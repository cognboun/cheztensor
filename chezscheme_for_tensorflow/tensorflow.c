/* tensorflow.c
 * Copyright 2019 error.d@gmail.com
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "system.h"
#include "tf_util.h"

IBOOL S_tf_test(followp) IBOOL followp; {
  tf_start();
  return followp;
}

void S_tensorflow_init()
{
    if (!S_boot_time) return;
    
    printf("hello ChezScheme Tensorflow...\n");
    Sforeign_symbol("(cs)S_tf_test", (void *)S_tf_test);
}
