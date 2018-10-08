#!/bin/bash
# Optional ENV VAR:
#  HAPROXY_CFG_FILE  the absolute path to the HAPRoxy.cfg file you want to use
#    defaults to /usr/local/etc/haproxy/haproxy.cfg if unset
PID_FILE="/var/run/haproxy.pid"


# Make sure service is running
service rsyslog start

# Touch the log file so we can tail on it
touch /var/log/haproxy.log

# Throw the log to output
tail -f /var/log/haproxy.log &


#function reload
#{
#  haproxy -f <config> -p <pidfile> -sf $(cat <pidfile>) &
#  wait
#}
#
#trap reload SIGHUP
#trap "kill -TERM $(cat pidfile) || exit 1" SIGTERM SIGINT

# Start haproxy
#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
exec haproxy -W \
  -f "${HAPROXY_CFG_FILE:-/usr/local/etc/haproxy/haproxy.cfg}" \
  -p $PID_FILE \
  -sf $(cat $PID_FILE)
