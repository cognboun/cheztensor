/* tensorflow.c
 * Copyright 2019 error.d@gmail.com
 * !!PLACEHOLDER FILE!!
 */


#include "system.h"

IBOOL S_tf_test(followp) IBOOL followp; {
  printf("this is tf_test placeholder file\n");
  return followp;
}

void S_tensorflow_init()
{
    if (!S_boot_time) return;
    
    printf("setup ChezScheme Tensorflow placeholder file ...\n");
    Sforeign_symbol("(cs)S_tf_test", (void *)S_tf_test);
}
