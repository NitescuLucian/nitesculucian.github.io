---
layout: post
title: AttackDefense.com [SXSS] - MyBB Downloads Plugin
date: 2018-10-28 12:29 -0300
categories: [AttackDefense.com, writeups]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

A version of MyBB Downloads Plugin is vulnerable to a stored cross site scripting attack.Your task is to find and exploit this vulnerability.

The following username and password may be used to explore the application and create regular users if required to exploit authenticated access vulnerabilities:

- User: test2    
- Password: password

Level difficulty: Easy

Category: Real World Webapps > Stored XSS

### Solution

On this challenge, I received a real MyBB forum application deployment and potentially at the last available version.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 17-43-48.png)

I used the above-provided credentials to authenticate on the forum application:

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 17-45-49.png)

At this point, we discover that the provided credentials are for an unprivileged user (forum member).

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 17-46-52.png)

Not knowing from where to start, I decided to use @GetSploitBot for Telegram in order to obtain exploits for the provided information "A version of ```MyBB Downloads Plugin``` is vulnerable".

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 17-52-01.png)

- [https://vulners.com/packetstorm/PACKETSTORM:147061](https://vulners.com/packetstorm/PACKETSTORM:147061)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 17-56-49.png)

By going to [http://3fthpltqv67g8lfuh2hgo4ztl.public2.attackdefenselabs.com/downloads.php](http://3fthpltqv67g8lfuh2hgo4ztl.public2.attackdefenselabs.com/downloads.php) I discovered the following Minion.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-01-49.png)

By accessing that specific Minion ([http://3fthpltqv67g8lfuh2hgo4ztl.public2.attackdefenselabs.com/downloads.php?category=1](http://3fthpltqv67g8lfuh2hgo4ztl.public2.attackdefenselabs.com/downloads.php?category=1)), I discovered the place where I should proceed with the exploit steps.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-05-06.png)

By clicking on "New Download", I was redirected to [http://3fthpltqv67g8lfuh2hgo4ztl.public2.attackdefenselabs.com/downloads.php?newdownload=1](http://3fthpltqv67g8lfuh2hgo4ztl.public2.attackdefenselabs.com/downloads.php?newdownload=1).

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-05-18.png)

I introduced multiple payloads in order to test for other XSS vulnerabilities then described on the reported exploit.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-12-04.png)

Funny enough I was unable to exploit my XSS due to the fact that I created an unintended SQL Injection exploit (OPS... my bad!). Also at the moment of this article, the identified SQL Injection vulnerability has no public available exploit (yet another Zero-day?).

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-14-46.png)

I changed my XSS payloads as such:

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-20-36.png)

And I obtained my XSS payload that can be traced back to my payload input:

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-21-12.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 18-23-49.png)
