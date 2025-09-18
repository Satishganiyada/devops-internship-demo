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
                sh 'cd app && npm install'
            }
        }
        stage('Deploy') {
            steps {
                sh 'pm2 delete demo || true'
                sh 'pm2 start app/app.js --name demo'
            }
        }
        stage('Test'){
            steps{
                sh """
                    python3 -m venv app-env
                    source app-env/bin/activate
                    pip install selenium
                    python3 test.py
                """
            }
        }
    }
}
