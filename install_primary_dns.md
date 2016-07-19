#Cài đặt
##Bước 1: cập nhật repository trên Ubuntu
> sudo apt-get update

##Bước 2: Cài đặt bìn9
> sudo apt-get install bind9 bind9-doc bind9utils


#Tiếp theo là bước cấu hình
**Caching nameserver**
Caching nameserver sẽ ghi nhớ các truy vấn DNS lần đầu, những lần truy vấn sau sẽ được lấy từ cache của máy local

##Bước 3:
Mở file /etc/bind/named.conf.options
Chỉnh sửa nội dung file như sau:

> forwarders{
>	8.8.8.8;
>	8.8.4.4;
> };

Hai địa chỉ trên là của máy chủ DNS google 

##Bước 4: Khởi động service 
> sudo service bind9 restart 

##Bước 5: 
kiểm tra dùng lệnh dig. Mở file /etc/resolv.conf và sửa địa chỉ IP nameserver bằng địa chỉ IP cụ thể mà máy tính bạn đang dùng

> nameserver 127.0.0.1

Dùng lệnh sau để truy vấn:
> dig www.ten.com

#Cấu hình Primary master:
Cấu hình Primary master giống như quản lý các bản ghi DNS cho từng tên miền 
> Domain name: ten.com
> Server ip: 192.168.6.5
> Server hostname: ns.ten.com
> Website ip; 192.168.6.10 (www.ten.com)

Chúng ta cần tạo 2 zone file gồm: Forward zone(Ánh xạ từ tên miền sang IP) và Reverse zone (Ánh xạ từ IP sang tên miền)

**Tập tin forward Zone**
##Bước 6:
Tạo forward zone bằng cách sao chép tập tin db.local
> sudo cp/etc/bind/db.local /etc/bind/db.ten.com

##Bước 7: 
Chỉnh nội dung file /etc/bind/db.ten.com 


> sudo cp /etc/bind/db.local /etc/bind/db.ten.com
> ; BIND data file for local loopback interface
> ;
> $TTL    604800
> @ IN SOA ns.ten.com. root.ns.ten.com. (
>                              2         ; Serial
>                        604800         ; Refresh
>                         86400         ; Retry
>                       2419200         ; Expire
>                         604800 )       ; Negative Cache TTL
> ;
> @       IN      NS      ns.ten.com.
> @       IN      A       192.168.6.5
> @       IN      AAAA    ::1
> ns      IN      A       192.168.6.5
> www     IN    A    192.168.6.10
 
**Tạo tập tin Reverse Zone**
##Bước 7:
Tạo db.192 bằng cách sao chép db.127
> sudo cp /etc/bind/db.127 /etc/bind/db.192

##Bước 8: 
Chỉnh sửa file /etc/bind/db.192

> ; BIND reverse data file for local loopback interface
> ;
> $TTL    604800
> @ IN SOA ns.ten.com. root.ns.ten.com. (
>                              1         ; Serial
>                        604800         ; Refresh
>                          86400         ; Retry
>                        2419200         ; Expire
>                         604800 )       ; Negative Cache TTL
> ;
> @      IN      NS      ns.
> 5      IN      PTR     ns.chuyengiait.com.
> 10     IN      PTR     www.chuyengiait.com.

##Bước 9:
Cấu hinh /etc/bind/named.conf.local, thêm các dòng sau vào tập tin forward zone và reverse zone
> // Forward zone
> zone "ten.com" {
>	type master;
>	file "/etc/bind/db.ten.com";
> };
> //Reverse zone
> zone "6.168.192.in-addr.arpa" {
>	type master;
>	file "/etc/bind/db.192";
> };

##Bước 10: Khởi động service 
> sudo service bind9 restart 

##Bước 11: Kiểm tra

> nslookup www.ten.com


sẽ hiện ra 
> Server: Ip
> Address: ip#..
> Name: www.ten.com
> Address: 192.168.6.10


test reverse lookup
> nslookup 172.27.6.10

trả về:
> Server: 127.0.0.1
> Address: 127.0.0.1
> 10.6.27.172.in-addr.arpa name=www.ten.com 




