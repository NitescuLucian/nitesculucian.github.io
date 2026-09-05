---
layout: post
title: Get started with Digital Ocean (DO) Droplets (VPS)
date: 2024-03-15 21:53:12 +0200
categories: [tutorial]
tags: [vps, ubuntu, private server, DigitalOcean, droplet]
pin: false
hidden: false
---

## What is Digital Ocean?

Digital Ocean is a cloud infrastructure provider that offers simplicity, scalability, and reliability for developers and businesses. Users can quickly deploy, manage, and scale applications with its intuitive platform. Digital Ocean provides various services, including Droplets (virtual private servers), managed databases, and object storage solutions, making it a versatile choice for hosting a wide range of applications and environments.

If you want to jump into this tutorial and set up your environment, here is a $200 referral link for your new Digital Ocean account:

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=69a748f0c7fb&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

## Configuring a VPS on Digital Ocean

Setting up a Virtual Private Server (VPS) on Digital Ocean is straightforward. After signing up using the referral link, you can create a Droplet, which is Digital Ocean's term for a VPS. During the creation process, you can choose the operating system (such as Ubuntu, CentOS, or Fedora), the Droplet size based on your needs, and the data center region. For this tutorial, it's advisable to select an operating system like Ubuntu, and here are the steps:

* On the right-hand top corner, click on the Create dropdown button and then select Droplets:

![Create Droplet](</uploads/Screenshot from 2024-03-16 21-32-30.png>)

* Select a region close to you:

![Region Selection](</uploads/Screenshot from 2024-03-16 21-39-06.png>)

* Select Ubuntu 22.04 (or the latest) operating system: 

![Ubuntu 22.04](</uploads/Screenshot from 2024-03-16 21-46-22.png>)

* Choose a size that fits your budget and is appropriate for what you need to test:

![size m4tters](</uploads/Screenshot from 2024-03-16 21-47-19.png>)

* Upload or select the SSH key you use to connect to the VPS as the root user:

![ssh key](</uploads/Screenshot from 2024-03-16 21-48-11.png>)

* Name your Droplet as you wish; here is how I did it:

![my target tld](</uploads/Screenshot from 2024-03-16 21-48-54.png>)

* Press "Create Droplet", wait a few seconds, get the allocated IP address and run `ssh root@<your ip address>` to get started:

![Create Droplet](</uploads/Screenshot from 2024-03-16 21-51-41.png>)