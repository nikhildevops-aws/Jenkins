pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')       // Your AWS Access Key ID credential ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key') // Your AWS Secret Access Key credential ID
        AWS_DEFAULT_REGION = 'us-east-1'                            // Change if needed
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub using Jenkins credentials
                git credentialsId: 'github-pat', url: 'https://github.com/nikhildevops-aws/devops-assessment-nikhil.git'
            }
        }
        stage('Validate Terraform') {
            steps {
                sh 'terraform fmt -check'
                sh 'terraform init'
                sh 'terraform validate'
            }
        }
        stage('Plan Terraform') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Approval') {
            steps {
                input message: 'Apply Terraform changes?', ok: 'Apply'
            }
        }
        stage('Apply Terraform') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
        stage('Verify Deployment') {
            steps {
                sh '''
                    echo "Waiting for EC2 to be ready..."
                    sleep 60
                    curl -I http://$(terraform output -raw instance_public_ip)
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
