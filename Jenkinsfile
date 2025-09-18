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
                    . app-env/bin/activate
                    pip install selenium
                    python3 test/test.py
                """
            }
        }
        stage('upload'){
            steps{
                script{
                    withAWS(credentials: 's3', region: 'ap-south-1') {
                        s3Upload acl: 'Private', bucket: 'myinterndemo', cacheControl: '', excludePathPattern: '', file: 'app/app.js', includePathPattern: '', metadatas: [''], path: '${BUILD_ID}', redirectLocation: '', sseAlgorithm: '', tags: '', text: '', workingDir: ''
                    }
                }
            }
        }
    }
}
