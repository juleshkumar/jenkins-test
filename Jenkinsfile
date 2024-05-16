pipeline {
    agent any

    parameters {
        string(name: 'EC2_IP', defaultValue: '13.127.122.206', description: 'EC2 IP Address')
        string(name: 'region', defaultValue: 'ap-south-1', description: 'Region')
        string(name: 'output', defaultValue: 'text', description: 'Output format')
        string(name: 'namespace', defaultValue: 'vrt', description: 'Namespace')
        string(name: 'EFS_DNS_NAME', defaultValue: 'fs-05b4b96da77246046', description: 'EFS DNS Name')
        string(name: 'cluster_name', defaultValue: 'eks-decimal-test', description: 'clustername')
        string(name: 'consul_version', defaultValue: '10.14.3', description: 'version')
        string(name: 'elasticsearch_version', defaultValue: '19.13.10', description: 'version')
        string(name: 'nginx_version', defaultValue: '9.2.22', description: 'version')
        string(name: 'kafka_version', defaultValue: '18.0.3', description: 'version')
        string(name: 'logstash_version', defaultValue: '5.1.13', description: 'version')
        string(name: 'redis_host', defaultValue: 'master.decimal-elasticache-replication.8g5lkl.aps1.cache.amazonaws.com', description: 'redis host')

        
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Tools Deploy') {
            steps {
                script {
                    dir('tools') {
                        git branch: 'dev-3', url: 'https://github.com/juleshkumar/jenkins-test.git'

                        def inventoryContent = "[ec2]\n${params.EC2_IP} ansible_user=ubuntu ansible_ssh_private_key_file=/var/lib/jenkins/keypairs/jenkins-test-server2-keypair.pem"
                        sh "echo '${inventoryContent}' > inventory.ini"

                    
                        sh "ansible-playbook -i inventory.ini deploy.yml --extra-vars 'efs_id=${params.EFS_DNS_NAME} aws_access_key_id=${env.AWS_ACCESS_KEY_ID} aws_secret_access_key=${env.AWS_SECRET_ACCESS_KEY} aws_region=${params.region} aws_output_format=${params.output} namespace=${params.namespace} region=${params.region} cluster_name=${params.cluster_name} consul_version=${params.consul_version} elasticsearch_version=${params.elasticsearch_version} kafka_version=${params.kafka_version} nginx_ic_version=${params.nginx_version} logstash_version=${params.logstash_version}'"
                    }
                }
            }
        }
        stage('Apps Deploy') {
            steps {
                script {
                    dir('apps') {
                        git branch: 'dev-4', url: 'https://github.com/juleshkumar/jenkins-test.git'

                        def inventoryContent = "[ec2]\n${params.EC2_IP} ansible_user=ubuntu ansible_ssh_private_key_file=/var/lib/jenkins/keypairs/jenkins-test-server2-keypair.pem"
                        sh "echo '${inventoryContent}' > inventory.ini"

                    
                        sh "ansible-playbook -i inventory.ini deploy.yml --extra-vars 'redis_host=${params.redis_host} aws_access_key_id=${env.AWS_ACCESS_KEY_ID} aws_secret_access_key=${env.AWS_SECRET_ACCESS_KEY} aws_region=${params.region} aws_output_format=${params.output} namespace=${params.namespace}'"
                    }
                }
            }
        }

    }
}
