# dependencies:
# GObject-2.0
# GdkPixbuf-2.0
# Gio-2.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# GdkPixbuf-2.0
# GLib-2.0
# libraries:
# libnotify.so.4
{.warning[UnusedImport]: off.}
import gobject, gdkpixbuf, gio, glib, gmodule
const Lib = "libnotify.so.4"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Notification* = ref object of gobject.Object
  Notification00* = object of gobject.Object00

proc notify_notification_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Notification()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClosed*(self: Notification;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc notify_notification_new(summary: cstring; body: cstring; icon: cstring): ptr Notification00 {.
    importc, libprag.}

proc newNotification*(summary: cstring; body: cstring = nil; icon: cstring = nil): Notification =
  let gobj = notify_notification_new(summary, body, icon)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, notify.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNotification*(tdesc: typedesc; summary: cstring; body: cstring = nil; icon: cstring = nil): tdesc =
  assert(result is Notification)
  let gobj = notify_notification_new(summary, body, icon)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, notify.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNotification*[T](result: var T; summary: cstring; body: cstring = nil; icon: cstring = nil) {.deprecated.} =
  assert(result is Notification)
  let gobj = notify_notification_new(summary, body, icon)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, notify.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc notify_notification_clear_actions(self: ptr Notification00) {.
    importc, libprag.}

proc clearActions*(self: Notification) =
  notify_notification_clear_actions(cast[ptr Notification00](self.impl))

proc notify_notification_clear_hints(self: ptr Notification00) {.
    importc, libprag.}

proc clearHints*(self: Notification) =
  notify_notification_clear_hints(cast[ptr Notification00](self.impl))

proc notify_notification_close(self: ptr Notification00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc close*(self: Notification): bool =
  var gerror: ptr glib.Error
  let resul0 = notify_notification_close(cast[ptr Notification00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc notify_notification_get_closed_reason(self: ptr Notification00): int32 {.
    importc, libprag.}

proc getClosedReason*(self: Notification): int =
  int(notify_notification_get_closed_reason(cast[ptr Notification00](self.impl)))

proc closedReason*(self: Notification): int =
  int(notify_notification_get_closed_reason(cast[ptr Notification00](self.impl)))

proc notify_notification_set_app_name(self: ptr Notification00; appName: cstring) {.
    importc, libprag.}

proc setAppName*(self: Notification; appName: cstring) =
  notify_notification_set_app_name(cast[ptr Notification00](self.impl), appName)

proc `appName=`*(self: Notification; appName: cstring) =
  notify_notification_set_app_name(cast[ptr Notification00](self.impl), appName)

proc notify_notification_set_category(self: ptr Notification00; category: cstring) {.
    importc, libprag.}

proc setCategory*(self: Notification; category: cstring) =
  notify_notification_set_category(cast[ptr Notification00](self.impl), category)

proc `category=`*(self: Notification; category: cstring) =
  notify_notification_set_category(cast[ptr Notification00](self.impl), category)

proc notify_notification_set_hint(self: ptr Notification00; key: cstring;
    value: ptr glib.Variant00) {.
    importc, libprag.}

proc setHint*(self: Notification; key: cstring; value: glib.Variant = nil) =
  notify_notification_set_hint(cast[ptr Notification00](self.impl), key, if value.isNil: nil else: cast[ptr glib.Variant00](value.impl))

proc notify_notification_set_hint_byte(self: ptr Notification00; key: cstring;
    value: uint8) {.
    importc, libprag.}

proc setHintByte*(self: Notification; key: cstring;
    value: uint8) =
  notify_notification_set_hint_byte(cast[ptr Notification00](self.impl), key, value)

proc notify_notification_set_hint_byte_array(self: ptr Notification00; key: cstring;
    value: ptr uint8; len: uint64) {.
    importc, libprag.}

proc setHintByteArray*(self: Notification; key: cstring;
    value: seq[uint8] | string) =
  let len = uint64(value.len)
  notify_notification_set_hint_byte_array(cast[ptr Notification00](self.impl), key, cast[ptr uint8](unsafeaddr(value[0])), len)

proc notify_notification_set_hint_double(self: ptr Notification00; key: cstring;
    value: cdouble) {.
    importc, libprag.}

proc setHintDouble*(self: Notification; key: cstring;
    value: cdouble) =
  notify_notification_set_hint_double(cast[ptr Notification00](self.impl), key, value)

proc notify_notification_set_hint_int32(self: ptr Notification00; key: cstring;
    value: int32) {.
    importc, libprag.}

proc setHintInt32*(self: Notification; key: cstring;
    value: int) =
  notify_notification_set_hint_int32(cast[ptr Notification00](self.impl), key, int32(value))

proc notify_notification_set_hint_string(self: ptr Notification00; key: cstring;
    value: cstring) {.
    importc, libprag.}

proc setHintString*(self: Notification; key: cstring;
    value: cstring) =
  notify_notification_set_hint_string(cast[ptr Notification00](self.impl), key, value)

proc notify_notification_set_hint_uint32(self: ptr Notification00; key: cstring;
    value: uint32) {.
    importc, libprag.}

proc setHintUint32*(self: Notification; key: cstring;
    value: int) =
  notify_notification_set_hint_uint32(cast[ptr Notification00](self.impl), key, uint32(value))

proc notify_notification_set_icon_from_pixbuf(self: ptr Notification00; icon: ptr gdkpixbuf.Pixbuf00) {.
    importc, libprag.}

proc setIconFromPixbuf*(self: Notification; icon: gdkpixbuf.Pixbuf) =
  notify_notification_set_icon_from_pixbuf(cast[ptr Notification00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](icon.impl))

proc `iconFromPixbuf=`*(self: Notification; icon: gdkpixbuf.Pixbuf) =
  notify_notification_set_icon_from_pixbuf(cast[ptr Notification00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](icon.impl))

proc notify_notification_set_image_from_pixbuf(self: ptr Notification00;
    pixbuf: ptr gdkpixbuf.Pixbuf00) {.
    importc, libprag.}

proc setImageFromPixbuf*(self: Notification; pixbuf: gdkpixbuf.Pixbuf) =
  notify_notification_set_image_from_pixbuf(cast[ptr Notification00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc `imageFromPixbuf=`*(self: Notification; pixbuf: gdkpixbuf.Pixbuf) =
  notify_notification_set_image_from_pixbuf(cast[ptr Notification00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc notify_notification_set_timeout(self: ptr Notification00; timeout: int32) {.
    importc, libprag.}

proc setTimeout*(self: Notification; timeout: int) =
  notify_notification_set_timeout(cast[ptr Notification00](self.impl), int32(timeout))

proc `timeout=`*(self: Notification; timeout: int) =
  notify_notification_set_timeout(cast[ptr Notification00](self.impl), int32(timeout))

proc notify_notification_show(self: ptr Notification00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc show*(self: Notification): bool =
  var gerror: ptr glib.Error
  let resul0 = notify_notification_show(cast[ptr Notification00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc notify_notification_update(self: ptr Notification00; summary: cstring;
    body: cstring; icon: cstring): gboolean {.
    importc, libprag.}

proc update*(self: Notification; summary: cstring; body: cstring = nil;
    icon: cstring = nil): bool =
  toBool(notify_notification_update(cast[ptr Notification00](self.impl), summary, body, icon))

type
  ActionCallback* = proc (notification: ptr Notification00; action: cstring; userData: pointer) {.cdecl.}

proc notify_notification_add_action(self: ptr Notification00; action: cstring;
    label: cstring; callback: ActionCallback; userData: pointer; freeFunc: DestroyNotify) {.
    importc, libprag.}

proc addAction*(self: Notification; action: cstring;
    label: cstring; callback: ActionCallback; userData: pointer; freeFunc: DestroyNotify) =
  notify_notification_add_action(cast[ptr Notification00](self.impl), action, label, callback, userData, freeFunc)

type
  Urgency* {.size: sizeof(cint), pure.} = enum
    low = 0
    normal = 1
    critical = 2

proc notify_notification_set_urgency(self: ptr Notification00; urgency: Urgency) {.
    importc, libprag.}

proc setUrgency*(self: Notification; urgency: Urgency) =
  notify_notification_set_urgency(cast[ptr Notification00](self.impl), urgency)

proc `urgency=`*(self: Notification; urgency: Urgency) =
  notify_notification_set_urgency(cast[ptr Notification00](self.impl), urgency)

const EXPIRES_DEFAULT* = -1'i32

const EXPIRES_NEVER* = 0'i32

const VERSION_MAJOR* = 0'i32

const VERSION_MICRO* = 9'i32

const VERSION_MINOR* = 7'i32

proc notify_get_app_name(): cstring {.
    importc, libprag.}

proc getAppName*(): string =
  result = $notify_get_app_name()

proc notify_get_server_caps(): ptr glib.List {.
    importc, libprag.}

proc getServerCaps*(): seq[cstring] =
  let resul0 = notify_get_server_caps()
  g_list_free(resul0)

proc notify_get_server_info(retName: var cstring; retVendor: var cstring;
    retVersion: var cstring; retSpecVersion: var cstring): gboolean {.
    importc, libprag.}

proc getServerInfo*(retName: var string = cast[var string](nil);
    retVendor: var string = cast[var string](nil); retVersion: var string = cast[var string](nil);
    retSpecVersion: var string = cast[var string](nil)): bool =
  var retVersion_00: cstring
  var retName_00: cstring
  var retVendor_00: cstring
  var retSpecVersion_00: cstring
  result = toBool(notify_get_server_info(retName_00, retVendor_00, retVersion_00, retSpecVersion_00))
  if retVersion.addr != nil:
    retVersion = $(retVersion_00)
  if retName.addr != nil:
    retName = $(retName_00)
  if retVendor.addr != nil:
    retVendor = $(retVendor_00)
  if retSpecVersion.addr != nil:
    retSpecVersion = $(retSpecVersion_00)

proc notify_init(appName: cstring): gboolean {.
    importc, libprag.}

proc init*(appName: cstring): bool =
  toBool(notify_init(appName))

proc notify_is_initted(): gboolean {.
    importc, libprag.}

proc isInitted*(): bool =
  toBool(notify_is_initted())

proc setAppName*(appName: cstring) {.
    importc: "notify_set_app_name", libprag.}

proc uninit*() {.
    importc: "notify_uninit", libprag.}
# === remaining symbols:
