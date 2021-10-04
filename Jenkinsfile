pipeline {
    agent any

    environment {
        JENKINS = 'true'
    }

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '30'))
    }
    /*
    nvm wrapper has to wrap all steps, interestingly its not supposed to work with the .nvmrc file however if you exclude the version as a blank
    string
    then it passes the blank string as the version and therefore nvm just does its job and uses the .nvmrc file.
    */
    stages {

        stage('Tool Versions') {
            steps {
                nvm('') {
                    sh 'node --version'
                    sh 'npm --version'
                }
            }
        }
        stage('Jenkins Clean') {
            steps {
                sh 'docker image prune -f'
                sh 'rm -rf cypress/screenshots'
                sh 'rm -rf cypress/videos'
                sh 'rm -rf cypress/reports'
            }
        }

        stage('Install and choose port') {
            steps {
                nvm('') {
                    sh 'npm install'
                }
                script {
                    def port = uk.ac.ox.ndm.jenkins.Utils.findFreeTcpPort()
                    sh "echo \"MDM_PORT=${port}\" > .env.test"
                    sh "echo \"CYPRESS_BASE_URL=http://localhost:${port}\" >> .env.test"
                    sh "echo \"cypress_api_server=http://localhost:${port}/api\" >> .env.test"
                }
            }
        }

        stage('Define develop build info') {
            when {
                not {
                    branch 'main'
                }
            }
            steps {
                sh 'echo "MDM_APPLICATION_COMMIT=develop" >> .env.test'
                sh 'echo "MDM_UI_COMMIT=develop" >> .env.test'
                sh 'echo "MDM_TAG=develop" >> .env.test'
            }
        }

        stage('Build and start MDM') {
            steps {
                sh 'cat ./.env.test'
                sh 'cp fixtures/*.sql mdm-docker/postgres/fixtures'
                dir('mdm-docker') {
                    sh 'git checkout develop && git pull'
                    sh 'docker-compose --env-file=../.env.test build --build-arg CACHE_BURST=$(date +%s)'
                    sh '. ../.env.test && echo starting mdm-docker on port $MDM_PORT'
                    sh 'docker-compose --env-file=../.env.test -p "${JOB_BASE_NAME}_${BUILD_NUMBER}" up -d'
                }
                sh 'sleep 60' // todo find better "wait method" the wait-for-it doesnt work
            }
        }

        stage('Test') {
            steps {
                nvm('') {
                    script {
                        int retStatus = sh(returnStatus: true,
                                           script: '. ./.env.test && CYPRESS_BASE_URL=http://localhost:$MDM_PORT cypress_api_server=http://localhost:$MDM_PORT/api npm test')
                        if (retStatus == 1) {
                            // Cypress returns the number of test failures as the exit code
                            // It returns 1 if there was a failure stopping it from running (such as MDM not being available)
                            // This does produce an issue if only 1 test fails...room for thought
                            error 'Cypress could not run'
                        } else if(retStatus > 0){
                            unstable "$retStatus test failures"
                        }
                    }
                }
            }
        }

        stage('Report') {
            steps {
                nvm('') {
                    catchError(buildResult: 'UNSTABLE', stageResult: 'UNSTABLE') {
                        sh 'npm run generate-reports'
                    }
                }
                publishHTML([
                    allowMissing         : false,
                    alwaysLinkToLastBuild: true,
                    keepAll              : true,
                    reportDir            : 'cypress/reports/mochawesome',
                    reportFiles          : 'index.html',
                    reportName           : 'Mocha Report',
                    reportTitles         : 'Mocha Report'
                ])
                junit allowEmptyResults: true, testResults: '**/cypress/reports/*.xml'
            }
        }
    }
    post {
        always {
            dir('mdm-docker') {
                sh 'echo Shutting down mdm-docker'
                sh 'docker-compose -p "${JOB_BASE_NAME}_${BUILD_NUMBER}" down -v || true'
            }
            outputTestResults()
            zulipNotification(topic: 'mdm-end-to-end-testing')
        }
    }
}
