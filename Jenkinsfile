pipeline {
  agent { label 'delphi12-pc' }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        bat '''
          "C:\\Program Files (x86)\\Embarcadero\\Studio\\23.0\\bin\\msbuild.exe" ^
          Project2.dproj ^
          /t:Build ^
          /p:Config=Release ^
          /p:Platform=Win32
        '''
      }
    }

    stage('Run Tests') {
      steps {
        bat '''
          Win32\\Release\\Project2.exe --xmlfile:"%WORKSPACE%\\TestResults.xml"
        '''
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'TestResults.xml', fingerprint: true
      junit allowEmptyResults: true, testResults: 'TestResults.xml'
    }
  }
}
