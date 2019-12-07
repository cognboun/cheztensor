# Description:
# ChezScheme support for TensorFlow.
#
# Public targets:
#  gen_chezscheme_source
#  tf_chezscheme
#
# Usage:
# bazel build -c opt --verbose_failures //tensorflow/chezscheme:gen_chezscheme_source
# bazel build -c opt --verbose_failures//tensorflow/chezscheme:tf_chezscheme
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
    "VERSION",
    "tf_cc_test",
    "tf_cc_binary",
    "tf_copts",
    "tf_gen_op_wrappers_cc",
    "tf_cc_shared_object",
)
load(
    ":config_chezscheme.bzl",
    "lz4_source_file",
    "lz4_hdrs_file",
    "cs_source_files",
    "cs_hdrs_files",
)

genrule(
    name = "gen_chezscheme_source",
    srcs = [],
    outs = ["bin/run.sh",
            "bin/scheme",
            "boot/equates.h",
            "boot/scheme.h",
            "boot/petite.boot",
            "boot/scheme.boot"],
    cmd = """

            threads=yes
            #threads=no

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

        if [ $$threads = yes ] ; then THREADOPT=\"--threads\" ; else THREADOPT=\"\" ; fi

        cd tensorflow/chezscheme/ChezScheme
        ./configure CPPFLAGS=-DFEATURE_TENSORFLOW $$THREADOPT
        make
        # create logical path
        ln -s $$m tf_chezscheme
        cd tf_chezscheme/boot
        ln -s $$m tf_boot
        cd ../../
        cd ../../../

        for f in $(OUTS); do
            if [[ ! $$f =~ run.sh ]]; then
                if [[ $$f =~ bin/scheme ]]; then
                    cp tensorflow/chezscheme/ChezScheme/$$m/bin/$${f##*/} $(@D)/bin
                else
                    cp tensorflow/chezscheme/ChezScheme/$$m/boot/$$m/$${f##*/} $(@D)/boot
                fi
            fi
        done

        echo \"\"\"
        ./scheme -b ../boot/petite.boot -b ../boot/scheme.boot
        \"\"\" > $(@D)/bin/run.sh

        """,
            visibility = ["//visibility:public"],
)

cc_library(
    name = "lz4",
    srcs = lz4_source_file(),
    hdrs = lz4_hdrs_file(),
    copts = tf_copts() + ["-DX86_64"],
)

cc_library(
    name = "chezscheme",
    srcs = cs_source_files(),
    hdrs = cs_hdrs_files(),
    copts = tf_copts() + ["-I./tensorflow/chezscheme/ChezScheme/tf_chezscheme/boot/tf_boot/",
                          "-I./tensorflow/chezscheme/ChezScheme/lz4/lib/"]
                       + ["-DFEATURE_TENSORFLOW", "-DX86_64"],
    deps = [
        ":lz4",
    ],
)


cc_library(
    name = "one_chezscheme",
    srcs = cs_source_files() + lz4_source_file(),
    hdrs = cs_hdrs_files() + lz4_hdrs_file(),
    copts = tf_copts() + ["-I./tensorflow/chezscheme/ChezScheme/tf_chezscheme/boot/tf_boot/",
                          "-I./tensorflow/chezscheme/ChezScheme/lz4/lib/"]
                       + ["-DFEATURE_TENSORFLOW", "-DX86_64"],
)

cc_library(
    name = "chezscheme_for_tensorflow",
    srcs = [
            "chezscheme_for_tensorflow/tensorflow.c",
            "chezscheme_for_tensorflow/tf_util.cc"],
    hdrs = [
            "chezscheme_for_tensorflow/tf_util.h",
    ],
    copts = tf_copts() + ["-I./tensorflow/chezscheme/ChezScheme/tf_chezscheme/c/",
                          "-I./tensorflow/chezscheme/ChezScheme/tf_chezscheme/boot/tf_boot/",]
                       + ["-DX86_64"],
    deps = [
        ":chezscheme",
        "//tensorflow/core:tensorflow",
        "//tensorflow/cc:cc_ops",
        "//tensorflow/core:core_cpu",
        "//tensorflow/core:framework",
        "//tensorflow/core:lib",
        "//tensorflow/core:protos_all_cc",
    ],
)    


tf_cc_shared_object(
    name = "chezscheme_for_tensorflow_so",
    linkopts = select({
        "//tensorflow:macos": [
            "-Wl",
        ],
        "//tensorflow:windows": [],
        "//conditions:default": [
            "-z defs",
            "-Wl",
        ],
    }),
    per_os_targets = True,
    soversion = VERSION,
    visibility = ["//visibility:public"],
    # add win_def_file for tensorflow_cc
    win_def_file = select({
        # We need this DEF file to properly export symbols on Windows
        "//tensorflow:windows": ":tensorflow_filtered_def_file",
        "//conditions:default": None,
    }),
    deps = [
        ":chezscheme",
        "//tensorflow/core:tensorflow",
        "//tensorflow/cc:cc_ops",
        "//tensorflow/core:core_cpu",
        "//tensorflow/core:framework",
        "//tensorflow/core:lib",
        "//tensorflow/core:protos_all_cc",
    ],
)

tf_cc_binary(
    name = "tf_chezscheme",
    srcs = ["tf_chezscheme.c"],
    copts = tf_copts() + ["-I./tensorflow/chezscheme/ChezScheme/tf_chezscheme/c/",
                          "-I./tensorflow/chezscheme/ChezScheme/tf_chezscheme/boot/tf_boot/",]
                       + ["-DX86_64"],
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
    ],
)
