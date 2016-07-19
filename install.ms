>apt-get update
>apt-get install bind9 bind9utils bind9-doc

#IPv4 Mode 

>sudo vim /etc/default/bind9

add "-4" to the OPTIONS variable. it should look like the following:
> OPTIONS="-4 -u bind"



