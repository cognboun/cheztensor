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
load(
    ":config_chezscheme.bzl",
    "cs_source_files",
    "cs_hdrs_files",
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
    srcs = cs_source_files(),
    hdrs = cs_hdrs_files(),
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

