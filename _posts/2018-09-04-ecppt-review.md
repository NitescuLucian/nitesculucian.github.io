---
layout: post
title: eCPPT Gold Review
date: 2018-09-04 19:13 -0300
categories: [review, certification, offensive_security]
tags: [ offensive security, cheat sheet, sniffing, mitm, arp]
---


![Image of eCPPT Gold](/uploads/Screenshot%20from%202018-09-05%2001-24-27.png)

On the 23rd of August 2018, I passed the eCPPT Gold v1.0 Certification. eCPPT stands for eLearnSecurity Certified Professional Penetration Tester, and eCPPT Gold was the designation for eCPPTv1. At the time of writing this article, note that you can no longer obtain this certification and that the newest version of it is eCPPTv2. In any case, both of them certify that you are an eLearnSecurity Certified Professional Penetration Tester and that you earned the certification by carrying out a demanding practical penetration test against a simulated corporation.


## eCPPT Pre-Requisites
Everything you’ll need to know to pass the exam is taught in the course; however, in my opinion, it won’t hurt to take note of the following key points:

- You should have at least minimal experience in penetration testing. Some skill is needed to be sure you will fit within the 7 day test period.
- You should be enthusiastic about learning something new
- You should be patient
- Hacker mindset
- Familiarity with both Windows and Linux
- Ability to read and write code (especially in Python and C/C++)
- You should not rely on tools. Nessus, Nexpose, Burp Suite Scanner etc. - they won't work, and they will only make you lose more time. Even simple things like Metasploit or Nmap will fail you in the middle of the certification exam.

## The Training Package

In short, the course for the eCPPT Certification includes the following topics:

- Penetration testing processes and methodologies
- Vulnerability Assessment of Networks
- Vulnerability Assessment of Web Applications
- Advanced Exploitation with Metasploit
- Performing Attacks in Pivoting
- Manual exploitation of web applications
- Information Gathering and Reconnaissance
- Scanning and Profiling the target
- Privilege escalation and Persistence
- Exploit Development
- Advanced Reporting skills and Remediation

Everything fits into 4 main categories, with 26 modules and 22 labs. There is one extra category if you take the most expensive package and you want to learn some Ruby, but I would say that this is not the key aspect of your certification. Note that even if you do not take the most expensive package, you still have access to the Ruby-related labs.

This so-called training will not only get you ready to identify and exploit vulnerabilities at the levels covered, but will also teach you what to report and how to report it. 

After all, the life of a Security Consultant / Penetration Tester / Security Specialist is always defined by the quality of the work they present in a report. 

## The Exam

You have exactly 7 days of testing and another 7 days for writing the report, which has to be uploaded before the end of that time frame. At the beginning of this certification exam, you will be presented with a so-called letter of engagement that states all the minimal requirements to pass (it also states that the minimum requirements alone are not enough to pass).

My letter of engagement told me the following things:

- Discover all hosts in all LANs
- Report any vulnerability on all hosts
- Obtain root access level on one specific server on one specific segregated network (yes, there is more than one)
- Do not overestimate the web vulnerabilities
- That I am allowed to use any techniques and tools I want. Very nice joke! Nope. Do it as manually as you can!
- This is not a CTF (Capture the Flag competition) and some things might not be vulnerable at all. I learned this the hard way. I can confirm it.
- You can fail the certification on the quality of the report

Funnily enough, I broke all the vulnerable machines and found all the vulnerabilities in 4-5 days, and then wanted to break the last one. After 48 hours (with 3.5 hours of sleep) of smart ideas and newly discovered methods and approaches, I still did not obtain access to all the hosts, and after consulting the forum I discovered that there was no way of doing it at all. After that, I wrote my report and uploaded it to the platform. After a while I received this:

![Image of eCPPT Gold](/uploads/Screenshot%20from%202018-09-05%2002-56-52.png)


## My Exam Tips

- Take note of everything, take screenshots, write the draft report during the first 6 days of the testing time frame and use one day to put it all together.
- Do not rely on commercial or non-commercial tools. They all have their problems, and eLearnSecurity knows exactly how to play with them!
- Take a break, eat, sleep, wash, relax, hack and repeat!
- It is an open book exam. That might help you.
- "Try harder!"
- Save all pieces of information and all files
- Find workarounds for any issue or problem; think outside the box.

Dear reader, good luck with your endeavors!

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/FoUWHfh733Y?start=11" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</center>