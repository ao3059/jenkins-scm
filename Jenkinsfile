pipeline {
    agent any

    environment {
        NODE_VERSION = '18' // Change to '18' for specific version
        NVM_DIR = "${env.HOME}/.nvm"
    }

    stages {
        stage('Connect to GitHub') {
            steps {
                git url: 'https://github.com/ao3059/jenkins-scm.git', branch: 'main'
            }
        }

        stage('Install Node.js and npm') {
            steps {
                sh '''
                    bash -c "
                    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
                    export NVM_DIR='$NVM_DIR'
                    [ -s '$NVM_DIR/nvm.sh' ] && . '$NVM_DIR/nvm.sh'  # Load NVM
                    [ -s '$NVM_DIR/bash_completion' ] && . '$NVM_DIR/bash_completion'  # Load bash_completion
                    nvm install $NODE_VERSION
                    nvm use $NODE_VERSION
                    node -v
                    npm -v
                    "
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    bash -c "
                    export NVM_DIR='$NVM_DIR'
                    [ -s '$NVM_DIR/nvm.sh' ] && . '$NVM_DIR/nvm.sh'
                    nvm use $NODE_VERSION
                    npm install
                    "
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    bash -c "
                    export NVM_DIR='$NVM_DIR'
                    [ -s '$NVM_DIR/nvm.sh' ] && . '$NVM_DIR/nvm.sh'
                    nvm use $NODE_VERSION
                    node -v
                    npm -v
                    npm test -- --passWithNoTests
                    "
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("my-ecommerce-app")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    dockerImage.run("-d -p 8081:80")
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deployment step would go here.'
            }
        }
    }

    post {
        always {
            echo 'This will always run, whether the pipeline succeeds or fails.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
