FROM node

FROM jenkins/jnlp-slave
USER root
COPY --from=0 /usr/local  /usr/local


COPY ./setup.sh /setup.sh
RUN /setup.sh

USER jenkins

RUN npm -version
RUN jenkins-slave -version x
RUN jenkins-agent -version x
RUN ansible --version

# COPY $INSTALLER /$INSTALLER

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

