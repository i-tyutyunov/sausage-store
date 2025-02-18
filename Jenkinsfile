pipeline {
    agent any // Выбираем Jenkins агента, на котором будет происходить сборка: нам нужен любой

    triggers {
        pollSCM('H/5 * * * *') // Запускать будем автоматически по крону примерно раз в 5 минут
    }

    tools {
        maven 'maven-3.8.1' // Для сборки бэкенда нужен Maven
//         jdk 'jdk16' // И Java Developer Kit нужной версии
        nodejs 'node-16' // А NodeJS нужен для фронта
    }

    stages {
        stage('Build & Test backend') {


            steps {
                dir("backend") { // Переходим в папку backend
                    sh 'mvn package' // Собираем мавеном бэкенд
                    sh 'echo "Собрали backend"'
                }
            }

            post {
                success {
                    junit 'backend/target/surefire-reports/**/*.xml' // Передадим результаты тестов в Jenkins
                    sh 'echo "Передадим результаты тестов в Jenkins"'
                }
            }
        }

        stage('Build frontend') {
            steps {
                dir("frontend") {
                    sh 'npm install' // Для фронта сначала загрузим все сторонние зависимости
                    sh 'npm run build' // Запустим сборку
                    sh 'echo "Собрали frontend"'
                }
            }
        }

        stage('Save artifacts') {
            steps {
                archiveArtifacts(artifacts: 'backend/target/sausage-store-0.0.1-SNAPSHOT.jar')
                archiveArtifacts(artifacts: 'frontend/dist/frontend/*')
                 sh 'echo "Сохранили артефакты"'
            }

             post {
                    success {
                        sh 'curl --location \'https://api.telegram.org/bot5933756043:AAE8JLL5KIzgrNBeTP5e-1bkbJy4YRoeGjs/sendMessage\' \
                            --header \'Content-Type: application/json\' \
                            --data \'{"chat_id": "-1002007326342","text": "Игорь Тютюнов собрал приложение."}\''
                    }
                }
        }
    }
}