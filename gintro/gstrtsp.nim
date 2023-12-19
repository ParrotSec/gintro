# dependencies:
# GObject-2.0
# GstBase-1.0
# GstSdp-1.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# Gio-2.0
# immediate dependencies:
# GstSdp-1.0
# GstBase-1.0
# Gst-1.0
# Gio-2.0
# libraries:
# libgstrtsp-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gstsdp, gst, glib, gmodule, gio
const Lib = "libgstrtsp-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  RTSPResult* {.size: sizeof(cint), pure.} = enum
    elast = -17
    etpost = -16
    etget = -15
    etimeout = -14
    enotip = -13
    enet = -12
    eeof = -11
    ewsaversion = -10
    ewsastart = -9
    eparse = -8
    esys = -7
    enotimpl = -6
    eresolv = -5
    enomem = -4
    eintr = -3
    einval = -2
    error = -1
    ok = 0

type
  RTSPAuthCredential00* {.pure.} = object
  RTSPAuthCredential* = ref object
    impl*: ptr RTSPAuthCredential00
    ignoreFinalizer*: bool

proc gst_rtsp_auth_credential_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstRTSPAuthCredential*(self: RTSPAuthCredential) =
  if not self.ignoreFinalizer:
    boxedFree(gst_rtsp_auth_credential_get_type(), cast[ptr RTSPAuthCredential00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTSPAuthCredential()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_rtsp_auth_credential_get_type(), cast[ptr RTSPAuthCredential00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var RTSPAuthCredential) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstRTSPAuthCredential)

type
  RTSPAuthMethod* {.size: sizeof(cint), pure.} = enum
    none = 0
    basic = 1
    digest = 2

type
  RTSPAuthParam00* {.pure.} = object
  RTSPAuthParam* = ref object
    impl*: ptr RTSPAuthParam00
    ignoreFinalizer*: bool

proc gst_rtsp_auth_param_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstRTSPAuthParam*(self: RTSPAuthParam) =
  if not self.ignoreFinalizer:
    boxedFree(gst_rtsp_auth_param_get_type(), cast[ptr RTSPAuthParam00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTSPAuthParam()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_rtsp_auth_param_get_type(), cast[ptr RTSPAuthParam00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var RTSPAuthParam) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstRTSPAuthParam)

proc gst_rtsp_auth_param_free(self: ptr RTSPAuthParam00) {.
    importc, libprag.}

proc free*(self: RTSPAuthParam) =
  gst_rtsp_auth_param_free(cast[ptr RTSPAuthParam00](self.impl))

proc finalizerfree*(self: RTSPAuthParam) =
  if not self.ignoreFinalizer:
    gst_rtsp_auth_param_free(cast[ptr RTSPAuthParam00](self.impl))

proc gst_rtsp_auth_param_copy(self: ptr RTSPAuthParam00): ptr RTSPAuthParam00 {.
    importc, libprag.}

proc copy*(self: RTSPAuthParam): RTSPAuthParam =
  fnew(result, gBoxedFreeGstRTSPAuthParam)
  result.impl = gst_rtsp_auth_param_copy(cast[ptr RTSPAuthParam00](self.impl))

type
  RTSPConnection00* {.pure.} = object
  RTSPConnection* = ref object
    impl*: ptr RTSPConnection00
    ignoreFinalizer*: bool

proc gst_rtsp_connection_free(self: ptr RTSPConnection00): RTSPResult {.
    importc, libprag.}

proc free*(self: RTSPConnection): RTSPResult =
  gst_rtsp_connection_free(cast[ptr RTSPConnection00](self.impl))

proc finalizerfree*(self: RTSPConnection) =
  if not self.ignoreFinalizer:
    discard gst_rtsp_connection_free(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTSPConnection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      discard gst_rtsp_connection_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var RTSPConnection) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_rtsp_connection_close(self: ptr RTSPConnection00): RTSPResult {.
    importc, libprag.}

proc close*(self: RTSPConnection): RTSPResult =
  gst_rtsp_connection_close(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_connect(self: ptr RTSPConnection00; timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc connect*(self: RTSPConnection; timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_connect(cast[ptr RTSPConnection00](self.impl), timeout)

proc gst_rtsp_connection_connect_usec(self: ptr RTSPConnection00; timeout: int64): RTSPResult {.
    importc, libprag.}

proc connectUsec*(self: RTSPConnection; timeout: int64): RTSPResult =
  gst_rtsp_connection_connect_usec(cast[ptr RTSPConnection00](self.impl), timeout)

proc gst_rtsp_connection_do_tunnel(self: ptr RTSPConnection00; conn2: ptr RTSPConnection00): RTSPResult {.
    importc, libprag.}

proc doTunnel*(self: RTSPConnection; conn2: RTSPConnection): RTSPResult =
  gst_rtsp_connection_do_tunnel(cast[ptr RTSPConnection00](self.impl), cast[ptr RTSPConnection00](conn2.impl))

proc gst_rtsp_connection_flush(self: ptr RTSPConnection00; flush: gboolean): RTSPResult {.
    importc, libprag.}

proc flush*(self: RTSPConnection; flush: bool): RTSPResult =
  gst_rtsp_connection_flush(cast[ptr RTSPConnection00](self.impl), gboolean(flush))

proc gst_rtsp_connection_clear_auth_params(self: ptr RTSPConnection00) {.
    importc, libprag.}

proc clearAuthParams*(self: RTSPConnection) =
  gst_rtsp_connection_clear_auth_params(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_get_ip(self: ptr RTSPConnection00): cstring {.
    importc, libprag.}

proc getIp*(self: RTSPConnection): string =
  result = $gst_rtsp_connection_get_ip(cast[ptr RTSPConnection00](self.impl))

proc ip*(self: RTSPConnection): string =
  result = $gst_rtsp_connection_get_ip(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_get_read_socket(self: ptr RTSPConnection00): ptr gio.Socket00 {.
    importc, libprag.}

proc getReadSocket*(self: RTSPConnection): gio.Socket =
  let gobj = gst_rtsp_connection_get_read_socket(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc readSocket*(self: RTSPConnection): gio.Socket =
  let gobj = gst_rtsp_connection_get_read_socket(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_rtsp_connection_get_remember_session_id(self: ptr RTSPConnection00): gboolean {.
    importc, libprag.}

proc getRememberSessionId*(self: RTSPConnection): bool =
  toBool(gst_rtsp_connection_get_remember_session_id(cast[ptr RTSPConnection00](self.impl)))

proc rememberSessionId*(self: RTSPConnection): bool =
  toBool(gst_rtsp_connection_get_remember_session_id(cast[ptr RTSPConnection00](self.impl)))

proc gst_rtsp_connection_get_tls(self: ptr RTSPConnection00; error: ptr ptr glib.Error = nil): ptr gio.TlsConnection00 {.
    importc, libprag.}

proc getTls*(self: RTSPConnection): gio.TlsConnection =
  var gerror: ptr glib.Error
  let gobj = gst_rtsp_connection_get_tls(cast[ptr RTSPConnection00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc tls*(self: RTSPConnection): gio.TlsConnection =
  var gerror: ptr glib.Error
  let gobj = gst_rtsp_connection_get_tls(cast[ptr RTSPConnection00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_rtsp_connection_get_tls_database(self: ptr RTSPConnection00): ptr gio.TlsDatabase00 {.
    importc, libprag.}

proc getTlsDatabase*(self: RTSPConnection): gio.TlsDatabase =
  let gobj = gst_rtsp_connection_get_tls_database(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc tlsDatabase*(self: RTSPConnection): gio.TlsDatabase =
  let gobj = gst_rtsp_connection_get_tls_database(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_rtsp_connection_get_tls_interaction(self: ptr RTSPConnection00): ptr gio.TlsInteraction00 {.
    importc, libprag.}

proc getTlsInteraction*(self: RTSPConnection): gio.TlsInteraction =
  let gobj = gst_rtsp_connection_get_tls_interaction(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc tlsInteraction*(self: RTSPConnection): gio.TlsInteraction =
  let gobj = gst_rtsp_connection_get_tls_interaction(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_rtsp_connection_get_tls_validation_flags(self: ptr RTSPConnection00): gio.TlsCertificateFlags {.
    importc, libprag.}

proc getTlsValidationFlags*(self: RTSPConnection): gio.TlsCertificateFlags =
  gst_rtsp_connection_get_tls_validation_flags(cast[ptr RTSPConnection00](self.impl))

proc tlsValidationFlags*(self: RTSPConnection): gio.TlsCertificateFlags =
  gst_rtsp_connection_get_tls_validation_flags(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_get_tunnelid(self: ptr RTSPConnection00): cstring {.
    importc, libprag.}

proc getTunnelid*(self: RTSPConnection): string =
  result = $gst_rtsp_connection_get_tunnelid(cast[ptr RTSPConnection00](self.impl))

proc tunnelid*(self: RTSPConnection): string =
  result = $gst_rtsp_connection_get_tunnelid(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_get_write_socket(self: ptr RTSPConnection00): ptr gio.Socket00 {.
    importc, libprag.}

proc getWriteSocket*(self: RTSPConnection): gio.Socket =
  let gobj = gst_rtsp_connection_get_write_socket(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc writeSocket*(self: RTSPConnection): gio.Socket =
  let gobj = gst_rtsp_connection_get_write_socket(cast[ptr RTSPConnection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_rtsp_connection_is_tunneled(self: ptr RTSPConnection00): gboolean {.
    importc, libprag.}

proc isTunneled*(self: RTSPConnection): bool =
  toBool(gst_rtsp_connection_is_tunneled(cast[ptr RTSPConnection00](self.impl)))

proc gst_rtsp_connection_next_timeout(self: ptr RTSPConnection00; timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc nextTimeout*(self: RTSPConnection; timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_next_timeout(cast[ptr RTSPConnection00](self.impl), timeout)

proc gst_rtsp_connection_next_timeout_usec(self: ptr RTSPConnection00): int64 {.
    importc, libprag.}

proc nextTimeoutUsec*(self: RTSPConnection): int64 =
  gst_rtsp_connection_next_timeout_usec(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_read(self: ptr RTSPConnection00; data: ptr uint8;
    size: uint32; timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc read*(self: RTSPConnection; data: ptr uint8; size: int;
    timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_read(cast[ptr RTSPConnection00](self.impl), data, uint32(size), timeout)

proc gst_rtsp_connection_read_usec(self: ptr RTSPConnection00; data: ptr uint8;
    size: uint32; timeout: int64): RTSPResult {.
    importc, libprag.}

proc readUsec*(self: RTSPConnection; data: ptr uint8;
    size: int; timeout: int64): RTSPResult =
  gst_rtsp_connection_read_usec(cast[ptr RTSPConnection00](self.impl), data, uint32(size), timeout)

proc gst_rtsp_connection_reset_timeout(self: ptr RTSPConnection00): RTSPResult {.
    importc, libprag.}

proc resetTimeout*(self: RTSPConnection): RTSPResult =
  gst_rtsp_connection_reset_timeout(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_set_auth(self: ptr RTSPConnection00; `method`: RTSPAuthMethod;
    user: cstring; pass: cstring): RTSPResult {.
    importc, libprag.}

proc setAuth*(self: RTSPConnection; `method`: RTSPAuthMethod;
    user: cstring; pass: cstring): RTSPResult =
  gst_rtsp_connection_set_auth(cast[ptr RTSPConnection00](self.impl), `method`, user, pass)

proc gst_rtsp_connection_set_auth_param(self: ptr RTSPConnection00; param: cstring;
    value: cstring) {.
    importc, libprag.}

proc setAuthParam*(self: RTSPConnection; param: cstring;
    value: cstring) =
  gst_rtsp_connection_set_auth_param(cast[ptr RTSPConnection00](self.impl), param, value)

proc gst_rtsp_connection_set_content_length_limit(self: ptr RTSPConnection00;
    limit: uint32) {.
    importc, libprag.}

proc setContentLengthLimit*(self: RTSPConnection; limit: int) =
  gst_rtsp_connection_set_content_length_limit(cast[ptr RTSPConnection00](self.impl), uint32(limit))

proc `contentLengthLimit=`*(self: RTSPConnection; limit: int) =
  gst_rtsp_connection_set_content_length_limit(cast[ptr RTSPConnection00](self.impl), uint32(limit))

proc gst_rtsp_connection_set_http_mode(self: ptr RTSPConnection00; enable: gboolean) {.
    importc, libprag.}

proc setHttpMode*(self: RTSPConnection; enable: bool = true) =
  gst_rtsp_connection_set_http_mode(cast[ptr RTSPConnection00](self.impl), gboolean(enable))

proc `httpMode=`*(self: RTSPConnection; enable: bool) =
  gst_rtsp_connection_set_http_mode(cast[ptr RTSPConnection00](self.impl), gboolean(enable))

proc gst_rtsp_connection_set_ip(self: ptr RTSPConnection00; ip: cstring) {.
    importc, libprag.}

proc setIp*(self: RTSPConnection; ip: cstring) =
  gst_rtsp_connection_set_ip(cast[ptr RTSPConnection00](self.impl), ip)

proc `ip=`*(self: RTSPConnection; ip: cstring) =
  gst_rtsp_connection_set_ip(cast[ptr RTSPConnection00](self.impl), ip)

proc gst_rtsp_connection_set_proxy(self: ptr RTSPConnection00; host: cstring;
    port: uint32): RTSPResult {.
    importc, libprag.}

proc setProxy*(self: RTSPConnection; host: cstring; port: int): RTSPResult =
  gst_rtsp_connection_set_proxy(cast[ptr RTSPConnection00](self.impl), host, uint32(port))

proc gst_rtsp_connection_set_qos_dscp(self: ptr RTSPConnection00; qosDscp: uint32): RTSPResult {.
    importc, libprag.}

proc setQosDscp*(self: RTSPConnection; qosDscp: int): RTSPResult =
  gst_rtsp_connection_set_qos_dscp(cast[ptr RTSPConnection00](self.impl), uint32(qosDscp))

proc gst_rtsp_connection_set_remember_session_id(self: ptr RTSPConnection00;
    remember: gboolean) {.
    importc, libprag.}

proc setRememberSessionId*(self: RTSPConnection; remember: bool = true) =
  gst_rtsp_connection_set_remember_session_id(cast[ptr RTSPConnection00](self.impl), gboolean(remember))

proc `rememberSessionId=`*(self: RTSPConnection; remember: bool) =
  gst_rtsp_connection_set_remember_session_id(cast[ptr RTSPConnection00](self.impl), gboolean(remember))

proc gst_rtsp_connection_set_tls_database(self: ptr RTSPConnection00; database: ptr gio.TlsDatabase00) {.
    importc, libprag.}

proc setTlsDatabase*(self: RTSPConnection; database: gio.TlsDatabase) =
  gst_rtsp_connection_set_tls_database(cast[ptr RTSPConnection00](self.impl), cast[ptr gio.TlsDatabase00](database.impl))

proc `tlsDatabase=`*(self: RTSPConnection; database: gio.TlsDatabase) =
  gst_rtsp_connection_set_tls_database(cast[ptr RTSPConnection00](self.impl), cast[ptr gio.TlsDatabase00](database.impl))

proc gst_rtsp_connection_set_tls_interaction(self: ptr RTSPConnection00;
    interaction: ptr gio.TlsInteraction00) {.
    importc, libprag.}

proc setTlsInteraction*(self: RTSPConnection; interaction: gio.TlsInteraction) =
  gst_rtsp_connection_set_tls_interaction(cast[ptr RTSPConnection00](self.impl), cast[ptr gio.TlsInteraction00](interaction.impl))

proc `tlsInteraction=`*(self: RTSPConnection; interaction: gio.TlsInteraction) =
  gst_rtsp_connection_set_tls_interaction(cast[ptr RTSPConnection00](self.impl), cast[ptr gio.TlsInteraction00](interaction.impl))

proc gst_rtsp_connection_set_tls_validation_flags(self: ptr RTSPConnection00;
    flags: gio.TlsCertificateFlags): gboolean {.
    importc, libprag.}

proc setTlsValidationFlags*(self: RTSPConnection; flags: gio.TlsCertificateFlags): bool =
  toBool(gst_rtsp_connection_set_tls_validation_flags(cast[ptr RTSPConnection00](self.impl), flags))

proc gst_rtsp_connection_set_tunneled(self: ptr RTSPConnection00; tunneled: gboolean) {.
    importc, libprag.}

proc setTunneled*(self: RTSPConnection; tunneled: bool = true) =
  gst_rtsp_connection_set_tunneled(cast[ptr RTSPConnection00](self.impl), gboolean(tunneled))

proc `tunneled=`*(self: RTSPConnection; tunneled: bool) =
  gst_rtsp_connection_set_tunneled(cast[ptr RTSPConnection00](self.impl), gboolean(tunneled))

proc gst_rtsp_connection_write(self: ptr RTSPConnection00; data: ptr uint8;
    size: uint32; timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc write*(self: RTSPConnection; data: ptr uint8; size: int;
    timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_write(cast[ptr RTSPConnection00](self.impl), data, uint32(size), timeout)

proc gst_rtsp_connection_write_usec(self: ptr RTSPConnection00; data: ptr uint8;
    size: uint32; timeout: int64): RTSPResult {.
    importc, libprag.}

proc writeUsec*(self: RTSPConnection; data: ptr uint8;
    size: int; timeout: int64): RTSPResult =
  gst_rtsp_connection_write_usec(cast[ptr RTSPConnection00](self.impl), data, uint32(size), timeout)

proc gst_rtsp_connection_accept(socket: ptr gio.Socket00; conn: var ptr RTSPConnection00;
    cancellable: ptr gio.Cancellable00): RTSPResult {.
    importc, libprag.}

proc accept*(socket: gio.Socket; conn: var RTSPConnection;
    cancellable: gio.Cancellable = nil): RTSPResult =
  fnew(conn, finalizerfree)
  gst_rtsp_connection_accept(cast[ptr gio.Socket00](socket.impl), cast[var ptr RTSPConnection00](addr conn.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl))

proc gst_rtsp_connection_create_from_socket(socket: ptr gio.Socket00; ip: cstring;
    port: uint16; initialBuffer: cstring; conn: var ptr RTSPConnection00): RTSPResult {.
    importc, libprag.}

proc createFromSocket*(socket: gio.Socket; ip: cstring;
    port: uint16; initialBuffer: cstring; conn: var RTSPConnection): RTSPResult =
  fnew(conn, finalizerfree)
  gst_rtsp_connection_create_from_socket(cast[ptr gio.Socket00](socket.impl), ip, port, initialBuffer, cast[var ptr RTSPConnection00](addr conn.impl))

type
  RTSPEvent* {.size: sizeof(cint), pure.} = enum
    read = 1
    write = 2

proc gst_rtsp_connection_poll(self: ptr RTSPConnection00; events: RTSPEvent;
    revents: ptr RTSPEvent; timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc poll*(self: RTSPConnection; events: RTSPEvent; revents: ptr RTSPEvent;
    timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_poll(cast[ptr RTSPConnection00](self.impl), events, revents, timeout)

proc gst_rtsp_connection_poll_usec(self: ptr RTSPConnection00; events: RTSPEvent;
    revents: ptr RTSPEvent; timeout: int64): RTSPResult {.
    importc, libprag.}

proc pollUsec*(self: RTSPConnection; events: RTSPEvent;
    revents: ptr RTSPEvent; timeout: int64): RTSPResult =
  gst_rtsp_connection_poll_usec(cast[ptr RTSPConnection00](self.impl), events, revents, timeout)

type
  RTSPMessage00* {.pure.} = object
  RTSPMessage* = ref object
    impl*: ptr RTSPMessage00
    ignoreFinalizer*: bool

proc gst_rtsp_msg_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstRTSPMessage*(self: RTSPMessage) =
  if not self.ignoreFinalizer:
    boxedFree(gst_rtsp_msg_get_type(), cast[ptr RTSPMessage00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTSPMessage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_rtsp_msg_get_type(), cast[ptr RTSPMessage00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var RTSPMessage) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstRTSPMessage)

proc gst_rtsp_message_free(self: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc free*(self: RTSPMessage): RTSPResult =
  gst_rtsp_message_free(cast[ptr RTSPMessage00](self.impl))

proc finalizerfree*(self: RTSPMessage) =
  if not self.ignoreFinalizer:
    discard gst_rtsp_message_free(self.impl)

proc gst_rtsp_message_add_header_by_name(self: ptr RTSPMessage00; header: cstring;
    value: cstring): RTSPResult {.
    importc, libprag.}

proc addHeaderByName*(self: RTSPMessage; header: cstring;
    value: cstring): RTSPResult =
  gst_rtsp_message_add_header_by_name(cast[ptr RTSPMessage00](self.impl), header, value)

proc gst_rtsp_message_append_headers(self: ptr RTSPMessage00; str: glib.String): RTSPResult {.
    importc, libprag.}

proc appendHeaders*(self: RTSPMessage; str: glib.String): RTSPResult =
  gst_rtsp_message_append_headers(cast[ptr RTSPMessage00](self.impl), str)

proc gst_rtsp_message_copy(self: ptr RTSPMessage00; copy: var ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc copy*(self: RTSPMessage; copy: var RTSPMessage): RTSPResult =
  fnew(copy, gBoxedFreeGstRTSPMessage)
  gst_rtsp_message_copy(cast[ptr RTSPMessage00](self.impl), cast[var ptr RTSPMessage00](addr copy.impl))

proc gst_rtsp_message_dump(self: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc dump*(self: RTSPMessage): RTSPResult =
  gst_rtsp_message_dump(cast[ptr RTSPMessage00](self.impl))

proc gst_rtsp_message_get_body(self: ptr RTSPMessage00; data: var ptr uint8;
    size: var uint32): RTSPResult {.
    importc, libprag.}

proc getBody*(self: RTSPMessage; data: var (seq[uint8] | string);
    size: var int): RTSPResult =
  var data_00: ptr uint8
  var size_00: uint32
  result = gst_rtsp_message_get_body(cast[ptr RTSPMessage00](self.impl), data_00, size_00)
  data.setLen(size)
  copyMem(unsafeaddr data[0], data_00, size.int * sizeof(data[0]))
  cogfree(data_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_rtsp_message_get_body_buffer(self: ptr RTSPMessage00; buffer: var ptr gst.Buffer00): RTSPResult {.
    importc, libprag.}

proc getBodyBuffer*(self: RTSPMessage; buffer: var gst.Buffer): RTSPResult =
  fnew(buffer, gBoxedFreeGstBuffer)
  result = gst_rtsp_message_get_body_buffer(cast[ptr RTSPMessage00](self.impl), cast[var ptr gst.Buffer00](addr buffer.impl))
  buffer.impl = cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl))

proc gst_rtsp_message_get_header_by_name(self: ptr RTSPMessage00; header: cstring;
    value: var cstring; index: int32): RTSPResult {.
    importc, libprag.}

proc getHeaderByName*(self: RTSPMessage; header: cstring;
    value: var string; index: int): RTSPResult =
  var value_00: cstring
  result = gst_rtsp_message_get_header_by_name(cast[ptr RTSPMessage00](self.impl), header, value_00, int32(index))
  if value.addr != nil:
    value = $(value_00)

proc gst_rtsp_message_has_body_buffer(self: ptr RTSPMessage00): gboolean {.
    importc, libprag.}

proc hasBodyBuffer*(self: RTSPMessage): bool =
  toBool(gst_rtsp_message_has_body_buffer(cast[ptr RTSPMessage00](self.impl)))

proc gst_rtsp_message_init(self: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc init*(self: RTSPMessage): RTSPResult =
  gst_rtsp_message_init(cast[ptr RTSPMessage00](self.impl))

proc gst_rtsp_message_init_data(self: ptr RTSPMessage00; channel: uint8): RTSPResult {.
    importc, libprag.}

proc initData*(self: RTSPMessage; channel: uint8): RTSPResult =
  gst_rtsp_message_init_data(cast[ptr RTSPMessage00](self.impl), channel)

proc gst_rtsp_message_parse_data(self: ptr RTSPMessage00; channel: var uint8): RTSPResult {.
    importc, libprag.}

proc parseData*(self: RTSPMessage; channel: var uint8): RTSPResult =
  gst_rtsp_message_parse_data(cast[ptr RTSPMessage00](self.impl), channel)

proc gst_rtsp_message_remove_header_by_name(self: ptr RTSPMessage00; header: cstring;
    index: int32): RTSPResult {.
    importc, libprag.}

proc removeHeaderByName*(self: RTSPMessage; header: cstring;
    index: int): RTSPResult =
  gst_rtsp_message_remove_header_by_name(cast[ptr RTSPMessage00](self.impl), header, int32(index))

proc gst_rtsp_message_set_body(self: ptr RTSPMessage00; data: ptr uint8;
    size: uint32): RTSPResult {.
    importc, libprag.}

proc setBody*(self: RTSPMessage; data: seq[uint8] | string): RTSPResult =
  let size = int(data.len)
  gst_rtsp_message_set_body(cast[ptr RTSPMessage00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(size))

proc gst_rtsp_message_set_body_buffer(self: ptr RTSPMessage00; buffer: ptr gst.Buffer00): RTSPResult {.
    importc, libprag.}

proc setBodyBuffer*(self: RTSPMessage; buffer: gst.Buffer): RTSPResult =
  gst_rtsp_message_set_body_buffer(cast[ptr RTSPMessage00](self.impl), cast[ptr gst.Buffer00](buffer.impl))

proc gst_rtsp_message_steal_body(self: ptr RTSPMessage00; data: var ptr uint8;
    size: var uint32): RTSPResult {.
    importc, libprag.}

proc stealBody*(self: RTSPMessage; data: var (seq[uint8] | string);
    size: var int): RTSPResult =
  var data_00: ptr uint8
  var size_00: uint32
  result = gst_rtsp_message_steal_body(cast[ptr RTSPMessage00](self.impl), data_00, size_00)
  data.setLen(size)
  copyMem(unsafeaddr data[0], data_00, size.int * sizeof(data[0]))
  cogfree(data_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_rtsp_message_steal_body_buffer(self: ptr RTSPMessage00; buffer: var ptr gst.Buffer00): RTSPResult {.
    importc, libprag.}

proc stealBodyBuffer*(self: RTSPMessage; buffer: var gst.Buffer): RTSPResult =
  fnew(buffer, gBoxedFreeGstBuffer)
  gst_rtsp_message_steal_body_buffer(cast[ptr RTSPMessage00](self.impl), cast[var ptr gst.Buffer00](addr buffer.impl))

proc gst_rtsp_message_take_body(self: ptr RTSPMessage00; data: ptr uint8;
    size: uint32): RTSPResult {.
    importc, libprag.}

proc takeBody*(self: RTSPMessage; data: seq[uint8] | string): RTSPResult =
  let size = int(data.len)
  gst_rtsp_message_take_body(cast[ptr RTSPMessage00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(size))

proc gst_rtsp_message_take_body_buffer(self: ptr RTSPMessage00; buffer: ptr gst.Buffer00): RTSPResult {.
    importc, libprag.}

proc takeBodyBuffer*(self: RTSPMessage; buffer: gst.Buffer): RTSPResult =
  gst_rtsp_message_take_body_buffer(cast[ptr RTSPMessage00](self.impl), cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_rtsp_message_take_header_by_name(self: ptr RTSPMessage00; header: cstring;
    value: cstring): RTSPResult {.
    importc, libprag.}

proc takeHeaderByName*(self: RTSPMessage; header: cstring;
    value: cstring): RTSPResult =
  gst_rtsp_message_take_header_by_name(cast[ptr RTSPMessage00](self.impl), header, value)

proc gst_rtsp_message_unset(self: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc unset*(self: RTSPMessage): RTSPResult =
  gst_rtsp_message_unset(cast[ptr RTSPMessage00](self.impl))

proc gst_rtsp_connection_connect_with_response(self: ptr RTSPConnection00;
    timeout: glib.TimeVal; response: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc connectWithResponse*(self: RTSPConnection; timeout: glib.TimeVal;
    response: RTSPMessage): RTSPResult =
  gst_rtsp_connection_connect_with_response(cast[ptr RTSPConnection00](self.impl), timeout, cast[ptr RTSPMessage00](response.impl))

proc gst_rtsp_connection_connect_with_response_usec(self: ptr RTSPConnection00;
    timeout: int64; response: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc connectWithResponseUsec*(self: RTSPConnection;
    timeout: int64; response: RTSPMessage): RTSPResult =
  gst_rtsp_connection_connect_with_response_usec(cast[ptr RTSPConnection00](self.impl), timeout, cast[ptr RTSPMessage00](response.impl))

proc gst_rtsp_connection_receive(self: ptr RTSPConnection00; message: ptr RTSPMessage00;
    timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc receive*(self: RTSPConnection; message: RTSPMessage;
    timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_receive(cast[ptr RTSPConnection00](self.impl), cast[ptr RTSPMessage00](message.impl), timeout)

proc gst_rtsp_connection_receive_usec(self: ptr RTSPConnection00; message: ptr RTSPMessage00;
    timeout: int64): RTSPResult {.
    importc, libprag.}

proc receiveUsec*(self: RTSPConnection; message: RTSPMessage;
    timeout: int64): RTSPResult =
  gst_rtsp_connection_receive_usec(cast[ptr RTSPConnection00](self.impl), cast[ptr RTSPMessage00](message.impl), timeout)

proc gst_rtsp_connection_send(self: ptr RTSPConnection00; message: ptr RTSPMessage00;
    timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc send*(self: RTSPConnection; message: RTSPMessage;
    timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_send(cast[ptr RTSPConnection00](self.impl), cast[ptr RTSPMessage00](message.impl), timeout)

proc gst_rtsp_connection_send_messages(self: ptr RTSPConnection00; messages: ptr RTSPMessage00;
    nMessages: uint32; timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc sendMessages*(self: RTSPConnection; messages: ptr RTSPMessage00;
    nMessages: int; timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_connection_send_messages(cast[ptr RTSPConnection00](self.impl), messages, uint32(nMessages), timeout)

proc gst_rtsp_connection_send_messages_usec(self: ptr RTSPConnection00; messages: ptr RTSPMessage00;
    nMessages: uint32; timeout: int64): RTSPResult {.
    importc, libprag.}

proc sendMessagesUsec*(self: RTSPConnection; messages: ptr RTSPMessage00;
    nMessages: int; timeout: int64): RTSPResult =
  gst_rtsp_connection_send_messages_usec(cast[ptr RTSPConnection00](self.impl), messages, uint32(nMessages), timeout)

proc gst_rtsp_connection_send_usec(self: ptr RTSPConnection00; message: ptr RTSPMessage00;
    timeout: int64): RTSPResult {.
    importc, libprag.}

proc sendUsec*(self: RTSPConnection; message: RTSPMessage;
    timeout: int64): RTSPResult =
  gst_rtsp_connection_send_usec(cast[ptr RTSPConnection00](self.impl), cast[ptr RTSPMessage00](message.impl), timeout)

type
  RTSPMsgType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    request = 1
    response = 2
    httpRequest = 3
    httpResponse = 4
    data = 5

proc gst_rtsp_message_get_type(self: ptr RTSPMessage00): RTSPMsgType {.
    importc, libprag.}

proc getType*(self: RTSPMessage): RTSPMsgType =
  gst_rtsp_message_get_type(cast[ptr RTSPMessage00](self.impl))

type
  RTSPMethod* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    describe = 1
    announce = 2
    getParameter = 4
    options = 8
    pause = 16
    play = 32
    record = 64
    redirect = 128
    setup = 256
    setParameter = 512
    teardown = 1024
    get = 2048
    post = 4096

proc gst_rtsp_method_as_text(`method`: RTSPMethod): cstring {.
    importc, libprag.}

proc asText*(`method`: RTSPMethod): string =
  result = $gst_rtsp_method_as_text(`method`)

proc gst_rtsp_message_init_request(self: ptr RTSPMessage00; `method`: RTSPMethod;
    uri: cstring): RTSPResult {.
    importc, libprag.}

proc initRequest*(self: RTSPMessage; `method`: RTSPMethod;
    uri: cstring): RTSPResult =
  gst_rtsp_message_init_request(cast[ptr RTSPMessage00](self.impl), `method`, uri)

type
  RTSPVersion* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    enum1_0 = 16
    enum1_1 = 17
    enum2_0 = 32

proc gst_rtsp_version_as_text(version: RTSPVersion): cstring {.
    importc, libprag.}

proc asText*(version: RTSPVersion): string =
  result = $gst_rtsp_version_as_text(version)

proc gst_rtsp_message_parse_request(self: ptr RTSPMessage00; `method`: var RTSPMethod;
    uri: var cstring; version: var RTSPVersion): RTSPResult {.
    importc, libprag.}

proc parseRequest*(self: RTSPMessage; `method`: var RTSPMethod = cast[var RTSPMethod](nil);
    uri: var string = cast[var string](nil); version: var RTSPVersion = cast[var RTSPVersion](nil)): RTSPResult =
  var uri_00: cstring
  result = gst_rtsp_message_parse_request(cast[ptr RTSPMessage00](self.impl), `method`, uri_00, version)
  if uri.addr != nil:
    uri = $(uri_00)

type
  RTSPStatusCode* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    `continue` = 100
    ok = 200
    created = 201
    lowOnStorage = 250
    multipleChoices = 300
    movedPermanently = 301
    moveTemporarily = 302
    seeOther = 303
    notModified = 304
    useProxy = 305
    badRequest = 400
    unauthorized = 401
    paymentRequired = 402
    forbidden = 403
    notFound = 404
    methodNotAllowed = 405
    notAcceptable = 406
    proxyAuthRequired = 407
    requestTimeout = 408
    gone = 410
    lengthRequired = 411
    preconditionFailed = 412
    requestEntityTooLarge = 413
    requestUriTooLarge = 414
    unsupportedMediaType = 415
    parameterNotUnderstood = 451
    conferenceNotFound = 452
    notEnoughBandwidth = 453
    sessionNotFound = 454
    methodNotValidInThisState = 455
    headerFieldNotValidForResource = 456
    invalidRange = 457
    parameterIsReadonly = 458
    aggregateOperationNotAllowed = 459
    onlyAggregateOperationAllowed = 460
    unsupportedTransport = 461
    destinationUnreachable = 462
    keyManagementFailure = 463
    internalServerError = 500
    notImplemented = 501
    badGateway = 502
    serviceUnavailable = 503
    gatewayTimeout = 504
    rtspVersionNotSupported = 505
    optionNotSupported = 551

proc gst_rtsp_message_init_response(self: ptr RTSPMessage00; code: RTSPStatusCode;
    reason: cstring; request: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc initResponse*(self: RTSPMessage; code: RTSPStatusCode;
    reason: cstring = nil; request: RTSPMessage = nil): RTSPResult =
  gst_rtsp_message_init_response(cast[ptr RTSPMessage00](self.impl), code, reason, if request.isNil: nil else: cast[ptr RTSPMessage00](request.impl))

proc gst_rtsp_message_parse_response(self: ptr RTSPMessage00; code: var RTSPStatusCode;
    reason: var cstring; version: var RTSPVersion): RTSPResult {.
    importc, libprag.}

proc parseResponse*(self: RTSPMessage; code: var RTSPStatusCode = cast[var RTSPStatusCode](nil);
    reason: var string = cast[var string](nil); version: var RTSPVersion = cast[var RTSPVersion](nil)): RTSPResult =
  var reason_00: cstring
  result = gst_rtsp_message_parse_response(cast[ptr RTSPMessage00](self.impl), code, reason_00, version)
  if reason.addr != nil:
    reason = $(reason_00)

type
  RTSPHeaderField* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    accept = 1
    acceptEncoding = 2
    acceptLanguage = 3
    allow = 4
    authorization = 5
    bandwidth = 6
    blocksize = 7
    cacheControl = 8
    conference = 9
    connection = 10
    contentBase = 11
    contentEncoding = 12
    contentLanguage = 13
    contentLength = 14
    contentLocation = 15
    contentType = 16
    cseq = 17
    date = 18
    expires = 19
    `from` = 20
    ifModifiedSince = 21
    lastModified = 22
    proxyAuthenticate = 23
    proxyRequire = 24
    public = 25
    range = 26
    referer = 27
    require = 28
    retryAfter = 29
    rtpInfo = 30
    scale = 31
    session = 32
    server = 33
    speed = 34
    transport = 35
    unsupported = 36
    userAgent = 37
    via = 38
    wwwAuthenticate = 39
    clientChallenge = 40
    realChallenge1 = 41
    realChallenge2 = 42
    realChallenge3 = 43
    subscribe = 44
    alert = 45
    clientId = 46
    companyId = 47
    guid = 48
    regionData = 49
    maxAsmWidth = 50
    language = 51
    playerStartTime = 52
    location = 53
    etag = 54
    ifMatch = 55
    acceptCharset = 56
    supported = 57
    vary = 58
    xAccelerateStreaming = 59
    xAcceptAuthent = 60
    xAcceptProxyAuthent = 61
    xBroadcastId = 62
    xBurstStreaming = 63
    xNotice = 64
    xPlayerLagTime = 65
    xPlaylist = 66
    xPlaylistChangeNotice = 67
    xPlaylistGenId = 68
    xPlaylistSeekId = 69
    xProxyClientAgent = 70
    xProxyClientVerb = 71
    xRecedingPlaylistchange = 72
    xRtpInfo = 73
    xStartupprofile = 74
    timestamp = 75
    authenticationInfo = 76
    host = 77
    pragma = 78
    xServerIpAddress = 79
    xSessioncookie = 80
    rtcpInterval = 81
    keymgmt = 82
    pipelinedRequests = 83
    mediaProperties = 84
    seekStyle = 85
    acceptRanges = 86
    frames = 87
    rateControl = 88
    last = 89

proc gst_rtsp_message_add_header(self: ptr RTSPMessage00; field: RTSPHeaderField;
    value: cstring): RTSPResult {.
    importc, libprag.}

proc addHeader*(self: RTSPMessage; field: RTSPHeaderField;
    value: cstring): RTSPResult =
  gst_rtsp_message_add_header(cast[ptr RTSPMessage00](self.impl), field, value)

proc gst_rtsp_message_get_header(self: ptr RTSPMessage00; field: RTSPHeaderField;
    value: var cstring; indx: int32): RTSPResult {.
    importc, libprag.}

proc getHeader*(self: RTSPMessage; field: RTSPHeaderField;
    value: var string; indx: int): RTSPResult =
  var value_00: cstring
  result = gst_rtsp_message_get_header(cast[ptr RTSPMessage00](self.impl), field, value_00, int32(indx))
  if value.addr != nil:
    value = $(value_00)

proc gst_rtsp_message_parse_auth_credentials(self: ptr RTSPMessage00; field: RTSPHeaderField): ptr ptr RTSPAuthCredential00 {.
    importc, libprag.}

proc parseAuthCredentials*(self: RTSPMessage; field: RTSPHeaderField): ptr ptr RTSPAuthCredential00 =
  gst_rtsp_message_parse_auth_credentials(cast[ptr RTSPMessage00](self.impl), field)

proc gst_rtsp_message_remove_header(self: ptr RTSPMessage00; field: RTSPHeaderField;
    indx: int32): RTSPResult {.
    importc, libprag.}

proc removeHeader*(self: RTSPMessage; field: RTSPHeaderField;
    indx: int): RTSPResult =
  gst_rtsp_message_remove_header(cast[ptr RTSPMessage00](self.impl), field, int32(indx))

proc gst_rtsp_message_take_header(self: ptr RTSPMessage00; field: RTSPHeaderField;
    value: cstring): RTSPResult {.
    importc, libprag.}

proc takeHeader*(self: RTSPMessage; field: RTSPHeaderField;
    value: cstring): RTSPResult =
  gst_rtsp_message_take_header(cast[ptr RTSPMessage00](self.impl), field, value)

type
  RTSPUrl00* {.pure.} = object
  RTSPUrl* = ref object
    impl*: ptr RTSPUrl00
    ignoreFinalizer*: bool

proc gst_rtsp_url_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstRTSPUrl*(self: RTSPUrl) =
  if not self.ignoreFinalizer:
    boxedFree(gst_rtsp_url_get_type(), cast[ptr RTSPUrl00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTSPUrl()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_rtsp_url_get_type(), cast[ptr RTSPUrl00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var RTSPUrl) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstRTSPUrl)

proc gst_rtsp_url_free(self: ptr RTSPUrl00) {.
    importc, libprag.}

proc free*(self: RTSPUrl) =
  gst_rtsp_url_free(cast[ptr RTSPUrl00](self.impl))

proc finalizerfree*(self: RTSPUrl) =
  if not self.ignoreFinalizer:
    gst_rtsp_url_free(cast[ptr RTSPUrl00](self.impl))

proc gst_rtsp_url_decode_path_components(self: ptr RTSPUrl00): ptr cstring {.
    importc, libprag.}

proc decodePathComponents*(self: RTSPUrl): seq[string] =
  let resul0 = gst_rtsp_url_decode_path_components(cast[ptr RTSPUrl00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_rtsp_url_copy(self: ptr RTSPUrl00): ptr RTSPUrl00 {.
    importc, libprag.}

proc copy*(self: RTSPUrl): RTSPUrl =
  fnew(result, gBoxedFreeGstRTSPUrl)
  result.impl = gst_rtsp_url_copy(cast[ptr RTSPUrl00](self.impl))

proc gst_rtsp_url_get_port(self: ptr RTSPUrl00; port: var uint16): RTSPResult {.
    importc, libprag.}

proc getPort*(self: RTSPUrl; port: var uint16): RTSPResult =
  gst_rtsp_url_get_port(cast[ptr RTSPUrl00](self.impl), port)

proc gst_rtsp_url_get_request_uri(self: ptr RTSPUrl00): cstring {.
    importc, libprag.}

proc getRequestUri*(self: RTSPUrl): string =
  let resul0 = gst_rtsp_url_get_request_uri(cast[ptr RTSPUrl00](self.impl))
  result = $resul0
  cogfree(resul0)

proc requestUri*(self: RTSPUrl): string =
  let resul0 = gst_rtsp_url_get_request_uri(cast[ptr RTSPUrl00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_rtsp_url_get_request_uri_with_control(self: ptr RTSPUrl00; controlPath: cstring): cstring {.
    importc, libprag.}

proc getRequestUriWithControl*(self: RTSPUrl; controlPath: cstring): string =
  let resul0 = gst_rtsp_url_get_request_uri_with_control(cast[ptr RTSPUrl00](self.impl), controlPath)
  result = $resul0
  cogfree(resul0)

proc gst_rtsp_url_set_port(self: ptr RTSPUrl00; port: uint16): RTSPResult {.
    importc, libprag.}

proc setPort*(self: RTSPUrl; port: uint16): RTSPResult =
  gst_rtsp_url_set_port(cast[ptr RTSPUrl00](self.impl), port)

proc gst_rtsp_url_parse(urlstr: cstring; url: var ptr RTSPUrl00): RTSPResult {.
    importc, libprag.}

proc parse*(urlstr: cstring; url: var RTSPUrl): RTSPResult =
  fnew(url, gBoxedFreeGstRTSPUrl)
  gst_rtsp_url_parse(urlstr, cast[var ptr RTSPUrl00](addr url.impl))

proc gst_rtsp_connection_get_url(self: ptr RTSPConnection00): ptr RTSPUrl00 {.
    importc, libprag.}

proc getUrl*(self: RTSPConnection): RTSPUrl =
  fnew(result, gBoxedFreeGstRTSPUrl)
  result.impl = gst_rtsp_connection_get_url(cast[ptr RTSPConnection00](self.impl))

proc url*(self: RTSPConnection): RTSPUrl =
  fnew(result, gBoxedFreeGstRTSPUrl)
  result.impl = gst_rtsp_connection_get_url(cast[ptr RTSPConnection00](self.impl))

proc gst_rtsp_connection_create(url: ptr RTSPUrl00; conn: var ptr RTSPConnection00): RTSPResult {.
    importc, libprag.}

proc create*(url: RTSPUrl; conn: var RTSPConnection): RTSPResult =
  fnew(conn, finalizerfree)
  gst_rtsp_connection_create(cast[ptr RTSPUrl00](url.impl), cast[var ptr RTSPConnection00](addr conn.impl))

type
  RTSPConnectionAcceptCertificateFunc* = proc (conn: ptr gio.TlsConnection00; peerCert: ptr gio.TlsCertificate00;
    errors: gio.TlsCertificateFlags; userData: pointer): gboolean {.cdecl.}

proc gst_rtsp_connection_set_accept_certificate_func(self: ptr RTSPConnection00;
    `func`: RTSPConnectionAcceptCertificateFunc; userData: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc setAcceptCertificateFunc*(self: RTSPConnection;
    `func`: RTSPConnectionAcceptCertificateFunc; userData: pointer; destroyNotify: DestroyNotify) =
  gst_rtsp_connection_set_accept_certificate_func(cast[ptr RTSPConnection00](self.impl), `func`, userData, destroyNotify)

type
  RTSPExtension00* = object of gobject.Object00
  RTSPExtension* = ref object of gobject.Object

proc scSend*(self: RTSPExtension;  p: proc (self: ptr RTSPExtension00; `object`: pointer; p0: pointer; xdata: pointer): RTSPResult {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "send", cast[GCallback](p), xdata, nil, cf)

proc gst_rtsp_extension_after_send(self: ptr RTSPExtension00; req: ptr RTSPMessage00;
    resp: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc afterSend*(self: RTSPExtension; req: RTSPMessage;
    resp: RTSPMessage): RTSPResult =
  gst_rtsp_extension_after_send(cast[ptr RTSPExtension00](self.impl), cast[ptr RTSPMessage00](req.impl), cast[ptr RTSPMessage00](resp.impl))

proc gst_rtsp_extension_before_send(self: ptr RTSPExtension00; req: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc beforeSend*(self: RTSPExtension; req: RTSPMessage): RTSPResult =
  gst_rtsp_extension_before_send(cast[ptr RTSPExtension00](self.impl), cast[ptr RTSPMessage00](req.impl))

proc gst_rtsp_extension_configure_stream(self: ptr RTSPExtension00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc configureStream*(self: RTSPExtension; caps: gst.Caps): bool =
  toBool(gst_rtsp_extension_configure_stream(cast[ptr RTSPExtension00](self.impl), cast[ptr gst.Caps00](caps.impl)))

proc gst_rtsp_extension_detect_server(self: ptr RTSPExtension00; resp: ptr RTSPMessage00): gboolean {.
    importc, libprag.}

proc detectServer*(self: RTSPExtension; resp: RTSPMessage): bool =
  toBool(gst_rtsp_extension_detect_server(cast[ptr RTSPExtension00](self.impl), cast[ptr RTSPMessage00](resp.impl)))

proc gst_rtsp_extension_parse_sdp(self: ptr RTSPExtension00; sdp: ptr gstsdp.SDPMessage00;
    s: ptr gst.Structure00): RTSPResult {.
    importc, libprag.}

proc parseSdp*(self: RTSPExtension; sdp: gstsdp.SDPMessage;
    s: gst.Structure): RTSPResult =
  gst_rtsp_extension_parse_sdp(cast[ptr RTSPExtension00](self.impl), cast[ptr gstsdp.SDPMessage00](sdp.impl), cast[ptr gst.Structure00](s.impl))

proc gst_rtsp_extension_receive_request(self: ptr RTSPExtension00; req: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc receiveRequest*(self: RTSPExtension; req: RTSPMessage): RTSPResult =
  gst_rtsp_extension_receive_request(cast[ptr RTSPExtension00](self.impl), cast[ptr RTSPMessage00](req.impl))

proc gst_rtsp_extension_send(self: ptr RTSPExtension00; req: ptr RTSPMessage00;
    resp: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc send*(self: RTSPExtension; req: RTSPMessage; resp: RTSPMessage): RTSPResult =
  gst_rtsp_extension_send(cast[ptr RTSPExtension00](self.impl), cast[ptr RTSPMessage00](req.impl), cast[ptr RTSPMessage00](resp.impl))

proc gst_rtsp_extension_setup_media(self: ptr RTSPExtension00; media: ptr gstsdp.SDPMedia00): RTSPResult {.
    importc, libprag.}

proc setupMedia*(self: RTSPExtension; media: gstsdp.SDPMedia): RTSPResult =
  gst_rtsp_extension_setup_media(cast[ptr RTSPExtension00](self.impl), cast[ptr gstsdp.SDPMedia00](media.impl))

proc gst_rtsp_extension_stream_select(self: ptr RTSPExtension00; url: ptr RTSPUrl00): RTSPResult {.
    importc, libprag.}

proc streamSelect*(self: RTSPExtension; url: RTSPUrl): RTSPResult =
  gst_rtsp_extension_stream_select(cast[ptr RTSPExtension00](self.impl), cast[ptr RTSPUrl00](url.impl))

type
  RTSPLowerTrans* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    udp = 1
    udpMcast = 2
    tcp = 4
    http = 16
    tls = 32

proc gst_rtsp_extension_get_transports(self: ptr RTSPExtension00; protocols: RTSPLowerTrans;
    transport: cstring): RTSPResult {.
    importc, libprag.}

proc getTransports*(self: RTSPExtension; protocols: RTSPLowerTrans;
    transport: cstring): RTSPResult =
  gst_rtsp_extension_get_transports(cast[ptr RTSPExtension00](self.impl), protocols, transport)

type
  RTSPFamily* {.size: sizeof(cint), pure.} = enum
    none = 0
    inet = 1
    inet6 = 2

type
  RTSPProfile* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    avp = 1
    savp = 2
    avpf = 4
    savpf = 8

type
  RTSPRange* {.pure, byRef.} = object
    min*: int32
    max*: int32

type
  RTSPRangeUnit* {.size: sizeof(cint), pure.} = enum
    smpte = 0
    smpte_30Drop = 1
    smpte_25 = 2
    npt = 3
    clock = 4

type
  RTSPTimeType* {.size: sizeof(cint), pure.} = enum
    seconds = 0
    now = 1
    `end` = 2
    frames = 3
    utc = 4

type
  RTSPTime* {.pure, byRef.} = object
    `type`*: RTSPTimeType
    seconds*: cdouble

type
  RTSPTime2* {.pure, byRef.} = object
    frames*: cdouble
    year*: uint32
    month*: uint32
    day*: uint32

type
  RTSPTimeRange* {.pure, byRef.} = object
    unit*: RTSPRangeUnit
    min*: RTSPTime
    max*: RTSPTime
    min2*: RTSPTime2
    max2*: RTSPTime2

proc gst_rtsp_range_free(range: RTSPTimeRange) {.
    importc, libprag.}

proc free*(range: RTSPTimeRange) =
  gst_rtsp_range_free(range)

proc gst_rtsp_range_convert_units(range: RTSPTimeRange; unit: RTSPRangeUnit): gboolean {.
    importc, libprag.}

proc convertUnits*(range: RTSPTimeRange; unit: RTSPRangeUnit): bool =
  toBool(gst_rtsp_range_convert_units(range, unit))

proc gst_rtsp_range_get_times(range: RTSPTimeRange; min: var uint64; max: var uint64): gboolean {.
    importc, libprag.}

proc getTimes*(range: RTSPTimeRange; min: var uint64; max: var uint64): bool =
  toBool(gst_rtsp_range_get_times(range, min, max))

proc parse*(rangestr: cstring; range: var RTSPTimeRange): RTSPResult {.
    importc: "gst_rtsp_range_parse", libprag.}

proc gst_rtsp_range_to_string(range: RTSPTimeRange): cstring {.
    importc, libprag.}

proc toString*(range: RTSPTimeRange): string =
  let resul0 = gst_rtsp_range_to_string(range)
  result = $resul0
  cogfree(resul0)

type
  RTSPState* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    init = 1
    ready = 2
    seeking = 3
    playing = 4
    recording = 5

type
  RTSPTransMode* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    rtp = 1
    rdt = 2

type
  RTSPTransport00* {.pure.} = object
  RTSPTransport* = ref object
    impl*: ptr RTSPTransport00
    ignoreFinalizer*: bool

proc gst_rtsp_transport_free(self: ptr RTSPTransport00): RTSPResult {.
    importc, libprag.}

proc free*(self: RTSPTransport): RTSPResult =
  gst_rtsp_transport_free(cast[ptr RTSPTransport00](self.impl))

proc finalizerfree*(self: RTSPTransport) =
  if not self.ignoreFinalizer:
    discard gst_rtsp_transport_free(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTSPTransport()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      discard gst_rtsp_transport_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var RTSPTransport) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_rtsp_transport_as_text(self: ptr RTSPTransport00): cstring {.
    importc, libprag.}

proc asText*(self: RTSPTransport): string =
  let resul0 = gst_rtsp_transport_as_text(cast[ptr RTSPTransport00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_rtsp_transport_get_media_type(self: ptr RTSPTransport00; mediaType: var cstring): RTSPResult {.
    importc, libprag.}

proc getMediaType*(self: RTSPTransport; mediaType: var string): RTSPResult =
  var mediaType_00: cstring
  result = gst_rtsp_transport_get_media_type(cast[ptr RTSPTransport00](self.impl), mediaType_00)
  if mediaType.addr != nil:
    mediaType = $(mediaType_00)

proc gst_rtsp_transport_init(self: ptr RTSPTransport00): RTSPResult {.
    importc, libprag.}

proc init*(self: RTSPTransport): RTSPResult =
  gst_rtsp_transport_init(cast[ptr RTSPTransport00](self.impl))

proc gst_rtsp_transport_get_manager(trans: RTSPTransMode; manager: var cstring;
    option: uint32): RTSPResult {.
    importc, libprag.}

proc getManager*(trans: RTSPTransMode; manager: var string;
    option: int): RTSPResult =
  var manager_00: cstring
  result = gst_rtsp_transport_get_manager(trans, manager_00, uint32(option))
  if manager.addr != nil:
    manager = $(manager_00)

proc getMime*(trans: RTSPTransMode; mime: cstring): RTSPResult {.
    importc: "gst_rtsp_transport_get_mime", libprag.}

proc gst_rtsp_transport_new(transport: ptr RTSPTransport00): RTSPResult {.
    importc, libprag.}

proc new*(transport: RTSPTransport): RTSPResult =
  gst_rtsp_transport_new(cast[ptr RTSPTransport00](transport.impl))

proc gst_rtsp_transport_parse(str: cstring; transport: ptr RTSPTransport00): RTSPResult {.
    importc, libprag.}

proc parse*(str: cstring; transport: RTSPTransport): RTSPResult =
  gst_rtsp_transport_parse(str, cast[ptr RTSPTransport00](transport.impl))

type
  RTSPWatch00* {.pure.} = object
  RTSPWatch* = ref object
    impl*: ptr RTSPWatch00
    ignoreFinalizer*: bool

proc gst_rtsp_watch_unref(self: ptr RTSPWatch00) {.
    importc, libprag.}

proc unref*(self: RTSPWatch) =
  gst_rtsp_watch_unref(cast[ptr RTSPWatch00](self.impl))

proc finalizerunref*(self: RTSPWatch) =
  if not self.ignoreFinalizer:
    gst_rtsp_watch_unref(cast[ptr RTSPWatch00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTSPWatch()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_rtsp_watch_unref(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var RTSPWatch) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerunref)

proc gst_rtsp_watch_get_send_backlog(self: ptr RTSPWatch00; bytes: var uint64;
    messages: var uint32) {.
    importc, libprag.}

proc getSendBacklog*(self: RTSPWatch; bytes: var uint64 = cast[var uint64](nil);
    messages: var int = cast[var int](nil)) =
  var messages_00: uint32
  gst_rtsp_watch_get_send_backlog(cast[ptr RTSPWatch00](self.impl), bytes, messages_00)
  if messages.addr != nil:
    messages = int(messages_00)

proc gst_rtsp_watch_reset(self: ptr RTSPWatch00) {.
    importc, libprag.}

proc reset*(self: RTSPWatch) =
  gst_rtsp_watch_reset(cast[ptr RTSPWatch00](self.impl))

proc gst_rtsp_watch_send_message(self: ptr RTSPWatch00; message: ptr RTSPMessage00;
    id: var uint32): RTSPResult {.
    importc, libprag.}

proc sendMessage*(self: RTSPWatch; message: RTSPMessage; id: var int = cast[var int](nil)): RTSPResult =
  var id_00: uint32
  result = gst_rtsp_watch_send_message(cast[ptr RTSPWatch00](self.impl), cast[ptr RTSPMessage00](message.impl), id_00)
  if id.addr != nil:
    id = int(id_00)

proc gst_rtsp_watch_send_messages(self: ptr RTSPWatch00; messages: ptr RTSPMessage00;
    nMessages: uint32; id: var uint32): RTSPResult {.
    importc, libprag.}

proc sendMessages*(self: RTSPWatch; messages: ptr RTSPMessage00;
    nMessages: int; id: var int = cast[var int](nil)): RTSPResult =
  var id_00: uint32
  result = gst_rtsp_watch_send_messages(cast[ptr RTSPWatch00](self.impl), messages, uint32(nMessages), id_00)
  if id.addr != nil:
    id = int(id_00)

proc gst_rtsp_watch_set_flushing(self: ptr RTSPWatch00; flushing: gboolean) {.
    importc, libprag.}

proc setFlushing*(self: RTSPWatch; flushing: bool = true) =
  gst_rtsp_watch_set_flushing(cast[ptr RTSPWatch00](self.impl), gboolean(flushing))

proc `flushing=`*(self: RTSPWatch; flushing: bool) =
  gst_rtsp_watch_set_flushing(cast[ptr RTSPWatch00](self.impl), gboolean(flushing))

proc gst_rtsp_watch_set_send_backlog(self: ptr RTSPWatch00; bytes: uint64;
    messages: uint32) {.
    importc, libprag.}

proc setSendBacklog*(self: RTSPWatch; bytes: uint64; messages: int) =
  gst_rtsp_watch_set_send_backlog(cast[ptr RTSPWatch00](self.impl), bytes, uint32(messages))

proc gst_rtsp_watch_attach(self: ptr RTSPWatch00; context: ptr glib.MainContext00): uint32 {.
    importc, libprag.}

proc attach*(self: RTSPWatch; context: glib.MainContext): int =
  int(gst_rtsp_watch_attach(cast[ptr RTSPWatch00](self.impl), cast[ptr glib.MainContext00](context.impl)))

proc gst_rtsp_watch_wait_backlog(self: ptr RTSPWatch00; timeout: glib.TimeVal): RTSPResult {.
    importc, libprag.}

proc waitBacklog*(self: RTSPWatch; timeout: glib.TimeVal): RTSPResult =
  gst_rtsp_watch_wait_backlog(cast[ptr RTSPWatch00](self.impl), timeout)

proc gst_rtsp_watch_wait_backlog_usec(self: ptr RTSPWatch00; timeout: int64): RTSPResult {.
    importc, libprag.}

proc waitBacklogUsec*(self: RTSPWatch; timeout: int64): RTSPResult =
  gst_rtsp_watch_wait_backlog_usec(cast[ptr RTSPWatch00](self.impl), timeout)

proc gst_rtsp_watch_write_data(self: ptr RTSPWatch00; data: ptr uint8; size: uint32;
    id: var uint32): RTSPResult {.
    importc, libprag.}

proc writeData*(self: RTSPWatch; data: seq[uint8] | string;
    id: var int = cast[var int](nil)): RTSPResult =
  let size = int(data.len)
  var id_00: uint32
  result = gst_rtsp_watch_write_data(cast[ptr RTSPWatch00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(size), id_00)
  if id.addr != nil:
    id = int(id_00)

type
  RTSPWatchFuncs00* {.pure.} = object
  RTSPWatchFuncs* = ref object
    impl*: ptr RTSPWatchFuncs00
    ignoreFinalizer*: bool

const RTSP_DEFAULT_PORT* = 554'i32

proc gst_rtsp_auth_credentials_free(credentials: ptr RTSPAuthCredential00) {.
    importc, libprag.}

proc rtspAuthCredentialsFree*(credentials: RTSPAuthCredential) =
  gst_rtsp_auth_credentials_free(cast[ptr RTSPAuthCredential00](credentials.impl))

proc rtspFindHeaderField*(header: cstring): RTSPHeaderField {.
    importc: "gst_rtsp_find_header_field", libprag.}

proc rtspFindMethod*(`method`: cstring): RTSPMethod {.
    importc: "gst_rtsp_find_method", libprag.}

proc gst_rtsp_generate_digest_auth_response(algorithm: cstring; `method`: cstring;
    realm: cstring; username: cstring; password: cstring; uri: cstring; nonce: cstring): cstring {.
    importc, libprag.}

proc rtspGenerateDigestAuthResponse*(algorithm: cstring = nil; `method`: cstring;
    realm: cstring; username: cstring; password: cstring; uri: cstring; nonce: cstring): string =
  let resul0 = gst_rtsp_generate_digest_auth_response(algorithm, `method`, realm, username, password, uri, nonce)
  result = $resul0
  cogfree(resul0)

proc gst_rtsp_generate_digest_auth_response_from_md5(algorithm: cstring;
    `method`: cstring; md5: cstring; uri: cstring; nonce: cstring): cstring {.
    importc, libprag.}

proc rtspGenerateDigestAuthResponseFromMd5*(algorithm: cstring = nil;
    `method`: cstring; md5: cstring; uri: cstring; nonce: cstring): string =
  let resul0 = gst_rtsp_generate_digest_auth_response_from_md5(algorithm, `method`, md5, uri, nonce)
  result = $resul0
  cogfree(resul0)

proc gst_rtsp_header_allow_multiple(field: RTSPHeaderField): gboolean {.
    importc, libprag.}

proc rtspHeaderAllowMultiple*(field: RTSPHeaderField): bool =
  toBool(gst_rtsp_header_allow_multiple(field))

proc gst_rtsp_header_as_text(field: RTSPHeaderField): cstring {.
    importc, libprag.}

proc rtspHeaderAsText*(field: RTSPHeaderField): string =
  result = $gst_rtsp_header_as_text(field)

proc gst_rtsp_message_new(msg: var ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc rtspMessageNew*(msg: var RTSPMessage): RTSPResult =
  fnew(msg, gBoxedFreeGstRTSPMessage)
  gst_rtsp_message_new(cast[var ptr RTSPMessage00](addr msg.impl))

proc gst_rtsp_message_new_data(msg: var ptr RTSPMessage00; channel: uint8): RTSPResult {.
    importc, libprag.}

proc rtspMessageNewData*(msg: var RTSPMessage; channel: uint8): RTSPResult =
  fnew(msg, gBoxedFreeGstRTSPMessage)
  gst_rtsp_message_new_data(cast[var ptr RTSPMessage00](addr msg.impl), channel)

proc gst_rtsp_message_new_request(msg: var ptr RTSPMessage00; `method`: RTSPMethod;
    uri: cstring): RTSPResult {.
    importc, libprag.}

proc rtspMessageNewRequest*(msg: var RTSPMessage; `method`: RTSPMethod;
    uri: cstring): RTSPResult =
  fnew(msg, gBoxedFreeGstRTSPMessage)
  gst_rtsp_message_new_request(cast[var ptr RTSPMessage00](addr msg.impl), `method`, uri)

proc gst_rtsp_message_new_response(msg: var ptr RTSPMessage00; code: RTSPStatusCode;
    reason: cstring; request: ptr RTSPMessage00): RTSPResult {.
    importc, libprag.}

proc rtspMessageNewResponse*(msg: var RTSPMessage; code: RTSPStatusCode;
    reason: cstring = nil; request: RTSPMessage = nil): RTSPResult =
  fnew(msg, gBoxedFreeGstRTSPMessage)
  gst_rtsp_message_new_response(cast[var ptr RTSPMessage00](addr msg.impl), code, reason, if request.isNil: nil else: cast[ptr RTSPMessage00](request.impl))

proc gst_rtsp_options_as_text(options: RTSPMethod): cstring {.
    importc, libprag.}

proc rtspOptionsAsText*(options: RTSPMethod): string =
  let resul0 = gst_rtsp_options_as_text(options)
  result = $resul0
  cogfree(resul0)

proc rtspOptionsFromText*(options: cstring): RTSPMethod {.
    importc: "gst_rtsp_options_from_text", libprag.}

proc gst_rtsp_status_as_text(code: RTSPStatusCode): cstring {.
    importc, libprag.}

proc rtspStatusAsText*(code: RTSPStatusCode): string =
  result = $gst_rtsp_status_as_text(code)

proc gst_rtsp_strresult(resu: RTSPResult): cstring {.
    importc, libprag.}

proc rtspStrresult*(resu: RTSPResult): string =
  let resul0 = gst_rtsp_strresult(resu)
  result = $resul0
  cogfree(resul0)
# === remaining symbols:
