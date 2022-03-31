# dependencies:
# immediate dependencies:
# libraries:
# 
{.warning[UnusedImport]: off.}

const Lib = ""
{.pragma: libprag, cdecl, dynlib: Lib.}

type
  Pattern00* {.pure.} = object
  Pattern* = ref object
    impl*: ptr Pattern00
    ignoreFinalizer*: bool

type
  CharSet00* {.pure.} = object
  CharSet* = ref object
    impl*: ptr CharSet00
    ignoreFinalizer*: bool

proc init*() {.
    importc: "FcInit", libprag.}
# === remaining symbols:
