# dependencies:
# GdkPixbuf-2.0
# GLib-2.0
# HarfBuzz-0.0
# GModule-2.0
# cairo-1.0
# GObject-2.0
# Pango-1.0
# Gio-2.0
# immediate dependencies:
# cairo-1.0
# Pango-1.0
# Gio-2.0
# GdkPixbuf-2.0
# libraries:
# libgdk-3.so.0
{.warning[UnusedImport]: off.}
import gdkpixbuf, glib, harfbuzz, gmodule, cairo, gobject, pango, gio
const Lib = "libgdk-3.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  AnchorHints* {.size: sizeof(cint), pure.} = enum
    flipX = 1
    flipY = 2
    flip = 3
    slideX = 4
    slideY = 8
    slide = 12
    resizeX = 16
    resizeY = 32
    resize = 48

type
  AppLaunchContext* = ref object of gio.AppLaunchContext
  AppLaunchContext00* = object of gio.AppLaunchContext00

proc gdk_app_launch_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AppLaunchContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_app_launch_context_new(): ptr AppLaunchContext00 {.
    importc, libprag.}

proc newAppLaunchContext*(): AppLaunchContext {.deprecated.}  =
  let gobj = gdk_app_launch_context_new()
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

proc newAppLaunchContext*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is AppLaunchContext)
  let gobj = gdk_app_launch_context_new()
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

proc initAppLaunchContext*[T](result: var T) {.deprecated.} =
  assert(result is AppLaunchContext)
  let gobj = gdk_app_launch_context_new()
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

proc gdk_app_launch_context_set_desktop(self: ptr AppLaunchContext00; desktop: int32) {.
    importc, libprag.}

proc setDesktop*(self: AppLaunchContext; desktop: int) =
  gdk_app_launch_context_set_desktop(cast[ptr AppLaunchContext00](self.impl), int32(desktop))

proc `desktop=`*(self: AppLaunchContext; desktop: int) =
  gdk_app_launch_context_set_desktop(cast[ptr AppLaunchContext00](self.impl), int32(desktop))

proc gdk_app_launch_context_set_icon(self: ptr AppLaunchContext00; icon: ptr gio.Icon00) {.
    importc, libprag.}

proc setIcon*(self: AppLaunchContext; icon: gio.Icon = nil) =
  gdk_app_launch_context_set_icon(cast[ptr AppLaunchContext00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc `icon=`*(self: AppLaunchContext; icon: gio.Icon = nil) =
  gdk_app_launch_context_set_icon(cast[ptr AppLaunchContext00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc gdk_app_launch_context_set_icon_name(self: ptr AppLaunchContext00; iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: AppLaunchContext; iconName: cstring = nil) =
  gdk_app_launch_context_set_icon_name(cast[ptr AppLaunchContext00](self.impl), iconName)

proc `iconName=`*(self: AppLaunchContext; iconName: cstring = nil) =
  gdk_app_launch_context_set_icon_name(cast[ptr AppLaunchContext00](self.impl), iconName)

proc gdk_app_launch_context_set_timestamp(self: ptr AppLaunchContext00; timestamp: uint32) {.
    importc, libprag.}

proc setTimestamp*(self: AppLaunchContext; timestamp: int) =
  gdk_app_launch_context_set_timestamp(cast[ptr AppLaunchContext00](self.impl), uint32(timestamp))

proc `timestamp=`*(self: AppLaunchContext; timestamp: int) =
  gdk_app_launch_context_set_timestamp(cast[ptr AppLaunchContext00](self.impl), uint32(timestamp))

type
  Monitor* = ref object of gobject.Object
  Monitor00* = object of gobject.Object00

proc gdk_monitor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Monitor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scInvalidate*(self: Monitor;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "invalidate", cast[GCallback](p), xdata, nil, cf)

proc gdk_monitor_get_height_mm(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getHeightMm*(self: Monitor): int =
  int(gdk_monitor_get_height_mm(cast[ptr Monitor00](self.impl)))

proc heightMm*(self: Monitor): int =
  int(gdk_monitor_get_height_mm(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_manufacturer(self: ptr Monitor00): cstring {.
    importc, libprag.}

proc getManufacturer*(self: Monitor): string =
  let resul0 = gdk_monitor_get_manufacturer(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc manufacturer*(self: Monitor): string =
  let resul0 = gdk_monitor_get_manufacturer(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_monitor_get_model(self: ptr Monitor00): cstring {.
    importc, libprag.}

proc getModel*(self: Monitor): string =
  let resul0 = gdk_monitor_get_model(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc model*(self: Monitor): string =
  let resul0 = gdk_monitor_get_model(cast[ptr Monitor00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_monitor_get_refresh_rate(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getRefreshRate*(self: Monitor): int =
  int(gdk_monitor_get_refresh_rate(cast[ptr Monitor00](self.impl)))

proc refreshRate*(self: Monitor): int =
  int(gdk_monitor_get_refresh_rate(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_scale_factor(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getScaleFactor*(self: Monitor): int =
  int(gdk_monitor_get_scale_factor(cast[ptr Monitor00](self.impl)))

proc scaleFactor*(self: Monitor): int =
  int(gdk_monitor_get_scale_factor(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_width_mm(self: ptr Monitor00): int32 {.
    importc, libprag.}

proc getWidthMm*(self: Monitor): int =
  int(gdk_monitor_get_width_mm(cast[ptr Monitor00](self.impl)))

proc widthMm*(self: Monitor): int =
  int(gdk_monitor_get_width_mm(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_is_primary(self: ptr Monitor00): gboolean {.
    importc, libprag.}

proc isPrimary*(self: Monitor): bool =
  toBool(gdk_monitor_is_primary(cast[ptr Monitor00](self.impl)))

type
  DeviceTool* = ref object of gobject.Object
  DeviceTool00* = object of gobject.Object00

proc gdk_device_tool_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceTool()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_device_tool_get_hardware_id(self: ptr DeviceTool00): uint64 {.
    importc, libprag.}

proc getHardwareId*(self: DeviceTool): uint64 =
  gdk_device_tool_get_hardware_id(cast[ptr DeviceTool00](self.impl))

proc hardwareId*(self: DeviceTool): uint64 =
  gdk_device_tool_get_hardware_id(cast[ptr DeviceTool00](self.impl))

proc gdk_device_tool_get_serial(self: ptr DeviceTool00): uint64 {.
    importc, libprag.}

proc getSerial*(self: DeviceTool): uint64 =
  gdk_device_tool_get_serial(cast[ptr DeviceTool00](self.impl))

proc serial*(self: DeviceTool): uint64 =
  gdk_device_tool_get_serial(cast[ptr DeviceTool00](self.impl))

type
  Device* = ref object of gobject.Object
  Device00* = object of gobject.Object00

proc gdk_device_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Device()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: Device;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc scToolChanged*(self: Device;  p: proc (self: ptr Device00; tool: ptr DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "tool-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_device_get_associated_device(self: ptr Device00): ptr Device00 {.
    importc, libprag.}

proc getAssociatedDevice*(self: Device): Device =
  let gobj = gdk_device_get_associated_device(cast[ptr Device00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc associatedDevice*(self: Device): Device =
  let gobj = gdk_device_get_associated_device(cast[ptr Device00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_device_get_has_cursor(self: ptr Device00): gboolean {.
    importc, libprag.}

proc getHasCursor*(self: Device): bool =
  toBool(gdk_device_get_has_cursor(cast[ptr Device00](self.impl)))

proc hasCursor*(self: Device): bool =
  toBool(gdk_device_get_has_cursor(cast[ptr Device00](self.impl)))

proc gdk_device_get_n_axes(self: ptr Device00): int32 {.
    importc, libprag.}

proc getNAxes*(self: Device): int =
  int(gdk_device_get_n_axes(cast[ptr Device00](self.impl)))

proc nAxes*(self: Device): int =
  int(gdk_device_get_n_axes(cast[ptr Device00](self.impl)))

proc gdk_device_get_n_keys(self: ptr Device00): int32 {.
    importc, libprag.}

proc getNKeys*(self: Device): int =
  int(gdk_device_get_n_keys(cast[ptr Device00](self.impl)))

proc nKeys*(self: Device): int =
  int(gdk_device_get_n_keys(cast[ptr Device00](self.impl)))

proc gdk_device_get_name(self: ptr Device00): cstring {.
    importc, libprag.}

proc getName*(self: Device): string =
  result = $gdk_device_get_name(cast[ptr Device00](self.impl))

proc name*(self: Device): string =
  result = $gdk_device_get_name(cast[ptr Device00](self.impl))

proc gdk_device_get_product_id(self: ptr Device00): cstring {.
    importc, libprag.}

proc getProductId*(self: Device): string =
  let resul0 = gdk_device_get_product_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc productId*(self: Device): string =
  let resul0 = gdk_device_get_product_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_device_get_vendor_id(self: ptr Device00): cstring {.
    importc, libprag.}

proc getVendorId*(self: Device): string =
  let resul0 = gdk_device_get_vendor_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vendorId*(self: Device): string =
  let resul0 = gdk_device_get_vendor_id(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_device_list_slave_devices(self: ptr Device00): ptr glib.List {.
    importc, libprag.}

proc listSlaveDevices*(self: Device): seq[Device] =
  let resul0 = gdk_device_list_slave_devices(cast[ptr Device00](self.impl))
  if resul0.isNil:
    return
  result = glistObjects2seq(Device, resul0, false)
  g_list_free(resul0)

proc gdk_device_ungrab(self: ptr Device00; time: uint32) {.
    importc, libprag.}

proc ungrab*(self: Device; time: int) =
  gdk_device_ungrab(cast[ptr Device00](self.impl), uint32(time))

type
  Seat* = ref object of gobject.Object
  Seat00* = object of gobject.Object00

proc gdk_seat_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Seat()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDeviceAdded*(self: Seat;  p: proc (self: ptr Seat00; device: ptr Device00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-added", cast[GCallback](p), xdata, nil, cf)

proc scDeviceRemoved*(self: Seat;  p: proc (self: ptr Seat00; device: ptr Device00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-removed", cast[GCallback](p), xdata, nil, cf)

proc scToolAdded*(self: Seat;  p: proc (self: ptr Seat00; tool: ptr DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "tool-added", cast[GCallback](p), xdata, nil, cf)

proc scToolRemoved*(self: Seat;  p: proc (self: ptr Seat00; tool: ptr DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "tool-removed", cast[GCallback](p), xdata, nil, cf)

proc gdk_seat_get_keyboard(self: ptr Seat00): ptr Device00 {.
    importc, libprag.}

proc getKeyboard*(self: Seat): Device =
  let gobj = gdk_seat_get_keyboard(cast[ptr Seat00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc keyboard*(self: Seat): Device =
  let gobj = gdk_seat_get_keyboard(cast[ptr Seat00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_seat_get_pointer(self: ptr Seat00): ptr Device00 {.
    importc, libprag.}

proc getPointer*(self: Seat): Device =
  let gobj = gdk_seat_get_pointer(cast[ptr Seat00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_seat_ungrab(self: ptr Seat00) {.
    importc, libprag.}

proc ungrab*(self: Seat) =
  gdk_seat_ungrab(cast[ptr Seat00](self.impl))

type
  Display* = ref object of gobject.Object
  Display00* = object of gobject.Object00

proc gdk_display_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Display()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClosed*(self: Display;  p: proc (self: ptr Display00; isError: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc scMonitorAdded*(self: Display;  p: proc (self: ptr Display00; monitor: ptr Monitor00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "monitor-added", cast[GCallback](p), xdata, nil, cf)

proc scMonitorRemoved*(self: Display;  p: proc (self: ptr Display00; monitor: ptr Monitor00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "monitor-removed", cast[GCallback](p), xdata, nil, cf)

proc scOpened*(self: Display;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "opened", cast[GCallback](p), xdata, nil, cf)

proc scSeatAdded*(self: Display;  p: proc (self: ptr Display00; seat: ptr Seat00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "seat-added", cast[GCallback](p), xdata, nil, cf)

proc scSeatRemoved*(self: Display;  p: proc (self: ptr Display00; seat: ptr Seat00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "seat-removed", cast[GCallback](p), xdata, nil, cf)

proc gdk_display_get_default(): ptr Display00 {.
    importc, libprag.}

proc getDefaultDisplay*(): Display =
  let gobj = gdk_display_get_default()
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_open(displayName: cstring): ptr Display00 {.
    importc, libprag.}

proc open*(displayName: cstring): Display =
  let gobj = gdk_display_open(displayName)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_open_default_libgtk_only(): ptr Display00 {.
    importc, libprag.}

proc openDefaultLibgtkOnly*(): Display =
  let gobj = gdk_display_open_default_libgtk_only()
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_beep(self: ptr Display00) {.
    importc, libprag.}

proc beep*(self: Display) =
  gdk_display_beep(cast[ptr Display00](self.impl))

proc gdk_display_close(self: ptr Display00) {.
    importc, libprag.}

proc close*(self: Display) =
  gdk_display_close(cast[ptr Display00](self.impl))

proc gdk_display_device_is_grabbed(self: ptr Display00; device: ptr Device00): gboolean {.
    importc, libprag.}

proc deviceIsGrabbed*(self: Display; device: Device): bool =
  toBool(gdk_display_device_is_grabbed(cast[ptr Display00](self.impl), cast[ptr Device00](device.impl)))

proc gdk_display_flush(self: ptr Display00) {.
    importc, libprag.}

proc flush*(self: Display) =
  gdk_display_flush(cast[ptr Display00](self.impl))

proc gdk_display_get_app_launch_context(self: ptr Display00): ptr AppLaunchContext00 {.
    importc, libprag.}

proc getAppLaunchContext*(self: Display): AppLaunchContext =
  let gobj = gdk_display_get_app_launch_context(cast[ptr Display00](self.impl))
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

proc appLaunchContext*(self: Display): AppLaunchContext =
  let gobj = gdk_display_get_app_launch_context(cast[ptr Display00](self.impl))
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

proc gdk_display_get_default_cursor_size(self: ptr Display00): uint32 {.
    importc, libprag.}

proc getDefaultCursorSize*(self: Display): int =
  int(gdk_display_get_default_cursor_size(cast[ptr Display00](self.impl)))

proc defaultCursorSize*(self: Display): int =
  int(gdk_display_get_default_cursor_size(cast[ptr Display00](self.impl)))

proc gdk_display_get_default_seat(self: ptr Display00): ptr Seat00 {.
    importc, libprag.}

proc getDefaultSeat*(self: Display): Seat =
  let gobj = gdk_display_get_default_seat(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultSeat*(self: Display): Seat =
  let gobj = gdk_display_get_default_seat(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_maximal_cursor_size(self: ptr Display00; width: var uint32;
    height: var uint32) {.
    importc, libprag.}

proc getMaximalCursorSize*(self: Display; width: var int; height: var int) =
  var width_00: uint32
  var height_00: uint32
  gdk_display_get_maximal_cursor_size(cast[ptr Display00](self.impl), width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc gdk_display_get_monitor(self: ptr Display00; monitorNum: int32): ptr Monitor00 {.
    importc, libprag.}

proc getMonitor*(self: Display; monitorNum: int): Monitor =
  let gobj = gdk_display_get_monitor(cast[ptr Display00](self.impl), int32(monitorNum))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_monitor_at_point(self: ptr Display00; x: int32; y: int32): ptr Monitor00 {.
    importc, libprag.}

proc getMonitorAtPoint*(self: Display; x: int; y: int): Monitor =
  let gobj = gdk_display_get_monitor_at_point(cast[ptr Display00](self.impl), int32(x), int32(y))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_n_monitors(self: ptr Display00): int32 {.
    importc, libprag.}

proc getNMonitors*(self: Display): int =
  int(gdk_display_get_n_monitors(cast[ptr Display00](self.impl)))

proc nMonitors*(self: Display): int =
  int(gdk_display_get_n_monitors(cast[ptr Display00](self.impl)))

proc gdk_display_get_n_screens(self: ptr Display00): int32 {.
    importc, libprag.}

proc getNScreens*(self: Display): int =
  int(gdk_display_get_n_screens(cast[ptr Display00](self.impl)))

proc nScreens*(self: Display): int =
  int(gdk_display_get_n_screens(cast[ptr Display00](self.impl)))

proc gdk_display_get_name(self: ptr Display00): cstring {.
    importc, libprag.}

proc getName*(self: Display): string =
  result = $gdk_display_get_name(cast[ptr Display00](self.impl))

proc name*(self: Display): string =
  result = $gdk_display_get_name(cast[ptr Display00](self.impl))

proc gdk_display_get_primary_monitor(self: ptr Display00): ptr Monitor00 {.
    importc, libprag.}

proc getPrimaryMonitor*(self: Display): Monitor =
  let gobj = gdk_display_get_primary_monitor(cast[ptr Display00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc primaryMonitor*(self: Display): Monitor =
  let gobj = gdk_display_get_primary_monitor(cast[ptr Display00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_has_pending(self: ptr Display00): gboolean {.
    importc, libprag.}

proc hasPending*(self: Display): bool =
  toBool(gdk_display_has_pending(cast[ptr Display00](self.impl)))

proc gdk_display_is_closed(self: ptr Display00): gboolean {.
    importc, libprag.}

proc isClosed*(self: Display): bool =
  toBool(gdk_display_is_closed(cast[ptr Display00](self.impl)))

proc gdk_display_keyboard_ungrab(self: ptr Display00; time: uint32) {.
    importc, libprag.}

proc keyboardUngrab*(self: Display; time: int) =
  gdk_display_keyboard_ungrab(cast[ptr Display00](self.impl), uint32(time))

proc gdk_display_list_devices(self: ptr Display00): ptr glib.List {.
    importc, libprag.}

proc listDevices*(self: Display): seq[Device] =
  result = glistObjects2seq(Device, gdk_display_list_devices(cast[ptr Display00](self.impl)), false)

proc gdk_display_list_seats(self: ptr Display00): ptr glib.List {.
    importc, libprag.}

proc listSeats*(self: Display): seq[Seat] =
  let resul0 = gdk_display_list_seats(cast[ptr Display00](self.impl))
  result = glistObjects2seq(Seat, resul0, false)
  g_list_free(resul0)

proc gdk_display_notify_startup_complete(self: ptr Display00; startupId: cstring) {.
    importc, libprag.}

proc notifyStartupComplete*(self: Display; startupId: cstring) =
  gdk_display_notify_startup_complete(cast[ptr Display00](self.impl), startupId)

proc gdk_display_pointer_is_grabbed(self: ptr Display00): gboolean {.
    importc, libprag.}

proc pointerIsGrabbed*(self: Display): bool =
  toBool(gdk_display_pointer_is_grabbed(cast[ptr Display00](self.impl)))

proc gdk_display_pointer_ungrab(self: ptr Display00; time: uint32) {.
    importc, libprag.}

proc pointerUngrab*(self: Display; time: int) =
  gdk_display_pointer_ungrab(cast[ptr Display00](self.impl), uint32(time))

proc gdk_display_set_double_click_distance(self: ptr Display00; distance: uint32) {.
    importc, libprag.}

proc setDoubleClickDistance*(self: Display; distance: int) =
  gdk_display_set_double_click_distance(cast[ptr Display00](self.impl), uint32(distance))

proc `doubleClickDistance=`*(self: Display; distance: int) =
  gdk_display_set_double_click_distance(cast[ptr Display00](self.impl), uint32(distance))

proc gdk_display_set_double_click_time(self: ptr Display00; msec: uint32) {.
    importc, libprag.}

proc setDoubleClickTime*(self: Display; msec: int) =
  gdk_display_set_double_click_time(cast[ptr Display00](self.impl), uint32(msec))

proc `doubleClickTime=`*(self: Display; msec: int) =
  gdk_display_set_double_click_time(cast[ptr Display00](self.impl), uint32(msec))

proc gdk_display_supports_clipboard_persistence(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsClipboardPersistence*(self: Display): bool =
  toBool(gdk_display_supports_clipboard_persistence(cast[ptr Display00](self.impl)))

proc gdk_display_supports_composite(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsComposite*(self: Display): bool =
  toBool(gdk_display_supports_composite(cast[ptr Display00](self.impl)))

proc gdk_display_supports_cursor_alpha(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsCursorAlpha*(self: Display): bool =
  toBool(gdk_display_supports_cursor_alpha(cast[ptr Display00](self.impl)))

proc gdk_display_supports_cursor_color(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsCursorColor*(self: Display): bool =
  toBool(gdk_display_supports_cursor_color(cast[ptr Display00](self.impl)))

proc gdk_display_supports_input_shapes(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsInputShapes*(self: Display): bool =
  toBool(gdk_display_supports_input_shapes(cast[ptr Display00](self.impl)))

proc gdk_display_supports_selection_notification(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsSelectionNotification*(self: Display): bool =
  toBool(gdk_display_supports_selection_notification(cast[ptr Display00](self.impl)))

proc gdk_display_supports_shapes(self: ptr Display00): gboolean {.
    importc, libprag.}

proc supportsShapes*(self: Display): bool =
  toBool(gdk_display_supports_shapes(cast[ptr Display00](self.impl)))

proc gdk_display_sync(self: ptr Display00) {.
    importc, libprag.}

proc sync*(self: Display) =
  gdk_display_sync(cast[ptr Display00](self.impl))

proc gdk_app_launch_context_set_display(self: ptr AppLaunchContext00; display: ptr Display00) {.
    importc, libprag.}

proc setDisplay*(self: AppLaunchContext; display: Display) =
  gdk_app_launch_context_set_display(cast[ptr AppLaunchContext00](self.impl), cast[ptr Display00](display.impl))

proc `display=`*(self: AppLaunchContext; display: Display) =
  gdk_app_launch_context_set_display(cast[ptr AppLaunchContext00](self.impl), cast[ptr Display00](display.impl))

proc gdk_monitor_get_display(self: ptr Monitor00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Monitor): Display =
  let gobj = gdk_monitor_get_display(cast[ptr Monitor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: Monitor): Display =
  let gobj = gdk_monitor_get_display(cast[ptr Monitor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_device_get_display(self: ptr Device00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Device): Display =
  let gobj = gdk_device_get_display(cast[ptr Device00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: Device): Display =
  let gobj = gdk_device_get_display(cast[ptr Device00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_device_get_seat(self: ptr Device00): ptr Seat00 {.
    importc, libprag.}

proc getSeat*(self: Device): Seat =
  let gobj = gdk_device_get_seat(cast[ptr Device00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc seat*(self: Device): Seat =
  let gobj = gdk_device_get_seat(cast[ptr Device00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_seat_get_display(self: ptr Seat00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Seat): Display =
  let gobj = gdk_seat_get_display(cast[ptr Seat00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: Seat): Display =
  let gobj = gdk_seat_get_display(cast[ptr Seat00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DeviceToolType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    pen = 1
    eraser = 2
    brush = 3
    pencil = 4
    airbrush = 5
    mouse = 6
    lens = 7

proc gdk_device_tool_get_tool_type(self: ptr DeviceTool00): DeviceToolType {.
    importc, libprag.}

proc getToolType*(self: DeviceTool): DeviceToolType =
  gdk_device_tool_get_tool_type(cast[ptr DeviceTool00](self.impl))

proc toolType*(self: DeviceTool): DeviceToolType =
  gdk_device_tool_get_tool_type(cast[ptr DeviceTool00](self.impl))

type
  AxisFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    x = 1
    y = 2
    pressure = 3
    xtilt = 4
    ytilt = 5
    wheel = 6
    distance = 7
    rotation = 8
    slider = 9

  AxisFlags* {.size: sizeof(cint).} = set[AxisFlag]

proc gdk_device_get_axes(self: ptr Device00): AxisFlags {.
    importc, libprag.}

proc getAxes*(self: Device): AxisFlags =
  gdk_device_get_axes(cast[ptr Device00](self.impl))

proc axes*(self: Device): AxisFlags =
  gdk_device_get_axes(cast[ptr Device00](self.impl))

type
  DeviceType* {.size: sizeof(cint), pure.} = enum
    master = 0
    slave = 1
    floating = 2

proc gdk_device_get_device_type(self: ptr Device00): DeviceType {.
    importc, libprag.}

proc getDeviceType*(self: Device): DeviceType =
  gdk_device_get_device_type(cast[ptr Device00](self.impl))

proc deviceType*(self: Device): DeviceType =
  gdk_device_get_device_type(cast[ptr Device00](self.impl))

type
  InputSource* {.size: sizeof(cint), pure.} = enum
    mouse = 0
    pen = 1
    eraser = 2
    cursor = 3
    keyboard = 4
    touchscreen = 5
    touchpad = 6
    trackpoint = 7
    tabletPad = 8

proc gdk_device_get_source(self: ptr Device00): InputSource {.
    importc, libprag.}

proc getSource*(self: Device): InputSource =
  gdk_device_get_source(cast[ptr Device00](self.impl))

proc source*(self: Device): InputSource =
  gdk_device_get_source(cast[ptr Device00](self.impl))

type
  AxisUse* {.size: sizeof(cint), pure.} = enum
    ignore = 0
    x = 1
    y = 2
    pressure = 3
    xtilt = 4
    ytilt = 5
    wheel = 6
    distance = 7
    rotation = 8
    slider = 9
    last = 10

proc gdk_device_get_axis_use(self: ptr Device00; index: uint32): AxisUse {.
    importc, libprag.}

proc getAxisUse*(self: Device; index: int): AxisUse =
  gdk_device_get_axis_use(cast[ptr Device00](self.impl), uint32(index))

proc gdk_device_set_axis_use(self: ptr Device00; index: uint32; use: AxisUse) {.
    importc, libprag.}

proc setAxisUse*(self: Device; index: int; use: AxisUse) =
  gdk_device_set_axis_use(cast[ptr Device00](self.impl), uint32(index), use)

type
  ModifierFlag* {.size: sizeof(cint), pure.} = enum
    shift = 0
    lock = 1
    control = 2
    mod1 = 3
    mod2 = 4
    mod3 = 5
    mod4 = 6
    mod5 = 7
    button1 = 8
    button2 = 9
    button3 = 10
    button4 = 11
    button5 = 12
    modifierReserved_13 = 13
    modifierReserved_14 = 14
    modifierReserved_15 = 15
    modifierReserved_16 = 16
    modifierReserved_17 = 17
    modifierReserved_18 = 18
    modifierReserved_19 = 19
    modifierReserved_20 = 20
    modifierReserved_21 = 21
    modifierReserved_22 = 22
    modifierReserved_23 = 23
    modifierReserved_24 = 24
    modifierReserved_25 = 25
    super = 26
    hyper = 27
    meta = 28
    modifierReserved_29 = 29
    release = 30

  ModifierType* {.size: sizeof(cint).} = set[ModifierFlag]

const ModifierMask* = {ModifierFlag.shift .. ModifierFlag.button5, ModifierFlag.super .. ModifierFlag.meta}

proc gdk_device_get_key(self: ptr Device00; index: uint32; keyval: var uint32;
    modifiers: var ModifierType): gboolean {.
    importc, libprag.}

proc getKey*(self: Device; index: int; keyval: var int; modifiers: var ModifierType): bool =
  var keyval_00: uint32
  result = toBool(gdk_device_get_key(cast[ptr Device00](self.impl), uint32(index), keyval_00, modifiers))
  if keyval.addr != nil:
    keyval = int(keyval_00)

proc gdk_device_set_key(self: ptr Device00; index: uint32; keyval: uint32;
    modifiers: ModifierType) {.
    importc, libprag.}

proc setKey*(self: Device; index: int; keyval: int; modifiers: ModifierType) =
  gdk_device_set_key(cast[ptr Device00](self.impl), uint32(index), uint32(keyval), modifiers)

type
  InputMode* {.size: sizeof(cint), pure.} = enum
    disabled = 0
    screen = 1
    window = 2

proc gdk_device_get_mode(self: ptr Device00): InputMode {.
    importc, libprag.}

proc getMode*(self: Device): InputMode =
  gdk_device_get_mode(cast[ptr Device00](self.impl))

proc mode*(self: Device): InputMode =
  gdk_device_get_mode(cast[ptr Device00](self.impl))

proc gdk_device_set_mode(self: ptr Device00; mode: InputMode): gboolean {.
    importc, libprag.}

proc setMode*(self: Device; mode: InputMode): bool =
  toBool(gdk_device_set_mode(cast[ptr Device00](self.impl), mode))

type
  SeatCapabilities* {.size: sizeof(cint), pure.} = enum
    none = 0
    pointer = 1
    touch = 2
    tabletStylus = 4
    allPointing = 7
    keyboard = 8
    all = 15

proc gdk_seat_get_capabilities(self: ptr Seat00): SeatCapabilities {.
    importc, libprag.}

proc getCapabilities*(self: Seat): SeatCapabilities =
  gdk_seat_get_capabilities(cast[ptr Seat00](self.impl))

proc capabilities*(self: Seat): SeatCapabilities =
  gdk_seat_get_capabilities(cast[ptr Seat00](self.impl))

proc gdk_seat_get_slaves(self: ptr Seat00; capabilities: SeatCapabilities): ptr glib.List {.
    importc, libprag.}

proc getSlaves*(self: Seat; capabilities: SeatCapabilities): seq[Device] =
  let resul0 = gdk_seat_get_slaves(cast[ptr Seat00](self.impl), capabilities)
  result = glistObjects2seq(Device, resul0, false)
  g_list_free(resul0)

type
  DeviceManager* = ref object of gobject.Object
  DeviceManager00* = object of gobject.Object00

proc gdk_device_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDeviceAdded*(self: DeviceManager;  p: proc (self: ptr DeviceManager00; device: ptr Device00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-added", cast[GCallback](p), xdata, nil, cf)

proc scDeviceChanged*(self: DeviceManager;  p: proc (self: ptr DeviceManager00; device: ptr Device00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-changed", cast[GCallback](p), xdata, nil, cf)

proc scDeviceRemoved*(self: DeviceManager;  p: proc (self: ptr DeviceManager00; device: ptr Device00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "device-removed", cast[GCallback](p), xdata, nil, cf)

proc gdk_device_manager_get_client_pointer(self: ptr DeviceManager00): ptr Device00 {.
    importc, libprag.}

proc getClientPointer*(self: DeviceManager): Device =
  let gobj = gdk_device_manager_get_client_pointer(cast[ptr DeviceManager00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc clientPointer*(self: DeviceManager): Device =
  let gobj = gdk_device_manager_get_client_pointer(cast[ptr DeviceManager00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_device_manager_get_display(self: ptr DeviceManager00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: DeviceManager): Display =
  let gobj = gdk_device_manager_get_display(cast[ptr DeviceManager00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: DeviceManager): Display =
  let gobj = gdk_device_manager_get_display(cast[ptr DeviceManager00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_device_manager_list_devices(self: ptr DeviceManager00; `type`: DeviceType): ptr glib.List {.
    importc, libprag.}

proc listDevices*(self: DeviceManager; `type`: DeviceType): seq[Device] =
  let resul0 = gdk_device_manager_list_devices(cast[ptr DeviceManager00](self.impl), `type`)
  result = glistObjects2seq(Device, resul0, false)
  g_list_free(resul0)

proc gdk_display_get_device_manager(self: ptr Display00): ptr DeviceManager00 {.
    importc, libprag.}

proc getDeviceManager*(self: Display): DeviceManager =
  let gobj = gdk_display_get_device_manager(cast[ptr Display00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc deviceManager*(self: Display): DeviceManager =
  let gobj = gdk_display_get_device_manager(cast[ptr Display00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Atom00* {.pure.} = object
  Atom* = ref object
    impl*: ptr Atom00
    ignoreFinalizer*: bool

proc gdk_atom_name(self: ptr Atom00): cstring {.
    importc, libprag.}

proc name*(self: Atom): string =
  let resul0 = gdk_atom_name(cast[ptr Atom00](self.impl))
  result = $resul0
  cogfree(resul0)

proc newWithFinalizer*(x: var Atom) =
    new(x)

proc gdk_atom_intern(atomName: cstring; onlyIfExists: gboolean): ptr Atom00 {.
    importc, libprag.}

proc intern*(atomName: cstring; onlyIfExists: bool): Atom =
  new(result)
  result.impl = gdk_atom_intern(atomName, gboolean(onlyIfExists))
  result.ignoreFinalizer = true

proc gdk_atom_intern_static_string(atomName: cstring): ptr Atom00 {.
    importc, libprag.}

proc internStaticString*(atomName: cstring): Atom =
  new(result)
  result.impl = gdk_atom_intern_static_string(atomName)
  result.ignoreFinalizer = true

proc gdk_device_list_axes(self: ptr Device00): ptr glib.List {.
    importc, libprag.}

proc listAxes*(self: Device): seq[Atom] =
  let resul0 = gdk_device_list_axes(cast[ptr Device00](self.impl))
  g_list_free(resul0)

proc gdk_display_request_selection_notification(self: ptr Display00; selection: ptr Atom00): gboolean {.
    importc, libprag.}

proc requestSelectionNotification*(self: Display; selection: Atom): bool =
  toBool(gdk_display_request_selection_notification(cast[ptr Display00](self.impl), cast[ptr Atom00](selection.impl)))

type
  Window* = ref object of gobject.Object
  Window00* = object of gobject.Object00

proc gdk_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Window()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCreateSurface*(self: Window;  p: proc (self: ptr Window00; width: int32; height: int32; xdata: pointer): cairo.Surface00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create-surface", cast[GCallback](p), xdata, nil, cf)

proc scFromEmbedder*(self: Window;  p: proc (self: ptr Window00; embedderX: cdouble; embedderY: cdouble; offscreenX: var cdouble; offscreenY: var cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "from-embedder", cast[GCallback](p), xdata, nil, cf)

proc scMovedToRect*(self: Window;  p: proc (self: ptr Window00; flippedRect: pointer; finalRect: pointer; flippedX: gboolean; flippedY: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "moved-to-rect", cast[GCallback](p), xdata, nil, cf)

proc scPickEmbeddedChild*(self: Window;  p: proc (self: ptr Window00; x: cdouble; y: cdouble; xdata: pointer): Window00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pick-embedded-child", cast[GCallback](p), xdata, nil, cf)

proc scToEmbedder*(self: Window;  p: proc (self: ptr Window00; offscreenX: cdouble; offscreenY: cdouble; embedderX: var cdouble; embedderY: var cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "to-embedder", cast[GCallback](p), xdata, nil, cf)

proc gdk_window_at_pointer(winX: var int32; winY: var int32): ptr Window00 {.
    importc, libprag.}

proc atPointer*(winX: var int = cast[var int](nil); winY: var int = cast[var int](nil)): Window =
  var winY_00: int32
  var winX_00: int32
  let gobj = gdk_window_at_pointer(winX_00, winY_00)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  if winY.addr != nil:
    winY = int(winY_00)
  if winX.addr != nil:
    winX = int(winX_00)

proc processAllUpdates*() {.
    importc: "gdk_window_process_all_updates", libprag.}

proc gdk_window_set_debug_updates(setting: gboolean) {.
    importc, libprag.}

proc setDebugUpdates*(setting: bool = true) =
  gdk_window_set_debug_updates(gboolean(setting))

proc gdk_window_beep(self: ptr Window00) {.
    importc, libprag.}

proc beep*(self: Window) =
  gdk_window_beep(cast[ptr Window00](self.impl))

proc gdk_window_begin_move_drag(self: ptr Window00; button: int32; rootX: int32;
    rootY: int32; timestamp: uint32) {.
    importc, libprag.}

proc beginMoveDrag*(self: Window; button: int; rootX: int; rootY: int;
    timestamp: int) =
  gdk_window_begin_move_drag(cast[ptr Window00](self.impl), int32(button), int32(rootX), int32(rootY), uint32(timestamp))

proc gdk_window_begin_move_drag_for_device(self: ptr Window00; device: ptr Device00;
    button: int32; rootX: int32; rootY: int32; timestamp: uint32) {.
    importc, libprag.}

proc beginMoveDragForDevice*(self: Window; device: Device;
    button: int; rootX: int; rootY: int; timestamp: int) =
  gdk_window_begin_move_drag_for_device(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), int32(button), int32(rootX), int32(rootY), uint32(timestamp))

proc gdk_window_begin_paint_region(self: ptr Window00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc beginPaintRegion*(self: Window; region: cairo.Region) =
  gdk_window_begin_paint_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_window_configure_finished(self: ptr Window00) {.
    importc, libprag.}

proc configureFinished*(self: Window) =
  gdk_window_configure_finished(cast[ptr Window00](self.impl))

proc gdk_window_coords_from_parent(self: ptr Window00; parentX: cdouble;
    parentY: cdouble; x: var cdouble; y: var cdouble) {.
    importc, libprag.}

proc coordsFromParent*(self: Window; parentX: cdouble; parentY: cdouble;
    x: var cdouble = cast[var cdouble](nil); y: var cdouble = cast[var cdouble](nil)) =
  gdk_window_coords_from_parent(cast[ptr Window00](self.impl), parentX, parentY, x, y)

proc gdk_window_coords_to_parent(self: ptr Window00; x: cdouble; y: cdouble;
    parentX: var cdouble; parentY: var cdouble) {.
    importc, libprag.}

proc coordsToParent*(self: Window; x: cdouble; y: cdouble; parentX: var cdouble = cast[var cdouble](nil);
    parentY: var cdouble = cast[var cdouble](nil)) =
  gdk_window_coords_to_parent(cast[ptr Window00](self.impl), x, y, parentX, parentY)

proc gdk_window_create_similar_image_surface(self: ptr Window00; format: int32;
    width: int32; height: int32; scale: int32): ptr cairo.Surface00 {.
    importc, libprag.}

proc createSimilarImageSurface*(self: Window; format: int; width: int;
    height: int; scale: int): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = gdk_window_create_similar_image_surface(cast[ptr Window00](self.impl), int32(format), int32(width), int32(height), int32(scale))

proc gdk_window_create_similar_surface(self: ptr Window00; content: cairo.Content;
    width: int32; height: int32): ptr cairo.Surface00 {.
    importc, libprag.}

proc createSimilarSurface*(self: Window; content: cairo.Content;
    width: int; height: int): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = gdk_window_create_similar_surface(cast[ptr Window00](self.impl), content, int32(width), int32(height))

proc gdk_window_deiconify(self: ptr Window00) {.
    importc, libprag.}

proc deiconify*(self: Window) =
  gdk_window_deiconify(cast[ptr Window00](self.impl))

proc gdk_window_destroy(self: ptr Window00) {.
    importc, libprag.}

proc destroy*(self: Window) =
  gdk_window_destroy(cast[ptr Window00](self.impl))

proc gdk_window_destroy_notify(self: ptr Window00) {.
    importc, libprag.}

proc destroyNotify*(self: Window) =
  gdk_window_destroy_notify(cast[ptr Window00](self.impl))

proc gdk_window_enable_synchronized_configure(self: ptr Window00) {.
    importc, libprag.}

proc enableSynchronizedConfigure*(self: Window) =
  gdk_window_enable_synchronized_configure(cast[ptr Window00](self.impl))

proc gdk_window_end_paint(self: ptr Window00) {.
    importc, libprag.}

proc endPaint*(self: Window) =
  gdk_window_end_paint(cast[ptr Window00](self.impl))

proc gdk_window_ensure_native(self: ptr Window00): gboolean {.
    importc, libprag.}

proc ensureNative*(self: Window): bool =
  toBool(gdk_window_ensure_native(cast[ptr Window00](self.impl)))

proc gdk_window_flush(self: ptr Window00) {.
    importc, libprag.}

proc flush*(self: Window) =
  gdk_window_flush(cast[ptr Window00](self.impl))

proc gdk_window_focus(self: ptr Window00; timestamp: uint32) {.
    importc, libprag.}

proc focus*(self: Window; timestamp: int) =
  gdk_window_focus(cast[ptr Window00](self.impl), uint32(timestamp))

proc gdk_window_freeze_toplevel_updates_libgtk_only(self: ptr Window00) {.
    importc, libprag.}

proc freezeToplevelUpdatesLibgtkOnly*(self: Window) =
  gdk_window_freeze_toplevel_updates_libgtk_only(cast[ptr Window00](self.impl))

proc gdk_window_freeze_updates(self: ptr Window00) {.
    importc, libprag.}

proc freezeUpdates*(self: Window) =
  gdk_window_freeze_updates(cast[ptr Window00](self.impl))

proc gdk_window_fullscreen(self: ptr Window00) {.
    importc, libprag.}

proc fullscreen*(self: Window) =
  gdk_window_fullscreen(cast[ptr Window00](self.impl))

proc gdk_window_fullscreen_on_monitor(self: ptr Window00; monitor: int32) {.
    importc, libprag.}

proc fullscreenOnMonitor*(self: Window; monitor: int) =
  gdk_window_fullscreen_on_monitor(cast[ptr Window00](self.impl), int32(monitor))

proc gdk_window_geometry_changed(self: ptr Window00) {.
    importc, libprag.}

proc geometryChanged*(self: Window) =
  gdk_window_geometry_changed(cast[ptr Window00](self.impl))

proc gdk_window_get_accept_focus(self: ptr Window00): gboolean {.
    importc, libprag.}

proc getAcceptFocus*(self: Window): bool =
  toBool(gdk_window_get_accept_focus(cast[ptr Window00](self.impl)))

proc acceptFocus*(self: Window): bool =
  toBool(gdk_window_get_accept_focus(cast[ptr Window00](self.impl)))

proc gdk_window_get_background_pattern(self: ptr Window00): ptr cairo.Pattern00 {.
    importc, libprag.}

proc getBackgroundPattern*(self: Window): cairo.Pattern =
  let impl0 = gdk_window_get_background_pattern(cast[ptr Window00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_pattern_get_type(), impl0))

proc backgroundPattern*(self: Window): cairo.Pattern =
  let impl0 = gdk_window_get_background_pattern(cast[ptr Window00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_pattern_get_type(), impl0))

proc gdk_window_get_children(self: ptr Window00): ptr glib.List {.
    importc, libprag.}

proc getChildren*(self: Window): seq[Window] =
  let resul0 = gdk_window_get_children(cast[ptr Window00](self.impl))
  result = glistObjects2seq(Window, resul0, false)
  g_list_free(resul0)

proc children*(self: Window): seq[Window] =
  let resul0 = gdk_window_get_children(cast[ptr Window00](self.impl))
  result = glistObjects2seq(Window, resul0, false)
  g_list_free(resul0)

proc gdk_window_get_children_with_user_data(self: ptr Window00; userData: pointer): ptr glib.List {.
    importc, libprag.}

proc getChildrenWithUserData*(self: Window; userData: pointer): seq[Window] =
  let resul0 = gdk_window_get_children_with_user_data(cast[ptr Window00](self.impl), userData)
  result = glistObjects2seq(Window, resul0, false)
  g_list_free(resul0)

proc gdk_window_get_clip_region(self: ptr Window00): ptr cairo.Region00 {.
    importc, libprag.}

proc getClipRegion*(self: Window): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_window_get_clip_region(cast[ptr Window00](self.impl))

proc clipRegion*(self: Window): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_window_get_clip_region(cast[ptr Window00](self.impl))

proc gdk_window_get_composited(self: ptr Window00): gboolean {.
    importc, libprag.}

proc getComposited*(self: Window): bool =
  toBool(gdk_window_get_composited(cast[ptr Window00](self.impl)))

proc composited*(self: Window): bool =
  toBool(gdk_window_get_composited(cast[ptr Window00](self.impl)))

proc gdk_window_get_device_position(self: ptr Window00; device: ptr Device00;
    x: var int32; y: var int32; mask: var ModifierType): ptr Window00 {.
    importc, libprag.}

proc getDevicePosition*(self: Window; device: Device; x: var int = cast[var int](nil);
    y: var int = cast[var int](nil); mask: var ModifierType = cast[var ModifierType](nil)): Window =
  var y_00: int32
  var x_00: int32
  let gobj = gdk_window_get_device_position(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), x_00, y_00, mask)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc gdk_window_get_device_position_double(self: ptr Window00; device: ptr Device00;
    x: var cdouble; y: var cdouble; mask: var ModifierType): ptr Window00 {.
    importc, libprag.}

proc getDevicePositionDouble*(self: Window; device: Device;
    x: var cdouble = cast[var cdouble](nil); y: var cdouble = cast[var cdouble](nil);
    mask: var ModifierType = cast[var ModifierType](nil)): Window =
  let gobj = gdk_window_get_device_position_double(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), x, y, mask)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_display(self: ptr Window00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Window): Display =
  let gobj = gdk_window_get_display(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: Window): Display =
  let gobj = gdk_window_get_display(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_effective_parent(self: ptr Window00): ptr Window00 {.
    importc, libprag.}

proc getEffectiveParent*(self: Window): Window =
  let gobj = gdk_window_get_effective_parent(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc effectiveParent*(self: Window): Window =
  let gobj = gdk_window_get_effective_parent(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_effective_toplevel(self: ptr Window00): ptr Window00 {.
    importc, libprag.}

proc getEffectiveToplevel*(self: Window): Window =
  let gobj = gdk_window_get_effective_toplevel(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc effectiveToplevel*(self: Window): Window =
  let gobj = gdk_window_get_effective_toplevel(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_event_compression(self: ptr Window00): gboolean {.
    importc, libprag.}

proc getEventCompression*(self: Window): bool =
  toBool(gdk_window_get_event_compression(cast[ptr Window00](self.impl)))

proc eventCompression*(self: Window): bool =
  toBool(gdk_window_get_event_compression(cast[ptr Window00](self.impl)))

proc gdk_window_get_focus_on_map(self: ptr Window00): gboolean {.
    importc, libprag.}

proc getFocusOnMap*(self: Window): bool =
  toBool(gdk_window_get_focus_on_map(cast[ptr Window00](self.impl)))

proc focusOnMap*(self: Window): bool =
  toBool(gdk_window_get_focus_on_map(cast[ptr Window00](self.impl)))

proc gdk_window_get_geometry(self: ptr Window00; x: var int32; y: var int32;
    width: var int32; height: var int32) {.
    importc, libprag.}

proc getGeometry*(self: Window; x: var int = cast[var int](nil);
    y: var int = cast[var int](nil); width: var int = cast[var int](nil); height: var int = cast[var int](nil)) =
  var width_00: int32
  var y_00: int32
  var x_00: int32
  var height_00: int32
  gdk_window_get_geometry(cast[ptr Window00](self.impl), x_00, y_00, width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)
  if height.addr != nil:
    height = int(height_00)

proc gdk_window_get_group(self: ptr Window00): ptr Window00 {.
    importc, libprag.}

proc getGroup*(self: Window): Window =
  let gobj = gdk_window_get_group(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc group*(self: Window): Window =
  let gobj = gdk_window_get_group(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_height(self: ptr Window00): int32 {.
    importc, libprag.}

proc getHeight*(self: Window): int =
  int(gdk_window_get_height(cast[ptr Window00](self.impl)))

proc height*(self: Window): int =
  int(gdk_window_get_height(cast[ptr Window00](self.impl)))

proc gdk_window_get_modal_hint(self: ptr Window00): gboolean {.
    importc, libprag.}

proc getModalHint*(self: Window): bool =
  toBool(gdk_window_get_modal_hint(cast[ptr Window00](self.impl)))

proc modalHint*(self: Window): bool =
  toBool(gdk_window_get_modal_hint(cast[ptr Window00](self.impl)))

proc gdk_window_get_origin(self: ptr Window00; x: var int32; y: var int32): int32 {.
    importc, libprag.}

proc getOrigin*(self: Window; x: var int = cast[var int](nil);
    y: var int = cast[var int](nil)): int =
  var y_00: int32
  var x_00: int32
  result = int(gdk_window_get_origin(cast[ptr Window00](self.impl), x_00, y_00))
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc gdk_window_get_parent(self: ptr Window00): ptr Window00 {.
    importc, libprag.}

proc getParent*(self: Window): Window =
  let gobj = gdk_window_get_parent(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parent*(self: Window): Window =
  let gobj = gdk_window_get_parent(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_pass_through(self: ptr Window00): gboolean {.
    importc, libprag.}

proc getPassThrough*(self: Window): bool =
  toBool(gdk_window_get_pass_through(cast[ptr Window00](self.impl)))

proc passThrough*(self: Window): bool =
  toBool(gdk_window_get_pass_through(cast[ptr Window00](self.impl)))

proc gdk_window_get_pointer(self: ptr Window00; x: var int32; y: var int32;
    mask: var ModifierType): ptr Window00 {.
    importc, libprag.}

proc getPointer*(self: Window; x: var int = cast[var int](nil);
    y: var int = cast[var int](nil); mask: var ModifierType = cast[var ModifierType](nil)): Window =
  var y_00: int32
  var x_00: int32
  let gobj = gdk_window_get_pointer(cast[ptr Window00](self.impl), x_00, y_00, mask)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc gdk_window_get_position(self: ptr Window00; x: var int32; y: var int32) {.
    importc, libprag.}

proc getPosition*(self: Window; x: var int = cast[var int](nil);
    y: var int = cast[var int](nil)) =
  var y_00: int32
  var x_00: int32
  gdk_window_get_position(cast[ptr Window00](self.impl), x_00, y_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc gdk_window_get_root_coords(self: ptr Window00; x: int32; y: int32; rootX: var int32;
    rootY: var int32) {.
    importc, libprag.}

proc getRootCoords*(self: Window; x: int; y: int; rootX: var int;
    rootY: var int) =
  var rootY_00: int32
  var rootX_00: int32
  gdk_window_get_root_coords(cast[ptr Window00](self.impl), int32(x), int32(y), rootX_00, rootY_00)
  if rootY.addr != nil:
    rootY = int(rootY_00)
  if rootX.addr != nil:
    rootX = int(rootX_00)

proc gdk_window_get_root_origin(self: ptr Window00; x: var int32; y: var int32) {.
    importc, libprag.}

proc getRootOrigin*(self: Window; x: var int; y: var int) =
  var y_00: int32
  var x_00: int32
  gdk_window_get_root_origin(cast[ptr Window00](self.impl), x_00, y_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc gdk_window_get_scale_factor(self: ptr Window00): int32 {.
    importc, libprag.}

proc getScaleFactor*(self: Window): int =
  int(gdk_window_get_scale_factor(cast[ptr Window00](self.impl)))

proc scaleFactor*(self: Window): int =
  int(gdk_window_get_scale_factor(cast[ptr Window00](self.impl)))

proc gdk_window_get_support_multidevice(self: ptr Window00): gboolean {.
    importc, libprag.}

proc getSupportMultidevice*(self: Window): bool =
  toBool(gdk_window_get_support_multidevice(cast[ptr Window00](self.impl)))

proc supportMultidevice*(self: Window): bool =
  toBool(gdk_window_get_support_multidevice(cast[ptr Window00](self.impl)))

proc gdk_window_get_toplevel(self: ptr Window00): ptr Window00 {.
    importc, libprag.}

proc getToplevel*(self: Window): Window =
  let gobj = gdk_window_get_toplevel(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc toplevel*(self: Window): Window =
  let gobj = gdk_window_get_toplevel(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_update_area(self: ptr Window00): ptr cairo.Region00 {.
    importc, libprag.}

proc getUpdateArea*(self: Window): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_window_get_update_area(cast[ptr Window00](self.impl))

proc updateArea*(self: Window): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_window_get_update_area(cast[ptr Window00](self.impl))

proc gdk_window_get_user_data(self: ptr Window00; data: var pointer) {.
    importc, libprag.}

proc getUserData*(self: Window; data: var pointer) =
  gdk_window_get_user_data(cast[ptr Window00](self.impl), data)

proc getUserData*(self: Window): pointer =
  gdk_window_get_user_data(cast[ptr Window00](self.impl), result)

proc gdk_window_get_visible_region(self: ptr Window00): ptr cairo.Region00 {.
    importc, libprag.}

proc getVisibleRegion*(self: Window): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_window_get_visible_region(cast[ptr Window00](self.impl))

proc visibleRegion*(self: Window): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_window_get_visible_region(cast[ptr Window00](self.impl))

proc gdk_window_get_width(self: ptr Window00): int32 {.
    importc, libprag.}

proc getWidth*(self: Window): int =
  int(gdk_window_get_width(cast[ptr Window00](self.impl)))

proc width*(self: Window): int =
  int(gdk_window_get_width(cast[ptr Window00](self.impl)))

proc gdk_window_has_native(self: ptr Window00): gboolean {.
    importc, libprag.}

proc hasNative*(self: Window): bool =
  toBool(gdk_window_has_native(cast[ptr Window00](self.impl)))

proc gdk_window_hide(self: ptr Window00) {.
    importc, libprag.}

proc hide*(self: Window) =
  gdk_window_hide(cast[ptr Window00](self.impl))

proc gdk_window_iconify(self: ptr Window00) {.
    importc, libprag.}

proc iconify*(self: Window) =
  gdk_window_iconify(cast[ptr Window00](self.impl))

proc gdk_window_input_shape_combine_region(self: ptr Window00; shapeRegion: ptr cairo.Region00;
    offsetX: int32; offsetY: int32) {.
    importc, libprag.}

proc inputShapeCombineRegion*(self: Window; shapeRegion: cairo.Region;
    offsetX: int; offsetY: int) =
  gdk_window_input_shape_combine_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](shapeRegion.impl), int32(offsetX), int32(offsetY))

proc gdk_window_invalidate_region(self: ptr Window00; region: ptr cairo.Region00;
    invalidateChildren: gboolean) {.
    importc, libprag.}

proc invalidateRegion*(self: Window; region: cairo.Region; invalidateChildren: bool) =
  gdk_window_invalidate_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl), gboolean(invalidateChildren))

proc gdk_window_is_destroyed(self: ptr Window00): gboolean {.
    importc, libprag.}

proc isDestroyed*(self: Window): bool =
  toBool(gdk_window_is_destroyed(cast[ptr Window00](self.impl)))

proc gdk_window_is_input_only(self: ptr Window00): gboolean {.
    importc, libprag.}

proc isInputOnly*(self: Window): bool =
  toBool(gdk_window_is_input_only(cast[ptr Window00](self.impl)))

proc gdk_window_is_shaped(self: ptr Window00): gboolean {.
    importc, libprag.}

proc isShaped*(self: Window): bool =
  toBool(gdk_window_is_shaped(cast[ptr Window00](self.impl)))

proc gdk_window_is_viewable(self: ptr Window00): gboolean {.
    importc, libprag.}

proc isViewable*(self: Window): bool =
  toBool(gdk_window_is_viewable(cast[ptr Window00](self.impl)))

proc gdk_window_is_visible(self: ptr Window00): gboolean {.
    importc, libprag.}

proc isVisible*(self: Window): bool =
  toBool(gdk_window_is_visible(cast[ptr Window00](self.impl)))

proc gdk_window_lower(self: ptr Window00) {.
    importc, libprag.}

proc lower*(self: Window) =
  gdk_window_lower(cast[ptr Window00](self.impl))

proc gdk_window_mark_paint_from_clip(self: ptr Window00; cr: ptr cairo.Context00) {.
    importc, libprag.}

proc markPaintFromClip*(self: Window; cr: cairo.Context) =
  gdk_window_mark_paint_from_clip(cast[ptr Window00](self.impl), cast[ptr cairo.Context00](cr.impl))

proc gdk_window_maximize(self: ptr Window00) {.
    importc, libprag.}

proc maximize*(self: Window) =
  gdk_window_maximize(cast[ptr Window00](self.impl))

proc gdk_window_merge_child_input_shapes(self: ptr Window00) {.
    importc, libprag.}

proc mergeChildInputShapes*(self: Window) =
  gdk_window_merge_child_input_shapes(cast[ptr Window00](self.impl))

proc gdk_window_merge_child_shapes(self: ptr Window00) {.
    importc, libprag.}

proc mergeChildShapes*(self: Window) =
  gdk_window_merge_child_shapes(cast[ptr Window00](self.impl))

proc gdk_window_move(self: ptr Window00; x: int32; y: int32) {.
    importc, libprag.}

proc move*(self: Window; x: int; y: int) =
  gdk_window_move(cast[ptr Window00](self.impl), int32(x), int32(y))

proc gdk_window_move_region(self: ptr Window00; region: ptr cairo.Region00;
    dx: int32; dy: int32) {.
    importc, libprag.}

proc moveRegion*(self: Window; region: cairo.Region; dx: int;
    dy: int) =
  gdk_window_move_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl), int32(dx), int32(dy))

proc gdk_window_move_resize(self: ptr Window00; x: int32; y: int32; width: int32;
    height: int32) {.
    importc, libprag.}

proc moveResize*(self: Window; x: int; y: int; width: int; height: int) =
  gdk_window_move_resize(cast[ptr Window00](self.impl), int32(x), int32(y), int32(width), int32(height))

proc gdk_window_peek_children(self: ptr Window00): ptr glib.List {.
    importc, libprag.}

proc peekChildren*(self: Window): seq[Window] =
  result = glistObjects2seq(Window, gdk_window_peek_children(cast[ptr Window00](self.impl)), false)

proc gdk_window_process_updates(self: ptr Window00; updateChildren: gboolean) {.
    importc, libprag.}

proc processUpdates*(self: Window; updateChildren: bool) =
  gdk_window_process_updates(cast[ptr Window00](self.impl), gboolean(updateChildren))

proc gdk_window_raise(self: ptr Window00) {.
    importc, libprag.}

proc `raise`*(self: Window) =
  gdk_window_raise(cast[ptr Window00](self.impl))

proc gdk_window_register_dnd(self: ptr Window00) {.
    importc, libprag.}

proc registerDnd*(self: Window) =
  gdk_window_register_dnd(cast[ptr Window00](self.impl))

proc gdk_window_reparent(self: ptr Window00; newParent: ptr Window00; x: int32;
    y: int32) {.
    importc, libprag.}

proc reparent*(self: Window; newParent: Window; x: int; y: int) =
  gdk_window_reparent(cast[ptr Window00](self.impl), cast[ptr Window00](newParent.impl), int32(x), int32(y))

proc gdk_window_resize(self: ptr Window00; width: int32; height: int32) {.
    importc, libprag.}

proc resize*(self: Window; width: int; height: int) =
  gdk_window_resize(cast[ptr Window00](self.impl), int32(width), int32(height))

proc gdk_window_restack(self: ptr Window00; sibling: ptr Window00; above: gboolean) {.
    importc, libprag.}

proc restack*(self: Window; sibling: Window = nil; above: bool) =
  gdk_window_restack(cast[ptr Window00](self.impl), if sibling.isNil: nil else: cast[ptr Window00](sibling.impl), gboolean(above))

proc gdk_window_scroll(self: ptr Window00; dx: int32; dy: int32) {.
    importc, libprag.}

proc scroll*(self: Window; dx: int; dy: int) =
  gdk_window_scroll(cast[ptr Window00](self.impl), int32(dx), int32(dy))

proc gdk_window_set_accept_focus(self: ptr Window00; acceptFocus: gboolean) {.
    importc, libprag.}

proc setAcceptFocus*(self: Window; acceptFocus: bool = true) =
  gdk_window_set_accept_focus(cast[ptr Window00](self.impl), gboolean(acceptFocus))

proc `acceptFocus=`*(self: Window; acceptFocus: bool) =
  gdk_window_set_accept_focus(cast[ptr Window00](self.impl), gboolean(acceptFocus))

proc gdk_window_set_background_pattern(self: ptr Window00; pattern: ptr cairo.Pattern00) {.
    importc, libprag.}

proc setBackgroundPattern*(self: Window; pattern: cairo.Pattern = nil) =
  gdk_window_set_background_pattern(cast[ptr Window00](self.impl), if pattern.isNil: nil else: cast[ptr cairo.Pattern00](pattern.impl))

proc `backgroundPattern=`*(self: Window; pattern: cairo.Pattern = nil) =
  gdk_window_set_background_pattern(cast[ptr Window00](self.impl), if pattern.isNil: nil else: cast[ptr cairo.Pattern00](pattern.impl))

proc gdk_window_set_child_input_shapes(self: ptr Window00) {.
    importc, libprag.}

proc setChildInputShapes*(self: Window) =
  gdk_window_set_child_input_shapes(cast[ptr Window00](self.impl))

proc gdk_window_set_child_shapes(self: ptr Window00) {.
    importc, libprag.}

proc setChildShapes*(self: Window) =
  gdk_window_set_child_shapes(cast[ptr Window00](self.impl))

proc gdk_window_set_composited(self: ptr Window00; composited: gboolean) {.
    importc, libprag.}

proc setComposited*(self: Window; composited: bool = true) =
  gdk_window_set_composited(cast[ptr Window00](self.impl), gboolean(composited))

proc `composited=`*(self: Window; composited: bool) =
  gdk_window_set_composited(cast[ptr Window00](self.impl), gboolean(composited))

proc gdk_window_set_event_compression(self: ptr Window00; eventCompression: gboolean) {.
    importc, libprag.}

proc setEventCompression*(self: Window; eventCompression: bool = true) =
  gdk_window_set_event_compression(cast[ptr Window00](self.impl), gboolean(eventCompression))

proc `eventCompression=`*(self: Window; eventCompression: bool) =
  gdk_window_set_event_compression(cast[ptr Window00](self.impl), gboolean(eventCompression))

proc gdk_window_set_focus_on_map(self: ptr Window00; focusOnMap: gboolean) {.
    importc, libprag.}

proc setFocusOnMap*(self: Window; focusOnMap: bool = true) =
  gdk_window_set_focus_on_map(cast[ptr Window00](self.impl), gboolean(focusOnMap))

proc `focusOnMap=`*(self: Window; focusOnMap: bool) =
  gdk_window_set_focus_on_map(cast[ptr Window00](self.impl), gboolean(focusOnMap))

proc gdk_window_set_group(self: ptr Window00; leader: ptr Window00) {.
    importc, libprag.}

proc setGroup*(self: Window; leader: Window = nil) =
  gdk_window_set_group(cast[ptr Window00](self.impl), if leader.isNil: nil else: cast[ptr Window00](leader.impl))

proc `group=`*(self: Window; leader: Window = nil) =
  gdk_window_set_group(cast[ptr Window00](self.impl), if leader.isNil: nil else: cast[ptr Window00](leader.impl))

proc gdk_window_set_icon_list(self: ptr Window00; pixbufs: ptr glib.List) {.
    importc, libprag.}

proc setIconList*(self: Window; pixbufs: seq[gdkpixbuf.Pixbuf]) =
  var tempResGL = seq2GList(pixbufs)
  gdk_window_set_icon_list(cast[ptr Window00](self.impl), tempResGL)
  g_list_free(tempResGL)

proc `iconList=`*(self: Window; pixbufs: seq[gdkpixbuf.Pixbuf]) =
  var tempResGL = seq2GList(pixbufs)
  gdk_window_set_icon_list(cast[ptr Window00](self.impl), tempResGL)
  g_list_free(tempResGL)

proc gdk_window_set_icon_name(self: ptr Window00; name: cstring) {.
    importc, libprag.}

proc setIconName*(self: Window; name: cstring = nil) =
  gdk_window_set_icon_name(cast[ptr Window00](self.impl), name)

proc `iconName=`*(self: Window; name: cstring = nil) =
  gdk_window_set_icon_name(cast[ptr Window00](self.impl), name)

proc gdk_window_set_keep_above(self: ptr Window00; setting: gboolean) {.
    importc, libprag.}

proc setKeepAbove*(self: Window; setting: bool = true) =
  gdk_window_set_keep_above(cast[ptr Window00](self.impl), gboolean(setting))

proc `keepAbove=`*(self: Window; setting: bool) =
  gdk_window_set_keep_above(cast[ptr Window00](self.impl), gboolean(setting))

proc gdk_window_set_keep_below(self: ptr Window00; setting: gboolean) {.
    importc, libprag.}

proc setKeepBelow*(self: Window; setting: bool = true) =
  gdk_window_set_keep_below(cast[ptr Window00](self.impl), gboolean(setting))

proc `keepBelow=`*(self: Window; setting: bool) =
  gdk_window_set_keep_below(cast[ptr Window00](self.impl), gboolean(setting))

proc gdk_window_set_modal_hint(self: ptr Window00; modal: gboolean) {.
    importc, libprag.}

proc setModalHint*(self: Window; modal: bool = true) =
  gdk_window_set_modal_hint(cast[ptr Window00](self.impl), gboolean(modal))

proc `modalHint=`*(self: Window; modal: bool) =
  gdk_window_set_modal_hint(cast[ptr Window00](self.impl), gboolean(modal))

proc gdk_window_set_opacity(self: ptr Window00; opacity: cdouble) {.
    importc, libprag.}

proc setOpacity*(self: Window; opacity: cdouble) =
  gdk_window_set_opacity(cast[ptr Window00](self.impl), opacity)

proc `opacity=`*(self: Window; opacity: cdouble) =
  gdk_window_set_opacity(cast[ptr Window00](self.impl), opacity)

proc gdk_window_set_opaque_region(self: ptr Window00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc setOpaqueRegion*(self: Window; region: cairo.Region = nil) =
  gdk_window_set_opaque_region(cast[ptr Window00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc `opaqueRegion=`*(self: Window; region: cairo.Region = nil) =
  gdk_window_set_opaque_region(cast[ptr Window00](self.impl), if region.isNil: nil else: cast[ptr cairo.Region00](region.impl))

proc gdk_window_set_override_redirect(self: ptr Window00; overrideRedirect: gboolean) {.
    importc, libprag.}

proc setOverrideRedirect*(self: Window; overrideRedirect: bool = true) =
  gdk_window_set_override_redirect(cast[ptr Window00](self.impl), gboolean(overrideRedirect))

proc `overrideRedirect=`*(self: Window; overrideRedirect: bool) =
  gdk_window_set_override_redirect(cast[ptr Window00](self.impl), gboolean(overrideRedirect))

proc gdk_window_set_pass_through(self: ptr Window00; passThrough: gboolean) {.
    importc, libprag.}

proc setPassThrough*(self: Window; passThrough: bool = true) =
  gdk_window_set_pass_through(cast[ptr Window00](self.impl), gboolean(passThrough))

proc `passThrough=`*(self: Window; passThrough: bool) =
  gdk_window_set_pass_through(cast[ptr Window00](self.impl), gboolean(passThrough))

proc gdk_window_set_role(self: ptr Window00; role: cstring) {.
    importc, libprag.}

proc setRole*(self: Window; role: cstring) =
  gdk_window_set_role(cast[ptr Window00](self.impl), role)

proc `role=`*(self: Window; role: cstring) =
  gdk_window_set_role(cast[ptr Window00](self.impl), role)

proc gdk_window_set_shadow_width(self: ptr Window00; left: int32; right: int32;
    top: int32; bottom: int32) {.
    importc, libprag.}

proc setShadowWidth*(self: Window; left: int; right: int; top: int;
    bottom: int) =
  gdk_window_set_shadow_width(cast[ptr Window00](self.impl), int32(left), int32(right), int32(top), int32(bottom))

proc gdk_window_set_skip_pager_hint(self: ptr Window00; skipsPager: gboolean) {.
    importc, libprag.}

proc setSkipPagerHint*(self: Window; skipsPager: bool = true) =
  gdk_window_set_skip_pager_hint(cast[ptr Window00](self.impl), gboolean(skipsPager))

proc `skipPagerHint=`*(self: Window; skipsPager: bool) =
  gdk_window_set_skip_pager_hint(cast[ptr Window00](self.impl), gboolean(skipsPager))

proc gdk_window_set_skip_taskbar_hint(self: ptr Window00; skipsTaskbar: gboolean) {.
    importc, libprag.}

proc setSkipTaskbarHint*(self: Window; skipsTaskbar: bool = true) =
  gdk_window_set_skip_taskbar_hint(cast[ptr Window00](self.impl), gboolean(skipsTaskbar))

proc `skipTaskbarHint=`*(self: Window; skipsTaskbar: bool) =
  gdk_window_set_skip_taskbar_hint(cast[ptr Window00](self.impl), gboolean(skipsTaskbar))

proc gdk_window_set_startup_id(self: ptr Window00; startupId: cstring) {.
    importc, libprag.}

proc setStartupId*(self: Window; startupId: cstring) =
  gdk_window_set_startup_id(cast[ptr Window00](self.impl), startupId)

proc `startupId=`*(self: Window; startupId: cstring) =
  gdk_window_set_startup_id(cast[ptr Window00](self.impl), startupId)

proc gdk_window_set_static_gravities(self: ptr Window00; useStatic: gboolean): gboolean {.
    importc, libprag.}

proc setStaticGravities*(self: Window; useStatic: bool = true): bool =
  toBool(gdk_window_set_static_gravities(cast[ptr Window00](self.impl), gboolean(useStatic)))

proc gdk_window_set_support_multidevice(self: ptr Window00; supportMultidevice: gboolean) {.
    importc, libprag.}

proc setSupportMultidevice*(self: Window; supportMultidevice: bool = true) =
  gdk_window_set_support_multidevice(cast[ptr Window00](self.impl), gboolean(supportMultidevice))

proc `supportMultidevice=`*(self: Window; supportMultidevice: bool) =
  gdk_window_set_support_multidevice(cast[ptr Window00](self.impl), gboolean(supportMultidevice))

proc gdk_window_set_title(self: ptr Window00; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: Window; title: cstring) =
  gdk_window_set_title(cast[ptr Window00](self.impl), title)

proc `title=`*(self: Window; title: cstring) =
  gdk_window_set_title(cast[ptr Window00](self.impl), title)

proc gdk_window_set_transient_for(self: ptr Window00; parent: ptr Window00) {.
    importc, libprag.}

proc setTransientFor*(self: Window; parent: Window) =
  gdk_window_set_transient_for(cast[ptr Window00](self.impl), cast[ptr Window00](parent.impl))

proc `transientFor=`*(self: Window; parent: Window) =
  gdk_window_set_transient_for(cast[ptr Window00](self.impl), cast[ptr Window00](parent.impl))

proc gdk_window_set_urgency_hint(self: ptr Window00; urgent: gboolean) {.
    importc, libprag.}

proc setUrgencyHint*(self: Window; urgent: bool = true) =
  gdk_window_set_urgency_hint(cast[ptr Window00](self.impl), gboolean(urgent))

proc `urgencyHint=`*(self: Window; urgent: bool) =
  gdk_window_set_urgency_hint(cast[ptr Window00](self.impl), gboolean(urgent))

proc gdk_window_set_user_data(self: ptr Window00; userData: ptr gobject.Object00) {.
    importc, libprag.}

proc setUserData*(self: Window; userData: gobject.Object = nil) =
  gdk_window_set_user_data(cast[ptr Window00](self.impl), if userData.isNil: nil else: cast[ptr gobject.Object00](userData.impl))

proc `userData=`*(self: Window; userData: gobject.Object = nil) =
  gdk_window_set_user_data(cast[ptr Window00](self.impl), if userData.isNil: nil else: cast[ptr gobject.Object00](userData.impl))

proc gdk_window_shape_combine_region(self: ptr Window00; shapeRegion: ptr cairo.Region00;
    offsetX: int32; offsetY: int32) {.
    importc, libprag.}

proc shapeCombineRegion*(self: Window; shapeRegion: cairo.Region = nil;
    offsetX: int; offsetY: int) =
  gdk_window_shape_combine_region(cast[ptr Window00](self.impl), if shapeRegion.isNil: nil else: cast[ptr cairo.Region00](shapeRegion.impl), int32(offsetX), int32(offsetY))

proc gdk_window_show(self: ptr Window00) {.
    importc, libprag.}

proc show*(self: Window) =
  gdk_window_show(cast[ptr Window00](self.impl))

proc gdk_window_show_unraised(self: ptr Window00) {.
    importc, libprag.}

proc showUnraised*(self: Window) =
  gdk_window_show_unraised(cast[ptr Window00](self.impl))

proc gdk_window_stick(self: ptr Window00) {.
    importc, libprag.}

proc stick*(self: Window) =
  gdk_window_stick(cast[ptr Window00](self.impl))

proc gdk_window_thaw_toplevel_updates_libgtk_only(self: ptr Window00) {.
    importc, libprag.}

proc thawToplevelUpdatesLibgtkOnly*(self: Window) =
  gdk_window_thaw_toplevel_updates_libgtk_only(cast[ptr Window00](self.impl))

proc gdk_window_thaw_updates(self: ptr Window00) {.
    importc, libprag.}

proc thawUpdates*(self: Window) =
  gdk_window_thaw_updates(cast[ptr Window00](self.impl))

proc gdk_window_unfullscreen(self: ptr Window00) {.
    importc, libprag.}

proc unfullscreen*(self: Window) =
  gdk_window_unfullscreen(cast[ptr Window00](self.impl))

proc gdk_window_unmaximize(self: ptr Window00) {.
    importc, libprag.}

proc unmaximize*(self: Window) =
  gdk_window_unmaximize(cast[ptr Window00](self.impl))

proc gdk_window_unstick(self: ptr Window00) {.
    importc, libprag.}

proc unstick*(self: Window) =
  gdk_window_unstick(cast[ptr Window00](self.impl))

proc gdk_window_withdraw(self: ptr Window00) {.
    importc, libprag.}

proc withdraw*(self: Window) =
  gdk_window_withdraw(cast[ptr Window00](self.impl))

proc gdk_device_grab_info_libgtk_only(display: ptr Display00; device: ptr Device00;
    grabWindow: var ptr Window00; ownerEvents: var gboolean): gboolean {.
    importc, libprag.}

proc grabInfoLibgtkOnly*(display: Display; device: Device; grabWindow: var Window;
    ownerEvents: var bool): bool =
  var tmpoutgobjectarg: ptr Window00
  var ownerEvents_00: gboolean
  result = toBool(gdk_device_grab_info_libgtk_only(cast[ptr Display00](display.impl), cast[ptr Device00](device.impl), tmpoutgobjectarg, ownerEvents_00))
  if ownerEvents.addr != nil:
    ownerEvents = toBool(ownerEvents_00)
#  dothemagic(grabWindow
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    grabWindow = cast[type(grabWindow)](argqdata)
    assert(grabWindow.impl == tmpoutgobjectarg)
  else:
    fnew(grabWindow, gdk.finalizeGObject)
    grabWindow.impl = tmpoutgobjectarg
    GC_ref(grabWindow)
    if g_object_is_floating(grabWindow.impl).int != 0:
      discard g_object_ref_sink(grabWindow.impl)
    g_object_add_toggle_ref(grabWindow.impl, toggleNotify, addr(grabWindow[]))
    g_object_unref(grabWindow.impl)
    assert(g_object_get_qdata(grabWindow.impl, Quark) == nil)
    g_object_set_qdata(grabWindow.impl, Quark, addr(grabWindow[]))


proc gdk_device_get_last_event_window(self: ptr Device00): ptr Window00 {.
    importc, libprag.}

proc getLastEventWindow*(self: Device): Window =
  let gobj = gdk_device_get_last_event_window(cast[ptr Device00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc lastEventWindow*(self: Device): Window =
  let gobj = gdk_device_get_last_event_window(cast[ptr Device00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_device_get_window_at_position(self: ptr Device00; winX: var int32;
    winY: var int32): ptr Window00 {.
    importc, libprag.}

proc getWindowAtPosition*(self: Device; winX: var int = cast[var int](nil);
    winY: var int = cast[var int](nil)): Window =
  var winY_00: int32
  var winX_00: int32
  let gobj = gdk_device_get_window_at_position(cast[ptr Device00](self.impl), winX_00, winY_00)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  if winY.addr != nil:
    winY = int(winY_00)
  if winX.addr != nil:
    winX = int(winX_00)

proc gdk_device_get_window_at_position_double(self: ptr Device00; winX: var cdouble;
    winY: var cdouble): ptr Window00 {.
    importc, libprag.}

proc getWindowAtPositionDouble*(self: Device; winX: var cdouble = cast[var cdouble](nil);
    winY: var cdouble = cast[var cdouble](nil)): Window =
  let gobj = gdk_device_get_window_at_position_double(cast[ptr Device00](self.impl), winX, winY)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_default_group(self: ptr Display00): ptr Window00 {.
    importc, libprag.}

proc getDefaultGroup*(self: Display): Window =
  let gobj = gdk_display_get_default_group(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultGroup*(self: Display): Window =
  let gobj = gdk_display_get_default_group(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_monitor_at_window(self: ptr Display00; window: ptr Window00): ptr Monitor00 {.
    importc, libprag.}

proc getMonitorAtWindow*(self: Display; window: Window): Monitor =
  let gobj = gdk_display_get_monitor_at_window(cast[ptr Display00](self.impl), cast[ptr Window00](window.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_window_at_pointer(self: ptr Display00; winX: var int32;
    winY: var int32): ptr Window00 {.
    importc, libprag.}

proc getWindowAtPointer*(self: Display; winX: var int = cast[var int](nil);
    winY: var int = cast[var int](nil)): Window =
  var winY_00: int32
  var winX_00: int32
  let gobj = gdk_display_get_window_at_pointer(cast[ptr Display00](self.impl), winX_00, winY_00)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  if winY.addr != nil:
    winY = int(winY_00)
  if winX.addr != nil:
    winX = int(winX_00)

proc gdk_display_store_clipboard(self: ptr Display00; clipboardWindow: ptr Window00;
    time: uint32; targets: ptr ptr Atom00; nTargets: int32) {.
    importc, libprag.}

proc storeClipboard*(self: Display; clipboardWindow: Window;
    time: int; targets: ptr ptr Atom00; nTargets: int) =
  gdk_display_store_clipboard(cast[ptr Display00](self.impl), cast[ptr Window00](clipboardWindow.impl), uint32(time), targets, int32(nTargets))

type
  GrabOwnership* {.size: sizeof(cint), pure.} = enum
    none = 0
    window = 1
    application = 2

type
  WindowAttr00* {.pure.} = object
  WindowAttr* = ref object
    impl*: ptr WindowAttr00
    ignoreFinalizer*: bool

type
  WindowAttributesType* {.size: sizeof(cint), pure.} = enum
    title = 2
    x = 4
    y = 8
    cursor = 16
    visual = 32
    wmclass = 64
    noredir = 128
    typeHint = 256

proc gdk_window_new(parent: ptr Window00; attributes: ptr WindowAttr00; attributesMask: WindowAttributesType): ptr Window00 {.
    importc, libprag.}

proc newWindow*(parent: Window = nil; attributes: WindowAttr; attributesMask: WindowAttributesType): Window =
  let gobj = gdk_window_new(if parent.isNil: nil else: cast[ptr Window00](parent.impl), cast[ptr WindowAttr00](attributes.impl), attributesMask)
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

proc newWindow*(tdesc: typedesc; parent: Window = nil; attributes: WindowAttr; attributesMask: WindowAttributesType): tdesc =
  assert(result is Window)
  let gobj = gdk_window_new(if parent.isNil: nil else: cast[ptr Window00](parent.impl), cast[ptr WindowAttr00](attributes.impl), attributesMask)
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

proc initWindow*[T](result: var T; parent: Window = nil; attributes: WindowAttr; attributesMask: WindowAttributesType) {.deprecated.} =
  assert(result is Window)
  let gobj = gdk_window_new(if parent.isNil: nil else: cast[ptr Window00](parent.impl), cast[ptr WindowAttr00](attributes.impl), attributesMask)
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

type
  WindowEdge* {.size: sizeof(cint), pure.} = enum
    northWest = 0
    north = 1
    northEast = 2
    west = 3
    east = 4
    southWest = 5
    south = 6
    southEast = 7

proc gdk_window_begin_resize_drag(self: ptr Window00; edge: WindowEdge; button: int32;
    rootX: int32; rootY: int32; timestamp: uint32) {.
    importc, libprag.}

proc beginResizeDrag*(self: Window; edge: WindowEdge; button: int;
    rootX: int; rootY: int; timestamp: int) =
  gdk_window_begin_resize_drag(cast[ptr Window00](self.impl), edge, int32(button), int32(rootX), int32(rootY), uint32(timestamp))

proc gdk_window_begin_resize_drag_for_device(self: ptr Window00; edge: WindowEdge;
    device: ptr Device00; button: int32; rootX: int32; rootY: int32; timestamp: uint32) {.
    importc, libprag.}

proc beginResizeDragForDevice*(self: Window; edge: WindowEdge;
    device: Device; button: int; rootX: int; rootY: int; timestamp: int) =
  gdk_window_begin_resize_drag_for_device(cast[ptr Window00](self.impl), edge, cast[ptr Device00](device.impl), int32(button), int32(rootX), int32(rootY), uint32(timestamp))

type
  GLContext* = ref object of gobject.Object
  GLContext00* = object of gobject.Object00

proc gdk_gl_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc clearCurrent*() {.
    importc: "gdk_gl_context_clear_current", libprag.}

proc gdk_gl_context_get_current(): ptr GLContext00 {.
    importc, libprag.}

proc getCurrentGLContext*(): GLContext =
  let gobj = gdk_gl_context_get_current()
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_gl_context_get_debug_enabled(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc getDebugEnabled*(self: GLContext): bool =
  toBool(gdk_gl_context_get_debug_enabled(cast[ptr GLContext00](self.impl)))

proc debugEnabled*(self: GLContext): bool =
  toBool(gdk_gl_context_get_debug_enabled(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_display(self: ptr GLContext00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: GLContext): Display =
  let gobj = gdk_gl_context_get_display(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: GLContext): Display =
  let gobj = gdk_gl_context_get_display(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_gl_context_get_forward_compatible(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc getForwardCompatible*(self: GLContext): bool =
  toBool(gdk_gl_context_get_forward_compatible(cast[ptr GLContext00](self.impl)))

proc forwardCompatible*(self: GLContext): bool =
  toBool(gdk_gl_context_get_forward_compatible(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_required_version(self: ptr GLContext00; major: var int32;
    minor: var int32) {.
    importc, libprag.}

proc getRequiredVersion*(self: GLContext; major: var int;
    minor: var int) =
  var major_00: int32
  var minor_00: int32
  gdk_gl_context_get_required_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gdk_gl_context_get_shared_context(self: ptr GLContext00): ptr GLContext00 {.
    importc, libprag.}

proc getSharedContext*(self: GLContext): GLContext =
  let gobj = gdk_gl_context_get_shared_context(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sharedContext*(self: GLContext): GLContext =
  let gobj = gdk_gl_context_get_shared_context(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_gl_context_get_use_es(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc getUseEs*(self: GLContext): bool =
  toBool(gdk_gl_context_get_use_es(cast[ptr GLContext00](self.impl)))

proc useEs*(self: GLContext): bool =
  toBool(gdk_gl_context_get_use_es(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_version(self: ptr GLContext00; major: var int32;
    minor: var int32) {.
    importc, libprag.}

proc getVersion*(self: GLContext; major: var int; minor: var int) =
  var major_00: int32
  var minor_00: int32
  gdk_gl_context_get_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gdk_gl_context_get_window(self: ptr GLContext00): ptr Window00 {.
    importc, libprag.}

proc getWindow*(self: GLContext): Window =
  let gobj = gdk_gl_context_get_window(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc window*(self: GLContext): Window =
  let gobj = gdk_gl_context_get_window(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_gl_context_is_legacy(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc isLegacy*(self: GLContext): bool =
  toBool(gdk_gl_context_is_legacy(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_make_current(self: ptr GLContext00) {.
    importc, libprag.}

proc makeCurrent*(self: GLContext) =
  gdk_gl_context_make_current(cast[ptr GLContext00](self.impl))

proc gdk_gl_context_realize(self: ptr GLContext00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc realize*(self: GLContext): bool =
  var gerror: ptr glib.Error
  let resul0 = gdk_gl_context_realize(cast[ptr GLContext00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gdk_gl_context_set_debug_enabled(self: ptr GLContext00; enabled: gboolean) {.
    importc, libprag.}

proc setDebugEnabled*(self: GLContext; enabled: bool = true) =
  gdk_gl_context_set_debug_enabled(cast[ptr GLContext00](self.impl), gboolean(enabled))

proc `debugEnabled=`*(self: GLContext; enabled: bool) =
  gdk_gl_context_set_debug_enabled(cast[ptr GLContext00](self.impl), gboolean(enabled))

proc gdk_gl_context_set_forward_compatible(self: ptr GLContext00; compatible: gboolean) {.
    importc, libprag.}

proc setForwardCompatible*(self: GLContext; compatible: bool = true) =
  gdk_gl_context_set_forward_compatible(cast[ptr GLContext00](self.impl), gboolean(compatible))

proc `forwardCompatible=`*(self: GLContext; compatible: bool) =
  gdk_gl_context_set_forward_compatible(cast[ptr GLContext00](self.impl), gboolean(compatible))

proc gdk_gl_context_set_required_version(self: ptr GLContext00; major: int32;
    minor: int32) {.
    importc, libprag.}

proc setRequiredVersion*(self: GLContext; major: int; minor: int) =
  gdk_gl_context_set_required_version(cast[ptr GLContext00](self.impl), int32(major), int32(minor))

proc gdk_gl_context_set_use_es(self: ptr GLContext00; useEs: int32) {.
    importc, libprag.}

proc setUseEs*(self: GLContext; useEs: int) =
  gdk_gl_context_set_use_es(cast[ptr GLContext00](self.impl), int32(useEs))

proc `useEs=`*(self: GLContext; useEs: int) =
  gdk_gl_context_set_use_es(cast[ptr GLContext00](self.impl), int32(useEs))

proc gdk_window_create_gl_context(self: ptr Window00; error: ptr ptr glib.Error = nil): ptr GLContext00 {.
    importc, libprag.}

proc createGlContext*(self: Window): GLContext =
  var gerror: ptr glib.Error
  let gobj = gdk_window_create_gl_context(cast[ptr Window00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

type
  DrawingContext* = ref object of gobject.Object
  DrawingContext00* = object of gobject.Object00

proc gdk_drawing_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DrawingContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_drawing_context_get_cairo_context(self: ptr DrawingContext00): ptr cairo.Context00 {.
    importc, libprag.}

proc getCairoContext*(self: DrawingContext): cairo.Context =
  fnew(result, gBoxedFreeCairoContext)
  result.impl = gdk_drawing_context_get_cairo_context(cast[ptr DrawingContext00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_context_get_type(), result.impl))

proc cairoContext*(self: DrawingContext): cairo.Context =
  fnew(result, gBoxedFreeCairoContext)
  result.impl = gdk_drawing_context_get_cairo_context(cast[ptr DrawingContext00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_context_get_type(), result.impl))

proc gdk_drawing_context_get_clip(self: ptr DrawingContext00): ptr cairo.Region00 {.
    importc, libprag.}

proc getClip*(self: DrawingContext): cairo.Region =
  let impl0 = gdk_drawing_context_get_clip(cast[ptr DrawingContext00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = impl0

proc clip*(self: DrawingContext): cairo.Region =
  let impl0 = gdk_drawing_context_get_clip(cast[ptr DrawingContext00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = impl0

proc gdk_drawing_context_get_window(self: ptr DrawingContext00): ptr Window00 {.
    importc, libprag.}

proc getWindow*(self: DrawingContext): Window =
  let gobj = gdk_drawing_context_get_window(cast[ptr DrawingContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc window*(self: DrawingContext): Window =
  let gobj = gdk_drawing_context_get_window(cast[ptr DrawingContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_drawing_context_is_valid(self: ptr DrawingContext00): gboolean {.
    importc, libprag.}

proc isValid*(self: DrawingContext): bool =
  toBool(gdk_drawing_context_is_valid(cast[ptr DrawingContext00](self.impl)))

proc gdk_window_begin_draw_frame(self: ptr Window00; region: ptr cairo.Region00): ptr DrawingContext00 {.
    importc, libprag.}

proc beginDrawFrame*(self: Window; region: cairo.Region): DrawingContext =
  let gobj = gdk_window_begin_draw_frame(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_end_draw_frame(self: ptr Window00; context: ptr DrawingContext00) {.
    importc, libprag.}

proc endDrawFrame*(self: Window; context: DrawingContext) =
  gdk_window_end_draw_frame(cast[ptr Window00](self.impl), cast[ptr DrawingContext00](context.impl))

type
  DragProtocol* {.size: sizeof(cint), pure.} = enum
    none = 0
    motif = 1
    xdnd = 2
    rootwin = 3
    win32Dropfiles = 4
    ole2 = 5
    local = 6
    wayland = 7

proc gdk_window_get_drag_protocol(self: ptr Window00; target: var ptr Window00): DragProtocol {.
    importc, libprag.}

proc getDragProtocol*(self: Window; target: var Window = cast[var Window](nil)): DragProtocol =
  var tmpoutgobjectarg: ptr Window00
  result = gdk_window_get_drag_protocol(cast[ptr Window00](self.impl), cast[var ptr Window00](if addr(target) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(target
  if addr(target) != nil:
    target = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      target = cast[type(target)](argqdata)
      assert(target.impl == tmpoutgobjectarg)
    else:
      fnew(target, gdk.finalizeGObject)
      target.impl = tmpoutgobjectarg
      GC_ref(target)
      if g_object_is_floating(target.impl).int != 0:
        discard g_object_ref_sink(target.impl)
      g_object_add_toggle_ref(target.impl, toggleNotify, addr(target[]))
      g_object_unref(target.impl)
      assert(g_object_get_qdata(target.impl, Quark) == nil)
      g_object_set_qdata(target.impl, Quark, addr(target[]))


type
  FrameClock* = ref object of gobject.Object
  FrameClock00* = object of gobject.Object00

proc gdk_frame_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FrameClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAfterPaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "after-paint", cast[GCallback](p), xdata, nil, cf)

proc scBeforePaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "before-paint", cast[GCallback](p), xdata, nil, cf)

proc scFlushEvents*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "flush-events", cast[GCallback](p), xdata, nil, cf)

proc scLayout*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "layout", cast[GCallback](p), xdata, nil, cf)

proc scPaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "paint", cast[GCallback](p), xdata, nil, cf)

proc scResumeEvents*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "resume-events", cast[GCallback](p), xdata, nil, cf)

proc scUpdate*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "update", cast[GCallback](p), xdata, nil, cf)

proc gdk_frame_clock_begin_updating(self: ptr FrameClock00) {.
    importc, libprag.}

proc beginUpdating*(self: FrameClock) =
  gdk_frame_clock_begin_updating(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_end_updating(self: ptr FrameClock00) {.
    importc, libprag.}

proc endUpdating*(self: FrameClock) =
  gdk_frame_clock_end_updating(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_frame_counter(self: ptr FrameClock00): int64 {.
    importc, libprag.}

proc getFrameCounter*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_counter(cast[ptr FrameClock00](self.impl))

proc frameCounter*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_counter(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_frame_time(self: ptr FrameClock00): int64 {.
    importc, libprag.}

proc getFrameTime*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_time(cast[ptr FrameClock00](self.impl))

proc frameTime*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_time(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_history_start(self: ptr FrameClock00): int64 {.
    importc, libprag.}

proc getHistoryStart*(self: FrameClock): int64 =
  gdk_frame_clock_get_history_start(cast[ptr FrameClock00](self.impl))

proc historyStart*(self: FrameClock): int64 =
  gdk_frame_clock_get_history_start(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_refresh_info(self: ptr FrameClock00; baseTime: int64;
    refreshIntervalReturn: var int64; presentationTimeReturn: var int64) {.
    importc, libprag.}

proc getRefreshInfo*(self: FrameClock; baseTime: int64;
    refreshIntervalReturn: var int64 = cast[var int64](nil); presentationTimeReturn: var int64) =
  gdk_frame_clock_get_refresh_info(cast[ptr FrameClock00](self.impl), baseTime, refreshIntervalReturn, presentationTimeReturn)

proc gdk_window_get_frame_clock(self: ptr Window00): ptr FrameClock00 {.
    importc, libprag.}

proc getFrameClock*(self: Window): FrameClock =
  let gobj = gdk_window_get_frame_clock(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc frameClock*(self: Window): FrameClock =
  let gobj = gdk_window_get_frame_clock(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  FrameTimings00* {.pure.} = object
  FrameTimings* = ref object
    impl*: ptr FrameTimings00
    ignoreFinalizer*: bool

proc gdk_frame_timings_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkFrameTimings*(self: FrameTimings) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_frame_timings_get_type(), cast[ptr FrameTimings00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FrameTimings()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_frame_timings_get_type(), cast[ptr FrameTimings00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FrameTimings) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkFrameTimings)

proc gdk_frame_timings_unref(self: ptr FrameTimings00) {.
    importc, libprag.}

proc unref*(self: FrameTimings) =
  gdk_frame_timings_unref(cast[ptr FrameTimings00](self.impl))

proc finalizerunref*(self: FrameTimings) =
  if not self.ignoreFinalizer:
    gdk_frame_timings_unref(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_frame_counter(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getFrameCounter*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_counter(cast[ptr FrameTimings00](self.impl))

proc frameCounter*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_counter(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_frame_time(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getFrameTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_time(cast[ptr FrameTimings00](self.impl))

proc frameTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_predicted_presentation_time(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getPredictedPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_predicted_presentation_time(cast[ptr FrameTimings00](self.impl))

proc predictedPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_predicted_presentation_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_presentation_time(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_presentation_time(cast[ptr FrameTimings00](self.impl))

proc presentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_presentation_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_refresh_interval(self: ptr FrameTimings00): int64 {.
    importc, libprag.}

proc getRefreshInterval*(self: FrameTimings): int64 =
  gdk_frame_timings_get_refresh_interval(cast[ptr FrameTimings00](self.impl))

proc refreshInterval*(self: FrameTimings): int64 =
  gdk_frame_timings_get_refresh_interval(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_ref(self: ptr FrameTimings00): ptr FrameTimings00 {.
    importc, libprag.}

proc `ref`*(self: FrameTimings): FrameTimings =
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = gdk_frame_timings_ref(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_complete(self: ptr FrameTimings00): gboolean {.
    importc, libprag.}

proc getComplete*(self: FrameTimings): bool =
  toBool(gdk_frame_timings_get_complete(cast[ptr FrameTimings00](self.impl)))

proc complete*(self: FrameTimings): bool =
  toBool(gdk_frame_timings_get_complete(cast[ptr FrameTimings00](self.impl)))

proc gdk_frame_clock_get_current_timings(self: ptr FrameClock00): ptr FrameTimings00 {.
    importc, libprag.}

proc getCurrentTimings*(self: FrameClock): FrameTimings =
  let impl0 = gdk_frame_clock_get_current_timings(cast[ptr FrameClock00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_frame_timings_get_type(), impl0))

proc currentTimings*(self: FrameClock): FrameTimings =
  let impl0 = gdk_frame_clock_get_current_timings(cast[ptr FrameClock00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_frame_timings_get_type(), impl0))

proc gdk_frame_clock_get_timings(self: ptr FrameClock00; frameCounter: int64): ptr FrameTimings00 {.
    importc, libprag.}

proc getTimings*(self: FrameClock; frameCounter: int64): FrameTimings =
  let impl0 = gdk_frame_clock_get_timings(cast[ptr FrameClock00](self.impl), frameCounter)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkFrameTimings)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_frame_timings_get_type(), impl0))

type
  FrameClockPhase* {.size: sizeof(cint), pure.} = enum
    none = 0
    flushEvents = 1
    beforePaint = 2
    update = 4
    layout = 8
    paint = 16
    resumeEvents = 32
    afterPaint = 64

proc gdk_frame_clock_request_phase(self: ptr FrameClock00; phase: FrameClockPhase) {.
    importc, libprag.}

proc requestPhase*(self: FrameClock; phase: FrameClockPhase) =
  gdk_frame_clock_request_phase(cast[ptr FrameClock00](self.impl), phase)

type
  WindowState* {.size: sizeof(cint), pure.} = enum
    withdrawn = 1
    iconified = 2
    maximized = 4
    sticky = 8
    fullscreen = 16
    above = 32
    below = 64
    focused = 128
    tiled = 256
    topTiled = 512
    topResizable = 1024
    rightTiled = 2048
    rightResizable = 4096
    bottomTiled = 8192
    bottomResizable = 16384
    leftTiled = 32768
    leftResizable = 65536

proc gdk_window_get_state(self: ptr Window00): WindowState {.
    importc, libprag.}

proc getState*(self: Window): WindowState =
  gdk_window_get_state(cast[ptr Window00](self.impl))

proc state*(self: Window): WindowState =
  gdk_window_get_state(cast[ptr Window00](self.impl))

type
  Visual* = ref object of gobject.Object
  Visual00* = object of gobject.Object00

proc gdk_visual_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Visual()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_visual_get_best(): ptr Visual00 {.
    importc, libprag.}

proc getBestVisual*(): Visual =
  let gobj = gdk_visual_get_best()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_visual_get_best_depth(): int32 {.
    importc, libprag.}

proc getBestDepth*(): int =
  int(gdk_visual_get_best_depth())

proc gdk_visual_get_best_with_depth(depth: int32): ptr Visual00 {.
    importc, libprag.}

proc getBestWithDepth*(depth: int): Visual =
  let gobj = gdk_visual_get_best_with_depth(int32(depth))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc bestWithDepth*(depth: int): Visual =
  let gobj = gdk_visual_get_best_with_depth(int32(depth))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_visual_get_system(): ptr Visual00 {.
    importc, libprag.}

proc getSystemVisual*(): Visual =
  let gobj = gdk_visual_get_system()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_visual_get_bits_per_rgb(self: ptr Visual00): int32 {.
    importc, libprag.}

proc getBitsPerRgb*(self: Visual): int =
  int(gdk_visual_get_bits_per_rgb(cast[ptr Visual00](self.impl)))

proc bitsPerRgb*(self: Visual): int =
  int(gdk_visual_get_bits_per_rgb(cast[ptr Visual00](self.impl)))

proc gdk_visual_get_blue_pixel_details(self: ptr Visual00; mask: var uint32;
    shift: var int32; precision: var int32) {.
    importc, libprag.}

proc getBluePixelDetails*(self: Visual; mask: var int = cast[var int](nil);
    shift: var int = cast[var int](nil); precision: var int = cast[var int](nil)) =
  var shift_00: int32
  var precision_00: int32
  var mask_00: uint32
  gdk_visual_get_blue_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  if shift.addr != nil:
    shift = int(shift_00)
  if precision.addr != nil:
    precision = int(precision_00)
  if mask.addr != nil:
    mask = int(mask_00)

proc gdk_visual_get_colormap_size(self: ptr Visual00): int32 {.
    importc, libprag.}

proc getColormapSize*(self: Visual): int =
  int(gdk_visual_get_colormap_size(cast[ptr Visual00](self.impl)))

proc colormapSize*(self: Visual): int =
  int(gdk_visual_get_colormap_size(cast[ptr Visual00](self.impl)))

proc gdk_visual_get_depth(self: ptr Visual00): int32 {.
    importc, libprag.}

proc getDepth*(self: Visual): int =
  int(gdk_visual_get_depth(cast[ptr Visual00](self.impl)))

proc depth*(self: Visual): int =
  int(gdk_visual_get_depth(cast[ptr Visual00](self.impl)))

proc gdk_visual_get_green_pixel_details(self: ptr Visual00; mask: var uint32;
    shift: var int32; precision: var int32) {.
    importc, libprag.}

proc getGreenPixelDetails*(self: Visual; mask: var int = cast[var int](nil);
    shift: var int = cast[var int](nil); precision: var int = cast[var int](nil)) =
  var shift_00: int32
  var precision_00: int32
  var mask_00: uint32
  gdk_visual_get_green_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  if shift.addr != nil:
    shift = int(shift_00)
  if precision.addr != nil:
    precision = int(precision_00)
  if mask.addr != nil:
    mask = int(mask_00)

proc gdk_visual_get_red_pixel_details(self: ptr Visual00; mask: var uint32;
    shift: var int32; precision: var int32) {.
    importc, libprag.}

proc getRedPixelDetails*(self: Visual; mask: var int = cast[var int](nil);
    shift: var int = cast[var int](nil); precision: var int = cast[var int](nil)) =
  var shift_00: int32
  var precision_00: int32
  var mask_00: uint32
  gdk_visual_get_red_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  if shift.addr != nil:
    shift = int(shift_00)
  if precision.addr != nil:
    precision = int(precision_00)
  if mask.addr != nil:
    mask = int(mask_00)

proc gdk_window_get_visual(self: ptr Window00): ptr Visual00 {.
    importc, libprag.}

proc getVisual*(self: Window): Visual =
  let gobj = gdk_window_get_visual(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc visual*(self: Window): Visual =
  let gobj = gdk_window_get_visual(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ByteOrder* {.size: sizeof(cint), pure.} = enum
    lsbFirst = 0
    msbFirst = 1

proc gdk_visual_get_byte_order(self: ptr Visual00): ByteOrder {.
    importc, libprag.}

proc getByteOrder*(self: Visual): ByteOrder =
  gdk_visual_get_byte_order(cast[ptr Visual00](self.impl))

proc byteOrder*(self: Visual): ByteOrder =
  gdk_visual_get_byte_order(cast[ptr Visual00](self.impl))

type
  VisualType* {.size: sizeof(cint), pure.} = enum
    staticGray = 0
    grayscale = 1
    staticColor = 2
    pseudoColor = 3
    trueColor = 4
    directColor = 5

proc getBestType*(): VisualType {.
    importc: "gdk_visual_get_best_type", libprag.}

proc gdk_visual_get_best_with_both(depth: int32; visualType: VisualType): ptr Visual00 {.
    importc, libprag.}

proc getBestWithBoth*(depth: int; visualType: VisualType): Visual =
  let gobj = gdk_visual_get_best_with_both(int32(depth), visualType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_visual_get_best_with_type(visualType: VisualType): ptr Visual00 {.
    importc, libprag.}

proc getBestWithType*(visualType: VisualType): Visual =
  let gobj = gdk_visual_get_best_with_type(visualType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc bestWithType*(visualType: VisualType): Visual =
  let gobj = gdk_visual_get_best_with_type(visualType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_visual_get_visual_type(self: ptr Visual00): VisualType {.
    importc, libprag.}

proc getVisualType*(self: Visual): VisualType =
  gdk_visual_get_visual_type(cast[ptr Visual00](self.impl))

proc visualType*(self: Visual): VisualType =
  gdk_visual_get_visual_type(cast[ptr Visual00](self.impl))

type
  WindowType* {.size: sizeof(cint), pure.} = enum
    root = 0
    toplevel = 1
    child = 2
    temp = 3
    foreign = 4
    offscreen = 5
    subsurface = 6

proc gdk_window_get_window_type(self: ptr Window00): WindowType {.
    importc, libprag.}

proc getWindowType*(self: Window): WindowType =
  gdk_window_get_window_type(cast[ptr Window00](self.impl))

proc windowType*(self: Window): WindowType =
  gdk_window_get_window_type(cast[ptr Window00](self.impl))

type
  Color* {.pure, byRef.} = object
    pixel*: uint32
    red*: uint16
    green*: uint16
    blue*: uint16

proc gdk_color_get_type*(): GType {.importc, libprag.}

proc gdk_color_free(self: Color) {.
    importc, libprag.}

proc free*(self: Color) =
  gdk_color_free(self)

proc gdk_color_equal(self: Color; colorb: Color): gboolean {.
    importc, libprag.}

proc equal*(self: Color; colorb: Color): bool =
  toBool(gdk_color_equal(self, colorb))

proc gdk_color_copy(self: Color): ptr Color {.
    importc, libprag.}

proc copy*(self: Color): ptr Color =
  gdk_color_copy(self)

proc gdk_color_hash(self: Color): uint32 {.
    importc, libprag.}

proc hash*(self: Color): int =
  int(gdk_color_hash(self))

proc gdk_color_to_string(self: Color): cstring {.
    importc, libprag.}

proc toString*(self: Color): string =
  let resul0 = gdk_color_to_string(self)
  result = $resul0
  cogfree(resul0)

proc gdk_color_parse(spec: cstring; color: var Color): gboolean {.
    importc, libprag.}

proc parse*(spec: cstring; color: var Color): bool =
  toBool(gdk_color_parse(spec, color))

proc gdk_window_set_background(self: ptr Window00; color: Color) {.
    importc, libprag.}

proc setBackground*(self: Window; color: Color) =
  gdk_window_set_background(cast[ptr Window00](self.impl), color)

proc `background=`*(self: Window; color: Color) =
  gdk_window_set_background(cast[ptr Window00](self.impl), color)

type
  RGBA* {.pure, byRef.} = object
    red*: cdouble
    green*: cdouble
    blue*: cdouble
    alpha*: cdouble

proc gdk_rgba_get_type*(): GType {.importc, libprag.}

proc gdk_rgba_free(self: RGBA) {.
    importc, libprag.}

proc free*(self: RGBA) =
  gdk_rgba_free(self)

proc gdk_rgba_equal(self: RGBA; p2: RGBA): gboolean {.
    importc, libprag.}

proc equal*(self: RGBA; p2: RGBA): bool =
  toBool(gdk_rgba_equal(self, p2))

proc gdk_rgba_copy(self: RGBA): ptr RGBA {.
    importc, libprag.}

proc copy*(self: RGBA): ptr RGBA =
  gdk_rgba_copy(self)

proc gdk_rgba_hash(self: RGBA): uint32 {.
    importc, libprag.}

proc hash*(self: RGBA): int =
  int(gdk_rgba_hash(self))

proc gdk_rgba_parse(self: RGBA; spec: cstring): gboolean {.
    importc, libprag.}

proc parse*(self: RGBA; spec: cstring): bool =
  toBool(gdk_rgba_parse(self, spec))

proc gdk_rgba_to_string(self: RGBA): cstring {.
    importc, libprag.}

proc toString*(self: RGBA): string =
  let resul0 = gdk_rgba_to_string(self)
  result = $resul0
  cogfree(resul0)

proc gdk_window_set_background_rgba(self: ptr Window00; rgba: RGBA) {.
    importc, libprag.}

proc setBackgroundRgba*(self: Window; rgba: RGBA) =
  gdk_window_set_background_rgba(cast[ptr Window00](self.impl), rgba)

proc `backgroundRgba=`*(self: Window; rgba: RGBA) =
  gdk_window_set_background_rgba(cast[ptr Window00](self.impl), rgba)

type
  WMDecoration* {.size: sizeof(cint), pure.} = enum
    all = 1
    border = 2
    resizeh = 4
    title = 8
    menu = 16
    minimize = 32
    maximize = 64

proc gdk_window_get_decorations(self: ptr Window00; decorations: var WMDecoration): gboolean {.
    importc, libprag.}

proc getDecorations*(self: Window; decorations: var WMDecoration): bool =
  toBool(gdk_window_get_decorations(cast[ptr Window00](self.impl), decorations))

proc gdk_window_set_decorations(self: ptr Window00; decorations: WMDecoration) {.
    importc, libprag.}

proc setDecorations*(self: Window; decorations: WMDecoration) =
  gdk_window_set_decorations(cast[ptr Window00](self.impl), decorations)

proc `decorations=`*(self: Window; decorations: WMDecoration) =
  gdk_window_set_decorations(cast[ptr Window00](self.impl), decorations)

type
  Cursor* = ref object of gobject.Object
  Cursor00* = object of gobject.Object00

proc gdk_cursor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Cursor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gdk_cursor_new_from_name(display: ptr Display00; name: cstring): ptr Cursor00 {.
    importc, libprag.}

proc newCursorFromName*(display: Display; name: cstring): Cursor =
  let gobj = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), name)
  if gobj.isNil:
    return nil
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

proc newCursorFromName*(tdesc: typedesc; display: Display; name: cstring): tdesc =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), name)
  if gobj.isNil:
    return nil
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

proc initCursorFromName*[T](result: var T; display: Display; name: cstring) {.deprecated.} =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), name)
  if gobj.isNil:
    return nil
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

proc gdk_cursor_new_from_pixbuf(display: ptr Display00; pixbuf: ptr gdkpixbuf.Pixbuf00;
    x: int32; y: int32): ptr Cursor00 {.
    importc, libprag.}

proc newCursorFromPixbuf*(display: Display; pixbuf: gdkpixbuf.Pixbuf;
    x: int; y: int): Cursor =
  let gobj = gdk_cursor_new_from_pixbuf(cast[ptr Display00](display.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), int32(x), int32(y))
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

proc newCursorFromPixbuf*(tdesc: typedesc; display: Display; pixbuf: gdkpixbuf.Pixbuf;
    x: int; y: int): tdesc =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_pixbuf(cast[ptr Display00](display.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), int32(x), int32(y))
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

proc initCursorFromPixbuf*[T](result: var T; display: Display; pixbuf: gdkpixbuf.Pixbuf;
    x: int; y: int) {.deprecated.} =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_pixbuf(cast[ptr Display00](display.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), int32(x), int32(y))
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

proc gdk_cursor_new_from_surface(display: ptr Display00; surface: ptr cairo.Surface00;
    x: cdouble; y: cdouble): ptr Cursor00 {.
    importc, libprag.}

proc newCursorFromSurface*(display: Display; surface: cairo.Surface;
    x: cdouble; y: cdouble): Cursor =
  let gobj = gdk_cursor_new_from_surface(cast[ptr Display00](display.impl), cast[ptr cairo.Surface00](surface.impl), x, y)
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

proc newCursorFromSurface*(tdesc: typedesc; display: Display; surface: cairo.Surface;
    x: cdouble; y: cdouble): tdesc =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_surface(cast[ptr Display00](display.impl), cast[ptr cairo.Surface00](surface.impl), x, y)
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

proc initCursorFromSurface*[T](result: var T; display: Display; surface: cairo.Surface;
    x: cdouble; y: cdouble) {.deprecated.} =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_from_surface(cast[ptr Display00](display.impl), cast[ptr cairo.Surface00](surface.impl), x, y)
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

proc gdk_cursor_get_display(self: ptr Cursor00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Cursor): Display =
  let gobj = gdk_cursor_get_display(cast[ptr Cursor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: Cursor): Display =
  let gobj = gdk_cursor_get_display(cast[ptr Cursor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_cursor_get_image(self: ptr Cursor00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getImage*(self: Cursor): gdkpixbuf.Pixbuf =
  let gobj = gdk_cursor_get_image(cast[ptr Cursor00](self.impl))
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

proc image*(self: Cursor): gdkpixbuf.Pixbuf =
  let gobj = gdk_cursor_get_image(cast[ptr Cursor00](self.impl))
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

proc gdk_cursor_get_surface(self: ptr Cursor00; xHot: var cdouble; yHot: var cdouble): ptr cairo.Surface00 {.
    importc, libprag.}

proc getSurface*(self: Cursor; xHot: var cdouble = cast[var cdouble](nil);
    yHot: var cdouble = cast[var cdouble](nil)): cairo.Surface =
  let impl0 = gdk_cursor_get_surface(cast[ptr Cursor00](self.impl), xHot, yHot)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = impl0

proc gdk_cursor_ref(self: ptr Cursor00): ptr Cursor00 {.
    importc, libprag.}

proc `ref`*(self: Cursor): Cursor =
  let gobj = gdk_cursor_ref(cast[ptr Cursor00](self.impl))
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

proc gdk_cursor_unref(self: ptr Cursor00) {.
    importc, libprag.}

proc unref*(self: Cursor) =
  gdk_cursor_unref(cast[ptr Cursor00](self.impl))

proc gdk_window_get_cursor(self: ptr Window00): ptr Cursor00 {.
    importc, libprag.}

proc getCursor*(self: Window): Cursor =
  let gobj = gdk_window_get_cursor(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc cursor*(self: Window): Cursor =
  let gobj = gdk_window_get_cursor(cast[ptr Window00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_get_device_cursor(self: ptr Window00; device: ptr Device00): ptr Cursor00 {.
    importc, libprag.}

proc getDeviceCursor*(self: Window; device: Device): Cursor =
  let gobj = gdk_window_get_device_cursor(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_window_set_cursor(self: ptr Window00; cursor: ptr Cursor00) {.
    importc, libprag.}

proc setCursor*(self: Window; cursor: Cursor = nil) =
  gdk_window_set_cursor(cast[ptr Window00](self.impl), if cursor.isNil: nil else: cast[ptr Cursor00](cursor.impl))

proc `cursor=`*(self: Window; cursor: Cursor = nil) =
  gdk_window_set_cursor(cast[ptr Window00](self.impl), if cursor.isNil: nil else: cast[ptr Cursor00](cursor.impl))

proc gdk_window_set_device_cursor(self: ptr Window00; device: ptr Device00;
    cursor: ptr Cursor00) {.
    importc, libprag.}

proc setDeviceCursor*(self: Window; device: Device; cursor: Cursor) =
  gdk_window_set_device_cursor(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), cast[ptr Cursor00](cursor.impl))

type
  CursorType* {.size: sizeof(cint), pure.} = enum
    blankCursor = -2
    cursorIsPixmap = -1
    xCursor = 0
    arrow = 2
    basedArrowDown = 4
    basedArrowUp = 6
    boat = 8
    bogosity = 10
    bottomLeftCorner = 12
    bottomRightCorner = 14
    bottomSide = 16
    bottomTee = 18
    boxSpiral = 20
    centerPtr = 22
    circle = 24
    clock = 26
    coffeeMug = 28
    cross = 30
    crossReverse = 32
    crosshair = 34
    diamondCross = 36
    dot = 38
    dotbox = 40
    doubleArrow = 42
    draftLarge = 44
    draftSmall = 46
    drapedBox = 48
    exchange = 50
    fleur = 52
    gobbler = 54
    gumby = 56
    hand1 = 58
    hand2 = 60
    heart = 62
    icon = 64
    ironCross = 66
    leftPtr = 68
    leftSide = 70
    leftTee = 72
    leftbutton = 74
    llAngle = 76
    lrAngle = 78
    man = 80
    middlebutton = 82
    mouse = 84
    pencil = 86
    pirate = 88
    plus = 90
    questionArrow = 92
    rightPtr = 94
    rightSide = 96
    rightTee = 98
    rightbutton = 100
    rtlLogo = 102
    sailboat = 104
    sbDownArrow = 106
    sbHDoubleArrow = 108
    sbLeftArrow = 110
    sbRightArrow = 112
    sbUpArrow = 114
    sbVDoubleArrow = 116
    shuttle = 118
    sizing = 120
    spider = 122
    spraycan = 124
    star = 126
    target = 128
    tcross = 130
    topLeftArrow = 132
    topLeftCorner = 134
    topRightCorner = 136
    topSide = 138
    topTee = 140
    trek = 142
    ulAngle = 144
    umbrella = 146
    urAngle = 148
    watch = 150
    xterm = 152
    lastCursor = 153

proc gdk_cursor_new(cursorType: CursorType): ptr Cursor00 {.
    importc, libprag.}

proc newCursor*(cursorType: CursorType): Cursor {.deprecated.}  =
  let gobj = gdk_cursor_new(cursorType)
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

proc newCursor*(tdesc: typedesc; cursorType: CursorType): tdesc {.deprecated.}  =
  assert(result is Cursor)
  let gobj = gdk_cursor_new(cursorType)
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

proc initCursor*[T](result: var T; cursorType: CursorType) {.deprecated.} =
  assert(result is Cursor)
  let gobj = gdk_cursor_new(cursorType)
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

proc gdk_cursor_new_for_display(display: ptr Display00; cursorType: CursorType): ptr Cursor00 {.
    importc, libprag.}

proc newCursorForDisplay*(display: Display; cursorType: CursorType): Cursor =
  let gobj = gdk_cursor_new_for_display(cast[ptr Display00](display.impl), cursorType)
  if gobj.isNil:
    return nil
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

proc newCursorForDisplay*(tdesc: typedesc; display: Display; cursorType: CursorType): tdesc =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_for_display(cast[ptr Display00](display.impl), cursorType)
  if gobj.isNil:
    return nil
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

proc initCursorForDisplay*[T](result: var T; display: Display; cursorType: CursorType) {.deprecated.} =
  assert(result is Cursor)
  let gobj = gdk_cursor_new_for_display(cast[ptr Display00](display.impl), cursorType)
  if gobj.isNil:
    return nil
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

proc gdk_cursor_get_cursor_type(self: ptr Cursor00): CursorType {.
    importc, libprag.}

proc getCursorType*(self: Cursor): CursorType =
  gdk_cursor_get_cursor_type(cast[ptr Cursor00](self.impl))

proc cursorType*(self: Cursor): CursorType =
  gdk_cursor_get_cursor_type(cast[ptr Cursor00](self.impl))

type
  FullscreenMode* {.size: sizeof(cint), pure.} = enum
    currentMonitor = 0
    allMonitors = 1

proc gdk_window_get_fullscreen_mode(self: ptr Window00): FullscreenMode {.
    importc, libprag.}

proc getFullscreenMode*(self: Window): FullscreenMode =
  gdk_window_get_fullscreen_mode(cast[ptr Window00](self.impl))

proc fullscreenMode*(self: Window): FullscreenMode =
  gdk_window_get_fullscreen_mode(cast[ptr Window00](self.impl))

proc gdk_window_set_fullscreen_mode(self: ptr Window00; mode: FullscreenMode) {.
    importc, libprag.}

proc setFullscreenMode*(self: Window; mode: FullscreenMode) =
  gdk_window_set_fullscreen_mode(cast[ptr Window00](self.impl), mode)

proc `fullscreenMode=`*(self: Window; mode: FullscreenMode) =
  gdk_window_set_fullscreen_mode(cast[ptr Window00](self.impl), mode)

type
  WMFunction* {.size: sizeof(cint), pure.} = enum
    all = 1
    resize = 2
    move = 4
    minimize = 8
    maximize = 16
    close = 32

proc gdk_window_set_functions(self: ptr Window00; functions: WMFunction) {.
    importc, libprag.}

proc setFunctions*(self: Window; functions: WMFunction) =
  gdk_window_set_functions(cast[ptr Window00](self.impl), functions)

proc `functions=`*(self: Window; functions: WMFunction) =
  gdk_window_set_functions(cast[ptr Window00](self.impl), functions)

type
  Gravity* {.size: sizeof(cint), pure.} = enum
    northWest = 1
    north = 2
    northEast = 3
    west = 4
    center = 5
    east = 6
    southWest = 7
    south = 8
    southEast = 9
    `static` = 10

type
  Geometry* {.pure, byRef.} = object
    minWidth*: int32
    minHeight*: int32
    maxWidth*: int32
    maxHeight*: int32
    baseWidth*: int32
    baseHeight*: int32
    widthInc*: int32
    heightInc*: int32
    minAspect*: cdouble
    maxAspect*: cdouble
    winGravity*: Gravity

type
  WindowHintsFlag* {.size: sizeof(cint), pure.} = enum
    pos = 0
    minSize = 1
    maxSize = 2
    baseSize = 3
    aspect = 4
    resizeInc = 5
    winGravity = 6
    userPos = 7
    userSize = 8

  WindowHints* {.size: sizeof(cint).} = set[WindowHintsFlag]

proc gdk_window_constrain_size(geometry: Geometry; flags: WindowHints; width: int32;
    height: int32; newWidth: var int32; newHeight: var int32) {.
    importc, libprag.}

proc constrainSize*(geometry: Geometry; flags: WindowHints; width: int;
    height: int; newWidth: var int; newHeight: var int) =
  var newHeight_00: int32
  var newWidth_00: int32
  gdk_window_constrain_size(geometry, flags, int32(width), int32(height), newWidth_00, newHeight_00)
  if newHeight.addr != nil:
    newHeight = int(newHeight_00)
  if newWidth.addr != nil:
    newWidth = int(newWidth_00)

proc gdk_window_set_geometry_hints(self: ptr Window00; geometry: Geometry;
    geomMask: WindowHints) {.
    importc, libprag.}

proc setGeometryHints*(self: Window; geometry: Geometry; geomMask: WindowHints) =
  gdk_window_set_geometry_hints(cast[ptr Window00](self.impl), geometry, geomMask)

type
  EventFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    exposure = 1
    pointerMotion = 2
    pointerMotionHint = 3
    buttonMotion = 4
    button1Motion = 5
    button2Motion = 6
    button3Motion = 7
    buttonPress = 8
    buttonRelease = 9
    keyPress = 10
    keyRelease = 11
    enterNotify = 12
    leaveNotify = 13
    focusChange = 14
    structure = 15
    propertyChange = 16
    visibilityNotify = 17
    proximityIn = 18
    proximityOut = 19
    substructure = 20
    scroll = 21
    touch = 22
    smoothScroll = 23
    touchpadGesture = 24
    tabletPad = 25

  EventMask* {.size: sizeof(cint).} = set[EventFlag]

const AllEventsMask* = {EventFlag.exposure .. EventFlag.smoothScroll}

proc gdk_window_get_device_events(self: ptr Window00; device: ptr Device00): EventMask {.
    importc, libprag.}

proc getDeviceEvents*(self: Window; device: Device): EventMask =
  gdk_window_get_device_events(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl))

proc gdk_window_get_events(self: ptr Window00): EventMask {.
    importc, libprag.}

proc getEvents*(self: Window): EventMask =
  gdk_window_get_events(cast[ptr Window00](self.impl))

proc events*(self: Window): EventMask =
  gdk_window_get_events(cast[ptr Window00](self.impl))

proc gdk_window_get_source_events(self: ptr Window00; source: InputSource): EventMask {.
    importc, libprag.}

proc getSourceEvents*(self: Window; source: InputSource): EventMask =
  gdk_window_get_source_events(cast[ptr Window00](self.impl), source)

proc gdk_window_set_device_events(self: ptr Window00; device: ptr Device00;
    eventMask: EventMask) {.
    importc, libprag.}

proc setDeviceEvents*(self: Window; device: Device; eventMask: EventMask) =
  gdk_window_set_device_events(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), eventMask)

proc gdk_window_set_events(self: ptr Window00; eventMask: EventMask) {.
    importc, libprag.}

proc setEvents*(self: Window; eventMask: EventMask) =
  gdk_window_set_events(cast[ptr Window00](self.impl), eventMask)

proc `events=`*(self: Window; eventMask: EventMask) =
  gdk_window_set_events(cast[ptr Window00](self.impl), eventMask)

proc gdk_window_set_source_events(self: ptr Window00; source: InputSource;
    eventMask: EventMask) {.
    importc, libprag.}

proc setSourceEvents*(self: Window; source: InputSource; eventMask: EventMask) =
  gdk_window_set_source_events(cast[ptr Window00](self.impl), source, eventMask)

type
  GrabStatus* {.size: sizeof(cint), pure.} = enum
    success = 0
    alreadyGrabbed = 1
    invalidTime = 2
    notViewable = 3
    frozen = 4
    failed = 5

proc gdk_device_grab(self: ptr Device00; window: ptr Window00; grabOwnership: GrabOwnership;
    ownerEvents: gboolean; eventMask: EventMask; cursor: ptr Cursor00; time: uint32): GrabStatus {.
    importc, libprag.}

proc grab*(self: Device; window: Window; grabOwnership: GrabOwnership;
    ownerEvents: bool; eventMask: EventMask; cursor: Cursor = nil; time: int): GrabStatus =
  gdk_device_grab(cast[ptr Device00](self.impl), cast[ptr Window00](window.impl), grabOwnership, gboolean(ownerEvents), eventMask, if cursor.isNil: nil else: cast[ptr Cursor00](cursor.impl), uint32(time))

type
  WindowTypeHint* {.size: sizeof(cint), pure.} = enum
    normal = 0
    dialog = 1
    menu = 2
    toolbar = 3
    splashscreen = 4
    utility = 5
    dock = 6
    desktop = 7
    dropdownMenu = 8
    popupMenu = 9
    tooltip = 10
    notification = 11
    combo = 12
    dnd = 13

proc gdk_window_get_type_hint(self: ptr Window00): WindowTypeHint {.
    importc, libprag.}

proc getTypeHint*(self: Window): WindowTypeHint =
  gdk_window_get_type_hint(cast[ptr Window00](self.impl))

proc typeHint*(self: Window): WindowTypeHint =
  gdk_window_get_type_hint(cast[ptr Window00](self.impl))

proc gdk_window_set_type_hint(self: ptr Window00; hint: WindowTypeHint) {.
    importc, libprag.}

proc setTypeHint*(self: Window; hint: WindowTypeHint) =
  gdk_window_set_type_hint(cast[ptr Window00](self.impl), hint)

proc `typeHint=`*(self: Window; hint: WindowTypeHint) =
  gdk_window_set_type_hint(cast[ptr Window00](self.impl), hint)

type
  SubpixelLayout* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    none = 1
    horizontalRgb = 2
    horizontalBgr = 3
    verticalRgb = 4
    verticalBgr = 5

proc gdk_monitor_get_subpixel_layout(self: ptr Monitor00): SubpixelLayout {.
    importc, libprag.}

proc getSubpixelLayout*(self: Monitor): SubpixelLayout =
  gdk_monitor_get_subpixel_layout(cast[ptr Monitor00](self.impl))

proc subpixelLayout*(self: Monitor): SubpixelLayout =
  gdk_monitor_get_subpixel_layout(cast[ptr Monitor00](self.impl))

type
  Rectangle* {.pure, byRef.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32

proc gdk_rectangle_get_type*(): GType {.importc, libprag.}

proc gdk_rectangle_equal(self: Rectangle; rect2: Rectangle): gboolean {.
    importc, libprag.}

proc equal*(self: Rectangle; rect2: Rectangle): bool =
  toBool(gdk_rectangle_equal(self, rect2))

proc gdk_rectangle_intersect(self: Rectangle; src2: Rectangle; dest: var Rectangle): gboolean {.
    importc, libprag.}

proc intersect*(self: Rectangle; src2: Rectangle; dest: var Rectangle = cast[var Rectangle](nil)): bool =
  toBool(gdk_rectangle_intersect(self, src2, dest))

proc gdk_rectangle_union(self: Rectangle; src2: Rectangle; dest: var Rectangle) {.
    importc, libprag.}

proc union*(self: Rectangle; src2: Rectangle; dest: var Rectangle) =
  gdk_rectangle_union(self, src2, dest)

proc gdk_monitor_get_geometry(self: ptr Monitor00; geometry: var Rectangle) {.
    importc, libprag.}

proc getGeometry*(self: Monitor; geometry: var Rectangle) =
  gdk_monitor_get_geometry(cast[ptr Monitor00](self.impl), geometry)

proc getGeometry*(self: Monitor): Rectangle =
  gdk_monitor_get_geometry(cast[ptr Monitor00](self.impl), result)

proc gdk_monitor_get_workarea(self: ptr Monitor00; workarea: var Rectangle) {.
    importc, libprag.}

proc getWorkarea*(self: Monitor; workarea: var Rectangle) =
  gdk_monitor_get_workarea(cast[ptr Monitor00](self.impl), workarea)

proc getWorkarea*(self: Monitor): Rectangle =
  gdk_monitor_get_workarea(cast[ptr Monitor00](self.impl), result)

proc gdk_window_begin_paint_rect(self: ptr Window00; rectangle: Rectangle) {.
    importc, libprag.}

proc beginPaintRect*(self: Window; rectangle: Rectangle) =
  gdk_window_begin_paint_rect(cast[ptr Window00](self.impl), rectangle)

proc gdk_window_get_frame_extents(self: ptr Window00; rect: var Rectangle) {.
    importc, libprag.}

proc getFrameExtents*(self: Window; rect: var Rectangle) =
  gdk_window_get_frame_extents(cast[ptr Window00](self.impl), rect)

proc getFrameExtents*(self: Window): Rectangle =
  gdk_window_get_frame_extents(cast[ptr Window00](self.impl), result)

proc gdk_window_invalidate_rect(self: ptr Window00; rect: Rectangle; invalidateChildren: gboolean) {.
    importc, libprag.}

proc invalidateRect*(self: Window; rect: Rectangle = cast[var Rectangle](nil);
    invalidateChildren: bool) =
  gdk_window_invalidate_rect(cast[ptr Window00](self.impl), rect, gboolean(invalidateChildren))

proc gdk_window_move_to_rect(self: ptr Window00; rect: Rectangle; rectAnchor: Gravity;
    windowAnchor: Gravity; anchorHints: AnchorHints; rectAnchorDx: int32; rectAnchorDy: int32) {.
    importc, libprag.}

proc moveToRect*(self: Window; rect: Rectangle; rectAnchor: Gravity;
    windowAnchor: Gravity; anchorHints: AnchorHints; rectAnchorDx: int; rectAnchorDy: int) =
  gdk_window_move_to_rect(cast[ptr Window00](self.impl), rect, rectAnchor, windowAnchor, anchorHints, int32(rectAnchorDx), int32(rectAnchorDy))

type
  Screen* = ref object of gobject.Object
  Screen00* = object of gobject.Object00

proc gdk_screen_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Screen()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCompositedChanged*(self: Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "composited-changed", cast[GCallback](p), xdata, nil, cf)

proc scMonitorsChanged*(self: Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "monitors-changed", cast[GCallback](p), xdata, nil, cf)

proc scSizeChanged*(self: Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "size-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_screen_get_default(): ptr Screen00 {.
    importc, libprag.}

proc getDefaultScreen*(): Screen =
  let gobj = gdk_screen_get_default()
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_screen_height(): int32 {.
    importc, libprag.}

proc height*(): int =
  int(gdk_screen_height())

proc gdk_screen_height_mm(): int32 {.
    importc, libprag.}

proc heightMm*(): int =
  int(gdk_screen_height_mm())

proc gdk_screen_width(): int32 {.
    importc, libprag.}

proc width*(): int =
  int(gdk_screen_width())

proc gdk_screen_width_mm(): int32 {.
    importc, libprag.}

proc widthMm*(): int =
  int(gdk_screen_width_mm())

proc gdk_screen_get_active_window(self: ptr Screen00): ptr Window00 {.
    importc, libprag.}

proc getActiveWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_active_window(cast[ptr Screen00](self.impl))
  if gobj.isNil:
    return nil
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

proc activeWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_active_window(cast[ptr Screen00](self.impl))
  if gobj.isNil:
    return nil
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

proc gdk_screen_get_display(self: ptr Screen00): ptr Display00 {.
    importc, libprag.}

proc getDisplay*(self: Screen): Display =
  let gobj = gdk_screen_get_display(cast[ptr Screen00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: Screen): Display =
  let gobj = gdk_screen_get_display(cast[ptr Screen00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_screen_get_font_options(self: ptr Screen00): ptr cairo.FontOptions00 {.
    importc, libprag.}

proc getFontOptions*(self: Screen): cairo.FontOptions =
  let impl0 = gdk_screen_get_font_options(cast[ptr Screen00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoFontOptions)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_font_options_get_type(), impl0))

proc fontOptions*(self: Screen): cairo.FontOptions =
  let impl0 = gdk_screen_get_font_options(cast[ptr Screen00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoFontOptions)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_font_options_get_type(), impl0))

proc gdk_screen_get_height(self: ptr Screen00): int32 {.
    importc, libprag.}

proc getHeight*(self: Screen): int =
  int(gdk_screen_get_height(cast[ptr Screen00](self.impl)))

proc height*(self: Screen): int =
  int(gdk_screen_get_height(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_height_mm(self: ptr Screen00): int32 {.
    importc, libprag.}

proc getHeightMm*(self: Screen): int =
  int(gdk_screen_get_height_mm(cast[ptr Screen00](self.impl)))

proc heightMm*(self: Screen): int =
  int(gdk_screen_get_height_mm(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_monitor_at_point(self: ptr Screen00; x: int32; y: int32): int32 {.
    importc, libprag.}

proc getMonitorAtPoint*(self: Screen; x: int; y: int): int =
  int(gdk_screen_get_monitor_at_point(cast[ptr Screen00](self.impl), int32(x), int32(y)))

proc gdk_screen_get_monitor_at_window(self: ptr Screen00; window: ptr Window00): int32 {.
    importc, libprag.}

proc getMonitorAtWindow*(self: Screen; window: Window): int =
  int(gdk_screen_get_monitor_at_window(cast[ptr Screen00](self.impl), cast[ptr Window00](window.impl)))

proc gdk_screen_get_monitor_geometry(self: ptr Screen00; monitorNum: int32;
    dest: var Rectangle) {.
    importc, libprag.}

proc getMonitorGeometry*(self: Screen; monitorNum: int; dest: var Rectangle = cast[var Rectangle](nil)) =
  gdk_screen_get_monitor_geometry(cast[ptr Screen00](self.impl), int32(monitorNum), dest)

proc gdk_screen_get_monitor_height_mm(self: ptr Screen00; monitorNum: int32): int32 {.
    importc, libprag.}

proc getMonitorHeightMm*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_height_mm(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc gdk_screen_get_monitor_plug_name(self: ptr Screen00; monitorNum: int32): cstring {.
    importc, libprag.}

proc getMonitorPlugName*(self: Screen; monitorNum: int): string =
  let resul0 = gdk_screen_get_monitor_plug_name(cast[ptr Screen00](self.impl), int32(monitorNum))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gdk_screen_get_monitor_scale_factor(self: ptr Screen00; monitorNum: int32): int32 {.
    importc, libprag.}

proc getMonitorScaleFactor*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_scale_factor(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc gdk_screen_get_monitor_width_mm(self: ptr Screen00; monitorNum: int32): int32 {.
    importc, libprag.}

proc getMonitorWidthMm*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_width_mm(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc gdk_screen_get_monitor_workarea(self: ptr Screen00; monitorNum: int32;
    dest: var Rectangle) {.
    importc, libprag.}

proc getMonitorWorkarea*(self: Screen; monitorNum: int; dest: var Rectangle = cast[var Rectangle](nil)) =
  gdk_screen_get_monitor_workarea(cast[ptr Screen00](self.impl), int32(monitorNum), dest)

proc gdk_screen_get_n_monitors(self: ptr Screen00): int32 {.
    importc, libprag.}

proc getNMonitors*(self: Screen): int =
  int(gdk_screen_get_n_monitors(cast[ptr Screen00](self.impl)))

proc nMonitors*(self: Screen): int =
  int(gdk_screen_get_n_monitors(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_number(self: ptr Screen00): int32 {.
    importc, libprag.}

proc getNumber*(self: Screen): int =
  int(gdk_screen_get_number(cast[ptr Screen00](self.impl)))

proc number*(self: Screen): int =
  int(gdk_screen_get_number(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_primary_monitor(self: ptr Screen00): int32 {.
    importc, libprag.}

proc getPrimaryMonitor*(self: Screen): int =
  int(gdk_screen_get_primary_monitor(cast[ptr Screen00](self.impl)))

proc primaryMonitor*(self: Screen): int =
  int(gdk_screen_get_primary_monitor(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_resolution(self: ptr Screen00): cdouble {.
    importc, libprag.}

proc getResolution*(self: Screen): cdouble =
  gdk_screen_get_resolution(cast[ptr Screen00](self.impl))

proc resolution*(self: Screen): cdouble =
  gdk_screen_get_resolution(cast[ptr Screen00](self.impl))

proc gdk_screen_get_rgba_visual(self: ptr Screen00): ptr Visual00 {.
    importc, libprag.}

proc getRgbaVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_rgba_visual(cast[ptr Screen00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rgbaVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_rgba_visual(cast[ptr Screen00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_screen_get_root_window(self: ptr Screen00): ptr Window00 {.
    importc, libprag.}

proc getRootWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_root_window(cast[ptr Screen00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rootWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_root_window(cast[ptr Screen00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_screen_get_setting(self: ptr Screen00; name: cstring; value: gobject.Value): gboolean {.
    importc, libprag.}

proc getSetting*(self: Screen; name: cstring; value: gobject.Value): bool =
  toBool(gdk_screen_get_setting(cast[ptr Screen00](self.impl), name, value))

proc gdk_screen_get_system_visual(self: ptr Screen00): ptr Visual00 {.
    importc, libprag.}

proc getSystemVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_system_visual(cast[ptr Screen00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc systemVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_system_visual(cast[ptr Screen00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_screen_get_toplevel_windows(self: ptr Screen00): ptr glib.List {.
    importc, libprag.}

proc getToplevelWindows*(self: Screen): seq[Window] =
  let resul0 = gdk_screen_get_toplevel_windows(cast[ptr Screen00](self.impl))
  result = glistObjects2seq(Window, resul0, false)
  g_list_free(resul0)

proc toplevelWindows*(self: Screen): seq[Window] =
  let resul0 = gdk_screen_get_toplevel_windows(cast[ptr Screen00](self.impl))
  result = glistObjects2seq(Window, resul0, false)
  g_list_free(resul0)

proc gdk_screen_get_width(self: ptr Screen00): int32 {.
    importc, libprag.}

proc getWidth*(self: Screen): int =
  int(gdk_screen_get_width(cast[ptr Screen00](self.impl)))

proc width*(self: Screen): int =
  int(gdk_screen_get_width(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_width_mm(self: ptr Screen00): int32 {.
    importc, libprag.}

proc getWidthMm*(self: Screen): int =
  int(gdk_screen_get_width_mm(cast[ptr Screen00](self.impl)))

proc widthMm*(self: Screen): int =
  int(gdk_screen_get_width_mm(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_window_stack(self: ptr Screen00): ptr glib.List {.
    importc, libprag.}

proc getWindowStack*(self: Screen): seq[Window] =
  let resul0 = gdk_screen_get_window_stack(cast[ptr Screen00](self.impl))
  if resul0.isNil:
    return
  result = glistObjects2seq(Window, resul0, true)
  g_list_free(resul0)

proc windowStack*(self: Screen): seq[Window] =
  let resul0 = gdk_screen_get_window_stack(cast[ptr Screen00](self.impl))
  if resul0.isNil:
    return
  result = glistObjects2seq(Window, resul0, true)
  g_list_free(resul0)

proc gdk_screen_is_composited(self: ptr Screen00): gboolean {.
    importc, libprag.}

proc isComposited*(self: Screen): bool =
  toBool(gdk_screen_is_composited(cast[ptr Screen00](self.impl)))

proc gdk_screen_list_visuals(self: ptr Screen00): ptr glib.List {.
    importc, libprag.}

proc listVisuals*(self: Screen): seq[Visual] =
  let resul0 = gdk_screen_list_visuals(cast[ptr Screen00](self.impl))
  result = glistObjects2seq(Visual, resul0, false)
  g_list_free(resul0)

proc gdk_screen_make_display_name(self: ptr Screen00): cstring {.
    importc, libprag.}

proc makeDisplayName*(self: Screen): string =
  let resul0 = gdk_screen_make_display_name(cast[ptr Screen00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_screen_set_font_options(self: ptr Screen00; options: ptr cairo.FontOptions00) {.
    importc, libprag.}

proc setFontOptions*(self: Screen; options: cairo.FontOptions = nil) =
  gdk_screen_set_font_options(cast[ptr Screen00](self.impl), if options.isNil: nil else: cast[ptr cairo.FontOptions00](options.impl))

proc `fontOptions=`*(self: Screen; options: cairo.FontOptions = nil) =
  gdk_screen_set_font_options(cast[ptr Screen00](self.impl), if options.isNil: nil else: cast[ptr cairo.FontOptions00](options.impl))

proc gdk_screen_set_resolution(self: ptr Screen00; dpi: cdouble) {.
    importc, libprag.}

proc setResolution*(self: Screen; dpi: cdouble) =
  gdk_screen_set_resolution(cast[ptr Screen00](self.impl), dpi)

proc `resolution=`*(self: Screen; dpi: cdouble) =
  gdk_screen_set_resolution(cast[ptr Screen00](self.impl), dpi)

proc gdk_app_launch_context_set_screen(self: ptr AppLaunchContext00; screen: ptr Screen00) {.
    importc, libprag.}

proc setScreen*(self: AppLaunchContext; screen: Screen) =
  gdk_app_launch_context_set_screen(cast[ptr AppLaunchContext00](self.impl), cast[ptr Screen00](screen.impl))

proc `screen=`*(self: AppLaunchContext; screen: Screen) =
  gdk_app_launch_context_set_screen(cast[ptr AppLaunchContext00](self.impl), cast[ptr Screen00](screen.impl))

proc gdk_device_get_position(self: ptr Device00; screen: var ptr Screen00;
    x: var int32; y: var int32) {.
    importc, libprag.}

proc getPosition*(self: Device; screen: var Screen = cast[var Screen](nil);
    x: var int = cast[var int](nil); y: var int = cast[var int](nil)) =
  var tmpoutgobjectarg: ptr Screen00
  var y_00: int32
  var x_00: int32
  gdk_device_get_position(cast[ptr Device00](self.impl), cast[var ptr Screen00](if addr(screen) == nil: nil else: addr tmpoutgobjectarg), x_00, y_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)
#  dothemagic(screen
  if addr(screen) != nil:
    screen = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      screen = cast[type(screen)](argqdata)
      assert(screen.impl == tmpoutgobjectarg)
    else:
      fnew(screen, gdk.finalizeGObject)
      screen.impl = tmpoutgobjectarg
      GC_ref(screen)
      if g_object_is_floating(screen.impl).int != 0:
        discard g_object_ref_sink(screen.impl)
      g_object_add_toggle_ref(screen.impl, toggleNotify, addr(screen[]))
      g_object_unref(screen.impl)
      assert(g_object_get_qdata(screen.impl, Quark) == nil)
      g_object_set_qdata(screen.impl, Quark, addr(screen[]))


proc gdk_device_get_position_double(self: ptr Device00; screen: var ptr Screen00;
    x: var cdouble; y: var cdouble) {.
    importc, libprag.}

proc getPositionDouble*(self: Device; screen: var Screen = cast[var Screen](nil);
    x: var cdouble = cast[var cdouble](nil); y: var cdouble = cast[var cdouble](nil)) =
  var tmpoutgobjectarg: ptr Screen00
  gdk_device_get_position_double(cast[ptr Device00](self.impl), cast[var ptr Screen00](if addr(screen) == nil: nil else: addr tmpoutgobjectarg), x, y)
#  dothemagic(screen
  if addr(screen) != nil:
    screen = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      screen = cast[type(screen)](argqdata)
      assert(screen.impl == tmpoutgobjectarg)
    else:
      fnew(screen, gdk.finalizeGObject)
      screen.impl = tmpoutgobjectarg
      GC_ref(screen)
      if g_object_is_floating(screen.impl).int != 0:
        discard g_object_ref_sink(screen.impl)
      g_object_add_toggle_ref(screen.impl, toggleNotify, addr(screen[]))
      g_object_unref(screen.impl)
      assert(g_object_get_qdata(screen.impl, Quark) == nil)
      g_object_set_qdata(screen.impl, Quark, addr(screen[]))


proc gdk_device_warp(self: ptr Device00; screen: ptr Screen00; x: int32;
    y: int32) {.
    importc, libprag.}

proc warp*(self: Device; screen: Screen; x: int; y: int) =
  gdk_device_warp(cast[ptr Device00](self.impl), cast[ptr Screen00](screen.impl), int32(x), int32(y))

proc gdk_display_get_default_screen(self: ptr Display00): ptr Screen00 {.
    importc, libprag.}

proc getDefaultScreen*(self: Display): Screen =
  let gobj = gdk_display_get_default_screen(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultScreen*(self: Display): Screen =
  let gobj = gdk_display_get_default_screen(cast[ptr Display00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_get_pointer(self: ptr Display00; screen: var ptr Screen00;
    x: var int32; y: var int32; mask: var ModifierType) {.
    importc, libprag.}

proc getPointer*(self: Display; screen: var Screen = cast[var Screen](nil);
    x: var int = cast[var int](nil); y: var int = cast[var int](nil); mask: var ModifierType = cast[var ModifierType](nil)) =
  var tmpoutgobjectarg: ptr Screen00
  var y_00: int32
  var x_00: int32
  gdk_display_get_pointer(cast[ptr Display00](self.impl), cast[var ptr Screen00](if addr(screen) == nil: nil else: addr tmpoutgobjectarg), x_00, y_00, mask)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)
#  dothemagic(screen
  if addr(screen) != nil:
    screen = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      screen = cast[type(screen)](argqdata)
      assert(screen.impl == tmpoutgobjectarg)
    else:
      fnew(screen, gdk.finalizeGObject)
      screen.impl = tmpoutgobjectarg
      GC_ref(screen)
      if g_object_is_floating(screen.impl).int != 0:
        discard g_object_ref_sink(screen.impl)
      g_object_add_toggle_ref(screen.impl, toggleNotify, addr(screen[]))
      g_object_unref(screen.impl)
      assert(g_object_get_qdata(screen.impl, Quark) == nil)
      g_object_set_qdata(screen.impl, Quark, addr(screen[]))


proc gdk_display_get_screen(self: ptr Display00; screenNum: int32): ptr Screen00 {.
    importc, libprag.}

proc getScreen*(self: Display; screenNum: int): Screen =
  let gobj = gdk_display_get_screen(cast[ptr Display00](self.impl), int32(screenNum))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_warp_pointer(self: ptr Display00; screen: ptr Screen00;
    x: int32; y: int32) {.
    importc, libprag.}

proc warpPointer*(self: Display; screen: Screen; x: int; y: int) =
  gdk_display_warp_pointer(cast[ptr Display00](self.impl), cast[ptr Screen00](screen.impl), int32(x), int32(y))

proc gdk_window_get_screen(self: ptr Window00): ptr Screen00 {.
    importc, libprag.}

proc getScreen*(self: Window): Screen =
  let gobj = gdk_window_get_screen(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc screen*(self: Window): Screen =
  let gobj = gdk_window_get_screen(cast[ptr Window00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_visual_get_screen(self: ptr Visual00): ptr Screen00 {.
    importc, libprag.}

proc getScreen*(self: Visual): Screen =
  let gobj = gdk_visual_get_screen(cast[ptr Visual00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc screen*(self: Visual): Screen =
  let gobj = gdk_visual_get_screen(cast[ptr Visual00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

const BUTTON_MIDDLE* = 2'i32

const BUTTON_PRIMARY* = 1'i32

const BUTTON_SECONDARY* = 3'i32

const CURRENT_TIME* = 0'i32

type
  CrossingMode* {.size: sizeof(cint), pure.} = enum
    normal = 0
    grab = 1
    ungrab = 2
    gtkGrab = 3
    gtkUngrab = 4
    stateChanged = 5
    touchBegin = 6
    touchEnd = 7
    deviceSwitch = 8

type
  DevicePad00* = object of gobject.Object00
  DevicePad* = ref object of gobject.Object

proc gdk_device_pad_get_group_n_modes(self: ptr DevicePad00; groupIdx: int32): int32 {.
    importc, libprag.}

proc getGroupNModes*(self: DevicePad; groupIdx: int): int =
  int(gdk_device_pad_get_group_n_modes(cast[ptr DevicePad00](self.impl), int32(groupIdx)))

proc gdk_device_pad_get_n_groups(self: ptr DevicePad00): int32 {.
    importc, libprag.}

proc getNGroups*(self: DevicePad): int =
  int(gdk_device_pad_get_n_groups(cast[ptr DevicePad00](self.impl)))

proc nGroups*(self: DevicePad): int =
  int(gdk_device_pad_get_n_groups(cast[ptr DevicePad00](self.impl)))

type
  DevicePadFeature* {.size: sizeof(cint), pure.} = enum
    button = 0
    ring = 1
    strip = 2

proc gdk_device_pad_get_feature_group(self: ptr DevicePad00; feature: DevicePadFeature;
    featureIdx: int32): int32 {.
    importc, libprag.}

proc getFeatureGroup*(self: DevicePad; feature: DevicePadFeature;
    featureIdx: int): int =
  int(gdk_device_pad_get_feature_group(cast[ptr DevicePad00](self.impl), feature, int32(featureIdx)))

proc gdk_device_pad_get_n_features(self: ptr DevicePad00; feature: DevicePadFeature): int32 {.
    importc, libprag.}

proc getNFeatures*(self: DevicePad; feature: DevicePadFeature): int =
  int(gdk_device_pad_get_n_features(cast[ptr DevicePad00](self.impl), feature))

type
  DisplayManager* = ref object of gobject.Object
  DisplayManager00* = object of gobject.Object00

proc gdk_display_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DisplayManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDisplayOpened*(self: DisplayManager;  p: proc (self: ptr DisplayManager00; display: ptr Display00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "display-opened", cast[GCallback](p), xdata, nil, cf)

proc gdk_display_manager_get(): ptr DisplayManager00 {.
    importc, libprag.}

proc getDisplayManager*(): DisplayManager =
  let gobj = gdk_display_manager_get()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_manager_get_default_display(self: ptr DisplayManager00): ptr Display00 {.
    importc, libprag.}

proc getDefaultDisplay*(self: DisplayManager): Display =
  let gobj = gdk_display_manager_get_default_display(cast[ptr DisplayManager00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultDisplay*(self: DisplayManager): Display =
  let gobj = gdk_display_manager_get_default_display(cast[ptr DisplayManager00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_manager_list_displays(self: ptr DisplayManager00): ptr glib.SList {.
    importc, libprag.}

proc listDisplays*(self: DisplayManager): seq[Display] =
  let resul0 = gdk_display_manager_list_displays(cast[ptr DisplayManager00](self.impl))
  result = gslistObjects2seq(Display, resul0, false)
  g_slist_free(resul0)

proc gdk_display_manager_open_display(self: ptr DisplayManager00; name: cstring): ptr Display00 {.
    importc, libprag.}

proc openDisplay*(self: DisplayManager; name: cstring): Display =
  let gobj = gdk_display_manager_open_display(cast[ptr DisplayManager00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_display_manager_set_default_display(self: ptr DisplayManager00;
    display: ptr Display00) {.
    importc, libprag.}

proc setDefaultDisplay*(self: DisplayManager; display: Display) =
  gdk_display_manager_set_default_display(cast[ptr DisplayManager00](self.impl), cast[ptr Display00](display.impl))

proc `defaultDisplay=`*(self: DisplayManager; display: Display) =
  gdk_display_manager_set_default_display(cast[ptr DisplayManager00](self.impl), cast[ptr Display00](display.impl))

type
  DragFlag* {.size: sizeof(cint), pure.} = enum
    default = 0
    copy = 1
    move = 2
    link = 3
    private = 4
    ask = 5

  DragAction* {.size: sizeof(cint).} = set[DragFlag]

type
  DragCancelReason* {.size: sizeof(cint), pure.} = enum
    noTarget = 0
    userCancelled = 1
    error = 2

type
  DragContext* = ref object of gobject.Object
  DragContext00* = object of gobject.Object00

proc gdk_drag_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DragContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActionChanged*(self: DragContext;  p: proc (self: ptr DragContext00; action: DragAction; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "action-changed", cast[GCallback](p), xdata, nil, cf)

proc scCancel*(self: DragContext;  p: proc (self: ptr DragContext00; reason: DragCancelReason; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "cancel", cast[GCallback](p), xdata, nil, cf)

proc scDndFinished*(self: DragContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "dnd-finished", cast[GCallback](p), xdata, nil, cf)

proc scDropPerformed*(self: DragContext;  p: proc (self: ptr DragContext00; time: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "drop-performed", cast[GCallback](p), xdata, nil, cf)

proc gdk_drag_context_get_actions(self: ptr DragContext00): DragAction {.
    importc, libprag.}

proc getActions*(self: DragContext): DragAction =
  gdk_drag_context_get_actions(cast[ptr DragContext00](self.impl))

proc actions*(self: DragContext): DragAction =
  gdk_drag_context_get_actions(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_get_dest_window(self: ptr DragContext00): ptr Window00 {.
    importc, libprag.}

proc getDestWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_dest_window(cast[ptr DragContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc destWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_dest_window(cast[ptr DragContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_drag_context_get_device(self: ptr DragContext00): ptr Device00 {.
    importc, libprag.}

proc getDevice*(self: DragContext): Device =
  let gobj = gdk_drag_context_get_device(cast[ptr DragContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc device*(self: DragContext): Device =
  let gobj = gdk_drag_context_get_device(cast[ptr DragContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_drag_context_get_drag_window(self: ptr DragContext00): ptr Window00 {.
    importc, libprag.}

proc getDragWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_drag_window(cast[ptr DragContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc dragWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_drag_window(cast[ptr DragContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_drag_context_get_protocol(self: ptr DragContext00): DragProtocol {.
    importc, libprag.}

proc getProtocol*(self: DragContext): DragProtocol =
  gdk_drag_context_get_protocol(cast[ptr DragContext00](self.impl))

proc protocol*(self: DragContext): DragProtocol =
  gdk_drag_context_get_protocol(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_get_selected_action(self: ptr DragContext00): DragAction {.
    importc, libprag.}

proc getSelectedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_selected_action(cast[ptr DragContext00](self.impl))

proc selectedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_selected_action(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_get_source_window(self: ptr DragContext00): ptr Window00 {.
    importc, libprag.}

proc getSourceWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_source_window(cast[ptr DragContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sourceWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_source_window(cast[ptr DragContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_drag_context_get_suggested_action(self: ptr DragContext00): DragAction {.
    importc, libprag.}

proc getSuggestedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_suggested_action(cast[ptr DragContext00](self.impl))

proc suggestedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_suggested_action(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_list_targets(self: ptr DragContext00): ptr glib.List {.
    importc, libprag.}

proc listTargets*(self: DragContext): seq[Atom] =
  result = glistStructs2seq[Atom](gdk_drag_context_list_targets(cast[ptr DragContext00](self.impl)), true)

proc gdk_drag_context_manage_dnd(self: ptr DragContext00; ipcWindow: ptr Window00;
    actions: DragAction): gboolean {.
    importc, libprag.}

proc manageDnd*(self: DragContext; ipcWindow: Window; actions: DragAction): bool =
  toBool(gdk_drag_context_manage_dnd(cast[ptr DragContext00](self.impl), cast[ptr Window00](ipcWindow.impl), actions))

proc gdk_drag_context_set_device(self: ptr DragContext00; device: ptr Device00) {.
    importc, libprag.}

proc setDevice*(self: DragContext; device: Device) =
  gdk_drag_context_set_device(cast[ptr DragContext00](self.impl), cast[ptr Device00](device.impl))

proc `device=`*(self: DragContext; device: Device) =
  gdk_drag_context_set_device(cast[ptr DragContext00](self.impl), cast[ptr Device00](device.impl))

proc gdk_drag_context_set_hotspot(self: ptr DragContext00; hotX: int32; hotY: int32) {.
    importc, libprag.}

proc setHotspot*(self: DragContext; hotX: int; hotY: int) =
  gdk_drag_context_set_hotspot(cast[ptr DragContext00](self.impl), int32(hotX), int32(hotY))

const EVENT_PROPAGATE* = false

const EVENT_STOP* = true

type
  Event00* {.pure, union.} = object
  Event* = ref object
    impl*: ptr Event00
    ignoreFinalizer*: bool

proc gdk_event_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkEvent*(self: Event) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_event_get_type(), cast[ptr Event00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Event()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_event_get_type(), cast[ptr Event00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Event) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkEvent)

proc gdk_event_free(self: ptr Event00) {.
    importc, libprag.}

proc free*(self: Event) =
  gdk_event_free(cast[ptr Event00](self.impl))

proc finalizerfree*(self: Event) =
  if not self.ignoreFinalizer:
    gdk_event_free(cast[ptr Event00](self.impl))

proc gdk_events_get_angle(self: ptr Event00; event2: ptr Event00; angle: var cdouble): gboolean {.
    importc, libprag.}

proc getAngle*(self: Event; event2: Event; angle: var cdouble): bool =
  toBool(gdk_events_get_angle(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), angle))

proc gdk_events_get_center(self: ptr Event00; event2: ptr Event00; x: var cdouble;
    y: var cdouble): gboolean {.
    importc, libprag.}

proc getCenter*(self: Event; event2: Event; x: var cdouble; y: var cdouble): bool =
  toBool(gdk_events_get_center(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), x, y))

proc gdk_events_get_distance(self: ptr Event00; event2: ptr Event00; distance: var cdouble): gboolean {.
    importc, libprag.}

proc getDistance*(self: Event; event2: Event; distance: var cdouble): bool =
  toBool(gdk_events_get_distance(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), distance))

proc gdk_event_copy(self: ptr Event00): ptr Event00 {.
    importc, libprag.}

proc copy*(self: Event): Event =
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = gdk_event_copy(cast[ptr Event00](self.impl))

proc gdk_event_get_axis(self: ptr Event00; axisUse: AxisUse; value: var cdouble): gboolean {.
    importc, libprag.}

proc getAxis*(self: Event; axisUse: AxisUse; value: var cdouble): bool =
  toBool(gdk_event_get_axis(cast[ptr Event00](self.impl), axisUse, value))

proc gdk_event_get_button(self: ptr Event00; button: var uint32): gboolean {.
    importc, libprag.}

proc getButton*(self: Event; button: var int): bool =
  var button_00: uint32
  result = toBool(gdk_event_get_button(cast[ptr Event00](self.impl), button_00))
  if button.addr != nil:
    button = int(button_00)

proc gdk_event_get_click_count(self: ptr Event00; clickCount: var uint32): gboolean {.
    importc, libprag.}

proc getClickCount*(self: Event; clickCount: var int): bool =
  var clickCount_00: uint32
  result = toBool(gdk_event_get_click_count(cast[ptr Event00](self.impl), clickCount_00))
  if clickCount.addr != nil:
    clickCount = int(clickCount_00)

proc gdk_event_get_coords(self: ptr Event00; xWin: var cdouble; yWin: var cdouble): gboolean {.
    importc, libprag.}

proc getCoords*(self: Event; xWin: var cdouble; yWin: var cdouble): bool =
  toBool(gdk_event_get_coords(cast[ptr Event00](self.impl), xWin, yWin))

proc gdk_event_get_device(self: ptr Event00): ptr Device00 {.
    importc, libprag.}

proc getDevice*(self: Event): Device =
  let gobj = gdk_event_get_device(cast[ptr Event00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc device*(self: Event): Device =
  let gobj = gdk_event_get_device(cast[ptr Event00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_event_get_device_tool(self: ptr Event00): ptr DeviceTool00 {.
    importc, libprag.}

proc getDeviceTool*(self: Event): DeviceTool =
  let gobj = gdk_event_get_device_tool(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc deviceTool*(self: Event): DeviceTool =
  let gobj = gdk_event_get_device_tool(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_event_get_keycode(self: ptr Event00; keycode: var uint16): gboolean {.
    importc, libprag.}

proc getKeycode*(self: Event; keycode: var uint16): bool =
  toBool(gdk_event_get_keycode(cast[ptr Event00](self.impl), keycode))

proc gdk_event_get_keyval(self: ptr Event00; keyval: var uint32): gboolean {.
    importc, libprag.}

proc getKeyval*(self: Event; keyval: var int): bool =
  var keyval_00: uint32
  result = toBool(gdk_event_get_keyval(cast[ptr Event00](self.impl), keyval_00))
  if keyval.addr != nil:
    keyval = int(keyval_00)

proc gdk_event_get_pointer_emulated(self: ptr Event00): gboolean {.
    importc, libprag.}

proc getPointerEmulated*(self: Event): bool =
  toBool(gdk_event_get_pointer_emulated(cast[ptr Event00](self.impl)))

proc pointerEmulated*(self: Event): bool =
  toBool(gdk_event_get_pointer_emulated(cast[ptr Event00](self.impl)))

proc gdk_event_get_root_coords(self: ptr Event00; xRoot: var cdouble; yRoot: var cdouble): gboolean {.
    importc, libprag.}

proc getRootCoords*(self: Event; xRoot: var cdouble; yRoot: var cdouble): bool =
  toBool(gdk_event_get_root_coords(cast[ptr Event00](self.impl), xRoot, yRoot))

proc gdk_event_get_scancode(self: ptr Event00): int32 {.
    importc, libprag.}

proc getScancode*(self: Event): int =
  int(gdk_event_get_scancode(cast[ptr Event00](self.impl)))

proc scancode*(self: Event): int =
  int(gdk_event_get_scancode(cast[ptr Event00](self.impl)))

proc gdk_event_get_screen(self: ptr Event00): ptr Screen00 {.
    importc, libprag.}

proc getScreen*(self: Event): Screen =
  let gobj = gdk_event_get_screen(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc screen*(self: Event): Screen =
  let gobj = gdk_event_get_screen(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_event_get_scroll_deltas(self: ptr Event00; deltaX: var cdouble;
    deltaY: var cdouble): gboolean {.
    importc, libprag.}

proc getScrollDeltas*(self: Event; deltaX: var cdouble; deltaY: var cdouble): bool =
  toBool(gdk_event_get_scroll_deltas(cast[ptr Event00](self.impl), deltaX, deltaY))

proc gdk_event_get_seat(self: ptr Event00): ptr Seat00 {.
    importc, libprag.}

proc getSeat*(self: Event): Seat =
  let gobj = gdk_event_get_seat(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc seat*(self: Event): Seat =
  let gobj = gdk_event_get_seat(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_event_get_source_device(self: ptr Event00): ptr Device00 {.
    importc, libprag.}

proc getSourceDevice*(self: Event): Device =
  let gobj = gdk_event_get_source_device(cast[ptr Event00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sourceDevice*(self: Event): Device =
  let gobj = gdk_event_get_source_device(cast[ptr Event00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_event_get_state(self: ptr Event00; state: var ModifierType): gboolean {.
    importc, libprag.}

proc getState*(self: Event; state: var ModifierType): bool =
  toBool(gdk_event_get_state(cast[ptr Event00](self.impl), state))

proc gdk_event_get_time(self: ptr Event00): uint32 {.
    importc, libprag.}

proc getTime*(self: Event): int =
  int(gdk_event_get_time(cast[ptr Event00](self.impl)))

proc time*(self: Event): int =
  int(gdk_event_get_time(cast[ptr Event00](self.impl)))

proc gdk_event_get_window(self: ptr Event00): ptr Window00 {.
    importc, libprag.}

proc getWindow*(self: Event): Window =
  let gobj = gdk_event_get_window(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc window*(self: Event): Window =
  let gobj = gdk_event_get_window(cast[ptr Event00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_event_is_scroll_stop_event(self: ptr Event00): gboolean {.
    importc, libprag.}

proc isScrollStopEvent*(self: Event): bool =
  toBool(gdk_event_is_scroll_stop_event(cast[ptr Event00](self.impl)))

proc gdk_event_put(self: ptr Event00) {.
    importc, libprag.}

proc put*(self: Event) =
  gdk_event_put(cast[ptr Event00](self.impl))

proc gdk_event_set_device(self: ptr Event00; device: ptr Device00) {.
    importc, libprag.}

proc setDevice*(self: Event; device: Device) =
  gdk_event_set_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc `device=`*(self: Event; device: Device) =
  gdk_event_set_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc gdk_event_set_device_tool(self: ptr Event00; tool: ptr DeviceTool00) {.
    importc, libprag.}

proc setDeviceTool*(self: Event; tool: DeviceTool = nil) =
  gdk_event_set_device_tool(cast[ptr Event00](self.impl), if tool.isNil: nil else: cast[ptr DeviceTool00](tool.impl))

proc `deviceTool=`*(self: Event; tool: DeviceTool = nil) =
  gdk_event_set_device_tool(cast[ptr Event00](self.impl), if tool.isNil: nil else: cast[ptr DeviceTool00](tool.impl))

proc gdk_event_set_screen(self: ptr Event00; screen: ptr Screen00) {.
    importc, libprag.}

proc setScreen*(self: Event; screen: Screen) =
  gdk_event_set_screen(cast[ptr Event00](self.impl), cast[ptr Screen00](screen.impl))

proc `screen=`*(self: Event; screen: Screen) =
  gdk_event_set_screen(cast[ptr Event00](self.impl), cast[ptr Screen00](screen.impl))

proc gdk_event_set_source_device(self: ptr Event00; device: ptr Device00) {.
    importc, libprag.}

proc setSourceDevice*(self: Event; device: Device) =
  gdk_event_set_source_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc `sourceDevice=`*(self: Event; device: Device) =
  gdk_event_set_source_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc gdk_event_triggers_context_menu(self: ptr Event00): gboolean {.
    importc, libprag.}

proc triggersContextMenu*(self: Event): bool =
  toBool(gdk_event_triggers_context_menu(cast[ptr Event00](self.impl)))

proc gdk_event_get(): ptr Event00 {.
    importc, libprag.}

proc getEvent*(): Event =
  let impl0 = gdk_event_get()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = impl0

proc gdk_event_peek(): ptr Event00 {.
    importc, libprag.}

proc peek*(): Event =
  let impl0 = gdk_event_peek()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = impl0

proc gdk_display_get_event(self: ptr Display00): ptr Event00 {.
    importc, libprag.}

proc getEvent*(self: Display): Event =
  let impl0 = gdk_display_get_event(cast[ptr Display00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = impl0

proc event*(self: Display): Event =
  let impl0 = gdk_display_get_event(cast[ptr Display00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = impl0

proc gdk_display_peek_event(self: ptr Display00): ptr Event00 {.
    importc, libprag.}

proc peekEvent*(self: Display): Event =
  let impl0 = gdk_display_peek_event(cast[ptr Display00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = impl0

proc gdk_display_put_event(self: ptr Display00; event: ptr Event00) {.
    importc, libprag.}

proc putEvent*(self: Display; event: Event) =
  gdk_display_put_event(cast[ptr Display00](self.impl), cast[ptr Event00](event.impl))

proc gdk_window_show_window_menu(self: ptr Window00; event: ptr Event00): gboolean {.
    importc, libprag.}

proc showWindowMenu*(self: Window; event: Event): bool =
  toBool(gdk_window_show_window_menu(cast[ptr Window00](self.impl), cast[ptr Event00](event.impl)))

type
  EventSequence00* {.pure.} = object
  EventSequence* = ref object
    impl*: ptr EventSequence00
    ignoreFinalizer*: bool

proc gdk_event_sequence_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGdkEventSequence*(self: EventSequence) =
  if not self.ignoreFinalizer:
    boxedFree(gdk_event_sequence_get_type(), cast[ptr EventSequence00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EventSequence()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gdk_event_sequence_get_type(), cast[ptr EventSequence00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var EventSequence) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGdkEventSequence)

proc gdk_event_get_event_sequence(self: ptr Event00): ptr EventSequence00 {.
    importc, libprag.}

proc getEventSequence*(self: Event): EventSequence =
  fnew(result, gBoxedFreeGdkEventSequence)
  result.impl = gdk_event_get_event_sequence(cast[ptr Event00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_event_sequence_get_type(), result.impl))

proc eventSequence*(self: Event): EventSequence =
  fnew(result, gBoxedFreeGdkEventSequence)
  result.impl = gdk_event_get_event_sequence(cast[ptr Event00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gdk_event_sequence_get_type(), result.impl))

type
  EventType* {.size: sizeof(cint), pure.} = enum
    nothing = -1
    delete = 0
    destroy = 1
    expose = 2
    motionNotify = 3
    buttonPress = 4
    doubleButtonPress = 5
    threeButtonPress = 6
    buttonRelease = 7
    keyPress = 8
    keyRelease = 9
    enterNotify = 10
    leaveNotify = 11
    focusChange = 12
    configure = 13
    map = 14
    unmap = 15
    propertyNotify = 16
    selectionClear = 17
    selectionRequest = 18
    selectionNotify = 19
    proximityIn = 20
    proximityOut = 21
    dragEnter = 22
    dragLeave = 23
    dragMotion = 24
    dragStatus = 25
    dropStart = 26
    dropFinished = 27
    clientEvent = 28
    visibilityNotify = 29
    scroll = 31
    windowState = 32
    setting = 33
    ownerChange = 34
    grabBroken = 35
    damage = 36
    touchBegin = 37
    touchUpdate = 38
    touchEnd = 39
    touchCancel = 40
    touchpadSwipe = 41
    touchpadPinch = 42
    padButtonPress = 43
    padButtonRelease = 44
    padRing = 45
    padStrip = 46
    padGroupMode = 47
    eventLast = 48

const
  EventTypeTwoButtonPress* = EventType.doubleButtonPress
  EventTypeTripleButtonPress* = EventType.threeButtonPress

proc gdk_event_new(`type`: EventType): ptr Event00 {.
    importc, libprag.}

proc newEvent*(`type`: EventType): Event =
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = gdk_event_new(`type`)

proc newEvent*(tdesc: typedesc; `type`: EventType): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = gdk_event_new(`type`)

proc initEvent*[T](result: var T; `type`: EventType) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGdkEvent)
  result.impl = gdk_event_new(`type`)

proc gdk_event_get_event_type(self: ptr Event00): EventType {.
    importc, libprag.}

proc getEventType*(self: Event): EventType =
  gdk_event_get_event_type(cast[ptr Event00](self.impl))

proc eventType*(self: Event): EventType =
  gdk_event_get_event_type(cast[ptr Event00](self.impl))

type
  ScrollDirection* {.size: sizeof(cint), pure.} = enum
    up = 0
    down = 1
    left = 2
    right = 3
    smooth = 4

proc gdk_event_get_scroll_direction(self: ptr Event00; direction: var ScrollDirection): gboolean {.
    importc, libprag.}

proc getScrollDirection*(self: Event; direction: var ScrollDirection): bool =
  toBool(gdk_event_get_scroll_direction(cast[ptr Event00](self.impl), direction))

type
  EventMotion00* = Event00
  EventMotion* = Event

proc gdk_event_request_motions(event: ptr EventMotion00) {.
    importc, libprag.}

proc requestMotions*(event: EventMotion) =
  gdk_event_request_motions(cast[ptr EventMotion00](event.impl))

type
  EventAny00* = Event00
  EventAny* = Event

type
  EventButton00* = Event00
  EventButton* = Event

type
  EventConfigure00* = Event00
  EventConfigure* = Event

type
  EventCrossing00* = Event00
  EventCrossing* = Event

type
  EventDND00* = Event00
  EventDND* = Event

type
  EventExpose00* = Event00
  EventExpose* = Event

type
  EventFocus00* = Event00
  EventFocus* = Event

type
  EventFunc* = proc (event: ptr Event00; data: pointer) {.cdecl.}

proc handlerSet*(`func`: EventFunc; data: pointer; notify: DestroyNotify) {.
    importc: "gdk_event_handler_set", libprag.}

type
  EventGrabBroken00* = Event00
  EventGrabBroken* = Event

type
  EventKey00* = Event00
  EventKey* = Event

type
  EventOwnerChange00* = Event00
  EventOwnerChange* = Event

type
  EventPadAxis00* = Event00
  EventPadAxis* = Event

type
  EventPadButton00* = Event00
  EventPadButton* = Event

type
  EventPadGroupMode00* = Event00
  EventPadGroupMode* = Event

type
  EventProperty00* = Event00
  EventProperty* = Event

type
  EventProximity00* = Event00
  EventProximity* = Event

type
  EventScroll00* = Event00
  EventScroll* = Event

type
  EventSelection00* = Event00
  EventSelection* = Event

type
  EventSetting00* = Event00
  EventSetting* = Event

type
  EventTouch00* = Event00
  EventTouch* = Event

type
  EventTouchpadPinch00* = Event00
  EventTouchpadPinch* = Event

type
  EventTouchpadSwipe00* = Event00
  EventTouchpadSwipe* = Event

type
  EventVisibility00* = Event00
  EventVisibility* = Event

type
  EventWindowState00* = Event00
  EventWindowState* = Event

type
  FilterReturn* {.size: sizeof(cint), pure.} = enum
    `continue` = 0
    translate = 1
    remove = 2

type
  FilterFunc* = proc (xevent: pointer; event: ptr Event00; data: pointer): FilterReturn {.cdecl.}

type
  GLError* {.size: sizeof(cint), pure.} = enum
    notAvailable = 0
    unsupportedFormat = 1
    unsupportedProfile = 2

const KEY_0* = 48'i32

const KEY_1* = 49'i32

const KEY_2* = 50'i32

const KEY_3* = 51'i32

const KEY_3270_AltCursor* = 64784'i32

const KEY_3270_Attn* = 64782'i32

const KEY_3270_BackTab* = 64773'i32

const KEY_3270_ChangeScreen* = 64793'i32

const KEY_3270_Copy* = 64789'i32

const KEY_3270_CursorBlink* = 64783'i32

const KEY_3270_CursorSelect* = 64796'i32

const KEY_3270_DeleteWord* = 64794'i32

const KEY_3270_Duplicate* = 64769'i32

const KEY_3270_Enter* = 64798'i32

const KEY_3270_EraseEOF* = 64774'i32

const KEY_3270_EraseInput* = 64775'i32

const KEY_3270_ExSelect* = 64795'i32

const KEY_3270_FieldMark* = 64770'i32

const KEY_3270_Ident* = 64787'i32

const KEY_3270_Jump* = 64786'i32

const KEY_3270_KeyClick* = 64785'i32

const KEY_3270_Left2* = 64772'i32

const KEY_3270_PA1* = 64778'i32

const KEY_3270_PA2* = 64779'i32

const KEY_3270_PA3* = 64780'i32

const KEY_3270_Play* = 64790'i32

const KEY_3270_PrintScreen* = 64797'i32

const KEY_3270_Quit* = 64777'i32

const KEY_3270_Record* = 64792'i32

const KEY_3270_Reset* = 64776'i32

const KEY_3270_Right2* = 64771'i32

const KEY_3270_Rule* = 64788'i32

const KEY_3270_Setup* = 64791'i32

const KEY_3270_Test* = 64781'i32

const KEY_4* = 52'i32

const KEY_5* = 53'i32

const KEY_6* = 54'i32

const KEY_7* = 55'i32

const KEY_8* = 56'i32

const KEY_9* = 57'i32

const UKEY_A* = 65'i32

const UKEY_AE* = 198'i32

const UKEY_Aacute* = 193'i32

const UKEY_Abelowdot* = 16785056'i32

const UKEY_Abreve* = 451'i32

const UKEY_Abreveacute* = 16785070'i32

const UKEY_Abrevebelowdot* = 16785078'i32

const UKEY_Abrevegrave* = 16785072'i32

const UKEY_Abrevehook* = 16785074'i32

const UKEY_Abrevetilde* = 16785076'i32

const KEY_AccessX_Enable* = 65136'i32

const KEY_AccessX_Feedback_Enable* = 65137'i32

const UKEY_Acircumflex* = 194'i32

const UKEY_Acircumflexacute* = 16785060'i32

const UKEY_Acircumflexbelowdot* = 16785068'i32

const UKEY_Acircumflexgrave* = 16785062'i32

const UKEY_Acircumflexhook* = 16785064'i32

const UKEY_Acircumflextilde* = 16785066'i32

const KEY_AddFavorite* = 269025081'i32

const UKEY_Adiaeresis* = 196'i32

const UKEY_Agrave* = 192'i32

const UKEY_Ahook* = 16785058'i32

const KEY_Alt_L* = 65513'i32

const KEY_Alt_R* = 65514'i32

const UKEY_Amacron* = 960'i32

const UKEY_Aogonek* = 417'i32

const KEY_ApplicationLeft* = 269025104'i32

const KEY_ApplicationRight* = 269025105'i32

const KEY_Arabic_0* = 16778848'i32

const KEY_Arabic_1* = 16778849'i32

const KEY_Arabic_2* = 16778850'i32

const KEY_Arabic_3* = 16778851'i32

const KEY_Arabic_4* = 16778852'i32

const KEY_Arabic_5* = 16778853'i32

const KEY_Arabic_6* = 16778854'i32

const KEY_Arabic_7* = 16778855'i32

const KEY_Arabic_8* = 16778856'i32

const KEY_Arabic_9* = 16778857'i32

const KEY_Arabic_ain* = 1497'i32

const KEY_Arabic_alef* = 1479'i32

const KEY_Arabic_alefmaksura* = 1513'i32

const KEY_Arabic_beh* = 1480'i32

const KEY_Arabic_comma* = 1452'i32

const KEY_Arabic_dad* = 1494'i32

const KEY_Arabic_dal* = 1487'i32

const KEY_Arabic_damma* = 1519'i32

const KEY_Arabic_dammatan* = 1516'i32

const KEY_Arabic_ddal* = 16778888'i32

const KEY_Arabic_farsi_yeh* = 16778956'i32

const KEY_Arabic_fatha* = 1518'i32

const KEY_Arabic_fathatan* = 1515'i32

const KEY_Arabic_feh* = 1505'i32

const KEY_Arabic_fullstop* = 16778964'i32

const KEY_Arabic_gaf* = 16778927'i32

const KEY_Arabic_ghain* = 1498'i32

const KEY_Arabic_ha* = 1511'i32

const KEY_Arabic_hah* = 1485'i32

const KEY_Arabic_hamza* = 1473'i32

const KEY_Arabic_hamza_above* = 16778836'i32

const KEY_Arabic_hamza_below* = 16778837'i32

const KEY_Arabic_hamzaonalef* = 1475'i32

const KEY_Arabic_hamzaonwaw* = 1476'i32

const KEY_Arabic_hamzaonyeh* = 1478'i32

const KEY_Arabic_hamzaunderalef* = 1477'i32

const KEY_Arabic_heh* = 1511'i32

const KEY_Arabic_heh_doachashmee* = 16778942'i32

const KEY_Arabic_heh_goal* = 16778945'i32

const KEY_Arabic_jeem* = 1484'i32

const KEY_Arabic_jeh* = 16778904'i32

const KEY_Arabic_kaf* = 1507'i32

const KEY_Arabic_kasra* = 1520'i32

const KEY_Arabic_kasratan* = 1517'i32

const KEY_Arabic_keheh* = 16778921'i32

const KEY_Arabic_khah* = 1486'i32

const KEY_Arabic_lam* = 1508'i32

const KEY_Arabic_madda_above* = 16778835'i32

const KEY_Arabic_maddaonalef* = 1474'i32

const KEY_Arabic_meem* = 1509'i32

const KEY_Arabic_noon* = 1510'i32

const KEY_Arabic_noon_ghunna* = 16778938'i32

const KEY_Arabic_peh* = 16778878'i32

const KEY_Arabic_percent* = 16778858'i32

const KEY_Arabic_qaf* = 1506'i32

const KEY_Arabic_question_mark* = 1471'i32

const KEY_Arabic_ra* = 1489'i32

const KEY_Arabic_rreh* = 16778897'i32

const KEY_Arabic_sad* = 1493'i32

const KEY_Arabic_seen* = 1491'i32

const KEY_Arabic_semicolon* = 1467'i32

const KEY_Arabic_shadda* = 1521'i32

const KEY_Arabic_sheen* = 1492'i32

const KEY_Arabic_sukun* = 1522'i32

const KEY_Arabic_superscript_alef* = 16778864'i32

const KEY_Arabic_switch* = 65406'i32

const KEY_Arabic_tah* = 1495'i32

const KEY_Arabic_tatweel* = 1504'i32

const KEY_Arabic_tcheh* = 16778886'i32

const KEY_Arabic_teh* = 1482'i32

const KEY_Arabic_tehmarbuta* = 1481'i32

const KEY_Arabic_thal* = 1488'i32

const KEY_Arabic_theh* = 1483'i32

const KEY_Arabic_tteh* = 16778873'i32

const KEY_Arabic_veh* = 16778916'i32

const KEY_Arabic_waw* = 1512'i32

const KEY_Arabic_yeh* = 1514'i32

const KEY_Arabic_yeh_baree* = 16778962'i32

const KEY_Arabic_zah* = 1496'i32

const KEY_Arabic_zain* = 1490'i32

const UKEY_Aring* = 197'i32

const UKEY_Armenian_AT* = 16778552'i32

const UKEY_Armenian_AYB* = 16778545'i32

const UKEY_Armenian_BEN* = 16778546'i32

const UKEY_Armenian_CHA* = 16778569'i32

const UKEY_Armenian_DA* = 16778548'i32

const UKEY_Armenian_DZA* = 16778561'i32

const UKEY_Armenian_E* = 16778551'i32

const UKEY_Armenian_FE* = 16778582'i32

const UKEY_Armenian_GHAT* = 16778562'i32

const UKEY_Armenian_GIM* = 16778547'i32

const UKEY_Armenian_HI* = 16778565'i32

const UKEY_Armenian_HO* = 16778560'i32

const UKEY_Armenian_INI* = 16778555'i32

const UKEY_Armenian_JE* = 16778571'i32

const UKEY_Armenian_KE* = 16778580'i32

const UKEY_Armenian_KEN* = 16778559'i32

const UKEY_Armenian_KHE* = 16778557'i32

const UKEY_Armenian_LYUN* = 16778556'i32

const UKEY_Armenian_MEN* = 16778564'i32

const UKEY_Armenian_NU* = 16778566'i32

const UKEY_Armenian_O* = 16778581'i32

const UKEY_Armenian_PE* = 16778570'i32

const UKEY_Armenian_PYUR* = 16778579'i32

const UKEY_Armenian_RA* = 16778572'i32

const UKEY_Armenian_RE* = 16778576'i32

const UKEY_Armenian_SE* = 16778573'i32

const UKEY_Armenian_SHA* = 16778567'i32

const UKEY_Armenian_TCHE* = 16778563'i32

const UKEY_Armenian_TO* = 16778553'i32

const UKEY_Armenian_TSA* = 16778558'i32

const UKEY_Armenian_TSO* = 16778577'i32

const UKEY_Armenian_TYUN* = 16778575'i32

const UKEY_Armenian_VEV* = 16778574'i32

const UKEY_Armenian_VO* = 16778568'i32

const UKEY_Armenian_VYUN* = 16778578'i32

const UKEY_Armenian_YECH* = 16778549'i32

const UKEY_Armenian_ZA* = 16778550'i32

const UKEY_Armenian_ZHE* = 16778554'i32

const KEY_Armenian_accent* = 16778587'i32

const KEY_Armenian_amanak* = 16778588'i32

const KEY_Armenian_apostrophe* = 16778586'i32

const KEY_Armenian_at* = 16778600'i32

const KEY_Armenian_ayb* = 16778593'i32

const KEY_Armenian_ben* = 16778594'i32

const KEY_Armenian_but* = 16778589'i32

const KEY_Armenian_cha* = 16778617'i32

const KEY_Armenian_da* = 16778596'i32

const KEY_Armenian_dza* = 16778609'i32

const KEY_Armenian_e* = 16778599'i32

const KEY_Armenian_exclam* = 16778588'i32

const KEY_Armenian_fe* = 16778630'i32

const KEY_Armenian_full_stop* = 16778633'i32

const KEY_Armenian_ghat* = 16778610'i32

const KEY_Armenian_gim* = 16778595'i32

const KEY_Armenian_hi* = 16778613'i32

const KEY_Armenian_ho* = 16778608'i32

const KEY_Armenian_hyphen* = 16778634'i32

const KEY_Armenian_ini* = 16778603'i32

const KEY_Armenian_je* = 16778619'i32

const KEY_Armenian_ke* = 16778628'i32

const KEY_Armenian_ken* = 16778607'i32

const KEY_Armenian_khe* = 16778605'i32

const KEY_Armenian_ligature_ew* = 16778631'i32

const KEY_Armenian_lyun* = 16778604'i32

const KEY_Armenian_men* = 16778612'i32

const KEY_Armenian_nu* = 16778614'i32

const KEY_Armenian_o* = 16778629'i32

const KEY_Armenian_paruyk* = 16778590'i32

const KEY_Armenian_pe* = 16778618'i32

const KEY_Armenian_pyur* = 16778627'i32

const KEY_Armenian_question* = 16778590'i32

const KEY_Armenian_ra* = 16778620'i32

const KEY_Armenian_re* = 16778624'i32

const KEY_Armenian_se* = 16778621'i32

const KEY_Armenian_separation_mark* = 16778589'i32

const KEY_Armenian_sha* = 16778615'i32

const KEY_Armenian_shesht* = 16778587'i32

const KEY_Armenian_tche* = 16778611'i32

const KEY_Armenian_to* = 16778601'i32

const KEY_Armenian_tsa* = 16778606'i32

const KEY_Armenian_tso* = 16778625'i32

const KEY_Armenian_tyun* = 16778623'i32

const KEY_Armenian_verjaket* = 16778633'i32

const KEY_Armenian_vev* = 16778622'i32

const KEY_Armenian_vo* = 16778616'i32

const KEY_Armenian_vyun* = 16778626'i32

const KEY_Armenian_yech* = 16778597'i32

const KEY_Armenian_yentamna* = 16778634'i32

const KEY_Armenian_za* = 16778598'i32

const KEY_Armenian_zhe* = 16778602'i32

const UKEY_Atilde* = 195'i32

const KEY_AudibleBell_Enable* = 65146'i32

const KEY_AudioCycleTrack* = 269025179'i32

const KEY_AudioForward* = 269025175'i32

const KEY_AudioLowerVolume* = 269025041'i32

const KEY_AudioMedia* = 269025074'i32

const KEY_AudioMicMute* = 269025202'i32

const KEY_AudioMute* = 269025042'i32

const KEY_AudioNext* = 269025047'i32

const KEY_AudioPause* = 269025073'i32

const KEY_AudioPlay* = 269025044'i32

const KEY_AudioPreset* = 269025206'i32

const KEY_AudioPrev* = 269025046'i32

const KEY_AudioRaiseVolume* = 269025043'i32

const KEY_AudioRandomPlay* = 269025177'i32

const KEY_AudioRecord* = 269025052'i32

const KEY_AudioRepeat* = 269025176'i32

const KEY_AudioRewind* = 269025086'i32

const KEY_AudioStop* = 269025045'i32

const KEY_Away* = 269025165'i32

const UKEY_B* = 66'i32

const UKEY_Babovedot* = 16784898'i32

const KEY_Back* = 269025062'i32

const KEY_BackForward* = 269025087'i32

const KEY_BackSpace* = 65288'i32

const KEY_Battery* = 269025171'i32

const KEY_Begin* = 65368'i32

const KEY_Blue* = 269025190'i32

const KEY_Bluetooth* = 269025172'i32

const KEY_Book* = 269025106'i32

const KEY_BounceKeys_Enable* = 65140'i32

const KEY_Break* = 65387'i32

const KEY_BrightnessAdjust* = 269025083'i32

const UKEY_Byelorussian_SHORTU* = 1726'i32

const KEY_Byelorussian_shortu* = 1710'i32

const UKEY_C* = 67'i32

const KEY_CD* = 269025107'i32

const KEY_CH6* = 65186'i32

const KEY_C_H9* = 65189'i32

const KEY_C_h8* = 65188'i32

const UKEY_Cabovedot* = 709'i32

const UKEY_Cacute* = 454'i32

const KEY_Calculator* = 269025053'i32

const KEY_Calendar* = 269025056'i32

const KEY_Cancel* = 65385'i32

const KEY_Caps_Lock* = 65509'i32

const UKEY_Ccaron* = 456'i32

const UKEY_Ccedilla* = 199'i32

const UKEY_Ccircumflex* = 710'i32

const KEY_Ch5* = 65185'i32

const KEY_Clear* = 65291'i32

const KEY_ClearGrab* = 269024801'i32

const KEY_Close* = 269025110'i32

const KEY_Codeinput* = 65335'i32

const KEY_ColonSign* = 16785569'i32

const KEY_Community* = 269025085'i32

const KEY_ContrastAdjust* = 269025058'i32

const KEY_Control_L* = 65507'i32

const KEY_Control_R* = 65508'i32

const KEY_Copy* = 269025111'i32

const KEY_CruzeiroSign* = 16785570'i32

const KEY_Cut* = 269025112'i32

const KEY_CycleAngle* = 269025180'i32

const UKEY_Cyrillic_A* = 1761'i32

const UKEY_Cyrillic_BE* = 1762'i32

const UKEY_Cyrillic_CHE* = 1790'i32

const UKEY_Cyrillic_CHE_descender* = 16778422'i32

const UKEY_Cyrillic_CHE_vertstroke* = 16778424'i32

const UKEY_Cyrillic_DE* = 1764'i32

const UKEY_Cyrillic_DZHE* = 1727'i32

const UKEY_Cyrillic_E* = 1788'i32

const UKEY_Cyrillic_EF* = 1766'i32

const UKEY_Cyrillic_EL* = 1772'i32

const UKEY_Cyrillic_EM* = 1773'i32

const UKEY_Cyrillic_EN* = 1774'i32

const UKEY_Cyrillic_EN_descender* = 16778402'i32

const UKEY_Cyrillic_ER* = 1778'i32

const UKEY_Cyrillic_ES* = 1779'i32

const UKEY_Cyrillic_GHE* = 1767'i32

const UKEY_Cyrillic_GHE_bar* = 16778386'i32

const UKEY_Cyrillic_HA* = 1768'i32

const UKEY_Cyrillic_HARDSIGN* = 1791'i32

const UKEY_Cyrillic_HA_descender* = 16778418'i32

const UKEY_Cyrillic_I* = 1769'i32

const UKEY_Cyrillic_IE* = 1765'i32

const UKEY_Cyrillic_IO* = 1715'i32

const UKEY_Cyrillic_I_macron* = 16778466'i32

const UKEY_Cyrillic_JE* = 1720'i32

const UKEY_Cyrillic_KA* = 1771'i32

const UKEY_Cyrillic_KA_descender* = 16778394'i32

const UKEY_Cyrillic_KA_vertstroke* = 16778396'i32

const UKEY_Cyrillic_LJE* = 1721'i32

const UKEY_Cyrillic_NJE* = 1722'i32

const UKEY_Cyrillic_O* = 1775'i32

const UKEY_Cyrillic_O_bar* = 16778472'i32

const UKEY_Cyrillic_PE* = 1776'i32

const UKEY_Cyrillic_SCHWA* = 16778456'i32

const UKEY_Cyrillic_SHA* = 1787'i32

const UKEY_Cyrillic_SHCHA* = 1789'i32

const UKEY_Cyrillic_SHHA* = 16778426'i32

const UKEY_Cyrillic_SHORTI* = 1770'i32

const UKEY_Cyrillic_SOFTSIGN* = 1784'i32

const UKEY_Cyrillic_TE* = 1780'i32

const UKEY_Cyrillic_TSE* = 1763'i32

const UKEY_Cyrillic_U* = 1781'i32

const UKEY_Cyrillic_U_macron* = 16778478'i32

const UKEY_Cyrillic_U_straight* = 16778414'i32

const UKEY_Cyrillic_U_straight_bar* = 16778416'i32

const UKEY_Cyrillic_VE* = 1783'i32

const UKEY_Cyrillic_YA* = 1777'i32

const UKEY_Cyrillic_YERU* = 1785'i32

const UKEY_Cyrillic_YU* = 1760'i32

const UKEY_Cyrillic_ZE* = 1786'i32

const UKEY_Cyrillic_ZHE* = 1782'i32

const UKEY_Cyrillic_ZHE_descender* = 16778390'i32

const KEY_Cyrillic_a* = 1729'i32

const KEY_Cyrillic_be* = 1730'i32

const KEY_Cyrillic_che* = 1758'i32

const KEY_Cyrillic_che_descender* = 16778423'i32

const KEY_Cyrillic_che_vertstroke* = 16778425'i32

const KEY_Cyrillic_de* = 1732'i32

const KEY_Cyrillic_dzhe* = 1711'i32

const KEY_Cyrillic_e* = 1756'i32

const KEY_Cyrillic_ef* = 1734'i32

const KEY_Cyrillic_el* = 1740'i32

const KEY_Cyrillic_em* = 1741'i32

const KEY_Cyrillic_en* = 1742'i32

const KEY_Cyrillic_en_descender* = 16778403'i32

const KEY_Cyrillic_er* = 1746'i32

const KEY_Cyrillic_es* = 1747'i32

const KEY_Cyrillic_ghe* = 1735'i32

const KEY_Cyrillic_ghe_bar* = 16778387'i32

const KEY_Cyrillic_ha* = 1736'i32

const KEY_Cyrillic_ha_descender* = 16778419'i32

const KEY_Cyrillic_hardsign* = 1759'i32

const KEY_Cyrillic_i* = 1737'i32

const KEY_Cyrillic_i_macron* = 16778467'i32

const KEY_Cyrillic_ie* = 1733'i32

const KEY_Cyrillic_io* = 1699'i32

const KEY_Cyrillic_je* = 1704'i32

const KEY_Cyrillic_ka* = 1739'i32

const KEY_Cyrillic_ka_descender* = 16778395'i32

const KEY_Cyrillic_ka_vertstroke* = 16778397'i32

const KEY_Cyrillic_lje* = 1705'i32

const KEY_Cyrillic_nje* = 1706'i32

const KEY_Cyrillic_o* = 1743'i32

const KEY_Cyrillic_o_bar* = 16778473'i32

const KEY_Cyrillic_pe* = 1744'i32

const KEY_Cyrillic_schwa* = 16778457'i32

const KEY_Cyrillic_sha* = 1755'i32

const KEY_Cyrillic_shcha* = 1757'i32

const KEY_Cyrillic_shha* = 16778427'i32

const KEY_Cyrillic_shorti* = 1738'i32

const KEY_Cyrillic_softsign* = 1752'i32

const KEY_Cyrillic_te* = 1748'i32

const KEY_Cyrillic_tse* = 1731'i32

const KEY_Cyrillic_u* = 1749'i32

const KEY_Cyrillic_u_macron* = 16778479'i32

const KEY_Cyrillic_u_straight* = 16778415'i32

const KEY_Cyrillic_u_straight_bar* = 16778417'i32

const KEY_Cyrillic_ve* = 1751'i32

const KEY_Cyrillic_ya* = 1745'i32

const KEY_Cyrillic_yeru* = 1753'i32

const KEY_Cyrillic_yu* = 1728'i32

const KEY_Cyrillic_ze* = 1754'i32

const KEY_Cyrillic_zhe* = 1750'i32

const KEY_Cyrillic_zhe_descender* = 16778391'i32

const UKEY_D* = 68'i32

const KEY_DOS* = 269025114'i32

const UKEY_Dabovedot* = 16784906'i32

const UKEY_Dcaron* = 463'i32

const KEY_Delete* = 65535'i32

const KEY_Display* = 269025113'i32

const KEY_Documents* = 269025115'i32

const KEY_DongSign* = 16785579'i32

const KEY_Down* = 65364'i32

const UKEY_Dstroke* = 464'i32

const UKEY_E* = 69'i32

const UKEY_ENG* = 957'i32

const XKEY_ETH* = 208'i32

const UKEY_EZH* = 16777655'i32

const UKEY_Eabovedot* = 972'i32

const UKEY_Eacute* = 201'i32

const UKEY_Ebelowdot* = 16785080'i32

const UKEY_Ecaron* = 460'i32

const UKEY_Ecircumflex* = 202'i32

const UKEY_Ecircumflexacute* = 16785086'i32

const UKEY_Ecircumflexbelowdot* = 16785094'i32

const UKEY_Ecircumflexgrave* = 16785088'i32

const UKEY_Ecircumflexhook* = 16785090'i32

const UKEY_Ecircumflextilde* = 16785092'i32

const KEY_EcuSign* = 16785568'i32

const UKEY_Ediaeresis* = 203'i32

const UKEY_Egrave* = 200'i32

const UKEY_Ehook* = 16785082'i32

const KEY_Eisu_Shift* = 65327'i32

const KEY_Eisu_toggle* = 65328'i32

const KEY_Eject* = 269025068'i32

const UKEY_Emacron* = 938'i32

const KEY_End* = 65367'i32

const UKEY_Eogonek* = 458'i32

const KEY_Escape* = 65307'i32

const UKEY_Eth* = 208'i32

const UKEY_Etilde* = 16785084'i32

const KEY_EuroSign* = 8364'i32

const KEY_Excel* = 269025116'i32

const KEY_Execute* = 65378'i32

const KEY_Explorer* = 269025117'i32

const UKEY_F* = 70'i32

const KEY_F1* = 65470'i32

const KEY_F10* = 65479'i32

const KEY_F11* = 65480'i32

const KEY_F12* = 65481'i32

const KEY_F13* = 65482'i32

const KEY_F14* = 65483'i32

const KEY_F15* = 65484'i32

const KEY_F16* = 65485'i32

const KEY_F17* = 65486'i32

const KEY_F18* = 65487'i32

const KEY_F19* = 65488'i32

const KEY_F2* = 65471'i32

const KEY_F20* = 65489'i32

const KEY_F21* = 65490'i32

const KEY_F22* = 65491'i32

const KEY_F23* = 65492'i32

const KEY_F24* = 65493'i32

const KEY_F25* = 65494'i32

const KEY_F26* = 65495'i32

const KEY_F27* = 65496'i32

const KEY_F28* = 65497'i32

const KEY_F29* = 65498'i32

const KEY_F3* = 65472'i32

const KEY_F30* = 65499'i32

const KEY_F31* = 65500'i32

const KEY_F32* = 65501'i32

const KEY_F33* = 65502'i32

const KEY_F34* = 65503'i32

const KEY_F35* = 65504'i32

const KEY_F4* = 65473'i32

const KEY_F5* = 65474'i32

const KEY_F6* = 65475'i32

const KEY_F7* = 65476'i32

const KEY_F8* = 65477'i32

const KEY_F9* = 65478'i32

const KEY_FFrancSign* = 16785571'i32

const UKEY_Fabovedot* = 16784926'i32

const KEY_Farsi_0* = 16778992'i32

const KEY_Farsi_1* = 16778993'i32

const KEY_Farsi_2* = 16778994'i32

const KEY_Farsi_3* = 16778995'i32

const KEY_Farsi_4* = 16778996'i32

const KEY_Farsi_5* = 16778997'i32

const KEY_Farsi_6* = 16778998'i32

const KEY_Farsi_7* = 16778999'i32

const KEY_Farsi_8* = 16779000'i32

const KEY_Farsi_9* = 16779001'i32

const KEY_Farsi_yeh* = 16778956'i32

const KEY_Favorites* = 269025072'i32

const KEY_Finance* = 269025084'i32

const KEY_Find* = 65384'i32

const KEY_First_Virtual_Screen* = 65232'i32

const KEY_Forward* = 269025063'i32

const KEY_FrameBack* = 269025181'i32

const KEY_FrameForward* = 269025182'i32

const UKEY_G* = 71'i32

const UKEY_Gabovedot* = 725'i32

const KEY_Game* = 269025118'i32

const UKEY_Gbreve* = 683'i32

const UKEY_Gcaron* = 16777702'i32

const UKEY_Gcedilla* = 939'i32

const UKEY_Gcircumflex* = 728'i32

const KEY_Georgian_an* = 16781520'i32

const KEY_Georgian_ban* = 16781521'i32

const KEY_Georgian_can* = 16781546'i32

const KEY_Georgian_char* = 16781549'i32

const KEY_Georgian_chin* = 16781545'i32

const KEY_Georgian_cil* = 16781548'i32

const KEY_Georgian_don* = 16781523'i32

const KEY_Georgian_en* = 16781524'i32

const KEY_Georgian_fi* = 16781558'i32

const KEY_Georgian_gan* = 16781522'i32

const KEY_Georgian_ghan* = 16781542'i32

const KEY_Georgian_hae* = 16781552'i32

const KEY_Georgian_har* = 16781556'i32

const KEY_Georgian_he* = 16781553'i32

const KEY_Georgian_hie* = 16781554'i32

const KEY_Georgian_hoe* = 16781557'i32

const KEY_Georgian_in* = 16781528'i32

const KEY_Georgian_jhan* = 16781551'i32

const KEY_Georgian_jil* = 16781547'i32

const KEY_Georgian_kan* = 16781529'i32

const KEY_Georgian_khar* = 16781541'i32

const KEY_Georgian_las* = 16781530'i32

const KEY_Georgian_man* = 16781531'i32

const KEY_Georgian_nar* = 16781532'i32

const KEY_Georgian_on* = 16781533'i32

const KEY_Georgian_par* = 16781534'i32

const KEY_Georgian_phar* = 16781540'i32

const KEY_Georgian_qar* = 16781543'i32

const KEY_Georgian_rae* = 16781536'i32

const KEY_Georgian_san* = 16781537'i32

const KEY_Georgian_shin* = 16781544'i32

const KEY_Georgian_tan* = 16781527'i32

const KEY_Georgian_tar* = 16781538'i32

const KEY_Georgian_un* = 16781539'i32

const KEY_Georgian_vin* = 16781525'i32

const KEY_Georgian_we* = 16781555'i32

const KEY_Georgian_xan* = 16781550'i32

const KEY_Georgian_zen* = 16781526'i32

const KEY_Georgian_zhar* = 16781535'i32

const KEY_Go* = 269025119'i32

const UKEY_Greek_ALPHA* = 1985'i32

const UKEY_Greek_ALPHAaccent* = 1953'i32

const UKEY_Greek_BETA* = 1986'i32

const UKEY_Greek_CHI* = 2007'i32

const UKEY_Greek_DELTA* = 1988'i32

const UKEY_Greek_EPSILON* = 1989'i32

const UKEY_Greek_EPSILONaccent* = 1954'i32

const UKEY_Greek_ETA* = 1991'i32

const UKEY_Greek_ETAaccent* = 1955'i32

const UKEY_Greek_GAMMA* = 1987'i32

const UKEY_Greek_IOTA* = 1993'i32

const UKEY_Greek_IOTAaccent* = 1956'i32

const KEY_Greek_IOTAdiaeresis* = 1957'i32

const UKEY_Greek_IOTAdieresis* = 1957'i32

const UKEY_Greek_KAPPA* = 1994'i32

const UKEY_Greek_LAMBDA* = 1995'i32

const UKEY_Greek_LAMDA* = 1995'i32

const UKEY_Greek_MU* = 1996'i32

const UKEY_Greek_NU* = 1997'i32

const UKEY_Greek_OMEGA* = 2009'i32

const UKEY_Greek_OMEGAaccent* = 1963'i32

const UKEY_Greek_OMICRON* = 1999'i32

const UKEY_Greek_OMICRONaccent* = 1959'i32

const UKEY_Greek_PHI* = 2006'i32

const UKEY_Greek_PI* = 2000'i32

const UKEY_Greek_PSI* = 2008'i32

const UKEY_Greek_RHO* = 2001'i32

const UKEY_Greek_SIGMA* = 2002'i32

const UKEY_Greek_TAU* = 2004'i32

const UKEY_Greek_THETA* = 1992'i32

const UKEY_Greek_UPSILON* = 2005'i32

const UKEY_Greek_UPSILONaccent* = 1960'i32

const UKEY_Greek_UPSILONdieresis* = 1961'i32

const UKEY_Greek_XI* = 1998'i32

const UKEY_Greek_ZETA* = 1990'i32

const KEY_Greek_accentdieresis* = 1966'i32

const KEY_Greek_alpha* = 2017'i32

const KEY_Greek_alphaaccent* = 1969'i32

const KEY_Greek_beta* = 2018'i32

const KEY_Greek_chi* = 2039'i32

const KEY_Greek_delta* = 2020'i32

const KEY_Greek_epsilon* = 2021'i32

const KEY_Greek_epsilonaccent* = 1970'i32

const KEY_Greek_eta* = 2023'i32

const KEY_Greek_etaaccent* = 1971'i32

const KEY_Greek_finalsmallsigma* = 2035'i32

const KEY_Greek_gamma* = 2019'i32

const KEY_Greek_horizbar* = 1967'i32

const KEY_Greek_iota* = 2025'i32

const KEY_Greek_iotaaccent* = 1972'i32

const KEY_Greek_iotaaccentdieresis* = 1974'i32

const KEY_Greek_iotadieresis* = 1973'i32

const KEY_Greek_kappa* = 2026'i32

const KEY_Greek_lambda* = 2027'i32

const KEY_Greek_lamda* = 2027'i32

const KEY_Greek_mu* = 2028'i32

const KEY_Greek_nu* = 2029'i32

const KEY_Greek_omega* = 2041'i32

const KEY_Greek_omegaaccent* = 1979'i32

const KEY_Greek_omicron* = 2031'i32

const KEY_Greek_omicronaccent* = 1975'i32

const KEY_Greek_phi* = 2038'i32

const KEY_Greek_pi* = 2032'i32

const KEY_Greek_psi* = 2040'i32

const KEY_Greek_rho* = 2033'i32

const KEY_Greek_sigma* = 2034'i32

const KEY_Greek_switch* = 65406'i32

const KEY_Greek_tau* = 2036'i32

const KEY_Greek_theta* = 2024'i32

const KEY_Greek_upsilon* = 2037'i32

const KEY_Greek_upsilonaccent* = 1976'i32

const KEY_Greek_upsilonaccentdieresis* = 1978'i32

const KEY_Greek_upsilondieresis* = 1977'i32

const KEY_Greek_xi* = 2030'i32

const KEY_Greek_zeta* = 2022'i32

const KEY_Green* = 269025188'i32

const UKEY_H* = 72'i32

const KEY_Hangul* = 65329'i32

const KEY_Hangul_A* = 3775'i32

const KEY_Hangul_AE* = 3776'i32

const KEY_Hangul_AraeA* = 3830'i32

const KEY_Hangul_AraeAE* = 3831'i32

const KEY_Hangul_Banja* = 65337'i32

const KEY_Hangul_Cieuc* = 3770'i32

const KEY_Hangul_Codeinput* = 65335'i32

const KEY_Hangul_Dikeud* = 3751'i32

const KEY_Hangul_E* = 3780'i32

const KEY_Hangul_EO* = 3779'i32

const KEY_Hangul_EU* = 3793'i32

const KEY_Hangul_End* = 65331'i32

const KEY_Hangul_Hanja* = 65332'i32

const KEY_Hangul_Hieuh* = 3774'i32

const KEY_Hangul_I* = 3795'i32

const KEY_Hangul_Ieung* = 3767'i32

const KEY_Hangul_J_Cieuc* = 3818'i32

const KEY_Hangul_J_Dikeud* = 3802'i32

const KEY_Hangul_J_Hieuh* = 3822'i32

const KEY_Hangul_J_Ieung* = 3816'i32

const KEY_Hangul_J_Jieuj* = 3817'i32

const KEY_Hangul_J_Khieuq* = 3819'i32

const KEY_Hangul_J_Kiyeog* = 3796'i32

const KEY_Hangul_J_KiyeogSios* = 3798'i32

const KEY_Hangul_J_KkogjiDalrinIeung* = 3833'i32

const KEY_Hangul_J_Mieum* = 3811'i32

const KEY_Hangul_J_Nieun* = 3799'i32

const KEY_Hangul_J_NieunHieuh* = 3801'i32

const KEY_Hangul_J_NieunJieuj* = 3800'i32

const KEY_Hangul_J_PanSios* = 3832'i32

const KEY_Hangul_J_Phieuf* = 3821'i32

const KEY_Hangul_J_Pieub* = 3812'i32

const KEY_Hangul_J_PieubSios* = 3813'i32

const KEY_Hangul_J_Rieul* = 3803'i32

const KEY_Hangul_J_RieulHieuh* = 3810'i32

const KEY_Hangul_J_RieulKiyeog* = 3804'i32

const KEY_Hangul_J_RieulMieum* = 3805'i32

const KEY_Hangul_J_RieulPhieuf* = 3809'i32

const KEY_Hangul_J_RieulPieub* = 3806'i32

const KEY_Hangul_J_RieulSios* = 3807'i32

const KEY_Hangul_J_RieulTieut* = 3808'i32

const KEY_Hangul_J_Sios* = 3814'i32

const KEY_Hangul_J_SsangKiyeog* = 3797'i32

const KEY_Hangul_J_SsangSios* = 3815'i32

const KEY_Hangul_J_Tieut* = 3820'i32

const KEY_Hangul_J_YeorinHieuh* = 3834'i32

const KEY_Hangul_Jamo* = 65333'i32

const KEY_Hangul_Jeonja* = 65336'i32

const KEY_Hangul_Jieuj* = 3768'i32

const KEY_Hangul_Khieuq* = 3771'i32

const KEY_Hangul_Kiyeog* = 3745'i32

const KEY_Hangul_KiyeogSios* = 3747'i32

const KEY_Hangul_KkogjiDalrinIeung* = 3827'i32

const KEY_Hangul_Mieum* = 3761'i32

const KEY_Hangul_MultipleCandidate* = 65341'i32

const KEY_Hangul_Nieun* = 3748'i32

const KEY_Hangul_NieunHieuh* = 3750'i32

const KEY_Hangul_NieunJieuj* = 3749'i32

const KEY_Hangul_O* = 3783'i32

const KEY_Hangul_OE* = 3786'i32

const KEY_Hangul_PanSios* = 3826'i32

const KEY_Hangul_Phieuf* = 3773'i32

const KEY_Hangul_Pieub* = 3762'i32

const KEY_Hangul_PieubSios* = 3764'i32

const KEY_Hangul_PostHanja* = 65339'i32

const KEY_Hangul_PreHanja* = 65338'i32

const KEY_Hangul_PreviousCandidate* = 65342'i32

const KEY_Hangul_Rieul* = 3753'i32

const KEY_Hangul_RieulHieuh* = 3760'i32

const KEY_Hangul_RieulKiyeog* = 3754'i32

const KEY_Hangul_RieulMieum* = 3755'i32

const KEY_Hangul_RieulPhieuf* = 3759'i32

const KEY_Hangul_RieulPieub* = 3756'i32

const KEY_Hangul_RieulSios* = 3757'i32

const KEY_Hangul_RieulTieut* = 3758'i32

const KEY_Hangul_RieulYeorinHieuh* = 3823'i32

const KEY_Hangul_Romaja* = 65334'i32

const KEY_Hangul_SingleCandidate* = 65340'i32

const KEY_Hangul_Sios* = 3765'i32

const KEY_Hangul_Special* = 65343'i32

const KEY_Hangul_SsangDikeud* = 3752'i32

const KEY_Hangul_SsangJieuj* = 3769'i32

const KEY_Hangul_SsangKiyeog* = 3746'i32

const KEY_Hangul_SsangPieub* = 3763'i32

const KEY_Hangul_SsangSios* = 3766'i32

const KEY_Hangul_Start* = 65330'i32

const KEY_Hangul_SunkyeongeumMieum* = 3824'i32

const KEY_Hangul_SunkyeongeumPhieuf* = 3828'i32

const KEY_Hangul_SunkyeongeumPieub* = 3825'i32

const KEY_Hangul_Tieut* = 3772'i32

const KEY_Hangul_U* = 3788'i32

const KEY_Hangul_WA* = 3784'i32

const KEY_Hangul_WAE* = 3785'i32

const KEY_Hangul_WE* = 3790'i32

const KEY_Hangul_WEO* = 3789'i32

const KEY_Hangul_WI* = 3791'i32

const KEY_Hangul_YA* = 3777'i32

const KEY_Hangul_YAE* = 3778'i32

const KEY_Hangul_YE* = 3782'i32

const KEY_Hangul_YEO* = 3781'i32

const KEY_Hangul_YI* = 3794'i32

const KEY_Hangul_YO* = 3787'i32

const KEY_Hangul_YU* = 3792'i32

const KEY_Hangul_YeorinHieuh* = 3829'i32

const KEY_Hangul_switch* = 65406'i32

const KEY_Hankaku* = 65321'i32

const UKEY_Hcircumflex* = 678'i32

const KEY_Hebrew_switch* = 65406'i32

const KEY_Help* = 65386'i32

const KEY_Henkan* = 65315'i32

const KEY_Henkan_Mode* = 65315'i32

const KEY_Hibernate* = 269025192'i32

const KEY_Hiragana* = 65317'i32

const KEY_Hiragana_Katakana* = 65319'i32

const KEY_History* = 269025079'i32

const KEY_Home* = 65360'i32

const KEY_HomePage* = 269025048'i32

const KEY_HotLinks* = 269025082'i32

const UKEY_Hstroke* = 673'i32

const KEY_Hyper_L* = 65517'i32

const KEY_Hyper_R* = 65518'i32

const UKEY_I* = 73'i32

const KEY_ISO_Center_Object* = 65075'i32

const KEY_ISO_Continuous_Underline* = 65072'i32

const KEY_ISO_Discontinuous_Underline* = 65073'i32

const KEY_ISO_Emphasize* = 65074'i32

const KEY_ISO_Enter* = 65076'i32

const KEY_ISO_Fast_Cursor_Down* = 65071'i32

const KEY_ISO_Fast_Cursor_Left* = 65068'i32

const KEY_ISO_Fast_Cursor_Right* = 65069'i32

const KEY_ISO_Fast_Cursor_Up* = 65070'i32

const KEY_ISO_First_Group* = 65036'i32

const KEY_ISO_First_Group_Lock* = 65037'i32

const KEY_ISO_Group_Latch* = 65030'i32

const KEY_ISO_Group_Lock* = 65031'i32

const KEY_ISO_Group_Shift* = 65406'i32

const KEY_ISO_Last_Group* = 65038'i32

const KEY_ISO_Last_Group_Lock* = 65039'i32

const KEY_ISO_Left_Tab* = 65056'i32

const KEY_ISO_Level2_Latch* = 65026'i32

const KEY_ISO_Level3_Latch* = 65028'i32

const KEY_ISO_Level3_Lock* = 65029'i32

const KEY_ISO_Level3_Shift* = 65027'i32

const KEY_ISO_Level5_Latch* = 65042'i32

const KEY_ISO_Level5_Lock* = 65043'i32

const KEY_ISO_Level5_Shift* = 65041'i32

const KEY_ISO_Lock* = 65025'i32

const KEY_ISO_Move_Line_Down* = 65058'i32

const KEY_ISO_Move_Line_Up* = 65057'i32

const KEY_ISO_Next_Group* = 65032'i32

const KEY_ISO_Next_Group_Lock* = 65033'i32

const KEY_ISO_Partial_Line_Down* = 65060'i32

const KEY_ISO_Partial_Line_Up* = 65059'i32

const KEY_ISO_Partial_Space_Left* = 65061'i32

const KEY_ISO_Partial_Space_Right* = 65062'i32

const KEY_ISO_Prev_Group* = 65034'i32

const KEY_ISO_Prev_Group_Lock* = 65035'i32

const KEY_ISO_Release_Both_Margins* = 65067'i32

const KEY_ISO_Release_Margin_Left* = 65065'i32

const KEY_ISO_Release_Margin_Right* = 65066'i32

const KEY_ISO_Set_Margin_Left* = 65063'i32

const KEY_ISO_Set_Margin_Right* = 65064'i32

const KEY_Iabovedot* = 681'i32

const UKEY_Iacute* = 205'i32

const UKEY_Ibelowdot* = 16785098'i32

const UKEY_Ibreve* = 16777516'i32

const UKEY_Icircumflex* = 206'i32

const UKEY_Idiaeresis* = 207'i32

const UKEY_Igrave* = 204'i32

const UKEY_Ihook* = 16785096'i32

const UKEY_Imacron* = 975'i32

const KEY_Insert* = 65379'i32

const UKEY_Iogonek* = 967'i32

const UKEY_Itilde* = 933'i32

const UKEY_J* = 74'i32

const UKEY_Jcircumflex* = 684'i32

const UKEY_K* = 75'i32

const KEY_KP_0* = 65456'i32

const KEY_KP_1* = 65457'i32

const KEY_KP_2* = 65458'i32

const KEY_KP_3* = 65459'i32

const KEY_KP_4* = 65460'i32

const KEY_KP_5* = 65461'i32

const KEY_KP_6* = 65462'i32

const KEY_KP_7* = 65463'i32

const KEY_KP_8* = 65464'i32

const KEY_KP_9* = 65465'i32

const KEY_KP_Add* = 65451'i32

const KEY_KP_Begin* = 65437'i32

const KEY_KP_Decimal* = 65454'i32

const KEY_KP_Delete* = 65439'i32

const KEY_KP_Divide* = 65455'i32

const KEY_KP_Down* = 65433'i32

const KEY_KP_End* = 65436'i32

const KEY_KP_Enter* = 65421'i32

const KEY_KP_Equal* = 65469'i32

const KEY_KP_F1* = 65425'i32

const KEY_KP_F2* = 65426'i32

const KEY_KP_F3* = 65427'i32

const KEY_KP_F4* = 65428'i32

const KEY_KP_Home* = 65429'i32

const KEY_KP_Insert* = 65438'i32

const KEY_KP_Left* = 65430'i32

const KEY_KP_Multiply* = 65450'i32

const KEY_KP_Next* = 65435'i32

const KEY_KP_Page_Down* = 65435'i32

const KEY_KP_Page_Up* = 65434'i32

const KEY_KP_Prior* = 65434'i32

const KEY_KP_Right* = 65432'i32

const KEY_KP_Separator* = 65452'i32

const KEY_KP_Space* = 65408'i32

const KEY_KP_Subtract* = 65453'i32

const KEY_KP_Tab* = 65417'i32

const KEY_KP_Up* = 65431'i32

const KEY_Kana_Lock* = 65325'i32

const KEY_Kana_Shift* = 65326'i32

const KEY_Kanji* = 65313'i32

const KEY_Kanji_Bangou* = 65335'i32

const KEY_Katakana* = 65318'i32

const KEY_KbdBrightnessDown* = 269025030'i32

const KEY_KbdBrightnessUp* = 269025029'i32

const KEY_KbdLightOnOff* = 269025028'i32

const UKEY_Kcedilla* = 979'i32

const KEY_Keyboard* = 269025203'i32

const KEY_Korean_Won* = 3839'i32

const UKEY_L* = 76'i32

const KEY_L1* = 65480'i32

const KEY_L10* = 65489'i32

const KEY_L2* = 65481'i32

const KEY_L3* = 65482'i32

const KEY_L4* = 65483'i32

const KEY_L5* = 65484'i32

const KEY_L6* = 65485'i32

const KEY_L7* = 65486'i32

const KEY_L8* = 65487'i32

const KEY_L9* = 65488'i32

const UKEY_Lacute* = 453'i32

const KEY_Last_Virtual_Screen* = 65236'i32

const KEY_Launch0* = 269025088'i32

const KEY_Launch1* = 269025089'i32

const KEY_Launch2* = 269025090'i32

const KEY_Launch3* = 269025091'i32

const KEY_Launch4* = 269025092'i32

const KEY_Launch5* = 269025093'i32

const KEY_Launch6* = 269025094'i32

const KEY_Launch7* = 269025095'i32

const KEY_Launch8* = 269025096'i32

const KEY_Launch9* = 269025097'i32

const KEY_LaunchA* = 269025098'i32

const KEY_LaunchB* = 269025099'i32

const KEY_LaunchC* = 269025100'i32

const KEY_LaunchD* = 269025101'i32

const KEY_LaunchE* = 269025102'i32

const KEY_LaunchF* = 269025103'i32

const UKEY_Lbelowdot* = 16784950'i32

const UKEY_Lcaron* = 421'i32

const UKEY_Lcedilla* = 934'i32

const KEY_Left* = 65361'i32

const KEY_LightBulb* = 269025077'i32

const KEY_Linefeed* = 65290'i32

const KEY_LiraSign* = 16785572'i32

const KEY_LogGrabInfo* = 269024805'i32

const KEY_LogOff* = 269025121'i32

const KEY_LogWindowTree* = 269024804'i32

const UKEY_Lstroke* = 419'i32

const UKEY_M* = 77'i32

const UKEY_Mabovedot* = 16784960'i32

const UKEY_Macedonia_DSE* = 1717'i32

const UKEY_Macedonia_GJE* = 1714'i32

const UKEY_Macedonia_KJE* = 1724'i32

const KEY_Macedonia_dse* = 1701'i32

const KEY_Macedonia_gje* = 1698'i32

const KEY_Macedonia_kje* = 1708'i32

const KEY_Mae_Koho* = 65342'i32

const KEY_Mail* = 269025049'i32

const KEY_MailForward* = 269025168'i32

const KEY_Market* = 269025122'i32

const KEY_Massyo* = 65324'i32

const KEY_Meeting* = 269025123'i32

const KEY_Memo* = 269025054'i32

const KEY_Menu* = 65383'i32

const KEY_MenuKB* = 269025125'i32

const KEY_MenuPB* = 269025126'i32

const KEY_Messenger* = 269025166'i32

const KEY_Meta_L* = 65511'i32

const KEY_Meta_R* = 65512'i32

const KEY_MillSign* = 16785573'i32

const KEY_ModeLock* = 269025025'i32

const KEY_Mode_switch* = 65406'i32

const KEY_MonBrightnessDown* = 269025027'i32

const KEY_MonBrightnessUp* = 269025026'i32

const KEY_MouseKeys_Accel_Enable* = 65143'i32

const KEY_MouseKeys_Enable* = 65142'i32

const KEY_Muhenkan* = 65314'i32

const KEY_Multi_key* = 65312'i32

const KEY_MultipleCandidate* = 65341'i32

const KEY_Music* = 269025170'i32

const KEY_MyComputer* = 269025075'i32

const KEY_MySites* = 269025127'i32

const UKEY_N* = 78'i32

const UKEY_Nacute* = 465'i32

const KEY_NairaSign* = 16785574'i32

const UKEY_Ncaron* = 466'i32

const UKEY_Ncedilla* = 977'i32

const KEY_New* = 269025128'i32

const KEY_NewSheqelSign* = 16785578'i32

const KEY_News* = 269025129'i32

const KEY_Next* = 65366'i32

const KEY_Next_VMode* = 269024802'i32

const KEY_Next_Virtual_Screen* = 65234'i32

const UKEY_Ntilde* = 209'i32

const KEY_Num_Lock* = 65407'i32

const UKEY_O* = 79'i32

const UKEY_OE* = 5052'i32

const UKEY_Oacute* = 211'i32

const UKEY_Obarred* = 16777631'i32

const UKEY_Obelowdot* = 16785100'i32

const UKEY_Ocaron* = 16777681'i32

const UKEY_Ocircumflex* = 212'i32

const UKEY_Ocircumflexacute* = 16785104'i32

const UKEY_Ocircumflexbelowdot* = 16785112'i32

const UKEY_Ocircumflexgrave* = 16785106'i32

const UKEY_Ocircumflexhook* = 16785108'i32

const UKEY_Ocircumflextilde* = 16785110'i32

const UKEY_Odiaeresis* = 214'i32

const UKEY_Odoubleacute* = 469'i32

const KEY_OfficeHome* = 269025130'i32

const UKEY_Ograve* = 210'i32

const UKEY_Ohook* = 16785102'i32

const UKEY_Ohorn* = 16777632'i32

const UKEY_Ohornacute* = 16785114'i32

const UKEY_Ohornbelowdot* = 16785122'i32

const UKEY_Ohorngrave* = 16785116'i32

const UKEY_Ohornhook* = 16785118'i32

const UKEY_Ohorntilde* = 16785120'i32

const UKEY_Omacron* = 978'i32

const UKEY_Ooblique* = 216'i32

const KEY_Open* = 269025131'i32

const KEY_OpenURL* = 269025080'i32

const KEY_Option* = 269025132'i32

const UKEY_Oslash* = 216'i32

const UKEY_Otilde* = 213'i32

const KEY_Overlay1_Enable* = 65144'i32

const KEY_Overlay2_Enable* = 65145'i32

const UKEY_P* = 80'i32

const UKEY_Pabovedot* = 16784982'i32

const KEY_Page_Down* = 65366'i32

const KEY_Page_Up* = 65365'i32

const KEY_Paste* = 269025133'i32

const KEY_Pause* = 65299'i32

const KEY_PesetaSign* = 16785575'i32

const KEY_Phone* = 269025134'i32

const KEY_Pictures* = 269025169'i32

const KEY_Pointer_Accelerate* = 65274'i32

const KEY_Pointer_Button1* = 65257'i32

const KEY_Pointer_Button2* = 65258'i32

const KEY_Pointer_Button3* = 65259'i32

const KEY_Pointer_Button4* = 65260'i32

const KEY_Pointer_Button5* = 65261'i32

const KEY_Pointer_Button_Dflt* = 65256'i32

const KEY_Pointer_DblClick1* = 65263'i32

const KEY_Pointer_DblClick2* = 65264'i32

const KEY_Pointer_DblClick3* = 65265'i32

const KEY_Pointer_DblClick4* = 65266'i32

const KEY_Pointer_DblClick5* = 65267'i32

const KEY_Pointer_DblClick_Dflt* = 65262'i32

const KEY_Pointer_DfltBtnNext* = 65275'i32

const KEY_Pointer_DfltBtnPrev* = 65276'i32

const KEY_Pointer_Down* = 65251'i32

const KEY_Pointer_DownLeft* = 65254'i32

const KEY_Pointer_DownRight* = 65255'i32

const KEY_Pointer_Drag1* = 65269'i32

const KEY_Pointer_Drag2* = 65270'i32

const KEY_Pointer_Drag3* = 65271'i32

const KEY_Pointer_Drag4* = 65272'i32

const KEY_Pointer_Drag5* = 65277'i32

const KEY_Pointer_Drag_Dflt* = 65268'i32

const KEY_Pointer_EnableKeys* = 65273'i32

const KEY_Pointer_Left* = 65248'i32

const KEY_Pointer_Right* = 65249'i32

const KEY_Pointer_Up* = 65250'i32

const KEY_Pointer_UpLeft* = 65252'i32

const KEY_Pointer_UpRight* = 65253'i32

const KEY_PowerDown* = 269025057'i32

const KEY_PowerOff* = 269025066'i32

const KEY_Prev_VMode* = 269024803'i32

const KEY_Prev_Virtual_Screen* = 65233'i32

const KEY_PreviousCandidate* = 65342'i32

const KEY_Print* = 65377'i32

const KEY_Prior* = 65365'i32

const UKEY_Q* = 81'i32

const UKEY_R* = 82'i32

const KEY_R1* = 65490'i32

const KEY_R10* = 65499'i32

const KEY_R11* = 65500'i32

const KEY_R12* = 65501'i32

const KEY_R13* = 65502'i32

const KEY_R14* = 65503'i32

const KEY_R15* = 65504'i32

const KEY_R2* = 65491'i32

const KEY_R3* = 65492'i32

const KEY_R4* = 65493'i32

const KEY_R5* = 65494'i32

const KEY_R6* = 65495'i32

const KEY_R7* = 65496'i32

const KEY_R8* = 65497'i32

const KEY_R9* = 65498'i32

const KEY_RFKill* = 269025205'i32

const UKEY_Racute* = 448'i32

const UKEY_Rcaron* = 472'i32

const UKEY_Rcedilla* = 931'i32

const KEY_Red* = 269025187'i32

const KEY_Redo* = 65382'i32

const KEY_Refresh* = 269025065'i32

const KEY_Reload* = 269025139'i32

const KEY_RepeatKeys_Enable* = 65138'i32

const KEY_Reply* = 269025138'i32

const KEY_Return* = 65293'i32

const KEY_Right* = 65363'i32

const KEY_RockerDown* = 269025060'i32

const KEY_RockerEnter* = 269025061'i32

const KEY_RockerUp* = 269025059'i32

const KEY_Romaji* = 65316'i32

const KEY_RotateWindows* = 269025140'i32

const KEY_RotationKB* = 269025142'i32

const KEY_RotationPB* = 269025141'i32

const KEY_RupeeSign* = 16785576'i32

const UKEY_S* = 83'i32

const UKEY_SCHWA* = 16777615'i32

const UKEY_Sabovedot* = 16784992'i32

const UKEY_Sacute* = 422'i32

const KEY_Save* = 269025143'i32

const UKEY_Scaron* = 425'i32

const UKEY_Scedilla* = 426'i32

const UKEY_Scircumflex* = 734'i32

const KEY_ScreenSaver* = 269025069'i32

const KEY_ScrollClick* = 269025146'i32

const KEY_ScrollDown* = 269025145'i32

const KEY_ScrollUp* = 269025144'i32

const KEY_Scroll_Lock* = 65300'i32

const KEY_Search* = 269025051'i32

const KEY_Select* = 65376'i32

const KEY_SelectButton* = 269025184'i32

const KEY_Send* = 269025147'i32

const UKEY_Serbian_DJE* = 1713'i32

const UKEY_Serbian_DZE* = 1727'i32

const UKEY_Serbian_JE* = 1720'i32

const UKEY_Serbian_LJE* = 1721'i32

const UKEY_Serbian_NJE* = 1722'i32

const UKEY_Serbian_TSHE* = 1723'i32

const KEY_Serbian_dje* = 1697'i32

const KEY_Serbian_dze* = 1711'i32

const KEY_Serbian_je* = 1704'i32

const KEY_Serbian_lje* = 1705'i32

const KEY_Serbian_nje* = 1706'i32

const KEY_Serbian_tshe* = 1707'i32

const KEY_Shift_L* = 65505'i32

const KEY_Shift_Lock* = 65510'i32

const KEY_Shift_R* = 65506'i32

const KEY_Shop* = 269025078'i32

const KEY_SingleCandidate* = 65340'i32

const KEY_Sinh_a* = 16780677'i32

const KEY_Sinh_aa* = 16780678'i32

const KEY_Sinh_aa2* = 16780751'i32

const KEY_Sinh_ae* = 16780679'i32

const KEY_Sinh_ae2* = 16780752'i32

const KEY_Sinh_aee* = 16780680'i32

const KEY_Sinh_aee2* = 16780753'i32

const KEY_Sinh_ai* = 16780691'i32

const KEY_Sinh_ai2* = 16780763'i32

const KEY_Sinh_al* = 16780746'i32

const KEY_Sinh_au* = 16780694'i32

const KEY_Sinh_au2* = 16780766'i32

const KEY_Sinh_ba* = 16780726'i32

const KEY_Sinh_bha* = 16780727'i32

const KEY_Sinh_ca* = 16780704'i32

const KEY_Sinh_cha* = 16780705'i32

const KEY_Sinh_dda* = 16780713'i32

const KEY_Sinh_ddha* = 16780714'i32

const KEY_Sinh_dha* = 16780719'i32

const KEY_Sinh_dhha* = 16780720'i32

const KEY_Sinh_e* = 16780689'i32

const KEY_Sinh_e2* = 16780761'i32

const KEY_Sinh_ee* = 16780690'i32

const KEY_Sinh_ee2* = 16780762'i32

const KEY_Sinh_fa* = 16780742'i32

const KEY_Sinh_ga* = 16780700'i32

const KEY_Sinh_gha* = 16780701'i32

const KEY_Sinh_h2* = 16780675'i32

const KEY_Sinh_ha* = 16780740'i32

const KEY_Sinh_i* = 16780681'i32

const KEY_Sinh_i2* = 16780754'i32

const KEY_Sinh_ii* = 16780682'i32

const KEY_Sinh_ii2* = 16780755'i32

const KEY_Sinh_ja* = 16780706'i32

const KEY_Sinh_jha* = 16780707'i32

const KEY_Sinh_jnya* = 16780709'i32

const KEY_Sinh_ka* = 16780698'i32

const KEY_Sinh_kha* = 16780699'i32

const KEY_Sinh_kunddaliya* = 16780788'i32

const KEY_Sinh_la* = 16780733'i32

const KEY_Sinh_lla* = 16780741'i32

const KEY_Sinh_lu* = 16780687'i32

const KEY_Sinh_lu2* = 16780767'i32

const KEY_Sinh_luu* = 16780688'i32

const KEY_Sinh_luu2* = 16780787'i32

const KEY_Sinh_ma* = 16780728'i32

const KEY_Sinh_mba* = 16780729'i32

const KEY_Sinh_na* = 16780721'i32

const KEY_Sinh_ndda* = 16780716'i32

const KEY_Sinh_ndha* = 16780723'i32

const KEY_Sinh_ng* = 16780674'i32

const KEY_Sinh_ng2* = 16780702'i32

const KEY_Sinh_nga* = 16780703'i32

const KEY_Sinh_nja* = 16780710'i32

const KEY_Sinh_nna* = 16780715'i32

const KEY_Sinh_nya* = 16780708'i32

const KEY_Sinh_o* = 16780692'i32

const KEY_Sinh_o2* = 16780764'i32

const KEY_Sinh_oo* = 16780693'i32

const KEY_Sinh_oo2* = 16780765'i32

const KEY_Sinh_pa* = 16780724'i32

const KEY_Sinh_pha* = 16780725'i32

const KEY_Sinh_ra* = 16780731'i32

const KEY_Sinh_ri* = 16780685'i32

const KEY_Sinh_rii* = 16780686'i32

const KEY_Sinh_ru2* = 16780760'i32

const KEY_Sinh_ruu2* = 16780786'i32

const KEY_Sinh_sa* = 16780739'i32

const KEY_Sinh_sha* = 16780737'i32

const KEY_Sinh_ssha* = 16780738'i32

const KEY_Sinh_tha* = 16780717'i32

const KEY_Sinh_thha* = 16780718'i32

const KEY_Sinh_tta* = 16780711'i32

const KEY_Sinh_ttha* = 16780712'i32

const KEY_Sinh_u* = 16780683'i32

const KEY_Sinh_u2* = 16780756'i32

const KEY_Sinh_uu* = 16780684'i32

const KEY_Sinh_uu2* = 16780758'i32

const KEY_Sinh_va* = 16780736'i32

const KEY_Sinh_ya* = 16780730'i32

const KEY_Sleep* = 269025071'i32

const KEY_SlowKeys_Enable* = 65139'i32

const KEY_Spell* = 269025148'i32

const KEY_SplitScreen* = 269025149'i32

const KEY_Standby* = 269025040'i32

const KEY_Start* = 269025050'i32

const KEY_StickyKeys_Enable* = 65141'i32

const KEY_Stop* = 269025064'i32

const KEY_Subtitle* = 269025178'i32

const KEY_Super_L* = 65515'i32

const KEY_Super_R* = 65516'i32

const KEY_Support* = 269025150'i32

const KEY_Suspend* = 269025191'i32

const KEY_Switch_VT_1* = 269024769'i32

const KEY_Switch_VT_10* = 269024778'i32

const KEY_Switch_VT_11* = 269024779'i32

const KEY_Switch_VT_12* = 269024780'i32

const KEY_Switch_VT_2* = 269024770'i32

const KEY_Switch_VT_3* = 269024771'i32

const KEY_Switch_VT_4* = 269024772'i32

const KEY_Switch_VT_5* = 269024773'i32

const KEY_Switch_VT_6* = 269024774'i32

const KEY_Switch_VT_7* = 269024775'i32

const KEY_Switch_VT_8* = 269024776'i32

const KEY_Switch_VT_9* = 269024777'i32

const KEY_Sys_Req* = 65301'i32

const UKEY_T* = 84'i32

const XKEY_THORN* = 222'i32

const KEY_Tab* = 65289'i32

const UKEY_Tabovedot* = 16785002'i32

const KEY_TaskPane* = 269025151'i32

const UKEY_Tcaron* = 427'i32

const UKEY_Tcedilla* = 478'i32

const KEY_Terminal* = 269025152'i32

const KEY_Terminate_Server* = 65237'i32

const KEY_Thai_baht* = 3551'i32

const KEY_Thai_bobaimai* = 3514'i32

const KEY_Thai_chochan* = 3496'i32

const KEY_Thai_chochang* = 3498'i32

const KEY_Thai_choching* = 3497'i32

const KEY_Thai_chochoe* = 3500'i32

const KEY_Thai_dochada* = 3502'i32

const KEY_Thai_dodek* = 3508'i32

const KEY_Thai_fofa* = 3517'i32

const KEY_Thai_fofan* = 3519'i32

const KEY_Thai_hohip* = 3531'i32

const KEY_Thai_honokhuk* = 3534'i32

const KEY_Thai_khokhai* = 3490'i32

const KEY_Thai_khokhon* = 3493'i32

const KEY_Thai_khokhuat* = 3491'i32

const KEY_Thai_khokhwai* = 3492'i32

const KEY_Thai_khorakhang* = 3494'i32

const KEY_Thai_kokai* = 3489'i32

const KEY_Thai_lakkhangyao* = 3557'i32

const KEY_Thai_lekchet* = 3575'i32

const KEY_Thai_lekha* = 3573'i32

const KEY_Thai_lekhok* = 3574'i32

const KEY_Thai_lekkao* = 3577'i32

const KEY_Thai_leknung* = 3569'i32

const KEY_Thai_lekpaet* = 3576'i32

const KEY_Thai_leksam* = 3571'i32

const KEY_Thai_leksi* = 3572'i32

const KEY_Thai_leksong* = 3570'i32

const KEY_Thai_leksun* = 3568'i32

const KEY_Thai_lochula* = 3532'i32

const KEY_Thai_loling* = 3525'i32

const KEY_Thai_lu* = 3526'i32

const KEY_Thai_maichattawa* = 3563'i32

const KEY_Thai_maiek* = 3560'i32

const KEY_Thai_maihanakat* = 3537'i32

const KEY_Thai_maihanakat_maitho* = 3550'i32

const KEY_Thai_maitaikhu* = 3559'i32

const KEY_Thai_maitho* = 3561'i32

const KEY_Thai_maitri* = 3562'i32

const KEY_Thai_maiyamok* = 3558'i32

const KEY_Thai_moma* = 3521'i32

const KEY_Thai_ngongu* = 3495'i32

const KEY_Thai_nikhahit* = 3565'i32

const KEY_Thai_nonen* = 3507'i32

const KEY_Thai_nonu* = 3513'i32

const KEY_Thai_oang* = 3533'i32

const KEY_Thai_paiyannoi* = 3535'i32

const KEY_Thai_phinthu* = 3546'i32

const KEY_Thai_phophan* = 3518'i32

const KEY_Thai_phophung* = 3516'i32

const KEY_Thai_phosamphao* = 3520'i32

const KEY_Thai_popla* = 3515'i32

const KEY_Thai_rorua* = 3523'i32

const KEY_Thai_ru* = 3524'i32

const KEY_Thai_saraa* = 3536'i32

const KEY_Thai_saraaa* = 3538'i32

const KEY_Thai_saraae* = 3553'i32

const KEY_Thai_saraaimaimalai* = 3556'i32

const KEY_Thai_saraaimaimuan* = 3555'i32

const KEY_Thai_saraam* = 3539'i32

const KEY_Thai_sarae* = 3552'i32

const KEY_Thai_sarai* = 3540'i32

const KEY_Thai_saraii* = 3541'i32

const KEY_Thai_sarao* = 3554'i32

const KEY_Thai_sarau* = 3544'i32

const KEY_Thai_saraue* = 3542'i32

const KEY_Thai_sarauee* = 3543'i32

const KEY_Thai_sarauu* = 3545'i32

const KEY_Thai_sorusi* = 3529'i32

const KEY_Thai_sosala* = 3528'i32

const KEY_Thai_soso* = 3499'i32

const KEY_Thai_sosua* = 3530'i32

const KEY_Thai_thanthakhat* = 3564'i32

const KEY_Thai_thonangmontho* = 3505'i32

const KEY_Thai_thophuthao* = 3506'i32

const KEY_Thai_thothahan* = 3511'i32

const KEY_Thai_thothan* = 3504'i32

const KEY_Thai_thothong* = 3512'i32

const KEY_Thai_thothung* = 3510'i32

const KEY_Thai_topatak* = 3503'i32

const KEY_Thai_totao* = 3509'i32

const KEY_Thai_wowaen* = 3527'i32

const KEY_Thai_yoyak* = 3522'i32

const KEY_Thai_yoying* = 3501'i32

const UKEY_Thorn* = 222'i32

const KEY_Time* = 269025183'i32

const KEY_ToDoList* = 269025055'i32

const KEY_Tools* = 269025153'i32

const KEY_TopMenu* = 269025186'i32

const KEY_TouchpadOff* = 269025201'i32

const KEY_TouchpadOn* = 269025200'i32

const KEY_TouchpadToggle* = 269025193'i32

const KEY_Touroku* = 65323'i32

const KEY_Travel* = 269025154'i32

const UKEY_Tslash* = 940'i32

const UKEY_U* = 85'i32

const KEY_UWB* = 269025174'i32

const UKEY_Uacute* = 218'i32

const UKEY_Ubelowdot* = 16785124'i32

const UKEY_Ubreve* = 733'i32

const UKEY_Ucircumflex* = 219'i32

const UKEY_Udiaeresis* = 220'i32

const UKEY_Udoubleacute* = 475'i32

const UKEY_Ugrave* = 217'i32

const UKEY_Uhook* = 16785126'i32

const UKEY_Uhorn* = 16777647'i32

const UKEY_Uhornacute* = 16785128'i32

const UKEY_Uhornbelowdot* = 16785136'i32

const UKEY_Uhorngrave* = 16785130'i32

const UKEY_Uhornhook* = 16785132'i32

const UKEY_Uhorntilde* = 16785134'i32

const UKEY_Ukrainian_GHE_WITH_UPTURN* = 1725'i32

const UKEY_Ukrainian_I* = 1718'i32

const UKEY_Ukrainian_IE* = 1716'i32

const UKEY_Ukrainian_YI* = 1719'i32

const KEY_Ukrainian_ghe_with_upturn* = 1709'i32

const KEY_Ukrainian_i* = 1702'i32

const KEY_Ukrainian_ie* = 1700'i32

const KEY_Ukrainian_yi* = 1703'i32

const UKEY_Ukranian_I* = 1718'i32

const UKEY_Ukranian_JE* = 1716'i32

const UKEY_Ukranian_YI* = 1719'i32

const KEY_Ukranian_i* = 1702'i32

const KEY_Ukranian_je* = 1700'i32

const KEY_Ukranian_yi* = 1703'i32

const UKEY_Umacron* = 990'i32

const KEY_Undo* = 65381'i32

const KEY_Ungrab* = 269024800'i32

const UKEY_Uogonek* = 985'i32

const KEY_Up* = 65362'i32

const UKEY_Uring* = 473'i32

const KEY_User1KB* = 269025157'i32

const KEY_User2KB* = 269025158'i32

const KEY_UserPB* = 269025156'i32

const UKEY_Utilde* = 989'i32

const UKEY_V* = 86'i32

const KEY_VendorHome* = 269025076'i32

const KEY_Video* = 269025159'i32

const KEY_View* = 269025185'i32

const KEY_VoidSymbol* = 16777215'i32

const UKEY_W* = 87'i32

const KEY_WLAN* = 269025173'i32

const KEY_WWAN* = 269025204'i32

const KEY_WWW* = 269025070'i32

const UKEY_Wacute* = 16785026'i32

const KEY_WakeUp* = 269025067'i32

const UKEY_Wcircumflex* = 16777588'i32

const UKEY_Wdiaeresis* = 16785028'i32

const KEY_WebCam* = 269025167'i32

const UKEY_Wgrave* = 16785024'i32

const KEY_WheelButton* = 269025160'i32

const KEY_WindowClear* = 269025109'i32

const KEY_WonSign* = 16785577'i32

const KEY_Word* = 269025161'i32

const UKEY_X* = 88'i32

const UKEY_Xabovedot* = 16785034'i32

const KEY_Xfer* = 269025162'i32

const UKEY_Y* = 89'i32

const UKEY_Yacute* = 221'i32

const UKEY_Ybelowdot* = 16785140'i32

const UKEY_Ycircumflex* = 16777590'i32

const UKEY_Ydiaeresis* = 5054'i32

const KEY_Yellow* = 269025189'i32

const UKEY_Ygrave* = 16785138'i32

const UKEY_Yhook* = 16785142'i32

const UKEY_Ytilde* = 16785144'i32

const UKEY_Z* = 90'i32

const UKEY_Zabovedot* = 431'i32

const UKEY_Zacute* = 428'i32

const UKEY_Zcaron* = 430'i32

const KEY_Zen_Koho* = 65341'i32

const KEY_Zenkaku* = 65320'i32

const KEY_Zenkaku_Hankaku* = 65322'i32

const KEY_ZoomIn* = 269025163'i32

const KEY_ZoomOut* = 269025164'i32

const UKEY_Zstroke* = 16777653'i32

const KEY_a* = 97'i32

const KEY_aacute* = 225'i32

const KEY_abelowdot* = 16785057'i32

const KEY_abovedot* = 511'i32

const KEY_abreve* = 483'i32

const KEY_abreveacute* = 16785071'i32

const KEY_abrevebelowdot* = 16785079'i32

const KEY_abrevegrave* = 16785073'i32

const KEY_abrevehook* = 16785075'i32

const KEY_abrevetilde* = 16785077'i32

const KEY_acircumflex* = 226'i32

const KEY_acircumflexacute* = 16785061'i32

const KEY_acircumflexbelowdot* = 16785069'i32

const KEY_acircumflexgrave* = 16785063'i32

const KEY_acircumflexhook* = 16785065'i32

const KEY_acircumflextilde* = 16785067'i32

const KEY_acute* = 180'i32

const KEY_adiaeresis* = 228'i32

const KEY_ae* = 230'i32

const KEY_agrave* = 224'i32

const KEY_ahook* = 16785059'i32

const KEY_amacron* = 992'i32

const KEY_ampersand* = 38'i32

const KEY_aogonek* = 433'i32

const KEY_apostrophe* = 39'i32

const KEY_approxeq* = 16785992'i32

const KEY_approximate* = 2248'i32

const KEY_aring* = 229'i32

const KEY_asciicircum* = 94'i32

const KEY_asciitilde* = 126'i32

const KEY_asterisk* = 42'i32

const KEY_at* = 64'i32

const KEY_atilde* = 227'i32

const KEY_b* = 98'i32

const KEY_babovedot* = 16784899'i32

const KEY_backslash* = 92'i32

const KEY_ballotcross* = 2804'i32

const KEY_bar* = 124'i32

const KEY_because* = 16785973'i32

const KEY_blank* = 2527'i32

const KEY_botintegral* = 2213'i32

const KEY_botleftparens* = 2220'i32

const KEY_botleftsqbracket* = 2216'i32

const KEY_botleftsummation* = 2226'i32

const KEY_botrightparens* = 2222'i32

const KEY_botrightsqbracket* = 2218'i32

const KEY_botrightsummation* = 2230'i32

const KEY_bott* = 2550'i32

const KEY_botvertsummationconnector* = 2228'i32

const KEY_braceleft* = 123'i32

const KEY_braceright* = 125'i32

const KEY_bracketleft* = 91'i32

const KEY_bracketright* = 93'i32

const KEY_braille_blank* = 16787456'i32

const KEY_braille_dot_1* = 65521'i32

const KEY_braille_dot_10* = 65530'i32

const KEY_braille_dot_2* = 65522'i32

const KEY_braille_dot_3* = 65523'i32

const KEY_braille_dot_4* = 65524'i32

const KEY_braille_dot_5* = 65525'i32

const KEY_braille_dot_6* = 65526'i32

const KEY_braille_dot_7* = 65527'i32

const KEY_braille_dot_8* = 65528'i32

const KEY_braille_dot_9* = 65529'i32

const KEY_braille_dots_1* = 16787457'i32

const KEY_braille_dots_12* = 16787459'i32

const KEY_braille_dots_123* = 16787463'i32

const KEY_braille_dots_1234* = 16787471'i32

const KEY_braille_dots_12345* = 16787487'i32

const KEY_braille_dots_123456* = 16787519'i32

const KEY_braille_dots_1234567* = 16787583'i32

const KEY_braille_dots_12345678* = 16787711'i32

const KEY_braille_dots_1234568* = 16787647'i32

const KEY_braille_dots_123457* = 16787551'i32

const KEY_braille_dots_1234578* = 16787679'i32

const KEY_braille_dots_123458* = 16787615'i32

const KEY_braille_dots_12346* = 16787503'i32

const KEY_braille_dots_123467* = 16787567'i32

const KEY_braille_dots_1234678* = 16787695'i32

const KEY_braille_dots_123468* = 16787631'i32

const KEY_braille_dots_12347* = 16787535'i32

const KEY_braille_dots_123478* = 16787663'i32

const KEY_braille_dots_12348* = 16787599'i32

const KEY_braille_dots_1235* = 16787479'i32

const KEY_braille_dots_12356* = 16787511'i32

const KEY_braille_dots_123567* = 16787575'i32

const KEY_braille_dots_1235678* = 16787703'i32

const KEY_braille_dots_123568* = 16787639'i32

const KEY_braille_dots_12357* = 16787543'i32

const KEY_braille_dots_123578* = 16787671'i32

const KEY_braille_dots_12358* = 16787607'i32

const KEY_braille_dots_1236* = 16787495'i32

const KEY_braille_dots_12367* = 16787559'i32

const KEY_braille_dots_123678* = 16787687'i32

const KEY_braille_dots_12368* = 16787623'i32

const KEY_braille_dots_1237* = 16787527'i32

const KEY_braille_dots_12378* = 16787655'i32

const KEY_braille_dots_1238* = 16787591'i32

const KEY_braille_dots_124* = 16787467'i32

const KEY_braille_dots_1245* = 16787483'i32

const KEY_braille_dots_12456* = 16787515'i32

const KEY_braille_dots_124567* = 16787579'i32

const KEY_braille_dots_1245678* = 16787707'i32

const KEY_braille_dots_124568* = 16787643'i32

const KEY_braille_dots_12457* = 16787547'i32

const KEY_braille_dots_124578* = 16787675'i32

const KEY_braille_dots_12458* = 16787611'i32

const KEY_braille_dots_1246* = 16787499'i32

const KEY_braille_dots_12467* = 16787563'i32

const KEY_braille_dots_124678* = 16787691'i32

const KEY_braille_dots_12468* = 16787627'i32

const KEY_braille_dots_1247* = 16787531'i32

const KEY_braille_dots_12478* = 16787659'i32

const KEY_braille_dots_1248* = 16787595'i32

const KEY_braille_dots_125* = 16787475'i32

const KEY_braille_dots_1256* = 16787507'i32

const KEY_braille_dots_12567* = 16787571'i32

const KEY_braille_dots_125678* = 16787699'i32

const KEY_braille_dots_12568* = 16787635'i32

const KEY_braille_dots_1257* = 16787539'i32

const KEY_braille_dots_12578* = 16787667'i32

const KEY_braille_dots_1258* = 16787603'i32

const KEY_braille_dots_126* = 16787491'i32

const KEY_braille_dots_1267* = 16787555'i32

const KEY_braille_dots_12678* = 16787683'i32

const KEY_braille_dots_1268* = 16787619'i32

const KEY_braille_dots_127* = 16787523'i32

const KEY_braille_dots_1278* = 16787651'i32

const KEY_braille_dots_128* = 16787587'i32

const KEY_braille_dots_13* = 16787461'i32

const KEY_braille_dots_134* = 16787469'i32

const KEY_braille_dots_1345* = 16787485'i32

const KEY_braille_dots_13456* = 16787517'i32

const KEY_braille_dots_134567* = 16787581'i32

const KEY_braille_dots_1345678* = 16787709'i32

const KEY_braille_dots_134568* = 16787645'i32

const KEY_braille_dots_13457* = 16787549'i32

const KEY_braille_dots_134578* = 16787677'i32

const KEY_braille_dots_13458* = 16787613'i32

const KEY_braille_dots_1346* = 16787501'i32

const KEY_braille_dots_13467* = 16787565'i32

const KEY_braille_dots_134678* = 16787693'i32

const KEY_braille_dots_13468* = 16787629'i32

const KEY_braille_dots_1347* = 16787533'i32

const KEY_braille_dots_13478* = 16787661'i32

const KEY_braille_dots_1348* = 16787597'i32

const KEY_braille_dots_135* = 16787477'i32

const KEY_braille_dots_1356* = 16787509'i32

const KEY_braille_dots_13567* = 16787573'i32

const KEY_braille_dots_135678* = 16787701'i32

const KEY_braille_dots_13568* = 16787637'i32

const KEY_braille_dots_1357* = 16787541'i32

const KEY_braille_dots_13578* = 16787669'i32

const KEY_braille_dots_1358* = 16787605'i32

const KEY_braille_dots_136* = 16787493'i32

const KEY_braille_dots_1367* = 16787557'i32

const KEY_braille_dots_13678* = 16787685'i32

const KEY_braille_dots_1368* = 16787621'i32

const KEY_braille_dots_137* = 16787525'i32

const KEY_braille_dots_1378* = 16787653'i32

const KEY_braille_dots_138* = 16787589'i32

const KEY_braille_dots_14* = 16787465'i32

const KEY_braille_dots_145* = 16787481'i32

const KEY_braille_dots_1456* = 16787513'i32

const KEY_braille_dots_14567* = 16787577'i32

const KEY_braille_dots_145678* = 16787705'i32

const KEY_braille_dots_14568* = 16787641'i32

const KEY_braille_dots_1457* = 16787545'i32

const KEY_braille_dots_14578* = 16787673'i32

const KEY_braille_dots_1458* = 16787609'i32

const KEY_braille_dots_146* = 16787497'i32

const KEY_braille_dots_1467* = 16787561'i32

const KEY_braille_dots_14678* = 16787689'i32

const KEY_braille_dots_1468* = 16787625'i32

const KEY_braille_dots_147* = 16787529'i32

const KEY_braille_dots_1478* = 16787657'i32

const KEY_braille_dots_148* = 16787593'i32

const KEY_braille_dots_15* = 16787473'i32

const KEY_braille_dots_156* = 16787505'i32

const KEY_braille_dots_1567* = 16787569'i32

const KEY_braille_dots_15678* = 16787697'i32

const KEY_braille_dots_1568* = 16787633'i32

const KEY_braille_dots_157* = 16787537'i32

const KEY_braille_dots_1578* = 16787665'i32

const KEY_braille_dots_158* = 16787601'i32

const KEY_braille_dots_16* = 16787489'i32

const KEY_braille_dots_167* = 16787553'i32

const KEY_braille_dots_1678* = 16787681'i32

const KEY_braille_dots_168* = 16787617'i32

const KEY_braille_dots_17* = 16787521'i32

const KEY_braille_dots_178* = 16787649'i32

const KEY_braille_dots_18* = 16787585'i32

const KEY_braille_dots_2* = 16787458'i32

const KEY_braille_dots_23* = 16787462'i32

const KEY_braille_dots_234* = 16787470'i32

const KEY_braille_dots_2345* = 16787486'i32

const KEY_braille_dots_23456* = 16787518'i32

const KEY_braille_dots_234567* = 16787582'i32

const KEY_braille_dots_2345678* = 16787710'i32

const KEY_braille_dots_234568* = 16787646'i32

const KEY_braille_dots_23457* = 16787550'i32

const KEY_braille_dots_234578* = 16787678'i32

const KEY_braille_dots_23458* = 16787614'i32

const KEY_braille_dots_2346* = 16787502'i32

const KEY_braille_dots_23467* = 16787566'i32

const KEY_braille_dots_234678* = 16787694'i32

const KEY_braille_dots_23468* = 16787630'i32

const KEY_braille_dots_2347* = 16787534'i32

const KEY_braille_dots_23478* = 16787662'i32

const KEY_braille_dots_2348* = 16787598'i32

const KEY_braille_dots_235* = 16787478'i32

const KEY_braille_dots_2356* = 16787510'i32

const KEY_braille_dots_23567* = 16787574'i32

const KEY_braille_dots_235678* = 16787702'i32

const KEY_braille_dots_23568* = 16787638'i32

const KEY_braille_dots_2357* = 16787542'i32

const KEY_braille_dots_23578* = 16787670'i32

const KEY_braille_dots_2358* = 16787606'i32

const KEY_braille_dots_236* = 16787494'i32

const KEY_braille_dots_2367* = 16787558'i32

const KEY_braille_dots_23678* = 16787686'i32

const KEY_braille_dots_2368* = 16787622'i32

const KEY_braille_dots_237* = 16787526'i32

const KEY_braille_dots_2378* = 16787654'i32

const KEY_braille_dots_238* = 16787590'i32

const KEY_braille_dots_24* = 16787466'i32

const KEY_braille_dots_245* = 16787482'i32

const KEY_braille_dots_2456* = 16787514'i32

const KEY_braille_dots_24567* = 16787578'i32

const KEY_braille_dots_245678* = 16787706'i32

const KEY_braille_dots_24568* = 16787642'i32

const KEY_braille_dots_2457* = 16787546'i32

const KEY_braille_dots_24578* = 16787674'i32

const KEY_braille_dots_2458* = 16787610'i32

const KEY_braille_dots_246* = 16787498'i32

const KEY_braille_dots_2467* = 16787562'i32

const KEY_braille_dots_24678* = 16787690'i32

const KEY_braille_dots_2468* = 16787626'i32

const KEY_braille_dots_247* = 16787530'i32

const KEY_braille_dots_2478* = 16787658'i32

const KEY_braille_dots_248* = 16787594'i32

const KEY_braille_dots_25* = 16787474'i32

const KEY_braille_dots_256* = 16787506'i32

const KEY_braille_dots_2567* = 16787570'i32

const KEY_braille_dots_25678* = 16787698'i32

const KEY_braille_dots_2568* = 16787634'i32

const KEY_braille_dots_257* = 16787538'i32

const KEY_braille_dots_2578* = 16787666'i32

const KEY_braille_dots_258* = 16787602'i32

const KEY_braille_dots_26* = 16787490'i32

const KEY_braille_dots_267* = 16787554'i32

const KEY_braille_dots_2678* = 16787682'i32

const KEY_braille_dots_268* = 16787618'i32

const KEY_braille_dots_27* = 16787522'i32

const KEY_braille_dots_278* = 16787650'i32

const KEY_braille_dots_28* = 16787586'i32

const KEY_braille_dots_3* = 16787460'i32

const KEY_braille_dots_34* = 16787468'i32

const KEY_braille_dots_345* = 16787484'i32

const KEY_braille_dots_3456* = 16787516'i32

const KEY_braille_dots_34567* = 16787580'i32

const KEY_braille_dots_345678* = 16787708'i32

const KEY_braille_dots_34568* = 16787644'i32

const KEY_braille_dots_3457* = 16787548'i32

const KEY_braille_dots_34578* = 16787676'i32

const KEY_braille_dots_3458* = 16787612'i32

const KEY_braille_dots_346* = 16787500'i32

const KEY_braille_dots_3467* = 16787564'i32

const KEY_braille_dots_34678* = 16787692'i32

const KEY_braille_dots_3468* = 16787628'i32

const KEY_braille_dots_347* = 16787532'i32

const KEY_braille_dots_3478* = 16787660'i32

const KEY_braille_dots_348* = 16787596'i32

const KEY_braille_dots_35* = 16787476'i32

const KEY_braille_dots_356* = 16787508'i32

const KEY_braille_dots_3567* = 16787572'i32

const KEY_braille_dots_35678* = 16787700'i32

const KEY_braille_dots_3568* = 16787636'i32

const KEY_braille_dots_357* = 16787540'i32

const KEY_braille_dots_3578* = 16787668'i32

const KEY_braille_dots_358* = 16787604'i32

const KEY_braille_dots_36* = 16787492'i32

const KEY_braille_dots_367* = 16787556'i32

const KEY_braille_dots_3678* = 16787684'i32

const KEY_braille_dots_368* = 16787620'i32

const KEY_braille_dots_37* = 16787524'i32

const KEY_braille_dots_378* = 16787652'i32

const KEY_braille_dots_38* = 16787588'i32

const KEY_braille_dots_4* = 16787464'i32

const KEY_braille_dots_45* = 16787480'i32

const KEY_braille_dots_456* = 16787512'i32

const KEY_braille_dots_4567* = 16787576'i32

const KEY_braille_dots_45678* = 16787704'i32

const KEY_braille_dots_4568* = 16787640'i32

const KEY_braille_dots_457* = 16787544'i32

const KEY_braille_dots_4578* = 16787672'i32

const KEY_braille_dots_458* = 16787608'i32

const KEY_braille_dots_46* = 16787496'i32

const KEY_braille_dots_467* = 16787560'i32

const KEY_braille_dots_4678* = 16787688'i32

const KEY_braille_dots_468* = 16787624'i32

const KEY_braille_dots_47* = 16787528'i32

const KEY_braille_dots_478* = 16787656'i32

const KEY_braille_dots_48* = 16787592'i32

const KEY_braille_dots_5* = 16787472'i32

const KEY_braille_dots_56* = 16787504'i32

const KEY_braille_dots_567* = 16787568'i32

const KEY_braille_dots_5678* = 16787696'i32

const KEY_braille_dots_568* = 16787632'i32

const KEY_braille_dots_57* = 16787536'i32

const KEY_braille_dots_578* = 16787664'i32

const KEY_braille_dots_58* = 16787600'i32

const KEY_braille_dots_6* = 16787488'i32

const KEY_braille_dots_67* = 16787552'i32

const KEY_braille_dots_678* = 16787680'i32

const KEY_braille_dots_68* = 16787616'i32

const KEY_braille_dots_7* = 16787520'i32

const KEY_braille_dots_78* = 16787648'i32

const KEY_braille_dots_8* = 16787584'i32

const KEY_breve* = 418'i32

const KEY_brokenbar* = 166'i32

const KEY_c* = 99'i32

const KEY_cH7* = 65187'i32

const KEY_cabovedot* = 741'i32

const KEY_cacute* = 486'i32

const KEY_careof* = 2744'i32

const KEY_caret* = 2812'i32

const KEY_caron* = 439'i32

const KEY_ccaron* = 488'i32

const KEY_ccedilla* = 231'i32

const KEY_ccircumflex* = 742'i32

const KEY_cedilla* = 184'i32

const KEY_cent* = 162'i32

const KEY_ch4* = 65184'i32

const KEY_checkerboard* = 2529'i32

const KEY_checkmark* = 2803'i32

const KEY_circle* = 3023'i32

const KEY_club* = 2796'i32

const KEY_colon* = 58'i32

const KEY_comma* = 44'i32

const KEY_containsas* = 16785931'i32

const KEY_copyright* = 169'i32

const KEY_cr* = 2532'i32

const KEY_crossinglines* = 2542'i32

const KEY_cuberoot* = 16785947'i32

const KEY_currency* = 164'i32

const KEY_cursor* = 2815'i32

const KEY_d* = 100'i32

const KEY_dabovedot* = 16784907'i32

const KEY_dagger* = 2801'i32

const KEY_dcaron* = 495'i32

const UKEY_dead_A* = 65153'i32

const UKEY_dead_E* = 65155'i32

const UKEY_dead_I* = 65157'i32

const UKEY_dead_O* = 65159'i32

const UKEY_dead_U* = 65161'i32

const KEY_dead_a* = 65152'i32

const KEY_dead_abovecomma* = 65124'i32

const KEY_dead_abovedot* = 65110'i32

const KEY_dead_abovereversedcomma* = 65125'i32

const KEY_dead_abovering* = 65112'i32

const KEY_dead_aboveverticalline* = 65169'i32

const KEY_dead_acute* = 65105'i32

const KEY_dead_belowbreve* = 65131'i32

const KEY_dead_belowcircumflex* = 65129'i32

const KEY_dead_belowcomma* = 65134'i32

const KEY_dead_belowdiaeresis* = 65132'i32

const KEY_dead_belowdot* = 65120'i32

const KEY_dead_belowmacron* = 65128'i32

const KEY_dead_belowring* = 65127'i32

const KEY_dead_belowtilde* = 65130'i32

const KEY_dead_belowverticalline* = 65170'i32

const KEY_dead_breve* = 65109'i32

const KEY_dead_capital_schwa* = 65163'i32

const KEY_dead_caron* = 65114'i32

const KEY_dead_cedilla* = 65115'i32

const KEY_dead_circumflex* = 65106'i32

const KEY_dead_currency* = 65135'i32

const KEY_dead_dasia* = 65125'i32

const KEY_dead_diaeresis* = 65111'i32

const KEY_dead_doubleacute* = 65113'i32

const KEY_dead_doublegrave* = 65126'i32

const KEY_dead_e* = 65154'i32

const KEY_dead_grave* = 65104'i32

const KEY_dead_greek* = 65164'i32

const KEY_dead_hook* = 65121'i32

const KEY_dead_horn* = 65122'i32

const KEY_dead_i* = 65156'i32

const KEY_dead_invertedbreve* = 65133'i32

const KEY_dead_iota* = 65117'i32

const KEY_dead_longsolidusoverlay* = 65171'i32

const KEY_dead_lowline* = 65168'i32

const KEY_dead_macron* = 65108'i32

const KEY_dead_o* = 65158'i32

const KEY_dead_ogonek* = 65116'i32

const KEY_dead_perispomeni* = 65107'i32

const KEY_dead_psili* = 65124'i32

const KEY_dead_semivoiced_sound* = 65119'i32

const KEY_dead_small_schwa* = 65162'i32

const KEY_dead_stroke* = 65123'i32

const KEY_dead_tilde* = 65107'i32

const KEY_dead_u* = 65160'i32

const KEY_dead_voiced_sound* = 65118'i32

const KEY_decimalpoint* = 2749'i32

const KEY_degree* = 176'i32

const KEY_diaeresis* = 168'i32

const KEY_diamond* = 2797'i32

const KEY_digitspace* = 2725'i32

const KEY_dintegral* = 16785964'i32

const KEY_division* = 247'i32

const KEY_dollar* = 36'i32

const KEY_doubbaselinedot* = 2735'i32

const KEY_doubleacute* = 445'i32

const KEY_doubledagger* = 2802'i32

const KEY_doublelowquotemark* = 2814'i32

const KEY_downarrow* = 2302'i32

const KEY_downcaret* = 2984'i32

const KEY_downshoe* = 3030'i32

const KEY_downstile* = 3012'i32

const KEY_downtack* = 3010'i32

const KEY_dstroke* = 496'i32

const KEY_e* = 101'i32

const KEY_eabovedot* = 1004'i32

const KEY_eacute* = 233'i32

const KEY_ebelowdot* = 16785081'i32

const KEY_ecaron* = 492'i32

const KEY_ecircumflex* = 234'i32

const KEY_ecircumflexacute* = 16785087'i32

const KEY_ecircumflexbelowdot* = 16785095'i32

const KEY_ecircumflexgrave* = 16785089'i32

const KEY_ecircumflexhook* = 16785091'i32

const KEY_ecircumflextilde* = 16785093'i32

const KEY_ediaeresis* = 235'i32

const KEY_egrave* = 232'i32

const KEY_ehook* = 16785083'i32

const KEY_eightsubscript* = 16785544'i32

const KEY_eightsuperior* = 16785528'i32

const KEY_elementof* = 16785928'i32

const KEY_ellipsis* = 2734'i32

const KEY_em3space* = 2723'i32

const KEY_em4space* = 2724'i32

const KEY_emacron* = 954'i32

const KEY_emdash* = 2729'i32

const KEY_emfilledcircle* = 2782'i32

const KEY_emfilledrect* = 2783'i32

const KEY_emopencircle* = 2766'i32

const KEY_emopenrectangle* = 2767'i32

const KEY_emptyset* = 16785925'i32

const KEY_emspace* = 2721'i32

const KEY_endash* = 2730'i32

const KEY_enfilledcircbullet* = 2790'i32

const KEY_enfilledsqbullet* = 2791'i32

const KEY_eng* = 959'i32

const KEY_enopencircbullet* = 2784'i32

const KEY_enopensquarebullet* = 2785'i32

const KEY_enspace* = 2722'i32

const KEY_eogonek* = 490'i32

const KEY_equal* = 61'i32

const KEY_eth* = 240'i32

const KEY_etilde* = 16785085'i32

const KEY_exclam* = 33'i32

const KEY_exclamdown* = 161'i32

const KEY_ezh* = 16777874'i32

const KEY_f* = 102'i32

const KEY_fabovedot* = 16784927'i32

const KEY_femalesymbol* = 2808'i32

const KEY_ff* = 2531'i32

const KEY_figdash* = 2747'i32

const KEY_filledlefttribullet* = 2780'i32

const KEY_filledrectbullet* = 2779'i32

const KEY_filledrighttribullet* = 2781'i32

const KEY_filledtribulletdown* = 2793'i32

const KEY_filledtribulletup* = 2792'i32

const KEY_fiveeighths* = 2757'i32

const KEY_fivesixths* = 2743'i32

const KEY_fivesubscript* = 16785541'i32

const KEY_fivesuperior* = 16785525'i32

const KEY_fourfifths* = 2741'i32

const KEY_foursubscript* = 16785540'i32

const KEY_foursuperior* = 16785524'i32

const KEY_fourthroot* = 16785948'i32

const KEY_function* = 2294'i32

const KEY_g* = 103'i32

const KEY_gabovedot* = 757'i32

const KEY_gbreve* = 699'i32

const KEY_gcaron* = 16777703'i32

const KEY_gcedilla* = 955'i32

const KEY_gcircumflex* = 760'i32

const KEY_grave* = 96'i32

const KEY_greater* = 62'i32

const KEY_greaterthanequal* = 2238'i32

const KEY_guillemotleft* = 171'i32

const KEY_guillemotright* = 187'i32

const KEY_h* = 104'i32

const KEY_hairspace* = 2728'i32

const KEY_hcircumflex* = 694'i32

const KEY_heart* = 2798'i32

const KEY_hebrew_aleph* = 3296'i32

const KEY_hebrew_ayin* = 3314'i32

const KEY_hebrew_bet* = 3297'i32

const KEY_hebrew_beth* = 3297'i32

const KEY_hebrew_chet* = 3303'i32

const KEY_hebrew_dalet* = 3299'i32

const KEY_hebrew_daleth* = 3299'i32

const KEY_hebrew_doublelowline* = 3295'i32

const KEY_hebrew_finalkaph* = 3306'i32

const KEY_hebrew_finalmem* = 3309'i32

const KEY_hebrew_finalnun* = 3311'i32

const KEY_hebrew_finalpe* = 3315'i32

const KEY_hebrew_finalzade* = 3317'i32

const KEY_hebrew_finalzadi* = 3317'i32

const KEY_hebrew_gimel* = 3298'i32

const KEY_hebrew_gimmel* = 3298'i32

const KEY_hebrew_he* = 3300'i32

const KEY_hebrew_het* = 3303'i32

const KEY_hebrew_kaph* = 3307'i32

const KEY_hebrew_kuf* = 3319'i32

const KEY_hebrew_lamed* = 3308'i32

const KEY_hebrew_mem* = 3310'i32

const KEY_hebrew_nun* = 3312'i32

const KEY_hebrew_pe* = 3316'i32

const KEY_hebrew_qoph* = 3319'i32

const KEY_hebrew_resh* = 3320'i32

const KEY_hebrew_samech* = 3313'i32

const KEY_hebrew_samekh* = 3313'i32

const KEY_hebrew_shin* = 3321'i32

const KEY_hebrew_taf* = 3322'i32

const KEY_hebrew_taw* = 3322'i32

const KEY_hebrew_tet* = 3304'i32

const KEY_hebrew_teth* = 3304'i32

const KEY_hebrew_waw* = 3301'i32

const KEY_hebrew_yod* = 3305'i32

const KEY_hebrew_zade* = 3318'i32

const KEY_hebrew_zadi* = 3318'i32

const KEY_hebrew_zain* = 3302'i32

const KEY_hebrew_zayin* = 3302'i32

const KEY_hexagram* = 2778'i32

const KEY_horizconnector* = 2211'i32

const KEY_horizlinescan1* = 2543'i32

const KEY_horizlinescan3* = 2544'i32

const KEY_horizlinescan5* = 2545'i32

const KEY_horizlinescan7* = 2546'i32

const KEY_horizlinescan9* = 2547'i32

const KEY_hstroke* = 689'i32

const KEY_ht* = 2530'i32

const KEY_hyphen* = 173'i32

const KEY_i* = 105'i32

const KEY_iTouch* = 269025120'i32

const KEY_iacute* = 237'i32

const KEY_ibelowdot* = 16785099'i32

const KEY_ibreve* = 16777517'i32

const KEY_icircumflex* = 238'i32

const KEY_identical* = 2255'i32

const KEY_idiaeresis* = 239'i32

const KEY_idotless* = 697'i32

const KEY_ifonlyif* = 2253'i32

const KEY_igrave* = 236'i32

const KEY_ihook* = 16785097'i32

const KEY_imacron* = 1007'i32

const KEY_implies* = 2254'i32

const KEY_includedin* = 2266'i32

const KEY_includes* = 2267'i32

const KEY_infinity* = 2242'i32

const KEY_integral* = 2239'i32

const KEY_intersection* = 2268'i32

const KEY_iogonek* = 999'i32

const KEY_itilde* = 949'i32

const KEY_j* = 106'i32

const KEY_jcircumflex* = 700'i32

const KEY_jot* = 3018'i32

const KEY_k* = 107'i32

const UKEY_kana_A* = 1201'i32

const KEY_kana_CHI* = 1217'i32

const UKEY_kana_E* = 1204'i32

const KEY_kana_FU* = 1228'i32

const KEY_kana_HA* = 1226'i32

const KEY_kana_HE* = 1229'i32

const KEY_kana_HI* = 1227'i32

const KEY_kana_HO* = 1230'i32

const KEY_kana_HU* = 1228'i32

const UKEY_kana_I* = 1202'i32

const KEY_kana_KA* = 1206'i32

const KEY_kana_KE* = 1209'i32

const KEY_kana_KI* = 1207'i32

const KEY_kana_KO* = 1210'i32

const KEY_kana_KU* = 1208'i32

const KEY_kana_MA* = 1231'i32

const KEY_kana_ME* = 1234'i32

const KEY_kana_MI* = 1232'i32

const KEY_kana_MO* = 1235'i32

const KEY_kana_MU* = 1233'i32

const KEY_kana_N* = 1245'i32

const KEY_kana_NA* = 1221'i32

const KEY_kana_NE* = 1224'i32

const KEY_kana_NI* = 1222'i32

const KEY_kana_NO* = 1225'i32

const KEY_kana_NU* = 1223'i32

const UKEY_kana_O* = 1205'i32

const KEY_kana_RA* = 1239'i32

const KEY_kana_RE* = 1242'i32

const KEY_kana_RI* = 1240'i32

const KEY_kana_RO* = 1243'i32

const KEY_kana_RU* = 1241'i32

const KEY_kana_SA* = 1211'i32

const KEY_kana_SE* = 1214'i32

const KEY_kana_SHI* = 1212'i32

const KEY_kana_SO* = 1215'i32

const KEY_kana_SU* = 1213'i32

const KEY_kana_TA* = 1216'i32

const KEY_kana_TE* = 1219'i32

const KEY_kana_TI* = 1217'i32

const KEY_kana_TO* = 1220'i32

const UKEY_kana_TSU* = 1218'i32

const UKEY_kana_TU* = 1218'i32

const UKEY_kana_U* = 1203'i32

const KEY_kana_WA* = 1244'i32

const KEY_kana_WO* = 1190'i32

const UKEY_kana_YA* = 1236'i32

const UKEY_kana_YO* = 1238'i32

const UKEY_kana_YU* = 1237'i32

const KEY_kana_a* = 1191'i32

const KEY_kana_closingbracket* = 1187'i32

const KEY_kana_comma* = 1188'i32

const KEY_kana_conjunctive* = 1189'i32

const KEY_kana_e* = 1194'i32

const KEY_kana_fullstop* = 1185'i32

const KEY_kana_i* = 1192'i32

const KEY_kana_middledot* = 1189'i32

const KEY_kana_o* = 1195'i32

const KEY_kana_openingbracket* = 1186'i32

const KEY_kana_switch* = 65406'i32

const KEY_kana_tsu* = 1199'i32

const KEY_kana_tu* = 1199'i32

const KEY_kana_u* = 1193'i32

const KEY_kana_ya* = 1196'i32

const KEY_kana_yo* = 1198'i32

const KEY_kana_yu* = 1197'i32

const KEY_kappa* = 930'i32

const KEY_kcedilla* = 1011'i32

const KEY_kra* = 930'i32

const KEY_l* = 108'i32

const KEY_lacute* = 485'i32

const KEY_latincross* = 2777'i32

const KEY_lbelowdot* = 16784951'i32

const KEY_lcaron* = 437'i32

const KEY_lcedilla* = 950'i32

const KEY_leftanglebracket* = 2748'i32

const KEY_leftarrow* = 2299'i32

const KEY_leftcaret* = 2979'i32

const KEY_leftdoublequotemark* = 2770'i32

const KEY_leftmiddlecurlybrace* = 2223'i32

const KEY_leftopentriangle* = 2764'i32

const KEY_leftpointer* = 2794'i32

const KEY_leftradical* = 2209'i32

const KEY_leftshoe* = 3034'i32

const KEY_leftsinglequotemark* = 2768'i32

const KEY_leftt* = 2548'i32

const KEY_lefttack* = 3036'i32

const KEY_less* = 60'i32

const KEY_lessthanequal* = 2236'i32

const KEY_lf* = 2533'i32

const KEY_logicaland* = 2270'i32

const KEY_logicalor* = 2271'i32

const KEY_lowleftcorner* = 2541'i32

const KEY_lowrightcorner* = 2538'i32

const KEY_lstroke* = 435'i32

const KEY_m* = 109'i32

const KEY_mabovedot* = 16784961'i32

const KEY_macron* = 175'i32

const KEY_malesymbol* = 2807'i32

const KEY_maltesecross* = 2800'i32

const KEY_marker* = 2751'i32

const KEY_masculine* = 186'i32

const KEY_minus* = 45'i32

const KEY_minutes* = 2774'i32

const KEY_mu* = 181'i32

const KEY_multiply* = 215'i32

const KEY_musicalflat* = 2806'i32

const KEY_musicalsharp* = 2805'i32

const KEY_n* = 110'i32

const KEY_nabla* = 2245'i32

const KEY_nacute* = 497'i32

const KEY_ncaron* = 498'i32

const KEY_ncedilla* = 1009'i32

const KEY_ninesubscript* = 16785545'i32

const KEY_ninesuperior* = 16785529'i32

const KEY_nl* = 2536'i32

const KEY_nobreakspace* = 160'i32

const KEY_notapproxeq* = 16785991'i32

const KEY_notelementof* = 16785929'i32

const KEY_notequal* = 2237'i32

const KEY_notidentical* = 16786018'i32

const KEY_notsign* = 172'i32

const KEY_ntilde* = 241'i32

const KEY_numbersign* = 35'i32

const KEY_numerosign* = 1712'i32

const KEY_o* = 111'i32

const KEY_oacute* = 243'i32

const KEY_obarred* = 16777845'i32

const KEY_obelowdot* = 16785101'i32

const KEY_ocaron* = 16777682'i32

const KEY_ocircumflex* = 244'i32

const KEY_ocircumflexacute* = 16785105'i32

const KEY_ocircumflexbelowdot* = 16785113'i32

const KEY_ocircumflexgrave* = 16785107'i32

const KEY_ocircumflexhook* = 16785109'i32

const KEY_ocircumflextilde* = 16785111'i32

const KEY_odiaeresis* = 246'i32

const KEY_odoubleacute* = 501'i32

const KEY_oe* = 5053'i32

const KEY_ogonek* = 434'i32

const KEY_ograve* = 242'i32

const KEY_ohook* = 16785103'i32

const KEY_ohorn* = 16777633'i32

const KEY_ohornacute* = 16785115'i32

const KEY_ohornbelowdot* = 16785123'i32

const KEY_ohorngrave* = 16785117'i32

const KEY_ohornhook* = 16785119'i32

const KEY_ohorntilde* = 16785121'i32

const KEY_omacron* = 1010'i32

const KEY_oneeighth* = 2755'i32

const KEY_onefifth* = 2738'i32

const KEY_onehalf* = 189'i32

const KEY_onequarter* = 188'i32

const KEY_onesixth* = 2742'i32

const KEY_onesubscript* = 16785537'i32

const KEY_onesuperior* = 185'i32

const KEY_onethird* = 2736'i32

const KEY_ooblique* = 248'i32

const KEY_openrectbullet* = 2786'i32

const KEY_openstar* = 2789'i32

const KEY_opentribulletdown* = 2788'i32

const KEY_opentribulletup* = 2787'i32

const KEY_ordfeminine* = 170'i32

const KEY_oslash* = 248'i32

const KEY_otilde* = 245'i32

const KEY_overbar* = 3008'i32

const KEY_overline* = 1150'i32

const KEY_p* = 112'i32

const KEY_pabovedot* = 16784983'i32

const KEY_paragraph* = 182'i32

const KEY_parenleft* = 40'i32

const KEY_parenright* = 41'i32

const KEY_partdifferential* = 16785922'i32

const KEY_partialderivative* = 2287'i32

const KEY_percent* = 37'i32

const KEY_period* = 46'i32

const KEY_periodcentered* = 183'i32

const KEY_permille* = 2773'i32

const KEY_phonographcopyright* = 2811'i32

const KEY_plus* = 43'i32

const KEY_plusminus* = 177'i32

const KEY_prescription* = 2772'i32

const KEY_prolongedsound* = 1200'i32

const KEY_punctspace* = 2726'i32

const KEY_q* = 113'i32

const KEY_quad* = 3020'i32

const KEY_question* = 63'i32

const KEY_questiondown* = 191'i32

const KEY_quotedbl* = 34'i32

const KEY_quoteleft* = 96'i32

const KEY_quoteright* = 39'i32

const KEY_r* = 114'i32

const KEY_racute* = 480'i32

const KEY_radical* = 2262'i32

const KEY_rcaron* = 504'i32

const KEY_rcedilla* = 947'i32

const KEY_registered* = 174'i32

const KEY_rightanglebracket* = 2750'i32

const KEY_rightarrow* = 2301'i32

const KEY_rightcaret* = 2982'i32

const KEY_rightdoublequotemark* = 2771'i32

const KEY_rightmiddlecurlybrace* = 2224'i32

const KEY_rightmiddlesummation* = 2231'i32

const KEY_rightopentriangle* = 2765'i32

const KEY_rightpointer* = 2795'i32

const KEY_rightshoe* = 3032'i32

const KEY_rightsinglequotemark* = 2769'i32

const KEY_rightt* = 2549'i32

const KEY_righttack* = 3068'i32

const KEY_s* = 115'i32

const KEY_sabovedot* = 16784993'i32

const KEY_sacute* = 438'i32

const KEY_scaron* = 441'i32

const KEY_scedilla* = 442'i32

const KEY_schwa* = 16777817'i32

const KEY_scircumflex* = 766'i32

const KEY_script_switch* = 65406'i32

const KEY_seconds* = 2775'i32

const KEY_section* = 167'i32

const KEY_semicolon* = 59'i32

const KEY_semivoicedsound* = 1247'i32

const KEY_seveneighths* = 2758'i32

const KEY_sevensubscript* = 16785543'i32

const KEY_sevensuperior* = 16785527'i32

const KEY_signaturemark* = 2762'i32

const KEY_signifblank* = 2732'i32

const KEY_similarequal* = 2249'i32

const KEY_singlelowquotemark* = 2813'i32

const KEY_sixsubscript* = 16785542'i32

const KEY_sixsuperior* = 16785526'i32

const KEY_slash* = 47'i32

const KEY_soliddiamond* = 2528'i32

const KEY_space* = 32'i32

const KEY_squareroot* = 16785946'i32

const KEY_ssharp* = 223'i32

const KEY_sterling* = 163'i32

const KEY_stricteq* = 16786019'i32

const KEY_t* = 116'i32

const KEY_tabovedot* = 16785003'i32

const KEY_tcaron* = 443'i32

const KEY_tcedilla* = 510'i32

const KEY_telephone* = 2809'i32

const KEY_telephonerecorder* = 2810'i32

const KEY_therefore* = 2240'i32

const KEY_thinspace* = 2727'i32

const KEY_thorn* = 254'i32

const KEY_threeeighths* = 2756'i32

const KEY_threefifths* = 2740'i32

const KEY_threequarters* = 190'i32

const KEY_threesubscript* = 16785539'i32

const KEY_threesuperior* = 179'i32

const KEY_tintegral* = 16785965'i32

const KEY_topintegral* = 2212'i32

const KEY_topleftparens* = 2219'i32

const KEY_topleftradical* = 2210'i32

const KEY_topleftsqbracket* = 2215'i32

const KEY_topleftsummation* = 2225'i32

const KEY_toprightparens* = 2221'i32

const KEY_toprightsqbracket* = 2217'i32

const KEY_toprightsummation* = 2229'i32

const KEY_topt* = 2551'i32

const KEY_topvertsummationconnector* = 2227'i32

const KEY_trademark* = 2761'i32

const KEY_trademarkincircle* = 2763'i32

const KEY_tslash* = 956'i32

const KEY_twofifths* = 2739'i32

const KEY_twosubscript* = 16785538'i32

const KEY_twosuperior* = 178'i32

const KEY_twothirds* = 2737'i32

const KEY_u* = 117'i32

const KEY_uacute* = 250'i32

const KEY_ubelowdot* = 16785125'i32

const KEY_ubreve* = 765'i32

const KEY_ucircumflex* = 251'i32

const KEY_udiaeresis* = 252'i32

const KEY_udoubleacute* = 507'i32

const KEY_ugrave* = 249'i32

const KEY_uhook* = 16785127'i32

const KEY_uhorn* = 16777648'i32

const KEY_uhornacute* = 16785129'i32

const KEY_uhornbelowdot* = 16785137'i32

const KEY_uhorngrave* = 16785131'i32

const KEY_uhornhook* = 16785133'i32

const KEY_uhorntilde* = 16785135'i32

const KEY_umacron* = 1022'i32

const KEY_underbar* = 3014'i32

const KEY_underscore* = 95'i32

const KEY_union* = 2269'i32

const KEY_uogonek* = 1017'i32

const KEY_uparrow* = 2300'i32

const KEY_upcaret* = 2985'i32

const KEY_upleftcorner* = 2540'i32

const KEY_uprightcorner* = 2539'i32

const KEY_upshoe* = 3011'i32

const KEY_upstile* = 3027'i32

const KEY_uptack* = 3022'i32

const KEY_uring* = 505'i32

const KEY_utilde* = 1021'i32

const KEY_v* = 118'i32

const KEY_variation* = 2241'i32

const KEY_vertbar* = 2552'i32

const KEY_vertconnector* = 2214'i32

const KEY_voicedsound* = 1246'i32

const KEY_vt* = 2537'i32

const KEY_w* = 119'i32

const KEY_wacute* = 16785027'i32

const KEY_wcircumflex* = 16777589'i32

const KEY_wdiaeresis* = 16785029'i32

const KEY_wgrave* = 16785025'i32

const KEY_x* = 120'i32

const KEY_xabovedot* = 16785035'i32

const KEY_y* = 121'i32

const KEY_yacute* = 253'i32

const KEY_ybelowdot* = 16785141'i32

const KEY_ycircumflex* = 16777591'i32

const KEY_ydiaeresis* = 255'i32

const KEY_yen* = 165'i32

const KEY_ygrave* = 16785139'i32

const KEY_yhook* = 16785143'i32

const KEY_ytilde* = 16785145'i32

const KEY_z* = 122'i32

const KEY_zabovedot* = 447'i32

const KEY_zacute* = 444'i32

const KEY_zcaron* = 446'i32

const KEY_zerosubscript* = 16785536'i32

const KEY_zerosuperior* = 16785520'i32

const KEY_zstroke* = 16777654'i32

type
  Keymap* = ref object of gobject.Object
  Keymap00* = object of gobject.Object00

proc gdk_keymap_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Keymap()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDirectionChanged*(self: Keymap;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "direction-changed", cast[GCallback](p), xdata, nil, cf)

proc scKeysChanged*(self: Keymap;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "keys-changed", cast[GCallback](p), xdata, nil, cf)

proc scStateChanged*(self: Keymap;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "state-changed", cast[GCallback](p), xdata, nil, cf)

proc gdk_keymap_get_default(): ptr Keymap00 {.
    importc, libprag.}

proc getDefaultKeymap*(): Keymap =
  let gobj = gdk_keymap_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_keymap_get_for_display(display: ptr Display00): ptr Keymap00 {.
    importc, libprag.}

proc getForDisplay*(display: Display): Keymap =
  let gobj = gdk_keymap_get_for_display(cast[ptr Display00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc forDisplay*(display: Display): Keymap =
  let gobj = gdk_keymap_get_for_display(cast[ptr Display00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_keymap_add_virtual_modifiers(self: ptr Keymap00; state: var ModifierType) {.
    importc, libprag.}

proc addVirtualModifiers*(self: Keymap; state: var ModifierType) =
  gdk_keymap_add_virtual_modifiers(cast[ptr Keymap00](self.impl), state)

proc gdk_keymap_get_caps_lock_state(self: ptr Keymap00): gboolean {.
    importc, libprag.}

proc getCapsLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_caps_lock_state(cast[ptr Keymap00](self.impl)))

proc capsLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_caps_lock_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_get_direction(self: ptr Keymap00): pango.Direction {.
    importc, libprag.}

proc getDirection*(self: Keymap): pango.Direction =
  gdk_keymap_get_direction(cast[ptr Keymap00](self.impl))

proc direction*(self: Keymap): pango.Direction =
  gdk_keymap_get_direction(cast[ptr Keymap00](self.impl))

proc gdk_keymap_get_modifier_state(self: ptr Keymap00): uint32 {.
    importc, libprag.}

proc getModifierState*(self: Keymap): int =
  int(gdk_keymap_get_modifier_state(cast[ptr Keymap00](self.impl)))

proc modifierState*(self: Keymap): int =
  int(gdk_keymap_get_modifier_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_get_num_lock_state(self: ptr Keymap00): gboolean {.
    importc, libprag.}

proc getNumLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_num_lock_state(cast[ptr Keymap00](self.impl)))

proc numLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_num_lock_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_get_scroll_lock_state(self: ptr Keymap00): gboolean {.
    importc, libprag.}

proc getScrollLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_scroll_lock_state(cast[ptr Keymap00](self.impl)))

proc scrollLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_scroll_lock_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_have_bidi_layouts(self: ptr Keymap00): gboolean {.
    importc, libprag.}

proc haveBidiLayouts*(self: Keymap): bool =
  toBool(gdk_keymap_have_bidi_layouts(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_map_virtual_modifiers(self: ptr Keymap00; state: var ModifierType): gboolean {.
    importc, libprag.}

proc mapVirtualModifiers*(self: Keymap; state: var ModifierType): bool =
  toBool(gdk_keymap_map_virtual_modifiers(cast[ptr Keymap00](self.impl), state))

proc gdk_keymap_translate_keyboard_state(self: ptr Keymap00; hardwareKeycode: uint32;
    state: ModifierType; group: int32; keyval: var uint32; effectiveGroup: var int32;
    level: var int32; consumedModifiers: var ModifierType): gboolean {.
    importc, libprag.}

proc translateKeyboardState*(self: Keymap; hardwareKeycode: int;
    state: ModifierType; group: int; keyval: var int = cast[var int](nil);
    effectiveGroup: var int = cast[var int](nil); level: var int = cast[var int](nil);
    consumedModifiers: var ModifierType = cast[var ModifierType](nil)): bool =
  var effectiveGroup_00: int32
  var level_00: int32
  var keyval_00: uint32
  result = toBool(gdk_keymap_translate_keyboard_state(cast[ptr Keymap00](self.impl), uint32(hardwareKeycode), state, int32(group), keyval_00, effectiveGroup_00, level_00, consumedModifiers))
  if effectiveGroup.addr != nil:
    effectiveGroup = int(effectiveGroup_00)
  if level.addr != nil:
    level = int(level_00)
  if keyval.addr != nil:
    keyval = int(keyval_00)

type
  ModifierIntent* {.size: sizeof(cint), pure.} = enum
    primaryAccelerator = 0
    contextMenu = 1
    extendSelection = 2
    modifySelection = 3
    noTextInput = 4
    shiftGroup = 5
    defaultModMask = 6

proc gdk_keymap_get_modifier_mask(self: ptr Keymap00; intent: ModifierIntent): ModifierType {.
    importc, libprag.}

proc getModifierMask*(self: Keymap; intent: ModifierIntent): ModifierType =
  gdk_keymap_get_modifier_mask(cast[ptr Keymap00](self.impl), intent)

type
  KeymapKey* {.pure, byRef.} = object
    keycode*: uint32
    group*: int32
    level*: int32

proc seq2KeymapKeyArray(s: openarray[KeymapKey]; a: var cstringArray):  ptr KeymapKey =
  assert s.high < 256
  let x = cast[ptr UncheckedArray[ptr KeymapKey]](a)
  for i in 0 .. s.high:
    x[i] = unsafeaddr(s[i])
  return cast[ptr KeymapKey](x)

proc keymapKeyArrayToSeq(s: ptr KeymapKey; n: int):  seq[KeymapKey] =
  let a = cast[ptr UncheckedArray[ptr KeymapKey]](s)
  for i in 0 ..< n:
    result.add(a[i][])
  cogfree(s)



proc gdk_keymap_get_entries_for_keyval(self: ptr Keymap00; keyval: uint32;
    keys: var ptr KeymapKey; nKeys: var int32): gboolean {.
    importc, libprag.}

proc getEntriesForKeyval*(self: Keymap; keyval: int; keys: var seq[KeymapKey];
    nKeys: var int): bool =
  var nKeys_00: int32
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var keys_00 = seq2KeymapKeyArray(keys, fs469n23)
  result = toBool(gdk_keymap_get_entries_for_keyval(cast[ptr Keymap00](self.impl), uint32(keyval), keys_00, nKeys_00))
  if nKeys.addr != nil:
    nKeys = int(nKeys_00)
  keys = keymapKeyArrayToSeq(keys_00, nKeys)

proc gdk_keymap_lookup_key(self: ptr Keymap00; key: KeymapKey): uint32 {.
    importc, libprag.}

proc lookupKey*(self: Keymap; key: KeymapKey): int =
  int(gdk_keymap_lookup_key(cast[ptr Keymap00](self.impl), key))

const MAJOR_VERSION* = 3'i32

const MAX_TIMECOORD_AXES* = 128'i32

const MICRO_VERSION* = 24'i32

const MINOR_VERSION* = 24'i32

type
  NotifyType* {.size: sizeof(cint), pure.} = enum
    ancestor = 0
    virtual = 1
    inferior = 2
    nonlinear = 3
    nonlinearVirtual = 4
    unknown = 5

type
  OwnerChange* {.size: sizeof(cint), pure.} = enum
    newOwner = 0
    destroy = 1
    close = 2

const PARENT_RELATIVE* = 1'i32

const PRIORITY_REDRAW* = 120'i32

type
  Point* {.pure, byRef.} = object
    x*: int32
    y*: int32

type
  PropMode* {.size: sizeof(cint), pure.} = enum
    replace = 0
    prepend = 1
    append = 2

type
  PropertyState* {.size: sizeof(cint), pure.} = enum
    newValue = 0
    delete = 1

type
  SeatGrabPrepareFunc* = proc (seat: ptr Seat00; window: ptr Window00; userData: pointer) {.cdecl.}

proc gdk_seat_grab(self: ptr Seat00; window: ptr Window00; capabilities: SeatCapabilities;
    ownerEvents: gboolean; cursor: ptr Cursor00; event: ptr Event00; prepareFunc: SeatGrabPrepareFunc;
    prepareFuncData: pointer): GrabStatus {.
    importc, libprag.}

proc grab*(self: Seat; window: Window; capabilities: SeatCapabilities;
    ownerEvents: bool; cursor: Cursor = nil; event: Event = nil; prepareFunc: SeatGrabPrepareFunc;
    prepareFuncData: pointer): GrabStatus =
  gdk_seat_grab(cast[ptr Seat00](self.impl), cast[ptr Window00](window.impl), capabilities, gboolean(ownerEvents), if cursor.isNil: nil else: cast[ptr Cursor00](cursor.impl), if event.isNil: nil else: cast[ptr Event00](event.impl), prepareFunc, prepareFuncData)

type
  SettingAction* {.size: sizeof(cint), pure.} = enum
    new = 0
    changed = 1
    deleted = 2

type
  Status* {.size: sizeof(cint), pure.} = enum
    errorMem = -4
    errorFile = -3
    errorParam = -2
    error = -1
    ok = 0

type
  TimeCoord* {.pure, byRef.} = object
    time*: uint32
    axes*: array[128, cdouble]

type
  TouchpadGesturePhase* {.size: sizeof(cint), pure.} = enum
    begin = 0
    update = 1
    `end` = 2
    cancel = 3

type
  VisibilityState* {.size: sizeof(cint), pure.} = enum
    unobscured = 0
    partial = 1
    fullyObscured = 2

type
  WindowChildFunc* = proc (window: ptr Window00; userData: pointer): gboolean {.cdecl.}

proc gdk_window_invalidate_maybe_recurse(self: ptr Window00; region: ptr cairo.Region00;
    childFunc: WindowChildFunc; userData: pointer) {.
    importc, libprag.}

proc invalidateMaybeRecurse*(self: Window; region: cairo.Region;
    childFunc: WindowChildFunc; userData: pointer) =
  gdk_window_invalidate_maybe_recurse(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl), childFunc, userData)

type
  WindowInvalidateHandlerFunc* = proc (window: ptr Window00; region: ptr cairo.Region00) {.cdecl.}

type
  WindowRedirect00* {.pure.} = object
  WindowRedirect* = ref object
    impl*: ptr WindowRedirect00
    ignoreFinalizer*: bool

type
  WindowWindowClass* {.size: sizeof(cint), pure.} = enum
    inputOutput = 0
    inputOnly = 1

proc gdk_add_option_entries_libgtk_only(group: ptr glib.OptionGroup00) {.
    importc, libprag.}

proc addOptionEntriesLibgtkOnly*(group: glib.OptionGroup) =
  gdk_add_option_entries_libgtk_only(cast[ptr glib.OptionGroup00](group.impl))

proc beep*() {.
    importc: "gdk_beep", libprag.}

proc gdk_cairo_create(window: ptr Window00): ptr cairo.Context00 {.
    importc, libprag.}

proc cairoCreate*(window: Window): cairo.Context =
  fnew(result, gBoxedFreeCairoContext)
  result.impl = gdk_cairo_create(cast[ptr Window00](window.impl))

proc gdk_cairo_draw_from_gl(cr: ptr cairo.Context00; window: ptr Window00;
    source: int32; sourceType: int32; bufferScale: int32; x: int32; y: int32;
    width: int32; height: int32) {.
    importc, libprag.}

proc cairoDrawFromGl*(cr: cairo.Context; window: Window; source: int;
    sourceType: int; bufferScale: int; x: int; y: int; width: int; height: int) =
  gdk_cairo_draw_from_gl(cast[ptr cairo.Context00](cr.impl), cast[ptr Window00](window.impl), int32(source), int32(sourceType), int32(bufferScale), int32(x), int32(y), int32(width), int32(height))

proc gdk_cairo_get_clip_rectangle(cr: ptr cairo.Context00; rect: var Rectangle): gboolean {.
    importc, libprag.}

proc cairoGetClipRectangle*(cr: cairo.Context; rect: var Rectangle = cast[var Rectangle](nil)): bool =
  toBool(gdk_cairo_get_clip_rectangle(cast[ptr cairo.Context00](cr.impl), rect))

proc gdk_cairo_get_drawing_context(cr: ptr cairo.Context00): ptr DrawingContext00 {.
    importc, libprag.}

proc cairoGetDrawingContext*(cr: cairo.Context): DrawingContext =
  let gobj = gdk_cairo_get_drawing_context(cast[ptr cairo.Context00](cr.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_cairo_rectangle(cr: ptr cairo.Context00; rectangle: Rectangle) {.
    importc, libprag.}

proc cairoRectangle*(cr: cairo.Context; rectangle: Rectangle) =
  gdk_cairo_rectangle(cast[ptr cairo.Context00](cr.impl), rectangle)

proc gdk_cairo_region(cr: ptr cairo.Context00; region: ptr cairo.Region00) {.
    importc, libprag.}

proc cairoRegion*(cr: cairo.Context; region: cairo.Region) =
  gdk_cairo_region(cast[ptr cairo.Context00](cr.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_cairo_region_create_from_surface(surface: ptr cairo.Surface00): ptr cairo.Region00 {.
    importc, libprag.}

proc cairoRegionCreateFromSurface*(surface: cairo.Surface): cairo.Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = gdk_cairo_region_create_from_surface(cast[ptr cairo.Surface00](surface.impl))

proc gdk_cairo_set_source_color(cr: ptr cairo.Context00; color: Color) {.
    importc, libprag.}

proc cairoSetSourceColor*(cr: cairo.Context; color: Color) =
  gdk_cairo_set_source_color(cast[ptr cairo.Context00](cr.impl), color)

proc gdk_cairo_set_source_pixbuf(cr: ptr cairo.Context00; pixbuf: ptr gdkpixbuf.Pixbuf00;
    pixbufX: cdouble; pixbufY: cdouble) {.
    importc, libprag.}

proc cairoSetSourcePixbuf*(cr: cairo.Context; pixbuf: gdkpixbuf.Pixbuf;
    pixbufX: cdouble; pixbufY: cdouble) =
  gdk_cairo_set_source_pixbuf(cast[ptr cairo.Context00](cr.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), pixbufX, pixbufY)

proc gdk_cairo_set_source_rgba(cr: ptr cairo.Context00; rgba: RGBA) {.
    importc, libprag.}

proc cairoSetSourceRgba*(cr: cairo.Context; rgba: RGBA) =
  gdk_cairo_set_source_rgba(cast[ptr cairo.Context00](cr.impl), rgba)

proc gdk_cairo_set_source_window(cr: ptr cairo.Context00; window: ptr Window00;
    x: cdouble; y: cdouble) {.
    importc, libprag.}

proc cairoSetSourceWindow*(cr: cairo.Context; window: Window; x: cdouble;
    y: cdouble) =
  gdk_cairo_set_source_window(cast[ptr cairo.Context00](cr.impl), cast[ptr Window00](window.impl), x, y)

proc gdk_cairo_surface_create_from_pixbuf(pixbuf: ptr gdkpixbuf.Pixbuf00;
    scale: int32; forWindow: ptr Window00): ptr cairo.Surface00 {.
    importc, libprag.}

proc cairoSurfaceCreateFromPixbuf*(pixbuf: gdkpixbuf.Pixbuf; scale: int;
    forWindow: Window = nil): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = gdk_cairo_surface_create_from_pixbuf(cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), int32(scale), if forWindow.isNil: nil else: cast[ptr Window00](forWindow.impl))

proc disableMultidevice*() {.
    importc: "gdk_disable_multidevice", libprag.}

proc gdk_drag_abort(context: ptr DragContext00; time: uint32) {.
    importc, libprag.}

proc dragAbort*(context: DragContext; time: int) =
  gdk_drag_abort(cast[ptr DragContext00](context.impl), uint32(time))

proc gdk_drag_begin(window: ptr Window00; targets: ptr glib.List): ptr DragContext00 {.
    importc, libprag.}

proc dragBegin*(window: Window; targets: seq[Atom]): DragContext =
  var tempResGL = seq2GList(targets)
  let gobj = gdk_drag_begin(cast[ptr Window00](window.impl), tempResGL)
  g_list_free(tempResGL)
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

proc gdk_drag_begin_for_device(window: ptr Window00; device: ptr Device00;
    targets: ptr glib.List): ptr DragContext00 {.
    importc, libprag.}

proc dragBeginForDevice*(window: Window; device: Device; targets: seq[Atom]): DragContext =
  var tempResGL = seq2GList(targets)
  let gobj = gdk_drag_begin_for_device(cast[ptr Window00](window.impl), cast[ptr Device00](device.impl), tempResGL)
  g_list_free(tempResGL)
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

proc gdk_drag_begin_from_point(window: ptr Window00; device: ptr Device00;
    targets: ptr glib.List; xRoot: int32; yRoot: int32): ptr DragContext00 {.
    importc, libprag.}

proc dragBeginFromPoint*(window: Window; device: Device; targets: seq[Atom];
    xRoot: int; yRoot: int): DragContext =
  var tempResGL = seq2GList(targets)
  let gobj = gdk_drag_begin_from_point(cast[ptr Window00](window.impl), cast[ptr Device00](device.impl), tempResGL, int32(xRoot), int32(yRoot))
  g_list_free(tempResGL)
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

proc gdk_drag_drop(context: ptr DragContext00; time: uint32) {.
    importc, libprag.}

proc dragDrop*(context: DragContext; time: int) =
  gdk_drag_drop(cast[ptr DragContext00](context.impl), uint32(time))

proc gdk_drag_drop_done(context: ptr DragContext00; success: gboolean) {.
    importc, libprag.}

proc dragDropDone*(context: DragContext; success: bool) =
  gdk_drag_drop_done(cast[ptr DragContext00](context.impl), gboolean(success))

proc gdk_drag_drop_succeeded(context: ptr DragContext00): gboolean {.
    importc, libprag.}

proc dragDropSucceeded*(context: DragContext): bool =
  toBool(gdk_drag_drop_succeeded(cast[ptr DragContext00](context.impl)))

proc gdk_drag_find_window_for_screen(context: ptr DragContext00; dragWindow: ptr Window00;
    screen: ptr Screen00; xRoot: int32; yRoot: int32; destWindow: var ptr Window00;
    protocol: var DragProtocol) {.
    importc, libprag.}

proc dragFindWindowForScreen*(context: DragContext; dragWindow: Window;
    screen: Screen; xRoot: int; yRoot: int; destWindow: var Window; protocol: var DragProtocol) =
  var tmpoutgobjectarg: ptr Window00
  gdk_drag_find_window_for_screen(cast[ptr DragContext00](context.impl), cast[ptr Window00](dragWindow.impl), cast[ptr Screen00](screen.impl), int32(xRoot), int32(yRoot), tmpoutgobjectarg, protocol)
#  dothemagic(destWindow
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    destWindow = cast[type(destWindow)](argqdata)
    assert(destWindow.impl == tmpoutgobjectarg)
  else:
    fnew(destWindow, gdk.finalizeGObject)
    destWindow.impl = tmpoutgobjectarg
    GC_ref(destWindow)
    if g_object_is_floating(destWindow.impl).int != 0:
      discard g_object_ref_sink(destWindow.impl)
    g_object_add_toggle_ref(destWindow.impl, toggleNotify, addr(destWindow[]))
    g_object_unref(destWindow.impl)
    assert(g_object_get_qdata(destWindow.impl, Quark) == nil)
    g_object_set_qdata(destWindow.impl, Quark, addr(destWindow[]))


proc gdk_drag_get_selection(context: ptr DragContext00): ptr Atom00 {.
    importc, libprag.}

proc dragGetSelection*(context: DragContext): Atom =
  new(result)
  result.impl = gdk_drag_get_selection(cast[ptr DragContext00](context.impl))
  result.ignoreFinalizer = true

proc gdk_drag_motion(context: ptr DragContext00; destWindow: ptr Window00;
    protocol: DragProtocol; xRoot: int32; yRoot: int32; suggestedAction: DragAction;
    possibleActions: DragAction; time: uint32): gboolean {.
    importc, libprag.}

proc dragMotion*(context: DragContext; destWindow: Window; protocol: DragProtocol;
    xRoot: int; yRoot: int; suggestedAction: DragAction; possibleActions: DragAction;
    time: int): bool =
  toBool(gdk_drag_motion(cast[ptr DragContext00](context.impl), cast[ptr Window00](destWindow.impl), protocol, int32(xRoot), int32(yRoot), suggestedAction, possibleActions, uint32(time)))

proc gdk_drag_status(context: ptr DragContext00; action: DragAction; time: uint32) {.
    importc, libprag.}

proc dragStatus*(context: DragContext; action: DragAction; time: int) =
  gdk_drag_status(cast[ptr DragContext00](context.impl), action, uint32(time))

proc gdk_drop_finish(context: ptr DragContext00; success: gboolean; time: uint32) {.
    importc, libprag.}

proc dropFinish*(context: DragContext; success: bool; time: int) =
  gdk_drop_finish(cast[ptr DragContext00](context.impl), gboolean(success), uint32(time))

proc gdk_drop_reply(context: ptr DragContext00; accepted: gboolean; time: uint32) {.
    importc, libprag.}

proc dropReply*(context: DragContext; accepted: bool; time: int) =
  gdk_drop_reply(cast[ptr DragContext00](context.impl), gboolean(accepted), uint32(time))

proc gdk_error_trap_pop(): int32 {.
    importc, libprag.}

proc errorTrapPop*(): int =
  int(gdk_error_trap_pop())

proc errorTrapPopIgnored*() {.
    importc: "gdk_error_trap_pop_ignored", libprag.}

proc errorTrapPush*() {.
    importc: "gdk_error_trap_push", libprag.}

proc gdk_events_pending(): gboolean {.
    importc, libprag.}

proc eventsPending*(): bool =
  toBool(gdk_events_pending())

proc flush*() {.
    importc: "gdk_flush", libprag.}

proc gdk_get_default_root_window(): ptr Window00 {.
    importc, libprag.}

proc getDefaultRootWindow*(): Window =
  let gobj = gdk_get_default_root_window()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_get_display(): cstring {.
    importc, libprag.}

proc getDisplay*(): string =
  let resul0 = gdk_get_display()
  result = $resul0
  cogfree(resul0)

proc gdk_get_display_arg_name(): cstring {.
    importc, libprag.}

proc getDisplayArgName*(): string =
  let resul0 = gdk_get_display_arg_name()
  if resul0.isNil:
    return
  result = $resul0

proc gdk_get_program_class(): cstring {.
    importc, libprag.}

proc getProgramClass*(): string =
  result = $gdk_get_program_class()

proc gdk_get_show_events(): gboolean {.
    importc, libprag.}

proc getShowEvents*(): bool =
  toBool(gdk_get_show_events())

proc gdk_init(argc: var int32; argv: var ptr cstring) {.
    importc, libprag.}

proc init*(argc: var int; argv: var seq[string]) =
  var argc_00 = int32(argc)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var argv_00 = seq2CstringArray(argv, fs469n23)
  gdk_init(argc_00, argv_00)
  argc = int(argc_00)
  argv = cstringArrayToSeq(argv_00)

proc gdk_init_check(argc: var int32; argv: var ptr cstring): gboolean {.
    importc, libprag.}

proc initCheck*(argc: var int; argv: var seq[string]): bool =
  var argc_00 = int32(argc)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var argv_00 = seq2CstringArray(argv, fs469n23)
  result = toBool(gdk_init_check(argc_00, argv_00))
  argc = int(argc_00)
  argv = cstringArrayToSeq(argv_00)

proc gdk_keyboard_grab(window: ptr Window00; ownerEvents: gboolean; time: uint32): GrabStatus {.
    importc, libprag.}

proc keyboardGrab*(window: Window; ownerEvents: bool; time: int): GrabStatus =
  gdk_keyboard_grab(cast[ptr Window00](window.impl), gboolean(ownerEvents), uint32(time))

proc gdk_keyboard_ungrab(time: uint32) {.
    importc, libprag.}

proc keyboardUngrab*(time: int) =
  gdk_keyboard_ungrab(uint32(time))

proc gdk_keyval_convert_case(symbol: uint32; lower: var uint32; upper: var uint32) {.
    importc, libprag.}

proc keyvalConvertCase*(symbol: int; lower: var int; upper: var int) =
  var upper_00: uint32
  var lower_00: uint32
  gdk_keyval_convert_case(uint32(symbol), lower_00, upper_00)
  if upper.addr != nil:
    upper = int(upper_00)
  if lower.addr != nil:
    lower = int(lower_00)

proc gdk_keyval_from_name(keyvalName: cstring): uint32 {.
    importc, libprag.}

proc keyvalFromName*(keyvalName: cstring): int =
  int(gdk_keyval_from_name(keyvalName))

proc gdk_keyval_is_lower(keyval: uint32): gboolean {.
    importc, libprag.}

proc keyvalIsLower*(keyval: int): bool =
  toBool(gdk_keyval_is_lower(uint32(keyval)))

proc gdk_keyval_is_upper(keyval: uint32): gboolean {.
    importc, libprag.}

proc keyvalIsUpper*(keyval: int): bool =
  toBool(gdk_keyval_is_upper(uint32(keyval)))

proc gdk_keyval_name(keyval: uint32): cstring {.
    importc, libprag.}

proc keyvalName*(keyval: int): string =
  let resul0 = gdk_keyval_name(uint32(keyval))
  if resul0.isNil:
    return
  result = $resul0

proc gdk_keyval_to_lower(keyval: uint32): uint32 {.
    importc, libprag.}

proc keyvalToLower*(keyval: int): int =
  int(gdk_keyval_to_lower(uint32(keyval)))

proc gdk_keyval_to_unicode(keyval: uint32): uint32 {.
    importc, libprag.}

proc keyvalToUnicode*(keyval: int): int =
  int(gdk_keyval_to_unicode(uint32(keyval)))

proc gdk_keyval_to_upper(keyval: uint32): uint32 {.
    importc, libprag.}

proc keyvalToUpper*(keyval: int): int =
  int(gdk_keyval_to_upper(uint32(keyval)))

proc gdk_list_visuals(): ptr glib.List {.
    importc, libprag.}

proc listVisuals*(): seq[Visual] =
  let resul0 = gdk_list_visuals()
  result = glistObjects2seq(Visual, resul0, false)
  g_list_free(resul0)

proc notifyStartupComplete*() {.
    importc: "gdk_notify_startup_complete", libprag.}

proc notifyStartupCompleteWithId*(startupId: cstring) {.
    importc: "gdk_notify_startup_complete_with_id", libprag.}

proc gdk_offscreen_window_get_embedder(window: ptr Window00): ptr Window00 {.
    importc, libprag.}

proc offscreenWindowGetEmbedder*(window: Window): Window =
  let gobj = gdk_offscreen_window_get_embedder(cast[ptr Window00](window.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_offscreen_window_get_surface(window: ptr Window00): ptr cairo.Surface00 {.
    importc, libprag.}

proc offscreenWindowGetSurface*(window: Window): cairo.Surface =
  let impl0 = gdk_offscreen_window_get_surface(cast[ptr Window00](window.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_surface_get_type(), impl0))

proc gdk_offscreen_window_set_embedder(window: ptr Window00; embedder: ptr Window00) {.
    importc, libprag.}

proc offscreenWindowSetEmbedder*(window: Window; embedder: Window) =
  gdk_offscreen_window_set_embedder(cast[ptr Window00](window.impl), cast[ptr Window00](embedder.impl))

proc gdk_pango_context_get(): ptr pango.Context00 {.
    importc, libprag.}

proc pangoContextGet*(): pango.Context =
  let gobj = gdk_pango_context_get()
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

proc gdk_pango_context_get_for_display(display: ptr Display00): ptr pango.Context00 {.
    importc, libprag.}

proc pangoContextGetForDisplay*(display: Display): pango.Context =
  let gobj = gdk_pango_context_get_for_display(cast[ptr Display00](display.impl))
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

proc gdk_pango_context_get_for_screen(screen: ptr Screen00): ptr pango.Context00 {.
    importc, libprag.}

proc pangoContextGetForScreen*(screen: Screen): pango.Context =
  let gobj = gdk_pango_context_get_for_screen(cast[ptr Screen00](screen.impl))
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

proc gdk_parse_args(argc: var int32; argv: var ptr cstring) {.
    importc, libprag.}

proc parseArgs*(argc: var int; argv: var seq[string]) =
  var argc_00 = int32(argc)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var argv_00 = seq2CstringArray(argv, fs469n23)
  gdk_parse_args(argc_00, argv_00)
  argc = int(argc_00)
  argv = cstringArrayToSeq(argv_00)

proc gdk_pixbuf_get_from_surface(surface: ptr cairo.Surface00; srcX: int32;
    srcY: int32; width: int32; height: int32): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc pixbufGetFromSurface*(surface: cairo.Surface; srcX: int; srcY: int;
    width: int; height: int): gdkpixbuf.Pixbuf =
  let gobj = gdk_pixbuf_get_from_surface(cast[ptr cairo.Surface00](surface.impl), int32(srcX), int32(srcY), int32(width), int32(height))
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

proc gdk_pixbuf_get_from_window(window: ptr Window00; srcX: int32; srcY: int32;
    width: int32; height: int32): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc pixbufGetFromWindow*(window: Window; srcX: int; srcY: int; width: int;
    height: int): gdkpixbuf.Pixbuf =
  let gobj = gdk_pixbuf_get_from_window(cast[ptr Window00](window.impl), int32(srcX), int32(srcY), int32(width), int32(height))
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

proc gdk_pointer_grab(window: ptr Window00; ownerEvents: gboolean; eventMask: EventMask;
    confineTo: ptr Window00; cursor: ptr Cursor00; time: uint32): GrabStatus {.
    importc, libprag.}

proc pointerGrab*(window: Window; ownerEvents: bool; eventMask: EventMask;
    confineTo: Window = nil; cursor: Cursor = nil; time: int): GrabStatus =
  gdk_pointer_grab(cast[ptr Window00](window.impl), gboolean(ownerEvents), eventMask, if confineTo.isNil: nil else: cast[ptr Window00](confineTo.impl), if cursor.isNil: nil else: cast[ptr Cursor00](cursor.impl), uint32(time))

proc gdk_pointer_is_grabbed(): gboolean {.
    importc, libprag.}

proc pointerIsGrabbed*(): bool =
  toBool(gdk_pointer_is_grabbed())

proc gdk_pointer_ungrab(time: uint32) {.
    importc, libprag.}

proc pointerUngrab*(time: int) =
  gdk_pointer_ungrab(uint32(time))

proc preParseLibgtkOnly*() {.
    importc: "gdk_pre_parse_libgtk_only", libprag.}

proc gdk_property_delete(window: ptr Window00; property: ptr Atom00) {.
    importc, libprag.}

proc propertyDelete*(window: Window; property: Atom) =
  gdk_property_delete(cast[ptr Window00](window.impl), cast[ptr Atom00](property.impl))

proc gdk_query_visual_types(visualTypes: var ptr VisualType; count: var int32) {.
    importc, libprag.}

proc queryVisualTypes*(visualTypes: var ptr VisualType; count: var int) =
  var count_00: int32
  gdk_query_visual_types(visualTypes, count_00)
  if count.addr != nil:
    count = int(count_00)

proc queryVisualTypes*(visualTypes: var ptr VisualType): int =
  var result_00: int32
  gdk_query_visual_types(visualTypes, result_00)
  if result.addr != nil:
    result = int(result_00)

proc gdk_selection_convert(requestor: ptr Window00; selection: ptr Atom00;
    target: ptr Atom00; time: uint32) {.
    importc, libprag.}

proc selectionConvert*(requestor: Window; selection: Atom; target: Atom;
    time: int) =
  gdk_selection_convert(cast[ptr Window00](requestor.impl), cast[ptr Atom00](selection.impl), cast[ptr Atom00](target.impl), uint32(time))

proc gdk_selection_owner_get(selection: ptr Atom00): ptr Window00 {.
    importc, libprag.}

proc selectionOwnerGet*(selection: Atom): Window =
  let gobj = gdk_selection_owner_get(cast[ptr Atom00](selection.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_selection_owner_get_for_display(display: ptr Display00; selection: ptr Atom00): ptr Window00 {.
    importc, libprag.}

proc selectionOwnerGetForDisplay*(display: Display; selection: Atom): Window =
  let gobj = gdk_selection_owner_get_for_display(cast[ptr Display00](display.impl), cast[ptr Atom00](selection.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_selection_owner_set(owner: ptr Window00; selection: ptr Atom00;
    time: uint32; sendEvent: gboolean): gboolean {.
    importc, libprag.}

proc selectionOwnerSet*(owner: Window = nil; selection: Atom; time: int;
    sendEvent: bool): bool =
  toBool(gdk_selection_owner_set(if owner.isNil: nil else: cast[ptr Window00](owner.impl), cast[ptr Atom00](selection.impl), uint32(time), gboolean(sendEvent)))

proc gdk_selection_owner_set_for_display(display: ptr Display00; owner: ptr Window00;
    selection: ptr Atom00; time: uint32; sendEvent: gboolean): gboolean {.
    importc, libprag.}

proc selectionOwnerSetForDisplay*(display: Display; owner: Window = nil;
    selection: Atom; time: int; sendEvent: bool): bool =
  toBool(gdk_selection_owner_set_for_display(cast[ptr Display00](display.impl), if owner.isNil: nil else: cast[ptr Window00](owner.impl), cast[ptr Atom00](selection.impl), uint32(time), gboolean(sendEvent)))

proc gdk_selection_send_notify(requestor: ptr Window00; selection: ptr Atom00;
    target: ptr Atom00; property: ptr Atom00; time: uint32) {.
    importc, libprag.}

proc selectionSendNotify*(requestor: Window; selection: Atom; target: Atom;
    property: Atom; time: int) =
  gdk_selection_send_notify(cast[ptr Window00](requestor.impl), cast[ptr Atom00](selection.impl), cast[ptr Atom00](target.impl), cast[ptr Atom00](property.impl), uint32(time))

proc gdk_selection_send_notify_for_display(display: ptr Display00; requestor: ptr Window00;
    selection: ptr Atom00; target: ptr Atom00; property: ptr Atom00; time: uint32) {.
    importc, libprag.}

proc selectionSendNotifyForDisplay*(display: Display; requestor: Window;
    selection: Atom; target: Atom; property: Atom; time: int) =
  gdk_selection_send_notify_for_display(cast[ptr Display00](display.impl), cast[ptr Window00](requestor.impl), cast[ptr Atom00](selection.impl), cast[ptr Atom00](target.impl), cast[ptr Atom00](property.impl), uint32(time))

proc setAllowedBackends*(backends: cstring) {.
    importc: "gdk_set_allowed_backends", libprag.}

proc gdk_set_double_click_time(msec: uint32) {.
    importc, libprag.}

proc setDoubleClickTime*(msec: int) =
  gdk_set_double_click_time(uint32(msec))

proc setProgramClass*(programClass: cstring) {.
    importc: "gdk_set_program_class", libprag.}

proc gdk_set_show_events(showEvents: gboolean) {.
    importc, libprag.}

proc setShowEvents*(showEvents: bool = true) =
  gdk_set_show_events(gboolean(showEvents))

proc gdk_setting_get(name: cstring; value: gobject.Value): gboolean {.
    importc, libprag.}

proc settingGet*(name: cstring; value: gobject.Value): bool =
  toBool(gdk_setting_get(name, value))

proc gdk_synthesize_window_state(window: ptr Window00; unsetFlags: WindowState;
    setFlags: WindowState) {.
    importc, libprag.}

proc synthesizeWindowState*(window: Window; unsetFlags: WindowState;
    setFlags: WindowState) =
  gdk_synthesize_window_state(cast[ptr Window00](window.impl), unsetFlags, setFlags)

proc gdk_test_render_sync(window: ptr Window00) {.
    importc, libprag.}

proc testRenderSync*(window: Window) =
  gdk_test_render_sync(cast[ptr Window00](window.impl))

proc gdk_test_simulate_button(window: ptr Window00; x: int32; y: int32; button: uint32;
    modifiers: ModifierType; buttonPressrelease: EventType): gboolean {.
    importc, libprag.}

proc testSimulateButton*(window: Window; x: int; y: int; button: int;
    modifiers: ModifierType; buttonPressrelease: EventType): bool =
  toBool(gdk_test_simulate_button(cast[ptr Window00](window.impl), int32(x), int32(y), uint32(button), modifiers, buttonPressrelease))

proc gdk_test_simulate_key(window: ptr Window00; x: int32; y: int32; keyval: uint32;
    modifiers: ModifierType; keyPressrelease: EventType): gboolean {.
    importc, libprag.}

proc testSimulateKey*(window: Window; x: int; y: int; keyval: int; modifiers: ModifierType;
    keyPressrelease: EventType): bool =
  toBool(gdk_test_simulate_key(cast[ptr Window00](window.impl), int32(x), int32(y), uint32(keyval), modifiers, keyPressrelease))

proc gdk_text_property_to_utf8_list_for_display(display: ptr Display00; encoding: ptr Atom00;
    format: int32; text: ptr uint8; length: int32; list: var ptr cstring): int32 {.
    importc, libprag.}

proc textPropertyToUtf8ListForDisplay*(display: Display; encoding: Atom;
    format: int; text: seq[uint8] | string; list: var seq[string]): int =
  let length = int(text.len)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var list_00 = seq2CstringArray(list, fs469n23)
  result = int(gdk_text_property_to_utf8_list_for_display(cast[ptr Display00](display.impl), cast[ptr Atom00](encoding.impl), int32(format), cast[ptr uint8](unsafeaddr(text[0])), int32(length), list_00))
  if list.addr != nil:
    list = cstringArrayToSeq(list_00)

proc gdk_threads_add_idle_full(priority: int32; function: SourceFunc; data: pointer;
    notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc threadsAddIdle*(priority: int; function: SourceFunc; data: pointer;
    notify: DestroyNotify): int =
  int(gdk_threads_add_idle_full(int32(priority), function, data, notify))

proc gdk_threads_add_timeout_full(priority: int32; interval: uint32; function: SourceFunc;
    data: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc threadsAddTimeout*(priority: int; interval: int; function: SourceFunc;
    data: pointer; notify: DestroyNotify): int =
  int(gdk_threads_add_timeout_full(int32(priority), uint32(interval), function, data, notify))

proc gdk_threads_add_timeout_seconds_full(priority: int32; interval: uint32;
    function: SourceFunc; data: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc threadsAddTimeoutSeconds*(priority: int; interval: int; function: SourceFunc;
    data: pointer; notify: DestroyNotify): int =
  int(gdk_threads_add_timeout_seconds_full(int32(priority), uint32(interval), function, data, notify))

proc threadsEnter*() {.
    importc: "gdk_threads_enter", libprag.}

proc threadsInit*() {.
    importc: "gdk_threads_init", libprag.}

proc threadsLeave*() {.
    importc: "gdk_threads_leave", libprag.}

proc gdk_unicode_to_keyval(wc: uint32): uint32 {.
    importc, libprag.}

proc unicodeToKeyval*(wc: int): int =
  int(gdk_unicode_to_keyval(uint32(wc)))

proc gdk_utf8_to_string_target(str: cstring): cstring {.
    importc, libprag.}

proc utf8ToStringTarget*(str: cstring): string =
  let resul0 = gdk_utf8_to_string_target(str)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)
# === remaining symbols:

proc getButton*(self: Event): int =
  var button: uint32
  if not toBool(gdk_event_get_button(cast[ptr Event00](self.impl), button)):
    raise newException(Defect, "Event don't has a button field.")
  return int(button)

proc getClickCount*(self: Event): int =
  var clickCount_00: uint32
  if not toBool(gdk_event_get_click_count(cast[ptr Event00](self.impl), clickCount_00)):
    raise newException(Defect, "Event does not support getClickCount().")
  return int(clickCount_00)

proc getCoords*(self: Event): (cdouble, cdouble) =
  if not toBool(gdk_event_get_coords(cast[ptr Event00](self.impl), result[0], result[1])):
    raise newException(Defect, "This event don't has a coordinate field.")

proc getKeyval*(self: Event): int =
  var keyval_00: uint32
  if not toBool(gdk_event_get_keyval(cast[ptr Event00](self.impl), keyval_00)):
    raise newException(Defect, "This event don't has a keyval field.")
  return int(keyval_00)

# not available in GTK4
proc getRootCoords*(self: Event): (cdouble, cdouble) =
  if not toBool(gdk_event_get_root_coords(cast[ptr Event00](self.impl), result[0], result[1])):
    raise newException(Defect, "This event don't has a rootCoordinate field.")

proc getScrollDeltas*(self: Event): (cdouble, cdouble) =
  if not toBool(gdk_event_get_scroll_deltas(cast[ptr Event00](self.impl), result[0], result[1])):
    raise newException(Defect, "This event don't has a scrollDeltas field.")

proc getScrollDirection*(self: Event): ScrollDirection =
  if not toBool(gdk_event_get_scroll_direction(cast[ptr Event00](self.impl), result)):
    raise newException(Defect, "Event don't has a scrollDirection field.")

proc getState*(self: Event): ModifierType =
  if not toBool(gdk_event_get_state(cast[ptr Event00](self.impl), result)):
    raise newException(Defect, "Event don't has a state field.")

proc gdk_window_invalidate_nilrect(self: ptr Window00; rect: ptr Rectangle; invalidateChildren: gboolean) {.
    importc: "gdk_window_invalidate_rect", libprag.}

proc invalidateRect*(self: Window; rect: ptr Rectangle = nil; invalidateChildren: bool = false) =
  gdk_window_invalidate_nilrect(cast[ptr Window00](self.impl), rect, gboolean(invalidateChildren))

proc fixednewCursorFromName*(display: Display; name: string): Cursor =
  fnew(result, gdk.finalizeGObject)
  result.impl = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), cstring(name))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  #assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc getAngle*(self: Event; event2: Event): cdouble =
  if not toBool(gdk_events_get_angle(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result)):
    raise newException(Defect, "Events do not support getAngle().")

proc getCenter*(self: Event; event2: Event): (cdouble, cdouble) =
  if not toBool(gdk_events_get_center(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result[0], result[1])):
    raise newException(Defect, "Events do not support getCenter().")

proc getDistance*(self: Event; event2: Event): cdouble =
  if not toBool(gdk_events_get_distance(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result)):
    raise newException(Defect, "Events do not support getDistance().")

proc getAxis*(self: Event; axisUse: AxisUse): cdouble =
  if not toBool(gdk_event_get_axis(cast[ptr Event00](self.impl), axisUse, result)):
    raise newException(Defect, "Event does not support getAxis().")

