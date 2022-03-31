# dependencies:
# immediate dependencies:
# libraries:
# 
{.warning[UnusedImport]: off.}

const Lib = ""
{.pragma: libprag, cdecl, dynlib: Lib.}

type
  Bitmap00* {.pure.} = object
  Bitmap* = ref object
    impl*: ptr Bitmap00
    ignoreFinalizer*: bool

type
  Face00* {.pure.} = object
  Face* = ref object
    impl*: ptr Face00
    ignoreFinalizer*: bool

type
  Library00* {.pure.} = object
  Library* = ref object
    impl*: ptr Library00
    ignoreFinalizer*: bool

proc libraryVersion*() {.
    importc: "FT_Library_Version", libprag.}
# === remaining symbols:
