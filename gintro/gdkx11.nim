# dependencies:
# xlib-2.0
# GLib-2.0
# GdkPixbuf-2.0
# HarfBuzz-0.0
# GModule-2.0
# cairo-1.0
# GObject-2.0
# Pango-1.0
# Gio-2.0
# Gdk-3.0
# immediate dependencies:
# xlib-2.0
# Pango-1.0
# Gio-2.0
# GdkPixbuf-2.0
# Gdk-3.0
# libraries:
# libgdk-3.so.0
{.warning[UnusedImport]: off.}
import xlib, glib, gdkpixbuf, harfbuzz, gmodule, cairo, gobject, pango, gio, gdk
const Lib = "libgdk-3.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  X11AppLaunchContext* = ref object of gdk.AppLaunchContext
  X11AppLaunchContext00* = object of gdk.AppLaunchContext00

proc gdk_x11_app_launch_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11AppLaunchContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11Cursor* = ref object of gdk.Cursor
  X11Cursor00* = object of gdk.Cursor00

proc gdk_x11_cursor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Cursor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_cursor_get_xcursor(self: ptr X11Cursor00): uint64 {.
    importc, libprag.}

proc getXcursor*(self: X11Cursor): uint64 =
  gdk_x11_cursor_get_xcursor(cast[ptr X11Cursor00](self.impl))

proc xcursor*(self: X11Cursor): uint64 =
  gdk_x11_cursor_get_xcursor(cast[ptr X11Cursor00](self.impl))

proc gdk_x11_cursor_get_xdisplay(self: ptr X11Cursor00): ptr xlib.Display00 {.
    importc, libprag.}

proc getXdisplay*(self: X11Cursor): xlib.Display =
  new(result)
  result.impl = gdk_x11_cursor_get_xdisplay(cast[ptr X11Cursor00](self.impl))
  result.ignoreFinalizer = true

proc xdisplay*(self: X11Cursor): xlib.Display =
  new(result)
  result.impl = gdk_x11_cursor_get_xdisplay(cast[ptr X11Cursor00](self.impl))
  result.ignoreFinalizer = true

type
  X11DeviceCore* = ref object of gdk.Device
  X11DeviceCore00* = object of gdk.Device00

proc gdk_x11_device_core_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DeviceCore()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11DeviceManagerCore* = ref object of gdk.DeviceManager
  X11DeviceManagerCore00* = object of gdk.DeviceManager00

proc gdk_x11_device_manager_core_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DeviceManagerCore()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11DeviceManagerXI2* = ref object of X11DeviceManagerCore
  X11DeviceManagerXI200* = object of X11DeviceManagerCore00

proc gdk_x11_device_manager_xi2_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DeviceManagerXI2()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11DeviceXI2* = ref object of gdk.Device
  X11DeviceXI200* = object of gdk.Device00

proc gdk_x11_device_xi2_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DeviceXI2()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11Display* = ref object of gdk.Display
  X11Display00* = object of gdk.Display00

proc gdk_x11_display_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Display()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_display_get_glx_version(display: ptr gdk.Display00; major: var int32;
    minor: var int32): gboolean {.
    importc, libprag.}

proc getGlxVersion*(display: gdk.Display; major: var int;
    minor: var int): bool =
  var major_00: int32
  var minor_00: int32
  result = toBool(gdk_x11_display_get_glx_version(cast[ptr gdk.Display00](display.impl), major_00, minor_00))
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gdk_x11_display_error_trap_pop(self: ptr X11Display00): int32 {.
    importc, libprag.}

proc errorTrapPop*(self: X11Display): int =
  int(gdk_x11_display_error_trap_pop(cast[ptr X11Display00](self.impl)))

proc gdk_x11_display_error_trap_pop_ignored(self: ptr X11Display00) {.
    importc, libprag.}

proc errorTrapPopIgnored*(self: X11Display) =
  gdk_x11_display_error_trap_pop_ignored(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_error_trap_push(self: ptr X11Display00) {.
    importc, libprag.}

proc errorTrapPush*(self: X11Display) =
  gdk_x11_display_error_trap_push(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_get_startup_notification_id(self: ptr X11Display00): cstring {.
    importc, libprag.}

proc getStartupNotificationId*(self: X11Display): string =
  result = $gdk_x11_display_get_startup_notification_id(cast[ptr X11Display00](self.impl))

proc startupNotificationId*(self: X11Display): string =
  result = $gdk_x11_display_get_startup_notification_id(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_get_user_time(self: ptr X11Display00): uint32 {.
    importc, libprag.}

proc getUserTime*(self: X11Display): int =
  int(gdk_x11_display_get_user_time(cast[ptr X11Display00](self.impl)))

proc userTime*(self: X11Display): int =
  int(gdk_x11_display_get_user_time(cast[ptr X11Display00](self.impl)))

proc gdk_x11_display_get_xdisplay(self: ptr X11Display00): ptr xlib.Display00 {.
    importc, libprag.}

proc getXdisplay*(self: X11Display): xlib.Display =
  new(result)
  result.impl = gdk_x11_display_get_xdisplay(cast[ptr X11Display00](self.impl))
  result.ignoreFinalizer = true

proc xdisplay*(self: X11Display): xlib.Display =
  new(result)
  result.impl = gdk_x11_display_get_xdisplay(cast[ptr X11Display00](self.impl))
  result.ignoreFinalizer = true

proc gdk_x11_display_grab(self: ptr X11Display00) {.
    importc, libprag.}

proc grab*(self: X11Display) =
  gdk_x11_display_grab(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_set_cursor_theme(self: ptr X11Display00; theme: cstring;
    size: int32) {.
    importc, libprag.}

proc setCursorTheme*(self: X11Display; theme: cstring = nil;
    size: int) =
  gdk_x11_display_set_cursor_theme(cast[ptr X11Display00](self.impl), theme, int32(size))

proc gdk_x11_display_set_startup_notification_id(self: ptr X11Display00;
    startupId: cstring) {.
    importc, libprag.}

proc setStartupNotificationId*(self: X11Display; startupId: cstring) =
  gdk_x11_display_set_startup_notification_id(cast[ptr X11Display00](self.impl), startupId)

proc `startupNotificationId=`*(self: X11Display; startupId: cstring) =
  gdk_x11_display_set_startup_notification_id(cast[ptr X11Display00](self.impl), startupId)

proc gdk_x11_display_set_window_scale(self: ptr X11Display00; scale: int32) {.
    importc, libprag.}

proc setWindowScale*(self: X11Display; scale: int) =
  gdk_x11_display_set_window_scale(cast[ptr X11Display00](self.impl), int32(scale))

proc `windowScale=`*(self: X11Display; scale: int) =
  gdk_x11_display_set_window_scale(cast[ptr X11Display00](self.impl), int32(scale))

proc gdk_x11_display_string_to_compound_text(self: ptr X11Display00; str: cstring;
    encoding: var ptr gdk.Atom00; format: var int32; ctext: var ptr uint8;
    length: var int32): int32 {.
    importc, libprag.}

proc stringToCompoundText*(self: X11Display; str: cstring;
    encoding: var ptr gdk.Atom00; format: var int; ctext: var (seq[uint8] | string);
    length: var int): int =
  var length_00: int32
  var format_00: int32
  var ctext_00: ptr uint8
  result = int(gdk_x11_display_string_to_compound_text(cast[ptr X11Display00](self.impl), str, encoding, format_00, ctext_00, length_00))
  if length.addr != nil:
    length = int(length_00)
  if format.addr != nil:
    format = int(format_00)
  ctext.setLen(length)
  copyMem(unsafeaddr ctext[0], ctext_00, length.int * sizeof(ctext[0]))
  cogfree(ctext_00)

proc gdk_x11_display_text_property_to_text_list(self: ptr X11Display00; encoding: ptr gdk.Atom00;
    format: int32; text: ptr uint8; length: int32; list: cstring): int32 {.
    importc, libprag.}

proc textPropertyToTextList*(self: X11Display; encoding: gdk.Atom;
    format: int; text: ptr uint8; length: int; list: cstring): int =
  int(gdk_x11_display_text_property_to_text_list(cast[ptr X11Display00](self.impl), cast[ptr gdk.Atom00](encoding.impl), int32(format), text, int32(length), list))

proc gdk_x11_display_ungrab(self: ptr X11Display00) {.
    importc, libprag.}

proc ungrab*(self: X11Display) =
  gdk_x11_display_ungrab(cast[ptr X11Display00](self.impl))

proc gdk_x11_display_utf8_to_compound_text(self: ptr X11Display00; str: cstring;
    encoding: var ptr gdk.Atom00; format: var int32; ctext: var ptr uint8;
    length: var int32): gboolean {.
    importc, libprag.}

proc utf8ToCompoundText*(self: X11Display; str: cstring;
    encoding: var ptr gdk.Atom00; format: var int; ctext: var (seq[uint8] | string);
    length: var int): bool =
  var length_00: int32
  var format_00: int32
  var ctext_00: ptr uint8
  result = toBool(gdk_x11_display_utf8_to_compound_text(cast[ptr X11Display00](self.impl), str, encoding, format_00, ctext_00, length_00))
  if length.addr != nil:
    length = int(length_00)
  if format.addr != nil:
    format = int(format_00)
  ctext.setLen(length)
  copyMem(unsafeaddr ctext[0], ctext_00, length.int * sizeof(ctext[0]))
  cogfree(ctext_00)

type
  X11DisplayManager* = ref object of gdk.DisplayManager
  X11DisplayManager00* = object of gdk.DisplayManager00

proc gdk_x11_display_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DisplayManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11DragContext* = ref object of gdk.DragContext
  X11DragContext00* = object of gdk.DragContext00

proc gdk_x11_drag_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11DragContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11GLContext* = ref object of gdk.GLContext
  X11GLContext00* = object of gdk.GLContext00

proc gdk_x11_gl_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11GLContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  X11Keymap* = ref object of gdk.Keymap
  X11Keymap00* = object of gdk.Keymap00

proc gdk_x11_keymap_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Keymap()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_keymap_get_group_for_state(self: ptr X11Keymap00; state: uint32): int32 {.
    importc, libprag.}

proc getGroupForState*(self: X11Keymap; state: int): int =
  int(gdk_x11_keymap_get_group_for_state(cast[ptr X11Keymap00](self.impl), uint32(state)))

proc gdk_x11_keymap_key_is_modifier(self: ptr X11Keymap00; keycode: uint32): gboolean {.
    importc, libprag.}

proc keyIsModifier*(self: X11Keymap; keycode: int): bool =
  toBool(gdk_x11_keymap_key_is_modifier(cast[ptr X11Keymap00](self.impl), uint32(keycode)))

type
  X11Monitor* = ref object of gdk.Monitor
  X11Monitor00* = object of gdk.Monitor00

proc gdk_x11_monitor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Monitor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_monitor_get_output(monitor: ptr gdk.Monitor00): uint64 {.
    importc, libprag.}

proc getOutput*(monitor: gdk.Monitor): uint64 =
  gdk_x11_monitor_get_output(cast[ptr gdk.Monitor00](monitor.impl))

proc output*(monitor: gdk.Monitor): uint64 =
  gdk_x11_monitor_get_output(cast[ptr gdk.Monitor00](monitor.impl))

type
  X11Screen* = ref object of gdk.Screen
  X11Screen00* = object of gdk.Screen00

proc gdk_x11_screen_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Screen()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scWindowManagerChanged*(self: X11Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "window-manager-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_x11_screen_get_current_desktop(self: ptr X11Screen00): uint32 {.
    importc, libprag.}

proc getCurrentDesktop*(self: X11Screen): int =
  int(gdk_x11_screen_get_current_desktop(cast[ptr X11Screen00](self.impl)))

proc currentDesktop*(self: X11Screen): int =
  int(gdk_x11_screen_get_current_desktop(cast[ptr X11Screen00](self.impl)))

proc gdk_x11_screen_get_monitor_output(self: ptr X11Screen00; monitorNum: int32): uint64 {.
    importc, libprag.}

proc getMonitorOutput*(self: X11Screen; monitorNum: int): uint64 =
  gdk_x11_screen_get_monitor_output(cast[ptr X11Screen00](self.impl), int32(monitorNum))

proc gdk_x11_screen_get_number_of_desktops(self: ptr X11Screen00): uint32 {.
    importc, libprag.}

proc getNumberOfDesktops*(self: X11Screen): int =
  int(gdk_x11_screen_get_number_of_desktops(cast[ptr X11Screen00](self.impl)))

proc numberOfDesktops*(self: X11Screen): int =
  int(gdk_x11_screen_get_number_of_desktops(cast[ptr X11Screen00](self.impl)))

proc gdk_x11_screen_get_screen_number(self: ptr X11Screen00): int32 {.
    importc, libprag.}

proc getScreenNumber*(self: X11Screen): int =
  int(gdk_x11_screen_get_screen_number(cast[ptr X11Screen00](self.impl)))

proc screenNumber*(self: X11Screen): int =
  int(gdk_x11_screen_get_screen_number(cast[ptr X11Screen00](self.impl)))

proc gdk_x11_screen_get_window_manager_name(self: ptr X11Screen00): cstring {.
    importc, libprag.}

proc getWindowManagerName*(self: X11Screen): string =
  result = $gdk_x11_screen_get_window_manager_name(cast[ptr X11Screen00](self.impl))

proc windowManagerName*(self: X11Screen): string =
  result = $gdk_x11_screen_get_window_manager_name(cast[ptr X11Screen00](self.impl))

proc gdk_x11_screen_get_xscreen(self: ptr X11Screen00): ptr xlib.Screen00 {.
    importc, libprag.}

proc getXscreen*(self: X11Screen): xlib.Screen =
  new(result)
  result.impl = gdk_x11_screen_get_xscreen(cast[ptr X11Screen00](self.impl))
  result.ignoreFinalizer = true

proc xscreen*(self: X11Screen): xlib.Screen =
  new(result)
  result.impl = gdk_x11_screen_get_xscreen(cast[ptr X11Screen00](self.impl))
  result.ignoreFinalizer = true

proc gdk_x11_screen_supports_net_wm_hint(self: ptr X11Screen00; property: ptr gdk.Atom00): gboolean {.
    importc, libprag.}

proc supportsNetWmHint*(self: X11Screen; property: gdk.Atom): bool =
  toBool(gdk_x11_screen_supports_net_wm_hint(cast[ptr X11Screen00](self.impl), cast[ptr gdk.Atom00](property.impl)))

type
  X11Visual* = ref object of gdk.Visual
  X11Visual00* = object of gdk.Visual00

proc gdk_x11_visual_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Visual()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_visual_get_xvisual(self: ptr X11Visual00): ptr xlib.Visual00 {.
    importc, libprag.}

proc getXvisual*(self: X11Visual): xlib.Visual =
  new(result)
  result.impl = gdk_x11_visual_get_xvisual(cast[ptr X11Visual00](self.impl))
  result.ignoreFinalizer = true

proc xvisual*(self: X11Visual): xlib.Visual =
  new(result)
  result.impl = gdk_x11_visual_get_xvisual(cast[ptr X11Visual00](self.impl))
  result.ignoreFinalizer = true

proc gdk_x11_screen_lookup_visual(self: ptr X11Screen00; xvisualid: uint64): ptr X11Visual00 {.
    importc, libprag.}

proc lookupVisual*(self: X11Screen; xvisualid: uint64): X11Visual =
  let gobj = gdk_x11_screen_lookup_visual(cast[ptr X11Screen00](self.impl), xvisualid)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx11.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  X11Window* = ref object of gdk.Window
  X11Window00* = object of gdk.Window00

proc gdk_x11_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(X11Window()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_x11_window_foreign_new_for_display(display: ptr X11Display00; window: uint64): ptr X11Window00 {.
    importc, libprag.}

proc foreignNewForDisplay*(display: X11Display; window: uint64): X11Window =
  let gobj = gdk_x11_window_foreign_new_for_display(cast[ptr X11Display00](display.impl), window)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc foreignNewForDisplay*(tdesc: typedesc; display: X11Display; window: uint64): tdesc =
  assert(result is X11Window)
  let gobj = gdk_x11_window_foreign_new_for_display(cast[ptr X11Display00](display.impl), window)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc foreignNewForDisplay*[T](result: var T; display: X11Display; window: uint64) {.deprecated.} =
  assert(result is X11Window)
  let gobj = gdk_x11_window_foreign_new_for_display(cast[ptr X11Display00](display.impl), window)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_window_lookup_for_display(display: ptr X11Display00; window: uint64): ptr X11Window00 {.
    importc, libprag.}

proc lookupForDisplay*(display: X11Display; window: uint64): X11Window =
  let gobj = gdk_x11_window_lookup_for_display(cast[ptr X11Display00](display.impl), window)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx11.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_window_get_desktop(self: ptr X11Window00): uint32 {.
    importc, libprag.}

proc getDesktop*(self: X11Window): int =
  int(gdk_x11_window_get_desktop(cast[ptr X11Window00](self.impl)))

proc desktop*(self: X11Window): int =
  int(gdk_x11_window_get_desktop(cast[ptr X11Window00](self.impl)))

proc gdk_x11_window_get_xid(self: ptr X11Window00): uint64 {.
    importc, libprag.}

proc getXid*(self: X11Window): uint64 =
  gdk_x11_window_get_xid(cast[ptr X11Window00](self.impl))

proc xid*(self: X11Window): uint64 =
  gdk_x11_window_get_xid(cast[ptr X11Window00](self.impl))

proc gdk_x11_window_move_to_current_desktop(self: ptr X11Window00) {.
    importc, libprag.}

proc moveToCurrentDesktop*(self: X11Window) =
  gdk_x11_window_move_to_current_desktop(cast[ptr X11Window00](self.impl))

proc gdk_x11_window_move_to_desktop(self: ptr X11Window00; desktop: uint32) {.
    importc, libprag.}

proc moveToDesktop*(self: X11Window; desktop: int) =
  gdk_x11_window_move_to_desktop(cast[ptr X11Window00](self.impl), uint32(desktop))

proc gdk_x11_window_set_frame_extents(self: ptr X11Window00; left: int32;
    right: int32; top: int32; bottom: int32) {.
    importc, libprag.}

proc setFrameExtents*(self: X11Window; left: int; right: int;
    top: int; bottom: int) =
  gdk_x11_window_set_frame_extents(cast[ptr X11Window00](self.impl), int32(left), int32(right), int32(top), int32(bottom))

proc gdk_x11_window_set_frame_sync_enabled(self: ptr X11Window00; frameSyncEnabled: gboolean) {.
    importc, libprag.}

proc setFrameSyncEnabled*(self: X11Window; frameSyncEnabled: bool = true) =
  gdk_x11_window_set_frame_sync_enabled(cast[ptr X11Window00](self.impl), gboolean(frameSyncEnabled))

proc `frameSyncEnabled=`*(self: X11Window; frameSyncEnabled: bool) =
  gdk_x11_window_set_frame_sync_enabled(cast[ptr X11Window00](self.impl), gboolean(frameSyncEnabled))

proc gdk_x11_window_set_hide_titlebar_when_maximized(self: ptr X11Window00;
    hideTitlebarWhenMaximized: gboolean) {.
    importc, libprag.}

proc setHideTitlebarWhenMaximized*(self: X11Window; hideTitlebarWhenMaximized: bool = true) =
  gdk_x11_window_set_hide_titlebar_when_maximized(cast[ptr X11Window00](self.impl), gboolean(hideTitlebarWhenMaximized))

proc `hideTitlebarWhenMaximized=`*(self: X11Window; hideTitlebarWhenMaximized: bool) =
  gdk_x11_window_set_hide_titlebar_when_maximized(cast[ptr X11Window00](self.impl), gboolean(hideTitlebarWhenMaximized))

proc gdk_x11_window_set_theme_variant(self: ptr X11Window00; variant: cstring) {.
    importc, libprag.}

proc setThemeVariant*(self: X11Window; variant: cstring) =
  gdk_x11_window_set_theme_variant(cast[ptr X11Window00](self.impl), variant)

proc `themeVariant=`*(self: X11Window; variant: cstring) =
  gdk_x11_window_set_theme_variant(cast[ptr X11Window00](self.impl), variant)

proc gdk_x11_window_set_user_time(self: ptr X11Window00; timestamp: uint32) {.
    importc, libprag.}

proc setUserTime*(self: X11Window; timestamp: int) =
  gdk_x11_window_set_user_time(cast[ptr X11Window00](self.impl), uint32(timestamp))

proc `userTime=`*(self: X11Window; timestamp: int) =
  gdk_x11_window_set_user_time(cast[ptr X11Window00](self.impl), uint32(timestamp))

proc gdk_x11_window_set_utf8_property(self: ptr X11Window00; name: cstring;
    value: cstring) {.
    importc, libprag.}

proc setUtf8Property*(self: X11Window; name: cstring; value: cstring = nil) =
  gdk_x11_window_set_utf8_property(cast[ptr X11Window00](self.impl), name, value)

proc gdk_x11_atom_to_xatom(atom: ptr gdk.Atom00): uint64 {.
    importc, libprag.}

proc x11AtomToXatom*(atom: gdk.Atom): uint64 =
  gdk_x11_atom_to_xatom(cast[ptr gdk.Atom00](atom.impl))

proc gdk_x11_atom_to_xatom_for_display(display: ptr X11Display00; atom: ptr gdk.Atom00): uint64 {.
    importc, libprag.}

proc x11AtomToXatomForDisplay*(display: X11Display; atom: gdk.Atom): uint64 =
  gdk_x11_atom_to_xatom_for_display(cast[ptr X11Display00](display.impl), cast[ptr gdk.Atom00](atom.impl))

proc gdk_x11_device_get_id(device: ptr X11DeviceCore00): int32 {.
    importc, libprag.}

proc x11DeviceGetId*(device: X11DeviceCore): int =
  int(gdk_x11_device_get_id(cast[ptr X11DeviceCore00](device.impl)))

proc gdk_x11_device_manager_lookup(deviceManager: ptr X11DeviceManagerCore00;
    deviceId: int32): ptr X11DeviceCore00 {.
    importc, libprag.}

proc x11DeviceManagerLookup*(deviceManager: X11DeviceManagerCore; deviceId: int): X11DeviceCore =
  let gobj = gdk_x11_device_manager_lookup(cast[ptr X11DeviceManagerCore00](deviceManager.impl), int32(deviceId))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx11.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc x11FreeCompoundText*(ctext: ptr uint8) {.
    importc: "gdk_x11_free_compound_text", libprag.}

proc x11FreeTextList*(list: cstring) {.
    importc: "gdk_x11_free_text_list", libprag.}

proc x11GetDefaultRootXwindow*(): uint64 {.
    importc: "gdk_x11_get_default_root_xwindow", libprag.}

proc gdk_x11_get_default_screen(): int32 {.
    importc, libprag.}

proc x11GetDefaultScreen*(): int =
  int(gdk_x11_get_default_screen())

proc gdk_x11_get_default_xdisplay(): ptr xlib.Display00 {.
    importc, libprag.}

proc x11GetDefaultXdisplay*(): xlib.Display =
  new(result)
  result.impl = gdk_x11_get_default_xdisplay()
  result.ignoreFinalizer = true

proc gdk_x11_get_parent_relative_pattern(): ptr cairo.Pattern00 {.
    importc, libprag.}

proc x11GetParentRelativePattern*(): cairo.Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = gdk_x11_get_parent_relative_pattern()

proc gdk_x11_get_server_time(window: ptr X11Window00): uint32 {.
    importc, libprag.}

proc x11GetServerTime*(window: X11Window): int =
  int(gdk_x11_get_server_time(cast[ptr X11Window00](window.impl)))

proc x11GetXatomByName*(atomName: cstring): uint64 {.
    importc: "gdk_x11_get_xatom_by_name", libprag.}

proc gdk_x11_get_xatom_by_name_for_display(display: ptr X11Display00; atomName: cstring): uint64 {.
    importc, libprag.}

proc x11GetXatomByNameForDisplay*(display: X11Display; atomName: cstring): uint64 =
  gdk_x11_get_xatom_by_name_for_display(cast[ptr X11Display00](display.impl), atomName)

proc gdk_x11_get_xatom_name(xatom: uint64): cstring {.
    importc, libprag.}

proc x11GetXatomName*(xatom: uint64): string =
  result = $gdk_x11_get_xatom_name(xatom)

proc gdk_x11_get_xatom_name_for_display(display: ptr X11Display00; xatom: uint64): cstring {.
    importc, libprag.}

proc x11GetXatomNameForDisplay*(display: X11Display; xatom: uint64): string =
  result = $gdk_x11_get_xatom_name_for_display(cast[ptr X11Display00](display.impl), xatom)

proc x11GrabServer*() {.
    importc: "gdk_x11_grab_server", libprag.}

proc gdk_x11_lookup_xdisplay(xdisplay: ptr xlib.Display00): ptr X11Display00 {.
    importc, libprag.}

proc x11LookupXdisplay*(xdisplay: xlib.Display): X11Display =
  let gobj = gdk_x11_lookup_xdisplay(cast[ptr xlib.Display00](xdisplay.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkx11.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_x11_register_standard_event_type(display: ptr X11Display00; eventBase: int32;
    nEvents: int32) {.
    importc, libprag.}

proc x11RegisterStandardEventType*(display: X11Display; eventBase: int;
    nEvents: int) =
  gdk_x11_register_standard_event_type(cast[ptr X11Display00](display.impl), int32(eventBase), int32(nEvents))

proc x11SetSmClientId*(smClientId: cstring) {.
    importc: "gdk_x11_set_sm_client_id", libprag.}

proc x11UngrabServer*() {.
    importc: "gdk_x11_ungrab_server", libprag.}

proc gdk_x11_xatom_to_atom(xatom: uint64): ptr gdk.Atom00 {.
    importc, libprag.}

proc x11XatomToAtom*(xatom: uint64): gdk.Atom =
  new(result)
  result.impl = gdk_x11_xatom_to_atom(xatom)
  result.ignoreFinalizer = true

proc gdk_x11_xatom_to_atom_for_display(display: ptr X11Display00; xatom: uint64): ptr gdk.Atom00 {.
    importc, libprag.}

proc x11XatomToAtomForDisplay*(display: X11Display; xatom: uint64): gdk.Atom =
  new(result)
  result.impl = gdk_x11_xatom_to_atom_for_display(cast[ptr X11Display00](display.impl), xatom)
  result.ignoreFinalizer = true
# === remaining symbols:
