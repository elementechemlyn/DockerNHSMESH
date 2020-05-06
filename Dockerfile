FROM openjdk:7

ARG MESHPWD
ARG MESHBOX
ARG KSPASS
ARG MESHENDPOINT=https:\\/\\/192\\.168\\.128\\.11

COPY ./mesh-6.2.0_20180601-installer-signed.jar /tmp
COPY ./auto-install.xml /tmp

RUN java -jar /tmp/mesh-6.2.0_20180601-installer-signed.jar /tmp/auto-install.xml
RUN sed -i "s/ClntAuth1/${MESHPWD}/g" /usr/MESH-APP-HOME/meshclient.cfg
RUN sed -i "s/MAILBOX01/${MESHBOX}/g" /usr/MESH-APP-HOME/meshclient.cfg
RUN sed -i "s/xxxxxxxx/${KSPASS}/g" /usr/MESH-APP-HOME/meshclient.cfg
RUN sed -i "s/<PrimaryURL>.*<\/PrimaryURL>/<PrimaryURL>${MESHENDPOINT}<\/PrimaryURL>/g" /usr/MESH-APP-HOME/meshclient.cfg

COPY mesh.keystore /usr/MESH-APP-HOME/KEYSTORE/mesh.keystore

RUN mv /usr/MESH-DATA-HOME/MAILBOX01 /usr/MESH-DATA-HOME/${MESHBOX}

WORKDIR /usr/MESH-APP-HOME
VOLUME ["/usr/MESH-DATA-HOME"]
#No shebang in run script
CMD ["/bin/bash", "/usr/MESH-APP-HOME/runMeshClient.sh"]
