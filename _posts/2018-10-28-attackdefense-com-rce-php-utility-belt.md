---
layout: post
title: AttackDefense.com [RCE] - PHP Utility Belt
date: 2018-10-28 17:48 -0300
categories: [AttackDefense.com, ctf, writeups, RCE]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

The attacker might not have any user level access to the web application. However, this does not mean that the application cannot be compromised remotely. Remote Code Execution vulnerabilities could be triggered even by unauthenticated users.

In the exercise below, the attacker is unauthenticated to the web application and needs to find a remote code injection attack to run arbitrary commands on the server.

A version of PHP Utility Belt is vulnerable to a remote code execution attack.

Objective: Your task is to find and exploit this vulnerability.

Level difficulty: Easy

Category: Real World Webapps > Remote Code Execution

### Solution

First of all, I must admit that I am doing this challenge a few hours after its initial release because I enjoyed this category.

On this challenge, I was presented with an interesting and dumb enough application that will execute my code on the first try.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 22-58-53.png)

All I did is this....

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-00-13.png)

The application already executes my code... So... More examples I suppose:

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-03-47.png)

Content of /etc/passwd:

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-04-17.png)

Unfortunately, my target application server dines access to an external resource and therefore I will not struggle to get a reverse shell.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-14-26.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-18-02.png)