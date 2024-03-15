---
layout: post
title: AttackDefense.com [PE] - Editing Gone Wrong
date: 2018-10-31 20:11 -0300
categories: [AttackDefense.com, ctf, writeups, PrivilegeEscalation]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

You have managed to get access to the "student" account on the client's server. This is bad enough as all the student resources are available to you. You are now trying to escalate privileges to get root. After some digging around and from other sources, you figure out that the same person in the organization uses both the student account and the root account on the system. 

Your mission is to escalate privileges and get a root shell on the box!

Level difficulty: Easy

Category: Privilege Escalation > Linux

### Solution

On this challenge, I got the web interface of a Linux terminal and I was authenticated as an unprivileged user named ```student```.

![Image of AttackDefense 2018](/uploads/adpe2/image4.png)

After that, I started to fingerprint the system and find something that I can use in a privilege escalation attack.

![Image of AttackDefense 2018](/uploads/adpe2/image9.png)

![Image of AttackDefense 2018](/uploads/adpe2/image3.png)

![Image of AttackDefense 2018](/uploads/adpe2/image5.png)

At some point, I found my starting point for my privilege escalation attack. As you can see in the next image, my ```student``` user is allowed to run man command as sudo.

![Image of AttackDefense 2018](/uploads/adpe2/image2.png)

Running man with sudo:

![Image of AttackDefense 2018](/uploads/adpe2/image10.png)

![Image of AttackDefense 2018](/uploads/adpe2/image1.png)

Unfortunately (or lucky for us) man knows how to spawn shells using the ```!sh``` command:

![Image of AttackDefense 2018](/uploads/adpe2/image6.png)

Proof of solving the challenge:

![Image of AttackDefense 2018](/uploads/adpe2/image7.png)

![Image of AttackDefense 2018](/uploads/adpe2/image8.png)
