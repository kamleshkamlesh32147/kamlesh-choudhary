pipeline {
    agent any
    parameters {
        // Build parameters
        string(defaultValue: 'docker-tag', description: 'Version of the docker image', name: 'DOCKER_TAG')
    }
 
    stages {
        stage('Build Docker Image and Push to ECR') {
            agent {
                any {
                }
            }
            steps {
                script {
                        def ecrRepoUri = "aws-repo-url"
                        echo "ECR Repo URI: ${ecrRepoUri}"
                        echo "Building Docker image with tag: ${params.DOCKER_TAG}"
                        sh "docker build -t ${ecrRepoUri}:${params.DOCKER_TAG} . --no-cache"
                }
            }
        }
 
        stage('Push Docker Image to ECR') {
            steps {
                script {
                        def ecrRepoUri = "aws-repo-url"
                        echo "Pushing Docker image with tag: ${params.DOCKER_TAG}"
 
                        sh """
                            #docker ecr login command don't remeber somewhat below it will br
                            aws ecr get-login-password --region ${params.AWS_REGION}
                            docker tag ${ecrRepoUri}:${params.DOCKER_TAG} ${ecrRepoUri}:${params.DOCKER_TAG}
                            docker push ${ecrRepoUri}:${params.DOCKER_TAG}
                        """
                        }
                    }
                }
 
            }

        }