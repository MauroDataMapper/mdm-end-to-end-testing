#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -p|--port)
    MDM_PORT="$2"
    shift # past argument
    shift # past value
    ;;
   -b|--build-only)
    BUILD=true
    START=false
    shift # past argument
    ;;
    -s|--start-only)
    BUILD=false
    START=true
    shift # past argument
    ;;
    -l|--production)
    PRODUCTION=true
    shift # past argument
    ;;
    -h|--help)
    USAGE=true
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

MDM_PORT="${MDM_PORT:-8082}"
BUILD="${BUILD:-true}"
START="${START:-true}"
PRODUCTION="${PRODUCTION:-false}"

##################
# Functions

outputLine(){
  echo
  eval printf '%.0s-' {1..$(tput cols)}
  echo
}

function build(){
  echo "Building environment"
  git submodule update --init

  cp fixtures/2_dump.sql mdm-docker/postgres/fixtures

  echo "MDM_PORT=${MDM_PORT}" > .env.test
#  echo "CYPRESS_BASE_URL=http://localhost:${MDM_PORT}" >> .env.test
#  echo "cypress_api_server=http://localhost:${MDM_PORT}/api" >> .env.test

  outputLine
  if $PRODUCTION
  then
    echo "Production environment::"
    . ./mdm-docker/.env &&  echo "MDM_APPLICATION_COMMIT=$MDM_APPLICATION_COMMIT" >> .env.test
    . ./mdm-docker/.env && echo "MDM_UI_COMMIT=$MDM_UI_COMMIT" >> .env.test
    . ./mdm-docker/.env && echo "MDM_TAG=$MDM_TAG" >> .env.test
  else
    echo "Develop environment::"
    echo "MDM_APPLICATION_COMMIT=develop" >> .env.test
    echo "MDM_UI_COMMIT=develop" >> .env.test
    echo "MDM_TAG=develop" >> .env.test
  fi

  cat ./.env.test

  outputLine

  pushd mdm-docker || exit

  if $PRODUCTION
  then
    git checkout main && git pull
  else
    git checkout develop && git pull
  fi

  docker-compose --env-file=../.env.test build --build-arg CACHE_BURST="$(date +%s)"
  popd

  outputLine
}

function start(){
  echo "Starting environment"
  pushd mdm-docker || exit

  . ../.env.test && echo starting mdm-docker on port $MDM_PORT

  docker-compose --env-file=../.env.test -p "mdm-e2e" up -d postgres

  grep -m 2 -c -q "database system is ready" <(docker-compose -p "mdm-e2e" logs -f postgres)

  docker-compose --env-file=../.env.test -p "mdm-e2e" up -d

  grep -m 1 -c -q "Server startup" <(docker-compose -p "mdm-e2e" logs -f mauro-data-mapper)
  popd

  outputLine
}

function usage(){
  echo
  echo "Usage: ./build_and_start_environment.sh [OPTIONS]"
  echo
  echo "Build and start the MDM docker environment for cypress to test against"
  echo "
Options:
  -p, --port        Port to start MDM on. Default: 8082
                    If you change this you will need to edit the cypress.json file to make sure cypress can connect.
  -l, --production  Builds the latest production environment rather than develop. Default: false
                    This will still install the required fixtures but will run the latest release of MDM.
  -b, --build-only  Perform the build step only. Default: false
  -s, --start-only  Perform the start step only, requires the build step to have been performed at least once before. Default: false
  -h, --help        This help
"
}

if $USAGE
then
  usage
else

  if $BUILD; then build; fi;
  if $START; then start; fi;
fi