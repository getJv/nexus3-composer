Nexus3 with Composer plugin
===========================

Docker image for nexus3 repository manager with composer plugin.

[Visit the tutorial Guide to use instructions](https://medium.com/@jhonatanvinicius/nexus3-with-composer-plugin-a621139d9fd0)

References
----------

* [Official nexus-repository-composer](https://github.com/sonatype-nexus-community/nexus-repository-composer)
* [Official guide about how to config composer at nexus3](https://github.com/sonatype-nexus-community/nexus-repository-composer/blob/master/docs/COMPOSER_USER_DOCUMENTATION.md)
* [Gitter/nexus-developers](https://gitter.im/sonatype/nexus-developers)
* [Forum nexus developers](https://groups.google.com/a/glists.sonatype.com/forum/?hl=en#!forum/nexus-users)
* [Composer nexus plugin](https://github.com/freelancer/nexus-repository-composer/releases)
* [Alternative nexus tutorial for studies](https://blog.4linux.com.br/repositorios-locais-com-nexus-sonatype/)

Usefull Commands
---------------

* `docker build -t getjv/nexus3 .` to build image.
* `docker volume create --name nexus-data` to create a volume
* `docker-compose up -d` to run the server (taks ~2min to server wake up)
* `docker exec -it --user=root nexus bash` to access the container as root user
* `docker logs -f nexus` to see nexus logs
* `http://localhost:8081/` to access nexus when using regular docker
* `http://192.168.99.100:8081/` to access nexus when using dockertoolbox (win7)
* `docker exec nexus cat /nexus-data/admin.password` to get admin password

Setting composer.json to use nexus3 repository
----------------------------------------------

Just add this infor in your composer.json project

```
{
    ...
    ,
    "config": {
        "secure-http":false
    },
    "repositories": [
        {
          "type": "composer",
          "url": "http://localhost:8081/repository/composer-proxy/"
        },
        {
          "packagist.org": false
        }
      ]
    ...
}

```

Notes
-----

[Copied from official repo](https://hub.docker.com/r/sonatype/nexus3#notes)

Our system requirements should be taken into account when provisioning the Docker container.

Default user is admin and the uniquely generated password can be found in the admin.password file inside the volume. See Persistent Data for information about the volume.

It can take some time (2-3 minutes) for the service to launch in a new container. You can tail the log to determine once Nexus is ready:

`$ docker logs -f nexus`

Installation of Nexus is to `/opt/sonatype/nexus`.

A persistent directory, `/nexus-data`, is used for configuration, logs, and storage. This directory needs to be writable by the Nexus process, which runs as UID 200.

There is an environment variable that is being used to pass JVM arguments to the startup script

INSTALL4J_ADD_VM_PARAMS, passed to the Install4J startup script. Defaults to `-Xms1200m -Xmx1200m -XX:MaxDirectMemorySize=2g -Djava.util.prefs.userRoot=${NEXUS_DATA}/javaprefs`.

* This can be adjusted at runtime:

`$ docker run -d -p 8081:8081 --name nexus -e INSTALL4J_ADD_VM_PARAMS="-Xms2g -Xmx2g -XX:MaxDirectMemorySize=3g  -Djava.util.prefs.userRoot=/some-other-dir" sonatype/nexus3`

Of particular note, -Djava.util.prefs.userRoot=/some-other-dir can be set to a persistent path, which will maintain the installed Nexus Repository License if the container is restarted.

* Another environment variable can be used to control the Nexus Context Path NEXUS_CONTEXT, defaults to /

This can be supplied at runtime: `$ docker run -d -p 8081:8081 --name nexus -e NEXUS_CONTEXT=nexus sonatype/nexus3`
