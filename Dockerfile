FROM resin/rpi-raspbian:jessie
MAINTAINER Vincent RABAH <vincent.rabah@gmail.com>
RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install bind9
EXPOSE 53
EXPOSE 53/udp
VOLUME /data
CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f"]
