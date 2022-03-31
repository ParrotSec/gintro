# dependencies:
# GObject-2.0
# Pango-1.0
# cairo-1.0
# GLib-2.0
# HarfBuzz-0.0
# immediate dependencies:
# cairo-1.0
# Pango-1.0
# GObject-2.0
# libraries:
# libpangocairo-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, pango, cairo, glib, harfbuzz
const Lib = "libpangocairo-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Font00* = object of gobject.Object00
  Font* = ref object of gobject.Object

proc pango_cairo_font_get_scaled_font(self: ptr Font00): ptr cairo.ScaledFont00 {.
    importc, libprag.}

proc getScaledFont*(self: Font): cairo.ScaledFont =
  let impl0 = pango_cairo_font_get_scaled_font(cast[ptr Font00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoScaledFont)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_scaled_font_get_type(), impl0))

proc scaledFont*(self: Font): cairo.ScaledFont =
  let impl0 = pango_cairo_font_get_scaled_font(cast[ptr Font00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoScaledFont)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_scaled_font_get_type(), impl0))

type
  FontMap00* = object of gobject.Object00
  FontMap* = ref object of gobject.Object

proc pango_cairo_font_map_get_default(): ptr pango.FontMap00 {.
    importc, libprag.}

proc getDefaultFontMap*(): pango.FontMap =
  let gobj = pango_cairo_font_map_get_default()
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

proc pango_cairo_font_map_new(): ptr pango.FontMap00 {.
    importc, libprag.}

proc newFontMap*(): pango.FontMap =
  let gobj = pango_cairo_font_map_new()
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

proc pango_cairo_font_map_new_for_font_type(fonttype: cairo.FontType): ptr pango.FontMap00 {.
    importc, libprag.}

proc newFontMapForFontType*(fonttype: cairo.FontType): pango.FontMap =
  let gobj = pango_cairo_font_map_new_for_font_type(fonttype)
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

proc pango_cairo_font_map_get_font_type(self: ptr FontMap00): cairo.FontType {.
    importc, libprag.}

proc getFontType*(self: FontMap): cairo.FontType =
  pango_cairo_font_map_get_font_type(cast[ptr FontMap00](self.impl))

proc fontType*(self: FontMap): cairo.FontType =
  pango_cairo_font_map_get_font_type(cast[ptr FontMap00](self.impl))

proc pango_cairo_font_map_get_resolution(self: ptr FontMap00): cdouble {.
    importc, libprag.}

proc getResolution*(self: FontMap): cdouble =
  pango_cairo_font_map_get_resolution(cast[ptr FontMap00](self.impl))

proc resolution*(self: FontMap): cdouble =
  pango_cairo_font_map_get_resolution(cast[ptr FontMap00](self.impl))

proc pango_cairo_font_map_set_default(self: ptr FontMap00) {.
    importc, libprag.}

proc setDefault*(self: FontMap) =
  pango_cairo_font_map_set_default(cast[ptr FontMap00](self.impl))

proc pango_cairo_font_map_set_resolution(self: ptr FontMap00; dpi: cdouble) {.
    importc, libprag.}

proc setResolution*(self: FontMap; dpi: cdouble) =
  pango_cairo_font_map_set_resolution(cast[ptr FontMap00](self.impl), dpi)

proc `resolution=`*(self: FontMap; dpi: cdouble) =
  pango_cairo_font_map_set_resolution(cast[ptr FontMap00](self.impl), dpi)

type
  ShapeRendererFunc* = proc (cr: ptr cairo.Context00; attr: ptr pango.AttrShape00; doPath: gboolean;
    data: pointer) {.cdecl.}

proc pango_cairo_context_get_font_options(context: ptr pango.Context00): ptr cairo.FontOptions00 {.
    importc, libprag.}

proc contextGetFontOptions*(context: pango.Context): cairo.FontOptions =
  let impl0 = pango_cairo_context_get_font_options(cast[ptr pango.Context00](context.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoFontOptions)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_font_options_get_type(), impl0))

proc pango_cairo_context_get_resolution(context: ptr pango.Context00): cdouble {.
    importc, libprag.}

proc contextGetResolution*(context: pango.Context): cdouble =
  pango_cairo_context_get_resolution(cast[ptr pango.Context00](context.impl))

proc pango_cairo_context_set_font_options(context: ptr pango.Context00; options: ptr cairo.FontOptions00) {.
    importc, libprag.}

proc contextSetFontOptions*(context: pango.Context; options: cairo.FontOptions = nil) =
  pango_cairo_context_set_font_options(cast[ptr pango.Context00](context.impl), if options.isNil: nil else: cast[ptr cairo.FontOptions00](options.impl))

proc pango_cairo_context_set_resolution(context: ptr pango.Context00; dpi: cdouble) {.
    importc, libprag.}

proc contextSetResolution*(context: pango.Context; dpi: cdouble) =
  pango_cairo_context_set_resolution(cast[ptr pango.Context00](context.impl), dpi)

proc pango_cairo_context_set_shape_renderer(context: ptr pango.Context00;
    `func`: ShapeRendererFunc; data: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc contextSetShapeRenderer*(context: pango.Context; `func`: ShapeRendererFunc;
    data: pointer; dnotify: DestroyNotify) =
  pango_cairo_context_set_shape_renderer(cast[ptr pango.Context00](context.impl), `func`, data, dnotify)

proc pango_cairo_create_context(cr: ptr cairo.Context00): ptr pango.Context00 {.
    importc, libprag.}

proc createContext*(cr: cairo.Context): pango.Context =
  let gobj = pango_cairo_create_context(cast[ptr cairo.Context00](cr.impl))
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

proc pango_cairo_create_layout(cr: ptr cairo.Context00): ptr pango.Layout00 {.
    importc, libprag.}

proc createLayout*(cr: cairo.Context): pango.Layout =
  let gobj = pango_cairo_create_layout(cast[ptr cairo.Context00](cr.impl))
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

proc pango_cairo_error_underline_path(cr: ptr cairo.Context00; x: cdouble;
    y: cdouble; width: cdouble; height: cdouble) {.
    importc, libprag.}

proc errorUnderlinePath*(cr: cairo.Context; x: cdouble; y: cdouble;
    width: cdouble; height: cdouble) =
  pango_cairo_error_underline_path(cast[ptr cairo.Context00](cr.impl), x, y, width, height)

proc pango_cairo_glyph_string_path(cr: ptr cairo.Context00; font: ptr pango.Font00;
    glyphs: ptr pango.GlyphString00) {.
    importc, libprag.}

proc glyphStringPath*(cr: cairo.Context; font: pango.Font; glyphs: pango.GlyphString) =
  pango_cairo_glyph_string_path(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.Font00](font.impl), cast[ptr pango.GlyphString00](glyphs.impl))

proc pango_cairo_layout_line_path(cr: ptr cairo.Context00; line: ptr pango.LayoutLine00) {.
    importc, libprag.}

proc layoutLinePath*(cr: cairo.Context; line: pango.LayoutLine) =
  pango_cairo_layout_line_path(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.LayoutLine00](line.impl))

proc pango_cairo_layout_path(cr: ptr cairo.Context00; layout: ptr pango.Layout00) {.
    importc, libprag.}

proc layoutPath*(cr: cairo.Context; layout: pango.Layout) =
  pango_cairo_layout_path(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.Layout00](layout.impl))

proc pango_cairo_show_error_underline(cr: ptr cairo.Context00; x: cdouble;
    y: cdouble; width: cdouble; height: cdouble) {.
    importc, libprag.}

proc showErrorUnderline*(cr: cairo.Context; x: cdouble; y: cdouble;
    width: cdouble; height: cdouble) =
  pango_cairo_show_error_underline(cast[ptr cairo.Context00](cr.impl), x, y, width, height)

proc pango_cairo_show_glyph_item(cr: ptr cairo.Context00; text: cstring;
    glyphItem: ptr pango.GlyphItem00) {.
    importc, libprag.}

proc showGlyphItem*(cr: cairo.Context; text: cstring; glyphItem: pango.GlyphItem) =
  pango_cairo_show_glyph_item(cast[ptr cairo.Context00](cr.impl), text, cast[ptr pango.GlyphItem00](glyphItem.impl))

proc pango_cairo_show_glyph_string(cr: ptr cairo.Context00; font: ptr pango.Font00;
    glyphs: ptr pango.GlyphString00) {.
    importc, libprag.}

proc showGlyphString*(cr: cairo.Context; font: pango.Font; glyphs: pango.GlyphString) =
  pango_cairo_show_glyph_string(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.Font00](font.impl), cast[ptr pango.GlyphString00](glyphs.impl))

proc pango_cairo_show_layout(cr: ptr cairo.Context00; layout: ptr pango.Layout00) {.
    importc, libprag.}

proc showLayout*(cr: cairo.Context; layout: pango.Layout) =
  pango_cairo_show_layout(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.Layout00](layout.impl))

proc pango_cairo_show_layout_line(cr: ptr cairo.Context00; line: ptr pango.LayoutLine00) {.
    importc, libprag.}

proc showLayoutLine*(cr: cairo.Context; line: pango.LayoutLine) =
  pango_cairo_show_layout_line(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.LayoutLine00](line.impl))

proc pango_cairo_update_context(cr: ptr cairo.Context00; context: ptr pango.Context00) {.
    importc, libprag.}

proc updateContext*(cr: cairo.Context; context: pango.Context) =
  pango_cairo_update_context(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.Context00](context.impl))

proc pango_cairo_update_layout(cr: ptr cairo.Context00; layout: ptr pango.Layout00) {.
    importc, libprag.}

proc updateLayout*(cr: cairo.Context; layout: pango.Layout) =
  pango_cairo_update_layout(cast[ptr cairo.Context00](cr.impl), cast[ptr pango.Layout00](layout.impl))
# === remaining symbols:
