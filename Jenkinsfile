pipeline {
    agent any

    environment {
        // AWS credentials stored securely in Jenkins
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-1'  // Change as needed
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-pat', url: 'https://github.com/nikhildevops-aws/Jenkins.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var="key_name=your-aws-keypair-name"'
            }
        }

        stage('Terraform Apply') {
            when {
                beforeAgent true
                expression {
                    return input(id: 'ApproveApply', message: 'Apply Terraform changes?', ok: 'Yes')
                }
            }
            steps {
                sh 'terraform apply -auto-approve -var="key_name=your-aws-keypair-name"'
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Deployment verification steps go here.'
            }
        }
    }
}
