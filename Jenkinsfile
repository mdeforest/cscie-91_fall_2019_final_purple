pipeline {
   agent any

    stages {
        stage('Dev') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'dev', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                        def remote = [:]
                        remote.name = '34.229.0.233'
                        remote.host = '34.229.0.233'
                        remote.user = userName
                        remote.identityFile = identity
                        remote.allowAnyHosts = true
                        sshCommand remote: remote, command: "git --git-dir=/home/e91user/cscie-91_fall_2019_final_purple/.git --work-tree=/home/e91user/cscie-91_fall_2019_final_purple/ pull"
                        sshCommand remote: remote, command: "docker build -t final-project cscie-91_fall_2019_final_purple/"
                        sshCommand remote: remote, command: "docker stop final-project"
                        sshCommand remote: remote, command: "docker run -d -p 8080:80 --name final-project final-project:latest"
                    }
                }
            }
        }
    }
}
