FROM node

FROM jenkins/jnlp-slave
USER root
COPY --from=0 /usr/local  /usr/local

USER jenkins

RUN npm -version
RUN jenkins-slave -version x
RUN jenkins-agent -version x
RUN ansible --version
