pipeline {
    environment {
        registry = "varia17/testingdocker"
        registryCredential = '334dff45-95e3-4adc-9c30-760d0dcd8bda'
        dockerImage = ''
                }
    agent any
        stages {
            stage('Cloning our Git') {
                    steps {
                        checkout scm
                            }
                    }
            stage('Building our image') {
                    steps{
                        script {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                            }
                        }
                }
            stage("docker_scan"){
                    steps{
                        sh '''
                            docker run -d --name "$BUILD_NUMBER" arminc/clair-db
                            sleep 15 # wait for db to come up
                            docker run -p 6060:6060 --link "$BUILD_NUMBER":postgres -d --name clair$BUILD_NUMBER arminc/clair-local-scan
                            sleep 1
                            DOCKER_GATEWAY=$(docker network inspect bridge --format "{{range .IPAM.Config}}{{.Gateway}}{{end}}")
                            wget -qO clair-scanner https://github.com/arminc/clair-scanner/releases/download/v8/clair-scanner_linux_amd64 && chmod +x clair-scanner
                            ./clair-scanner -repot=$BUILD_NUMBER.json --ip="$DOCKER_GATEWAY" varia17/testingdocker":$BUILD_NUMBER"  || exit 0
                            '''
                    }   
                }
            stage('Deploy image') {
                    steps{
                        script {
                        docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                            }
                        }
                    }
                }
            stage('Cleaning up') {
                    steps{
                        sh '''
                            docker ps
                            docker rm $(docker ps -a -q)
                            '''
                        }
                }                   
        }           
}
