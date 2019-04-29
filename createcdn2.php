#!/bin/bash
echo $1
touch /etc/nginx/conf/cdnbiz/$1.conf

cat > /etc/nginx/conf/cdnbiz/$1.conf <<EOF
location ~/$1(.*)$ {
set \$upstream_endpoint https://$1:443;
proxy_set_header  X-Real-IP \$remote_addr;
proxy_pass \$upstream_endpoint\$1;
proxy_store /tmp/cache2/cache\$uri;
proxy_store_access user:rw group:rw all:r;
}
EOF
