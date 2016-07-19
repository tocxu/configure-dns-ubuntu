BIND's configuration consists of multiple files, which are included from the main configuation file, named.conf
# Confiure Options File

On ns1, open the *named.conf.options* file for editing:
> sudo vi /etc/bind/named.conf.options

Above the existing >options  block, create a new ACL block called "trusted". This is where we will define list of clients that we will allow recursive DNS queries from (i.e your servers that are in the same datacenter as ns1)

>	/etc/bind/named.conf.options-1 of 3

>acl "trusted" {

>		10.128.10.11; #ns1 - can be set to localhost

>	10.128.20.12; #ns2

>	10.128.100.102; #host1

>	10.128.200.102; #host2

}>;

Now that we have our list of trusted DNS Clients, we will want to edit the options block. Currently, the start of the block looks like the following:
>		/etc/bing/named.conf.options -2 of 3

>options {

>	directory "/var/cache/bind";

>...

>};

Below the directory diretory, add the highlighted congiguration lines (and substiture in the proper ns1 IP address) so it looks something like this:

>	/etc/bind/named.conf.options -3 of 3

>options {

>	directory "/var/cache/bind";

>

>	recursion yes; #enables recusive queries 

>	allow-recursion {trusted;}; #allows recursive queries from "trusted" clients

>	listen-on {10.128.10.11;}; #ns1 private IP address - listen on private network only

>	allow-transfers {none;}; # disable zone transfers by default 

>

>	forwarders{

>		8.8.8.8;

>		8.8.4.4;

>	};

>..

>};


#Configure Local File
on ns1, open the named.conf.local
>sudo vim /etc/bind/named.conf.local

>	/etc/bind/named.conf.local - 1of2

>zone "ncy3.example.com" {

>	type master;

>	file "/etc/bind/zones/db.nyc3.example.com"; #zone file path

>	allow-transfer {10.128.20.12;}; #ns2 private IP address - secondary

>};

#Create Forward Zone File


