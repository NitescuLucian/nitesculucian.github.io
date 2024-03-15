---
layout: post
title: AttackDefense.com [RCE] - Joomla com_xcloner Component
date: 2018-10-26 11:40 -0300
categories: [AttackDefense.com, ctf, writeups, RCE]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

A version of Joomla com_xcloner Component is vulnerable to remote code execution attack. Your task is to find and exploit this vulnerability.

The following username and password may be used to explore the application and create regular users if required to exploit authenticated access vulnerabilities:

- User: admin        
- Password: password

Level difficulty: Easy

Category: Real World Webapps > Remote Code Execution

### Solution

First I was provided with the following Joomla website:

![Image of AttackDefense 2018](/uploads/adrce1-image4.png)

By using the username and password that were given to me at the start of this challenge, I have obtained access to the Joomla Control Panel:

![Image of AttackDefense 2018](/uploads/adrce1-image2.png)

There I was able to discover the installed version of Joomla Core:

![Image of AttackDefense 2018](/uploads/adrce1-image6.png)

Even if I tried multiple known remote code execution exploits for Joomla Core version 1.6.0, I was unable to get any command execution on the target website. Therefore, I took in account the following provided information: 

``` Joomla com_xcloner Component ```

This simple statement transmitted me to search on Google for exploits applicable to Joomla com_xcloner Component and to my surprise, I have obtained the following:

![Image of AttackDefense 2018](/uploads/adrce1-image5.png)

After downloading the exploit and running it against the target website, I have obtained the following:

```terminal
lucian@local:~/Downloads$ python 16246.py -t ie9i8y5pobnhaf1u7vhg8egbt.public2.attackdefenselabs.com:80 -d /joomla/

	| ----------------------------------------------------------------------------- |
	| Joomla component (com_xcloner-backupandrestore) remote code execution explo!t |
	| by mr_me - net-ninja.net ---------------------------------------------------- |

(+) Targeting http://ie9i8y5pobnhaf1u7vhg8egbt.public2.attackdefenselabs.com:80/joomla/
(!) Exploit working!
(+) Droping to remote console (q for quit)

lucian@ie9i8y5pobnhaf1u7vhg8egbt.public2.attackdefenselabs.com:80# 

```

The last thing was to prove that I have finished the challenge:

![Image of AttackDefense 2018](/uploads/adrce1-image3.png)

![Image of AttackDefense 2018](/uploads/adrce1-image1.png)
