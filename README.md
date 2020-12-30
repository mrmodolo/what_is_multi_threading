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

> gcc -o ./build/matrix_multiplication ./src/simple_multi-threaded_matrix_multiplication.c -lpthread
> gcc -o ./build/server ./src/simple_server.c -lpthread 
> ./src/simple_server.c: In function ‘serverWatch’:
> ./src/simple_server.c:89:51: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>    89 |     pthread_create(&dummy_thr, NULL, serveClient, (void *)accepted_socket);
>       |                                                   ^
> ./src/simple_server.c: In function ‘serveClient’:
> ./src/simple_server.c:103:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   103 |     write((int)socket, buffer, strlen(buffer));
>       |           ^
> ./src/simple_server.c:105:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   105 |     if (read((int)socket, buffer, 255) > 0) {
>       |              ^
> ./src/simple_server.c:107:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   107 |         close((int)socket);
>       |               ^
