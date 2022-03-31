# dependencies:
# GObject-2.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# Gio-2.0
# immediate dependencies:
# Gst-1.0
# Gio-2.0
# GObject-2.0
# GModule-2.0
# GLib-2.0
# libraries:
# libgstnet-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule, gio
const Lib = "libgstnet-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const NET_TIME_PACKET_SIZE* = 16'i32

type
  NetAddressMeta00* {.pure.} = object
  NetAddressMeta* = ref object
    impl*: ptr NetAddressMeta00
    ignoreFinalizer*: bool

proc gst_net_address_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoNetAddressMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_net_address_meta_get_info()
  result.ignoreFinalizer = true

type
  NetClientClock* = ref object of gst.SystemClock
  NetClientClock00* = object of gst.SystemClock00

proc gst_net_client_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NetClientClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_net_client_clock_new(name: cstring; remoteAddress: cstring; remotePort: int32;
    baseTime: uint64): ptr NetClientClock00 {.
    importc, libprag.}

proc newNetClientClock*(name: cstring; remoteAddress: cstring; remotePort: int;
    baseTime: uint64): NetClientClock =
  let gobj = gst_net_client_clock_new(name, remoteAddress, int32(remotePort), baseTime)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNetClientClock*(tdesc: typedesc; name: cstring; remoteAddress: cstring; remotePort: int;
    baseTime: uint64): tdesc =
  assert(result is NetClientClock)
  let gobj = gst_net_client_clock_new(name, remoteAddress, int32(remotePort), baseTime)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNetClientClock*[T](result: var T; name: cstring; remoteAddress: cstring; remotePort: int;
    baseTime: uint64) {.deprecated.} =
  assert(result is NetClientClock)
  let gobj = gst_net_client_clock_new(name, remoteAddress, int32(remotePort), baseTime)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  NetControlMessageMeta00* {.pure.} = object
  NetControlMessageMeta* = ref object
    impl*: ptr NetControlMessageMeta00
    ignoreFinalizer*: bool

proc gst_net_control_message_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoNetControlMessageMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_net_control_message_meta_get_info()
  result.ignoreFinalizer = true

type
  NetTimePacket00* {.pure.} = object
  NetTimePacket* = ref object
    impl*: ptr NetTimePacket00
    ignoreFinalizer*: bool

proc gst_net_time_packet_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstNetTimePacket*(self: NetTimePacket) =
  if not self.ignoreFinalizer:
    boxedFree(gst_net_time_packet_get_type(), cast[ptr NetTimePacket00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NetTimePacket()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_net_time_packet_get_type(), cast[ptr NetTimePacket00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var NetTimePacket) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstNetTimePacket)

proc gst_net_time_packet_free(self: ptr NetTimePacket00) {.
    importc, libprag.}

proc free*(self: NetTimePacket) =
  gst_net_time_packet_free(cast[ptr NetTimePacket00](self.impl))

proc finalizerfree*(self: NetTimePacket) =
  if not self.ignoreFinalizer:
    gst_net_time_packet_free(cast[ptr NetTimePacket00](self.impl))

proc gst_net_time_packet_copy(self: ptr NetTimePacket00): ptr NetTimePacket00 {.
    importc, libprag.}

proc copy*(self: NetTimePacket): NetTimePacket =
  fnew(result, gBoxedFreeGstNetTimePacket)
  result.impl = gst_net_time_packet_copy(cast[ptr NetTimePacket00](self.impl))

proc gst_net_time_packet_new(buffer: ptr uint8): ptr NetTimePacket00 {.
    importc, libprag.}

proc newNetTimePacket*(buffer: seq[uint8] | string): NetTimePacket =
  fnew(result, gBoxedFreeGstNetTimePacket)
  result.impl = gst_net_time_packet_new(cast[ptr uint8](unsafeaddr(buffer[0])))

proc newNetTimePacket*(tdesc: typedesc; buffer: seq[uint8] | string): tdesc =
  assert(result is NetTimePacket)
  fnew(result, gBoxedFreeGstNetTimePacket)
  result.impl = gst_net_time_packet_new(cast[ptr uint8](unsafeaddr(buffer[0])))

proc initNetTimePacket*[T](result: var T; buffer: seq[uint8] | string) {.deprecated.} =
  assert(result is NetTimePacket)
  fnew(result, gBoxedFreeGstNetTimePacket)
  result.impl = gst_net_time_packet_new(cast[ptr uint8](unsafeaddr(buffer[0])))

proc gst_net_time_packet_send(self: ptr NetTimePacket00; socket: ptr gio.Socket00;
    destAddress: ptr gio.SocketAddress00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc send*(self: NetTimePacket; socket: gio.Socket; destAddress: gio.SocketAddress): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_net_time_packet_send(cast[ptr NetTimePacket00](self.impl), cast[ptr gio.Socket00](socket.impl), cast[ptr gio.SocketAddress00](destAddress.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_net_time_packet_serialize(self: ptr NetTimePacket00): ptr uint8 {.
    importc, libprag.}

proc serialize*(self: NetTimePacket): ptr uint8 =
  gst_net_time_packet_serialize(cast[ptr NetTimePacket00](self.impl))

proc gst_net_time_packet_receive(socket: ptr gio.Socket00; srcAddress: var ptr gio.SocketAddress00;
    error: ptr ptr glib.Error = nil): ptr NetTimePacket00 {.
    importc, libprag.}

proc receive*(socket: gio.Socket; srcAddress: var gio.SocketAddress): NetTimePacket =
  var tmpoutgobjectarg: ptr gio.SocketAddress00
  var gerror: ptr glib.Error
  let impl0 = gst_net_time_packet_receive(cast[ptr gio.Socket00](socket.impl), tmpoutgobjectarg, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstNetTimePacket)
  result.impl = impl0
#  dothemagic(srcAddress
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    srcAddress = cast[type(srcAddress)](argqdata)
    assert(srcAddress.impl == tmpoutgobjectarg)
  else:
    fnew(srcAddress, gstnet.finalizeGObject)
    srcAddress.impl = tmpoutgobjectarg
    GC_ref(srcAddress)
    if g_object_is_floating(srcAddress.impl).int != 0:
      discard g_object_ref_sink(srcAddress.impl)
    g_object_add_toggle_ref(srcAddress.impl, toggleNotify, addr(srcAddress[]))
    g_object_unref(srcAddress.impl)
    assert(g_object_get_qdata(srcAddress.impl, Quark) == nil)
    g_object_set_qdata(srcAddress.impl, Quark, addr(srcAddress[]))


type
  NetTimeProvider* = ref object of gst.Object
  NetTimeProvider00* = object of gst.Object00

proc gst_net_time_provider_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NetTimeProvider()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_net_time_provider_new(clock: ptr gst.Clock00; address: cstring;
    port: int32): ptr NetTimeProvider00 {.
    importc, libprag.}

proc newNetTimeProvider*(clock: gst.Clock; address: cstring = nil;
    port: int): NetTimeProvider =
  let gobj = gst_net_time_provider_new(cast[ptr gst.Clock00](clock.impl), address, int32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstnet.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNetTimeProvider*(tdesc: typedesc; clock: gst.Clock; address: cstring = nil;
    port: int): tdesc =
  assert(result is NetTimeProvider)
  let gobj = gst_net_time_provider_new(cast[ptr gst.Clock00](clock.impl), address, int32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstnet.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNetTimeProvider*[T](result: var T; clock: gst.Clock; address: cstring = nil;
    port: int) {.deprecated.} =
  assert(result is NetTimeProvider)
  let gobj = gst_net_time_provider_new(cast[ptr gst.Clock00](clock.impl), address, int32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstnet.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  NtpClock* = ref object of NetClientClock
  NtpClock00* = object of NetClientClock00

proc gst_ntp_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NtpClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_ntp_clock_new(name: cstring; remoteAddress: cstring; remotePort: int32;
    baseTime: uint64): ptr NtpClock00 {.
    importc, libprag.}

proc newNtpClock*(name: cstring; remoteAddress: cstring; remotePort: int;
    baseTime: uint64): NtpClock =
  let gobj = gst_ntp_clock_new(name, remoteAddress, int32(remotePort), baseTime)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNtpClock*(tdesc: typedesc; name: cstring; remoteAddress: cstring; remotePort: int;
    baseTime: uint64): tdesc =
  assert(result is NtpClock)
  let gobj = gst_ntp_clock_new(name, remoteAddress, int32(remotePort), baseTime)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNtpClock*[T](result: var T; name: cstring; remoteAddress: cstring; remotePort: int;
    baseTime: uint64) {.deprecated.} =
  assert(result is NtpClock)
  let gobj = gst_ntp_clock_new(name, remoteAddress, int32(remotePort), baseTime)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

const PTP_CLOCK_ID_NONE* = 18446744073709551615'u64

const PTP_STATISTICS_BEST_MASTER_CLOCK_SELECTED* = "GstPtpStatisticsBestMasterClockSelected"

const PTP_STATISTICS_NEW_DOMAIN_FOUND* = "GstPtpStatisticsNewDomainFound"

const PTP_STATISTICS_PATH_DELAY_MEASURED* = "GstPtpStatisticsPathDelayMeasured"

const PTP_STATISTICS_TIME_UPDATED* = "GstPtpStatisticsTimeUpdated"

type
  PtpClock* = ref object of gst.SystemClock
  PtpClock00* = object of gst.SystemClock00

proc gst_ptp_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PtpClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_ptp_clock_new(name: cstring; domain: uint32): ptr PtpClock00 {.
    importc, libprag.}

proc newPtpClock*(name: cstring; domain: int): PtpClock =
  let gobj = gst_ptp_clock_new(name, uint32(domain))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPtpClock*(tdesc: typedesc; name: cstring; domain: int): tdesc =
  assert(result is PtpClock)
  let gobj = gst_ptp_clock_new(name, uint32(domain))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPtpClock*[T](result: var T; name: cstring; domain: int) {.deprecated.} =
  assert(result is PtpClock)
  let gobj = gst_ptp_clock_new(name, uint32(domain))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PtpStatisticsCallback* = proc (domain: uint8; stats: ptr gst.Structure00; userData: pointer): gboolean {.cdecl.}

proc gst_buffer_add_net_address_meta(buffer: ptr gst.Buffer00; `addr`: ptr gio.SocketAddress00): ptr NetAddressMeta00 {.
    importc, libprag.}

proc bufferAddNetAddressMeta*(buffer: gst.Buffer; `addr`: gio.SocketAddress): NetAddressMeta =
  new(result)
  result.impl = gst_buffer_add_net_address_meta(cast[ptr gst.Buffer00](buffer.impl), cast[ptr gio.SocketAddress00](`addr`.impl))
  result.ignoreFinalizer = true

proc gst_buffer_add_net_control_message_meta(buffer: ptr gst.Buffer00; message: ptr gio.SocketControlMessage00): ptr NetControlMessageMeta00 {.
    importc, libprag.}

proc bufferAddNetControlMessageMeta*(buffer: gst.Buffer; message: gio.SocketControlMessage): NetControlMessageMeta =
  new(result)
  result.impl = gst_buffer_add_net_control_message_meta(cast[ptr gst.Buffer00](buffer.impl), cast[ptr gio.SocketControlMessage00](message.impl))
  result.ignoreFinalizer = true

proc gst_buffer_get_net_address_meta(buffer: ptr gst.Buffer00): ptr NetAddressMeta00 {.
    importc, libprag.}

proc bufferGetNetAddressMeta*(buffer: gst.Buffer): NetAddressMeta =
  new(result)
  result.impl = gst_buffer_get_net_address_meta(cast[ptr gst.Buffer00](buffer.impl))
  result.ignoreFinalizer = true

proc netAddressMetaApiGetType*(): GType {.
    importc: "gst_net_address_meta_api_get_type", libprag.}

proc netControlMessageMetaApiGetType*(): GType {.
    importc: "gst_net_control_message_meta_api_get_type", libprag.}

proc gst_net_utils_set_socket_tos(socket: ptr gio.Socket00; qosDscp: int32): gboolean {.
    importc, libprag.}

proc netUtilsSetSocketTos*(socket: gio.Socket; qosDscp: int): bool =
  toBool(gst_net_utils_set_socket_tos(cast[ptr gio.Socket00](socket.impl), int32(qosDscp)))

proc ptpDeinit*() {.
    importc: "gst_ptp_deinit", libprag.}

proc gst_ptp_init(clockId: uint64; interfaces: ptr cstring): gboolean {.
    importc, libprag.}

proc ptpInit*(clockId: uint64; interfaces: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  toBool(gst_ptp_init(clockId, seq2CstringArray(interfaces, fs469n23)))

proc gst_ptp_is_initialized(): gboolean {.
    importc, libprag.}

proc ptpIsInitialized*(): bool =
  toBool(gst_ptp_is_initialized())

proc gst_ptp_is_supported(): gboolean {.
    importc, libprag.}

proc ptpIsSupported*(): bool =
  toBool(gst_ptp_is_supported())

proc ptpStatisticsCallbackAdd*(callback: PtpStatisticsCallback; userData: pointer;
    destroyData: DestroyNotify): uint64 {.
    importc: "gst_ptp_statistics_callback_add", libprag.}

proc ptpStatisticsCallbackRemove*(id: uint64) {.
    importc: "gst_ptp_statistics_callback_remove", libprag.}
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc initable*(x: gstnet.NetTimeProvider): gio.Initable = cast[gio.Initable](x)
