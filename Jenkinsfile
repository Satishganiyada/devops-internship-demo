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
        stage('Deploy to Dev Env') {
            steps {
                sh 'pm2 delete demo || true'
                sh 'pm2 start app/app.js --name demo'
            }
        }
        stage('UI Test Automation - Dev Env'){
            steps{
                sh """
                    python3 -m venv app-env
                    . app-env/bin/activate
                    pip install selenium
                    python3 test/test.py
                """

                // cleanUp env
                sh 'pm2 delete demo || true'
            }
        }
        // upload the artifact to S3
        stage('upload'){
            steps{
                script{
                    sh "zip -r app.zip app"
                    stash includes: 'app.zip', name: 'app.zip', useDefaultExcludes: false
                    withAWS(credentials: 's3', region: 'ap-south-1') {
                        s3Upload acl: "Private", bucket: "myinterndemo", file: "app.zip", path: "${BUILD_ID}/app.zip"
                    }
                }
            }
        }
        stage("Deploy to QA/Prod"){
            agent {
                label("prod-vm")
            }
            stage("Deploy"){
                steps{
                    // stop running application
                    sh 'pm2 delete demo || true'

                    // take backup of old files
                    sh "rm -rf old_code_app || true"
                    sh "mv app old_code_app"

                    // get new code from stash
                    unstash 'app.zip'
                    sh "unzip app.zip"
                    sh 'pm2 start app/app.js --name demo'
                }
            }
            stage("Check status & Rollback"){
                steps{
                    sh """
                        curl localhost:8082
                        if [[ $? -ne 0 ]];
                        then
                            ## roll back
                            
                            ## delete new code
                            rm -rf app
                            cp old_code_app app 
                        else
                            echo "Application is running successfully..."
                        fi
                    """
                }
            }
        }
    }
}
