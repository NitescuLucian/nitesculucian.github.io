---
layout: post
title: AttackDefense.com [SXSS] - Concrete5 CMS
date: 2018-11-02 21:53 -0300
categories: [AttackDefense.com, writeups]
tags: [ writeups, CTF,  challenge, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

In this exercise, the attacker already has admin access, so there is nothing more to be done. However, it looks like that admin access does lead to an XSS attack. So you can try to find this XSS as a purely academic exercise.

A version of Concrete5 CMS is vulnerable to a stored cross site scripting attack. The following username and password may be used to explore the application and/or find a vulnerability which might require authenticated access:

- Username: admin 
- Password: 123321

Objective: Your task is to find and exploit this vulnerability.

Level difficulty: Easy

Category: Real World Webapps > Stored XSS

### Solution

This time, I was provided with a full Concrete5 CMS website with multiple pages.

![Image of AttackDefense 2018](/uploads/adsxss2/image2.png)

On the following page, I found the admin panel login, and I got access using the provided username and password.

- [http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/login/](http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/login/)

![Image of AttackDefense 2018](/uploads/adsxss2/image10.png)

By navigating the application control panel, I managed to obtain access to the environment variables at the following link.

- [http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/dashboard/system/environment/info/
](http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/dashboard/system/environment/info/
)

![Image of AttackDefense 2018](/uploads/adsxss2/image6.png)


As we can see, the Concrete5 version is ```5.6.1.2```. 

![Image of AttackDefense 2018](/uploads/adsxss2/image8.png)

Again, I will use @GetSploitBot for Telegram in order to obtain exploits for my version of Concrete5.

![Image of AttackDefense 2018](/uploads/adsxss2/image5.png)

- [https://vulners.com/seebug/SSV:79724](https://vulners.com/seebug/SSV:79724)

![Image of AttackDefense 2018](/uploads/adsxss2/image1.png)

Following the above exploit, I was able to find the following path:

- [http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/dashboard/system/attributes/sets/
](http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/dashboard/system/attributes/sets/
)

![Image of AttackDefense 2018](/uploads/adsxss2/image4.png)

I decided to set my XSS payloads at [http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/dashboard/system/attributes/sets/category/1/](http://x9prkx7tb2hteo96do4zamsv0.public1.attackdefenselabs.com/index.php/dashboard/system/attributes/sets/category/1/), as seen in the example below:

![Image of AttackDefense 2018](/uploads/adsxss2/image7.png)

Result of my payloads:

![Image of AttackDefense 2018](/uploads/adsxss2/image9.png)

![Image of AttackDefense 2018](/uploads/adsxss2/image3.png)
