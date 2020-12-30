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
