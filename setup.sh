#!/bin/sh

set -eu

apt-get purge -y \
mercurial-common \
adwaita-icon-theme

apt-get update && apt-get -y install software-properties-common

# Ansible repository
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 93C4A3FD7BB9C367

# Java repository
# add-apt-repository -y ppa:webupd8team/java \
# && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C2518248EEA14886 \
# && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
# && sed -i 's/disco/xenial/g' /etc/apt/sources.list.d/webupd8team-ubuntu-java-disco.list

# NodeJS repository
# apt-get update \
# && curl -sL https://deb.nodesource.com/setup_8.x | bash -
# 
# apt-add-repository ppa:qameta/allure && \
# sed -i 's/disco/xenial/g' /etc/apt/sources.list.d/qameta-ubuntu-allure-disco.list && \
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 134BF6F3

apt-get update && apt-get -y install \
vim less \
ansible \
ant \
zip \
openssl \
curl \
nodejs \
python-pip \
jq \
rdesktop \
xvfb \
maven \
wget \
unzip \
sudo \
rpm \
sudo \
rsync

# oracle-java8-installer \

pip install awscli boto requests-credssp docker pywinrm --upgrade

#install terraform
# wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip \
# && unzip terraform_0.11.8_linux_amd64.zip -d /usr/bin \
# && rm terraform_0.11.8_linux_amd64.zip \
# && terraform --version

apt-get autoremove -y --purge && apt-get clean

#rm /docker-java-home
#ln -s /usr/lib/jvm/java-8-oracle/jre /docker-java-home

# volumes
mkdir -p /home/jenkins/.m2

# env settings
# echo 'export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"' >> /etc/profile
# echo 'export JAVA_1_6_HOME=$JAVA_HOME' >> /etc/profile
unset EXECUTOR_NUMBER

# http://ksoong.org/troubleshooting/descriptor/mvn-too-many-file-open.html
echo "* soft	nofile           4096" >> /etc/security/limits.conf
echo "* hard	nofile           4096" >> /etc/security/limits.conf
echo "jenkins soft nofile           4096" >> /etc/security/limits.conf
echo "jenkins hard	nofile           4096" >> /etc/security/limits.conf
echo "%jenkins soft nofile           4096" >> /etc/security/limits.conf
echo "%jenkins hard	nofile           4096" >> /etc/security/limits.conf

# maven custom version
wget https://www-us.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz -P /tmp && \
tar xf /tmp/apache-maven-*.tar.gz -C /opt && \
ln -sf /opt/apache-maven-3.5.4 /opt/maven
echo 'export MAVEN_HOME=/opt/maven' >> /etc/profile
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile
ln -sfv /opt/maven/bin/mvn /usr/bin/mvn || true

# java jdk
INSTALLER=jdk-8u241-linux-x64.deb
dpkg -i /$INSTALLER && rm /$INSTALLER
