FROM registry.access.redhat.com/ubi8:latest
ENV APP_ROOT=/opt
WORKDIR ${APP_ROOT}
RUN yum install -y java-11-openjdk-devel unzip procps
ADD sonarqube-7.9.1.zip ./
RUN unzip sonarqube-7.9.1.zip
RUN rm /opt/sonarqube-7.9.1.zip
ADD uid_entrypoint /usr/bin
RUN chmod -R u+x ${APP_ROOT} && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

USER 1001
# See: https://docs.openshift.com/container-platform/4.1/openshift_images/create-images.html#images-create-guide-openshift_create-images
ENTRYPOINT [ "uid_entrypoint" ]
VOLUME ${APP_ROOT}/logs ${APP_ROOT}/data
CMD sonarqube-7.9.1/bin/linux-x86-64/sonar.sh console