pipeline {
    agent any 

    environment {
        ANSIBLE_REPO = '/var/lib/jenkins/workspace/ansible_master'
        WEBHOOK = credentials('JENKINS_DISCORD')
        PORTAINER_PRD_WEBHOOK = credentials('PORTAINER_WEBHOOK_UNIFI')
    }

    //triggering periodically so the code is always present
    // run every friday at 3AM
    triggers { cron('0 3 * * 5') }

    stages {
        // deploy code to sevastopol, when the branch is 'master'
        stage('deploy prd code') {
            when { branch 'master' }
            steps {
                // deploy configs to PRD
                echo 'deploy docker config files (PRD)'
                sh 'ansible-playbook ${ANSIBLE_REPO}/deploy/docker/deploy_docker_compose_prd.yml --extra-vars repo="unifi-net-app"'
            }
        }
        // trigger portainer redeploy
        // separated out so this only gets run if the ansible playbook doesn't fail
        stage('redeploy portainer stack (PRD)') {
            when { branch 'master' }
            steps {
                // deploy configs to PRD
                echo 'Redeploy PRD stack'
                sh 'http post ${PORTAINER_PRD_WEBHOOK}'
            }
        }

    }
    post {
        always {
            discordSend \
                description: "${JOB_NAME} - build #${BUILD_NUMBER}", \
                // footer: "Footer Text", \
                // link: env.BUILD_URL, \
                result: currentBuild.currentResult, \
                // title: JOB_NAME, \
                webhookURL: "${WEBHOOK}"
        }
    }
}

