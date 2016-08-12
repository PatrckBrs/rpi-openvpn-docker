# Dockerfile Raspberry Pi OpenVPN
FROM resin/rpi-raspbian:latest

# Update sources && install packages
RUN DEBIAN_FRONTEND=noninteractive ;\
apt-get update && \
apt-get install --assume-yes \
    openvpn \
    wget && \
    rm -rf /var/lib/apt/lists/*
    
RUN echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure tzdata && sed -i 's/.debian./.fr./g' /etc/ntp.conf

# Configuration supervisor
RUN mkdir -p /var/log/supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Ports 
EXPOSE 80 443

# Boot up container
CMD ["/usr/bin/supervisord"]