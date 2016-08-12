# Dockerfile Raspberry Pi OpenVPN
FROM resin/rpi-raspbian:latest

# Gen Local FR
#RUN locale-gen fr_FR.UTF-8 
#ENV LANG fr_FR.UTF-8
#ENV LANGUAGE fr_FR:fr
#ENV LC_ALL fr_FR.UTF-8

# Update sources && install packages
RUN DEBIAN_FRONTEND=noninteractive ;\
apt-get update && \
apt-get install --assume-yes \
    openvpn \
    ntp \
    wget && \
    rm -rf /var/lib/apt/lists/*
    
RUN echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure tzdata && sed -i 's/.debian./.fr./g' /etc/ntp.conf

# Configuration supervisor
RUN mkdir -p /var/log/supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/etc/openvpn"]
WORKDIR /etc/openvpn

# Ports 
EXPOSE 1194 1194/udp

# Boot up container
CMD ["/usr/bin/supervisord"]
