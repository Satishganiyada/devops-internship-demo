# DevOps Internship Demo 🚀

## Tech Stack Justification  

- **Node.js (Express App)** → Provides a fast and scalable backend.  
- **PM2** → Process manager for Node.js, ensures the app runs continuously with monitoring and restart features.  
- **Jenkins** → CI/CD automation tool, managing build, test, and deploy stages.  
- **Selenium (Python)** → Used for automated UI testing to validate app functionality.  
- **AWS S3** → Stores build artifacts for consistent deployments across environments.    
- **Rollback Strategy** → Ensures safe deployments with the ability to recover from failures.  

---

## Prerequisites  

Before running the application and pipeline, ensure the following are installed:  

- **System Requirements**  
  - Ubuntu/Debian-based Linux server (or equivalent environment)  
  - Node.js & npm  
  - Python 3  
  - Java (for Jenkins)  

- **Tools**  
  - [Jenkins](https://www.jenkins.io/) installed and running  
  - PM2 (`npm install -g pm2`)  
  - AWS CLI configured with S3 access   

- **Jenkins Plugins**  
  - Pipeline  
  - AWS Steps (`withAWS`, `s3Upload`)  

---

## Steps to Deploy & Test  

## 🔹 Local Setup  

1. Clone repository:  
   ```bash
   git clone https://github.com/Satishganiyada/devops-internship-demo.git
   cd devops-internship-demo/app
## Install dependencies:

### npm install


### Start application using PM2:

### pm2 start app.js --name demo


## Run tests locally:

### cd ../test
### python3 -m venv app-env
### source app-env/bin/activate
### pip install selenium
### python3 test.py

# 🔹 CI/CD Pipeline Execution

### Push code to GitHub (main branch).

### Jenkins pipeline triggers automatically.

## Pipeline flow:

Checkout latest code.

Build app with npm install.

Deploy app to Dev Environment using PM2.

Run Selenium UI tests in Dev.

Upload build artifact (zipped app) to AWS S3 bucket.

Deploy app on QA/Prod environment.

Perform health check on localhost:8082.

Rollback to old version if health check fails.

# Jenkins Pipeline Flow

### Stage 1: Checkout → Pull code from GitHub.

### Stage 2: Build → Install dependencies with npm install.

### Stage 3: Deploy to Dev Env → Run app using PM2 (pm2 start app/app.js --name demo).

### Stage 4: UI Test Automation (Dev Env) → Create Python venv, install Selenium, run test/test.py.

### Stage 5: Upload Artifact → Zip app, upload to AWS S3 bucket myinterndemo/${BUILD_ID}/app.zip.

### Stage 6: Deploy to QA/Prod → Deploy artifact on Jenkins agent (prod-vm).

### Stage 7: Health Check & Rollback → Verify app on localhost:8082, rollback if app fails.   
