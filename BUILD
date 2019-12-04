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
    srcs = [":test_ccs"],
    hdrs = [":test_ccs"],
    copts = tf_copts() + ["-DX86_64"],
    deps = [
        ":lz4",
    ],
)

genrule(
        name = "test_ccs",
            srcs = [],
            outs = ["alloc.c"],
            cmd = """

            threads=yes
            CONFIG_UNAME=`uname`

            case \"$$CONFIG_UNAME\" in
            Linux)
            if uname -a | egrep 'i386|i686|amd64|athlon|x86_64' > /dev/null 2>&1 ; then
                m32=i3le
                m64=a6le
                tm32=ti3le
                tm64=ta6le
            elif uname -a | grep -i power > /dev/null 2>&1 ; then
                m32=ppc32le
                m64=""
                tm32=tppc32le
                tm64=""
            fi
            ;;
            QNX)
            if uname -a | egrep 'x86' > /dev/null 2>&1 ; then
                    m32=i3qnx
                    tm32=ti3qnx
            fi
            ;;
            FreeBSD)
            if uname -a | egrep 'i386|i686|amd64|athlon|x86_64' > /dev/null 2>&1 ; then
                m32=i3fb
                m64=a6fb
                tm32=ti3fb
                tm64=ta6fb
            fi
            ;;
            OpenBSD)
            if uname -a | egrep 'i386|i686|amd64|athlon|x86_64' > /dev/null 2>&1 ; then
                m32=i3ob
                m64=a6ob
                tm32=ti3ob
                tm64=ta6ob
            fi
            ;;
            NetBSD)
            if uname -a | egrep 'i386|i686|amd64|athlon|x86_64' > /dev/null 2>&1 ; then
                m32=i3nb
                m64=a6nb
                tm32=ti3nb
                tm64=ta6nb
            fi
            ;;
            Darwin)
            if uname -a | egrep 'i386|i686|amd64|athlon|x86_64' > /dev/null 2>&1 ; then
                m32=i3osx
                m64=a6osx
                tm32=ti3osx
                tm64=ta6osx
            fi
            ;;
            SunOS)
            if uname -a | egrep 'i386|i686|amd64|athlon|x86_64' > /dev/null 2>&1 ; then
                m32=i3s2
                m64=a6s2
                tm32=ti3s2
                tm64=ta6s2
            fi
            ;;
            CYGWIN_NT-*)
            if uname -a | egrep 'i386|i686|amd64|athlon|x86_64' > /dev/null 2>&1 ; then
                m32=i3nt
                m64=a6nt
                tm32=ti3nt
                tm64=ta6nt
        fi
        ;;
        esac

        if uname -a | egrep 'amd64|x86_64' > /dev/null 2>&1 ; then
            bits=64
        else
            bits=32
        fi

        if [ $$bits = 64 ] ; then
            if [ $$threads = yes ] ; then m=$$tm64 ; else m=$$m64 ; fi
        else
            if [ $$threads = yes ] ; then m=$$tm32 ; else m=$$m32 ; fi
        fi
        echo \"aaaaaaaaaaaaaaaaaaa $$m aaaaaaaaaaaa\"
        cd tensorflow/chezscheme/ChezScheme
        ./configure --threads
        pwd
        cd -
        ls tensorflow/chezscheme/ChezScheme/$$m/c
        cp tensorflow/chezscheme/ChezScheme/$$m/c/alloc.c $(@D)
        """,
            visibility = ["//visibility:public"],
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

