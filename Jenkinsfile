pipeline {
    agent { 
        docker {
            image 'ypolosov/eggshell'
        }
    }
    environment {
        PROJECT_DIR = 'backend'
    }
    stages {
        stage('Config') {
            environment { 
                DOCKER_PASSWORD = credentials('docker-password')
            }
            steps {
                checkout scm
                echo 'Hello Config'
                echo 'Hello Registry login'
                sh '''
                    export DOCKER_PASSWORD="$DOCKER_PASSWORD"
                    ./agnostic-pipeline/stages/01_login.sh
                '''
                echo 'Hello Ci'
                sh './agnostic-pipeline/stages/01_ci.sh'
                echo 'Hello Build'
                sh './agnostic-pipeline/stages/02_build.sh'
                echo 'Hello Test'
                sh './agnostic-pipeline/stages/03_test.sh'
                echo 'Hello Archive'
                sh './agnostic-pipeline/stages/04_archive.sh'
                echo 'Hello Deploy'
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key-file', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                    sh '''
                        mkdir -p $HOME/.ssh
                        cat ${SSH_PRIVATE_KEY} >> $HOME/.ssh/id_rsa
                        export SSH_PRIVATE_KEY=`cat $HOME/.ssh/id_rsa`
                        ./agnostic-pipeline/stages/05_deploy.sh
                    '''
                }
                echo 'Hello Archive CI'
                sh './agnostic-pipeline/stages/06_archive-ci.sh'
            }
        }
    }
}

