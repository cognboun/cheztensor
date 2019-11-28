# Description:
# ChezScheme support for TensorFlow.
#
# Public targets:
#  tf_chezscheme
#

package(
    default_visibility = [
	"//visibility:public",
    ],
)

licenses(["notice"])  # Apache 2.0

exports_files(["LICENSE"])

load(
    "//tensorflow:tensorflow.bzl",
    "tf_cc_test",
    "tf_cc_binary",
    "tf_copts",
    "tf_gen_op_wrappers_cc",
)

cc_library(
    name = "lz4",
    srcs = [
            "ChezScheme/lz4/lib/lz4.c",
            "ChezScheme/lz4/lib/lz4frame.c",
            "ChezScheme/lz4/lib/lz4hc.c",
            "ChezScheme/lz4/lib/xxhash.c",
    ],
    hdrs = [
            "ChezScheme/lz4/lib/lz4.h",
            "ChezScheme/lz4/lib/lz4.inc",
            "ChezScheme/lz4/lib/lz4frame.h",
            "ChezScheme/lz4/lib/lz4hc.h",
            "ChezScheme/lz4/lib/xxhash.h",
    ],
    copts = tf_copts() + ["-DX86_64"],
)    

cc_library(
    name = "chezscheme",
    srcs = [
            "ChezScheme/a6osx/c/alloc.c",
            "ChezScheme/a6osx/c/statics.c",
            "ChezScheme/a6osx/c/segment.c",
            "ChezScheme/a6osx/c/symbol.c",
            "ChezScheme/a6osx/c/intern.c",
            "ChezScheme/a6osx/c/gcwrapper.c",
            "ChezScheme/a6osx/c/gc-ocd.c",
            "ChezScheme/a6osx/c/gc-oce.c",
            "ChezScheme/a6osx/c/number.c",
            "ChezScheme/a6osx/c/schsig.c",
            "ChezScheme/a6osx/c/io.c",
            "ChezScheme/a6osx/c/new-io.c",
            "ChezScheme/a6osx/c/print.c",
            "ChezScheme/a6osx/c/fasl.c",
            "ChezScheme/a6osx/c/stats.c",
            "ChezScheme/a6osx/c/foreign.c",
            "ChezScheme/a6osx/c/prim.c",
            "ChezScheme/a6osx/c/prim5.c",
            "ChezScheme/a6osx/c/flushcache.c",
            "ChezScheme/a6osx/c/schlib.c",
            "ChezScheme/a6osx/c/thread.c",
            "ChezScheme/a6osx/c/expeditor.c",
            "ChezScheme/a6osx/c/scheme.c",
            "ChezScheme/a6osx/c/compress-io.c",
            "ChezScheme/a6osx/c/i3le.c"],
    hdrs = [
            "ChezScheme/a6osx/c/gc.inc",
            "ChezScheme/a6osx/c/system.h",
            "ChezScheme/a6osx/c/version.h",
            "ChezScheme/a6osx/c/config.h",
            "ChezScheme/a6osx/c/thread.h",
            "ChezScheme/a6osx/c/compress-io.h",
            "ChezScheme/a6osx/c/globals.h",
            "ChezScheme/a6osx/c/externs.h",
            "ChezScheme/a6osx/c/segment.h",
            "ChezScheme/a6osx/c/types.h",
            "ChezScheme/a6osx/c/sort.h",
            "ChezScheme/a6osx/boot/a6osx/scheme.h",
            "ChezScheme/a6osx/boot/a6osx/equates.h"],
    copts = tf_copts() + ["-DX86_64"],
    deps = [
        ":lz4",
    ],
)

cc_library(
    name = "chezscheme_for_tensorflow",
    srcs = [
            "chezscheme_for_tensorflow/tensorflow.c",
            "chezscheme_for_tensorflow/tf_util.cc"],
    hdrs = [
            "chezscheme_for_tensorflow/tf_util.h",
    ],
    copts = tf_copts() + ["-DX86_64"],
    deps = [
        ":chezscheme",
        "//tensorflow/core:tensorflow",
        "//tensorflow/cc:cc_ops",
    ],
)    

tf_cc_binary(
    name = "tf_chezscheme",
    srcs = ["tf_chezscheme.c"],
    copts = tf_copts() + ["-DX86_64"],
    linkopts = select({
        "//tensorflow:macos": [
            "-lm",
            "-lpthread",
            "-liconv",
            "-lm",
            "-lncurses",
        ],
        "//tensorflow:ios": [
            "-lm",
            "-lpthread",
        ],
        "//conditions:default": [
            "-lm",
            "-lpthread",
            "-lrt",
        ],
    }),
    deps = [
        ":chezscheme_for_tensorflow",
        "//tensorflow/cc:cc_ops",
        "//tensorflow/core:core_cpu",
        "//tensorflow/core:framework",
        "//tensorflow/core:lib",
        "//tensorflow/core:protos_all_cc",
        "//tensorflow/core:tensorflow",
    ],
)

