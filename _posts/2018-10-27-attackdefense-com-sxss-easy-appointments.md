---
layout: post
title: AttackDefense.com [SXSS] - Easy Appointments
date: 2018-10-27 16:40 -0300
categories: [AttackDefense.com, writeups]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

A version of Easy Appointments is vulnerable to stored cross site scripting attack. This application is vulnerable to multiple reflected and stored XSS vulnerabilities. Your task is to find and exploit them.

The following username and password may be used to explore the application and create regular users if required to exploit authenticated access vulnerabilities:

- User: admin        
- Password: password

Level difficulty: Easy

Category: Real World Webapps > Stored XSS

### Solution

At first,  I was prompted straight to the application “Backed Section” at [http://75dux4a6duu9d9ikl8elrdxsc.public1.attackdefenselabs.com/easyappointments/index.php/user/login](http://75dux4a6duu9d9ikl8elrdxsc.public1.attackdefenselabs.com/easyappointments/index.php/user/login).

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 22-45-53.png)


By trimming the given URL of the application, I found the following valid path:

- [http://75dux4a6duu9d9ikl8elrdxsc.public1.attackdefenselabs.com/easyappointments/index.php](http://75dux4a6duu9d9ikl8elrdxsc.public1.attackdefenselabs.com/easyappointments/index.php)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 22-49-43.png)

I discovered, by filling the public available form, that on step 3 it is the best place to inject my JavaScript payloads in order to achieve a Stored XSS Exploit.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-00-05.png)

After that, I received an appointment confirmation with a safe and escaped (at least for the user) output of my payloads.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-03-01.png)

Here my payloads are already saved in the database of the application with no error (SQL Injection Vulnerabilities, restricted format or characters).

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-04-16.png)

Using the provided credentials on [http://75dux4a6duu9d9ikl8elrdxsc.public1.attackdefenselabs.com/easyappointments/index.php/user/login](http://75dux4a6duu9d9ikl8elrdxsc.public1.attackdefenselabs.com/easyappointments/index.php/user/login) page we obtain access to the admin interface where you can observe the followings:

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-10-55.png)

By clicking on the 29 October 2018 appointment (my appointment), we will execute two different payloads that can be linked back to our inputs.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-14-05.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-14-12.png)

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-14-21.png)

With the above example and not just in this scenario, an attacker can compromise the session of the admin user in order to obtain access to the application backend.

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-27 23-19-06.png)
