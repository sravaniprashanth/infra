pipeline
{
    agent 
    {
        node { label 'maven' }
    }
environment {
PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
}
    stages {
        stage("build")
        {
            steps {
sh 'mvn clean package -Dmaven.test.skip=true'
            }
        }
stage("test") {
steps {
echo "-----unit tests started-----"
sh 'mvn surefire-report:report'
echo "----unit tests done-------"
}
}
 stage('SonarQube analysis') {
environment {
    scannerHome = tool 'my-sonar-scanner';
}
steps {
    withSonarQubeEnv('sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }
    }
stage("QualityGate"){
steps
{
script {
timeout(time: 1, unit: 'HOURS') {
def qg = waitForQualityGate()
if (qg.status != 'OK') {
error "pipeline aborted due to qg failure: ${qg.status}"
}}}}}


}
}
