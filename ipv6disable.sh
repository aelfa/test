#!/bin/bash
# ip6tables single-host firewall script
# Define your command variables
ipt6="/usr/sbin/ip6tables"
# Flush all rules and delete all chains
# for a clean startup
$ipt6 -F
$ipt6 -X 
# Zero out all counters
$ipt6 -Z

# Default policies: deny all incoming
# Unrestricted outgoing

$ipt6 -P INPUT DROP
$ipt6 -P FORWARD DROP
$ipt6 -P OUTPUT ACCEPT

# Must allow loopback interface
$ipt6 -A INPUT -i lo -j ACCEPT

# Reject connection attempts not initiated from the host
$ipt6 -A INPUT -p tcp --syn -j DROP

# Allow return connections initiated from the host
$ipt6 -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Accept all ICMP v6 packets
$ipt6 -A INPUT -p ipv6-icmp -j ACCEPT

# Allow connections from SSH clients
$ipt6 -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT

# Allow HTTP and HTTPS traffic 
$ipt6 -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
$ipt6 -A INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT

