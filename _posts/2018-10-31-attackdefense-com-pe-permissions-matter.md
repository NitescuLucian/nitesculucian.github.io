---
layout: post
title: AttackDefense.com [PE] - Permissions Matter!
date: 2018-10-31 19:16 -0300
categories: [AttackDefense.com, ctf, writeups, PrivilegeEscalation]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

The admin was tasked to create a replica of an existing Linux system. He copied the entire filesystem to his computer, made modifications to some files and then copied it onto the newly provisioned system. Unfortunately, in his haste to set the new system up, he forgot to take care of permission sets. 

Your mission is to get a root shell on the box!

Level difficulty: Easy

Category: Privilege Escalation > Linux

### Solution

On this challenge, I got the web interface of a Linux terminal and I was authenticated as an unprivileged user named ```student```.

![Image of AttackDefense 2018](/uploads/adpe1/image6.png)

First of all, I checked If I had access to both ```passwd``` and ```shadow``` files.

![Image of AttackDefense 2018](/uploads/adpe1/image7.png)

![Image of AttackDefense 2018](/uploads/adpe1/image5.png)

Funny enough I had access to the ```shadow``` file but I see no password hash within that.
I decided to check if I had write access to the ```shadow``` or ```passwd``` file in order to place a password hash for the root user (some legacy systems accept password hashes in ```passwd```).  

![Image of AttackDefense 2018](/uploads/adpe1/image1.png)

As you can see in the above image, I have both read and write permissions for the ```shadow``` file. Generating the password hash as such:

```terminal
student@attackdefense:~$ openssl passwd -1 -salt root pass123
$1$root$quimBCDAqK3JX3mbeqrrD1
student@attackdefense:~$
```

Placing the password hash for root user in the ```shadow``` file:

![Image of AttackDefense 2018](/uploads/adpe1/image4.png)

Authenticating as root on the target server:

![Image of AttackDefense 2018](/uploads/adpe1/image2.png)

![Image of AttackDefense 2018](/uploads/adpe1/image3.png)