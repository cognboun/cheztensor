""" config build ChezScheme """


def lz4_source_file():
    path = "ChezScheme/"
    _source_files = [
        path + "lz4/lib/lz4.c",
        path + "lz4/lib/lz4frame.c",
        path + "lz4/lib/lz4hc.c",
        path + "lz4/lib/xxhash.c",]
    return _source_files

def lz4_hdrs_file():
    path = "ChezScheme/"
    _hdrs_files = [
        path + "lz4/lib/lz4.h",
        path + "lz4/lib/lz4.inc",
        path + "lz4/lib/lz4frame.h",
        path + "lz4/lib/lz4hc.h",
        path + "lz4/lib/xxhash.h",
        ]
    return _hdrs_files

def cs_source_files():
    path = "ChezScheme/tf_chezscheme/c/"
    _source_files = [
        path + "alloc.c",
        path + "statics.c",
        path + "segment.c",
        path + "symbol.c",
        path + "intern.c",
        path + "gcwrapper.c",
        path + "gc-ocd.c",
        path + "gc-oce.c",
        path + "number.c",
        path + "schsig.c",
        path + "io.c",
        path + "new-io.c",
        path + "print.c",
        path + "fasl.c",
        path + "stats.c",
        path + "foreign.c",
        path + "prim.c",
        path + "prim5.c",
        path + "flushcache.c",
        path + "schlib.c",
        path + "thread.c",
        path + "expeditor.c",
        path + "scheme.c",
        path + "compress-io.c",
        path + "i3le.c"]
    return _source_files

def cs_hdrs_files():
    path = "ChezScheme/tf_chezscheme/c/"
    boot_path = "ChezScheme/tf_chezscheme/boot/tf_boot/"
    _hdrs_files = [
        path + "gc.c",
        path + "system.h",
        path + "version.h",
        path + "config.h",
        path + "thread.h",
        path + "compress-io.h",
        path + "globals.h",
        path + "externs.h",
        path + "segment.h",
        path + "types.h",
        path + "sort.h",
        boot_path + "scheme.h",
        boot_path + "equates.h"]
    return _hdrs_files
