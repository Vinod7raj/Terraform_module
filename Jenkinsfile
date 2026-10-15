pipeline {
  agent any
  options { disableConcurrentBuilds(); timestamps() }
  stages {
    stage('Init')     { steps { sh 'terraform init -input=false' } }
    stage('Format')   { steps { sh 'terraform fmt -check -recursive' } }
    stage('Validate') { steps { sh 'terraform validate' } }
    stage('Scan')     { steps { sh 'tfsec .' } }
    stage('Plan') {
      steps {
        sh 'terraform plan -input=false -out=tfplan'
        sh 'terraform show -no-color tfplan > plan.txt'
        archiveArtifacts 'plan.txt'
      }
    }

stage('Debug') {
  steps {
    echo "BRANCH_NAME=${env.BRANCH_NAME} GIT_BRANCH=${env.GIT_BRANCH}"
  }
}
    stage('Approve') {
      when { branch 'master' }
      steps { timeout(time: 30, unit: 'MINUTES') { input message: 'Apply this plan?' } }
    }
    stage('Apply') {
      when { branch 'master' }
      steps { sh 'terraform apply -input=false tfplan' }
    }
  }
  post { always { cleanWs() } }
}
