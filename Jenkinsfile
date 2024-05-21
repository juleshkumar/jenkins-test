pipeline {
    agent any

    parameters {
        string(name: 'cluster_name', defaultValue: 'eks-decimal-test', description: 'clustername')
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
                    
                    git branch: 'dev-5', url: 'https://github.com/juleshkumar/jenkins-test.git'
                    dir('addon') {
                        sh 'terraform init'
                        
                        def tfPlanCmd = "terraform plan -out=as_tfplan " +
                                        "-var 'cluster-name=${params.cluster_name}'"
                        sh tfPlanCmd
                        sh 'terraform show -no-color as_tfplan > as_tfplan.txt'
                        
                        if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'as_tfplan.txt'
                            input message: "Do you want to apply the plan?",
                                  parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh "terraform ${params.action} -input=false as_tfplan"
                    } else if (params.action == 'destroy') {
                        sh "terraform ${params.action} --auto-approve -var 'cluster-name=${params.cluster_name}' "
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                    }
                }
            }
        }
    }
}
