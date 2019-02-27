#!/bin/bash

read -p "Masukkan Domain: "  DOMAIN
rm -f /etc/nginx/conf/upstream/$DOMAIN.conf 
rm -f /etc/nginx/conf/cdn/$DOMAIN.conf

service nginx reload

echo ""
echo "Deleting complete!"
