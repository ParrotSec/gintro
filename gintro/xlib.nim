# dependencies:
# immediate dependencies:
# libraries:
# 
{.warning[UnusedImport]: off.}

const Lib = ""
{.pragma: libprag, cdecl, dynlib: Lib.}

type
  Display00* {.pure.} = object
  Display* = ref object
    impl*: ptr Display00
    ignoreFinalizer*: bool

type
  Screen00* {.pure.} = object
  Screen* = ref object
    impl*: ptr Screen00
    ignoreFinalizer*: bool

type
  Visual00* {.pure.} = object
  Visual* = ref object
    impl*: ptr Visual00
    ignoreFinalizer*: bool

type
  XEvent00* {.pure, union.} = object
  XEvent* = ref object
    impl*: ptr XEvent00
    ignoreFinalizer*: bool

type
  XConfigureEvent00* {.pure.} = object
  XConfigureEvent* = ref object
    impl*: ptr XConfigureEvent00
    ignoreFinalizer*: bool

type
  XImage00* {.pure.} = object
  XImage* = ref object
    impl*: ptr XImage00
    ignoreFinalizer*: bool

type
  XFontStruct00* {.pure.} = object
  XFontStruct* = ref object
    impl*: ptr XFontStruct00
    ignoreFinalizer*: bool

type
  XTrapezoid00* {.pure.} = object
  XTrapezoid* = ref object
    impl*: ptr XTrapezoid00
    ignoreFinalizer*: bool

type
  XVisualInfo00* {.pure.} = object
  XVisualInfo* = ref object
    impl*: ptr XVisualInfo00
    ignoreFinalizer*: bool

type
  XWindowAttributes00* {.pure.} = object
  XWindowAttributes* = ref object
    impl*: ptr XWindowAttributes00
    ignoreFinalizer*: bool

proc openDisplay*() {.
    importc: "XOpenDisplay", libprag.}
# === remaining symbols:
