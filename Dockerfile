FROM debian:stretch-slim

MAINTAINER James McCoy <james@mcy.email>

#
# Define some variables.
#
ENV NGINX_VERSION release-1.17.6

#
# Install needed packages, compile and install.
# Remove unused packages and cleanup some directories.
#
RUN \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        ca-certificates \
        git \
        gcc \
        make \
        libpcre3-dev \
        zlib1g-dev \
        libldap2-dev \
        libldap-2.4-2 \
        libssl-dev \
        libgeoip-dev \
        wget && \
    mkdir /var/log/nginx && \
    mkdir /etc/nginx && \
    cd /tmp && \
    git clone https://github.com/kvspb/nginx-auth-ldap.git && \
    git clone https://github.com/nginx/nginx.git && \
    cd /tmp/nginx && \
    git checkout tags/${NGINX_VERSION} && \
    ./auto/configure \
        --add-module=/tmp/nginx-auth-ldap \
        --with-pcre \
        --with-debug \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --with-http_stub_status_module \
        --with-http_realip_module \
        --with-http_auth_request_module \
        --with-http_v2_module \
        --with-http_geoip_module=dynamic \
        --with-http_sub_module \
        --with-stream \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
        --with-stream_realip_module \
        --with-stream_geoip_module=dynamic \
        --with-mail \
        --with-mail_ssl_module \
        --conf-path=/etc/nginx/nginx.conf \
        --sbin-path=/usr/sbin/nginx \
        --pid-path=/var/log/nginx/nginx.pid \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log && \
    make install && \
    apt purge -y \
        git \
        gcc \
        make \
        libpcre3-dev \
        zlib1g-dev \
        libldap2-dev \
        libssl-dev \
        wget && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/src/* && \
    rm -rf /tmp/* && \
    rm -rf /usr/share/doc/* && \
    rm -rf /usr/share/man/* && \
    rm -rf /usr/share/locale/*

#
# link access and error logs to docker log collector.
#
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log


#
# Expose ports.
#
EXPOSE 80 443

#
# Start nginx.
#
CMD ["nginx", "-g", "daemon off;"]
