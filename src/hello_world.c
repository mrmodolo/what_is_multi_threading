/******************
**
** Multi-threaded "Hello World" program
**
*/

#define _REENTRANT
#include <pthread.h>
#include <stdio.h>

/* function prototypes */
void* outputMsg( void* );

/* mutex variables */
pthread_mutex_t printfLock = \
  PTHREAD_MUTEX_INITIALIZER;

int main( void )
{
  pthread_t thr1, thr2;
  const char* msg1 = "Hello ";
  const char* msg2 = "world ";

  pthread_create( &thr1, NULL, outputMsg, \
    (void*)msg1 );
  pthread_create( &thr2, NULL, outputMsg, \
    (void*)msg2 );

  pthread_join( thr1, NULL );
  pthread_join( thr2, NULL );

  printf( "\n" );

  return 0;
}


void* outputMsg( void* msg )
{
  int i;

  for( i = 0; i < 10; ++i ) {
    pthread_mutex_lock( &printfLock );
    printf("%s", (char*)msg );
    pthread_mutex_unlock( &printfLock );
  }
  return NULL;
}
