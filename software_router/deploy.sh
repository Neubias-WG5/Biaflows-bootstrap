#!/bin/bash

/etc/init.d/ssh start

mkdir /software_router
cd software_router/
mv /tmp/config.groovy .
mv /tmp/cytomine-java-client-1.0-SNAPSHOT-jar-with-dependencies.jar .

echo "cytomineCoreURL='http://$CORE_URL'" >> config.groovy
echo "rabbitUsername='$RABBITMQ_LOGIN'" >> config.groovy
echo "rabbitPassword='$RABBITMQ_PASSWORD'" >> config.groovy
echo "groovyPath='$GROOVY_PATH'" >> config.groovy
echo "publicKey='$ADMIN_PUB_KEY'" >> config.groovy
echo "privateKey='$ADMIN_PRIV_KEY'" >> config.groovy


wget -q $ALGO_TAR -O algo.tar.gz
tar -xvf algo.tar.gz algo

wget -q $SOFTWARE_ROUTER_JAR -O Cytomine-software-router.jar

echo "$(route -n | awk '/UG[ \t]/{print $2}')       $CORE_URL" >> /etc/hosts

touch /tmp/test.out

java -jar Cytomine-software-router.jar

tail -f /tmp/test.out