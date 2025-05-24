pipeline {
    agent any

    environment {
        // Set AWS credentials (these should be stored in Jenkins credentials securely)
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-1'  // Change to your desired region
    }


    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/devops-assessment-yourname.git'
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
