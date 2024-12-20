pipeline {
    agent any
        stages {
        
            stage('build') {
                steps {
                    sh 'mvn clean package'
                }
            }
            
            stage('sonar') {
                steps {
                   sh 'mvn sonar:sonar'
                }    
            }
            stage('Deploy to Nexus') {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: 'http://18.215.161.44:8081',
                    groupId: 'pom.org.sonarqube',
                    version: 'pom.1.0-SNAPSHOT',
                    repository: 'maven-releases',
                    credentialsId: 'nexus',
                    artifacts: [
                        [artifactId: 'sonarscanner-maven-aggregate',
                         file: '/tests/target/tests-1.0-SNAPSHOT',
                         type: 'jar']
                    ]
                    )
                }
            }
            
        
        }
}

