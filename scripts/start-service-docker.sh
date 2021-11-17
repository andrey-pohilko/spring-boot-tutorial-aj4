#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
/opt/apache-maven-3.8.3/bin/mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following complex command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`/opt/apache-maven-3.8.3/bin/mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
set +x

echo 'The following complex command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`/opt/apache-maven-3.8.3/bin/mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
set +x

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
set -x
mkdir -p /var/lib/spring-boot-tutorial-aj4
cp scripts/docker/Dockerfile /var/lib/spring-boot-tutorial-aj4
cp target/${NAME}-${VERSION}.jar /var/lib/spring-boot-tutorial-aj4/spring-boot-tutorial-aj4.jar

cd /var/lib/spring-boot-tutorial-aj4


docker build -t anoxis/spring-boot-tutorial-aj4-image:${VERSION} .
docker stop spring-boot-tutorial-aj4
docker rm spring-boot-tutorial-aj4
docker rmi anoxis/spring-boot-tutorial-aj4-image:latest
docker tag anoxis/spring-boot-tutorial-aj4-image:${VERSION} anoxis/spring-boot-tutorial-aj4-image:latest

docker run --restart unless-stopped -d -p 9000:9000 --name spring-boot-tutorial-aj4 anoxis/spring-boot-tutorial-aj4-image:latest