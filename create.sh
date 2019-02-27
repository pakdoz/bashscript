#!/bin/bash

read -p "Masukkan Domain: "  DOMAIN
read -p "Masukkan Upstream IP: "  IPADDRESS
read -p "Masukkan Port Upstream: "  PORT
touch /etc/nginx/conf/upstream/$DOMAIN.conf
touch /etc/nginx/conf/cdn/$DOMAIN.conf

cat > /etc/nginx/conf/upstream/$DOMAIN.conf <<EOF
upstream $DOMAIN {
server $IPADDRESS:$PORT;
}
EOF

cat > /etc/nginx/conf/cdn/$DOMAIN.conf <<EOF
location ~/$DOMAIN(.*)$ {
proxy_set_header  X-Real-IP \$remote_addr;
proxy_pass https://$DOMAIN\$1;
proxy_store /tmp/cache/cache\$uri;
proxy_store_access user:rw group:rw all:r;
}
EOF

service nginx reload

echo ""
echo "Creating complete!"
