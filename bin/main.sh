#!/bin/sh
echo "Use DNS-SERVER: $DNS_SERVER"
if [ -n "$DOMAINS" ]; then
    echo "$DOMAINS" >>$DOMAINS_FILE
fi

while read -r domain || [[ -n $domain ]]; do
    ip=$(dig @$DNS_SERVER +short "$domain" | tail -n 1)
    sudo echo "$ip $domain" | sudo tee -a /etc/hosts
    echo "✅ Add $ip $domain succeed！"
done <$DOMAINS_FILE

echo "---- output hosts ----"
sudo cat /etc/hosts

# check domain is accessible
# while IFS= read -r domain; do
#     response=$(curl -IL -s -o /dev/null -w "%{http_code}" "$domain")
#     if [ "$response" -eq 200 ]; then
#         echo "✅ $domain site is accessible"
#     else
#         echo "⚠️ $domain site is not accessible"
#     fi
# done <domain.txt