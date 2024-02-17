node {
  stage('SCM') {
    checkout scm
  }
  }
  stage("sendemail") {
    mail bcc: '', body: '''sonarqube detailed report on the project
http://20.89.90.110:9090/dashboard?id=myproject''', cc: '', from: '', replyTo: '', subject: 'report', to: 'nocturnaldevops@gmail.com'
}
}
