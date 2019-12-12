pipeline {
    agent { dockerfile true }
    stages {
        stage('Dev') {
            steps {
                sh "docker build --no-cache"
            }
        }
    }
}
