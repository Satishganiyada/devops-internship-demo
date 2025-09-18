pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Satishganiyada/devops-internship-demo.git'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Deploy') {
            steps {
                sh 'pm2 delete demo || true'
                sh 'pm2 start app/app.js --name demo'
            }
        }
    }
}
