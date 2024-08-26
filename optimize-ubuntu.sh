#!/bin/bash
green='\033[1;92m'        # Green
White='\033[1;97m'        # White
wget -q -O/etc/trackers https://raw.githubusercontent.com/Heclalava/blockpublictorrent-iptables/main/trackers
cat >/etc/cron.daily/denypublic<<'EOF'
IFS=$'\n'
L=$(/usr/bin/sort /etc/trackers | /usr/bin/uniq)
for fn in $L; do
        /sbin/iptables -D INPUT -d $fn -j DROP
        /sbin/iptables -D FORWARD -d $fn -j DROP
        /sbin/iptables -D OUTPUT -d $fn -j DROP
        /sbin/iptables -A INPUT -d $fn -j DROP
        /sbin/iptables -A FORWARD -d $fn -j DROP
        /sbin/iptables -A OUTPUT -d $fn -j DROP
done
EOF
chmod +x /etc/cron.daily/denypublic
curl -s -LO https://raw.githubusercontent.com/Heclalava/blockpublictorrent-iptables/main/hostsTrackers
cat hostsTrackers >> /etc/hosts
sort -uf /etc/hosts > /etc/hosts.uniq && mv /etc/hosts{.uniq,}
echo "${OK}"
ufw deny out from any to 10.0.0.0/8

ufw deny out from any to 103.71.29.0/24

ufw deny out from any to 172.16.0.0/12

ufw deny out from any to 192.168.0.0/16

ufw deny out from any to 100.64.0.0/10

ufw deny out from any to 141.101.78.0/23

ufw deny out from any to 173.245.48.0/20

ufw deny out from any to 192.0.2.0/24

ufw deny out from any to 169.254.0.0/24

ufw deny out from any to 0.0.0.0/8

ufw deny out from any to 169.254.0.0/16

ufw deny out from any to 192.0.2.0/24

ufw deny out from any to 198.18.0.0/15

ufw deny out from any to 224.0.0.0/4

ufw deny out from any to 240.0.0.0/4

ufw deny out from any to 203.0.113.0/24 

ufw deny out from any to 224.0.0.0/3 

ufw deny out from any to 198.51.100.0/24 

ufw deny out from any to 192.88.99.0/24 

ufw deny out from any to 192.0.0.0/24

ufw deny out from any to 223.202.0.0/16

ufw deny out from any to 194.5.192.0/19

ufw deny out from any to 209.237.192.0/18

ufw deny out from any to 169.254.0.0/16

iptables -A OUTPUT -p tcp -s 0/0 -d 10.0.0.0/8 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 103.71.29.0/24 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 172.16.0.0/12 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 192.168.0.0/16 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 100.64.0.0/10 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 10.0.0.0/8 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 172.16.0.0/12 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 192.168.0.0/16 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 100.64.0.0/10 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 141.101.78.0/23 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 173.245.48.0/20 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 192.0.2.0/24 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 169.254.0.0/24 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 0.0.0.0/8 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 169.254.0.0/16 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 192.0.2.0/24 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 198.18.0.0/15 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 224.0.0.0/4 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 240.0.0.0/4 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 203.0.113.0/24 -j DROP 

iptables -A OUTPUT -p tcp -s 0/0 -d 224.0.0.0/3 -j DROP 

iptables -A OUTPUT -p tcp -s 0/0 -d 198.51.100.0/24 -j DROP 

iptables -A OUTPUT -p tcp -s 0/0 -d 192.88.99.0/24 -j DROP 

iptables -A OUTPUT -p tcp -s 0/0 -d 192.0.0.0/24 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 223.202.0.0/16 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 194.5.192.0/19 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 209.237.192.0/18 -j DROP

iptables -A OUTPUT -p tcp -s 0/0 -d 169.254.0.0/16 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 10.0.0.0/8 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 103.71.29.0/24 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 172.16.0.0/12 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 192.168.0.0/16 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 100.64.0.0/10 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 10.0.0.0/8 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 172.16.0.0/12 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 192.168.0.0/16 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 100.64.0.0/10 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 141.101.78.0/23 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 173.245.48.0/20 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 192.0.2.0/24 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 169.254.0.0/24 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 0.0.0.0/8 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 169.254.0.0/16 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 192.0.2.0/24 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 198.18.0.0/15 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 224.0.0.0/4 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 240.0.0.0/4 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 203.0.113.0/24 -j DROP 

iptables -A OUTPUT -p udp -s 0/0 -d 224.0.0.0/3 -j DROP 

iptables -A OUTPUT -p udp -s 0/0 -d 198.51.100.0/24 -j DROP 

iptables -A OUTPUT -p udp -s 0/0 -d 192.88.99.0/24 -j DROP 

iptables -A OUTPUT -p udp -s 0/0 -d 192.0.0.0/24 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 223.202.0.0/16 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 194.5.192.0/19 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 209.237.192.0/18 -j DROP

iptables -A OUTPUT -p udp -s 0/0 -d 169.254.0.0/16 -j DROP

iptables-save
ufw --force enable
clear
echo -e "  ${green}Server Optimized Successfully! ${White}"
