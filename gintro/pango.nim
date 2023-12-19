# dependencies:
# GObject-2.0
# cairo-1.0
# GLib-2.0
# HarfBuzz-0.0
# immediate dependencies:
# cairo-1.0
# HarfBuzz-0.0
# GObject-2.0
# libraries:
# libpango-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, cairo, glib, harfbuzz
const Lib = "libpango-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const ANALYSIS_FLAG_CENTERED_BASELINE* = 1'i32

const ANALYSIS_FLAG_IS_ELLIPSIS* = 2'i32

const ANALYSIS_FLAG_NEED_HYPHEN* = 4'i32


type
  Alignment* {.size: sizeof(cint), pure.} = enum
    left = 0
    center = 1
    right = 2

type
  Analysis00* {.pure.} = object
  Analysis* = ref object
    impl*: ptr Analysis00
    ignoreFinalizer*: bool

type
  AttrClass00* {.pure.} = object
  AttrClass* = ref object
    impl*: ptr AttrClass00
    ignoreFinalizer*: bool

type
  AttrColor00* {.pure.} = object
  AttrColor* = ref object
    impl*: ptr AttrColor00
    ignoreFinalizer*: bool

type
  AttrDataCopyFunc* = proc (userData: pointer): pointer {.cdecl.}

type
  Attribute00* {.pure.} = object
    klass*: ptr AttrClass00
    startIndex*: uint32
    endIndex*: uint32
  Attribute* = ref object
    impl*: ptr Attribute00
    ignoreFinalizer*: bool

proc pango_attribute_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoAttribute*(self: Attribute) =
  if not self.ignoreFinalizer:
    boxedFree(pango_attribute_get_type(), cast[ptr Attribute00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Attribute()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_attribute_get_type(), cast[ptr Attribute00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Attribute) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoAttribute)

proc pango_attribute_destroy(self: ptr Attribute00) {.
    importc, libprag.}

proc destroy*(self: Attribute) =
  pango_attribute_destroy(cast[ptr Attribute00](self.impl))

proc finalizerdestroy*(self: Attribute) =
  if not self.ignoreFinalizer:
    pango_attribute_destroy(cast[ptr Attribute00](self.impl))

proc pango_attribute_copy(self: ptr Attribute00): ptr Attribute00 {.
    importc, libprag.}

proc copy*(self: Attribute): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attribute_copy(cast[ptr Attribute00](self.impl))

proc pango_attribute_equal(self: ptr Attribute00; attr2: ptr Attribute00): gboolean {.
    importc, libprag.}

proc equal*(self: Attribute; attr2: Attribute): bool =
  toBool(pango_attribute_equal(cast[ptr Attribute00](self.impl), cast[ptr Attribute00](attr2.impl)))

proc pango_attribute_init(self: ptr Attribute00; klass: ptr AttrClass00) {.
    importc, libprag.}

proc init*(self: Attribute; klass: AttrClass) =
  pango_attribute_init(cast[ptr Attribute00](self.impl), cast[ptr AttrClass00](klass.impl))

type
  AttrFilterFunc* = proc (attribute: ptr Attribute00; userData: pointer): gboolean {.cdecl.}

type
  AttrFloat00* {.pure.} = object
  AttrFloat* = ref object
    impl*: ptr AttrFloat00
    ignoreFinalizer*: bool

type
  AttrFontDesc00* {.pure.} = object
  AttrFontDesc* = ref object
    impl*: ptr AttrFontDesc00
    ignoreFinalizer*: bool

type
  FontDescription00* {.pure.} = object
  FontDescription* = ref object
    impl*: ptr FontDescription00
    ignoreFinalizer*: bool

proc pango_font_description_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoFontDescription*(self: FontDescription) =
  if not self.ignoreFinalizer:
    boxedFree(pango_font_description_get_type(), cast[ptr FontDescription00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontDescription()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_font_description_get_type(), cast[ptr FontDescription00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FontDescription) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoFontDescription)

proc pango_font_description_free(self: ptr FontDescription00) {.
    importc, libprag.}

proc free*(self: FontDescription) =
  pango_font_description_free(cast[ptr FontDescription00](self.impl))

proc finalizerfree*(self: FontDescription) =
  if not self.ignoreFinalizer:
    pango_font_description_free(cast[ptr FontDescription00](self.impl))

proc pango_font_description_better_match(self: ptr FontDescription00; oldMatch: ptr FontDescription00;
    newMatch: ptr FontDescription00): gboolean {.
    importc, libprag.}

proc betterMatch*(self: FontDescription; oldMatch: FontDescription = nil;
    newMatch: FontDescription): bool =
  toBool(pango_font_description_better_match(cast[ptr FontDescription00](self.impl), if oldMatch.isNil: nil else: cast[ptr FontDescription00](oldMatch.impl), cast[ptr FontDescription00](newMatch.impl)))

proc pango_font_description_copy(self: ptr FontDescription00): ptr FontDescription00 {.
    importc, libprag.}

proc copy*(self: FontDescription): FontDescription =
  let impl0 = pango_font_description_copy(cast[ptr FontDescription00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = impl0

proc pango_font_description_copy_static(self: ptr FontDescription00): ptr FontDescription00 {.
    importc, libprag.}

proc copyStatic*(self: FontDescription): FontDescription =
  let impl0 = pango_font_description_copy_static(cast[ptr FontDescription00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = impl0

proc pango_font_description_equal(self: ptr FontDescription00; desc2: ptr FontDescription00): gboolean {.
    importc, libprag.}

proc equal*(self: FontDescription; desc2: FontDescription): bool =
  toBool(pango_font_description_equal(cast[ptr FontDescription00](self.impl), cast[ptr FontDescription00](desc2.impl)))

proc pango_font_description_new(): ptr FontDescription00 {.
    importc, libprag.}

proc newFontDescription*(): FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_font_description_new()

proc newFontDescription*(tdesc: typedesc): tdesc =
  assert(result is FontDescription)
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_font_description_new()

proc initFontDescription*[T](result: var T) {.deprecated.} =
  assert(result is FontDescription)
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_font_description_new()

proc pango_font_description_get_family(self: ptr FontDescription00): cstring {.
    importc, libprag.}

proc getFamily*(self: FontDescription): string =
  let resul0 = pango_font_description_get_family(cast[ptr FontDescription00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc family*(self: FontDescription): string =
  let resul0 = pango_font_description_get_family(cast[ptr FontDescription00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc pango_font_description_get_size(self: ptr FontDescription00): int32 {.
    importc, libprag.}

proc getSize*(self: FontDescription): int =
  int(pango_font_description_get_size(cast[ptr FontDescription00](self.impl)))

proc size*(self: FontDescription): int =
  int(pango_font_description_get_size(cast[ptr FontDescription00](self.impl)))

proc pango_font_description_get_size_is_absolute(self: ptr FontDescription00): gboolean {.
    importc, libprag.}

proc getSizeIsAbsolute*(self: FontDescription): bool =
  toBool(pango_font_description_get_size_is_absolute(cast[ptr FontDescription00](self.impl)))

proc sizeIsAbsolute*(self: FontDescription): bool =
  toBool(pango_font_description_get_size_is_absolute(cast[ptr FontDescription00](self.impl)))

proc pango_font_description_get_variations(self: ptr FontDescription00): cstring {.
    importc, libprag.}

proc getVariations*(self: FontDescription): string =
  let resul0 = pango_font_description_get_variations(cast[ptr FontDescription00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc variations*(self: FontDescription): string =
  let resul0 = pango_font_description_get_variations(cast[ptr FontDescription00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc pango_font_description_hash(self: ptr FontDescription00): uint32 {.
    importc, libprag.}

proc hash*(self: FontDescription): int =
  int(pango_font_description_hash(cast[ptr FontDescription00](self.impl)))

proc pango_font_description_merge(self: ptr FontDescription00; descToMerge: ptr FontDescription00;
    replaceExisting: gboolean) {.
    importc, libprag.}

proc merge*(self: FontDescription; descToMerge: FontDescription = nil;
    replaceExisting: bool) =
  pango_font_description_merge(cast[ptr FontDescription00](self.impl), if descToMerge.isNil: nil else: cast[ptr FontDescription00](descToMerge.impl), gboolean(replaceExisting))

proc pango_font_description_merge_static(self: ptr FontDescription00; descToMerge: ptr FontDescription00;
    replaceExisting: gboolean) {.
    importc, libprag.}

proc mergeStatic*(self: FontDescription; descToMerge: FontDescription;
    replaceExisting: bool) =
  pango_font_description_merge_static(cast[ptr FontDescription00](self.impl), cast[ptr FontDescription00](descToMerge.impl), gboolean(replaceExisting))

proc pango_font_description_set_absolute_size(self: ptr FontDescription00;
    size: cdouble) {.
    importc, libprag.}

proc setAbsoluteSize*(self: FontDescription; size: cdouble) =
  pango_font_description_set_absolute_size(cast[ptr FontDescription00](self.impl), size)

proc `absoluteSize=`*(self: FontDescription; size: cdouble) =
  pango_font_description_set_absolute_size(cast[ptr FontDescription00](self.impl), size)

proc pango_font_description_set_family(self: ptr FontDescription00; family: cstring) {.
    importc, libprag.}

proc setFamily*(self: FontDescription; family: cstring) =
  pango_font_description_set_family(cast[ptr FontDescription00](self.impl), family)

proc `family=`*(self: FontDescription; family: cstring) =
  pango_font_description_set_family(cast[ptr FontDescription00](self.impl), family)

proc pango_font_description_set_family_static(self: ptr FontDescription00;
    family: cstring) {.
    importc, libprag.}

proc setFamilyStatic*(self: FontDescription; family: cstring) =
  pango_font_description_set_family_static(cast[ptr FontDescription00](self.impl), family)

proc `familyStatic=`*(self: FontDescription; family: cstring) =
  pango_font_description_set_family_static(cast[ptr FontDescription00](self.impl), family)

proc pango_font_description_set_size(self: ptr FontDescription00; size: int32) {.
    importc, libprag.}

proc setSize*(self: FontDescription; size: int) =
  pango_font_description_set_size(cast[ptr FontDescription00](self.impl), int32(size))

proc `size=`*(self: FontDescription; size: int) =
  pango_font_description_set_size(cast[ptr FontDescription00](self.impl), int32(size))

proc pango_font_description_set_variations(self: ptr FontDescription00; variations: cstring) {.
    importc, libprag.}

proc setVariations*(self: FontDescription; variations: cstring) =
  pango_font_description_set_variations(cast[ptr FontDescription00](self.impl), variations)

proc `variations=`*(self: FontDescription; variations: cstring) =
  pango_font_description_set_variations(cast[ptr FontDescription00](self.impl), variations)

proc pango_font_description_set_variations_static(self: ptr FontDescription00;
    variations: cstring) {.
    importc, libprag.}

proc setVariationsStatic*(self: FontDescription;
    variations: cstring) =
  pango_font_description_set_variations_static(cast[ptr FontDescription00](self.impl), variations)

proc `variationsStatic=`*(self: FontDescription;
    variations: cstring) =
  pango_font_description_set_variations_static(cast[ptr FontDescription00](self.impl), variations)

proc pango_font_description_to_filename(self: ptr FontDescription00): cstring {.
    importc, libprag.}

proc toFilename*(self: FontDescription): string =
  let resul0 = pango_font_description_to_filename(cast[ptr FontDescription00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pango_font_description_to_string(self: ptr FontDescription00): cstring {.
    importc, libprag.}

proc toString*(self: FontDescription): string =
  let resul0 = pango_font_description_to_string(cast[ptr FontDescription00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pango_font_description_from_string(str: cstring): ptr FontDescription00 {.
    importc, libprag.}

proc newFontDescription*(str: cstring): FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_font_description_from_string(str)

proc pango_attr_font_desc_new(desc: ptr FontDescription00): ptr Attribute00 {.
    importc, libprag.}

proc newAttrFontDesc*(desc: FontDescription): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_font_desc_new(cast[ptr FontDescription00](desc.impl))

type
  Gravity* {.size: sizeof(cint), pure.} = enum
    south = 0
    east = 1
    north = 2
    west = 3
    auto = 4

proc toRotation*(gravity: Gravity): cdouble {.
    importc: "pango_gravity_to_rotation", libprag.}

proc pango_font_description_get_gravity(self: ptr FontDescription00): Gravity {.
    importc, libprag.}

proc getGravity*(self: FontDescription): Gravity =
  pango_font_description_get_gravity(cast[ptr FontDescription00](self.impl))

proc gravity*(self: FontDescription): Gravity =
  pango_font_description_get_gravity(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_gravity(self: ptr FontDescription00; gravity: Gravity) {.
    importc, libprag.}

proc setGravity*(self: FontDescription; gravity: Gravity) =
  pango_font_description_set_gravity(cast[ptr FontDescription00](self.impl), gravity)

proc `gravity=`*(self: FontDescription; gravity: Gravity) =
  pango_font_description_set_gravity(cast[ptr FontDescription00](self.impl), gravity)

type
  Matrix00* {.pure.} = object
  Matrix* = ref object
    impl*: ptr Matrix00
    ignoreFinalizer*: bool

proc pango_matrix_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoMatrix*(self: Matrix) =
  if not self.ignoreFinalizer:
    boxedFree(pango_matrix_get_type(), cast[ptr Matrix00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Matrix()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_matrix_get_type(), cast[ptr Matrix00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Matrix) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoMatrix)

proc pango_matrix_free(self: ptr Matrix00) {.
    importc, libprag.}

proc free*(self: Matrix) =
  pango_matrix_free(cast[ptr Matrix00](self.impl))

proc finalizerfree*(self: Matrix) =
  if not self.ignoreFinalizer:
    pango_matrix_free(cast[ptr Matrix00](self.impl))

proc pango_matrix_copy(self: ptr Matrix00): ptr Matrix00 {.
    importc, libprag.}

proc copy*(self: Matrix): Matrix =
  let impl0 = pango_matrix_copy(cast[ptr Matrix00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoMatrix)
  result.impl = impl0

proc pango_matrix_concat(self: ptr Matrix00; newMatrix: ptr Matrix00) {.
    importc, libprag.}

proc concat*(self: Matrix; newMatrix: Matrix) =
  pango_matrix_concat(cast[ptr Matrix00](self.impl), cast[ptr Matrix00](newMatrix.impl))

proc pango_matrix_get_font_scale_factor(self: ptr Matrix00): cdouble {.
    importc, libprag.}

proc getFontScaleFactor*(self: Matrix): cdouble =
  pango_matrix_get_font_scale_factor(cast[ptr Matrix00](self.impl))

proc fontScaleFactor*(self: Matrix): cdouble =
  pango_matrix_get_font_scale_factor(cast[ptr Matrix00](self.impl))

proc pango_matrix_get_font_scale_factors(self: ptr Matrix00; xscale: var cdouble;
    yscale: var cdouble) {.
    importc, libprag.}

proc getFontScaleFactors*(self: Matrix; xscale: var cdouble = cast[var cdouble](nil);
    yscale: var cdouble = cast[var cdouble](nil)) =
  pango_matrix_get_font_scale_factors(cast[ptr Matrix00](self.impl), xscale, yscale)

proc pango_matrix_rotate(self: ptr Matrix00; degrees: cdouble) {.
    importc, libprag.}

proc rotate*(self: Matrix; degrees: cdouble) =
  pango_matrix_rotate(cast[ptr Matrix00](self.impl), degrees)

proc pango_matrix_scale(self: ptr Matrix00; scaleX: cdouble; scaleY: cdouble) {.
    importc, libprag.}

proc scale*(self: Matrix; scaleX: cdouble; scaleY: cdouble) =
  pango_matrix_scale(cast[ptr Matrix00](self.impl), scaleX, scaleY)

proc pango_matrix_transform_distance(self: ptr Matrix00; dx: var cdouble;
    dy: var cdouble) {.
    importc, libprag.}

proc transformDistance*(self: Matrix; dx: var cdouble; dy: var cdouble) =
  pango_matrix_transform_distance(cast[ptr Matrix00](self.impl), dx, dy)

proc pango_matrix_transform_point(self: ptr Matrix00; x: var cdouble; y: var cdouble) {.
    importc, libprag.}

proc transformPoint*(self: Matrix; x: var cdouble; y: var cdouble) =
  pango_matrix_transform_point(cast[ptr Matrix00](self.impl), x, y)

proc pango_matrix_translate(self: ptr Matrix00; tx: cdouble; ty: cdouble) {.
    importc, libprag.}

proc translate*(self: Matrix; tx: cdouble; ty: cdouble) =
  pango_matrix_translate(cast[ptr Matrix00](self.impl), tx, ty)

proc pango_gravity_get_for_matrix(matrix: ptr Matrix00): Gravity {.
    importc, libprag.}

proc getForMatrix*(matrix: Matrix = nil): Gravity =
  pango_gravity_get_for_matrix(if matrix.isNil: nil else: cast[ptr Matrix00](matrix.impl))

proc forMatrix*(matrix: Matrix = nil): Gravity =
  pango_gravity_get_for_matrix(if matrix.isNil: nil else: cast[ptr Matrix00](matrix.impl))

type
  Rectangle* {.pure, byRef.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32

proc pango_matrix_transform_pixel_rectangle(self: ptr Matrix00; rect: var Rectangle) {.
    importc, libprag.}

proc transformPixelRectangle*(self: Matrix; rect: var Rectangle = cast[var Rectangle](nil)) =
  pango_matrix_transform_pixel_rectangle(cast[ptr Matrix00](self.impl), rect)

proc pango_matrix_transform_rectangle(self: ptr Matrix00; rect: var Rectangle) {.
    importc, libprag.}

proc transformRectangle*(self: Matrix; rect: var Rectangle = cast[var Rectangle](nil)) =
  pango_matrix_transform_rectangle(cast[ptr Matrix00](self.impl), rect)

type
  Script* {.size: sizeof(cint), pure.} = enum
    invalidCode = -1
    common = 0
    inherited = 1
    arabic = 2
    armenian = 3
    bengali = 4
    bopomofo = 5
    cherokee = 6
    coptic = 7
    cyrillic = 8
    deseret = 9
    devanagari = 10
    ethiopic = 11
    georgian = 12
    gothic = 13
    greek = 14
    gujarati = 15
    gurmukhi = 16
    han = 17
    hangul = 18
    hebrew = 19
    hiragana = 20
    kannada = 21
    katakana = 22
    khmer = 23
    lao = 24
    latin = 25
    malayalam = 26
    mongolian = 27
    myanmar = 28
    ogham = 29
    oldItalic = 30
    oriya = 31
    runic = 32
    sinhala = 33
    syriac = 34
    tamil = 35
    telugu = 36
    thaana = 37
    thai = 38
    tibetan = 39
    canadianAboriginal = 40
    yi = 41
    tagalog = 42
    hanunoo = 43
    buhid = 44
    tagbanwa = 45
    braille = 46
    cypriot = 47
    limbu = 48
    osmanya = 49
    shavian = 50
    linearB = 51
    taiLe = 52
    ugaritic = 53
    newTaiLue = 54
    buginese = 55
    glagolitic = 56
    tifinagh = 57
    sylotiNagri = 58
    oldPersian = 59
    kharoshthi = 60
    unknown = 61
    balinese = 62
    cuneiform = 63
    phoenician = 64
    phagsPa = 65
    nko = 66
    kayahLi = 67
    lepcha = 68
    rejang = 69
    sundanese = 70
    saurashtra = 71
    cham = 72
    olChiki = 73
    vai = 74
    carian = 75
    lycian = 76
    lydian = 77
    batak = 78
    brahmi = 79
    mandaic = 80
    chakma = 81
    meroiticCursive = 82
    meroiticHieroglyphs = 83
    miao = 84
    sharada = 85
    soraSompeng = 86
    takri = 87
    bassaVah = 88
    caucasianAlbanian = 89
    duployan = 90
    elbasan = 91
    grantha = 92
    khojki = 93
    khudawadi = 94
    linearA = 95
    mahajani = 96
    manichaean = 97
    mendeKikakui = 98
    modi = 99
    mro = 100
    nabataean = 101
    oldNorthArabian = 102
    oldPermic = 103
    pahawhHmong = 104
    palmyrene = 105
    pauCinHau = 106
    psalterPahlavi = 107
    siddham = 108
    tirhuta = 109
    warangCiti = 110
    ahom = 111
    anatolianHieroglyphs = 112
    hatran = 113
    multani = 114
    oldHungarian = 115
    signwriting = 116

proc scriptForUnichar*(ch: gunichar): Script {.
    importc: "pango_script_for_unichar", libprag.}

type
  GravityHint* {.size: sizeof(cint), pure.} = enum
    natural = 0
    strong = 1
    line = 2

proc getForScript*(script: Script; baseGravity: Gravity; hint: GravityHint): Gravity {.
    importc: "pango_gravity_get_for_script", libprag.}

proc pango_gravity_get_for_script_and_width(script: Script; wide: gboolean;
    baseGravity: Gravity; hint: GravityHint): Gravity {.
    importc, libprag.}

proc getForScriptAndWidth*(script: Script; wide: bool; baseGravity: Gravity;
    hint: GravityHint): Gravity =
  pango_gravity_get_for_script_and_width(script, gboolean(wide), baseGravity, hint)

type
  Language00* {.pure.} = object
  Language* = ref object
    impl*: ptr Language00
    ignoreFinalizer*: bool

proc pango_language_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoLanguage*(self: Language) =
  if not self.ignoreFinalizer:
    boxedFree(pango_language_get_type(), cast[ptr Language00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Language()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_language_get_type(), cast[ptr Language00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Language) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoLanguage)

proc pango_language_get_sample_string(self: ptr Language00): cstring {.
    importc, libprag.}

proc getSampleString*(self: Language): string =
  result = $pango_language_get_sample_string(cast[ptr Language00](self.impl))

proc sampleString*(self: Language): string =
  result = $pango_language_get_sample_string(cast[ptr Language00](self.impl))

proc pango_language_get_scripts(self: ptr Language00; numScripts: var int32): ptr Script {.
    importc, libprag.}

proc getScripts*(self: Language; numScripts: var int = cast[var int](nil)): ptr Script =
  var numScripts_00: int32
  let resul0 = pango_language_get_scripts(cast[ptr Language00](self.impl), numScripts_00)
  if resul0.isNil:
    return
  result = resul0
  if numScripts.addr != nil:
    numScripts = int(numScripts_00)

proc pango_language_includes_script(self: ptr Language00; script: Script): gboolean {.
    importc, libprag.}

proc includesScript*(self: Language; script: Script): bool =
  toBool(pango_language_includes_script(cast[ptr Language00](self.impl), script))

proc pango_language_matches(self: ptr Language00; rangeList: cstring): gboolean {.
    importc, libprag.}

proc matches*(self: Language; rangeList: cstring): bool =
  toBool(pango_language_matches(cast[ptr Language00](self.impl), rangeList))

proc pango_language_to_string(self: ptr Language00): cstring {.
    importc, libprag.}

proc toString*(self: Language): string =
  result = $pango_language_to_string(cast[ptr Language00](self.impl))

proc pango_language_from_string(language: cstring): ptr Language00 {.
    importc, libprag.}

proc languageFromString*(language: cstring = nil): Language =
  let impl0 = pango_language_from_string(language)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLanguage)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_language_get_type(), impl0))

proc pango_language_get_default(): ptr Language00 {.
    importc, libprag.}

proc getDefaultLanguage*(): Language =
  fnew(result, gBoxedFreePangoLanguage)
  result.impl = pango_language_get_default()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_language_get_type(), result.impl))

proc pango_script_get_sample_language(script: Script): ptr Language00 {.
    importc, libprag.}

proc getSampleLanguage*(script: Script): Language =
  let impl0 = pango_script_get_sample_language(script)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLanguage)
  result.impl = impl0

proc sampleLanguage*(script: Script): Language =
  let impl0 = pango_script_get_sample_language(script)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLanguage)
  result.impl = impl0

type
  Stretch* {.size: sizeof(cint), pure.} = enum
    ultraCondensed = 0
    extraCondensed = 1
    condensed = 2
    semiCondensed = 3
    normal = 4
    semiExpanded = 5
    expanded = 6
    extraExpanded = 7
    ultraExpanded = 8

proc pango_font_description_get_stretch(self: ptr FontDescription00): Stretch {.
    importc, libprag.}

proc getStretch*(self: FontDescription): Stretch =
  pango_font_description_get_stretch(cast[ptr FontDescription00](self.impl))

proc stretch*(self: FontDescription): Stretch =
  pango_font_description_get_stretch(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_stretch(self: ptr FontDescription00; stretch: Stretch) {.
    importc, libprag.}

proc setStretch*(self: FontDescription; stretch: Stretch) =
  pango_font_description_set_stretch(cast[ptr FontDescription00](self.impl), stretch)

proc `stretch=`*(self: FontDescription; stretch: Stretch) =
  pango_font_description_set_stretch(cast[ptr FontDescription00](self.impl), stretch)

type
  Style* {.size: sizeof(cint), pure.} = enum
    normal = 0
    oblique = 1
    italic = 2

proc pango_font_description_get_style(self: ptr FontDescription00): Style {.
    importc, libprag.}

proc getStyle*(self: FontDescription): Style =
  pango_font_description_get_style(cast[ptr FontDescription00](self.impl))

proc style*(self: FontDescription): Style =
  pango_font_description_get_style(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_style(self: ptr FontDescription00; style: Style) {.
    importc, libprag.}

proc setStyle*(self: FontDescription; style: Style) =
  pango_font_description_set_style(cast[ptr FontDescription00](self.impl), style)

proc `style=`*(self: FontDescription; style: Style) =
  pango_font_description_set_style(cast[ptr FontDescription00](self.impl), style)

type
  Variant* {.size: sizeof(cint), pure.} = enum
    normal = 0
    smallCaps = 1

proc pango_font_description_get_variant(self: ptr FontDescription00): Variant {.
    importc, libprag.}

proc getVariant*(self: FontDescription): Variant =
  pango_font_description_get_variant(cast[ptr FontDescription00](self.impl))

proc variant*(self: FontDescription): Variant =
  pango_font_description_get_variant(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_variant(self: ptr FontDescription00; variant: Variant) {.
    importc, libprag.}

proc setVariant*(self: FontDescription; variant: Variant) =
  pango_font_description_set_variant(cast[ptr FontDescription00](self.impl), variant)

proc `variant=`*(self: FontDescription; variant: Variant) =
  pango_font_description_set_variant(cast[ptr FontDescription00](self.impl), variant)

type
  Weight* {.size: sizeof(cint), pure.} = enum
    thin = 100
    ultralight = 200
    light = 300
    semilight = 350
    book = 380
    normal = 400
    medium = 500
    semibold = 600
    bold = 700
    ultrabold = 800
    heavy = 900
    ultraheavy = 1000

proc pango_font_description_get_weight(self: ptr FontDescription00): Weight {.
    importc, libprag.}

proc getWeight*(self: FontDescription): Weight =
  pango_font_description_get_weight(cast[ptr FontDescription00](self.impl))

proc weight*(self: FontDescription): Weight =
  pango_font_description_get_weight(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_weight(self: ptr FontDescription00; weight: Weight) {.
    importc, libprag.}

proc setWeight*(self: FontDescription; weight: Weight) =
  pango_font_description_set_weight(cast[ptr FontDescription00](self.impl), weight)

proc `weight=`*(self: FontDescription; weight: Weight) =
  pango_font_description_set_weight(cast[ptr FontDescription00](self.impl), weight)

type
  FontMask* {.size: sizeof(cint), pure.} = enum
    family = 1
    style = 2
    variant = 4
    weight = 8
    stretch = 16
    size = 32
    gravity = 64
    variations = 128

proc pango_font_description_get_set_fields(self: ptr FontDescription00): FontMask {.
    importc, libprag.}

proc getSetFields*(self: FontDescription): FontMask =
  pango_font_description_get_set_fields(cast[ptr FontDescription00](self.impl))

proc `fields=`*(self: FontDescription): FontMask =
  pango_font_description_get_set_fields(cast[ptr FontDescription00](self.impl))

proc pango_font_description_unset_fields(self: ptr FontDescription00; toUnset: FontMask) {.
    importc, libprag.}

proc unsetFields*(self: FontDescription; toUnset: FontMask) =
  pango_font_description_unset_fields(cast[ptr FontDescription00](self.impl), toUnset)

type
  AttrFontFeatures00* {.pure.} = object
  AttrFontFeatures* = ref object
    impl*: ptr AttrFontFeatures00
    ignoreFinalizer*: bool

proc pango_attr_font_features_new(features: cstring): ptr Attribute00 {.
    importc, libprag.}

proc newAttrFontFeatures*(features: cstring): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_font_features_new(features)

type
  AttrInt00* {.pure.} = object
  AttrInt* = ref object
    impl*: ptr AttrInt00
    ignoreFinalizer*: bool

type
  AttrIterator* {.pure, byRef.} = object

proc pango_attr_iterator_get_type*(): GType {.importc, libprag.}

proc pango_attr_iterator_destroy(self: AttrIterator) {.
    importc, libprag.}

proc destroy*(self: AttrIterator) =
  pango_attr_iterator_destroy(self)

proc pango_attr_iterator_copy(self: AttrIterator): ptr AttrIterator {.
    importc, libprag.}

proc copy*(self: AttrIterator): ptr AttrIterator =
  pango_attr_iterator_copy(self)

proc pango_attr_iterator_get_attrs(self: AttrIterator): ptr glib.SList {.
    importc, libprag.}

proc getAttrs*(self: AttrIterator): seq[Attribute] =
  let resul0 = pango_attr_iterator_get_attrs(self)
  result = gslistStructs2seq[Attribute](resul0, false)
  g_slist_free(resul0)

proc attrs*(self: AttrIterator): seq[Attribute] =
  let resul0 = pango_attr_iterator_get_attrs(self)
  result = gslistStructs2seq[Attribute](resul0, false)
  g_slist_free(resul0)

proc pango_attr_iterator_get_font(self: AttrIterator; desc: ptr FontDescription00;
    language: ptr Language00; extraAttrs: ptr glib.SList) {.
    importc, libprag.}

proc getFont*(self: AttrIterator; desc: FontDescription;
    language: Language = nil; extraAttrs: seq[Attribute]) =
  var tempResGL = seq2GSList(extraAttrs)
  pango_attr_iterator_get_font(self, cast[ptr FontDescription00](desc.impl), if language.isNil: nil else: cast[ptr Language00](language.impl), tempResGL)

proc pango_attr_iterator_next(self: AttrIterator): gboolean {.
    importc, libprag.}

proc next*(self: AttrIterator): bool =
  toBool(pango_attr_iterator_next(self))

proc pango_attr_iterator_range(self: AttrIterator; start: var int32; `end`: var int32) {.
    importc, libprag.}

proc range*(self: AttrIterator; start: var int; `end`: var int) =
  var start_00: int32
  var end_00: int32
  pango_attr_iterator_range(self, start_00, end_00)
  if start.addr != nil:
    start = int(start_00)
  if `end`.addr != nil:
    `end` = int(end_00)

type
  AttrType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    language = 1
    family = 2
    style = 3
    weight = 4
    variant = 5
    stretch = 6
    size = 7
    fontDesc = 8
    foreground = 9
    background = 10
    underline = 11
    strikethrough = 12
    rise = 13
    shape = 14
    scale = 15
    fallback = 16
    letterSpacing = 17
    underlineColor = 18
    strikethroughColor = 19
    absoluteSize = 20
    gravity = 21
    gravityHint = 22
    fontFeatures = 23
    foregroundAlpha = 24
    backgroundAlpha = 25
    allowBreaks = 26
    show = 27
    insertHyphens = 28
    overline = 29
    overlineColor = 30

proc pango_attr_type_get_name(`type`: AttrType): cstring {.
    importc, libprag.}

proc getName*(`type`: AttrType): string =
  let resul0 = pango_attr_type_get_name(`type`)
  if resul0.isNil:
    return
  result = $resul0

proc name*(`type`: AttrType): string =
  let resul0 = pango_attr_type_get_name(`type`)
  if resul0.isNil:
    return
  result = $resul0

proc registerAttrType*(name: cstring): AttrType {.
    importc: "pango_attr_type_register", libprag.}

proc pango_attr_iterator_get(self: AttrIterator; `type`: AttrType): ptr Attribute00 {.
    importc, libprag.}

proc getAttrIterator*(self: AttrIterator; `type`: AttrType): Attribute =
  let impl0 = pango_attr_iterator_get(self, `type`)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_attribute_get_type(), impl0))

type
  AttrLanguage00* {.pure.} = object
  AttrLanguage* = ref object
    impl*: ptr AttrLanguage00
    ignoreFinalizer*: bool

proc pango_attr_language_new(language: ptr Language00): ptr Attribute00 {.
    importc, libprag.}

proc newAttrLanguage*(language: Language): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_language_new(cast[ptr Language00](language.impl))

type
  AttrList00* {.pure.} = object
  AttrList* = ref object
    impl*: ptr AttrList00
    ignoreFinalizer*: bool

proc pango_attr_list_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoAttrList*(self: AttrList) =
  if not self.ignoreFinalizer:
    boxedFree(pango_attr_list_get_type(), cast[ptr AttrList00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AttrList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_attr_list_get_type(), cast[ptr AttrList00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AttrList) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoAttrList)

proc pango_attr_list_unref(self: ptr AttrList00) {.
    importc, libprag.}

proc unref*(self: AttrList) =
  pango_attr_list_unref(cast[ptr AttrList00](self.impl))

proc finalizerunref*(self: AttrList) =
  if not self.ignoreFinalizer:
    pango_attr_list_unref(cast[ptr AttrList00](self.impl))

proc pango_attr_list_change(self: ptr AttrList00; attr: ptr Attribute00) {.
    importc, libprag.}

proc change*(self: AttrList; attr: Attribute) =
  pango_attr_list_change(cast[ptr AttrList00](self.impl), cast[ptr Attribute00](g_boxed_copy(pango_attribute_get_type(), attr.impl)))

proc pango_attr_list_copy(self: ptr AttrList00): ptr AttrList00 {.
    importc, libprag.}

proc copy*(self: AttrList): AttrList =
  let impl0 = pango_attr_list_copy(cast[ptr AttrList00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = impl0

proc pango_attr_list_equal(self: ptr AttrList00; otherList: ptr AttrList00): gboolean {.
    importc, libprag.}

proc equal*(self: AttrList; otherList: AttrList): bool =
  toBool(pango_attr_list_equal(cast[ptr AttrList00](self.impl), cast[ptr AttrList00](otherList.impl)))

proc pango_attr_list_filter(self: ptr AttrList00; `func`: AttrFilterFunc;
    data: pointer): ptr AttrList00 {.
    importc, libprag.}

proc filter*(self: AttrList; `func`: AttrFilterFunc; data: pointer): AttrList =
  let impl0 = pango_attr_list_filter(cast[ptr AttrList00](self.impl), `func`, data)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = impl0

proc pango_attr_list_get_attributes(self: ptr AttrList00): ptr glib.SList {.
    importc, libprag.}

proc getAttributes*(self: AttrList): seq[Attribute] =
  let resul0 = pango_attr_list_get_attributes(cast[ptr AttrList00](self.impl))
  result = gslistStructs2seq[Attribute](resul0, false)
  g_slist_free(resul0)

proc attributes*(self: AttrList): seq[Attribute] =
  let resul0 = pango_attr_list_get_attributes(cast[ptr AttrList00](self.impl))
  result = gslistStructs2seq[Attribute](resul0, false)
  g_slist_free(resul0)

proc pango_attr_list_get_iterator(self: ptr AttrList00): ptr AttrIterator {.
    importc, libprag.}

proc getIterator*(self: AttrList): ptr AttrIterator =
  pango_attr_list_get_iterator(cast[ptr AttrList00](self.impl))

proc pango_attr_list_insert(self: ptr AttrList00; attr: ptr Attribute00) {.
    importc, libprag.}

proc insert*(self: AttrList; attr: Attribute) =
  pango_attr_list_insert(cast[ptr AttrList00](self.impl), cast[ptr Attribute00](g_boxed_copy(pango_attribute_get_type(), attr.impl)))

proc pango_attr_list_insert_before(self: ptr AttrList00; attr: ptr Attribute00) {.
    importc, libprag.}

proc insertBefore*(self: AttrList; attr: Attribute) =
  pango_attr_list_insert_before(cast[ptr AttrList00](self.impl), cast[ptr Attribute00](g_boxed_copy(pango_attribute_get_type(), attr.impl)))

proc pango_attr_list_ref(self: ptr AttrList00): ptr AttrList00 {.
    importc, libprag.}

proc `ref`*(self: AttrList): AttrList =
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = pango_attr_list_ref(cast[ptr AttrList00](self.impl))

proc pango_attr_list_splice(self: ptr AttrList00; other: ptr AttrList00;
    pos: int32; len: int32) {.
    importc, libprag.}

proc splice*(self: AttrList; other: AttrList; pos: int; len: int) =
  pango_attr_list_splice(cast[ptr AttrList00](self.impl), cast[ptr AttrList00](other.impl), int32(pos), int32(len))

proc pango_attr_list_new(): ptr AttrList00 {.
    importc, libprag.}

proc newAttrList*(): AttrList =
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = pango_attr_list_new()

proc newAttrList*(tdesc: typedesc): tdesc =
  assert(result is AttrList)
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = pango_attr_list_new()

proc initAttrList*[T](result: var T) {.deprecated.} =
  assert(result is AttrList)
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = pango_attr_list_new()

proc pango_attr_list_update(self: ptr AttrList00; pos: int32; remove: int32;
    add: int32) {.
    importc, libprag.}

proc update*(self: AttrList; pos: int; remove: int; add: int) =
  pango_attr_list_update(cast[ptr AttrList00](self.impl), int32(pos), int32(remove), int32(add))

type
  AttrShape00* {.pure.} = object
  AttrShape* = ref object
    impl*: ptr AttrShape00
    ignoreFinalizer*: bool

proc pango_attr_shape_new(inkRect: Rectangle; logicalRect: Rectangle): ptr Attribute00 {.
    importc, libprag.}

proc newAttrShape*(inkRect: Rectangle; logicalRect: Rectangle): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_shape_new(inkRect, logicalRect)

proc pango_attr_shape_new_with_data(inkRect: Rectangle; logicalRect: Rectangle;
    data: pointer; copyFunc: AttrDataCopyFunc; destroyFunc: DestroyNotify): ptr Attribute00 {.
    importc, libprag.}

proc newAttrShapeWithData*(inkRect: Rectangle; logicalRect: Rectangle;
    data: pointer; copyFunc: AttrDataCopyFunc; destroyFunc: DestroyNotify): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_shape_new_with_data(inkRect, logicalRect, data, copyFunc, destroyFunc)

type
  AttrSize00* {.pure.} = object
  AttrSize* = ref object
    impl*: ptr AttrSize00
    ignoreFinalizer*: bool

proc pango_attr_size_new(size: int32): ptr Attribute00 {.
    importc, libprag.}

proc newAttrSize*(size: int): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_size_new(int32(size))

proc pango_attr_size_new_absolute(size: int32): ptr Attribute00 {.
    importc, libprag.}

proc newAttrSizeAbsolute*(size: int): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_size_new_absolute(int32(size))

type
  AttrString00* {.pure.} = object
  AttrString* = ref object
    impl*: ptr AttrString00
    ignoreFinalizer*: bool

type
  BidiType* {.size: sizeof(cint), pure.} = enum
    l = 0
    lre = 1
    lro = 2
    r = 3
    al = 4
    rle = 5
    rlo = 6
    pdf = 7
    en = 8
    es = 9
    et = 10
    an = 11
    cs = 12
    nsm = 13
    bn = 14
    b = 15
    s = 16
    ws = 17
    on = 18

proc bidiTypeForUnichar*(ch: gunichar): BidiType {.
    importc: "pango_bidi_type_for_unichar", libprag.}

type
  Color* {.pure, byRef.} = object
    red*: uint16
    green*: uint16
    blue*: uint16

proc pango_color_get_type*(): GType {.importc, libprag.}

proc pango_color_free(self: Color) {.
    importc, libprag.}

proc free*(self: Color) =
  pango_color_free(self)

proc pango_color_copy(self: Color): ptr Color {.
    importc, libprag.}

proc copy*(self: Color): ptr Color =
  pango_color_copy(self)

proc pango_color_parse(self: Color; spec: cstring): gboolean {.
    importc, libprag.}

proc parse*(self: Color; spec: cstring): bool =
  toBool(pango_color_parse(self, spec))

proc pango_color_parse_with_alpha(self: Color; alpha: var uint16; spec: cstring): gboolean {.
    importc, libprag.}

proc parseWithAlpha*(self: Color; alpha: var uint16 = cast[var uint16](nil);
    spec: cstring): bool =
  toBool(pango_color_parse_with_alpha(self, alpha, spec))

proc pango_color_to_string(self: Color): cstring {.
    importc, libprag.}

proc toString*(self: Color): string =
  let resul0 = pango_color_to_string(self)
  result = $resul0
  cogfree(resul0)

type
  Context* = ref object of gobject.Object
  Context00* = object of gobject.Object00

proc pango_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Context()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_context_new(): ptr Context00 {.
    importc, libprag.}

proc newContext*(): Context =
  let gobj = pango_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContext*(tdesc: typedesc): tdesc =
  assert(result is Context)
  let gobj = pango_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContext*[T](result: var T) {.deprecated.} =
  assert(result is Context)
  let gobj = pango_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_context_changed(self: ptr Context00) {.
    importc, libprag.}

proc changed*(self: Context) =
  pango_context_changed(cast[ptr Context00](self.impl))

proc pango_context_get_base_gravity(self: ptr Context00): Gravity {.
    importc, libprag.}

proc getBaseGravity*(self: Context): Gravity =
  pango_context_get_base_gravity(cast[ptr Context00](self.impl))

proc baseGravity*(self: Context): Gravity =
  pango_context_get_base_gravity(cast[ptr Context00](self.impl))

proc pango_context_get_font_description(self: ptr Context00): ptr FontDescription00 {.
    importc, libprag.}

proc getFontDescription*(self: Context): FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_context_get_font_description(cast[ptr Context00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_font_description_get_type(), result.impl))

proc fontDescription*(self: Context): FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_context_get_font_description(cast[ptr Context00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_font_description_get_type(), result.impl))

proc pango_context_get_gravity(self: ptr Context00): Gravity {.
    importc, libprag.}

proc getGravity*(self: Context): Gravity =
  pango_context_get_gravity(cast[ptr Context00](self.impl))

proc gravity*(self: Context): Gravity =
  pango_context_get_gravity(cast[ptr Context00](self.impl))

proc pango_context_get_gravity_hint(self: ptr Context00): GravityHint {.
    importc, libprag.}

proc getGravityHint*(self: Context): GravityHint =
  pango_context_get_gravity_hint(cast[ptr Context00](self.impl))

proc gravityHint*(self: Context): GravityHint =
  pango_context_get_gravity_hint(cast[ptr Context00](self.impl))

proc pango_context_get_language(self: ptr Context00): ptr Language00 {.
    importc, libprag.}

proc getLanguage*(self: Context): Language =
  fnew(result, gBoxedFreePangoLanguage)
  result.impl = pango_context_get_language(cast[ptr Context00](self.impl))

proc language*(self: Context): Language =
  fnew(result, gBoxedFreePangoLanguage)
  result.impl = pango_context_get_language(cast[ptr Context00](self.impl))

proc pango_context_get_matrix(self: ptr Context00): ptr Matrix00 {.
    importc, libprag.}

proc getMatrix*(self: Context): Matrix =
  let impl0 = pango_context_get_matrix(cast[ptr Context00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoMatrix)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_matrix_get_type(), impl0))

proc matrix*(self: Context): Matrix =
  let impl0 = pango_context_get_matrix(cast[ptr Context00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoMatrix)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_matrix_get_type(), impl0))

proc pango_context_get_round_glyph_positions(self: ptr Context00): gboolean {.
    importc, libprag.}

proc getRoundGlyphPositions*(self: Context): bool =
  toBool(pango_context_get_round_glyph_positions(cast[ptr Context00](self.impl)))

proc roundGlyphPositions*(self: Context): bool =
  toBool(pango_context_get_round_glyph_positions(cast[ptr Context00](self.impl)))

proc pango_context_get_serial(self: ptr Context00): uint32 {.
    importc, libprag.}

proc getSerial*(self: Context): int =
  int(pango_context_get_serial(cast[ptr Context00](self.impl)))

proc serial*(self: Context): int =
  int(pango_context_get_serial(cast[ptr Context00](self.impl)))

proc pango_context_set_base_gravity(self: ptr Context00; gravity: Gravity) {.
    importc, libprag.}

proc setBaseGravity*(self: Context; gravity: Gravity) =
  pango_context_set_base_gravity(cast[ptr Context00](self.impl), gravity)

proc `baseGravity=`*(self: Context; gravity: Gravity) =
  pango_context_set_base_gravity(cast[ptr Context00](self.impl), gravity)

proc pango_context_set_font_description(self: ptr Context00; desc: ptr FontDescription00) {.
    importc, libprag.}

proc setFontDescription*(self: Context; desc: FontDescription) =
  pango_context_set_font_description(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl))

proc `fontDescription=`*(self: Context; desc: FontDescription) =
  pango_context_set_font_description(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl))

proc pango_context_set_gravity_hint(self: ptr Context00; hint: GravityHint) {.
    importc, libprag.}

proc setGravityHint*(self: Context; hint: GravityHint) =
  pango_context_set_gravity_hint(cast[ptr Context00](self.impl), hint)

proc `gravityHint=`*(self: Context; hint: GravityHint) =
  pango_context_set_gravity_hint(cast[ptr Context00](self.impl), hint)

proc pango_context_set_language(self: ptr Context00; language: ptr Language00) {.
    importc, libprag.}

proc setLanguage*(self: Context; language: Language) =
  pango_context_set_language(cast[ptr Context00](self.impl), cast[ptr Language00](language.impl))

proc `language=`*(self: Context; language: Language) =
  pango_context_set_language(cast[ptr Context00](self.impl), cast[ptr Language00](language.impl))

proc pango_context_set_matrix(self: ptr Context00; matrix: ptr Matrix00) {.
    importc, libprag.}

proc setMatrix*(self: Context; matrix: Matrix = nil) =
  pango_context_set_matrix(cast[ptr Context00](self.impl), if matrix.isNil: nil else: cast[ptr Matrix00](matrix.impl))

proc `matrix=`*(self: Context; matrix: Matrix = nil) =
  pango_context_set_matrix(cast[ptr Context00](self.impl), if matrix.isNil: nil else: cast[ptr Matrix00](matrix.impl))

proc pango_context_set_round_glyph_positions(self: ptr Context00; roundPositions: gboolean) {.
    importc, libprag.}

proc setRoundGlyphPositions*(self: Context; roundPositions: bool = true) =
  pango_context_set_round_glyph_positions(cast[ptr Context00](self.impl), gboolean(roundPositions))

proc `roundGlyphPositions=`*(self: Context; roundPositions: bool) =
  pango_context_set_round_glyph_positions(cast[ptr Context00](self.impl), gboolean(roundPositions))

type
  FontMetrics00* {.pure.} = object
  FontMetrics* = ref object
    impl*: ptr FontMetrics00
    ignoreFinalizer*: bool

proc pango_font_metrics_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoFontMetrics*(self: FontMetrics) =
  if not self.ignoreFinalizer:
    boxedFree(pango_font_metrics_get_type(), cast[ptr FontMetrics00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontMetrics()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_font_metrics_get_type(), cast[ptr FontMetrics00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FontMetrics) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoFontMetrics)

proc pango_font_metrics_unref(self: ptr FontMetrics00) {.
    importc, libprag.}

proc unref*(self: FontMetrics) =
  pango_font_metrics_unref(cast[ptr FontMetrics00](self.impl))

proc finalizerunref*(self: FontMetrics) =
  if not self.ignoreFinalizer:
    pango_font_metrics_unref(cast[ptr FontMetrics00](self.impl))

proc pango_font_metrics_get_approximate_digit_width(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getApproximateDigitWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_digit_width(cast[ptr FontMetrics00](self.impl)))

proc approximateDigitWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_digit_width(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_ascent(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getAscent*(self: FontMetrics): int =
  int(pango_font_metrics_get_ascent(cast[ptr FontMetrics00](self.impl)))

proc ascent*(self: FontMetrics): int =
  int(pango_font_metrics_get_ascent(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_descent(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getDescent*(self: FontMetrics): int =
  int(pango_font_metrics_get_descent(cast[ptr FontMetrics00](self.impl)))

proc descent*(self: FontMetrics): int =
  int(pango_font_metrics_get_descent(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_height(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getHeight*(self: FontMetrics): int =
  int(pango_font_metrics_get_height(cast[ptr FontMetrics00](self.impl)))

proc height*(self: FontMetrics): int =
  int(pango_font_metrics_get_height(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_strikethrough_position(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getStrikethroughPosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_position(cast[ptr FontMetrics00](self.impl)))

proc strikethroughPosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_position(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_strikethrough_thickness(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getStrikethroughThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_thickness(cast[ptr FontMetrics00](self.impl)))

proc strikethroughThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_thickness(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_underline_position(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getUnderlinePosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_position(cast[ptr FontMetrics00](self.impl)))

proc underlinePosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_position(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_underline_thickness(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getUnderlineThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_thickness(cast[ptr FontMetrics00](self.impl)))

proc underlineThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_thickness(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_ref(self: ptr FontMetrics00): ptr FontMetrics00 {.
    importc, libprag.}

proc `ref`*(self: FontMetrics): FontMetrics =
  let impl0 = pango_font_metrics_ref(cast[ptr FontMetrics00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoFontMetrics)
  result.impl = impl0

proc pango_font_metrics_get_approximate_char_width(self: ptr FontMetrics00): int32 {.
    importc, libprag.}

proc getApproximateCharWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_char_width(cast[ptr FontMetrics00](self.impl)))

proc approximateCharWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_char_width(cast[ptr FontMetrics00](self.impl)))

proc pango_context_get_metrics(self: ptr Context00; desc: ptr FontDescription00;
    language: ptr Language00): ptr FontMetrics00 {.
    importc, libprag.}

proc getMetrics*(self: Context; desc: FontDescription = nil;
    language: Language = nil): FontMetrics =
  fnew(result, gBoxedFreePangoFontMetrics)
  result.impl = pango_context_get_metrics(cast[ptr Context00](self.impl), if desc.isNil: nil else: cast[ptr FontDescription00](desc.impl), if language.isNil: nil else: cast[ptr Language00](language.impl))

type
  FontFamily* = ref object of gobject.Object
  FontFamily00* = object of gobject.Object00

proc pango_font_family_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontFamily()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_font_family_get_name(self: ptr FontFamily00): cstring {.
    importc, libprag.}

proc getName*(self: FontFamily): string =
  result = $pango_font_family_get_name(cast[ptr FontFamily00](self.impl))

proc name*(self: FontFamily): string =
  result = $pango_font_family_get_name(cast[ptr FontFamily00](self.impl))

proc pango_font_family_is_monospace(self: ptr FontFamily00): gboolean {.
    importc, libprag.}

proc isMonospace*(self: FontFamily): bool =
  toBool(pango_font_family_is_monospace(cast[ptr FontFamily00](self.impl)))

proc pango_font_family_is_variable(self: ptr FontFamily00): gboolean {.
    importc, libprag.}

proc isVariable*(self: FontFamily): bool =
  toBool(pango_font_family_is_variable(cast[ptr FontFamily00](self.impl)))

proc pango_context_list_families(self: ptr Context00; families: var ptr ptr FontFamily00;
    nFamilies: var int32) {.
    importc, libprag.}

proc listFamilies*(self: Context; families: var ptr ptr FontFamily00;
    nFamilies: var int) =
  var nFamilies_00: int32
  pango_context_list_families(cast[ptr Context00](self.impl), families, nFamilies_00)
  if nFamilies.addr != nil:
    nFamilies = int(nFamilies_00)

type
  FontFace* = ref object of gobject.Object
  FontFace00* = object of gobject.Object00

proc pango_font_face_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontFace()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_font_face_describe(self: ptr FontFace00): ptr FontDescription00 {.
    importc, libprag.}

proc describe*(self: FontFace): FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_font_face_describe(cast[ptr FontFace00](self.impl))

proc pango_font_face_get_face_name(self: ptr FontFace00): cstring {.
    importc, libprag.}

proc getFaceName*(self: FontFace): string =
  result = $pango_font_face_get_face_name(cast[ptr FontFace00](self.impl))

proc faceName*(self: FontFace): string =
  result = $pango_font_face_get_face_name(cast[ptr FontFace00](self.impl))

proc pango_font_face_get_family(self: ptr FontFace00): ptr FontFamily00 {.
    importc, libprag.}

proc getFamily*(self: FontFace): FontFamily =
  let gobj = pango_font_face_get_family(cast[ptr FontFace00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc family*(self: FontFace): FontFamily =
  let gobj = pango_font_face_get_family(cast[ptr FontFace00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_font_face_is_synthesized(self: ptr FontFace00): gboolean {.
    importc, libprag.}

proc isSynthesized*(self: FontFace): bool =
  toBool(pango_font_face_is_synthesized(cast[ptr FontFace00](self.impl)))

proc pango_font_family_get_face(self: ptr FontFamily00; name: cstring): ptr FontFace00 {.
    importc, libprag.}

proc getFace*(self: FontFamily; name: cstring = nil): FontFace =
  let gobj = pango_font_family_get_face(cast[ptr FontFamily00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_font_family_list_faces(self: ptr FontFamily00; faces: var ptr ptr FontFace00;
    nFaces: var int32) {.
    importc, libprag.}

proc listFaces*(self: FontFamily; faces: var ptr ptr FontFace00 = cast[var ptr ptr FontFace00](nil);
    nFaces: var int) =
  var nFaces_00: int32
  pango_font_family_list_faces(cast[ptr FontFamily00](self.impl), faces, nFaces_00)
  if nFaces.addr != nil:
    nFaces = int(nFaces_00)

type
  Font* = ref object of gobject.Object
  Font00* = object of gobject.Object00

proc pango_font_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Font()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_font_descriptions_free(descs: ptr ptr FontDescription00; nDescs: int32) {.
    importc, libprag.}

proc descriptionsFree*(descs: ptr ptr FontDescription00; nDescs: int) =
  pango_font_descriptions_free(descs, int32(nDescs))

proc pango_font_describe(self: ptr Font00): ptr FontDescription00 {.
    importc, libprag.}

proc describe*(self: Font): FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_font_describe(cast[ptr Font00](self.impl))

proc pango_font_describe_with_absolute_size(self: ptr Font00): ptr FontDescription00 {.
    importc, libprag.}

proc describeWithAbsoluteSize*(self: Font): FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = pango_font_describe_with_absolute_size(cast[ptr Font00](self.impl))

proc pango_font_get_face(self: ptr Font00): ptr FontFace00 {.
    importc, libprag.}

proc getFace*(self: Font): FontFace =
  let gobj = pango_font_get_face(cast[ptr Font00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc face*(self: Font): FontFace =
  let gobj = pango_font_get_face(cast[ptr Font00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_font_get_features(self: ptr Font00; features: var ptr harfbuzz.featureT00;
    len: var uint32; numFeatures: var uint32) {.
    importc, libprag.}

proc getFeatures*(self: Font; features: var ptr harfbuzz.featureT00;
    len: var int; numFeatures: var int) =
  var numFeatures_00 = uint32(numFeatures)
  var len_00: uint32
  pango_font_get_features(cast[ptr Font00](self.impl), features, len_00, numFeatures_00)
  numFeatures = int(numFeatures_00)
  if len.addr != nil:
    len = int(len_00)

proc pango_font_get_glyph_extents(self: ptr Font00; glyph: uint32; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getGlyphExtents*(self: Font; glyph: int; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_font_get_glyph_extents(cast[ptr Font00](self.impl), uint32(glyph), inkRect, logicalRect)

proc pango_font_get_metrics(self: ptr Font00; language: ptr Language00): ptr FontMetrics00 {.
    importc, libprag.}

proc getMetrics*(self: Font; language: Language = nil): FontMetrics =
  fnew(result, gBoxedFreePangoFontMetrics)
  result.impl = pango_font_get_metrics(cast[ptr Font00](self.impl), if language.isNil: nil else: cast[ptr Language00](language.impl))

proc pango_font_has_char(self: ptr Font00; wc: gunichar): gboolean {.
    importc, libprag.}

proc hasChar*(self: Font; wc: gunichar): bool =
  toBool(pango_font_has_char(cast[ptr Font00](self.impl), wc))

proc pango_context_load_font(self: ptr Context00; desc: ptr FontDescription00): ptr Font00 {.
    importc, libprag.}

proc loadFont*(self: Context; desc: FontDescription): Font =
  let gobj = pango_context_load_font(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Engine* = ref object of gobject.Object
  Engine00* = object of gobject.Object00

proc pango_engine_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Engine()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  EngineShape* = ref object of Engine
  EngineShape00* = object of Engine00

proc pango_engine_shape_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EngineShape()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_font_find_shaper(self: ptr Font00; language: ptr Language00; ch: uint32): ptr EngineShape00 {.
    importc, libprag.}

proc findShaper*(self: Font; language: Language; ch: int): EngineShape =
  let gobj = pango_font_find_shaper(cast[ptr Font00](self.impl), cast[ptr Language00](language.impl), uint32(ch))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Coverage* = ref object of gobject.Object
  Coverage00* = object of gobject.Object00

proc pango_coverage_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Coverage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_coverage_new(): ptr Coverage00 {.
    importc, libprag.}

proc newCoverage*(): Coverage =
  let gobj = pango_coverage_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCoverage*(tdesc: typedesc): tdesc =
  assert(result is Coverage)
  let gobj = pango_coverage_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCoverage*[T](result: var T) {.deprecated.} =
  assert(result is Coverage)
  let gobj = pango_coverage_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_coverage_from_bytes(bytes: ptr uint8; nBytes: int32): ptr Coverage00 {.
    importc, libprag.}

proc fromBytes*(bytes: seq[uint8] | string): Coverage =
  let nBytes = int(bytes.len)
  let gobj = pango_coverage_from_bytes(cast[ptr uint8](unsafeaddr(bytes[0])), int32(nBytes))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_coverage_copy(self: ptr Coverage00): ptr Coverage00 {.
    importc, libprag.}

proc copy*(self: Coverage): Coverage =
  let gobj = pango_coverage_copy(cast[ptr Coverage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_coverage_max(self: ptr Coverage00; other: ptr Coverage00) {.
    importc, libprag.}

proc max*(self: Coverage; other: Coverage) =
  pango_coverage_max(cast[ptr Coverage00](self.impl), cast[ptr Coverage00](other.impl))

proc pango_coverage_ref(self: ptr Coverage00): ptr Coverage00 {.
    importc, libprag.}

proc `ref`*(self: Coverage): Coverage =
  let gobj = pango_coverage_ref(cast[ptr Coverage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_coverage_unref(self: ptr Coverage00) {.
    importc, libprag.}

proc unref*(self: Coverage) =
  pango_coverage_unref(cast[ptr Coverage00](g_object_ref(self.impl)))

proc pango_font_get_coverage(self: ptr Font00; language: ptr Language00): ptr Coverage00 {.
    importc, libprag.}

proc getCoverage*(self: Font; language: Language): Coverage =
  let gobj = pango_font_get_coverage(cast[ptr Font00](self.impl), cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  CoverageLevel* {.size: sizeof(cint), pure.} = enum
    none = 0
    fallback = 1
    approximate = 2
    exact = 3

proc pango_coverage_get(self: ptr Coverage00; index: int32): CoverageLevel {.
    importc, libprag.}

proc getCoverage*(self: Coverage; index: int): CoverageLevel =
  pango_coverage_get(cast[ptr Coverage00](self.impl), int32(index))

proc pango_coverage_set(self: ptr Coverage00; index: int32; level: CoverageLevel) {.
    importc, libprag.}

proc set*(self: Coverage; index: int; level: CoverageLevel) =
  pango_coverage_set(cast[ptr Coverage00](self.impl), int32(index), level)

type
  Fontset* = ref object of gobject.Object
  Fontset00* = object of gobject.Object00

proc pango_fontset_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Fontset()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_fontset_get_font(self: ptr Fontset00; wc: uint32): ptr Font00 {.
    importc, libprag.}

proc getFont*(self: Fontset; wc: int): Font =
  let gobj = pango_fontset_get_font(cast[ptr Fontset00](self.impl), uint32(wc))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_fontset_get_metrics(self: ptr Fontset00): ptr FontMetrics00 {.
    importc, libprag.}

proc getMetrics*(self: Fontset): FontMetrics =
  fnew(result, gBoxedFreePangoFontMetrics)
  result.impl = pango_fontset_get_metrics(cast[ptr Fontset00](self.impl))

proc metrics*(self: Fontset): FontMetrics =
  fnew(result, gBoxedFreePangoFontMetrics)
  result.impl = pango_fontset_get_metrics(cast[ptr Fontset00](self.impl))

proc pango_context_load_fontset(self: ptr Context00; desc: ptr FontDescription00;
    language: ptr Language00): ptr Fontset00 {.
    importc, libprag.}

proc loadFontset*(self: Context; desc: FontDescription; language: Language): Fontset =
  let gobj = pango_context_load_fontset(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Direction* {.size: sizeof(cint), pure.} = enum
    ltr = 0
    rtl = 1
    ttbLtr = 2
    ttbRtl = 3
    weakLtr = 4
    weakRtl = 5
    neutral = 6

proc pango_context_get_base_dir(self: ptr Context00): Direction {.
    importc, libprag.}

proc getBaseDir*(self: Context): Direction =
  pango_context_get_base_dir(cast[ptr Context00](self.impl))

proc baseDir*(self: Context): Direction =
  pango_context_get_base_dir(cast[ptr Context00](self.impl))

proc pango_context_set_base_dir(self: ptr Context00; direction: Direction) {.
    importc, libprag.}

proc setBaseDir*(self: Context; direction: Direction) =
  pango_context_set_base_dir(cast[ptr Context00](self.impl), direction)

proc `baseDir=`*(self: Context; direction: Direction) =
  pango_context_set_base_dir(cast[ptr Context00](self.impl), direction)

type
  FontMap* = ref object of gobject.Object
  FontMap00* = object of gobject.Object00

proc pango_font_map_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontMap()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_font_map_changed(self: ptr FontMap00) {.
    importc, libprag.}

proc changed*(self: FontMap) =
  pango_font_map_changed(cast[ptr FontMap00](self.impl))

proc pango_font_map_create_context(self: ptr FontMap00): ptr Context00 {.
    importc, libprag.}

proc createContext*(self: FontMap): Context =
  let gobj = pango_font_map_create_context(cast[ptr FontMap00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_font_map_get_family(self: ptr FontMap00; name: cstring): ptr FontFamily00 {.
    importc, libprag.}

proc getFamily*(self: FontMap; name: cstring): FontFamily =
  let gobj = pango_font_map_get_family(cast[ptr FontMap00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_font_map_get_serial(self: ptr FontMap00): uint32 {.
    importc, libprag.}

proc getSerial*(self: FontMap): int =
  int(pango_font_map_get_serial(cast[ptr FontMap00](self.impl)))

proc serial*(self: FontMap): int =
  int(pango_font_map_get_serial(cast[ptr FontMap00](self.impl)))

proc pango_font_map_list_families(self: ptr FontMap00; families: var ptr ptr FontFamily00;
    nFamilies: var int32) {.
    importc, libprag.}

proc listFamilies*(self: FontMap; families: var ptr ptr FontFamily00;
    nFamilies: var int) =
  var nFamilies_00: int32
  pango_font_map_list_families(cast[ptr FontMap00](self.impl), families, nFamilies_00)
  if nFamilies.addr != nil:
    nFamilies = int(nFamilies_00)

proc pango_font_map_load_font(self: ptr FontMap00; context: ptr Context00;
    desc: ptr FontDescription00): ptr Font00 {.
    importc, libprag.}

proc loadFont*(self: FontMap; context: Context; desc: FontDescription): Font =
  let gobj = pango_font_map_load_font(cast[ptr FontMap00](self.impl), cast[ptr Context00](context.impl), cast[ptr FontDescription00](desc.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_font_map_load_fontset(self: ptr FontMap00; context: ptr Context00;
    desc: ptr FontDescription00; language: ptr Language00): ptr Fontset00 {.
    importc, libprag.}

proc loadFontset*(self: FontMap; context: Context; desc: FontDescription;
    language: Language): Fontset =
  let gobj = pango_font_map_load_fontset(cast[ptr FontMap00](self.impl), cast[ptr Context00](context.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_context_get_font_map(self: ptr Context00): ptr FontMap00 {.
    importc, libprag.}

proc getFontMap*(self: Context): FontMap =
  let gobj = pango_context_get_font_map(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc fontMap*(self: Context): FontMap =
  let gobj = pango_context_get_font_map(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_context_set_font_map(self: ptr Context00; fontMap: ptr FontMap00) {.
    importc, libprag.}

proc setFontMap*(self: Context; fontMap: FontMap) =
  pango_context_set_font_map(cast[ptr Context00](self.impl), cast[ptr FontMap00](fontMap.impl))

proc `fontMap=`*(self: Context; fontMap: FontMap) =
  pango_context_set_font_map(cast[ptr Context00](self.impl), cast[ptr FontMap00](fontMap.impl))

proc pango_font_get_font_map(self: ptr Font00): ptr FontMap00 {.
    importc, libprag.}

proc getFontMap*(self: Font): FontMap =
  let gobj = pango_font_get_font_map(cast[ptr Font00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc fontMap*(self: Font): FontMap =
  let gobj = pango_font_get_font_map(cast[ptr Font00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

const ENGINE_TYPE_LANG* = "PangoEngineLang"

const ENGINE_TYPE_SHAPE* = "PangoEngineShape"

type
  EllipsizeMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    start = 1
    middle = 2
    `end` = 3

type
  EngineInfo00* {.pure.} = object
  EngineInfo* = ref object
    impl*: ptr EngineInfo00
    ignoreFinalizer*: bool

type
  EngineLang* = ref object of Engine
  EngineLang00* = object of Engine00

proc pango_engine_lang_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EngineLang()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  EngineScriptInfo00* {.pure.} = object
  EngineScriptInfo* = ref object
    impl*: ptr EngineScriptInfo00
    ignoreFinalizer*: bool

type
  FontsetForeachFunc* = proc (fontset: ptr Fontset00; font: ptr Font00; userData: pointer): gboolean {.cdecl.}

proc pango_fontset_foreach(self: ptr Fontset00; `func`: FontsetForeachFunc;
    data: pointer) {.
    importc, libprag.}

proc foreach*(self: Fontset; `func`: FontsetForeachFunc; data: pointer) =
  pango_fontset_foreach(cast[ptr Fontset00](self.impl), `func`, data)

type
  FontsetSimple* = ref object of Fontset
  FontsetSimple00* = object of Fontset00

proc pango_fontset_simple_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontsetSimple()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_fontset_simple_new(language: ptr Language00): ptr FontsetSimple00 {.
    importc, libprag.}

proc newFontsetSimple*(language: Language): FontsetSimple =
  let gobj = pango_fontset_simple_new(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFontsetSimple*(tdesc: typedesc; language: Language): tdesc =
  assert(result is FontsetSimple)
  let gobj = pango_fontset_simple_new(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFontsetSimple*[T](result: var T; language: Language) {.deprecated.} =
  assert(result is FontsetSimple)
  let gobj = pango_fontset_simple_new(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_fontset_simple_append(self: ptr FontsetSimple00; font: ptr Font00) {.
    importc, libprag.}

proc append*(self: FontsetSimple; font: Font) =
  pango_fontset_simple_append(cast[ptr FontsetSimple00](self.impl), cast[ptr Font00](font.impl))

proc pango_fontset_simple_size(self: ptr FontsetSimple00): int32 {.
    importc, libprag.}

proc size*(self: FontsetSimple): int =
  int(pango_fontset_simple_size(cast[ptr FontsetSimple00](self.impl)))

const GLYPH_EMPTY* = 268435455'u32

const GLYPH_INVALID_INPUT* = 4294967295'u32

const GLYPH_UNKNOWN_FLAG* = 268435456'u32

type
  GlyphGeometry* {.pure, byRef.} = object
    width*: int32
    xOffset*: int32
    yOffset*: int32

type
  GlyphVisAttr* {.pure, byRef.} = object
    isClusterStart*: uint32

type
  GlyphInfo* {.pure, byRef.} = object
    glyph*: uint32
    geometry*: GlyphGeometry
    attr*: GlyphVisAttr

type
  GlyphItem00* {.pure.} = object
  GlyphItem* = ref object
    impl*: ptr GlyphItem00
    ignoreFinalizer*: bool

proc pango_glyph_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoGlyphItem*(self: GlyphItem) =
  if not self.ignoreFinalizer:
    boxedFree(pango_glyph_item_get_type(), cast[ptr GlyphItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GlyphItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_glyph_item_get_type(), cast[ptr GlyphItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GlyphItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoGlyphItem)

proc pango_glyph_item_free(self: ptr GlyphItem00) {.
    importc, libprag.}

proc free*(self: GlyphItem) =
  pango_glyph_item_free(cast[ptr GlyphItem00](self.impl))

proc finalizerfree*(self: GlyphItem) =
  if not self.ignoreFinalizer:
    pango_glyph_item_free(cast[ptr GlyphItem00](self.impl))

proc pango_glyph_item_copy(self: ptr GlyphItem00): ptr GlyphItem00 {.
    importc, libprag.}

proc copy*(self: GlyphItem): GlyphItem =
  let impl0 = pango_glyph_item_copy(cast[ptr GlyphItem00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoGlyphItem)
  result.impl = impl0

proc pango_glyph_item_apply_attrs(self: ptr GlyphItem00; text: cstring; list: ptr AttrList00): ptr glib.SList {.
    importc, libprag.}

proc applyAttrs*(self: GlyphItem; text: cstring; list: AttrList): seq[GlyphItem] =
  let resul0 = pango_glyph_item_apply_attrs(cast[ptr GlyphItem00](self.impl), text, cast[ptr AttrList00](list.impl))
  result = gslistStructs2seq[GlyphItem](resul0, false)
  g_slist_free(resul0)

proc pango_glyph_item_get_logical_widths(self: ptr GlyphItem00; text: cstring;
    logicalWidths: ptr int32) {.
    importc, libprag.}

proc getLogicalWidths*(self: GlyphItem; text: cstring;
    logicalWidths: seq[int32]) =
  pango_glyph_item_get_logical_widths(cast[ptr GlyphItem00](self.impl), text, cast[ptr int32](unsafeaddr(logicalWidths[0])))

proc pango_glyph_item_split(self: ptr GlyphItem00; text: cstring; splitIndex: int32): ptr GlyphItem00 {.
    importc, libprag.}

proc split*(self: GlyphItem; text: cstring; splitIndex: int): GlyphItem =
  fnew(result, gBoxedFreePangoGlyphItem)
  result.impl = pango_glyph_item_split(cast[ptr GlyphItem00](self.impl), text, int32(splitIndex))

type
  LogAttr00* {.pure.} = object
  LogAttr* = ref object
    impl*: ptr LogAttr00
    ignoreFinalizer*: bool

proc pango_glyph_item_letter_space(self: ptr GlyphItem00; text: cstring;
    logAttrs: ptr LogAttr00; letterSpacing: int32) {.
    importc, libprag.}

proc letterSpace*(self: GlyphItem; text: cstring; logAttrs: ptr LogAttr00;
    letterSpacing: int) =
  pango_glyph_item_letter_space(cast[ptr GlyphItem00](self.impl), text, logAttrs, int32(letterSpacing))

type
  GlyphItemIter00* {.pure.} = object
  GlyphItemIter* = ref object
    impl*: ptr GlyphItemIter00
    ignoreFinalizer*: bool

proc pango_glyph_item_iter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoGlyphItemIter*(self: GlyphItemIter) =
  if not self.ignoreFinalizer:
    boxedFree(pango_glyph_item_iter_get_type(), cast[ptr GlyphItemIter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GlyphItemIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_glyph_item_iter_get_type(), cast[ptr GlyphItemIter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GlyphItemIter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoGlyphItemIter)

proc pango_glyph_item_iter_free(self: ptr GlyphItemIter00) {.
    importc, libprag.}

proc free*(self: GlyphItemIter) =
  pango_glyph_item_iter_free(cast[ptr GlyphItemIter00](self.impl))

proc finalizerfree*(self: GlyphItemIter) =
  if not self.ignoreFinalizer:
    pango_glyph_item_iter_free(cast[ptr GlyphItemIter00](self.impl))

proc pango_glyph_item_iter_copy(self: ptr GlyphItemIter00): ptr GlyphItemIter00 {.
    importc, libprag.}

proc copy*(self: GlyphItemIter): GlyphItemIter =
  let impl0 = pango_glyph_item_iter_copy(cast[ptr GlyphItemIter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoGlyphItemIter)
  result.impl = impl0

proc pango_glyph_item_iter_init_end(self: ptr GlyphItemIter00; glyphItem: ptr GlyphItem00;
    text: cstring): gboolean {.
    importc, libprag.}

proc initEnd*(self: GlyphItemIter; glyphItem: GlyphItem;
    text: cstring): bool =
  toBool(pango_glyph_item_iter_init_end(cast[ptr GlyphItemIter00](self.impl), cast[ptr GlyphItem00](glyphItem.impl), text))

proc pango_glyph_item_iter_init_start(self: ptr GlyphItemIter00; glyphItem: ptr GlyphItem00;
    text: cstring): gboolean {.
    importc, libprag.}

proc initStart*(self: GlyphItemIter; glyphItem: GlyphItem;
    text: cstring): bool =
  toBool(pango_glyph_item_iter_init_start(cast[ptr GlyphItemIter00](self.impl), cast[ptr GlyphItem00](glyphItem.impl), text))

proc pango_glyph_item_iter_next_cluster(self: ptr GlyphItemIter00): gboolean {.
    importc, libprag.}

proc nextCluster*(self: GlyphItemIter): bool =
  toBool(pango_glyph_item_iter_next_cluster(cast[ptr GlyphItemIter00](self.impl)))

proc pango_glyph_item_iter_prev_cluster(self: ptr GlyphItemIter00): gboolean {.
    importc, libprag.}

proc prevCluster*(self: GlyphItemIter): bool =
  toBool(pango_glyph_item_iter_prev_cluster(cast[ptr GlyphItemIter00](self.impl)))

type
  GlyphString00* {.pure.} = object
  GlyphString* = ref object
    impl*: ptr GlyphString00
    ignoreFinalizer*: bool

proc pango_glyph_string_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoGlyphString*(self: GlyphString) =
  if not self.ignoreFinalizer:
    boxedFree(pango_glyph_string_get_type(), cast[ptr GlyphString00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GlyphString()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_glyph_string_get_type(), cast[ptr GlyphString00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GlyphString) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoGlyphString)

proc pango_glyph_string_free(self: ptr GlyphString00) {.
    importc, libprag.}

proc free*(self: GlyphString) =
  pango_glyph_string_free(cast[ptr GlyphString00](self.impl))

proc finalizerfree*(self: GlyphString) =
  if not self.ignoreFinalizer:
    pango_glyph_string_free(cast[ptr GlyphString00](self.impl))

proc pango_glyph_string_copy(self: ptr GlyphString00): ptr GlyphString00 {.
    importc, libprag.}

proc copy*(self: GlyphString): GlyphString =
  let impl0 = pango_glyph_string_copy(cast[ptr GlyphString00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoGlyphString)
  result.impl = impl0

proc pango_glyph_string_extents(self: ptr GlyphString00; font: ptr Font00;
    inkRect: var Rectangle; logicalRect: var Rectangle) {.
    importc, libprag.}

proc extents*(self: GlyphString; font: Font; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_glyph_string_extents(cast[ptr GlyphString00](self.impl), cast[ptr Font00](font.impl), inkRect, logicalRect)

proc pango_glyph_string_extents_range(self: ptr GlyphString00; start: int32;
    `end`: int32; font: ptr Font00; inkRect: var Rectangle; logicalRect: var Rectangle) {.
    importc, libprag.}

proc extentsRange*(self: GlyphString; start: int; `end`: int;
    font: Font; inkRect: var Rectangle = cast[var Rectangle](nil); logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_glyph_string_extents_range(cast[ptr GlyphString00](self.impl), int32(start), int32(`end`), cast[ptr Font00](font.impl), inkRect, logicalRect)

proc pango_glyph_string_new(): ptr GlyphString00 {.
    importc, libprag.}

proc newGlyphString*(): GlyphString =
  fnew(result, gBoxedFreePangoGlyphString)
  result.impl = pango_glyph_string_new()

proc newGlyphString*(tdesc: typedesc): tdesc =
  assert(result is GlyphString)
  fnew(result, gBoxedFreePangoGlyphString)
  result.impl = pango_glyph_string_new()

proc initGlyphString*[T](result: var T) {.deprecated.} =
  assert(result is GlyphString)
  fnew(result, gBoxedFreePangoGlyphString)
  result.impl = pango_glyph_string_new()

proc pango_glyph_string_get_logical_widths(self: ptr GlyphString00; text: cstring;
    length: int32; embeddingLevel: int32; logicalWidths: ptr int32) {.
    importc, libprag.}

proc getLogicalWidths*(self: GlyphString; text: cstring;
    length: int; embeddingLevel: int; logicalWidths: seq[int32]) =
  pango_glyph_string_get_logical_widths(cast[ptr GlyphString00](self.impl), text, int32(length), int32(embeddingLevel), cast[ptr int32](unsafeaddr(logicalWidths[0])))

proc pango_glyph_string_get_width(self: ptr GlyphString00): int32 {.
    importc, libprag.}

proc getWidth*(self: GlyphString): int =
  int(pango_glyph_string_get_width(cast[ptr GlyphString00](self.impl)))

proc width*(self: GlyphString): int =
  int(pango_glyph_string_get_width(cast[ptr GlyphString00](self.impl)))

proc pango_glyph_string_index_to_x(self: ptr GlyphString00; text: cstring;
    length: int32; analysis: ptr Analysis00; index: int32; trailing: gboolean;
    xPos: var int32) {.
    importc, libprag.}

proc indexToX*(self: GlyphString; text: cstring; length: int;
    analysis: Analysis; index: int; trailing: bool; xPos: var int) =
  var xPos_00: int32
  pango_glyph_string_index_to_x(cast[ptr GlyphString00](self.impl), text, int32(length), cast[ptr Analysis00](analysis.impl), int32(index), gboolean(trailing), xPos_00)
  if xPos.addr != nil:
    xPos = int(xPos_00)

proc pango_glyph_string_set_size(self: ptr GlyphString00; newLen: int32) {.
    importc, libprag.}

proc setSize*(self: GlyphString; newLen: int) =
  pango_glyph_string_set_size(cast[ptr GlyphString00](self.impl), int32(newLen))

proc `size=`*(self: GlyphString; newLen: int) =
  pango_glyph_string_set_size(cast[ptr GlyphString00](self.impl), int32(newLen))

proc pango_glyph_string_x_to_index(self: ptr GlyphString00; text: cstring;
    length: int32; analysis: ptr Analysis00; xPos: int32; index: var int32;
    trailing: var int32) {.
    importc, libprag.}

proc xToIndex*(self: GlyphString; text: cstring; length: int;
    analysis: Analysis; xPos: int; index: var int; trailing: var int) =
  var index_00: int32
  var trailing_00: int32
  pango_glyph_string_x_to_index(cast[ptr GlyphString00](self.impl), text, int32(length), cast[ptr Analysis00](analysis.impl), int32(xPos), index_00, trailing_00)
  if index.addr != nil:
    index = int(index_00)
  if trailing.addr != nil:
    trailing = int(trailing_00)

type
  IncludedModule00* {.pure.} = object
  IncludedModule* = ref object
    impl*: ptr IncludedModule00
    ignoreFinalizer*: bool

type
  Item00* {.pure.} = object
  Item* = ref object
    impl*: ptr Item00
    ignoreFinalizer*: bool

proc pango_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoItem*(self: Item) =
  if not self.ignoreFinalizer:
    boxedFree(pango_item_get_type(), cast[ptr Item00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Item()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_item_get_type(), cast[ptr Item00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Item) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoItem)

proc pango_item_free(self: ptr Item00) {.
    importc, libprag.}

proc free*(self: Item) =
  pango_item_free(cast[ptr Item00](self.impl))

proc finalizerfree*(self: Item) =
  if not self.ignoreFinalizer:
    pango_item_free(cast[ptr Item00](self.impl))

proc pango_item_apply_attrs(self: ptr Item00; iter: AttrIterator) {.
    importc, libprag.}

proc applyAttrs*(self: Item; iter: AttrIterator) =
  pango_item_apply_attrs(cast[ptr Item00](self.impl), iter)

proc pango_item_copy(self: ptr Item00): ptr Item00 {.
    importc, libprag.}

proc copy*(self: Item): Item =
  let impl0 = pango_item_copy(cast[ptr Item00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoItem)
  result.impl = impl0

proc pango_item_new(): ptr Item00 {.
    importc, libprag.}

proc newItem*(): Item =
  fnew(result, gBoxedFreePangoItem)
  result.impl = pango_item_new()

proc newItem*(tdesc: typedesc): tdesc =
  assert(result is Item)
  fnew(result, gBoxedFreePangoItem)
  result.impl = pango_item_new()

proc initItem*[T](result: var T) {.deprecated.} =
  assert(result is Item)
  fnew(result, gBoxedFreePangoItem)
  result.impl = pango_item_new()

proc pango_item_split(self: ptr Item00; splitIndex: int32; splitOffset: int32): ptr Item00 {.
    importc, libprag.}

proc split*(self: Item; splitIndex: int; splitOffset: int): Item =
  fnew(result, gBoxedFreePangoItem)
  result.impl = pango_item_split(cast[ptr Item00](self.impl), int32(splitIndex), int32(splitOffset))

type
  Layout* = ref object of gobject.Object
  Layout00* = object of gobject.Object00

proc pango_layout_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Layout()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_layout_new(context: ptr Context00): ptr Layout00 {.
    importc, libprag.}

proc newLayout*(context: Context): Layout =
  let gobj = pango_layout_new(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newLayout*(tdesc: typedesc; context: Context): tdesc =
  assert(result is Layout)
  let gobj = pango_layout_new(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initLayout*[T](result: var T; context: Context) {.deprecated.} =
  assert(result is Layout)
  let gobj = pango_layout_new(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_layout_context_changed(self: ptr Layout00) {.
    importc, libprag.}

proc contextChanged*(self: Layout) =
  pango_layout_context_changed(cast[ptr Layout00](self.impl))

proc pango_layout_copy(self: ptr Layout00): ptr Layout00 {.
    importc, libprag.}

proc copy*(self: Layout): Layout =
  let gobj = pango_layout_copy(cast[ptr Layout00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_layout_get_alignment(self: ptr Layout00): Alignment {.
    importc, libprag.}

proc getAlignment*(self: Layout): Alignment =
  pango_layout_get_alignment(cast[ptr Layout00](self.impl))

proc alignment*(self: Layout): Alignment =
  pango_layout_get_alignment(cast[ptr Layout00](self.impl))

proc pango_layout_get_attributes(self: ptr Layout00): ptr AttrList00 {.
    importc, libprag.}

proc getAttributes*(self: Layout): AttrList =
  let impl0 = pango_layout_get_attributes(cast[ptr Layout00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_attr_list_get_type(), impl0))

proc attributes*(self: Layout): AttrList =
  let impl0 = pango_layout_get_attributes(cast[ptr Layout00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoAttrList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_attr_list_get_type(), impl0))

proc pango_layout_get_auto_dir(self: ptr Layout00): gboolean {.
    importc, libprag.}

proc getAutoDir*(self: Layout): bool =
  toBool(pango_layout_get_auto_dir(cast[ptr Layout00](self.impl)))

proc autoDir*(self: Layout): bool =
  toBool(pango_layout_get_auto_dir(cast[ptr Layout00](self.impl)))

proc pango_layout_get_baseline(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getBaseline*(self: Layout): int =
  int(pango_layout_get_baseline(cast[ptr Layout00](self.impl)))

proc baseline*(self: Layout): int =
  int(pango_layout_get_baseline(cast[ptr Layout00](self.impl)))

proc pango_layout_get_character_count(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getCharacterCount*(self: Layout): int =
  int(pango_layout_get_character_count(cast[ptr Layout00](self.impl)))

proc characterCount*(self: Layout): int =
  int(pango_layout_get_character_count(cast[ptr Layout00](self.impl)))

proc pango_layout_get_context(self: ptr Layout00): ptr Context00 {.
    importc, libprag.}

proc getContext*(self: Layout): Context =
  let gobj = pango_layout_get_context(cast[ptr Layout00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: Layout): Context =
  let gobj = pango_layout_get_context(cast[ptr Layout00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_layout_get_cursor_pos(self: ptr Layout00; index: int32; strongPos: var Rectangle;
    weakPos: var Rectangle) {.
    importc, libprag.}

proc getCursorPos*(self: Layout; index: int; strongPos: var Rectangle = cast[var Rectangle](nil);
    weakPos: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_get_cursor_pos(cast[ptr Layout00](self.impl), int32(index), strongPos, weakPos)

proc pango_layout_get_direction(self: ptr Layout00; index: int32): Direction {.
    importc, libprag.}

proc getDirection*(self: Layout; index: int): Direction =
  pango_layout_get_direction(cast[ptr Layout00](self.impl), int32(index))

proc pango_layout_get_ellipsize(self: ptr Layout00): EllipsizeMode {.
    importc, libprag.}

proc getEllipsize*(self: Layout): EllipsizeMode =
  pango_layout_get_ellipsize(cast[ptr Layout00](self.impl))

proc ellipsize*(self: Layout): EllipsizeMode =
  pango_layout_get_ellipsize(cast[ptr Layout00](self.impl))

proc pango_layout_get_extents(self: ptr Layout00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getExtents*(self: Layout; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_get_extents(cast[ptr Layout00](self.impl), inkRect, logicalRect)

proc pango_layout_get_font_description(self: ptr Layout00): ptr FontDescription00 {.
    importc, libprag.}

proc getFontDescription*(self: Layout): FontDescription =
  let impl0 = pango_layout_get_font_description(cast[ptr Layout00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_font_description_get_type(), impl0))

proc fontDescription*(self: Layout): FontDescription =
  let impl0 = pango_layout_get_font_description(cast[ptr Layout00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_font_description_get_type(), impl0))

proc pango_layout_get_height(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getHeight*(self: Layout): int =
  int(pango_layout_get_height(cast[ptr Layout00](self.impl)))

proc height*(self: Layout): int =
  int(pango_layout_get_height(cast[ptr Layout00](self.impl)))

proc pango_layout_get_indent(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getIndent*(self: Layout): int =
  int(pango_layout_get_indent(cast[ptr Layout00](self.impl)))

proc indent*(self: Layout): int =
  int(pango_layout_get_indent(cast[ptr Layout00](self.impl)))

proc pango_layout_get_justify(self: ptr Layout00): gboolean {.
    importc, libprag.}

proc getJustify*(self: Layout): bool =
  toBool(pango_layout_get_justify(cast[ptr Layout00](self.impl)))

proc justify*(self: Layout): bool =
  toBool(pango_layout_get_justify(cast[ptr Layout00](self.impl)))

proc pango_layout_get_line_count(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getLineCount*(self: Layout): int =
  int(pango_layout_get_line_count(cast[ptr Layout00](self.impl)))

proc lineCount*(self: Layout): int =
  int(pango_layout_get_line_count(cast[ptr Layout00](self.impl)))

proc pango_layout_get_line_spacing(self: ptr Layout00): cfloat {.
    importc, libprag.}

proc getLineSpacing*(self: Layout): cfloat =
  pango_layout_get_line_spacing(cast[ptr Layout00](self.impl))

proc lineSpacing*(self: Layout): cfloat =
  pango_layout_get_line_spacing(cast[ptr Layout00](self.impl))

proc pango_layout_get_log_attrs(self: ptr Layout00; attrs: var ptr LogAttr00;
    nAttrs: var int32) {.
    importc, libprag.}

proc getLogAttrs*(self: Layout; attrs: var ptr LogAttr00; nAttrs: var int) =
  var nAttrs_00: int32
  pango_layout_get_log_attrs(cast[ptr Layout00](self.impl), attrs, nAttrs_00)
  if nAttrs.addr != nil:
    nAttrs = int(nAttrs_00)

proc pango_layout_get_log_attrs_readonly(self: ptr Layout00; nAttrs: var int32): ptr LogAttr00 {.
    importc, libprag.}

proc getLogAttrsReadonly*(self: Layout; nAttrs: var int): ptr LogAttr00 =
  var nAttrs_00: int32
  result = pango_layout_get_log_attrs_readonly(cast[ptr Layout00](self.impl), nAttrs_00)
  if nAttrs.addr != nil:
    nAttrs = int(nAttrs_00)

proc pango_layout_get_pixel_extents(self: ptr Layout00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getPixelExtents*(self: Layout; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_get_pixel_extents(cast[ptr Layout00](self.impl), inkRect, logicalRect)

proc pango_layout_get_pixel_size(self: ptr Layout00; width: var int32; height: var int32) {.
    importc, libprag.}

proc getPixelSize*(self: Layout; width: var int = cast[var int](nil);
    height: var int = cast[var int](nil)) =
  var width_00: int32
  var height_00: int32
  pango_layout_get_pixel_size(cast[ptr Layout00](self.impl), width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc pango_layout_get_serial(self: ptr Layout00): uint32 {.
    importc, libprag.}

proc getSerial*(self: Layout): int =
  int(pango_layout_get_serial(cast[ptr Layout00](self.impl)))

proc serial*(self: Layout): int =
  int(pango_layout_get_serial(cast[ptr Layout00](self.impl)))

proc pango_layout_get_single_paragraph_mode(self: ptr Layout00): gboolean {.
    importc, libprag.}

proc getSingleParagraphMode*(self: Layout): bool =
  toBool(pango_layout_get_single_paragraph_mode(cast[ptr Layout00](self.impl)))

proc singleParagraphMode*(self: Layout): bool =
  toBool(pango_layout_get_single_paragraph_mode(cast[ptr Layout00](self.impl)))

proc pango_layout_get_size(self: ptr Layout00; width: var int32; height: var int32) {.
    importc, libprag.}

proc getSize*(self: Layout; width: var int = cast[var int](nil);
    height: var int = cast[var int](nil)) =
  var width_00: int32
  var height_00: int32
  pango_layout_get_size(cast[ptr Layout00](self.impl), width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc pango_layout_get_spacing(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getSpacing*(self: Layout): int =
  int(pango_layout_get_spacing(cast[ptr Layout00](self.impl)))

proc spacing*(self: Layout): int =
  int(pango_layout_get_spacing(cast[ptr Layout00](self.impl)))

proc pango_layout_get_text(self: ptr Layout00): cstring {.
    importc, libprag.}

proc getText*(self: Layout): string =
  result = $pango_layout_get_text(cast[ptr Layout00](self.impl))

proc text*(self: Layout): string =
  result = $pango_layout_get_text(cast[ptr Layout00](self.impl))

proc pango_layout_get_unknown_glyphs_count(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getUnknownGlyphsCount*(self: Layout): int =
  int(pango_layout_get_unknown_glyphs_count(cast[ptr Layout00](self.impl)))

proc unknownGlyphsCount*(self: Layout): int =
  int(pango_layout_get_unknown_glyphs_count(cast[ptr Layout00](self.impl)))

proc pango_layout_get_width(self: ptr Layout00): int32 {.
    importc, libprag.}

proc getWidth*(self: Layout): int =
  int(pango_layout_get_width(cast[ptr Layout00](self.impl)))

proc width*(self: Layout): int =
  int(pango_layout_get_width(cast[ptr Layout00](self.impl)))

proc pango_layout_index_to_line_x(self: ptr Layout00; index: int32; trailing: gboolean;
    line: var int32; xPos: var int32) {.
    importc, libprag.}

proc indexToLineX*(self: Layout; index: int; trailing: bool;
    line: var int = cast[var int](nil); xPos: var int = cast[var int](nil)) =
  var xPos_00: int32
  var line_00: int32
  pango_layout_index_to_line_x(cast[ptr Layout00](self.impl), int32(index), gboolean(trailing), line_00, xPos_00)
  if xPos.addr != nil:
    xPos = int(xPos_00)
  if line.addr != nil:
    line = int(line_00)

proc pango_layout_index_to_pos(self: ptr Layout00; index: int32; pos: var Rectangle) {.
    importc, libprag.}

proc indexToPos*(self: Layout; index: int; pos: var Rectangle) =
  pango_layout_index_to_pos(cast[ptr Layout00](self.impl), int32(index), pos)

proc pango_layout_is_ellipsized(self: ptr Layout00): gboolean {.
    importc, libprag.}

proc isEllipsized*(self: Layout): bool =
  toBool(pango_layout_is_ellipsized(cast[ptr Layout00](self.impl)))

proc pango_layout_is_wrapped(self: ptr Layout00): gboolean {.
    importc, libprag.}

proc isWrapped*(self: Layout): bool =
  toBool(pango_layout_is_wrapped(cast[ptr Layout00](self.impl)))

proc pango_layout_move_cursor_visually(self: ptr Layout00; strong: gboolean;
    oldIndex: int32; oldTrailing: int32; direction: int32; newIndex: var int32;
    newTrailing: var int32) {.
    importc, libprag.}

proc moveCursorVisually*(self: Layout; strong: bool; oldIndex: int;
    oldTrailing: int; direction: int; newIndex: var int; newTrailing: var int) =
  var newTrailing_00: int32
  var newIndex_00: int32
  pango_layout_move_cursor_visually(cast[ptr Layout00](self.impl), gboolean(strong), int32(oldIndex), int32(oldTrailing), int32(direction), newIndex_00, newTrailing_00)
  if newTrailing.addr != nil:
    newTrailing = int(newTrailing_00)
  if newIndex.addr != nil:
    newIndex = int(newIndex_00)

proc pango_layout_set_alignment(self: ptr Layout00; alignment: Alignment) {.
    importc, libprag.}

proc setAlignment*(self: Layout; alignment: Alignment) =
  pango_layout_set_alignment(cast[ptr Layout00](self.impl), alignment)

proc `alignment=`*(self: Layout; alignment: Alignment) =
  pango_layout_set_alignment(cast[ptr Layout00](self.impl), alignment)

proc pango_layout_set_attributes(self: ptr Layout00; attrs: ptr AttrList00) {.
    importc, libprag.}

proc setAttributes*(self: Layout; attrs: AttrList = nil) =
  pango_layout_set_attributes(cast[ptr Layout00](self.impl), if attrs.isNil: nil else: cast[ptr AttrList00](attrs.impl))

proc `attributes=`*(self: Layout; attrs: AttrList = nil) =
  pango_layout_set_attributes(cast[ptr Layout00](self.impl), if attrs.isNil: nil else: cast[ptr AttrList00](attrs.impl))

proc pango_layout_set_auto_dir(self: ptr Layout00; autoDir: gboolean) {.
    importc, libprag.}

proc setAutoDir*(self: Layout; autoDir: bool = true) =
  pango_layout_set_auto_dir(cast[ptr Layout00](self.impl), gboolean(autoDir))

proc `autoDir=`*(self: Layout; autoDir: bool) =
  pango_layout_set_auto_dir(cast[ptr Layout00](self.impl), gboolean(autoDir))

proc pango_layout_set_ellipsize(self: ptr Layout00; ellipsize: EllipsizeMode) {.
    importc, libprag.}

proc setEllipsize*(self: Layout; ellipsize: EllipsizeMode) =
  pango_layout_set_ellipsize(cast[ptr Layout00](self.impl), ellipsize)

proc `ellipsize=`*(self: Layout; ellipsize: EllipsizeMode) =
  pango_layout_set_ellipsize(cast[ptr Layout00](self.impl), ellipsize)

proc pango_layout_set_font_description(self: ptr Layout00; desc: ptr FontDescription00) {.
    importc, libprag.}

proc setFontDescription*(self: Layout; desc: FontDescription = nil) =
  pango_layout_set_font_description(cast[ptr Layout00](self.impl), if desc.isNil: nil else: cast[ptr FontDescription00](desc.impl))

proc `fontDescription=`*(self: Layout; desc: FontDescription = nil) =
  pango_layout_set_font_description(cast[ptr Layout00](self.impl), if desc.isNil: nil else: cast[ptr FontDescription00](desc.impl))

proc pango_layout_set_height(self: ptr Layout00; height: int32) {.
    importc, libprag.}

proc setHeight*(self: Layout; height: int) =
  pango_layout_set_height(cast[ptr Layout00](self.impl), int32(height))

proc `height=`*(self: Layout; height: int) =
  pango_layout_set_height(cast[ptr Layout00](self.impl), int32(height))

proc pango_layout_set_indent(self: ptr Layout00; indent: int32) {.
    importc, libprag.}

proc setIndent*(self: Layout; indent: int) =
  pango_layout_set_indent(cast[ptr Layout00](self.impl), int32(indent))

proc `indent=`*(self: Layout; indent: int) =
  pango_layout_set_indent(cast[ptr Layout00](self.impl), int32(indent))

proc pango_layout_set_justify(self: ptr Layout00; justify: gboolean) {.
    importc, libprag.}

proc setJustify*(self: Layout; justify: bool = true) =
  pango_layout_set_justify(cast[ptr Layout00](self.impl), gboolean(justify))

proc `justify=`*(self: Layout; justify: bool) =
  pango_layout_set_justify(cast[ptr Layout00](self.impl), gboolean(justify))

proc pango_layout_set_line_spacing(self: ptr Layout00; factor: cfloat) {.
    importc, libprag.}

proc setLineSpacing*(self: Layout; factor: cfloat) =
  pango_layout_set_line_spacing(cast[ptr Layout00](self.impl), factor)

proc `lineSpacing=`*(self: Layout; factor: cfloat) =
  pango_layout_set_line_spacing(cast[ptr Layout00](self.impl), factor)

proc pango_layout_set_markup(self: ptr Layout00; markup: cstring; length: int32) {.
    importc, libprag.}

proc setMarkup*(self: Layout; markup: cstring; length: int) =
  pango_layout_set_markup(cast[ptr Layout00](self.impl), markup, int32(length))

proc pango_layout_set_markup_with_accel(self: ptr Layout00; markup: cstring;
    length: int32; accelMarker: gunichar; accelChar: var gunichar) {.
    importc, libprag.}

proc setMarkupWithAccel*(self: Layout; markup: cstring; length: int;
    accelMarker: gunichar; accelChar: var gunichar = cast[var gunichar](nil)) =
  pango_layout_set_markup_with_accel(cast[ptr Layout00](self.impl), markup, int32(length), accelMarker, accelChar)

proc pango_layout_set_single_paragraph_mode(self: ptr Layout00; setting: gboolean) {.
    importc, libprag.}

proc setSingleParagraphMode*(self: Layout; setting: bool = true) =
  pango_layout_set_single_paragraph_mode(cast[ptr Layout00](self.impl), gboolean(setting))

proc `singleParagraphMode=`*(self: Layout; setting: bool) =
  pango_layout_set_single_paragraph_mode(cast[ptr Layout00](self.impl), gboolean(setting))

proc pango_layout_set_spacing(self: ptr Layout00; spacing: int32) {.
    importc, libprag.}

proc setSpacing*(self: Layout; spacing: int) =
  pango_layout_set_spacing(cast[ptr Layout00](self.impl), int32(spacing))

proc `spacing=`*(self: Layout; spacing: int) =
  pango_layout_set_spacing(cast[ptr Layout00](self.impl), int32(spacing))

proc pango_layout_set_text(self: ptr Layout00; text: cstring; length: int32) {.
    importc, libprag.}

proc setText*(self: Layout; text: cstring; length: int = -1) =
  pango_layout_set_text(cast[ptr Layout00](self.impl), text, int32(length))

proc pango_layout_set_width(self: ptr Layout00; width: int32) {.
    importc, libprag.}

proc setWidth*(self: Layout; width: int) =
  pango_layout_set_width(cast[ptr Layout00](self.impl), int32(width))

proc `width=`*(self: Layout; width: int) =
  pango_layout_set_width(cast[ptr Layout00](self.impl), int32(width))

proc pango_layout_xy_to_index(self: ptr Layout00; x: int32; y: int32; index: var int32;
    trailing: var int32): gboolean {.
    importc, libprag.}

proc xyToIndex*(self: Layout; x: int; y: int; index: var int;
    trailing: var int): bool =
  var index_00: int32
  var trailing_00: int32
  result = toBool(pango_layout_xy_to_index(cast[ptr Layout00](self.impl), int32(x), int32(y), index_00, trailing_00))
  if index.addr != nil:
    index = int(index_00)
  if trailing.addr != nil:
    trailing = int(trailing_00)

type
  LayoutIter00* {.pure.} = object
  LayoutIter* = ref object
    impl*: ptr LayoutIter00
    ignoreFinalizer*: bool

proc pango_layout_iter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoLayoutIter*(self: LayoutIter) =
  if not self.ignoreFinalizer:
    boxedFree(pango_layout_iter_get_type(), cast[ptr LayoutIter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LayoutIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_layout_iter_get_type(), cast[ptr LayoutIter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var LayoutIter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoLayoutIter)

proc pango_layout_iter_free(self: ptr LayoutIter00) {.
    importc, libprag.}

proc free*(self: LayoutIter) =
  pango_layout_iter_free(cast[ptr LayoutIter00](self.impl))

proc finalizerfree*(self: LayoutIter) =
  if not self.ignoreFinalizer:
    pango_layout_iter_free(cast[ptr LayoutIter00](self.impl))

proc pango_layout_iter_copy(self: ptr LayoutIter00): ptr LayoutIter00 {.
    importc, libprag.}

proc copy*(self: LayoutIter): LayoutIter =
  let impl0 = pango_layout_iter_copy(cast[ptr LayoutIter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLayoutIter)
  result.impl = impl0

proc pango_layout_iter_at_last_line(self: ptr LayoutIter00): gboolean {.
    importc, libprag.}

proc atLastLine*(self: LayoutIter): bool =
  toBool(pango_layout_iter_at_last_line(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_get_baseline(self: ptr LayoutIter00): int32 {.
    importc, libprag.}

proc getBaseline*(self: LayoutIter): int =
  int(pango_layout_iter_get_baseline(cast[ptr LayoutIter00](self.impl)))

proc baseline*(self: LayoutIter): int =
  int(pango_layout_iter_get_baseline(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_get_char_extents(self: ptr LayoutIter00; logicalRect: var Rectangle) {.
    importc, libprag.}

proc getCharExtents*(self: LayoutIter; logicalRect: var Rectangle) =
  pango_layout_iter_get_char_extents(cast[ptr LayoutIter00](self.impl), logicalRect)

proc getCharExtents*(self: LayoutIter): Rectangle =
  pango_layout_iter_get_char_extents(cast[ptr LayoutIter00](self.impl), result)

proc pango_layout_iter_get_cluster_extents(self: ptr LayoutIter00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getClusterExtents*(self: LayoutIter; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_iter_get_cluster_extents(cast[ptr LayoutIter00](self.impl), inkRect, logicalRect)

proc pango_layout_iter_get_index(self: ptr LayoutIter00): int32 {.
    importc, libprag.}

proc getIndex*(self: LayoutIter): int =
  int(pango_layout_iter_get_index(cast[ptr LayoutIter00](self.impl)))

proc index*(self: LayoutIter): int =
  int(pango_layout_iter_get_index(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_get_layout(self: ptr LayoutIter00): ptr Layout00 {.
    importc, libprag.}

proc getLayout*(self: LayoutIter): Layout =
  let gobj = pango_layout_iter_get_layout(cast[ptr LayoutIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc layout*(self: LayoutIter): Layout =
  let gobj = pango_layout_iter_get_layout(cast[ptr LayoutIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_layout_iter_get_layout_extents(self: ptr LayoutIter00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getLayoutExtents*(self: LayoutIter; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_iter_get_layout_extents(cast[ptr LayoutIter00](self.impl), inkRect, logicalRect)

proc pango_layout_iter_get_line_extents(self: ptr LayoutIter00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getLineExtents*(self: LayoutIter; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_iter_get_line_extents(cast[ptr LayoutIter00](self.impl), inkRect, logicalRect)

proc pango_layout_iter_get_line_yrange(self: ptr LayoutIter00; y0: var int32;
    y1: var int32) {.
    importc, libprag.}

proc getLineYrange*(self: LayoutIter; y0: var int = cast[var int](nil);
    y1: var int = cast[var int](nil)) =
  var y0_00: int32
  var y1_00: int32
  pango_layout_iter_get_line_yrange(cast[ptr LayoutIter00](self.impl), y0_00, y1_00)
  if y0.addr != nil:
    y0 = int(y0_00)
  if y1.addr != nil:
    y1 = int(y1_00)

proc pango_layout_iter_get_run(self: ptr LayoutIter00): ptr GlyphItem00 {.
    importc, libprag.}

proc getRun*(self: LayoutIter): GlyphItem =
  let impl0 = pango_layout_iter_get_run(cast[ptr LayoutIter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoGlyphItem)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_glyph_item_get_type(), impl0))

proc run*(self: LayoutIter): GlyphItem =
  let impl0 = pango_layout_iter_get_run(cast[ptr LayoutIter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoGlyphItem)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_glyph_item_get_type(), impl0))

proc pango_layout_iter_get_run_extents(self: ptr LayoutIter00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getRunExtents*(self: LayoutIter; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_iter_get_run_extents(cast[ptr LayoutIter00](self.impl), inkRect, logicalRect)

proc pango_layout_iter_get_run_readonly(self: ptr LayoutIter00): ptr GlyphItem00 {.
    importc, libprag.}

proc getRunReadonly*(self: LayoutIter): GlyphItem =
  let impl0 = pango_layout_iter_get_run_readonly(cast[ptr LayoutIter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoGlyphItem)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_glyph_item_get_type(), impl0))

proc runReadonly*(self: LayoutIter): GlyphItem =
  let impl0 = pango_layout_iter_get_run_readonly(cast[ptr LayoutIter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoGlyphItem)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_glyph_item_get_type(), impl0))

proc pango_layout_iter_next_char(self: ptr LayoutIter00): gboolean {.
    importc, libprag.}

proc nextChar*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_char(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_next_cluster(self: ptr LayoutIter00): gboolean {.
    importc, libprag.}

proc nextCluster*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_cluster(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_next_line(self: ptr LayoutIter00): gboolean {.
    importc, libprag.}

proc nextLine*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_line(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_next_run(self: ptr LayoutIter00): gboolean {.
    importc, libprag.}

proc nextRun*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_run(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_get_iter(self: ptr Layout00): ptr LayoutIter00 {.
    importc, libprag.}

proc getIter*(self: Layout): LayoutIter =
  fnew(result, gBoxedFreePangoLayoutIter)
  result.impl = pango_layout_get_iter(cast[ptr Layout00](self.impl))

proc iter*(self: Layout): LayoutIter =
  fnew(result, gBoxedFreePangoLayoutIter)
  result.impl = pango_layout_get_iter(cast[ptr Layout00](self.impl))

type
  LayoutLine00* {.pure.} = object
  LayoutLine* = ref object
    impl*: ptr LayoutLine00
    ignoreFinalizer*: bool

proc pango_layout_line_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoLayoutLine*(self: LayoutLine) =
  if not self.ignoreFinalizer:
    boxedFree(pango_layout_line_get_type(), cast[ptr LayoutLine00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LayoutLine()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_layout_line_get_type(), cast[ptr LayoutLine00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var LayoutLine) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoLayoutLine)

proc pango_layout_line_unref(self: ptr LayoutLine00) {.
    importc, libprag.}

proc unref*(self: LayoutLine) =
  pango_layout_line_unref(cast[ptr LayoutLine00](self.impl))

proc finalizerunref*(self: LayoutLine) =
  if not self.ignoreFinalizer:
    pango_layout_line_unref(cast[ptr LayoutLine00](self.impl))

proc pango_layout_line_get_height(self: ptr LayoutLine00; height: var int32) {.
    importc, libprag.}

proc getHeight*(self: LayoutLine; height: var int = cast[var int](nil)) =
  var height_00: int32
  pango_layout_line_get_height(cast[ptr LayoutLine00](self.impl), height_00)
  if height.addr != nil:
    height = int(height_00)

proc getHeight*(self: LayoutLine): int  =
  var result_00: int32
  pango_layout_line_get_height(cast[ptr LayoutLine00](self.impl), result_00)
  if result.addr != nil:
    result = int(result_00)

proc pango_layout_line_get_pixel_extents(self: ptr LayoutLine00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getPixelExtents*(self: LayoutLine; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_line_get_pixel_extents(cast[ptr LayoutLine00](self.impl), inkRect, logicalRect)

proc pango_layout_line_get_x_ranges(self: ptr LayoutLine00; startIndex: int32;
    endIndex: int32; ranges: var ptr int32; nRanges: var int32) {.
    importc, libprag.}

proc getXRanges*(self: LayoutLine; startIndex: int; endIndex: int;
    ranges: var seq[int32]; nRanges: var int) =
  var nRanges_00: int32
  var ranges_00: ptr int32
  pango_layout_line_get_x_ranges(cast[ptr LayoutLine00](self.impl), int32(startIndex), int32(endIndex), ranges_00, nRanges_00)
  if nRanges.addr != nil:
    nRanges = int(nRanges_00)
  ranges.setLen(nRanges)
  copyMem(unsafeaddr ranges[0], ranges_00, nRanges.int * sizeof(ranges[0]))
  cogfree(ranges_00)

proc pango_layout_line_index_to_x(self: ptr LayoutLine00; index: int32; trailing: gboolean;
    xPos: var int32) {.
    importc, libprag.}

proc indexToX*(self: LayoutLine; index: int; trailing: bool;
    xPos: var int) =
  var xPos_00: int32
  pango_layout_line_index_to_x(cast[ptr LayoutLine00](self.impl), int32(index), gboolean(trailing), xPos_00)
  if xPos.addr != nil:
    xPos = int(xPos_00)

proc pango_layout_line_ref(self: ptr LayoutLine00): ptr LayoutLine00 {.
    importc, libprag.}

proc `ref`*(self: LayoutLine): LayoutLine =
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = pango_layout_line_ref(cast[ptr LayoutLine00](self.impl))

proc pango_layout_line_get_extents(self: ptr LayoutLine00; inkRect: var Rectangle;
    logicalRect: var Rectangle) {.
    importc, libprag.}

proc getExtents*(self: LayoutLine; inkRect: var Rectangle = cast[var Rectangle](nil);
    logicalRect: var Rectangle = cast[var Rectangle](nil)) =
  pango_layout_line_get_extents(cast[ptr LayoutLine00](self.impl), inkRect, logicalRect)

proc pango_layout_line_x_to_index(self: ptr LayoutLine00; xPos: int32; index: var int32;
    trailing: var int32): gboolean {.
    importc, libprag.}

proc xToIndex*(self: LayoutLine; xPos: int; index: var int;
    trailing: var int): bool =
  var index_00: int32
  var trailing_00: int32
  result = toBool(pango_layout_line_x_to_index(cast[ptr LayoutLine00](self.impl), int32(xPos), index_00, trailing_00))
  if index.addr != nil:
    index = int(index_00)
  if trailing.addr != nil:
    trailing = int(trailing_00)

proc pango_layout_get_line(self: ptr Layout00; line: int32): ptr LayoutLine00 {.
    importc, libprag.}

proc getLine*(self: Layout; line: int): LayoutLine =
  let impl0 = pango_layout_get_line(cast[ptr Layout00](self.impl), int32(line))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), impl0))

proc pango_layout_get_line_readonly(self: ptr Layout00; line: int32): ptr LayoutLine00 {.
    importc, libprag.}

proc getLineReadonly*(self: Layout; line: int): LayoutLine =
  let impl0 = pango_layout_get_line_readonly(cast[ptr Layout00](self.impl), int32(line))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), impl0))

proc pango_layout_get_lines(self: ptr Layout00): ptr glib.SList {.
    importc, libprag.}

proc getLines*(self: Layout): seq[LayoutLine] =
  discard

proc lines*(self: Layout): seq[LayoutLine] =
  discard

proc pango_layout_get_lines_readonly(self: ptr Layout00): ptr glib.SList {.
    importc, libprag.}

proc getLinesReadonly*(self: Layout): seq[LayoutLine] =
  discard

proc linesReadonly*(self: Layout): seq[LayoutLine] =
  discard

proc pango_layout_iter_get_line(self: ptr LayoutIter00): ptr LayoutLine00 {.
    importc, libprag.}

proc getLine*(self: LayoutIter): LayoutLine =
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = pango_layout_iter_get_line(cast[ptr LayoutIter00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), result.impl))

proc line*(self: LayoutIter): LayoutLine =
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = pango_layout_iter_get_line(cast[ptr LayoutIter00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), result.impl))

proc pango_layout_iter_get_line_readonly(self: ptr LayoutIter00): ptr LayoutLine00 {.
    importc, libprag.}

proc getLineReadonly*(self: LayoutIter): LayoutLine =
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = pango_layout_iter_get_line_readonly(cast[ptr LayoutIter00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), result.impl))

proc lineReadonly*(self: LayoutIter): LayoutLine =
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = pango_layout_iter_get_line_readonly(cast[ptr LayoutIter00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), result.impl))

type
  TabArray00* {.pure.} = object
  TabArray* = ref object
    impl*: ptr TabArray00
    ignoreFinalizer*: bool

proc pango_tab_array_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoTabArray*(self: TabArray) =
  if not self.ignoreFinalizer:
    boxedFree(pango_tab_array_get_type(), cast[ptr TabArray00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TabArray()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_tab_array_get_type(), cast[ptr TabArray00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TabArray) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoTabArray)

proc pango_tab_array_free(self: ptr TabArray00) {.
    importc, libprag.}

proc free*(self: TabArray) =
  pango_tab_array_free(cast[ptr TabArray00](self.impl))

proc finalizerfree*(self: TabArray) =
  if not self.ignoreFinalizer:
    pango_tab_array_free(cast[ptr TabArray00](self.impl))

proc pango_tab_array_copy(self: ptr TabArray00): ptr TabArray00 {.
    importc, libprag.}

proc copy*(self: TabArray): TabArray =
  fnew(result, gBoxedFreePangoTabArray)
  result.impl = pango_tab_array_copy(cast[ptr TabArray00](self.impl))

proc pango_tab_array_new(initialSize: int32; positionsInPixels: gboolean): ptr TabArray00 {.
    importc, libprag.}

proc newTabArray*(initialSize: int; positionsInPixels: bool): TabArray =
  fnew(result, gBoxedFreePangoTabArray)
  result.impl = pango_tab_array_new(int32(initialSize), gboolean(positionsInPixels))

proc newTabArray*(tdesc: typedesc; initialSize: int; positionsInPixels: bool): tdesc =
  assert(result is TabArray)
  fnew(result, gBoxedFreePangoTabArray)
  result.impl = pango_tab_array_new(int32(initialSize), gboolean(positionsInPixels))

proc initTabArray*[T](result: var T; initialSize: int; positionsInPixels: bool) {.deprecated.} =
  assert(result is TabArray)
  fnew(result, gBoxedFreePangoTabArray)
  result.impl = pango_tab_array_new(int32(initialSize), gboolean(positionsInPixels))

proc pango_tab_array_get_positions_in_pixels(self: ptr TabArray00): gboolean {.
    importc, libprag.}

proc getPositionsInPixels*(self: TabArray): bool =
  toBool(pango_tab_array_get_positions_in_pixels(cast[ptr TabArray00](self.impl)))

proc positionsInPixels*(self: TabArray): bool =
  toBool(pango_tab_array_get_positions_in_pixels(cast[ptr TabArray00](self.impl)))

proc pango_tab_array_get_size(self: ptr TabArray00): int32 {.
    importc, libprag.}

proc getSize*(self: TabArray): int =
  int(pango_tab_array_get_size(cast[ptr TabArray00](self.impl)))

proc size*(self: TabArray): int =
  int(pango_tab_array_get_size(cast[ptr TabArray00](self.impl)))

proc pango_tab_array_resize(self: ptr TabArray00; newSize: int32) {.
    importc, libprag.}

proc resize*(self: TabArray; newSize: int) =
  pango_tab_array_resize(cast[ptr TabArray00](self.impl), int32(newSize))

proc pango_layout_get_tabs(self: ptr Layout00): ptr TabArray00 {.
    importc, libprag.}

proc getTabs*(self: Layout): TabArray =
  let impl0 = pango_layout_get_tabs(cast[ptr Layout00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoTabArray)
  result.impl = impl0

proc tabs*(self: Layout): TabArray =
  let impl0 = pango_layout_get_tabs(cast[ptr Layout00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoTabArray)
  result.impl = impl0

proc pango_layout_set_tabs(self: ptr Layout00; tabs: ptr TabArray00) {.
    importc, libprag.}

proc setTabs*(self: Layout; tabs: TabArray = nil) =
  pango_layout_set_tabs(cast[ptr Layout00](self.impl), if tabs.isNil: nil else: cast[ptr TabArray00](tabs.impl))

proc `tabs=`*(self: Layout; tabs: TabArray = nil) =
  pango_layout_set_tabs(cast[ptr Layout00](self.impl), if tabs.isNil: nil else: cast[ptr TabArray00](tabs.impl))

type
  TabAlign* {.size: sizeof(cint), pure.} = enum
    left = 0

proc pango_tab_array_get_tab(self: ptr TabArray00; tabIndex: int32; alignment: var TabAlign;
    location: var int32) {.
    importc, libprag.}

proc getTab*(self: TabArray; tabIndex: int; alignment: var TabAlign = cast[var TabAlign](nil);
    location: var int = cast[var int](nil)) =
  var location_00: int32
  pango_tab_array_get_tab(cast[ptr TabArray00](self.impl), int32(tabIndex), alignment, location_00)
  if location.addr != nil:
    location = int(location_00)

proc pango_tab_array_set_tab(self: ptr TabArray00; tabIndex: int32; alignment: TabAlign;
    location: int32) {.
    importc, libprag.}

proc setTab*(self: TabArray; tabIndex: int; alignment: TabAlign;
    location: int) =
  pango_tab_array_set_tab(cast[ptr TabArray00](self.impl), int32(tabIndex), alignment, int32(location))

type
  WrapMode* {.size: sizeof(cint), pure.} = enum
    word = 0
    char = 1
    wordChar = 2

proc pango_layout_get_wrap(self: ptr Layout00): WrapMode {.
    importc, libprag.}

proc getWrap*(self: Layout): WrapMode =
  pango_layout_get_wrap(cast[ptr Layout00](self.impl))

proc wrap*(self: Layout): WrapMode =
  pango_layout_get_wrap(cast[ptr Layout00](self.impl))

proc pango_layout_set_wrap(self: ptr Layout00; wrap: WrapMode) {.
    importc, libprag.}

proc setWrap*(self: Layout; wrap: WrapMode) =
  pango_layout_set_wrap(cast[ptr Layout00](self.impl), wrap)

proc `wrap=`*(self: Layout; wrap: WrapMode) =
  pango_layout_set_wrap(cast[ptr Layout00](self.impl), wrap)

type
  Map00* {.pure.} = object
  Map* = ref object
    impl*: ptr Map00
    ignoreFinalizer*: bool

type
  MapEntry00* {.pure.} = object
  MapEntry* = ref object
    impl*: ptr MapEntry00
    ignoreFinalizer*: bool

type
  Overline* {.size: sizeof(cint), pure.} = enum
    none = 0
    single = 1

const RENDER_TYPE_NONE* = "PangoRenderNone"

type
  RenderPart* {.size: sizeof(cint), pure.} = enum
    foreground = 0
    background = 1
    underline = 2
    strikethrough = 3
    overline = 4

type
  Renderer* = ref object of gobject.Object
  Renderer00* = object of gobject.Object00

proc pango_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Renderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_renderer_activate(self: ptr Renderer00) {.
    importc, libprag.}

proc activate*(self: Renderer) =
  pango_renderer_activate(cast[ptr Renderer00](self.impl))

proc pango_renderer_deactivate(self: ptr Renderer00) {.
    importc, libprag.}

proc deactivate*(self: Renderer) =
  pango_renderer_deactivate(cast[ptr Renderer00](self.impl))

proc pango_renderer_draw_error_underline(self: ptr Renderer00; x: int32;
    y: int32; width: int32; height: int32) {.
    importc, libprag.}

proc drawErrorUnderline*(self: Renderer; x: int; y: int;
    width: int; height: int) =
  pango_renderer_draw_error_underline(cast[ptr Renderer00](self.impl), int32(x), int32(y), int32(width), int32(height))

proc pango_renderer_draw_glyph(self: ptr Renderer00; font: ptr Font00; glyph: uint32;
    x: cdouble; y: cdouble) {.
    importc, libprag.}

proc drawGlyph*(self: Renderer; font: Font; glyph: int; x: cdouble;
    y: cdouble) =
  pango_renderer_draw_glyph(cast[ptr Renderer00](self.impl), cast[ptr Font00](font.impl), uint32(glyph), x, y)

proc pango_renderer_draw_glyph_item(self: ptr Renderer00; text: cstring;
    glyphItem: ptr GlyphItem00; x: int32; y: int32) {.
    importc, libprag.}

proc drawGlyphItem*(self: Renderer; text: cstring = nil;
    glyphItem: GlyphItem; x: int; y: int) =
  pango_renderer_draw_glyph_item(cast[ptr Renderer00](self.impl), text, cast[ptr GlyphItem00](glyphItem.impl), int32(x), int32(y))

proc pango_renderer_draw_glyphs(self: ptr Renderer00; font: ptr Font00; glyphs: ptr GlyphString00;
    x: int32; y: int32) {.
    importc, libprag.}

proc drawGlyphs*(self: Renderer; font: Font; glyphs: GlyphString;
    x: int; y: int) =
  pango_renderer_draw_glyphs(cast[ptr Renderer00](self.impl), cast[ptr Font00](font.impl), cast[ptr GlyphString00](glyphs.impl), int32(x), int32(y))

proc pango_renderer_draw_layout(self: ptr Renderer00; layout: ptr Layout00;
    x: int32; y: int32) {.
    importc, libprag.}

proc drawLayout*(self: Renderer; layout: Layout; x: int; y: int) =
  pango_renderer_draw_layout(cast[ptr Renderer00](self.impl), cast[ptr Layout00](layout.impl), int32(x), int32(y))

proc pango_renderer_draw_layout_line(self: ptr Renderer00; line: ptr LayoutLine00;
    x: int32; y: int32) {.
    importc, libprag.}

proc drawLayoutLine*(self: Renderer; line: LayoutLine; x: int;
    y: int) =
  pango_renderer_draw_layout_line(cast[ptr Renderer00](self.impl), cast[ptr LayoutLine00](line.impl), int32(x), int32(y))

proc pango_renderer_draw_rectangle(self: ptr Renderer00; part: RenderPart;
    x: int32; y: int32; width: int32; height: int32) {.
    importc, libprag.}

proc drawRectangle*(self: Renderer; part: RenderPart; x: int;
    y: int; width: int; height: int) =
  pango_renderer_draw_rectangle(cast[ptr Renderer00](self.impl), part, int32(x), int32(y), int32(width), int32(height))

proc pango_renderer_draw_trapezoid(self: ptr Renderer00; part: RenderPart;
    y1: cdouble; x11: cdouble; x21: cdouble; y2: cdouble; x12: cdouble; x22: cdouble) {.
    importc, libprag.}

proc drawTrapezoid*(self: Renderer; part: RenderPart; y1: cdouble;
    x11: cdouble; x21: cdouble; y2: cdouble; x12: cdouble; x22: cdouble) =
  pango_renderer_draw_trapezoid(cast[ptr Renderer00](self.impl), part, y1, x11, x21, y2, x12, x22)

proc pango_renderer_get_alpha(self: ptr Renderer00; part: RenderPart): uint16 {.
    importc, libprag.}

proc getAlpha*(self: Renderer; part: RenderPart): uint16 =
  pango_renderer_get_alpha(cast[ptr Renderer00](self.impl), part)

proc pango_renderer_get_color(self: ptr Renderer00; part: RenderPart): ptr Color {.
    importc, libprag.}

proc getColor*(self: Renderer; part: RenderPart): ptr Color =
  pango_renderer_get_color(cast[ptr Renderer00](self.impl), part)

proc pango_renderer_get_layout(self: ptr Renderer00): ptr Layout00 {.
    importc, libprag.}

proc getLayout*(self: Renderer): Layout =
  let gobj = pango_renderer_get_layout(cast[ptr Renderer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc layout*(self: Renderer): Layout =
  let gobj = pango_renderer_get_layout(cast[ptr Renderer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, pango.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_renderer_get_layout_line(self: ptr Renderer00): ptr LayoutLine00 {.
    importc, libprag.}

proc getLayoutLine*(self: Renderer): LayoutLine =
  let impl0 = pango_renderer_get_layout_line(cast[ptr Renderer00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), impl0))

proc layoutLine*(self: Renderer): LayoutLine =
  let impl0 = pango_renderer_get_layout_line(cast[ptr Renderer00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoLayoutLine)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_layout_line_get_type(), impl0))

proc pango_renderer_get_matrix(self: ptr Renderer00): ptr Matrix00 {.
    importc, libprag.}

proc getMatrix*(self: Renderer): Matrix =
  let impl0 = pango_renderer_get_matrix(cast[ptr Renderer00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoMatrix)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_matrix_get_type(), impl0))

proc matrix*(self: Renderer): Matrix =
  let impl0 = pango_renderer_get_matrix(cast[ptr Renderer00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreePangoMatrix)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_matrix_get_type(), impl0))

proc pango_renderer_part_changed(self: ptr Renderer00; part: RenderPart) {.
    importc, libprag.}

proc partChanged*(self: Renderer; part: RenderPart) =
  pango_renderer_part_changed(cast[ptr Renderer00](self.impl), part)

proc pango_renderer_set_alpha(self: ptr Renderer00; part: RenderPart; alpha: uint16) {.
    importc, libprag.}

proc setAlpha*(self: Renderer; part: RenderPart; alpha: uint16) =
  pango_renderer_set_alpha(cast[ptr Renderer00](self.impl), part, alpha)

proc pango_renderer_set_color(self: ptr Renderer00; part: RenderPart; color: Color) {.
    importc, libprag.}

proc setColor*(self: Renderer; part: RenderPart; color: Color = cast[var Color](nil)) =
  pango_renderer_set_color(cast[ptr Renderer00](self.impl), part, color)

proc pango_renderer_set_matrix(self: ptr Renderer00; matrix: ptr Matrix00) {.
    importc, libprag.}

proc setMatrix*(self: Renderer; matrix: Matrix = nil) =
  pango_renderer_set_matrix(cast[ptr Renderer00](self.impl), if matrix.isNil: nil else: cast[ptr Matrix00](matrix.impl))

proc `matrix=`*(self: Renderer; matrix: Matrix = nil) =
  pango_renderer_set_matrix(cast[ptr Renderer00](self.impl), if matrix.isNil: nil else: cast[ptr Matrix00](matrix.impl))

const SCALE* = 1024'i32

type
  ScriptIter00* {.pure.} = object
  ScriptIter* = ref object
    impl*: ptr ScriptIter00
    ignoreFinalizer*: bool

proc pango_script_iter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreePangoScriptIter*(self: ScriptIter) =
  if not self.ignoreFinalizer:
    boxedFree(pango_script_iter_get_type(), cast[ptr ScriptIter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ScriptIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(pango_script_iter_get_type(), cast[ptr ScriptIter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ScriptIter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreePangoScriptIter)

proc pango_script_iter_free(self: ptr ScriptIter00) {.
    importc, libprag.}

proc free*(self: ScriptIter) =
  pango_script_iter_free(cast[ptr ScriptIter00](self.impl))

proc finalizerfree*(self: ScriptIter) =
  if not self.ignoreFinalizer:
    pango_script_iter_free(cast[ptr ScriptIter00](self.impl))

proc pango_script_iter_new(text: cstring; length: int32): ptr ScriptIter00 {.
    importc, libprag.}

proc newScriptIter*(text: cstring; length: int): ScriptIter =
  fnew(result, gBoxedFreePangoScriptIter)
  result.impl = pango_script_iter_new(text, int32(length))

proc newScriptIter*(tdesc: typedesc; text: cstring; length: int): tdesc =
  assert(result is ScriptIter)
  fnew(result, gBoxedFreePangoScriptIter)
  result.impl = pango_script_iter_new(text, int32(length))

proc initScriptIter*[T](result: var T; text: cstring; length: int) {.deprecated.} =
  assert(result is ScriptIter)
  fnew(result, gBoxedFreePangoScriptIter)
  result.impl = pango_script_iter_new(text, int32(length))

proc pango_script_iter_get_range(self: ptr ScriptIter00; start: var cstring;
    `end`: var cstring; script: var Script) {.
    importc, libprag.}

proc getRange*(self: ScriptIter; start: var string = cast[var string](nil);
    `end`: var string = cast[var string](nil); script: var Script = cast[var Script](nil)) =
  var start_00: cstring
  var end_00: cstring
  pango_script_iter_get_range(cast[ptr ScriptIter00](self.impl), start_00, end_00, script)
  if start.addr != nil:
    start = $(start_00)
  if `end`.addr != nil:
    `end` = $(end_00)

proc pango_script_iter_next(self: ptr ScriptIter00): gboolean {.
    importc, libprag.}

proc next*(self: ScriptIter): bool =
  toBool(pango_script_iter_next(cast[ptr ScriptIter00](self.impl)))

type
  ShapeFlag* {.size: sizeof(cint), pure.} = enum
    roundPositions = 0

  ShapeFlags* {.size: sizeof(cint).} = set[ShapeFlag]

const
  ShapeFlagsNone* = ShapeFlags({})
proc none*(t: typedesc[ShapeFlags]): ShapeFlags = ShapeFlags({})

type
  ShowFlag* {.size: sizeof(cint), pure.} = enum
    spaces = 0
    lineBreaks = 1
    ignorables = 2

  ShowFlags* {.size: sizeof(cint).} = set[ShowFlag]

const
  ShowFlagsNone* = ShowFlags({})
proc none*(t: typedesc[ShowFlags]): ShowFlags = ShowFlags({})

const UNKNOWN_GLYPH_HEIGHT* = 14'i32

const UNKNOWN_GLYPH_WIDTH* = 10'i32

type
  Underline* {.size: sizeof(cint), pure.} = enum
    none = 0
    single = 1
    double = 2
    low = 3
    error = 4
    singleLine = 5
    doubleLine = 6
    errorLine = 7

const VERSION_MIN_REQUIRED* = 2'i32

proc pango_attr_allow_breaks_new(allowBreaks: gboolean): ptr Attribute00 {.
    importc, libprag.}

proc newAttrAllowBreaks*(allowBreaks: bool): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_allow_breaks_new(gboolean(allowBreaks))

proc pango_attr_background_alpha_new(alpha: uint16): ptr Attribute00 {.
    importc, libprag.}

proc newAttrBackgroundAlpha*(alpha: uint16): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_background_alpha_new(alpha)

proc pango_attr_background_new(red: uint16; green: uint16; blue: uint16): ptr Attribute00 {.
    importc, libprag.}

proc newAttrBackground*(red: uint16; green: uint16; blue: uint16): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_background_new(red, green, blue)

proc pango_attr_fallback_new(enableFallback: gboolean): ptr Attribute00 {.
    importc, libprag.}

proc newAttrFallback*(enableFallback: bool): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_fallback_new(gboolean(enableFallback))

proc pango_attr_family_new(family: cstring): ptr Attribute00 {.
    importc, libprag.}

proc newAttrFamily*(family: cstring): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_family_new(family)

proc pango_attr_foreground_alpha_new(alpha: uint16): ptr Attribute00 {.
    importc, libprag.}

proc newAttrForegroundAlpha*(alpha: uint16): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_foreground_alpha_new(alpha)

proc pango_attr_foreground_new(red: uint16; green: uint16; blue: uint16): ptr Attribute00 {.
    importc, libprag.}

proc newAttrForeground*(red: uint16; green: uint16; blue: uint16): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_foreground_new(red, green, blue)

proc pango_attr_gravity_hint_new(hint: GravityHint): ptr Attribute00 {.
    importc, libprag.}

proc newAttrGravityHint*(hint: GravityHint): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_gravity_hint_new(hint)

proc pango_attr_gravity_new(gravity: Gravity): ptr Attribute00 {.
    importc, libprag.}

proc newAttrGravity*(gravity: Gravity): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_gravity_new(gravity)

proc pango_attr_insert_hyphens_new(insertHyphens: gboolean): ptr Attribute00 {.
    importc, libprag.}

proc newAttrInsertHyphens*(insertHyphens: bool): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_insert_hyphens_new(gboolean(insertHyphens))

proc pango_attr_letter_spacing_new(letterSpacing: int32): ptr Attribute00 {.
    importc, libprag.}

proc newAttrLetterSpacing*(letterSpacing: int): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_letter_spacing_new(int32(letterSpacing))

proc pango_attr_overline_color_new(red: uint16; green: uint16; blue: uint16): ptr Attribute00 {.
    importc, libprag.}

proc newAttrOverlineColor*(red: uint16; green: uint16; blue: uint16): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_overline_color_new(red, green, blue)

proc pango_attr_overline_new(overline: Overline): ptr Attribute00 {.
    importc, libprag.}

proc newAttrOverline*(overline: Overline): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_overline_new(overline)

proc pango_attr_rise_new(rise: int32): ptr Attribute00 {.
    importc, libprag.}

proc newAttrRise*(rise: int): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_rise_new(int32(rise))

proc pango_attr_scale_new(scaleFactor: cdouble): ptr Attribute00 {.
    importc, libprag.}

proc newAttrScale*(scaleFactor: cdouble): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_scale_new(scaleFactor)

proc pango_attr_show_new(flags: ShowFlags): ptr Attribute00 {.
    importc, libprag.}

proc newAttrShow*(flags: ShowFlags): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_show_new(flags)

proc pango_attr_stretch_new(stretch: Stretch): ptr Attribute00 {.
    importc, libprag.}

proc newAttrStretch*(stretch: Stretch): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_stretch_new(stretch)

proc pango_attr_strikethrough_color_new(red: uint16; green: uint16; blue: uint16): ptr Attribute00 {.
    importc, libprag.}

proc newAttrStrikethroughColor*(red: uint16; green: uint16; blue: uint16): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_strikethrough_color_new(red, green, blue)

proc pango_attr_strikethrough_new(strikethrough: gboolean): ptr Attribute00 {.
    importc, libprag.}

proc newAttrStrikethrough*(strikethrough: bool): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_strikethrough_new(gboolean(strikethrough))

proc pango_attr_style_new(style: Style): ptr Attribute00 {.
    importc, libprag.}

proc newAttrStyle*(style: Style): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_style_new(style)

proc pango_attr_underline_color_new(red: uint16; green: uint16; blue: uint16): ptr Attribute00 {.
    importc, libprag.}

proc newAttrUnderlineColor*(red: uint16; green: uint16; blue: uint16): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_underline_color_new(red, green, blue)

proc pango_attr_underline_new(underline: Underline): ptr Attribute00 {.
    importc, libprag.}

proc newAttrUnderline*(underline: Underline): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_underline_new(underline)

proc pango_attr_variant_new(variant: Variant): ptr Attribute00 {.
    importc, libprag.}

proc newAttrVariant*(variant: Variant): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_variant_new(variant)

proc pango_attr_weight_new(weight: Weight): ptr Attribute00 {.
    importc, libprag.}

proc newAttrWeight*(weight: Weight): Attribute =
  fnew(result, gBoxedFreePangoAttribute)
  result.impl = pango_attr_weight_new(weight)

proc pango_break(text: cstring; length: int32; analysis: ptr Analysis00;
    attrs: ptr LogAttr00; attrsLen: int32) {.
    importc, libprag.}

proc `break`*(text: cstring; length: int; analysis: Analysis; attrs: ptr LogAttr00;
    attrsLen: int) =
  pango_break(text, int32(length), cast[ptr Analysis00](analysis.impl), attrs, int32(attrsLen))

proc pango_default_break(text: cstring; length: int32; analysis: ptr Analysis00;
    attrs: ptr LogAttr00; attrsLen: int32) {.
    importc, libprag.}

proc defaultBreak*(text: cstring; length: int; analysis: Analysis = nil;
    attrs: LogAttr; attrsLen: int) =
  pango_default_break(text, int32(length), if analysis.isNil: nil else: cast[ptr Analysis00](analysis.impl), cast[ptr LogAttr00](attrs.impl), int32(attrsLen))

proc extentsToPixels*(inclusive: Rectangle = cast[var Rectangle](nil);
    nearest: Rectangle = cast[var Rectangle](nil)) {.
    importc: "pango_extents_to_pixels", libprag.}

proc pango_find_base_dir(text: cstring; length: int32): Direction {.
    importc, libprag.}

proc findBaseDir*(text: cstring; length: int): Direction =
  pango_find_base_dir(text, int32(length))

proc pango_find_paragraph_boundary(text: cstring; length: int32; paragraphDelimiterIndex: var int32;
    nextParagraphStart: var int32) {.
    importc, libprag.}

proc findParagraphBoundary*(text: cstring; length: int; paragraphDelimiterIndex: var int;
    nextParagraphStart: var int) =
  var paragraphDelimiterIndex_00: int32
  var nextParagraphStart_00: int32
  pango_find_paragraph_boundary(text, int32(length), paragraphDelimiterIndex_00, nextParagraphStart_00)
  if paragraphDelimiterIndex.addr != nil:
    paragraphDelimiterIndex = int(paragraphDelimiterIndex_00)
  if nextParagraphStart.addr != nil:
    nextParagraphStart = int(nextParagraphStart_00)

proc pango_get_log_attrs(text: cstring; length: int32; level: int32; language: ptr Language00;
    logAttrs: ptr LogAttr00; attrsLen: int32) {.
    importc, libprag.}

proc getLogAttrs*(text: cstring; length: int; level: int; language: Language;
    logAttrs: ptr LogAttr00; attrsLen: int) =
  pango_get_log_attrs(text, int32(length), int32(level), cast[ptr Language00](language.impl), logAttrs, int32(attrsLen))

proc pango_get_mirror_char(ch: gunichar; mirroredCh: ptr gunichar): gboolean {.
    importc, libprag.}

proc getMirrorChar*(ch: gunichar; mirroredCh: ptr gunichar): bool =
  toBool(pango_get_mirror_char(ch, mirroredCh))

proc pango_is_zero_width(ch: gunichar): gboolean {.
    importc, libprag.}

proc isZeroWidth*(ch: gunichar): bool =
  toBool(pango_is_zero_width(ch))

proc pango_itemize(context: ptr Context00; text: cstring; startIndex: int32;
    length: int32; attrs: ptr AttrList00; cachedIter: AttrIterator): ptr glib.List {.
    importc, libprag.}

proc itemize*(context: Context; text: cstring; startIndex: int; length: int;
    attrs: AttrList; cachedIter: AttrIterator = cast[var AttrIterator](nil)): seq[Item] =
  let resul0 = pango_itemize(cast[ptr Context00](context.impl), text, int32(startIndex), int32(length), cast[ptr AttrList00](attrs.impl), cachedIter)
  result = glistStructs2seq[Item](resul0, false)
  g_list_free(resul0)

proc pango_itemize_with_base_dir(context: ptr Context00; baseDir: Direction;
    text: cstring; startIndex: int32; length: int32; attrs: ptr AttrList00;
    cachedIter: AttrIterator): ptr glib.List {.
    importc, libprag.}

proc itemizeWithBaseDir*(context: Context; baseDir: Direction; text: cstring;
    startIndex: int; length: int; attrs: AttrList; cachedIter: AttrIterator = cast[var AttrIterator](nil)): seq[Item] =
  let resul0 = pango_itemize_with_base_dir(cast[ptr Context00](context.impl), baseDir, text, int32(startIndex), int32(length), cast[ptr AttrList00](attrs.impl), cachedIter)
  result = glistStructs2seq[Item](resul0, false)
  g_list_free(resul0)

proc pango_log2vis_get_embedding_levels(text: cstring; length: int32; pbaseDir: ptr Direction): ptr uint8 {.
    importc, libprag.}

proc log2visGetEmbeddingLevels*(text: cstring; length: int; pbaseDir: ptr Direction): ptr uint8 =
  pango_log2vis_get_embedding_levels(text, int32(length), pbaseDir)

proc pango_markup_parser_finish(context: ptr glib.MarkupParseContext00; attrList: var ptr AttrList00;
    text: var cstring; accelChar: var gunichar; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc markupParserFinish*(context: glib.MarkupParseContext; attrList: var AttrList = cast[var AttrList](nil);
    text: var string = cast[var string](nil); accelChar: var gunichar = cast[var gunichar](nil)): bool =
  if addr(attrList) != nil:
    fnew(attrList, gBoxedFreePangoAttrList)
  var gerror: ptr glib.Error
  var text_00: cstring
  let resul0 = pango_markup_parser_finish(cast[ptr glib.MarkupParseContext00](context.impl), cast[var ptr AttrList00](if addr(attrList) == nil: nil else: addr attrList.impl), text_00, accelChar, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if text.addr != nil:
    text = $(text_00)

proc pango_markup_parser_new(accelMarker: gunichar): ptr glib.MarkupParseContext00 {.
    importc, libprag.}

proc newMarkupParser*(accelMarker: gunichar): glib.MarkupParseContext =
  fnew(result, gBoxedFreeGMarkupParseContext)
  result.impl = pango_markup_parser_new(accelMarker)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_markup_parse_context_get_type(), result.impl))

proc pango_parse_enum(`type`: GType; str: cstring; value: var int32; warn: gboolean;
    possibleValues: var cstring): gboolean {.
    importc, libprag.}

proc parseEnum*(`type`: GType; str: cstring = nil; value: var int = cast[var int](nil);
    warn: bool; possibleValues: var string = cast[var string](nil)): bool =
  var possibleValues_00: cstring
  var value_00: int32
  result = toBool(pango_parse_enum(`type`, str, value_00, gboolean(warn), possibleValues_00))
  if possibleValues.addr != nil:
    possibleValues = $(possibleValues_00)
  if value.addr != nil:
    value = int(value_00)

proc pango_parse_markup(markupText: cstring; length: int32; accelMarker: gunichar;
    attrList: var ptr AttrList00; text: var cstring; accelChar: var gunichar;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc parseMarkup*(markupText: cstring; length: int; accelMarker: gunichar;
    attrList: var AttrList = cast[var AttrList](nil); text: var string = cast[var string](nil);
    accelChar: var gunichar = cast[var gunichar](nil)): bool =
  if addr(attrList) != nil:
    fnew(attrList, gBoxedFreePangoAttrList)
  var gerror: ptr glib.Error
  var text_00: cstring
  let resul0 = pango_parse_markup(markupText, int32(length), accelMarker, cast[var ptr AttrList00](if addr(attrList) == nil: nil else: addr attrList.impl), text_00, accelChar, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if text.addr != nil:
    text = $(text_00)

proc pango_parse_stretch(str: cstring; stretch: var Stretch; warn: gboolean): gboolean {.
    importc, libprag.}

proc parseStretch*(str: cstring; stretch: var Stretch; warn: bool): bool =
  toBool(pango_parse_stretch(str, stretch, gboolean(warn)))

proc pango_parse_style(str: cstring; style: var Style; warn: gboolean): gboolean {.
    importc, libprag.}

proc parseStyle*(str: cstring; style: var Style; warn: bool): bool =
  toBool(pango_parse_style(str, style, gboolean(warn)))

proc pango_parse_variant(str: cstring; variant: var Variant; warn: gboolean): gboolean {.
    importc, libprag.}

proc parseVariant*(str: cstring; variant: var Variant; warn: bool): bool =
  toBool(pango_parse_variant(str, variant, gboolean(warn)))

proc pango_parse_weight(str: cstring; weight: var Weight; warn: gboolean): gboolean {.
    importc, libprag.}

proc parseWeight*(str: cstring; weight: var Weight; warn: bool): bool =
  toBool(pango_parse_weight(str, weight, gboolean(warn)))

proc pango_quantize_line_geometry(thickness: var int32; position: var int32) {.
    importc, libprag.}

proc quantizeLineGeometry*(thickness: var int; position: var int) =
  var position_00 = int32(position)
  var thickness_00 = int32(thickness)
  pango_quantize_line_geometry(thickness_00, position_00)
  position = int(position_00)
  thickness = int(thickness_00)

proc pango_read_line(stream: pointer; str: glib.String): int32 {.
    importc, libprag.}

proc readLine*(stream: pointer; str: glib.String): int =
  int(pango_read_line(stream, str))

proc pango_reorder_items(logicalItems: ptr glib.List): ptr glib.List {.
    importc, libprag.}

proc reorderItems*(logicalItems: seq[Item]): seq[Item] =
  var tempResGL = seq2GList(logicalItems)
  let resul0 = pango_reorder_items(tempResGL)
  g_list_free(tempResGL)
  result = glistStructs2seq[Item](resul0, false)
  g_list_free(resul0)

proc pango_scan_int(pos: var cstring; `out`: var int32): gboolean {.
    importc, libprag.}

proc scanInt*(pos: var string; `out`: var int): bool =
  var out_00: int32
  var pos_00 = cstring(pos)
  result = toBool(pango_scan_int(pos_00, out_00))
  if `out`.addr != nil:
    `out` = int(out_00)
  pos = $(pos_00)

proc pango_scan_string(pos: var cstring; `out`: glib.String): gboolean {.
    importc, libprag.}

proc scanString*(pos: var string; `out`: glib.String): bool =
  var pos_00 = cstring(pos)
  result = toBool(pango_scan_string(pos_00, `out`))
  pos = $(pos_00)

proc pango_scan_word(pos: var cstring; `out`: glib.String): gboolean {.
    importc, libprag.}

proc scanWord*(pos: var string; `out`: glib.String): bool =
  var pos_00 = cstring(pos)
  result = toBool(pango_scan_word(pos_00, `out`))
  pos = $(pos_00)

proc pango_shape(text: cstring; length: int32; analysis: ptr Analysis00;
    glyphs: ptr GlyphString00) {.
    importc, libprag.}

proc shape*(text: cstring; length: int; analysis: Analysis; glyphs: GlyphString) =
  pango_shape(text, int32(length), cast[ptr Analysis00](analysis.impl), cast[ptr GlyphString00](glyphs.impl))

proc pango_shape_full(itemText: cstring; itemLength: int32; paragraphText: cstring;
    paragraphLength: int32; analysis: ptr Analysis00; glyphs: ptr GlyphString00) {.
    importc, libprag.}

proc shapeFull*(itemText: cstring; itemLength: int; paragraphText: cstring = nil;
    paragraphLength: int; analysis: Analysis; glyphs: GlyphString) =
  pango_shape_full(itemText, int32(itemLength), paragraphText, int32(paragraphLength), cast[ptr Analysis00](analysis.impl), cast[ptr GlyphString00](glyphs.impl))

proc pango_shape_with_flags(itemText: cstring; itemLength: int32; paragraphText: cstring;
    paragraphLength: int32; analysis: ptr Analysis00; glyphs: ptr GlyphString00;
    flags: ShapeFlags) {.
    importc, libprag.}

proc shapeWithFlags*(itemText: cstring; itemLength: int; paragraphText: cstring = nil;
    paragraphLength: int; analysis: Analysis; glyphs: GlyphString; flags: ShapeFlags) =
  pango_shape_with_flags(itemText, int32(itemLength), paragraphText, int32(paragraphLength), cast[ptr Analysis00](analysis.impl), cast[ptr GlyphString00](glyphs.impl), flags)

proc pango_skip_space(pos: var cstring): gboolean {.
    importc, libprag.}

proc skipSpace*(pos: var string): bool =
  var pos_00 = cstring(pos)
  result = toBool(pango_skip_space(pos_00))
  pos = $(pos_00)

proc pango_split_file_list(str: cstring): ptr cstring {.
    importc, libprag.}

proc splitFileList*(str: cstring): seq[string] =
  let resul0 = pango_split_file_list(str)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc pango_tailor_break(text: cstring; length: int32; analysis: ptr Analysis00;
    offset: int32; logAttrs: ptr LogAttr00; logAttrsLen: int32) {.
    importc, libprag.}

proc tailorBreak*(text: cstring; length: int; analysis: Analysis; offset: int;
    logAttrs: ptr LogAttr00; logAttrsLen: int) =
  pango_tailor_break(text, int32(length), cast[ptr Analysis00](analysis.impl), int32(offset), logAttrs, int32(logAttrsLen))

proc pango_trim_string(str: cstring): cstring {.
    importc, libprag.}

proc trimString*(str: cstring): string =
  let resul0 = pango_trim_string(str)
  result = $resul0
  cogfree(resul0)

proc unicharDirection*(ch: gunichar): Direction {.
    importc: "pango_unichar_direction", libprag.}

proc pango_units_from_double(d: cdouble): int32 {.
    importc, libprag.}

proc unitsFromDouble*(d: cdouble): int =
  int(pango_units_from_double(d))

proc pango_units_to_double(i: int32): cdouble {.
    importc, libprag.}

proc unitsToDouble*(i: int): cdouble =
  pango_units_to_double(int32(i))

proc pango_version(): int32 {.
    importc, libprag.}

proc version*(): int =
  int(pango_version())

proc pango_version_check(requiredMajor: int32; requiredMinor: int32; requiredMicro: int32): cstring {.
    importc, libprag.}

proc versionCheck*(requiredMajor: int; requiredMinor: int; requiredMicro: int): string =
  let resul0 = pango_version_check(int32(requiredMajor), int32(requiredMinor), int32(requiredMicro))
  if resul0.isNil:
    return
  result = $resul0

proc pango_version_string(): cstring {.
    importc, libprag.}

proc versionString*(): string =
  result = $pango_version_string()
# === remaining symbols:

when not declared(ATTR_INDEX_TO_TEXT_END):
  const ATTR_INDEX_TO_TEXT_END* = uint32.high

when not declared(ATTR_INDEX_FROM_TEXT_BEGINNING):
  const ATTR_INDEX_FROM_TEXT_BEGINNING* = uint32.low

proc setStartIndex*(a: Attribute; i: uint32) =
  a.impl.startIndex = i

proc setEndIndex*(a: Attribute; i: uint32) =
  a.impl.endIndex = i

proc setIndices*(a: Attribute; s, e: uint32) =
  a.impl.startIndex = s
  a.impl.endIndex = e

proc `startIndex=`*(a: Attribute; i: uint32) =
  a.impl.startIndex = i

proc `endIndex=`*(a: Attribute; i: uint32) =
  a.impl.endIndex = i

#proc `indices=`*(a: Attribute; s, e: uint32) =
proc `indices=`*(a: Attribute; se: tuple[start: uint32; `end`: uint32]) =
  a.impl.startIndex = se[0]
  a.impl.endIndex = se[1]

