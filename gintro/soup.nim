# dependencies:
# GObject-2.0
# Gio-2.0
# GLib-2.0
# immediate dependencies:
# Gio-2.0
# libraries:
# libsoup-2.4.so.1
{.warning[UnusedImport]: off.}
import gobject, gio, glib
const Lib = "libsoup-2.4.so.1"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const ADDRESS_ANY_PORT_STR* = 0'i32

const ADDRESS_FAMILY_STR* = "family"

const ADDRESS_NAME_STR* = "name"

const ADDRESS_PHYSICAL_STR* = "physical"

const ADDRESS_PORT_STR* = "port"

const ADDRESS_PROTOCOL_STR* = "protocol"

const ADDRESS_SOCKADDR_STR* = "sockaddr"

const AUTH_DOMAIN_ADD_PATH_STR* = "add-path"

const AUTH_DOMAIN_BASIC_AUTH_CALLBACK_STR* = "auth-callback"

const AUTH_DOMAIN_BASIC_AUTH_DATA_STR* = "auth-data"

const AUTH_DOMAIN_DIGEST_AUTH_CALLBACK_STR* = "auth-callback"

const AUTH_DOMAIN_DIGEST_AUTH_DATA_STR* = "auth-data"

const AUTH_DOMAIN_FILTER_STR* = "filter"

const AUTH_DOMAIN_FILTER_DATA_STR* = "filter-data"

const AUTH_DOMAIN_GENERIC_AUTH_CALLBACK_STR* = "generic-auth-callback"

const AUTH_DOMAIN_GENERIC_AUTH_DATA_STR* = "generic-auth-data"

const AUTH_DOMAIN_PROXY_STR* = "proxy"

const AUTH_DOMAIN_REALM_STR* = "realm"

const AUTH_DOMAIN_REMOVE_PATH_STR* = "remove-path"

const AUTH_HOST_STR* = "host"

const AUTH_IS_AUTHENTICATED_STR* = "is-authenticated"

const AUTH_IS_FOR_PROXY_STR* = "is-for-proxy"

const AUTH_REALM_STR* = "realm"

const AUTH_SCHEME_NAME_STR* = "scheme-name"

type
  Address* = ref object of gobject.Object
  Address00* = object of gobject.Object00

proc soup_address_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Address()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_address_new(name: cstring; port: uint32): ptr Address00 {.
    importc, libprag.}

proc newAddress*(name: cstring; port: int): Address =
  let gobj = soup_address_new(name, uint32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAddress*(tdesc: typedesc; name: cstring; port: int): tdesc =
  assert(result is Address)
  let gobj = soup_address_new(name, uint32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAddress*[T](result: var T; name: cstring; port: int) {.deprecated.} =
  assert(result is Address)
  let gobj = soup_address_new(name, uint32(port))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_address_new_from_sockaddr(sa: pointer; len: int32): ptr Address00 {.
    importc, libprag.}

proc newAddressFromSockaddr*(sa: pointer; len: int): Address =
  let gobj = soup_address_new_from_sockaddr(sa, int32(len))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAddressFromSockaddr*(tdesc: typedesc; sa: pointer; len: int): tdesc =
  assert(result is Address)
  let gobj = soup_address_new_from_sockaddr(sa, int32(len))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAddressFromSockaddr*[T](result: var T; sa: pointer; len: int) {.deprecated.} =
  assert(result is Address)
  let gobj = soup_address_new_from_sockaddr(sa, int32(len))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_address_equal_by_ip(self: ptr Address00; addr2: ptr Address00): gboolean {.
    importc, libprag.}

proc equalByIp*(self: Address; addr2: Address): bool =
  toBool(soup_address_equal_by_ip(cast[ptr Address00](self.impl), cast[ptr Address00](addr2.impl)))

proc soup_address_equal_by_name(self: ptr Address00; addr2: ptr Address00): gboolean {.
    importc, libprag.}

proc equalByName*(self: Address; addr2: Address): bool =
  toBool(soup_address_equal_by_name(cast[ptr Address00](self.impl), cast[ptr Address00](addr2.impl)))

proc soup_address_get_gsockaddr(self: ptr Address00): ptr gio.SocketAddress00 {.
    importc, libprag.}

proc getGsockaddr*(self: Address): gio.SocketAddress =
  let gobj = soup_address_get_gsockaddr(cast[ptr Address00](self.impl))
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

proc gsockaddr*(self: Address): gio.SocketAddress =
  let gobj = soup_address_get_gsockaddr(cast[ptr Address00](self.impl))
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

proc soup_address_get_name(self: ptr Address00): cstring {.
    importc, libprag.}

proc getName*(self: Address): string =
  let resul0 = soup_address_get_name(cast[ptr Address00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc name*(self: Address): string =
  let resul0 = soup_address_get_name(cast[ptr Address00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_address_get_physical(self: ptr Address00): cstring {.
    importc, libprag.}

proc getPhysical*(self: Address): string =
  let resul0 = soup_address_get_physical(cast[ptr Address00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc physical*(self: Address): string =
  let resul0 = soup_address_get_physical(cast[ptr Address00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_address_get_port(self: ptr Address00): uint32 {.
    importc, libprag.}

proc getPort*(self: Address): int =
  int(soup_address_get_port(cast[ptr Address00](self.impl)))

proc port*(self: Address): int =
  int(soup_address_get_port(cast[ptr Address00](self.impl)))

proc soup_address_get_sockaddr(self: ptr Address00; len: ptr int32): pointer {.
    importc, libprag.}

proc getSockaddr*(self: Address; len: ptr int32): pointer =
  soup_address_get_sockaddr(cast[ptr Address00](self.impl), len)

proc soup_address_hash_by_ip(self: ptr Address00): uint32 {.
    importc, libprag.}

proc hashByIp*(self: Address): int =
  int(soup_address_hash_by_ip(cast[ptr Address00](self.impl)))

proc soup_address_hash_by_name(self: ptr Address00): uint32 {.
    importc, libprag.}

proc hashByName*(self: Address): int =
  int(soup_address_hash_by_name(cast[ptr Address00](self.impl)))

proc soup_address_is_resolved(self: ptr Address00): gboolean {.
    importc, libprag.}

proc isResolved*(self: Address): bool =
  toBool(soup_address_is_resolved(cast[ptr Address00](self.impl)))

proc soup_address_resolve_sync(self: ptr Address00; cancellable: ptr gio.Cancellable00): uint32 {.
    importc, libprag.}

proc resolveSync*(self: Address; cancellable: gio.Cancellable = nil): int =
  int(soup_address_resolve_sync(cast[ptr Address00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl)))

type
  AddressFamily* {.size: sizeof(cint), pure.} = enum
    invalid = -1
    ipv4 = 2
    ipv6 = 10

proc soup_address_new_any(family: AddressFamily; port: uint32): ptr Address00 {.
    importc, libprag.}

proc newAddressAny*(family: AddressFamily; port: int): Address =
  let gobj = soup_address_new_any(family, uint32(port))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAddressAny*(tdesc: typedesc; family: AddressFamily; port: int): tdesc =
  assert(result is Address)
  let gobj = soup_address_new_any(family, uint32(port))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAddressAny*[T](result: var T; family: AddressFamily; port: int) {.deprecated.} =
  assert(result is Address)
  let gobj = soup_address_new_any(family, uint32(port))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  AddressCallback* = proc (`addr`: ptr Address00; status: uint32; userData: pointer) {.cdecl.}

proc soup_address_resolve_async(self: ptr Address00; asyncContext: ptr glib.MainContext00;
    cancellable: ptr gio.Cancellable00; callback: AddressCallback; userData: pointer) {.
    importc, libprag.}

proc resolveAsync*(self: Address; asyncContext: glib.MainContext = nil;
    cancellable: gio.Cancellable = nil; callback: AddressCallback; userData: pointer) =
  soup_address_resolve_async(cast[ptr Address00](self.impl), if asyncContext.isNil: nil else: cast[ptr glib.MainContext00](asyncContext.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  Auth* = ref object of gobject.Object
  Auth00* = object of gobject.Object00

proc soup_auth_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Auth()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_authenticate(self: ptr Auth00; username: cstring; password: cstring) {.
    importc, libprag.}

proc authenticate*(self: Auth; username: cstring; password: cstring) =
  soup_auth_authenticate(cast[ptr Auth00](self.impl), username, password)

proc soup_auth_can_authenticate(self: ptr Auth00): gboolean {.
    importc, libprag.}

proc canAuthenticate*(self: Auth): bool =
  toBool(soup_auth_can_authenticate(cast[ptr Auth00](self.impl)))

proc soup_auth_get_host(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getHost*(self: Auth): string =
  result = $soup_auth_get_host(cast[ptr Auth00](self.impl))

proc host*(self: Auth): string =
  result = $soup_auth_get_host(cast[ptr Auth00](self.impl))

proc soup_auth_get_info(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getInfoAuth*(self: Auth): string =
  let resul0 = soup_auth_get_info(cast[ptr Auth00](self.impl))
  result = $resul0
  cogfree(resul0)

proc infoAuth*(self: Auth): string =
  let resul0 = soup_auth_get_info(cast[ptr Auth00](self.impl))
  result = $resul0
  cogfree(resul0)

proc soup_auth_get_realm(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getRealm*(self: Auth): string =
  result = $soup_auth_get_realm(cast[ptr Auth00](self.impl))

proc realm*(self: Auth): string =
  result = $soup_auth_get_realm(cast[ptr Auth00](self.impl))

proc soup_auth_get_saved_password(self: ptr Auth00; user: cstring): cstring {.
    importc, libprag.}

proc getSavedPassword*(self: Auth; user: cstring): string =
  result = $soup_auth_get_saved_password(cast[ptr Auth00](self.impl), user)

proc soup_auth_get_saved_users(self: ptr Auth00): ptr glib.SList {.
    importc, libprag.}

proc getSavedUsers*(self: Auth): seq[cstring] =
  let resul0 = soup_auth_get_saved_users(cast[ptr Auth00](self.impl))
  g_slist_free(resul0)

proc savedUsers*(self: Auth): seq[cstring] =
  let resul0 = soup_auth_get_saved_users(cast[ptr Auth00](self.impl))
  g_slist_free(resul0)

proc soup_auth_get_scheme_name(self: ptr Auth00): cstring {.
    importc, libprag.}

proc getSchemeName*(self: Auth): string =
  result = $soup_auth_get_scheme_name(cast[ptr Auth00](self.impl))

proc schemeName*(self: Auth): string =
  result = $soup_auth_get_scheme_name(cast[ptr Auth00](self.impl))

proc soup_auth_has_saved_password(self: ptr Auth00; username: cstring; password: cstring) {.
    importc, libprag.}

proc hasSavedPassword*(self: Auth; username: cstring; password: cstring) =
  soup_auth_has_saved_password(cast[ptr Auth00](self.impl), username, password)

proc soup_auth_is_authenticated(self: ptr Auth00): gboolean {.
    importc, libprag.}

proc isAuthenticated*(self: Auth): bool =
  toBool(soup_auth_is_authenticated(cast[ptr Auth00](self.impl)))

proc soup_auth_is_for_proxy(self: ptr Auth00): gboolean {.
    importc, libprag.}

proc isForProxy*(self: Auth): bool =
  toBool(soup_auth_is_for_proxy(cast[ptr Auth00](self.impl)))

proc soup_auth_save_password(self: ptr Auth00; username: cstring; password: cstring) {.
    importc, libprag.}

proc savePassword*(self: Auth; username: cstring; password: cstring) =
  soup_auth_save_password(cast[ptr Auth00](self.impl), username, password)

type
  URI00* {.pure.} = object
  URI* = ref object
    impl*: ptr URI00
    ignoreFinalizer*: bool

proc soup_uri_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupURI*(self: URI) =
  if not self.ignoreFinalizer:
    boxedFree(soup_uri_get_type(), cast[ptr URI00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(URI()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_uri_get_type(), cast[ptr URI00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var URI) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupURI)

proc soup_uri_free(self: ptr URI00) {.
    importc, libprag.}

proc free*(self: URI) =
  soup_uri_free(cast[ptr URI00](self.impl))

proc finalizerfree*(self: URI) =
  if not self.ignoreFinalizer:
    soup_uri_free(cast[ptr URI00](self.impl))

proc soup_uri_new_with_base(base: ptr URI00; uriString: cstring): ptr URI00 {.
    importc, libprag.}

proc newURIWithBase*(base: URI; uriString: cstring): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_uri_new_with_base(cast[ptr URI00](base.impl), uriString)

proc newURIWithBase*(tdesc: typedesc; base: URI; uriString: cstring): tdesc =
  assert(result is URI)
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_uri_new_with_base(cast[ptr URI00](base.impl), uriString)

proc initURIWithBase*[T](result: var T; base: URI; uriString: cstring) {.deprecated.} =
  assert(result is URI)
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_uri_new_with_base(cast[ptr URI00](base.impl), uriString)

proc soup_uri_copy(self: ptr URI00): ptr URI00 {.
    importc, libprag.}

proc copy*(self: URI): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_uri_copy(cast[ptr URI00](self.impl))

proc soup_uri_copy_host(self: ptr URI00): ptr URI00 {.
    importc, libprag.}

proc copyHost*(self: URI): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_uri_copy_host(cast[ptr URI00](self.impl))

proc soup_uri_equal(self: ptr URI00; uri2: ptr URI00): gboolean {.
    importc, libprag.}

proc equal*(self: URI; uri2: URI): bool =
  toBool(soup_uri_equal(cast[ptr URI00](self.impl), cast[ptr URI00](uri2.impl)))

proc soup_uri_new(uriString: cstring): ptr URI00 {.
    importc, libprag.}

proc newURI*(uriString: cstring = nil): URI =
  let impl0 = soup_uri_new(uriString)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupURI)
  result.impl = impl0

proc newURI*(tdesc: typedesc; uriString: cstring = nil): tdesc =
  assert(result is URI)
  let impl0 = soup_uri_new(uriString)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupURI)
  result.impl = impl0

proc initURI*[T](result: var T; uriString: cstring = nil) {.deprecated.} =
  assert(result is URI)
  let impl0 = soup_uri_new(uriString)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupURI)
  result.impl = impl0

proc soup_uri_get_fragment(self: ptr URI00): cstring {.
    importc, libprag.}

proc getFragment*(self: URI): string =
  result = $soup_uri_get_fragment(cast[ptr URI00](self.impl))

proc fragment*(self: URI): string =
  result = $soup_uri_get_fragment(cast[ptr URI00](self.impl))

proc soup_uri_get_host(self: ptr URI00): cstring {.
    importc, libprag.}

proc getHost*(self: URI): string =
  result = $soup_uri_get_host(cast[ptr URI00](self.impl))

proc host*(self: URI): string =
  result = $soup_uri_get_host(cast[ptr URI00](self.impl))

proc soup_uri_get_password(self: ptr URI00): cstring {.
    importc, libprag.}

proc getPassword*(self: URI): string =
  result = $soup_uri_get_password(cast[ptr URI00](self.impl))

proc password*(self: URI): string =
  result = $soup_uri_get_password(cast[ptr URI00](self.impl))

proc soup_uri_get_path(self: ptr URI00): cstring {.
    importc, libprag.}

proc getPath*(self: URI): string =
  result = $soup_uri_get_path(cast[ptr URI00](self.impl))

proc path*(self: URI): string =
  result = $soup_uri_get_path(cast[ptr URI00](self.impl))

proc soup_uri_get_port(self: ptr URI00): uint32 {.
    importc, libprag.}

proc getPort*(self: URI): int =
  int(soup_uri_get_port(cast[ptr URI00](self.impl)))

proc port*(self: URI): int =
  int(soup_uri_get_port(cast[ptr URI00](self.impl)))

proc soup_uri_get_query(self: ptr URI00): cstring {.
    importc, libprag.}

proc getQuery*(self: URI): string =
  result = $soup_uri_get_query(cast[ptr URI00](self.impl))

proc query*(self: URI): string =
  result = $soup_uri_get_query(cast[ptr URI00](self.impl))

proc soup_uri_get_scheme(self: ptr URI00): cstring {.
    importc, libprag.}

proc getScheme*(self: URI): string =
  result = $soup_uri_get_scheme(cast[ptr URI00](self.impl))

proc scheme*(self: URI): string =
  result = $soup_uri_get_scheme(cast[ptr URI00](self.impl))

proc soup_uri_get_user(self: ptr URI00): cstring {.
    importc, libprag.}

proc getUser*(self: URI): string =
  result = $soup_uri_get_user(cast[ptr URI00](self.impl))

proc user*(self: URI): string =
  result = $soup_uri_get_user(cast[ptr URI00](self.impl))

proc soup_uri_host_equal(self: ptr URI00; v2: ptr URI00): gboolean {.
    importc, libprag.}

proc hostEqual*(self: URI; v2: URI): bool =
  toBool(soup_uri_host_equal(cast[ptr URI00](self.impl), cast[ptr URI00](v2.impl)))

proc soup_uri_host_hash(self: ptr URI00): uint32 {.
    importc, libprag.}

proc hostHash*(self: URI): int =
  int(soup_uri_host_hash(cast[ptr URI00](self.impl)))

proc soup_uri_set_fragment(self: ptr URI00; fragment: cstring) {.
    importc, libprag.}

proc setFragment*(self: URI; fragment: cstring = nil) =
  soup_uri_set_fragment(cast[ptr URI00](self.impl), fragment)

proc `fragment=`*(self: URI; fragment: cstring = nil) =
  soup_uri_set_fragment(cast[ptr URI00](self.impl), fragment)

proc soup_uri_set_host(self: ptr URI00; host: cstring) {.
    importc, libprag.}

proc setHost*(self: URI; host: cstring = nil) =
  soup_uri_set_host(cast[ptr URI00](self.impl), host)

proc `host=`*(self: URI; host: cstring = nil) =
  soup_uri_set_host(cast[ptr URI00](self.impl), host)

proc soup_uri_set_password(self: ptr URI00; password: cstring) {.
    importc, libprag.}

proc setPassword*(self: URI; password: cstring = nil) =
  soup_uri_set_password(cast[ptr URI00](self.impl), password)

proc `password=`*(self: URI; password: cstring = nil) =
  soup_uri_set_password(cast[ptr URI00](self.impl), password)

proc soup_uri_set_path(self: ptr URI00; path: cstring) {.
    importc, libprag.}

proc setPath*(self: URI; path: cstring) =
  soup_uri_set_path(cast[ptr URI00](self.impl), path)

proc `path=`*(self: URI; path: cstring) =
  soup_uri_set_path(cast[ptr URI00](self.impl), path)

proc soup_uri_set_port(self: ptr URI00; port: uint32) {.
    importc, libprag.}

proc setPort*(self: URI; port: int) =
  soup_uri_set_port(cast[ptr URI00](self.impl), uint32(port))

proc `port=`*(self: URI; port: int) =
  soup_uri_set_port(cast[ptr URI00](self.impl), uint32(port))

proc soup_uri_set_query(self: ptr URI00; query: cstring) {.
    importc, libprag.}

proc setQuery*(self: URI; query: cstring = nil) =
  soup_uri_set_query(cast[ptr URI00](self.impl), query)

proc `query=`*(self: URI; query: cstring = nil) =
  soup_uri_set_query(cast[ptr URI00](self.impl), query)

proc soup_uri_set_query_from_form(self: ptr URI00; form: ptr HashTable00) {.
    importc, libprag.}

proc setQueryFromForm*(self: URI; form: ptr HashTable00) =
  soup_uri_set_query_from_form(cast[ptr URI00](self.impl), form)

proc `queryFromForm=`*(self: URI; form: ptr HashTable00) =
  soup_uri_set_query_from_form(cast[ptr URI00](self.impl), form)

proc soup_uri_set_scheme(self: ptr URI00; scheme: cstring) {.
    importc, libprag.}

proc setScheme*(self: URI; scheme: cstring) =
  soup_uri_set_scheme(cast[ptr URI00](self.impl), scheme)

proc `scheme=`*(self: URI; scheme: cstring) =
  soup_uri_set_scheme(cast[ptr URI00](self.impl), scheme)

proc soup_uri_set_user(self: ptr URI00; user: cstring) {.
    importc, libprag.}

proc setUser*(self: URI; user: cstring = nil) =
  soup_uri_set_user(cast[ptr URI00](self.impl), user)

proc `user=`*(self: URI; user: cstring = nil) =
  soup_uri_set_user(cast[ptr URI00](self.impl), user)

proc soup_uri_to_string(self: ptr URI00; justPathAndQuery: gboolean): cstring {.
    importc, libprag.}

proc toString*(self: URI; justPathAndQuery: bool): string =
  let resul0 = soup_uri_to_string(cast[ptr URI00](self.impl), gboolean(justPathAndQuery))
  result = $resul0
  cogfree(resul0)

proc soup_uri_uses_default_port(self: ptr URI00): gboolean {.
    importc, libprag.}

proc usesDefaultPort*(self: URI): bool =
  toBool(soup_uri_uses_default_port(cast[ptr URI00](self.impl)))

proc soup_uri_decode(part: cstring): cstring {.
    importc, libprag.}

proc decode*(part: cstring): string =
  let resul0 = soup_uri_decode(part)
  result = $resul0
  cogfree(resul0)

proc soup_uri_encode(part: cstring; escapeExtra: cstring): cstring {.
    importc, libprag.}

proc encode*(part: cstring; escapeExtra: cstring = nil): string =
  let resul0 = soup_uri_encode(part, escapeExtra)
  result = $resul0
  cogfree(resul0)

proc soup_uri_normalize(part: cstring; unescapeExtra: cstring): cstring {.
    importc, libprag.}

proc normalize*(part: cstring; unescapeExtra: cstring = nil): string =
  let resul0 = soup_uri_normalize(part, unescapeExtra)
  result = $resul0
  cogfree(resul0)

proc soup_auth_get_protection_space(self: ptr Auth00; sourceUri: ptr URI00): ptr glib.SList {.
    importc, libprag.}

proc getProtectionSpace*(self: Auth; sourceUri: URI): seq[cstring] =
  let resul0 = soup_auth_get_protection_space(cast[ptr Auth00](self.impl), cast[ptr URI00](sourceUri.impl))
  g_slist_free(resul0)

type
  Buffer00* {.pure.} = object
  Buffer* = ref object
    impl*: ptr Buffer00
    ignoreFinalizer*: bool

proc soup_buffer_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupBuffer*(self: Buffer) =
  if not self.ignoreFinalizer:
    boxedFree(soup_buffer_get_type(), cast[ptr Buffer00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Buffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_buffer_get_type(), cast[ptr Buffer00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Buffer) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupBuffer)

proc soup_buffer_free(self: ptr Buffer00) {.
    importc, libprag.}

proc free*(self: Buffer) =
  soup_buffer_free(cast[ptr Buffer00](self.impl))

proc finalizerfree*(self: Buffer) =
  if not self.ignoreFinalizer:
    soup_buffer_free(cast[ptr Buffer00](self.impl))

proc soup_buffer_new_with_owner(data: ptr uint8; length: uint64; owner: pointer;
    ownerDnotify: DestroyNotify): ptr Buffer00 {.
    importc, libprag.}

proc newBufferWithOwner*(data: seq[uint8] | string; owner: pointer;
    ownerDnotify: DestroyNotify): Buffer =
  let length = uint64(data.len)
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_new_with_owner(cast[ptr uint8](unsafeaddr(data[0])), length, owner, ownerDnotify)

proc newBufferWithOwner*(tdesc: typedesc; data: seq[uint8] | string; owner: pointer;
    ownerDnotify: DestroyNotify): tdesc =
  let length = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_new_with_owner(cast[ptr uint8](unsafeaddr(data[0])), length, owner, ownerDnotify)

proc initBufferWithOwner*[T](result: var T; data: seq[uint8] | string; owner: pointer;
    ownerDnotify: DestroyNotify) {.deprecated.} =
  let length = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_new_with_owner(cast[ptr uint8](unsafeaddr(data[0])), length, owner, ownerDnotify)

proc soup_buffer_copy(self: ptr Buffer00): ptr Buffer00 {.
    importc, libprag.}

proc copy*(self: Buffer): Buffer =
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_copy(cast[ptr Buffer00](self.impl))

proc soup_buffer_new_take(data: ptr uint8; length: uint64): ptr Buffer00 {.
    importc, libprag.}

proc newBuffer*(data: seq[uint8] | string): Buffer =
  let length = uint64(data.len)
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_new_take(cast[ptr uint8](unsafeaddr(data[0])), length)

proc newBuffer*(tdesc: typedesc; data: seq[uint8] | string): tdesc =
  let length = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_new_take(cast[ptr uint8](unsafeaddr(data[0])), length)

proc initBuffer*[T](result: var T; data: seq[uint8] | string) {.deprecated.} =
  let length = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_new_take(cast[ptr uint8](unsafeaddr(data[0])), length)

proc soup_buffer_get_as_bytes(self: ptr Buffer00): ptr glib.Bytes00 {.
    importc, libprag.}

proc getAsBytes*(self: Buffer): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = soup_buffer_get_as_bytes(cast[ptr Buffer00](self.impl))

proc asBytes*(self: Buffer): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = soup_buffer_get_as_bytes(cast[ptr Buffer00](self.impl))

proc soup_buffer_get_data(self: ptr Buffer00; data: var ptr uint8; length: var uint64) {.
    importc, libprag.}

proc getData*(self: Buffer; data: var (seq[uint8] | string);
    length: var uint64) =
  var data_00: ptr uint8
  soup_buffer_get_data(cast[ptr Buffer00](self.impl), data_00, length)
  data.setLen(length)
  copyMem(unsafeaddr data[0], data_00, length.int * sizeof(data[0]))
  cogfree(data_00)

proc soup_buffer_get_owner(self: ptr Buffer00): pointer {.
    importc, libprag.}

proc getOwner*(self: Buffer): pointer =
  soup_buffer_get_owner(cast[ptr Buffer00](self.impl))

proc soup_buffer_new_subbuffer(self: ptr Buffer00; offset: uint64; length: uint64): ptr Buffer00 {.
    importc, libprag.}

proc newBufferSubbuffer*(self: Buffer; offset: uint64; length: uint64): Buffer =
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_buffer_new_subbuffer(cast[ptr Buffer00](self.impl), offset, length)

type
  Message* = ref object of gobject.Object
  Message00* = object of gobject.Object00

proc soup_message_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Message()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scContentSniffed*(self: Message;  p: proc (self: ptr Message00; `type`: cstring; params: ptr HashTable00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "content-sniffed", cast[GCallback](p), xdata, nil, cf)

proc scFinished*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc scGotBody*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-body", cast[GCallback](p), xdata, nil, cf)

proc scGotChunk*(self: Message;  p: proc (self: ptr Message00; chunk: ptr Buffer00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-chunk", cast[GCallback](p), xdata, nil, cf)

proc scGotHeaders*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-headers", cast[GCallback](p), xdata, nil, cf)

proc scGotInformational*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "got-informational", cast[GCallback](p), xdata, nil, cf)

proc scNetworkEvent*(self: Message;  p: proc (self: ptr Message00; event: gio.SocketClientEvent; connection: ptr gio.IOStream00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "network-event", cast[GCallback](p), xdata, nil, cf)

proc scRestarted*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "restarted", cast[GCallback](p), xdata, nil, cf)

proc scStarting*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "starting", cast[GCallback](p), xdata, nil, cf)

proc scWroteBody*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-body", cast[GCallback](p), xdata, nil, cf)

proc scWroteBodyData*(self: Message;  p: proc (self: ptr Message00; chunk: ptr Buffer00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-body-data", cast[GCallback](p), xdata, nil, cf)

proc scWroteChunk*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-chunk", cast[GCallback](p), xdata, nil, cf)

proc scWroteHeaders*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-headers", cast[GCallback](p), xdata, nil, cf)

proc scWroteInformational*(self: Message;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "wrote-informational", cast[GCallback](p), xdata, nil, cf)

proc soup_message_new(`method`: cstring; uriString: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessage*(`method`: cstring; uriString: cstring): Message =
  let gobj = soup_message_new(`method`, uriString)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMessage*(tdesc: typedesc; `method`: cstring; uriString: cstring): tdesc =
  assert(result is Message)
  let gobj = soup_message_new(`method`, uriString)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMessage*[T](result: var T; `method`: cstring; uriString: cstring) {.deprecated.} =
  assert(result is Message)
  let gobj = soup_message_new(`method`, uriString)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_message_new_from_uri(`method`: cstring; uri: ptr URI00): ptr Message00 {.
    importc, libprag.}

proc newMessageFromUri*(`method`: cstring; uri: URI): Message =
  let gobj = soup_message_new_from_uri(`method`, cast[ptr URI00](uri.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMessageFromUri*(tdesc: typedesc; `method`: cstring; uri: URI): tdesc =
  assert(result is Message)
  let gobj = soup_message_new_from_uri(`method`, cast[ptr URI00](uri.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMessageFromUri*[T](result: var T; `method`: cstring; uri: URI) {.deprecated.} =
  assert(result is Message)
  let gobj = soup_message_new_from_uri(`method`, cast[ptr URI00](uri.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_message_content_sniffed(self: ptr Message00; contentType: cstring;
    params: ptr HashTable00) {.
    importc, libprag.}

proc contentSniffed*(self: Message; contentType: cstring; params: ptr HashTable00) =
  soup_message_content_sniffed(cast[ptr Message00](self.impl), contentType, params)

proc soup_message_disable_feature(self: ptr Message00; featureType: GType) {.
    importc, libprag.}

proc disableFeature*(self: Message; featureType: GType) =
  soup_message_disable_feature(cast[ptr Message00](self.impl), featureType)

proc soup_message_finished(self: ptr Message00) {.
    importc, libprag.}

proc finished*(self: Message) =
  soup_message_finished(cast[ptr Message00](self.impl))

proc soup_message_get_address(self: ptr Message00): ptr Address00 {.
    importc, libprag.}

proc getAddress*(self: Message): Address =
  let gobj = soup_message_get_address(cast[ptr Message00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc address*(self: Message): Address =
  let gobj = soup_message_get_address(cast[ptr Message00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_message_get_first_party(self: ptr Message00): ptr URI00 {.
    importc, libprag.}

proc getFirstParty*(self: Message): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_message_get_first_party(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc firstParty*(self: Message): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_message_get_first_party(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc soup_message_get_https_status(self: ptr Message00; certificate: var ptr gio.TlsCertificate00;
    errors: var gio.TlsCertificateFlags): gboolean {.
    importc, libprag.}

proc getHttpsStatus*(self: Message; certificate: var gio.TlsCertificate;
    errors: var gio.TlsCertificateFlags): bool =
  var tmpoutgobjectarg: ptr gio.TlsCertificate00
  result = toBool(soup_message_get_https_status(cast[ptr Message00](self.impl), tmpoutgobjectarg, errors))
#  dothemagic(certificate
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    certificate = cast[type(certificate)](argqdata)
    assert(certificate.impl == tmpoutgobjectarg)
  else:
    fnew(certificate, soup.finalizeGObject)
    certificate.impl = tmpoutgobjectarg
    GC_ref(certificate)
    if g_object_is_floating(certificate.impl).int != 0:
      discard g_object_ref_sink(certificate.impl)
    g_object_add_toggle_ref(certificate.impl, toggleNotify, addr(certificate[]))
    g_object_unref(certificate.impl)
    assert(g_object_get_qdata(certificate.impl, Quark) == nil)
    g_object_set_qdata(certificate.impl, Quark, addr(certificate[]))


proc soup_message_get_is_top_level_navigation(self: ptr Message00): gboolean {.
    importc, libprag.}

proc getIsTopLevelNavigation*(self: Message): bool =
  toBool(soup_message_get_is_top_level_navigation(cast[ptr Message00](self.impl)))

proc isTopLevelNavigation*(self: Message): bool =
  toBool(soup_message_get_is_top_level_navigation(cast[ptr Message00](self.impl)))

proc soup_message_get_site_for_cookies(self: ptr Message00): ptr URI00 {.
    importc, libprag.}

proc getSiteForCookies*(self: Message): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_message_get_site_for_cookies(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc siteForCookies*(self: Message): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_message_get_site_for_cookies(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc soup_message_get_uri(self: ptr Message00): ptr URI00 {.
    importc, libprag.}

proc getUri*(self: Message): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_message_get_uri(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc uri*(self: Message): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_message_get_uri(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc soup_message_got_body(self: ptr Message00) {.
    importc, libprag.}

proc gotBody*(self: Message) =
  soup_message_got_body(cast[ptr Message00](self.impl))

proc soup_message_got_chunk(self: ptr Message00; chunk: ptr Buffer00) {.
    importc, libprag.}

proc gotChunk*(self: Message; chunk: Buffer) =
  soup_message_got_chunk(cast[ptr Message00](self.impl), cast[ptr Buffer00](chunk.impl))

proc soup_message_got_headers(self: ptr Message00) {.
    importc, libprag.}

proc gotHeaders*(self: Message) =
  soup_message_got_headers(cast[ptr Message00](self.impl))

proc soup_message_got_informational(self: ptr Message00) {.
    importc, libprag.}

proc gotInformational*(self: Message) =
  soup_message_got_informational(cast[ptr Message00](self.impl))

proc soup_message_is_feature_disabled(self: ptr Message00; featureType: GType): gboolean {.
    importc, libprag.}

proc isFeatureDisabled*(self: Message; featureType: GType): bool =
  toBool(soup_message_is_feature_disabled(cast[ptr Message00](self.impl), featureType))

proc soup_message_is_keepalive(self: ptr Message00): gboolean {.
    importc, libprag.}

proc isKeepalive*(self: Message): bool =
  toBool(soup_message_is_keepalive(cast[ptr Message00](self.impl)))

proc soup_message_restarted(self: ptr Message00) {.
    importc, libprag.}

proc restarted*(self: Message) =
  soup_message_restarted(cast[ptr Message00](self.impl))

proc soup_message_set_first_party(self: ptr Message00; firstParty: ptr URI00) {.
    importc, libprag.}

proc setFirstParty*(self: Message; firstParty: URI) =
  soup_message_set_first_party(cast[ptr Message00](self.impl), cast[ptr URI00](firstParty.impl))

proc `firstParty=`*(self: Message; firstParty: URI) =
  soup_message_set_first_party(cast[ptr Message00](self.impl), cast[ptr URI00](firstParty.impl))

proc soup_message_set_is_top_level_navigation(self: ptr Message00; isTopLevelNavigation: gboolean) {.
    importc, libprag.}

proc setIsTopLevelNavigation*(self: Message; isTopLevelNavigation: bool = true) =
  soup_message_set_is_top_level_navigation(cast[ptr Message00](self.impl), gboolean(isTopLevelNavigation))

proc `isTopLevelNavigation=`*(self: Message; isTopLevelNavigation: bool) =
  soup_message_set_is_top_level_navigation(cast[ptr Message00](self.impl), gboolean(isTopLevelNavigation))

proc soup_message_set_redirect(self: ptr Message00; statusCode: uint32; redirectUri: cstring) {.
    importc, libprag.}

proc setRedirect*(self: Message; statusCode: int; redirectUri: cstring) =
  soup_message_set_redirect(cast[ptr Message00](self.impl), uint32(statusCode), redirectUri)

proc soup_message_set_site_for_cookies(self: ptr Message00; siteForCookies: ptr URI00) {.
    importc, libprag.}

proc setSiteForCookies*(self: Message; siteForCookies: URI = nil) =
  soup_message_set_site_for_cookies(cast[ptr Message00](self.impl), if siteForCookies.isNil: nil else: cast[ptr URI00](siteForCookies.impl))

proc `siteForCookies=`*(self: Message; siteForCookies: URI = nil) =
  soup_message_set_site_for_cookies(cast[ptr Message00](self.impl), if siteForCookies.isNil: nil else: cast[ptr URI00](siteForCookies.impl))

proc soup_message_set_status(self: ptr Message00; statusCode: uint32) {.
    importc, libprag.}

proc setStatus*(self: Message; statusCode: int) =
  soup_message_set_status(cast[ptr Message00](self.impl), uint32(statusCode))

proc `status=`*(self: Message; statusCode: int) =
  soup_message_set_status(cast[ptr Message00](self.impl), uint32(statusCode))

proc soup_message_set_status_full(self: ptr Message00; statusCode: uint32;
    reasonPhrase: cstring) {.
    importc, libprag.}

proc setStatusFull*(self: Message; statusCode: int; reasonPhrase: cstring) =
  soup_message_set_status_full(cast[ptr Message00](self.impl), uint32(statusCode), reasonPhrase)

proc soup_message_set_uri(self: ptr Message00; uri: ptr URI00) {.
    importc, libprag.}

proc setUri*(self: Message; uri: URI) =
  soup_message_set_uri(cast[ptr Message00](self.impl), cast[ptr URI00](uri.impl))

proc `uri=`*(self: Message; uri: URI) =
  soup_message_set_uri(cast[ptr Message00](self.impl), cast[ptr URI00](uri.impl))

proc soup_message_starting(self: ptr Message00) {.
    importc, libprag.}

proc starting*(self: Message) =
  soup_message_starting(cast[ptr Message00](self.impl))

proc soup_message_wrote_body(self: ptr Message00) {.
    importc, libprag.}

proc wroteBody*(self: Message) =
  soup_message_wrote_body(cast[ptr Message00](self.impl))

proc soup_message_wrote_body_data(self: ptr Message00; chunk: ptr Buffer00) {.
    importc, libprag.}

proc wroteBodyData*(self: Message; chunk: Buffer) =
  soup_message_wrote_body_data(cast[ptr Message00](self.impl), cast[ptr Buffer00](chunk.impl))

proc soup_message_wrote_chunk(self: ptr Message00) {.
    importc, libprag.}

proc wroteChunk*(self: Message) =
  soup_message_wrote_chunk(cast[ptr Message00](self.impl))

proc soup_message_wrote_headers(self: ptr Message00) {.
    importc, libprag.}

proc wroteHeaders*(self: Message) =
  soup_message_wrote_headers(cast[ptr Message00](self.impl))

proc soup_message_wrote_informational(self: ptr Message00) {.
    importc, libprag.}

proc wroteInformational*(self: Message) =
  soup_message_wrote_informational(cast[ptr Message00](self.impl))

proc soup_auth_new(`type`: GType; msg: ptr Message00; authHeader: cstring): ptr Auth00 {.
    importc, libprag.}

proc newAuth*(`type`: GType; msg: Message; authHeader: cstring): Auth =
  let gobj = soup_auth_new(`type`, cast[ptr Message00](msg.impl), authHeader)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAuth*(tdesc: typedesc; `type`: GType; msg: Message; authHeader: cstring): tdesc =
  assert(result is Auth)
  let gobj = soup_auth_new(`type`, cast[ptr Message00](msg.impl), authHeader)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAuth*[T](result: var T; `type`: GType; msg: Message; authHeader: cstring) {.deprecated.} =
  assert(result is Auth)
  let gobj = soup_auth_new(`type`, cast[ptr Message00](msg.impl), authHeader)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_auth_get_authorization(self: ptr Auth00; msg: ptr Message00): cstring {.
    importc, libprag.}

proc getAuthorization*(self: Auth; msg: Message): string =
  let resul0 = soup_auth_get_authorization(cast[ptr Auth00](self.impl), cast[ptr Message00](msg.impl))
  result = $resul0
  cogfree(resul0)

proc soup_auth_is_ready(self: ptr Auth00; msg: ptr Message00): gboolean {.
    importc, libprag.}

proc isReady*(self: Auth; msg: Message): bool =
  toBool(soup_auth_is_ready(cast[ptr Auth00](self.impl), cast[ptr Message00](msg.impl)))

proc soup_auth_update(self: ptr Auth00; msg: ptr Message00; authHeader: cstring): gboolean {.
    importc, libprag.}

proc update*(self: Auth; msg: Message; authHeader: cstring): bool =
  toBool(soup_auth_update(cast[ptr Auth00](self.impl), cast[ptr Message00](msg.impl), authHeader))

type
  Request* = ref object of gobject.Object
  Request00* = object of gobject.Object00

proc soup_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Request()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_request_get_content_length(self: ptr Request00): int64 {.
    importc, libprag.}

proc getContentLength*(self: Request): int64 =
  soup_request_get_content_length(cast[ptr Request00](self.impl))

proc contentLength*(self: Request): int64 =
  soup_request_get_content_length(cast[ptr Request00](self.impl))

proc soup_request_get_content_type(self: ptr Request00): cstring {.
    importc, libprag.}

proc getContentType*(self: Request): string =
  let resul0 = soup_request_get_content_type(cast[ptr Request00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc contentType*(self: Request): string =
  let resul0 = soup_request_get_content_type(cast[ptr Request00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_request_get_uri(self: ptr Request00): ptr URI00 {.
    importc, libprag.}

proc getUri*(self: Request): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_request_get_uri(cast[ptr Request00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc uri*(self: Request): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_request_get_uri(cast[ptr Request00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc soup_request_send(self: ptr Request00; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc send*(self: Request; cancellable: gio.Cancellable = nil): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_request_send(cast[ptr Request00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
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

proc soup_request_send_async(self: ptr Request00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc sendAsync*(self: Request; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  soup_request_send_async(cast[ptr Request00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_request_send_finish(self: ptr Request00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc sendFinish*(self: Request; resu: gio.AsyncResult): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_request_send_finish(cast[ptr Request00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
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

proc soup_message_get_soup_request(self: ptr Message00): ptr Request00 {.
    importc, libprag.}

proc getSoupRequest*(self: Message): Request =
  let gobj = soup_message_get_soup_request(cast[ptr Message00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soupRequest*(self: Message): Request =
  let gobj = soup_message_get_soup_request(cast[ptr Message00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Socket* = ref object of gobject.Object
  Socket00* = object of gobject.Object00

proc soup_socket_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Socket()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDisconnected*(self: Socket;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "disconnected", cast[GCallback](p), xdata, nil, cf)

proc scEvent*(self: Socket;  p: proc (self: ptr Socket00; event: gio.SocketClientEvent; connection: ptr gio.IOStream00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "event", cast[GCallback](p), xdata, nil, cf)

proc scNewConnection*(self: Socket;  p: proc (self: ptr Socket00; new: ptr Socket00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-connection", cast[GCallback](p), xdata, nil, cf)

proc scReadable*(self: Socket;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "readable", cast[GCallback](p), xdata, nil, cf)

proc scWritable*(self: Socket;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "writable", cast[GCallback](p), xdata, nil, cf)

proc soup_socket_connect_sync(self: ptr Socket00; cancellable: ptr gio.Cancellable00): uint32 {.
    importc, libprag.}

proc connectSync*(self: Socket; cancellable: gio.Cancellable = nil): int =
  int(soup_socket_connect_sync(cast[ptr Socket00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl)))

proc soup_socket_disconnect(self: ptr Socket00) {.
    importc, libprag.}

proc disconnect*(self: Socket) =
  soup_socket_disconnect(cast[ptr Socket00](self.impl))

proc soup_socket_get_fd(self: ptr Socket00): int32 {.
    importc, libprag.}

proc getFd*(self: Socket): int =
  int(soup_socket_get_fd(cast[ptr Socket00](self.impl)))

proc fd*(self: Socket): int =
  int(soup_socket_get_fd(cast[ptr Socket00](self.impl)))

proc soup_socket_get_local_address(self: ptr Socket00): ptr Address00 {.
    importc, libprag.}

proc getLocalAddress*(self: Socket): Address =
  let gobj = soup_socket_get_local_address(cast[ptr Socket00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc localAddress*(self: Socket): Address =
  let gobj = soup_socket_get_local_address(cast[ptr Socket00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_socket_get_remote_address(self: ptr Socket00): ptr Address00 {.
    importc, libprag.}

proc getRemoteAddress*(self: Socket): Address =
  let gobj = soup_socket_get_remote_address(cast[ptr Socket00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc remoteAddress*(self: Socket): Address =
  let gobj = soup_socket_get_remote_address(cast[ptr Socket00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_socket_is_connected(self: ptr Socket00): gboolean {.
    importc, libprag.}

proc isConnected*(self: Socket): bool =
  toBool(soup_socket_is_connected(cast[ptr Socket00](self.impl)))

proc soup_socket_is_ssl(self: ptr Socket00): gboolean {.
    importc, libprag.}

proc isSsl*(self: Socket): bool =
  toBool(soup_socket_is_ssl(cast[ptr Socket00](self.impl)))

proc soup_socket_listen(self: ptr Socket00): gboolean {.
    importc, libprag.}

proc listen*(self: Socket): bool =
  toBool(soup_socket_listen(cast[ptr Socket00](self.impl)))

proc soup_socket_start_proxy_ssl(self: ptr Socket00; sslHost: cstring; cancellable: ptr gio.Cancellable00): gboolean {.
    importc, libprag.}

proc startProxySsl*(self: Socket; sslHost: cstring; cancellable: gio.Cancellable = nil): bool =
  toBool(soup_socket_start_proxy_ssl(cast[ptr Socket00](self.impl), sslHost, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl)))

proc soup_socket_start_ssl(self: ptr Socket00; cancellable: ptr gio.Cancellable00): gboolean {.
    importc, libprag.}

proc startSsl*(self: Socket; cancellable: gio.Cancellable = nil): bool =
  toBool(soup_socket_start_ssl(cast[ptr Socket00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl)))

type
  Session* = ref object of gobject.Object
  Session00* = object of gobject.Object00

proc soup_session_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Session()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAuthenticate*(self: Session;  p: proc (self: ptr Session00; msg: ptr Message00; auth: ptr Auth00; retrying: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "authenticate", cast[GCallback](p), xdata, nil, cf)

proc scConnectionCreated*(self: Session;  p: proc (self: ptr Session00; connection: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "connection-created", cast[GCallback](p), xdata, nil, cf)

proc scRequestQueued*(self: Session;  p: proc (self: ptr Session00; msg: ptr Message00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-queued", cast[GCallback](p), xdata, nil, cf)

proc scRequestStarted*(self: Session;  p: proc (self: ptr Session00; msg: ptr Message00; socket: ptr Socket00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-started", cast[GCallback](p), xdata, nil, cf)

proc scRequestUnqueued*(self: Session;  p: proc (self: ptr Session00; msg: ptr Message00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-unqueued", cast[GCallback](p), xdata, nil, cf)

proc scTunneling*(self: Session;  p: proc (self: ptr Session00; connection: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "tunneling", cast[GCallback](p), xdata, nil, cf)

proc soup_session_new(): ptr Session00 {.
    importc, libprag.}

proc newSession*(): Session =
  let gobj = soup_session_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSession*(tdesc: typedesc): tdesc =
  assert(result is Session)
  let gobj = soup_session_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSession*[T](result: var T) {.deprecated.} =
  assert(result is Session)
  let gobj = soup_session_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_session_abort(self: ptr Session00) {.
    importc, libprag.}

proc abort*(self: Session) =
  soup_session_abort(cast[ptr Session00](self.impl))

proc soup_session_add_feature_by_type(self: ptr Session00; featureType: GType) {.
    importc, libprag.}

proc addFeatureByType*(self: Session; featureType: GType) =
  soup_session_add_feature_by_type(cast[ptr Session00](self.impl), featureType)

proc soup_session_cancel_message(self: ptr Session00; msg: ptr Message00;
    statusCode: uint32) {.
    importc, libprag.}

proc cancelMessage*(self: Session; msg: Message; statusCode: int) =
  soup_session_cancel_message(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), uint32(statusCode))

proc soup_session_connect_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr gio.IOStream00 {.
    importc, libprag.}

proc connectFinish*(self: Session; resu: gio.AsyncResult): gio.IOStream =
  var gerror: ptr glib.Error
  let gobj = soup_session_connect_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
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

proc soup_session_get_async_context(self: ptr Session00): ptr glib.MainContext00 {.
    importc, libprag.}

proc getAsyncContext*(self: Session): glib.MainContext =
  let impl0 = soup_session_get_async_context(cast[ptr Session00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGMainContext)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), impl0))

proc asyncContext*(self: Session): glib.MainContext =
  let impl0 = soup_session_get_async_context(cast[ptr Session00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGMainContext)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), impl0))

proc soup_session_has_feature(self: ptr Session00; featureType: GType): gboolean {.
    importc, libprag.}

proc hasFeature*(self: Session; featureType: GType): bool =
  toBool(soup_session_has_feature(cast[ptr Session00](self.impl), featureType))

proc soup_session_pause_message(self: ptr Session00; msg: ptr Message00) {.
    importc, libprag.}

proc pauseMessage*(self: Session; msg: Message) =
  soup_session_pause_message(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl))

proc soup_session_prefetch_dns(self: ptr Session00; hostname: cstring; cancellable: ptr gio.Cancellable00;
    callback: AddressCallback; userData: pointer) {.
    importc, libprag.}

proc prefetchDns*(self: Session; hostname: cstring; cancellable: gio.Cancellable = nil;
    callback: AddressCallback; userData: pointer) =
  soup_session_prefetch_dns(cast[ptr Session00](self.impl), hostname, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_prepare_for_uri(self: ptr Session00; uri: ptr URI00) {.
    importc, libprag.}

proc prepareForUri*(self: Session; uri: URI) =
  soup_session_prepare_for_uri(cast[ptr Session00](self.impl), cast[ptr URI00](uri.impl))

proc soup_session_redirect_message(self: ptr Session00; msg: ptr Message00): gboolean {.
    importc, libprag.}

proc redirectMessage*(self: Session; msg: Message): bool =
  toBool(soup_session_redirect_message(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl)))

proc soup_session_remove_feature_by_type(self: ptr Session00; featureType: GType) {.
    importc, libprag.}

proc removeFeatureByType*(self: Session; featureType: GType) =
  soup_session_remove_feature_by_type(cast[ptr Session00](self.impl), featureType)

proc soup_session_request(self: ptr Session00; uriString: cstring; error: ptr ptr glib.Error = nil): ptr Request00 {.
    importc, libprag.}

proc request*(self: Session; uriString: cstring): Request =
  var gerror: ptr glib.Error
  let gobj = soup_session_request(cast[ptr Session00](self.impl), uriString, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_session_request_uri(self: ptr Session00; uri: ptr URI00; error: ptr ptr glib.Error = nil): ptr Request00 {.
    importc, libprag.}

proc requestUri*(self: Session; uri: URI): Request =
  var gerror: ptr glib.Error
  let gobj = soup_session_request_uri(cast[ptr Session00](self.impl), cast[ptr URI00](uri.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_session_requeue_message(self: ptr Session00; msg: ptr Message00) {.
    importc, libprag.}

proc requeueMessage*(self: Session; msg: Message) =
  soup_session_requeue_message(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl))

proc soup_session_send(self: ptr Session00; msg: ptr Message00; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc send*(self: Session; msg: Message; cancellable: gio.Cancellable = nil): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_session_send(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
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

proc soup_session_send_async(self: ptr Session00; msg: ptr Message00; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc sendAsync*(self: Session; msg: Message; cancellable: gio.Cancellable = nil;
    callback: AsyncReadyCallback; userData: pointer) =
  soup_session_send_async(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_send_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc sendFinish*(self: Session; resu: gio.AsyncResult): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_session_send_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
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

proc soup_session_send_message(self: ptr Session00; msg: ptr Message00): uint32 {.
    importc, libprag.}

proc sendMessage*(self: Session; msg: Message): int =
  int(soup_session_send_message(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl)))

proc soup_session_steal_connection(self: ptr Session00; msg: ptr Message00): ptr gio.IOStream00 {.
    importc, libprag.}

proc stealConnection*(self: Session; msg: Message): gio.IOStream =
  let gobj = soup_session_steal_connection(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl))
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

proc soup_session_unpause_message(self: ptr Session00; msg: ptr Message00) {.
    importc, libprag.}

proc unpauseMessage*(self: Session; msg: Message) =
  soup_session_unpause_message(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl))

proc soup_session_websocket_connect_async(self: ptr Session00; msg: ptr Message00;
    origin: cstring; protocols: ptr cstring; cancellable: ptr gio.Cancellable00;
    callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc websocketConnectAsync*(self: Session; msg: Message; origin: cstring = nil;
    protocols: openArray[string]; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    userData: pointer) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  soup_session_websocket_connect_async(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl), origin, seq2CstringArray(protocols, fs469n23), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc soup_session_would_redirect(self: ptr Session00; msg: ptr Message00): gboolean {.
    importc, libprag.}

proc wouldRedirect*(self: Session; msg: Message): bool =
  toBool(soup_session_would_redirect(cast[ptr Session00](self.impl), cast[ptr Message00](msg.impl)))

proc soup_request_get_session(self: ptr Request00): ptr Session00 {.
    importc, libprag.}

proc getSession*(self: Request): Session =
  let gobj = soup_request_get_session(cast[ptr Request00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc session*(self: Request): Session =
  let gobj = soup_request_get_session(cast[ptr Request00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SocketIOStatus* {.size: sizeof(cint), pure.} = enum
    ok = 0
    wouldBlock = 1
    eof = 2
    error = 3

proc soup_socket_read(self: ptr Socket00; buffer: ptr uint8; len: uint64;
    nread: var uint64; cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): SocketIOStatus {.
    importc, libprag.}

proc read*(self: Socket; buffer: seq[uint8] | string; nread: var uint64;
    cancellable: gio.Cancellable = nil): SocketIOStatus =
  let len = uint64(buffer.len)
  var gerror: ptr glib.Error
  let resul0 = soup_socket_read(cast[ptr Socket00](self.impl), cast[ptr uint8](unsafeaddr(buffer[0])), len, nread, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc soup_socket_read_until(self: ptr Socket00; buffer: ptr uint8; len: uint64;
    boundary: pointer; boundaryLen: uint64; nread: var uint64; gotBoundary: ptr gboolean;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): SocketIOStatus {.
    importc, libprag.}

proc readUntil*(self: Socket; buffer: seq[uint8] | string; boundary: pointer;
    boundaryLen: uint64; nread: var uint64; gotBoundary: ptr gboolean; cancellable: gio.Cancellable = nil): SocketIOStatus =
  let len = uint64(buffer.len)
  var gerror: ptr glib.Error
  let resul0 = soup_socket_read_until(cast[ptr Socket00](self.impl), cast[ptr uint8](unsafeaddr(buffer[0])), len, boundary, boundaryLen, nread, gotBoundary, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc soup_socket_write(self: ptr Socket00; buffer: ptr uint8; len: uint64;
    nwrote: var uint64; cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): SocketIOStatus {.
    importc, libprag.}

proc write*(self: Socket; buffer: seq[uint8] | string; nwrote: var uint64;
    cancellable: gio.Cancellable = nil): SocketIOStatus =
  let len = uint64(buffer.len)
  var gerror: ptr glib.Error
  let resul0 = soup_socket_write(cast[ptr Socket00](self.impl), cast[ptr uint8](unsafeaddr(buffer[0])), len, nwrote, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

type
  SessionFeature00* = object of gobject.Object00
  SessionFeature* = ref object of gobject.Object

proc soup_session_get_feature(self: ptr Session00; featureType: GType): ptr SessionFeature00 {.
    importc, libprag.}

proc getFeature*(self: Session; featureType: GType): SessionFeature =
  let gobj = soup_session_get_feature(cast[ptr Session00](self.impl), featureType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_session_get_feature_for_message(self: ptr Session00; featureType: GType;
    msg: ptr Message00): ptr SessionFeature00 {.
    importc, libprag.}

proc getFeatureForMessage*(self: Session; featureType: GType;
    msg: Message): SessionFeature =
  let gobj = soup_session_get_feature_for_message(cast[ptr Session00](self.impl), featureType, cast[ptr Message00](msg.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_session_get_features(self: ptr Session00; featureType: GType): ptr glib.SList {.
    importc, libprag.}

proc getFeatures*(self: Session; featureType: GType): seq[SessionFeature] =
  let resul0 = soup_session_get_features(cast[ptr Session00](self.impl), featureType)
  result = gslistObjects2seq(SessionFeature, resul0, false)
  g_slist_free(resul0)

type
  AuthManager* = ref object of gobject.Object
  AuthManager00* = object of gobject.Object00

proc soup_auth_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scAuthenticate*(self: AuthManager;  p: proc (self: ptr AuthManager00; msg: ptr Message00; auth: ptr Auth00; retrying: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "authenticate", cast[GCallback](p), xdata, nil, cf)

proc soup_auth_manager_clear_cached_credentials(self: ptr AuthManager00) {.
    importc, libprag.}

proc clearCachedCredentials*(self: AuthManager) =
  soup_auth_manager_clear_cached_credentials(cast[ptr AuthManager00](self.impl))

proc soup_auth_manager_use_auth(self: ptr AuthManager00; uri: ptr URI00;
    auth: ptr Auth00) {.
    importc, libprag.}

proc useAuth*(self: AuthManager; uri: URI; auth: Auth) =
  soup_auth_manager_use_auth(cast[ptr AuthManager00](self.impl), cast[ptr URI00](uri.impl), cast[ptr Auth00](auth.impl))

type
  Cookie00* {.pure.} = object
  Cookie* = ref object
    impl*: ptr Cookie00
    ignoreFinalizer*: bool

proc soup_cookie_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupCookie*(self: Cookie) =
  if not self.ignoreFinalizer:
    boxedFree(soup_cookie_get_type(), cast[ptr Cookie00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Cookie()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_cookie_get_type(), cast[ptr Cookie00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Cookie) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupCookie)

proc soup_cookie_free(self: ptr Cookie00) {.
    importc, libprag.}

proc free*(self: Cookie) =
  soup_cookie_free(cast[ptr Cookie00](self.impl))

proc finalizerfree*(self: Cookie) =
  if not self.ignoreFinalizer:
    soup_cookie_free(cast[ptr Cookie00](self.impl))

proc soup_cookie_applies_to_uri(self: ptr Cookie00; uri: ptr URI00): gboolean {.
    importc, libprag.}

proc appliesToUri*(self: Cookie; uri: URI): bool =
  toBool(soup_cookie_applies_to_uri(cast[ptr Cookie00](self.impl), cast[ptr URI00](uri.impl)))

proc soup_cookie_copy(self: ptr Cookie00): ptr Cookie00 {.
    importc, libprag.}

proc copy*(self: Cookie): Cookie =
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_copy(cast[ptr Cookie00](self.impl))

proc soup_cookie_domain_matches(self: ptr Cookie00; host: cstring): gboolean {.
    importc, libprag.}

proc domainMatches*(self: Cookie; host: cstring): bool =
  toBool(soup_cookie_domain_matches(cast[ptr Cookie00](self.impl), host))

proc soup_cookie_equal(self: ptr Cookie00; cookie2: ptr Cookie00): gboolean {.
    importc, libprag.}

proc equal*(self: Cookie; cookie2: Cookie): bool =
  toBool(soup_cookie_equal(cast[ptr Cookie00](self.impl), cast[ptr Cookie00](cookie2.impl)))

proc soup_cookie_new(name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int32): ptr Cookie00 {.
    importc, libprag.}

proc newCookie*(name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int): Cookie =
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_new(name, value, domain, path, int32(maxAge))

proc newCookie*(tdesc: typedesc; name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int): tdesc =
  assert(result is Cookie)
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_new(name, value, domain, path, int32(maxAge))

proc initCookie*[T](result: var T; name: cstring; value: cstring; domain: cstring; path: cstring;
    maxAge: int) {.deprecated.} =
  assert(result is Cookie)
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = soup_cookie_new(name, value, domain, path, int32(maxAge))

proc soup_cookie_get_domain(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getDomain*(self: Cookie): string =
  result = $soup_cookie_get_domain(cast[ptr Cookie00](self.impl))

proc domain*(self: Cookie): string =
  result = $soup_cookie_get_domain(cast[ptr Cookie00](self.impl))

proc soup_cookie_get_http_only(self: ptr Cookie00): gboolean {.
    importc, libprag.}

proc getHttpOnly*(self: Cookie): bool =
  toBool(soup_cookie_get_http_only(cast[ptr Cookie00](self.impl)))

proc httpOnly*(self: Cookie): bool =
  toBool(soup_cookie_get_http_only(cast[ptr Cookie00](self.impl)))

proc soup_cookie_get_name(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getName*(self: Cookie): string =
  result = $soup_cookie_get_name(cast[ptr Cookie00](self.impl))

proc name*(self: Cookie): string =
  result = $soup_cookie_get_name(cast[ptr Cookie00](self.impl))

proc soup_cookie_get_path(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getPath*(self: Cookie): string =
  result = $soup_cookie_get_path(cast[ptr Cookie00](self.impl))

proc path*(self: Cookie): string =
  result = $soup_cookie_get_path(cast[ptr Cookie00](self.impl))

proc soup_cookie_get_secure(self: ptr Cookie00): gboolean {.
    importc, libprag.}

proc getSecure*(self: Cookie): bool =
  toBool(soup_cookie_get_secure(cast[ptr Cookie00](self.impl)))

proc secure*(self: Cookie): bool =
  toBool(soup_cookie_get_secure(cast[ptr Cookie00](self.impl)))

proc soup_cookie_get_value(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc getValue*(self: Cookie): string =
  result = $soup_cookie_get_value(cast[ptr Cookie00](self.impl))

proc value*(self: Cookie): string =
  result = $soup_cookie_get_value(cast[ptr Cookie00](self.impl))

proc soup_cookie_set_domain(self: ptr Cookie00; domain: cstring) {.
    importc, libprag.}

proc setDomain*(self: Cookie; domain: cstring) =
  soup_cookie_set_domain(cast[ptr Cookie00](self.impl), domain)

proc `domain=`*(self: Cookie; domain: cstring) =
  soup_cookie_set_domain(cast[ptr Cookie00](self.impl), domain)

proc soup_cookie_set_http_only(self: ptr Cookie00; httpOnly: gboolean) {.
    importc, libprag.}

proc setHttpOnly*(self: Cookie; httpOnly: bool = true) =
  soup_cookie_set_http_only(cast[ptr Cookie00](self.impl), gboolean(httpOnly))

proc `httpOnly=`*(self: Cookie; httpOnly: bool) =
  soup_cookie_set_http_only(cast[ptr Cookie00](self.impl), gboolean(httpOnly))

proc soup_cookie_set_max_age(self: ptr Cookie00; maxAge: int32) {.
    importc, libprag.}

proc setMaxAge*(self: Cookie; maxAge: int) =
  soup_cookie_set_max_age(cast[ptr Cookie00](self.impl), int32(maxAge))

proc `maxAge=`*(self: Cookie; maxAge: int) =
  soup_cookie_set_max_age(cast[ptr Cookie00](self.impl), int32(maxAge))

proc soup_cookie_set_name(self: ptr Cookie00; name: cstring) {.
    importc, libprag.}

proc setName*(self: Cookie; name: cstring) =
  soup_cookie_set_name(cast[ptr Cookie00](self.impl), name)

proc `name=`*(self: Cookie; name: cstring) =
  soup_cookie_set_name(cast[ptr Cookie00](self.impl), name)

proc soup_cookie_set_path(self: ptr Cookie00; path: cstring) {.
    importc, libprag.}

proc setPath*(self: Cookie; path: cstring) =
  soup_cookie_set_path(cast[ptr Cookie00](self.impl), path)

proc `path=`*(self: Cookie; path: cstring) =
  soup_cookie_set_path(cast[ptr Cookie00](self.impl), path)

proc soup_cookie_set_secure(self: ptr Cookie00; secure: gboolean) {.
    importc, libprag.}

proc setSecure*(self: Cookie; secure: bool = true) =
  soup_cookie_set_secure(cast[ptr Cookie00](self.impl), gboolean(secure))

proc `secure=`*(self: Cookie; secure: bool) =
  soup_cookie_set_secure(cast[ptr Cookie00](self.impl), gboolean(secure))

proc soup_cookie_set_value(self: ptr Cookie00; value: cstring) {.
    importc, libprag.}

proc setValue*(self: Cookie; value: cstring) =
  soup_cookie_set_value(cast[ptr Cookie00](self.impl), value)

proc `value=`*(self: Cookie; value: cstring) =
  soup_cookie_set_value(cast[ptr Cookie00](self.impl), value)

proc soup_cookie_to_cookie_header(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc toCookieHeader*(self: Cookie): string =
  let resul0 = soup_cookie_to_cookie_header(cast[ptr Cookie00](self.impl))
  result = $resul0
  cogfree(resul0)

proc soup_cookie_to_set_cookie_header(self: ptr Cookie00): cstring {.
    importc, libprag.}

proc toSetCookieHeader*(self: Cookie): string =
  let resul0 = soup_cookie_to_set_cookie_header(cast[ptr Cookie00](self.impl))
  result = $resul0
  cogfree(resul0)

proc soup_cookie_parse(header: cstring; origin: ptr URI00): ptr Cookie00 {.
    importc, libprag.}

proc parse*(header: cstring; origin: URI): Cookie =
  let impl0 = soup_cookie_parse(header, cast[ptr URI00](origin.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupCookie)
  result.impl = impl0

type
  CookieJar* = ref object of gobject.Object
  CookieJar00* = object of gobject.Object00

proc soup_cookie_jar_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CookieJar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: CookieJar;  p: proc (self: ptr CookieJar00; oldCookie: ptr Cookie00; newCookie: ptr Cookie00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc soup_cookie_jar_new(): ptr CookieJar00 {.
    importc, libprag.}

proc newCookieJar*(): CookieJar =
  let gobj = soup_cookie_jar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCookieJar*(tdesc: typedesc): tdesc =
  assert(result is CookieJar)
  let gobj = soup_cookie_jar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCookieJar*[T](result: var T) {.deprecated.} =
  assert(result is CookieJar)
  let gobj = soup_cookie_jar_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_cookie_jar_add_cookie(self: ptr CookieJar00; cookie: ptr Cookie00) {.
    importc, libprag.}

proc addCookie*(self: CookieJar; cookie: Cookie) =
  soup_cookie_jar_add_cookie(cast[ptr CookieJar00](self.impl), cast[ptr Cookie00](g_boxed_copy(soup_cookie_get_type(), cookie.impl)))

proc soup_cookie_jar_add_cookie_full(self: ptr CookieJar00; cookie: ptr Cookie00;
    uri: ptr URI00; firstParty: ptr URI00) {.
    importc, libprag.}

proc addCookieFull*(self: CookieJar; cookie: Cookie; uri: URI = nil;
    firstParty: URI = nil) =
  soup_cookie_jar_add_cookie_full(cast[ptr CookieJar00](self.impl), cast[ptr Cookie00](g_boxed_copy(soup_cookie_get_type(), cookie.impl)), if uri.isNil: nil else: cast[ptr URI00](uri.impl), if firstParty.isNil: nil else: cast[ptr URI00](firstParty.impl))

proc soup_cookie_jar_add_cookie_with_first_party(self: ptr CookieJar00; firstParty: ptr URI00;
    cookie: ptr Cookie00) {.
    importc, libprag.}

proc addCookieWithFirstParty*(self: CookieJar; firstParty: URI;
    cookie: Cookie) =
  soup_cookie_jar_add_cookie_with_first_party(cast[ptr CookieJar00](self.impl), cast[ptr URI00](firstParty.impl), cast[ptr Cookie00](g_boxed_copy(soup_cookie_get_type(), cookie.impl)))

proc soup_cookie_jar_all_cookies(self: ptr CookieJar00): ptr glib.SList {.
    importc, libprag.}

proc allCookies*(self: CookieJar): seq[Cookie] =
  let resul0 = soup_cookie_jar_all_cookies(cast[ptr CookieJar00](self.impl))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookie_jar_delete_cookie(self: ptr CookieJar00; cookie: ptr Cookie00) {.
    importc, libprag.}

proc deleteCookie*(self: CookieJar; cookie: Cookie) =
  soup_cookie_jar_delete_cookie(cast[ptr CookieJar00](self.impl), cast[ptr Cookie00](cookie.impl))

proc soup_cookie_jar_get_cookie_list(self: ptr CookieJar00; uri: ptr URI00;
    forHttp: gboolean): ptr glib.SList {.
    importc, libprag.}

proc getCookieList*(self: CookieJar; uri: URI; forHttp: bool): seq[Cookie] =
  let resul0 = soup_cookie_jar_get_cookie_list(cast[ptr CookieJar00](self.impl), cast[ptr URI00](uri.impl), gboolean(forHttp))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookie_jar_get_cookie_list_with_same_site_info(self: ptr CookieJar00;
    uri: ptr URI00; topLevel: ptr URI00; siteForCookies: ptr URI00; forHttp: gboolean;
    isSafeMethod: gboolean; isTopLevelNavigation: gboolean): ptr glib.SList {.
    importc, libprag.}

proc getCookieListWithSameSiteInfo*(self: CookieJar;
    uri: URI; topLevel: URI = nil; siteForCookies: URI = nil; forHttp: bool;
    isSafeMethod: bool; isTopLevelNavigation: bool): seq[Cookie] =
  let resul0 = soup_cookie_jar_get_cookie_list_with_same_site_info(cast[ptr CookieJar00](self.impl), cast[ptr URI00](uri.impl), if topLevel.isNil: nil else: cast[ptr URI00](topLevel.impl), if siteForCookies.isNil: nil else: cast[ptr URI00](siteForCookies.impl), gboolean(forHttp), gboolean(isSafeMethod), gboolean(isTopLevelNavigation))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookie_jar_get_cookies(self: ptr CookieJar00; uri: ptr URI00; forHttp: gboolean): cstring {.
    importc, libprag.}

proc getCookies*(self: CookieJar; uri: URI; forHttp: bool): string =
  let resul0 = soup_cookie_jar_get_cookies(cast[ptr CookieJar00](self.impl), cast[ptr URI00](uri.impl), gboolean(forHttp))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_cookie_jar_is_persistent(self: ptr CookieJar00): gboolean {.
    importc, libprag.}

proc isPersistent*(self: CookieJar): bool =
  toBool(soup_cookie_jar_is_persistent(cast[ptr CookieJar00](self.impl)))

proc soup_cookie_jar_save(self: ptr CookieJar00) {.
    importc, libprag.}

proc save*(self: CookieJar) =
  soup_cookie_jar_save(cast[ptr CookieJar00](self.impl))

proc soup_cookie_jar_set_cookie(self: ptr CookieJar00; uri: ptr URI00; cookie: cstring) {.
    importc, libprag.}

proc setCookie*(self: CookieJar; uri: URI; cookie: cstring) =
  soup_cookie_jar_set_cookie(cast[ptr CookieJar00](self.impl), cast[ptr URI00](uri.impl), cookie)

proc soup_cookie_jar_set_cookie_with_first_party(self: ptr CookieJar00; uri: ptr URI00;
    firstParty: ptr URI00; cookie: cstring) {.
    importc, libprag.}

proc setCookieWithFirstParty*(self: CookieJar; uri: URI;
    firstParty: URI; cookie: cstring) =
  soup_cookie_jar_set_cookie_with_first_party(cast[ptr CookieJar00](self.impl), cast[ptr URI00](uri.impl), cast[ptr URI00](firstParty.impl), cookie)

type
  CookieJarText* = ref object of CookieJar
  CookieJarText00* = object of CookieJar00

proc soup_cookie_jar_text_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CookieJarText()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_cookie_jar_text_new(filename: cstring; readOnly: gboolean): ptr CookieJarText00 {.
    importc, libprag.}

proc newCookieJarText*(filename: cstring; readOnly: bool): CookieJarText =
  let gobj = soup_cookie_jar_text_new(filename, gboolean(readOnly))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCookieJarText*(tdesc: typedesc; filename: cstring; readOnly: bool): tdesc =
  assert(result is CookieJarText)
  let gobj = soup_cookie_jar_text_new(filename, gboolean(readOnly))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCookieJarText*[T](result: var T; filename: cstring; readOnly: bool) {.deprecated.} =
  assert(result is CookieJarText)
  let gobj = soup_cookie_jar_text_new(filename, gboolean(readOnly))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  WebsocketExtensionManager* = ref object of gobject.Object
  WebsocketExtensionManager00* = object of gobject.Object00

proc soup_websocket_extension_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketExtensionManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  ContentSniffer* = ref object of gobject.Object
  ContentSniffer00* = object of gobject.Object00

proc soup_content_sniffer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentSniffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_content_sniffer_new(): ptr ContentSniffer00 {.
    importc, libprag.}

proc newContentSniffer*(): ContentSniffer =
  let gobj = soup_content_sniffer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContentSniffer*(tdesc: typedesc): tdesc =
  assert(result is ContentSniffer)
  let gobj = soup_content_sniffer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContentSniffer*[T](result: var T) {.deprecated.} =
  assert(result is ContentSniffer)
  let gobj = soup_content_sniffer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_content_sniffer_get_buffer_size(self: ptr ContentSniffer00): uint64 {.
    importc, libprag.}

proc getBufferSize*(self: ContentSniffer): uint64 =
  soup_content_sniffer_get_buffer_size(cast[ptr ContentSniffer00](self.impl))

proc bufferSize*(self: ContentSniffer): uint64 =
  soup_content_sniffer_get_buffer_size(cast[ptr ContentSniffer00](self.impl))

proc soup_content_sniffer_sniff(self: ptr ContentSniffer00; msg: ptr Message00;
    buffer: ptr Buffer00; params: var ptr HashTable00): cstring {.
    importc, libprag.}

proc sniff*(self: ContentSniffer; msg: Message; buffer: Buffer;
    params: var ptr HashTable00 = cast[var ptr HashTable00](nil)): string =
  let resul0 = soup_content_sniffer_sniff(cast[ptr ContentSniffer00](self.impl), cast[ptr Message00](msg.impl), cast[ptr Buffer00](buffer.impl), params)
  result = $resul0
  cogfree(resul0)

type
  ProxyResolverDefault* = ref object of gobject.Object
  ProxyResolverDefault00* = object of gobject.Object00

proc soup_proxy_resolver_default_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ProxyResolverDefault()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  CookieJarDB* = ref object of CookieJar
  CookieJarDB00* = object of CookieJar00

proc soup_cookie_jar_db_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CookieJarDB()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_cookie_jar_db_new(filename: cstring; readOnly: gboolean): ptr CookieJarDB00 {.
    importc, libprag.}

proc newCookieJarDB*(filename: cstring; readOnly: bool): CookieJarDB =
  let gobj = soup_cookie_jar_db_new(filename, gboolean(readOnly))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCookieJarDB*(tdesc: typedesc; filename: cstring; readOnly: bool): tdesc =
  assert(result is CookieJarDB)
  let gobj = soup_cookie_jar_db_new(filename, gboolean(readOnly))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCookieJarDB*[T](result: var T; filename: cstring; readOnly: bool) {.deprecated.} =
  assert(result is CookieJarDB)
  let gobj = soup_cookie_jar_db_new(filename, gboolean(readOnly))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  HSTSPolicy00* {.pure.} = object
  HSTSPolicy* = ref object
    impl*: ptr HSTSPolicy00
    ignoreFinalizer*: bool

proc soup_hsts_policy_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupHSTSPolicy*(self: HSTSPolicy) =
  if not self.ignoreFinalizer:
    boxedFree(soup_hsts_policy_get_type(), cast[ptr HSTSPolicy00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HSTSPolicy()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_hsts_policy_get_type(), cast[ptr HSTSPolicy00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var HSTSPolicy) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupHSTSPolicy)

proc soup_hsts_policy_free(self: ptr HSTSPolicy00) {.
    importc, libprag.}

proc free*(self: HSTSPolicy) =
  soup_hsts_policy_free(cast[ptr HSTSPolicy00](g_boxed_copy(soup_hsts_policy_get_type(), self.impl)))

proc finalizerfree*(self: HSTSPolicy) =
  if not self.ignoreFinalizer:
    soup_hsts_policy_free(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_new_from_response(msg: ptr Message00): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicyFromResponse*(msg: Message): HSTSPolicy =
  let impl0 = soup_hsts_policy_new_from_response(cast[ptr Message00](msg.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = impl0

proc newHSTSPolicyFromResponse*(tdesc: typedesc; msg: Message): tdesc =
  assert(result is HSTSPolicy)
  let impl0 = soup_hsts_policy_new_from_response(cast[ptr Message00](msg.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = impl0

proc initHSTSPolicyFromResponse*[T](result: var T; msg: Message) {.deprecated.} =
  assert(result is HSTSPolicy)
  let impl0 = soup_hsts_policy_new_from_response(cast[ptr Message00](msg.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = impl0

proc soup_hsts_policy_new_session_policy(domain: cstring; includeSubdomains: gboolean): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicySessionPolicy*(domain: cstring; includeSubdomains: bool): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_session_policy(domain, gboolean(includeSubdomains))

proc newHSTSPolicySessionPolicy*(tdesc: typedesc; domain: cstring; includeSubdomains: bool): tdesc =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_session_policy(domain, gboolean(includeSubdomains))

proc initHSTSPolicySessionPolicy*[T](result: var T; domain: cstring; includeSubdomains: bool) {.deprecated.} =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_session_policy(domain, gboolean(includeSubdomains))

proc soup_hsts_policy_copy(self: ptr HSTSPolicy00): ptr HSTSPolicy00 {.
    importc, libprag.}

proc copy*(self: HSTSPolicy): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_copy(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_equal(self: ptr HSTSPolicy00; policy2: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc equal*(self: HSTSPolicy; policy2: HSTSPolicy): bool =
  toBool(soup_hsts_policy_equal(cast[ptr HSTSPolicy00](self.impl), cast[ptr HSTSPolicy00](policy2.impl)))

proc soup_hsts_policy_new(domain: cstring; maxAge: uint64; includeSubdomains: gboolean): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicy*(domain: cstring; maxAge: uint64; includeSubdomains: bool): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new(domain, maxAge, gboolean(includeSubdomains))

proc newHSTSPolicy*(tdesc: typedesc; domain: cstring; maxAge: uint64; includeSubdomains: bool): tdesc =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new(domain, maxAge, gboolean(includeSubdomains))

proc initHSTSPolicy*[T](result: var T; domain: cstring; maxAge: uint64; includeSubdomains: bool) {.deprecated.} =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new(domain, maxAge, gboolean(includeSubdomains))

proc soup_hsts_policy_get_domain(self: ptr HSTSPolicy00): cstring {.
    importc, libprag.}

proc getDomain*(self: HSTSPolicy): string =
  result = $soup_hsts_policy_get_domain(cast[ptr HSTSPolicy00](self.impl))

proc domain*(self: HSTSPolicy): string =
  result = $soup_hsts_policy_get_domain(cast[ptr HSTSPolicy00](self.impl))

proc soup_hsts_policy_includes_subdomains(self: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc includesSubdomains*(self: HSTSPolicy): bool =
  toBool(soup_hsts_policy_includes_subdomains(cast[ptr HSTSPolicy00](self.impl)))

proc soup_hsts_policy_is_expired(self: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc isExpired*(self: HSTSPolicy): bool =
  toBool(soup_hsts_policy_is_expired(cast[ptr HSTSPolicy00](self.impl)))

proc soup_hsts_policy_is_session_policy(self: ptr HSTSPolicy00): gboolean {.
    importc, libprag.}

proc isSessionPolicy*(self: HSTSPolicy): bool =
  toBool(soup_hsts_policy_is_session_policy(cast[ptr HSTSPolicy00](self.impl)))

type
  HSTSEnforcer* = ref object of gobject.Object
  HSTSEnforcer00* = object of gobject.Object00

proc soup_hsts_enforcer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HSTSEnforcer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChanged*(self: HSTSEnforcer;  p: proc (self: ptr HSTSEnforcer00; oldPolicy: ptr HSTSPolicy00; newPolicy: ptr HSTSPolicy00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc scHstsEnforced*(self: HSTSEnforcer;  p: proc (self: ptr HSTSEnforcer00; message: ptr Message00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "hsts-enforced", cast[GCallback](p), xdata, nil, cf)

proc soup_hsts_enforcer_new(): ptr HSTSEnforcer00 {.
    importc, libprag.}

proc newHSTSEnforcer*(): HSTSEnforcer =
  let gobj = soup_hsts_enforcer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHSTSEnforcer*(tdesc: typedesc): tdesc =
  assert(result is HSTSEnforcer)
  let gobj = soup_hsts_enforcer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHSTSEnforcer*[T](result: var T) {.deprecated.} =
  assert(result is HSTSEnforcer)
  let gobj = soup_hsts_enforcer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_hsts_enforcer_get_domains(self: ptr HSTSEnforcer00; sessionPolicies: gboolean): ptr glib.List {.
    importc, libprag.}

proc getDomains*(self: HSTSEnforcer; sessionPolicies: bool): seq[cstring] =
  let resul0 = soup_hsts_enforcer_get_domains(cast[ptr HSTSEnforcer00](self.impl), gboolean(sessionPolicies))
  g_list_free(resul0)

proc soup_hsts_enforcer_get_policies(self: ptr HSTSEnforcer00; sessionPolicies: gboolean): ptr glib.List {.
    importc, libprag.}

proc getPolicies*(self: HSTSEnforcer; sessionPolicies: bool): seq[HSTSPolicy] =
  let resul0 = soup_hsts_enforcer_get_policies(cast[ptr HSTSEnforcer00](self.impl), gboolean(sessionPolicies))
  result = glistStructs2seq[HSTSPolicy](resul0, false)
  g_list_free(resul0)

proc soup_hsts_enforcer_has_valid_policy(self: ptr HSTSEnforcer00; domain: cstring): gboolean {.
    importc, libprag.}

proc hasValidPolicy*(self: HSTSEnforcer; domain: cstring): bool =
  toBool(soup_hsts_enforcer_has_valid_policy(cast[ptr HSTSEnforcer00](self.impl), domain))

proc soup_hsts_enforcer_is_persistent(self: ptr HSTSEnforcer00): gboolean {.
    importc, libprag.}

proc isPersistent*(self: HSTSEnforcer): bool =
  toBool(soup_hsts_enforcer_is_persistent(cast[ptr HSTSEnforcer00](self.impl)))

proc soup_hsts_enforcer_set_policy(self: ptr HSTSEnforcer00; policy: ptr HSTSPolicy00) {.
    importc, libprag.}

proc setPolicy*(self: HSTSEnforcer; policy: HSTSPolicy) =
  soup_hsts_enforcer_set_policy(cast[ptr HSTSEnforcer00](self.impl), cast[ptr HSTSPolicy00](policy.impl))

proc `policy=`*(self: HSTSEnforcer; policy: HSTSPolicy) =
  soup_hsts_enforcer_set_policy(cast[ptr HSTSEnforcer00](self.impl), cast[ptr HSTSPolicy00](policy.impl))

proc soup_hsts_enforcer_set_session_policy(self: ptr HSTSEnforcer00; domain: cstring;
    includeSubdomains: gboolean) {.
    importc, libprag.}

proc setSessionPolicy*(self: HSTSEnforcer; domain: cstring;
    includeSubdomains: bool) =
  soup_hsts_enforcer_set_session_policy(cast[ptr HSTSEnforcer00](self.impl), domain, gboolean(includeSubdomains))

type
  ContentDecoder* = ref object of gobject.Object
  ContentDecoder00* = object of gobject.Object00

proc soup_content_decoder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContentDecoder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  HSTSEnforcerDB* = ref object of HSTSEnforcer
  HSTSEnforcerDB00* = object of HSTSEnforcer00

proc soup_hsts_enforcer_db_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HSTSEnforcerDB()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_hsts_enforcer_db_new(filename: cstring): ptr HSTSEnforcerDB00 {.
    importc, libprag.}

proc newHSTSEnforcerDB*(filename: cstring): HSTSEnforcerDB =
  let gobj = soup_hsts_enforcer_db_new(filename)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newHSTSEnforcerDB*(tdesc: typedesc; filename: cstring): tdesc =
  assert(result is HSTSEnforcerDB)
  let gobj = soup_hsts_enforcer_db_new(filename)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHSTSEnforcerDB*[T](result: var T; filename: cstring) {.deprecated.} =
  assert(result is HSTSEnforcerDB)
  let gobj = soup_hsts_enforcer_db_new(filename)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Cache* = ref object of gobject.Object
  Cache00* = object of gobject.Object00

proc soup_cache_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Cache()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_cache_clear(self: ptr Cache00) {.
    importc, libprag.}

proc clear*(self: Cache) =
  soup_cache_clear(cast[ptr Cache00](self.impl))

proc soup_cache_dump(self: ptr Cache00) {.
    importc, libprag.}

proc dump*(self: Cache) =
  soup_cache_dump(cast[ptr Cache00](self.impl))

proc soup_cache_flush(self: ptr Cache00) {.
    importc, libprag.}

proc flush*(self: Cache) =
  soup_cache_flush(cast[ptr Cache00](self.impl))

proc soup_cache_get_max_size(self: ptr Cache00): uint32 {.
    importc, libprag.}

proc getMaxSize*(self: Cache): int =
  int(soup_cache_get_max_size(cast[ptr Cache00](self.impl)))

proc maxSize*(self: Cache): int =
  int(soup_cache_get_max_size(cast[ptr Cache00](self.impl)))

proc soup_cache_load(self: ptr Cache00) {.
    importc, libprag.}

proc load*(self: Cache) =
  soup_cache_load(cast[ptr Cache00](self.impl))

proc soup_cache_set_max_size(self: ptr Cache00; maxSize: uint32) {.
    importc, libprag.}

proc setMaxSize*(self: Cache; maxSize: int) =
  soup_cache_set_max_size(cast[ptr Cache00](self.impl), uint32(maxSize))

proc `maxSize=`*(self: Cache; maxSize: int) =
  soup_cache_set_max_size(cast[ptr Cache00](self.impl), uint32(maxSize))

type
  Requester* = ref object of gobject.Object
  Requester00* = object of gobject.Object00

proc soup_requester_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Requester()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_requester_new(): ptr Requester00 {.
    importc, libprag.}

proc newRequester*(): Requester =
  let gobj = soup_requester_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRequester*(tdesc: typedesc): tdesc =
  assert(result is Requester)
  let gobj = soup_requester_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRequester*[T](result: var T) {.deprecated.} =
  assert(result is Requester)
  let gobj = soup_requester_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_requester_request(self: ptr Requester00; uriString: cstring; error: ptr ptr glib.Error = nil): ptr Request00 {.
    importc, libprag.}

proc request*(self: Requester; uriString: cstring): Request =
  var gerror: ptr glib.Error
  let gobj = soup_requester_request(cast[ptr Requester00](self.impl), uriString, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_requester_request_uri(self: ptr Requester00; uri: ptr URI00; error: ptr ptr glib.Error = nil): ptr Request00 {.
    importc, libprag.}

proc requestUri*(self: Requester; uri: URI): Request =
  var gerror: ptr glib.Error
  let gobj = soup_requester_request_uri(cast[ptr Requester00](self.impl), cast[ptr URI00](uri.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Logger* = ref object of gobject.Object
  Logger00* = object of gobject.Object00

proc soup_logger_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Logger()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_logger_attach(self: ptr Logger00; session: ptr Session00) {.
    importc, libprag.}

proc attach*(self: Logger; session: Session) =
  soup_logger_attach(cast[ptr Logger00](self.impl), cast[ptr Session00](session.impl))

proc soup_logger_detach(self: ptr Logger00; session: ptr Session00) {.
    importc, libprag.}

proc detach*(self: Logger; session: Session) =
  soup_logger_detach(cast[ptr Logger00](self.impl), cast[ptr Session00](session.impl))

proc soup_session_add_feature(self: ptr Session00; feature: ptr SessionFeature00) {.
    importc, libprag.}

proc addFeature*(self: Session; feature: SessionFeature | AuthManager | CookieJarText | WebsocketExtensionManager | ContentSniffer | ProxyResolverDefault | CookieJarDB | HSTSEnforcer | ContentDecoder | CookieJar | HSTSEnforcerDB | Cache | Requester | Logger) =
  soup_session_add_feature(cast[ptr Session00](self.impl), cast[ptr SessionFeature00](feature.impl))

proc soup_session_remove_feature(self: ptr Session00; feature: ptr SessionFeature00) {.
    importc, libprag.}

proc removeFeature*(self: Session; feature: SessionFeature | AuthManager | CookieJarText | WebsocketExtensionManager | ContentSniffer | ProxyResolverDefault | CookieJarDB | HSTSEnforcer | ContentDecoder | CookieJar | HSTSEnforcerDB | Cache | Requester | Logger) =
  soup_session_remove_feature(cast[ptr Session00](self.impl), cast[ptr SessionFeature00](feature.impl))

proc soup_session_feature_add_feature(self: ptr SessionFeature00; `type`: GType): gboolean {.
    importc, libprag.}

proc addFeature*(self: SessionFeature | AuthManager | CookieJarText | WebsocketExtensionManager | ContentSniffer | ProxyResolverDefault | CookieJarDB | HSTSEnforcer | ContentDecoder | CookieJar | HSTSEnforcerDB | Cache | Requester | Logger;
    `type`: GType): bool =
  toBool(soup_session_feature_add_feature(cast[ptr SessionFeature00](self.impl), `type`))

proc soup_session_feature_attach(self: ptr SessionFeature00; session: ptr Session00) {.
    importc, libprag.}

proc attach*(self: SessionFeature | AuthManager | CookieJarText | WebsocketExtensionManager | ContentSniffer | ProxyResolverDefault | CookieJarDB | HSTSEnforcer | ContentDecoder | CookieJar | HSTSEnforcerDB | Cache | Requester | Logger;
    session: Session) =
  soup_session_feature_attach(cast[ptr SessionFeature00](self.impl), cast[ptr Session00](session.impl))

proc soup_session_feature_detach(self: ptr SessionFeature00; session: ptr Session00) {.
    importc, libprag.}

proc detach*(self: SessionFeature | AuthManager | CookieJarText | WebsocketExtensionManager | ContentSniffer | ProxyResolverDefault | CookieJarDB | HSTSEnforcer | ContentDecoder | CookieJar | HSTSEnforcerDB | Cache | Requester | Logger;
    session: Session) =
  soup_session_feature_detach(cast[ptr SessionFeature00](self.impl), cast[ptr Session00](session.impl))

proc soup_session_feature_has_feature(self: ptr SessionFeature00; `type`: GType): gboolean {.
    importc, libprag.}

proc hasFeature*(self: SessionFeature | AuthManager | CookieJarText | WebsocketExtensionManager | ContentSniffer | ProxyResolverDefault | CookieJarDB | HSTSEnforcer | ContentDecoder | CookieJar | HSTSEnforcerDB | Cache | Requester | Logger;
    `type`: GType): bool =
  toBool(soup_session_feature_has_feature(cast[ptr SessionFeature00](self.impl), `type`))

proc soup_session_feature_remove_feature(self: ptr SessionFeature00; `type`: GType): gboolean {.
    importc, libprag.}

proc removeFeature*(self: SessionFeature | AuthManager | CookieJarText | WebsocketExtensionManager | ContentSniffer | ProxyResolverDefault | CookieJarDB | HSTSEnforcer | ContentDecoder | CookieJar | HSTSEnforcerDB | Cache | Requester | Logger;
    `type`: GType): bool =
  toBool(soup_session_feature_remove_feature(cast[ptr SessionFeature00](self.impl), `type`))

type
  LoggerLogLevel* {.size: sizeof(cint), pure.} = enum
    none = 0
    minimal = 1
    headers = 2
    body = 3

proc soup_logger_new(level: LoggerLogLevel; maxBodySize: int32): ptr Logger00 {.
    importc, libprag.}

proc newLogger*(level: LoggerLogLevel; maxBodySize: int): Logger =
  let gobj = soup_logger_new(level, int32(maxBodySize))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newLogger*(tdesc: typedesc; level: LoggerLogLevel; maxBodySize: int): tdesc =
  assert(result is Logger)
  let gobj = soup_logger_new(level, int32(maxBodySize))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initLogger*[T](result: var T; level: LoggerLogLevel; maxBodySize: int) {.deprecated.} =
  assert(result is Logger)
  let gobj = soup_logger_new(level, int32(maxBodySize))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  CacheType* {.size: sizeof(cint), pure.} = enum
    singleUser = 0
    shared = 1

proc soup_cache_new(cacheDir: cstring; cacheType: CacheType): ptr Cache00 {.
    importc, libprag.}

proc newCache*(cacheDir: cstring = nil; cacheType: CacheType): Cache =
  let gobj = soup_cache_new(cacheDir, cacheType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCache*(tdesc: typedesc; cacheDir: cstring = nil; cacheType: CacheType): tdesc =
  assert(result is Cache)
  let gobj = soup_cache_new(cacheDir, cacheType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCache*[T](result: var T; cacheDir: cstring = nil; cacheType: CacheType) {.deprecated.} =
  assert(result is Cache)
  let gobj = soup_cache_new(cacheDir, cacheType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Date00* {.pure.} = object
  Date* = ref object
    impl*: ptr Date00
    ignoreFinalizer*: bool

proc soup_date_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupDate*(self: Date) =
  if not self.ignoreFinalizer:
    boxedFree(soup_date_get_type(), cast[ptr Date00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Date()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_date_get_type(), cast[ptr Date00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Date) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupDate)

proc soup_date_free(self: ptr Date00) {.
    importc, libprag.}

proc free*(self: Date) =
  soup_date_free(cast[ptr Date00](self.impl))

proc finalizerfree*(self: Date) =
  if not self.ignoreFinalizer:
    soup_date_free(cast[ptr Date00](self.impl))

proc soup_date_new_from_now(offsetSeconds: int32): ptr Date00 {.
    importc, libprag.}

proc newDateFromNow*(offsetSeconds: int): Date =
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new_from_now(int32(offsetSeconds))

proc newDateFromNow*(tdesc: typedesc; offsetSeconds: int): tdesc =
  assert(result is Date)
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new_from_now(int32(offsetSeconds))

proc initDateFromNow*[T](result: var T; offsetSeconds: int) {.deprecated.} =
  assert(result is Date)
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new_from_now(int32(offsetSeconds))

proc soup_date_new_from_string(dateString: cstring): ptr Date00 {.
    importc, libprag.}

proc newDateFromString*(dateString: cstring): Date =
  let impl0 = soup_date_new_from_string(dateString)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupDate)
  result.impl = impl0

proc newDateFromString*(tdesc: typedesc; dateString: cstring): tdesc =
  assert(result is Date)
  let impl0 = soup_date_new_from_string(dateString)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupDate)
  result.impl = impl0

proc initDateFromString*[T](result: var T; dateString: cstring) {.deprecated.} =
  assert(result is Date)
  let impl0 = soup_date_new_from_string(dateString)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupDate)
  result.impl = impl0

proc soup_date_new_from_time_t(`when`: int64): ptr Date00 {.
    importc, libprag.}

proc newDateFromTimeT*(`when`: int64): Date =
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new_from_time_t(`when`)

proc newDateFromTimeT*(tdesc: typedesc; `when`: int64): tdesc =
  assert(result is Date)
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new_from_time_t(`when`)

proc initDateFromTimeT*[T](result: var T; `when`: int64) {.deprecated.} =
  assert(result is Date)
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new_from_time_t(`when`)

proc soup_date_copy(self: ptr Date00): ptr Date00 {.
    importc, libprag.}

proc copy*(self: Date): Date =
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_copy(cast[ptr Date00](self.impl))

proc soup_date_new(year: int32; month: int32; day: int32; hour: int32; minute: int32;
    second: int32): ptr Date00 {.
    importc, libprag.}

proc newDate*(year: int; month: int; day: int; hour: int; minute: int;
    second: int): Date =
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new(int32(year), int32(month), int32(day), int32(hour), int32(minute), int32(second))

proc newDate*(tdesc: typedesc; year: int; month: int; day: int; hour: int; minute: int;
    second: int): tdesc =
  assert(result is Date)
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new(int32(year), int32(month), int32(day), int32(hour), int32(minute), int32(second))

proc initDate*[T](result: var T; year: int; month: int; day: int; hour: int; minute: int;
    second: int) {.deprecated.} =
  assert(result is Date)
  fnew(result, gBoxedFreeSoupDate)
  result.impl = soup_date_new(int32(year), int32(month), int32(day), int32(hour), int32(minute), int32(second))

proc soup_date_get_day(self: ptr Date00): int32 {.
    importc, libprag.}

proc getDay*(self: Date): int =
  int(soup_date_get_day(cast[ptr Date00](self.impl)))

proc day*(self: Date): int =
  int(soup_date_get_day(cast[ptr Date00](self.impl)))

proc soup_date_get_hour(self: ptr Date00): int32 {.
    importc, libprag.}

proc getHour*(self: Date): int =
  int(soup_date_get_hour(cast[ptr Date00](self.impl)))

proc hour*(self: Date): int =
  int(soup_date_get_hour(cast[ptr Date00](self.impl)))

proc soup_date_get_minute(self: ptr Date00): int32 {.
    importc, libprag.}

proc getMinute*(self: Date): int =
  int(soup_date_get_minute(cast[ptr Date00](self.impl)))

proc minute*(self: Date): int =
  int(soup_date_get_minute(cast[ptr Date00](self.impl)))

proc soup_date_get_month(self: ptr Date00): int32 {.
    importc, libprag.}

proc getMonth*(self: Date): int =
  int(soup_date_get_month(cast[ptr Date00](self.impl)))

proc month*(self: Date): int =
  int(soup_date_get_month(cast[ptr Date00](self.impl)))

proc soup_date_get_offset(self: ptr Date00): int32 {.
    importc, libprag.}

proc getOffset*(self: Date): int =
  int(soup_date_get_offset(cast[ptr Date00](self.impl)))

proc offset*(self: Date): int =
  int(soup_date_get_offset(cast[ptr Date00](self.impl)))

proc soup_date_get_second(self: ptr Date00): int32 {.
    importc, libprag.}

proc getSecond*(self: Date): int =
  int(soup_date_get_second(cast[ptr Date00](self.impl)))

proc second*(self: Date): int =
  int(soup_date_get_second(cast[ptr Date00](self.impl)))

proc soup_date_get_utc(self: ptr Date00): int32 {.
    importc, libprag.}

proc getUtc*(self: Date): int =
  int(soup_date_get_utc(cast[ptr Date00](self.impl)))

proc utc*(self: Date): int =
  int(soup_date_get_utc(cast[ptr Date00](self.impl)))

proc soup_date_get_year(self: ptr Date00): int32 {.
    importc, libprag.}

proc getYear*(self: Date): int =
  int(soup_date_get_year(cast[ptr Date00](self.impl)))

proc year*(self: Date): int =
  int(soup_date_get_year(cast[ptr Date00](self.impl)))

proc soup_date_is_past(self: ptr Date00): gboolean {.
    importc, libprag.}

proc isPast*(self: Date): bool =
  toBool(soup_date_is_past(cast[ptr Date00](self.impl)))

proc soup_date_to_time_t(self: ptr Date00): int64 {.
    importc, libprag.}

proc toTimeT*(self: Date): int64 =
  soup_date_to_time_t(cast[ptr Date00](self.impl))

proc soup_date_to_timeval(self: ptr Date00; time: var glib.TimeVal) {.
    importc, libprag.}

proc toTimeval*(self: Date; time: var glib.TimeVal) =
  soup_date_to_timeval(cast[ptr Date00](self.impl), time)

proc toTimeval*(self: Date): glib.TimeVal =
  soup_date_to_timeval(cast[ptr Date00](self.impl), result)

proc soup_cookie_get_expires(self: ptr Cookie00): ptr Date00 {.
    importc, libprag.}

proc getExpires*(self: Cookie): Date =
  let impl0 = soup_cookie_get_expires(cast[ptr Cookie00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupDate)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_date_get_type(), impl0))

proc expires*(self: Cookie): Date =
  let impl0 = soup_cookie_get_expires(cast[ptr Cookie00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupDate)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_date_get_type(), impl0))

proc soup_cookie_set_expires(self: ptr Cookie00; expires: ptr Date00) {.
    importc, libprag.}

proc setExpires*(self: Cookie; expires: Date) =
  soup_cookie_set_expires(cast[ptr Cookie00](self.impl), cast[ptr Date00](expires.impl))

proc `expires=`*(self: Cookie; expires: Date) =
  soup_cookie_set_expires(cast[ptr Cookie00](self.impl), cast[ptr Date00](expires.impl))

proc soup_hsts_policy_new_full(domain: cstring; maxAge: uint64; expires: ptr Date00;
    includeSubdomains: gboolean): ptr HSTSPolicy00 {.
    importc, libprag.}

proc newHSTSPolicyFull*(domain: cstring; maxAge: uint64; expires: Date;
    includeSubdomains: bool): HSTSPolicy =
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_full(domain, maxAge, cast[ptr Date00](expires.impl), gboolean(includeSubdomains))

proc newHSTSPolicyFull*(tdesc: typedesc; domain: cstring; maxAge: uint64; expires: Date;
    includeSubdomains: bool): tdesc =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_full(domain, maxAge, cast[ptr Date00](expires.impl), gboolean(includeSubdomains))

proc initHSTSPolicyFull*[T](result: var T; domain: cstring; maxAge: uint64; expires: Date;
    includeSubdomains: bool) {.deprecated.} =
  assert(result is HSTSPolicy)
  fnew(result, gBoxedFreeSoupHSTSPolicy)
  result.impl = soup_hsts_policy_new_full(domain, maxAge, cast[ptr Date00](expires.impl), gboolean(includeSubdomains))

type
  DateFormat* {.size: sizeof(cint), pure.} = enum
    http = 1
    cookie = 2
    rfc2822 = 3
    iso8601Compact = 4
    iso8601 = 5
    iso8601Xmlrpc = 6

const
  DateFormatIso8601Full* = DateFormat.iso8601

proc soup_date_to_string(self: ptr Date00; format: DateFormat): cstring {.
    importc, libprag.}

proc toString*(self: Date; format: DateFormat): string =
  let resul0 = soup_date_to_string(cast[ptr Date00](self.impl), format)
  result = $resul0
  cogfree(resul0)

type
  SameSitePolicy* {.size: sizeof(cint), pure.} = enum
    none = 0
    lax = 1
    strict = 2

proc soup_cookie_get_same_site_policy(self: ptr Cookie00): SameSitePolicy {.
    importc, libprag.}

proc getSameSitePolicy*(self: Cookie): SameSitePolicy =
  soup_cookie_get_same_site_policy(cast[ptr Cookie00](self.impl))

proc sameSitePolicy*(self: Cookie): SameSitePolicy =
  soup_cookie_get_same_site_policy(cast[ptr Cookie00](self.impl))

proc soup_cookie_set_same_site_policy(self: ptr Cookie00; policy: SameSitePolicy) {.
    importc, libprag.}

proc setSameSitePolicy*(self: Cookie; policy: SameSitePolicy) =
  soup_cookie_set_same_site_policy(cast[ptr Cookie00](self.impl), policy)

proc `sameSitePolicy=`*(self: Cookie; policy: SameSitePolicy) =
  soup_cookie_set_same_site_policy(cast[ptr Cookie00](self.impl), policy)

type
  CookieJarAcceptPolicy* {.size: sizeof(cint), pure.} = enum
    always = 0
    never = 1
    noThirdParty = 2
    grandfatheredThirdParty = 3

proc soup_cookie_jar_get_accept_policy(self: ptr CookieJar00): CookieJarAcceptPolicy {.
    importc, libprag.}

proc getAcceptPolicy*(self: CookieJar): CookieJarAcceptPolicy =
  soup_cookie_jar_get_accept_policy(cast[ptr CookieJar00](self.impl))

proc acceptPolicy*(self: CookieJar): CookieJarAcceptPolicy =
  soup_cookie_jar_get_accept_policy(cast[ptr CookieJar00](self.impl))

proc soup_cookie_jar_set_accept_policy(self: ptr CookieJar00; policy: CookieJarAcceptPolicy) {.
    importc, libprag.}

proc setAcceptPolicy*(self: CookieJar; policy: CookieJarAcceptPolicy) =
  soup_cookie_jar_set_accept_policy(cast[ptr CookieJar00](self.impl), policy)

proc `acceptPolicy=`*(self: CookieJar; policy: CookieJarAcceptPolicy) =
  soup_cookie_jar_set_accept_policy(cast[ptr CookieJar00](self.impl), policy)

type
  RequestHTTP* = ref object of Request
  RequestHTTP00* = object of Request00

proc soup_request_http_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RequestHTTP()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_request_http_get_message(self: ptr RequestHTTP00): ptr Message00 {.
    importc, libprag.}

proc getMessage*(self: RequestHTTP): Message =
  let gobj = soup_request_http_get_message(cast[ptr RequestHTTP00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc message*(self: RequestHTTP): Message =
  let gobj = soup_request_http_get_message(cast[ptr RequestHTTP00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_session_request_http(self: ptr Session00; `method`: cstring; uriString: cstring;
    error: ptr ptr glib.Error = nil): ptr RequestHTTP00 {.
    importc, libprag.}

proc requestHttp*(self: Session; `method`: cstring; uriString: cstring): RequestHTTP =
  var gerror: ptr glib.Error
  let gobj = soup_session_request_http(cast[ptr Session00](self.impl), `method`, uriString, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_session_request_http_uri(self: ptr Session00; `method`: cstring;
    uri: ptr URI00; error: ptr ptr glib.Error = nil): ptr RequestHTTP00 {.
    importc, libprag.}

proc requestHttpUri*(self: Session; `method`: cstring; uri: URI): RequestHTTP =
  var gerror: ptr glib.Error
  let gobj = soup_session_request_http_uri(cast[ptr Session00](self.impl), `method`, cast[ptr URI00](uri.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  WebsocketConnection* = ref object of gobject.Object
  WebsocketConnection00* = object of gobject.Object00

proc soup_websocket_connection_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketConnection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scClosed*(self: WebsocketConnection;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cf)

proc scClosing*(self: WebsocketConnection;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "closing", cast[GCallback](p), xdata, nil, cf)

proc scError*(self: WebsocketConnection;  p: proc (self: ptr WebsocketConnection00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "error", cast[GCallback](p), xdata, nil, cf)

proc scMessage*(self: WebsocketConnection;  p: proc (self: ptr WebsocketConnection00; `type`: int32; message: ptr glib.Bytes00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "message", cast[GCallback](p), xdata, nil, cf)

proc scPong*(self: WebsocketConnection;  p: proc (self: ptr WebsocketConnection00; message: ptr glib.Bytes00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pong", cast[GCallback](p), xdata, nil, cf)

proc soup_websocket_connection_close(self: ptr WebsocketConnection00; code: uint16;
    data: cstring) {.
    importc, libprag.}

proc close*(self: WebsocketConnection; code: uint16;
    data: cstring = nil) =
  soup_websocket_connection_close(cast[ptr WebsocketConnection00](self.impl), code, data)

proc soup_websocket_connection_get_close_code(self: ptr WebsocketConnection00): uint16 {.
    importc, libprag.}

proc getCloseCode*(self: WebsocketConnection): uint16 =
  soup_websocket_connection_get_close_code(cast[ptr WebsocketConnection00](self.impl))

proc closeCode*(self: WebsocketConnection): uint16 =
  soup_websocket_connection_get_close_code(cast[ptr WebsocketConnection00](self.impl))

proc soup_websocket_connection_get_close_data(self: ptr WebsocketConnection00): cstring {.
    importc, libprag.}

proc getCloseData*(self: WebsocketConnection): string =
  result = $soup_websocket_connection_get_close_data(cast[ptr WebsocketConnection00](self.impl))

proc closeData*(self: WebsocketConnection): string =
  result = $soup_websocket_connection_get_close_data(cast[ptr WebsocketConnection00](self.impl))

proc soup_websocket_connection_get_io_stream(self: ptr WebsocketConnection00): ptr gio.IOStream00 {.
    importc, libprag.}

proc getIoStream*(self: WebsocketConnection): gio.IOStream =
  let gobj = soup_websocket_connection_get_io_stream(cast[ptr WebsocketConnection00](self.impl))
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

proc ioStream*(self: WebsocketConnection): gio.IOStream =
  let gobj = soup_websocket_connection_get_io_stream(cast[ptr WebsocketConnection00](self.impl))
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

proc soup_websocket_connection_get_keepalive_interval(self: ptr WebsocketConnection00): uint32 {.
    importc, libprag.}

proc getKeepaliveInterval*(self: WebsocketConnection): int =
  int(soup_websocket_connection_get_keepalive_interval(cast[ptr WebsocketConnection00](self.impl)))

proc keepaliveInterval*(self: WebsocketConnection): int =
  int(soup_websocket_connection_get_keepalive_interval(cast[ptr WebsocketConnection00](self.impl)))

proc soup_websocket_connection_get_max_incoming_payload_size(self: ptr WebsocketConnection00): uint64 {.
    importc, libprag.}

proc getMaxIncomingPayloadSize*(self: WebsocketConnection): uint64 =
  soup_websocket_connection_get_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl))

proc maxIncomingPayloadSize*(self: WebsocketConnection): uint64 =
  soup_websocket_connection_get_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl))

proc soup_websocket_connection_get_origin(self: ptr WebsocketConnection00): cstring {.
    importc, libprag.}

proc getOrigin*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_origin(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc origin*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_origin(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_websocket_connection_get_protocol(self: ptr WebsocketConnection00): cstring {.
    importc, libprag.}

proc getProtocol*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_protocol(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc protocol*(self: WebsocketConnection): string =
  let resul0 = soup_websocket_connection_get_protocol(cast[ptr WebsocketConnection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_websocket_connection_get_uri(self: ptr WebsocketConnection00): ptr URI00 {.
    importc, libprag.}

proc getUri*(self: WebsocketConnection): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_websocket_connection_get_uri(cast[ptr WebsocketConnection00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc uri*(self: WebsocketConnection): URI =
  fnew(result, gBoxedFreeSoupURI)
  result.impl = soup_websocket_connection_get_uri(cast[ptr WebsocketConnection00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_uri_get_type(), result.impl))

proc soup_websocket_connection_send_binary(self: ptr WebsocketConnection00;
    data: ptr uint8; length: uint64) {.
    importc, libprag.}

proc sendBinary*(self: WebsocketConnection; data: seq[uint8] | string) =
  let length = uint64(data.len)
  soup_websocket_connection_send_binary(cast[ptr WebsocketConnection00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

proc soup_websocket_connection_send_text(self: ptr WebsocketConnection00;
    text: cstring) {.
    importc, libprag.}

proc sendText*(self: WebsocketConnection; text: cstring) =
  soup_websocket_connection_send_text(cast[ptr WebsocketConnection00](self.impl), text)

proc soup_websocket_connection_set_keepalive_interval(self: ptr WebsocketConnection00;
    interval: uint32) {.
    importc, libprag.}

proc setKeepaliveInterval*(self: WebsocketConnection;
    interval: int) =
  soup_websocket_connection_set_keepalive_interval(cast[ptr WebsocketConnection00](self.impl), uint32(interval))

proc `keepaliveInterval=`*(self: WebsocketConnection;
    interval: int) =
  soup_websocket_connection_set_keepalive_interval(cast[ptr WebsocketConnection00](self.impl), uint32(interval))

proc soup_websocket_connection_set_max_incoming_payload_size(self: ptr WebsocketConnection00;
    maxIncomingPayloadSize: uint64) {.
    importc, libprag.}

proc setMaxIncomingPayloadSize*(self: WebsocketConnection;
    maxIncomingPayloadSize: uint64) =
  soup_websocket_connection_set_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl), maxIncomingPayloadSize)

proc `maxIncomingPayloadSize=`*(self: WebsocketConnection;
    maxIncomingPayloadSize: uint64) =
  soup_websocket_connection_set_max_incoming_payload_size(cast[ptr WebsocketConnection00](self.impl), maxIncomingPayloadSize)

proc soup_session_websocket_connect_finish(self: ptr Session00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr WebsocketConnection00 {.
    importc, libprag.}

proc websocketConnectFinish*(self: Session; resu: gio.AsyncResult): WebsocketConnection =
  var gerror: ptr glib.Error
  let gobj = soup_session_websocket_connect_finish(cast[ptr Session00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  WebsocketConnectionType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    client = 1
    server = 2

proc soup_websocket_connection_new(stream: ptr gio.IOStream00; uri: ptr URI00;
    `type`: WebsocketConnectionType; origin: cstring; protocol: cstring): ptr WebsocketConnection00 {.
    importc, libprag.}

proc newWebsocketConnection*(stream: gio.IOStream; uri: URI; `type`: WebsocketConnectionType;
    origin: cstring = nil; protocol: cstring = nil): WebsocketConnection =
  let gobj = soup_websocket_connection_new(cast[ptr gio.IOStream00](stream.impl), cast[ptr URI00](uri.impl), `type`, origin, protocol)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebsocketConnection*(tdesc: typedesc; stream: gio.IOStream; uri: URI; `type`: WebsocketConnectionType;
    origin: cstring = nil; protocol: cstring = nil): tdesc =
  assert(result is WebsocketConnection)
  let gobj = soup_websocket_connection_new(cast[ptr gio.IOStream00](stream.impl), cast[ptr URI00](uri.impl), `type`, origin, protocol)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebsocketConnection*[T](result: var T; stream: gio.IOStream; uri: URI; `type`: WebsocketConnectionType;
    origin: cstring = nil; protocol: cstring = nil) {.deprecated.} =
  assert(result is WebsocketConnection)
  let gobj = soup_websocket_connection_new(cast[ptr gio.IOStream00](stream.impl), cast[ptr URI00](uri.impl), `type`, origin, protocol)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_websocket_connection_get_connection_type(self: ptr WebsocketConnection00): WebsocketConnectionType {.
    importc, libprag.}

proc getConnectionType*(self: WebsocketConnection): WebsocketConnectionType =
  soup_websocket_connection_get_connection_type(cast[ptr WebsocketConnection00](self.impl))

proc connectionType*(self: WebsocketConnection): WebsocketConnectionType =
  soup_websocket_connection_get_connection_type(cast[ptr WebsocketConnection00](self.impl))

type
  WebsocketExtension* = ref object of gobject.Object
  WebsocketExtension00* = object of gobject.Object00

proc soup_websocket_extension_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketExtension()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_websocket_extension_configure(self: ptr WebsocketExtension00; connectionType: WebsocketConnectionType;
    params: ptr HashTable00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc configure*(self: WebsocketExtension; connectionType: WebsocketConnectionType;
    params: ptr HashTable00): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_extension_configure(cast[ptr WebsocketExtension00](self.impl), connectionType, params, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_extension_get_request_params(self: ptr WebsocketExtension00): cstring {.
    importc, libprag.}

proc getRequestParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_request_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc requestParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_request_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_websocket_extension_get_response_params(self: ptr WebsocketExtension00): cstring {.
    importc, libprag.}

proc getResponseParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_response_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc responseParams*(self: WebsocketExtension): string =
  let resul0 = soup_websocket_extension_get_response_params(cast[ptr WebsocketExtension00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_websocket_extension_process_incoming_message(self: ptr WebsocketExtension00;
    header: var uint8; payload: ptr glib.Bytes00; error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc processIncomingMessage*(self: WebsocketExtension;
    header: var uint8; payload: glib.Bytes): glib.Bytes =
  var gerror: ptr glib.Error
  let impl0 = soup_websocket_extension_process_incoming_message(cast[ptr WebsocketExtension00](self.impl), header, cast[ptr glib.Bytes00](g_boxed_copy(g_bytes_get_type(), payload.impl)), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc soup_websocket_extension_process_outgoing_message(self: ptr WebsocketExtension00;
    header: var uint8; payload: ptr glib.Bytes00; error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc processOutgoingMessage*(self: WebsocketExtension;
    header: var uint8; payload: glib.Bytes): glib.Bytes =
  var gerror: ptr glib.Error
  let impl0 = soup_websocket_extension_process_outgoing_message(cast[ptr WebsocketExtension00](self.impl), header, cast[ptr glib.Bytes00](g_boxed_copy(g_bytes_get_type(), payload.impl)), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc soup_websocket_connection_new_with_extensions(stream: ptr gio.IOStream00;
    uri: ptr URI00; `type`: WebsocketConnectionType; origin: cstring; protocol: cstring;
    extensions: ptr glib.List): ptr WebsocketConnection00 {.
    importc, libprag.}

proc newWebsocketConnectionWithExtensions*(stream: gio.IOStream;
    uri: URI; `type`: WebsocketConnectionType; origin: cstring = nil; protocol: cstring = nil;
    extensions: seq[WebsocketExtension]): WebsocketConnection =
  var tempResGL = seq2GList(extensions)
  let gobj = soup_websocket_connection_new_with_extensions(cast[ptr gio.IOStream00](stream.impl), cast[ptr URI00](uri.impl), `type`, origin, protocol, tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWebsocketConnectionWithExtensions*(tdesc: typedesc; stream: gio.IOStream;
    uri: URI; `type`: WebsocketConnectionType; origin: cstring = nil; protocol: cstring = nil;
    extensions: seq[WebsocketExtension]): tdesc =
  assert(result is WebsocketConnection)
  var tempResGL = seq2GList(extensions)
  let gobj = soup_websocket_connection_new_with_extensions(cast[ptr gio.IOStream00](stream.impl), cast[ptr URI00](uri.impl), `type`, origin, protocol, tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWebsocketConnectionWithExtensions*[T](result: var T; stream: gio.IOStream;
    uri: URI; `type`: WebsocketConnectionType; origin: cstring = nil; protocol: cstring = nil;
    extensions: seq[WebsocketExtension]) {.deprecated.} =
  assert(result is WebsocketConnection)
  var tempResGL = seq2GList(extensions)
  let gobj = soup_websocket_connection_new_with_extensions(cast[ptr gio.IOStream00](stream.impl), cast[ptr URI00](uri.impl), `type`, origin, protocol, tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_websocket_connection_get_extensions(self: ptr WebsocketConnection00): ptr glib.List {.
    importc, libprag.}

proc getExtensions*(self: WebsocketConnection): seq[WebsocketExtension] =
  result = glistObjects2seq(WebsocketExtension, soup_websocket_connection_get_extensions(cast[ptr WebsocketConnection00](self.impl)), false)

proc extensions*(self: WebsocketConnection): seq[WebsocketExtension] =
  result = glistObjects2seq(WebsocketExtension, soup_websocket_connection_get_extensions(cast[ptr WebsocketConnection00](self.impl)), false)

type
  WebsocketState* {.size: sizeof(cint), pure.} = enum
    open = 1
    closing = 2
    closed = 3

proc soup_websocket_connection_get_state(self: ptr WebsocketConnection00): WebsocketState {.
    importc, libprag.}

proc getState*(self: WebsocketConnection): WebsocketState =
  soup_websocket_connection_get_state(cast[ptr WebsocketConnection00](self.impl))

proc state*(self: WebsocketConnection): WebsocketState =
  soup_websocket_connection_get_state(cast[ptr WebsocketConnection00](self.impl))

type
  WebsocketDataType* {.size: sizeof(cint), pure.} = enum
    text = 1
    binary = 2

proc soup_websocket_connection_send_message(self: ptr WebsocketConnection00;
    `type`: WebsocketDataType; message: ptr glib.Bytes00) {.
    importc, libprag.}

proc sendMessage*(self: WebsocketConnection; `type`: WebsocketDataType;
    message: glib.Bytes) =
  soup_websocket_connection_send_message(cast[ptr WebsocketConnection00](self.impl), `type`, cast[ptr glib.Bytes00](message.impl))

type
  MessageFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    noRedirect = 1
    canRebuild = 2
    overwriteChunks = 3
    contentDecoded = 4
    certificateTrusted = 5
    newConnection = 6
    idempotent = 7
    ignoreConnectionLimits = 8
    doNotUseAuthCache = 9

  MessageFlags* {.size: sizeof(cint).} = set[MessageFlag]

proc soup_message_get_flags(self: ptr Message00): MessageFlags {.
    importc, libprag.}

proc getFlags*(self: Message): MessageFlags =
  soup_message_get_flags(cast[ptr Message00](self.impl))

proc flags*(self: Message): MessageFlags =
  soup_message_get_flags(cast[ptr Message00](self.impl))

proc soup_message_set_flags(self: ptr Message00; flags: MessageFlags) {.
    importc, libprag.}

proc setFlags*(self: Message; flags: MessageFlags) =
  soup_message_set_flags(cast[ptr Message00](self.impl), flags)

proc `flags=`*(self: Message; flags: MessageFlags) =
  soup_message_set_flags(cast[ptr Message00](self.impl), flags)

type
  HTTPVersion* {.size: sizeof(cint), pure.} = enum
    http_1_0 = 0
    http_1_1 = 1

proc soup_message_get_http_version(self: ptr Message00): HTTPVersion {.
    importc, libprag.}

proc getHttpVersion*(self: Message): HTTPVersion =
  soup_message_get_http_version(cast[ptr Message00](self.impl))

proc httpVersion*(self: Message): HTTPVersion =
  soup_message_get_http_version(cast[ptr Message00](self.impl))

proc soup_message_set_http_version(self: ptr Message00; version: HTTPVersion) {.
    importc, libprag.}

proc setHttpVersion*(self: Message; version: HTTPVersion) =
  soup_message_set_http_version(cast[ptr Message00](self.impl), version)

proc `httpVersion=`*(self: Message; version: HTTPVersion) =
  soup_message_set_http_version(cast[ptr Message00](self.impl), version)

type
  MessagePriority* {.size: sizeof(cint), pure.} = enum
    veryLow = 0
    low = 1
    normal = 2
    high = 3
    veryHigh = 4

proc soup_message_get_priority(self: ptr Message00): MessagePriority {.
    importc, libprag.}

proc getPriority*(self: Message): MessagePriority =
  soup_message_get_priority(cast[ptr Message00](self.impl))

proc priority*(self: Message): MessagePriority =
  soup_message_get_priority(cast[ptr Message00](self.impl))

proc soup_message_set_priority(self: ptr Message00; priority: MessagePriority) {.
    importc, libprag.}

proc setPriority*(self: Message; priority: MessagePriority) =
  soup_message_set_priority(cast[ptr Message00](self.impl), priority)

proc `priority=`*(self: Message; priority: MessagePriority) =
  soup_message_set_priority(cast[ptr Message00](self.impl), priority)

type
  MemoryUse* {.size: sizeof(cint), pure.} = enum
    `static` = 0
    take = 1
    copy = 2
    temporary = 3

proc soup_message_set_request(self: ptr Message00; contentType: cstring;
    reqUse: MemoryUse; reqBody: ptr uint8; reqLength: uint64) {.
    importc, libprag.}

proc setRequest*(self: Message; contentType: cstring = nil;
    reqUse: MemoryUse; reqBody: seq[uint8] | string) =
  let reqLength = uint64(reqBody.len)
  soup_message_set_request(cast[ptr Message00](self.impl), contentType, reqUse, cast[ptr uint8](unsafeaddr(reqBody[0])), reqLength)

proc soup_message_set_response(self: ptr Message00; contentType: cstring;
    respUse: MemoryUse; respBody: ptr uint8; respLength: uint64) {.
    importc, libprag.}

proc setResponse*(self: Message; contentType: cstring = nil;
    respUse: MemoryUse; respBody: seq[uint8] | string) =
  let respLength = uint64(respBody.len)
  soup_message_set_response(cast[ptr Message00](self.impl), contentType, respUse, cast[ptr uint8](unsafeaddr(respBody[0])), respLength)

type
  AuthBasic* = ref object of Auth
  AuthBasic00* = object of Auth00

proc soup_auth_basic_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthBasic()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthDigest* = ref object of Auth
  AuthDigest00* = object of Auth00

proc soup_auth_digest_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDigest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthDomain* = ref object of gobject.Object
  AuthDomain00* = object of gobject.Object00

proc soup_auth_domain_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDomain()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_domain_accepts(self: ptr AuthDomain00; msg: ptr Message00): cstring {.
    importc, libprag.}

proc accepts*(self: AuthDomain; msg: Message): string =
  let resul0 = soup_auth_domain_accepts(cast[ptr AuthDomain00](self.impl), cast[ptr Message00](msg.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_auth_domain_add_path(self: ptr AuthDomain00; path: cstring) {.
    importc, libprag.}

proc addPath*(self: AuthDomain; path: cstring) =
  soup_auth_domain_add_path(cast[ptr AuthDomain00](self.impl), path)

proc soup_auth_domain_challenge(self: ptr AuthDomain00; msg: ptr Message00) {.
    importc, libprag.}

proc challenge*(self: AuthDomain; msg: Message) =
  soup_auth_domain_challenge(cast[ptr AuthDomain00](self.impl), cast[ptr Message00](msg.impl))

proc soup_auth_domain_check_password(self: ptr AuthDomain00; msg: ptr Message00;
    username: cstring; password: cstring): gboolean {.
    importc, libprag.}

proc checkPassword*(self: AuthDomain; msg: Message; username: cstring;
    password: cstring): bool =
  toBool(soup_auth_domain_check_password(cast[ptr AuthDomain00](self.impl), cast[ptr Message00](msg.impl), username, password))

proc soup_auth_domain_covers(self: ptr AuthDomain00; msg: ptr Message00): gboolean {.
    importc, libprag.}

proc covers*(self: AuthDomain; msg: Message): bool =
  toBool(soup_auth_domain_covers(cast[ptr AuthDomain00](self.impl), cast[ptr Message00](msg.impl)))

proc soup_auth_domain_get_realm(self: ptr AuthDomain00): cstring {.
    importc, libprag.}

proc getRealm*(self: AuthDomain): string =
  result = $soup_auth_domain_get_realm(cast[ptr AuthDomain00](self.impl))

proc realm*(self: AuthDomain): string =
  result = $soup_auth_domain_get_realm(cast[ptr AuthDomain00](self.impl))

proc soup_auth_domain_remove_path(self: ptr AuthDomain00; path: cstring) {.
    importc, libprag.}

proc removePath*(self: AuthDomain; path: cstring) =
  soup_auth_domain_remove_path(cast[ptr AuthDomain00](self.impl), path)

proc soup_auth_domain_try_generic_auth_callback(self: ptr AuthDomain00; msg: ptr Message00;
    username: cstring): gboolean {.
    importc, libprag.}

proc tryGenericAuthCallback*(self: AuthDomain; msg: Message;
    username: cstring): bool =
  toBool(soup_auth_domain_try_generic_auth_callback(cast[ptr AuthDomain00](self.impl), cast[ptr Message00](msg.impl), username))

type
  AuthDomainBasic* = ref object of AuthDomain
  AuthDomainBasic00* = object of AuthDomain00

proc soup_auth_domain_basic_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDomainBasic()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthDomainBasicAuthCallback* = proc (domain: ptr AuthDomainBasic00; msg: ptr Message00; username: cstring;
    password: cstring; userData: pointer): gboolean {.cdecl.}

proc soup_auth_domain_basic_set_auth_callback(self: ptr AuthDomainBasic00;
    callback: AuthDomainBasicAuthCallback; userData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setAuthCallback*(self: AuthDomainBasic; callback: AuthDomainBasicAuthCallback;
    userData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_basic_set_auth_callback(cast[ptr AuthDomainBasic00](self.impl), callback, userData, dnotify)

type
  AuthDomainDigest* = ref object of AuthDomain
  AuthDomainDigest00* = object of AuthDomain00

proc soup_auth_domain_digest_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthDomainDigest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_domain_digest_encode_password(username: cstring; realm: cstring;
    password: cstring): cstring {.
    importc, libprag.}

proc encodePassword*(username: cstring; realm: cstring;
    password: cstring): string =
  let resul0 = soup_auth_domain_digest_encode_password(username, realm, password)
  result = $resul0
  cogfree(resul0)

type
  AuthDomainDigestAuthCallback* = proc (domain: ptr AuthDomainDigest00; msg: ptr Message00; username: cstring;
    userData: pointer): cstring {.cdecl.}

proc soup_auth_domain_digest_set_auth_callback(self: ptr AuthDomainDigest00;
    callback: AuthDomainDigestAuthCallback; userData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setAuthCallback*(self: AuthDomainDigest; callback: AuthDomainDigestAuthCallback;
    userData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_digest_set_auth_callback(cast[ptr AuthDomainDigest00](self.impl), callback, userData, dnotify)

type
  AuthDomainFilter* = proc (domain: ptr AuthDomain00; msg: ptr Message00; userData: pointer): gboolean {.cdecl.}

proc soup_auth_domain_set_filter(self: ptr AuthDomain00; filter: AuthDomainFilter;
    filterData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setFilter*(self: AuthDomain; filter: AuthDomainFilter;
    filterData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_set_filter(cast[ptr AuthDomain00](self.impl), filter, filterData, dnotify)

type
  AuthDomainGenericAuthCallback* = proc (domain: ptr AuthDomain00; msg: ptr Message00; username: cstring; userData: pointer): gboolean {.cdecl.}

proc soup_auth_domain_set_generic_auth_callback(self: ptr AuthDomain00; authCallback: AuthDomainGenericAuthCallback;
    authData: pointer; dnotify: DestroyNotify) {.
    importc, libprag.}

proc setGenericAuthCallback*(self: AuthDomain; authCallback: AuthDomainGenericAuthCallback;
    authData: pointer; dnotify: DestroyNotify) =
  soup_auth_domain_set_generic_auth_callback(cast[ptr AuthDomain00](self.impl), authCallback, authData, dnotify)

type
  AuthNTLM* = ref object of Auth
  AuthNTLM00* = object of Auth00

proc soup_auth_ntlm_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthNTLM()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AuthNegotiate* = ref object of Auth
  AuthNegotiate00* = object of Auth00

proc soup_auth_negotiate_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AuthNegotiate()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_auth_negotiate_supported(): gboolean {.
    importc, libprag.}

proc supported*(): bool =
  toBool(soup_auth_negotiate_supported())


const CHAR_HTTP_CTL_STR* = 16'i32

const CHAR_HTTP_SEPARATOR_STR* = 8'i32

const CHAR_URI_GEN_DELIMS_STR* = 2'i32

const CHAR_URI_PERCENT_ENCODED_STR* = 1'i32

const CHAR_URI_SUB_DELIMS_STR* = 4'i32

const COOKIE_JAR_ACCEPT_POLICY_STR* = "accept-policy"

const COOKIE_JAR_DB_FILENAME_STR* = "filename"

const COOKIE_JAR_READ_ONLY_STR* = "read-only"

const COOKIE_JAR_TEXT_FILENAME_STR* = "filename"

const COOKIE_MAX_AGE_ONE_DAY_STR* = 0'i32

const COOKIE_MAX_AGE_ONE_HOUR_STR* = 3600'i32

const COOKIE_MAX_AGE_ONE_WEEK_STR* = 0'i32

const COOKIE_MAX_AGE_ONE_YEAR_STR* = 0'i32

type
  CacheResponse* {.size: sizeof(cint), pure.} = enum
    fresh = 0
    needsValidation = 1
    stale = 2

type
  Cacheability* {.size: sizeof(cint), pure.} = enum
    cacheable = 1
    uncacheable = 2
    invalidates = 4
    validates = 8

type
  ChunkAllocator* = proc (msg: ptr Message00; maxLen: uint64; userData: pointer): ptr Buffer00 {.cdecl.}

proc soup_message_set_chunk_allocator(self: ptr Message00; allocator: ChunkAllocator;
    userData: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc setChunkAllocator*(self: Message; allocator: ChunkAllocator;
    userData: pointer; destroyNotify: DestroyNotify) =
  soup_message_set_chunk_allocator(cast[ptr Message00](self.impl), allocator, userData, destroyNotify)

type
  ClientContext00* {.pure.} = object
  ClientContext* = ref object
    impl*: ptr ClientContext00
    ignoreFinalizer*: bool

proc soup_client_context_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupClientContext*(self: ClientContext) =
  if not self.ignoreFinalizer:
    boxedFree(soup_client_context_get_type(), cast[ptr ClientContext00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ClientContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_client_context_get_type(), cast[ptr ClientContext00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ClientContext) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupClientContext)

proc soup_client_context_get_address(self: ptr ClientContext00): ptr Address00 {.
    importc, libprag.}

proc getAddress*(self: ClientContext): Address =
  let gobj = soup_client_context_get_address(cast[ptr ClientContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc address*(self: ClientContext): Address =
  let gobj = soup_client_context_get_address(cast[ptr ClientContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_client_context_get_auth_domain(self: ptr ClientContext00): ptr AuthDomain00 {.
    importc, libprag.}

proc getAuthDomain*(self: ClientContext): AuthDomain =
  let gobj = soup_client_context_get_auth_domain(cast[ptr ClientContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc authDomain*(self: ClientContext): AuthDomain =
  let gobj = soup_client_context_get_auth_domain(cast[ptr ClientContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_client_context_get_auth_user(self: ptr ClientContext00): cstring {.
    importc, libprag.}

proc getAuthUser*(self: ClientContext): string =
  let resul0 = soup_client_context_get_auth_user(cast[ptr ClientContext00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc authUser*(self: ClientContext): string =
  let resul0 = soup_client_context_get_auth_user(cast[ptr ClientContext00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_client_context_get_gsocket(self: ptr ClientContext00): ptr gio.Socket00 {.
    importc, libprag.}

proc getGsocket*(self: ClientContext): gio.Socket =
  let gobj = soup_client_context_get_gsocket(cast[ptr ClientContext00](self.impl))
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

proc gsocket*(self: ClientContext): gio.Socket =
  let gobj = soup_client_context_get_gsocket(cast[ptr ClientContext00](self.impl))
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

proc soup_client_context_get_host(self: ptr ClientContext00): cstring {.
    importc, libprag.}

proc getHost*(self: ClientContext): string =
  let resul0 = soup_client_context_get_host(cast[ptr ClientContext00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc host*(self: ClientContext): string =
  let resul0 = soup_client_context_get_host(cast[ptr ClientContext00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc soup_client_context_get_local_address(self: ptr ClientContext00): ptr gio.SocketAddress00 {.
    importc, libprag.}

proc getLocalAddress*(self: ClientContext): gio.SocketAddress =
  let gobj = soup_client_context_get_local_address(cast[ptr ClientContext00](self.impl))
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

proc localAddress*(self: ClientContext): gio.SocketAddress =
  let gobj = soup_client_context_get_local_address(cast[ptr ClientContext00](self.impl))
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

proc soup_client_context_get_remote_address(self: ptr ClientContext00): ptr gio.SocketAddress00 {.
    importc, libprag.}

proc getRemoteAddress*(self: ClientContext): gio.SocketAddress =
  let gobj = soup_client_context_get_remote_address(cast[ptr ClientContext00](self.impl))
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

proc remoteAddress*(self: ClientContext): gio.SocketAddress =
  let gobj = soup_client_context_get_remote_address(cast[ptr ClientContext00](self.impl))
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

proc soup_client_context_get_socket(self: ptr ClientContext00): ptr Socket00 {.
    importc, libprag.}

proc getSocket*(self: ClientContext): Socket =
  let gobj = soup_client_context_get_socket(cast[ptr ClientContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc socket*(self: ClientContext): Socket =
  let gobj = soup_client_context_get_socket(cast[ptr ClientContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_client_context_steal_connection(self: ptr ClientContext00): ptr gio.IOStream00 {.
    importc, libprag.}

proc stealConnection*(self: ClientContext): gio.IOStream =
  let gobj = soup_client_context_steal_connection(cast[ptr ClientContext00](self.impl))
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

type
  Connection00* {.pure.} = object
  Connection* = ref object
    impl*: ptr Connection00
    ignoreFinalizer*: bool

type
  ConnectionState* {.size: sizeof(cint), pure.} = enum
    new = 0
    connecting = 1
    idle = 2
    inUse = 3
    remoteDisconnected = 4
    disconnected = 5

type
  Encoding* {.size: sizeof(cint), pure.} = enum
    unrecognized = 0
    none = 1
    contentLength = 2
    eof = 3
    chunked = 4
    byteranges = 5

type
  Expectation* {.size: sizeof(cint), pure.} = enum
    unrecognized = 1
    `continue` = 2

const FORM_MIME_TYPE_MULTIPART_STR* = "multipart/form-data"

const FORM_MIME_TYPE_URLENCODED_STR* = "application/x-www-form-urlencoded"

const HSTS_ENFORCER_DB_FILENAME_STR* = "filename"

const HSTS_POLICY_MAX_AGE_PAST_STR* = 0'i32

type
  KnownStatusCode* {.size: sizeof(cint), pure.} = enum
    none = 0
    cancelled = 1
    cantResolve = 2
    cantResolveProxy = 3
    cantConnect = 4
    cantConnectProxy = 5
    sslFailed = 6
    ioError = 7
    malformed = 8
    tryAgain = 9
    tooManyRedirects = 10
    tlsFailed = 11
    `continue` = 100
    switchingProtocols = 101
    processing = 102
    ok = 200
    created = 201
    accepted = 202
    nonAuthoritative = 203
    noContent = 204
    resetContent = 205
    partialContent = 206
    multiStatus = 207
    multipleChoices = 300
    movedPermanently = 301
    found = 302
    seeOther = 303
    notModified = 304
    useProxy = 305
    notAppearingInThisProtocol = 306
    temporaryRedirect = 307
    badRequest = 400
    unauthorized = 401
    paymentRequired = 402
    forbidden = 403
    notFound = 404
    methodNotAllowed = 405
    notAcceptable = 406
    proxyAuthenticationRequired = 407
    requestTimeout = 408
    conflict = 409
    gone = 410
    lengthRequired = 411
    preconditionFailed = 412
    requestEntityTooLarge = 413
    requestUriTooLong = 414
    unsupportedMediaType = 415
    invalidRange = 416
    expectationFailed = 417
    unprocessableEntity = 422
    locked = 423
    failedDependency = 424
    internalServerError = 500
    notImplemented = 501
    badGateway = 502
    serviceUnavailable = 503
    gatewayTimeout = 504
    httpVersionNotSupported = 505
    insufficientStorage = 507
    notExtended = 510

const
  KnownStatusCodeMovedTemporarily* = KnownStatusCode.found
  KnownStatusCodeRequestedRangeNotSatisfiable* = KnownStatusCode.invalidRange
  KnownStatusCodeProxyUnauthorized* = KnownStatusCode.proxyAuthenticationRequired

const LOGGER_LEVEL_STR* = "level"

const LOGGER_MAX_BODY_SIZE_STR* = "max-body-size"

type
  LoggerFilter* = proc (logger: ptr Logger00; msg: ptr Message00; userData: pointer): LoggerLogLevel {.cdecl.}

proc soup_logger_set_request_filter(self: ptr Logger00; requestFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc setRequestFilter*(self: Logger; requestFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) =
  soup_logger_set_request_filter(cast[ptr Logger00](self.impl), requestFilter, filterData, destroy)

proc soup_logger_set_response_filter(self: ptr Logger00; responseFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc setResponseFilter*(self: Logger; responseFilter: LoggerFilter;
    filterData: pointer; destroy: DestroyNotify) =
  soup_logger_set_response_filter(cast[ptr Logger00](self.impl), responseFilter, filterData, destroy)

type
  LoggerPrinter* = proc (logger: ptr Logger00; level: LoggerLogLevel; direction: int8; data: cstring;
    userData: pointer) {.cdecl.}

proc soup_logger_set_printer(self: ptr Logger00; printer: LoggerPrinter;
    printerData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc setPrinter*(self: Logger; printer: LoggerPrinter; printerData: pointer;
    destroy: DestroyNotify) =
  soup_logger_set_printer(cast[ptr Logger00](self.impl), printer, printerData, destroy)

const MAJOR_VERSION_STR* = 2'i32

const MESSAGE_FIRST_PARTY_STR* = "first-party"

const MESSAGE_FLAGS_STR* = "flags"

const MESSAGE_HTTP_VERSION_STR* = "http-version"

const MESSAGE_IS_TOP_LEVEL_NAVIGATION_STR* = "is-top-level-navigation"

const MESSAGE_METHOD_STR* = "method"

const MESSAGE_PRIORITY_STR* = "priority"

const MESSAGE_REASON_PHRASE_STR* = "reason-phrase"

const MESSAGE_REQUEST_BODY_STR* = "request-body"

const MESSAGE_REQUEST_BODY_DATA_STR* = "request-body-data"

const MESSAGE_REQUEST_HEADERS_STR* = "request-headers"

const MESSAGE_RESPONSE_BODY_STR* = "response-body"

const MESSAGE_RESPONSE_BODY_DATA_STR* = "response-body-data"

const MESSAGE_RESPONSE_HEADERS_STR* = "response-headers"

const MESSAGE_SERVER_SIDE_STR* = "server-side"

const MESSAGE_SITE_FOR_COOKIES_STR* = "site-for-cookies"

const MESSAGE_STATUS_CODE_STR* = "status-code"

const MESSAGE_TLS_CERTIFICATE_STR* = "tls-certificate"

const MESSAGE_TLS_ERRORS_STR* = "tls-errors"

const MESSAGE_URI_STR* = "uri"

const MICRO_VERSION_STR* = 0'i32

const MINOR_VERSION_STR* = 72'i32

type
  MessageBody00* {.pure.} = object
  MessageBody* = ref object
    impl*: ptr MessageBody00
    ignoreFinalizer*: bool

proc soup_message_body_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupMessageBody*(self: MessageBody) =
  if not self.ignoreFinalizer:
    boxedFree(soup_message_body_get_type(), cast[ptr MessageBody00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MessageBody()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_message_body_get_type(), cast[ptr MessageBody00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MessageBody) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupMessageBody)

proc soup_message_body_free(self: ptr MessageBody00) {.
    importc, libprag.}

proc free*(self: MessageBody) =
  soup_message_body_free(cast[ptr MessageBody00](self.impl))

proc finalizerfree*(self: MessageBody) =
  if not self.ignoreFinalizer:
    soup_message_body_free(cast[ptr MessageBody00](self.impl))

proc soup_message_body_append_buffer(self: ptr MessageBody00; buffer: ptr Buffer00) {.
    importc, libprag.}

proc appendBuffer*(self: MessageBody; buffer: Buffer) =
  soup_message_body_append_buffer(cast[ptr MessageBody00](self.impl), cast[ptr Buffer00](buffer.impl))

proc soup_message_body_append_take(self: ptr MessageBody00; data: ptr uint8;
    length: uint64) {.
    importc, libprag.}

proc append*(self: MessageBody; data: seq[uint8] | string) =
  let length = uint64(data.len)
  soup_message_body_append_take(cast[ptr MessageBody00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

proc soup_message_body_complete(self: ptr MessageBody00) {.
    importc, libprag.}

proc complete*(self: MessageBody) =
  soup_message_body_complete(cast[ptr MessageBody00](self.impl))

proc soup_message_body_flatten(self: ptr MessageBody00): ptr Buffer00 {.
    importc, libprag.}

proc flatten*(self: MessageBody): Buffer =
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = soup_message_body_flatten(cast[ptr MessageBody00](self.impl))

proc soup_message_body_new(): ptr MessageBody00 {.
    importc, libprag.}

proc newMessageBody*(): MessageBody =
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_message_body_new()

proc newMessageBody*(tdesc: typedesc): tdesc =
  assert(result is MessageBody)
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_message_body_new()

proc initMessageBody*[T](result: var T) {.deprecated.} =
  assert(result is MessageBody)
  fnew(result, gBoxedFreeSoupMessageBody)
  result.impl = soup_message_body_new()

proc soup_message_body_get_accumulate(self: ptr MessageBody00): gboolean {.
    importc, libprag.}

proc getAccumulate*(self: MessageBody): bool =
  toBool(soup_message_body_get_accumulate(cast[ptr MessageBody00](self.impl)))

proc accumulate*(self: MessageBody): bool =
  toBool(soup_message_body_get_accumulate(cast[ptr MessageBody00](self.impl)))

proc soup_message_body_get_chunk(self: ptr MessageBody00; offset: int64): ptr Buffer00 {.
    importc, libprag.}

proc getChunk*(self: MessageBody; offset: int64): Buffer =
  let impl0 = soup_message_body_get_chunk(cast[ptr MessageBody00](self.impl), offset)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupBuffer)
  result.impl = impl0

proc soup_message_body_got_chunk(self: ptr MessageBody00; chunk: ptr Buffer00) {.
    importc, libprag.}

proc gotChunk*(self: MessageBody; chunk: Buffer) =
  soup_message_body_got_chunk(cast[ptr MessageBody00](self.impl), cast[ptr Buffer00](chunk.impl))

proc soup_message_body_set_accumulate(self: ptr MessageBody00; accumulate: gboolean) {.
    importc, libprag.}

proc setAccumulate*(self: MessageBody; accumulate: bool = true) =
  soup_message_body_set_accumulate(cast[ptr MessageBody00](self.impl), gboolean(accumulate))

proc `accumulate=`*(self: MessageBody; accumulate: bool) =
  soup_message_body_set_accumulate(cast[ptr MessageBody00](self.impl), gboolean(accumulate))

proc soup_message_body_truncate(self: ptr MessageBody00) {.
    importc, libprag.}

proc truncate*(self: MessageBody) =
  soup_message_body_truncate(cast[ptr MessageBody00](self.impl))

proc soup_message_body_wrote_chunk(self: ptr MessageBody00; chunk: ptr Buffer00) {.
    importc, libprag.}

proc wroteChunk*(self: MessageBody; chunk: Buffer) =
  soup_message_body_wrote_chunk(cast[ptr MessageBody00](self.impl), cast[ptr Buffer00](chunk.impl))

type
  MessageHeaders00* {.pure.} = object
  MessageHeaders* = ref object
    impl*: ptr MessageHeaders00
    ignoreFinalizer*: bool

proc soup_message_headers_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupMessageHeaders*(self: MessageHeaders) =
  if not self.ignoreFinalizer:
    boxedFree(soup_message_headers_get_type(), cast[ptr MessageHeaders00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MessageHeaders()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_message_headers_get_type(), cast[ptr MessageHeaders00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MessageHeaders) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupMessageHeaders)

proc soup_message_headers_free(self: ptr MessageHeaders00) {.
    importc, libprag.}

proc free*(self: MessageHeaders) =
  soup_message_headers_free(cast[ptr MessageHeaders00](self.impl))

proc finalizerfree*(self: MessageHeaders) =
  if not self.ignoreFinalizer:
    soup_message_headers_free(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_append(self: ptr MessageHeaders00; name: cstring;
    value: cstring) {.
    importc, libprag.}

proc append*(self: MessageHeaders; name: cstring; value: cstring) =
  soup_message_headers_append(cast[ptr MessageHeaders00](self.impl), name, value)

proc soup_message_headers_clean_connection_headers(self: ptr MessageHeaders00) {.
    importc, libprag.}

proc cleanConnectionHeaders*(self: MessageHeaders) =
  soup_message_headers_clean_connection_headers(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_clear(self: ptr MessageHeaders00) {.
    importc, libprag.}

proc clear*(self: MessageHeaders) =
  soup_message_headers_clear(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_get(self: ptr MessageHeaders00; name: cstring): cstring {.
    importc, libprag.}

proc getMessageHeaders*(self: MessageHeaders; name: cstring): string =
  let resul0 = soup_message_headers_get(cast[ptr MessageHeaders00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_headers_get_content_disposition(self: ptr MessageHeaders00;
    disposition: var cstring; params: var ptr HashTable00): gboolean {.
    importc, libprag.}

proc getContentDisposition*(self: MessageHeaders; disposition: var string;
    params: var ptr HashTable00): bool =
  var disposition_00: cstring
  result = toBool(soup_message_headers_get_content_disposition(cast[ptr MessageHeaders00](self.impl), disposition_00, params))
  if disposition.addr != nil:
    disposition = $(disposition_00)

proc soup_message_headers_get_content_length(self: ptr MessageHeaders00): int64 {.
    importc, libprag.}

proc getContentLength*(self: MessageHeaders): int64 =
  soup_message_headers_get_content_length(cast[ptr MessageHeaders00](self.impl))

proc contentLength*(self: MessageHeaders): int64 =
  soup_message_headers_get_content_length(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_get_content_range(self: ptr MessageHeaders00; start: var int64;
    `end`: var int64; totalLength: var int64): gboolean {.
    importc, libprag.}

proc getContentRange*(self: MessageHeaders; start: var int64;
    `end`: var int64; totalLength: var int64 = cast[var int64](nil)): bool =
  toBool(soup_message_headers_get_content_range(cast[ptr MessageHeaders00](self.impl), start, `end`, totalLength))

proc soup_message_headers_get_content_type(self: ptr MessageHeaders00; params: var ptr HashTable00): cstring {.
    importc, libprag.}

proc getContentType*(self: MessageHeaders; params: var ptr HashTable00 = cast[var ptr HashTable00](nil)): string =
  let resul0 = soup_message_headers_get_content_type(cast[ptr MessageHeaders00](self.impl), params)
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_headers_get_encoding(self: ptr MessageHeaders00): Encoding {.
    importc, libprag.}

proc getEncoding*(self: MessageHeaders): Encoding =
  soup_message_headers_get_encoding(cast[ptr MessageHeaders00](self.impl))

proc encoding*(self: MessageHeaders): Encoding =
  soup_message_headers_get_encoding(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_get_expectations(self: ptr MessageHeaders00): Expectation {.
    importc, libprag.}

proc getExpectations*(self: MessageHeaders): Expectation =
  soup_message_headers_get_expectations(cast[ptr MessageHeaders00](self.impl))

proc expectations*(self: MessageHeaders): Expectation =
  soup_message_headers_get_expectations(cast[ptr MessageHeaders00](self.impl))

proc soup_message_headers_get_list(self: ptr MessageHeaders00; name: cstring): cstring {.
    importc, libprag.}

proc getListMessageHeaders*(self: MessageHeaders; name: cstring): string =
  let resul0 = soup_message_headers_get_list(cast[ptr MessageHeaders00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_headers_get_one(self: ptr MessageHeaders00; name: cstring): cstring {.
    importc, libprag.}

proc getOne*(self: MessageHeaders; name: cstring): string =
  let resul0 = soup_message_headers_get_one(cast[ptr MessageHeaders00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc soup_message_headers_header_contains(self: ptr MessageHeaders00; name: cstring;
    token: cstring): gboolean {.
    importc, libprag.}

proc headerContains*(self: MessageHeaders; name: cstring;
    token: cstring): bool =
  toBool(soup_message_headers_header_contains(cast[ptr MessageHeaders00](self.impl), name, token))

proc soup_message_headers_header_equals(self: ptr MessageHeaders00; name: cstring;
    value: cstring): gboolean {.
    importc, libprag.}

proc headerEquals*(self: MessageHeaders; name: cstring;
    value: cstring): bool =
  toBool(soup_message_headers_header_equals(cast[ptr MessageHeaders00](self.impl), name, value))

proc soup_message_headers_remove(self: ptr MessageHeaders00; name: cstring) {.
    importc, libprag.}

proc remove*(self: MessageHeaders; name: cstring) =
  soup_message_headers_remove(cast[ptr MessageHeaders00](self.impl), name)

proc soup_message_headers_replace(self: ptr MessageHeaders00; name: cstring;
    value: cstring) {.
    importc, libprag.}

proc replace*(self: MessageHeaders; name: cstring; value: cstring) =
  soup_message_headers_replace(cast[ptr MessageHeaders00](self.impl), name, value)

proc soup_message_headers_set_content_disposition(self: ptr MessageHeaders00;
    disposition: cstring; params: ptr HashTable00) {.
    importc, libprag.}

proc setContentDisposition*(self: MessageHeaders; disposition: cstring;
    params: ptr HashTable00) =
  soup_message_headers_set_content_disposition(cast[ptr MessageHeaders00](self.impl), disposition, params)

proc soup_message_headers_set_content_length(self: ptr MessageHeaders00;
    contentLength: int64) {.
    importc, libprag.}

proc setContentLength*(self: MessageHeaders; contentLength: int64) =
  soup_message_headers_set_content_length(cast[ptr MessageHeaders00](self.impl), contentLength)

proc `contentLength=`*(self: MessageHeaders; contentLength: int64) =
  soup_message_headers_set_content_length(cast[ptr MessageHeaders00](self.impl), contentLength)

proc soup_message_headers_set_content_range(self: ptr MessageHeaders00; start: int64;
    `end`: int64; totalLength: int64) {.
    importc, libprag.}

proc setContentRange*(self: MessageHeaders; start: int64;
    `end`: int64; totalLength: int64) =
  soup_message_headers_set_content_range(cast[ptr MessageHeaders00](self.impl), start, `end`, totalLength)

proc soup_message_headers_set_content_type(self: ptr MessageHeaders00; contentType: cstring;
    params: ptr HashTable00) {.
    importc, libprag.}

proc setContentType*(self: MessageHeaders; contentType: cstring;
    params: ptr HashTable00) =
  soup_message_headers_set_content_type(cast[ptr MessageHeaders00](self.impl), contentType, params)

proc soup_message_headers_set_encoding(self: ptr MessageHeaders00; encoding: Encoding) {.
    importc, libprag.}

proc setEncoding*(self: MessageHeaders; encoding: Encoding) =
  soup_message_headers_set_encoding(cast[ptr MessageHeaders00](self.impl), encoding)

proc `encoding=`*(self: MessageHeaders; encoding: Encoding) =
  soup_message_headers_set_encoding(cast[ptr MessageHeaders00](self.impl), encoding)

proc soup_message_headers_set_expectations(self: ptr MessageHeaders00; expectations: Expectation) {.
    importc, libprag.}

proc setExpectations*(self: MessageHeaders; expectations: Expectation) =
  soup_message_headers_set_expectations(cast[ptr MessageHeaders00](self.impl), expectations)

proc `expectations=`*(self: MessageHeaders; expectations: Expectation) =
  soup_message_headers_set_expectations(cast[ptr MessageHeaders00](self.impl), expectations)

proc soup_message_headers_set_range(self: ptr MessageHeaders00; start: int64;
    `end`: int64) {.
    importc, libprag.}

proc setRange*(self: MessageHeaders; start: int64; `end`: int64) =
  soup_message_headers_set_range(cast[ptr MessageHeaders00](self.impl), start, `end`)

type
  MessageHeadersType* {.size: sizeof(cint), pure.} = enum
    request = 0
    response = 1
    multipart = 2

proc soup_message_headers_new(`type`: MessageHeadersType): ptr MessageHeaders00 {.
    importc, libprag.}

proc newMessageHeaders*(`type`: MessageHeadersType): MessageHeaders =
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_headers_new(`type`)

proc newMessageHeaders*(tdesc: typedesc; `type`: MessageHeadersType): tdesc =
  assert(result is MessageHeaders)
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_headers_new(`type`)

proc initMessageHeaders*[T](result: var T; `type`: MessageHeadersType) {.deprecated.} =
  assert(result is MessageHeaders)
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = soup_message_headers_new(`type`)

proc soup_message_headers_get_headers_type(self: ptr MessageHeaders00): MessageHeadersType {.
    importc, libprag.}

proc getHeadersType*(self: MessageHeaders): MessageHeadersType =
  soup_message_headers_get_headers_type(cast[ptr MessageHeaders00](self.impl))

proc headersType*(self: MessageHeaders): MessageHeadersType =
  soup_message_headers_get_headers_type(cast[ptr MessageHeaders00](self.impl))

type
  Range00* {.pure.} = object
  Range* = ref object
    impl*: ptr Range00
    ignoreFinalizer*: bool

proc soup_message_headers_free_ranges(self: ptr MessageHeaders00; ranges: ptr Range00) {.
    importc, libprag.}

proc freeRanges*(self: MessageHeaders; ranges: Range) =
  soup_message_headers_free_ranges(cast[ptr MessageHeaders00](self.impl), cast[ptr Range00](ranges.impl))

proc soup_message_headers_get_ranges(self: ptr MessageHeaders00; totalLength: int64;
    ranges: var ptr Range00; length: var int32): gboolean {.
    importc, libprag.}

proc getRanges*(self: MessageHeaders; totalLength: int64;
    ranges: var ptr Range00; length: var int): bool =
  var length_00: int32
  result = toBool(soup_message_headers_get_ranges(cast[ptr MessageHeaders00](self.impl), totalLength, ranges, length_00))
  if length.addr != nil:
    length = int(length_00)

proc soup_message_headers_set_ranges(self: ptr MessageHeaders00; ranges: ptr Range00;
    length: int32) {.
    importc, libprag.}

proc setRanges*(self: MessageHeaders; ranges: Range;
    length: int) =
  soup_message_headers_set_ranges(cast[ptr MessageHeaders00](self.impl), cast[ptr Range00](ranges.impl), int32(length))

type
  MessageHeadersForeachFunc* = proc (name: cstring; value: cstring; userData: pointer) {.cdecl.}

proc soup_message_headers_foreach(self: ptr MessageHeaders00; `func`: MessageHeadersForeachFunc;
    userData: pointer) {.
    importc, libprag.}

proc foreach*(self: MessageHeaders; `func`: MessageHeadersForeachFunc;
    userData: pointer) =
  soup_message_headers_foreach(cast[ptr MessageHeaders00](self.impl), `func`, userData)

type
  MessageHeadersIter00* {.pure.} = object
  MessageHeadersIter* = ref object
    impl*: ptr MessageHeadersIter00
    ignoreFinalizer*: bool

proc soup_message_headers_iter_next(self: ptr MessageHeadersIter00; name: var cstring;
    value: var cstring): gboolean {.
    importc, libprag.}

proc next*(self: MessageHeadersIter; name: var string;
    value: var string): bool =
  var value_00: cstring
  var name_00: cstring
  result = toBool(soup_message_headers_iter_next(cast[ptr MessageHeadersIter00](self.impl), name_00, value_00))
  if value.addr != nil:
    value = $(value_00)
  if name.addr != nil:
    name = $(name_00)

proc soup_message_headers_iter_init(iter: var MessageHeadersIter00; hdrs: ptr MessageHeaders00) {.
    importc, libprag.}

proc init*(iter: var MessageHeadersIter00; hdrs: MessageHeaders) =
  soup_message_headers_iter_init(iter, cast[ptr MessageHeaders00](hdrs.impl))

type
  MessageQueue00* {.pure.} = object
  MessageQueue* = ref object
    impl*: ptr MessageQueue00
    ignoreFinalizer*: bool

type
  MessageQueueItem00* {.pure.} = object
  MessageQueueItem* = ref object
    impl*: ptr MessageQueueItem00
    ignoreFinalizer*: bool

type
  Multipart00* {.pure.} = object
  Multipart* = ref object
    impl*: ptr Multipart00
    ignoreFinalizer*: bool

proc soup_multipart_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeSoupMultipart*(self: Multipart) =
  if not self.ignoreFinalizer:
    boxedFree(soup_multipart_get_type(), cast[ptr Multipart00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Multipart()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(soup_multipart_get_type(), cast[ptr Multipart00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Multipart) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeSoupMultipart)

proc soup_multipart_free(self: ptr Multipart00) {.
    importc, libprag.}

proc free*(self: Multipart) =
  soup_multipart_free(cast[ptr Multipart00](self.impl))

proc finalizerfree*(self: Multipart) =
  if not self.ignoreFinalizer:
    soup_multipart_free(cast[ptr Multipart00](self.impl))

proc soup_multipart_new_from_message(headers: ptr MessageHeaders00; body: ptr MessageBody00): ptr Multipart00 {.
    importc, libprag.}

proc newMultipartFromMessage*(headers: MessageHeaders; body: MessageBody): Multipart =
  let impl0 = soup_multipart_new_from_message(cast[ptr MessageHeaders00](headers.impl), cast[ptr MessageBody00](body.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = impl0

proc newMultipartFromMessage*(tdesc: typedesc; headers: MessageHeaders; body: MessageBody): tdesc =
  assert(result is Multipart)
  let impl0 = soup_multipart_new_from_message(cast[ptr MessageHeaders00](headers.impl), cast[ptr MessageBody00](body.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = impl0

proc initMultipartFromMessage*[T](result: var T; headers: MessageHeaders; body: MessageBody) {.deprecated.} =
  assert(result is Multipart)
  let impl0 = soup_multipart_new_from_message(cast[ptr MessageHeaders00](headers.impl), cast[ptr MessageBody00](body.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = impl0

proc soup_multipart_append_form_file(self: ptr Multipart00; controlName: cstring;
    filename: cstring; contentType: cstring; body: ptr Buffer00) {.
    importc, libprag.}

proc appendFormFile*(self: Multipart; controlName: cstring;
    filename: cstring; contentType: cstring; body: Buffer) =
  soup_multipart_append_form_file(cast[ptr Multipart00](self.impl), controlName, filename, contentType, cast[ptr Buffer00](body.impl))

proc soup_multipart_append_form_string(self: ptr Multipart00; controlName: cstring;
    data: cstring) {.
    importc, libprag.}

proc appendFormString*(self: Multipart; controlName: cstring;
    data: cstring) =
  soup_multipart_append_form_string(cast[ptr Multipart00](self.impl), controlName, data)

proc soup_multipart_append_part(self: ptr Multipart00; headers: ptr MessageHeaders00;
    body: ptr Buffer00) {.
    importc, libprag.}

proc appendPart*(self: Multipart; headers: MessageHeaders;
    body: Buffer) =
  soup_multipart_append_part(cast[ptr Multipart00](self.impl), cast[ptr MessageHeaders00](headers.impl), cast[ptr Buffer00](body.impl))

proc soup_multipart_new(mimeType: cstring): ptr Multipart00 {.
    importc, libprag.}

proc newMultipart*(mimeType: cstring): Multipart =
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = soup_multipart_new(mimeType)

proc newMultipart*(tdesc: typedesc; mimeType: cstring): tdesc =
  assert(result is Multipart)
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = soup_multipart_new(mimeType)

proc initMultipart*[T](result: var T; mimeType: cstring) {.deprecated.} =
  assert(result is Multipart)
  fnew(result, gBoxedFreeSoupMultipart)
  result.impl = soup_multipart_new(mimeType)

proc soup_multipart_get_length(self: ptr Multipart00): int32 {.
    importc, libprag.}

proc getLength*(self: Multipart): int =
  int(soup_multipart_get_length(cast[ptr Multipart00](self.impl)))

proc length*(self: Multipart): int =
  int(soup_multipart_get_length(cast[ptr Multipart00](self.impl)))

proc soup_multipart_get_part(self: ptr Multipart00; part: int32; headers: var ptr MessageHeaders00;
    body: var ptr Buffer00): gboolean {.
    importc, libprag.}

proc getPart*(self: Multipart; part: int; headers: var MessageHeaders;
    body: var Buffer): bool =
  fnew(headers, gBoxedFreeSoupMessageHeaders)
  fnew(body, gBoxedFreeSoupBuffer)
  result = toBool(soup_multipart_get_part(cast[ptr Multipart00](self.impl), int32(part), cast[var ptr MessageHeaders00](addr headers.impl), cast[var ptr Buffer00](addr body.impl)))
  headers.impl = cast[ptr MessageHeaders00](g_boxed_copy(soup_message_headers_get_type(), headers.impl))
  body.impl = cast[ptr Buffer00](g_boxed_copy(soup_buffer_get_type(), body.impl))

proc soup_multipart_to_message(self: ptr Multipart00; destHeaders: ptr MessageHeaders00;
    destBody: ptr MessageBody00) {.
    importc, libprag.}

proc toMessage*(self: Multipart; destHeaders: MessageHeaders;
    destBody: MessageBody) =
  soup_multipart_to_message(cast[ptr Multipart00](self.impl), cast[ptr MessageHeaders00](destHeaders.impl), cast[ptr MessageBody00](destBody.impl))

type
  MultipartInputStream* = ref object of gio.FilterInputStream
  MultipartInputStream00* = object of gio.FilterInputStream00

proc soup_multipart_input_stream_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MultipartInputStream()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_multipart_input_stream_new(msg: ptr Message00; baseStream: ptr gio.InputStream00): ptr MultipartInputStream00 {.
    importc, libprag.}

proc newMultipartInputStream*(msg: Message; baseStream: gio.InputStream): MultipartInputStream =
  let gobj = soup_multipart_input_stream_new(cast[ptr Message00](msg.impl), cast[ptr gio.InputStream00](baseStream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMultipartInputStream*(tdesc: typedesc; msg: Message; baseStream: gio.InputStream): tdesc =
  assert(result is MultipartInputStream)
  let gobj = soup_multipart_input_stream_new(cast[ptr Message00](msg.impl), cast[ptr gio.InputStream00](baseStream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMultipartInputStream*[T](result: var T; msg: Message; baseStream: gio.InputStream) {.deprecated.} =
  assert(result is MultipartInputStream)
  let gobj = soup_multipart_input_stream_new(cast[ptr Message00](msg.impl), cast[ptr gio.InputStream00](baseStream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_multipart_input_stream_get_headers(self: ptr MultipartInputStream00): ptr MessageHeaders00 {.
    importc, libprag.}

proc getHeaders*(self: MultipartInputStream): MessageHeaders =
  let impl0 = soup_multipart_input_stream_get_headers(cast[ptr MultipartInputStream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), impl0))

proc headers*(self: MultipartInputStream): MessageHeaders =
  let impl0 = soup_multipart_input_stream_get_headers(cast[ptr MultipartInputStream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeSoupMessageHeaders)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(soup_message_headers_get_type(), impl0))

proc soup_multipart_input_stream_next_part(self: ptr MultipartInputStream00;
    cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc nextPart*(self: MultipartInputStream; cancellable: gio.Cancellable = nil): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_multipart_input_stream_next_part(cast[ptr MultipartInputStream00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_multipart_input_stream_next_part_async(self: ptr MultipartInputStream00;
    ioPriority: int32; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    data: pointer) {.
    importc, libprag.}

proc nextPartAsync*(self: MultipartInputStream;
    ioPriority: int; cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback;
    data: pointer) =
  soup_multipart_input_stream_next_part_async(cast[ptr MultipartInputStream00](self.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, data)

proc soup_multipart_input_stream_next_part_finish(self: ptr MultipartInputStream00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr gio.InputStream00 {.
    importc, libprag.}

proc nextPartFinish*(self: MultipartInputStream;
    resu: gio.AsyncResult): gio.InputStream =
  var gerror: ptr glib.Error
  let gobj = soup_multipart_input_stream_next_part_finish(cast[ptr MultipartInputStream00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PasswordManager00* = object of gobject.Object00
  PasswordManager* = ref object of gobject.Object

proc soup_password_manager_get_passwords_sync(self: ptr PasswordManager00;
    msg: ptr Message00; auth: ptr Auth00; cancellable: ptr gio.Cancellable00) {.
    importc, libprag.}

proc getPasswordsSync*(self: PasswordManager; msg: Message;
    auth: Auth; cancellable: gio.Cancellable = nil) =
  soup_password_manager_get_passwords_sync(cast[ptr PasswordManager00](self.impl), cast[ptr Message00](msg.impl), cast[ptr Auth00](auth.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl))

type
  PasswordManagerCallback* = proc (passwordManager: ptr PasswordManager00; msg: ptr Message00; auth: ptr Auth00;
    retrying: gboolean; userData: pointer) {.cdecl.}

proc soup_password_manager_get_passwords_async(self: ptr PasswordManager00;
    msg: ptr Message00; auth: ptr Auth00; retrying: gboolean; asyncContext: ptr glib.MainContext00;
    cancellable: ptr gio.Cancellable00; callback: PasswordManagerCallback;
    userData: pointer) {.
    importc, libprag.}

proc getPasswordsAsync*(self: PasswordManager; msg: Message;
    auth: Auth; retrying: bool; asyncContext: glib.MainContext; cancellable: gio.Cancellable = nil;
    callback: PasswordManagerCallback; userData: pointer) =
  soup_password_manager_get_passwords_async(cast[ptr PasswordManager00](self.impl), cast[ptr Message00](msg.impl), cast[ptr Auth00](auth.impl), gboolean(retrying), cast[ptr glib.MainContext00](asyncContext.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  ProxyResolver00* = object of gobject.Object00
  ProxyResolver* = ref object of gobject.Object

proc soup_proxy_resolver_get_proxy_sync(self: ptr ProxyResolver00; msg: ptr Message00;
    cancellable: ptr gio.Cancellable00; `addr`: var ptr Address00): uint32 {.
    importc, libprag.}

proc getProxySync*(self: ProxyResolver; msg: Message;
    cancellable: gio.Cancellable = nil; `addr`: var Address): int =
  var tmpoutgobjectarg: ptr Address00
  result = int(soup_proxy_resolver_get_proxy_sync(cast[ptr ProxyResolver00](self.impl), cast[ptr Message00](msg.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), tmpoutgobjectarg))
#  dothemagic(`addr`
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    `addr` = cast[type(`addr`)](argqdata)
    assert(`addr`.impl == tmpoutgobjectarg)
  else:
    fnew(`addr`, soup.finalizeGObject)
    `addr`.impl = tmpoutgobjectarg
    GC_ref(`addr`)
    if g_object_is_floating(`addr`.impl).int != 0:
      discard g_object_ref_sink(`addr`.impl)
    g_object_add_toggle_ref(`addr`.impl, toggleNotify, addr(`addr`[]))
    g_object_unref(`addr`.impl)
    assert(g_object_get_qdata(`addr`.impl, Quark) == nil)
    g_object_set_qdata(`addr`.impl, Quark, addr(`addr`[]))


type
  ProxyResolverCallback* = proc (proxyResolver: ptr ProxyResolver00; msg: ptr Message00; arg: uint32;
    `addr`: ptr Address00; userData: pointer) {.cdecl.}

proc soup_proxy_resolver_get_proxy_async(self: ptr ProxyResolver00; msg: ptr Message00;
    asyncContext: ptr glib.MainContext00; cancellable: ptr gio.Cancellable00;
    callback: ProxyResolverCallback; userData: pointer) {.
    importc, libprag.}

proc getProxyAsync*(self: ProxyResolver; msg: Message;
    asyncContext: glib.MainContext; cancellable: gio.Cancellable = nil; callback: ProxyResolverCallback;
    userData: pointer) =
  soup_proxy_resolver_get_proxy_async(cast[ptr ProxyResolver00](self.impl), cast[ptr Message00](msg.impl), cast[ptr glib.MainContext00](asyncContext.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  ProxyURIResolver00* = object of gobject.Object00
  ProxyURIResolver* = ref object of gobject.Object

proc soup_proxy_uri_resolver_get_proxy_uri_sync(self: ptr ProxyURIResolver00;
    uri: ptr URI00; cancellable: ptr gio.Cancellable00; proxyUri: var ptr URI00): uint32 {.
    importc, libprag.}

proc getProxyUriSync*(self: ProxyURIResolver | ProxyResolverDefault;
    uri: URI; cancellable: gio.Cancellable = nil; proxyUri: var URI): int =
  fnew(proxyUri, gBoxedFreeSoupURI)
  int(soup_proxy_uri_resolver_get_proxy_uri_sync(cast[ptr ProxyURIResolver00](self.impl), cast[ptr URI00](uri.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), cast[var ptr URI00](addr proxyUri.impl)))

type
  ProxyURIResolverCallback* = proc (resolver: ptr ProxyURIResolver00; status: uint32; proxyUri: ptr URI00;
    userData: pointer) {.cdecl.}

proc soup_proxy_uri_resolver_get_proxy_uri_async(self: ptr ProxyURIResolver00;
    uri: ptr URI00; asyncContext: ptr glib.MainContext00; cancellable: ptr gio.Cancellable00;
    callback: ProxyURIResolverCallback; userData: pointer) {.
    importc, libprag.}

proc getProxyUriAsync*(self: ProxyURIResolver | ProxyResolverDefault;
    uri: URI; asyncContext: glib.MainContext = nil; cancellable: gio.Cancellable = nil;
    callback: ProxyURIResolverCallback; userData: pointer) =
  soup_proxy_uri_resolver_get_proxy_uri_async(cast[ptr ProxyURIResolver00](self.impl), cast[ptr URI00](uri.impl), if asyncContext.isNil: nil else: cast[ptr glib.MainContext00](asyncContext.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

const REQUEST_SESSION_STR* = "session"

const REQUEST_URI_STR* = "uri"

type
  RequestData* = ref object of Request
  RequestData00* = object of Request00

proc soup_request_data_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RequestData()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  RequestError* {.size: sizeof(cint), pure.} = enum
    badUri = 0
    unsupportedUriScheme = 1
    parsing = 2
    encoding = 3

type
  RequestFile* = ref object of Request
  RequestFile00* = object of Request00

proc soup_request_file_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RequestFile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_request_file_get_file(self: ptr RequestFile00): ptr gio.GFile00 {.
    importc, libprag.}

proc getFile*(self: RequestFile): gio.GFile =
  let gobj = soup_request_file_get_file(cast[ptr RequestFile00](self.impl))
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

proc file*(self: RequestFile): gio.GFile =
  let gobj = soup_request_file_get_file(cast[ptr RequestFile00](self.impl))
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

type
  RequesterError* {.size: sizeof(cint), pure.} = enum
    badUri = 0
    unsupportedUriScheme = 1

const SERVER_ASYNC_CONTEXT_STR* = "async-context"

const SERVER_HTTPS_ALIASES_STR* = "https-aliases"

const SERVER_HTTP_ALIASES_STR* = "http-aliases"

const SERVER_INTERFACE_STR* = "interface"

const SERVER_PORT_STR* = "port"

const SERVER_RAW_PATHS_STR* = "raw-paths"

const SERVER_SERVER_HEADER_STR* = "server-header"

const SERVER_SSL_CERT_FILE_STR* = "ssl-cert-file"

const SERVER_SSL_KEY_FILE_STR* = "ssl-key-file"

const SERVER_TLS_CERTIFICATE_STR* = "tls-certificate"

const SESSION_ACCEPT_LANGUAGE_STR* = "accept-language"

const SESSION_ACCEPT_LANGUAGE_AUTO_STR* = "accept-language-auto"

const SESSION_ASYNC_CONTEXT_STR* = "async-context"

const SESSION_HTTPS_ALIASES_STR* = "https-aliases"

const SESSION_HTTP_ALIASES_STR* = "http-aliases"

const SESSION_IDLE_TIMEOUT_STR* = "idle-timeout"

const SESSION_LOCAL_ADDRESS_STR* = "local-address"

const SESSION_MAX_CONNS_STR* = "max-conns"

const SESSION_MAX_CONNS_PER_HOST_STR* = "max-conns-per-host"

const SESSION_PROXY_RESOLVER_STR* = "proxy-resolver"

const SESSION_PROXY_URI_STR* = "proxy-uri"

const SESSION_SSL_CA_FILE_STR* = "ssl-ca-file"

const SESSION_SSL_STRICT_STR* = "ssl-strict"

const SESSION_SSL_USE_SYSTEM_CA_FILE_STR* = "ssl-use-system-ca-file"

const SESSION_TIMEOUT_STR* = "timeout"

const SESSION_TLS_DATABASE_STR* = "tls-database"

const SESSION_TLS_INTERACTION_STR* = "tls-interaction"

const SESSION_USER_AGENT_STR* = "user-agent"

const SESSION_USE_NTLM_STR* = "use-ntlm"

const SESSION_USE_THREAD_CONTEXT_STR* = "use-thread-context"

const SOCKET_ASYNC_CONTEXT_STR* = "async-context"

const SOCKET_FLAG_NONBLOCKING_STR* = "non-blocking"

const SOCKET_IS_SERVER_STR* = "is-server"

const SOCKET_LOCAL_ADDRESS_STR* = "local-address"

const SOCKET_REMOTE_ADDRESS_STR* = "remote-address"

const SOCKET_SSL_CREDENTIALS_STR* = "ssl-creds"

const SOCKET_SSL_FALLBACK_STR* = "ssl-fallback"

const SOCKET_SSL_STRICT_STR* = "ssl-strict"

const SOCKET_TIMEOUT_STR* = "timeout"

const SOCKET_TLS_CERTIFICATE_STR* = "tls-certificate"

const SOCKET_TLS_ERRORS_STR* = "tls-errors"

const SOCKET_TRUSTED_CERTIFICATE_STR* = "trusted-certificate"

const SOCKET_USE_THREAD_CONTEXT_STR* = "use-thread-context"

type
  Server* = ref object of gobject.Object
  Server00* = object of gobject.Object00

proc soup_server_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Server()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scRequestAborted*(self: Server;  p: proc (self: ptr Server00; message: ptr Message00; client: ptr ClientContext00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-aborted", cast[GCallback](p), xdata, nil, cf)

proc scRequestFinished*(self: Server;  p: proc (self: ptr Server00; message: ptr Message00; client: ptr ClientContext00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-finished", cast[GCallback](p), xdata, nil, cf)

proc scRequestRead*(self: Server;  p: proc (self: ptr Server00; message: ptr Message00; client: ptr ClientContext00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-read", cast[GCallback](p), xdata, nil, cf)

proc scRequestStarted*(self: Server;  p: proc (self: ptr Server00; message: ptr Message00; client: ptr ClientContext00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "request-started", cast[GCallback](p), xdata, nil, cf)

proc soup_server_accept_iostream(self: ptr Server00; stream: ptr gio.IOStream00;
    localAddr: ptr gio.SocketAddress00; remoteAddr: ptr gio.SocketAddress00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc acceptIostream*(self: Server; stream: gio.IOStream; localAddr: gio.SocketAddress = nil;
    remoteAddr: gio.SocketAddress = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_accept_iostream(cast[ptr Server00](self.impl), cast[ptr gio.IOStream00](stream.impl), if localAddr.isNil: nil else: cast[ptr gio.SocketAddress00](localAddr.impl), if remoteAddr.isNil: nil else: cast[ptr gio.SocketAddress00](remoteAddr.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_add_auth_domain(self: ptr Server00; authDomain: ptr AuthDomain00) {.
    importc, libprag.}

proc addAuthDomain*(self: Server; authDomain: AuthDomain) =
  soup_server_add_auth_domain(cast[ptr Server00](self.impl), cast[ptr AuthDomain00](authDomain.impl))

proc soup_server_add_websocket_extension(self: ptr Server00; extensionType: GType) {.
    importc, libprag.}

proc addWebsocketExtension*(self: Server; extensionType: GType) =
  soup_server_add_websocket_extension(cast[ptr Server00](self.impl), extensionType)

proc soup_server_disconnect(self: ptr Server00) {.
    importc, libprag.}

proc disconnect*(self: Server) =
  soup_server_disconnect(cast[ptr Server00](self.impl))

proc soup_server_get_async_context(self: ptr Server00): ptr glib.MainContext00 {.
    importc, libprag.}

proc getAsyncContext*(self: Server): glib.MainContext =
  let impl0 = soup_server_get_async_context(cast[ptr Server00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGMainContext)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), impl0))

proc asyncContext*(self: Server): glib.MainContext =
  let impl0 = soup_server_get_async_context(cast[ptr Server00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGMainContext)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), impl0))

proc soup_server_get_listener(self: ptr Server00): ptr Socket00 {.
    importc, libprag.}

proc getListener*(self: Server): Socket =
  let gobj = soup_server_get_listener(cast[ptr Server00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc listener*(self: Server): Socket =
  let gobj = soup_server_get_listener(cast[ptr Server00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_server_get_listeners(self: ptr Server00): ptr glib.SList {.
    importc, libprag.}

proc getListeners*(self: Server): seq[gio.Socket] =
  let resul0 = soup_server_get_listeners(cast[ptr Server00](self.impl))
  result = gslistObjects2seq(gio.Socket, resul0, false)
  g_slist_free(resul0)

proc listeners*(self: Server): seq[gio.Socket] =
  let resul0 = soup_server_get_listeners(cast[ptr Server00](self.impl))
  result = gslistObjects2seq(gio.Socket, resul0, false)
  g_slist_free(resul0)

proc soup_server_get_port(self: ptr Server00): uint32 {.
    importc, libprag.}

proc getPort*(self: Server): int =
  int(soup_server_get_port(cast[ptr Server00](self.impl)))

proc port*(self: Server): int =
  int(soup_server_get_port(cast[ptr Server00](self.impl)))

proc soup_server_get_uris(self: ptr Server00): ptr glib.SList {.
    importc, libprag.}

proc getUris*(self: Server): seq[URI] =
  let resul0 = soup_server_get_uris(cast[ptr Server00](self.impl))
  result = gslistStructs2seq[URI](resul0, false)
  g_slist_free(resul0)

proc uris*(self: Server): seq[URI] =
  let resul0 = soup_server_get_uris(cast[ptr Server00](self.impl))
  result = gslistStructs2seq[URI](resul0, false)
  g_slist_free(resul0)

proc soup_server_is_https(self: ptr Server00): gboolean {.
    importc, libprag.}

proc isHttps*(self: Server): bool =
  toBool(soup_server_is_https(cast[ptr Server00](self.impl)))

proc soup_server_pause_message(self: ptr Server00; msg: ptr Message00) {.
    importc, libprag.}

proc pauseMessage*(self: Server; msg: Message) =
  soup_server_pause_message(cast[ptr Server00](self.impl), cast[ptr Message00](msg.impl))

proc soup_server_quit(self: ptr Server00) {.
    importc, libprag.}

proc quit*(self: Server) =
  soup_server_quit(cast[ptr Server00](self.impl))

proc soup_server_remove_auth_domain(self: ptr Server00; authDomain: ptr AuthDomain00) {.
    importc, libprag.}

proc removeAuthDomain*(self: Server; authDomain: AuthDomain) =
  soup_server_remove_auth_domain(cast[ptr Server00](self.impl), cast[ptr AuthDomain00](authDomain.impl))

proc soup_server_remove_handler(self: ptr Server00; path: cstring) {.
    importc, libprag.}

proc removeHandler*(self: Server; path: cstring) =
  soup_server_remove_handler(cast[ptr Server00](self.impl), path)

proc soup_server_remove_websocket_extension(self: ptr Server00; extensionType: GType) {.
    importc, libprag.}

proc removeWebsocketExtension*(self: Server; extensionType: GType) =
  soup_server_remove_websocket_extension(cast[ptr Server00](self.impl), extensionType)

proc soup_server_run(self: ptr Server00) {.
    importc, libprag.}

proc run*(self: Server) =
  soup_server_run(cast[ptr Server00](self.impl))

proc soup_server_run_async(self: ptr Server00) {.
    importc, libprag.}

proc runAsync*(self: Server) =
  soup_server_run_async(cast[ptr Server00](self.impl))

proc soup_server_set_ssl_cert_file(self: ptr Server00; sslCertFile: cstring;
    sslKeyFile: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setSslCertFile*(self: Server; sslCertFile: cstring; sslKeyFile: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_set_ssl_cert_file(cast[ptr Server00](self.impl), sslCertFile, sslKeyFile, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_unpause_message(self: ptr Server00; msg: ptr Message00) {.
    importc, libprag.}

proc unpauseMessage*(self: Server; msg: Message) =
  soup_server_unpause_message(cast[ptr Server00](self.impl), cast[ptr Message00](msg.impl))

type
  ServerListenOptions* {.size: sizeof(cint), pure.} = enum
    https = 1
    ipv4Only = 2
    ipv6Only = 4

proc soup_server_listen(self: ptr Server00; address: ptr gio.SocketAddress00;
    options: ServerListenOptions; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listen*(self: Server; address: gio.SocketAddress; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen(cast[ptr Server00](self.impl), cast[ptr gio.SocketAddress00](address.impl), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_listen_all(self: ptr Server00; port: uint32; options: ServerListenOptions;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listenAll*(self: Server; port: int; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen_all(cast[ptr Server00](self.impl), uint32(port), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_listen_fd(self: ptr Server00; fd: int32; options: ServerListenOptions;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listenFd*(self: Server; fd: int; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen_fd(cast[ptr Server00](self.impl), int32(fd), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_listen_local(self: ptr Server00; port: uint32; options: ServerListenOptions;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listenLocal*(self: Server; port: int; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen_local(cast[ptr Server00](self.impl), uint32(port), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_server_listen_socket(self: ptr Server00; socket: ptr gio.Socket00;
    options: ServerListenOptions; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc listenSocket*(self: Server; socket: gio.Socket; options: ServerListenOptions): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_server_listen_socket(cast[ptr Server00](self.impl), cast[ptr gio.Socket00](socket.impl), options, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  ServerCallback* = proc (server: ptr Server00; msg: ptr Message00; path: cstring; query: ptr HashTable00;
    client: ptr ClientContext00; userData: pointer) {.cdecl.}

proc soup_server_add_early_handler(self: ptr Server00; path: cstring; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc addEarlyHandler*(self: Server; path: cstring = nil; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) =
  soup_server_add_early_handler(cast[ptr Server00](self.impl), path, callback, userData, destroy)

proc soup_server_add_handler(self: ptr Server00; path: cstring; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc addHandler*(self: Server; path: cstring = nil; callback: ServerCallback;
    userData: pointer; destroy: DestroyNotify) =
  soup_server_add_handler(cast[ptr Server00](self.impl), path, callback, userData, destroy)

type
  ServerWebsocketCallback* = proc (server: ptr Server00; connection: ptr WebsocketConnection00; path: cstring;
    client: ptr ClientContext00; userData: pointer) {.cdecl.}

proc soup_server_add_websocket_handler(self: ptr Server00; path: cstring;
    origin: cstring; protocols: ptr cstring; callback: ServerWebsocketCallback;
    userData: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc addWebsocketHandler*(self: Server; path: cstring = nil;
    origin: cstring = nil; protocols: openArray[string]; callback: ServerWebsocketCallback;
    userData: pointer; destroy: DestroyNotify) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  soup_server_add_websocket_handler(cast[ptr Server00](self.impl), path, origin, seq2CstringArray(protocols, fs469n23), callback, userData, destroy)

type
  SessionAsync* = ref object of Session
  SessionAsync00* = object of Session00

proc soup_session_async_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SessionAsync()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_session_async_new(): ptr SessionAsync00 {.
    importc, libprag.}

proc newSessionAsync*(): SessionAsync {.deprecated.}  =
  let gobj = soup_session_async_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSessionAsync*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is SessionAsync)
  let gobj = soup_session_async_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSessionAsync*[T](result: var T) {.deprecated.} =
  assert(result is SessionAsync)
  let gobj = soup_session_async_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SessionCallback* = proc (session: ptr Session00; msg: ptr Message00; userData: pointer) {.cdecl.}

proc soup_session_queue_message(self: ptr Session00; msg: ptr Message00;
    callback: SessionCallback; userData: pointer) {.
    importc, libprag.}

proc queueMessage*(self: Session; msg: Message; callback: SessionCallback;
    userData: pointer) =
  soup_session_queue_message(cast[ptr Session00](self.impl), cast[ptr Message00](g_object_ref(msg.impl)), callback, userData)

type
  SessionConnectProgressCallback* = proc (session: ptr Session00; event: gio.SocketClientEvent; connection: ptr gio.IOStream00;
    userData: pointer) {.cdecl.}

proc soup_session_connect_async(self: ptr Session00; uri: ptr URI00; cancellable: ptr gio.Cancellable00;
    progressCallback: SessionConnectProgressCallback; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc connectAsync*(self: Session; uri: URI; cancellable: gio.Cancellable = nil;
    progressCallback: SessionConnectProgressCallback; callback: AsyncReadyCallback;
    userData: pointer) =
  soup_session_connect_async(cast[ptr Session00](self.impl), cast[ptr URI00](uri.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), progressCallback, callback, userData)

type
  SessionSync* = ref object of Session
  SessionSync00* = object of Session00

proc soup_session_sync_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SessionSync()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc soup_session_sync_new(): ptr SessionSync00 {.
    importc, libprag.}

proc newSessionSync*(): SessionSync {.deprecated.}  =
  let gobj = soup_session_sync_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSessionSync*(tdesc: typedesc): tdesc {.deprecated.}  =
  assert(result is SessionSync)
  let gobj = soup_session_sync_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSessionSync*[T](result: var T) {.deprecated.} =
  assert(result is SessionSync)
  let gobj = soup_session_sync_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SocketCallback* = proc (sock: ptr Socket00; status: uint32; userData: pointer) {.cdecl.}

proc soup_socket_connect_async(self: ptr Socket00; cancellable: ptr gio.Cancellable00;
    callback: SocketCallback; userData: pointer) {.
    importc, libprag.}

proc connectAsync*(self: Socket; cancellable: gio.Cancellable = nil;
    callback: SocketCallback; userData: pointer) =
  soup_socket_connect_async(cast[ptr Socket00](self.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  Status* {.size: sizeof(cint), pure.} = enum
    none = 0
    cancelled = 1
    cantResolve = 2
    cantResolveProxy = 3
    cantConnect = 4
    cantConnectProxy = 5
    sslFailed = 6
    ioError = 7
    malformed = 8
    tryAgain = 9
    tooManyRedirects = 10
    tlsFailed = 11
    `continue` = 100
    switchingProtocols = 101
    processing = 102
    ok = 200
    created = 201
    accepted = 202
    nonAuthoritative = 203
    noContent = 204
    resetContent = 205
    partialContent = 206
    multiStatus = 207
    multipleChoices = 300
    movedPermanently = 301
    found = 302
    seeOther = 303
    notModified = 304
    useProxy = 305
    notAppearingInThisProtocol = 306
    temporaryRedirect = 307
    permanentRedirect = 308
    badRequest = 400
    unauthorized = 401
    paymentRequired = 402
    forbidden = 403
    notFound = 404
    methodNotAllowed = 405
    notAcceptable = 406
    proxyAuthenticationRequired = 407
    requestTimeout = 408
    conflict = 409
    gone = 410
    lengthRequired = 411
    preconditionFailed = 412
    requestEntityTooLarge = 413
    requestUriTooLong = 414
    unsupportedMediaType = 415
    invalidRange = 416
    expectationFailed = 417
    unprocessableEntity = 422
    locked = 423
    failedDependency = 424
    internalServerError = 500
    notImplemented = 501
    badGateway = 502
    serviceUnavailable = 503
    gatewayTimeout = 504
    httpVersionNotSupported = 505
    insufficientStorage = 507
    notExtended = 510

const
  StatusRequestedRangeNotSatisfiable* = Status.invalidRange
  StatusMovedTemporarily* = Status.found
  StatusProxyUnauthorized* = Status.proxyAuthenticationRequired

proc soup_status_get_phrase(statusCode: uint32): cstring {.
    importc, libprag.}

proc getPhrase*(statusCode: int): string =
  result = $soup_status_get_phrase(uint32(statusCode))

proc phrase*(statusCode: int): string =
  result = $soup_status_get_phrase(uint32(statusCode))

proc soup_status_proxify(statusCode: uint32): uint32 {.
    importc, libprag.}

proc proxify*(statusCode: int): int =
  int(soup_status_proxify(uint32(statusCode)))

type
  TLDError* {.size: sizeof(cint), pure.} = enum
    invalidHostname = 0
    isIpAddress = 1
    notEnoughDomains = 2
    noBaseDomain = 3
    noPslData = 4

const VERSION_MIN_REQUIRED_STR* = 2'i32

type
  WebsocketCloseCode* {.size: sizeof(cint), pure.} = enum
    normal = 1000
    goingAway = 1001
    protocolError = 1002
    unsupportedData = 1003
    noStatus = 1005
    abnormal = 1006
    badData = 1007
    policyViolation = 1008
    tooBig = 1009
    noExtension = 1010
    serverError = 1011
    tlsHandshake = 1015

type
  WebsocketError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    notWebsocket = 1
    badHandshake = 2
    badOrigin = 3

proc soup_websocket_error_get_quark(): uint32 {.
    importc, libprag.}

proc getQuark*(): int =
  int(soup_websocket_error_get_quark())

type
  WebsocketExtensionDeflate* = ref object of WebsocketExtension
  WebsocketExtensionDeflate00* = object of WebsocketExtension00

proc soup_websocket_extension_deflate_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebsocketExtensionDeflate()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  XMLRPCError* {.size: sizeof(cint), pure.} = enum
    arguments = 0
    retval = 1

type
  XMLRPCFault* {.size: sizeof(cint), pure.} = enum
    parseErrorInvalidCharacterForEncoding = -32702
    parseErrorUnsupportedEncoding = -32701
    parseErrorNotWellFormed = -32700
    serverErrorInternalXmlRpcError = -32603
    serverErrorInvalidMethodParameters = -32602
    serverErrorRequestedMethodNotFound = -32601
    serverErrorInvalidXmlRpc = -32600
    applicationError = -32500
    systemError = -32400
    transportError = -32300

type
  XMLRPCParams00* {.pure.} = object
  XMLRPCParams* = ref object
    impl*: ptr XMLRPCParams00
    ignoreFinalizer*: bool

proc soup_xmlrpc_params_free(self: ptr XMLRPCParams00) {.
    importc, libprag.}

proc free*(self: XMLRPCParams) =
  soup_xmlrpc_params_free(cast[ptr XMLRPCParams00](self.impl))

proc finalizerfree*(self: XMLRPCParams) =
  if not self.ignoreFinalizer:
    soup_xmlrpc_params_free(cast[ptr XMLRPCParams00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(XMLRPCParams()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      soup_xmlrpc_params_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var XMLRPCParams) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc soup_xmlrpc_params_parse(self: ptr XMLRPCParams00; signature: cstring;
    error: ptr ptr glib.Error = nil): ptr glib.Variant00 {.
    importc, libprag.}

proc parse*(self: XMLRPCParams; signature: cstring = nil): glib.Variant =
  var gerror: ptr glib.Error
  let impl0 = soup_xmlrpc_params_parse(cast[ptr XMLRPCParams00](self.impl), signature, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, finalizerunref)
  result.impl = impl0

proc soup_check_version(major: uint32; minor: uint32; micro: uint32): gboolean {.
    importc, libprag.}

proc checkVersion*(major: int; minor: int; micro: int): bool =
  toBool(soup_check_version(uint32(major), uint32(minor), uint32(micro)))

proc soup_cookies_from_request(msg: ptr Message00): ptr glib.SList {.
    importc, libprag.}

proc cookiesFromRequest*(msg: Message): seq[Cookie] =
  let resul0 = soup_cookies_from_request(cast[ptr Message00](msg.impl))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookies_from_response(msg: ptr Message00): ptr glib.SList {.
    importc, libprag.}

proc cookiesFromResponse*(msg: Message): seq[Cookie] =
  let resul0 = soup_cookies_from_response(cast[ptr Message00](msg.impl))
  result = gslistStructs2seq[Cookie](resul0, false)
  g_slist_free(resul0)

proc soup_cookies_to_cookie_header(cookies: ptr glib.SList): cstring {.
    importc, libprag.}

proc cookiesToCookieHeader*(cookies: seq[Cookie]): string =
  var tempResGL = seq2GSList(cookies)
  let resul0 = soup_cookies_to_cookie_header(tempResGL)
  g_slist_free(tempResGL)
  result = $resul0
  cogfree(resul0)

proc soup_cookies_to_request(cookies: ptr glib.SList; msg: ptr Message00) {.
    importc, libprag.}

proc cookiesToRequest*(cookies: seq[Cookie]; msg: Message) =
  var tempResGL = seq2GSList(cookies)
  soup_cookies_to_request(tempResGL, cast[ptr Message00](msg.impl))
  g_slist_free(tempResGL)

proc soup_cookies_to_response(cookies: ptr glib.SList; msg: ptr Message00) {.
    importc, libprag.}

proc cookiesToResponse*(cookies: seq[Cookie]; msg: Message) =
  var tempResGL = seq2GSList(cookies)
  soup_cookies_to_response(tempResGL, cast[ptr Message00](msg.impl))
  g_slist_free(tempResGL)

proc formDecode*(encodedForm: cstring): ptr HashTable00 {.
    importc: "soup_form_decode", libprag.}

proc soup_form_decode_multipart(msg: ptr Message00; fileControlName: cstring;
    filename: var cstring; contentType: var cstring; file: var ptr Buffer00): ptr HashTable00 {.
    importc, libprag.}

proc formDecodeMultipart*(msg: Message; fileControlName: cstring = nil;
    filename: var string = cast[var string](nil); contentType: var string = cast[var string](nil);
    file: var Buffer = cast[var Buffer](nil)): ptr HashTable00 =
  if addr(file) != nil:
    fnew(file, gBoxedFreeSoupBuffer)
  var filename_00: cstring
  var contentType_00: cstring
  let resul0 = soup_form_decode_multipart(cast[ptr Message00](msg.impl), fileControlName, filename_00, contentType_00, cast[var ptr Buffer00](if addr(file) == nil: nil else: addr file.impl))
  if resul0.isNil:
    return
  result = resul0
  if filename.addr != nil:
    filename = $(filename_00)
  if contentType.addr != nil:
    contentType = $(contentType_00)

proc soup_form_encode_datalist(formDataSet: glib.Data): cstring {.
    importc, libprag.}

proc formEncodeDatalist*(formDataSet: glib.Data): string =
  let resul0 = soup_form_encode_datalist(formDataSet)
  result = $resul0
  cogfree(resul0)

proc soup_form_encode_hash(formDataSet: ptr HashTable00): cstring {.
    importc, libprag.}

proc formEncodeHash*(formDataSet: ptr HashTable00): string =
  let resul0 = soup_form_encode_hash(formDataSet)
  result = $resul0
  cogfree(resul0)

proc soup_form_request_new_from_datalist(`method`: cstring; uri: cstring;
    formDataSet: glib.Data): ptr Message00 {.
    importc, libprag.}

proc formRequestNewFromDatalist*(`method`: cstring; uri: cstring;
    formDataSet: glib.Data): Message =
  let gobj = soup_form_request_new_from_datalist(`method`, uri, formDataSet)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_form_request_new_from_hash(`method`: cstring; uri: cstring; formDataSet: ptr HashTable00): ptr Message00 {.
    importc, libprag.}

proc formRequestNewFromHash*(`method`: cstring; uri: cstring; formDataSet: ptr HashTable00): Message =
  let gobj = soup_form_request_new_from_hash(`method`, uri, formDataSet)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_form_request_new_from_multipart(uri: cstring; multipart: ptr Multipart00): ptr Message00 {.
    importc, libprag.}

proc formRequestNewFromMultipart*(uri: cstring; multipart: Multipart): Message =
  let gobj = soup_form_request_new_from_multipart(uri, cast[ptr Multipart00](multipart.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(soup_get_major_version())

proc soup_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(soup_get_micro_version())

proc soup_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(soup_get_minor_version())

proc soup_get_resource(): ptr gio.Resource00 {.
    importc, libprag.}

proc getResource*(): gio.Resource =
  fnew(result, gBoxedFreeGResource)
  result.impl = soup_get_resource()

proc soup_header_contains(header: cstring; token: cstring): gboolean {.
    importc, libprag.}

proc headerContains*(header: cstring; token: cstring): bool =
  toBool(soup_header_contains(header, token))

proc headerFreeParamList*(paramList: ptr HashTable00) {.
    importc: "soup_header_free_param_list", libprag.}

proc headerGStringAppendParam*(string: glib.String; name: cstring;
    value: cstring) {.
    importc: "soup_header_g_string_append_param", libprag.}

proc headerGStringAppendParamQuoted*(string: glib.String; name: cstring;
    value: cstring) {.
    importc: "soup_header_g_string_append_param_quoted", libprag.}

proc headerParseList*(header: cstring): ptr glib.SList {.
    importc: "soup_header_parse_list", libprag.}

proc headerParseParamList*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_param_list", libprag.}

proc headerParseParamListStrict*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_param_list_strict", libprag.}

proc headerParseQualityList*(header: cstring; unacceptable: var ptr glib.SList): ptr glib.SList {.
    importc: "soup_header_parse_quality_list", libprag.}

proc headerParseSemiParamList*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_semi_param_list", libprag.}

proc headerParseSemiParamListStrict*(header: cstring): ptr HashTable00 {.
    importc: "soup_header_parse_semi_param_list_strict", libprag.}

proc soup_headers_parse(str: cstring; len: int32; dest: ptr MessageHeaders00): gboolean {.
    importc, libprag.}

proc headersParse*(str: cstring; len: int; dest: MessageHeaders): bool =
  toBool(soup_headers_parse(str, int32(len), cast[ptr MessageHeaders00](dest.impl)))

proc soup_headers_parse_request(str: cstring; len: int32; reqHeaders: ptr MessageHeaders00;
    reqMethod: var cstring; reqPath: var cstring; ver: var HTTPVersion): uint32 {.
    importc, libprag.}

proc headersParseRequest*(str: cstring; len: int; reqHeaders: MessageHeaders;
    reqMethod: var string = cast[var string](nil); reqPath: var string = cast[var string](nil);
    ver: var HTTPVersion = cast[var HTTPVersion](nil)): int =
  var reqPath_00: cstring
  var reqMethod_00: cstring
  result = int(soup_headers_parse_request(str, int32(len), cast[ptr MessageHeaders00](reqHeaders.impl), reqMethod_00, reqPath_00, ver))
  if reqPath.addr != nil:
    reqPath = $(reqPath_00)
  if reqMethod.addr != nil:
    reqMethod = $(reqMethod_00)

proc soup_headers_parse_response(str: cstring; len: int32; headers: ptr MessageHeaders00;
    ver: var HTTPVersion; statusCode: var uint32; reasonPhrase: var cstring): gboolean {.
    importc, libprag.}

proc headersParseResponse*(str: cstring; len: int; headers: MessageHeaders;
    ver: var HTTPVersion = cast[var HTTPVersion](nil); statusCode: var int = cast[var int](nil);
    reasonPhrase: var string = cast[var string](nil)): bool =
  var reasonPhrase_00: cstring
  var statusCode_00: uint32
  result = toBool(soup_headers_parse_response(str, int32(len), cast[ptr MessageHeaders00](headers.impl), ver, statusCode_00, reasonPhrase_00))
  if reasonPhrase.addr != nil:
    reasonPhrase = $(reasonPhrase_00)
  if statusCode.addr != nil:
    statusCode = int(statusCode_00)

proc soup_headers_parse_status_line(statusLine: cstring; ver: var HTTPVersion;
    statusCode: var uint32; reasonPhrase: var cstring): gboolean {.
    importc, libprag.}

proc headersParseStatusLine*(statusLine: cstring; ver: var HTTPVersion = cast[var HTTPVersion](nil);
    statusCode: var int = cast[var int](nil); reasonPhrase: var string = cast[var string](nil)): bool =
  var reasonPhrase_00: cstring
  var statusCode_00: uint32
  result = toBool(soup_headers_parse_status_line(statusLine, ver, statusCode_00, reasonPhrase_00))
  if reasonPhrase.addr != nil:
    reasonPhrase = $(reasonPhrase_00)
  if statusCode.addr != nil:
    statusCode = int(statusCode_00)

proc soup_http_error_quark(): uint32 {.
    importc, libprag.}

proc httpErrorQuark*(): int =
  int(soup_http_error_quark())

proc soup_str_case_equal(v1: pointer; v2: pointer): gboolean {.
    importc, libprag.}

proc strCaseEqual*(v1: pointer; v2: pointer): bool =
  toBool(soup_str_case_equal(v1, v2))

proc soup_str_case_hash(key: pointer): uint32 {.
    importc, libprag.}

proc strCaseHash*(key: pointer): int =
  int(soup_str_case_hash(key))

proc soup_tld_domain_is_public_suffix(domain: cstring): gboolean {.
    importc, libprag.}

proc tldDomainIsPublicSuffix*(domain: cstring): bool =
  toBool(soup_tld_domain_is_public_suffix(domain))

proc soup_tld_get_base_domain(hostname: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc tldGetBaseDomain*(hostname: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = soup_tld_get_base_domain(hostname, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0

proc soup_value_array_new(): ptr gobject.ValueArray00 {.
    importc, libprag.}

proc newValueArray*(): gobject.ValueArray =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = soup_value_array_new()

proc valueHashInsertValue*(hash: ptr HashTable00; key: cstring; value: gobject.Value) {.
    importc: "soup_value_hash_insert_value", libprag.}

proc valueHashNew*(): ptr HashTable00 {.
    importc: "soup_value_hash_new", libprag.}

proc soup_websocket_client_prepare_handshake(msg: ptr Message00; origin: cstring;
    protocols: ptr cstring) {.
    importc, libprag.}

proc websocketClientPrepareHandshake*(msg: Message; origin: cstring = nil;
    protocols: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  soup_websocket_client_prepare_handshake(cast[ptr Message00](msg.impl), origin, seq2CstringArray(protocols, fs469n23))

proc soup_websocket_client_prepare_handshake_with_extensions(msg: ptr Message00;
    origin: cstring; protocols: ptr cstring; supportedExtensions: ptr PtrArray00) {.
    importc, libprag.}

proc websocketClientPrepareHandshakeWithExtensions*(msg: Message;
    origin: cstring = nil; protocols: openArray[string]; supportedExtensions: ptr PtrArray00) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  soup_websocket_client_prepare_handshake_with_extensions(cast[ptr Message00](msg.impl), origin, seq2CstringArray(protocols, fs469n23), supportedExtensions)

proc soup_websocket_client_verify_handshake(msg: ptr Message00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc websocketClientVerifyHandshake*(msg: Message): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_client_verify_handshake(cast[ptr Message00](msg.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_client_verify_handshake_with_extensions(msg: ptr Message00;
    supportedExtensions: ptr PtrArray00; acceptedExtensions: var ptr glib.List;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc websocketClientVerifyHandshakeWithExtensions*(msg: Message;
    supportedExtensions: ptr PtrArray00; acceptedExtensions: var seq[WebsocketExtension] = cast[var seq[WebsocketExtension]](nil)): bool =
  var tempResGL = seq2GList(acceptedExtensions)
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_client_verify_handshake_with_extensions(cast[ptr Message00](msg.impl), supportedExtensions, tempResGL, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_server_check_handshake(msg: ptr Message00; origin: cstring;
    protocols: ptr cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc websocketServerCheckHandshake*(msg: Message; origin: cstring = nil;
    protocols: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_server_check_handshake(cast[ptr Message00](msg.impl), origin, seq2CstringArray(protocols, fs469n23), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_server_check_handshake_with_extensions(msg: ptr Message00;
    origin: cstring; protocols: ptr cstring; supportedExtensions: ptr PtrArray00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc websocketServerCheckHandshakeWithExtensions*(msg: Message;
    origin: cstring = nil; protocols: openArray[string]; supportedExtensions: ptr PtrArray00): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let resul0 = soup_websocket_server_check_handshake_with_extensions(cast[ptr Message00](msg.impl), origin, seq2CstringArray(protocols, fs469n23), supportedExtensions, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_websocket_server_process_handshake(msg: ptr Message00; expectedOrigin: cstring;
    protocols: ptr cstring): gboolean {.
    importc, libprag.}

proc websocketServerProcessHandshake*(msg: Message; expectedOrigin: cstring = nil;
    protocols: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  toBool(soup_websocket_server_process_handshake(cast[ptr Message00](msg.impl), expectedOrigin, seq2CstringArray(protocols, fs469n23)))

proc soup_websocket_server_process_handshake_with_extensions(msg: ptr Message00;
    expectedOrigin: cstring; protocols: ptr cstring; supportedExtensions: ptr PtrArray00;
    acceptedExtensions: var ptr glib.List): gboolean {.
    importc, libprag.}

proc websocketServerProcessHandshakeWithExtensions*(msg: Message;
    expectedOrigin: cstring = nil; protocols: openArray[string]; supportedExtensions: ptr PtrArray00;
    acceptedExtensions: var seq[WebsocketExtension] = cast[var seq[WebsocketExtension]](nil)): bool =
  var tempResGL = seq2GList(acceptedExtensions)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  toBool(soup_websocket_server_process_handshake_with_extensions(cast[ptr Message00](msg.impl), expectedOrigin, seq2CstringArray(protocols, fs469n23), supportedExtensions, tempResGL))

proc soup_xmlrpc_build_method_call(methodName: cstring; params: ptr gobject.Value;
    nParams: int32): cstring {.
    importc, libprag.}

proc xmlrpcBuildMethodCall*(methodName: cstring; params: ptr gobject.Value;
    nParams: int): string =
  let resul0 = soup_xmlrpc_build_method_call(methodName, params, int32(nParams))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_xmlrpc_build_method_response(value: gobject.Value): cstring {.
    importc, libprag.}

proc xmlrpcBuildMethodResponse*(value: gobject.Value): string =
  let resul0 = soup_xmlrpc_build_method_response(value)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc soup_xmlrpc_build_request(methodName: cstring; params: ptr glib.Variant00;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc xmlrpcBuildRequest*(methodName: cstring; params: glib.Variant): string =
  var gerror: ptr glib.Error
  let resul0 = soup_xmlrpc_build_request(methodName, cast[ptr glib.Variant00](params.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc soup_xmlrpc_build_response(value: ptr glib.Variant00; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc xmlrpcBuildResponse*(value: glib.Variant): string =
  var gerror: ptr glib.Error
  let resul0 = soup_xmlrpc_build_response(cast[ptr glib.Variant00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc soup_xmlrpc_message_new(uri: cstring; methodName: cstring; params: ptr glib.Variant00;
    error: ptr ptr glib.Error = nil): ptr Message00 {.
    importc, libprag.}

proc newXmlrpcMessage*(uri: cstring; methodName: cstring; params: glib.Variant): Message =
  var gerror: ptr glib.Error
  let gobj = soup_xmlrpc_message_new(uri, methodName, cast[ptr glib.Variant00](params.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, soup.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc soup_xmlrpc_message_set_response(msg: ptr Message00; value: ptr glib.Variant00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc xmlrpcMessageSetResponse*(msg: Message; value: glib.Variant): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_xmlrpc_message_set_response(cast[ptr Message00](msg.impl), cast[ptr glib.Variant00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_xmlrpc_parse_method_call(methodCall: cstring; length: int32; methodName: var cstring;
    params: var ptr gobject.ValueArray00): gboolean {.
    importc, libprag.}

proc xmlrpcParseMethodCall*(methodCall: cstring; length: int; methodName: var string;
    params: var gobject.ValueArray): bool =
  fnew(params, gBoxedFreeGValueArray)
  var methodName_00: cstring
  result = toBool(soup_xmlrpc_parse_method_call(methodCall, int32(length), methodName_00, cast[var ptr gobject.ValueArray00](addr params.impl)))
  if methodName.addr != nil:
    methodName = $(methodName_00)

proc soup_xmlrpc_parse_method_response(methodResponse: cstring; length: int32;
    value: var gobject.Value; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc xmlrpcParseMethodResponse*(methodResponse: cstring; length: int;
    value: var gobject.Value): bool =
  var gerror: ptr glib.Error
  let resul0 = soup_xmlrpc_parse_method_response(methodResponse, int32(length), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc soup_xmlrpc_parse_request(methodCall: cstring; length: int32; params: var ptr XMLRPCParams00;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc xmlrpcParseRequest*(methodCall: cstring; length: int; params: var XMLRPCParams): string =
  fnew(params, finalizerfree)
  var gerror: ptr glib.Error
  let resul0 = soup_xmlrpc_parse_request(methodCall, int32(length), cast[var ptr XMLRPCParams00](addr params.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc soup_xmlrpc_parse_response(methodResponse: cstring; length: int32; signature: cstring;
    error: ptr ptr glib.Error = nil): ptr glib.Variant00 {.
    importc, libprag.}

proc xmlrpcParseResponse*(methodResponse: cstring; length: int; signature: cstring = nil): glib.Variant =
  var gerror: ptr glib.Error
  let impl0 = soup_xmlrpc_parse_response(methodResponse, int32(length), signature, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, finalizerunref)
  result.impl = impl0

proc soup_xmlrpc_variant_get_datetime(variant: ptr glib.Variant00; error: ptr ptr glib.Error = nil): ptr Date00 {.
    importc, libprag.}

proc xmlrpcVariantGetDatetime*(variant: glib.Variant): Date =
  var gerror: ptr glib.Error
  let impl0 = soup_xmlrpc_variant_get_datetime(cast[ptr glib.Variant00](variant.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeSoupDate)
  result.impl = impl0

proc soup_xmlrpc_variant_new_datetime(date: ptr Date00): ptr glib.Variant00 {.
    importc, libprag.}

proc xmlrpcVariantNewDatetime*(date: Date): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = soup_xmlrpc_variant_new_datetime(cast[ptr Date00](date.impl))
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc socketConnectable*(x: soup.Address): gio.SocketConnectable = cast[gio.SocketConnectable](x)

proc pollableInputStream*(x: soup.MultipartInputStream): gio.PollableInputStream = cast[gio.PollableInputStream](x)

proc initable*(x: soup.Request): gio.Initable = cast[gio.Initable](x)

proc initable*(x: soup.RequestData): gio.Initable = cast[gio.Initable](x)

proc initable*(x: soup.RequestFile): gio.Initable = cast[gio.Initable](x)

proc initable*(x: soup.RequestHTTP): gio.Initable = cast[gio.Initable](x)

proc initable*(x: soup.Socket): gio.Initable = cast[gio.Initable](x)
