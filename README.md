# Cheztensor

ChezScheme Tensorflow Bindings

### Build on Tensorflow

* download Tensorflow source code

* ```git clone https://github.com/cognboun/chezscheme_for_tensorflow.git``` in tensorflow/tensorflow

* rename chezscheme_for_tensorflow chezscheme

* shell
```
bazel build -c opt //tensorflow/chezscheme:gen_chezscheme_source
bazel build -c opt //tensorflow/chezscheme:tf_chezscheme

./bazel-bin/tensorflow/chezscheme/tf_chezscheme -b ./bazel-bin/tensorflow/chezscheme/boot/petite.boot -b ./bazel-bin/tensorflow/chezscheme/boot/scheme.boot

```
    
* just
```
build_chezscheme build_opt=DEFAULT_BUILD_OPT:
	bazel build -c {{build_opt}} {{VERBOSE}} //tensorflow/chezscheme:gen_chezscheme_source
	bazel build -c {{build_opt}} {{VERBOSE}} //tensorflow/chezscheme:tf_chezscheme
	@echo "export TF_CPP_MIN_VLOG_LEVEL=5; ./bazel-bin/tensorflow/chezscheme/tf_chezscheme -b ./bazel-bin/tensorflow/chezscheme/boot/petite.boot -b ./bazel-bin/tensorflow/chezscheme/boot/scheme.boot  --num_concurrent_sessions=1 --num_concurrent_steps=1 --num_iterations=1"
```

### todolist
- [ ]  Tensorflow bindings Chezscheme
	- [ ] validation tensorflow c_api or c++ api
	- [ ] develop tensorflow base function
	- [ ] develop chezscheme bindings function
	- [ ] chezscheme wrapper
	- [ ] chezscheme mathematical environment base on tensorflow
	- [ ] chezscheme tensorflow environment

### chezscheme version
* git commit ab1656597150676dd33c311b8ae7e37287bbe54e


### Resource
* Tensorflow: https://github.com/tensorflow/tensorflow
* ChezScheme: https://github.com/cisco/ChezScheme
