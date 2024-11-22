# Server Optimizer Script !



- Update Server and Install Important Packages
 
- Optimized Network

- Set TimeZone

- Fix Hosts File (Github & LocalHost)

- Fix Dns Nameservers

- NetScan protection

- Block Torrent Access

- Enable TCP BBR


#Copy Below Code and Paste it on Your Server :

```
bash <(curl -Ls https://raw.githubusercontent.com/sh-vp/Server-Optimize/main/optimizer.sh)
```

#To open each of the internal IPs to use the tunnel, use the following commands :

```
iptables -A OUTPUT -p tcp -s 0/0 -d 10.0.0.0/8 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 103.71.29.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 172.16.0.0/12 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 192.168.0.0/16 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 100.64.0.0/10 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 141.101.78.0/23 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 173.245.48.0/20 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 192.0.2.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 169.254.0.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 0.0.0.0/8 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 169.254.0.0/16 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 192.0.2.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 198.18.0.0/15 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 224.0.0.0/4 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 240.0.0.0/4 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 203.0.113.0/24 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p tcp -s 0/0 -d 224.0.0.0/3 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p tcp -s 0/0 -d 198.51.100.0/24 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p tcp -s 0/0 -d 192.88.99.0/24 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p tcp -s 0/0 -d 192.0.0.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 223.202.0.0/16 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 194.5.192.0/19 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 209.237.192.0/18 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p tcp -s 0/0 -d 169.254.0.0/16 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 10.0.0.0/8 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 103.71.29.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 172.16.0.0/12 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 192.168.0.0/16 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 100.64.0.0/10 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 141.101.78.0/23 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 173.245.48.0/20 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 192.0.2.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 169.254.0.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 0.0.0.0/8 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 169.254.0.0/16 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 192.0.2.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 198.18.0.0/15 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 224.0.0.0/4 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 240.0.0.0/4 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 203.0.113.0/24 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p udp -s 0/0 -d 224.0.0.0/3 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p udp -s 0/0 -d 198.51.100.0/24 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p udp -s 0/0 -d 192.88.99.0/24 -j ACCEPT 
 ``` 
 ``` 
iptables -A OUTPUT -p udp -s 0/0 -d 192.0.0.0/24 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 223.202.0.0/16 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 194.5.192.0/19 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 209.237.192.0/18 -j ACCEPT 
 ``` 
 ```
iptables -A OUTPUT -p udp -s 0/0 -d 169.254.0.0/16 -j ACCEPT 
 ``` 
