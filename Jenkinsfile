pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout from your correct GitHub repo using your PAT credential
                git credentialsId: 'github-pat', url: 'https://github.com/nikhildevops-aws/Jenkins.git', branch: 'main'
            }
        }

        // Add your other stages here, e.g., Terraform Validate, Plan, Apply, etc.
        stage('Validate Terraform') {
            steps {
                sh 'terraform validate'
            }
        }
        
        stage('Plan Terraform') {
            steps {
                sh 'terraform plan'
            }
        }
        
        stage('Apply Terraform') {
            steps {
                input 'Approve to apply?'
                sh 'terraform apply -auto-approve'
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo 'Verify deployment steps here'
            }
        }
    }
}
