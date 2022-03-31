# dependencies:
# immediate dependencies:
# libraries:
# libcairo-gobject.so.2
{.warning[UnusedImport]: off.}

const Lib = "libcairo-gobject.so.2"
{.pragma: libprag, cdecl, dynlib: Lib.}

from gobject import boxedFree
from glib import GType

type
  Context00* {.pure.} = object
  Context* = ref object of RootRef
    impl*: ptr Context00
    ignoreFinalizer*: bool

proc cairo_gobject_context_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoContext*(self: Context) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_context_get_type(), cast[ptr Context00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Context()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_context_get_type(), cast[ptr Context00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Context) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoContext)

type
  Device00* {.pure.} = object
  Device* = ref object of RootRef
    impl*: ptr Device00
    ignoreFinalizer*: bool

proc cairo_gobject_device_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoDevice*(self: Device) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_device_get_type(), cast[ptr Device00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Device()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_device_get_type(), cast[ptr Device00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Device) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoDevice)

type
  Surface00* {.pure.} = object
  Surface* = ref object of RootRef
    impl*: ptr Surface00
    ignoreFinalizer*: bool

proc cairo_gobject_surface_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoSurface*(self: Surface) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_surface_get_type(), cast[ptr Surface00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Surface()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_surface_get_type(), cast[ptr Surface00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Surface) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoSurface)

type
  Matrix00* {.pure.} = object
  Matrix* = ref object of RootRef
    impl*: ptr Matrix00
    ignoreFinalizer*: bool

type
  Pattern00* {.pure.} = object
  Pattern* = ref object of RootRef
    impl*: ptr Pattern00
    ignoreFinalizer*: bool

proc cairo_gobject_pattern_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoPattern*(self: Pattern) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_pattern_get_type(), cast[ptr Pattern00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Pattern()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_pattern_get_type(), cast[ptr Pattern00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Pattern) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoPattern)

type
  Region00* {.pure.} = object
  Region* = ref object of RootRef
    impl*: ptr Region00
    ignoreFinalizer*: bool

proc cairo_gobject_region_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoRegion*(self: Region) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_region_get_type(), cast[ptr Region00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Region()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_region_get_type(), cast[ptr Region00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Region) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoRegion)

type
  Status* {.size: sizeof(cint), pure.} = enum
    success = 0
    noMemory = 1
    invalidRestore = 2
    invalidPopGroup = 3
    noCurrentPoint = 4
    invalidMatrix = 5
    invalidStatus = 6
    nullPointer = 7
    invalidString = 8
    invalidPathData = 9
    readError = 10
    writeError = 11
    surfaceFinished = 12
    surfaceTypeMismatch = 13
    patternTypeMismatch = 14
    invalidContent = 15
    invalidFormat = 16
    invalidVisual = 17
    fileNotFound = 18
    invalidDash = 19
    invalidDscComment = 20
    invalidIndex = 21
    clipNotRepresentable = 22
    tempFileError = 23
    invalidStride = 24
    fontTypeMismatch = 25
    userFontImmutable = 26
    userFontError = 27
    negativeCount = 28
    invalidClusters = 29
    invalidSlant = 30
    invalidWeight = 31
    invalidSize = 32
    userFontNotImplemented = 33
    deviceTypeMismatch = 34
    deviceError = 35
    invalidMeshConstruction = 36
    deviceFinished = 37
    jbig2GlobalMissing = 38

type
  Content* {.size: sizeof(cint), pure.} = enum
    color = 4096
    alpha = 8192
    colorAlpha = 12288

type
  Operator* {.size: sizeof(cint), pure.} = enum
    clear = 0
    source = 1
    over = 2
    `in` = 3
    `out` = 4
    atop = 5
    dest = 6
    destOver = 7
    destIn = 8
    destOut = 9
    destAtop = 10
    `xor` = 11
    add = 12
    saturate = 13
    multiply = 14
    screen = 15
    overlay = 16
    darken = 17
    lighten = 18
    colorDodge = 19
    colorBurn = 20
    hardLight = 21
    softLight = 22
    difference = 23
    exclusion = 24
    hslHue = 25
    hslSaturation = 26
    hslColor = 27
    hslLuminosity = 28

type
  Antialias* {.size: sizeof(cint), pure.} = enum
    default = 0
    none = 1
    gray = 2
    subpixel = 3
    fast = 4
    good = 5
    best = 6

type
  FillRule* {.size: sizeof(cint), pure.} = enum
    winding = 0
    evenOdd = 1

type
  LineCap* {.size: sizeof(cint), pure.} = enum
    butt = 0
    round = 1
    square = 2

type
  LineJoin* {.size: sizeof(cint), pure.} = enum
    miter = 0
    round = 1
    bevel = 2

type
  TextClusterFlags* {.size: sizeof(cint), pure.} = enum
    backward = 1

type
  FontSlant* {.size: sizeof(cint), pure.} = enum
    normal = 0
    italic = 1
    oblique = 2

type
  FontWeight* {.size: sizeof(cint), pure.} = enum
    normal = 0
    bold = 1

type
  SubpixelOrder* {.size: sizeof(cint), pure.} = enum
    default = 0
    rgb = 1
    bgr = 2
    vrgb = 3
    vbgr = 4

type
  HintStyle* {.size: sizeof(cint), pure.} = enum
    default = 0
    none = 1
    slight = 2
    medium = 3
    full = 4

type
  HintMetrics* {.size: sizeof(cint), pure.} = enum
    default = 0
    off = 1
    on = 2

type
  FontOptions00* {.pure.} = object
  FontOptions* = ref object of RootRef
    impl*: ptr FontOptions00
    ignoreFinalizer*: bool

proc cairo_gobject_font_options_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoFontOptions*(self: FontOptions) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_font_options_get_type(), cast[ptr FontOptions00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontOptions()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_font_options_get_type(), cast[ptr FontOptions00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FontOptions) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoFontOptions)

type
  FontType* {.size: sizeof(cint), pure.} = enum
    toy = 0
    ft = 1
    win32 = 2
    quartz = 3
    user = 4

type
  PathDataType* {.size: sizeof(cint), pure.} = enum
    moveTo = 0
    lineTo = 1
    curveTo = 2
    closePath = 3

type
  DeviceType* {.size: sizeof(cint), pure.} = enum
    invalid = -1
    drm = 0
    gl = 1
    script = 2
    xcb = 3
    xlib = 4
    xml = 5
    cogl = 6
    win32 = 7

type
  SurfaceType* {.size: sizeof(cint), pure.} = enum
    image = 0
    pdf = 1
    ps = 2
    xlib = 3
    xcb = 4
    glitz = 5
    quartz = 6
    win32 = 7
    beos = 8
    directfb = 9
    svg = 10
    os2 = 11
    win32Printing = 12
    quartzImage = 13
    script = 14
    qt = 15
    recording = 16
    vg = 17
    gl = 18
    drm = 19
    tee = 20
    xml = 21
    skia = 22
    subsurface = 23
    cogl = 24

type
  Format* {.size: sizeof(cint), pure.} = enum
    invalid = -1
    argb32 = 0
    rgb24 = 1
    a8 = 2
    a1 = 3
    rgb16_565 = 4
    rgb30 = 5

type
  PatternType* {.size: sizeof(cint), pure.} = enum
    solid = 0
    surface = 1
    linear = 2
    radial = 3
    mesh = 4
    rasterSource = 5

type
  Extend* {.size: sizeof(cint), pure.} = enum
    none = 0
    repeat = 1
    reflect = 2
    pad = 3

type
  Filter* {.size: sizeof(cint), pure.} = enum
    fast = 0
    good = 1
    best = 2
    nearest = 3
    bilinear = 4
    gaussian = 5

type
  RegionOverlap* {.size: sizeof(cint), pure.} = enum
    `in` = 0
    `out` = 1
    part = 2

type
  FontFace00* {.pure.} = object
  FontFace* = ref object of RootRef
    impl*: ptr FontFace00
    ignoreFinalizer*: bool

proc cairo_gobject_font_face_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoFontFace*(self: FontFace) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_font_face_get_type(), cast[ptr FontFace00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontFace()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_font_face_get_type(), cast[ptr FontFace00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FontFace) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoFontFace)

type
  ScaledFont00* {.pure.} = object
  ScaledFont* = ref object of RootRef
    impl*: ptr ScaledFont00
    ignoreFinalizer*: bool

proc cairo_gobject_scaled_font_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeCairoScaledFont*(self: ScaledFont) =
  if not self.ignoreFinalizer and  self.impl != nil:
    boxedFree(cairo_gobject_scaled_font_get_type(), cast[ptr ScaledFont00](self.impl))
    self.impl = nil

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ScaledFont()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(cairo_gobject_scaled_font_get_type(), cast[ptr ScaledFont00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ScaledFont) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeCairoScaledFont)

type
  Path00* {.pure.} = object
  Path* = ref object of RootRef
    impl*: ptr Path00
    ignoreFinalizer*: bool

type
  Rectangle* {.pure, byRef.} = object
    x*: cdouble
    y*: cdouble
    width*: cdouble
    height*: cdouble

proc cairo_gobject_rectangle_get_type*(): GType {.importc, libprag.}

type
  RectangleInt* {.pure, byRef.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32

proc cairo_gobject_rectangle_int_get_type*(): GType {.importc, libprag.}

proc imageSurfaceCreate*() {.
    importc: "cairo_image_surface_create", libprag.}
# === remaining symbols:

include cairoimpl
