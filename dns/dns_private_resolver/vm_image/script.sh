#!/bin/sh
sudo apt update
        
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
        
sudo apt-get install bind9 -y

sudo rm /etc/bind/named.conf.options

sudo tee /etc/bind/named.conf.options << END
options {
        directory "/var/cache/bind";

        forwarders { 168.63.129.16; }; // IP Address of forwarder

        dnssec-enable yes; 
        dnssec-validation yes; 

        listen-on port 53 { any; }; 
        listen-on-v6 port 53 { ::1; }; 


        allow-query { any; };

        recursion yes;
};
END