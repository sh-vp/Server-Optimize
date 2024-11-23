# Server Optimizer Script !



- Update Server and Install Important Packages

- System Updated & Cleaned

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

#To open each of the internal IPs to use the tunnel, use the following commands with what Local Ip you want:

```
iptables -A OUTPUT -p tcp -s 0/0 -d YOUR_LOCAL_IP -j ACCEPT 
 ``` 
