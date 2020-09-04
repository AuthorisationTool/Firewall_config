#!/bin/bash

#sudo apt install -y ipset
#sudo ipset create whitelist

sudo iptables -F

sudo iptables -t nat -F

sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

sudo iptables -t nat -A PREROUTING -m set --match-set whitelist src \
-p tcp --dport 80 -j DNAT --to 192.168.1.108:80

sudo iptables -A FORWARD -m set --match-set whitelist src \
-p tcp --dport 80 -d 192.168.1.108 -j ACCEPT

sudo iptables -t nat -A POSTROUTING -m set --match-set whitelist src \
-p tcp --dport 80 -d 192.168.1.108 -j SNAT --to-source 192.168.1.109

