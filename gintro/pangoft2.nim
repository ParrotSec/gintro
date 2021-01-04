# dependencies:
# freetype2-2.0
# GLib-2.0
# HarfBuzz-0.0
# cairo-1.0
# PangoFc-1.0
# GObject-2.0
# fontconfig-2.0
# Pango-1.0
# immediate dependencies:
# freetype2-2.0
# PangoFc-1.0
# libraries:
# libpangoft2-1.0.so.0
{.warning[UnusedImport]: off.}
import freetype2, glib, harfbuzz, cairo, pangofc, gobject, fontconfig, pango
const Lib = "libpangoft2-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  FontMap* = ref object of pangofc.FontMap
  FontMap00* = object of pangofc.FontMap00

proc pango_ft2_font_map_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FontMap()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc pango_ft2_font_map_new(): ptr FontMap00 {.
    importc, libprag.}

proc newFontMap*(): FontMap =
  let gobj = pango_ft2_font_map_new()
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

proc newFontMap*(tdesc: typedesc): tdesc =
  assert(result is FontMap)
  let gobj = pango_ft2_font_map_new()
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

proc initFontMap*[T](result: var T) {.deprecated.} =
  assert(result is FontMap)
  let gobj = pango_ft2_font_map_new()
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

proc pango_ft2_font_map_set_resolution(self: ptr FontMap00; dpiX: cdouble;
    dpiY: cdouble) {.
    importc, libprag.}

proc setResolution*(self: FontMap; dpiX: cdouble; dpiY: cdouble) =
  pango_ft2_font_map_set_resolution(cast[ptr FontMap00](self.impl), dpiX, dpiY)

proc pango_ft2_font_map_substitute_changed(self: ptr FontMap00) {.
    importc, libprag.}

proc substituteChanged*(self: FontMap) =
  pango_ft2_font_map_substitute_changed(cast[ptr FontMap00](self.impl))

type
  SubstituteFunc* = proc (pattern: ptr fontconfig.Pattern00; data: pointer) {.cdecl.}

proc pango_ft2_font_map_set_default_substitute(self: ptr FontMap00; `func`: SubstituteFunc;
    data: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setDefaultSubstitute*(self: FontMap; `func`: SubstituteFunc;
    data: pointer; notify: DestroyNotify) =
  pango_ft2_font_map_set_default_substitute(cast[ptr FontMap00](self.impl), `func`, data, notify)

proc pango_ft2_font_get_coverage(font: ptr pango.Font00; language: ptr pango.Language00): ptr pango.Coverage00 {.
    importc, libprag.}

proc fontGetCoverage*(font: pango.Font; language: pango.Language): pango.Coverage =
  let gobj = pango_ft2_font_get_coverage(cast[ptr pango.Font00](font.impl), cast[ptr pango.Language00](language.impl))
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

proc pango_ft2_font_get_kerning(font: ptr pango.Font00; left: uint32; right: uint32): int32 {.
    importc, libprag.}

proc fontGetKerning*(font: pango.Font; left: int; right: int): int =
  int(pango_ft2_font_get_kerning(cast[ptr pango.Font00](font.impl), uint32(left), uint32(right)))

proc pango_ft2_get_unknown_glyph(font: ptr pango.Font00): uint32 {.
    importc, libprag.}

proc getUnknownGlyph*(font: pango.Font): int =
  int(pango_ft2_get_unknown_glyph(cast[ptr pango.Font00](font.impl)))

proc unknownGlyph*(font: pango.Font): int =
  int(pango_ft2_get_unknown_glyph(cast[ptr pango.Font00](font.impl)))

proc pango_ft2_render(bitmap: ptr freetype2.Bitmap00; font: ptr pango.Font00;
    glyphs: ptr pango.GlyphString00; x: int32; y: int32) {.
    importc, libprag.}

proc render*(bitmap: freetype2.Bitmap; font: pango.Font; glyphs: pango.GlyphString;
    x: int; y: int) =
  pango_ft2_render(cast[ptr freetype2.Bitmap00](bitmap.impl), cast[ptr pango.Font00](font.impl), cast[ptr pango.GlyphString00](glyphs.impl), int32(x), int32(y))

proc pango_ft2_render_layout(bitmap: ptr freetype2.Bitmap00; layout: ptr pango.Layout00;
    x: int32; y: int32) {.
    importc, libprag.}

proc renderLayout*(bitmap: freetype2.Bitmap; layout: pango.Layout;
    x: int; y: int) =
  pango_ft2_render_layout(cast[ptr freetype2.Bitmap00](bitmap.impl), cast[ptr pango.Layout00](layout.impl), int32(x), int32(y))

proc pango_ft2_render_layout_line(bitmap: ptr freetype2.Bitmap00; line: ptr pango.LayoutLine00;
    x: int32; y: int32) {.
    importc, libprag.}

proc renderLayoutLine*(bitmap: freetype2.Bitmap; line: pango.LayoutLine;
    x: int; y: int) =
  pango_ft2_render_layout_line(cast[ptr freetype2.Bitmap00](bitmap.impl), cast[ptr pango.LayoutLine00](line.impl), int32(x), int32(y))

proc pango_ft2_render_layout_line_subpixel(bitmap: ptr freetype2.Bitmap00;
    line: ptr pango.LayoutLine00; x: int32; y: int32) {.
    importc, libprag.}

proc renderLayoutLineSubpixel*(bitmap: freetype2.Bitmap; line: pango.LayoutLine;
    x: int; y: int) =
  pango_ft2_render_layout_line_subpixel(cast[ptr freetype2.Bitmap00](bitmap.impl), cast[ptr pango.LayoutLine00](line.impl), int32(x), int32(y))

proc pango_ft2_render_layout_subpixel(bitmap: ptr freetype2.Bitmap00; layout: ptr pango.Layout00;
    x: int32; y: int32) {.
    importc, libprag.}

proc renderLayoutSubpixel*(bitmap: freetype2.Bitmap; layout: pango.Layout;
    x: int; y: int) =
  pango_ft2_render_layout_subpixel(cast[ptr freetype2.Bitmap00](bitmap.impl), cast[ptr pango.Layout00](layout.impl), int32(x), int32(y))

proc pango_ft2_render_transformed(bitmap: ptr freetype2.Bitmap00; matrix: ptr pango.Matrix00;
    font: ptr pango.Font00; glyphs: ptr pango.GlyphString00; x: int32; y: int32) {.
    importc, libprag.}

proc renderTransformed*(bitmap: freetype2.Bitmap; matrix: pango.Matrix = nil;
    font: pango.Font; glyphs: pango.GlyphString; x: int; y: int) =
  pango_ft2_render_transformed(cast[ptr freetype2.Bitmap00](bitmap.impl), if matrix.isNil: nil else: cast[ptr pango.Matrix00](matrix.impl), cast[ptr pango.Font00](font.impl), cast[ptr pango.GlyphString00](glyphs.impl), int32(x), int32(y))

proc shutdownDisplay*() {.
    importc: "pango_ft2_shutdown_display", libprag.}
# === remaining symbols:
