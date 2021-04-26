# Jenkinsfile
# Verify a Maven project

node {
  git url: 'https://github.com/user/repo.git'
  def mvnHome = tool 'M3'
  sh "${mvnHome}/bin/mvn -B verify"
}