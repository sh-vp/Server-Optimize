#!/bin/bash

red='\033[1;91m'          # Red
green='\033[1;92m'        # Green
yellow='\033[1;93m'       # Yellow
white='\033[1;97m'        # White
blue='\033[1;94m'         # blue
nc='\033[0m'              # no color

clear

# Paths
HOST_PATH="/etc/hosts"
DNS_PATH="/etc/resolv.conf"

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}Fatal error: ${yellow} Please run this script with root privilege !${nc}" && exit 1

# Check OS and set release variable
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    release=$ID
elif [[ -f /usr/lib/os-release ]]; then
    source /usr/lib/os-release
    release=$ID
else
    echo -e "${red}Failed to check the system OS, please contact the author!${nc}" >&2
    exit 1
fi
show_report(){

clear

echo -e "${blue}    ___         __           ____        __  _           _                 ${nc}"
echo -e "${blue}   /   | __  __/ /_____     / __ \____  / /_(_)___ ___  (_)___  ___  _____ ${nc}"
echo -e "${blue}  / /| |/ / / / __/ __ \   / / / / __ \/ __/ / __ \`__ \/ /_  / / _ \/ ___/${nc}"
echo -e "${blue} / ___ / /_/ / /_/ /_/ /  / /_/ / /_/ / /_/ / / / / / / / / /_/  __/ /     ${nc}"
echo -e "${blue}/_/  |_\__,_/\__/\____/   \____/ .___/\__/_/_/ /_/ /_/_/ /___/\___/_/      ${nc}"
echo -e "${blue}                              /_/                                          ${nc}"
echo -e ""
echo -e "${red}=========================================================================== ${nc}"
echo -e ""
echo -e "${yellow}  https://github.com/sh-vp/Server-Optimize${nc}"
echo -e ""
echo -e "${green}  Author: Shadow-dev ${nc}"
echo -e ""
echo -e "${red}=================================================${nc}"
echo -e ""
echo -e "${red}  Server ${green}Optimized Successfully !${nc}"
echo -e ""
echo -e "${red}  # ${green}Install Important Packages !${nc}"
echo -e "${red}  # ${green}Set TimeZone !${nc}"
echo -e "${red}  # ${green}Fix Hosts File !${nc}"
echo -e "${red}  # ${green}Fix Dns Nameservers !${nc}"
echo -e "${red}  # ${green}Block Local Ip's For Control Netscan Attack !${nc}"
echo -e "${red}  # ${green}Enable BBR !${nc}"
echo -e ""
}

blockscan(){
    
echo -e "${yellow}Fixing Network Scan Abuse...${nc}"
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

    case "${release}" in
    centos | almalinux | rocky | fedora )
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="10.0.0.0/8" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="103.71.29.0/24" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="172.16.0.0/12" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.0.0/16" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="100.64.0.0/10" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="141.101.78.0/23" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="173.245.48.0/20" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="192.0.2.0/24" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="169.254.0.0/24" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="0.0.0.0/8" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="169.254.0.0/16" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="192.0.2.0/24" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="198.18.0.0/15" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="224.0.0.0/4" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="240.0.0.0/4" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="203.0.113.0/24" reject' 
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="224.0.0.0/3" reject' 
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="198.51.100.0/24" reject' 
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="192.88.99.0/24" reject' 
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="192.0.0.0/24" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="223.202.0.0/16" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="194.5.192.0/19" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="209.237.192.0/18" reject'
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="169.254.0.0/16" reject'
firewall-cmd --reload
        ;;
    ubuntu | debian )
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
ufw reload
        ;;
        *)
echo -e "${red}The firewall compatible with your operating system was not found!${nc}"
        ;;
    esac
iptables -A OUTPUT -p tcp -s 0/0 -d 10.0.0.0/8 -j DROP
iptables -A OUTPUT -p tcp -s 0/0 -d 103.71.29.0/24 -j DROP
iptables -A OUTPUT -p tcp -s 0/0 -d 172.16.0.0/12 -j DROP
iptables -A OUTPUT -p tcp -s 0/0 -d 192.168.0.0/16 -j DROP
iptables -A OUTPUT -p tcp -s 0/0 -d 100.64.0.0/10 -j DROP
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
sudo /sbin/iptables-save >> /dev/null

echo -e "${green}Netscan Abuse Fixed !${nc}"
}

# Install dependencies
install_dependencies() {

echo -e "${white}The OS release is: $release${nc}"
echo -e "${yellow}Installing Dependencies...${nc}"
sleep 0.5

    # Check the OS and install necessary packages
    case "${release}" in
    ubuntu | debian | armbian)
        apt-get update -y && apt-get install ufw iptables ipset wget jq sudo -y -q
        echo -e "${green}Dependencies Installed ! ${nc}"
        ;;
    centos | almalinux | rocky | ol | fedora | amzn)
        dnf update -y && dnf install firewalld iptables ipset wget jq -y -q 
        echo -e "${green}Dependencies Installed ! ${nc}"
        ;;
    *)
        echo -e "${red}Unsupported operating system. Please check the script and install the necessary packages manually.${nc}\n"
        exit 1
        ;;
    esac
  sleep 0.5
}

# Fix Hosts file
fix_etc_hosts(){ 
  echo -e "${yellow}Fixing Hosts file...${nc}"
  sleep 0.5

  cp $HOST_PATH /etc/hosts.bak
  echo -e "${yellow}Default hosts file saved. Directory: /etc/hosts.bak${nc}"
  sleep 0.5

  if ! grep -q $(hostname) $HOST_PATH; then
    echo "127.0.1.1 $(hostname)" | sudo tee -a $HOST_PATH > /dev/null
    echo -e "${green}Local Host Fixed !${nc}"
    sleep 0.5
  elif ! grep -q "185.199.108.133 raw.githubusercontent.com" $HOST_PATH; then
    echo "185.199.108.133 raw.githubusercontent.com" | sudo tee -a $HOST_PATH > /dev/null
    echo -e "${green}Github Host Fixed !${nc}"
    sleep 0.5
  else
    echo -e "${green}Hosts OK. No changes made !${nc}"
    sleep 0.5
  fi
}

#Enable BBR
enable_bbr() {
    if grep -q "net.core.default_qdisc=fq" /etc/sysctl.conf && grep -q "net.ipv4.tcp_congestion_control=bbr" /etc/sysctl.conf; then
        echo -e "${green}BBR is already enabled!${nc}"
        before_show_menu
    fi

    # Check the OS and install necessary packages
    case "${release}" in
    ubuntu | debian | armbian)
        apt-get -y update && apt-get install -yqq --no-install-recommends ca-certificates
        ;;
    centos | almalinux | rocky | ol | fedora | amzn)
        dnf -y update && dnf -y install ca-certificates
        ;;
    *)
        echo -e "${red}Unsupported operating system. Please check the script and install the necessary packages manually.${nc}\n"
        exit 1
        ;;
    esac

    # Enable BBR
    echo "net.core.default_qdisc=fq" | tee -a /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" | tee -a /etc/sysctl.conf

    # Apply changes
    sysctl -p

    # Verify that BBR is enabled
    if [[ $(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}') == "bbr" ]]; then
        echo -e "${green}BBR has been enabled successfully.${nc}"
    else
        echo -e "${red}Failed to enable BBR. Please check your system configuration.${nc}"
    fi
}

# Fix DNS Temporarly
fix_dns(){
    echo -e "${yellow}Fixing DNS Temporarily...${nc}"
    sleep 0.5

    cp $DNS_PATH /etc/resolv.conf.bak
    echo -e "${yellow}Default resolv.conf file saved. Directory: /etc/resolv.conf.bak${nc}"
    sleep 0.5

    sed -i '/nameserver/d' $DNS_PATH

    echo "nameserver 8.8.8.8" >> $DNS_PATH
    echo "nameserver 1.1.1.1" >> $DNS_PATH

    echo -e "${green}DNS Fixed Temporarily !${nc}"
    sleep 0.5
}


# Set the server TimeZone to the VPS IP address location.
set_timezone() {
    echo -e "${yellow}Setting TimeZone based on VPS IP address...${nc}"
    sleep 0.5

    get_location_info() {
        local ip_sources=("https://ipv4.icanhazip.com" "https://api.ipify.org" "https://ipv4.ident.me/")
        local location_info

        for source in "${ip_sources[@]}"; do
            local ip=$(curl -s "$source")
            if [ -n "$ip" ]; then
                location_info=$(curl -s "http://ip-api.com/json/$ip")
                if [ -n "$location_info" ]; then
                    echo "$location_info"
                    return 0
                fi
            fi
        done

        echo -e "${red}Error: Failed to fetch location information from known sources. Setting timezone to UTC.${nc}"
        sudo timedatectl set-timezone "UTC"
        return 1
    }

    # Fetch location information from three sources
    location_info_1=$(get_location_info)
    location_info_2=$(get_location_info)
    location_info_3=$(get_location_info)

    # Extract timezones from the location information
    timezones=($(echo "$location_info_1 $location_info_2 $location_info_3" | jq -r '.timezone'))

    # Check if at least two timezones are equal
    if [[ "${timezones[0]}" == "${timezones[1]}" || "${timezones[0]}" == "${timezones[2]}" || "${timezones[1]}" == "${timezones[2]}" ]]; then
        # Set the timezone based on the first matching pair
        timezone="${timezones[0]}"
        sudo timedatectl set-timezone "$timezone"
        echo -e "${green}Timezone set to $timezone${nc}"
    else
        echo -e "${red}Error: Failed to fetch consistent location information from known sources. Setting timezone to UTC.${nc}"
        sudo timedatectl set-timezone "UTC"
    fi
    sleep 0.5
}


## Run

#install Dependencies
install_dependencies
sleep 0.5

# Fix Hosts file
fix_etc_hosts
sleep 0.5

# Fix DNS
fix_dns
sleep 0.5

# Timezone
set_timezone
sleep 0.5

# BlockNetScan
blockscan
sleep 0.5

# Install bbr
enable_bbr
sleep 0.5

#Show report
show_report
