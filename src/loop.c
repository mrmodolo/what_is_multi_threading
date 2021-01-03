/******************
**
** Multi-threaded "Loop" program
**
*/

#include <pthread.h>
#include <stdio.h>

/* function prototypes */
void* fn( void* );

static int i;

/* mutex variables */
static pthread_mutex_t loopLock = PTHREAD_MUTEX_INITIALIZER;

int main( void )
{
  pthread_t thr1, thr2;

  pthread_create( &thr1, NULL, fn, \
    (void*)NULL );
  pthread_create( &thr2, NULL, fn, \
    (void*)NULL );

  pthread_join( thr1, NULL );
  pthread_join( thr2, NULL );

  printf( "\n" );

  return 0;
}

void* fn(__attribute__((unused))void* param)
{
  pthread_mutex_lock( &loopLock );
  for( i = 0; i != 4; ++i ) {
    printf( "%d ", i );
  }
  printf( "\n" );
  pthread_mutex_unlock( &loopLock );
  return NULL;
}
