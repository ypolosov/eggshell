pipeline {
    agent { 
        dockerfile {
            filename 'Dockerfile.dev-container'
            dir '.devcontainer'
            label 'docker'
        }
    }
    environment {
        PROJECT_DIR = 'backend'
    }
    stages {
        stage('Config') {
            steps {
                checkout scm
                echo 'Hello Config'
            }
        }
        stage('Registry login') {
            environment { 
                DOCKER_PASSWORD = credentials('docker-password')
            }
            steps {
                echo 'Hello Registry login'
                sh '''
                    export DOCKER_PASSWORD="$DOCKER_PASSWORD"
                    ./agnostic-pipeline/stages/01_login.sh
                '''
            }
        }
        stage('Ci') {
            steps {
                echo 'Hello Ci'
                sh './agnostic-pipeline/stages/01_ci.sh'
            }
        }
        stage('Build') {
            steps {
                echo 'Hello Build'
                sh './agnostic-pipeline/stages/02_build.sh'
            }
        }
        stage('Test') {
            steps {
                echo 'Hello Test'
                sh './agnostic-pipeline/stages/03_test.sh'
            }
        }
        stage('Archive') {
            steps {
                echo 'Hello Archive'
                sh './agnostic-pipeline/stages/04_archive.sh'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Hello Deploy'
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key-file', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                    sh '''
                        mkdir -p $HOME/.ssh
                        cat ${SSH_PRIVATE_KEY} >> $HOME/.ssh/id_rsa
                        export SSH_PRIVATE_KEY=`cat $HOME/.ssh/id_rsa`
                        ./agnostic-pipeline/stages/05_deploy.sh
                    '''
                }
            }
        }
        stage('Archive CI') {
            steps {
                echo 'Hello Archive CI'
                sh './agnostic-pipeline/stages/06_archive-ci.sh'
            }
        }
    }
}

