---
layout: post
title: AttackDefense.com [MSF] - Meterpreter Basics
date: 2018-12-02 18:49 -0300
categories: [AttackDefense.com, writeups, offensive_security]
tags: [ writeups, CTF,  challange, AttackDefense.com, msf]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

The target server as described below is running a vulnerable web server. You have to exploit the vulnerability and get a meterpreter session on the server.  Then, you have to perform the following tasks to complete the challenge!
 
Tasks:

- Check the present working directory on remote (exploited) machine.
- List the files present in present working directory of the remote machine.
- Check the present working directory on local (attacker) machine.
- List the files present in present working directory of the local machine.
- Get the flag value present in /app/flag1 file.
- Change the flag value present in /app/flag1, so that no one else can get the right flag.
- Change the present working directory to a suspiciously named directory in /app and read the flag from a hidden file present in that directory.
- Get the flag5.zip to local machine, open it using password 56784. The information given in the extracted file will give clue about the location of the another flag.
- Delete the .zip file from the directory.
- Print checksum of file mentioned in the extracted file (Refer to Q8).
- Check the PATH environment variable on the remote machine.
- There is a file with string “ckdo” in its name in one of the places included in PATH variable. Print the flag hidden in that file.
- Change to tools directory on the local machine.
- Upload a PHP webshell to app directory of the remote machine.
 
Instructions: 

- This lab is dedicated to you! No other users are on this network :) 
- Once you start the lab, you will have access to a root terminal of a Kali instance
- Your Kali has an interface with IP address 192.X.Y.Z. Run "ip addr" to know the values of X and Y.
- The target server should be located at the IP address 192.X.Y.3. 
- Do not attack the gateway located at IP address 192.X.Y.1 
- postgresql is not running by default so Metasploit may give you an error about this when starting

Level difficulty: Easy

Category: Metasploit > Meterpreter

### Solution

On this atypical lab I was provided with a Linux environment with root access and with two separated tasks:

- Obtain access with a meterpreter session to another host.
- Run multiple commands by following several tasks in order to retrieve flags and understand how Metasploit works.

I started by understanding the current system network connections:

![Image of AttackDefense 2018](/uploads/msf1/image3.png)

I decided to target the 192.247.240.0/24 internal network as such:

```terminal
root@attackdefense:~# nmap -sP 192.247.240.2/24 -T4
```

![Image of AttackDefense 2018](/uploads/msf1/image19.png)

On this internal network, I discovered a particular 192.247.240.3 host on which I executed a ```nmap``` scan in order to retrieve all (```-p-```) open ports.

```terminal
root@attackdefense:~# nmap -A -p- -T4 192.247.240.3 -v
Starting Nmap 7.70 ( https://nmap.org ) at 2018-12-02 20:16 UTC
NSE: Loaded 148 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 20:16
Completed NSE at 20:16, 0.00s elapsed
Initiating NSE at 20:16
Completed NSE at 20:16, 0.00s elapsed
Initiating ARP Ping Scan at 20:16
Scanning 192.247.240.3 [1 port]
Completed ARP Ping Scan at 20:16, 0.03s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 20:16
Completed Parallel DNS resolution of 1 host. at 20:16, 0.00s elapsed
Initiating SYN Stealth Scan at 20:16
Scanning g918q3ltrwh2wjm89rxhxkbbw.temp-network_a-247-240 (192.247.240.3) [65535 ports]
Discovered open port 80/tcp on 192.247.240.3
Discovered open port 3306/tcp on 192.247.240.3
Completed SYN Stealth Scan at 20:16, 1.36s elapsed (65535 total ports)
Initiating Service scan at 20:16
Scanning 2 services on g918q3ltrwh2wjm89rxhxkbbw.temp-network_a-247-240 (192.247.240.3)
Completed Service scan at 20:16, 6.03s elapsed (2 services on 1 host)
Initiating OS detection (try #1) against g918q3ltrwh2wjm89rxhxkbbw.temp-network_a-247-240 (192.247.240.3)
NSE: Script scanning 192.247.240.3.
Initiating NSE at 20:16
Completed NSE at 20:16, 0.13s elapsed
Initiating NSE at 20:16
Completed NSE at 20:16, 0.00s elapsed
Nmap scan report for g918q3ltrwh2wjm89rxhxkbbw.temp-network_a-247-240 (192.247.240.3)
Host is up (0.000087s latency).
Not shown: 65533 closed ports
PORT     STATE SERVICE VERSION
80/tcp   open  http    Apache httpd 2.4.7 ((Ubuntu))
| http-cookie-flags:
|   /:
|     PHPSESSID:
|_      httponly flag not set
| http-git:
|   192.247.240.3:80/.git/
|     Git repository found!
|     Repository description: Unnamed repository; edit this file 'description' to name the...
|     Remotes:
|_      https://github.com/fermayo/hello-world-lamp.git
| http-methods:
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.7 (Ubuntu)
|_http-title: XODA
3306/tcp open  mysql   MySQL 5.5.47-0ubuntu0.14.04.1
| mysql-info:
|   Protocol: 10
|   Version: 5.5.47-0ubuntu0.14.04.1
|   Thread ID: 2
|   Capabilities flags: 63487
|   Some Capabilities: FoundRows, ConnectWithDatabase, LongColumnFlag, SupportsLoadDataLocal, SupportsCompression, ODBCClient, Support41Auth, SupportsTransactions, IgnoreSigpipes, LongPassword, Speaks41ProtocolOld, Speaks41ProtocolNew, IgnoreSpaceBeforeParenthesis, DontAllowDatabaseTableColumn, InteractiveClient, SupportsMultipleStatments, SupportsMultipleResults, SupportsAuthPlugins
|   Status: Autocommit
|   Salt: 5(eJ~^>Wz#;>c[~*Q<uZ
|_  Auth Plugin Name: 96
MAC Address: 02:42:C0:F7:F0:03 (Unknown)
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.2 - 4.9
Uptime guess: 2.178 days (since Fri Nov 30 16:00:30 2018)
Network Distance: 1 hop
TCP Sequence Prediction: Difficulty=249 (Good luck!)
IP ID Sequence Generation: All zeros

TRACEROUTE
HOP RTT     ADDRESS
1   0.09 ms g918q3ltrwh2wjm89rxhxkbbw.temp-network_a-247-240 (192.247.240.3)

NSE: Script Post-scanning.
Initiating NSE at 20:16
Completed NSE at 20:16, 0.00s elapsed
Initiating NSE at 20:16
Completed NSE at 20:16, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 9.74 seconds
           Raw packets sent: 65558 (2.885MB) | Rcvd: 65550 (2.623MB)
root@attackdefense:~#
```

As we can see port 80 is open therefore I decided to run a basic Nikto scan:

```terminal
root@attackdefense:~# nikto -host 192.247.240.3:80
- Nikto v2.1.6
---------------------------------------------------------------------------
+ Target IP:          192.247.240.3
+ Target Hostname:    192.247.240.3
+ Target Port:        80
+ Start Time:         2018-12-02 20:18:27 (GMT0)
---------------------------------------------------------------------------
+ Server: Apache/2.4.7 (Ubuntu)
+ Cookie PHPSESSID created without the httponly flag
+ Retrieved x-powered-by header: PHP/5.5.9-1ubuntu4.25
+ The anti-clickjacking X-Frame-Options header is not present.
+ The X-XSS-Protection header is not defined. This header can hint to the user agent to protect against some forms of XSS
+ The X-Content-Type-Options header is not set. This could allow the user agent to render the content of the site in a different fashion to the MIME type
+ Apache/2.4.7 appears to be outdated (current is at least Apache/2.4.12). Apache 2.0.65 (final release) and 2.2.29 are also current.
+ Web Server returns a valid response with junk HTTP methods, this may cause false positives.
+ /phpinfo.php?VARIABLE=<script>alert('Vulnerable')</script>: Output from the phpinfo() function was found.
+ /config.php: PHP Config file may contain database IDs and passwords.
+ OSVDB-3268: /files/: Directory indexing found.
+ OSVDB-3092: /files/: This might be interesting...
+ /phpinfo.php: Output from the phpinfo() function was found.
+ OSVDB-3233: /phpinfo.php: PHP is installed, and a test script which runs phpinfo() was found. This gives a lot of system information.
+ Server leaks inodes via ETags, header found with file /README, fields: 0x21ff 0x5777f9f606580
+ OSVDB-3092: /README: README file found.
+ /phpinfo.php?GLOBALS[test]=<script>alert(document.cookie);</script>: Output from the phpinfo() function was found.
+ /phpinfo.php?cx[]=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<script>alert(foo)</script>: Output from the phpinfo() function was found.
+ OSVDB-3233: /icons/README: Apache default file found.
+ OSVDB-3092: /.git/index: Git Index file may contain directory listing information.
+ /.git/HEAD: Git HEAD file found. Full repo details may be present.
+ /.git/config: Git config file found. Infos about repo details may be present.
+ 8346 requests: 0 error(s) and 21 item(s) reported on remote host
+ End Time:           2018-12-02 20:18:34 (GMT0) (7 seconds)
---------------------------------------------------------------------------
+ 1 host(s) tested
root@attackdefense:~#
```

The Nikto scan did not return something interesting therefore I decided to move to a more advanced web scanner such as Arachni: 

```
root@attackdefense:~# arachni http://192.247.240.3:80
```

The output:

![Image of AttackDefense 2018](/uploads/msf1/image18.png)

At this point I realized there might be a known vulnerable application called ```xoda``` so I asked ```msfconsole``` to see if there is a publicly known exploit:

![Image of AttackDefense 2018](/uploads/msf1/image1.png)

Using the ```exploit/unix/webapp/xoda_file_upload``` exploit in msfconsole command line interface:

![Image of AttackDefense 2018](/uploads/msf1/image10.png)

Configuring the exploit to match our target:

![Image of AttackDefense 2018](/uploads/msf1/image20.png)

Running the exploit against the target and obtaining the meterpreter session as a PHP web shell through an unrestricted file upload vulnerability:

![Image of AttackDefense 2018](/uploads/msf1/image5.png)

Let’s proceed with the meterpreter specific tasks:

- Check the present working directory on remote (exploited) machine.

![Image of AttackDefense 2018](/uploads/msf1/image15.png)

- List the files present in present working directory of the remote machine.

![Image of AttackDefense 2018](/uploads/msf1/image4.png)

- Check the present working directory on local (attacker) machine.

![Image of AttackDefense 2018](/uploads/msf1/image11.png)

- List the files present in present working directory of the local machine.

![Image of AttackDefense 2018](/uploads/msf1/image2.png)

- Get the flag value present in /app/flag1 file.

![Image of AttackDefense 2018](/uploads/msf1/image8.png)

- Change the flag value present in /app/flag1, so that no one else can get the right flag.

![Image of AttackDefense 2018](/uploads/msf1/image7.png)

- Change the present working directory to a suspiciously named directory in /app and read the flag from a hidden file present in that directory.

![Image of AttackDefense 2018](/uploads/msf1/image14.png)

![Image of AttackDefense 2018](/uploads/msf1/image12.png)

- This flag is also trimmed:

![Image of AttackDefense 2018](/uploads/msf1/image27.png)

- Get the flag5.zip to local machine, open it using password 56784. The information given in the extracted file will give clue about the location of the another flag.


![Image of AttackDefense 2018](/uploads/msf1/image26.png)


![Image of AttackDefense 2018](/uploads/msf1/image25.png)


![Image of AttackDefense 2018](/uploads/msf1/image22.png)

- Delete the .zip file from the directory.

![Image of AttackDefense 2018](/uploads/msf1/image9.png)

- Print checksum of file mentioned in the extracted file (Refer to Q8).

![Image of AttackDefense 2018](/uploads/msf1/image16.png)

- Check the PATH environment variable on the remote machine.

![Image of AttackDefense 2018](/uploads/msf1/image13.png)

- There is a file with string “ckdo” in its name in one of the places included in PATH variable. Print the flag hidden in that file.

![Image of AttackDefense 2018](/uploads/msf1/image21.png)

- Change to tools directory on the local machine.

![Image of AttackDefense 2018](/uploads/msf1/image23.png)

- Upload a PHP webshell to app directory of the remote machine.


![Image of AttackDefense 2018](/uploads/msf1/image6.png)

```terminal
root@attackdefense:~# cp /usr/share/webshells/php/php-backdoor.php tools/
```


![Image of AttackDefense 2018](/uploads/msf1/image17.png)

The above-presented lab can be considered a good introduction on using meterpreter sessions and to ECCPT or OSCP like labs.

![Image of AttackDefense 2018](/uploads/msf1/image24.png)
