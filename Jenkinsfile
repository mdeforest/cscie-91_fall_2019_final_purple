pipeline {
    agent any

    stages {
        stage("pull-updates-to-dev"){
            steps {
                sshagent (credentials: ['e91ta']) {
                    sh "ssh -o StrictHostKeyChecking=no root@34.229.0.233 'cd /tmp/ && rm -rf cscie-91_fall_2019_final_purple/ && git clone git@github.com:nickwhalen06/cscie-91_fall_2019_final_purple.git && cd cscie-91_fall_2019_final_purple/ && git checkout dev && git pull'"
                }
                sleep 2
            }
        }    
        stage("run-docker-code-on-dev"){
            steps {
                sshagent (credentials: ['e91ta']) {
                    sh "ssh -o StrictHostKeyChecking=no root@34.229.0.233 'cd /tmp/cscie-91_fall_2019_final_purple && docker stop dev || true && docker rm dev || true && docker build -t centosapache . && docker run --name dev -d -p 80:80 centosapache'"
                }
                sleep 2
            }
        }
        
        stage("merger-dev-to-stage"){
            steps('Merge dev') {
                sshagent (credentials: ['e91ta']) {
                    sh "ssh -o StrictHostKeyChecking=no root@54.196.197.103 'cd /tmp/ && rm -rf cscie-91_fall_2019_final_purple/ && git clone git@github.com:nickwhalen06/cscie-91_fall_2019_final_purple.git && cd cscie-91_fall_2019_final_purple/ && git checkout dev && git pull && git checkout stage && git merge dev --no-edit && git push'"
                }
                sleep 2
            }
        }


        stage("run-docker-code-on-stage"){
            steps {
                sshagent (credentials: ['e91ta']) {
                    sh "ssh -o StrictHostKeyChecking=no root@54.196.197.103 'cd /tmp/cscie-91_fall_2019_final_purple && docker stop stage || true && docker rm stage || true && docker build -t centosapache . && docker run --name stage -d -p 80:80 centosapache'"
                }
                sleep 2
            }
        }
        
        stage("check-output-on-stage"){
            steps {
				script {
					try {         
				    	new URL("http://54.196.197.103/index.html").getText()
				    	return true
					} catch (Exception e) {
				    	return false
					}
				}
                sleep 2
            }
		}

        stage("merger-stage-to-master"){
            steps('Merge stage') {
                sshagent (credentials: ['e91ta']) {
                    sh "ssh -o StrictHostKeyChecking=no root@35.221.7.119 'cd /tmp/ && rm -rf cscie-91_fall_2019_final_purple/ && git clone git@github.com:nickwhalen06/cscie-91_fall_2019_final_purple.git && cd cscie-91_fall_2019_final_purple/ && git checkout stage && git pull && git checkout master && git merge stage --no-edit && git push'"
                }
                sleep 2
            }
        }


        stage("run-docker-code-on-prod"){
            steps {
                sshagent (credentials: ['e91ta']) {
                    sh "ssh -o StrictHostKeyChecking=no root@35.221.7.119 'cd /tmp/cscie-91_fall_2019_final_purple && docker stop prod || true && docker rm prod || true && docker build -t centosapache . && docker run --name prod -d -p 80:80 centosapache'"
                }
                sleep 2
            }
        }
        

    }
}
