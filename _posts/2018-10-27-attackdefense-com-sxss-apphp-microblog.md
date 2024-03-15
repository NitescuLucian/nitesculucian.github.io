---
layout: post
title: AttackDefense.com [SXSS] - ApPHP MicroBlog
date: 2018-10-27 21:31 -0300
categories: [AttackDefense.com, writeups]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

A version of ApPHP MicroBlog is vulnerable to stored cross site scripting attack. Your task is to find and exploit this vulnerability. Authenticated access is not required to exploit this vulnerability. 

Level difficulty: Easy

Category: Real World Webapps > Stored XSS

### Solution

On this challenge, I was again provided with the same version of ApPHP MicroBlog as on the RCE exercise found [here](https://nitesculucian.github.io/2018/10/26/attackdefense-com-rce-apphp-microblog/).

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 03-33-08.png)

Therefore, I tried the same password and username (```admin``` && ```password```) as in the RCE challenge on the admin login form.

- [http://udxkg51hwj61dpkifm62lkdu9.public2.attackdefenselabs.com/index.php?admin=login](http://udxkg51hwj61dpkifm62lkdu9.public2.attackdefenselabs.com/index.php?admin=login)
 
![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 03-37-55.png)

- [http://udxkg51hwj61dpkifm62lkdu9.public2.attackdefenselabs.com/index.php](http://udxkg51hwj61dpkifm62lkdu9.public2.attackdefenselabs.com/index.php)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 03-04-30.png)

By going to an already posted article, we can observe the presence of a comment module within our blog. In that comment module, I used the following examples of XSS payloads.

- [http://udxkg51hwj61dpkifm62lkdu9.public2.attackdefenselabs.com/index.php?page=posts&post_id=69](http://udxkg51hwj61dpkifm62lkdu9.public2.attackdefenselabs.com/index.php?page=posts&post_id=69)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 03-17-24.png)

With a simple refresh I have obtained the following result:


![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 03-21-39.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 03-33-29.png)