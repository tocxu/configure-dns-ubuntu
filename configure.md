BIND's configuration consists of multiple files, which are included from the main configuation file, named.conf
# Confiure Options File

On ns1, open the *named.conf.options* file for editing:
> sudo vi /etc/bind/named.conf.options

Above the existing >options  block, create a new ACL block called "trusted". This is where we will define list of clients that we will allow recursive DNS queries from (i.e your servers that are in the same datacenter as ns1)

>	/etc/bind/named.conf.options-1 of 3
acl "trusted" {
	10.128.10.11; #ns1 - can be set to localhost
	10.128.20.12; #ns2
	10.128.100.102; #host1
	10.128.200.102; #host2
};


