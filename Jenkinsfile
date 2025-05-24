pipeline {
    agent any

    environment {
        // AWS credentials stored securely in Jenkins credentials store
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'  // Change as needed
    }

    stages {
        stage('Checkout') {
            steps {
                // Use your real GitHub repo URL and credentials ID here
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
                script {
                    def publicIp = sh(script: "terraform output -raw instance_public_ip", returnStdout: true).trim()
                    echo "EC2 Public IP: ${publicIp}"
                    sleep(time: 60, unit: 'SECONDS')
                    sh "curl -I http://${publicIp}"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
