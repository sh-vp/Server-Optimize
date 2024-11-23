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
SYS_PATH="/etc/sysctl.conf"
PROF_PATH="/etc/profile"
SSH_PORT=""
SSH_PATH="/etc/ssh/sshd_config"
SWAP_PATH="/swapfile"
SWAP_SIZE=2G
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
show_header(){

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
echo -e "${green}  Server ${red}Optimized ${green}Successfully !${nc}"
echo -e "${red}  -------------------------------${nc}"
echo -e ""
echo -e "${red}  # ${green}Install Important Packages !${nc}"
echo -e "${red}  # ${green}System Updated & Cleaned !${nc}"
echo -e "${red}  # ${green}Set TimeZone !${nc}"
echo -e "${red}  # ${green}Fix Hosts File !${nc}"
echo -e "${red}  # ${green}Torrent Access Blocked !${nc}"
echo -e "${red}  # ${green}Fix Dns Nameservers !${nc}"
echo -e "${red}  # ${green}NetScan Protection Enabled !${nc}"
echo -e "${red}  # ${green}TCP BBR Enabled !${nc}"
echo -e ""
echo -e "${red}  -------------------------------${nc}"
echo -e ""
}

# Ask Reboot
reboot_server() {
    read -p "  -> Do you want to Reboot Server now (y/n)? (Recommended) : " yn
        [ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
 	echo -e ""
	echo -e "${blue} VPS reboot in progress...${nc}"
        reboot
	else
 	exit 1
	fi
}
# Update & Upgrade & Remove & Clean
complete_update() {
    echo -e "${yellow}Updating the System... (This can take a while.)${nc}"
    sleep 0.5

    sudo apt -q update
    sudo apt -y upgrade
    sudo apt -y full-upgrade
    sudo apt -y autoremove
    sleep 0.5
    sudo apt -y -q autoclean
    sudo apt -y clean
    sudo apt -q update
    sudo apt -y upgrade
    sudo apt -y full-upgrade
    sudo apt -y autoremove --purge

    echo -e "${green}System Updated & Cleaned Successfully.${nc}"
    sleep 0.5
}
# Swap Maker
swap_maker() {
    echo -e "${yellow}Making SWAP Space...${nc}"
    sleep 0.5

    ## Make Swap
    sudo fallocate -l $SWAP_SIZE $SWAP_PATH  ## Allocate size
    sudo chmod 600 $SWAP_PATH                ## Set proper permission
    sudo mkswap $SWAP_PATH                   ## Setup swap         
    sudo swapon $SWAP_PATH                   ## Enable swap
    echo "$SWAP_PATH   none    swap    sw    0   0" >> /etc/fstab ## Add to fstab
    echo -e "${green}SWAP Created Successfully.${nc}"
    sleep 0.5
}

# Optimize system configuration
sysctl_optimizations() {
    ## Make a backup of the original sysctl.conf file
    cp $SYS_PATH /etc/sysctl.conf.bak

    echo -e "${yellow}Default sysctl.conf file Saved. Directory: /etc/sysctl.conf.bak${nc}"
    sleep 1

    echo -e "${yellow}Optimizing the Network...${nc}"
    sleep 0.5

    sed -i -e '/fs.file-max/d' \
        -e '/net.core.default_qdisc/d' \
        -e '/net.core.netdev_max_backlog/d' \
        -e '/net.core.optmem_max/d' \
        -e '/net.core.somaxconn/d' \
        -e '/net.core.rmem_max/d' \
        -e '/net.core.wmem_max/d' \
        -e '/net.core.rmem_default/d' \
        -e '/net.core.wmem_default/d' \
        -e '/net.ipv4.tcp_rmem/d' \
        -e '/net.ipv4.tcp_wmem/d' \
        -e '/net.ipv4.tcp_congestion_control/d' \
        -e '/net.ipv4.tcp_fastopen/d' \
        -e '/net.ipv4.tcp_fin_timeout/d' \
        -e '/net.ipv4.tcp_keepalive_time/d' \
        -e '/net.ipv4.tcp_keepalive_probes/d' \
        -e '/net.ipv4.tcp_keepalive_intvl/d' \
        -e '/net.ipv4.tcp_max_orphans/d' \
        -e '/net.ipv4.tcp_max_syn_backlog/d' \
        -e '/net.ipv4.tcp_max_tw_buckets/d' \
        -e '/net.ipv4.tcp_mem/d' \
        -e '/net.ipv4.tcp_mtu_probing/d' \
        -e '/net.ipv4.tcp_notsent_lowat/d' \
        -e '/net.ipv4.tcp_retries2/d' \
        -e '/net.ipv4.tcp_sack/d' \
        -e '/net.ipv4.tcp_dsack/d' \
        -e '/net.ipv4.tcp_slow_start_after_idle/d' \
        -e '/net.ipv4.tcp_window_scaling/d' \
        -e '/net.ipv4.tcp_adv_win_scale/d' \
        -e '/net.ipv4.tcp_ecn/d' \
        -e '/net.ipv4.tcp_ecn_fallback/d' \
        -e '/net.ipv4.tcp_syncookies/d' \
        -e '/net.ipv4.udp_mem/d' \
        -e '/net.ipv6.conf.all.disable_ipv6/d' \
        -e '/net.ipv6.conf.default.disable_ipv6/d' \
        -e '/net.ipv6.conf.lo.disable_ipv6/d' \
        -e '/net.unix.max_dgram_qlen/d' \
        -e '/vm.min_free_kbytes/d' \
        -e '/vm.swappiness/d' \
        -e '/vm.vfs_cache_pressure/d' \
        -e '/net.ipv4.conf.default.rp_filter/d' \
        -e '/net.ipv4.conf.all.rp_filter/d' \
        -e '/net.ipv4.conf.all.accept_source_route/d' \
        -e '/net.ipv4.conf.default.accept_source_route/d' \
        -e '/net.ipv4.neigh.default.gc_thresh1/d' \
        -e '/net.ipv4.neigh.default.gc_thresh2/d' \
        -e '/net.ipv4.neigh.default.gc_thresh3/d' \
        -e '/net.ipv4.neigh.default.gc_stale_time/d' \
        -e '/net.ipv4.conf.default.arp_announce/d' \
        -e '/net.ipv4.conf.lo.arp_announce/d' \
        -e '/net.ipv4.conf.all.arp_announce/d' \
        -e '/kernel.panic/d' \
        -e '/vm.dirty_ratio/d' \
        -e '/^#/d' \
        -e '/^$/d' \
        "$SYS_PATH"

cat <<EOF >> "$SYS_PATH"

fs.file-max = 67108864
net.core.default_qdisc = fq_codel
net.core.netdev_max_backlog = 32768
net.core.optmem_max = 262144
net.core.somaxconn = 65536
net.core.rmem_max = 33554432
net.core.rmem_default = 1048576
net.core.wmem_max = 33554432
net.core.wmem_default = 1048576
net.ipv4.tcp_rmem = 16384 1048576 33554432
net.ipv4.tcp_wmem = 16384 1048576 33554432
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_fin_timeout = 25
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_probes = 7
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_max_orphans = 819200
net.ipv4.tcp_max_syn_backlog = 20480
net.ipv4.tcp_max_tw_buckets = 1440000
net.ipv4.tcp_mem = 65536 1048576 33554432
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_notsent_lowat = 32768
net.ipv4.tcp_retries2 = 8
net.ipv4.tcp_sack = 1
net.ipv4.tcp_dsack = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_adv_win_scale = -2
net.ipv4.tcp_ecn = 1
net.ipv4.tcp_ecn_fallback = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.udp_mem = 65536 1048576 33554432
net.ipv6.conf.all.disable_ipv6 = 0
net.ipv6.conf.default.disable_ipv6 = 0
net.ipv6.conf.lo.disable_ipv6 = 0
net.unix.max_dgram_qlen = 256
vm.min_free_kbytes = 65536
vm.swappiness = 10
vm.vfs_cache_pressure = 250
net.ipv4.conf.default.rp_filter = 2
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.neigh.default.gc_thresh1 = 512
net.ipv4.neigh.default.gc_thresh2 = 2048
net.ipv4.neigh.default.gc_thresh3 = 16384
net.ipv4.neigh.default.gc_stale_time = 60
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_announce = 2
kernel.panic = 1
vm.dirty_ratio = 20


EOF

    sudo sysctl -p
    
    echo -e "${green}Network is Optimized.${nc}"
    sleep 0.5
}


# Function to find the SSH port and set it in the SSH_PORT variable
find_ssh_port() {
    echo -e "${yellow}Finding SSH port..."
    
    ## Check if the SSH configuration file exists
    if [ -e "$SSH_PATH" ]; then
        ## Use grep to search for the 'Port' directive in the SSH configuration file
        SSH_PORT=$(grep -oP '^Port\s+\K\d+' "$SSH_PATH" 2>/dev/null)

        if [ -n "$SSH_PORT" ]; then
            echo -e "${green}SSH port found: $SSH_PORT${nc}"
            sleep 0.5
        else
            echo 
            echo -e "${green}SSH port is default 22.${nc}"
            echo 
            SSH_PORT=22
            sleep 0.5
        fi
    else
        echo -e "${red}SSH configuration file not found at $SSH_PATH${nc}"
    fi
}

# Remove old SSH config to prevent duplicates.
remove_old_ssh_conf() {
    ## Make a backup of the original sshd_config file
    cp $SSH_PATH /etc/ssh/sshd_config.bak

    echo -e "${yellow}Default SSH Config file Saved. Directory: /etc/ssh/sshd_config.bak${nc}"
    sleep 1

    ## Remove these lines
    sed -i -e 's/#UseDNS yes/UseDNS no/' \
        -e 's/#Compression no/Compression yes/' \
        -e 's/Ciphers .*/Ciphers aes256-ctr,chacha20-poly1305@openssh.com/' \
        -e '/MaxAuthTries/d' \
        -e '/MaxSessions/d' \
        -e '/TCPKeepAlive/d' \
        -e '/ClientAliveInterval/d' \
        -e '/ClientAliveCountMax/d' \
        -e '/AllowAgentForwarding/d' \
        -e '/AllowTcpForwarding/d' \
        -e '/GatewayPorts/d' \
        -e '/PermitTunnel/d' \
        -e '/X11Forwarding/d' "$SSH_PATH"

}
# Update SSH config
update_sshd_conf() {
    echo -e "${yellow}Optimizing SSH...${nc}"
    sleep 0.5
    echo "TCPKeepAlive yes" | tee -a "$SSH_PATH"
    echo "ClientAliveInterval 3000" | tee -a "$SSH_PATH"
    echo "ClientAliveCountMax 100" | tee -a "$SSH_PATH"
    echo "AllowAgentForwarding yes" | tee -a "$SSH_PATH"
    echo "AllowTcpForwarding yes" | tee -a "$SSH_PATH"
    echo "GatewayPorts yes" | tee -a "$SSH_PATH"
    echo "PermitTunnel yes" | tee -a "$SSH_PATH"
    echo "X11Forwarding yes" | tee -a "$SSH_PATH"
    sudo systemctl restart ssh

    echo -e "${green}SSH is Optimized.${nc}"
    sleep 0.5
}

block_torrent() {
    echo -e "${yellow}Blocking torrent access...${nc}"
    iptables -A OUTPUT -p tcp --dport 6881:6889 -j REJECT
    iptables -A OUTPUT -p udp --dport 6881:6889 -j REJECT
    iptables -A OUTPUT -p tcp --dport 6969 -j REJECT
    iptables -A OUTPUT -p udp --dport 6969 -j REJECT
    iptables -A OUTPUT -p udp --dport 4444 -j REJECT
    iptables -A OUTPUT -p udp --dport 8999 -j REJECT
    iptables -A OUTPUT -p udp -m string --string "announce" --algo bm -j REJECT
    iptables -A OUTPUT -p udp --dport 443 -j REJECT
    echo -e "${green}Torrent access has been blocked completely.${nc}"
}

block_net_scan(){
    
echo -e "${yellow}Enabling NetScan protection...${nc}"

    iptables -N PORTSCAN
    iptables -A PORTSCAN -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 4 -j RETURN
    iptables -A PORTSCAN -j DROP
    iptables -A INPUT -p tcp --tcp-flags SYN,ACK,FIN,RST RST -j PORTSCAN
    iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
    
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

echo -e "${green}NetScan Protection Enabled !${nc}"
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
else
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
block_net_scan
sleep 0.5

# Block Torrent
block_torrent
sleep 0.5

# Install bbr
enable_bbr
sleep 2

#complete update
complete_update
sleep 0.5

#Show report
show_header
sleep 0.5

#reboot
reboot_server
