[What Is Multi-Threading?](https://www.linuxjournal.com/article/1363)

Para o erro:

simple_multi-threaded_matrix_multiplication.c:72:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

A solução:

[Warning: cast to/from pointer from/to integer of different size](https://stackoverflow.com/questions/21323628/warning-cast-to-from-pointer-from-to-integer-of-different-size)

```c

#include <stdint.h> /* intptr_t */

  int i, j;

  for( i = 0; i < MATSIZE; ++i ) {
    pthread_create( &thr[i], NULL, matMult, (void*)(intptr_t)i );
  }


void* matMult( void* param )
{
  int i, j;
  int val;
  int col = (intptr_t)param;

  for(i = 0; i < MATSIZE; ++i) {
    result[i][col] = 0;
    for(j = 0; j < MATSIZE; ++j) {
      result[i][col] += mat1[i][j] * mat2[j][col];
    }
  }
  return NULL;
}

```

Corrigido o  tipo de size para socklen_t conforme o página de manual:


> ACCEPT(2)                                         Linux Programmer's Manual                                        ACCEPT(2)
> 
> NAME
>        accept, accept4 - accept a connection on a socket
> 
> SYNOPSIS
>        #include <sys/types.h>          /* See NOTES */
>        #include <sys/socket.h>
> 
>        int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
> 
>        #define _GNU_SOURCE             /* See feature_test_macros(7) */
>        #include <sys/socket.h>
> 
>        int accept4(int sockfd, struct sockaddr *addr,
>                    socklen_t *addrlen, int flags);

```c
socklen_t size;
accept(srv_socket, (struct sockaddr *)&accept_addr, &size);
```
