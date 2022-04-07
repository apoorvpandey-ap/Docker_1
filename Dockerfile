From jboss/base-jdk:11

ENV WILDFLY_VERSION 24.0.0.Final
ENV WILDFLY_SHA1 391346c9ed2772647ff07aeae39deb838ee11dcf
ENV JBOSS_HOME /opt/jboss/wildfly

USER root

RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}
	
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER root
EXPOSE 6060

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
