FROM sonatype/nexus3:3.18.1

MAINTAINER Jhonatan Morais <jhonatanvinicius@gmail.com>

COPY nexus-repository-composer-0.0.2.jar /opt/sonatype/nexus/deploy/nexus-repository-composer-0.0.2.jar

WORKDIR /nexus-data


