# dependencies:
# xlib-2.0
# GdkPixbuf-2.0
# GLib-2.0
# Soup-2.4
# JavaScriptCore-4.0
# HarfBuzz-0.0
# Gtk-3.0
# cairo-1.0
# GObject-2.0
# Gdk-3.0
# Gio-2.0
# GModule-2.0
# Pango-1.0
# Atk-1.0
# immediate dependencies:
# Soup-2.4
# JavaScriptCore-4.0
# Gtk-3.0
# GObject-2.0
# libraries:
# libwebkit2gtk-4.0.so.37,libjavascriptcoregtk-4.0.so.18
{.warning[UnusedImport]: off.}
import xlib, gdkpixbuf, glib, soup, javascriptcore, harfbuzz, gtk, cairo, gobject, gdk, gio, gmodule, pango, atk
const Lib = "libwebkit2gtk-4.0.so.37"
{.pragma: libprag, cdecl, dynlib: Lib.}
from atk import ImplementorIface


proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  ApplicationInfo00* {.pure.} = object
  ApplicationInfo* = ref object
    impl*: ptr ApplicationInfo00
    ignoreFinalizer*: bool

proc webkit_application_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitApplicationInfo*(self: ApplicationInfo) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_application_info_get_type(), cast[ptr ApplicationInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ApplicationInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_application_info_get_type(), cast[ptr ApplicationInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ApplicationInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitApplicationInfo)

proc webkit_application_info_unref(self: ptr ApplicationInfo00) {.
    importc, libprag.}

proc unref*(self: ApplicationInfo) =
  webkit_application_info_unref(cast[ptr ApplicationInfo00](self.impl))

proc finalizerunref*(self: ApplicationInfo) =
  if not self.ignoreFinalizer:
    webkit_application_info_unref(cast[ptr ApplicationInfo00](self.impl))

proc webkit_application_info_get_name(self: ptr ApplicationInfo00): cstring {.
    importc, libprag.}

proc getName*(self: ApplicationInfo): string =
  result = $webkit_application_info_get_name(cast[ptr ApplicationInfo00](self.impl))

proc name*(self: ApplicationInfo): string =
  result = $webkit_application_info_get_name(cast[ptr ApplicationInfo00](self.impl))

proc webkit_application_info_get_version(self: ptr ApplicationInfo00; major: var uint64;
    minor: var uint64; micro: var uint64) {.
    importc, libprag.}

proc getVersion*(self: ApplicationInfo; major: var uint64;
    minor: var uint64 = cast[var uint64](nil); micro: var uint64 = cast[var uint64](nil)) =
  webkit_application_info_get_version(cast[ptr ApplicationInfo00](self.impl), major, minor, micro)

proc webkit_application_info_ref(self: ptr ApplicationInfo00): ptr ApplicationInfo00 {.
    importc, libprag.}

proc `ref`*(self: ApplicationInfo): ApplicationInfo =
  fnew(result, gBoxedFreeWebKitApplicationInfo)
  result.impl = webkit_application_info_ref(cast[ptr ApplicationInfo00](self.impl))

proc webkit_application_info_set_name(self: ptr ApplicationInfo00; name: cstring) {.
    importc, libprag.}

proc setName*(self: ApplicationInfo; name: cstring) =
  webkit_application_info_set_name(cast[ptr ApplicationInfo00](self.impl), name)

proc `name=`*(self: ApplicationInfo; name: cstring) =
  webkit_application_info_set_name(cast[ptr ApplicationInfo00](self.impl), name)

proc webkit_application_info_set_version(self: ptr ApplicationInfo00; major: uint64;
    minor: uint64; micro: uint64) {.
    importc, libprag.}

proc setVersion*(self: ApplicationInfo; major: uint64;
    minor: uint64; micro: uint64) =
  webkit_application_info_set_version(cast[ptr ApplicationInfo00](self.impl), major, minor, micro)

proc webkit_application_info_new(): ptr ApplicationInfo00 {.
    importc, libprag.}

proc newApplicationInfo*(): ApplicationInfo =
  fnew(result, gBoxedFreeWebKitApplicationInfo)
  result.impl = webkit_application_info_new()

proc newApplicationInfo*(tdesc: typedesc): tdesc =
  assert(result is ApplicationInfo)
  fnew(result, gBoxedFreeWebKitApplicationInfo)
  result.impl = webkit_application_info_new()

proc initApplicationInfo*[T](result: var T) {.deprecated.} =
  assert(result is ApplicationInfo)
  fnew(result, gBoxedFreeWebKitApplicationInfo)
  result.impl = webkit_application_info_new()

type
  Credential00* {.pure.} = object
  Credential* = ref object
    impl*: ptr Credential00
    ignoreFinalizer*: bool

proc webkit_credential_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitCredential*(self: Credential) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_credential_get_type(), cast[ptr Credential00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Credential()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_credential_get_type(), cast[ptr Credential00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Credential) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitCredential)

proc webkit_credential_free(self: ptr Credential00) {.
    importc, libprag.}

proc free*(self: Credential) =
  webkit_credential_free(cast[ptr Credential00](self.impl))

proc finalizerfree*(self: Credential) =
  if not self.ignoreFinalizer:
    webkit_credential_free(cast[ptr Credential00](self.impl))

proc webkit_credential_copy(self: ptr Credential00): ptr Credential00 {.
    importc, libprag.}

proc copy*(self: Credential): Credential =
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_copy(cast[ptr Credential00](self.impl))

proc webkit_credential_get_certificate(self: ptr Credential00): ptr gio.TlsCertificate00 {.
    importc, libprag.}

proc getCertificate*(self: Credential): gio.TlsCertificate =
  let gobj = webkit_credential_get_certificate(cast[ptr Credential00](self.impl))
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

proc certificate*(self: Credential): gio.TlsCertificate =
  let gobj = webkit_credential_get_certificate(cast[ptr Credential00](self.impl))
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

proc webkit_credential_get_password(self: ptr Credential00): cstring {.
    importc, libprag.}

proc getPassword*(self: Credential): string =
  result = $webkit_credential_get_password(cast[ptr Credential00](self.impl))

proc password*(self: Credential): string =
  result = $webkit_credential_get_password(cast[ptr Credential00](self.impl))

proc webkit_credential_get_username(self: ptr Credential00): cstring {.
    importc, libprag.}

proc getUsername*(self: Credential): string =
  result = $webkit_credential_get_username(cast[ptr Credential00](self.impl))

proc username*(self: Credential): string =
  result = $webkit_credential_get_username(cast[ptr Credential00](self.impl))

proc webkit_credential_has_password(self: ptr Credential00): gboolean {.
    importc, libprag.}

proc hasPassword*(self: Credential): bool =
  toBool(webkit_credential_has_password(cast[ptr Credential00](self.impl)))

type
  AuthenticationRequest* = ref object of gobject.Object
  AuthenticationRequest00* = object of gobject.Object00

proc webkit_authentication_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthenticationRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAuthenticated*(self: AuthenticationRequest;  p: proc (self: ptr AuthenticationRequest00; credential: ptr Credential00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "authenticated", cast[GCallback](p), xdata, nil, cf)

proc scCancelled*(self: AuthenticationRequest;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "cancelled", cast[GCallback](p), xdata, nil, cf)

proc webkit_authentication_request_authenticate(self: ptr AuthenticationRequest00;
    credential: ptr Credential00) {.
    importc, libprag.}

proc authenticate*(self: AuthenticationRequest;
    credential: Credential = nil) =
  webkit_authentication_request_authenticate(cast[ptr AuthenticationRequest00](self.impl), if credential.isNil: nil else: cast[ptr Credential00](credential.impl))

proc webkit_authentication_request_can_save_credentials(self: ptr AuthenticationRequest00): gboolean {.
    importc, libprag.}

proc canSaveCredentials*(self: AuthenticationRequest): bool =
  toBool(webkit_authentication_request_can_save_credentials(cast[ptr AuthenticationRequest00](self.impl)))

proc webkit_authentication_request_cancel(self: ptr AuthenticationRequest00) {.
    importc, libprag.}

proc cancel*(self: AuthenticationRequest) =
  webkit_authentication_request_cancel(cast[ptr AuthenticationRequest00](self.impl))

proc webkit_authentication_request_get_certificate_pin_flags(self: ptr AuthenticationRequest00): gio.TlsPasswordFlags {.
    importc, libprag.}

proc getCertificatePinFlags*(self: AuthenticationRequest): gio.TlsPasswordFlags =
  webkit_authentication_request_get_certificate_pin_flags(cast[ptr AuthenticationRequest00](self.impl))

proc certificatePinFlags*(self: AuthenticationRequest): gio.TlsPasswordFlags =
  webkit_authentication_request_get_certificate_pin_flags(cast[ptr AuthenticationRequest00](self.impl))

proc webkit_authentication_request_get_host(self: ptr AuthenticationRequest00): cstring {.
    importc, libprag.}

proc getHost*(self: AuthenticationRequest): string =
  result = $webkit_authentication_request_get_host(cast[ptr AuthenticationRequest00](self.impl))

proc host*(self: AuthenticationRequest): string =
  result = $webkit_authentication_request_get_host(cast[ptr AuthenticationRequest00](self.impl))

proc webkit_authentication_request_get_port(self: ptr AuthenticationRequest00): uint32 {.
    importc, libprag.}

proc getPort*(self: AuthenticationRequest): int =
  int(webkit_authentication_request_get_port(cast[ptr AuthenticationRequest00](self.impl)))

proc port*(self: AuthenticationRequest): int =
  int(webkit_authentication_request_get_port(cast[ptr AuthenticationRequest00](self.impl)))

proc webkit_authentication_request_get_proposed_credential(self: ptr AuthenticationRequest00): ptr Credential00 {.
    importc, libprag.}

proc getProposedCredential*(self: AuthenticationRequest): Credential =
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_authentication_request_get_proposed_credential(cast[ptr AuthenticationRequest00](self.impl))

proc proposedCredential*(self: AuthenticationRequest): Credential =
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_authentication_request_get_proposed_credential(cast[ptr AuthenticationRequest00](self.impl))

proc webkit_authentication_request_get_realm(self: ptr AuthenticationRequest00): cstring {.
    importc, libprag.}

proc getRealm*(self: AuthenticationRequest): string =
  result = $webkit_authentication_request_get_realm(cast[ptr AuthenticationRequest00](self.impl))

proc realm*(self: AuthenticationRequest): string =
  result = $webkit_authentication_request_get_realm(cast[ptr AuthenticationRequest00](self.impl))

proc webkit_authentication_request_is_for_proxy(self: ptr AuthenticationRequest00): gboolean {.
    importc, libprag.}

proc isForProxy*(self: AuthenticationRequest): bool =
  toBool(webkit_authentication_request_is_for_proxy(cast[ptr AuthenticationRequest00](self.impl)))

proc webkit_authentication_request_is_retry(self: ptr AuthenticationRequest00): gboolean {.
    importc, libprag.}

proc isRetry*(self: AuthenticationRequest): bool =
  toBool(webkit_authentication_request_is_retry(cast[ptr AuthenticationRequest00](self.impl)))

proc webkit_authentication_request_set_can_save_credentials(self: ptr AuthenticationRequest00;
    enabled: gboolean) {.
    importc, libprag.}

proc setCanSaveCredentials*(self: AuthenticationRequest;
    enabled: bool = true) =
  webkit_authentication_request_set_can_save_credentials(cast[ptr AuthenticationRequest00](self.impl), gboolean(enabled))

proc `canSaveCredentials=`*(self: AuthenticationRequest;
    enabled: bool) =
  webkit_authentication_request_set_can_save_credentials(cast[ptr AuthenticationRequest00](self.impl), gboolean(enabled))

proc webkit_authentication_request_set_proposed_credential(self: ptr AuthenticationRequest00;
    credential: ptr Credential00) {.
    importc, libprag.}

proc setProposedCredential*(self: AuthenticationRequest;
    credential: Credential) =
  webkit_authentication_request_set_proposed_credential(cast[ptr AuthenticationRequest00](self.impl), cast[ptr Credential00](credential.impl))

proc `proposedCredential=`*(self: AuthenticationRequest;
    credential: Credential) =
  webkit_authentication_request_set_proposed_credential(cast[ptr AuthenticationRequest00](self.impl), cast[ptr Credential00](credential.impl))

type
  CredentialPersistence* {.size: sizeof(cint), pure.} = enum
    none = 0
    forSession = 1
    permanent = 2

proc webkit_credential_new_for_certificate(certificate: ptr gio.TlsCertificate00;
    persistence: CredentialPersistence): ptr Credential00 {.
    importc, libprag.}

proc newCredentialForCertificate*(certificate: gio.TlsCertificate = nil;
    persistence: CredentialPersistence): Credential =
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new_for_certificate(if certificate.isNil: nil else: cast[ptr gio.TlsCertificate00](certificate.impl), persistence)

proc newCredentialForCertificate*(tdesc: typedesc; certificate: gio.TlsCertificate = nil;
    persistence: CredentialPersistence): tdesc =
  assert(result is Credential)
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new_for_certificate(if certificate.isNil: nil else: cast[ptr gio.TlsCertificate00](certificate.impl), persistence)

proc initCredentialForCertificate*[T](result: var T; certificate: gio.TlsCertificate = nil;
    persistence: CredentialPersistence) {.deprecated.} =
  assert(result is Credential)
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new_for_certificate(if certificate.isNil: nil else: cast[ptr gio.TlsCertificate00](certificate.impl), persistence)

proc webkit_credential_new_for_certificate_pin(pin: cstring; persistence: CredentialPersistence): ptr Credential00 {.
    importc, libprag.}

proc newCredentialForCertificatePin*(pin: cstring; persistence: CredentialPersistence): Credential =
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new_for_certificate_pin(pin, persistence)

proc newCredentialForCertificatePin*(tdesc: typedesc; pin: cstring; persistence: CredentialPersistence): tdesc =
  assert(result is Credential)
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new_for_certificate_pin(pin, persistence)

proc initCredentialForCertificatePin*[T](result: var T; pin: cstring; persistence: CredentialPersistence) {.deprecated.} =
  assert(result is Credential)
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new_for_certificate_pin(pin, persistence)

proc webkit_credential_new(username: cstring; password: cstring; persistence: CredentialPersistence): ptr Credential00 {.
    importc, libprag.}

proc newCredential*(username: cstring; password: cstring; persistence: CredentialPersistence): Credential =
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new(username, password, persistence)

proc newCredential*(tdesc: typedesc; username: cstring; password: cstring; persistence: CredentialPersistence): tdesc =
  assert(result is Credential)
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new(username, password, persistence)

proc initCredential*[T](result: var T; username: cstring; password: cstring; persistence: CredentialPersistence) {.deprecated.} =
  assert(result is Credential)
  fnew(result, gBoxedFreeWebKitCredential)
  result.impl = webkit_credential_new(username, password, persistence)

proc webkit_credential_get_persistence(self: ptr Credential00): CredentialPersistence {.
    importc, libprag.}

proc getPersistence*(self: Credential): CredentialPersistence =
  webkit_credential_get_persistence(cast[ptr Credential00](self.impl))

proc persistence*(self: Credential): CredentialPersistence =
  webkit_credential_get_persistence(cast[ptr Credential00](self.impl))

type
  AuthenticationScheme* {.size: sizeof(cint), pure.} = enum
    default = 1
    httpBasic = 2
    httpDigest = 3
    htmlForm = 4
    ntlm = 5
    negotiate = 6
    clientCertificateRequested = 7
    serverTrustEvaluationRequested = 8
    clientCertificatePinRequested = 9
    unknown = 100

proc webkit_authentication_request_get_scheme(self: ptr AuthenticationRequest00): AuthenticationScheme {.
    importc, libprag.}

proc getScheme*(self: AuthenticationRequest): AuthenticationScheme =
  webkit_authentication_request_get_scheme(cast[ptr AuthenticationRequest00](self.impl))

proc scheme*(self: AuthenticationRequest): AuthenticationScheme =
  webkit_authentication_request_get_scheme(cast[ptr AuthenticationRequest00](self.impl))

type
  SecurityOrigin00* {.pure.} = object
  SecurityOrigin* = ref object
    impl*: ptr SecurityOrigin00
    ignoreFinalizer*: bool

proc webkit_security_origin_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitSecurityOrigin*(self: SecurityOrigin) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_security_origin_get_type(), cast[ptr SecurityOrigin00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SecurityOrigin()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_security_origin_get_type(), cast[ptr SecurityOrigin00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SecurityOrigin) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitSecurityOrigin)

proc webkit_security_origin_unref(self: ptr SecurityOrigin00) {.
    importc, libprag.}

proc unref*(self: SecurityOrigin) =
  webkit_security_origin_unref(cast[ptr SecurityOrigin00](self.impl))

proc finalizerunref*(self: SecurityOrigin) =
  if not self.ignoreFinalizer:
    webkit_security_origin_unref(cast[ptr SecurityOrigin00](self.impl))

proc webkit_security_origin_new_for_uri(uri: cstring): ptr SecurityOrigin00 {.
    importc, libprag.}

proc newSecurityOriginForUri*(uri: cstring): SecurityOrigin =
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_security_origin_new_for_uri(uri)

proc newSecurityOriginForUri*(tdesc: typedesc; uri: cstring): tdesc =
  assert(result is SecurityOrigin)
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_security_origin_new_for_uri(uri)

proc initSecurityOriginForUri*[T](result: var T; uri: cstring) {.deprecated.} =
  assert(result is SecurityOrigin)
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_security_origin_new_for_uri(uri)

proc webkit_security_origin_get_host(self: ptr SecurityOrigin00): cstring {.
    importc, libprag.}

proc getHost*(self: SecurityOrigin): string =
  let resul0 = webkit_security_origin_get_host(cast[ptr SecurityOrigin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc host*(self: SecurityOrigin): string =
  let resul0 = webkit_security_origin_get_host(cast[ptr SecurityOrigin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_security_origin_get_port(self: ptr SecurityOrigin00): uint16 {.
    importc, libprag.}

proc getPort*(self: SecurityOrigin): uint16 =
  webkit_security_origin_get_port(cast[ptr SecurityOrigin00](self.impl))

proc port*(self: SecurityOrigin): uint16 =
  webkit_security_origin_get_port(cast[ptr SecurityOrigin00](self.impl))

proc webkit_security_origin_get_protocol(self: ptr SecurityOrigin00): cstring {.
    importc, libprag.}

proc getProtocol*(self: SecurityOrigin): string =
  let resul0 = webkit_security_origin_get_protocol(cast[ptr SecurityOrigin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc protocol*(self: SecurityOrigin): string =
  let resul0 = webkit_security_origin_get_protocol(cast[ptr SecurityOrigin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_security_origin_is_opaque(self: ptr SecurityOrigin00): gboolean {.
    importc, libprag.}

proc isOpaque*(self: SecurityOrigin): bool =
  toBool(webkit_security_origin_is_opaque(cast[ptr SecurityOrigin00](self.impl)))

proc webkit_security_origin_ref(self: ptr SecurityOrigin00): ptr SecurityOrigin00 {.
    importc, libprag.}

proc `ref`*(self: SecurityOrigin): SecurityOrigin =
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_security_origin_ref(cast[ptr SecurityOrigin00](self.impl))

proc webkit_security_origin_to_string(self: ptr SecurityOrigin00): cstring {.
    importc, libprag.}

proc toString*(self: SecurityOrigin): string =
  let resul0 = webkit_security_origin_to_string(cast[ptr SecurityOrigin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc webkit_security_origin_new(protocol: cstring; host: cstring; port: uint16): ptr SecurityOrigin00 {.
    importc, libprag.}

proc newSecurityOrigin*(protocol: cstring; host: cstring; port: uint16): SecurityOrigin =
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_security_origin_new(protocol, host, port)

proc newSecurityOrigin*(tdesc: typedesc; protocol: cstring; host: cstring; port: uint16): tdesc =
  assert(result is SecurityOrigin)
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_security_origin_new(protocol, host, port)

proc initSecurityOrigin*[T](result: var T; protocol: cstring; host: cstring; port: uint16) {.deprecated.} =
  assert(result is SecurityOrigin)
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_security_origin_new(protocol, host, port)

proc webkit_authentication_request_get_security_origin(self: ptr AuthenticationRequest00): ptr SecurityOrigin00 {.
    importc, libprag.}

proc getSecurityOrigin*(self: AuthenticationRequest): SecurityOrigin =
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_authentication_request_get_security_origin(cast[ptr AuthenticationRequest00](self.impl))

proc securityOrigin*(self: AuthenticationRequest): SecurityOrigin =
  fnew(result, gBoxedFreeWebKitSecurityOrigin)
  result.impl = webkit_authentication_request_get_security_origin(cast[ptr AuthenticationRequest00](self.impl))

type
  AutomationBrowsingContextPresentation* {.size: sizeof(cint), pure.} = enum
    window = 0
    tab = 1

type
  WebViewBase* = ref object of gtk.Container
  WebViewBase00* = object of gtk.Container00

proc webkit_web_view_base_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebViewBase()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  ContextMenu* = ref object of gobject.Object
  ContextMenu00* = object of gobject.Object00

proc webkit_context_menu_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContextMenu()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_context_menu_new(): ptr ContextMenu00 {.
    importc, libprag.}

proc newContextMenu*(): ContextMenu =
  let gobj = webkit_context_menu_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenu*(tdesc: typedesc): tdesc =
  assert(result is ContextMenu)
  let gobj = webkit_context_menu_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenu*[T](result: var T) {.deprecated.} =
  assert(result is ContextMenu)
  let gobj = webkit_context_menu_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_get_n_items(self: ptr ContextMenu00): uint32 {.
    importc, libprag.}

proc getNItems*(self: ContextMenu): int =
  int(webkit_context_menu_get_n_items(cast[ptr ContextMenu00](self.impl)))

proc nItems*(self: ContextMenu): int =
  int(webkit_context_menu_get_n_items(cast[ptr ContextMenu00](self.impl)))

proc webkit_context_menu_get_user_data(self: ptr ContextMenu00): ptr glib.Variant00 {.
    importc, libprag.}

proc getUserData*(self: ContextMenu): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = webkit_context_menu_get_user_data(cast[ptr ContextMenu00](self.impl))
  result.ignoreFinalizer = true # GVariant

proc userData*(self: ContextMenu): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = webkit_context_menu_get_user_data(cast[ptr ContextMenu00](self.impl))
  result.ignoreFinalizer = true # GVariant

proc webkit_context_menu_remove_all(self: ptr ContextMenu00) {.
    importc, libprag.}

proc removeAll*(self: ContextMenu) =
  webkit_context_menu_remove_all(cast[ptr ContextMenu00](self.impl))

proc webkit_context_menu_set_user_data(self: ptr ContextMenu00; userData: ptr glib.Variant00) {.
    importc, libprag.}

proc setUserData*(self: ContextMenu; userData: glib.Variant) =
  webkit_context_menu_set_user_data(cast[ptr ContextMenu00](self.impl), cast[ptr glib.Variant00](userData.impl))

proc `userData=`*(self: ContextMenu; userData: glib.Variant) =
  webkit_context_menu_set_user_data(cast[ptr ContextMenu00](self.impl), cast[ptr glib.Variant00](userData.impl))

type
  HitTestResult* = ref object of gobject.Object
  HitTestResult00* = object of gobject.Object00

proc webkit_hit_test_result_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HitTestResult()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_hit_test_result_context_is_editable(self: ptr HitTestResult00): gboolean {.
    importc, libprag.}

proc contextIsEditable*(self: HitTestResult): bool =
  toBool(webkit_hit_test_result_context_is_editable(cast[ptr HitTestResult00](self.impl)))

proc webkit_hit_test_result_context_is_image(self: ptr HitTestResult00): gboolean {.
    importc, libprag.}

proc contextIsImage*(self: HitTestResult): bool =
  toBool(webkit_hit_test_result_context_is_image(cast[ptr HitTestResult00](self.impl)))

proc webkit_hit_test_result_context_is_link(self: ptr HitTestResult00): gboolean {.
    importc, libprag.}

proc contextIsLink*(self: HitTestResult): bool =
  toBool(webkit_hit_test_result_context_is_link(cast[ptr HitTestResult00](self.impl)))

proc webkit_hit_test_result_context_is_media(self: ptr HitTestResult00): gboolean {.
    importc, libprag.}

proc contextIsMedia*(self: HitTestResult): bool =
  toBool(webkit_hit_test_result_context_is_media(cast[ptr HitTestResult00](self.impl)))

proc webkit_hit_test_result_context_is_scrollbar(self: ptr HitTestResult00): gboolean {.
    importc, libprag.}

proc contextIsScrollbar*(self: HitTestResult): bool =
  toBool(webkit_hit_test_result_context_is_scrollbar(cast[ptr HitTestResult00](self.impl)))

proc webkit_hit_test_result_context_is_selection(self: ptr HitTestResult00): gboolean {.
    importc, libprag.}

proc contextIsSelection*(self: HitTestResult): bool =
  toBool(webkit_hit_test_result_context_is_selection(cast[ptr HitTestResult00](self.impl)))

proc webkit_hit_test_result_get_context(self: ptr HitTestResult00): uint32 {.
    importc, libprag.}

proc getContext*(self: HitTestResult): int =
  int(webkit_hit_test_result_get_context(cast[ptr HitTestResult00](self.impl)))

proc context*(self: HitTestResult): int =
  int(webkit_hit_test_result_get_context(cast[ptr HitTestResult00](self.impl)))

proc webkit_hit_test_result_get_image_uri(self: ptr HitTestResult00): cstring {.
    importc, libprag.}

proc getImageUri*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_image_uri(cast[ptr HitTestResult00](self.impl))

proc imageUri*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_image_uri(cast[ptr HitTestResult00](self.impl))

proc webkit_hit_test_result_get_link_label(self: ptr HitTestResult00): cstring {.
    importc, libprag.}

proc getLinkLabel*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_link_label(cast[ptr HitTestResult00](self.impl))

proc linkLabel*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_link_label(cast[ptr HitTestResult00](self.impl))

proc webkit_hit_test_result_get_link_title(self: ptr HitTestResult00): cstring {.
    importc, libprag.}

proc getLinkTitle*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_link_title(cast[ptr HitTestResult00](self.impl))

proc linkTitle*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_link_title(cast[ptr HitTestResult00](self.impl))

proc webkit_hit_test_result_get_link_uri(self: ptr HitTestResult00): cstring {.
    importc, libprag.}

proc getLinkUri*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_link_uri(cast[ptr HitTestResult00](self.impl))

proc linkUri*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_link_uri(cast[ptr HitTestResult00](self.impl))

proc webkit_hit_test_result_get_media_uri(self: ptr HitTestResult00): cstring {.
    importc, libprag.}

proc getMediaUri*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_media_uri(cast[ptr HitTestResult00](self.impl))

proc mediaUri*(self: HitTestResult): string =
  result = $webkit_hit_test_result_get_media_uri(cast[ptr HitTestResult00](self.impl))

type
  NavigationAction00* {.pure.} = object
  NavigationAction* = ref object
    impl*: ptr NavigationAction00
    ignoreFinalizer*: bool

proc webkit_navigation_action_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitNavigationAction*(self: NavigationAction) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_navigation_action_get_type(), cast[ptr NavigationAction00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NavigationAction()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_navigation_action_get_type(), cast[ptr NavigationAction00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var NavigationAction) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitNavigationAction)

proc webkit_navigation_action_free(self: ptr NavigationAction00) {.
    importc, libprag.}

proc free*(self: NavigationAction) =
  webkit_navigation_action_free(cast[ptr NavigationAction00](self.impl))

proc finalizerfree*(self: NavigationAction) =
  if not self.ignoreFinalizer:
    webkit_navigation_action_free(cast[ptr NavigationAction00](self.impl))

proc webkit_navigation_action_copy(self: ptr NavigationAction00): ptr NavigationAction00 {.
    importc, libprag.}

proc copy*(self: NavigationAction): NavigationAction =
  fnew(result, gBoxedFreeWebKitNavigationAction)
  result.impl = webkit_navigation_action_copy(cast[ptr NavigationAction00](self.impl))

proc webkit_navigation_action_get_modifiers(self: ptr NavigationAction00): uint32 {.
    importc, libprag.}

proc getModifiers*(self: NavigationAction): int =
  int(webkit_navigation_action_get_modifiers(cast[ptr NavigationAction00](self.impl)))

proc modifiers*(self: NavigationAction): int =
  int(webkit_navigation_action_get_modifiers(cast[ptr NavigationAction00](self.impl)))

proc webkit_navigation_action_get_mouse_button(self: ptr NavigationAction00): uint32 {.
    importc, libprag.}

proc getMouseButton*(self: NavigationAction): int =
  int(webkit_navigation_action_get_mouse_button(cast[ptr NavigationAction00](self.impl)))

proc mouseButton*(self: NavigationAction): int =
  int(webkit_navigation_action_get_mouse_button(cast[ptr NavigationAction00](self.impl)))

proc webkit_navigation_action_is_redirect(self: ptr NavigationAction00): gboolean {.
    importc, libprag.}

proc isRedirect*(self: NavigationAction): bool =
  toBool(webkit_navigation_action_is_redirect(cast[ptr NavigationAction00](self.impl)))

proc webkit_navigation_action_is_user_gesture(self: ptr NavigationAction00): gboolean {.
    importc, libprag.}

proc isUserGesture*(self: NavigationAction): bool =
  toBool(webkit_navigation_action_is_user_gesture(cast[ptr NavigationAction00](self.impl)))

type
  PolicyDecision* = ref object of gobject.Object
  PolicyDecision00* = object of gobject.Object00

proc webkit_policy_decision_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PolicyDecision()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_policy_decision_download(self: ptr PolicyDecision00) {.
    importc, libprag.}

proc download*(self: PolicyDecision) =
  webkit_policy_decision_download(cast[ptr PolicyDecision00](self.impl))

proc webkit_policy_decision_ignore(self: ptr PolicyDecision00) {.
    importc, libprag.}

proc ignore*(self: PolicyDecision) =
  webkit_policy_decision_ignore(cast[ptr PolicyDecision00](self.impl))

proc webkit_policy_decision_use(self: ptr PolicyDecision00) {.
    importc, libprag.}

proc use*(self: PolicyDecision) =
  webkit_policy_decision_use(cast[ptr PolicyDecision00](self.impl))

type
  PolicyDecisionType* {.size: sizeof(cint), pure.} = enum
    navigationAction = 0
    newWindowAction = 1
    response = 2

type
  InsecureContentEvent* {.size: sizeof(cint), pure.} = enum
    run = 0
    displayed = 1

type
  LoadEvent* {.size: sizeof(cint), pure.} = enum
    started = 0
    redirected = 1
    committed = 2
    finished = 3

type
  PermissionRequest00* = object of gobject.Object00
  PermissionRequest* = ref object of gobject.Object

type
  PrintCustomWidget* = ref object of gobject.Object
  PrintCustomWidget00* = object of gobject.Object00

proc webkit_print_custom_widget_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PrintCustomWidget()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scApply*(self: PrintCustomWidget;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "apply", cast[GCallback](p), xdata, nil, cf)

proc scUpdate*(self: PrintCustomWidget;  p: proc (self: ptr PrintCustomWidget00; pageSetup: ptr gtk.PageSetup00; printSettings: ptr gtk.PrintSettings00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "update", cast[GCallback](p), xdata, nil, cf)

proc webkit_print_custom_widget_new(widget: ptr gtk.Widget00; title: cstring): ptr PrintCustomWidget00 {.
    importc, libprag.}

proc newPrintCustomWidget*(widget: gtk.Widget; title: cstring): PrintCustomWidget =
  let gobj = webkit_print_custom_widget_new(cast[ptr gtk.Widget00](widget.impl), title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPrintCustomWidget*(tdesc: typedesc; widget: gtk.Widget; title: cstring): tdesc =
  assert(result is PrintCustomWidget)
  let gobj = webkit_print_custom_widget_new(cast[ptr gtk.Widget00](widget.impl), title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPrintCustomWidget*[T](result: var T; widget: gtk.Widget; title: cstring) {.deprecated.} =
  assert(result is PrintCustomWidget)
  let gobj = webkit_print_custom_widget_new(cast[ptr gtk.Widget00](widget.impl), title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_print_custom_widget_get_title(self: ptr PrintCustomWidget00): cstring {.
    importc, libprag.}

proc getTitle*(self: PrintCustomWidget): string =
  result = $webkit_print_custom_widget_get_title(cast[ptr PrintCustomWidget00](self.impl))

proc title*(self: PrintCustomWidget): string =
  result = $webkit_print_custom_widget_get_title(cast[ptr PrintCustomWidget00](self.impl))

proc webkit_print_custom_widget_get_widget(self: ptr PrintCustomWidget00): ptr gtk.Widget00 {.
    importc, libprag.}

proc getWidget*(self: PrintCustomWidget): gtk.Widget =
  let gobj = webkit_print_custom_widget_get_widget(cast[ptr PrintCustomWidget00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc widget*(self: PrintCustomWidget): gtk.Widget =
  let gobj = webkit_print_custom_widget_get_widget(cast[ptr PrintCustomWidget00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PrintOperation* = ref object of gobject.Object
  PrintOperation00* = object of gobject.Object00

proc webkit_print_operation_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PrintOperation()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCreateCustomWidget*(self: PrintOperation;  p: proc (self: ptr PrintOperation00; xdata: pointer): PrintCustomWidget00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create-custom-widget", cast[GCallback](p), xdata, nil, cf)

proc scFailed*(self: PrintOperation;  p: proc (self: ptr PrintOperation00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "failed", cast[GCallback](p), xdata, nil, cf)

proc scFinished*(self: PrintOperation;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc webkit_print_operation_get_page_setup(self: ptr PrintOperation00): ptr gtk.PageSetup00 {.
    importc, libprag.}

proc getPageSetup*(self: PrintOperation): gtk.PageSetup =
  let gobj = webkit_print_operation_get_page_setup(cast[ptr PrintOperation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pageSetup*(self: PrintOperation): gtk.PageSetup =
  let gobj = webkit_print_operation_get_page_setup(cast[ptr PrintOperation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_print_operation_get_print_settings(self: ptr PrintOperation00): ptr gtk.PrintSettings00 {.
    importc, libprag.}

proc getPrintSettings*(self: PrintOperation): gtk.PrintSettings =
  let gobj = webkit_print_operation_get_print_settings(cast[ptr PrintOperation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc printSettings*(self: PrintOperation): gtk.PrintSettings =
  let gobj = webkit_print_operation_get_print_settings(cast[ptr PrintOperation00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_print_operation_print(self: ptr PrintOperation00) {.
    importc, libprag.}

proc print*(self: PrintOperation) =
  webkit_print_operation_print(cast[ptr PrintOperation00](self.impl))

proc webkit_print_operation_set_page_setup(self: ptr PrintOperation00; pageSetup: ptr gtk.PageSetup00) {.
    importc, libprag.}

proc setPageSetup*(self: PrintOperation; pageSetup: gtk.PageSetup) =
  webkit_print_operation_set_page_setup(cast[ptr PrintOperation00](self.impl), cast[ptr gtk.PageSetup00](pageSetup.impl))

proc `pageSetup=`*(self: PrintOperation; pageSetup: gtk.PageSetup) =
  webkit_print_operation_set_page_setup(cast[ptr PrintOperation00](self.impl), cast[ptr gtk.PageSetup00](pageSetup.impl))

proc webkit_print_operation_set_print_settings(self: ptr PrintOperation00;
    printSettings: ptr gtk.PrintSettings00) {.
    importc, libprag.}

proc setPrintSettings*(self: PrintOperation; printSettings: gtk.PrintSettings) =
  webkit_print_operation_set_print_settings(cast[ptr PrintOperation00](self.impl), cast[ptr gtk.PrintSettings00](printSettings.impl))

proc `printSettings=`*(self: PrintOperation; printSettings: gtk.PrintSettings) =
  webkit_print_operation_set_print_settings(cast[ptr PrintOperation00](self.impl), cast[ptr gtk.PrintSettings00](printSettings.impl))

type
  PrintOperationResponse* {.size: sizeof(cint), pure.} = enum
    print = 0
    cancel = 1

proc webkit_print_operation_run_dialog(self: ptr PrintOperation00; parent: ptr gtk.Window00): PrintOperationResponse {.
    importc, libprag.}

proc runDialog*(self: PrintOperation; parent: gtk.Window = nil): PrintOperationResponse =
  webkit_print_operation_run_dialog(cast[ptr PrintOperation00](self.impl), if parent.isNil: nil else: cast[ptr gtk.Window00](parent.impl))

type
  NotificationPermissionRequest* = ref object of gobject.Object
  NotificationPermissionRequest00* = object of gobject.Object00

proc webkit_notification_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NotificationPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  DeviceInfoPermissionRequest* = ref object of gobject.Object
  DeviceInfoPermissionRequest00* = object of gobject.Object00

proc webkit_device_info_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceInfoPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  WebsiteDataAccessPermissionRequest* = ref object of gobject.Object
  WebsiteDataAccessPermissionRequest00* = object of gobject.Object00

proc webkit_website_data_access_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsiteDataAccessPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_website_data_access_permission_request_get_current_domain(self: ptr WebsiteDataAccessPermissionRequest00): cstring {.
    importc, libprag.}

proc getCurrentDomain*(self: WebsiteDataAccessPermissionRequest): string =
  result = $webkit_website_data_access_permission_request_get_current_domain(cast[ptr WebsiteDataAccessPermissionRequest00](self.impl))

proc currentDomain*(self: WebsiteDataAccessPermissionRequest): string =
  result = $webkit_website_data_access_permission_request_get_current_domain(cast[ptr WebsiteDataAccessPermissionRequest00](self.impl))

proc webkit_website_data_access_permission_request_get_requesting_domain(self: ptr WebsiteDataAccessPermissionRequest00): cstring {.
    importc, libprag.}

proc getRequestingDomain*(self: WebsiteDataAccessPermissionRequest): string =
  result = $webkit_website_data_access_permission_request_get_requesting_domain(cast[ptr WebsiteDataAccessPermissionRequest00](self.impl))

proc requestingDomain*(self: WebsiteDataAccessPermissionRequest): string =
  result = $webkit_website_data_access_permission_request_get_requesting_domain(cast[ptr WebsiteDataAccessPermissionRequest00](self.impl))

type
  UserMediaPermissionRequest* = ref object of gobject.Object
  UserMediaPermissionRequest00* = object of gobject.Object00

proc webkit_user_media_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserMediaPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  PointerLockPermissionRequest* = ref object of gobject.Object
  PointerLockPermissionRequest00* = object of gobject.Object00

proc webkit_pointer_lock_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PointerLockPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  MediaKeySystemPermissionRequest* = ref object of gobject.Object
  MediaKeySystemPermissionRequest00* = object of gobject.Object00

proc webkit_media_key_system_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MediaKeySystemPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  InstallMissingMediaPluginsPermissionRequest* = ref object of gobject.Object
  InstallMissingMediaPluginsPermissionRequest00* = object of gobject.Object00

proc webkit_install_missing_media_plugins_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InstallMissingMediaPluginsPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_install_missing_media_plugins_permission_request_get_description(self: ptr InstallMissingMediaPluginsPermissionRequest00): cstring {.
    importc, libprag.}

proc getDescription*(self: InstallMissingMediaPluginsPermissionRequest): string =
  result = $webkit_install_missing_media_plugins_permission_request_get_description(cast[ptr InstallMissingMediaPluginsPermissionRequest00](self.impl))

proc description*(self: InstallMissingMediaPluginsPermissionRequest): string =
  result = $webkit_install_missing_media_plugins_permission_request_get_description(cast[ptr InstallMissingMediaPluginsPermissionRequest00](self.impl))

type
  GeolocationPermissionRequest* = ref object of gobject.Object
  GeolocationPermissionRequest00* = object of gobject.Object00

proc webkit_geolocation_permission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GeolocationPermissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_permission_request_allow(self: ptr PermissionRequest00) {.
    importc, libprag.}

proc allow*(self: PermissionRequest | NotificationPermissionRequest | DeviceInfoPermissionRequest | WebsiteDataAccessPermissionRequest | UserMediaPermissionRequest | PointerLockPermissionRequest | MediaKeySystemPermissionRequest | InstallMissingMediaPluginsPermissionRequest | GeolocationPermissionRequest) =
  webkit_permission_request_allow(cast[ptr PermissionRequest00](self.impl))

proc webkit_permission_request_deny(self: ptr PermissionRequest00) {.
    importc, libprag.}

proc deny*(self: PermissionRequest | NotificationPermissionRequest | DeviceInfoPermissionRequest | WebsiteDataAccessPermissionRequest | UserMediaPermissionRequest | PointerLockPermissionRequest | MediaKeySystemPermissionRequest | InstallMissingMediaPluginsPermissionRequest | GeolocationPermissionRequest) =
  webkit_permission_request_deny(cast[ptr PermissionRequest00](self.impl))

type
  WebsitePolicies* = ref object of gobject.Object
  WebsitePolicies00* = object of gobject.Object00

proc webkit_website_policies_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsitePolicies()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_website_policies_new(): ptr WebsitePolicies00 {.
    importc, libprag.}

proc newWebsitePolicies*(): WebsitePolicies =
  let gobj = webkit_website_policies_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebsitePolicies*(tdesc: typedesc): tdesc =
  assert(result is WebsitePolicies)
  let gobj = webkit_website_policies_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebsitePolicies*[T](result: var T) {.deprecated.} =
  assert(result is WebsitePolicies)
  let gobj = webkit_website_policies_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_policy_decision_use_with_policies(self: ptr PolicyDecision00;
    policies: ptr WebsitePolicies00) {.
    importc, libprag.}

proc useWithPolicies*(self: PolicyDecision; policies: WebsitePolicies) =
  webkit_policy_decision_use_with_policies(cast[ptr PolicyDecision00](self.impl), cast[ptr WebsitePolicies00](policies.impl))

type
  AutoplayPolicy* {.size: sizeof(cint), pure.} = enum
    allow = 0
    allowWithoutSound = 1
    deny = 2

proc webkit_website_policies_get_autoplay_policy(self: ptr WebsitePolicies00): AutoplayPolicy {.
    importc, libprag.}

proc getAutoplayPolicy*(self: WebsitePolicies): AutoplayPolicy =
  webkit_website_policies_get_autoplay_policy(cast[ptr WebsitePolicies00](self.impl))

proc autoplayPolicy*(self: WebsitePolicies): AutoplayPolicy =
  webkit_website_policies_get_autoplay_policy(cast[ptr WebsitePolicies00](self.impl))

type
  NavigationType* {.size: sizeof(cint), pure.} = enum
    linkClicked = 0
    formSubmitted = 1
    backForward = 2
    reload = 3
    formResubmitted = 4
    other = 5

proc webkit_navigation_action_get_navigation_type(self: ptr NavigationAction00): NavigationType {.
    importc, libprag.}

proc getNavigationType*(self: NavigationAction): NavigationType =
  webkit_navigation_action_get_navigation_type(cast[ptr NavigationAction00](self.impl))

proc navigationType*(self: NavigationAction): NavigationType =
  webkit_navigation_action_get_navigation_type(cast[ptr NavigationAction00](self.impl))

type
  URIRequest* = ref object of gobject.Object
  URIRequest00* = object of gobject.Object00

proc webkit_uri_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(URIRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_uri_request_new(uri: cstring): ptr URIRequest00 {.
    importc, libprag.}

proc newURIRequest*(uri: cstring): URIRequest =
  let gobj = webkit_uri_request_new(uri)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newURIRequest*(tdesc: typedesc; uri: cstring): tdesc =
  assert(result is URIRequest)
  let gobj = webkit_uri_request_new(uri)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initURIRequest*[T](result: var T; uri: cstring) {.deprecated.} =
  assert(result is URIRequest)
  let gobj = webkit_uri_request_new(uri)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_uri_request_get_http_headers(self: ptr URIRequest00): ptr soup.MessageHeaders00 {.
    importc, libprag.}

proc getHttpHeaders*(self: URIRequest): soup.MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = webkit_uri_request_get_http_headers(cast[ptr URIRequest00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc httpHeaders*(self: URIRequest): soup.MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = webkit_uri_request_get_http_headers(cast[ptr URIRequest00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc webkit_uri_request_get_http_method(self: ptr URIRequest00): cstring {.
    importc, libprag.}

proc getHttpMethod*(self: URIRequest): string =
  result = $webkit_uri_request_get_http_method(cast[ptr URIRequest00](self.impl))

proc httpMethod*(self: URIRequest): string =
  result = $webkit_uri_request_get_http_method(cast[ptr URIRequest00](self.impl))

proc webkit_uri_request_get_uri(self: ptr URIRequest00): cstring {.
    importc, libprag.}

proc getUri*(self: URIRequest): string =
  result = $webkit_uri_request_get_uri(cast[ptr URIRequest00](self.impl))

proc uri*(self: URIRequest): string =
  result = $webkit_uri_request_get_uri(cast[ptr URIRequest00](self.impl))

proc webkit_uri_request_set_uri(self: ptr URIRequest00; uri: cstring) {.
    importc, libprag.}

proc setUri*(self: URIRequest; uri: cstring) =
  webkit_uri_request_set_uri(cast[ptr URIRequest00](self.impl), uri)

proc `uri=`*(self: URIRequest; uri: cstring) =
  webkit_uri_request_set_uri(cast[ptr URIRequest00](self.impl), uri)

proc webkit_navigation_action_get_request(self: ptr NavigationAction00): ptr URIRequest00 {.
    importc, libprag.}

proc getRequest*(self: NavigationAction): URIRequest =
  let gobj = webkit_navigation_action_get_request(cast[ptr NavigationAction00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc request*(self: NavigationAction): URIRequest =
  let gobj = webkit_navigation_action_get_request(cast[ptr NavigationAction00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  URIResponse* = ref object of gobject.Object
  URIResponse00* = object of gobject.Object00

proc webkit_uri_response_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(URIResponse()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_uri_response_get_content_length(self: ptr URIResponse00): uint64 {.
    importc, libprag.}

proc getContentLength*(self: URIResponse): uint64 =
  webkit_uri_response_get_content_length(cast[ptr URIResponse00](self.impl))

proc contentLength*(self: URIResponse): uint64 =
  webkit_uri_response_get_content_length(cast[ptr URIResponse00](self.impl))

proc webkit_uri_response_get_http_headers(self: ptr URIResponse00): ptr soup.MessageHeaders00 {.
    importc, libprag.}

proc getHttpHeaders*(self: URIResponse): soup.MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = webkit_uri_response_get_http_headers(cast[ptr URIResponse00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc httpHeaders*(self: URIResponse): soup.MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = webkit_uri_response_get_http_headers(cast[ptr URIResponse00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), result.impl))

proc webkit_uri_response_get_mime_type(self: ptr URIResponse00): cstring {.
    importc, libprag.}

proc getMimeType*(self: URIResponse): string =
  result = $webkit_uri_response_get_mime_type(cast[ptr URIResponse00](self.impl))

proc mimeType*(self: URIResponse): string =
  result = $webkit_uri_response_get_mime_type(cast[ptr URIResponse00](self.impl))

proc webkit_uri_response_get_status_code(self: ptr URIResponse00): uint32 {.
    importc, libprag.}

proc getStatusCode*(self: URIResponse): int =
  int(webkit_uri_response_get_status_code(cast[ptr URIResponse00](self.impl)))

proc statusCode*(self: URIResponse): int =
  int(webkit_uri_response_get_status_code(cast[ptr URIResponse00](self.impl)))

proc webkit_uri_response_get_suggested_filename(self: ptr URIResponse00): cstring {.
    importc, libprag.}

proc getSuggestedFilename*(self: URIResponse): string =
  result = $webkit_uri_response_get_suggested_filename(cast[ptr URIResponse00](self.impl))

proc suggestedFilename*(self: URIResponse): string =
  result = $webkit_uri_response_get_suggested_filename(cast[ptr URIResponse00](self.impl))

proc webkit_uri_response_get_uri(self: ptr URIResponse00): cstring {.
    importc, libprag.}

proc getUri*(self: URIResponse): string =
  result = $webkit_uri_response_get_uri(cast[ptr URIResponse00](self.impl))

proc uri*(self: URIResponse): string =
  result = $webkit_uri_response_get_uri(cast[ptr URIResponse00](self.impl))

type
  WebResource* = ref object of gobject.Object
  WebResource00* = object of gobject.Object00

proc webkit_web_resource_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebResource()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scFailed*(self: WebResource;  p: proc (self: ptr WebResource00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "failed", cast[GCallback](p), xdata, nil, cf)

proc scFailedWithTlsErrors*(self: WebResource;  p: proc (self: ptr WebResource00; certificate: ptr gio.TlsCertificate00; errors: gio.TlsCertificateFlags; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "failed-with-tls-errors", cast[GCallback](p), xdata, nil, cf)

proc scFinished*(self: WebResource;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc scReceivedData*(self: WebResource;  p: proc (self: ptr WebResource00; dataLength: uint64; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "received-data", cast[GCallback](p), xdata, nil, cf)

proc scSentRequest*(self: WebResource;  p: proc (self: ptr WebResource00; request: ptr URIRequest00; redirectedResponse: ptr URIResponse00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "sent-request", cast[GCallback](p), xdata, nil, cf)

proc webkit_web_resource_get_data(self: ptr WebResource00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getData*(self: WebResource; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_resource_get_data(cast[ptr WebResource00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_resource_get_data_finish(self: ptr WebResource00; resu: ptr gio.AsyncResult00;
    length: var uint64; error: ptr ptr glib.Error = nil): ptr uint8 {.
    importc, libprag.}

proc getDataFinish*(self: WebResource; resu: gio.AsyncResult;
    length: var uint64 = cast[var uint64](nil)): seq[uint8] =
  var gerror: ptr glib.Error
  let resul0 = webkit_web_resource_get_data_finish(cast[ptr WebResource00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = uint8ArrayToSeq(resul0, length.int)
  cogfree(resul0)

proc webkit_web_resource_get_response(self: ptr WebResource00): ptr URIResponse00 {.
    importc, libprag.}

proc getResponse*(self: WebResource): URIResponse =
  let gobj = webkit_web_resource_get_response(cast[ptr WebResource00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc response*(self: WebResource): URIResponse =
  let gobj = webkit_web_resource_get_response(cast[ptr WebResource00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_resource_get_uri(self: ptr WebResource00): cstring {.
    importc, libprag.}

proc getUri*(self: WebResource): string =
  result = $webkit_web_resource_get_uri(cast[ptr WebResource00](self.impl))

proc uri*(self: WebResource): string =
  result = $webkit_web_resource_get_uri(cast[ptr WebResource00](self.impl))

type
  ColorChooserRequest* = ref object of gobject.Object
  ColorChooserRequest00* = object of gobject.Object00

proc webkit_color_chooser_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ColorChooserRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scFinished*(self: ColorChooserRequest;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc webkit_color_chooser_request_cancel(self: ptr ColorChooserRequest00) {.
    importc, libprag.}

proc cancel*(self: ColorChooserRequest) =
  webkit_color_chooser_request_cancel(cast[ptr ColorChooserRequest00](self.impl))

proc webkit_color_chooser_request_finish(self: ptr ColorChooserRequest00) {.
    importc, libprag.}

proc finish*(self: ColorChooserRequest) =
  webkit_color_chooser_request_finish(cast[ptr ColorChooserRequest00](self.impl))

proc webkit_color_chooser_request_get_element_rectangle(self: ptr ColorChooserRequest00;
    rect: var gdk.Rectangle) {.
    importc, libprag.}

proc getElementRectangle*(self: ColorChooserRequest;
    rect: var gdk.Rectangle) =
  webkit_color_chooser_request_get_element_rectangle(cast[ptr ColorChooserRequest00](self.impl), rect)

proc getElementRectangle*(self: ColorChooserRequest): gdk.Rectangle =
  webkit_color_chooser_request_get_element_rectangle(cast[ptr ColorChooserRequest00](self.impl), result)

proc webkit_color_chooser_request_get_rgba(self: ptr ColorChooserRequest00;
    rgba: var gdk.RGBA) {.
    importc, libprag.}

proc getRgba*(self: ColorChooserRequest; rgba: var gdk.RGBA) =
  webkit_color_chooser_request_get_rgba(cast[ptr ColorChooserRequest00](self.impl), rgba)

proc getRgba*(self: ColorChooserRequest): gdk.RGBA =
  webkit_color_chooser_request_get_rgba(cast[ptr ColorChooserRequest00](self.impl), result)

proc webkit_color_chooser_request_set_rgba(self: ptr ColorChooserRequest00;
    rgba: gdk.RGBA) {.
    importc, libprag.}

proc setRgba*(self: ColorChooserRequest; rgba: gdk.RGBA) =
  webkit_color_chooser_request_set_rgba(cast[ptr ColorChooserRequest00](self.impl), rgba)

proc `rgba=`*(self: ColorChooserRequest; rgba: gdk.RGBA) =
  webkit_color_chooser_request_set_rgba(cast[ptr ColorChooserRequest00](self.impl), rgba)

type
  FileChooserRequest* = ref object of gobject.Object
  FileChooserRequest00* = object of gobject.Object00

proc webkit_file_chooser_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FileChooserRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_file_chooser_request_cancel(self: ptr FileChooserRequest00) {.
    importc, libprag.}

proc cancel*(self: FileChooserRequest) =
  webkit_file_chooser_request_cancel(cast[ptr FileChooserRequest00](self.impl))

proc webkit_file_chooser_request_get_mime_types(self: ptr FileChooserRequest00): ptr cstring {.
    importc, libprag.}

proc getMimeTypes*(self: FileChooserRequest): seq[string] =
  cstringArrayToSeq(webkit_file_chooser_request_get_mime_types(cast[ptr FileChooserRequest00](self.impl)))

proc mimeTypes*(self: FileChooserRequest): seq[string] =
  cstringArrayToSeq(webkit_file_chooser_request_get_mime_types(cast[ptr FileChooserRequest00](self.impl)))

proc webkit_file_chooser_request_get_mime_types_filter(self: ptr FileChooserRequest00): ptr gtk.FileFilter00 {.
    importc, libprag.}

proc getMimeTypesFilter*(self: FileChooserRequest): gtk.FileFilter =
  let gobj = webkit_file_chooser_request_get_mime_types_filter(cast[ptr FileChooserRequest00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc mimeTypesFilter*(self: FileChooserRequest): gtk.FileFilter =
  let gobj = webkit_file_chooser_request_get_mime_types_filter(cast[ptr FileChooserRequest00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_file_chooser_request_get_select_multiple(self: ptr FileChooserRequest00): gboolean {.
    importc, libprag.}

proc getSelectMultiple*(self: FileChooserRequest): bool =
  toBool(webkit_file_chooser_request_get_select_multiple(cast[ptr FileChooserRequest00](self.impl)))

proc selectMultiple*(self: FileChooserRequest): bool =
  toBool(webkit_file_chooser_request_get_select_multiple(cast[ptr FileChooserRequest00](self.impl)))

proc webkit_file_chooser_request_get_selected_files(self: ptr FileChooserRequest00): ptr cstring {.
    importc, libprag.}

proc getSelectedFiles*(self: FileChooserRequest): seq[string] =
  cstringArrayToSeq(webkit_file_chooser_request_get_selected_files(cast[ptr FileChooserRequest00](self.impl)))

proc selectedFiles*(self: FileChooserRequest): seq[string] =
  cstringArrayToSeq(webkit_file_chooser_request_get_selected_files(cast[ptr FileChooserRequest00](self.impl)))

proc webkit_file_chooser_request_select_files(self: ptr FileChooserRequest00;
    files: ptr cstring) {.
    importc, libprag.}

proc selectFiles*(self: FileChooserRequest; files: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  webkit_file_chooser_request_select_files(cast[ptr FileChooserRequest00](self.impl), seq2CstringArray(files, fs469n23))

type
  ScriptDialog00* {.pure.} = object
  ScriptDialog* = ref object
    impl*: ptr ScriptDialog00
    ignoreFinalizer*: bool

proc webkit_script_dialog_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitScriptDialog*(self: ScriptDialog) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_script_dialog_get_type(), cast[ptr ScriptDialog00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ScriptDialog()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_script_dialog_get_type(), cast[ptr ScriptDialog00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ScriptDialog) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitScriptDialog)

proc webkit_script_dialog_unref(self: ptr ScriptDialog00) {.
    importc, libprag.}

proc unref*(self: ScriptDialog) =
  webkit_script_dialog_unref(cast[ptr ScriptDialog00](self.impl))

proc finalizerunref*(self: ScriptDialog) =
  if not self.ignoreFinalizer:
    webkit_script_dialog_unref(cast[ptr ScriptDialog00](self.impl))

proc webkit_script_dialog_confirm_set_confirmed(self: ptr ScriptDialog00;
    confirmed: gboolean) {.
    importc, libprag.}

proc confirmSetConfirmed*(self: ScriptDialog; confirmed: bool = true) =
  webkit_script_dialog_confirm_set_confirmed(cast[ptr ScriptDialog00](self.impl), gboolean(confirmed))

proc webkit_script_dialog_get_message(self: ptr ScriptDialog00): cstring {.
    importc, libprag.}

proc getMessage*(self: ScriptDialog): string =
  result = $webkit_script_dialog_get_message(cast[ptr ScriptDialog00](self.impl))

proc message*(self: ScriptDialog): string =
  result = $webkit_script_dialog_get_message(cast[ptr ScriptDialog00](self.impl))

proc webkit_script_dialog_prompt_get_default_text(self: ptr ScriptDialog00): cstring {.
    importc, libprag.}

proc promptGetDefaultText*(self: ScriptDialog): string =
  result = $webkit_script_dialog_prompt_get_default_text(cast[ptr ScriptDialog00](self.impl))

proc webkit_script_dialog_prompt_set_text(self: ptr ScriptDialog00; text: cstring) {.
    importc, libprag.}

proc promptSetText*(self: ScriptDialog; text: cstring) =
  webkit_script_dialog_prompt_set_text(cast[ptr ScriptDialog00](self.impl), text)

proc webkit_script_dialog_ref(self: ptr ScriptDialog00): ptr ScriptDialog00 {.
    importc, libprag.}

proc `ref`*(self: ScriptDialog): ScriptDialog =
  fnew(result, gBoxedFreeWebKitScriptDialog)
  result.impl = webkit_script_dialog_ref(cast[ptr ScriptDialog00](self.impl))

proc webkit_script_dialog_close(self: ptr ScriptDialog00) {.
    importc, libprag.}

proc close*(self: ScriptDialog) =
  webkit_script_dialog_close(cast[ptr ScriptDialog00](self.impl))

type
  Notification* = ref object of gobject.Object
  Notification00* = object of gobject.Object00

proc webkit_notification_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Notification()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClicked*(self: Notification;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "clicked", cast[GCallback](p), xdata, nil, cf)

proc scClosed*(self: Notification;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc webkit_notification_clicked(self: ptr Notification00) {.
    importc, libprag.}

proc clicked*(self: Notification) =
  webkit_notification_clicked(cast[ptr Notification00](self.impl))

proc webkit_notification_close(self: ptr Notification00) {.
    importc, libprag.}

proc close*(self: Notification) =
  webkit_notification_close(cast[ptr Notification00](self.impl))

proc webkit_notification_get_body(self: ptr Notification00): cstring {.
    importc, libprag.}

proc getBody*(self: Notification): string =
  result = $webkit_notification_get_body(cast[ptr Notification00](self.impl))

proc body*(self: Notification): string =
  result = $webkit_notification_get_body(cast[ptr Notification00](self.impl))

proc webkit_notification_get_id(self: ptr Notification00): uint64 {.
    importc, libprag.}

proc getId*(self: Notification): uint64 =
  webkit_notification_get_id(cast[ptr Notification00](self.impl))

proc id*(self: Notification): uint64 =
  webkit_notification_get_id(cast[ptr Notification00](self.impl))

proc webkit_notification_get_tag(self: ptr Notification00): cstring {.
    importc, libprag.}

proc getTag*(self: Notification): string =
  let resul0 = webkit_notification_get_tag(cast[ptr Notification00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc tag*(self: Notification): string =
  let resul0 = webkit_notification_get_tag(cast[ptr Notification00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_notification_get_title(self: ptr Notification00): cstring {.
    importc, libprag.}

proc getTitle*(self: Notification): string =
  result = $webkit_notification_get_title(cast[ptr Notification00](self.impl))

proc title*(self: Notification): string =
  result = $webkit_notification_get_title(cast[ptr Notification00](self.impl))

type
  OptionMenu* = ref object of gobject.Object
  OptionMenu00* = object of gobject.Object00

proc webkit_option_menu_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(OptionMenu()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClose*(self: OptionMenu;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "close", cast[GCallback](p), xdata, nil, cf)

proc webkit_option_menu_activate_item(self: ptr OptionMenu00; index: uint32) {.
    importc, libprag.}

proc activateItem*(self: OptionMenu; index: int) =
  webkit_option_menu_activate_item(cast[ptr OptionMenu00](self.impl), uint32(index))

proc webkit_option_menu_close(self: ptr OptionMenu00) {.
    importc, libprag.}

proc close*(self: OptionMenu) =
  webkit_option_menu_close(cast[ptr OptionMenu00](self.impl))

proc webkit_option_menu_get_n_items(self: ptr OptionMenu00): uint32 {.
    importc, libprag.}

proc getNItems*(self: OptionMenu): int =
  int(webkit_option_menu_get_n_items(cast[ptr OptionMenu00](self.impl)))

proc nItems*(self: OptionMenu): int =
  int(webkit_option_menu_get_n_items(cast[ptr OptionMenu00](self.impl)))

proc webkit_option_menu_select_item(self: ptr OptionMenu00; index: uint32) {.
    importc, libprag.}

proc selectItem*(self: OptionMenu; index: int) =
  webkit_option_menu_select_item(cast[ptr OptionMenu00](self.impl), uint32(index))

type
  FormSubmissionRequest* = ref object of gobject.Object
  FormSubmissionRequest00* = object of gobject.Object00

proc webkit_form_submission_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FormSubmissionRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_form_submission_request_get_text_fields(self: ptr FormSubmissionRequest00): ptr HashTable00 {.
    importc, libprag.}

proc getTextFields*(self: FormSubmissionRequest): ptr HashTable00 =
  webkit_form_submission_request_get_text_fields(cast[ptr FormSubmissionRequest00](self.impl))

proc textFields*(self: FormSubmissionRequest): ptr HashTable00 =
  webkit_form_submission_request_get_text_fields(cast[ptr FormSubmissionRequest00](self.impl))

proc webkit_form_submission_request_list_text_fields(self: ptr FormSubmissionRequest00;
    fieldNames: var ptr PtrArray00; fieldValues: var ptr PtrArray00): gboolean {.
    importc, libprag.}

proc listTextFields*(self: FormSubmissionRequest;
    fieldNames: var ptr PtrArray00 = cast[var ptr PtrArray00](nil); fieldValues: var ptr PtrArray00 = cast[var ptr PtrArray00](nil)): bool =
  toBool(webkit_form_submission_request_list_text_fields(cast[ptr FormSubmissionRequest00](self.impl), fieldNames, fieldValues))

proc webkit_form_submission_request_submit(self: ptr FormSubmissionRequest00) {.
    importc, libprag.}

proc submit*(self: FormSubmissionRequest) =
  webkit_form_submission_request_submit(cast[ptr FormSubmissionRequest00](self.impl))

type
  UserMessage* = ref object of gobject.InitiallyUnowned
  UserMessage00* = object of gobject.InitiallyUnowned00

proc webkit_user_message_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserMessage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_user_message_new(name: cstring; parameters: ptr glib.Variant00): ptr UserMessage00 {.
    importc, libprag.}

proc newUserMessage*(name: cstring; parameters: glib.Variant = nil): UserMessage =
  let gobj = webkit_user_message_new(name, if parameters.isNil: nil else: cast[ptr glib.Variant00](parameters.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newUserMessage*(tdesc: typedesc; name: cstring; parameters: glib.Variant = nil): tdesc =
  assert(result is UserMessage)
  let gobj = webkit_user_message_new(name, if parameters.isNil: nil else: cast[ptr glib.Variant00](parameters.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUserMessage*[T](result: var T; name: cstring; parameters: glib.Variant = nil) {.deprecated.} =
  assert(result is UserMessage)
  let gobj = webkit_user_message_new(name, if parameters.isNil: nil else: cast[ptr glib.Variant00](parameters.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_user_message_new_with_fd_list(name: cstring; parameters: ptr glib.Variant00;
    fdList: ptr gio.UnixFDList00): ptr UserMessage00 {.
    importc, libprag.}

proc newUserMessageWithFdList*(name: cstring; parameters: glib.Variant = nil;
    fdList: gio.UnixFDList = nil): UserMessage =
  let gobj = webkit_user_message_new_with_fd_list(name, if parameters.isNil: nil else: cast[ptr glib.Variant00](parameters.impl), if fdList.isNil: nil else: cast[ptr gio.UnixFDList00](fdList.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newUserMessageWithFdList*(tdesc: typedesc; name: cstring; parameters: glib.Variant = nil;
    fdList: gio.UnixFDList = nil): tdesc =
  assert(result is UserMessage)
  let gobj = webkit_user_message_new_with_fd_list(name, if parameters.isNil: nil else: cast[ptr glib.Variant00](parameters.impl), if fdList.isNil: nil else: cast[ptr gio.UnixFDList00](fdList.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUserMessageWithFdList*[T](result: var T; name: cstring; parameters: glib.Variant = nil;
    fdList: gio.UnixFDList = nil) {.deprecated.} =
  assert(result is UserMessage)
  let gobj = webkit_user_message_new_with_fd_list(name, if parameters.isNil: nil else: cast[ptr glib.Variant00](parameters.impl), if fdList.isNil: nil else: cast[ptr gio.UnixFDList00](fdList.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_user_message_get_fd_list(self: ptr UserMessage00): ptr gio.UnixFDList00 {.
    importc, libprag.}

proc getFdList*(self: UserMessage): gio.UnixFDList =
  let gobj = webkit_user_message_get_fd_list(cast[ptr UserMessage00](self.impl))
  if gobj.isNil:
    return nil
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

proc fdList*(self: UserMessage): gio.UnixFDList =
  let gobj = webkit_user_message_get_fd_list(cast[ptr UserMessage00](self.impl))
  if gobj.isNil:
    return nil
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

proc webkit_user_message_get_name(self: ptr UserMessage00): cstring {.
    importc, libprag.}

proc getName*(self: UserMessage): string =
  result = $webkit_user_message_get_name(cast[ptr UserMessage00](self.impl))

proc name*(self: UserMessage): string =
  result = $webkit_user_message_get_name(cast[ptr UserMessage00](self.impl))

proc webkit_user_message_get_parameters(self: ptr UserMessage00): ptr glib.Variant00 {.
    importc, libprag.}

proc getParameters*(self: UserMessage): glib.Variant =
  let impl0 = webkit_user_message_get_parameters(cast[ptr UserMessage00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0
  result.ignoreFinalizer = true # GVariant

proc parameters*(self: UserMessage): glib.Variant =
  let impl0 = webkit_user_message_get_parameters(cast[ptr UserMessage00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0
  result.ignoreFinalizer = true # GVariant

proc webkit_user_message_send_reply(self: ptr UserMessage00; reply: ptr UserMessage00) {.
    importc, libprag.}

proc sendReply*(self: UserMessage; reply: UserMessage) =
  webkit_user_message_send_reply(cast[ptr UserMessage00](self.impl), cast[ptr UserMessage00](reply.impl))

type
  WebProcessTerminationReason* {.size: sizeof(cint), pure.} = enum
    crashed = 0
    exceededMemoryLimit = 1
    terminatedByApi = 2

type
  WebView* = ref object of WebViewBase
  WebView00* = object of WebViewBase00

proc webkit_web_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebView()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAuthenticate*(self: WebView;  p: proc (self: ptr WebView00; request: ptr AuthenticationRequest00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "authenticate", cast[GCallback](p), xdata, nil, cf)

proc scClose*(self: WebView;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "close", cast[GCallback](p), xdata, nil, cf)

proc scContextMenu*(self: WebView;  p: proc (self: ptr WebView00; contextMenu: ptr ContextMenu00; event: ptr gdk.Event00; hitTestResult: ptr HitTestResult00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "context-menu", cast[GCallback](p), xdata, nil, cf)

proc scContextMenuDismissed*(self: WebView;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "context-menu-dismissed", cast[GCallback](p), xdata, nil, cf)

proc scCreate*(self: WebView;  p: proc (self: ptr WebView00; navigationAction: ptr NavigationAction00; xdata: pointer): gtk.Widget00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create", cast[GCallback](p), xdata, nil, cf)

proc scDecidePolicy*(self: WebView;  p: proc (self: ptr WebView00; decision: ptr PolicyDecision00; decisionType: PolicyDecisionType; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "decide-policy", cast[GCallback](p), xdata, nil, cf)

proc scEnterFullscreen*(self: WebView;  p: proc (self: ptr WebView00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "enter-fullscreen", cast[GCallback](p), xdata, nil, cf)

proc scInsecureContentDetected*(self: WebView;  p: proc (self: ptr WebView00; event: InsecureContentEvent; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "insecure-content-detected", cast[GCallback](p), xdata, nil, cf)

proc scLeaveFullscreen*(self: WebView;  p: proc (self: ptr WebView00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "leave-fullscreen", cast[GCallback](p), xdata, nil, cf)

proc scLoadChanged*(self: WebView;  p: proc (self: ptr WebView00; loadEvent: LoadEvent; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "load-changed", cast[GCallback](p), xdata, nil, cf)

proc scLoadFailed*(self: WebView;  p: proc (self: ptr WebView00; loadEvent: LoadEvent; failingUri: cstring; error: ptr glib.Error; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "load-failed", cast[GCallback](p), xdata, nil, cf)

proc scLoadFailedWithTlsErrors*(self: WebView;  p: proc (self: ptr WebView00; failingUri: cstring; certificate: ptr gio.TlsCertificate00; errors: gio.TlsCertificateFlags; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "load-failed-with-tls-errors", cast[GCallback](p), xdata, nil, cf)

proc scMouseTargetChanged*(self: WebView;  p: proc (self: ptr WebView00; hitTestResult: ptr HitTestResult00; modifiers: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "mouse-target-changed", cast[GCallback](p), xdata, nil, cf)

proc scPermissionRequest*(self: WebView;  p: proc (self: ptr WebView00; request: ptr PermissionRequest00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "permission-request", cast[GCallback](p), xdata, nil, cf)

proc scPrint*(self: WebView;  p: proc (self: ptr WebView00; printOperation: ptr PrintOperation00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "print", cast[GCallback](p), xdata, nil, cf)

proc scReadyToShow*(self: WebView;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "ready-to-show", cast[GCallback](p), xdata, nil, cf)

proc scResourceLoadStarted*(self: WebView;  p: proc (self: ptr WebView00; resource: ptr WebResource00; request: ptr URIRequest00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "resource-load-started", cast[GCallback](p), xdata, nil, cf)

proc scRunAsModal*(self: WebView;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "run-as-modal", cast[GCallback](p), xdata, nil, cf)

proc scRunColorChooser*(self: WebView;  p: proc (self: ptr WebView00; request: ptr ColorChooserRequest00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "run-color-chooser", cast[GCallback](p), xdata, nil, cf)

proc scRunFileChooser*(self: WebView;  p: proc (self: ptr WebView00; request: ptr FileChooserRequest00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "run-file-chooser", cast[GCallback](p), xdata, nil, cf)

proc scScriptDialog*(self: WebView;  p: proc (self: ptr WebView00; dialog: ptr ScriptDialog00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "script-dialog", cast[GCallback](p), xdata, nil, cf)

proc scShowNotification*(self: WebView;  p: proc (self: ptr WebView00; notification: ptr Notification00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "show-notification", cast[GCallback](p), xdata, nil, cf)

proc scShowOptionMenu*(self: WebView;  p: proc (self: ptr WebView00; menu: ptr OptionMenu00; event: ptr gdk.Event00; rectangle: gdk.Rectangle; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "show-option-menu", cast[GCallback](p), xdata, nil, cf)

proc scSubmitForm*(self: WebView;  p: proc (self: ptr WebView00; request: ptr FormSubmissionRequest00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "submit-form", cast[GCallback](p), xdata, nil, cf)

proc scUserMessageReceived*(self: WebView;  p: proc (self: ptr WebView00; message: ptr UserMessage00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "user-message-received", cast[GCallback](p), xdata, nil, cf)

proc scWebProcessCrashed*(self: WebView;  p: proc (self: ptr WebView00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "web-process-crashed", cast[GCallback](p), xdata, nil, cf)

proc scWebProcessTerminated*(self: WebView;  p: proc (self: ptr WebView00; reason: WebProcessTerminationReason; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "web-process-terminated", cast[GCallback](p), xdata, nil, cf)

proc webkit_web_view_new(): ptr WebView00 {.
    importc, libprag.}

proc newWebView*(): WebView =
  let gobj = webkit_web_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebView*(tdesc: typedesc): tdesc =
  assert(result is WebView)
  let gobj = webkit_web_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebView*[T](result: var T) {.deprecated.} =
  assert(result is WebView)
  let gobj = webkit_web_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_new_with_related_view(webView: ptr WebView00): ptr WebView00 {.
    importc, libprag.}

proc newWebViewWithRelatedView*(webView: WebView): WebView =
  let gobj = webkit_web_view_new_with_related_view(cast[ptr WebView00](webView.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebViewWithRelatedView*(tdesc: typedesc; webView: WebView): tdesc =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_related_view(cast[ptr WebView00](webView.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebViewWithRelatedView*[T](result: var T; webView: WebView) {.deprecated.} =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_related_view(cast[ptr WebView00](webView.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_can_execute_editing_command(self: ptr WebView00; command: cstring;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc canExecuteEditingCommand*(self: WebView; command: cstring;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_view_can_execute_editing_command(cast[ptr WebView00](self.impl), command, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_view_can_execute_editing_command_finish(self: ptr WebView00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc canExecuteEditingCommandFinish*(self: WebView; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_web_view_can_execute_editing_command_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_web_view_can_go_back(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc canGoBack*(self: WebView): bool =
  toBool(webkit_web_view_can_go_back(cast[ptr WebView00](self.impl)))

proc webkit_web_view_can_go_forward(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc canGoForward*(self: WebView): bool =
  toBool(webkit_web_view_can_go_forward(cast[ptr WebView00](self.impl)))

proc webkit_web_view_can_show_mime_type(self: ptr WebView00; mimeType: cstring): gboolean {.
    importc, libprag.}

proc canShowMimeType*(self: WebView; mimeType: cstring): bool =
  toBool(webkit_web_view_can_show_mime_type(cast[ptr WebView00](self.impl), mimeType))

proc webkit_web_view_execute_editing_command(self: ptr WebView00; command: cstring) {.
    importc, libprag.}

proc executeEditingCommand*(self: WebView; command: cstring) =
  webkit_web_view_execute_editing_command(cast[ptr WebView00](self.impl), command)

proc webkit_web_view_execute_editing_command_with_argument(self: ptr WebView00;
    command: cstring; argument: cstring) {.
    importc, libprag.}

proc executeEditingCommandWithArgument*(self: WebView;
    command: cstring; argument: cstring) =
  webkit_web_view_execute_editing_command_with_argument(cast[ptr WebView00](self.impl), command, argument)

proc webkit_web_view_get_automation_presentation_type(self: ptr WebView00): AutomationBrowsingContextPresentation {.
    importc, libprag.}

proc getAutomationPresentationType*(self: WebView): AutomationBrowsingContextPresentation =
  webkit_web_view_get_automation_presentation_type(cast[ptr WebView00](self.impl))

proc automationPresentationType*(self: WebView): AutomationBrowsingContextPresentation =
  webkit_web_view_get_automation_presentation_type(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_background_color(self: ptr WebView00; rgba: var gdk.RGBA) {.
    importc, libprag.}

proc getBackgroundColor*(self: WebView; rgba: var gdk.RGBA) =
  webkit_web_view_get_background_color(cast[ptr WebView00](self.impl), rgba)

proc getBackgroundColor*(self: WebView): gdk.RGBA =
  webkit_web_view_get_background_color(cast[ptr WebView00](self.impl), result)

proc webkit_web_view_get_custom_charset(self: ptr WebView00): cstring {.
    importc, libprag.}

proc getCustomCharset*(self: WebView): string =
  result = $webkit_web_view_get_custom_charset(cast[ptr WebView00](self.impl))

proc customCharset*(self: WebView): string =
  result = $webkit_web_view_get_custom_charset(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_estimated_load_progress(self: ptr WebView00): cdouble {.
    importc, libprag.}

proc getEstimatedLoadProgress*(self: WebView): cdouble =
  webkit_web_view_get_estimated_load_progress(cast[ptr WebView00](self.impl))

proc estimatedLoadProgress*(self: WebView): cdouble =
  webkit_web_view_get_estimated_load_progress(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_favicon(self: ptr WebView00): ptr cairo.Surface00 {.
    importc, libprag.}

proc getFavicon*(self: WebView): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = webkit_web_view_get_favicon(cast[ptr WebView00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_surface_get_type(), result.impl))

proc favicon*(self: WebView): cairo.Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = webkit_web_view_get_favicon(cast[ptr WebView00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(cairo_gobject_surface_get_type(), result.impl))

proc webkit_web_view_get_is_muted(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc getIsMuted*(self: WebView): bool =
  toBool(webkit_web_view_get_is_muted(cast[ptr WebView00](self.impl)))

proc isMuted*(self: WebView): bool =
  toBool(webkit_web_view_get_is_muted(cast[ptr WebView00](self.impl)))

proc webkit_web_view_get_is_web_process_responsive(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc getIsWebProcessResponsive*(self: WebView): bool =
  toBool(webkit_web_view_get_is_web_process_responsive(cast[ptr WebView00](self.impl)))

proc isWebProcessResponsive*(self: WebView): bool =
  toBool(webkit_web_view_get_is_web_process_responsive(cast[ptr WebView00](self.impl)))

proc webkit_web_view_get_main_resource(self: ptr WebView00): ptr WebResource00 {.
    importc, libprag.}

proc getMainResource*(self: WebView): WebResource =
  let gobj = webkit_web_view_get_main_resource(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc mainResource*(self: WebView): WebResource =
  let gobj = webkit_web_view_get_main_resource(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_get_page_id(self: ptr WebView00): uint64 {.
    importc, libprag.}

proc getPageId*(self: WebView): uint64 =
  webkit_web_view_get_page_id(cast[ptr WebView00](self.impl))

proc pageId*(self: WebView): uint64 =
  webkit_web_view_get_page_id(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_snapshot_finish(self: ptr WebView00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr cairo.Surface00 {.
    importc, libprag.}

proc getSnapshotFinish*(self: WebView; resu: gio.AsyncResult): cairo.Surface =
  var gerror: ptr glib.Error
  let impl0 = webkit_web_view_get_snapshot_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = impl0

proc webkit_web_view_get_title(self: ptr WebView00): cstring {.
    importc, libprag.}

proc getTitle*(self: WebView): string =
  result = $webkit_web_view_get_title(cast[ptr WebView00](self.impl))

proc title*(self: WebView): string =
  result = $webkit_web_view_get_title(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_tls_info(self: ptr WebView00; certificate: var ptr gio.TlsCertificate00;
    errors: var gio.TlsCertificateFlags): gboolean {.
    importc, libprag.}

proc getTlsInfo*(self: WebView; certificate: var gio.TlsCertificate;
    errors: var gio.TlsCertificateFlags): bool =
  var tmpoutgobjectarg: ptr gio.TlsCertificate00
  result = toBool(webkit_web_view_get_tls_info(cast[ptr WebView00](self.impl), tmpoutgobjectarg, errors))
#  dothemagic(certificate
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    certificate = cast[type(certificate)](argqdata)
    assert(certificate.impl == tmpoutgobjectarg)
  else:
    fnew(certificate, webkit2.finalizeGObject)
    certificate.impl = tmpoutgobjectarg
    GC_ref(certificate)
    if g_object_is_floating(certificate.impl).int != 0:
      discard g_object_ref_sink(certificate.impl)
    g_object_add_toggle_ref(certificate.impl, toggleNotify, addr(certificate[]))
    g_object_unref(certificate.impl)
    assert(g_object_get_qdata(certificate.impl, Quark) == nil)
    g_object_set_qdata(certificate.impl, Quark, addr(certificate[]))


proc webkit_web_view_get_uri(self: ptr WebView00): cstring {.
    importc, libprag.}

proc getUri*(self: WebView): string =
  result = $webkit_web_view_get_uri(cast[ptr WebView00](self.impl))

proc uri*(self: WebView): string =
  result = $webkit_web_view_get_uri(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_website_policies(self: ptr WebView00): ptr WebsitePolicies00 {.
    importc, libprag.}

proc getWebsitePolicies*(self: WebView): WebsitePolicies =
  let gobj = webkit_web_view_get_website_policies(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc websitePolicies*(self: WebView): WebsitePolicies =
  let gobj = webkit_web_view_get_website_policies(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_get_zoom_level(self: ptr WebView00): cdouble {.
    importc, libprag.}

proc getZoomLevel*(self: WebView): cdouble =
  webkit_web_view_get_zoom_level(cast[ptr WebView00](self.impl))

proc zoomLevel*(self: WebView): cdouble =
  webkit_web_view_get_zoom_level(cast[ptr WebView00](self.impl))

proc webkit_web_view_go_back(self: ptr WebView00) {.
    importc, libprag.}

proc goBack*(self: WebView) =
  webkit_web_view_go_back(cast[ptr WebView00](self.impl))

proc webkit_web_view_go_forward(self: ptr WebView00) {.
    importc, libprag.}

proc goForward*(self: WebView) =
  webkit_web_view_go_forward(cast[ptr WebView00](self.impl))

proc webkit_web_view_is_controlled_by_automation(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc isControlledByAutomation*(self: WebView): bool =
  toBool(webkit_web_view_is_controlled_by_automation(cast[ptr WebView00](self.impl)))

proc webkit_web_view_is_editable(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc isEditable*(self: WebView): bool =
  toBool(webkit_web_view_is_editable(cast[ptr WebView00](self.impl)))

proc webkit_web_view_is_ephemeral(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc isEphemeral*(self: WebView): bool =
  toBool(webkit_web_view_is_ephemeral(cast[ptr WebView00](self.impl)))

proc webkit_web_view_is_loading(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc isLoading*(self: WebView): bool =
  toBool(webkit_web_view_is_loading(cast[ptr WebView00](self.impl)))

proc webkit_web_view_is_playing_audio(self: ptr WebView00): gboolean {.
    importc, libprag.}

proc isPlayingAudio*(self: WebView): bool =
  toBool(webkit_web_view_is_playing_audio(cast[ptr WebView00](self.impl)))

proc webkit_web_view_load_alternate_html(self: ptr WebView00; content: cstring;
    contentUri: cstring; baseUri: cstring) {.
    importc, libprag.}

proc loadAlternateHtml*(self: WebView; content: cstring;
    contentUri: cstring; baseUri: cstring = nil) =
  webkit_web_view_load_alternate_html(cast[ptr WebView00](self.impl), content, contentUri, baseUri)

proc webkit_web_view_load_bytes(self: ptr WebView00; bytes: ptr glib.Bytes00;
    mimeType: cstring; encoding: cstring; baseUri: cstring) {.
    importc, libprag.}

proc loadBytes*(self: WebView; bytes: glib.Bytes; mimeType: cstring = nil;
    encoding: cstring = nil; baseUri: cstring = nil) =
  webkit_web_view_load_bytes(cast[ptr WebView00](self.impl), cast[ptr glib.Bytes00](bytes.impl), mimeType, encoding, baseUri)

proc webkit_web_view_load_html(self: ptr WebView00; content: cstring; baseUri: cstring) {.
    importc, libprag.}

proc loadHtml*(self: WebView; content: cstring; baseUri: cstring = nil) =
  webkit_web_view_load_html(cast[ptr WebView00](self.impl), content, baseUri)

proc webkit_web_view_load_plain_text(self: ptr WebView00; plainText: cstring) {.
    importc, libprag.}

proc loadPlainText*(self: WebView; plainText: cstring) =
  webkit_web_view_load_plain_text(cast[ptr WebView00](self.impl), plainText)

proc webkit_web_view_load_request(self: ptr WebView00; request: ptr URIRequest00) {.
    importc, libprag.}

proc loadRequest*(self: WebView; request: URIRequest) =
  webkit_web_view_load_request(cast[ptr WebView00](self.impl), cast[ptr URIRequest00](request.impl))

proc webkit_web_view_load_uri(self: ptr WebView00; uri: cstring) {.
    importc, libprag.}

proc loadUri*(self: WebView; uri: cstring) =
  webkit_web_view_load_uri(cast[ptr WebView00](self.impl), uri)

proc webkit_web_view_reload(self: ptr WebView00) {.
    importc, libprag.}

proc reload*(self: WebView) =
  webkit_web_view_reload(cast[ptr WebView00](self.impl))

proc webkit_web_view_reload_bypass_cache(self: ptr WebView00) {.
    importc, libprag.}

proc reloadBypassCache*(self: WebView) =
  webkit_web_view_reload_bypass_cache(cast[ptr WebView00](self.impl))

proc webkit_web_view_run_javascript(self: ptr WebView00; script: cstring;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc runJavascript*(self: WebView; script: cstring; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_view_run_javascript(cast[ptr WebView00](self.impl), script, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_view_run_javascript_from_gresource(self: ptr WebView00; resource: cstring;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc runJavascriptFromGresource*(self: WebView; resource: cstring;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_view_run_javascript_from_gresource(cast[ptr WebView00](self.impl), resource, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_view_run_javascript_in_world(self: ptr WebView00; script: cstring;
    worldName: cstring; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc runJavascriptInWorld*(self: WebView; script: cstring;
    worldName: cstring; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  webkit_web_view_run_javascript_in_world(cast[ptr WebView00](self.impl), script, worldName, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_view_save_finish(self: ptr WebView00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc saveFinish*(self: WebView; resu: gio.AsyncResult): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = webkit_web_view_save_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
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
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_save_to_file_finish(self: ptr WebView00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToFileFinish*(self: WebView; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_web_view_save_to_file_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_web_view_send_message_to_page(self: ptr WebView00; message: ptr UserMessage00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc sendMessageToPage*(self: WebView; message: UserMessage;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_view_send_message_to_page(cast[ptr WebView00](self.impl), cast[ptr UserMessage00](message.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_view_send_message_to_page_finish(self: ptr WebView00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr UserMessage00 {.
    importc, libprag.}

proc sendMessageToPageFinish*(self: WebView; resu: gio.AsyncResult): UserMessage =
  var gerror: ptr glib.Error
  let gobj = webkit_web_view_send_message_to_page_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_set_background_color(self: ptr WebView00; rgba: gdk.RGBA) {.
    importc, libprag.}

proc setBackgroundColor*(self: WebView; rgba: gdk.RGBA) =
  webkit_web_view_set_background_color(cast[ptr WebView00](self.impl), rgba)

proc `backgroundColor=`*(self: WebView; rgba: gdk.RGBA) =
  webkit_web_view_set_background_color(cast[ptr WebView00](self.impl), rgba)

proc webkit_web_view_set_cors_allowlist(self: ptr WebView00; allowlist: ptr cstring) {.
    importc, libprag.}

proc setCorsAllowlist*(self: WebView; allowlist: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  webkit_web_view_set_cors_allowlist(cast[ptr WebView00](self.impl), seq2CstringArray(allowlist, fs469n23))

proc `corsAllowlist=`*(self: WebView; allowlist: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  webkit_web_view_set_cors_allowlist(cast[ptr WebView00](self.impl), seq2CstringArray(allowlist, fs469n23))

proc webkit_web_view_set_custom_charset(self: ptr WebView00; charset: cstring) {.
    importc, libprag.}

proc setCustomCharset*(self: WebView; charset: cstring = nil) =
  webkit_web_view_set_custom_charset(cast[ptr WebView00](self.impl), charset)

proc `customCharset=`*(self: WebView; charset: cstring = nil) =
  webkit_web_view_set_custom_charset(cast[ptr WebView00](self.impl), charset)

proc webkit_web_view_set_editable(self: ptr WebView00; editable: gboolean) {.
    importc, libprag.}

proc setEditable*(self: WebView; editable: bool = true) =
  webkit_web_view_set_editable(cast[ptr WebView00](self.impl), gboolean(editable))

proc `editable=`*(self: WebView; editable: bool) =
  webkit_web_view_set_editable(cast[ptr WebView00](self.impl), gboolean(editable))

proc webkit_web_view_set_is_muted(self: ptr WebView00; muted: gboolean) {.
    importc, libprag.}

proc setIsMuted*(self: WebView; muted: bool = true) =
  webkit_web_view_set_is_muted(cast[ptr WebView00](self.impl), gboolean(muted))

proc `isMuted=`*(self: WebView; muted: bool) =
  webkit_web_view_set_is_muted(cast[ptr WebView00](self.impl), gboolean(muted))

proc webkit_web_view_set_zoom_level(self: ptr WebView00; zoomLevel: cdouble) {.
    importc, libprag.}

proc setZoomLevel*(self: WebView; zoomLevel: cdouble) =
  webkit_web_view_set_zoom_level(cast[ptr WebView00](self.impl), zoomLevel)

proc `zoomLevel=`*(self: WebView; zoomLevel: cdouble) =
  webkit_web_view_set_zoom_level(cast[ptr WebView00](self.impl), zoomLevel)

proc webkit_web_view_stop_loading(self: ptr WebView00) {.
    importc, libprag.}

proc stopLoading*(self: WebView) =
  webkit_web_view_stop_loading(cast[ptr WebView00](self.impl))

proc webkit_web_view_terminate_web_process(self: ptr WebView00) {.
    importc, libprag.}

proc terminateWebProcess*(self: WebView) =
  webkit_web_view_terminate_web_process(cast[ptr WebView00](self.impl))

proc webkit_web_view_try_close(self: ptr WebView00) {.
    importc, libprag.}

proc tryClose*(self: WebView) =
  webkit_web_view_try_close(cast[ptr WebView00](self.impl))

type
  AutomationSession* = ref object of gobject.Object
  AutomationSession00* = object of gobject.Object00

proc webkit_automation_session_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AutomationSession()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCreateWebView*(self: AutomationSession;  p: proc (self: ptr AutomationSession00; xdata: pointer): WebView00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create-web-view", cast[GCallback](p), xdata, nil, cf)

proc webkit_automation_session_get_application_info(self: ptr AutomationSession00): ptr ApplicationInfo00 {.
    importc, libprag.}

proc getApplicationInfo*(self: AutomationSession): ApplicationInfo =
  fnew(result, gBoxedFreeWebKitApplicationInfo)
  result.impl = webkit_automation_session_get_application_info(cast[ptr AutomationSession00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(webkit_application_info_get_type(), result.impl))

proc applicationInfo*(self: AutomationSession): ApplicationInfo =
  fnew(result, gBoxedFreeWebKitApplicationInfo)
  result.impl = webkit_automation_session_get_application_info(cast[ptr AutomationSession00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(webkit_application_info_get_type(), result.impl))

proc webkit_automation_session_get_id(self: ptr AutomationSession00): cstring {.
    importc, libprag.}

proc getId*(self: AutomationSession): string =
  result = $webkit_automation_session_get_id(cast[ptr AutomationSession00](self.impl))

proc id*(self: AutomationSession): string =
  result = $webkit_automation_session_get_id(cast[ptr AutomationSession00](self.impl))

proc webkit_automation_session_set_application_info(self: ptr AutomationSession00;
    info: ptr ApplicationInfo00) {.
    importc, libprag.}

proc setApplicationInfo*(self: AutomationSession;
    info: ApplicationInfo) =
  webkit_automation_session_set_application_info(cast[ptr AutomationSession00](self.impl), cast[ptr ApplicationInfo00](info.impl))

proc `applicationInfo=`*(self: AutomationSession;
    info: ApplicationInfo) =
  webkit_automation_session_set_application_info(cast[ptr AutomationSession00](self.impl), cast[ptr ApplicationInfo00](info.impl))

proc webkit_print_operation_new(webView: ptr WebView00): ptr PrintOperation00 {.
    importc, libprag.}

proc newPrintOperation*(webView: WebView): PrintOperation =
  let gobj = webkit_print_operation_new(cast[ptr WebView00](webView.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPrintOperation*(tdesc: typedesc; webView: WebView): tdesc =
  assert(result is PrintOperation)
  let gobj = webkit_print_operation_new(cast[ptr WebView00](webView.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPrintOperation*[T](result: var T; webView: WebView) {.deprecated.} =
  assert(result is PrintOperation)
  let gobj = webkit_print_operation_new(cast[ptr WebView00](webView.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Download* = ref object of gobject.Object
  Download00* = object of gobject.Object00

proc webkit_download_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Download()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCreatedDestination*(self: Download;  p: proc (self: ptr Download00; destination: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "created-destination", cast[GCallback](p), xdata, nil, cf)

proc scDecideDestination*(self: Download;  p: proc (self: ptr Download00; suggestedFilename: cstring; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "decide-destination", cast[GCallback](p), xdata, nil, cf)

proc scFailed*(self: Download;  p: proc (self: ptr Download00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "failed", cast[GCallback](p), xdata, nil, cf)

proc scFinished*(self: Download;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc scReceivedData*(self: Download;  p: proc (self: ptr Download00; dataLength: uint64; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "received-data", cast[GCallback](p), xdata, nil, cf)

proc webkit_download_cancel(self: ptr Download00) {.
    importc, libprag.}

proc cancel*(self: Download) =
  webkit_download_cancel(cast[ptr Download00](self.impl))

proc webkit_download_get_allow_overwrite(self: ptr Download00): gboolean {.
    importc, libprag.}

proc getAllowOverwrite*(self: Download): bool =
  toBool(webkit_download_get_allow_overwrite(cast[ptr Download00](self.impl)))

proc allowOverwrite*(self: Download): bool =
  toBool(webkit_download_get_allow_overwrite(cast[ptr Download00](self.impl)))

proc webkit_download_get_destination(self: ptr Download00): cstring {.
    importc, libprag.}

proc getDestination*(self: Download): string =
  result = $webkit_download_get_destination(cast[ptr Download00](self.impl))

proc destination*(self: Download): string =
  result = $webkit_download_get_destination(cast[ptr Download00](self.impl))

proc webkit_download_get_elapsed_time(self: ptr Download00): cdouble {.
    importc, libprag.}

proc getElapsedTime*(self: Download): cdouble =
  webkit_download_get_elapsed_time(cast[ptr Download00](self.impl))

proc elapsedTime*(self: Download): cdouble =
  webkit_download_get_elapsed_time(cast[ptr Download00](self.impl))

proc webkit_download_get_estimated_progress(self: ptr Download00): cdouble {.
    importc, libprag.}

proc getEstimatedProgress*(self: Download): cdouble =
  webkit_download_get_estimated_progress(cast[ptr Download00](self.impl))

proc estimatedProgress*(self: Download): cdouble =
  webkit_download_get_estimated_progress(cast[ptr Download00](self.impl))

proc webkit_download_get_received_data_length(self: ptr Download00): uint64 {.
    importc, libprag.}

proc getReceivedDataLength*(self: Download): uint64 =
  webkit_download_get_received_data_length(cast[ptr Download00](self.impl))

proc receivedDataLength*(self: Download): uint64 =
  webkit_download_get_received_data_length(cast[ptr Download00](self.impl))

proc webkit_download_get_request(self: ptr Download00): ptr URIRequest00 {.
    importc, libprag.}

proc getRequest*(self: Download): URIRequest =
  let gobj = webkit_download_get_request(cast[ptr Download00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc request*(self: Download): URIRequest =
  let gobj = webkit_download_get_request(cast[ptr Download00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_download_get_response(self: ptr Download00): ptr URIResponse00 {.
    importc, libprag.}

proc getResponse*(self: Download): URIResponse =
  let gobj = webkit_download_get_response(cast[ptr Download00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc response*(self: Download): URIResponse =
  let gobj = webkit_download_get_response(cast[ptr Download00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_download_get_web_view(self: ptr Download00): ptr WebView00 {.
    importc, libprag.}

proc getWebView*(self: Download): WebView =
  let gobj = webkit_download_get_web_view(cast[ptr Download00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webView*(self: Download): WebView =
  let gobj = webkit_download_get_web_view(cast[ptr Download00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_download_set_allow_overwrite(self: ptr Download00; allowed: gboolean) {.
    importc, libprag.}

proc setAllowOverwrite*(self: Download; allowed: bool = true) =
  webkit_download_set_allow_overwrite(cast[ptr Download00](self.impl), gboolean(allowed))

proc `allowOverwrite=`*(self: Download; allowed: bool) =
  webkit_download_set_allow_overwrite(cast[ptr Download00](self.impl), gboolean(allowed))

proc webkit_download_set_destination(self: ptr Download00; uri: cstring) {.
    importc, libprag.}

proc setDestination*(self: Download; uri: cstring) =
  webkit_download_set_destination(cast[ptr Download00](self.impl), uri)

proc `destination=`*(self: Download; uri: cstring) =
  webkit_download_set_destination(cast[ptr Download00](self.impl), uri)

proc webkit_web_view_download_uri(self: ptr WebView00; uri: cstring): ptr Download00 {.
    importc, libprag.}

proc downloadUri*(self: WebView; uri: cstring): Download =
  let gobj = webkit_web_view_download_uri(cast[ptr WebView00](self.impl), uri)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  WebContext* = ref object of gobject.Object
  WebContext00* = object of gobject.Object00

proc webkit_web_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAutomationStarted*(self: WebContext;  p: proc (self: ptr WebContext00; session: ptr AutomationSession00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "automation-started", cast[GCallback](p), xdata, nil, cf)

proc scDownloadStarted*(self: WebContext;  p: proc (self: ptr WebContext00; download: ptr Download00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "download-started", cast[GCallback](p), xdata, nil, cf)

proc scInitializeNotificationPermissions*(self: WebContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "initialize-notification-permissions", cast[GCallback](p), xdata, nil, cf)

proc scInitializeWebExtensions*(self: WebContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "initialize-web-extensions", cast[GCallback](p), xdata, nil, cf)

proc scUserMessageReceived*(self: WebContext;  p: proc (self: ptr WebContext00; message: ptr UserMessage00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "user-message-received", cast[GCallback](p), xdata, nil, cf)

proc webkit_web_context_new(): ptr WebContext00 {.
    importc, libprag.}

proc newWebContext*(): WebContext =
  let gobj = webkit_web_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebContext*(tdesc: typedesc): tdesc =
  assert(result is WebContext)
  let gobj = webkit_web_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebContext*[T](result: var T) {.deprecated.} =
  assert(result is WebContext)
  let gobj = webkit_web_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_context_new_ephemeral(): ptr WebContext00 {.
    importc, libprag.}

proc newWebContextEphemeral*(): WebContext =
  let gobj = webkit_web_context_new_ephemeral()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebContextEphemeral*(tdesc: typedesc): tdesc =
  assert(result is WebContext)
  let gobj = webkit_web_context_new_ephemeral()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebContextEphemeral*[T](result: var T) {.deprecated.} =
  assert(result is WebContext)
  let gobj = webkit_web_context_new_ephemeral()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_context_get_default(): ptr WebContext00 {.
    importc, libprag.}

proc getDefaultWebContext*(): WebContext =
  let gobj = webkit_web_context_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_context_add_path_to_sandbox(self: ptr WebContext00; path: cstring;
    readOnly: gboolean) {.
    importc, libprag.}

proc addPathToSandbox*(self: WebContext; path: cstring;
    readOnly: bool) =
  webkit_web_context_add_path_to_sandbox(cast[ptr WebContext00](self.impl), path, gboolean(readOnly))

proc webkit_web_context_allow_tls_certificate_for_host(self: ptr WebContext00;
    certificate: ptr gio.TlsCertificate00; host: cstring) {.
    importc, libprag.}

proc allowTlsCertificateForHost*(self: WebContext;
    certificate: gio.TlsCertificate; host: cstring) =
  webkit_web_context_allow_tls_certificate_for_host(cast[ptr WebContext00](self.impl), cast[ptr gio.TlsCertificate00](certificate.impl), host)

proc webkit_web_context_clear_cache(self: ptr WebContext00) {.
    importc, libprag.}

proc clearCache*(self: WebContext) =
  webkit_web_context_clear_cache(cast[ptr WebContext00](self.impl))

proc webkit_web_context_download_uri(self: ptr WebContext00; uri: cstring): ptr Download00 {.
    importc, libprag.}

proc downloadUri*(self: WebContext; uri: cstring): Download =
  let gobj = webkit_web_context_download_uri(cast[ptr WebContext00](self.impl), uri)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_context_get_favicon_database_directory(self: ptr WebContext00): cstring {.
    importc, libprag.}

proc getFaviconDatabaseDirectory*(self: WebContext): string =
  result = $webkit_web_context_get_favicon_database_directory(cast[ptr WebContext00](self.impl))

proc faviconDatabaseDirectory*(self: WebContext): string =
  result = $webkit_web_context_get_favicon_database_directory(cast[ptr WebContext00](self.impl))

proc webkit_web_context_get_plugins(self: ptr WebContext00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getPlugins*(self: WebContext; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_context_get_plugins(cast[ptr WebContext00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_context_get_sandbox_enabled(self: ptr WebContext00): gboolean {.
    importc, libprag.}

proc getSandboxEnabled*(self: WebContext): bool =
  toBool(webkit_web_context_get_sandbox_enabled(cast[ptr WebContext00](self.impl)))

proc sandboxEnabled*(self: WebContext): bool =
  toBool(webkit_web_context_get_sandbox_enabled(cast[ptr WebContext00](self.impl)))

proc webkit_web_context_get_spell_checking_enabled(self: ptr WebContext00): gboolean {.
    importc, libprag.}

proc getSpellCheckingEnabled*(self: WebContext): bool =
  toBool(webkit_web_context_get_spell_checking_enabled(cast[ptr WebContext00](self.impl)))

proc spellCheckingEnabled*(self: WebContext): bool =
  toBool(webkit_web_context_get_spell_checking_enabled(cast[ptr WebContext00](self.impl)))

proc webkit_web_context_get_spell_checking_languages(self: ptr WebContext00): ptr cstring {.
    importc, libprag.}

proc getSpellCheckingLanguages*(self: WebContext): seq[string] =
  cstringArrayToSeq(webkit_web_context_get_spell_checking_languages(cast[ptr WebContext00](self.impl)))

proc spellCheckingLanguages*(self: WebContext): seq[string] =
  cstringArrayToSeq(webkit_web_context_get_spell_checking_languages(cast[ptr WebContext00](self.impl)))

proc webkit_web_context_get_use_system_appearance_for_scrollbars(self: ptr WebContext00): gboolean {.
    importc, libprag.}

proc getUseSystemAppearanceForScrollbars*(self: WebContext): bool =
  toBool(webkit_web_context_get_use_system_appearance_for_scrollbars(cast[ptr WebContext00](self.impl)))

proc useSystemAppearanceForScrollbars*(self: WebContext): bool =
  toBool(webkit_web_context_get_use_system_appearance_for_scrollbars(cast[ptr WebContext00](self.impl)))

proc webkit_web_context_get_web_process_count_limit(self: ptr WebContext00): uint32 {.
    importc, libprag.}

proc getWebProcessCountLimit*(self: WebContext): int =
  int(webkit_web_context_get_web_process_count_limit(cast[ptr WebContext00](self.impl)))

proc webProcessCountLimit*(self: WebContext): int =
  int(webkit_web_context_get_web_process_count_limit(cast[ptr WebContext00](self.impl)))

proc webkit_web_context_initialize_notification_permissions(self: ptr WebContext00;
    allowedOrigins: ptr glib.List; disallowedOrigins: ptr glib.List) {.
    importc, libprag.}

proc initializeNotificationPermissions*(self: WebContext;
    allowedOrigins: seq[SecurityOrigin]; disallowedOrigins: seq[SecurityOrigin]) =
  var tempResGL = seq2GList(disallowedOrigins)
  webkit_web_context_initialize_notification_permissions(cast[ptr WebContext00](self.impl), tempResGL, tempResGL)
  g_list_free(tempResGL)

proc webkit_web_context_is_automation_allowed(self: ptr WebContext00): gboolean {.
    importc, libprag.}

proc isAutomationAllowed*(self: WebContext): bool =
  toBool(webkit_web_context_is_automation_allowed(cast[ptr WebContext00](self.impl)))

proc webkit_web_context_is_ephemeral(self: ptr WebContext00): gboolean {.
    importc, libprag.}

proc isEphemeral*(self: WebContext): bool =
  toBool(webkit_web_context_is_ephemeral(cast[ptr WebContext00](self.impl)))

proc webkit_web_context_prefetch_dns(self: ptr WebContext00; hostname: cstring) {.
    importc, libprag.}

proc prefetchDns*(self: WebContext; hostname: cstring) =
  webkit_web_context_prefetch_dns(cast[ptr WebContext00](self.impl), hostname)

proc webkit_web_context_send_message_to_all_extensions(self: ptr WebContext00;
    message: ptr UserMessage00) {.
    importc, libprag.}

proc sendMessageToAllExtensions*(self: WebContext;
    message: UserMessage) =
  webkit_web_context_send_message_to_all_extensions(cast[ptr WebContext00](self.impl), cast[ptr UserMessage00](message.impl))

proc webkit_web_context_set_additional_plugins_directory(self: ptr WebContext00;
    directory: cstring) {.
    importc, libprag.}

proc setAdditionalPluginsDirectory*(self: WebContext;
    directory: cstring) =
  webkit_web_context_set_additional_plugins_directory(cast[ptr WebContext00](self.impl), directory)

proc `additionalPluginsDirectory=`*(self: WebContext;
    directory: cstring) =
  webkit_web_context_set_additional_plugins_directory(cast[ptr WebContext00](self.impl), directory)

proc webkit_web_context_set_automation_allowed(self: ptr WebContext00; allowed: gboolean) {.
    importc, libprag.}

proc setAutomationAllowed*(self: WebContext; allowed: bool = true) =
  webkit_web_context_set_automation_allowed(cast[ptr WebContext00](self.impl), gboolean(allowed))

proc `automationAllowed=`*(self: WebContext; allowed: bool) =
  webkit_web_context_set_automation_allowed(cast[ptr WebContext00](self.impl), gboolean(allowed))

proc webkit_web_context_set_disk_cache_directory(self: ptr WebContext00;
    directory: cstring) {.
    importc, libprag.}

proc setDiskCacheDirectory*(self: WebContext; directory: cstring) =
  webkit_web_context_set_disk_cache_directory(cast[ptr WebContext00](self.impl), directory)

proc `diskCacheDirectory=`*(self: WebContext; directory: cstring) =
  webkit_web_context_set_disk_cache_directory(cast[ptr WebContext00](self.impl), directory)

proc webkit_web_context_set_favicon_database_directory(self: ptr WebContext00;
    path: cstring) {.
    importc, libprag.}

proc setFaviconDatabaseDirectory*(self: WebContext;
    path: cstring = nil) =
  webkit_web_context_set_favicon_database_directory(cast[ptr WebContext00](self.impl), path)

proc `faviconDatabaseDirectory=`*(self: WebContext;
    path: cstring = nil) =
  webkit_web_context_set_favicon_database_directory(cast[ptr WebContext00](self.impl), path)

proc webkit_web_context_set_preferred_languages(self: ptr WebContext00; languages: ptr cstring) {.
    importc, libprag.}

proc setPreferredLanguages*(self: WebContext; languages: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  webkit_web_context_set_preferred_languages(cast[ptr WebContext00](self.impl), seq2CstringArray(languages, fs469n23))

proc `preferredLanguages=`*(self: WebContext; languages: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  webkit_web_context_set_preferred_languages(cast[ptr WebContext00](self.impl), seq2CstringArray(languages, fs469n23))

proc webkit_web_context_set_sandbox_enabled(self: ptr WebContext00; enabled: gboolean) {.
    importc, libprag.}

proc setSandboxEnabled*(self: WebContext; enabled: bool = true) =
  webkit_web_context_set_sandbox_enabled(cast[ptr WebContext00](self.impl), gboolean(enabled))

proc `sandboxEnabled=`*(self: WebContext; enabled: bool) =
  webkit_web_context_set_sandbox_enabled(cast[ptr WebContext00](self.impl), gboolean(enabled))

proc webkit_web_context_set_spell_checking_enabled(self: ptr WebContext00;
    enabled: gboolean) {.
    importc, libprag.}

proc setSpellCheckingEnabled*(self: WebContext; enabled: bool = true) =
  webkit_web_context_set_spell_checking_enabled(cast[ptr WebContext00](self.impl), gboolean(enabled))

proc `spellCheckingEnabled=`*(self: WebContext; enabled: bool) =
  webkit_web_context_set_spell_checking_enabled(cast[ptr WebContext00](self.impl), gboolean(enabled))

proc webkit_web_context_set_spell_checking_languages(self: ptr WebContext00;
    languages: ptr cstring) {.
    importc, libprag.}

proc setSpellCheckingLanguages*(self: WebContext; languages: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  webkit_web_context_set_spell_checking_languages(cast[ptr WebContext00](self.impl), seq2CstringArray(languages, fs469n23))

proc `spellCheckingLanguages=`*(self: WebContext; languages: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  webkit_web_context_set_spell_checking_languages(cast[ptr WebContext00](self.impl), seq2CstringArray(languages, fs469n23))

proc webkit_web_context_set_use_system_appearance_for_scrollbars(self: ptr WebContext00;
    enabled: gboolean) {.
    importc, libprag.}

proc setUseSystemAppearanceForScrollbars*(self: WebContext;
    enabled: bool = true) =
  webkit_web_context_set_use_system_appearance_for_scrollbars(cast[ptr WebContext00](self.impl), gboolean(enabled))

proc `useSystemAppearanceForScrollbars=`*(self: WebContext;
    enabled: bool) =
  webkit_web_context_set_use_system_appearance_for_scrollbars(cast[ptr WebContext00](self.impl), gboolean(enabled))

proc webkit_web_context_set_web_extensions_directory(self: ptr WebContext00;
    directory: cstring) {.
    importc, libprag.}

proc setWebExtensionsDirectory*(self: WebContext; directory: cstring) =
  webkit_web_context_set_web_extensions_directory(cast[ptr WebContext00](self.impl), directory)

proc `webExtensionsDirectory=`*(self: WebContext; directory: cstring) =
  webkit_web_context_set_web_extensions_directory(cast[ptr WebContext00](self.impl), directory)

proc webkit_web_context_set_web_extensions_initialization_user_data(self: ptr WebContext00;
    userData: ptr glib.Variant00) {.
    importc, libprag.}

proc setWebExtensionsInitializationUserData*(self: WebContext;
    userData: glib.Variant) =
  webkit_web_context_set_web_extensions_initialization_user_data(cast[ptr WebContext00](self.impl), cast[ptr glib.Variant00](userData.impl))

proc `webExtensionsInitializationUserData=`*(self: WebContext;
    userData: glib.Variant) =
  webkit_web_context_set_web_extensions_initialization_user_data(cast[ptr WebContext00](self.impl), cast[ptr glib.Variant00](userData.impl))

proc webkit_web_context_set_web_process_count_limit(self: ptr WebContext00;
    limit: uint32) {.
    importc, libprag.}

proc setWebProcessCountLimit*(self: WebContext; limit: int) =
  webkit_web_context_set_web_process_count_limit(cast[ptr WebContext00](self.impl), uint32(limit))

proc `webProcessCountLimit=`*(self: WebContext; limit: int) =
  webkit_web_context_set_web_process_count_limit(cast[ptr WebContext00](self.impl), uint32(limit))

proc webkit_web_view_new_with_context(context: ptr WebContext00): ptr WebView00 {.
    importc, libprag.}

proc newWebViewWithContext*(context: WebContext): WebView =
  let gobj = webkit_web_view_new_with_context(cast[ptr WebContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebViewWithContext*(tdesc: typedesc; context: WebContext): tdesc =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_context(cast[ptr WebContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebViewWithContext*[T](result: var T; context: WebContext) {.deprecated.} =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_context(cast[ptr WebContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_get_context(self: ptr WebView00): ptr WebContext00 {.
    importc, libprag.}

proc getContext*(self: WebView): WebContext =
  let gobj = webkit_web_view_get_context(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: WebView): WebContext =
  let gobj = webkit_web_view_get_context(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  CookieManager* = ref object of gobject.Object
  CookieManager00* = object of gobject.Object00

proc webkit_cookie_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CookieManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: CookieManager;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc webkit_cookie_manager_add_cookie(self: ptr CookieManager00; cookie: ptr soup.Cookie00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc addCookie*(self: CookieManager; cookie: soup.Cookie;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_cookie_manager_add_cookie(cast[ptr CookieManager00](self.impl), cast[ptr soup.Cookie00](cookie.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_cookie_manager_add_cookie_finish(self: ptr CookieManager00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc addCookieFinish*(self: CookieManager; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_cookie_manager_add_cookie_finish(cast[ptr CookieManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_cookie_manager_delete_all_cookies(self: ptr CookieManager00) {.
    importc, libprag.}

proc deleteAllCookies*(self: CookieManager) =
  webkit_cookie_manager_delete_all_cookies(cast[ptr CookieManager00](self.impl))

proc webkit_cookie_manager_delete_cookie(self: ptr CookieManager00; cookie: ptr soup.Cookie00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc deleteCookie*(self: CookieManager; cookie: soup.Cookie;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_cookie_manager_delete_cookie(cast[ptr CookieManager00](self.impl), cast[ptr soup.Cookie00](cookie.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_cookie_manager_delete_cookie_finish(self: ptr CookieManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc deleteCookieFinish*(self: CookieManager; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_cookie_manager_delete_cookie_finish(cast[ptr CookieManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_cookie_manager_delete_cookies_for_domain(self: ptr CookieManager00;
    domain: cstring) {.
    importc, libprag.}

proc deleteCookiesForDomain*(self: CookieManager;
    domain: cstring) =
  webkit_cookie_manager_delete_cookies_for_domain(cast[ptr CookieManager00](self.impl), domain)

proc webkit_cookie_manager_get_accept_policy(self: ptr CookieManager00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getAcceptPolicy*(self: CookieManager; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  webkit_cookie_manager_get_accept_policy(cast[ptr CookieManager00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_cookie_manager_get_cookies(self: ptr CookieManager00; uri: cstring;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getCookies*(self: CookieManager; uri: cstring;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_cookie_manager_get_cookies(cast[ptr CookieManager00](self.impl), uri, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_cookie_manager_get_cookies_finish(self: ptr CookieManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr glib.List {.
    importc, libprag.}

proc getCookiesFinish*(self: CookieManager; resu: gio.AsyncResult): seq[soup.Cookie] =
  var gerror: ptr glib.Error
  let resul0 = webkit_cookie_manager_get_cookies_finish(cast[ptr CookieManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = glistStructs2seq[soup.Cookie](resul0, false)
  g_list_free(resul0)

proc webkit_cookie_manager_get_domains_with_cookies(self: ptr CookieManager00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getDomainsWithCookies*(self: CookieManager;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_cookie_manager_get_domains_with_cookies(cast[ptr CookieManager00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_cookie_manager_get_domains_with_cookies_finish(self: ptr CookieManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr cstring {.
    importc, libprag.}

proc getDomainsWithCookiesFinish*(self: CookieManager;
    resu: gio.AsyncResult): seq[string] =
  var gerror: ptr glib.Error
  let resul0 = webkit_cookie_manager_get_domains_with_cookies_finish(cast[ptr CookieManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = cstringArrayToSeq(resul0)

proc webkit_web_context_get_cookie_manager(self: ptr WebContext00): ptr CookieManager00 {.
    importc, libprag.}

proc getCookieManager*(self: WebContext): CookieManager =
  let gobj = webkit_web_context_get_cookie_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc cookieManager*(self: WebContext): CookieManager =
  let gobj = webkit_web_context_get_cookie_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  CookieAcceptPolicy* {.size: sizeof(cint), pure.} = enum
    always = 0
    never = 1
    noThirdParty = 2

proc webkit_cookie_manager_get_accept_policy_finish(self: ptr CookieManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): CookieAcceptPolicy {.
    importc, libprag.}

proc getAcceptPolicyFinish*(self: CookieManager;
    resu: gio.AsyncResult): CookieAcceptPolicy =
  var gerror: ptr glib.Error
  let resul0 = webkit_cookie_manager_get_accept_policy_finish(cast[ptr CookieManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_cookie_manager_set_accept_policy(self: ptr CookieManager00; policy: CookieAcceptPolicy) {.
    importc, libprag.}

proc setAcceptPolicy*(self: CookieManager; policy: CookieAcceptPolicy) =
  webkit_cookie_manager_set_accept_policy(cast[ptr CookieManager00](self.impl), policy)

proc `acceptPolicy=`*(self: CookieManager; policy: CookieAcceptPolicy) =
  webkit_cookie_manager_set_accept_policy(cast[ptr CookieManager00](self.impl), policy)

type
  CookiePersistentStorage* {.size: sizeof(cint), pure.} = enum
    text = 0
    sqlite = 1

proc webkit_cookie_manager_set_persistent_storage(self: ptr CookieManager00;
    filename: cstring; storage: CookiePersistentStorage) {.
    importc, libprag.}

proc setPersistentStorage*(self: CookieManager; filename: cstring;
    storage: CookiePersistentStorage) =
  webkit_cookie_manager_set_persistent_storage(cast[ptr CookieManager00](self.impl), filename, storage)

type
  FaviconDatabase* = ref object of gobject.Object
  FaviconDatabase00* = object of gobject.Object00

proc webkit_favicon_database_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FaviconDatabase()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scFaviconChanged*(self: FaviconDatabase;  p: proc (self: ptr FaviconDatabase00; pageUri: cstring; faviconUri: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "favicon-changed", cast[GCallback](p), xdata, nil, cf)

proc webkit_favicon_database_clear(self: ptr FaviconDatabase00) {.
    importc, libprag.}

proc clear*(self: FaviconDatabase) =
  webkit_favicon_database_clear(cast[ptr FaviconDatabase00](self.impl))

proc webkit_favicon_database_get_favicon(self: ptr FaviconDatabase00; pageUri: cstring;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getFavicon*(self: FaviconDatabase; pageUri: cstring;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_favicon_database_get_favicon(cast[ptr FaviconDatabase00](self.impl), pageUri, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_favicon_database_get_favicon_finish(self: ptr FaviconDatabase00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr cairo.Surface00 {.
    importc, libprag.}

proc getFaviconFinish*(self: FaviconDatabase; resu: gio.AsyncResult): cairo.Surface =
  var gerror: ptr glib.Error
  let impl0 = webkit_favicon_database_get_favicon_finish(cast[ptr FaviconDatabase00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = impl0

proc webkit_favicon_database_get_favicon_uri(self: ptr FaviconDatabase00;
    pageUri: cstring): cstring {.
    importc, libprag.}

proc getFaviconUri*(self: FaviconDatabase; pageUri: cstring): string =
  let resul0 = webkit_favicon_database_get_favicon_uri(cast[ptr FaviconDatabase00](self.impl), pageUri)
  result = $resul0
  cogfree(resul0)

proc webkit_web_context_get_favicon_database(self: ptr WebContext00): ptr FaviconDatabase00 {.
    importc, libprag.}

proc getFaviconDatabase*(self: WebContext): FaviconDatabase =
  let gobj = webkit_web_context_get_favicon_database(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc faviconDatabase*(self: WebContext): FaviconDatabase =
  let gobj = webkit_web_context_get_favicon_database(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GeolocationManager* = ref object of gobject.Object
  GeolocationManager00* = object of gobject.Object00

proc webkit_geolocation_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GeolocationManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scStart*(self: GeolocationManager;  p: proc (self: ptr GeolocationManager00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "start", cast[GCallback](p), xdata, nil, cf)

proc scStop*(self: GeolocationManager;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "stop", cast[GCallback](p), xdata, nil, cf)

proc webkit_geolocation_manager_failed(self: ptr GeolocationManager00; errorMessage: cstring) {.
    importc, libprag.}

proc failed*(self: GeolocationManager; errorMessage: cstring) =
  webkit_geolocation_manager_failed(cast[ptr GeolocationManager00](self.impl), errorMessage)

proc webkit_geolocation_manager_get_enable_high_accuracy(self: ptr GeolocationManager00): gboolean {.
    importc, libprag.}

proc getEnableHighAccuracy*(self: GeolocationManager): bool =
  toBool(webkit_geolocation_manager_get_enable_high_accuracy(cast[ptr GeolocationManager00](self.impl)))

proc enableHighAccuracy*(self: GeolocationManager): bool =
  toBool(webkit_geolocation_manager_get_enable_high_accuracy(cast[ptr GeolocationManager00](self.impl)))

proc webkit_web_context_get_geolocation_manager(self: ptr WebContext00): ptr GeolocationManager00 {.
    importc, libprag.}

proc getGeolocationManager*(self: WebContext): GeolocationManager =
  let gobj = webkit_web_context_get_geolocation_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc geolocationManager*(self: WebContext): GeolocationManager =
  let gobj = webkit_web_context_get_geolocation_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GeolocationPosition00* {.pure.} = object
  GeolocationPosition* = ref object
    impl*: ptr GeolocationPosition00
    ignoreFinalizer*: bool

proc webkit_geolocation_position_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitGeolocationPosition*(self: GeolocationPosition) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_geolocation_position_get_type(), cast[ptr GeolocationPosition00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GeolocationPosition()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_geolocation_position_get_type(), cast[ptr GeolocationPosition00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GeolocationPosition) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitGeolocationPosition)

proc webkit_geolocation_position_free(self: ptr GeolocationPosition00) {.
    importc, libprag.}

proc free*(self: GeolocationPosition) =
  webkit_geolocation_position_free(cast[ptr GeolocationPosition00](self.impl))

proc finalizerfree*(self: GeolocationPosition) =
  if not self.ignoreFinalizer:
    webkit_geolocation_position_free(cast[ptr GeolocationPosition00](self.impl))

proc webkit_geolocation_position_copy(self: ptr GeolocationPosition00): ptr GeolocationPosition00 {.
    importc, libprag.}

proc copy*(self: GeolocationPosition): GeolocationPosition =
  fnew(result, gBoxedFreeWebKitGeolocationPosition)
  result.impl = webkit_geolocation_position_copy(cast[ptr GeolocationPosition00](self.impl))

proc webkit_geolocation_position_new(latitude: cdouble; longitude: cdouble;
    accuracy: cdouble): ptr GeolocationPosition00 {.
    importc, libprag.}

proc newGeolocationPosition*(latitude: cdouble; longitude: cdouble;
    accuracy: cdouble): GeolocationPosition =
  fnew(result, gBoxedFreeWebKitGeolocationPosition)
  result.impl = webkit_geolocation_position_new(latitude, longitude, accuracy)

proc newGeolocationPosition*(tdesc: typedesc; latitude: cdouble; longitude: cdouble;
    accuracy: cdouble): tdesc =
  assert(result is GeolocationPosition)
  fnew(result, gBoxedFreeWebKitGeolocationPosition)
  result.impl = webkit_geolocation_position_new(latitude, longitude, accuracy)

proc initGeolocationPosition*[T](result: var T; latitude: cdouble; longitude: cdouble;
    accuracy: cdouble) {.deprecated.} =
  assert(result is GeolocationPosition)
  fnew(result, gBoxedFreeWebKitGeolocationPosition)
  result.impl = webkit_geolocation_position_new(latitude, longitude, accuracy)

proc webkit_geolocation_position_set_altitude(self: ptr GeolocationPosition00;
    altitude: cdouble) {.
    importc, libprag.}

proc setAltitude*(self: GeolocationPosition;
    altitude: cdouble) =
  webkit_geolocation_position_set_altitude(cast[ptr GeolocationPosition00](self.impl), altitude)

proc `altitude=`*(self: GeolocationPosition;
    altitude: cdouble) =
  webkit_geolocation_position_set_altitude(cast[ptr GeolocationPosition00](self.impl), altitude)

proc webkit_geolocation_position_set_altitude_accuracy(self: ptr GeolocationPosition00;
    altitudeAccuracy: cdouble) {.
    importc, libprag.}

proc setAltitudeAccuracy*(self: GeolocationPosition;
    altitudeAccuracy: cdouble) =
  webkit_geolocation_position_set_altitude_accuracy(cast[ptr GeolocationPosition00](self.impl), altitudeAccuracy)

proc `altitudeAccuracy=`*(self: GeolocationPosition;
    altitudeAccuracy: cdouble) =
  webkit_geolocation_position_set_altitude_accuracy(cast[ptr GeolocationPosition00](self.impl), altitudeAccuracy)

proc webkit_geolocation_position_set_heading(self: ptr GeolocationPosition00;
    heading: cdouble) {.
    importc, libprag.}

proc setHeading*(self: GeolocationPosition; heading: cdouble) =
  webkit_geolocation_position_set_heading(cast[ptr GeolocationPosition00](self.impl), heading)

proc `heading=`*(self: GeolocationPosition; heading: cdouble) =
  webkit_geolocation_position_set_heading(cast[ptr GeolocationPosition00](self.impl), heading)

proc webkit_geolocation_position_set_speed(self: ptr GeolocationPosition00;
    speed: cdouble) {.
    importc, libprag.}

proc setSpeed*(self: GeolocationPosition; speed: cdouble) =
  webkit_geolocation_position_set_speed(cast[ptr GeolocationPosition00](self.impl), speed)

proc `speed=`*(self: GeolocationPosition; speed: cdouble) =
  webkit_geolocation_position_set_speed(cast[ptr GeolocationPosition00](self.impl), speed)

proc webkit_geolocation_position_set_timestamp(self: ptr GeolocationPosition00;
    timestamp: uint64) {.
    importc, libprag.}

proc setTimestamp*(self: GeolocationPosition;
    timestamp: uint64) =
  webkit_geolocation_position_set_timestamp(cast[ptr GeolocationPosition00](self.impl), timestamp)

proc `timestamp=`*(self: GeolocationPosition;
    timestamp: uint64) =
  webkit_geolocation_position_set_timestamp(cast[ptr GeolocationPosition00](self.impl), timestamp)

proc webkit_geolocation_manager_update_position(self: ptr GeolocationManager00;
    position: ptr GeolocationPosition00) {.
    importc, libprag.}

proc updatePosition*(self: GeolocationManager;
    position: GeolocationPosition) =
  webkit_geolocation_manager_update_position(cast[ptr GeolocationManager00](self.impl), cast[ptr GeolocationPosition00](position.impl))

type
  Plugin* = ref object of gobject.Object
  Plugin00* = object of gobject.Object00

proc webkit_plugin_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Plugin()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_plugin_get_description(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getDescription*(self: Plugin): string =
  result = $webkit_plugin_get_description(cast[ptr Plugin00](self.impl))

proc description*(self: Plugin): string =
  result = $webkit_plugin_get_description(cast[ptr Plugin00](self.impl))

proc webkit_plugin_get_name(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getName*(self: Plugin): string =
  result = $webkit_plugin_get_name(cast[ptr Plugin00](self.impl))

proc name*(self: Plugin): string =
  result = $webkit_plugin_get_name(cast[ptr Plugin00](self.impl))

proc webkit_plugin_get_path(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getPath*(self: Plugin): string =
  result = $webkit_plugin_get_path(cast[ptr Plugin00](self.impl))

proc path*(self: Plugin): string =
  result = $webkit_plugin_get_path(cast[ptr Plugin00](self.impl))

proc webkit_web_context_get_plugins_finish(self: ptr WebContext00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr glib.List {.
    importc, libprag.}

proc getPluginsFinish*(self: WebContext; resu: gio.AsyncResult): seq[Plugin] =
  var gerror: ptr glib.Error
  let resul0 = webkit_web_context_get_plugins_finish(cast[ptr WebContext00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = glistObjects2seq(Plugin, resul0, true)
  g_list_free(resul0)

type
  MimeInfo00* {.pure.} = object
  MimeInfo* = ref object
    impl*: ptr MimeInfo00
    ignoreFinalizer*: bool

proc webkit_mime_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitMimeInfo*(self: MimeInfo) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_mime_info_get_type(), cast[ptr MimeInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MimeInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_mime_info_get_type(), cast[ptr MimeInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MimeInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitMimeInfo)

proc webkit_mime_info_unref(self: ptr MimeInfo00) {.
    importc, libprag.}

proc unref*(self: MimeInfo) =
  webkit_mime_info_unref(cast[ptr MimeInfo00](self.impl))

proc finalizerunref*(self: MimeInfo) =
  if not self.ignoreFinalizer:
    webkit_mime_info_unref(cast[ptr MimeInfo00](self.impl))

proc webkit_mime_info_get_extensions(self: ptr MimeInfo00): ptr cstring {.
    importc, libprag.}

proc getExtensions*(self: MimeInfo): seq[string] =
  cstringArrayToSeq(webkit_mime_info_get_extensions(cast[ptr MimeInfo00](self.impl)))

proc extensions*(self: MimeInfo): seq[string] =
  cstringArrayToSeq(webkit_mime_info_get_extensions(cast[ptr MimeInfo00](self.impl)))

proc webkit_mime_info_get_mime_type(self: ptr MimeInfo00): cstring {.
    importc, libprag.}

proc getMimeType*(self: MimeInfo): string =
  result = $webkit_mime_info_get_mime_type(cast[ptr MimeInfo00](self.impl))

proc mimeType*(self: MimeInfo): string =
  result = $webkit_mime_info_get_mime_type(cast[ptr MimeInfo00](self.impl))

proc webkit_mime_info_ref(self: ptr MimeInfo00): ptr MimeInfo00 {.
    importc, libprag.}

proc `ref`*(self: MimeInfo): MimeInfo =
  fnew(result, gBoxedFreeWebKitMimeInfo)
  result.impl = webkit_mime_info_ref(cast[ptr MimeInfo00](self.impl))

proc webkit_mime_info_get_description(self: ptr MimeInfo00): cstring {.
    importc, libprag.}

proc getDescription*(self: MimeInfo): string =
  result = $webkit_mime_info_get_description(cast[ptr MimeInfo00](self.impl))

proc description*(self: MimeInfo): string =
  result = $webkit_mime_info_get_description(cast[ptr MimeInfo00](self.impl))

proc webkit_plugin_get_mime_info_list(self: ptr Plugin00): ptr glib.List {.
    importc, libprag.}

proc getMimeInfoList*(self: Plugin): seq[MimeInfo] =
  discard

proc mimeInfoList*(self: Plugin): seq[MimeInfo] =
  discard

type
  SecurityManager* = ref object of gobject.Object
  SecurityManager00* = object of gobject.Object00

proc webkit_security_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SecurityManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_security_manager_register_uri_scheme_as_cors_enabled(self: ptr SecurityManager00;
    scheme: cstring) {.
    importc, libprag.}

proc registerUriSchemeAsCorsEnabled*(self: SecurityManager;
    scheme: cstring) =
  webkit_security_manager_register_uri_scheme_as_cors_enabled(cast[ptr SecurityManager00](self.impl), scheme)

proc webkit_security_manager_register_uri_scheme_as_display_isolated(self: ptr SecurityManager00;
    scheme: cstring) {.
    importc, libprag.}

proc registerUriSchemeAsDisplayIsolated*(self: SecurityManager;
    scheme: cstring) =
  webkit_security_manager_register_uri_scheme_as_display_isolated(cast[ptr SecurityManager00](self.impl), scheme)

proc webkit_security_manager_register_uri_scheme_as_empty_document(self: ptr SecurityManager00;
    scheme: cstring) {.
    importc, libprag.}

proc registerUriSchemeAsEmptyDocument*(self: SecurityManager;
    scheme: cstring) =
  webkit_security_manager_register_uri_scheme_as_empty_document(cast[ptr SecurityManager00](self.impl), scheme)

proc webkit_security_manager_register_uri_scheme_as_local(self: ptr SecurityManager00;
    scheme: cstring) {.
    importc, libprag.}

proc registerUriSchemeAsLocal*(self: SecurityManager;
    scheme: cstring) =
  webkit_security_manager_register_uri_scheme_as_local(cast[ptr SecurityManager00](self.impl), scheme)

proc webkit_security_manager_register_uri_scheme_as_no_access(self: ptr SecurityManager00;
    scheme: cstring) {.
    importc, libprag.}

proc registerUriSchemeAsNoAccess*(self: SecurityManager;
    scheme: cstring) =
  webkit_security_manager_register_uri_scheme_as_no_access(cast[ptr SecurityManager00](self.impl), scheme)

proc webkit_security_manager_register_uri_scheme_as_secure(self: ptr SecurityManager00;
    scheme: cstring) {.
    importc, libprag.}

proc registerUriSchemeAsSecure*(self: SecurityManager;
    scheme: cstring) =
  webkit_security_manager_register_uri_scheme_as_secure(cast[ptr SecurityManager00](self.impl), scheme)

proc webkit_security_manager_uri_scheme_is_cors_enabled(self: ptr SecurityManager00;
    scheme: cstring): gboolean {.
    importc, libprag.}

proc uriSchemeIsCorsEnabled*(self: SecurityManager;
    scheme: cstring): bool =
  toBool(webkit_security_manager_uri_scheme_is_cors_enabled(cast[ptr SecurityManager00](self.impl), scheme))

proc webkit_security_manager_uri_scheme_is_display_isolated(self: ptr SecurityManager00;
    scheme: cstring): gboolean {.
    importc, libprag.}

proc uriSchemeIsDisplayIsolated*(self: SecurityManager;
    scheme: cstring): bool =
  toBool(webkit_security_manager_uri_scheme_is_display_isolated(cast[ptr SecurityManager00](self.impl), scheme))

proc webkit_security_manager_uri_scheme_is_empty_document(self: ptr SecurityManager00;
    scheme: cstring): gboolean {.
    importc, libprag.}

proc uriSchemeIsEmptyDocument*(self: SecurityManager;
    scheme: cstring): bool =
  toBool(webkit_security_manager_uri_scheme_is_empty_document(cast[ptr SecurityManager00](self.impl), scheme))

proc webkit_security_manager_uri_scheme_is_local(self: ptr SecurityManager00;
    scheme: cstring): gboolean {.
    importc, libprag.}

proc uriSchemeIsLocal*(self: SecurityManager; scheme: cstring): bool =
  toBool(webkit_security_manager_uri_scheme_is_local(cast[ptr SecurityManager00](self.impl), scheme))

proc webkit_security_manager_uri_scheme_is_no_access(self: ptr SecurityManager00;
    scheme: cstring): gboolean {.
    importc, libprag.}

proc uriSchemeIsNoAccess*(self: SecurityManager;
    scheme: cstring): bool =
  toBool(webkit_security_manager_uri_scheme_is_no_access(cast[ptr SecurityManager00](self.impl), scheme))

proc webkit_security_manager_uri_scheme_is_secure(self: ptr SecurityManager00;
    scheme: cstring): gboolean {.
    importc, libprag.}

proc uriSchemeIsSecure*(self: SecurityManager;
    scheme: cstring): bool =
  toBool(webkit_security_manager_uri_scheme_is_secure(cast[ptr SecurityManager00](self.impl), scheme))

proc webkit_web_context_get_security_manager(self: ptr WebContext00): ptr SecurityManager00 {.
    importc, libprag.}

proc getSecurityManager*(self: WebContext): SecurityManager =
  let gobj = webkit_web_context_get_security_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc securityManager*(self: WebContext): SecurityManager =
  let gobj = webkit_web_context_get_security_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  CacheModel* {.size: sizeof(cint), pure.} = enum
    documentViewer = 0
    webBrowser = 1
    documentBrowser = 2

proc webkit_web_context_get_cache_model(self: ptr WebContext00): CacheModel {.
    importc, libprag.}

proc getCacheModel*(self: WebContext): CacheModel =
  webkit_web_context_get_cache_model(cast[ptr WebContext00](self.impl))

proc cacheModel*(self: WebContext): CacheModel =
  webkit_web_context_get_cache_model(cast[ptr WebContext00](self.impl))

proc webkit_web_context_set_cache_model(self: ptr WebContext00; cacheModel: CacheModel) {.
    importc, libprag.}

proc setCacheModel*(self: WebContext; cacheModel: CacheModel) =
  webkit_web_context_set_cache_model(cast[ptr WebContext00](self.impl), cacheModel)

proc `cacheModel=`*(self: WebContext; cacheModel: CacheModel) =
  webkit_web_context_set_cache_model(cast[ptr WebContext00](self.impl), cacheModel)

type
  NetworkProxyMode* {.size: sizeof(cint), pure.} = enum
    default = 0
    noProxy = 1
    custom = 2

type
  NetworkProxySettings00* {.pure.} = object
  NetworkProxySettings* = ref object
    impl*: ptr NetworkProxySettings00
    ignoreFinalizer*: bool

proc webkit_network_proxy_settings_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitNetworkProxySettings*(self: NetworkProxySettings) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_network_proxy_settings_get_type(), cast[ptr NetworkProxySettings00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NetworkProxySettings()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_network_proxy_settings_get_type(), cast[ptr NetworkProxySettings00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var NetworkProxySettings) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitNetworkProxySettings)

proc webkit_network_proxy_settings_free(self: ptr NetworkProxySettings00) {.
    importc, libprag.}

proc free*(self: NetworkProxySettings) =
  webkit_network_proxy_settings_free(cast[ptr NetworkProxySettings00](self.impl))

proc finalizerfree*(self: NetworkProxySettings) =
  if not self.ignoreFinalizer:
    webkit_network_proxy_settings_free(cast[ptr NetworkProxySettings00](self.impl))

proc webkit_network_proxy_settings_add_proxy_for_scheme(self: ptr NetworkProxySettings00;
    scheme: cstring; proxyUri: cstring) {.
    importc, libprag.}

proc addProxyForScheme*(self: NetworkProxySettings;
    scheme: cstring; proxyUri: cstring) =
  webkit_network_proxy_settings_add_proxy_for_scheme(cast[ptr NetworkProxySettings00](self.impl), scheme, proxyUri)

proc webkit_network_proxy_settings_copy(self: ptr NetworkProxySettings00): ptr NetworkProxySettings00 {.
    importc, libprag.}

proc copy*(self: NetworkProxySettings): NetworkProxySettings =
  fnew(result, gBoxedFreeWebKitNetworkProxySettings)
  result.impl = webkit_network_proxy_settings_copy(cast[ptr NetworkProxySettings00](self.impl))

proc webkit_network_proxy_settings_new(defaultProxyUri: cstring; ignoreHosts: ptr cstring): ptr NetworkProxySettings00 {.
    importc, libprag.}

proc newNetworkProxySettings*(defaultProxyUri: cstring = nil; ignoreHosts: varargs[string, `$`]): NetworkProxySettings =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, gBoxedFreeWebKitNetworkProxySettings)
  result.impl = webkit_network_proxy_settings_new(defaultProxyUri, seq2CstringArray(ignoreHosts, fs469n23))

proc newNetworkProxySettings*(tdesc: typedesc; defaultProxyUri: cstring = nil; ignoreHosts: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is NetworkProxySettings)
  fnew(result, gBoxedFreeWebKitNetworkProxySettings)
  result.impl = webkit_network_proxy_settings_new(defaultProxyUri, seq2CstringArray(ignoreHosts, fs469n23))

proc initNetworkProxySettings*[T](result: var T; defaultProxyUri: cstring = nil; ignoreHosts: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is NetworkProxySettings)
  fnew(result, gBoxedFreeWebKitNetworkProxySettings)
  result.impl = webkit_network_proxy_settings_new(defaultProxyUri, seq2CstringArray(ignoreHosts, fs469n23))

proc webkit_web_context_set_network_proxy_settings(self: ptr WebContext00;
    proxyMode: NetworkProxyMode; proxySettings: ptr NetworkProxySettings00) {.
    importc, libprag.}

proc setNetworkProxySettings*(self: WebContext; proxyMode: NetworkProxyMode;
    proxySettings: NetworkProxySettings = nil) =
  webkit_web_context_set_network_proxy_settings(cast[ptr WebContext00](self.impl), proxyMode, if proxySettings.isNil: nil else: cast[ptr NetworkProxySettings00](proxySettings.impl))

type
  ProcessModel* {.size: sizeof(cint), pure.} = enum
    sharedSecondaryProcess = 0
    multipleSecondaryProcesses = 1

proc webkit_web_context_get_process_model(self: ptr WebContext00): ProcessModel {.
    importc, libprag.}

proc getProcessModel*(self: WebContext): ProcessModel =
  webkit_web_context_get_process_model(cast[ptr WebContext00](self.impl))

proc processModel*(self: WebContext): ProcessModel =
  webkit_web_context_get_process_model(cast[ptr WebContext00](self.impl))

proc webkit_web_context_set_process_model(self: ptr WebContext00; processModel: ProcessModel) {.
    importc, libprag.}

proc setProcessModel*(self: WebContext; processModel: ProcessModel) =
  webkit_web_context_set_process_model(cast[ptr WebContext00](self.impl), processModel)

proc `processModel=`*(self: WebContext; processModel: ProcessModel) =
  webkit_web_context_set_process_model(cast[ptr WebContext00](self.impl), processModel)

type
  TLSErrorsPolicy* {.size: sizeof(cint), pure.} = enum
    ignore = 0
    fail = 1

proc webkit_web_context_get_tls_errors_policy(self: ptr WebContext00): TLSErrorsPolicy {.
    importc, libprag.}

proc getTlsErrorsPolicy*(self: WebContext): TLSErrorsPolicy =
  webkit_web_context_get_tls_errors_policy(cast[ptr WebContext00](self.impl))

proc tlsErrorsPolicy*(self: WebContext): TLSErrorsPolicy =
  webkit_web_context_get_tls_errors_policy(cast[ptr WebContext00](self.impl))

proc webkit_web_context_set_tls_errors_policy(self: ptr WebContext00; policy: TLSErrorsPolicy) {.
    importc, libprag.}

proc setTlsErrorsPolicy*(self: WebContext; policy: TLSErrorsPolicy) =
  webkit_web_context_set_tls_errors_policy(cast[ptr WebContext00](self.impl), policy)

proc `tlsErrorsPolicy=`*(self: WebContext; policy: TLSErrorsPolicy) =
  webkit_web_context_set_tls_errors_policy(cast[ptr WebContext00](self.impl), policy)

type
  EditorState* = ref object of gobject.Object
  EditorState00* = object of gobject.Object00

proc webkit_editor_state_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EditorState()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_editor_state_get_typing_attributes(self: ptr EditorState00): uint32 {.
    importc, libprag.}

proc getTypingAttributes*(self: EditorState): int =
  int(webkit_editor_state_get_typing_attributes(cast[ptr EditorState00](self.impl)))

proc typingAttributes*(self: EditorState): int =
  int(webkit_editor_state_get_typing_attributes(cast[ptr EditorState00](self.impl)))

proc webkit_editor_state_is_copy_available(self: ptr EditorState00): gboolean {.
    importc, libprag.}

proc isCopyAvailable*(self: EditorState): bool =
  toBool(webkit_editor_state_is_copy_available(cast[ptr EditorState00](self.impl)))

proc webkit_editor_state_is_cut_available(self: ptr EditorState00): gboolean {.
    importc, libprag.}

proc isCutAvailable*(self: EditorState): bool =
  toBool(webkit_editor_state_is_cut_available(cast[ptr EditorState00](self.impl)))

proc webkit_editor_state_is_paste_available(self: ptr EditorState00): gboolean {.
    importc, libprag.}

proc isPasteAvailable*(self: EditorState): bool =
  toBool(webkit_editor_state_is_paste_available(cast[ptr EditorState00](self.impl)))

proc webkit_editor_state_is_redo_available(self: ptr EditorState00): gboolean {.
    importc, libprag.}

proc isRedoAvailable*(self: EditorState): bool =
  toBool(webkit_editor_state_is_redo_available(cast[ptr EditorState00](self.impl)))

proc webkit_editor_state_is_undo_available(self: ptr EditorState00): gboolean {.
    importc, libprag.}

proc isUndoAvailable*(self: EditorState): bool =
  toBool(webkit_editor_state_is_undo_available(cast[ptr EditorState00](self.impl)))

proc webkit_web_view_get_editor_state(self: ptr WebView00): ptr EditorState00 {.
    importc, libprag.}

proc getEditorState*(self: WebView): EditorState =
  let gobj = webkit_web_view_get_editor_state(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc editorState*(self: WebView): EditorState =
  let gobj = webkit_web_view_get_editor_state(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  FindController* = ref object of gobject.Object
  FindController00* = object of gobject.Object00

proc webkit_find_controller_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FindController()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCountedMatches*(self: FindController;  p: proc (self: ptr FindController00; matchCount: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "counted-matches", cast[GCallback](p), xdata, nil, cf)

proc scFailedToFindText*(self: FindController;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "failed-to-find-text", cast[GCallback](p), xdata, nil, cf)

proc scFoundText*(self: FindController;  p: proc (self: ptr FindController00; matchCount: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "found-text", cast[GCallback](p), xdata, nil, cf)

proc webkit_find_controller_count_matches(self: ptr FindController00; searchText: cstring;
    findOptions: uint32; maxMatchCount: uint32) {.
    importc, libprag.}

proc countMatches*(self: FindController; searchText: cstring;
    findOptions: int; maxMatchCount: int) =
  webkit_find_controller_count_matches(cast[ptr FindController00](self.impl), searchText, uint32(findOptions), uint32(maxMatchCount))

proc webkit_find_controller_get_max_match_count(self: ptr FindController00): uint32 {.
    importc, libprag.}

proc getMaxMatchCount*(self: FindController): int =
  int(webkit_find_controller_get_max_match_count(cast[ptr FindController00](self.impl)))

proc maxMatchCount*(self: FindController): int =
  int(webkit_find_controller_get_max_match_count(cast[ptr FindController00](self.impl)))

proc webkit_find_controller_get_options(self: ptr FindController00): uint32 {.
    importc, libprag.}

proc getOptions*(self: FindController): int =
  int(webkit_find_controller_get_options(cast[ptr FindController00](self.impl)))

proc options*(self: FindController): int =
  int(webkit_find_controller_get_options(cast[ptr FindController00](self.impl)))

proc webkit_find_controller_get_search_text(self: ptr FindController00): cstring {.
    importc, libprag.}

proc getSearchText*(self: FindController): string =
  result = $webkit_find_controller_get_search_text(cast[ptr FindController00](self.impl))

proc searchText*(self: FindController): string =
  result = $webkit_find_controller_get_search_text(cast[ptr FindController00](self.impl))

proc webkit_find_controller_get_web_view(self: ptr FindController00): ptr WebView00 {.
    importc, libprag.}

proc getWebView*(self: FindController): WebView =
  let gobj = webkit_find_controller_get_web_view(cast[ptr FindController00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webView*(self: FindController): WebView =
  let gobj = webkit_find_controller_get_web_view(cast[ptr FindController00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_find_controller_search(self: ptr FindController00; searchText: cstring;
    findOptions: uint32; maxMatchCount: uint32) {.
    importc, libprag.}

proc search*(self: FindController; searchText: cstring;
    findOptions: int; maxMatchCount: int) =
  webkit_find_controller_search(cast[ptr FindController00](self.impl), searchText, uint32(findOptions), uint32(maxMatchCount))

proc webkit_find_controller_search_finish(self: ptr FindController00) {.
    importc, libprag.}

proc searchFinish*(self: FindController) =
  webkit_find_controller_search_finish(cast[ptr FindController00](self.impl))

proc webkit_find_controller_search_next(self: ptr FindController00) {.
    importc, libprag.}

proc searchNext*(self: FindController) =
  webkit_find_controller_search_next(cast[ptr FindController00](self.impl))

proc webkit_find_controller_search_previous(self: ptr FindController00) {.
    importc, libprag.}

proc searchPrevious*(self: FindController) =
  webkit_find_controller_search_previous(cast[ptr FindController00](self.impl))

proc webkit_web_view_get_find_controller(self: ptr WebView00): ptr FindController00 {.
    importc, libprag.}

proc getFindController*(self: WebView): FindController =
  let gobj = webkit_web_view_get_find_controller(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc findController*(self: WebView): FindController =
  let gobj = webkit_web_view_get_find_controller(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  WebInspector* = ref object of gobject.Object
  WebInspector00* = object of gobject.Object00

proc webkit_web_inspector_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebInspector()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAttach*(self: WebInspector;  p: proc (self: ptr WebInspector00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "attach", cast[GCallback](p), xdata, nil, cf)

proc scBringToFront*(self: WebInspector;  p: proc (self: ptr WebInspector00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "bring-to-front", cast[GCallback](p), xdata, nil, cf)

proc scClosed*(self: WebInspector;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc scDetach*(self: WebInspector;  p: proc (self: ptr WebInspector00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "detach", cast[GCallback](p), xdata, nil, cf)

proc scOpenWindow*(self: WebInspector;  p: proc (self: ptr WebInspector00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "open-window", cast[GCallback](p), xdata, nil, cf)

proc webkit_web_inspector_attach(self: ptr WebInspector00) {.
    importc, libprag.}

proc attach*(self: WebInspector) =
  webkit_web_inspector_attach(cast[ptr WebInspector00](self.impl))

proc webkit_web_inspector_close(self: ptr WebInspector00) {.
    importc, libprag.}

proc close*(self: WebInspector) =
  webkit_web_inspector_close(cast[ptr WebInspector00](self.impl))

proc webkit_web_inspector_detach(self: ptr WebInspector00) {.
    importc, libprag.}

proc detach*(self: WebInspector) =
  webkit_web_inspector_detach(cast[ptr WebInspector00](self.impl))

proc webkit_web_inspector_get_attached_height(self: ptr WebInspector00): uint32 {.
    importc, libprag.}

proc getAttachedHeight*(self: WebInspector): int =
  int(webkit_web_inspector_get_attached_height(cast[ptr WebInspector00](self.impl)))

proc attachedHeight*(self: WebInspector): int =
  int(webkit_web_inspector_get_attached_height(cast[ptr WebInspector00](self.impl)))

proc webkit_web_inspector_get_can_attach(self: ptr WebInspector00): gboolean {.
    importc, libprag.}

proc getCanAttach*(self: WebInspector): bool =
  toBool(webkit_web_inspector_get_can_attach(cast[ptr WebInspector00](self.impl)))

proc canAttach*(self: WebInspector): bool =
  toBool(webkit_web_inspector_get_can_attach(cast[ptr WebInspector00](self.impl)))

proc webkit_web_inspector_get_inspected_uri(self: ptr WebInspector00): cstring {.
    importc, libprag.}

proc getInspectedUri*(self: WebInspector): string =
  result = $webkit_web_inspector_get_inspected_uri(cast[ptr WebInspector00](self.impl))

proc inspectedUri*(self: WebInspector): string =
  result = $webkit_web_inspector_get_inspected_uri(cast[ptr WebInspector00](self.impl))

proc webkit_web_inspector_get_web_view(self: ptr WebInspector00): ptr WebViewBase00 {.
    importc, libprag.}

proc getWebView*(self: WebInspector): WebViewBase =
  let gobj = webkit_web_inspector_get_web_view(cast[ptr WebInspector00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webView*(self: WebInspector): WebViewBase =
  let gobj = webkit_web_inspector_get_web_view(cast[ptr WebInspector00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_inspector_is_attached(self: ptr WebInspector00): gboolean {.
    importc, libprag.}

proc isAttached*(self: WebInspector): bool =
  toBool(webkit_web_inspector_is_attached(cast[ptr WebInspector00](self.impl)))

proc webkit_web_inspector_show(self: ptr WebInspector00) {.
    importc, libprag.}

proc show*(self: WebInspector) =
  webkit_web_inspector_show(cast[ptr WebInspector00](self.impl))

proc webkit_web_view_get_inspector(self: ptr WebView00): ptr WebInspector00 {.
    importc, libprag.}

proc getInspector*(self: WebView): WebInspector =
  let gobj = webkit_web_view_get_inspector(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc inspector*(self: WebView): WebInspector =
  let gobj = webkit_web_view_get_inspector(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SnapshotRegion* {.size: sizeof(cint), pure.} = enum
    visible = 0
    fullDocument = 1

type
  SnapshotOptions* {.size: sizeof(cint), pure.} = enum
    none = 0
    includeSelectionHighlighting = 1
    transparentBackground = 2

proc webkit_web_view_get_snapshot(self: ptr WebView00; region: SnapshotRegion;
    options: SnapshotOptions; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc getSnapshot*(self: WebView; region: SnapshotRegion;
    options: SnapshotOptions; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  webkit_web_view_get_snapshot(cast[ptr WebView00](self.impl), region, options, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  WebsiteDataManager* = ref object of gobject.Object
  WebsiteDataManager00* = object of gobject.Object00

proc webkit_website_data_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsiteDataManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_website_data_manager_new_ephemeral(): ptr WebsiteDataManager00 {.
    importc, libprag.}

proc newWebsiteDataManagerEphemeral*(): WebsiteDataManager =
  let gobj = webkit_website_data_manager_new_ephemeral()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebsiteDataManagerEphemeral*(tdesc: typedesc): tdesc =
  assert(result is WebsiteDataManager)
  let gobj = webkit_website_data_manager_new_ephemeral()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebsiteDataManagerEphemeral*[T](result: var T) {.deprecated.} =
  assert(result is WebsiteDataManager)
  let gobj = webkit_website_data_manager_new_ephemeral()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_website_data_manager_clear_finish(self: ptr WebsiteDataManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc clearFinish*(self: WebsiteDataManager; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_website_data_manager_clear_finish(cast[ptr WebsiteDataManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_website_data_manager_get_base_cache_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getBaseCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_base_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc baseCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_base_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_base_data_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getBaseDataDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_base_data_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc baseDataDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_base_data_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_cookie_manager(self: ptr WebsiteDataManager00): ptr CookieManager00 {.
    importc, libprag.}

proc getCookieManager*(self: WebsiteDataManager): CookieManager =
  let gobj = webkit_website_data_manager_get_cookie_manager(cast[ptr WebsiteDataManager00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc cookieManager*(self: WebsiteDataManager): CookieManager =
  let gobj = webkit_website_data_manager_get_cookie_manager(cast[ptr WebsiteDataManager00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_website_data_manager_get_disk_cache_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getDiskCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_disk_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc diskCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_disk_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_dom_cache_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getDomCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_dom_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc domCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_dom_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_hsts_cache_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getHstsCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_hsts_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc hstsCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_hsts_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_indexeddb_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getIndexeddbDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_indexeddb_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc indexeddbDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_indexeddb_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_itp_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getItpDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_itp_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc itpDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_itp_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_itp_enabled(self: ptr WebsiteDataManager00): gboolean {.
    importc, libprag.}

proc getItpEnabled*(self: WebsiteDataManager): bool =
  toBool(webkit_website_data_manager_get_itp_enabled(cast[ptr WebsiteDataManager00](self.impl)))

proc itpEnabled*(self: WebsiteDataManager): bool =
  toBool(webkit_website_data_manager_get_itp_enabled(cast[ptr WebsiteDataManager00](self.impl)))

proc webkit_website_data_manager_get_itp_summary(self: ptr WebsiteDataManager00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc getItpSummary*(self: WebsiteDataManager;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_website_data_manager_get_itp_summary(cast[ptr WebsiteDataManager00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_website_data_manager_get_local_storage_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getLocalStorageDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_local_storage_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc localStorageDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_local_storage_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_offline_application_cache_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getOfflineApplicationCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_offline_application_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc offlineApplicationCacheDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_offline_application_cache_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_persistent_credential_storage_enabled(self: ptr WebsiteDataManager00): gboolean {.
    importc, libprag.}

proc getPersistentCredentialStorageEnabled*(self: WebsiteDataManager): bool =
  toBool(webkit_website_data_manager_get_persistent_credential_storage_enabled(cast[ptr WebsiteDataManager00](self.impl)))

proc persistentCredentialStorageEnabled*(self: WebsiteDataManager): bool =
  toBool(webkit_website_data_manager_get_persistent_credential_storage_enabled(cast[ptr WebsiteDataManager00](self.impl)))

proc webkit_website_data_manager_get_service_worker_registrations_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getServiceWorkerRegistrationsDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_service_worker_registrations_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc serviceWorkerRegistrationsDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_service_worker_registrations_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_get_tls_errors_policy(self: ptr WebsiteDataManager00): TLSErrorsPolicy {.
    importc, libprag.}

proc getTlsErrorsPolicy*(self: WebsiteDataManager): TLSErrorsPolicy =
  webkit_website_data_manager_get_tls_errors_policy(cast[ptr WebsiteDataManager00](self.impl))

proc tlsErrorsPolicy*(self: WebsiteDataManager): TLSErrorsPolicy =
  webkit_website_data_manager_get_tls_errors_policy(cast[ptr WebsiteDataManager00](self.impl))

proc webkit_website_data_manager_get_websql_directory(self: ptr WebsiteDataManager00): cstring {.
    importc, libprag.}

proc getWebsqlDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_websql_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc websqlDirectory*(self: WebsiteDataManager): string =
  let resul0 = webkit_website_data_manager_get_websql_directory(cast[ptr WebsiteDataManager00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc webkit_website_data_manager_is_ephemeral(self: ptr WebsiteDataManager00): gboolean {.
    importc, libprag.}

proc isEphemeral*(self: WebsiteDataManager): bool =
  toBool(webkit_website_data_manager_is_ephemeral(cast[ptr WebsiteDataManager00](self.impl)))

proc webkit_website_data_manager_remove_finish(self: ptr WebsiteDataManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeFinish*(self: WebsiteDataManager;
    resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_website_data_manager_remove_finish(cast[ptr WebsiteDataManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_website_data_manager_set_itp_enabled(self: ptr WebsiteDataManager00;
    enabled: gboolean) {.
    importc, libprag.}

proc setItpEnabled*(self: WebsiteDataManager;
    enabled: bool = true) =
  webkit_website_data_manager_set_itp_enabled(cast[ptr WebsiteDataManager00](self.impl), gboolean(enabled))

proc `itpEnabled=`*(self: WebsiteDataManager;
    enabled: bool) =
  webkit_website_data_manager_set_itp_enabled(cast[ptr WebsiteDataManager00](self.impl), gboolean(enabled))

proc webkit_website_data_manager_set_network_proxy_settings(self: ptr WebsiteDataManager00;
    proxyMode: NetworkProxyMode; proxySettings: ptr NetworkProxySettings00) {.
    importc, libprag.}

proc setNetworkProxySettings*(self: WebsiteDataManager;
    proxyMode: NetworkProxyMode; proxySettings: NetworkProxySettings = nil) =
  webkit_website_data_manager_set_network_proxy_settings(cast[ptr WebsiteDataManager00](self.impl), proxyMode, if proxySettings.isNil: nil else: cast[ptr NetworkProxySettings00](proxySettings.impl))

proc webkit_website_data_manager_set_persistent_credential_storage_enabled(self: ptr WebsiteDataManager00;
    enabled: gboolean) {.
    importc, libprag.}

proc setPersistentCredentialStorageEnabled*(self: WebsiteDataManager;
    enabled: bool = true) =
  webkit_website_data_manager_set_persistent_credential_storage_enabled(cast[ptr WebsiteDataManager00](self.impl), gboolean(enabled))

proc `persistentCredentialStorageEnabled=`*(self: WebsiteDataManager;
    enabled: bool) =
  webkit_website_data_manager_set_persistent_credential_storage_enabled(cast[ptr WebsiteDataManager00](self.impl), gboolean(enabled))

proc webkit_website_data_manager_set_tls_errors_policy(self: ptr WebsiteDataManager00;
    policy: TLSErrorsPolicy) {.
    importc, libprag.}

proc setTlsErrorsPolicy*(self: WebsiteDataManager;
    policy: TLSErrorsPolicy) =
  webkit_website_data_manager_set_tls_errors_policy(cast[ptr WebsiteDataManager00](self.impl), policy)

proc `tlsErrorsPolicy=`*(self: WebsiteDataManager;
    policy: TLSErrorsPolicy) =
  webkit_website_data_manager_set_tls_errors_policy(cast[ptr WebsiteDataManager00](self.impl), policy)

proc webkit_web_view_get_website_data_manager(self: ptr WebView00): ptr WebsiteDataManager00 {.
    importc, libprag.}

proc getWebsiteDataManager*(self: WebView): WebsiteDataManager =
  let gobj = webkit_web_view_get_website_data_manager(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc websiteDataManager*(self: WebView): WebsiteDataManager =
  let gobj = webkit_web_view_get_website_data_manager(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_context_new_with_website_data_manager(manager: ptr WebsiteDataManager00): ptr WebContext00 {.
    importc, libprag.}

proc newWebContextWithWebsiteDataManager*(manager: WebsiteDataManager): WebContext =
  let gobj = webkit_web_context_new_with_website_data_manager(cast[ptr WebsiteDataManager00](manager.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebContextWithWebsiteDataManager*(tdesc: typedesc; manager: WebsiteDataManager): tdesc =
  assert(result is WebContext)
  let gobj = webkit_web_context_new_with_website_data_manager(cast[ptr WebsiteDataManager00](manager.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebContextWithWebsiteDataManager*[T](result: var T; manager: WebsiteDataManager) {.deprecated.} =
  assert(result is WebContext)
  let gobj = webkit_web_context_new_with_website_data_manager(cast[ptr WebsiteDataManager00](manager.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_context_get_website_data_manager(self: ptr WebContext00): ptr WebsiteDataManager00 {.
    importc, libprag.}

proc getWebsiteDataManager*(self: WebContext): WebsiteDataManager =
  let gobj = webkit_web_context_get_website_data_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc websiteDataManager*(self: WebContext): WebsiteDataManager =
  let gobj = webkit_web_context_get_website_data_manager(cast[ptr WebContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  MemoryPressureSettings00* {.pure.} = object
  MemoryPressureSettings* = ref object
    impl*: ptr MemoryPressureSettings00
    ignoreFinalizer*: bool

proc webkit_memory_pressure_settings_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitMemoryPressureSettings*(self: MemoryPressureSettings) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_memory_pressure_settings_get_type(), cast[ptr MemoryPressureSettings00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MemoryPressureSettings()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_memory_pressure_settings_get_type(), cast[ptr MemoryPressureSettings00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MemoryPressureSettings) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitMemoryPressureSettings)

proc webkit_memory_pressure_settings_free(self: ptr MemoryPressureSettings00) {.
    importc, libprag.}

proc free*(self: MemoryPressureSettings) =
  webkit_memory_pressure_settings_free(cast[ptr MemoryPressureSettings00](self.impl))

proc finalizerfree*(self: MemoryPressureSettings) =
  if not self.ignoreFinalizer:
    webkit_memory_pressure_settings_free(cast[ptr MemoryPressureSettings00](self.impl))

proc webkit_memory_pressure_settings_copy(self: ptr MemoryPressureSettings00): ptr MemoryPressureSettings00 {.
    importc, libprag.}

proc copy*(self: MemoryPressureSettings): MemoryPressureSettings =
  fnew(result, gBoxedFreeWebKitMemoryPressureSettings)
  result.impl = webkit_memory_pressure_settings_copy(cast[ptr MemoryPressureSettings00](self.impl))

proc webkit_memory_pressure_settings_new(): ptr MemoryPressureSettings00 {.
    importc, libprag.}

proc newMemoryPressureSettings*(): MemoryPressureSettings =
  fnew(result, gBoxedFreeWebKitMemoryPressureSettings)
  result.impl = webkit_memory_pressure_settings_new()

proc newMemoryPressureSettings*(tdesc: typedesc): tdesc =
  assert(result is MemoryPressureSettings)
  fnew(result, gBoxedFreeWebKitMemoryPressureSettings)
  result.impl = webkit_memory_pressure_settings_new()

proc initMemoryPressureSettings*[T](result: var T) {.deprecated.} =
  assert(result is MemoryPressureSettings)
  fnew(result, gBoxedFreeWebKitMemoryPressureSettings)
  result.impl = webkit_memory_pressure_settings_new()

proc webkit_memory_pressure_settings_get_conservative_threshold(self: ptr MemoryPressureSettings00): cdouble {.
    importc, libprag.}

proc getConservativeThreshold*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_conservative_threshold(cast[ptr MemoryPressureSettings00](self.impl))

proc conservativeThreshold*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_conservative_threshold(cast[ptr MemoryPressureSettings00](self.impl))

proc webkit_memory_pressure_settings_get_kill_threshold(self: ptr MemoryPressureSettings00): cdouble {.
    importc, libprag.}

proc getKillThreshold*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_kill_threshold(cast[ptr MemoryPressureSettings00](self.impl))

proc killThreshold*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_kill_threshold(cast[ptr MemoryPressureSettings00](self.impl))

proc webkit_memory_pressure_settings_get_memory_limit(self: ptr MemoryPressureSettings00): uint32 {.
    importc, libprag.}

proc getMemoryLimit*(self: MemoryPressureSettings): int =
  int(webkit_memory_pressure_settings_get_memory_limit(cast[ptr MemoryPressureSettings00](self.impl)))

proc memoryLimit*(self: MemoryPressureSettings): int =
  int(webkit_memory_pressure_settings_get_memory_limit(cast[ptr MemoryPressureSettings00](self.impl)))

proc webkit_memory_pressure_settings_get_poll_interval(self: ptr MemoryPressureSettings00): cdouble {.
    importc, libprag.}

proc getPollInterval*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_poll_interval(cast[ptr MemoryPressureSettings00](self.impl))

proc pollInterval*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_poll_interval(cast[ptr MemoryPressureSettings00](self.impl))

proc webkit_memory_pressure_settings_get_strict_threshold(self: ptr MemoryPressureSettings00): cdouble {.
    importc, libprag.}

proc getStrictThreshold*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_strict_threshold(cast[ptr MemoryPressureSettings00](self.impl))

proc strictThreshold*(self: MemoryPressureSettings): cdouble =
  webkit_memory_pressure_settings_get_strict_threshold(cast[ptr MemoryPressureSettings00](self.impl))

proc webkit_memory_pressure_settings_set_conservative_threshold(self: ptr MemoryPressureSettings00;
    value: cdouble) {.
    importc, libprag.}

proc setConservativeThreshold*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_conservative_threshold(cast[ptr MemoryPressureSettings00](self.impl), value)

proc `conservativeThreshold=`*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_conservative_threshold(cast[ptr MemoryPressureSettings00](self.impl), value)

proc webkit_memory_pressure_settings_set_kill_threshold(self: ptr MemoryPressureSettings00;
    value: cdouble) {.
    importc, libprag.}

proc setKillThreshold*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_kill_threshold(cast[ptr MemoryPressureSettings00](self.impl), value)

proc `killThreshold=`*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_kill_threshold(cast[ptr MemoryPressureSettings00](self.impl), value)

proc webkit_memory_pressure_settings_set_memory_limit(self: ptr MemoryPressureSettings00;
    memoryLimit: uint32) {.
    importc, libprag.}

proc setMemoryLimit*(self: MemoryPressureSettings;
    memoryLimit: int) =
  webkit_memory_pressure_settings_set_memory_limit(cast[ptr MemoryPressureSettings00](self.impl), uint32(memoryLimit))

proc `memoryLimit=`*(self: MemoryPressureSettings;
    memoryLimit: int) =
  webkit_memory_pressure_settings_set_memory_limit(cast[ptr MemoryPressureSettings00](self.impl), uint32(memoryLimit))

proc webkit_memory_pressure_settings_set_poll_interval(self: ptr MemoryPressureSettings00;
    value: cdouble) {.
    importc, libprag.}

proc setPollInterval*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_poll_interval(cast[ptr MemoryPressureSettings00](self.impl), value)

proc `pollInterval=`*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_poll_interval(cast[ptr MemoryPressureSettings00](self.impl), value)

proc webkit_memory_pressure_settings_set_strict_threshold(self: ptr MemoryPressureSettings00;
    value: cdouble) {.
    importc, libprag.}

proc setStrictThreshold*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_strict_threshold(cast[ptr MemoryPressureSettings00](self.impl), value)

proc `strictThreshold=`*(self: MemoryPressureSettings;
    value: cdouble) =
  webkit_memory_pressure_settings_set_strict_threshold(cast[ptr MemoryPressureSettings00](self.impl), value)

proc webkit_website_data_manager_set_memory_pressure_settings(settings: ptr MemoryPressureSettings00) {.
    importc, libprag.}

proc setMemoryPressureSettings*(settings: MemoryPressureSettings) =
  webkit_website_data_manager_set_memory_pressure_settings(cast[ptr MemoryPressureSettings00](settings.impl))

type
  WebsiteData00* {.pure.} = object
  WebsiteData* = ref object
    impl*: ptr WebsiteData00
    ignoreFinalizer*: bool

proc webkit_website_data_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitWebsiteData*(self: WebsiteData) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_website_data_get_type(), cast[ptr WebsiteData00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsiteData()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_website_data_get_type(), cast[ptr WebsiteData00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var WebsiteData) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitWebsiteData)

proc webkit_website_data_unref(self: ptr WebsiteData00) {.
    importc, libprag.}

proc unref*(self: WebsiteData) =
  webkit_website_data_unref(cast[ptr WebsiteData00](self.impl))

proc finalizerunref*(self: WebsiteData) =
  if not self.ignoreFinalizer:
    webkit_website_data_unref(cast[ptr WebsiteData00](self.impl))

proc webkit_website_data_ref(self: ptr WebsiteData00): ptr WebsiteData00 {.
    importc, libprag.}

proc `ref`*(self: WebsiteData): WebsiteData =
  fnew(result, gBoxedFreeWebKitWebsiteData)
  result.impl = webkit_website_data_ref(cast[ptr WebsiteData00](self.impl))

proc webkit_website_data_get_name(self: ptr WebsiteData00): cstring {.
    importc, libprag.}

proc getName*(self: WebsiteData): string =
  result = $webkit_website_data_get_name(cast[ptr WebsiteData00](self.impl))

proc name*(self: WebsiteData): string =
  result = $webkit_website_data_get_name(cast[ptr WebsiteData00](self.impl))

proc webkit_website_data_manager_fetch_finish(self: ptr WebsiteDataManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr glib.List {.
    importc, libprag.}

proc fetchFinish*(self: WebsiteDataManager; resu: gio.AsyncResult): seq[WebsiteData] =
  var gerror: ptr glib.Error
  let resul0 = webkit_website_data_manager_fetch_finish(cast[ptr WebsiteDataManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = glistStructs2seq[WebsiteData](resul0, false)
  g_list_free(resul0)

type
  ITPThirdParty00* {.pure.} = object
  ITPThirdParty* = ref object
    impl*: ptr ITPThirdParty00
    ignoreFinalizer*: bool

proc webkit_itp_third_party_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitITPThirdParty*(self: ITPThirdParty) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_itp_third_party_get_type(), cast[ptr ITPThirdParty00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ITPThirdParty()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_itp_third_party_get_type(), cast[ptr ITPThirdParty00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ITPThirdParty) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitITPThirdParty)

proc webkit_itp_third_party_unref(self: ptr ITPThirdParty00) {.
    importc, libprag.}

proc unref*(self: ITPThirdParty) =
  webkit_itp_third_party_unref(cast[ptr ITPThirdParty00](self.impl))

proc finalizerunref*(self: ITPThirdParty) =
  if not self.ignoreFinalizer:
    webkit_itp_third_party_unref(cast[ptr ITPThirdParty00](self.impl))

proc webkit_itp_third_party_ref(self: ptr ITPThirdParty00): ptr ITPThirdParty00 {.
    importc, libprag.}

proc `ref`*(self: ITPThirdParty): ITPThirdParty =
  fnew(result, gBoxedFreeWebKitITPThirdParty)
  result.impl = webkit_itp_third_party_ref(cast[ptr ITPThirdParty00](self.impl))

proc webkit_itp_third_party_get_domain(self: ptr ITPThirdParty00): cstring {.
    importc, libprag.}

proc getDomain*(self: ITPThirdParty): string =
  result = $webkit_itp_third_party_get_domain(cast[ptr ITPThirdParty00](self.impl))

proc domain*(self: ITPThirdParty): string =
  result = $webkit_itp_third_party_get_domain(cast[ptr ITPThirdParty00](self.impl))

proc webkit_website_data_manager_get_itp_summary_finish(self: ptr WebsiteDataManager00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr glib.List {.
    importc, libprag.}

proc getItpSummaryFinish*(self: WebsiteDataManager;
    resu: gio.AsyncResult): seq[ITPThirdParty] =
  var gerror: ptr glib.Error
  let resul0 = webkit_website_data_manager_get_itp_summary_finish(cast[ptr WebsiteDataManager00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = glistStructs2seq[ITPThirdParty](resul0, false)
  g_list_free(resul0)

type
  ITPFirstParty00* {.pure.} = object
  ITPFirstParty* = ref object
    impl*: ptr ITPFirstParty00
    ignoreFinalizer*: bool

proc webkit_itp_first_party_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitITPFirstParty*(self: ITPFirstParty) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_itp_first_party_get_type(), cast[ptr ITPFirstParty00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ITPFirstParty()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_itp_first_party_get_type(), cast[ptr ITPFirstParty00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ITPFirstParty) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitITPFirstParty)

proc webkit_itp_first_party_unref(self: ptr ITPFirstParty00) {.
    importc, libprag.}

proc unref*(self: ITPFirstParty) =
  webkit_itp_first_party_unref(cast[ptr ITPFirstParty00](self.impl))

proc finalizerunref*(self: ITPFirstParty) =
  if not self.ignoreFinalizer:
    webkit_itp_first_party_unref(cast[ptr ITPFirstParty00](self.impl))

proc webkit_itp_first_party_get_last_update_time(self: ptr ITPFirstParty00): ptr glib.DateTime00 {.
    importc, libprag.}

proc getLastUpdateTime*(self: ITPFirstParty): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = webkit_itp_first_party_get_last_update_time(cast[ptr ITPFirstParty00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc lastUpdateTime*(self: ITPFirstParty): glib.DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = webkit_itp_first_party_get_last_update_time(cast[ptr ITPFirstParty00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), result.impl))

proc webkit_itp_first_party_get_website_data_access_allowed(self: ptr ITPFirstParty00): gboolean {.
    importc, libprag.}

proc getWebsiteDataAccessAllowed*(self: ITPFirstParty): bool =
  toBool(webkit_itp_first_party_get_website_data_access_allowed(cast[ptr ITPFirstParty00](self.impl)))

proc websiteDataAccessAllowed*(self: ITPFirstParty): bool =
  toBool(webkit_itp_first_party_get_website_data_access_allowed(cast[ptr ITPFirstParty00](self.impl)))

proc webkit_itp_first_party_ref(self: ptr ITPFirstParty00): ptr ITPFirstParty00 {.
    importc, libprag.}

proc `ref`*(self: ITPFirstParty): ITPFirstParty =
  fnew(result, gBoxedFreeWebKitITPFirstParty)
  result.impl = webkit_itp_first_party_ref(cast[ptr ITPFirstParty00](self.impl))

proc webkit_itp_first_party_get_domain(self: ptr ITPFirstParty00): cstring {.
    importc, libprag.}

proc getDomain*(self: ITPFirstParty): string =
  result = $webkit_itp_first_party_get_domain(cast[ptr ITPFirstParty00](self.impl))

proc domain*(self: ITPFirstParty): string =
  result = $webkit_itp_first_party_get_domain(cast[ptr ITPFirstParty00](self.impl))

proc webkit_itp_third_party_get_first_parties(self: ptr ITPThirdParty00): ptr glib.List {.
    importc, libprag.}

proc getFirstParties*(self: ITPThirdParty): seq[ITPFirstParty] =
  discard

proc firstParties*(self: ITPThirdParty): seq[ITPFirstParty] =
  discard

type
  WebsiteDataTypes* {.size: sizeof(cint), pure.} = enum
    memoryCache = 1
    diskCache = 2
    offlineApplicationCache = 4
    sessionStorage = 8
    localStorage = 16
    websqlDatabases = 32
    indexeddbDatabases = 64
    pluginData = 128
    cookies = 256
    deviceIdHashSalt = 512
    hstsCache = 1024
    itp = 2048
    serviceWorkerRegistrations = 4096
    domCache = 8192
    all = 16383

proc webkit_website_data_manager_clear(self: ptr WebsiteDataManager00; types: WebsiteDataTypes;
    timespan: int64; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc clear*(self: WebsiteDataManager; types: WebsiteDataTypes;
    timespan: int64; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  webkit_website_data_manager_clear(cast[ptr WebsiteDataManager00](self.impl), types, timespan, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_website_data_manager_fetch(self: ptr WebsiteDataManager00; types: WebsiteDataTypes;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc fetch*(self: WebsiteDataManager; types: WebsiteDataTypes;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_website_data_manager_fetch(cast[ptr WebsiteDataManager00](self.impl), types, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_website_data_manager_remove(self: ptr WebsiteDataManager00; types: WebsiteDataTypes;
    websiteData: ptr glib.List; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc remove*(self: WebsiteDataManager; types: WebsiteDataTypes;
    websiteData: seq[WebsiteData]; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  var tempResGL = seq2GList(websiteData)
  webkit_website_data_manager_remove(cast[ptr WebsiteDataManager00](self.impl), types, tempResGL, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)
  g_list_free(tempResGL)

proc webkit_website_data_get_size(self: ptr WebsiteData00; types: WebsiteDataTypes): uint64 {.
    importc, libprag.}

proc getSize*(self: WebsiteData; types: WebsiteDataTypes): uint64 =
  webkit_website_data_get_size(cast[ptr WebsiteData00](self.impl), types)

proc webkit_website_data_get_types(self: ptr WebsiteData00): WebsiteDataTypes {.
    importc, libprag.}

proc getTypes*(self: WebsiteData): WebsiteDataTypes =
  webkit_website_data_get_types(cast[ptr WebsiteData00](self.impl))

proc types*(self: WebsiteData): WebsiteDataTypes =
  webkit_website_data_get_types(cast[ptr WebsiteData00](self.impl))

type
  WindowProperties* = ref object of gobject.Object
  WindowProperties00* = object of gobject.Object00

proc webkit_window_properties_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WindowProperties()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_window_properties_get_fullscreen(self: ptr WindowProperties00): gboolean {.
    importc, libprag.}

proc getFullscreen*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_fullscreen(cast[ptr WindowProperties00](self.impl)))

proc fullscreen*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_fullscreen(cast[ptr WindowProperties00](self.impl)))

proc webkit_window_properties_get_geometry(self: ptr WindowProperties00;
    geometry: var gdk.Rectangle) {.
    importc, libprag.}

proc getGeometry*(self: WindowProperties; geometry: var gdk.Rectangle) =
  webkit_window_properties_get_geometry(cast[ptr WindowProperties00](self.impl), geometry)

proc getGeometry*(self: WindowProperties): gdk.Rectangle =
  webkit_window_properties_get_geometry(cast[ptr WindowProperties00](self.impl), result)

proc webkit_window_properties_get_locationbar_visible(self: ptr WindowProperties00): gboolean {.
    importc, libprag.}

proc getLocationbarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_locationbar_visible(cast[ptr WindowProperties00](self.impl)))

proc locationbarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_locationbar_visible(cast[ptr WindowProperties00](self.impl)))

proc webkit_window_properties_get_menubar_visible(self: ptr WindowProperties00): gboolean {.
    importc, libprag.}

proc getMenubarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_menubar_visible(cast[ptr WindowProperties00](self.impl)))

proc menubarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_menubar_visible(cast[ptr WindowProperties00](self.impl)))

proc webkit_window_properties_get_resizable(self: ptr WindowProperties00): gboolean {.
    importc, libprag.}

proc getResizable*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_resizable(cast[ptr WindowProperties00](self.impl)))

proc resizable*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_resizable(cast[ptr WindowProperties00](self.impl)))

proc webkit_window_properties_get_scrollbars_visible(self: ptr WindowProperties00): gboolean {.
    importc, libprag.}

proc getScrollbarsVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_scrollbars_visible(cast[ptr WindowProperties00](self.impl)))

proc scrollbarsVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_scrollbars_visible(cast[ptr WindowProperties00](self.impl)))

proc webkit_window_properties_get_statusbar_visible(self: ptr WindowProperties00): gboolean {.
    importc, libprag.}

proc getStatusbarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_statusbar_visible(cast[ptr WindowProperties00](self.impl)))

proc statusbarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_statusbar_visible(cast[ptr WindowProperties00](self.impl)))

proc webkit_window_properties_get_toolbar_visible(self: ptr WindowProperties00): gboolean {.
    importc, libprag.}

proc getToolbarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_toolbar_visible(cast[ptr WindowProperties00](self.impl)))

proc toolbarVisible*(self: WindowProperties): bool =
  toBool(webkit_window_properties_get_toolbar_visible(cast[ptr WindowProperties00](self.impl)))

proc webkit_web_view_get_window_properties(self: ptr WebView00): ptr WindowProperties00 {.
    importc, libprag.}

proc getWindowProperties*(self: WebView): WindowProperties =
  let gobj = webkit_web_view_get_window_properties(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc windowProperties*(self: WebView): WindowProperties =
  let gobj = webkit_web_view_get_window_properties(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  BackForwardListItem* = ref object of gobject.InitiallyUnowned
  BackForwardListItem00* = object of gobject.InitiallyUnowned00

proc webkit_back_forward_list_item_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BackForwardListItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_back_forward_list_item_get_original_uri(self: ptr BackForwardListItem00): cstring {.
    importc, libprag.}

proc getOriginalUri*(self: BackForwardListItem): string =
  result = $webkit_back_forward_list_item_get_original_uri(cast[ptr BackForwardListItem00](self.impl))

proc originalUri*(self: BackForwardListItem): string =
  result = $webkit_back_forward_list_item_get_original_uri(cast[ptr BackForwardListItem00](self.impl))

proc webkit_back_forward_list_item_get_title(self: ptr BackForwardListItem00): cstring {.
    importc, libprag.}

proc getTitle*(self: BackForwardListItem): string =
  result = $webkit_back_forward_list_item_get_title(cast[ptr BackForwardListItem00](self.impl))

proc title*(self: BackForwardListItem): string =
  result = $webkit_back_forward_list_item_get_title(cast[ptr BackForwardListItem00](self.impl))

proc webkit_back_forward_list_item_get_uri(self: ptr BackForwardListItem00): cstring {.
    importc, libprag.}

proc getUri*(self: BackForwardListItem): string =
  result = $webkit_back_forward_list_item_get_uri(cast[ptr BackForwardListItem00](self.impl))

proc uri*(self: BackForwardListItem): string =
  result = $webkit_back_forward_list_item_get_uri(cast[ptr BackForwardListItem00](self.impl))

type
  BackForwardList* = ref object of gobject.Object
  BackForwardList00* = object of gobject.Object00

proc webkit_back_forward_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BackForwardList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: BackForwardList;  p: proc (self: ptr BackForwardList00; itemAdded: ptr BackForwardListItem00; itemsRemoved: pointer; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc webkit_back_forward_list_get_back_item(self: ptr BackForwardList00): ptr BackForwardListItem00 {.
    importc, libprag.}

proc getBackItem*(self: BackForwardList): BackForwardListItem =
  let gobj = webkit_back_forward_list_get_back_item(cast[ptr BackForwardList00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc backItem*(self: BackForwardList): BackForwardListItem =
  let gobj = webkit_back_forward_list_get_back_item(cast[ptr BackForwardList00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_back_forward_list_get_back_list(self: ptr BackForwardList00): ptr glib.List {.
    importc, libprag.}

proc getBackList*(self: BackForwardList): seq[BackForwardListItem] =
  let resul0 = webkit_back_forward_list_get_back_list(cast[ptr BackForwardList00](self.impl))
  result = glistObjects2seq(BackForwardListItem, resul0, false)
  g_list_free(resul0)

proc backList*(self: BackForwardList): seq[BackForwardListItem] =
  let resul0 = webkit_back_forward_list_get_back_list(cast[ptr BackForwardList00](self.impl))
  result = glistObjects2seq(BackForwardListItem, resul0, false)
  g_list_free(resul0)

proc webkit_back_forward_list_get_back_list_with_limit(self: ptr BackForwardList00;
    limit: uint32): ptr glib.List {.
    importc, libprag.}

proc getBackListWithLimit*(self: BackForwardList;
    limit: int): seq[BackForwardListItem] =
  let resul0 = webkit_back_forward_list_get_back_list_with_limit(cast[ptr BackForwardList00](self.impl), uint32(limit))
  result = glistObjects2seq(BackForwardListItem, resul0, false)
  g_list_free(resul0)

proc webkit_back_forward_list_get_current_item(self: ptr BackForwardList00): ptr BackForwardListItem00 {.
    importc, libprag.}

proc getCurrentItem*(self: BackForwardList): BackForwardListItem =
  let gobj = webkit_back_forward_list_get_current_item(cast[ptr BackForwardList00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentItem*(self: BackForwardList): BackForwardListItem =
  let gobj = webkit_back_forward_list_get_current_item(cast[ptr BackForwardList00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_back_forward_list_get_forward_item(self: ptr BackForwardList00): ptr BackForwardListItem00 {.
    importc, libprag.}

proc getForwardItem*(self: BackForwardList): BackForwardListItem =
  let gobj = webkit_back_forward_list_get_forward_item(cast[ptr BackForwardList00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc forwardItem*(self: BackForwardList): BackForwardListItem =
  let gobj = webkit_back_forward_list_get_forward_item(cast[ptr BackForwardList00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_back_forward_list_get_forward_list(self: ptr BackForwardList00): ptr glib.List {.
    importc, libprag.}

proc getForwardList*(self: BackForwardList): seq[BackForwardListItem] =
  let resul0 = webkit_back_forward_list_get_forward_list(cast[ptr BackForwardList00](self.impl))
  result = glistObjects2seq(BackForwardListItem, resul0, false)
  g_list_free(resul0)

proc forwardList*(self: BackForwardList): seq[BackForwardListItem] =
  let resul0 = webkit_back_forward_list_get_forward_list(cast[ptr BackForwardList00](self.impl))
  result = glistObjects2seq(BackForwardListItem, resul0, false)
  g_list_free(resul0)

proc webkit_back_forward_list_get_forward_list_with_limit(self: ptr BackForwardList00;
    limit: uint32): ptr glib.List {.
    importc, libprag.}

proc getForwardListWithLimit*(self: BackForwardList;
    limit: int): seq[BackForwardListItem] =
  let resul0 = webkit_back_forward_list_get_forward_list_with_limit(cast[ptr BackForwardList00](self.impl), uint32(limit))
  result = glistObjects2seq(BackForwardListItem, resul0, false)
  g_list_free(resul0)

proc webkit_back_forward_list_get_length(self: ptr BackForwardList00): uint32 {.
    importc, libprag.}

proc getLength*(self: BackForwardList): int =
  int(webkit_back_forward_list_get_length(cast[ptr BackForwardList00](self.impl)))

proc length*(self: BackForwardList): int =
  int(webkit_back_forward_list_get_length(cast[ptr BackForwardList00](self.impl)))

proc webkit_back_forward_list_get_nth_item(self: ptr BackForwardList00; index: int32): ptr BackForwardListItem00 {.
    importc, libprag.}

proc getNthItem*(self: BackForwardList; index: int): BackForwardListItem =
  let gobj = webkit_back_forward_list_get_nth_item(cast[ptr BackForwardList00](self.impl), int32(index))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_get_back_forward_list(self: ptr WebView00): ptr BackForwardList00 {.
    importc, libprag.}

proc getBackForwardList*(self: WebView): BackForwardList =
  let gobj = webkit_web_view_get_back_forward_list(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc backForwardList*(self: WebView): BackForwardList =
  let gobj = webkit_web_view_get_back_forward_list(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_go_to_back_forward_list_item(self: ptr WebView00; listItem: ptr BackForwardListItem00) {.
    importc, libprag.}

proc goToBackForwardListItem*(self: WebView; listItem: BackForwardListItem) =
  webkit_web_view_go_to_back_forward_list_item(cast[ptr WebView00](self.impl), cast[ptr BackForwardListItem00](listItem.impl))

type
  WebViewSessionState00* {.pure.} = object
  WebViewSessionState* = ref object
    impl*: ptr WebViewSessionState00
    ignoreFinalizer*: bool

proc webkit_web_view_session_state_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitWebViewSessionState*(self: WebViewSessionState) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_web_view_session_state_get_type(), cast[ptr WebViewSessionState00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebViewSessionState()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_web_view_session_state_get_type(), cast[ptr WebViewSessionState00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var WebViewSessionState) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitWebViewSessionState)

proc webkit_web_view_session_state_unref(self: ptr WebViewSessionState00) {.
    importc, libprag.}

proc unref*(self: WebViewSessionState) =
  webkit_web_view_session_state_unref(cast[ptr WebViewSessionState00](self.impl))

proc finalizerunref*(self: WebViewSessionState) =
  if not self.ignoreFinalizer:
    webkit_web_view_session_state_unref(cast[ptr WebViewSessionState00](self.impl))

proc webkit_web_view_session_state_ref(self: ptr WebViewSessionState00): ptr WebViewSessionState00 {.
    importc, libprag.}

proc `ref`*(self: WebViewSessionState): WebViewSessionState =
  fnew(result, gBoxedFreeWebKitWebViewSessionState)
  result.impl = webkit_web_view_session_state_ref(cast[ptr WebViewSessionState00](self.impl))

proc webkit_web_view_session_state_serialize(self: ptr WebViewSessionState00): ptr glib.Bytes00 {.
    importc, libprag.}

proc serialize*(self: WebViewSessionState): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = webkit_web_view_session_state_serialize(cast[ptr WebViewSessionState00](self.impl))

proc webkit_web_view_session_state_new(data: ptr glib.Bytes00): ptr WebViewSessionState00 {.
    importc, libprag.}

proc newWebViewSessionState*(data: glib.Bytes): WebViewSessionState =
  fnew(result, gBoxedFreeWebKitWebViewSessionState)
  result.impl = webkit_web_view_session_state_new(cast[ptr glib.Bytes00](data.impl))

proc newWebViewSessionState*(tdesc: typedesc; data: glib.Bytes): tdesc =
  assert(result is WebViewSessionState)
  fnew(result, gBoxedFreeWebKitWebViewSessionState)
  result.impl = webkit_web_view_session_state_new(cast[ptr glib.Bytes00](data.impl))

proc initWebViewSessionState*[T](result: var T; data: glib.Bytes) {.deprecated.} =
  assert(result is WebViewSessionState)
  fnew(result, gBoxedFreeWebKitWebViewSessionState)
  result.impl = webkit_web_view_session_state_new(cast[ptr glib.Bytes00](data.impl))

proc webkit_web_view_get_session_state(self: ptr WebView00): ptr WebViewSessionState00 {.
    importc, libprag.}

proc getSessionState*(self: WebView): WebViewSessionState =
  fnew(result, gBoxedFreeWebKitWebViewSessionState)
  result.impl = webkit_web_view_get_session_state(cast[ptr WebView00](self.impl))

proc sessionState*(self: WebView): WebViewSessionState =
  fnew(result, gBoxedFreeWebKitWebViewSessionState)
  result.impl = webkit_web_view_get_session_state(cast[ptr WebView00](self.impl))

proc webkit_web_view_restore_session_state(self: ptr WebView00; state: ptr WebViewSessionState00) {.
    importc, libprag.}

proc restoreSessionState*(self: WebView; state: WebViewSessionState) =
  webkit_web_view_restore_session_state(cast[ptr WebView00](self.impl), cast[ptr WebViewSessionState00](state.impl))

type
  JavascriptResult00* {.pure.} = object
  JavascriptResult* = ref object
    impl*: ptr JavascriptResult00
    ignoreFinalizer*: bool

proc webkit_javascript_result_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitJavascriptResult*(self: JavascriptResult) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_javascript_result_get_type(), cast[ptr JavascriptResult00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(JavascriptResult()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_javascript_result_get_type(), cast[ptr JavascriptResult00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var JavascriptResult) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitJavascriptResult)

proc webkit_javascript_result_unref(self: ptr JavascriptResult00) {.
    importc, libprag.}

proc unref*(self: JavascriptResult) =
  webkit_javascript_result_unref(cast[ptr JavascriptResult00](self.impl))

proc finalizerunref*(self: JavascriptResult) =
  if not self.ignoreFinalizer:
    webkit_javascript_result_unref(cast[ptr JavascriptResult00](self.impl))

proc webkit_javascript_result_ref(self: ptr JavascriptResult00): ptr JavascriptResult00 {.
    importc, libprag.}

proc `ref`*(self: JavascriptResult): JavascriptResult =
  fnew(result, gBoxedFreeWebKitJavascriptResult)
  result.impl = webkit_javascript_result_ref(cast[ptr JavascriptResult00](self.impl))

proc webkit_javascript_result_get_js_value(self: ptr JavascriptResult00): ptr javascriptcore.Value00 {.
    importc, libprag.}

proc getJsValue*(self: JavascriptResult): javascriptcore.Value =
  let gobj = webkit_javascript_result_get_js_value(cast[ptr JavascriptResult00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsValue*(self: JavascriptResult): javascriptcore.Value =
  let gobj = webkit_javascript_result_get_js_value(cast[ptr JavascriptResult00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  UserContentManager* = ref object of gobject.Object
  UserContentManager00* = object of gobject.Object00

proc webkit_user_content_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserContentManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scScriptMessageReceived*(self: UserContentManager;  p: proc (self: ptr UserContentManager00; jsResult: ptr JavascriptResult00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "script-message-received", cast[GCallback](p), xdata, nil, cf)

proc webkit_user_content_manager_new(): ptr UserContentManager00 {.
    importc, libprag.}

proc newUserContentManager*(): UserContentManager =
  let gobj = webkit_user_content_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newUserContentManager*(tdesc: typedesc): tdesc =
  assert(result is UserContentManager)
  let gobj = webkit_user_content_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUserContentManager*[T](result: var T) {.deprecated.} =
  assert(result is UserContentManager)
  let gobj = webkit_user_content_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_user_content_manager_register_script_message_handler(self: ptr UserContentManager00;
    name: cstring): gboolean {.
    importc, libprag.}

proc registerScriptMessageHandler*(self: UserContentManager;
    name: cstring): bool =
  toBool(webkit_user_content_manager_register_script_message_handler(cast[ptr UserContentManager00](self.impl), name))

proc webkit_user_content_manager_register_script_message_handler_in_world(self: ptr UserContentManager00;
    name: cstring; worldName: cstring): gboolean {.
    importc, libprag.}

proc registerScriptMessageHandlerInWorld*(self: UserContentManager;
    name: cstring; worldName: cstring): bool =
  toBool(webkit_user_content_manager_register_script_message_handler_in_world(cast[ptr UserContentManager00](self.impl), name, worldName))

proc webkit_user_content_manager_remove_all_filters(self: ptr UserContentManager00) {.
    importc, libprag.}

proc removeAllFilters*(self: UserContentManager) =
  webkit_user_content_manager_remove_all_filters(cast[ptr UserContentManager00](self.impl))

proc webkit_user_content_manager_remove_all_scripts(self: ptr UserContentManager00) {.
    importc, libprag.}

proc removeAllScripts*(self: UserContentManager) =
  webkit_user_content_manager_remove_all_scripts(cast[ptr UserContentManager00](self.impl))

proc webkit_user_content_manager_remove_all_style_sheets(self: ptr UserContentManager00) {.
    importc, libprag.}

proc removeAllStyleSheets*(self: UserContentManager) =
  webkit_user_content_manager_remove_all_style_sheets(cast[ptr UserContentManager00](self.impl))

proc webkit_user_content_manager_remove_filter_by_id(self: ptr UserContentManager00;
    filterId: cstring) {.
    importc, libprag.}

proc removeFilterById*(self: UserContentManager;
    filterId: cstring) =
  webkit_user_content_manager_remove_filter_by_id(cast[ptr UserContentManager00](self.impl), filterId)

proc webkit_user_content_manager_unregister_script_message_handler(self: ptr UserContentManager00;
    name: cstring) {.
    importc, libprag.}

proc unregisterScriptMessageHandler*(self: UserContentManager;
    name: cstring) =
  webkit_user_content_manager_unregister_script_message_handler(cast[ptr UserContentManager00](self.impl), name)

proc webkit_user_content_manager_unregister_script_message_handler_in_world(self: ptr UserContentManager00;
    name: cstring; worldName: cstring) {.
    importc, libprag.}

proc unregisterScriptMessageHandlerInWorld*(self: UserContentManager;
    name: cstring; worldName: cstring) =
  webkit_user_content_manager_unregister_script_message_handler_in_world(cast[ptr UserContentManager00](self.impl), name, worldName)

proc webkit_web_view_new_with_user_content_manager(userContentManager: ptr UserContentManager00): ptr WebView00 {.
    importc, libprag.}

proc newWebViewWithUserContentManager*(userContentManager: UserContentManager): WebView =
  let gobj = webkit_web_view_new_with_user_content_manager(cast[ptr UserContentManager00](userContentManager.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebViewWithUserContentManager*(tdesc: typedesc; userContentManager: UserContentManager): tdesc =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_user_content_manager(cast[ptr UserContentManager00](userContentManager.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebViewWithUserContentManager*[T](result: var T; userContentManager: UserContentManager) {.deprecated.} =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_user_content_manager(cast[ptr UserContentManager00](userContentManager.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_get_user_content_manager(self: ptr WebView00): ptr UserContentManager00 {.
    importc, libprag.}

proc getUserContentManager*(self: WebView): UserContentManager =
  let gobj = webkit_web_view_get_user_content_manager(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc userContentManager*(self: WebView): UserContentManager =
  let gobj = webkit_web_view_get_user_content_manager(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_run_javascript_finish(self: ptr WebView00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr JavascriptResult00 {.
    importc, libprag.}

proc runJavascriptFinish*(self: WebView; resu: gio.AsyncResult): JavascriptResult =
  var gerror: ptr glib.Error
  let impl0 = webkit_web_view_run_javascript_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeWebKitJavascriptResult)
  result.impl = impl0

proc webkit_web_view_run_javascript_from_gresource_finish(self: ptr WebView00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr JavascriptResult00 {.
    importc, libprag.}

proc runJavascriptFromGresourceFinish*(self: WebView;
    resu: gio.AsyncResult): JavascriptResult =
  var gerror: ptr glib.Error
  let impl0 = webkit_web_view_run_javascript_from_gresource_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeWebKitJavascriptResult)
  result.impl = impl0

proc webkit_web_view_run_javascript_in_world_finish(self: ptr WebView00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr JavascriptResult00 {.
    importc, libprag.}

proc runJavascriptInWorldFinish*(self: WebView; resu: gio.AsyncResult): JavascriptResult =
  var gerror: ptr glib.Error
  let impl0 = webkit_web_view_run_javascript_in_world_finish(cast[ptr WebView00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeWebKitJavascriptResult)
  result.impl = impl0

type
  UserContentFilter00* {.pure.} = object
  UserContentFilter* = ref object
    impl*: ptr UserContentFilter00
    ignoreFinalizer*: bool

proc webkit_user_content_filter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitUserContentFilter*(self: UserContentFilter) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_user_content_filter_get_type(), cast[ptr UserContentFilter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserContentFilter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_user_content_filter_get_type(), cast[ptr UserContentFilter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var UserContentFilter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitUserContentFilter)

proc webkit_user_content_filter_unref(self: ptr UserContentFilter00) {.
    importc, libprag.}

proc unref*(self: UserContentFilter) =
  webkit_user_content_filter_unref(cast[ptr UserContentFilter00](self.impl))

proc finalizerunref*(self: UserContentFilter) =
  if not self.ignoreFinalizer:
    webkit_user_content_filter_unref(cast[ptr UserContentFilter00](self.impl))

proc webkit_user_content_filter_ref(self: ptr UserContentFilter00): ptr UserContentFilter00 {.
    importc, libprag.}

proc `ref`*(self: UserContentFilter): UserContentFilter =
  fnew(result, gBoxedFreeWebKitUserContentFilter)
  result.impl = webkit_user_content_filter_ref(cast[ptr UserContentFilter00](self.impl))

proc webkit_user_content_filter_get_identifier(self: ptr UserContentFilter00): cstring {.
    importc, libprag.}

proc getIdentifier*(self: UserContentFilter): string =
  result = $webkit_user_content_filter_get_identifier(cast[ptr UserContentFilter00](self.impl))

proc identifier*(self: UserContentFilter): string =
  result = $webkit_user_content_filter_get_identifier(cast[ptr UserContentFilter00](self.impl))

proc webkit_user_content_manager_add_filter(self: ptr UserContentManager00;
    filter: ptr UserContentFilter00) {.
    importc, libprag.}

proc addFilter*(self: UserContentManager; filter: UserContentFilter) =
  webkit_user_content_manager_add_filter(cast[ptr UserContentManager00](self.impl), cast[ptr UserContentFilter00](filter.impl))

proc webkit_user_content_manager_remove_filter(self: ptr UserContentManager00;
    filter: ptr UserContentFilter00) {.
    importc, libprag.}

proc removeFilter*(self: UserContentManager;
    filter: UserContentFilter) =
  webkit_user_content_manager_remove_filter(cast[ptr UserContentManager00](self.impl), cast[ptr UserContentFilter00](filter.impl))

type
  UserScript00* {.pure.} = object
  UserScript* = ref object
    impl*: ptr UserScript00
    ignoreFinalizer*: bool

proc webkit_user_script_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitUserScript*(self: UserScript) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_user_script_get_type(), cast[ptr UserScript00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserScript()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_user_script_get_type(), cast[ptr UserScript00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var UserScript) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitUserScript)

proc webkit_user_script_unref(self: ptr UserScript00) {.
    importc, libprag.}

proc unref*(self: UserScript) =
  webkit_user_script_unref(cast[ptr UserScript00](self.impl))

proc finalizerunref*(self: UserScript) =
  if not self.ignoreFinalizer:
    webkit_user_script_unref(cast[ptr UserScript00](self.impl))

proc webkit_user_script_ref(self: ptr UserScript00): ptr UserScript00 {.
    importc, libprag.}

proc `ref`*(self: UserScript): UserScript =
  fnew(result, gBoxedFreeWebKitUserScript)
  result.impl = webkit_user_script_ref(cast[ptr UserScript00](self.impl))

proc webkit_user_content_manager_add_script(self: ptr UserContentManager00;
    script: ptr UserScript00) {.
    importc, libprag.}

proc addScript*(self: UserContentManager; script: UserScript) =
  webkit_user_content_manager_add_script(cast[ptr UserContentManager00](self.impl), cast[ptr UserScript00](script.impl))

proc webkit_user_content_manager_remove_script(self: ptr UserContentManager00;
    script: ptr UserScript00) {.
    importc, libprag.}

proc removeScript*(self: UserContentManager;
    script: UserScript) =
  webkit_user_content_manager_remove_script(cast[ptr UserContentManager00](self.impl), cast[ptr UserScript00](script.impl))

type
  UserContentInjectedFrames* {.size: sizeof(cint), pure.} = enum
    allFrames = 0
    topFrame = 1

type
  UserScriptInjectionTime* {.size: sizeof(cint), pure.} = enum
    start = 0
    `end` = 1

proc webkit_user_script_new_for_world(source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; worldName: cstring; allowList: ptr cstring;
    blockList: ptr cstring): ptr UserScript00 {.
    importc, libprag.}

proc newUserScriptForWorld*(source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; worldName: cstring; allowList: openArray[string];
    blockList: varargs[string, `$`]): UserScript =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  fnew(result, gBoxedFreeWebKitUserScript)
  result.impl = webkit_user_script_new_for_world(source, injectedFrames, injectionTime, worldName, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc newUserScriptForWorld*(tdesc: typedesc; source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; worldName: cstring; allowList: openArray[string];
    blockList: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserScript)
  fnew(result, gBoxedFreeWebKitUserScript)
  result.impl = webkit_user_script_new_for_world(source, injectedFrames, injectionTime, worldName, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc initUserScriptForWorld*[T](result: var T; source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; worldName: cstring; allowList: openArray[string];
    blockList: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserScript)
  fnew(result, gBoxedFreeWebKitUserScript)
  result.impl = webkit_user_script_new_for_world(source, injectedFrames, injectionTime, worldName, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc webkit_user_script_new(source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; allowList: ptr cstring; blockList: ptr cstring): ptr UserScript00 {.
    importc, libprag.}

proc newUserScript*(source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; allowList: openArray[string]; blockList: varargs[string, `$`]): UserScript =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  fnew(result, gBoxedFreeWebKitUserScript)
  result.impl = webkit_user_script_new(source, injectedFrames, injectionTime, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc newUserScript*(tdesc: typedesc; source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; allowList: openArray[string]; blockList: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserScript)
  fnew(result, gBoxedFreeWebKitUserScript)
  result.impl = webkit_user_script_new(source, injectedFrames, injectionTime, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc initUserScript*[T](result: var T; source: cstring; injectedFrames: UserContentInjectedFrames;
    injectionTime: UserScriptInjectionTime; allowList: openArray[string]; blockList: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserScript)
  fnew(result, gBoxedFreeWebKitUserScript)
  result.impl = webkit_user_script_new(source, injectedFrames, injectionTime, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

type
  UserStyleSheet00* {.pure.} = object
  UserStyleSheet* = ref object
    impl*: ptr UserStyleSheet00
    ignoreFinalizer*: bool

proc webkit_user_style_sheet_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitUserStyleSheet*(self: UserStyleSheet) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_user_style_sheet_get_type(), cast[ptr UserStyleSheet00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserStyleSheet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_user_style_sheet_get_type(), cast[ptr UserStyleSheet00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var UserStyleSheet) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitUserStyleSheet)

proc webkit_user_style_sheet_unref(self: ptr UserStyleSheet00) {.
    importc, libprag.}

proc unref*(self: UserStyleSheet) =
  webkit_user_style_sheet_unref(cast[ptr UserStyleSheet00](self.impl))

proc finalizerunref*(self: UserStyleSheet) =
  if not self.ignoreFinalizer:
    webkit_user_style_sheet_unref(cast[ptr UserStyleSheet00](self.impl))

proc webkit_user_style_sheet_ref(self: ptr UserStyleSheet00): ptr UserStyleSheet00 {.
    importc, libprag.}

proc `ref`*(self: UserStyleSheet): UserStyleSheet =
  fnew(result, gBoxedFreeWebKitUserStyleSheet)
  result.impl = webkit_user_style_sheet_ref(cast[ptr UserStyleSheet00](self.impl))

proc webkit_user_content_manager_add_style_sheet(self: ptr UserContentManager00;
    stylesheet: ptr UserStyleSheet00) {.
    importc, libprag.}

proc addStyleSheet*(self: UserContentManager;
    stylesheet: UserStyleSheet) =
  webkit_user_content_manager_add_style_sheet(cast[ptr UserContentManager00](self.impl), cast[ptr UserStyleSheet00](stylesheet.impl))

proc webkit_user_content_manager_remove_style_sheet(self: ptr UserContentManager00;
    stylesheet: ptr UserStyleSheet00) {.
    importc, libprag.}

proc removeStyleSheet*(self: UserContentManager;
    stylesheet: UserStyleSheet) =
  webkit_user_content_manager_remove_style_sheet(cast[ptr UserContentManager00](self.impl), cast[ptr UserStyleSheet00](stylesheet.impl))

type
  UserStyleLevel* {.size: sizeof(cint), pure.} = enum
    user = 0
    author = 1

proc webkit_user_style_sheet_new_for_world(source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; worldName: cstring; allowList: ptr cstring; blockList: ptr cstring): ptr UserStyleSheet00 {.
    importc, libprag.}

proc newUserStyleSheetForWorld*(source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; worldName: cstring; allowList: openArray[string];
    blockList: varargs[string, `$`]): UserStyleSheet =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  fnew(result, gBoxedFreeWebKitUserStyleSheet)
  result.impl = webkit_user_style_sheet_new_for_world(source, injectedFrames, level, worldName, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc newUserStyleSheetForWorld*(tdesc: typedesc; source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; worldName: cstring; allowList: openArray[string];
    blockList: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserStyleSheet)
  fnew(result, gBoxedFreeWebKitUserStyleSheet)
  result.impl = webkit_user_style_sheet_new_for_world(source, injectedFrames, level, worldName, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc initUserStyleSheetForWorld*[T](result: var T; source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; worldName: cstring; allowList: openArray[string];
    blockList: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserStyleSheet)
  fnew(result, gBoxedFreeWebKitUserStyleSheet)
  result.impl = webkit_user_style_sheet_new_for_world(source, injectedFrames, level, worldName, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc webkit_user_style_sheet_new(source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; allowList: ptr cstring; blockList: ptr cstring): ptr UserStyleSheet00 {.
    importc, libprag.}

proc newUserStyleSheet*(source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; allowList: openArray[string]; blockList: varargs[string, `$`]): UserStyleSheet =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  fnew(result, gBoxedFreeWebKitUserStyleSheet)
  result.impl = webkit_user_style_sheet_new(source, injectedFrames, level, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc newUserStyleSheet*(tdesc: typedesc; source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; allowList: openArray[string]; blockList: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserStyleSheet)
  fnew(result, gBoxedFreeWebKitUserStyleSheet)
  result.impl = webkit_user_style_sheet_new(source, injectedFrames, level, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

proc initUserStyleSheet*[T](result: var T; source: cstring; injectedFrames: UserContentInjectedFrames;
    level: UserStyleLevel; allowList: openArray[string]; blockList: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  assert(result is UserStyleSheet)
  fnew(result, gBoxedFreeWebKitUserStyleSheet)
  result.impl = webkit_user_style_sheet_new(source, injectedFrames, level, seq2CstringArray(allowList, fs469n23), seq2CstringArray(blockList, fs469n232))

type
  SaveMode* {.size: sizeof(cint), pure.} = enum
    mhtml = 0

proc webkit_web_view_save(self: ptr WebView00; saveMode: SaveMode; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc save*(self: WebView; saveMode: SaveMode; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_view_save(cast[ptr WebView00](self.impl), saveMode, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_view_save_to_file(self: ptr WebView00; file: ptr gio.GFile00;
    saveMode: SaveMode; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc saveToFile*(self: WebView; file: gio.GFile; saveMode: SaveMode;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_view_save_to_file(cast[ptr WebView00](self.impl), cast[ptr gio.GFile00](file.impl), saveMode, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  InputMethodContext* = ref object of gobject.Object
  InputMethodContext00* = object of gobject.Object00

proc webkit_input_method_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InputMethodContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCommitted*(self: InputMethodContext;  p: proc (self: ptr InputMethodContext00; text: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "committed", cast[GCallback](p), xdata, nil, cf)

proc scDeleteSurrounding*(self: InputMethodContext;  p: proc (self: ptr InputMethodContext00; offset: int32; nChars: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "delete-surrounding", cast[GCallback](p), xdata, nil, cf)

proc scPreeditChanged*(self: InputMethodContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "preedit-changed", cast[GCallback](p), xdata, nil, cf)

proc scPreeditFinished*(self: InputMethodContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "preedit-finished", cast[GCallback](p), xdata, nil, cf)

proc scPreeditStarted*(self: InputMethodContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "preedit-started", cast[GCallback](p), xdata, nil, cf)

proc webkit_input_method_context_filter_key_event(self: ptr InputMethodContext00;
    keyEvent: ptr gdk.EventKey00): gboolean {.
    importc, libprag.}

proc filterKeyEvent*(self: InputMethodContext;
    keyEvent: gdk.EventKey): bool =
  toBool(webkit_input_method_context_filter_key_event(cast[ptr InputMethodContext00](self.impl), cast[ptr gdk.EventKey00](keyEvent.impl)))

proc webkit_input_method_context_notify_cursor_area(self: ptr InputMethodContext00;
    x: int32; y: int32; width: int32; height: int32) {.
    importc, libprag.}

proc notifyCursorArea*(self: InputMethodContext;
    x: int; y: int; width: int; height: int) =
  webkit_input_method_context_notify_cursor_area(cast[ptr InputMethodContext00](self.impl), int32(x), int32(y), int32(width), int32(height))

proc webkit_input_method_context_notify_focus_in(self: ptr InputMethodContext00) {.
    importc, libprag.}

proc notifyFocusIn*(self: InputMethodContext) =
  webkit_input_method_context_notify_focus_in(cast[ptr InputMethodContext00](self.impl))

proc webkit_input_method_context_notify_focus_out(self: ptr InputMethodContext00) {.
    importc, libprag.}

proc notifyFocusOut*(self: InputMethodContext) =
  webkit_input_method_context_notify_focus_out(cast[ptr InputMethodContext00](self.impl))

proc webkit_input_method_context_notify_surrounding(self: ptr InputMethodContext00;
    text: cstring; length: int32; cursorIndex: uint32; selectionIndex: uint32) {.
    importc, libprag.}

proc notifySurrounding*(self: InputMethodContext;
    text: cstring; length: int; cursorIndex: int; selectionIndex: int) =
  webkit_input_method_context_notify_surrounding(cast[ptr InputMethodContext00](self.impl), text, int32(length), uint32(cursorIndex), uint32(selectionIndex))

proc webkit_input_method_context_reset(self: ptr InputMethodContext00) {.
    importc, libprag.}

proc reset*(self: InputMethodContext) =
  webkit_input_method_context_reset(cast[ptr InputMethodContext00](self.impl))

proc webkit_input_method_context_set_enable_preedit(self: ptr InputMethodContext00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnablePreedit*(self: InputMethodContext;
    enabled: bool = true) =
  webkit_input_method_context_set_enable_preedit(cast[ptr InputMethodContext00](self.impl), gboolean(enabled))

proc `enablePreedit=`*(self: InputMethodContext;
    enabled: bool) =
  webkit_input_method_context_set_enable_preedit(cast[ptr InputMethodContext00](self.impl), gboolean(enabled))

proc webkit_web_view_get_input_method_context(self: ptr WebView00): ptr InputMethodContext00 {.
    importc, libprag.}

proc getInputMethodContext*(self: WebView): InputMethodContext =
  let gobj = webkit_web_view_get_input_method_context(cast[ptr WebView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc inputMethodContext*(self: WebView): InputMethodContext =
  let gobj = webkit_web_view_get_input_method_context(cast[ptr WebView00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_set_input_method_context(self: ptr WebView00; context: ptr InputMethodContext00) {.
    importc, libprag.}

proc setInputMethodContext*(self: WebView; context: InputMethodContext = nil) =
  webkit_web_view_set_input_method_context(cast[ptr WebView00](self.impl), if context.isNil: nil else: cast[ptr InputMethodContext00](context.impl))

proc `inputMethodContext=`*(self: WebView; context: InputMethodContext = nil) =
  webkit_web_view_set_input_method_context(cast[ptr WebView00](self.impl), if context.isNil: nil else: cast[ptr InputMethodContext00](context.impl))

type
  InputMethodUnderline00* {.pure.} = object
  InputMethodUnderline* = ref object
    impl*: ptr InputMethodUnderline00
    ignoreFinalizer*: bool

proc webkit_input_method_underline_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitInputMethodUnderline*(self: InputMethodUnderline) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_input_method_underline_get_type(), cast[ptr InputMethodUnderline00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InputMethodUnderline()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_input_method_underline_get_type(), cast[ptr InputMethodUnderline00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var InputMethodUnderline) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitInputMethodUnderline)

proc webkit_input_method_underline_free(self: ptr InputMethodUnderline00) {.
    importc, libprag.}

proc free*(self: InputMethodUnderline) =
  webkit_input_method_underline_free(cast[ptr InputMethodUnderline00](self.impl))

proc finalizerfree*(self: InputMethodUnderline) =
  if not self.ignoreFinalizer:
    webkit_input_method_underline_free(cast[ptr InputMethodUnderline00](self.impl))

proc webkit_input_method_underline_copy(self: ptr InputMethodUnderline00): ptr InputMethodUnderline00 {.
    importc, libprag.}

proc copy*(self: InputMethodUnderline): InputMethodUnderline =
  fnew(result, gBoxedFreeWebKitInputMethodUnderline)
  result.impl = webkit_input_method_underline_copy(cast[ptr InputMethodUnderline00](self.impl))

proc webkit_input_method_underline_new(startOffset: uint32; endOffset: uint32): ptr InputMethodUnderline00 {.
    importc, libprag.}

proc newInputMethodUnderline*(startOffset: int; endOffset: int): InputMethodUnderline =
  fnew(result, gBoxedFreeWebKitInputMethodUnderline)
  result.impl = webkit_input_method_underline_new(uint32(startOffset), uint32(endOffset))

proc newInputMethodUnderline*(tdesc: typedesc; startOffset: int; endOffset: int): tdesc =
  assert(result is InputMethodUnderline)
  fnew(result, gBoxedFreeWebKitInputMethodUnderline)
  result.impl = webkit_input_method_underline_new(uint32(startOffset), uint32(endOffset))

proc initInputMethodUnderline*[T](result: var T; startOffset: int; endOffset: int) {.deprecated.} =
  assert(result is InputMethodUnderline)
  fnew(result, gBoxedFreeWebKitInputMethodUnderline)
  result.impl = webkit_input_method_underline_new(uint32(startOffset), uint32(endOffset))

proc webkit_input_method_underline_set_color(self: ptr InputMethodUnderline00;
    rgba: gdk.RGBA) {.
    importc, libprag.}

proc setColor*(self: InputMethodUnderline;
    rgba: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  webkit_input_method_underline_set_color(cast[ptr InputMethodUnderline00](self.impl), rgba)

proc `color=`*(self: InputMethodUnderline;
    rgba: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  webkit_input_method_underline_set_color(cast[ptr InputMethodUnderline00](self.impl), rgba)

proc webkit_input_method_context_get_preedit(self: ptr InputMethodContext00;
    text: var cstring; underlines: var ptr glib.List; cursorOffset: var uint32) {.
    importc, libprag.}

proc getPreedit*(self: InputMethodContext; text: var string;
    underlines: var seq[InputMethodUnderline]; cursorOffset: var int) =
  var tempResGL = seq2GList(underlines)
  var cursorOffset_00: uint32
  var text_00: cstring
  webkit_input_method_context_get_preedit(cast[ptr InputMethodContext00](self.impl), text_00, tempResGL, cursorOffset_00)
  if cursorOffset.addr != nil:
    cursorOffset = int(cursorOffset_00)
  if text.addr != nil:
    text = $(text_00)

type
  InputHints* {.size: sizeof(cint), pure.} = enum
    none = 0
    spellcheck = 1
    lowercase = 2
    uppercaseChars = 4
    uppercaseWords = 8
    uppercaseSentences = 16
    inhibitOsk = 32

proc webkit_input_method_context_get_input_hints(self: ptr InputMethodContext00): InputHints {.
    importc, libprag.}

proc getInputHints*(self: InputMethodContext): InputHints =
  webkit_input_method_context_get_input_hints(cast[ptr InputMethodContext00](self.impl))

proc inputHints*(self: InputMethodContext): InputHints =
  webkit_input_method_context_get_input_hints(cast[ptr InputMethodContext00](self.impl))

proc webkit_input_method_context_set_input_hints(self: ptr InputMethodContext00;
    hints: InputHints) {.
    importc, libprag.}

proc setInputHints*(self: InputMethodContext;
    hints: InputHints) =
  webkit_input_method_context_set_input_hints(cast[ptr InputMethodContext00](self.impl), hints)

proc `inputHints=`*(self: InputMethodContext;
    hints: InputHints) =
  webkit_input_method_context_set_input_hints(cast[ptr InputMethodContext00](self.impl), hints)

type
  InputPurpose* {.size: sizeof(cint), pure.} = enum
    freeForm = 0
    digits = 1
    number = 2
    phone = 3
    url = 4
    email = 5
    password = 6

proc webkit_input_method_context_get_input_purpose(self: ptr InputMethodContext00): InputPurpose {.
    importc, libprag.}

proc getInputPurpose*(self: InputMethodContext): InputPurpose =
  webkit_input_method_context_get_input_purpose(cast[ptr InputMethodContext00](self.impl))

proc inputPurpose*(self: InputMethodContext): InputPurpose =
  webkit_input_method_context_get_input_purpose(cast[ptr InputMethodContext00](self.impl))

proc webkit_input_method_context_set_input_purpose(self: ptr InputMethodContext00;
    purpose: InputPurpose) {.
    importc, libprag.}

proc setInputPurpose*(self: InputMethodContext;
    purpose: InputPurpose) =
  webkit_input_method_context_set_input_purpose(cast[ptr InputMethodContext00](self.impl), purpose)

proc `inputPurpose=`*(self: InputMethodContext;
    purpose: InputPurpose) =
  webkit_input_method_context_set_input_purpose(cast[ptr InputMethodContext00](self.impl), purpose)

type
  MediaCaptureState* {.size: sizeof(cint), pure.} = enum
    none = 0
    active = 1
    muted = 2

proc webkit_web_view_get_camera_capture_state(self: ptr WebView00): MediaCaptureState {.
    importc, libprag.}

proc getCameraCaptureState*(self: WebView): MediaCaptureState =
  webkit_web_view_get_camera_capture_state(cast[ptr WebView00](self.impl))

proc cameraCaptureState*(self: WebView): MediaCaptureState =
  webkit_web_view_get_camera_capture_state(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_display_capture_state(self: ptr WebView00): MediaCaptureState {.
    importc, libprag.}

proc getDisplayCaptureState*(self: WebView): MediaCaptureState =
  webkit_web_view_get_display_capture_state(cast[ptr WebView00](self.impl))

proc displayCaptureState*(self: WebView): MediaCaptureState =
  webkit_web_view_get_display_capture_state(cast[ptr WebView00](self.impl))

proc webkit_web_view_get_microphone_capture_state(self: ptr WebView00): MediaCaptureState {.
    importc, libprag.}

proc getMicrophoneCaptureState*(self: WebView): MediaCaptureState =
  webkit_web_view_get_microphone_capture_state(cast[ptr WebView00](self.impl))

proc microphoneCaptureState*(self: WebView): MediaCaptureState =
  webkit_web_view_get_microphone_capture_state(cast[ptr WebView00](self.impl))

proc webkit_web_view_set_camera_capture_state(self: ptr WebView00; state: MediaCaptureState) {.
    importc, libprag.}

proc setCameraCaptureState*(self: WebView; state: MediaCaptureState) =
  webkit_web_view_set_camera_capture_state(cast[ptr WebView00](self.impl), state)

proc `cameraCaptureState=`*(self: WebView; state: MediaCaptureState) =
  webkit_web_view_set_camera_capture_state(cast[ptr WebView00](self.impl), state)

proc webkit_web_view_set_display_capture_state(self: ptr WebView00; state: MediaCaptureState) {.
    importc, libprag.}

proc setDisplayCaptureState*(self: WebView; state: MediaCaptureState) =
  webkit_web_view_set_display_capture_state(cast[ptr WebView00](self.impl), state)

proc `displayCaptureState=`*(self: WebView; state: MediaCaptureState) =
  webkit_web_view_set_display_capture_state(cast[ptr WebView00](self.impl), state)

proc webkit_web_view_set_microphone_capture_state(self: ptr WebView00; state: MediaCaptureState) {.
    importc, libprag.}

proc setMicrophoneCaptureState*(self: WebView; state: MediaCaptureState) =
  webkit_web_view_set_microphone_capture_state(cast[ptr WebView00](self.impl), state)

proc `microphoneCaptureState=`*(self: WebView; state: MediaCaptureState) =
  webkit_web_view_set_microphone_capture_state(cast[ptr WebView00](self.impl), state)

type
  Settings* = ref object of gobject.Object
  Settings00* = object of gobject.Object00

proc webkit_settings_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Settings()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_settings_new(): ptr Settings00 {.
    importc, libprag.}

proc newSettings*(): Settings =
  let gobj = webkit_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSettings*(tdesc: typedesc): tdesc =
  assert(result is Settings)
  let gobj = webkit_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSettings*[T](result: var T) {.deprecated.} =
  assert(result is Settings)
  let gobj = webkit_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_settings_font_size_to_pixels(points: uint32): uint32 {.
    importc, libprag.}

proc fontSizeToPixels*(points: int): int =
  int(webkit_settings_font_size_to_pixels(uint32(points)))

proc webkit_settings_font_size_to_points(pixels: uint32): uint32 {.
    importc, libprag.}

proc fontSizeToPoints*(pixels: int): int =
  int(webkit_settings_font_size_to_points(uint32(pixels)))

proc webkit_settings_get_allow_file_access_from_file_urls(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getAllowFileAccessFromFileUrls*(self: Settings): bool =
  toBool(webkit_settings_get_allow_file_access_from_file_urls(cast[ptr Settings00](self.impl)))

proc allowFileAccessFromFileUrls*(self: Settings): bool =
  toBool(webkit_settings_get_allow_file_access_from_file_urls(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_allow_modal_dialogs(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getAllowModalDialogs*(self: Settings): bool =
  toBool(webkit_settings_get_allow_modal_dialogs(cast[ptr Settings00](self.impl)))

proc allowModalDialogs*(self: Settings): bool =
  toBool(webkit_settings_get_allow_modal_dialogs(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_allow_top_navigation_to_data_urls(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getAllowTopNavigationToDataUrls*(self: Settings): bool =
  toBool(webkit_settings_get_allow_top_navigation_to_data_urls(cast[ptr Settings00](self.impl)))

proc allowTopNavigationToDataUrls*(self: Settings): bool =
  toBool(webkit_settings_get_allow_top_navigation_to_data_urls(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_allow_universal_access_from_file_urls(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getAllowUniversalAccessFromFileUrls*(self: Settings): bool =
  toBool(webkit_settings_get_allow_universal_access_from_file_urls(cast[ptr Settings00](self.impl)))

proc allowUniversalAccessFromFileUrls*(self: Settings): bool =
  toBool(webkit_settings_get_allow_universal_access_from_file_urls(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_auto_load_images(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getAutoLoadImages*(self: Settings): bool =
  toBool(webkit_settings_get_auto_load_images(cast[ptr Settings00](self.impl)))

proc autoLoadImages*(self: Settings): bool =
  toBool(webkit_settings_get_auto_load_images(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_cursive_font_family(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getCursiveFontFamily*(self: Settings): string =
  result = $webkit_settings_get_cursive_font_family(cast[ptr Settings00](self.impl))

proc cursiveFontFamily*(self: Settings): string =
  result = $webkit_settings_get_cursive_font_family(cast[ptr Settings00](self.impl))

proc webkit_settings_get_default_charset(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getDefaultCharset*(self: Settings): string =
  result = $webkit_settings_get_default_charset(cast[ptr Settings00](self.impl))

proc defaultCharset*(self: Settings): string =
  result = $webkit_settings_get_default_charset(cast[ptr Settings00](self.impl))

proc webkit_settings_get_default_font_family(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getDefaultFontFamily*(self: Settings): string =
  result = $webkit_settings_get_default_font_family(cast[ptr Settings00](self.impl))

proc defaultFontFamily*(self: Settings): string =
  result = $webkit_settings_get_default_font_family(cast[ptr Settings00](self.impl))

proc webkit_settings_get_default_font_size(self: ptr Settings00): uint32 {.
    importc, libprag.}

proc getDefaultFontSize*(self: Settings): int =
  int(webkit_settings_get_default_font_size(cast[ptr Settings00](self.impl)))

proc defaultFontSize*(self: Settings): int =
  int(webkit_settings_get_default_font_size(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_default_monospace_font_size(self: ptr Settings00): uint32 {.
    importc, libprag.}

proc getDefaultMonospaceFontSize*(self: Settings): int =
  int(webkit_settings_get_default_monospace_font_size(cast[ptr Settings00](self.impl)))

proc defaultMonospaceFontSize*(self: Settings): int =
  int(webkit_settings_get_default_monospace_font_size(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_draw_compositing_indicators(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getDrawCompositingIndicators*(self: Settings): bool =
  toBool(webkit_settings_get_draw_compositing_indicators(cast[ptr Settings00](self.impl)))

proc drawCompositingIndicators*(self: Settings): bool =
  toBool(webkit_settings_get_draw_compositing_indicators(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_accelerated_2d_canvas(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableAccelerated_2dCanvas*(self: Settings): bool =
  toBool(webkit_settings_get_enable_accelerated_2d_canvas(cast[ptr Settings00](self.impl)))

proc enableAccelerated_2dCanvas*(self: Settings): bool =
  toBool(webkit_settings_get_enable_accelerated_2d_canvas(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_back_forward_navigation_gestures(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableBackForwardNavigationGestures*(self: Settings): bool =
  toBool(webkit_settings_get_enable_back_forward_navigation_gestures(cast[ptr Settings00](self.impl)))

proc enableBackForwardNavigationGestures*(self: Settings): bool =
  toBool(webkit_settings_get_enable_back_forward_navigation_gestures(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_caret_browsing(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableCaretBrowsing*(self: Settings): bool =
  toBool(webkit_settings_get_enable_caret_browsing(cast[ptr Settings00](self.impl)))

proc enableCaretBrowsing*(self: Settings): bool =
  toBool(webkit_settings_get_enable_caret_browsing(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_developer_extras(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableDeveloperExtras*(self: Settings): bool =
  toBool(webkit_settings_get_enable_developer_extras(cast[ptr Settings00](self.impl)))

proc enableDeveloperExtras*(self: Settings): bool =
  toBool(webkit_settings_get_enable_developer_extras(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_dns_prefetching(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableDnsPrefetching*(self: Settings): bool =
  toBool(webkit_settings_get_enable_dns_prefetching(cast[ptr Settings00](self.impl)))

proc enableDnsPrefetching*(self: Settings): bool =
  toBool(webkit_settings_get_enable_dns_prefetching(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_encrypted_media(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableEncryptedMedia*(self: Settings): bool =
  toBool(webkit_settings_get_enable_encrypted_media(cast[ptr Settings00](self.impl)))

proc enableEncryptedMedia*(self: Settings): bool =
  toBool(webkit_settings_get_enable_encrypted_media(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_frame_flattening(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableFrameFlattening*(self: Settings): bool =
  toBool(webkit_settings_get_enable_frame_flattening(cast[ptr Settings00](self.impl)))

proc enableFrameFlattening*(self: Settings): bool =
  toBool(webkit_settings_get_enable_frame_flattening(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_fullscreen(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableFullscreen*(self: Settings): bool =
  toBool(webkit_settings_get_enable_fullscreen(cast[ptr Settings00](self.impl)))

proc enableFullscreen*(self: Settings): bool =
  toBool(webkit_settings_get_enable_fullscreen(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_html5_database(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableHtml5Database*(self: Settings): bool =
  toBool(webkit_settings_get_enable_html5_database(cast[ptr Settings00](self.impl)))

proc enableHtml5Database*(self: Settings): bool =
  toBool(webkit_settings_get_enable_html5_database(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_html5_local_storage(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableHtml5LocalStorage*(self: Settings): bool =
  toBool(webkit_settings_get_enable_html5_local_storage(cast[ptr Settings00](self.impl)))

proc enableHtml5LocalStorage*(self: Settings): bool =
  toBool(webkit_settings_get_enable_html5_local_storage(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_hyperlink_auditing(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableHyperlinkAuditing*(self: Settings): bool =
  toBool(webkit_settings_get_enable_hyperlink_auditing(cast[ptr Settings00](self.impl)))

proc enableHyperlinkAuditing*(self: Settings): bool =
  toBool(webkit_settings_get_enable_hyperlink_auditing(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_java(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableJava*(self: Settings): bool =
  toBool(webkit_settings_get_enable_java(cast[ptr Settings00](self.impl)))

proc enableJava*(self: Settings): bool =
  toBool(webkit_settings_get_enable_java(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_javascript(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableJavascript*(self: Settings): bool =
  toBool(webkit_settings_get_enable_javascript(cast[ptr Settings00](self.impl)))

proc enableJavascript*(self: Settings): bool =
  toBool(webkit_settings_get_enable_javascript(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_javascript_markup(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableJavascriptMarkup*(self: Settings): bool =
  toBool(webkit_settings_get_enable_javascript_markup(cast[ptr Settings00](self.impl)))

proc enableJavascriptMarkup*(self: Settings): bool =
  toBool(webkit_settings_get_enable_javascript_markup(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_media(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableMedia*(self: Settings): bool =
  toBool(webkit_settings_get_enable_media(cast[ptr Settings00](self.impl)))

proc enableMedia*(self: Settings): bool =
  toBool(webkit_settings_get_enable_media(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_media_capabilities(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableMediaCapabilities*(self: Settings): bool =
  toBool(webkit_settings_get_enable_media_capabilities(cast[ptr Settings00](self.impl)))

proc enableMediaCapabilities*(self: Settings): bool =
  toBool(webkit_settings_get_enable_media_capabilities(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_media_stream(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableMediaStream*(self: Settings): bool =
  toBool(webkit_settings_get_enable_media_stream(cast[ptr Settings00](self.impl)))

proc enableMediaStream*(self: Settings): bool =
  toBool(webkit_settings_get_enable_media_stream(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_mediasource(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableMediasource*(self: Settings): bool =
  toBool(webkit_settings_get_enable_mediasource(cast[ptr Settings00](self.impl)))

proc enableMediasource*(self: Settings): bool =
  toBool(webkit_settings_get_enable_mediasource(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_mock_capture_devices(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableMockCaptureDevices*(self: Settings): bool =
  toBool(webkit_settings_get_enable_mock_capture_devices(cast[ptr Settings00](self.impl)))

proc enableMockCaptureDevices*(self: Settings): bool =
  toBool(webkit_settings_get_enable_mock_capture_devices(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_offline_web_application_cache(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableOfflineWebApplicationCache*(self: Settings): bool =
  toBool(webkit_settings_get_enable_offline_web_application_cache(cast[ptr Settings00](self.impl)))

proc enableOfflineWebApplicationCache*(self: Settings): bool =
  toBool(webkit_settings_get_enable_offline_web_application_cache(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_page_cache(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnablePageCache*(self: Settings): bool =
  toBool(webkit_settings_get_enable_page_cache(cast[ptr Settings00](self.impl)))

proc enablePageCache*(self: Settings): bool =
  toBool(webkit_settings_get_enable_page_cache(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_plugins(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnablePlugins*(self: Settings): bool =
  toBool(webkit_settings_get_enable_plugins(cast[ptr Settings00](self.impl)))

proc enablePlugins*(self: Settings): bool =
  toBool(webkit_settings_get_enable_plugins(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_private_browsing(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnablePrivateBrowsing*(self: Settings): bool =
  toBool(webkit_settings_get_enable_private_browsing(cast[ptr Settings00](self.impl)))

proc enablePrivateBrowsing*(self: Settings): bool =
  toBool(webkit_settings_get_enable_private_browsing(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_resizable_text_areas(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableResizableTextAreas*(self: Settings): bool =
  toBool(webkit_settings_get_enable_resizable_text_areas(cast[ptr Settings00](self.impl)))

proc enableResizableTextAreas*(self: Settings): bool =
  toBool(webkit_settings_get_enable_resizable_text_areas(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_site_specific_quirks(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableSiteSpecificQuirks*(self: Settings): bool =
  toBool(webkit_settings_get_enable_site_specific_quirks(cast[ptr Settings00](self.impl)))

proc enableSiteSpecificQuirks*(self: Settings): bool =
  toBool(webkit_settings_get_enable_site_specific_quirks(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_smooth_scrolling(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableSmoothScrolling*(self: Settings): bool =
  toBool(webkit_settings_get_enable_smooth_scrolling(cast[ptr Settings00](self.impl)))

proc enableSmoothScrolling*(self: Settings): bool =
  toBool(webkit_settings_get_enable_smooth_scrolling(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_spatial_navigation(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableSpatialNavigation*(self: Settings): bool =
  toBool(webkit_settings_get_enable_spatial_navigation(cast[ptr Settings00](self.impl)))

proc enableSpatialNavigation*(self: Settings): bool =
  toBool(webkit_settings_get_enable_spatial_navigation(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_tabs_to_links(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableTabsToLinks*(self: Settings): bool =
  toBool(webkit_settings_get_enable_tabs_to_links(cast[ptr Settings00](self.impl)))

proc enableTabsToLinks*(self: Settings): bool =
  toBool(webkit_settings_get_enable_tabs_to_links(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_webaudio(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableWebaudio*(self: Settings): bool =
  toBool(webkit_settings_get_enable_webaudio(cast[ptr Settings00](self.impl)))

proc enableWebaudio*(self: Settings): bool =
  toBool(webkit_settings_get_enable_webaudio(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_webgl(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableWebgl*(self: Settings): bool =
  toBool(webkit_settings_get_enable_webgl(cast[ptr Settings00](self.impl)))

proc enableWebgl*(self: Settings): bool =
  toBool(webkit_settings_get_enable_webgl(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_write_console_messages_to_stdout(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableWriteConsoleMessagesToStdout*(self: Settings): bool =
  toBool(webkit_settings_get_enable_write_console_messages_to_stdout(cast[ptr Settings00](self.impl)))

proc enableWriteConsoleMessagesToStdout*(self: Settings): bool =
  toBool(webkit_settings_get_enable_write_console_messages_to_stdout(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_enable_xss_auditor(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getEnableXssAuditor*(self: Settings): bool =
  toBool(webkit_settings_get_enable_xss_auditor(cast[ptr Settings00](self.impl)))

proc enableXssAuditor*(self: Settings): bool =
  toBool(webkit_settings_get_enable_xss_auditor(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_fantasy_font_family(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getFantasyFontFamily*(self: Settings): string =
  result = $webkit_settings_get_fantasy_font_family(cast[ptr Settings00](self.impl))

proc fantasyFontFamily*(self: Settings): string =
  result = $webkit_settings_get_fantasy_font_family(cast[ptr Settings00](self.impl))

proc webkit_settings_get_javascript_can_access_clipboard(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getJavascriptCanAccessClipboard*(self: Settings): bool =
  toBool(webkit_settings_get_javascript_can_access_clipboard(cast[ptr Settings00](self.impl)))

proc javascriptCanAccessClipboard*(self: Settings): bool =
  toBool(webkit_settings_get_javascript_can_access_clipboard(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_javascript_can_open_windows_automatically(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getJavascriptCanOpenWindowsAutomatically*(self: Settings): bool =
  toBool(webkit_settings_get_javascript_can_open_windows_automatically(cast[ptr Settings00](self.impl)))

proc javascriptCanOpenWindowsAutomatically*(self: Settings): bool =
  toBool(webkit_settings_get_javascript_can_open_windows_automatically(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_load_icons_ignoring_image_load_setting(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getLoadIconsIgnoringImageLoadSetting*(self: Settings): bool =
  toBool(webkit_settings_get_load_icons_ignoring_image_load_setting(cast[ptr Settings00](self.impl)))

proc loadIconsIgnoringImageLoadSetting*(self: Settings): bool =
  toBool(webkit_settings_get_load_icons_ignoring_image_load_setting(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_media_content_types_requiring_hardware_support(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getMediaContentTypesRequiringHardwareSupport*(self: Settings): string =
  result = $webkit_settings_get_media_content_types_requiring_hardware_support(cast[ptr Settings00](self.impl))

proc mediaContentTypesRequiringHardwareSupport*(self: Settings): string =
  result = $webkit_settings_get_media_content_types_requiring_hardware_support(cast[ptr Settings00](self.impl))

proc webkit_settings_get_media_playback_allows_inline(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getMediaPlaybackAllowsInline*(self: Settings): bool =
  toBool(webkit_settings_get_media_playback_allows_inline(cast[ptr Settings00](self.impl)))

proc mediaPlaybackAllowsInline*(self: Settings): bool =
  toBool(webkit_settings_get_media_playback_allows_inline(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_media_playback_requires_user_gesture(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getMediaPlaybackRequiresUserGesture*(self: Settings): bool =
  toBool(webkit_settings_get_media_playback_requires_user_gesture(cast[ptr Settings00](self.impl)))

proc mediaPlaybackRequiresUserGesture*(self: Settings): bool =
  toBool(webkit_settings_get_media_playback_requires_user_gesture(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_minimum_font_size(self: ptr Settings00): uint32 {.
    importc, libprag.}

proc getMinimumFontSize*(self: Settings): int =
  int(webkit_settings_get_minimum_font_size(cast[ptr Settings00](self.impl)))

proc minimumFontSize*(self: Settings): int =
  int(webkit_settings_get_minimum_font_size(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_monospace_font_family(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getMonospaceFontFamily*(self: Settings): string =
  result = $webkit_settings_get_monospace_font_family(cast[ptr Settings00](self.impl))

proc monospaceFontFamily*(self: Settings): string =
  result = $webkit_settings_get_monospace_font_family(cast[ptr Settings00](self.impl))

proc webkit_settings_get_pictograph_font_family(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getPictographFontFamily*(self: Settings): string =
  result = $webkit_settings_get_pictograph_font_family(cast[ptr Settings00](self.impl))

proc pictographFontFamily*(self: Settings): string =
  result = $webkit_settings_get_pictograph_font_family(cast[ptr Settings00](self.impl))

proc webkit_settings_get_print_backgrounds(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getPrintBackgrounds*(self: Settings): bool =
  toBool(webkit_settings_get_print_backgrounds(cast[ptr Settings00](self.impl)))

proc printBackgrounds*(self: Settings): bool =
  toBool(webkit_settings_get_print_backgrounds(cast[ptr Settings00](self.impl)))

proc webkit_settings_get_sans_serif_font_family(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getSansSerifFontFamily*(self: Settings): string =
  result = $webkit_settings_get_sans_serif_font_family(cast[ptr Settings00](self.impl))

proc sansSerifFontFamily*(self: Settings): string =
  result = $webkit_settings_get_sans_serif_font_family(cast[ptr Settings00](self.impl))

proc webkit_settings_get_serif_font_family(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getSerifFontFamily*(self: Settings): string =
  result = $webkit_settings_get_serif_font_family(cast[ptr Settings00](self.impl))

proc serifFontFamily*(self: Settings): string =
  result = $webkit_settings_get_serif_font_family(cast[ptr Settings00](self.impl))

proc webkit_settings_get_user_agent(self: ptr Settings00): cstring {.
    importc, libprag.}

proc getUserAgent*(self: Settings): string =
  result = $webkit_settings_get_user_agent(cast[ptr Settings00](self.impl))

proc userAgent*(self: Settings): string =
  result = $webkit_settings_get_user_agent(cast[ptr Settings00](self.impl))

proc webkit_settings_get_zoom_text_only(self: ptr Settings00): gboolean {.
    importc, libprag.}

proc getZoomTextOnly*(self: Settings): bool =
  toBool(webkit_settings_get_zoom_text_only(cast[ptr Settings00](self.impl)))

proc zoomTextOnly*(self: Settings): bool =
  toBool(webkit_settings_get_zoom_text_only(cast[ptr Settings00](self.impl)))

proc webkit_settings_set_allow_file_access_from_file_urls(self: ptr Settings00;
    allowed: gboolean) {.
    importc, libprag.}

proc setAllowFileAccessFromFileUrls*(self: Settings;
    allowed: bool = true) =
  webkit_settings_set_allow_file_access_from_file_urls(cast[ptr Settings00](self.impl), gboolean(allowed))

proc `allowFileAccessFromFileUrls=`*(self: Settings;
    allowed: bool) =
  webkit_settings_set_allow_file_access_from_file_urls(cast[ptr Settings00](self.impl), gboolean(allowed))

proc webkit_settings_set_allow_modal_dialogs(self: ptr Settings00; allowed: gboolean) {.
    importc, libprag.}

proc setAllowModalDialogs*(self: Settings; allowed: bool = true) =
  webkit_settings_set_allow_modal_dialogs(cast[ptr Settings00](self.impl), gboolean(allowed))

proc `allowModalDialogs=`*(self: Settings; allowed: bool) =
  webkit_settings_set_allow_modal_dialogs(cast[ptr Settings00](self.impl), gboolean(allowed))

proc webkit_settings_set_allow_top_navigation_to_data_urls(self: ptr Settings00;
    allowed: gboolean) {.
    importc, libprag.}

proc setAllowTopNavigationToDataUrls*(self: Settings;
    allowed: bool = true) =
  webkit_settings_set_allow_top_navigation_to_data_urls(cast[ptr Settings00](self.impl), gboolean(allowed))

proc `allowTopNavigationToDataUrls=`*(self: Settings;
    allowed: bool) =
  webkit_settings_set_allow_top_navigation_to_data_urls(cast[ptr Settings00](self.impl), gboolean(allowed))

proc webkit_settings_set_allow_universal_access_from_file_urls(self: ptr Settings00;
    allowed: gboolean) {.
    importc, libprag.}

proc setAllowUniversalAccessFromFileUrls*(self: Settings;
    allowed: bool = true) =
  webkit_settings_set_allow_universal_access_from_file_urls(cast[ptr Settings00](self.impl), gboolean(allowed))

proc `allowUniversalAccessFromFileUrls=`*(self: Settings;
    allowed: bool) =
  webkit_settings_set_allow_universal_access_from_file_urls(cast[ptr Settings00](self.impl), gboolean(allowed))

proc webkit_settings_set_auto_load_images(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setAutoLoadImages*(self: Settings; enabled: bool = true) =
  webkit_settings_set_auto_load_images(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `autoLoadImages=`*(self: Settings; enabled: bool) =
  webkit_settings_set_auto_load_images(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_cursive_font_family(self: ptr Settings00; cursiveFontFamily: cstring) {.
    importc, libprag.}

proc setCursiveFontFamily*(self: Settings; cursiveFontFamily: cstring) =
  webkit_settings_set_cursive_font_family(cast[ptr Settings00](self.impl), cursiveFontFamily)

proc `cursiveFontFamily=`*(self: Settings; cursiveFontFamily: cstring) =
  webkit_settings_set_cursive_font_family(cast[ptr Settings00](self.impl), cursiveFontFamily)

proc webkit_settings_set_default_charset(self: ptr Settings00; defaultCharset: cstring) {.
    importc, libprag.}

proc setDefaultCharset*(self: Settings; defaultCharset: cstring) =
  webkit_settings_set_default_charset(cast[ptr Settings00](self.impl), defaultCharset)

proc `defaultCharset=`*(self: Settings; defaultCharset: cstring) =
  webkit_settings_set_default_charset(cast[ptr Settings00](self.impl), defaultCharset)

proc webkit_settings_set_default_font_family(self: ptr Settings00; defaultFontFamily: cstring) {.
    importc, libprag.}

proc setDefaultFontFamily*(self: Settings; defaultFontFamily: cstring) =
  webkit_settings_set_default_font_family(cast[ptr Settings00](self.impl), defaultFontFamily)

proc `defaultFontFamily=`*(self: Settings; defaultFontFamily: cstring) =
  webkit_settings_set_default_font_family(cast[ptr Settings00](self.impl), defaultFontFamily)

proc webkit_settings_set_default_font_size(self: ptr Settings00; fontSize: uint32) {.
    importc, libprag.}

proc setDefaultFontSize*(self: Settings; fontSize: int) =
  webkit_settings_set_default_font_size(cast[ptr Settings00](self.impl), uint32(fontSize))

proc `defaultFontSize=`*(self: Settings; fontSize: int) =
  webkit_settings_set_default_font_size(cast[ptr Settings00](self.impl), uint32(fontSize))

proc webkit_settings_set_default_monospace_font_size(self: ptr Settings00;
    fontSize: uint32) {.
    importc, libprag.}

proc setDefaultMonospaceFontSize*(self: Settings; fontSize: int) =
  webkit_settings_set_default_monospace_font_size(cast[ptr Settings00](self.impl), uint32(fontSize))

proc `defaultMonospaceFontSize=`*(self: Settings; fontSize: int) =
  webkit_settings_set_default_monospace_font_size(cast[ptr Settings00](self.impl), uint32(fontSize))

proc webkit_settings_set_draw_compositing_indicators(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setDrawCompositingIndicators*(self: Settings; enabled: bool = true) =
  webkit_settings_set_draw_compositing_indicators(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `drawCompositingIndicators=`*(self: Settings; enabled: bool) =
  webkit_settings_set_draw_compositing_indicators(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_accelerated_2d_canvas(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableAccelerated_2dCanvas*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_accelerated_2d_canvas(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableAccelerated_2dCanvas=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_accelerated_2d_canvas(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_back_forward_navigation_gestures(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableBackForwardNavigationGestures*(self: Settings;
    enabled: bool = true) =
  webkit_settings_set_enable_back_forward_navigation_gestures(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableBackForwardNavigationGestures=`*(self: Settings;
    enabled: bool) =
  webkit_settings_set_enable_back_forward_navigation_gestures(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_caret_browsing(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableCaretBrowsing*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_caret_browsing(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableCaretBrowsing=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_caret_browsing(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_developer_extras(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableDeveloperExtras*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_developer_extras(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableDeveloperExtras=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_developer_extras(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_dns_prefetching(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableDnsPrefetching*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_dns_prefetching(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableDnsPrefetching=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_dns_prefetching(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_encrypted_media(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableEncryptedMedia*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_encrypted_media(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableEncryptedMedia=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_encrypted_media(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_frame_flattening(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableFrameFlattening*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_frame_flattening(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableFrameFlattening=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_frame_flattening(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_fullscreen(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableFullscreen*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_fullscreen(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableFullscreen=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_fullscreen(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_html5_database(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableHtml5Database*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_html5_database(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableHtml5Database=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_html5_database(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_html5_local_storage(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableHtml5LocalStorage*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_html5_local_storage(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableHtml5LocalStorage=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_html5_local_storage(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_hyperlink_auditing(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableHyperlinkAuditing*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_hyperlink_auditing(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableHyperlinkAuditing=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_hyperlink_auditing(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_java(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableJava*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_java(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableJava=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_java(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_javascript(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableJavascript*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_javascript(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableJavascript=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_javascript(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_javascript_markup(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableJavascriptMarkup*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_javascript_markup(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableJavascriptMarkup=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_javascript_markup(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_media(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableMedia*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_media(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableMedia=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_media(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_media_capabilities(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableMediaCapabilities*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_media_capabilities(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableMediaCapabilities=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_media_capabilities(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_media_stream(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableMediaStream*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_media_stream(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableMediaStream=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_media_stream(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_mediasource(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableMediasource*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_mediasource(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableMediasource=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_mediasource(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_mock_capture_devices(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableMockCaptureDevices*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_mock_capture_devices(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableMockCaptureDevices=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_mock_capture_devices(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_offline_web_application_cache(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableOfflineWebApplicationCache*(self: Settings;
    enabled: bool = true) =
  webkit_settings_set_enable_offline_web_application_cache(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableOfflineWebApplicationCache=`*(self: Settings;
    enabled: bool) =
  webkit_settings_set_enable_offline_web_application_cache(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_page_cache(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnablePageCache*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_page_cache(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enablePageCache=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_page_cache(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_plugins(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnablePlugins*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_plugins(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enablePlugins=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_plugins(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_private_browsing(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnablePrivateBrowsing*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_private_browsing(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enablePrivateBrowsing=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_private_browsing(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_resizable_text_areas(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableResizableTextAreas*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_resizable_text_areas(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableResizableTextAreas=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_resizable_text_areas(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_site_specific_quirks(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableSiteSpecificQuirks*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_site_specific_quirks(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableSiteSpecificQuirks=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_site_specific_quirks(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_smooth_scrolling(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableSmoothScrolling*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_smooth_scrolling(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableSmoothScrolling=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_smooth_scrolling(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_spatial_navigation(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableSpatialNavigation*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_spatial_navigation(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableSpatialNavigation=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_spatial_navigation(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_tabs_to_links(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableTabsToLinks*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_tabs_to_links(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableTabsToLinks=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_tabs_to_links(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_webaudio(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableWebaudio*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_webaudio(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableWebaudio=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_webaudio(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_webgl(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableWebgl*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_webgl(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableWebgl=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_webgl(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_write_console_messages_to_stdout(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setEnableWriteConsoleMessagesToStdout*(self: Settings;
    enabled: bool = true) =
  webkit_settings_set_enable_write_console_messages_to_stdout(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableWriteConsoleMessagesToStdout=`*(self: Settings;
    enabled: bool) =
  webkit_settings_set_enable_write_console_messages_to_stdout(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_enable_xss_auditor(self: ptr Settings00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableXssAuditor*(self: Settings; enabled: bool = true) =
  webkit_settings_set_enable_xss_auditor(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `enableXssAuditor=`*(self: Settings; enabled: bool) =
  webkit_settings_set_enable_xss_auditor(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_fantasy_font_family(self: ptr Settings00; fantasyFontFamily: cstring) {.
    importc, libprag.}

proc setFantasyFontFamily*(self: Settings; fantasyFontFamily: cstring) =
  webkit_settings_set_fantasy_font_family(cast[ptr Settings00](self.impl), fantasyFontFamily)

proc `fantasyFontFamily=`*(self: Settings; fantasyFontFamily: cstring) =
  webkit_settings_set_fantasy_font_family(cast[ptr Settings00](self.impl), fantasyFontFamily)

proc webkit_settings_set_javascript_can_access_clipboard(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setJavascriptCanAccessClipboard*(self: Settings;
    enabled: bool = true) =
  webkit_settings_set_javascript_can_access_clipboard(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `javascriptCanAccessClipboard=`*(self: Settings;
    enabled: bool) =
  webkit_settings_set_javascript_can_access_clipboard(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_javascript_can_open_windows_automatically(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setJavascriptCanOpenWindowsAutomatically*(self: Settings;
    enabled: bool = true) =
  webkit_settings_set_javascript_can_open_windows_automatically(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `javascriptCanOpenWindowsAutomatically=`*(self: Settings;
    enabled: bool) =
  webkit_settings_set_javascript_can_open_windows_automatically(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_load_icons_ignoring_image_load_setting(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setLoadIconsIgnoringImageLoadSetting*(self: Settings;
    enabled: bool = true) =
  webkit_settings_set_load_icons_ignoring_image_load_setting(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `loadIconsIgnoringImageLoadSetting=`*(self: Settings;
    enabled: bool) =
  webkit_settings_set_load_icons_ignoring_image_load_setting(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_media_content_types_requiring_hardware_support(self: ptr Settings00;
    contentTypes: cstring) {.
    importc, libprag.}

proc setMediaContentTypesRequiringHardwareSupport*(self: Settings;
    contentTypes: cstring = nil) =
  webkit_settings_set_media_content_types_requiring_hardware_support(cast[ptr Settings00](self.impl), contentTypes)

proc `mediaContentTypesRequiringHardwareSupport=`*(self: Settings;
    contentTypes: cstring = nil) =
  webkit_settings_set_media_content_types_requiring_hardware_support(cast[ptr Settings00](self.impl), contentTypes)

proc webkit_settings_set_media_playback_allows_inline(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setMediaPlaybackAllowsInline*(self: Settings; enabled: bool = true) =
  webkit_settings_set_media_playback_allows_inline(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `mediaPlaybackAllowsInline=`*(self: Settings; enabled: bool) =
  webkit_settings_set_media_playback_allows_inline(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_media_playback_requires_user_gesture(self: ptr Settings00;
    enabled: gboolean) {.
    importc, libprag.}

proc setMediaPlaybackRequiresUserGesture*(self: Settings;
    enabled: bool = true) =
  webkit_settings_set_media_playback_requires_user_gesture(cast[ptr Settings00](self.impl), gboolean(enabled))

proc `mediaPlaybackRequiresUserGesture=`*(self: Settings;
    enabled: bool) =
  webkit_settings_set_media_playback_requires_user_gesture(cast[ptr Settings00](self.impl), gboolean(enabled))

proc webkit_settings_set_minimum_font_size(self: ptr Settings00; fontSize: uint32) {.
    importc, libprag.}

proc setMinimumFontSize*(self: Settings; fontSize: int) =
  webkit_settings_set_minimum_font_size(cast[ptr Settings00](self.impl), uint32(fontSize))

proc `minimumFontSize=`*(self: Settings; fontSize: int) =
  webkit_settings_set_minimum_font_size(cast[ptr Settings00](self.impl), uint32(fontSize))

proc webkit_settings_set_monospace_font_family(self: ptr Settings00; monospaceFontFamily: cstring) {.
    importc, libprag.}

proc setMonospaceFontFamily*(self: Settings; monospaceFontFamily: cstring) =
  webkit_settings_set_monospace_font_family(cast[ptr Settings00](self.impl), monospaceFontFamily)

proc `monospaceFontFamily=`*(self: Settings; monospaceFontFamily: cstring) =
  webkit_settings_set_monospace_font_family(cast[ptr Settings00](self.impl), monospaceFontFamily)

proc webkit_settings_set_pictograph_font_family(self: ptr Settings00; pictographFontFamily: cstring) {.
    importc, libprag.}

proc setPictographFontFamily*(self: Settings; pictographFontFamily: cstring) =
  webkit_settings_set_pictograph_font_family(cast[ptr Settings00](self.impl), pictographFontFamily)

proc `pictographFontFamily=`*(self: Settings; pictographFontFamily: cstring) =
  webkit_settings_set_pictograph_font_family(cast[ptr Settings00](self.impl), pictographFontFamily)

proc webkit_settings_set_print_backgrounds(self: ptr Settings00; printBackgrounds: gboolean) {.
    importc, libprag.}

proc setPrintBackgrounds*(self: Settings; printBackgrounds: bool = true) =
  webkit_settings_set_print_backgrounds(cast[ptr Settings00](self.impl), gboolean(printBackgrounds))

proc `printBackgrounds=`*(self: Settings; printBackgrounds: bool) =
  webkit_settings_set_print_backgrounds(cast[ptr Settings00](self.impl), gboolean(printBackgrounds))

proc webkit_settings_set_sans_serif_font_family(self: ptr Settings00; sansSerifFontFamily: cstring) {.
    importc, libprag.}

proc setSansSerifFontFamily*(self: Settings; sansSerifFontFamily: cstring) =
  webkit_settings_set_sans_serif_font_family(cast[ptr Settings00](self.impl), sansSerifFontFamily)

proc `sansSerifFontFamily=`*(self: Settings; sansSerifFontFamily: cstring) =
  webkit_settings_set_sans_serif_font_family(cast[ptr Settings00](self.impl), sansSerifFontFamily)

proc webkit_settings_set_serif_font_family(self: ptr Settings00; serifFontFamily: cstring) {.
    importc, libprag.}

proc setSerifFontFamily*(self: Settings; serifFontFamily: cstring) =
  webkit_settings_set_serif_font_family(cast[ptr Settings00](self.impl), serifFontFamily)

proc `serifFontFamily=`*(self: Settings; serifFontFamily: cstring) =
  webkit_settings_set_serif_font_family(cast[ptr Settings00](self.impl), serifFontFamily)

proc webkit_settings_set_user_agent(self: ptr Settings00; userAgent: cstring) {.
    importc, libprag.}

proc setUserAgent*(self: Settings; userAgent: cstring = nil) =
  webkit_settings_set_user_agent(cast[ptr Settings00](self.impl), userAgent)

proc `userAgent=`*(self: Settings; userAgent: cstring = nil) =
  webkit_settings_set_user_agent(cast[ptr Settings00](self.impl), userAgent)

proc webkit_settings_set_user_agent_with_application_details(self: ptr Settings00;
    applicationName: cstring; applicationVersion: cstring) {.
    importc, libprag.}

proc setUserAgentWithApplicationDetails*(self: Settings;
    applicationName: cstring = nil; applicationVersion: cstring = nil) =
  webkit_settings_set_user_agent_with_application_details(cast[ptr Settings00](self.impl), applicationName, applicationVersion)

proc webkit_settings_set_zoom_text_only(self: ptr Settings00; zoomTextOnly: gboolean) {.
    importc, libprag.}

proc setZoomTextOnly*(self: Settings; zoomTextOnly: bool = true) =
  webkit_settings_set_zoom_text_only(cast[ptr Settings00](self.impl), gboolean(zoomTextOnly))

proc `zoomTextOnly=`*(self: Settings; zoomTextOnly: bool) =
  webkit_settings_set_zoom_text_only(cast[ptr Settings00](self.impl), gboolean(zoomTextOnly))

proc webkit_web_view_new_with_settings(settings: ptr Settings00): ptr WebView00 {.
    importc, libprag.}

proc newWebViewWithSettings*(settings: Settings): WebView =
  let gobj = webkit_web_view_new_with_settings(cast[ptr Settings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebViewWithSettings*(tdesc: typedesc; settings: Settings): tdesc =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_settings(cast[ptr Settings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebViewWithSettings*[T](result: var T; settings: Settings) {.deprecated.} =
  assert(result is WebView)
  let gobj = webkit_web_view_new_with_settings(cast[ptr Settings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_get_settings(self: ptr WebView00): ptr Settings00 {.
    importc, libprag.}

proc getSettings*(self: WebView): Settings =
  let gobj = webkit_web_view_get_settings(cast[ptr WebView00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_view_set_settings(self: ptr WebView00; settings: ptr Settings00) {.
    importc, libprag.}

proc setSettings*(self: WebView; settings: Settings) =
  webkit_web_view_set_settings(cast[ptr WebView00](self.impl), cast[ptr Settings00](settings.impl))

proc `settings=`*(self: WebView; settings: Settings) =
  webkit_web_view_set_settings(cast[ptr WebView00](self.impl), cast[ptr Settings00](settings.impl))

type
  HardwareAccelerationPolicy* {.size: sizeof(cint), pure.} = enum
    onDemand = 0
    always = 1
    never = 2

proc webkit_settings_get_hardware_acceleration_policy(self: ptr Settings00): HardwareAccelerationPolicy {.
    importc, libprag.}

proc getHardwareAccelerationPolicy*(self: Settings): HardwareAccelerationPolicy =
  webkit_settings_get_hardware_acceleration_policy(cast[ptr Settings00](self.impl))

proc hardwareAccelerationPolicy*(self: Settings): HardwareAccelerationPolicy =
  webkit_settings_get_hardware_acceleration_policy(cast[ptr Settings00](self.impl))

proc webkit_settings_set_hardware_acceleration_policy(self: ptr Settings00;
    policy: HardwareAccelerationPolicy) {.
    importc, libprag.}

proc setHardwareAccelerationPolicy*(self: Settings; policy: HardwareAccelerationPolicy) =
  webkit_settings_set_hardware_acceleration_policy(cast[ptr Settings00](self.impl), policy)

proc `hardwareAccelerationPolicy=`*(self: Settings; policy: HardwareAccelerationPolicy) =
  webkit_settings_set_hardware_acceleration_policy(cast[ptr Settings00](self.impl), policy)

type
  OptionMenuItem00* {.pure.} = object
  OptionMenuItem* = ref object
    impl*: ptr OptionMenuItem00
    ignoreFinalizer*: bool

proc webkit_option_menu_item_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitOptionMenuItem*(self: OptionMenuItem) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_option_menu_item_get_type(), cast[ptr OptionMenuItem00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(OptionMenuItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_option_menu_item_get_type(), cast[ptr OptionMenuItem00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var OptionMenuItem) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitOptionMenuItem)

proc webkit_option_menu_item_free(self: ptr OptionMenuItem00) {.
    importc, libprag.}

proc free*(self: OptionMenuItem) =
  webkit_option_menu_item_free(cast[ptr OptionMenuItem00](self.impl))

proc finalizerfree*(self: OptionMenuItem) =
  if not self.ignoreFinalizer:
    webkit_option_menu_item_free(cast[ptr OptionMenuItem00](self.impl))

proc webkit_option_menu_item_copy(self: ptr OptionMenuItem00): ptr OptionMenuItem00 {.
    importc, libprag.}

proc copy*(self: OptionMenuItem): OptionMenuItem =
  fnew(result, gBoxedFreeWebKitOptionMenuItem)
  result.impl = webkit_option_menu_item_copy(cast[ptr OptionMenuItem00](self.impl))

proc webkit_option_menu_item_get_label(self: ptr OptionMenuItem00): cstring {.
    importc, libprag.}

proc getLabel*(self: OptionMenuItem): string =
  result = $webkit_option_menu_item_get_label(cast[ptr OptionMenuItem00](self.impl))

proc label*(self: OptionMenuItem): string =
  result = $webkit_option_menu_item_get_label(cast[ptr OptionMenuItem00](self.impl))

proc webkit_option_menu_item_get_tooltip(self: ptr OptionMenuItem00): cstring {.
    importc, libprag.}

proc getTooltip*(self: OptionMenuItem): string =
  result = $webkit_option_menu_item_get_tooltip(cast[ptr OptionMenuItem00](self.impl))

proc tooltip*(self: OptionMenuItem): string =
  result = $webkit_option_menu_item_get_tooltip(cast[ptr OptionMenuItem00](self.impl))

proc webkit_option_menu_item_is_enabled(self: ptr OptionMenuItem00): gboolean {.
    importc, libprag.}

proc isEnabled*(self: OptionMenuItem): bool =
  toBool(webkit_option_menu_item_is_enabled(cast[ptr OptionMenuItem00](self.impl)))

proc webkit_option_menu_item_is_group_child(self: ptr OptionMenuItem00): gboolean {.
    importc, libprag.}

proc isGroupChild*(self: OptionMenuItem): bool =
  toBool(webkit_option_menu_item_is_group_child(cast[ptr OptionMenuItem00](self.impl)))

proc webkit_option_menu_item_is_group_label(self: ptr OptionMenuItem00): gboolean {.
    importc, libprag.}

proc isGroupLabel*(self: OptionMenuItem): bool =
  toBool(webkit_option_menu_item_is_group_label(cast[ptr OptionMenuItem00](self.impl)))

proc webkit_option_menu_item_is_selected(self: ptr OptionMenuItem00): gboolean {.
    importc, libprag.}

proc isSelected*(self: OptionMenuItem): bool =
  toBool(webkit_option_menu_item_is_selected(cast[ptr OptionMenuItem00](self.impl)))

proc webkit_option_menu_get_item(self: ptr OptionMenu00; index: uint32): ptr OptionMenuItem00 {.
    importc, libprag.}

proc getItem*(self: OptionMenu; index: int): OptionMenuItem =
  fnew(result, gBoxedFreeWebKitOptionMenuItem)
  result.impl = webkit_option_menu_get_item(cast[ptr OptionMenu00](self.impl), uint32(index))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(webkit_option_menu_item_get_type(), result.impl))

type
  ScriptDialogType* {.size: sizeof(cint), pure.} = enum
    alert = 0
    confirm = 1
    prompt = 2
    beforeUnloadConfirm = 3

proc webkit_script_dialog_get_dialog_type(self: ptr ScriptDialog00): ScriptDialogType {.
    importc, libprag.}

proc getDialogType*(self: ScriptDialog): ScriptDialogType =
  webkit_script_dialog_get_dialog_type(cast[ptr ScriptDialog00](self.impl))

proc dialogType*(self: ScriptDialog): ScriptDialogType =
  webkit_script_dialog_get_dialog_type(cast[ptr ScriptDialog00](self.impl))

type
  ContextMenuItem* = ref object of gobject.InitiallyUnowned
  ContextMenuItem00* = object of gobject.InitiallyUnowned00

proc webkit_context_menu_item_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContextMenuItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_context_menu_item_new(action: ptr gtk.Action00): ptr ContextMenuItem00 {.
    importc, libprag.}

proc newContextMenuItem*(action: gtk.Action): ContextMenuItem {.deprecated.}  =
  let gobj = webkit_context_menu_item_new(cast[ptr gtk.Action00](action.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenuItem*(tdesc: typedesc; action: gtk.Action): tdesc {.deprecated.}  =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new(cast[ptr gtk.Action00](action.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenuItem*[T](result: var T; action: gtk.Action) {.deprecated.} =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new(cast[ptr gtk.Action00](action.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_new_from_gaction(action: ptr gio.Action00;
    label: cstring; target: ptr glib.Variant00): ptr ContextMenuItem00 {.
    importc, libprag.}

proc newContextMenuItemFromGaction*(action: gio.Action; label: cstring;
    target: glib.Variant = nil): ContextMenuItem =
  let gobj = webkit_context_menu_item_new_from_gaction(cast[ptr gio.Action00](action.impl), label, if target.isNil: nil else: cast[ptr glib.Variant00](target.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenuItemFromGaction*(tdesc: typedesc; action: gio.Action; label: cstring;
    target: glib.Variant = nil): tdesc =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_from_gaction(cast[ptr gio.Action00](action.impl), label, if target.isNil: nil else: cast[ptr glib.Variant00](target.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenuItemFromGaction*[T](result: var T; action: gio.Action; label: cstring;
    target: glib.Variant = nil) {.deprecated.} =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_from_gaction(cast[ptr gio.Action00](action.impl), label, if target.isNil: nil else: cast[ptr glib.Variant00](target.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_new_separator(): ptr ContextMenuItem00 {.
    importc, libprag.}

proc newContextMenuItemSeparator*(): ContextMenuItem =
  let gobj = webkit_context_menu_item_new_separator()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenuItemSeparator*(tdesc: typedesc): tdesc =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_separator()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenuItemSeparator*[T](result: var T) {.deprecated.} =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_separator()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_new_with_submenu(label: cstring; submenu: ptr ContextMenu00): ptr ContextMenuItem00 {.
    importc, libprag.}

proc newContextMenuItemWithSubmenu*(label: cstring; submenu: ContextMenu): ContextMenuItem =
  let gobj = webkit_context_menu_item_new_with_submenu(label, cast[ptr ContextMenu00](submenu.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenuItemWithSubmenu*(tdesc: typedesc; label: cstring; submenu: ContextMenu): tdesc =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_with_submenu(label, cast[ptr ContextMenu00](submenu.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenuItemWithSubmenu*[T](result: var T; label: cstring; submenu: ContextMenu) {.deprecated.} =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_with_submenu(label, cast[ptr ContextMenu00](submenu.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_get_action(self: ptr ContextMenuItem00): ptr gtk.Action00 {.
    importc, libprag.}

proc getAction*(self: ContextMenuItem): gtk.Action =
  let gobj = webkit_context_menu_item_get_action(cast[ptr ContextMenuItem00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc action*(self: ContextMenuItem): gtk.Action =
  let gobj = webkit_context_menu_item_get_action(cast[ptr ContextMenuItem00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_get_gaction(self: ptr ContextMenuItem00): ptr gio.Action00 {.
    importc, libprag.}

proc getGaction*(self: ContextMenuItem): gio.Action =
  let gobj = webkit_context_menu_item_get_gaction(cast[ptr ContextMenuItem00](self.impl))
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

proc gaction*(self: ContextMenuItem): gio.Action =
  let gobj = webkit_context_menu_item_get_gaction(cast[ptr ContextMenuItem00](self.impl))
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

proc webkit_context_menu_item_get_submenu(self: ptr ContextMenuItem00): ptr ContextMenu00 {.
    importc, libprag.}

proc getSubmenu*(self: ContextMenuItem): ContextMenu =
  let gobj = webkit_context_menu_item_get_submenu(cast[ptr ContextMenuItem00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc submenu*(self: ContextMenuItem): ContextMenu =
  let gobj = webkit_context_menu_item_get_submenu(cast[ptr ContextMenuItem00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_is_separator(self: ptr ContextMenuItem00): gboolean {.
    importc, libprag.}

proc isSeparator*(self: ContextMenuItem): bool =
  toBool(webkit_context_menu_item_is_separator(cast[ptr ContextMenuItem00](self.impl)))

proc webkit_context_menu_item_set_submenu(self: ptr ContextMenuItem00; submenu: ptr ContextMenu00) {.
    importc, libprag.}

proc setSubmenu*(self: ContextMenuItem; submenu: ContextMenu = nil) =
  webkit_context_menu_item_set_submenu(cast[ptr ContextMenuItem00](self.impl), if submenu.isNil: nil else: cast[ptr ContextMenu00](submenu.impl))

proc `submenu=`*(self: ContextMenuItem; submenu: ContextMenu = nil) =
  webkit_context_menu_item_set_submenu(cast[ptr ContextMenuItem00](self.impl), if submenu.isNil: nil else: cast[ptr ContextMenu00](submenu.impl))

proc webkit_context_menu_new_with_items(items: ptr glib.List): ptr ContextMenu00 {.
    importc, libprag.}

proc newContextMenuWithItems*(items: seq[ContextMenuItem]): ContextMenu =
  var tempResGL = seq2GList(items)
  let gobj = webkit_context_menu_new_with_items(tempResGL)
  g_list_free(tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenuWithItems*(tdesc: typedesc; items: seq[ContextMenuItem]): tdesc =
  assert(result is ContextMenu)
  var tempResGL = seq2GList(items)
  let gobj = webkit_context_menu_new_with_items(tempResGL)
  g_list_free(tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenuWithItems*[T](result: var T; items: seq[ContextMenuItem]) {.deprecated.} =
  assert(result is ContextMenu)
  var tempResGL = seq2GList(items)
  let gobj = webkit_context_menu_new_with_items(tempResGL)
  g_list_free(tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_append(self: ptr ContextMenu00; item: ptr ContextMenuItem00) {.
    importc, libprag.}

proc append*(self: ContextMenu; item: ContextMenuItem) =
  webkit_context_menu_append(cast[ptr ContextMenu00](self.impl), cast[ptr ContextMenuItem00](item.impl))

proc webkit_context_menu_first(self: ptr ContextMenu00): ptr ContextMenuItem00 {.
    importc, libprag.}

proc first*(self: ContextMenu): ContextMenuItem =
  let gobj = webkit_context_menu_first(cast[ptr ContextMenu00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_get_item_at_position(self: ptr ContextMenu00; position: uint32): ptr ContextMenuItem00 {.
    importc, libprag.}

proc getItemAtPosition*(self: ContextMenu; position: int): ContextMenuItem =
  let gobj = webkit_context_menu_get_item_at_position(cast[ptr ContextMenu00](self.impl), uint32(position))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_get_items(self: ptr ContextMenu00): ptr glib.List {.
    importc, libprag.}

proc getItems*(self: ContextMenu): seq[ContextMenuItem] =
  result = glistObjects2seq(ContextMenuItem, webkit_context_menu_get_items(cast[ptr ContextMenu00](self.impl)), false)

proc items*(self: ContextMenu): seq[ContextMenuItem] =
  result = glistObjects2seq(ContextMenuItem, webkit_context_menu_get_items(cast[ptr ContextMenu00](self.impl)), false)

proc webkit_context_menu_insert(self: ptr ContextMenu00; item: ptr ContextMenuItem00;
    position: int32) {.
    importc, libprag.}

proc insert*(self: ContextMenu; item: ContextMenuItem;
    position: int) =
  webkit_context_menu_insert(cast[ptr ContextMenu00](self.impl), cast[ptr ContextMenuItem00](item.impl), int32(position))

proc webkit_context_menu_last(self: ptr ContextMenu00): ptr ContextMenuItem00 {.
    importc, libprag.}

proc last*(self: ContextMenu): ContextMenuItem =
  let gobj = webkit_context_menu_last(cast[ptr ContextMenu00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_move_item(self: ptr ContextMenu00; item: ptr ContextMenuItem00;
    position: int32) {.
    importc, libprag.}

proc moveItem*(self: ContextMenu; item: ContextMenuItem;
    position: int) =
  webkit_context_menu_move_item(cast[ptr ContextMenu00](self.impl), cast[ptr ContextMenuItem00](item.impl), int32(position))

proc webkit_context_menu_prepend(self: ptr ContextMenu00; item: ptr ContextMenuItem00) {.
    importc, libprag.}

proc prepend*(self: ContextMenu; item: ContextMenuItem) =
  webkit_context_menu_prepend(cast[ptr ContextMenu00](self.impl), cast[ptr ContextMenuItem00](item.impl))

proc webkit_context_menu_remove(self: ptr ContextMenu00; item: ptr ContextMenuItem00) {.
    importc, libprag.}

proc remove*(self: ContextMenu; item: ContextMenuItem) =
  webkit_context_menu_remove(cast[ptr ContextMenu00](self.impl), cast[ptr ContextMenuItem00](item.impl))

type
  ContextMenuAction* {.size: sizeof(cint), pure.} = enum
    noAction = 0
    openLink = 1
    openLinkInNewWindow = 2
    downloadLinkToDisk = 3
    copyLinkToClipboard = 4
    openImageInNewWindow = 5
    downloadImageToDisk = 6
    copyImageToClipboard = 7
    copyImageUrlToClipboard = 8
    openFrameInNewWindow = 9
    goBack = 10
    goForward = 11
    stop = 12
    reload = 13
    copy = 14
    cut = 15
    paste = 16
    delete = 17
    selectAll = 18
    inputMethods = 19
    unicode = 20
    spellingGuess = 21
    noGuessesFound = 22
    ignoreSpelling = 23
    learnSpelling = 24
    ignoreGrammar = 25
    fontMenu = 26
    bold = 27
    italic = 28
    underline = 29
    outline = 30
    inspectElement = 31
    openVideoInNewWindow = 32
    openAudioInNewWindow = 33
    copyVideoLinkToClipboard = 34
    copyAudioLinkToClipboard = 35
    toggleMediaControls = 36
    toggleMediaLoop = 37
    enterVideoFullscreen = 38
    mediaPlay = 39
    mediaPause = 40
    mediaMute = 41
    downloadVideoToDisk = 42
    downloadAudioToDisk = 43
    insertEmoji = 44
    pasteAsPlainText = 45
    custom = 10000

proc webkit_context_menu_item_new_from_stock_action(action: ContextMenuAction): ptr ContextMenuItem00 {.
    importc, libprag.}

proc newContextMenuItemFromStockAction*(action: ContextMenuAction): ContextMenuItem =
  let gobj = webkit_context_menu_item_new_from_stock_action(action)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenuItemFromStockAction*(tdesc: typedesc; action: ContextMenuAction): tdesc =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_from_stock_action(action)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenuItemFromStockAction*[T](result: var T; action: ContextMenuAction) {.deprecated.} =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_from_stock_action(action)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_new_from_stock_action_with_label(action: ContextMenuAction;
    label: cstring): ptr ContextMenuItem00 {.
    importc, libprag.}

proc newContextMenuItemFromStockActionWithLabel*(action: ContextMenuAction;
    label: cstring): ContextMenuItem =
  let gobj = webkit_context_menu_item_new_from_stock_action_with_label(action, label)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextMenuItemFromStockActionWithLabel*(tdesc: typedesc; action: ContextMenuAction;
    label: cstring): tdesc =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_from_stock_action_with_label(action, label)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextMenuItemFromStockActionWithLabel*[T](result: var T; action: ContextMenuAction;
    label: cstring) {.deprecated.} =
  assert(result is ContextMenuItem)
  let gobj = webkit_context_menu_item_new_from_stock_action_with_label(action, label)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_context_menu_item_get_stock_action(self: ptr ContextMenuItem00): ContextMenuAction {.
    importc, libprag.}

proc getStockAction*(self: ContextMenuItem): ContextMenuAction =
  webkit_context_menu_item_get_stock_action(cast[ptr ContextMenuItem00](self.impl))

proc stockAction*(self: ContextMenuItem): ContextMenuAction =
  webkit_context_menu_item_get_stock_action(cast[ptr ContextMenuItem00](self.impl))

type
  DownloadError* {.size: sizeof(cint), pure.} = enum
    cancelledByUser = 400
    destination = 401
    network = 499

const EDITING_COMMAND_COPY* = "Copy"

const EDITING_COMMAND_CREATE_LINK* = "CreateLink"

const EDITING_COMMAND_CUT* = "Cut"

const EDITING_COMMAND_INSERT_IMAGE* = "InsertImage"

const EDITING_COMMAND_PASTE* = "Paste"

const EDITING_COMMAND_PASTE_AS_PLAIN_TEXT* = "PasteAsPlainText"

const EDITING_COMMAND_REDO* = "Redo"

const EDITING_COMMAND_SELECT_ALL* = "SelectAll"

const EDITING_COMMAND_UNDO* = "Undo"

type
  EditorTypingAttributes* {.size: sizeof(cint), pure.} = enum
    none = 2
    bold = 4
    italic = 8
    underline = 16
    strikethrough = 32

type
  FaviconDatabaseError* {.size: sizeof(cint), pure.} = enum
    notInitialized = 0
    faviconNotFound = 1
    faviconUnknown = 2

type
  FindOptions* {.size: sizeof(cint), pure.} = enum
    none = 0
    caseInsensitive = 1
    atWordStarts = 2
    treatMedialCapitalAsWordStart = 4
    backwards = 8
    wrapAround = 16

type
  HitTestResultContext* {.size: sizeof(cint), pure.} = enum
    document = 2
    link = 4
    image = 8
    media = 16
    editable = 32
    scrollbar = 64
    selection = 128

type
  JavascriptError* {.size: sizeof(cint), pure.} = enum
    failed = 699

const MAJOR_VERSION* = 2'i32

const MICRO_VERSION* = 0'i32

const MINOR_VERSION* = 36'i32

type
  NavigationPolicyDecision* = ref object of PolicyDecision
  NavigationPolicyDecision00* = object of PolicyDecision00

proc webkit_navigation_policy_decision_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NavigationPolicyDecision()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_navigation_policy_decision_get_frame_name(self: ptr NavigationPolicyDecision00): cstring {.
    importc, libprag.}

proc getFrameName*(self: NavigationPolicyDecision): string =
  result = $webkit_navigation_policy_decision_get_frame_name(cast[ptr NavigationPolicyDecision00](self.impl))

proc frameName*(self: NavigationPolicyDecision): string =
  result = $webkit_navigation_policy_decision_get_frame_name(cast[ptr NavigationPolicyDecision00](self.impl))

proc webkit_navigation_policy_decision_get_modifiers(self: ptr NavigationPolicyDecision00): uint32 {.
    importc, libprag.}

proc getModifiers*(self: NavigationPolicyDecision): int =
  int(webkit_navigation_policy_decision_get_modifiers(cast[ptr NavigationPolicyDecision00](self.impl)))

proc modifiers*(self: NavigationPolicyDecision): int =
  int(webkit_navigation_policy_decision_get_modifiers(cast[ptr NavigationPolicyDecision00](self.impl)))

proc webkit_navigation_policy_decision_get_mouse_button(self: ptr NavigationPolicyDecision00): uint32 {.
    importc, libprag.}

proc getMouseButton*(self: NavigationPolicyDecision): int =
  int(webkit_navigation_policy_decision_get_mouse_button(cast[ptr NavigationPolicyDecision00](self.impl)))

proc mouseButton*(self: NavigationPolicyDecision): int =
  int(webkit_navigation_policy_decision_get_mouse_button(cast[ptr NavigationPolicyDecision00](self.impl)))

proc webkit_navigation_policy_decision_get_navigation_action(self: ptr NavigationPolicyDecision00): ptr NavigationAction00 {.
    importc, libprag.}

proc getNavigationAction*(self: NavigationPolicyDecision): NavigationAction =
  fnew(result, gBoxedFreeWebKitNavigationAction)
  result.impl = webkit_navigation_policy_decision_get_navigation_action(cast[ptr NavigationPolicyDecision00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(webkit_navigation_action_get_type(), result.impl))

proc navigationAction*(self: NavigationPolicyDecision): NavigationAction =
  fnew(result, gBoxedFreeWebKitNavigationAction)
  result.impl = webkit_navigation_policy_decision_get_navigation_action(cast[ptr NavigationPolicyDecision00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(webkit_navigation_action_get_type(), result.impl))

proc webkit_navigation_policy_decision_get_navigation_type(self: ptr NavigationPolicyDecision00): NavigationType {.
    importc, libprag.}

proc getNavigationType*(self: NavigationPolicyDecision): NavigationType =
  webkit_navigation_policy_decision_get_navigation_type(cast[ptr NavigationPolicyDecision00](self.impl))

proc navigationType*(self: NavigationPolicyDecision): NavigationType =
  webkit_navigation_policy_decision_get_navigation_type(cast[ptr NavigationPolicyDecision00](self.impl))

proc webkit_navigation_policy_decision_get_request(self: ptr NavigationPolicyDecision00): ptr URIRequest00 {.
    importc, libprag.}

proc getRequest*(self: NavigationPolicyDecision): URIRequest =
  let gobj = webkit_navigation_policy_decision_get_request(cast[ptr NavigationPolicyDecision00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc request*(self: NavigationPolicyDecision): URIRequest =
  let gobj = webkit_navigation_policy_decision_get_request(cast[ptr NavigationPolicyDecision00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  NetworkError* {.size: sizeof(cint), pure.} = enum
    transport = 300
    unknownProtocol = 301
    cancelled = 302
    fileDoesNotExist = 303
    failed = 399

type
  PluginError* {.size: sizeof(cint), pure.} = enum
    cannotFindPlugin = 200
    cannotLoadPlugin = 201
    javaUnavailable = 202
    connectionCancelled = 203
    willHandleLoad = 204
    failed = 299

type
  PolicyError* {.size: sizeof(cint), pure.} = enum
    cannotShowMimeType = 100
    cannotShowUri = 101
    frameLoadInterruptedByPolicyChange = 102
    cannotUseRestrictedPort = 103
    failed = 199

type
  PrintError* {.size: sizeof(cint), pure.} = enum
    printerNotFound = 500
    invalidPageRange = 501
    general = 599

type
  ResponsePolicyDecision* = ref object of PolicyDecision
  ResponsePolicyDecision00* = object of PolicyDecision00

proc webkit_response_policy_decision_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ResponsePolicyDecision()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_response_policy_decision_get_request(self: ptr ResponsePolicyDecision00): ptr URIRequest00 {.
    importc, libprag.}

proc getRequest*(self: ResponsePolicyDecision): URIRequest =
  let gobj = webkit_response_policy_decision_get_request(cast[ptr ResponsePolicyDecision00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc request*(self: ResponsePolicyDecision): URIRequest =
  let gobj = webkit_response_policy_decision_get_request(cast[ptr ResponsePolicyDecision00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_response_policy_decision_get_response(self: ptr ResponsePolicyDecision00): ptr URIResponse00 {.
    importc, libprag.}

proc getResponse*(self: ResponsePolicyDecision): URIResponse =
  let gobj = webkit_response_policy_decision_get_response(cast[ptr ResponsePolicyDecision00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc response*(self: ResponsePolicyDecision): URIResponse =
  let gobj = webkit_response_policy_decision_get_response(cast[ptr ResponsePolicyDecision00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_response_policy_decision_is_mime_type_supported(self: ptr ResponsePolicyDecision00): gboolean {.
    importc, libprag.}

proc isMimeTypeSupported*(self: ResponsePolicyDecision): bool =
  toBool(webkit_response_policy_decision_is_mime_type_supported(cast[ptr ResponsePolicyDecision00](self.impl)))

type
  SnapshotError* {.size: sizeof(cint), pure.} = enum
    create = 799

type
  URISchemeRequest* = ref object of gobject.Object
  URISchemeRequest00* = object of gobject.Object00

proc webkit_uri_scheme_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(URISchemeRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_uri_scheme_request_finish(self: ptr URISchemeRequest00; stream: ptr gio.InputStream00;
    streamLength: int64; contentType: cstring) {.
    importc, libprag.}

proc finish*(self: URISchemeRequest; stream: gio.InputStream;
    streamLength: int64; contentType: cstring = nil) =
  webkit_uri_scheme_request_finish(cast[ptr URISchemeRequest00](self.impl), cast[ptr gio.InputStream00](stream.impl), streamLength, contentType)

proc webkit_uri_scheme_request_finish_error(self: ptr URISchemeRequest00;
    error: ptr glib.Error) {.
    importc, libprag.}

proc finishError*(self: URISchemeRequest; error: ptr glib.Error) =
  webkit_uri_scheme_request_finish_error(cast[ptr URISchemeRequest00](self.impl), error)

proc webkit_uri_scheme_request_get_http_headers(self: ptr URISchemeRequest00): ptr soup.MessageHeaders00 {.
    importc, libprag.}

proc getHttpHeaders*(self: URISchemeRequest): soup.MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = webkit_uri_scheme_request_get_http_headers(cast[ptr URISchemeRequest00](self.impl))

proc httpHeaders*(self: URISchemeRequest): soup.MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = webkit_uri_scheme_request_get_http_headers(cast[ptr URISchemeRequest00](self.impl))

proc webkit_uri_scheme_request_get_http_method(self: ptr URISchemeRequest00): cstring {.
    importc, libprag.}

proc getHttpMethod*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_http_method(cast[ptr URISchemeRequest00](self.impl))

proc httpMethod*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_http_method(cast[ptr URISchemeRequest00](self.impl))

proc webkit_uri_scheme_request_get_path(self: ptr URISchemeRequest00): cstring {.
    importc, libprag.}

proc getPath*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_path(cast[ptr URISchemeRequest00](self.impl))

proc path*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_path(cast[ptr URISchemeRequest00](self.impl))

proc webkit_uri_scheme_request_get_scheme(self: ptr URISchemeRequest00): cstring {.
    importc, libprag.}

proc getScheme*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_scheme(cast[ptr URISchemeRequest00](self.impl))

proc scheme*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_scheme(cast[ptr URISchemeRequest00](self.impl))

proc webkit_uri_scheme_request_get_uri(self: ptr URISchemeRequest00): cstring {.
    importc, libprag.}

proc getUri*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_uri(cast[ptr URISchemeRequest00](self.impl))

proc uri*(self: URISchemeRequest): string =
  result = $webkit_uri_scheme_request_get_uri(cast[ptr URISchemeRequest00](self.impl))

proc webkit_uri_scheme_request_get_web_view(self: ptr URISchemeRequest00): ptr WebView00 {.
    importc, libprag.}

proc getWebView*(self: URISchemeRequest): WebView =
  let gobj = webkit_uri_scheme_request_get_web_view(cast[ptr URISchemeRequest00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webView*(self: URISchemeRequest): WebView =
  let gobj = webkit_uri_scheme_request_get_web_view(cast[ptr URISchemeRequest00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  URISchemeResponse* = ref object of gobject.Object
  URISchemeResponse00* = object of gobject.Object00

proc webkit_uri_scheme_response_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(URISchemeResponse()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_uri_scheme_response_new(inputStream: ptr gio.InputStream00; streamLength: int64): ptr URISchemeResponse00 {.
    importc, libprag.}

proc newURISchemeResponse*(inputStream: gio.InputStream; streamLength: int64): URISchemeResponse =
  let gobj = webkit_uri_scheme_response_new(cast[ptr gio.InputStream00](inputStream.impl), streamLength)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newURISchemeResponse*(tdesc: typedesc; inputStream: gio.InputStream; streamLength: int64): tdesc =
  assert(result is URISchemeResponse)
  let gobj = webkit_uri_scheme_response_new(cast[ptr gio.InputStream00](inputStream.impl), streamLength)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initURISchemeResponse*[T](result: var T; inputStream: gio.InputStream; streamLength: int64) {.deprecated.} =
  assert(result is URISchemeResponse)
  let gobj = webkit_uri_scheme_response_new(cast[ptr gio.InputStream00](inputStream.impl), streamLength)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_uri_scheme_response_set_content_type(self: ptr URISchemeResponse00;
    contentType: cstring) {.
    importc, libprag.}

proc setContentType*(self: URISchemeResponse;
    contentType: cstring) =
  webkit_uri_scheme_response_set_content_type(cast[ptr URISchemeResponse00](self.impl), contentType)

proc `contentType=`*(self: URISchemeResponse;
    contentType: cstring) =
  webkit_uri_scheme_response_set_content_type(cast[ptr URISchemeResponse00](self.impl), contentType)

proc webkit_uri_scheme_response_set_http_headers(self: ptr URISchemeResponse00;
    headers: ptr soup.MessageHeaders00) {.
    importc, libprag.}

proc setHttpHeaders*(self: URISchemeResponse;
    headers: soup.MessageHeaders) =
  webkit_uri_scheme_response_set_http_headers(cast[ptr URISchemeResponse00](self.impl), cast[ptr soup.MessageHeaders00](headers.impl))

proc `httpHeaders=`*(self: URISchemeResponse;
    headers: soup.MessageHeaders) =
  webkit_uri_scheme_response_set_http_headers(cast[ptr URISchemeResponse00](self.impl), cast[ptr soup.MessageHeaders00](headers.impl))

proc webkit_uri_scheme_response_set_status(self: ptr URISchemeResponse00;
    statusCode: uint32; reasonPhrase: cstring) {.
    importc, libprag.}

proc setStatus*(self: URISchemeResponse; statusCode: int;
    reasonPhrase: cstring = nil) =
  webkit_uri_scheme_response_set_status(cast[ptr URISchemeResponse00](self.impl), uint32(statusCode), reasonPhrase)

proc webkit_uri_scheme_request_finish_with_response(self: ptr URISchemeRequest00;
    response: ptr URISchemeResponse00) {.
    importc, libprag.}

proc finishWithResponse*(self: URISchemeRequest;
    response: URISchemeResponse) =
  webkit_uri_scheme_request_finish_with_response(cast[ptr URISchemeRequest00](self.impl), cast[ptr URISchemeResponse00](response.impl))

type
  URISchemeRequestCallback* = proc (request: ptr URISchemeRequest00; userData: pointer) {.cdecl.}

proc webkit_web_context_register_uri_scheme(self: ptr WebContext00; scheme: cstring;
    callback: URISchemeRequestCallback; userData: pointer; userDataDestroyFunc: DestroyNotify) {.
    importc, libprag.}

proc registerUriScheme*(self: WebContext; scheme: cstring;
    callback: URISchemeRequestCallback; userData: pointer; userDataDestroyFunc: DestroyNotify) =
  webkit_web_context_register_uri_scheme(cast[ptr WebContext00](self.impl), scheme, callback, userData, userDataDestroyFunc)

type
  UserContentFilterError* {.size: sizeof(cint), pure.} = enum
    invalidSource = 0
    notFound = 1

type
  UserContentFilterStore* = ref object of gobject.Object
  UserContentFilterStore00* = object of gobject.Object00

proc webkit_user_content_filter_store_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserContentFilterStore()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_user_content_filter_store_new(storagePath: cstring): ptr UserContentFilterStore00 {.
    importc, libprag.}

proc newUserContentFilterStore*(storagePath: cstring): UserContentFilterStore =
  let gobj = webkit_user_content_filter_store_new(storagePath)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newUserContentFilterStore*(tdesc: typedesc; storagePath: cstring): tdesc =
  assert(result is UserContentFilterStore)
  let gobj = webkit_user_content_filter_store_new(storagePath)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUserContentFilterStore*[T](result: var T; storagePath: cstring) {.deprecated.} =
  assert(result is UserContentFilterStore)
  let gobj = webkit_user_content_filter_store_new(storagePath)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_user_content_filter_store_fetch_identifiers(self: ptr UserContentFilterStore00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc fetchIdentifiers*(self: UserContentFilterStore;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_user_content_filter_store_fetch_identifiers(cast[ptr UserContentFilterStore00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_user_content_filter_store_fetch_identifiers_finish(self: ptr UserContentFilterStore00;
    resu: ptr gio.AsyncResult00): ptr cstring {.
    importc, libprag.}

proc fetchIdentifiersFinish*(self: UserContentFilterStore;
    resu: gio.AsyncResult): seq[string] =
  let resul0 = webkit_user_content_filter_store_fetch_identifiers_finish(cast[ptr UserContentFilterStore00](self.impl), cast[ptr gio.AsyncResult00](resu.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc webkit_user_content_filter_store_get_path(self: ptr UserContentFilterStore00): cstring {.
    importc, libprag.}

proc getPath*(self: UserContentFilterStore): string =
  result = $webkit_user_content_filter_store_get_path(cast[ptr UserContentFilterStore00](self.impl))

proc path*(self: UserContentFilterStore): string =
  result = $webkit_user_content_filter_store_get_path(cast[ptr UserContentFilterStore00](self.impl))

proc webkit_user_content_filter_store_load(self: ptr UserContentFilterStore00;
    identifier: cstring; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc load*(self: UserContentFilterStore;
    identifier: cstring; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  webkit_user_content_filter_store_load(cast[ptr UserContentFilterStore00](self.impl), identifier, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_user_content_filter_store_load_finish(self: ptr UserContentFilterStore00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr UserContentFilter00 {.
    importc, libprag.}

proc loadFinish*(self: UserContentFilterStore;
    resu: gio.AsyncResult): UserContentFilter =
  var gerror: ptr glib.Error
  let impl0 = webkit_user_content_filter_store_load_finish(cast[ptr UserContentFilterStore00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeWebKitUserContentFilter)
  result.impl = impl0

proc webkit_user_content_filter_store_remove(self: ptr UserContentFilterStore00;
    identifier: cstring; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc remove*(self: UserContentFilterStore;
    identifier: cstring; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  webkit_user_content_filter_store_remove(cast[ptr UserContentFilterStore00](self.impl), identifier, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_user_content_filter_store_remove_finish(self: ptr UserContentFilterStore00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeFinish*(self: UserContentFilterStore;
    resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_user_content_filter_store_remove_finish(cast[ptr UserContentFilterStore00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_user_content_filter_store_save(self: ptr UserContentFilterStore00;
    identifier: cstring; source: ptr glib.Bytes00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc save*(self: UserContentFilterStore;
    identifier: cstring; source: glib.Bytes; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  webkit_user_content_filter_store_save(cast[ptr UserContentFilterStore00](self.impl), identifier, cast[ptr glib.Bytes00](source.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_user_content_filter_store_save_finish(self: ptr UserContentFilterStore00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr UserContentFilter00 {.
    importc, libprag.}

proc saveFinish*(self: UserContentFilterStore;
    resu: gio.AsyncResult): UserContentFilter =
  var gerror: ptr glib.Error
  let impl0 = webkit_user_content_filter_store_save_finish(cast[ptr UserContentFilterStore00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeWebKitUserContentFilter)
  result.impl = impl0

proc webkit_user_content_filter_store_save_from_file(self: ptr UserContentFilterStore00;
    identifier: cstring; file: ptr gio.GFile00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc saveFromFile*(self: UserContentFilterStore;
    identifier: cstring; file: gio.GFile; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  webkit_user_content_filter_store_save_from_file(cast[ptr UserContentFilterStore00](self.impl), identifier, cast[ptr gio.GFile00](file.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_user_content_filter_store_save_from_file_finish(self: ptr UserContentFilterStore00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr UserContentFilter00 {.
    importc, libprag.}

proc saveFromFileFinish*(self: UserContentFilterStore;
    resu: gio.AsyncResult): UserContentFilter =
  var gerror: ptr glib.Error
  let impl0 = webkit_user_content_filter_store_save_from_file_finish(cast[ptr UserContentFilterStore00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeWebKitUserContentFilter)
  result.impl = impl0

type
  UserMessageError* {.size: sizeof(cint), pure.} = enum
    message = 0

proc webkit_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(webkit_get_major_version())

proc webkit_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(webkit_get_micro_version())

proc webkit_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(webkit_get_minor_version())

proc webkit_media_key_system_permission_get_name(request: ptr MediaKeySystemPermissionRequest00): cstring {.
    importc, libprag.}

proc mediaKeySystemPermissionGetName*(request: MediaKeySystemPermissionRequest): string =
  result = $webkit_media_key_system_permission_get_name(cast[ptr MediaKeySystemPermissionRequest00](request.impl))

proc webkit_uri_for_display(uri: cstring): cstring {.
    importc, libprag.}

proc uriForDisplay*(uri: cstring): string =
  let resul0 = webkit_uri_for_display(uri)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc webkit_user_media_permission_is_for_audio_device(request: ptr UserMediaPermissionRequest00): gboolean {.
    importc, libprag.}

proc userMediaPermissionIsForAudioDevice*(request: UserMediaPermissionRequest): bool =
  toBool(webkit_user_media_permission_is_for_audio_device(cast[ptr UserMediaPermissionRequest00](request.impl)))

proc webkit_user_media_permission_is_for_display_device(request: ptr UserMediaPermissionRequest00): gboolean {.
    importc, libprag.}

proc userMediaPermissionIsForDisplayDevice*(request: UserMediaPermissionRequest): bool =
  toBool(webkit_user_media_permission_is_for_display_device(cast[ptr UserMediaPermissionRequest00](request.impl)))

proc webkit_user_media_permission_is_for_video_device(request: ptr UserMediaPermissionRequest00): gboolean {.
    importc, libprag.}

proc userMediaPermissionIsForVideoDevice*(request: UserMediaPermissionRequest): bool =
  toBool(webkit_user_media_permission_is_for_video_device(cast[ptr UserMediaPermissionRequest00](request.impl)))
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc implementorIface*(x: webkit2.WebView): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: webkit2.WebView): gtk.Buildable = cast[gtk.Buildable](x)

proc implementorIface*(x: webkit2.WebViewBase): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: webkit2.WebViewBase): gtk.Buildable = cast[gtk.Buildable](x)
