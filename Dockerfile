FROM haproxy:1.9.5

# Install rsyslog
RUN apt-get update && \
  apt-get -y install rsyslog && \
  rm -rf /var/lib/apt/lists/*

ADD haproxy.conf /etc/rsyslog.d
ADD rsyslog.conf /etc/rsyslog.conf
COPY docker-entrypoint.sh /

# Optional ENV var you could override:
# HAPROXY_CFG_FILE setup the full path (in the container) where to load the HAproxy config

EXPOSE 80 443 1883 8883 1988

ENTRYPOINT ["/docker-entrypoint.sh"]

