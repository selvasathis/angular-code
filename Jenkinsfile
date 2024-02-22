pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/selvasathis/angular-code.git'
            
                }
            }
        }
        stage ('docker build') {
            steps {
                script {
                    sh 'docker build -t angular-app .'
                }
            }
        }
        stage ('ecr login and build') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 267765472985.dkr.ecr.ap-northeast-1.amazonaws.com'
                    sh 'docker tag angular-app:latest 267765472985.dkr.ecr.ap-northeast-1.amazonaws.com/angular-app:latest'
                    sh 'docker push 267765472985.dkr.ecr.ap-northeast-1.amazonaws.com/angular-app:latest'
                }
            }
        }
        stage('Deploy on Kubernetes') {
            steps {
                script {
                    // Deploy resources on Kubernetes
                    withKubeCredentials(kubectlCredentials: [[credentialsId: 'k8s-credentials']]) {
                        sh 'kubectl apply -f kube.yaml'
                        sh 'kubectl apply -f service.yaml'
                        sh 'kubectl get pods -o wide'
                        sh 'kubectl get svc'
                    }
                }
            }
        }
    }
}
