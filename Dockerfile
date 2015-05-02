FROM resin/rpi-raspbian:jessie

MAINTAINER Vincent RABAH <vincent.rabah@gmail.com>

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install bind9 --no-install-recommends && \
    cat /etc/bind/named.conf.options | sed 's/dnssec-validation auto;/dnssec-validation auto; allow-query { 0.0.0.0\/0; }; allow-recursion { 0.0.0.0\/0; };/' >/tmp/bind.options && cat /tmp/bind.options >/etc/bind/named.conf.options && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

EXPOSE 53
EXPOSE 53/udp

VOLUME /data

CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f"]
