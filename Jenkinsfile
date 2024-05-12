

pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
        string(name: 'vpc_cidr', defaultValue: '10.0.0.0/16', description: 'CIDR for VPC')
        string(name: 'public-count', defaultValue: '2', description: 'Number of public subnets')
        string(name: 'private-count', defaultValue: '2', description: 'Number of private subnets')
        string(name: 'nat-count', defaultValue: '2', description: 'Number of NAT gateways')
        string(name: 'public-subnet_mask', defaultValue: '4', description: 'Mask for public subnets')
        string(name: 'private-subnet_mask', defaultValue: '4', description: 'Mask for private subnets')
        string(name: 'environment', defaultValue: 'dev', description: 'Environment name')
        string(name: 'security_group', defaultValue: 'test-sg', description: 'Security group name')
        string(name: 'ami', defaultValue: 'ami-05e00961530ae1b55', description: 'AMI ID for EC2 instances')
        string(name: 'ec2_key_name', defaultValue: 'jenkins-test-server2-keypair', description: 'EC2 key pair name')
        string(name: 'ec2_instance_type', defaultValue: 't3a.medium', description: 'EC2 instance type')
        string(name: 'js_user', defaultValue: 'ec2-new-user', description: 'Jumpbox user')
        string(name: 'autoscaling-group-name', defaultValue: 'vrt-asg', description: 'ASG name')
        string(name: 'kms_key_name', defaultValue: 'decimal-kms-key', description: 'kms key name')
        string(name: 'cluster_name', defaultValue: 'eks-decimal-test', description: 'eks cluster name')
        string(name: 'max-workers-demand', defaultValue: '5', description: 'maximum no of worker nodes')
        string(name: 'max-workers-spot', defaultValue: '5', description: 'max-workers-spot')
        booleanParam(name: 'cloudwatch_logs', defaultValue: false, description: ' cloudwatch logs')
        booleanParam(name: 'cluster-autoscaler', defaultValue: false, description: 'cluster AS')
        string(name: 'instance_capacity_types_demand', defaultValue: 'ON_DEMAND', description: 'on demand instance')
        string(name: 'instance_capacity_types_spot', defaultValue: 'SPOT', description: 'spot instance')
        string(name: 'inst_disk_size', defaultValue: '60', description: 'volume for instance')
        string(name: 'inst_key_pair', defaultValue: 'null', description: 'node instances key pair')
        string(name: 'num-workers-spot', defaultValue: '1', description: 'spot worker nodes')
        string(name: 'num-workers-demand', defaultValue: '1', description: 'on demand worker nodes')
        string(name: 'k8s_version', defaultValue: '1.29', description: 'eks version')
        string(name: 'instance-type-on-demand', defaultValue: 'r5a.large', description: 'on demand instance type')
        string(name: 'instance-type-spot', defaultValue: 't3a.large', description: 'spot instance type')
        string(name: 'public_key_file', defaultValue: '/var/lib/jenkins/.ssh/id_rsa.pub', description: 'public key file')
        string(name: 'ec2_instance_type', defaultValue: 't2.micro', description: 'instance type')
        string(name: 'eks_key_name', defaultValue: 'eks-key', description: 'eks_key_name')
        string(name: 'vrt_db_instance_identifier', defaultValue: 'decimal-db-tech', description: 'vrt_db_instance_identifier')
        string(name: 'vrt_db_security_group', defaultValue: 'decimal-rds-security', description: 'vrt_db_security_group')
        string(name: 'vrt__db_cidr_range', defaultValue: '10.0.0.0/16', description: 'vrt__db_cidr_range')
        string(name: 'major_version', defaultValue: '12', description: 'major_version') 
        string(name: 'vrt_db_allocated_storage', defaultValue: '20', description: 'vrt_db_allocated_storage') 
        string(name: 'engine_version', defaultValue: '12.17', description: 'rds engine_version')     
        string(name: 'vrt_db_instance_type', defaultValue: 'db.m6g.large', description: 'vrt_db_instance_type')
        string(name: 'vrt_database_name', defaultValue: 'decimal_database_technologies', description: 'vrt_database_name')
        string(name: 'database_user', defaultValue: 'psq_demo', description: 'database_user')
        string(name: 'database_password', defaultValue: 'Qwerty#789', description: 'database_password')
        string(name: 'replication-id', defaultValue: 'decimal-elasticache-replication', description: 'replication-id')
        string(name: 'redis-cluster', defaultValue: 'elasticache-redis-cluster', description: 'redis-cluster')
        string(name: 'redis-engine', defaultValue: 'redis', description: 'redis-engine')
        string(name: 'redis-engine-version', defaultValue: '6.0', description: 'redis-engine-version') 
        string(name: 'redis-node-type', defaultValue: 'cache.t3.small', description: 'redis-node-type')
        string(name: 'num-cache-nodes', defaultValue: '1', description: 'num-cache-nodes')
        string(name: 'parameter-group-family', defaultValue: 'redis6.x', description: 'parameter-group-family')
        string(name: 'efs-security-group', defaultValue: 'efs-mount-target-sg', description: 'efs-security-group')
        booleanParam(name: 'internal', defaultValue: 'false', description: 'LB')
        string(name: 'load_balancer_type', defaultValue: 'application', description: 'LB')
        string(name: 'load_balancer_name', defaultValue: 'decimal-load-balancer', description: 'LB')
        string(name: 'lb-port', defaultValue: '80', description: 'lb-port')
        string(name: 'protocol', defaultValue: 'HTTP', description: 'protocol for lb sg')
        string(name: 'autoscaling-group-name', defaultValue: 'vrt-asg', description: 'ASG name')
        string(name: 'target-group-name', defaultValue: 'tg-sg-lb', description: 'target group name')
        string(name: 'lb_security_group', defaultValue: 'load-balancer-sg', description: 'load-balancer-sg')
        string(name: 'from_ports', defaultValue: '443', description: 'lb port')
        string(name: 'to_ports', defaultValue: '443', description: 'lb port')
        string(name: 'security-group-cidr', defaultValue: '0.0.0.0/0', description: 'source cidr')
        string(name: 'region', defaultValue: 'ap-south-1', description: 'Region')
        string(name: 'output', defaultValue: 'text', description: 'Output format')
        string(name: 'namespace', defaultValue: 'test', description: 'Namespace')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('VPC Creation') {
            steps {
                script {
                    // Convert parameters to numbers
                    def publicCount = params['public-count'].toInteger()
                    def privateCount = params['private-count'].toInteger()
                    def natCount = params['nat-count'].toInteger()
                    def publicSubnetMask = params['public-subnet_mask'].toInteger()
                    def privateSubnetMask = params['private-subnet_mask'].toInteger()
                    
                    git branch: 'main', url: 'https://github.com/juleshkumar/jenkins-test.git'
                    dir('julesh-terraform/environments/dev/vpc') {
                        sh 'terraform init'
                        
                        def tfPlanCmd = "terraform plan -out=vpc_tfplan " +
                                        "-var 'vpc_cidr=${params.vpc_cidr}' " +
                                        "-var 'public-count=${publicCount}' " +
                                        "-var 'private-count=${privateCount}' " +
                                        "-var 'nat-count=${natCount}' " +
                                        "-var 'public-subnet_mask=${publicSubnetMask}' " +
                                        "-var 'private-subnet_mask=${privateSubnetMask}' " +
                                        "-var 'environment=${params.environment}' " +
                                        "-var 'security_group=${params.security_group}'"
                        sh tfPlanCmd
                        sh 'terraform show -no-color vpc_tfplan > vpc_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'vpc_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false vpc_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var 'vpc_cidr=${params.vpc_cidr}' " +
                            "-var 'public-count=${publicCount}' " +
                            "-var 'private-count=${privateCount}' " +
                            "-var 'nat-count=${natCount}' " +
                            "-var 'public-subnet_mask=${publicSubnetMask}' " +
                            "-var 'private-subnet_mask=${privateSubnetMask}' " +
                            "-var 'environment=${params.environment}' " +
                            "-var 'security_group=${params.security_group}'"
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                    }
                }
            }
        }
        stage('LB Creation') {
            steps {
                script {
                    def lbport = params['lb-port'].toInteger()
                    def fromport = params['from_ports'].toInteger()
                    def toport = params['to_ports'].toInteger()
                    
                    dir('julesh-terraform/environments/dev/load_balancer') {
                        sh 'terraform init'
                        
                        def tfPlanCmd = "terraform plan -out=lb_tfplan " +
                                        "-var 'load_balancer_name=${params.load_balancer_name}' " +
                                        "-var 'lb-port=${lbport}' " +
                                        "-var 'from_ports=${fromport}' " +
                                        "-var 'to_ports=${toport}' " +
                                        "-var 'load_balancer_type=${params.load_balancer_type}' " +
                                        "-var 'protocol=${params.protocol}' " +
                                        "-var 'autoscaling-group-name=${params['autoscaling-group-name']}' " +
                                        "-var 'target-group-name=${params['target-group-name']}' " +
                                        "-var 'security-group-cidr=${params['security-group-cidr']}' " +
                                        "-var 'lb_security_group=${params.lb_security_group}'"
                        if (params.internal) {
                            tfPlanCmd += " -var 'internal=true'"
                        } else {
                            tfPlanCmd += " -var 'internal=false'"
                        }
                        sh tfPlanCmd
                        sh 'terraform show -no-color lb_tfplan > lb_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'lb_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false lb_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var 'load_balancer_name=${params.load_balancer_name}' " +
                            "-var 'lb-port=${lbport}' " +
                            "-var 'from_ports=${fromport}' " +
                            "-var 'to_ports=${toport}' " +
                            "-var 'load_balancer_type=${params.load_balancer_type}' " +
                            "-var 'protocol=${params.protocol}' " +
                            "-var 'autoscaling-group-name=${params['autoscaling-group-name']}' " +
                            "-var 'target-group-name=${params['target-group-name']}' " +
                            "-var 'security-group-cidr=${params['security-group-cidr']}' " +
                            "-var 'lb_security_group=${params.lb_security_group}'"
                        if (params.internal) {
                            tfPlanCmd += " -var 'internal=true'"
                        } else {
                            tfPlanCmd += " -var 'internal=false'"
                        }
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                    }
                }
            }
        }
        stage('EFS Creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/efs') {
                        sh 'terraform init'
                        def tfPlanCmd = "terraform plan -out=efs_tfplan " +
                                        "-var 'cluster-name=${params.cluster_name}' " +
                                        "-var 'efs-security-group=${params['efs-security-group']}' "

                        sh tfPlanCmd
                        sh 'terraform show -no-color efs_tfplan > efs_tfplan.txt'
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'efs_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false efs_tfplan"
                        sh "terraform ${params.action} --auto-approve -var 'cluster-name=${params.cluster_name}' "+
                            "-var 'efs-security-group=${params['efs-security-group']}' "
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }

                    def efsDnsName = sh(returnStdout: true, script: "terraform output -json efs_mount_target_dns_names").trim()
                    def formattedEfsDnsName = efsDnsName.replaceAll('"', '')

                    env.EFS_DNS_NAME = formattedEfsDnsName

                    }
                }
            }
        }
        stage('KMS Creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/kms') {
                        sh 'terraform init'
                        def tfPlanCmd = "terraform plan -out=kms_tfplan " +
                                        "-var 'kms_key_name=${params.kms_key_name}'"

                        sh tfPlanCmd
                        sh 'terraform show -no-color kms_tfplan > kms_tfplan.txt'
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'kms_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false kms_tfplan"
                        sh "terraform ${params.action} --auto-approve -var 'kms_key_name=${params.kms_key_name}' "
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }

                    }
                }
            }
        }
        stage('Redis Creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/elasticache') {
                        sh 'terraform init'
                        
                        def tfPlanCmd = "terraform plan -out=ec_tfplan " +
                                        "-var 'replication-id=${params['replication-id']}' " +
                                        "-var 'redis-cluster=${params['redis-cluster']}' " +
                                        "-var 'redis-engine=${params['redis-engine']}' " +
                                        "-var 'redis-engine-version=${params['redis-engine-version']}' " +
                                        "-var 'redis-node-type=${params['redis-node-type']}' " +
                                        "-var 'num-cache-nodes=${cachenodes}' " +
                                        "-var 'parameter-group-family=${params['parameter-group-family']}' "
                        sh tfPlanCmd
                        sh 'terraform show -no-color ec_tfplan > ec_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'ec_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false ec_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var '-var 'replication-id=${params['replication-id']}' " +
                            "-var 'redis-cluster=${params['redis-cluster']}' " +
                            "-var 'redis-engine=${params['redis-engine']}' " +
                            "-var 'redis-engine-version=${params['redis-engine-version']}' " +
                            "-var 'redis-node-type=${params['redis-node-type']}' " +
                            "-var 'num-cache-nodes=${params['num-cache-nodes']}' " +
                            "-var 'parameter-group-family=${params['parameter-group-family']}' "
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                    }
                }
            }
        }
        stage('RDS Creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/rds') {
                        sh 'terraform init'
                        
                        def tfPlanCmd = "terraform plan -out=rds_tfplan " +
                                        "-var 'vrt_db_instance_identifier=${params.vrt_db_instance_identifier}' " +
                                        "-var 'vrt_db_security_group=${params.vrt_db_security_group}' " +
                                        "-var 'vrt__db_cidr_range=${params.vrt__db_cidr_range}' " +
                                        "-var 'major_version=${params.major_version}' " +
                                        "-var 'vrt_db_allocated_storage=${params.vrt_db_allocated_storage}' " +
                                        "-var 'engine_version=${params.engine_version}' " +
                                        "-var 'vrt_db_instance_type=${params.vrt_db_instance_type}' " +
                                        "-var 'vrt_database_name=${params.vrt_database_name}' " +
                                        "-var 'database_user=${params.database_user}' " +
                                        "-var 'database_password=${params.database_password}'"
                        sh tfPlanCmd
                        sh 'terraform show -no-color rds_tfplan > rds_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'rds_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false rds_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var 'vrt_db_instance_identifier=${params.vrt_db_instance_identifier}' " +
                            "-var 'vrt_db_security_group=${params.vrt_db_security_group}' " +
                            "-var 'vrt__db_cidr_range=${params.vrt__db_cidr_range}' " +
                            "-var 'major_version=${params.major_version}' " +
                            "-var 'vrt_db_allocated_storage=${params.vrt_db_allocated_storage}' " +
                            "-var 'engine_version=${params.engine_version}' " +
                            "-var 'vrt_db_instance_type=${params.vrt_db_instance_type}' " +
                            "-var 'vrt_database_name=${params.vrt_database_name}' " +
                            "-var 'database_user=${params.database_user}' " +
                            "-var 'database_password=${params.database_password}'"
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                    def efsDnsName = sh(returnStdout: true, script: "terraform output -json rds_endpoint").trim()
                    def formattedrdsendpoint = efsDnsName.replaceAll('"', '')

                    env.rds_endpoint = formattedrdsendpoint
                    }
                }
            }
        }
        stage('eks creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/eks') {
                        sh 'terraform init'
                        def tfPlanCmd = "terraform plan -out=eks_tfplan " +
                                        "-var 'cluster-name=${params.cluster_name}' " +
                                        "-var 'max-workers-demand=${params['max-workers-demand']}' " +
                                        "-var 'max-workers-spot=${params['max-workers-spot']}' " +
                                        "-var 'instance_capacity_types_demand=${params['instance_capacity_types_demand']}' " +
                                        "-var 'instance_capacity_types_spot=${params['instance_capacity_types_spot']}' " +
                                        "-var 'inst_disk_size=${params['inst_disk_size']}' " +
                                        "-var 'inst_key_pair=${params['inst_key_pair']}' " +
                                        "-var 'k8s_version=${params['k8s_version']}' " +
                                        "-var 'num-workers-spot=${params['num-workers-spot']}' " +
                                        "-var 'num-workers-demand=${params['num-workers-demand']}' " +
                                        "-var 'instance-type-on-demand=${params['instance-type-on-demand']}' " +
                                        "-var 'instance-type-spot=${params['instance-type-spot']}' " +
                                        "-var 'public_key_file=${params['public_key_file']}' " +
                                        "-var 'eks_key_name=${params['eks_key_name']}' "


                        if (params.cloudwatch_logs) {
                            tfPlanCmd += " -var 'cloudwatch_logs=true'"
                        } else {
                            tfPlanCmd += " -var 'cloudwatch_logs=false'"
                        }

                        if (params.cluster_autoscaler) {
                            tfPlanCmd += " -var 'cluster-autoscaler=true'"
                        } else {
                            tfPlanCmd += " -var 'cluster-autoscaler=false'"
                        }

                        sh tfPlanCmd
                        sh 'terraform show -no-color eks_tfplan > eks_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'eks_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false eks_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var 'cluster-name=${params.cluster_name}' " +
                            "-var 'max-workers-demand=${params['max-workers-demand']}' " +
                            "-var 'max-workers-spot=${params['max-workers-spot']}' " +
                            "-var 'instance_capacity_types_demand=${params['instance_capacity_types_demand']}' " +
                            "-var 'instance_capacity_types_spot=${params['instance_capacity_types_spot']}' " +
                            "-var 'inst_disk_size=${params['inst_disk_size']}' " +
                            "-var 'inst_key_pair=${params['inst_key_pair']}' " +
                            "-var 'k8s_version=${params['k8s_version']}' " +
                            "-var 'num-workers-spot=${params['num-workers-spot']}' " +
                            "-var 'num-workers-demand=${params['num-workers-demand']}' " +
                            "-var 'instance-type-on-demand=${params['instance-type-on-demand']}' " +
                            "-var 'instance-type-spot=${params['instance-type-spot']}' " +
                            "-var 'public_key_file=${params['public_key_file']}' " +
                            "-var 'eks_key_name=${params['eks_key_name']}' "

                        if (params.cloudwatch_logs) {
                            tfPlanCmd += " -var 'cloudwatch_logs=true'"
                        } else {
                            tfPlanCmd += " -var 'cloudwatch_logs=false'"
                        }

                        if (params.cluster_autoscaler) {
                            tfPlanCmd += " -var 'cluster-autoscaler=true'"
                        } else {
                            tfPlanCmd += " -var 'cluster-autoscaler=false'"
                        }

                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }


                        }
                }
            }
        }
        stage('Nodegorup creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/nodegroups') {
                        sh 'terraform init'
                        def tfPlanCmd = "terraform plan -out=ng_tfplan " +
                                        "-var 'cluster-name=${params.cluster_name}' " +
                                        "-var 'max-workers-demand=${params['max-workers-demand']}' " +
                                        "-var 'max-workers-spot=${params['max-workers-spot']}' " +
                                        "-var 'instance_capacity_types_demand=${params['instance_capacity_types_demand']}' " +
                                        "-var 'instance_capacity_types_spot=${params['instance_capacity_types_spot']}' " +
                                        "-var 'inst_disk_size=${params['inst_disk_size']}' " +
                                        "-var 'inst_key_pair=${params['inst_key_pair']}' " +
                                        "-var 'num-workers-spot=${params['num-workers-spot']}' " +
                                        "-var 'num-workers-demand=${params['num-workers-demand']}' " +
                                        "-var 'instance-type-on-demand=${params['instance-type-on-demand']}' " +
                                        "-var 'instance-type-spot=${params['instance-type-spot']}' " +
                                        "-var 'public_key_file=${params['public_key_file']}' " +
                                        "-var 'eks_key_name=${params['eks_key_name']}' "

                        if (params.cloudwatch_logs) {
                            tfPlanCmd += " -var 'cloudwatch_logs=true'"
                        } else {
                            tfPlanCmd += " -var 'cloudwatch_logs=false'"
                        }

                        if (params.cluster_autoscaler) {
                            tfPlanCmd += " -var 'cluster-autoscaler=true'"
                        } else {
                            tfPlanCmd += " -var 'cluster-autoscaler=false'"
                        }

                        sh tfPlanCmd
                        sh 'terraform show -no-color ng_tfplan > ng_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'ng_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false ng_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var 'cluster-name=${params.cluster_name}' " +
                            "-var 'max-workers-demand=${params['max-workers-demand']}' " +
                            "-var 'max-workers-spot=${params['max-workers-spot']}' " +
                            "-var 'instance_capacity_types_demand=${params['instance_capacity_types_demand']}' " +
                            "-var 'instance_capacity_types_spot=${params['instance_capacity_types_spot']}' " +
                            "-var 'inst_disk_size=${params['inst_disk_size']}' " +
                            "-var 'inst_key_pair=${params['inst_key_pair']}' " +
                            "-var 'num-workers-spot=${params['num-workers-spot']}' " +
                            "-var 'num-workers-demand=${params['num-workers-demand']}' " +
                            "-var 'instance-type-on-demand=${params['instance-type-on-demand']}' " +
                            "-var 'instance-type-spot=${params['instance-type-spot']}' " +
                            "-var 'public_key_file=${params['public_key_file']}' " +
                            "-var 'eks_key_name=${params['eks_key_name']}' "

                        if (params.cloudwatch_logs) {
                            tfPlanCmd += " -var 'cloudwatch_logs=true'"
                        } else {
                            tfPlanCmd += " -var 'cloudwatch_logs=false'"
                        }

                        if (params.cluster_autoscaler) {
                            tfPlanCmd += " -var 'cluster-autoscaler=true'"
                        } else {
                            tfPlanCmd += " -var 'cluster-autoscaler=false'"
                        }

                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }


                        }
                }
            }
        }
        stage('ec2-jumbox creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/ec2-jumpbox') {
                        sh 'terraform init'
                        def tfPlanCmd = "terraform plan -out=ec2_jumpbox_tfplan " +
                                        "-var 'ami=${params.ami}' " +
                                        "-var 'ec2_key_name=${params.ec2_key_name}' " +
                                        "-var 'ec2_instance_type=${params.ec2_instance_type}' " +
                                        "-var 'js_user=${params.js_user}'"
                        sh tfPlanCmd
                        sh 'terraform show -no-color ec2_jumpbox_tfplan > ec2_jumpbox_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'ec2_jumpbox_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false ec2_jumpbox_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var 'ami=${params.ami}' " +
                            "-var 'ec2_key_name=${params.ec2_key_name}' " +
                            "-var 'ec2_instance_type=${params.ec2_instance_type}' " +
                            "-var 'js_user=${params.js_user}'"
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }

                    def instancePublicIp = sh(returnStdout: true, script: "terraform output public_ip").trim()

                    env.INSTANCE_PUBLIC_IP = instancePublicIp
                    }
                }
            }
        }
        stage('Dir creation') {
            steps {
                script {
                    dir('julesh-terraform/environments/dev/ec2-jumpbox') {
                        def inventoryContent = "[ec2]\n${env.INSTANCE_PUBLIC_IP} ansible_user=ubuntu ansible_ssh_private_key_file=/var/lib/jenkins/keypairs/jenkins-test-server2-keypair.pem"
                        sh "echo '${inventoryContent}' > inventory.ini"

                        sh "ansible-playbook -i inventory.ini deploy.yml --extra-vars 'efs_dns_name=${env.EFS_DNS_NAME} aws_access_key_id=${env.AWS_ACCESS_KEY_ID} aws_secret_access_key=${env.AWS_SECRET_ACCESS_KEY} aws_region=${params.region} aws_output_format=${params.output} namespace_name=${params.namespace} region=${params.region} cluster_name=${params.cluster_name}'"
                }
                }
            }
        }
    }
}
