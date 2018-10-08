FROM haproxy:1.8.13

# Install rsyslog
RUN apt-get update && \
  apt-get -y install rsyslog && \
  rm -rf /var/lib/apt/lists/*

ADD haproxy.conf /etc/rsyslog.d
ADD rsyslog.conf /etc/rsyslog.conf
COPY docker-entrypoint.sh /


EXPOSE 80 443 1883 8883 1988

ENTRYPOINT ["/docker-entrypoint.sh"]
