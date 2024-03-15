---
layout: post
title: "[DCTF Quals 2018] Even more lucky?"
date: 2018-10-06 18:38 -0300
categories: [dctf, writeups]
tags: [ DCTF, DefCamp 2018, writeups, CTF capture, flag,  challange]
---

![Image of DCTF Quals 2018](/uploads/Screenshot%20from%202018-10-01%2016-37-21.png)

### Description:

We have updated the lucky game just for you! Now the executable is lighter and more efficient. 

Target: 167.99.143.206 65032

Bin: [Even more lucky binary](/uploads/lucky2)

### Author: 
Lucian Nitescu

### Stats: 
50 point / 119 solvers

### Solution:  

On ```167.99.143.206``` at port 65032 we can observe the following:

```terminal
$ nc 167.99.143.206 65032
Hello, there!

What is your name?
Lucian
I am glad to know you, Lucian!
Server time: 153886
If you guess the next 100 random numbers I shall give you the flag!

What number am I thinking of? [0/100]
1
Wow that is wrong!

```

Let’s decompile the binary in IDA and analyze its main function.

```c++
__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  __int64 v3; // rax@1
  __int64 v4; // rax@1
  __int64 v5; // rax@1
  __int64 v6; // rax@1
  __int64 v7; // rax@1
  __int64 v8; // rax@1
  __int64 v9; // rax@1
  __int64 v10; // rax@1
  __int64 v11; // rax@1
  __int64 v12; // rax@1
  __int64 v13; // rax@3
  __int64 v14; // rax@3
  __int64 v15; // rax@3
  __int64 v16; // rax@4
  __int64 v17; // rax@4
  __int64 v18; // rax@5
  signed int v19; // ebx@5
  __int64 v20; // rax@7
  char v22; // [sp+0h] [bp-330h]@6
  char v23; // [sp+210h] [bp-120h]@1
  char v24; // [sp+2A0h] [bp-90h]@1
  char v25; // [sp+2C0h] [bp-70h]@1
  char v26; // [sp+2E0h] [bp-50h]@1
  int v27; // [sp+310h] [bp-20h]@3
  int v28; // [sp+314h] [bp-1Ch]@3
  int v29; // [sp+318h] [bp-18h]@1
  unsigned int i; // [sp+31Ch] [bp-14h]@1
 
  v29 = time(0LL);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::basic_string(&v25, a2);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::basic_string(&v24, a2);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::basic_string(&v23, a2);
  srand(v29 / 10);
  LODWORD(v3) = std::operator<<<std::char_traits<char>>(&std::cout, "Hello, there!");
  LODWORD(v4) = std::ostream::operator<<(v3, &std::endl<char,std::char_traits<char>>);
  std::ostream::operator<<(v4, &std::endl<char,std::char_traits<char>>);
  LODWORD(v5) = std::operator<<<std::char_traits<char>>(&std::cout, "What is your name?");
  std::ostream::operator<<(v5, &std::endl<char,std::char_traits<char>>);
  std::getline<char,std::char_traits<char>,std::allocator<char>>(&std::cin, &v23);
  sub_2033(&v26, v29 / 10000);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::operator=(&v25, &v26);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(&v26);
  LODWORD(v6) = std::operator<<<std::char_traits<char>>(&std::cout, "I am glad to know you, ");
  LODWORD(v7) = std::operator<<<char,std::char_traits<char>,std::allocator<char>>(v6, &v23);
  LODWORD(v8) = std::operator<<<std::char_traits<char>>(v7, "!");
  std::ostream::operator<<(v8, &std::endl<char,std::char_traits<char>>);
  LODWORD(v9) = std::operator<<<std::char_traits<char>>(&std::cout, "Server time: ");
  LODWORD(v10) = std::operator<<<char,std::char_traits<char>,std::allocator<char>>(v9, &v25);
  std::ostream::operator<<(v10, &std::endl<char,std::char_traits<char>>);
  LODWORD(v11) = std::operator<<<std::char_traits<char>>(
                   &std::cout,
                   "If you guess the next 100 random numbers I shall give you the flag!");
  LODWORD(v12) = std::ostream::operator<<(v11, &std::endl<char,std::char_traits<char>>);
  std::ostream::operator<<(v12, &std::endl<char,std::char_traits<char>>);
  for ( i = 0; (signed int)i <= 99; ++i )
  {
    v28 = rand();
    LODWORD(v13) = std::operator<<<std::char_traits<char>>(&std::cout, "What number am I thinking of? [");
    LODWORD(v14) = std::ostream::operator<<(v13, i);
    LODWORD(v15) = std::operator<<<std::char_traits<char>>(v14, "/100]");
    std::ostream::operator<<(v15, &std::endl<char,std::char_traits<char>>);
    std::getline<char,std::char_traits<char>,std::allocator<char>>(&std::cin, &v23);
    v27 = sub_1FE9(&v23, 0LL, 10LL);
    if ( v27 != v28 )
    {
      LODWORD(v18) = std::operator<<<std::char_traits<char>>(&std::cout, "Wow that is wrong!");
      std::ostream::operator<<(v18, &std::endl<char,std::char_traits<char>>);
      v19 = -1;
      goto LABEL_9;
    }
    LODWORD(v16) = std::operator<<<std::char_traits<char>>(&std::cout, "Wow that is corect!");
    LODWORD(v17) = std::ostream::operator<<(v16, &std::endl<char,std::char_traits<char>>);
    std::ostream::operator<<(v17, &std::endl<char,std::char_traits<char>>);
  }
  std::basic_ifstream<char,std::char_traits<char>>::basic_ifstream(&v22, "./flag2", 8LL);
  if ( (unsigned __int8)std::basic_ifstream<char,std::char_traits<char>>::is_open(&v22) )
  {
    std::getline<char,std::char_traits<char>,std::allocator<char>>(&v22, &v24);
    LODWORD(v20) = std::operator<<<char,std::char_traits<char>,std::allocator<char>>(&std::cout, &v24);
    std::ostream::operator<<(v20, &std::endl<char,std::char_traits<char>>);
    std::basic_ifstream<char,std::char_traits<char>>::close(&v22);
  }
  v19 = 0;
  std::basic_ifstream<char,std::char_traits<char>>::~basic_ifstream(&v22);
LABEL_9:
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(&v23);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(&v24);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(&v25);
  return (unsigned int)v19;
}
```

This time the seed fed into srand() is time(NULL) / 10. The C library function time_t time(time_t *seconds) returns the time since the Epoch (00:00:00 UTC, January 1, 1970), measured in seconds. If seconds is not NULL, the return value is also stored in variable seconds. We can use the current system time output in order to exploit the vulnerability.

Get the seed value and the random numbers with:
```c++
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv){
    int seed = atoi(argv[1]);
    srand(seed);
    for(int i = 0; i < 100; i++){
        printf("%d\n", rand());
    }
}
```

Final step using the above compiled (in a.out) source code:
```python
#!/usr/bin/python
from pwn import *
import time
import os
host = '167.99.143.206'
port = 65032
r = remote(host, port)
x = time.time()
r.recvuntil('?')
r.sendline('a')
os.system('./a.out ' + str(x // 10) + ' > see')
f = open('see', 'r')
x = f.read().split('\n')[:-1]
for i in range(100):
    r.recvuntil(']')
    r.sendline(str(x[i]))
    print (i)
r.interactive()
```

Result:
```terminal
$ python 2.py 
[+] Opening connection to 167.99.143.206 on port 65032: Done
0
1
2
3
4
5
6
7
8
9
10

.. sniiiiiip

95
96
97
98
99
[*] Switching to interactive mode

Wow that is corect!

DCTF{2e7aaa899a8b212ea6ebda3112d24559f2d2c540a9a29b1b47477ae8e5f20ace}
[*] Got EOF while reading in interactive
```

The flag was: DCTF{2e7aaa899a8b212ea6ebda3112d24559f2d2c540a9a29b1b47477ae8e5f20ace}