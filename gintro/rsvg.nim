# dependencies:
# GObject-2.0
# GdkPixbuf-2.0
# cairo-1.0
# Gio-2.0
# GModule-2.0
# GLib-2.0
# immediate dependencies:
# cairo-1.0
# Gio-2.0
# GdkPixbuf-2.0
# GObject-2.0
# GLib-2.0
# libraries:
# librsvg-2.so.2
{.warning[UnusedImport]: off.}
import gobject, gdkpixbuf, cairo, gio, gmodule, glib
const Lib = "librsvg-2.so.2"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  DimensionData* {.pure, byRef.} = object
    width*: int32
    height*: int32
    em*: cdouble
    ex*: cdouble

type
  Error* {.size: sizeof(cint), pure.} = enum
    failed = 0

type
  Handle* = ref object of gobject.Object
  Handle00* = object of gobject.Object00

proc rsvg_handle_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Handle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc rsvg_handle_new(): ptr Handle00 {.
    importc, libprag.}

proc newHandle*(): Handle =
  let gobj = rsvg_handle_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHandle*(tdesc: typedesc): tdesc =
  assert(result is Handle)
  let gobj = rsvg_handle_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandle*[T](result: var T) {.deprecated.} =
  assert(result is Handle)
  let gobj = rsvg_handle_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_from_data(data: ptr uint8; dataLen: uint64; error: ptr ptr glib.Error = nil): ptr Handle00 {.
    importc, libprag.}

proc newHandleFromData*(data: seq[uint8] | string): Handle =
  let dataLen = uint64(data.len)
  var gerror: ptr glib.Error
  let gobj = rsvg_handle_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), dataLen, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHandleFromData*(tdesc: typedesc; data: seq[uint8] | string): tdesc =
  let dataLen = uint64(data.len)
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), dataLen, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromData*[T](result: var T; data: seq[uint8] | string) {.deprecated.} =
  let dataLen = uint64(data.len)
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), dataLen, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_from_file(filename: cstring; error: ptr ptr glib.Error = nil): ptr Handle00 {.
    importc, libprag.}

proc newHandleFromFile*(filename: cstring): Handle =
  var gerror: ptr glib.Error
  let gobj = rsvg_handle_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHandleFromFile*(tdesc: typedesc; filename: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromFile*[T](result: var T; filename: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_close(self: ptr Handle00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc close*(self: Handle): bool =
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_close(cast[ptr Handle00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc rsvg_handle_get_base_uri(self: ptr Handle00): cstring {.
    importc, libprag.}

proc getBaseUri*(self: Handle): string =
  result = $rsvg_handle_get_base_uri(cast[ptr Handle00](self.impl))

proc baseUri*(self: Handle): string =
  result = $rsvg_handle_get_base_uri(cast[ptr Handle00](self.impl))

proc rsvg_handle_get_dimensions(self: ptr Handle00; dimensionData: var DimensionData) {.
    importc, libprag.}

proc getDimensions*(self: Handle; dimensionData: var DimensionData) =
  rsvg_handle_get_dimensions(cast[ptr Handle00](self.impl), dimensionData)

proc getDimensions*(self: Handle): DimensionData =
  rsvg_handle_get_dimensions(cast[ptr Handle00](self.impl), result)

proc rsvg_handle_get_dimensions_sub(self: ptr Handle00; dimensionData: var DimensionData;
    id: cstring): gboolean {.
    importc, libprag.}

proc getDimensionsSub*(self: Handle; dimensionData: var DimensionData;
    id: cstring = nil): bool =
  toBool(rsvg_handle_get_dimensions_sub(cast[ptr Handle00](self.impl), dimensionData, id))

proc rsvg_handle_get_pixbuf(self: ptr Handle00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getPixbuf*(self: Handle): gdkpixbuf.Pixbuf =
  let gobj = rsvg_handle_get_pixbuf(cast[ptr Handle00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: Handle): gdkpixbuf.Pixbuf =
  let gobj = rsvg_handle_get_pixbuf(cast[ptr Handle00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_get_pixbuf_sub(self: ptr Handle00; id: cstring): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getPixbufSub*(self: Handle; id: cstring = nil): gdkpixbuf.Pixbuf =
  let gobj = rsvg_handle_get_pixbuf_sub(cast[ptr Handle00](self.impl), id)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_has_sub(self: ptr Handle00; id: cstring): gboolean {.
    importc, libprag.}

proc hasSub*(self: Handle; id: cstring): bool =
  toBool(rsvg_handle_has_sub(cast[ptr Handle00](self.impl), id))

proc rsvg_handle_internal_set_testing(self: ptr Handle00; testing: gboolean) {.
    importc, libprag.}

proc internalSetTesting*(self: Handle; testing: bool = true) =
  rsvg_handle_internal_set_testing(cast[ptr Handle00](self.impl), gboolean(testing))

proc rsvg_handle_read_stream_sync(self: ptr Handle00; stream: ptr gio.InputStream00;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc readStreamSync*(self: Handle; stream: gio.InputStream;
    cancellable: gio.Cancellable = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_read_stream_sync(cast[ptr Handle00](self.impl), cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc rsvg_handle_render_cairo(self: ptr Handle00; cr: ptr cairo.Context00): gboolean {.
    importc, libprag.}

proc renderCairo*(self: Handle; cr: cairo.Context): bool =
  toBool(rsvg_handle_render_cairo(cast[ptr Handle00](self.impl), cast[ptr cairo.Context00](cr.impl)))

proc rsvg_handle_render_cairo_sub(self: ptr Handle00; cr: ptr cairo.Context00;
    id: cstring): gboolean {.
    importc, libprag.}

proc renderCairoSub*(self: Handle; cr: cairo.Context; id: cstring = nil): bool =
  toBool(rsvg_handle_render_cairo_sub(cast[ptr Handle00](self.impl), cast[ptr cairo.Context00](cr.impl), id))

proc rsvg_handle_set_base_gfile(self: ptr Handle00; baseFile: ptr gio.GFile00) {.
    importc, libprag.}

proc setBaseGfile*(self: Handle; baseFile: gio.GFile) =
  rsvg_handle_set_base_gfile(cast[ptr Handle00](self.impl), cast[ptr gio.GFile00](baseFile.impl))

proc `baseGfile=`*(self: Handle; baseFile: gio.GFile) =
  rsvg_handle_set_base_gfile(cast[ptr Handle00](self.impl), cast[ptr gio.GFile00](baseFile.impl))

proc rsvg_handle_set_base_uri(self: ptr Handle00; baseUri: cstring) {.
    importc, libprag.}

proc setBaseUri*(self: Handle; baseUri: cstring) =
  rsvg_handle_set_base_uri(cast[ptr Handle00](self.impl), baseUri)

proc `baseUri=`*(self: Handle; baseUri: cstring) =
  rsvg_handle_set_base_uri(cast[ptr Handle00](self.impl), baseUri)

proc rsvg_handle_set_dpi(self: ptr Handle00; dpi: cdouble) {.
    importc, libprag.}

proc setDpi*(self: Handle; dpi: cdouble) =
  rsvg_handle_set_dpi(cast[ptr Handle00](self.impl), dpi)

proc `dpi=`*(self: Handle; dpi: cdouble) =
  rsvg_handle_set_dpi(cast[ptr Handle00](self.impl), dpi)

proc rsvg_handle_set_dpi_x_y(self: ptr Handle00; dpiX: cdouble; dpiY: cdouble) {.
    importc, libprag.}

proc setDpiXY*(self: Handle; dpiX: cdouble; dpiY: cdouble) =
  rsvg_handle_set_dpi_x_y(cast[ptr Handle00](self.impl), dpiX, dpiY)

proc rsvg_handle_set_stylesheet(self: ptr Handle00; css: ptr uint8; cssLen: uint64;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setStylesheet*(self: Handle; css: seq[uint8] | string): bool =
  let cssLen = uint64(css.len)
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_set_stylesheet(cast[ptr Handle00](self.impl), cast[ptr uint8](unsafeaddr(css[0])), cssLen, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc rsvg_handle_write(self: ptr Handle00; buf: ptr uint8; count: uint64;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc write*(self: Handle; buf: seq[uint8] | string): bool =
  let count = uint64(buf.len)
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_write(cast[ptr Handle00](self.impl), cast[ptr uint8](unsafeaddr(buf[0])), count, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  HandleFlag* {.size: sizeof(cint), pure.} = enum
    flagUnlimited = 0
    flagKeepImageData = 1

  HandleFlags* {.size: sizeof(cint).} = set[HandleFlag]

const
  HandleFlagsFlagsNone* = HandleFlags({})
proc flagsNone*(t: typedesc[HandleFlags]): HandleFlags = HandleFlags({})

proc rsvg_handle_new_from_gfile_sync(file: ptr gio.GFile00; flags: HandleFlags;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr Handle00 {.
    importc, libprag.}

proc newHandleFromGfileSync*(file: gio.GFile; flags: HandleFlags;
    cancellable: gio.Cancellable = nil): Handle =
  var gerror: ptr glib.Error
  let gobj = rsvg_handle_new_from_gfile_sync(cast[ptr gio.GFile00](file.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHandleFromGfileSync*(tdesc: typedesc; file: gio.GFile; flags: HandleFlags;
    cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_gfile_sync(cast[ptr gio.GFile00](file.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromGfileSync*[T](result: var T; file: gio.GFile; flags: HandleFlags;
    cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_gfile_sync(cast[ptr gio.GFile00](file.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_from_stream_sync(inputStream: ptr gio.InputStream00;
    baseFile: ptr gio.GFile00; flags: HandleFlags; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr Handle00 {.
    importc, libprag.}

proc newHandleFromStreamSync*(inputStream: gio.InputStream; baseFile: gio.GFile = nil;
    flags: HandleFlags; cancellable: gio.Cancellable = nil): Handle =
  var gerror: ptr glib.Error
  let gobj = rsvg_handle_new_from_stream_sync(cast[ptr gio.InputStream00](inputStream.impl), if baseFile.isNil: nil else: cast[ptr gio.GFile00](baseFile.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHandleFromStreamSync*(tdesc: typedesc; inputStream: gio.InputStream; baseFile: gio.GFile = nil;
    flags: HandleFlags; cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_stream_sync(cast[ptr gio.InputStream00](inputStream.impl), if baseFile.isNil: nil else: cast[ptr gio.GFile00](baseFile.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromStreamSync*[T](result: var T; inputStream: gio.InputStream; baseFile: gio.GFile = nil;
    flags: HandleFlags; cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Handle)
  let gobj = rsvg_handle_new_from_stream_sync(cast[ptr gio.InputStream00](inputStream.impl), if baseFile.isNil: nil else: cast[ptr gio.GFile00](baseFile.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_with_flags(flags: HandleFlags): ptr Handle00 {.
    importc, libprag.}

proc newHandleWithFlags*(flags: HandleFlags): Handle =
  let gobj = rsvg_handle_new_with_flags(flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHandleWithFlags*(tdesc: typedesc; flags: HandleFlags): tdesc =
  assert(result is Handle)
  let gobj = rsvg_handle_new_with_flags(flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleWithFlags*[T](result: var T; flags: HandleFlags) {.deprecated.} =
  assert(result is Handle)
  let gobj = rsvg_handle_new_with_flags(flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, rsvg.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Unit* {.size: sizeof(cint), pure.} = enum
    percent = 0
    px = 1
    em = 2
    ex = 3
    `in` = 4
    cm = 5
    mm = 6
    pt = 7
    pc = 8

type
  Length* {.pure, byRef.} = object
    length*: cdouble
    unit*: Unit

type
  PositionData* {.pure, byRef.} = object
    x*: int32
    y*: int32

proc rsvg_handle_get_position_sub(self: ptr Handle00; positionData: var PositionData;
    id: cstring): gboolean {.
    importc, libprag.}

proc getPositionSub*(self: Handle; positionData: var PositionData;
    id: cstring = nil): bool =
  toBool(rsvg_handle_get_position_sub(cast[ptr Handle00](self.impl), positionData, id))

type
  Rectangle* {.pure, byRef.} = object
    x*: cdouble
    y*: cdouble
    width*: cdouble
    height*: cdouble

proc rsvg_handle_get_geometry_for_element(self: ptr Handle00; id: cstring;
    outInkRect: var Rectangle; outLogicalRect: var Rectangle; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getGeometryForElement*(self: Handle; id: cstring = nil;
    outInkRect: var Rectangle = cast[var Rectangle](nil); outLogicalRect: var Rectangle = cast[var Rectangle](nil)): bool =
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_get_geometry_for_element(cast[ptr Handle00](self.impl), id, outInkRect, outLogicalRect, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc rsvg_handle_get_geometry_for_layer(self: ptr Handle00; id: cstring;
    viewport: Rectangle; outInkRect: var Rectangle; outLogicalRect: var Rectangle;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getGeometryForLayer*(self: Handle; id: cstring = nil;
    viewport: Rectangle; outInkRect: var Rectangle = cast[var Rectangle](nil);
    outLogicalRect: var Rectangle = cast[var Rectangle](nil)): bool =
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_get_geometry_for_layer(cast[ptr Handle00](self.impl), id, viewport, outInkRect, outLogicalRect, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc rsvg_handle_get_intrinsic_dimensions(self: ptr Handle00; outHasWidth: var gboolean;
    outWidth: var Length; outHasHeight: var gboolean; outHeight: var Length;
    outHasViewbox: var gboolean; outViewbox: var Rectangle) {.
    importc, libprag.}

proc getIntrinsicDimensions*(self: Handle; outHasWidth: var bool = cast[var bool](nil);
    outWidth: var Length = cast[var Length](nil); outHasHeight: var bool = cast[var bool](nil);
    outHeight: var Length = cast[var Length](nil); outHasViewbox: var bool = cast[var bool](nil);
    outViewbox: var Rectangle = cast[var Rectangle](nil)) =
  var outHasWidth_00: gboolean
  var outHasHeight_00: gboolean
  var outHasViewbox_00: gboolean
  rsvg_handle_get_intrinsic_dimensions(cast[ptr Handle00](self.impl), outHasWidth_00, outWidth, outHasHeight_00, outHeight, outHasViewbox_00, outViewbox)
  if outHasWidth.addr != nil:
    outHasWidth = toBool(outHasWidth_00)
  if outHasHeight.addr != nil:
    outHasHeight = toBool(outHasHeight_00)
  if outHasViewbox.addr != nil:
    outHasViewbox = toBool(outHasViewbox_00)

proc rsvg_handle_render_document(self: ptr Handle00; cr: ptr cairo.Context00;
    viewport: Rectangle; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc renderDocument*(self: Handle; cr: cairo.Context; viewport: Rectangle): bool =
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_render_document(cast[ptr Handle00](self.impl), cast[ptr cairo.Context00](cr.impl), viewport, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc rsvg_handle_render_element(self: ptr Handle00; cr: ptr cairo.Context00;
    id: cstring; elementViewport: Rectangle; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc renderElement*(self: Handle; cr: cairo.Context; id: cstring = nil;
    elementViewport: Rectangle): bool =
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_render_element(cast[ptr Handle00](self.impl), cast[ptr cairo.Context00](cr.impl), id, elementViewport, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc rsvg_handle_render_layer(self: ptr Handle00; cr: ptr cairo.Context00;
    id: cstring; viewport: Rectangle; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc renderLayer*(self: Handle; cr: cairo.Context; id: cstring = nil;
    viewport: Rectangle): bool =
  var gerror: ptr glib.Error
  let resul0 = rsvg_handle_render_layer(cast[ptr Handle00](self.impl), cast[ptr cairo.Context00](cr.impl), id, viewport, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

const MAJOR_VERSION* = 2'i32

const MICRO_VERSION* = 3'i32

const MINOR_VERSION* = 50'i32

const VERSION* = "2.50.3"

proc cleanup*() {.
    importc: "rsvg_cleanup", libprag.}

proc setDefaultDpi*(dpi: cdouble) {.
    importc: "rsvg_set_default_dpi", libprag.}

proc setDefaultDpiXY*(dpiX: cdouble; dpiY: cdouble) {.
    importc: "rsvg_set_default_dpi_x_y", libprag.}

proc `defaultDpiXY=`*(dpiX: cdouble; dpiY: cdouble) {.
    importc: "rsvg_set_default_dpi_x_y", libprag.}
# === remaining symbols:
