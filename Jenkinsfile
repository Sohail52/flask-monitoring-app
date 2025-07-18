pipeline {
    agent any

    stages {
        stage('Terraform Apply') {
            steps {
                script {
                    docker.image('hashicorp/terraform:latest').inside {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}
