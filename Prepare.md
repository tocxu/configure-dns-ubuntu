#Model
 
* Some servers that are running in the same datacenter and have private networking enabled
* A new VPS to server as the Primary DNS server, ns1
* Optional: A new VPS to server as a Secondary DNS server, ns2
* Root access to all of the above 

#Example hosts
* We have two existing VPS called "host1" and "host2"
* Both VPS exist in the nyc3 datacenter 
* Both VPS have private networking enabled (and are on the 10.128.0.0/16 subnet)
* Both VPS are somehow related to our web application that runs on "example.com"

"nyc3.example.com" to refer to our private subnet or zone.
host1's private Fully-Qualified Domain Name(FDQN) will be "host1.nyc3.example.com"
Host   	Role   		Private FQDN    	Private IP Address
host1 	Generic Host 1	host1.nyc3.example.com	10.128.100.101
host2	Generic Host 2	host2.nyc3.example.com	10.128.200.102

#By the end
We will have a primary DNS server ns1, optionally a secondary DNS server ns2, which will server as a backup


Host  Role		    Prvate FQDN		     Private IP Address
ns1   primary DNS Server    ns1.nyc3.example.com     10.128.10.11
ns2   Secondary DNS Server  ns2.nyc3.example.com     10.128.20.12




 


