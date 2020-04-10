FROM jenkins/jnlp-slave

ARG INSTALLER=jdk-8u241-linux-x64.deb

USER root
COPY $INSTALLER /$INSTALLER

ADD setup.sh /
RUN /setup.sh

# java
# RUN apt-get -y install rpm
# RUN rpm -i /$INSTALLER && \
# rm /$INSTALLER

USER jenkins
VOLUME ["/home/jenkins/.m2"]

ENV MAVEN_OPTS="-Xmx8192m -XX:MaxPermSize=1024m -XX:-UseGCOverheadLimit"
ENV JAVA_HOME="/usr/java/jdk1.8.0_241-amd64/"
ENV JAVA_1_6_HOME="$JAVA_HOME"
ENV JAVA_1_8_HOME="$JAVA_HOME"
ENV JAVA5_BOOTCLASSES="$JAVA_HOME/jre/lib/rt.jar"
ENV JAVA7_BOOTCLASSES="$JAVA5_BOOTCLASSES"
ENV JAVA8_BOOTCLASSES="$JAVA5_BOOTCLASSES"

USER root
