# dependencies:
# GObject-2.0
# Gio-2.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gio-2.0
# GModule-2.0
# libraries:
# libgdk_pixbuf-2.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gio, glib, gmodule
const Lib = "libgdk_pixbuf-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Colorspace* {.size: sizeof(cint), pure.} = enum
    rgb = 0

type
  InterpType* {.size: sizeof(cint), pure.} = enum
    nearest = 0
    tiles = 1
    bilinear = 2
    hyper = 3

const PIXBUF_FEATURES_H* = 1'i32

const PIXBUF_MAJOR* = 2'i32

const PIXBUF_MICRO* = 2'i32

const PIXBUF_MINOR* = 42'i32

const PIXBUF_VERSION* = "2.42.2"

type
  Pixbuf* = ref object of gobject.Object
  Pixbuf00* = object of gobject.Object00

proc gdk_pixbuf_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Pixbuf()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_pixbuf_new(colorspace: Colorspace; hasAlpha: gboolean; bitsPerSample: int32;
    width: int32; height: int32): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbuf*(colorspace: Colorspace; hasAlpha: bool; bitsPerSample: int;
    width: int; height: int): Pixbuf =
  let gobj = gdk_pixbuf_new(colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height))
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

proc newPixbuf*(tdesc: typedesc; colorspace: Colorspace; hasAlpha: bool; bitsPerSample: int;
    width: int; height: int): tdesc =
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new(colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height))
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

proc initPixbuf*[T](result: var T; colorspace: Colorspace; hasAlpha: bool; bitsPerSample: int;
    width: int; height: int) {.deprecated.} =
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new(colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height))
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

proc gdk_pixbuf_new_from_bytes(data: ptr glib.Bytes00; colorspace: Colorspace;
    hasAlpha: gboolean; bitsPerSample: int32; width: int32; height: int32;
    rowstride: int32): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromBytes*(data: glib.Bytes; colorspace: Colorspace;
    hasAlpha: bool; bitsPerSample: int; width: int; height: int; rowstride: int): Pixbuf =
  let gobj = gdk_pixbuf_new_from_bytes(cast[ptr glib.Bytes00](data.impl), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride))
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

proc newPixbufFromBytes*(tdesc: typedesc; data: glib.Bytes; colorspace: Colorspace;
    hasAlpha: bool; bitsPerSample: int; width: int; height: int; rowstride: int): tdesc =
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_bytes(cast[ptr glib.Bytes00](data.impl), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride))
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

proc initPixbufFromBytes*[T](result: var T; data: glib.Bytes; colorspace: Colorspace;
    hasAlpha: bool; bitsPerSample: int; width: int; height: int; rowstride: int) {.deprecated.} =
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_bytes(cast[ptr glib.Bytes00](data.impl), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride))
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

proc gdk_pixbuf_new_from_file(filename: cstring; error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromFile*(filename: cstring): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromFile*(tdesc: typedesc; filename: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromFile*[T](result: var T; filename: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_file_at_scale(filename: cstring; width: int32; height: int32;
    preserveAspectRatio: gboolean; error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromFileAtScale*(filename: cstring; width: int; height: int;
    preserveAspectRatio: bool): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_file_at_scale(filename, int32(width), int32(height), gboolean(preserveAspectRatio), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromFileAtScale*(tdesc: typedesc; filename: cstring; width: int; height: int;
    preserveAspectRatio: bool): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_file_at_scale(filename, int32(width), int32(height), gboolean(preserveAspectRatio), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromFileAtScale*[T](result: var T; filename: cstring; width: int; height: int;
    preserveAspectRatio: bool) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_file_at_scale(filename, int32(width), int32(height), gboolean(preserveAspectRatio), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_file_at_size(filename: cstring; width: int32; height: int32;
    error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromFileAtSize*(filename: cstring; width: int; height: int): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_file_at_size(filename, int32(width), int32(height), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromFileAtSize*(tdesc: typedesc; filename: cstring; width: int; height: int): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_file_at_size(filename, int32(width), int32(height), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromFileAtSize*[T](result: var T; filename: cstring; width: int; height: int) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_file_at_size(filename, int32(width), int32(height), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_inline(dataLength: int32; data: ptr uint8; copyPixels: gboolean;
    error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromInline*(data: seq[uint8] | string; copyPixels: bool): Pixbuf {.deprecated.}  =
  let dataLength = int(data.len)
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_inline(int32(dataLength), cast[ptr uint8](unsafeaddr(data[0])), gboolean(copyPixels), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromInline*(tdesc: typedesc; data: seq[uint8] | string; copyPixels: bool): tdesc {.deprecated.}  =
  let dataLength = int(data.len)
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_inline(int32(dataLength), cast[ptr uint8](unsafeaddr(data[0])), gboolean(copyPixels), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromInline*[T](result: var T; data: seq[uint8] | string; copyPixels: bool) {.deprecated.} =
  let dataLength = int(data.len)
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_inline(int32(dataLength), cast[ptr uint8](unsafeaddr(data[0])), gboolean(copyPixels), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_resource(resourcePath: cstring; error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromResource*(resourcePath: cstring): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_resource(resourcePath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromResource*(tdesc: typedesc; resourcePath: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_resource(resourcePath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromResource*[T](result: var T; resourcePath: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_resource(resourcePath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_resource_at_scale(resourcePath: cstring; width: int32;
    height: int32; preserveAspectRatio: gboolean; error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromResourceAtScale*(resourcePath: cstring; width: int;
    height: int; preserveAspectRatio: bool): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_resource_at_scale(resourcePath, int32(width), int32(height), gboolean(preserveAspectRatio), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromResourceAtScale*(tdesc: typedesc; resourcePath: cstring; width: int;
    height: int; preserveAspectRatio: bool): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_resource_at_scale(resourcePath, int32(width), int32(height), gboolean(preserveAspectRatio), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromResourceAtScale*[T](result: var T; resourcePath: cstring; width: int;
    height: int; preserveAspectRatio: bool) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_resource_at_scale(resourcePath, int32(width), int32(height), gboolean(preserveAspectRatio), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_stream(stream: ptr gio.InputStream00; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromStream*(stream: gio.InputStream; cancellable: gio.Cancellable = nil): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_stream(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromStream*(tdesc: typedesc; stream: gio.InputStream; cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_stream(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromStream*[T](result: var T; stream: gio.InputStream; cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_stream(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_stream_at_scale(stream: ptr gio.InputStream00; width: int32;
    height: int32; preserveAspectRatio: gboolean; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromStreamAtScale*(stream: gio.InputStream; width: int;
    height: int; preserveAspectRatio: bool; cancellable: gio.Cancellable = nil): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_stream_at_scale(cast[ptr gio.InputStream00](stream.impl), int32(width), int32(height), gboolean(preserveAspectRatio), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromStreamAtScale*(tdesc: typedesc; stream: gio.InputStream; width: int;
    height: int; preserveAspectRatio: bool; cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_stream_at_scale(cast[ptr gio.InputStream00](stream.impl), int32(width), int32(height), gboolean(preserveAspectRatio), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromStreamAtScale*[T](result: var T; stream: gio.InputStream; width: int;
    height: int; preserveAspectRatio: bool; cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_stream_at_scale(cast[ptr gio.InputStream00](stream.impl), int32(width), int32(height), gboolean(preserveAspectRatio), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_stream_finish(asyncResult: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromStreamFinish*(asyncResult: gio.AsyncResult): Pixbuf =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufFromStreamFinish*(tdesc: typedesc; asyncResult: gio.AsyncResult): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufFromStreamFinish*[T](result: var T; asyncResult: gio.AsyncResult) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_new_from_xpm_data(data: ptr cstring): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromXpmData*(data: varargs[string, `$`]): Pixbuf =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let gobj = gdk_pixbuf_new_from_xpm_data(seq2CstringArray(data, fs469n23))
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

proc newPixbufFromXpmData*(tdesc: typedesc; data: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_xpm_data(seq2CstringArray(data, fs469n23))
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

proc initPixbufFromXpmData*[T](result: var T; data: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_xpm_data(seq2CstringArray(data, fs469n23))
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

proc gdk_pixbuf_calculate_rowstride(colorspace: Colorspace; hasAlpha: gboolean;
    bitsPerSample: int32; width: int32; height: int32): int32 {.
    importc, libprag.}

proc calculateRowstride*(colorspace: Colorspace; hasAlpha: bool;
    bitsPerSample: int; width: int; height: int): int =
  int(gdk_pixbuf_calculate_rowstride(colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height)))

proc gdk_pixbuf_get_file_info_async(filename: cstring; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getFileInfoAsync*(filename: cstring; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_pixbuf_get_file_info_async(filename, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_init_modules(path: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc initModules*(path: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_init_modules(path, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_pixbuf_new_from_stream_async(stream: ptr gio.InputStream00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc newFromStreamAsync*(stream: gio.InputStream; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_pixbuf_new_from_stream_async(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_new_from_stream_at_scale_async(stream: ptr gio.InputStream00;
    width: int32; height: int32; preserveAspectRatio: gboolean; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc newFromStreamAtScaleAsync*(stream: gio.InputStream; width: int;
    height: int; preserveAspectRatio: bool; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_pixbuf_new_from_stream_at_scale_async(cast[ptr gio.InputStream00](stream.impl), int32(width), int32(height), gboolean(preserveAspectRatio), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_save_to_stream_finish(asyncResult: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToStreamFinish*(asyncResult: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_save_to_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_pixbuf_add_alpha(self: ptr Pixbuf00; substituteColor: gboolean;
    r: uint8; g: uint8; b: uint8): ptr Pixbuf00 {.
    importc, libprag.}

proc addAlpha*(self: Pixbuf; substituteColor: bool; r: uint8;
    g: uint8; b: uint8): Pixbuf =
  let gobj = gdk_pixbuf_add_alpha(cast[ptr Pixbuf00](self.impl), gboolean(substituteColor), r, g, b)
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

proc gdk_pixbuf_apply_embedded_orientation(self: ptr Pixbuf00): ptr Pixbuf00 {.
    importc, libprag.}

proc applyEmbeddedOrientation*(self: Pixbuf): Pixbuf =
  let gobj = gdk_pixbuf_apply_embedded_orientation(cast[ptr Pixbuf00](self.impl))
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

proc gdk_pixbuf_composite(self: ptr Pixbuf00; dest: ptr Pixbuf00; destX: int32;
    destY: int32; destWidth: int32; destHeight: int32; offsetX: cdouble; offsetY: cdouble;
    scaleX: cdouble; scaleY: cdouble; interpType: InterpType; overallAlpha: int32) {.
    importc, libprag.}

proc composite*(self: Pixbuf; dest: Pixbuf; destX: int; destY: int;
    destWidth: int; destHeight: int; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble;
    scaleY: cdouble; interpType: InterpType; overallAlpha: int) =
  gdk_pixbuf_composite(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), int32(destX), int32(destY), int32(destWidth), int32(destHeight), offsetX, offsetY, scaleX, scaleY, interpType, int32(overallAlpha))

proc gdk_pixbuf_composite_color(self: ptr Pixbuf00; dest: ptr Pixbuf00; destX: int32;
    destY: int32; destWidth: int32; destHeight: int32; offsetX: cdouble; offsetY: cdouble;
    scaleX: cdouble; scaleY: cdouble; interpType: InterpType; overallAlpha: int32;
    checkX: int32; checkY: int32; checkSize: int32; color1: uint32; color2: uint32) {.
    importc, libprag.}

proc compositeColor*(self: Pixbuf; dest: Pixbuf; destX: int; destY: int;
    destWidth: int; destHeight: int; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble;
    scaleY: cdouble; interpType: InterpType; overallAlpha: int; checkX: int;
    checkY: int; checkSize: int; color1: int; color2: int) =
  gdk_pixbuf_composite_color(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), int32(destX), int32(destY), int32(destWidth), int32(destHeight), offsetX, offsetY, scaleX, scaleY, interpType, int32(overallAlpha), int32(checkX), int32(checkY), int32(checkSize), uint32(color1), uint32(color2))

proc gdk_pixbuf_composite_color_simple(self: ptr Pixbuf00; destWidth: int32;
    destHeight: int32; interpType: InterpType; overallAlpha: int32; checkSize: int32;
    color1: uint32; color2: uint32): ptr Pixbuf00 {.
    importc, libprag.}

proc compositeColorSimple*(self: Pixbuf; destWidth: int; destHeight: int;
    interpType: InterpType; overallAlpha: int; checkSize: int; color1: int;
    color2: int): Pixbuf =
  let gobj = gdk_pixbuf_composite_color_simple(cast[ptr Pixbuf00](self.impl), int32(destWidth), int32(destHeight), interpType, int32(overallAlpha), int32(checkSize), uint32(color1), uint32(color2))
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

proc gdk_pixbuf_copy(self: ptr Pixbuf00): ptr Pixbuf00 {.
    importc, libprag.}

proc copy*(self: Pixbuf): Pixbuf =
  let gobj = gdk_pixbuf_copy(cast[ptr Pixbuf00](self.impl))
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

proc gdk_pixbuf_copy_area(self: ptr Pixbuf00; srcX: int32; srcY: int32; width: int32;
    height: int32; destPixbuf: ptr Pixbuf00; destX: int32; destY: int32) {.
    importc, libprag.}

proc copyArea*(self: Pixbuf; srcX: int; srcY: int; width: int;
    height: int; destPixbuf: Pixbuf; destX: int; destY: int) =
  gdk_pixbuf_copy_area(cast[ptr Pixbuf00](self.impl), int32(srcX), int32(srcY), int32(width), int32(height), cast[ptr Pixbuf00](destPixbuf.impl), int32(destX), int32(destY))

proc gdk_pixbuf_copy_options(self: ptr Pixbuf00; destPixbuf: ptr Pixbuf00): gboolean {.
    importc, libprag.}

proc copyOptions*(self: Pixbuf; destPixbuf: Pixbuf): bool =
  toBool(gdk_pixbuf_copy_options(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](destPixbuf.impl)))

proc gdk_pixbuf_fill(self: ptr Pixbuf00; pixel: uint32) {.
    importc, libprag.}

proc fill*(self: Pixbuf; pixel: int) =
  gdk_pixbuf_fill(cast[ptr Pixbuf00](self.impl), uint32(pixel))

proc gdk_pixbuf_flip(self: ptr Pixbuf00; horizontal: gboolean): ptr Pixbuf00 {.
    importc, libprag.}

proc flip*(self: Pixbuf; horizontal: bool): Pixbuf =
  let gobj = gdk_pixbuf_flip(cast[ptr Pixbuf00](self.impl), gboolean(horizontal))
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

proc gdk_pixbuf_get_bits_per_sample(self: ptr Pixbuf00): int32 {.
    importc, libprag.}

proc getBitsPerSample*(self: Pixbuf): int =
  int(gdk_pixbuf_get_bits_per_sample(cast[ptr Pixbuf00](self.impl)))

proc bitsPerSample*(self: Pixbuf): int =
  int(gdk_pixbuf_get_bits_per_sample(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_byte_length(self: ptr Pixbuf00): uint64 {.
    importc, libprag.}

proc getByteLength*(self: Pixbuf): uint64 =
  gdk_pixbuf_get_byte_length(cast[ptr Pixbuf00](self.impl))

proc byteLength*(self: Pixbuf): uint64 =
  gdk_pixbuf_get_byte_length(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_get_colorspace(self: ptr Pixbuf00): Colorspace {.
    importc, libprag.}

proc getColorspace*(self: Pixbuf): Colorspace =
  gdk_pixbuf_get_colorspace(cast[ptr Pixbuf00](self.impl))

proc colorspace*(self: Pixbuf): Colorspace =
  gdk_pixbuf_get_colorspace(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_get_has_alpha(self: ptr Pixbuf00): gboolean {.
    importc, libprag.}

proc getHasAlpha*(self: Pixbuf): bool =
  toBool(gdk_pixbuf_get_has_alpha(cast[ptr Pixbuf00](self.impl)))

proc hasAlpha*(self: Pixbuf): bool =
  toBool(gdk_pixbuf_get_has_alpha(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_height(self: ptr Pixbuf00): int32 {.
    importc, libprag.}

proc getHeight*(self: Pixbuf): int =
  int(gdk_pixbuf_get_height(cast[ptr Pixbuf00](self.impl)))

proc height*(self: Pixbuf): int =
  int(gdk_pixbuf_get_height(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_n_channels(self: ptr Pixbuf00): int32 {.
    importc, libprag.}

proc getNChannels*(self: Pixbuf): int =
  int(gdk_pixbuf_get_n_channels(cast[ptr Pixbuf00](self.impl)))

proc nChannels*(self: Pixbuf): int =
  int(gdk_pixbuf_get_n_channels(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_option(self: ptr Pixbuf00; key: cstring): cstring {.
    importc, libprag.}

proc getOption*(self: Pixbuf; key: cstring): string =
  result = $gdk_pixbuf_get_option(cast[ptr Pixbuf00](self.impl), key)

proc gdk_pixbuf_get_options(self: ptr Pixbuf00): ptr HashTable00 {.
    importc, libprag.}

proc getOptions*(self: Pixbuf): ptr HashTable00 =
  gdk_pixbuf_get_options(cast[ptr Pixbuf00](self.impl))

proc options*(self: Pixbuf): ptr HashTable00 =
  gdk_pixbuf_get_options(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_get_pixels_with_length(self: ptr Pixbuf00; length: var uint32): ptr uint8 {.
    importc, libprag.}

proc getPixels*(self: Pixbuf; length: var int): seq[uint8] =
  var length_00: uint32
  result = uint8ArrayToSeq(gdk_pixbuf_get_pixels_with_length(cast[ptr Pixbuf00](self.impl), length_00), length.int)
  if length.addr != nil:
    length = int(length_00)

proc gdk_pixbuf_get_rowstride(self: ptr Pixbuf00): int32 {.
    importc, libprag.}

proc getRowstride*(self: Pixbuf): int =
  int(gdk_pixbuf_get_rowstride(cast[ptr Pixbuf00](self.impl)))

proc rowstride*(self: Pixbuf): int =
  int(gdk_pixbuf_get_rowstride(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_width(self: ptr Pixbuf00): int32 {.
    importc, libprag.}

proc getWidth*(self: Pixbuf): int =
  int(gdk_pixbuf_get_width(cast[ptr Pixbuf00](self.impl)))

proc width*(self: Pixbuf): int =
  int(gdk_pixbuf_get_width(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_new_subpixbuf(self: ptr Pixbuf00; srcX: int32; srcY: int32;
    width: int32; height: int32): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufSubpixbuf*(self: Pixbuf; srcX: int; srcY: int; width: int;
    height: int): Pixbuf =
  let gobj = gdk_pixbuf_new_subpixbuf(cast[ptr Pixbuf00](self.impl), int32(srcX), int32(srcY), int32(width), int32(height))
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

proc gdk_pixbuf_read_pixel_bytes(self: ptr Pixbuf00): ptr glib.Bytes00 {.
    importc, libprag.}

proc readPixelBytes*(self: Pixbuf): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gdk_pixbuf_read_pixel_bytes(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_read_pixels(self: ptr Pixbuf00): ptr uint8 {.
    importc, libprag.}

proc readPixels*(self: Pixbuf): ptr uint8 =
  gdk_pixbuf_read_pixels(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_remove_option(self: ptr Pixbuf00; key: cstring): gboolean {.
    importc, libprag.}

proc removeOption*(self: Pixbuf; key: cstring): bool =
  toBool(gdk_pixbuf_remove_option(cast[ptr Pixbuf00](self.impl), key))

proc gdk_pixbuf_saturate_and_pixelate(self: ptr Pixbuf00; dest: ptr Pixbuf00;
    saturation: cfloat; pixelate: gboolean) {.
    importc, libprag.}

proc saturateAndPixelate*(self: Pixbuf; dest: Pixbuf; saturation: cfloat;
    pixelate: bool) =
  gdk_pixbuf_saturate_and_pixelate(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), saturation, gboolean(pixelate))

proc gdk_pixbuf_save_to_streamv(self: ptr Pixbuf00; stream: ptr gio.OutputStream00;
    `type`: cstring; optionKeys: ptr cstring; optionValues: ptr cstring; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToStreamv*(self: Pixbuf; stream: gio.OutputStream; `type`: cstring;
    optionKeys: openArray[string]; optionValues: openArray[string]; cancellable: gio.Cancellable = nil): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_save_to_streamv(cast[ptr Pixbuf00](self.impl), cast[ptr gio.OutputStream00](stream.impl), `type`, seq2CstringArray(optionKeys, fs469n23), seq2CstringArray(optionValues, fs469n232), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_pixbuf_save_to_streamv_async(self: ptr Pixbuf00; stream: ptr gio.OutputStream00;
    `type`: cstring; optionKeys: ptr cstring; optionValues: ptr cstring; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc saveToStreamvAsync*(self: Pixbuf; stream: gio.OutputStream;
    `type`: cstring; optionKeys: openArray[string]; optionValues: openArray[string];
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  gdk_pixbuf_save_to_streamv_async(cast[ptr Pixbuf00](self.impl), cast[ptr gio.OutputStream00](stream.impl), `type`, seq2CstringArray(optionKeys, fs469n23), seq2CstringArray(optionValues, fs469n232), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_savev(self: ptr Pixbuf00; filename: cstring; `type`: cstring;
    optionKeys: ptr cstring; optionValues: ptr cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc savev*(self: Pixbuf; filename: cstring; `type`: cstring; optionKeys: openArray[string];
    optionValues: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_savev(cast[ptr Pixbuf00](self.impl), filename, `type`, seq2CstringArray(optionKeys, fs469n23), seq2CstringArray(optionValues, fs469n232), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_pixbuf_scale(self: ptr Pixbuf00; dest: ptr Pixbuf00; destX: int32;
    destY: int32; destWidth: int32; destHeight: int32; offsetX: cdouble; offsetY: cdouble;
    scaleX: cdouble; scaleY: cdouble; interpType: InterpType) {.
    importc, libprag.}

proc scale*(self: Pixbuf; dest: Pixbuf; destX: int; destY: int;
    destWidth: int; destHeight: int; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble;
    scaleY: cdouble; interpType: InterpType) =
  gdk_pixbuf_scale(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), int32(destX), int32(destY), int32(destWidth), int32(destHeight), offsetX, offsetY, scaleX, scaleY, interpType)

proc gdk_pixbuf_scale_simple(self: ptr Pixbuf00; destWidth: int32; destHeight: int32;
    interpType: InterpType): ptr Pixbuf00 {.
    importc, libprag.}

proc scaleSimple*(self: Pixbuf; destWidth: int; destHeight: int;
    interpType: InterpType): Pixbuf =
  let gobj = gdk_pixbuf_scale_simple(cast[ptr Pixbuf00](self.impl), int32(destWidth), int32(destHeight), interpType)
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

proc gdk_pixbuf_set_option(self: ptr Pixbuf00; key: cstring; value: cstring): gboolean {.
    importc, libprag.}

proc setOption*(self: Pixbuf; key: cstring; value: cstring): bool =
  toBool(gdk_pixbuf_set_option(cast[ptr Pixbuf00](self.impl), key, value))

type
  PixbufFormat00* {.pure.} = object
  PixbufFormat* = ref object
    impl*: ptr PixbufFormat00
    ignoreFinalizer*: bool

proc gdk_pixbuf_format_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkPixbufFormat*(self: PixbufFormat) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_pixbuf_format_get_type(), cast[ptr PixbufFormat00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PixbufFormat()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_pixbuf_format_get_type(), cast[ptr PixbufFormat00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PixbufFormat) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkPixbufFormat)

proc gdk_pixbuf_format_free(self: ptr PixbufFormat00) {.
    importc, libprag.}

proc free*(self: PixbufFormat) =
  gdk_pixbuf_format_free(cast[ptr PixbufFormat00](self.impl))

proc finalizerfree*(self: PixbufFormat) =
  if not self.ignoreFinalizer:
    gdk_pixbuf_format_free(cast[ptr PixbufFormat00](self.impl))

proc gdk_pixbuf_format_copy(self: ptr PixbufFormat00): ptr PixbufFormat00 {.
    importc, libprag.}

proc copy*(self: PixbufFormat): PixbufFormat =
  fnew(result, gBoxedFreeGdkPixbufFormat)
  result.impl = gdk_pixbuf_format_copy(cast[ptr PixbufFormat00](self.impl))

proc gdk_pixbuf_format_get_description(self: ptr PixbufFormat00): cstring {.
    importc, libprag.}

proc getDescription*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_description(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc description*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_description(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_pixbuf_format_get_extensions(self: ptr PixbufFormat00): ptr cstring {.
    importc, libprag.}

proc getExtensions*(self: PixbufFormat): seq[string] =
  let resul0 = gdk_pixbuf_format_get_extensions(cast[ptr PixbufFormat00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc extensions*(self: PixbufFormat): seq[string] =
  let resul0 = gdk_pixbuf_format_get_extensions(cast[ptr PixbufFormat00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gdk_pixbuf_format_get_license(self: ptr PixbufFormat00): cstring {.
    importc, libprag.}

proc getLicense*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_license(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc license*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_license(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_pixbuf_format_get_mime_types(self: ptr PixbufFormat00): ptr cstring {.
    importc, libprag.}

proc getMimeTypes*(self: PixbufFormat): seq[string] =
  let resul0 = gdk_pixbuf_format_get_mime_types(cast[ptr PixbufFormat00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc mimeTypes*(self: PixbufFormat): seq[string] =
  let resul0 = gdk_pixbuf_format_get_mime_types(cast[ptr PixbufFormat00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gdk_pixbuf_format_get_name(self: ptr PixbufFormat00): cstring {.
    importc, libprag.}

proc getName*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_name(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_name(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_pixbuf_format_is_disabled(self: ptr PixbufFormat00): gboolean {.
    importc, libprag.}

proc isDisabled*(self: PixbufFormat): bool =
  toBool(gdk_pixbuf_format_is_disabled(cast[ptr PixbufFormat00](self.impl)))

proc gdk_pixbuf_format_is_save_option_supported(self: ptr PixbufFormat00;
    optionKey: cstring): gboolean {.
    importc, libprag.}

proc isSaveOptionSupported*(self: PixbufFormat; optionKey: cstring): bool =
  toBool(gdk_pixbuf_format_is_save_option_supported(cast[ptr PixbufFormat00](self.impl), optionKey))

proc gdk_pixbuf_format_is_scalable(self: ptr PixbufFormat00): gboolean {.
    importc, libprag.}

proc isScalable*(self: PixbufFormat): bool =
  toBool(gdk_pixbuf_format_is_scalable(cast[ptr PixbufFormat00](self.impl)))

proc gdk_pixbuf_format_is_writable(self: ptr PixbufFormat00): gboolean {.
    importc, libprag.}

proc isWritable*(self: PixbufFormat): bool =
  toBool(gdk_pixbuf_format_is_writable(cast[ptr PixbufFormat00](self.impl)))

proc gdk_pixbuf_format_set_disabled(self: ptr PixbufFormat00; disabled: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: PixbufFormat; disabled: bool = true) =
  gdk_pixbuf_format_set_disabled(cast[ptr PixbufFormat00](self.impl), gboolean(disabled))

proc `disabled=`*(self: PixbufFormat; disabled: bool) =
  gdk_pixbuf_format_set_disabled(cast[ptr PixbufFormat00](self.impl), gboolean(disabled))

proc gdk_pixbuf_get_file_info(filename: cstring; width: var int32; height: var int32): ptr PixbufFormat00 {.
    importc, libprag.}

proc getFileInfo*(filename: cstring; width: var int = cast[var int](nil);
    height: var int = cast[var int](nil)): PixbufFormat =
  var width_00: int32
  var height_00: int32
  let impl0 = gdk_pixbuf_get_file_info(filename, width_00, height_00)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkPixbufFormat)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_pixbuf_format_get_type(), impl0))
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc gdk_pixbuf_get_file_info_finish(asyncResult: ptr gio.AsyncResult00;
    width: var int32; height: var int32; error: ptr ptr glib.Error = nil): ptr PixbufFormat00 {.
    importc, libprag.}

proc getFileInfoFinish*(asyncResult: gio.AsyncResult; width: var int;
    height: var int): PixbufFormat =
  var gerror: ptr glib.Error
  var width_00: int32
  var height_00: int32
  let impl0 = gdk_pixbuf_get_file_info_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), width_00, height_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGdkPixbufFormat)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_pixbuf_format_get_type(), impl0))
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc getPixbufFormats*(): ptr glib.SList {.
    importc: "gdk_pixbuf_get_formats", libprag.}

type
  PixbufRotation* {.size: sizeof(cint), pure.} = enum
    none = 0
    counterclockwise = 90
    upsidedown = 180
    clockwise = 270

proc gdk_pixbuf_rotate_simple(self: ptr Pixbuf00; angle: PixbufRotation): ptr Pixbuf00 {.
    importc, libprag.}

proc rotateSimple*(self: Pixbuf; angle: PixbufRotation): Pixbuf =
  let gobj = gdk_pixbuf_rotate_simple(cast[ptr Pixbuf00](self.impl), angle)
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

type
  PixbufAlphaMode* {.size: sizeof(cint), pure.} = enum
    bilevel = 0
    full = 1

type
  PixbufAnimation* = ref object of gobject.Object
  PixbufAnimation00* = object of gobject.Object00

proc gdk_pixbuf_animation_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PixbufAnimation()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_pixbuf_animation_new_from_file(filename: cstring; error: ptr ptr glib.Error = nil): ptr PixbufAnimation00 {.
    importc, libprag.}

proc newPixbufAnimationFromFile*(filename: cstring): PixbufAnimation =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_animation_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufAnimationFromFile*(tdesc: typedesc; filename: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufAnimationFromFile*[T](result: var T; filename: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_animation_new_from_resource(resourcePath: cstring; error: ptr ptr glib.Error = nil): ptr PixbufAnimation00 {.
    importc, libprag.}

proc newPixbufAnimationFromResource*(resourcePath: cstring): PixbufAnimation =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_animation_new_from_resource(resourcePath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufAnimationFromResource*(tdesc: typedesc; resourcePath: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_resource(resourcePath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufAnimationFromResource*[T](result: var T; resourcePath: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_resource(resourcePath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_animation_new_from_stream(stream: ptr gio.InputStream00;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr PixbufAnimation00 {.
    importc, libprag.}

proc newPixbufAnimationFromStream*(stream: gio.InputStream; cancellable: gio.Cancellable = nil): PixbufAnimation =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_animation_new_from_stream(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufAnimationFromStream*(tdesc: typedesc; stream: gio.InputStream; cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_stream(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufAnimationFromStream*[T](result: var T; stream: gio.InputStream; cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_stream(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_animation_new_from_stream_finish(asyncResult: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr PixbufAnimation00 {.
    importc, libprag.}

proc newPixbufAnimationFromStreamFinish*(asyncResult: gio.AsyncResult): PixbufAnimation =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_animation_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufAnimationFromStreamFinish*(tdesc: typedesc; asyncResult: gio.AsyncResult): tdesc =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufAnimationFromStreamFinish*[T](result: var T; asyncResult: gio.AsyncResult) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is PixbufAnimation)
  let gobj = gdk_pixbuf_animation_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_animation_new_from_stream_async(stream: ptr gio.InputStream00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc newAnimationFromStreamAsync*(stream: gio.InputStream;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gdk_pixbuf_animation_new_from_stream_async(cast[ptr gio.InputStream00](stream.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_animation_get_height(self: ptr PixbufAnimation00): int32 {.
    importc, libprag.}

proc getHeight*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_height(cast[ptr PixbufAnimation00](self.impl)))

proc height*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_height(cast[ptr PixbufAnimation00](self.impl)))

proc gdk_pixbuf_animation_get_static_image(self: ptr PixbufAnimation00): ptr Pixbuf00 {.
    importc, libprag.}

proc getStaticImage*(self: PixbufAnimation): Pixbuf =
  let gobj = gdk_pixbuf_animation_get_static_image(cast[ptr PixbufAnimation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc staticImage*(self: PixbufAnimation): Pixbuf =
  let gobj = gdk_pixbuf_animation_get_static_image(cast[ptr PixbufAnimation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_animation_get_width(self: ptr PixbufAnimation00): int32 {.
    importc, libprag.}

proc getWidth*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_width(cast[ptr PixbufAnimation00](self.impl)))

proc width*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_width(cast[ptr PixbufAnimation00](self.impl)))

proc gdk_pixbuf_animation_is_static_image(self: ptr PixbufAnimation00): gboolean {.
    importc, libprag.}

proc isStaticImage*(self: PixbufAnimation): bool =
  toBool(gdk_pixbuf_animation_is_static_image(cast[ptr PixbufAnimation00](self.impl)))

type
  PixbufAnimationIter* = ref object of gobject.Object
  PixbufAnimationIter00* = object of gobject.Object00

proc gdk_pixbuf_animation_iter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PixbufAnimationIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_pixbuf_animation_iter_advance(self: ptr PixbufAnimationIter00; currentTime: glib.TimeVal): gboolean {.
    importc, libprag.}

proc advance*(self: PixbufAnimationIter; currentTime: glib.TimeVal = cast[var glib.TimeVal](nil)): bool =
  toBool(gdk_pixbuf_animation_iter_advance(cast[ptr PixbufAnimationIter00](self.impl), currentTime))

proc gdk_pixbuf_animation_iter_get_delay_time(self: ptr PixbufAnimationIter00): int32 {.
    importc, libprag.}

proc getDelayTime*(self: PixbufAnimationIter): int =
  int(gdk_pixbuf_animation_iter_get_delay_time(cast[ptr PixbufAnimationIter00](self.impl)))

proc delayTime*(self: PixbufAnimationIter): int =
  int(gdk_pixbuf_animation_iter_get_delay_time(cast[ptr PixbufAnimationIter00](self.impl)))

proc gdk_pixbuf_animation_iter_get_pixbuf(self: ptr PixbufAnimationIter00): ptr Pixbuf00 {.
    importc, libprag.}

proc getPixbuf*(self: PixbufAnimationIter): Pixbuf =
  let gobj = gdk_pixbuf_animation_iter_get_pixbuf(cast[ptr PixbufAnimationIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: PixbufAnimationIter): Pixbuf =
  let gobj = gdk_pixbuf_animation_iter_get_pixbuf(cast[ptr PixbufAnimationIter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_animation_iter_on_currently_loading_frame(self: ptr PixbufAnimationIter00): gboolean {.
    importc, libprag.}

proc onCurrentlyLoadingFrame*(self: PixbufAnimationIter): bool =
  toBool(gdk_pixbuf_animation_iter_on_currently_loading_frame(cast[ptr PixbufAnimationIter00](self.impl)))

proc gdk_pixbuf_animation_get_iter(self: ptr PixbufAnimation00; startTime: glib.TimeVal): ptr PixbufAnimationIter00 {.
    importc, libprag.}

proc getIter*(self: PixbufAnimation; startTime: glib.TimeVal = cast[var glib.TimeVal](nil)): PixbufAnimationIter =
  let gobj = gdk_pixbuf_animation_get_iter(cast[ptr PixbufAnimation00](self.impl), startTime)
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

type
  PixbufDestroyNotify* = proc (pixels: ptr uint8; data: pointer) {.cdecl.}

proc gdk_pixbuf_new_from_data(data: ptr uint8; colorspace: Colorspace; hasAlpha: gboolean;
    bitsPerSample: int32; width: int32; height: int32; rowstride: int32; destroyFn: PixbufDestroyNotify;
    destroyFnData: pointer): ptr Pixbuf00 {.
    importc, libprag.}

proc newPixbufFromData*(data: seq[uint8] | string; colorspace: Colorspace;
    hasAlpha: bool; bitsPerSample: int; width: int; height: int; rowstride: int;
    destroyFn: PixbufDestroyNotify; destroyFnData: pointer): Pixbuf =
  let gobj = gdk_pixbuf_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride), destroyFn, destroyFnData)
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

proc newPixbufFromData*(tdesc: typedesc; data: seq[uint8] | string; colorspace: Colorspace;
    hasAlpha: bool; bitsPerSample: int; width: int; height: int; rowstride: int;
    destroyFn: PixbufDestroyNotify; destroyFnData: pointer): tdesc =
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride), destroyFn, destroyFnData)
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

proc initPixbufFromData*[T](result: var T; data: seq[uint8] | string; colorspace: Colorspace;
    hasAlpha: bool; bitsPerSample: int; width: int; height: int; rowstride: int;
    destroyFn: PixbufDestroyNotify; destroyFnData: pointer) {.deprecated.} =
  assert(result is Pixbuf)
  let gobj = gdk_pixbuf_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride), destroyFn, destroyFnData)
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

type
  PixbufError* {.size: sizeof(cint), pure.} = enum
    corruptImage = 0
    insufficientMemory = 1
    badOption = 2
    unknownType = 3
    unsupportedOperation = 4
    failed = 5
    incompleteAnimation = 6

type
  PixbufLoader* = ref object of gobject.Object
  PixbufLoader00* = object of gobject.Object00

proc gdk_pixbuf_loader_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PixbufLoader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAreaPrepared*(self: PixbufLoader;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "area-prepared", cast[GCallback](p), xdata, nil, cf)

proc scAreaUpdated*(self: PixbufLoader;  p: proc (self: ptr PixbufLoader00; x: int32; y: int32; width: int32; height: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "area-updated", cast[GCallback](p), xdata, nil, cf)

proc scClosed*(self: PixbufLoader;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc scSizePrepared*(self: PixbufLoader;  p: proc (self: ptr PixbufLoader00; width: int32; height: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "size-prepared", cast[GCallback](p), xdata, nil, cf)

proc gdk_pixbuf_loader_new(): ptr PixbufLoader00 {.
    importc, libprag.}

proc newPixbufLoader*(): PixbufLoader =
  let gobj = gdk_pixbuf_loader_new()
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

proc newPixbufLoader*(tdesc: typedesc): tdesc =
  assert(result is PixbufLoader)
  let gobj = gdk_pixbuf_loader_new()
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

proc initPixbufLoader*[T](result: var T) {.deprecated.} =
  assert(result is PixbufLoader)
  let gobj = gdk_pixbuf_loader_new()
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

proc gdk_pixbuf_loader_new_with_mime_type(mimeType: cstring; error: ptr ptr glib.Error = nil): ptr PixbufLoader00 {.
    importc, libprag.}

proc newPixbufLoaderWithMimeType*(mimeType: cstring): PixbufLoader =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_loader_new_with_mime_type(mimeType, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufLoaderWithMimeType*(tdesc: typedesc; mimeType: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is PixbufLoader)
  let gobj = gdk_pixbuf_loader_new_with_mime_type(mimeType, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufLoaderWithMimeType*[T](result: var T; mimeType: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is PixbufLoader)
  let gobj = gdk_pixbuf_loader_new_with_mime_type(mimeType, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_loader_new_with_type(imageType: cstring; error: ptr ptr glib.Error = nil): ptr PixbufLoader00 {.
    importc, libprag.}

proc newPixbufLoaderWithType*(imageType: cstring): PixbufLoader =
  var gerror: ptr glib.Error
  let gobj = gdk_pixbuf_loader_new_with_type(imageType, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc newPixbufLoaderWithType*(tdesc: typedesc; imageType: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is PixbufLoader)
  let gobj = gdk_pixbuf_loader_new_with_type(imageType, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc initPixbufLoaderWithType*[T](result: var T; imageType: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is PixbufLoader)
  let gobj = gdk_pixbuf_loader_new_with_type(imageType, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gdk_pixbuf_loader_close(self: ptr PixbufLoader00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc close*(self: PixbufLoader): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_loader_close(cast[ptr PixbufLoader00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_pixbuf_loader_get_animation(self: ptr PixbufLoader00): ptr PixbufAnimation00 {.
    importc, libprag.}

proc getAnimation*(self: PixbufLoader): PixbufAnimation =
  let gobj = gdk_pixbuf_loader_get_animation(cast[ptr PixbufLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc animation*(self: PixbufLoader): PixbufAnimation =
  let gobj = gdk_pixbuf_loader_get_animation(cast[ptr PixbufLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_loader_get_format(self: ptr PixbufLoader00): ptr PixbufFormat00 {.
    importc, libprag.}

proc getFormat*(self: PixbufLoader): PixbufFormat =
  let impl0 = gdk_pixbuf_loader_get_format(cast[ptr PixbufLoader00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkPixbufFormat)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_pixbuf_format_get_type(), impl0))

proc format*(self: PixbufLoader): PixbufFormat =
  let impl0 = gdk_pixbuf_loader_get_format(cast[ptr PixbufLoader00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkPixbufFormat)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_pixbuf_format_get_type(), impl0))

proc gdk_pixbuf_loader_get_pixbuf(self: ptr PixbufLoader00): ptr Pixbuf00 {.
    importc, libprag.}

proc getPixbuf*(self: PixbufLoader): Pixbuf =
  let gobj = gdk_pixbuf_loader_get_pixbuf(cast[ptr PixbufLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: PixbufLoader): Pixbuf =
  let gobj = gdk_pixbuf_loader_get_pixbuf(cast[ptr PixbufLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_loader_set_size(self: ptr PixbufLoader00; width: int32; height: int32) {.
    importc, libprag.}

proc setSize*(self: PixbufLoader; width: int; height: int) =
  gdk_pixbuf_loader_set_size(cast[ptr PixbufLoader00](self.impl), int32(width), int32(height))

proc gdk_pixbuf_loader_write(self: ptr PixbufLoader00; buf: ptr uint8; count: uint64;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc write*(self: PixbufLoader; buf: seq[uint8] | string): bool =
  let count = uint64(buf.len)
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_loader_write(cast[ptr PixbufLoader00](self.impl), cast[ptr uint8](unsafeaddr(buf[0])), count, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_pixbuf_loader_write_bytes(self: ptr PixbufLoader00; buffer: ptr glib.Bytes00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc writeBytes*(self: PixbufLoader; buffer: glib.Bytes): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_loader_write_bytes(cast[ptr PixbufLoader00](self.impl), cast[ptr glib.Bytes00](buffer.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  PixbufSaveFunc* = proc (buf: ptr uint8; count: uint64; error: var ptr glib.Error; data: pointer): gboolean {.cdecl.}

proc gdk_pixbuf_save_to_callbackv(self: ptr Pixbuf00; saveFunc: PixbufSaveFunc;
    userData: pointer; `type`: cstring; optionKeys: ptr cstring; optionValues: ptr cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToCallbackv*(self: Pixbuf; saveFunc: PixbufSaveFunc;
    userData: pointer; `type`: cstring; optionKeys: openArray[string]; optionValues: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var gerror: ptr glib.Error
  let resul0 = gdk_pixbuf_save_to_callbackv(cast[ptr Pixbuf00](self.impl), saveFunc, userData, `type`, seq2CstringArray(optionKeys, fs469n23), seq2CstringArray(optionValues, fs469n232), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  PixbufSimpleAnim* = ref object of PixbufAnimation
  PixbufSimpleAnim00* = object of PixbufAnimation00

proc gdk_pixbuf_simple_anim_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PixbufSimpleAnim()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_pixbuf_simple_anim_new(width: int32; height: int32; rate: cfloat): ptr PixbufSimpleAnim00 {.
    importc, libprag.}

proc newPixbufSimpleAnim*(width: int; height: int; rate: cfloat): PixbufSimpleAnim =
  let gobj = gdk_pixbuf_simple_anim_new(int32(width), int32(height), rate)
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

proc newPixbufSimpleAnim*(tdesc: typedesc; width: int; height: int; rate: cfloat): tdesc =
  assert(result is PixbufSimpleAnim)
  let gobj = gdk_pixbuf_simple_anim_new(int32(width), int32(height), rate)
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

proc initPixbufSimpleAnim*[T](result: var T; width: int; height: int; rate: cfloat) {.deprecated.} =
  assert(result is PixbufSimpleAnim)
  let gobj = gdk_pixbuf_simple_anim_new(int32(width), int32(height), rate)
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

proc gdk_pixbuf_simple_anim_add_frame(self: ptr PixbufSimpleAnim00; pixbuf: ptr Pixbuf00) {.
    importc, libprag.}

proc addFrame*(self: PixbufSimpleAnim; pixbuf: Pixbuf) =
  gdk_pixbuf_simple_anim_add_frame(cast[ptr PixbufSimpleAnim00](self.impl), cast[ptr Pixbuf00](pixbuf.impl))

proc gdk_pixbuf_simple_anim_get_loop(self: ptr PixbufSimpleAnim00): gboolean {.
    importc, libprag.}

proc getLoop*(self: PixbufSimpleAnim): bool =
  toBool(gdk_pixbuf_simple_anim_get_loop(cast[ptr PixbufSimpleAnim00](self.impl)))

proc loop*(self: PixbufSimpleAnim): bool =
  toBool(gdk_pixbuf_simple_anim_get_loop(cast[ptr PixbufSimpleAnim00](self.impl)))

proc gdk_pixbuf_simple_anim_set_loop(self: ptr PixbufSimpleAnim00; loop: gboolean) {.
    importc, libprag.}

proc setLoop*(self: PixbufSimpleAnim; loop: bool = true) =
  gdk_pixbuf_simple_anim_set_loop(cast[ptr PixbufSimpleAnim00](self.impl), gboolean(loop))

proc `loop=`*(self: PixbufSimpleAnim; loop: bool) =
  gdk_pixbuf_simple_anim_set_loop(cast[ptr PixbufSimpleAnim00](self.impl), gboolean(loop))

type
  PixbufSimpleAnimIter* = ref object of PixbufAnimationIter
  PixbufSimpleAnimIter00* = object of PixbufAnimationIter00

proc gdk_pixbuf_simple_anim_iter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PixbufSimpleAnimIter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc icon*(x: gdkpixbuf.Pixbuf): gio.Icon = cast[gio.Icon](x)

proc loadableIcon*(x: gdkpixbuf.Pixbuf): gio.LoadableIcon = cast[gio.LoadableIcon](x)
