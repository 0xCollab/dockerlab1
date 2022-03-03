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
                        sh "docker rmi $registry:$BUILD_NUMBER"
                        }
                }                   
        }           
}
