---
layout: post
title: AttackDefense.com [SXSS] - YetiForce CRM
date: 2018-11-01 19:53 -0300
categories: [AttackDefense.com, writeups]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

In this exercise, the attacker has admin access already so there is nothing more to be done. However, looks like the admin access does lead to an XSS attack. So you can try to find this XSS as purely academic exercise.

A version of YetiForce CRM is vulnerable to stored cross side scripting attack. The following username and passwords may be used to explore the application and/or find a vulnerability which might require authenticated access:
	
- Username: admin	
- Password: Password1

Objective: Your task is to find and exploit this vulnerability.

Level difficulty: Easy

Category: Real World Webapps > Stored XSS

### Solution

At first, I was prompted straight to the application login and by using the above-provided username and password. I was able to gain access to the application backend. 

![Image of AttackDefense 2018](/uploads/adsxss1/image6.png)

![Image of AttackDefense 2018](/uploads/adsxss1/image8.png)

Straight after login, we can see that in the footer section of the application the version is listed as 3.0.0.

![Image of AttackDefense 2018](/uploads/adsxss1/image3.png)

Not knowing from where to start, I decided to use @GetSploitBot for Telegram in order to obtain exploits for the provided information “A version of ```YetiForce CRM``` is vulnerable to stored cross side scripting attack.”.

![Image of AttackDefense 2018](/uploads/adsxss1/image5.png)

- [https://vulners.com/zdt/1337DAY-ID-25124](https://vulners.com/zdt/1337DAY-ID-25124)

![Image of AttackDefense 2018](/uploads/adsxss1/image9.png)

Accessing the following link we can observe the exploit described path and input field.

- [http://50ucbc62if096e5a0gyy0icih.public1.attackdefenselabs.com/index.php?module=Accounts&view=Detail&record=110](http://50ucbc62if096e5a0gyy0icih.public1.attackdefenselabs.com/index.php?module=Accounts&view=Detail&record=110)

![Image of AttackDefense 2018](/uploads/adsxss1/image7.png)

I set my payload as such in the comments input:

![Image of AttackDefense 2018](/uploads/adsxss1/image2.png)

Proof of Stored XSS:

![Image of AttackDefense 2018](/uploads/adsxss1/image4.png)

![Image of AttackDefense 2018](/uploads/adsxss1/image1.png)
