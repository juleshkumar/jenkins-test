pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
        string(name: 'name', defaultValue: 'vpc', description: 'enter name of your vpc')
        string(name: 'project', defaultValue: 'testing', description: 'enter your project name')
        string(name: 'environment', defaultValue: 'dev', description: 'mention env name')
        string(name: 'region', defaultValue: 'ap-south--1', description: 'mention resource creation region')
        string(name: 'cidr_block', defaultValue: '10.0.0.0/16', description: 'enter the cidr for vpc')
        string(name: 'availability_zone_one', defaultValue: 'ap-south-1a', description: 'enter the az1')
        string(name: 'availability_zone_two', defaultValue: 'ap-south-1b', description: 'enter the az2')
        string(name: 'public_subnet_a_cidr_blocks', defaultValue: '10.0.0.0/24', description: 'enter cidr for public subnet 1a')
        string(name: 'public_subnet_b_cidr_blocks', defaultValue: '10.0.1.0/24', description: 'enter cidr for public subnet 1b')
        string(name: 'private_subnet_a_cidr_blocks', defaultValue: '10.0.2.0/24', description: 'enter cidr for pvt subnet 1a')
        string(name: 'private_subnet_b_cidr_blocks', defaultValue: '10.0.3.0/24', description: 'enter cidr for pvt subnet 1b')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/juleshkumar/jenkins-test.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan') {
            steps {
                sh "terraform plan -out tfplan \
                        -var 'name=${params.name}' \
                        -var 'project=${params.project}' \
                        -var 'environment=${params.environment}' \
                        -var 'region=${params.region}' \
                        -var 'cidr_block=${params.cidr_block}' \
                        -var 'availability_zone_one=${params.availability_zone_one}' \
                        -var 'availability_zone_two=${params.availability_zone_two}' \
                        -var 'public_subnet_a_cidr_blocks=${params.public_subnet_a_cidr_blocks}' \
                        -var 'public_subnet_b_cidr_blocks=${params.public_subnet_b_cidr_blocks}' \
                        -var 'private_subnet_a_cidr_blocks=${params.private_subnet_a_cidr_blocks}' \
                        -var 'private_subnet_b_cidr_blocks=${params.private_subnet_b_cidr_blocks}'"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        
        stage('Apply / Destroy') {
            steps {
                script {
                    if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'tfplan.txt'
                            input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }

                        sh "terraform ${params.action} -input=false tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve \
                                -var 'name=${params.name}' \
                                -var 'project=${params.project}' \
                                -var 'environment=${params.environment}' \
                                -var 'region=${params.region}' \
                                -var 'cidr_block=${params.cidr_block}' \
                                -var 'availability_zone_one=${params.availability_zone_one}' \
                                -var 'availability_zone_two=${params.availability_zone_two}' \
                                -var 'public_subnet_a_cidr_blocks=${params.public_subnet_a_cidr_blocks}' \
                                -var 'public_subnet_b_cidr_blocks=${params.public_subnet_b_cidr_blocks}' \
                                -var 'private_subnet_a_cidr_blocks=${params.private_subnet_a_cidr_blocks}' \
                                -var 'private_subnet_b_cidr_blocks=${params.private_subnet_b_cidr_blocks}'"
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                }
            }
        }
        
        stage('Save Outputs') {
            steps {
                // Retrieve the values from outputs.tf and save them in a file
                sh 'terraform output -json > terraform_outputs.json'
                // You can also save the values as environment variables if needed
                script {
                    def outputs = readJSON file: 'terraform_outputs.json'
                    env.TF_OUTPUT_VALUE_1 = outputs.vpc_id
                    env.TF_OUTPUT_VALUE_2 = outputs.public_subnet_a_ids
                    // Repeat for other output values as needed
                }
            }
        }
        // Additional stages...
    }
    
    post {
        always {
            // Archive the file containing the output values as an artifact
            archiveArtifacts artifacts: 'terraform_outputs.json', onlyIfSuccessful: true
        }
    }
    }
}
