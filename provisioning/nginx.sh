#!/bin/bash
apt-get update -y
apt-get install -y nginx

# Remove any default nginx html files
rm -f /var/www/html/*

# Default output is full FQDN
output=$(hostname -f)

# If no arguments supplied then use hostname as output for nginx
# else use that output
if [ $# -ne  0 ]; then
  output=$1
fi

# Write provided argument as default nginx output
echo $output > /var/www/html/index.html

service nginx start
