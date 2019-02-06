About
=====

The nginx-ldap Docker image provides a container, that contains a [nginx server](http://nginx.org/) with LDAP support.

This [nginx-auth-ldap](https://github.com/kvspb/nginx-auth-ldap) module is used for LDAP support.


Usage
=====

The docker image can be used like the [official nginx docker image](https://hub.docker.com/r/library/nginx/).
But you have to overwrite the configuration file like to configure the LDAP authentication.

```
$ docker run --name some-nginx -v /some/nginx.conf:/etc/nginx/nginx.conf:ro -d jmccoy555/nginx
```

LDAP configuration
------------------

The documentation for the LDAP authentication and an example is [here](https://github.com/kvspb/nginx-auth-ldap/blob/master/README.md#example-configuration) available.


Nginx Configuration
===================

Here are some further links for more configuration hints.

* [official nginx documentation](http://nginx.org/en/docs/configure.html)
* [nginx tuning documentation](https://www.nginx.com/blog/tuning-nginx)
* [ldap module documentation](https://github.com/kvspb/nginx-auth-ldap/blob/master/README.md)


Registry
========

This image is an automated build on the [official Docker Hub](https://hub.docker.com/r/jmccoy555/nginx).


Changelog
=========
* 09/09/17 - Updated to 1.13.5 and added stream, stream-ssl and stream-ssl-preread modules.
* 13/09/17 - Added http2 module, updated readme.
* 21/10/17 - Updated to 1.13.6 and added mail, mail-ssl, geoip and stream-realip modules.
* 25/02/18 - Updated to 1.13.9.
* 11/07/18 - Updated to 1.15.1.
* 24/07/18 - Added http_stub_status_module.
* 06/02/19 - Switch to debain:stretch-slim and updated version to 1.15.8.
