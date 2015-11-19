---
layout: post
title: Raspberry Pi 上手
published: true
---

从公司拿来一台树莓派折腾玩，下面记录一下折腾的的过程吧。

# 买 SD 卡装系统

京东买了个 [Sandisk 16G卡](http://item.jd.com/1875996.html)，插在读卡器上就可以用了。官网下载 [RASPBIAN JESSIE](https://www.raspberrypi.org/downloads/raspbian/)，
装好之后懒得接显示器，nmap 查一下 ip， ssh pi@<ip>，密码是 raspberry。配了 192.168.1.233 这个静态 ip，这样以后就可以直接连了233。

# 连接显示器

HDMI连上我的 Dell U2312HM 显示器，居然没反应。。还好搜到[解决方法](http://www.chriszh.com/?p=562)

> 在网上找了一下，说是将/boot/config.txt的HDMI_SAFE的注释删掉就好了，于是照做。发现显示器能亮了，但是只有640*480的分辨率。再经过若干折腾，发现将HDMI_SAFE还是注掉，将hdmi_force_hotplug=1打开就可以完美1080p了。不过用hdmi接电视的时候需要再关上。

# USB网卡

开始折腾的时间到了。。买了个[TP-LINK TL-WN821N 300M无线USB网卡](http://item.jd.com/123836.html)，插上去之后 lsusb 没识别。

```
pi@raspberrypi ~ $ lsusb
Bus 001 Device 004: ID 0bda:818b Realtek Semiconductor Corp.
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514 Fast Ethernet Adapter
Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

能搜到需要 rtl8192eu 驱动，谢天谢地有人编译好了，从[百度贴吧](http://tieba.baidu.com/p/4161599392)找到的链接：
https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=124509&p=835823&hilit=8192eu#p835823

根据规则从 Dropbox 下载就好了，好幸福。。就怕他以后不更新了，不敢升级系统了。。

# 路由器
参考这篇文章把树莓派搞成AP吧：

http://jacobsalmela.com/raspberry-pi-and-routing-turning-a-pi-into-a-router/

注意 hostapd 不能用 debian 自带的，需要自己编译，我直接用的 master 分支，参考：http://www.jenssegers.be/43/realtek-rtl8188-based-access-point-on-raspberry-pi

hostapd.conf
```
# Basic configuration

interface=wlan0
ssid=RPiAP
channel=7
#bridge=br0

# WPA and WPA2 configuration

macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=12345678
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP

# Hardware configuration

driver=rtl871xdrv
ieee80211n=1
hw_mode=g
device_name=RTL8192CU
manufacturer=Realtek
```

```
pi@raspberrypi ~ $ cat /etc/dnsmasq.conf | grep -v "#" | sed '/^$/d'
domain-needed
interface=wlan0
listen-address=127.0.0.1,192.168.2.1
dhcp-range=192.168.2.20,192.168.2.200,12h
```

```
pi@raspberrypi ~ $ cat /etc/network/interfaces
# Please note that this file is written to be used with dhcpcd.
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'.

auto lo
iface lo inet loopback

auto eth0
allow-hotplug eth0
#iface eth0 inet manual
iface eth0 inet static
address 192.168.1.233
netmask 255.255.255.0
network 192.168.1.0
broadcast 192.168.1.255
gateway 192.168.1.1

allow-hotplug wlan0
iface wlan0 inet static
	address 192.168.2.1
	netmask 255.255.255.0
	network 192.168.2.0
	gateway 192.168.2.1
```

iptables 配置参考这篇文章：http://liberize.me/tech/turn-raspberry-pi-into-a-router.html

```
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
```

Done! Have fun!
