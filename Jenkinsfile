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
                sh 'rm -rf cypress/screenshots'
                sh 'rm -rf cypress/videos'
            }
        }

        stage('Install and choose port') {
            steps {
                nvm('') {
                    sh 'npm install'
                }
                script{
                    def port = uk.ac.ox.ndm.jenkins.Utils.findFreeTcpPort()
                    sh "echo \"MDM_PORT=${port}\" > .env.test"
                    sh "echo \"CYPRESS_BASE_URL=http://localhost:${port}\" >> .env.test"
                    sh "echo \"cypress_api_server=http://localhost:${port}/api\" >> .env.test"
                }
            }
        }

        stage('Define develop build info'){
            when{
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

        stage('Build and start MDM'){
            steps {
                sh 'cat ./.env.test'
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
                    catchError(buildResult: 'UNSTABLE', stageResult: 'UNSTABLE') {
                        sh '. ./.env.test && CYPRESS_BASE_URL=http://localhost:$MDM_PORT cypress_api_server=http://localhost:$MDM_PORT/api npm test'
                    }
                }
            }
        }
        stage('Stop MDM'){
            steps{
                dir('mdm-docker') {
                    sh 'echo Shutting down mdm-docker'
                    sh 'docker-compose -p "${JOB_BASE_NAME}_${BUILD_NUMBER}" down -v'
                }
            }
        }
    }
    post {
        always {
            //            publishHTML([
            //                allowMissing         : false,
            //                alwaysLinkToLastBuild: true,
            //                keepAll              : true,
            //                reportDir            : 'reports/html',
            //                reportFiles          : 'cucumber_reporter.html',
            //                reportName           : 'Cucumber Style Test Report',
            //                reportTitles         : 'Test'
            //            ])
            //            cucumber([
            //                buildStatus        : 'UNSTABLE',
            //                fileIncludePattern : '**/*.json',
            //                jsonReportDirectory: 'reports',
            //                reportTitle        : 'E2E Report',
            //                sortingMethod      : 'ALPHABETICAL',
            //                classifications    : [[key: 'Browser', value: 'Chrome Headless']],
            //            ])


            outputTestResults()
            zulipNotification(topic: 'mdm-end-to-end-testing')
        }
    }
}
