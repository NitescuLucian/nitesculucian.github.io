---
layout: post
title: Create a Tor Website in 5 minutes
date: 2018-07-24 20:08 -0300
categories: [tutorials]
tags: [ Tor, TheOnionRouting, dark net, dark web]
---

![Image of TheOnionRouting](/uploads/tor.png)

# General information

#### What is Tor?
Tor is free software and an open network that helps you defend against traffic analysis, a form of network surveillance that threatens personal freedom and privacy, confidential business activities and relationships, and state security.

#### Why Anonymity Matters
Tor protects you by bouncing your communications around a distributed network of relays run by volunteers all around the world: it prevents somebody watching your Internet connection from learning what sites you visit, and it prevents the sites you visit from learning your physical location.

Source: https://www.torproject.org/

# Installation and routing

Personally, when I need a simple Tor Website I use a VM or a physical machine with a live booted a Linux based OS (in general the Ubuntu 16.04). This tutorial is actually for Ubuntu 16.04 in virtual box and feel free to change it to your needs.

#### Step 1: VM and Network Interface

- Make a fresh new VM.
- Configure interface in bridged mode.
- Boot Ubuntu 16.04 live ISO.
- Do not install Ubuntu and choose "Try Ubuntu"

#### Step 2: Install Nginx

- sudo apt install nginx
- sudo rm /etc/nginx/sites-available/default
- sudo nano /etc/nginx/sites-available/default
- Add the followings to the new ```/etc/nginx/sites-available/default``` and save:

```config
server {
       listen 127.0.0.1:8080 default_server;
       server_name localhost;
       root /usr/share/nginx/html;
       index index.html index.htm;
       location / {
               allow 127.0.0.1;
               deny all;
       }
}
```

#### Step 3: Install Tor for the website

- sudo nano /etc/apt/sources.list
- Append and save: ```deb http://deb.torproject.org/torproject.org xenial main```
- Go to https://www.torproject.org/docs/debian.html.en and retrive the followings:

```bash
gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
```

- Proceed with the instalation:

```bash
sudo apt update
sudo apt install tor deb.torproject.org-keyring
```

- Proceed with the configuration:

```bash
sudo nano /etc/tor/torrc
```

Replace: 

```config
#HiddenServiceDir /var/lib/tor/hidden_service/#
#HiddenServicePort 80 127.0.0.1:80
```

With: 

```config
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:8080
```

#### Step 4: Fire it up!

```bash
sudo service nginx restart
sudo service tor restart
```

To retrive the website .onion link:

```bash
cat /var/lib/tor/hidden_service/hostname
```

![Image of TheOnionRouting](/uploads/Screenshot%20from%202018-07-25%2002-01-59.png)

Your websites html files can be found in ```/usr/share/nginx/html```