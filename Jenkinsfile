pipeline {

    agent any

    options {
        disableConcurrentBuilds()
    }

    stages {

        stage('Terraform Init') {
            steps {
                bat 'terraform init -reconfigure'
            }
        }

        stage('Terraform Format Check') {
            steps {
                bat 'terraform fmt -check'
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out=tfplan'
            }
        }

        stage('Archive Terraform Plan') {
            steps {
                archiveArtifacts artifacts: 'tfplan', fingerprint: true
            }
        }

        stage('Approval') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Do you want to apply Terraform changes?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                bat 'terraform apply tfplan'
            }
        }
    }
}