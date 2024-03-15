---
layout: post
title: Common Network Sniffing Tools
date: 2018-07-31 18:08 -0300
categories: [tools, offensive_security]
tags: [ offensive security, cheat sheet, sniffing, mitm, arp]
---

![Image of Wireshark](/uploads/Screenshot%20from%202018-08-01%2000-48-07.png)

In this article, I am going to list (not explain) some common packet sniffers and network analyzers that you can use now in any man-in-the-middle attack (MITM).

What you have to keep in mind, is that there is no perfect tool for doing the perfect MITM attack and you will have to adapt your technics in order to better match your objectives.

## DSNIFF

[https://www.monkey.org/~dugsong/dsniff/](https://www.monkey.org/~dugsong/dsniff/)

dsniff is a collection of tools for network auditing and penetration testing. dsniff, filesnarf, mailsnarf, msgsnarf, urlsnarf, and webspy passively monitor a network for interesting data (passwords, e-mail, files, etc.). arpspoof, dnsspoof, and macof facilitate the interception of network traffic normally unavailable to an attacker (e.g, due to layer-2 switching). sshmitm and webmitm implement active monkey-in-the-middle attacks against redirected SSH and HTTPS sessions by exploiting weak bindings in ad-hoc PKI.

## driftnet

[https://github.com/deiv/driftnet](https://github.com/deiv/driftnet)

Driftnet watches network traffic, and picks out and displays JPEG and GIF images for display. It is a horrific invasion of privacy and shouldn't be used by anyone anywhere. It can also extract MPEG audio data from the network and play it. If you live in a house with thick walls, this may be a useful way to find out about your neighbours' musical taste.

## WIRESHARK

[https://www.wireshark.org/](https://www.wireshark.org/)

Wireshark is the world’s foremost and widely-used network protocol analyzer. It lets you see what’s happening on your network at a microscopic level and is the de facto (and often de jure) standard across many commercial and non-profit enterprises, government agencies, and educational institutions. Wireshark development thrives thanks to the volunteer contributions of networking experts around the globe and is the continuation of a project started by Gerald Combs in 1998.

## TCPDUMP

[https://www.tcpdump.org/manpages/tcpdump.1.html](https://www.tcpdump.org/manpages/tcpdump.1.html)

tcpdump is a common packet analyzer that runs under the command line. It allows the user to display TCP/IP and other packets being transmitted or received over a network to which the computer is attached.

## WINDUMP

[https://www.winpcap.org/windump/](https://www.winpcap.org/windump/)

WinDump is the Windows version of tcpdump, the command line network analyzer for UNIX. WinDump is fully compatible with tcpdump and can be used to watch, diagnose and save to disk network traffic according to various complex rules. It can run under Windows 95, 98, ME, NT, 2000, XP, 2003 and Vista.

## ETTERCAP

[https://www.ettercap-project.org/](https://www.ettercap-project.org/)

Ettercap is a comprehensive suite for man in the middle attacks. It features sniffing of live connections, content filtering on the fly and many other interesting tricks. It supports active and passive dissection of many protocols and includes many features for network and host analysis.

## BETTERCAP

[https://www.bettercap.org/](https://www.bettercap.org/)

bettercap is the Swiss army knife for network attacks and monitoring. 

## NetworkMiner

[https://www.netresec.com/index.ashx?page=NetworkMiner](https://www.netresec.com/index.ashx?page=NetworkMiner)

NetworkMiner is an open source Network Forensic Analysis Tool (NFAT) for Windows (but also works in Linux / Mac OS X / FreeBSD). NetworkMiner can be used as a passive network sniffer/packet capturing tool in order to detect operating systems, sessions, hostnames, open ports etc. without putting any traffic on the network. NetworkMiner can also parse PCAP files for off-line analysis and to regenerate/reassemble transmitted files and certificates from PCAP files.

