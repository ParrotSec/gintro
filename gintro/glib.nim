# dependencies:
# immediate dependencies:
# libraries:
# libgobject-2.0.so.0,libglib-2.0.so.0
{.warning[UnusedImport]: off.}

const Lib = "libglib-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
const GobjectLib* = "libgobject-2.0.so.0"
{.pragma: gobjectlibprag, cdecl, dynlib: GobjectLib.}
type
  GException* = object of CatchableError
type
  GArray00* = pointer
type
  ucstring* = distinct cstring
type
  gboolean* = distinct cint
const
  GLIB_SIZEOF_VOID_P = sizeof(pointer)
const
  GLIB_SIZEOF_SIZE_T* = GLIB_SIZEOF_VOID_P
const
  GLIB_SIZEOF_LONG* = sizeof(clong)
type
  Gssize* = int # csize
type
  Gsize* = uint # csize # note: csize is signed in Nim!
when GLIB_SIZEOF_SIZE_T != GLIB_SIZEOF_LONG or not defined(cpp):
  type
    GType* = Gsize
else:
  type
    GType* = culong
type
  gunichar* = uint32
type
  utf8* = char
const GFalse* = gboolean(0)
const GTrue* = gboolean(1)

proc boxedFree(boxedType: GType; boxed: pointer) {.
    importc: "g_boxed_free", gobjectlibprag.}

proc g_boxed_copy(boxedType: GType; boxed: pointer): pointer {.
    importc , gobjectlibprag.}
#proc fnew*[T](a: var ref T; finalizer: proc (x: ref T)) =
template fnew*(a: untyped; finalizer: untyped) =
  when defined(gcDestructors):
    system.new(a)
  else:
    new(a, finalizer)

proc int32ArrayZT2seq*(p: pointer): seq[int32] =
  let a = cast[ptr UncheckedArray[int32]](p)
  var i: int
  while true:
    if a[i] == 0:
      break
    result.add(a[i])
    inc(i)

proc uint32ArrayZT2seq*(p: pointer): seq[uint32] =
  let a = cast[ptr UncheckedArray[uint32]](p)
  var i: int
  while true:
    if a[i] == 0:
      break
    result.add(a[i])
    inc(i)

proc uint8ArrayZT2seq*(p: pointer): seq[uint8] =
  let a = cast[ptr UncheckedArray[uint8]](p)
  var i: int
  while true:
    if a[i] == 0:
      break
    result.add(a[i])
    inc(i)

proc uint8ArrayToSeq*(s: ptr uint8; n: int): seq[uint8] =
  let a = cast[ptr UncheckedArray[uint8]](s)
  for i in 0 ..< n:
    result.add(a[i])

proc uint32ArrayToSeq*(s: ptr uint32; n: int): seq[uint32] =
  let a = cast[ptr UncheckedArray[uint32]](s)
  for i in 0 ..< n:
    result.add(a[i])

proc int32ArrayToSeq*(s: ptr int32; n: int): seq[int32] =
  let a = cast[ptr UncheckedArray[int32]](s)
  for i in 0 ..< n:
    result.add(a[i])

proc cstringArrayToSeq*(s: ptr cstring): seq[string] =
  system.cstringArrayToSeq(cast[cstringArray](s))

proc cogfree*(mem: pointer) {.importc: "g_free", libprag.}
proc g_strfreev*(strArray: ptr cstring) {.importc: "g_strfreev", libprag.}
proc toBool*(g: gboolean): bool = g.int != 0

proc seq2cstringArray*(s: openarray[string]; a: var cstringArray): ptr cstring =
  assert s.high < 256 - 1
  let x = cast[ptr UncheckedArray[string]](s)
  for i in 0 .. s.high:
    a[i] = addr(x[i][0])
  a[s.len] = nil
  return cast[ptr cstring](a)
    


type
  Error* {.pure, byRef.} = object
    domain*: uint32
    code*: int32
    message*: cstring

proc g_error_get_type*(): GType {.importc, gobjectlibprag.}

proc g_error_free*(self: Error) {.
    importc, libprag.}

proc free*(self: Error) =
  g_error_free(self)

proc g_error_copy(self: Error): ptr glib.Error {.
    importc, libprag.}

proc copy*(self: Error): ptr glib.Error =
  g_error_copy(self)

proc g_error_matches(self: Error; domain: uint32; code: int32): gboolean {.
    importc, libprag.}

proc matches*(self: Error; domain: int; code: int): bool =
  toBool(g_error_matches(self, uint32(domain), int32(code)))

const ANALYZER_ANALYZING* = 1'i32

const ASCII_DTOSTR_BUF_SIZE* = 39'i32

type
  Array00* {.pure.} = object
  Array* = ref object
    impl*: ptr Array00
    ignoreFinalizer*: bool

proc g_array_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGArray*(self: Array) =
  if not self.ignoreFinalizer:
    boxedFree(g_array_get_type(), cast[ptr Array00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Array()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_array_get_type(), cast[ptr Array00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Array) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGArray)

type
  AsciiType* {.size: sizeof(cint), pure.} = enum
    alnum = 1
    alpha = 2
    cntrl = 4
    digit = 8
    graph = 16
    lower = 32
    print = 64
    punct = 128
    space = 256
    upper = 512
    xdigit = 1024

type
  AsyncQueue00* {.pure.} = object
  AsyncQueue* = ref object
    impl*: ptr AsyncQueue00
    ignoreFinalizer*: bool

proc g_async_queue_unref(self: ptr AsyncQueue00) {.
    importc, libprag.}

proc unref*(self: AsyncQueue) =
  g_async_queue_unref(cast[ptr AsyncQueue00](self.impl))

proc finalizerunref*(self: AsyncQueue) =
  if not self.ignoreFinalizer:
    g_async_queue_unref(cast[ptr AsyncQueue00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AsyncQueue()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_async_queue_unref(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var AsyncQueue) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerunref)

proc g_async_queue_length_unlocked(self: ptr AsyncQueue00): int32 {.
    importc, libprag.}

proc lengthUnlocked*(self: AsyncQueue): int =
  int(g_async_queue_length_unlocked(cast[ptr AsyncQueue00](self.impl)))

proc g_async_queue_lock(self: ptr AsyncQueue00) {.
    importc, libprag.}

proc lock*(self: AsyncQueue) =
  g_async_queue_lock(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_pop(self: ptr AsyncQueue00): pointer {.
    importc, libprag.}

proc pop*(self: AsyncQueue): pointer =
  g_async_queue_pop(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_pop_unlocked(self: ptr AsyncQueue00): pointer {.
    importc, libprag.}

proc popUnlocked*(self: AsyncQueue): pointer =
  g_async_queue_pop_unlocked(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_push(self: ptr AsyncQueue00; data: pointer) {.
    importc, libprag.}

proc push*(self: AsyncQueue; data: pointer) =
  g_async_queue_push(cast[ptr AsyncQueue00](self.impl), data)

proc g_async_queue_push_front(self: ptr AsyncQueue00; item: pointer) {.
    importc, libprag.}

proc pushFront*(self: AsyncQueue; item: pointer) =
  g_async_queue_push_front(cast[ptr AsyncQueue00](self.impl), item)

proc g_async_queue_push_front_unlocked(self: ptr AsyncQueue00; item: pointer) {.
    importc, libprag.}

proc pushFrontUnlocked*(self: AsyncQueue; item: pointer) =
  g_async_queue_push_front_unlocked(cast[ptr AsyncQueue00](self.impl), item)

proc g_async_queue_push_unlocked(self: ptr AsyncQueue00; data: pointer) {.
    importc, libprag.}

proc pushUnlocked*(self: AsyncQueue; data: pointer) =
  g_async_queue_push_unlocked(cast[ptr AsyncQueue00](self.impl), data)

proc g_async_queue_ref_unlocked(self: ptr AsyncQueue00) {.
    importc, libprag.}

proc refUnlocked*(self: AsyncQueue) =
  g_async_queue_ref_unlocked(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_remove(self: ptr AsyncQueue00; item: pointer): gboolean {.
    importc, libprag.}

proc remove*(self: AsyncQueue; item: pointer): bool =
  toBool(g_async_queue_remove(cast[ptr AsyncQueue00](self.impl), item))

proc g_async_queue_remove_unlocked(self: ptr AsyncQueue00; item: pointer): gboolean {.
    importc, libprag.}

proc removeUnlocked*(self: AsyncQueue; item: pointer): bool =
  toBool(g_async_queue_remove_unlocked(cast[ptr AsyncQueue00](self.impl), item))

proc g_async_queue_timeout_pop(self: ptr AsyncQueue00; timeout: uint64): pointer {.
    importc, libprag.}

proc timeoutPop*(self: AsyncQueue; timeout: uint64): pointer =
  g_async_queue_timeout_pop(cast[ptr AsyncQueue00](self.impl), timeout)

proc g_async_queue_timeout_pop_unlocked(self: ptr AsyncQueue00; timeout: uint64): pointer {.
    importc, libprag.}

proc timeoutPopUnlocked*(self: AsyncQueue; timeout: uint64): pointer =
  g_async_queue_timeout_pop_unlocked(cast[ptr AsyncQueue00](self.impl), timeout)

proc g_async_queue_try_pop(self: ptr AsyncQueue00): pointer {.
    importc, libprag.}

proc tryPop*(self: AsyncQueue): pointer =
  g_async_queue_try_pop(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_try_pop_unlocked(self: ptr AsyncQueue00): pointer {.
    importc, libprag.}

proc tryPopUnlocked*(self: AsyncQueue): pointer =
  g_async_queue_try_pop_unlocked(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_unlock(self: ptr AsyncQueue00) {.
    importc, libprag.}

proc unlock*(self: AsyncQueue) =
  g_async_queue_unlock(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_length(self: ptr AsyncQueue00): int32 {.
    importc, libprag.}

proc length*(self: AsyncQueue): int =
  int(g_async_queue_length(cast[ptr AsyncQueue00](self.impl)))

proc g_async_queue_unref_and_unlock(self: ptr AsyncQueue00) {.
    importc, libprag.}

proc unrefAndUnlock*(self: AsyncQueue) =
  g_async_queue_unref_and_unlock(cast[ptr AsyncQueue00](self.impl))

type
  TimeVal* {.pure, byRef.} = object
    tvSec*: int64
    tvUsec*: int64

proc g_time_val_add(self: TimeVal; microseconds: int64) {.
    importc, libprag.}

proc add*(self: TimeVal; microseconds: int64) =
  g_time_val_add(self, microseconds)

proc g_time_val_to_iso8601(self: TimeVal): cstring {.
    importc, libprag.}

proc toIso8601*(self: TimeVal): string =
  let resul0 = g_time_val_to_iso8601(self)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_time_val_from_iso8601(isoDate: cstring; time: var TimeVal): gboolean {.
    importc, libprag.}

proc fromIso8601*(isoDate: cstring; time: var TimeVal): bool =
  toBool(g_time_val_from_iso8601(isoDate, time))

proc g_async_queue_timed_pop(self: ptr AsyncQueue00; endTime: TimeVal): pointer {.
    importc, libprag.}

proc timedPop*(self: AsyncQueue; endTime: TimeVal): pointer =
  g_async_queue_timed_pop(cast[ptr AsyncQueue00](self.impl), endTime)

proc g_async_queue_timed_pop_unlocked(self: ptr AsyncQueue00; endTime: TimeVal): pointer {.
    importc, libprag.}

proc timedPopUnlocked*(self: AsyncQueue; endTime: TimeVal): pointer =
  g_async_queue_timed_pop_unlocked(cast[ptr AsyncQueue00](self.impl), endTime)

const BIG_ENDIAN* = 4321'i32

type
  BookmarkFile00* {.pure.} = object
  BookmarkFile* = ref object
    impl*: ptr BookmarkFile00
    ignoreFinalizer*: bool

proc g_bookmark_file_free(self: ptr BookmarkFile00) {.
    importc, libprag.}

proc free*(self: BookmarkFile) =
  g_bookmark_file_free(cast[ptr BookmarkFile00](self.impl))

proc finalizerfree*(self: BookmarkFile) =
  if not self.ignoreFinalizer:
    g_bookmark_file_free(cast[ptr BookmarkFile00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BookmarkFile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_bookmark_file_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var BookmarkFile) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_bookmark_file_add_group(self: ptr BookmarkFile00; uri: cstring; group: cstring) {.
    importc, libprag.}

proc addGroup*(self: BookmarkFile; uri: cstring; group: cstring) =
  g_bookmark_file_add_group(cast[ptr BookmarkFile00](self.impl), uri, group)

proc g_bookmark_file_add_application(self: ptr BookmarkFile00; uri: cstring;
    name: cstring; exec: cstring) {.
    importc, libprag.}

proc addApplication*(self: BookmarkFile; uri: cstring; name: cstring = nil;
    exec: cstring = nil) =
  g_bookmark_file_add_application(cast[ptr BookmarkFile00](self.impl), uri, name, exec)

proc g_bookmark_file_get_added(self: ptr BookmarkFile00; uri: cstring; error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc getAdded*(self: BookmarkFile; uri: cstring): int64 =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_added(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_bookmark_file_get_app_info(self: ptr BookmarkFile00; uri: cstring;
    name: cstring; exec: var cstring; count: var uint32; stamp: var int64;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getAppInfo*(self: BookmarkFile; uri: cstring; name: cstring;
    exec: var string = cast[var string](nil); count: var int = cast[var int](nil);
    stamp: var int64 = cast[var int64](nil)): bool =
  var gerror: ptr glib.Error
  var count_00: uint32
  var exec_00: cstring
  let resul0 = g_bookmark_file_get_app_info(cast[ptr BookmarkFile00](self.impl), uri, name, exec_00, count_00, stamp, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if count.addr != nil:
    count = int(count_00)
  if exec.addr != nil:
    exec = $(exec_00)

proc g_bookmark_file_get_applications(self: ptr BookmarkFile00; uri: cstring;
    length: var uint64; error: ptr ptr glib.Error = nil): ptr cstring {.
    importc, libprag.}

proc getApplications*(self: BookmarkFile; uri: cstring; length: var uint64 = cast[var uint64](nil)): seq[string] =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_applications(cast[ptr BookmarkFile00](self.impl), uri, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = cstringArrayToSeq(resul0)

proc g_bookmark_file_get_description(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getDescription*(self: BookmarkFile; uri: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_description(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_bookmark_file_get_groups(self: ptr BookmarkFile00; uri: cstring; length: var uint64;
    error: ptr ptr glib.Error = nil): ptr cstring {.
    importc, libprag.}

proc getGroups*(self: BookmarkFile; uri: cstring; length: var uint64 = cast[var uint64](nil)): seq[string] =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_groups(cast[ptr BookmarkFile00](self.impl), uri, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = cstringArrayToSeq(resul0)

proc g_bookmark_file_get_icon(self: ptr BookmarkFile00; uri: cstring; href: var cstring;
    mimeType: var cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getIcon*(self: BookmarkFile; uri: cstring; href: var string = cast[var string](nil);
    mimeType: var string = cast[var string](nil)): bool =
  var gerror: ptr glib.Error
  var href_00: cstring
  var mimeType_00: cstring
  let resul0 = g_bookmark_file_get_icon(cast[ptr BookmarkFile00](self.impl), uri, href_00, mimeType_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if href.addr != nil:
    href = $(href_00)
  if mimeType.addr != nil:
    mimeType = $(mimeType_00)

proc g_bookmark_file_get_is_private(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getIsPrivate*(self: BookmarkFile; uri: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_is_private(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_get_mime_type(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getMimeType*(self: BookmarkFile; uri: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_mime_type(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_bookmark_file_get_modified(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc getModified*(self: BookmarkFile; uri: cstring): int64 =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_modified(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_bookmark_file_get_size(self: ptr BookmarkFile00): int32 {.
    importc, libprag.}

proc getSize*(self: BookmarkFile): int =
  int(g_bookmark_file_get_size(cast[ptr BookmarkFile00](self.impl)))

proc size*(self: BookmarkFile): int =
  int(g_bookmark_file_get_size(cast[ptr BookmarkFile00](self.impl)))

proc g_bookmark_file_get_title(self: ptr BookmarkFile00; uri: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getTitle*(self: BookmarkFile; uri: cstring = nil): string =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_title(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_bookmark_file_get_uris(self: ptr BookmarkFile00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc getUris*(self: BookmarkFile; length: var uint64 = cast[var uint64](nil)): seq[string] =
  let resul0 = g_bookmark_file_get_uris(cast[ptr BookmarkFile00](self.impl), length)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_bookmark_file_get_visited(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc getVisited*(self: BookmarkFile; uri: cstring): int64 =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_get_visited(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_bookmark_file_has_application(self: ptr BookmarkFile00; uri: cstring;
    name: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc hasApplication*(self: BookmarkFile; uri: cstring; name: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_has_application(cast[ptr BookmarkFile00](self.impl), uri, name, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_has_group(self: ptr BookmarkFile00; uri: cstring; group: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc hasGroup*(self: BookmarkFile; uri: cstring; group: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_has_group(cast[ptr BookmarkFile00](self.impl), uri, group, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_has_item(self: ptr BookmarkFile00; uri: cstring): gboolean {.
    importc, libprag.}

proc hasItem*(self: BookmarkFile; uri: cstring): bool =
  toBool(g_bookmark_file_has_item(cast[ptr BookmarkFile00](self.impl), uri))

proc g_bookmark_file_load_from_data(self: ptr BookmarkFile00; data: ptr uint8;
    length: uint64; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromData*(self: BookmarkFile; data: seq[uint8] | string): bool =
  let length = uint64(data.len)
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_load_from_data(cast[ptr BookmarkFile00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_load_from_data_dirs(self: ptr BookmarkFile00; file: cstring;
    fullPath: var cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromDataDirs*(self: BookmarkFile; file: cstring;
    fullPath: var string = cast[var string](nil)): bool =
  var gerror: ptr glib.Error
  var fullPath_00: cstring
  let resul0 = g_bookmark_file_load_from_data_dirs(cast[ptr BookmarkFile00](self.impl), file, fullPath_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if fullPath.addr != nil:
    fullPath = $(fullPath_00)

proc g_bookmark_file_load_from_file(self: ptr BookmarkFile00; filename: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromFile*(self: BookmarkFile; filename: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_load_from_file(cast[ptr BookmarkFile00](self.impl), filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_move_item(self: ptr BookmarkFile00; oldUri: cstring;
    newUri: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc moveItem*(self: BookmarkFile; oldUri: cstring; newUri: cstring = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_move_item(cast[ptr BookmarkFile00](self.impl), oldUri, newUri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_remove_application(self: ptr BookmarkFile00; uri: cstring;
    name: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeApplication*(self: BookmarkFile; uri: cstring;
    name: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_remove_application(cast[ptr BookmarkFile00](self.impl), uri, name, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_remove_group(self: ptr BookmarkFile00; uri: cstring;
    group: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeGroup*(self: BookmarkFile; uri: cstring; group: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_remove_group(cast[ptr BookmarkFile00](self.impl), uri, group, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_remove_item(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeItem*(self: BookmarkFile; uri: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_remove_item(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_set_added(self: ptr BookmarkFile00; uri: cstring; added: int64) {.
    importc, libprag.}

proc setAdded*(self: BookmarkFile; uri: cstring; added: int64) =
  g_bookmark_file_set_added(cast[ptr BookmarkFile00](self.impl), uri, added)

proc g_bookmark_file_set_app_info(self: ptr BookmarkFile00; uri: cstring;
    name: cstring; exec: cstring; count: int32; stamp: int64; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setAppInfo*(self: BookmarkFile; uri: cstring; name: cstring;
    exec: cstring; count: int; stamp: int64): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_set_app_info(cast[ptr BookmarkFile00](self.impl), uri, name, exec, int32(count), stamp, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_set_description(self: ptr BookmarkFile00; uri: cstring;
    description: cstring) {.
    importc, libprag.}

proc setDescription*(self: BookmarkFile; uri: cstring = nil;
    description: cstring) =
  g_bookmark_file_set_description(cast[ptr BookmarkFile00](self.impl), uri, description)

proc g_bookmark_file_set_groups(self: ptr BookmarkFile00; uri: cstring; groups: ptr cstring;
    length: uint64) {.
    importc, libprag.}

proc setGroups*(self: BookmarkFile; uri: cstring; groups: openArray[string];
    length: uint64) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  g_bookmark_file_set_groups(cast[ptr BookmarkFile00](self.impl), uri, seq2CstringArray(groups, fs469n23), length)

proc g_bookmark_file_set_icon(self: ptr BookmarkFile00; uri: cstring; href: cstring;
    mimeType: cstring) {.
    importc, libprag.}

proc setIcon*(self: BookmarkFile; uri: cstring; href: cstring = nil;
    mimeType: cstring) =
  g_bookmark_file_set_icon(cast[ptr BookmarkFile00](self.impl), uri, href, mimeType)

proc g_bookmark_file_set_is_private(self: ptr BookmarkFile00; uri: cstring;
    isPrivate: gboolean) {.
    importc, libprag.}

proc setIsPrivate*(self: BookmarkFile; uri: cstring; isPrivate: bool) =
  g_bookmark_file_set_is_private(cast[ptr BookmarkFile00](self.impl), uri, gboolean(isPrivate))

proc g_bookmark_file_set_mime_type(self: ptr BookmarkFile00; uri: cstring;
    mimeType: cstring) {.
    importc, libprag.}

proc setMimeType*(self: BookmarkFile; uri: cstring; mimeType: cstring) =
  g_bookmark_file_set_mime_type(cast[ptr BookmarkFile00](self.impl), uri, mimeType)

proc g_bookmark_file_set_modified(self: ptr BookmarkFile00; uri: cstring;
    modified: int64) {.
    importc, libprag.}

proc setModified*(self: BookmarkFile; uri: cstring; modified: int64) =
  g_bookmark_file_set_modified(cast[ptr BookmarkFile00](self.impl), uri, modified)

proc g_bookmark_file_set_title(self: ptr BookmarkFile00; uri: cstring; title: cstring) {.
    importc, libprag.}

proc setTitle*(self: BookmarkFile; uri: cstring = nil; title: cstring) =
  g_bookmark_file_set_title(cast[ptr BookmarkFile00](self.impl), uri, title)

proc g_bookmark_file_set_visited(self: ptr BookmarkFile00; uri: cstring;
    visited: int64) {.
    importc, libprag.}

proc setVisited*(self: BookmarkFile; uri: cstring; visited: int64) =
  g_bookmark_file_set_visited(cast[ptr BookmarkFile00](self.impl), uri, visited)

proc g_bookmark_file_to_data(self: ptr BookmarkFile00; length: var uint64;
    error: ptr ptr glib.Error = nil): ptr uint8 {.
    importc, libprag.}

proc toData*(self: BookmarkFile; length: var uint64 = cast[var uint64](nil)): seq[uint8] =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_to_data(cast[ptr BookmarkFile00](self.impl), length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = uint8ArrayToSeq(resul0, length.int)
  cogfree(resul0)

proc g_bookmark_file_to_file(self: ptr BookmarkFile00; filename: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc toFile*(self: BookmarkFile; filename: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_to_file(cast[ptr BookmarkFile00](self.impl), filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  DateTime00* {.pure.} = object
  DateTime* = ref object
    impl*: ptr DateTime00
    ignoreFinalizer*: bool

proc g_date_time_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGDateTime*(self: DateTime) =
  if not self.ignoreFinalizer:
    boxedFree(g_date_time_get_type(), cast[ptr DateTime00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DateTime()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_date_time_get_type(), cast[ptr DateTime00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DateTime) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGDateTime)

proc g_date_time_unref(self: ptr DateTime00) {.
    importc, libprag.}

proc unref*(self: DateTime) =
  g_date_time_unref(cast[ptr DateTime00](self.impl))

proc finalizerunref*(self: DateTime) =
  if not self.ignoreFinalizer:
    g_date_time_unref(cast[ptr DateTime00](self.impl))

proc g_date_time_new_from_timeval_local(tv: TimeVal): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromTimevalLocal*(tv: TimeVal): DateTime {.deprecated.}  =
  let impl0 = g_date_time_new_from_timeval_local(tv)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeFromTimevalLocal*(tdesc: typedesc; tv: TimeVal): tdesc {.deprecated.}  =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_timeval_local(tv)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeFromTimevalLocal*[T](result: var T; tv: TimeVal) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_timeval_local(tv)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_from_timeval_utc(tv: TimeVal): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromTimevalUtc*(tv: TimeVal): DateTime {.deprecated.}  =
  let impl0 = g_date_time_new_from_timeval_utc(tv)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeFromTimevalUtc*(tdesc: typedesc; tv: TimeVal): tdesc {.deprecated.}  =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_timeval_utc(tv)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeFromTimevalUtc*[T](result: var T; tv: TimeVal) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_timeval_utc(tv)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_from_unix_local(t: int64): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromUnixLocal*(t: int64): DateTime =
  let impl0 = g_date_time_new_from_unix_local(t)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeFromUnixLocal*(tdesc: typedesc; t: int64): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_unix_local(t)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeFromUnixLocal*[T](result: var T; t: int64) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_unix_local(t)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_from_unix_utc(t: int64): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromUnixUtc*(t: int64): DateTime =
  let impl0 = g_date_time_new_from_unix_utc(t)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeFromUnixUtc*(tdesc: typedesc; t: int64): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_unix_utc(t)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeFromUnixUtc*[T](result: var T; t: int64) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_unix_utc(t)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_local(year: int32; month: int32; day: int32; hour: int32;
    minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeLocal*(year: int; month: int; day: int; hour: int; minute: int;
    seconds: cdouble): DateTime =
  let impl0 = g_date_time_new_local(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeLocal*(tdesc: typedesc; year: int; month: int; day: int; hour: int; minute: int;
    seconds: cdouble): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_local(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeLocal*[T](result: var T; year: int; month: int; day: int; hour: int; minute: int;
    seconds: cdouble) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_local(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_now_local(): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeNowLocal*(): DateTime =
  let impl0 = g_date_time_new_now_local()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeNowLocal*(tdesc: typedesc): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_now_local()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeNowLocal*[T](result: var T) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_now_local()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_now_utc(): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeNowUtc*(): DateTime =
  let impl0 = g_date_time_new_now_utc()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeNowUtc*(tdesc: typedesc): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_now_utc()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeNowUtc*[T](result: var T) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_now_utc()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_utc(year: int32; month: int32; day: int32; hour: int32;
    minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeUtc*(year: int; month: int; day: int; hour: int; minute: int;
    seconds: cdouble): DateTime =
  let impl0 = g_date_time_new_utc(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeUtc*(tdesc: typedesc; year: int; month: int; day: int; hour: int; minute: int;
    seconds: cdouble): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_utc(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeUtc*[T](result: var T; year: int; month: int; day: int; hour: int; minute: int;
    seconds: cdouble) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_utc(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add(self: ptr DateTime00; timespan: int64): ptr DateTime00 {.
    importc, libprag.}

proc add*(self: DateTime; timespan: int64): DateTime =
  let impl0 = g_date_time_add(cast[ptr DateTime00](self.impl), timespan)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_days(self: ptr DateTime00; days: int32): ptr DateTime00 {.
    importc, libprag.}

proc addDays*(self: DateTime; days: int): DateTime =
  let impl0 = g_date_time_add_days(cast[ptr DateTime00](self.impl), int32(days))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_full(self: ptr DateTime00; years: int32; months: int32;
    days: int32; hours: int32; minutes: int32; seconds: cdouble): ptr DateTime00 {.
    importc, libprag.}

proc addFull*(self: DateTime; years: int; months: int; days: int;
    hours: int; minutes: int; seconds: cdouble): DateTime =
  let impl0 = g_date_time_add_full(cast[ptr DateTime00](self.impl), int32(years), int32(months), int32(days), int32(hours), int32(minutes), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_hours(self: ptr DateTime00; hours: int32): ptr DateTime00 {.
    importc, libprag.}

proc addHours*(self: DateTime; hours: int): DateTime =
  let impl0 = g_date_time_add_hours(cast[ptr DateTime00](self.impl), int32(hours))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_minutes(self: ptr DateTime00; minutes: int32): ptr DateTime00 {.
    importc, libprag.}

proc addMinutes*(self: DateTime; minutes: int): DateTime =
  let impl0 = g_date_time_add_minutes(cast[ptr DateTime00](self.impl), int32(minutes))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_months(self: ptr DateTime00; months: int32): ptr DateTime00 {.
    importc, libprag.}

proc addMonths*(self: DateTime; months: int): DateTime =
  let impl0 = g_date_time_add_months(cast[ptr DateTime00](self.impl), int32(months))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_seconds(self: ptr DateTime00; seconds: cdouble): ptr DateTime00 {.
    importc, libprag.}

proc addSeconds*(self: DateTime; seconds: cdouble): DateTime =
  let impl0 = g_date_time_add_seconds(cast[ptr DateTime00](self.impl), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_weeks(self: ptr DateTime00; weeks: int32): ptr DateTime00 {.
    importc, libprag.}

proc addWeeks*(self: DateTime; weeks: int): DateTime =
  let impl0 = g_date_time_add_weeks(cast[ptr DateTime00](self.impl), int32(weeks))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_add_years(self: ptr DateTime00; years: int32): ptr DateTime00 {.
    importc, libprag.}

proc addYears*(self: DateTime; years: int): DateTime =
  let impl0 = g_date_time_add_years(cast[ptr DateTime00](self.impl), int32(years))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_difference(self: ptr DateTime00; begin: ptr DateTime00): int64 {.
    importc, libprag.}

proc difference*(self: DateTime; begin: DateTime): int64 =
  g_date_time_difference(cast[ptr DateTime00](self.impl), cast[ptr DateTime00](begin.impl))

proc g_date_time_format*(self: ptr DateTime00; format: cstring): cstring {.
    importc, libprag.}

proc format*(self: DateTime; format: cstring): string =
  let resul0 = g_date_time_format(cast[ptr DateTime00](self.impl), format)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_date_time_format_iso8601(self: ptr DateTime00): cstring {.
    importc, libprag.}

proc formatIso8601*(self: DateTime): string =
  let resul0 = g_date_time_format_iso8601(cast[ptr DateTime00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_date_time_get_day_of_month(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getDayOfMonth*(self: DateTime): int =
  int(g_date_time_get_day_of_month(cast[ptr DateTime00](self.impl)))

proc dayOfMonth*(self: DateTime): int =
  int(g_date_time_get_day_of_month(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_day_of_week(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getDayOfWeek*(self: DateTime): int =
  int(g_date_time_get_day_of_week(cast[ptr DateTime00](self.impl)))

proc dayOfWeek*(self: DateTime): int =
  int(g_date_time_get_day_of_week(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_day_of_year(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getDayOfYear*(self: DateTime): int =
  int(g_date_time_get_day_of_year(cast[ptr DateTime00](self.impl)))

proc dayOfYear*(self: DateTime): int =
  int(g_date_time_get_day_of_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_hour(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getHour*(self: DateTime): int =
  int(g_date_time_get_hour(cast[ptr DateTime00](self.impl)))

proc hour*(self: DateTime): int =
  int(g_date_time_get_hour(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_microsecond(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getMicrosecond*(self: DateTime): int =
  int(g_date_time_get_microsecond(cast[ptr DateTime00](self.impl)))

proc microsecond*(self: DateTime): int =
  int(g_date_time_get_microsecond(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_minute(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getMinute*(self: DateTime): int =
  int(g_date_time_get_minute(cast[ptr DateTime00](self.impl)))

proc minute*(self: DateTime): int =
  int(g_date_time_get_minute(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_month(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getMonth*(self: DateTime): int =
  int(g_date_time_get_month(cast[ptr DateTime00](self.impl)))

proc month*(self: DateTime): int =
  int(g_date_time_get_month(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_second(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getSecond*(self: DateTime): int =
  int(g_date_time_get_second(cast[ptr DateTime00](self.impl)))

proc second*(self: DateTime): int =
  int(g_date_time_get_second(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_seconds(self: ptr DateTime00): cdouble {.
    importc, libprag.}

proc getSeconds*(self: DateTime): cdouble =
  g_date_time_get_seconds(cast[ptr DateTime00](self.impl))

proc seconds*(self: DateTime): cdouble =
  g_date_time_get_seconds(cast[ptr DateTime00](self.impl))

proc g_date_time_get_timezone_abbreviation(self: ptr DateTime00): cstring {.
    importc, libprag.}

proc getTimezoneAbbreviation*(self: DateTime): string =
  result = $g_date_time_get_timezone_abbreviation(cast[ptr DateTime00](self.impl))

proc timezoneAbbreviation*(self: DateTime): string =
  result = $g_date_time_get_timezone_abbreviation(cast[ptr DateTime00](self.impl))

proc g_date_time_get_utc_offset(self: ptr DateTime00): int64 {.
    importc, libprag.}

proc getUtcOffset*(self: DateTime): int64 =
  g_date_time_get_utc_offset(cast[ptr DateTime00](self.impl))

proc utcOffset*(self: DateTime): int64 =
  g_date_time_get_utc_offset(cast[ptr DateTime00](self.impl))

proc g_date_time_get_week_numbering_year(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getWeekNumberingYear*(self: DateTime): int =
  int(g_date_time_get_week_numbering_year(cast[ptr DateTime00](self.impl)))

proc weekNumberingYear*(self: DateTime): int =
  int(g_date_time_get_week_numbering_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_week_of_year(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getWeekOfYear*(self: DateTime): int =
  int(g_date_time_get_week_of_year(cast[ptr DateTime00](self.impl)))

proc weekOfYear*(self: DateTime): int =
  int(g_date_time_get_week_of_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_year(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getYear*(self: DateTime): int =
  int(g_date_time_get_year(cast[ptr DateTime00](self.impl)))

proc year*(self: DateTime): int =
  int(g_date_time_get_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_ymd(self: ptr DateTime00; year: var int32; month: var int32;
    day: var int32) {.
    importc, libprag.}

proc getYmd*(self: DateTime; year: var int = cast[var int](nil);
    month: var int = cast[var int](nil); day: var int = cast[var int](nil)) =
  var day_00: int32
  var year_00: int32
  var month_00: int32
  g_date_time_get_ymd(cast[ptr DateTime00](self.impl), year_00, month_00, day_00)
  if day.addr != nil:
    day = int(day_00)
  if year.addr != nil:
    year = int(year_00)
  if month.addr != nil:
    month = int(month_00)

proc g_date_time_is_daylight_savings(self: ptr DateTime00): gboolean {.
    importc, libprag.}

proc isDaylightSavings*(self: DateTime): bool =
  toBool(g_date_time_is_daylight_savings(cast[ptr DateTime00](self.impl)))

proc g_date_time_ref(self: ptr DateTime00): ptr DateTime00 {.
    importc, libprag.}

proc `ref`*(self: DateTime): DateTime =
  fnew(result, gBoxedFreeGDateTime)
  result.impl = g_date_time_ref(cast[ptr DateTime00](self.impl))

proc g_date_time_to_local(self: ptr DateTime00): ptr DateTime00 {.
    importc, libprag.}

proc toLocal*(self: DateTime): DateTime =
  let impl0 = g_date_time_to_local(cast[ptr DateTime00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_to_timeval(self: ptr DateTime00; tv: TimeVal): gboolean {.
    importc, libprag.}

proc toTimeval*(self: DateTime; tv: TimeVal): bool =
  toBool(g_date_time_to_timeval(cast[ptr DateTime00](self.impl), tv))

proc g_date_time_to_unix(self: ptr DateTime00): int64 {.
    importc, libprag.}

proc toUnix*(self: DateTime): int64 =
  g_date_time_to_unix(cast[ptr DateTime00](self.impl))

proc g_date_time_to_utc(self: ptr DateTime00): ptr DateTime00 {.
    importc, libprag.}

proc toUtc*(self: DateTime): DateTime =
  let impl0 = g_date_time_to_utc(cast[ptr DateTime00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_compare(dt1: pointer; dt2: pointer): int32 {.
    importc, libprag.}

proc compare*(dt1: pointer; dt2: pointer): int =
  int(g_date_time_compare(dt1, dt2))

proc g_date_time_equal(dt1: pointer; dt2: pointer): gboolean {.
    importc, libprag.}

proc equal*(dt1: pointer; dt2: pointer): bool =
  toBool(g_date_time_equal(dt1, dt2))

proc g_date_time_hash(datetime: pointer): uint32 {.
    importc, libprag.}

proc hash*(datetime: pointer): int =
  int(g_date_time_hash(datetime))

proc g_bookmark_file_get_added_date_time(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): ptr DateTime00 {.
    importc, libprag.}

proc getAddedDateTime*(self: BookmarkFile; uri: cstring): DateTime =
  var gerror: ptr glib.Error
  let impl0 = g_bookmark_file_get_added_date_time(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc g_bookmark_file_get_application_info(self: ptr BookmarkFile00; uri: cstring;
    name: cstring; exec: var cstring; count: var uint32; stamp: var ptr DateTime00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getApplicationInfo*(self: BookmarkFile; uri: cstring;
    name: cstring; exec: var string = cast[var string](nil); count: var int = cast[var int](nil);
    stamp: var DateTime = cast[var DateTime](nil)): bool =
  if addr(stamp) != nil:
    fnew(stamp, gBoxedFreeGDateTime)
  var gerror: ptr glib.Error
  var count_00: uint32
  var exec_00: cstring
  let resul0 = g_bookmark_file_get_application_info(cast[ptr BookmarkFile00](self.impl), uri, name, exec_00, count_00, cast[var ptr DateTime00](if addr(stamp) == nil: nil else: addr stamp.impl), addr gerror)
  stamp.impl = cast[ptr DateTime00](g_boxed_copy(g_date_time_get_type(), stamp.impl))
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if count.addr != nil:
    count = int(count_00)
  if exec.addr != nil:
    exec = $(exec_00)

proc g_bookmark_file_get_modified_date_time(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): ptr DateTime00 {.
    importc, libprag.}

proc getModifiedDateTime*(self: BookmarkFile; uri: cstring): DateTime =
  var gerror: ptr glib.Error
  let impl0 = g_bookmark_file_get_modified_date_time(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc g_bookmark_file_get_visited_date_time(self: ptr BookmarkFile00; uri: cstring;
    error: ptr ptr glib.Error = nil): ptr DateTime00 {.
    importc, libprag.}

proc getVisitedDateTime*(self: BookmarkFile; uri: cstring): DateTime =
  var gerror: ptr glib.Error
  let impl0 = g_bookmark_file_get_visited_date_time(cast[ptr BookmarkFile00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGDateTime)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_date_time_get_type(), impl0))

proc g_bookmark_file_set_added_date_time(self: ptr BookmarkFile00; uri: cstring;
    added: ptr DateTime00) {.
    importc, libprag.}

proc setAddedDateTime*(self: BookmarkFile; uri: cstring;
    added: DateTime) =
  g_bookmark_file_set_added_date_time(cast[ptr BookmarkFile00](self.impl), uri, cast[ptr DateTime00](added.impl))

proc g_bookmark_file_set_application_info(self: ptr BookmarkFile00; uri: cstring;
    name: cstring; exec: cstring; count: int32; stamp: ptr DateTime00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setApplicationInfo*(self: BookmarkFile; uri: cstring;
    name: cstring; exec: cstring; count: int; stamp: DateTime = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = g_bookmark_file_set_application_info(cast[ptr BookmarkFile00](self.impl), uri, name, exec, int32(count), if stamp.isNil: nil else: cast[ptr DateTime00](stamp.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_bookmark_file_set_modified_date_time(self: ptr BookmarkFile00; uri: cstring;
    modified: ptr DateTime00) {.
    importc, libprag.}

proc setModifiedDateTime*(self: BookmarkFile; uri: cstring;
    modified: DateTime) =
  g_bookmark_file_set_modified_date_time(cast[ptr BookmarkFile00](self.impl), uri, cast[ptr DateTime00](modified.impl))

proc g_bookmark_file_set_visited_date_time(self: ptr BookmarkFile00; uri: cstring;
    visited: ptr DateTime00) {.
    importc, libprag.}

proc setVisitedDateTime*(self: BookmarkFile; uri: cstring;
    visited: DateTime) =
  g_bookmark_file_set_visited_date_time(cast[ptr BookmarkFile00](self.impl), uri, cast[ptr DateTime00](visited.impl))

type
  TimeZone00* {.pure.} = object
  TimeZone* = ref object
    impl*: ptr TimeZone00
    ignoreFinalizer*: bool

proc g_time_zone_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGTimeZone*(self: TimeZone) =
  if not self.ignoreFinalizer:
    boxedFree(g_time_zone_get_type(), cast[ptr TimeZone00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TimeZone()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_time_zone_get_type(), cast[ptr TimeZone00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TimeZone) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGTimeZone)

proc g_time_zone_unref(self: ptr TimeZone00) {.
    importc, libprag.}

proc unref*(self: TimeZone) =
  g_time_zone_unref(cast[ptr TimeZone00](self.impl))

proc finalizerunref*(self: TimeZone) =
  if not self.ignoreFinalizer:
    g_time_zone_unref(cast[ptr TimeZone00](self.impl))

proc g_time_zone_new_local(): ptr TimeZone00 {.
    importc, libprag.}

proc newTimeZoneLocal*(): TimeZone =
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_local()

proc newTimeZoneLocal*(tdesc: typedesc): tdesc =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_local()

proc initTimeZoneLocal*[T](result: var T) {.deprecated.} =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_local()

proc g_time_zone_new_offset(seconds: int32): ptr TimeZone00 {.
    importc, libprag.}

proc newTimeZoneOffset*(seconds: int): TimeZone =
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_offset(int32(seconds))

proc newTimeZoneOffset*(tdesc: typedesc; seconds: int): tdesc =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_offset(int32(seconds))

proc initTimeZoneOffset*[T](result: var T; seconds: int) {.deprecated.} =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_offset(int32(seconds))

proc g_time_zone_new_utc(): ptr TimeZone00 {.
    importc, libprag.}

proc newTimeZoneUtc*(): TimeZone =
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_utc()

proc newTimeZoneUtc*(tdesc: typedesc): tdesc =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_utc()

proc initTimeZoneUtc*[T](result: var T) {.deprecated.} =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new_utc()

proc g_time_zone_get_abbreviation(self: ptr TimeZone00; interval: int32): cstring {.
    importc, libprag.}

proc getAbbreviation*(self: TimeZone; interval: int): string =
  result = $g_time_zone_get_abbreviation(cast[ptr TimeZone00](self.impl), int32(interval))

proc g_time_zone_get_identifier(self: ptr TimeZone00): cstring {.
    importc, libprag.}

proc getIdentifier*(self: TimeZone): string =
  result = $g_time_zone_get_identifier(cast[ptr TimeZone00](self.impl))

proc identifier*(self: TimeZone): string =
  result = $g_time_zone_get_identifier(cast[ptr TimeZone00](self.impl))

proc g_time_zone_get_offset(self: ptr TimeZone00; interval: int32): int32 {.
    importc, libprag.}

proc getOffset*(self: TimeZone; interval: int): int =
  int(g_time_zone_get_offset(cast[ptr TimeZone00](self.impl), int32(interval)))

proc g_time_zone_is_dst(self: ptr TimeZone00; interval: int32): gboolean {.
    importc, libprag.}

proc isDst*(self: TimeZone; interval: int): bool =
  toBool(g_time_zone_is_dst(cast[ptr TimeZone00](self.impl), int32(interval)))

proc g_time_zone_ref(self: ptr TimeZone00): ptr TimeZone00 {.
    importc, libprag.}

proc `ref`*(self: TimeZone): TimeZone =
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_ref(cast[ptr TimeZone00](self.impl))

proc g_time_zone_new(identifier: cstring): ptr TimeZone00 {.
    importc, libprag.}

proc newTimeZone*(identifier: cstring = nil): TimeZone =
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new(identifier)

proc newTimeZone*(tdesc: typedesc; identifier: cstring = nil): tdesc =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new(identifier)

proc initTimeZone*[T](result: var T; identifier: cstring = nil) {.deprecated.} =
  assert(result is TimeZone)
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_time_zone_new(identifier)

proc g_date_time_new_from_iso8601(text: cstring; defaultTz: ptr TimeZone00): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromIso8601*(text: cstring; defaultTz: TimeZone = nil): DateTime =
  let impl0 = g_date_time_new_from_iso8601(text, if defaultTz.isNil: nil else: cast[ptr TimeZone00](defaultTz.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeFromIso8601*(tdesc: typedesc; text: cstring; defaultTz: TimeZone = nil): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_iso8601(text, if defaultTz.isNil: nil else: cast[ptr TimeZone00](defaultTz.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeFromIso8601*[T](result: var T; text: cstring; defaultTz: TimeZone = nil) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_from_iso8601(text, if defaultTz.isNil: nil else: cast[ptr TimeZone00](defaultTz.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new_now(tz: ptr TimeZone00): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeNow*(tz: TimeZone): DateTime =
  let impl0 = g_date_time_new_now(cast[ptr TimeZone00](tz.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTimeNow*(tdesc: typedesc; tz: TimeZone): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new_now(cast[ptr TimeZone00](tz.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTimeNow*[T](result: var T; tz: TimeZone) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new_now(cast[ptr TimeZone00](tz.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_get_timezone(self: ptr DateTime00): ptr TimeZone00 {.
    importc, libprag.}

proc getTimezone*(self: DateTime): TimeZone =
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_date_time_get_timezone(cast[ptr DateTime00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_time_zone_get_type(), result.impl))

proc timezone*(self: DateTime): TimeZone =
  fnew(result, gBoxedFreeGTimeZone)
  result.impl = g_date_time_get_timezone(cast[ptr DateTime00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_time_zone_get_type(), result.impl))

proc g_date_time_to_timezone(self: ptr DateTime00; tz: ptr TimeZone00): ptr DateTime00 {.
    importc, libprag.}

proc toTimezone*(self: DateTime; tz: TimeZone): DateTime =
  let impl0 = g_date_time_to_timezone(cast[ptr DateTime00](self.impl), cast[ptr TimeZone00](tz.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc g_date_time_new(tz: ptr TimeZone00; year: int32; month: int32; day: int32;
    hour: int32; minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc, libprag.}

proc newDateTime*(tz: TimeZone; year: int; month: int; day: int; hour: int;
    minute: int; seconds: cdouble): DateTime =
  let impl0 = g_date_time_new(cast[ptr TimeZone00](tz.impl), int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc newDateTime*(tdesc: typedesc; tz: TimeZone; year: int; month: int; day: int; hour: int;
    minute: int; seconds: cdouble): tdesc =
  assert(result is DateTime)
  let impl0 = g_date_time_new(cast[ptr TimeZone00](tz.impl), int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc initDateTime*[T](result: var T; tz: TimeZone; year: int; month: int; day: int; hour: int;
    minute: int; seconds: cdouble) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = g_date_time_new(cast[ptr TimeZone00](tz.impl), int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

type
  TimeType* {.size: sizeof(cint), pure.} = enum
    standard = 0
    daylight = 1
    universal = 2

proc g_time_zone_adjust_time(self: ptr TimeZone00; `type`: TimeType; time: ptr int64): int32 {.
    importc, libprag.}

proc adjustTime*(self: TimeZone; `type`: TimeType; time: ptr int64): int =
  int(g_time_zone_adjust_time(cast[ptr TimeZone00](self.impl), `type`, time))

proc g_time_zone_find_interval(self: ptr TimeZone00; `type`: TimeType; time: int64): int32 {.
    importc, libprag.}

proc findInterval*(self: TimeZone; `type`: TimeType; time: int64): int =
  int(g_time_zone_find_interval(cast[ptr TimeZone00](self.impl), `type`, time))

type
  BookmarkFileError* {.size: sizeof(cint), pure.} = enum
    invalidUri = 0
    invalidValue = 1
    appNotRegistered = 2
    uriNotFound = 3
    read = 4
    unknownEncoding = 5
    write = 6
    fileNotFound = 7

type
  ByteArray00* {.pure.} = object
  ByteArray* = ref object
    impl*: ptr ByteArray00
    ignoreFinalizer*: bool

proc g_byte_array_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGByteArray*(self: ByteArray) =
  if not self.ignoreFinalizer:
    boxedFree(g_byte_array_get_type(), cast[ptr ByteArray00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ByteArray()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_byte_array_get_type(), cast[ptr ByteArray00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ByteArray) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGByteArray)

proc g_byte_array_free(array: ptr ByteArray00; freeSegment: gboolean): ptr uint8 {.
    importc, libprag.}

proc free*(array: ptr ByteArray00; freeSegment: bool): ptr uint8 =
  g_byte_array_free(array, gboolean(freeSegment))

proc new*(): ptr ByteArray00 {.
    importc: "g_byte_array_new", libprag.}

proc g_byte_array_new_take(data: ptr uint8; len: uint64): ptr ByteArray00 {.
    importc, libprag.}

proc newTake*(data: seq[uint8] | string): ptr ByteArray00 =
  let len = uint64(data.len)
  g_byte_array_new_take(cast[ptr uint8](unsafeaddr(data[0])), len)

proc steal*(array: ptr ByteArray00; len: var uint64): ptr uint8 {.
    importc: "g_byte_array_steal", libprag.}

proc g_byte_array_unref(array: ptr ByteArray00) {.
    importc, libprag.}

proc unref*(array: ptr ByteArray00) =
  g_byte_array_unref(array)

proc finalizerunref*(self: ByteArray) =
  if not self.ignoreFinalizer:
    g_byte_array_unref(cast[ptr ByteArray00](self.impl))

type
  Bytes00* {.pure.} = object
  Bytes* = ref object
    impl*: ptr Bytes00
    ignoreFinalizer*: bool

proc g_bytes_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGBytes*(self: Bytes) =
  if not self.ignoreFinalizer:
    boxedFree(g_bytes_get_type(), cast[ptr Bytes00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Bytes()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_bytes_get_type(), cast[ptr Bytes00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Bytes) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGBytes)

proc g_bytes_unref(self: ptr Bytes00) {.
    importc, libprag.}

proc unref*(self: Bytes) =
  g_bytes_unref(cast[ptr Bytes00](self.impl))

proc finalizerunref*(self: Bytes) =
  if not self.ignoreFinalizer:
    g_bytes_unref(cast[ptr Bytes00](self.impl))

proc g_bytes_new_take(data: ptr uint8; size: uint64): ptr Bytes00 {.
    importc, libprag.}

proc newBytesTake*(data: seq[uint8] | string): Bytes =
  let size = uint64(data.len)
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_new_take(cast[ptr uint8](unsafeaddr(data[0])), size)

proc newBytesTake*(tdesc: typedesc; data: seq[uint8] | string): tdesc =
  let size = uint64(data.len)
  assert(result is Bytes)
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_new_take(cast[ptr uint8](unsafeaddr(data[0])), size)

proc initBytesTake*[T](result: var T; data: seq[uint8] | string) {.deprecated.} =
  let size = uint64(data.len)
  assert(result is Bytes)
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_new_take(cast[ptr uint8](unsafeaddr(data[0])), size)

proc g_bytes_compare(self: ptr Bytes00; bytes2: ptr Bytes00): int32 {.
    importc, libprag.}

proc compare*(self: Bytes; bytes2: Bytes): int =
  int(g_bytes_compare(cast[ptr Bytes00](self.impl), cast[ptr Bytes00](bytes2.impl)))

proc g_bytes_equal(self: ptr Bytes00; bytes2: ptr Bytes00): gboolean {.
    importc, libprag.}

proc equal*(self: Bytes; bytes2: Bytes): bool =
  toBool(g_bytes_equal(cast[ptr Bytes00](self.impl), cast[ptr Bytes00](bytes2.impl)))

proc g_bytes_get_data(self: ptr Bytes00; size: var uint64): ptr uint8 {.
    importc, libprag.}

proc getData*(self: Bytes; size: var uint64 = cast[var uint64](nil)): seq[uint8] =
  let resul0 = g_bytes_get_data(cast[ptr Bytes00](self.impl), size)
  if resul0.isNil:
    return
  result = uint8ArrayToSeq(resul0, size.int)

proc g_bytes_get_size(self: ptr Bytes00): uint64 {.
    importc, libprag.}

proc getSize*(self: Bytes): uint64 =
  g_bytes_get_size(cast[ptr Bytes00](self.impl))

proc size*(self: Bytes): uint64 =
  g_bytes_get_size(cast[ptr Bytes00](self.impl))

proc g_bytes_hash(self: ptr Bytes00): uint32 {.
    importc, libprag.}

proc hash*(self: Bytes): int =
  int(g_bytes_hash(cast[ptr Bytes00](self.impl)))

proc g_bytes_new_from_bytes(self: ptr Bytes00; offset: uint64; length: uint64): ptr Bytes00 {.
    importc, libprag.}

proc newBytesFromBytes*(self: Bytes; offset: uint64; length: uint64): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_new_from_bytes(cast[ptr Bytes00](self.impl), offset, length)

proc g_bytes_ref(self: ptr Bytes00): ptr Bytes00 {.
    importc, libprag.}

proc `ref`*(self: Bytes): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_ref(cast[ptr Bytes00](self.impl))

proc g_bytes_new(data: ptr uint8; size: uint64): ptr Bytes00 {.
    importc, libprag.}

proc newBytes*(data: seq[uint8] | string): Bytes =
  let size = uint64(data.len)
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_new(cast[ptr uint8](unsafeaddr(data[0])), size)

proc newBytes*(tdesc: typedesc; data: seq[uint8] | string): tdesc =
  let size = uint64(data.len)
  assert(result is Bytes)
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_new(cast[ptr uint8](unsafeaddr(data[0])), size)

proc initBytes*[T](result: var T; data: seq[uint8] | string) {.deprecated.} =
  let size = uint64(data.len)
  assert(result is Bytes)
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_bytes_new(cast[ptr uint8](unsafeaddr(data[0])), size)

proc g_bytes_unref_to_array(self: ptr Bytes00): ptr ByteArray00 {.
    importc, libprag.}

proc unrefToArray*(self: Bytes): ptr ByteArray00 =
  g_bytes_unref_to_array(cast[ptr Bytes00](g_boxed_copy(g_bytes_get_type(), self.impl)))

proc g_bytes_unref_to_data(self: ptr Bytes00; size: var uint64): ptr uint8 {.
    importc, libprag.}

proc unrefToData*(self: Bytes; size: var uint64): seq[uint8] =
  let resul0 = g_bytes_unref_to_data(cast[ptr Bytes00](g_boxed_copy(g_bytes_get_type(), self.impl)), size)
  result = uint8ArrayToSeq(resul0, size.int)
  cogfree(resul0)

proc g_byte_array_free_to_bytes(array: ptr ByteArray00): ptr Bytes00 {.
    importc, libprag.}

proc freeToBytes*(array: ptr ByteArray00): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_byte_array_free_to_bytes(array)

const CSET_A_2_Z_U* = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

const CSET_DIGITS* = "0123456789"

const CSET_a_2Z* = "abcdefghijklmnopqrstuvwxyz"

type
  Checksum00* {.pure.} = object
  Checksum* = ref object
    impl*: ptr Checksum00
    ignoreFinalizer*: bool

proc g_checksum_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGChecksum*(self: Checksum) =
  if not self.ignoreFinalizer:
    boxedFree(g_checksum_get_type(), cast[ptr Checksum00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Checksum()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_checksum_get_type(), cast[ptr Checksum00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Checksum) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGChecksum)

proc g_checksum_free(self: ptr Checksum00) {.
    importc, libprag.}

proc free*(self: Checksum) =
  g_checksum_free(cast[ptr Checksum00](self.impl))

proc finalizerfree*(self: Checksum) =
  if not self.ignoreFinalizer:
    g_checksum_free(cast[ptr Checksum00](self.impl))

proc g_checksum_copy(self: ptr Checksum00): ptr Checksum00 {.
    importc, libprag.}

proc copy*(self: Checksum): Checksum =
  fnew(result, gBoxedFreeGChecksum)
  result.impl = g_checksum_copy(cast[ptr Checksum00](self.impl))

proc g_checksum_get_string(self: ptr Checksum00): cstring {.
    importc, libprag.}

proc getString*(self: Checksum): string =
  result = $g_checksum_get_string(cast[ptr Checksum00](self.impl))

proc g_checksum_reset(self: ptr Checksum00) {.
    importc, libprag.}

proc reset*(self: Checksum) =
  g_checksum_reset(cast[ptr Checksum00](self.impl))

proc g_checksum_update(self: ptr Checksum00; data: ptr uint8; length: int64) {.
    importc, libprag.}

proc update*(self: Checksum; data: seq[uint8] | string) =
  let length = int64(data.len)
  g_checksum_update(cast[ptr Checksum00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

type
  ChecksumType* {.size: sizeof(cint), pure.} = enum
    md5 = 0
    sha1 = 1
    sha256 = 2
    sha512 = 3
    sha384 = 4

proc g_checksum_new(checksumType: ChecksumType): ptr Checksum00 {.
    importc, libprag.}

proc newChecksum*(checksumType: ChecksumType): Checksum =
  fnew(result, gBoxedFreeGChecksum)
  result.impl = g_checksum_new(checksumType)

proc newChecksum*(tdesc: typedesc; checksumType: ChecksumType): tdesc =
  assert(result is Checksum)
  fnew(result, gBoxedFreeGChecksum)
  result.impl = g_checksum_new(checksumType)

proc initChecksum*[T](result: var T; checksumType: ChecksumType) {.deprecated.} =
  assert(result is Checksum)
  fnew(result, gBoxedFreeGChecksum)
  result.impl = g_checksum_new(checksumType)

proc typeGetLength*(checksumType: ChecksumType): int64 {.
    importc: "g_checksum_type_get_length", libprag.}

type
  ChildWatchFunc* = proc (pid: int32; status: int32; userData: pointer) {.cdecl.}

type
  ClearHandleFunc* = proc (handleId: uint32) {.cdecl.}

type
  CompareDataFunc* = proc (a: pointer; b: pointer; userData: pointer): int32 {.cdecl.}

type
  CompareFunc* = proc (a: pointer; b: pointer): int32 {.cdecl.}

type
  Cond* {.pure, byRef.} = object
    p*: pointer
    i*: array[2, uint32]

proc g_cond_broadcast(self: Cond) {.
    importc, libprag.}

proc broadcast*(self: Cond) =
  g_cond_broadcast(self)

proc g_cond_clear(self: Cond) {.
    importc, libprag.}

proc clear*(self: Cond) =
  g_cond_clear(self)

proc g_cond_init(self: Cond) {.
    importc, libprag.}

proc init*(self: Cond) =
  g_cond_init(self)

proc g_cond_signal(self: Cond) {.
    importc, libprag.}

proc signal*(self: Cond) =
  g_cond_signal(self)

type
  ConvertError* {.size: sizeof(cint), pure.} = enum
    noConversion = 0
    illegalSequence = 1
    failed = 2
    partialInput = 3
    badUri = 4
    notAbsolutePath = 5
    noMemory = 6
    embeddedNul = 7

type
  CopyFunc* = proc (src: pointer; data: pointer): pointer {.cdecl.}

const DATALIST_FLAGS_MASK* = 3'i32

const DATE_BAD_DAY* = 0'i32

const DATE_BAD_JULIAN* = 0'i32

const DATE_BAD_YEAR* = 0'i32

const DIR_SEPARATOR* = 47'i32

const DIR_SEPARATOR_S* = "/"

type
  Data* {.pure, byRef.} = object

type
  DataForeachFunc* = proc (keyId: uint32; data: pointer; userData: pointer) {.cdecl.}

type
  Date00* {.pure.} = object
  Date* = ref object
    impl*: ptr Date00
    ignoreFinalizer*: bool

proc g_date_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGDate*(self: Date) =
  if not self.ignoreFinalizer:
    boxedFree(g_date_get_type(), cast[ptr Date00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Date()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_date_get_type(), cast[ptr Date00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Date) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGDate)

proc g_date_free(self: ptr Date00) {.
    importc, libprag.}

proc free*(self: Date) =
  g_date_free(cast[ptr Date00](self.impl))

proc finalizerfree*(self: Date) =
  if not self.ignoreFinalizer:
    g_date_free(cast[ptr Date00](self.impl))

proc g_date_new_julian(julianDay: uint32): ptr Date00 {.
    importc, libprag.}

proc newDateJulian*(julianDay: int): Date =
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new_julian(uint32(julianDay))

proc newDateJulian*(tdesc: typedesc; julianDay: int): tdesc =
  assert(result is Date)
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new_julian(uint32(julianDay))

proc initDateJulian*[T](result: var T; julianDay: int) {.deprecated.} =
  assert(result is Date)
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new_julian(uint32(julianDay))

proc g_date_add_days(self: ptr Date00; nDays: uint32) {.
    importc, libprag.}

proc addDays*(self: Date; nDays: int) =
  g_date_add_days(cast[ptr Date00](self.impl), uint32(nDays))

proc g_date_add_months(self: ptr Date00; nMonths: uint32) {.
    importc, libprag.}

proc addMonths*(self: Date; nMonths: int) =
  g_date_add_months(cast[ptr Date00](self.impl), uint32(nMonths))

proc g_date_add_years(self: ptr Date00; nYears: uint32) {.
    importc, libprag.}

proc addYears*(self: Date; nYears: int) =
  g_date_add_years(cast[ptr Date00](self.impl), uint32(nYears))

proc g_date_clamp(self: ptr Date00; minDate: ptr Date00; maxDate: ptr Date00) {.
    importc, libprag.}

proc clamp*(self: Date; minDate: Date; maxDate: Date) =
  g_date_clamp(cast[ptr Date00](self.impl), cast[ptr Date00](minDate.impl), cast[ptr Date00](maxDate.impl))

proc g_date_clear(self: ptr Date00; nDates: uint32) {.
    importc, libprag.}

proc clear*(self: Date; nDates: int) =
  g_date_clear(cast[ptr Date00](self.impl), uint32(nDates))

proc g_date_compare(self: ptr Date00; rhs: ptr Date00): int32 {.
    importc, libprag.}

proc compare*(self: Date; rhs: Date): int =
  int(g_date_compare(cast[ptr Date00](self.impl), cast[ptr Date00](rhs.impl)))

proc g_date_copy(self: ptr Date00): ptr Date00 {.
    importc, libprag.}

proc copy*(self: Date): Date =
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_copy(cast[ptr Date00](self.impl))

proc g_date_days_between(self: ptr Date00; date2: ptr Date00): int32 {.
    importc, libprag.}

proc daysBetween*(self: Date; date2: Date): int =
  int(g_date_days_between(cast[ptr Date00](self.impl), cast[ptr Date00](date2.impl)))

proc g_date_new(): ptr Date00 {.
    importc, libprag.}

proc newDate*(): Date =
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new()

proc newDate*(tdesc: typedesc): tdesc =
  assert(result is Date)
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new()

proc initDate*[T](result: var T) {.deprecated.} =
  assert(result is Date)
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new()

proc g_date_get_day(self: ptr Date00): uint8 {.
    importc, libprag.}

proc getDay*(self: Date): uint8 =
  g_date_get_day(cast[ptr Date00](self.impl))

proc day*(self: Date): uint8 =
  g_date_get_day(cast[ptr Date00](self.impl))

proc g_date_get_day_of_year(self: ptr Date00): uint32 {.
    importc, libprag.}

proc getDayOfYear*(self: Date): int =
  int(g_date_get_day_of_year(cast[ptr Date00](self.impl)))

proc dayOfYear*(self: Date): int =
  int(g_date_get_day_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_iso8601_week_of_year(self: ptr Date00): uint32 {.
    importc, libprag.}

proc getIso8601WeekOfYear*(self: Date): int =
  int(g_date_get_iso8601_week_of_year(cast[ptr Date00](self.impl)))

proc iso8601WeekOfYear*(self: Date): int =
  int(g_date_get_iso8601_week_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_julian(self: ptr Date00): uint32 {.
    importc, libprag.}

proc getJulian*(self: Date): int =
  int(g_date_get_julian(cast[ptr Date00](self.impl)))

proc julian*(self: Date): int =
  int(g_date_get_julian(cast[ptr Date00](self.impl)))

proc g_date_get_monday_week_of_year(self: ptr Date00): uint32 {.
    importc, libprag.}

proc getMondayWeekOfYear*(self: Date): int =
  int(g_date_get_monday_week_of_year(cast[ptr Date00](self.impl)))

proc mondayWeekOfYear*(self: Date): int =
  int(g_date_get_monday_week_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_sunday_week_of_year(self: ptr Date00): uint32 {.
    importc, libprag.}

proc getSundayWeekOfYear*(self: Date): int =
  int(g_date_get_sunday_week_of_year(cast[ptr Date00](self.impl)))

proc sundayWeekOfYear*(self: Date): int =
  int(g_date_get_sunday_week_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_year(self: ptr Date00): uint16 {.
    importc, libprag.}

proc getYear*(self: Date): uint16 =
  g_date_get_year(cast[ptr Date00](self.impl))

proc year*(self: Date): uint16 =
  g_date_get_year(cast[ptr Date00](self.impl))

proc g_date_is_first_of_month(self: ptr Date00): gboolean {.
    importc, libprag.}

proc isFirstOfMonth*(self: Date): bool =
  toBool(g_date_is_first_of_month(cast[ptr Date00](self.impl)))

proc g_date_is_last_of_month(self: ptr Date00): gboolean {.
    importc, libprag.}

proc isLastOfMonth*(self: Date): bool =
  toBool(g_date_is_last_of_month(cast[ptr Date00](self.impl)))

proc g_date_order(self: ptr Date00; date2: ptr Date00) {.
    importc, libprag.}

proc order*(self: Date; date2: Date) =
  g_date_order(cast[ptr Date00](self.impl), cast[ptr Date00](date2.impl))

proc g_date_set_day(self: ptr Date00; day: uint8) {.
    importc, libprag.}

proc setDay*(self: Date; day: uint8) =
  g_date_set_day(cast[ptr Date00](self.impl), day)

proc `day=`*(self: Date; day: uint8) =
  g_date_set_day(cast[ptr Date00](self.impl), day)

proc g_date_set_julian(self: ptr Date00; julianDate: uint32) {.
    importc, libprag.}

proc setJulian*(self: Date; julianDate: int) =
  g_date_set_julian(cast[ptr Date00](self.impl), uint32(julianDate))

proc `julian=`*(self: Date; julianDate: int) =
  g_date_set_julian(cast[ptr Date00](self.impl), uint32(julianDate))

proc g_date_set_parse(self: ptr Date00; str: cstring) {.
    importc, libprag.}

proc setParse*(self: Date; str: cstring) =
  g_date_set_parse(cast[ptr Date00](self.impl), str)

proc `parse=`*(self: Date; str: cstring) =
  g_date_set_parse(cast[ptr Date00](self.impl), str)

proc g_date_set_time(self: ptr Date00; time: int32) {.
    importc, libprag.}

proc setTime*(self: Date; time: int) =
  g_date_set_time(cast[ptr Date00](self.impl), int32(time))

proc `time=`*(self: Date; time: int) =
  g_date_set_time(cast[ptr Date00](self.impl), int32(time))

proc g_date_set_time_t(self: ptr Date00; timet: int64) {.
    importc, libprag.}

proc setTimeT*(self: Date; timet: int64) =
  g_date_set_time_t(cast[ptr Date00](self.impl), timet)

proc `timeT=`*(self: Date; timet: int64) =
  g_date_set_time_t(cast[ptr Date00](self.impl), timet)

proc g_date_set_time_val(self: ptr Date00; timeval: TimeVal) {.
    importc, libprag.}

proc setTimeVal*(self: Date; timeval: TimeVal) =
  g_date_set_time_val(cast[ptr Date00](self.impl), timeval)

proc `timeVal=`*(self: Date; timeval: TimeVal) =
  g_date_set_time_val(cast[ptr Date00](self.impl), timeval)

proc g_date_set_year(self: ptr Date00; year: uint16) {.
    importc, libprag.}

proc setYear*(self: Date; year: uint16) =
  g_date_set_year(cast[ptr Date00](self.impl), year)

proc `year=`*(self: Date; year: uint16) =
  g_date_set_year(cast[ptr Date00](self.impl), year)

proc g_date_subtract_days(self: ptr Date00; nDays: uint32) {.
    importc, libprag.}

proc subtractDays*(self: Date; nDays: int) =
  g_date_subtract_days(cast[ptr Date00](self.impl), uint32(nDays))

proc g_date_subtract_months(self: ptr Date00; nMonths: uint32) {.
    importc, libprag.}

proc subtractMonths*(self: Date; nMonths: int) =
  g_date_subtract_months(cast[ptr Date00](self.impl), uint32(nMonths))

proc g_date_subtract_years(self: ptr Date00; nYears: uint32) {.
    importc, libprag.}

proc subtractYears*(self: Date; nYears: int) =
  g_date_subtract_years(cast[ptr Date00](self.impl), uint32(nYears))

proc g_date_to_struct_tm(self: ptr Date00; tm: pointer) {.
    importc, libprag.}

proc toStructTm*(self: Date; tm: pointer) =
  g_date_to_struct_tm(cast[ptr Date00](self.impl), tm)

proc g_date_valid(self: ptr Date00): gboolean {.
    importc, libprag.}

proc valid*(self: Date): bool =
  toBool(g_date_valid(cast[ptr Date00](self.impl)))

proc getMondayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_monday_weeks_in_year", libprag.}

proc mondayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_monday_weeks_in_year", libprag.}

proc getSundayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_sunday_weeks_in_year", libprag.}

proc sundayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_sunday_weeks_in_year", libprag.}

proc g_date_is_leap_year(year: uint16): gboolean {.
    importc, libprag.}

proc isLeapYear*(year: uint16): bool =
  toBool(g_date_is_leap_year(year))

proc g_date_strftime(s: cstring; slen: uint64; format: cstring; date: ptr Date00): uint64 {.
    importc, libprag.}

proc strftime*(s: cstring; slen: uint64; format: cstring; date: Date): uint64 =
  g_date_strftime(s, slen, format, cast[ptr Date00](date.impl))

proc g_date_valid_day(day: uint8): gboolean {.
    importc, libprag.}

proc validDay*(day: uint8): bool =
  toBool(g_date_valid_day(day))

proc g_date_valid_julian(julianDate: uint32): gboolean {.
    importc, libprag.}

proc validJulian*(julianDate: int): bool =
  toBool(g_date_valid_julian(uint32(julianDate)))

proc g_date_valid_year(year: uint16): gboolean {.
    importc, libprag.}

proc validYear*(year: uint16): bool =
  toBool(g_date_valid_year(year))

type
  DateMonth* {.size: sizeof(cint), pure.} = enum
    badMonth = 0
    january = 1
    february = 2
    march = 3
    april = 4
    may = 5
    june = 6
    july = 7
    august = 8
    september = 9
    october = 10
    november = 11
    december = 12

proc g_date_new_dmy(day: uint8; month: DateMonth; year: uint16): ptr Date00 {.
    importc, libprag.}

proc newDateDmy*(day: uint8; month: DateMonth; year: uint16): Date =
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new_dmy(day, month, year)

proc newDateDmy*(tdesc: typedesc; day: uint8; month: DateMonth; year: uint16): tdesc =
  assert(result is Date)
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new_dmy(day, month, year)

proc initDateDmy*[T](result: var T; day: uint8; month: DateMonth; year: uint16) {.deprecated.} =
  assert(result is Date)
  fnew(result, gBoxedFreeGDate)
  result.impl = g_date_new_dmy(day, month, year)

proc g_date_get_month(self: ptr Date00): DateMonth {.
    importc, libprag.}

proc getMonth*(self: Date): DateMonth =
  g_date_get_month(cast[ptr Date00](self.impl))

proc month*(self: Date): DateMonth =
  g_date_get_month(cast[ptr Date00](self.impl))

proc g_date_set_dmy(self: ptr Date00; day: uint8; month: DateMonth; y: uint16) {.
    importc, libprag.}

proc setDmy*(self: Date; day: uint8; month: DateMonth; y: uint16) =
  g_date_set_dmy(cast[ptr Date00](self.impl), day, month, y)

proc g_date_set_month(self: ptr Date00; month: DateMonth) {.
    importc, libprag.}

proc setMonth*(self: Date; month: DateMonth) =
  g_date_set_month(cast[ptr Date00](self.impl), month)

proc `month=`*(self: Date; month: DateMonth) =
  g_date_set_month(cast[ptr Date00](self.impl), month)

proc getDaysInMonth*(month: DateMonth; year: uint16): uint8 {.
    importc: "g_date_get_days_in_month", libprag.}

proc g_date_valid_dmy(day: uint8; month: DateMonth; year: uint16): gboolean {.
    importc, libprag.}

proc validDmy*(day: uint8; month: DateMonth; year: uint16): bool =
  toBool(g_date_valid_dmy(day, month, year))

proc g_date_valid_month(month: DateMonth): gboolean {.
    importc, libprag.}

proc validMonth*(month: DateMonth): bool =
  toBool(g_date_valid_month(month))

type
  DateWeekday* {.size: sizeof(cint), pure.} = enum
    badWeekday = 0
    monday = 1
    tuesday = 2
    wednesday = 3
    thursday = 4
    friday = 5
    saturday = 6
    sunday = 7

proc g_date_get_weekday(self: ptr Date00): DateWeekday {.
    importc, libprag.}

proc getWeekday*(self: Date): DateWeekday =
  g_date_get_weekday(cast[ptr Date00](self.impl))

proc weekday*(self: Date): DateWeekday =
  g_date_get_weekday(cast[ptr Date00](self.impl))

proc g_date_valid_weekday(weekday: DateWeekday): gboolean {.
    importc, libprag.}

proc validWeekday*(weekday: DateWeekday): bool =
  toBool(g_date_valid_weekday(weekday))

type
  DateDMY* {.size: sizeof(cint), pure.} = enum
    day = 0
    month = 1
    year = 2

type
  DebugKey* {.pure, byRef.} = object
    key*: cstring
    value*: uint32

type
  DestroyNotify* = proc (data: pointer) {.cdecl.}

type
  Dir* {.pure, byRef.} = object

proc g_dir_close(self: Dir) {.
    importc, libprag.}

proc close*(self: Dir) =
  g_dir_close(self)

proc g_dir_read_name(self: Dir): cstring {.
    importc, libprag.}

proc readName*(self: Dir): string =
  result = $g_dir_read_name(self)

proc g_dir_rewind(self: Dir) {.
    importc, libprag.}

proc rewind*(self: Dir) =
  g_dir_rewind(self)

proc g_dir_make_tmp(tmpl: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc makeTmp*(tmpl: cstring = nil): string =
  var gerror: ptr glib.Error
  let resul0 = g_dir_make_tmp(tmpl, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

type
  DoubleIEEE754* {.pure, byRef, union.} = object
    vDouble*: cdouble

type
  DuplicateFunc* = proc (data: pointer; userData: pointer): pointer {.cdecl.}

const E* = 2.718282'f64

type
  EqualFunc* = proc (a: pointer; b: pointer): gboolean {.cdecl.}

type
  ErrorType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    unexpEof = 1
    unexpEofInString = 2
    unexpEofInComment = 3
    nonDigitInConst = 4
    digitRadix = 5
    floatRadix = 6
    floatMalformed = 7

type
  FileError* {.size: sizeof(cint), pure.} = enum
    exist = 0
    isdir = 1
    acces = 2
    nametoolong = 3
    noent = 4
    notdir = 5
    nxio = 6
    nodev = 7
    rofs = 8
    txtbsy = 9
    fault = 10
    loop = 11
    nospc = 12
    nomem = 13
    mfile = 14
    nfile = 15
    badf = 16
    inval = 17
    pipe = 18
    again = 19
    intr = 20
    io = 21
    perm = 22
    nosys = 23
    failed = 24

type
  FileSetContentsFlag* {.size: sizeof(cint), pure.} = enum
    consistent = 0
    durable = 1
    onlyExisting = 2

  FileSetContentsFlags* {.size: sizeof(cint).} = set[FileSetContentsFlag]

const
  FileSetContentsFlagsNone* = FileSetContentsFlags({})
proc none*(t: typedesc[FileSetContentsFlags]): FileSetContentsFlags = FileSetContentsFlags({})

type
  FileTest* {.size: sizeof(cint), pure.} = enum
    isRegular = 1
    isSymlink = 2
    isDir = 4
    isExecutable = 8
    exists = 16

type
  FloatIEEE754* {.pure, byRef, union.} = object
    vFloat*: cfloat

type
  FormatSizeFlag* {.size: sizeof(cint), pure.} = enum
    longFormat = 0
    iecUnits = 1
    bits = 2

  FormatSizeFlags* {.size: sizeof(cint).} = set[FormatSizeFlag]

const
  FormatSizeFlagsDefault* = FormatSizeFlags({})
proc default*(t: typedesc[FormatSizeFlags]): FormatSizeFlags = FormatSizeFlags({})

type
  FreeFunc* = proc (data: pointer) {.cdecl.}

type
  Func* = proc (data: pointer; userData: pointer) {.cdecl.}

const GINT16_FORMAT* = "hi"

const GINT16_MODIFIER* = "h"

const GINT32_FORMAT* = "i"

const GINT32_MODIFIER* = ""

const GINT64_FORMAT* = "li"

const GINT64_MODIFIER* = "l"

const GINTPTR_FORMAT* = "li"

const GINTPTR_MODIFIER* = "l"

const GNUC_FUNCTION* = ""

const GNUC_PRETTY_FUNCTION* = ""

const GSIZE_FORMAT* = "lu"

const GSIZE_MODIFIER* = "l"

const GSSIZE_FORMAT* = "li"

const GSSIZE_MODIFIER* = "l"

const GUINT16_FORMAT* = "hu"

const GUINT32_FORMAT* = "u"

const GUINT64_FORMAT* = "lu"

const GUINTPTR_FORMAT* = "lu"

const HAVE_GINT64* = 1'i32

const HAVE_GNUC_VARARGS* = 1'i32

const HAVE_GNUC_VISIBILITY* = 1'i32

const HAVE_GROWING_STACK* = 0'i32

const HAVE_ISO_VARARGS* = 1'i32

type
  HFunc* = proc (key: pointer; value: pointer; userData: pointer) {.cdecl.}

const HOOK_FLAG_USER_SHIFT* = 4'i32

type
  HRFunc* = proc (key: pointer; value: pointer; userData: pointer): gboolean {.cdecl.}

type
  HashFunc* = proc (key: pointer): uint32 {.cdecl.}

type
  HashTable00* {.pure.} = object
  HashTable* = ref object
    impl*: ptr HashTable00
    ignoreFinalizer*: bool

proc g_hash_table_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGHashTable*(self: HashTable) =
  if not self.ignoreFinalizer:
    boxedFree(g_hash_table_get_type(), cast[ptr HashTable00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HashTable()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_hash_table_get_type(), cast[ptr HashTable00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var HashTable) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGHashTable)

proc g_hash_table_unref(hashTable: ptr HashTable00) {.
    importc, libprag.}

proc unref*(hashTable: ptr HashTable00) =
  g_hash_table_unref(hashTable)

proc finalizerunref*(self: HashTable) =
  if not self.ignoreFinalizer:
    g_hash_table_unref(cast[ptr HashTable00](self.impl))

proc g_hash_table_contains(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc, libprag.}

proc contains*(hashTable: ptr HashTable00; key: pointer): bool =
  toBool(g_hash_table_contains(hashTable, key))

proc g_hash_table_insert(hashTable: ptr HashTable00; key: pointer; value: pointer): gboolean {.
    importc, libprag.}

proc insert*(hashTable: ptr HashTable00; key: pointer; value: pointer): bool =
  toBool(g_hash_table_insert(hashTable, key, value))

proc lookup*(hashTable: ptr HashTable00; key: pointer): pointer {.
    importc: "g_hash_table_lookup", libprag.}

proc g_hash_table_lookup_extended(hashTable: ptr HashTable00; lookupKey: pointer;
    origKey: var pointer; value: var pointer): gboolean {.
    importc, libprag.}

proc lookupExtended*(hashTable: ptr HashTable00; lookupKey: pointer;
    origKey: var pointer = cast[var pointer](nil); value: var pointer = cast[var pointer](nil)): bool =
  toBool(g_hash_table_lookup_extended(hashTable, lookupKey, origKey, value))

proc g_hash_table_remove(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc, libprag.}

proc remove*(hashTable: ptr HashTable00; key: pointer): bool =
  toBool(g_hash_table_remove(hashTable, key))

proc removeAll*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_remove_all", libprag.}

proc g_hash_table_replace(hashTable: ptr HashTable00; key: pointer; value: pointer): gboolean {.
    importc, libprag.}

proc replace*(hashTable: ptr HashTable00; key: pointer; value: pointer): bool =
  toBool(g_hash_table_replace(hashTable, key, value))

proc g_hash_table_size(hashTable: ptr HashTable00): uint32 {.
    importc, libprag.}

proc size*(hashTable: ptr HashTable00): int =
  int(g_hash_table_size(hashTable))

proc g_hash_table_steal(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc, libprag.}

proc steal*(hashTable: ptr HashTable00; key: pointer): bool =
  toBool(g_hash_table_steal(hashTable, key))

proc stealAll*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_steal_all", libprag.}

proc g_hash_table_steal_extended(hashTable: ptr HashTable00; lookupKey: pointer;
    stolenKey: var pointer; stolenValue: var pointer): gboolean {.
    importc, libprag.}

proc stealExtended*(hashTable: ptr HashTable00; lookupKey: pointer;
    stolenKey: var pointer = cast[var pointer](nil); stolenValue: var pointer = cast[var pointer](nil)): bool =
  toBool(g_hash_table_steal_extended(hashTable, lookupKey, stolenKey, stolenValue))

proc g_hash_table_add(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc, libprag.}

proc add*(hashTable: ptr HashTable00; key: pointer): bool =
  toBool(g_hash_table_add(hashTable, key))

type
  HashTableIter* {.pure, byRef.} = object
    dummy1*: pointer
    dummy2*: pointer
    dummy3*: pointer
    dummy4*: int32
    dummy5*: gboolean
    dummy6*: pointer

proc g_hash_table_iter_init(self: HashTableIter; hashTable: ptr HashTable00) {.
    importc, libprag.}

proc init*(self: HashTableIter; hashTable: ptr HashTable00) =
  g_hash_table_iter_init(self, hashTable)

proc g_hash_table_iter_next(self: HashTableIter; key: var pointer; value: var pointer): gboolean {.
    importc, libprag.}

proc next*(self: HashTableIter; key: var pointer = cast[var pointer](nil);
    value: var pointer = cast[var pointer](nil)): bool =
  toBool(g_hash_table_iter_next(self, key, value))

proc g_hash_table_iter_remove(self: HashTableIter) {.
    importc, libprag.}

proc remove*(self: HashTableIter) =
  g_hash_table_iter_remove(self)

proc g_hash_table_iter_replace(self: HashTableIter; value: pointer) {.
    importc, libprag.}

proc replace*(self: HashTableIter; value: pointer) =
  g_hash_table_iter_replace(self, value)

proc g_hash_table_iter_steal(self: HashTableIter) {.
    importc, libprag.}

proc steal*(self: HashTableIter) =
  g_hash_table_iter_steal(self)

type
  Hmac00* {.pure.} = object
  Hmac* = ref object
    impl*: ptr Hmac00
    ignoreFinalizer*: bool

proc g_hmac_unref(self: ptr Hmac00) {.
    importc, libprag.}

proc unref*(self: Hmac) =
  g_hmac_unref(cast[ptr Hmac00](self.impl))

proc finalizerunref*(self: Hmac) =
  if not self.ignoreFinalizer:
    g_hmac_unref(cast[ptr Hmac00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Hmac()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_hmac_unref(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Hmac) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerunref)

proc g_hmac_get_string(self: ptr Hmac00): cstring {.
    importc, libprag.}

proc getString*(self: Hmac): string =
  result = $g_hmac_get_string(cast[ptr Hmac00](self.impl))

proc g_hmac_get_digest(self: ptr Hmac00; buffer: ptr uint8; digestLen: var uint64) {.
    importc, libprag.}

proc getDigest*(self: Hmac; buffer: seq[uint8] | string; digestLen: var uint64) =
  g_hmac_get_digest(cast[ptr Hmac00](self.impl), cast[ptr uint8](unsafeaddr(buffer[0])), digestLen)

proc g_hmac_update(self: ptr Hmac00; data: ptr uint8; length: int64) {.
    importc, libprag.}

proc update*(self: Hmac; data: seq[uint8] | string) =
  let length = int64(data.len)
  g_hmac_update(cast[ptr Hmac00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

type
  Hook00* {.pure.} = object
  Hook* = ref object
    impl*: ptr Hook00
    ignoreFinalizer*: bool

proc g_hook_compare_ids(self: ptr Hook00; sibling: ptr Hook00): int32 {.
    importc, libprag.}

proc compareIds*(self: Hook; sibling: Hook): int =
  int(g_hook_compare_ids(cast[ptr Hook00](self.impl), cast[ptr Hook00](sibling.impl)))

type
  HookList00* {.pure.} = object
  HookList* = ref object
    impl*: ptr HookList00
    ignoreFinalizer*: bool

proc g_hook_list_clear(self: ptr HookList00) {.
    importc, libprag.}

proc clear*(self: HookList) =
  g_hook_list_clear(cast[ptr HookList00](self.impl))

proc g_hook_list_init(self: ptr HookList00; hookSize: uint32) {.
    importc, libprag.}

proc init*(self: HookList; hookSize: int) =
  g_hook_list_init(cast[ptr HookList00](self.impl), uint32(hookSize))

proc g_hook_list_invoke(self: ptr HookList00; mayRecurse: gboolean) {.
    importc, libprag.}

proc invoke*(self: HookList; mayRecurse: bool) =
  g_hook_list_invoke(cast[ptr HookList00](self.impl), gboolean(mayRecurse))

proc g_hook_list_invoke_check(self: ptr HookList00; mayRecurse: gboolean) {.
    importc, libprag.}

proc invokeCheck*(self: HookList; mayRecurse: bool) =
  g_hook_list_invoke_check(cast[ptr HookList00](self.impl), gboolean(mayRecurse))

proc g_hook_free(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc, libprag.}

proc free*(hookList: HookList; hook: Hook) =
  g_hook_free(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

proc g_hook_destroy(hookList: ptr HookList00; hookId: uint64): gboolean {.
    importc, libprag.}

proc destroy*(hookList: HookList; hookId: uint64): bool =
  toBool(g_hook_destroy(cast[ptr HookList00](hookList.impl), hookId))

proc g_hook_destroy_link(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc, libprag.}

proc destroyLink*(hookList: HookList; hook: Hook) =
  g_hook_destroy_link(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

proc g_hook_insert_before(hookList: ptr HookList00; sibling: ptr Hook00;
    hook: ptr Hook00) {.
    importc, libprag.}

proc insertBefore*(hookList: HookList; sibling: Hook = nil; hook: Hook) =
  g_hook_insert_before(cast[ptr HookList00](hookList.impl), if sibling.isNil: nil else: cast[ptr Hook00](sibling.impl), cast[ptr Hook00](hook.impl))

proc g_hook_prepend(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc, libprag.}

proc prepend*(hookList: HookList; hook: Hook) =
  g_hook_prepend(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

proc g_hook_unref(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc, libprag.}

proc unref*(hookList: HookList; hook: Hook) =
  g_hook_unref(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

type
  HookCheckFunc* = proc (data: pointer): gboolean {.cdecl.}

type
  HookCheckMarshaller* = proc (hook: ptr Hook00; marshalData: pointer): gboolean {.cdecl.}

type
  HookCompareFunc* = proc (newHook: ptr Hook00; sibling: ptr Hook00): int32 {.cdecl.}

type
  HookFinalizeFunc* = proc (hookList: ptr HookList00; hook: ptr Hook00) {.cdecl.}

type
  HookFindFunc* = proc (hook: ptr Hook00; data: pointer): gboolean {.cdecl.}

type
  HookFlagMask* {.size: sizeof(cint), pure.} = enum
    active = 1
    inCall = 2
    mask = 15

type
  HookFunc* = proc (data: pointer) {.cdecl.}

type
  HookMarshaller* = proc (hook: ptr Hook00; marshalData: pointer) {.cdecl.}

const IEEE754_DOUBLE_BIAS* = 1023'i32

const IEEE754_FLOAT_BIAS* = 127'i32

type
  IOChannel00* {.pure.} = object
  IOChannel* = ref object
    impl*: ptr IOChannel00
    ignoreFinalizer*: bool

proc g_io_channel_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGIOChannel*(self: IOChannel) =
  if not self.ignoreFinalizer:
    boxedFree(g_io_channel_get_type(), cast[ptr IOChannel00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(IOChannel()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_io_channel_get_type(), cast[ptr IOChannel00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var IOChannel) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGIOChannel)

proc g_io_channel_unref(self: ptr IOChannel00) {.
    importc, libprag.}

proc unref*(self: IOChannel) =
  g_io_channel_unref(cast[ptr IOChannel00](self.impl))

proc finalizerunref*(self: IOChannel) =
  if not self.ignoreFinalizer:
    g_io_channel_unref(cast[ptr IOChannel00](self.impl))

proc g_io_channel_unix_new(fd: int32): ptr IOChannel00 {.
    importc, libprag.}

proc unixNew*(fd: int): IOChannel =
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = g_io_channel_unix_new(int32(fd))

proc unixNew*(tdesc: typedesc; fd: int): tdesc =
  assert(result is IOChannel)
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = g_io_channel_unix_new(int32(fd))

proc unixNew*[T](result: var T; fd: int) {.deprecated.} =
  assert(result is IOChannel)
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = g_io_channel_unix_new(int32(fd))

proc g_io_channel_close(self: ptr IOChannel00) {.
    importc, libprag.}

proc close*(self: IOChannel) =
  g_io_channel_close(cast[ptr IOChannel00](self.impl))

proc g_io_channel_get_buffer_size(self: ptr IOChannel00): uint64 {.
    importc, libprag.}

proc getBufferSize*(self: IOChannel): uint64 =
  g_io_channel_get_buffer_size(cast[ptr IOChannel00](self.impl))

proc bufferSize*(self: IOChannel): uint64 =
  g_io_channel_get_buffer_size(cast[ptr IOChannel00](self.impl))

proc g_io_channel_get_buffered(self: ptr IOChannel00): gboolean {.
    importc, libprag.}

proc getBuffered*(self: IOChannel): bool =
  toBool(g_io_channel_get_buffered(cast[ptr IOChannel00](self.impl)))

proc buffered*(self: IOChannel): bool =
  toBool(g_io_channel_get_buffered(cast[ptr IOChannel00](self.impl)))

proc g_io_channel_get_close_on_unref(self: ptr IOChannel00): gboolean {.
    importc, libprag.}

proc getCloseOnUnref*(self: IOChannel): bool =
  toBool(g_io_channel_get_close_on_unref(cast[ptr IOChannel00](self.impl)))

proc closeOnUnref*(self: IOChannel): bool =
  toBool(g_io_channel_get_close_on_unref(cast[ptr IOChannel00](self.impl)))

proc g_io_channel_get_encoding(self: ptr IOChannel00): cstring {.
    importc, libprag.}

proc getEncoding*(self: IOChannel): string =
  result = $g_io_channel_get_encoding(cast[ptr IOChannel00](self.impl))

proc encoding*(self: IOChannel): string =
  result = $g_io_channel_get_encoding(cast[ptr IOChannel00](self.impl))

proc g_io_channel_get_line_term(self: ptr IOChannel00; length: ptr int32): cstring {.
    importc, libprag.}

proc getLineTerm*(self: IOChannel; length: ptr int32): string =
  result = $g_io_channel_get_line_term(cast[ptr IOChannel00](self.impl), length)

proc g_io_channel_init(self: ptr IOChannel00) {.
    importc, libprag.}

proc init*(self: IOChannel) =
  g_io_channel_init(cast[ptr IOChannel00](self.impl))

proc g_io_channel_ref(self: ptr IOChannel00): ptr IOChannel00 {.
    importc, libprag.}

proc `ref`*(self: IOChannel): IOChannel =
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = g_io_channel_ref(cast[ptr IOChannel00](self.impl))

proc g_io_channel_set_buffer_size(self: ptr IOChannel00; size: uint64) {.
    importc, libprag.}

proc setBufferSize*(self: IOChannel; size: uint64) =
  g_io_channel_set_buffer_size(cast[ptr IOChannel00](self.impl), size)

proc `bufferSize=`*(self: IOChannel; size: uint64) =
  g_io_channel_set_buffer_size(cast[ptr IOChannel00](self.impl), size)

proc g_io_channel_set_buffered(self: ptr IOChannel00; buffered: gboolean) {.
    importc, libprag.}

proc setBuffered*(self: IOChannel; buffered: bool = true) =
  g_io_channel_set_buffered(cast[ptr IOChannel00](self.impl), gboolean(buffered))

proc `buffered=`*(self: IOChannel; buffered: bool) =
  g_io_channel_set_buffered(cast[ptr IOChannel00](self.impl), gboolean(buffered))

proc g_io_channel_set_close_on_unref(self: ptr IOChannel00; doClose: gboolean) {.
    importc, libprag.}

proc setCloseOnUnref*(self: IOChannel; doClose: bool = true) =
  g_io_channel_set_close_on_unref(cast[ptr IOChannel00](self.impl), gboolean(doClose))

proc `closeOnUnref=`*(self: IOChannel; doClose: bool) =
  g_io_channel_set_close_on_unref(cast[ptr IOChannel00](self.impl), gboolean(doClose))

proc g_io_channel_set_line_term(self: ptr IOChannel00; lineTerm: cstring;
    length: int32) {.
    importc, libprag.}

proc setLineTerm*(self: IOChannel; lineTerm: cstring = nil;
    length: int) =
  g_io_channel_set_line_term(cast[ptr IOChannel00](self.impl), lineTerm, int32(length))

proc g_io_channel_unix_get_fd(self: ptr IOChannel00): int32 {.
    importc, libprag.}

proc unixGetFd*(self: IOChannel): int =
  int(g_io_channel_unix_get_fd(cast[ptr IOChannel00](self.impl)))

proc g_io_channel_new_file(filename: cstring; mode: cstring; error: ptr ptr glib.Error = nil): ptr IOChannel00 {.
    importc, libprag.}

proc newIOChannelFile*(filename: cstring; mode: cstring): IOChannel =
  var gerror: ptr glib.Error
  let impl0 = g_io_channel_new_file(filename, mode, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = impl0

proc newIOChannelFile*(tdesc: typedesc; filename: cstring; mode: cstring): tdesc =
  var gerror: ptr glib.Error
  assert(result is IOChannel)
  let impl0 = g_io_channel_new_file(filename, mode, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = impl0

proc initIOChannelFile*[T](result: var T; filename: cstring; mode: cstring) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is IOChannel)
  let impl0 = g_io_channel_new_file(filename, mode, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = impl0

type
  IOCFlag* {.size: sizeof(cint), pure.} = enum
    `in` = 0
    pri = 1
    `out` = 2
    err = 3
    hup = 4
    nval = 5

  IOCondition* {.size: sizeof(cint).} = set[IOCFlag]

proc g_io_channel_get_buffer_condition(self: ptr IOChannel00): IOCondition {.
    importc, libprag.}

proc getBufferCondition*(self: IOChannel): IOCondition =
  g_io_channel_get_buffer_condition(cast[ptr IOChannel00](self.impl))

proc bufferCondition*(self: IOChannel): IOCondition =
  g_io_channel_get_buffer_condition(cast[ptr IOChannel00](self.impl))

type
  String* {.pure, byRef.} = object
    str*: cstring
    len*: uint64
    allocatedLen*: uint64

proc g_string_free(self: String; freeSegment: gboolean): cstring {.
    importc, libprag.}

proc free*(self: String; freeSegment: bool): string =
  let resul0 = g_string_free(self, gboolean(freeSegment))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_string_append_c(self: String; c: int8): ptr String {.
    importc, libprag.}

proc appendC*(self: String; c: int8): ptr String =
  g_string_append_c(self, c)

proc g_string_append_len(self: String; val: cstring; len: int64): ptr String {.
    importc, libprag.}

proc appendLen*(self: String; val: cstring; len: int64): ptr String =
  g_string_append_len(self, val, len)

proc g_string_append_unichar(self: String; wc: gunichar): ptr String {.
    importc, libprag.}

proc appendUnichar*(self: String; wc: gunichar): ptr String =
  g_string_append_unichar(self, wc)

proc g_string_append_uri_escaped(self: String; unescaped: cstring; reservedCharsAllowed: cstring;
    allowUtf8: gboolean): ptr String {.
    importc, libprag.}

proc appendUriEscaped*(self: String; unescaped: cstring; reservedCharsAllowed: cstring;
    allowUtf8: bool): ptr String =
  g_string_append_uri_escaped(self, unescaped, reservedCharsAllowed, gboolean(allowUtf8))

proc g_string_ascii_down(self: String): ptr String {.
    importc, libprag.}

proc asciiDown*(self: String): ptr String =
  g_string_ascii_down(self)

proc g_string_ascii_up(self: String): ptr String {.
    importc, libprag.}

proc asciiUp*(self: String): ptr String =
  g_string_ascii_up(self)

proc g_string_assign(self: String; rval: cstring): ptr String {.
    importc, libprag.}

proc assign*(self: String; rval: cstring): ptr String =
  g_string_assign(self, rval)

proc g_string_down(self: String): ptr String {.
    importc, libprag.}

proc down*(self: String): ptr String =
  g_string_down(self)

proc g_string_equal(self: String; v2: String): gboolean {.
    importc, libprag.}

proc equal*(self: String; v2: String): bool =
  toBool(g_string_equal(self, v2))

proc g_string_erase(self: String; pos: int64; len: int64): ptr String {.
    importc, libprag.}

proc erase*(self: String; pos: int64; len: int64): ptr String =
  g_string_erase(self, pos, len)

proc g_string_append(self: String; val: cstring): ptr String {.
    importc, libprag.}

proc append*(self: String; val: cstring): ptr String =
  g_string_append(self, val)

proc g_string_free_to_bytes(self: String): ptr Bytes00 {.
    importc, libprag.}

proc freeToBytes*(self: String): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_string_free_to_bytes(self)

proc g_string_hash(self: String): uint32 {.
    importc, libprag.}

proc hash*(self: String): int =
  int(g_string_hash(self))

proc g_string_insert(self: String; pos: int64; val: cstring): ptr String {.
    importc, libprag.}

proc insert*(self: String; pos: int64; val: cstring): ptr String =
  g_string_insert(self, pos, val)

proc g_string_insert_c(self: String; pos: int64; c: int8): ptr String {.
    importc, libprag.}

proc insertC*(self: String; pos: int64; c: int8): ptr String =
  g_string_insert_c(self, pos, c)

proc g_string_insert_len(self: String; pos: int64; val: cstring; len: int64): ptr String {.
    importc, libprag.}

proc insertLen*(self: String; pos: int64; val: cstring; len: int64): ptr String =
  g_string_insert_len(self, pos, val, len)

proc g_string_insert_unichar(self: String; pos: int64; wc: gunichar): ptr String {.
    importc, libprag.}

proc insertUnichar*(self: String; pos: int64; wc: gunichar): ptr String =
  g_string_insert_unichar(self, pos, wc)

proc g_string_overwrite(self: String; pos: uint64; val: cstring): ptr String {.
    importc, libprag.}

proc overwrite*(self: String; pos: uint64; val: cstring): ptr String =
  g_string_overwrite(self, pos, val)

proc g_string_overwrite_len(self: String; pos: uint64; val: cstring; len: int64): ptr String {.
    importc, libprag.}

proc overwriteLen*(self: String; pos: uint64; val: cstring; len: int64): ptr String =
  g_string_overwrite_len(self, pos, val, len)

proc g_string_prepend(self: String; val: cstring): ptr String {.
    importc, libprag.}

proc prepend*(self: String; val: cstring): ptr String =
  g_string_prepend(self, val)

proc g_string_prepend_c(self: String; c: int8): ptr String {.
    importc, libprag.}

proc prependC*(self: String; c: int8): ptr String =
  g_string_prepend_c(self, c)

proc g_string_prepend_len(self: String; val: cstring; len: int64): ptr String {.
    importc, libprag.}

proc prependLen*(self: String; val: cstring; len: int64): ptr String =
  g_string_prepend_len(self, val, len)

proc g_string_prepend_unichar(self: String; wc: gunichar): ptr String {.
    importc, libprag.}

proc prependUnichar*(self: String; wc: gunichar): ptr String =
  g_string_prepend_unichar(self, wc)

proc g_string_set_size(self: String; len: uint64): ptr String {.
    importc, libprag.}

proc setSize*(self: String; len: uint64): ptr String =
  g_string_set_size(self, len)

proc g_string_truncate(self: String; len: uint64): ptr String {.
    importc, libprag.}

proc truncate*(self: String; len: uint64): ptr String =
  g_string_truncate(self, len)

proc g_string_up(self: String): ptr String {.
    importc, libprag.}

proc up*(self: String): ptr String =
  g_string_up(self)

type
  SeekType* {.size: sizeof(cint), pure.} = enum
    cur = 0
    set = 1
    `end` = 2

type
  IOFlags* {.size: sizeof(cint), pure.} = enum
    append = 1
    nonblock = 2
    setMask = 3
    isReadable = 4
    isWritable = 8
    isSeekable = 16
    getMask = 31

const
  IOFlagsMask* = IOFlags.getMask
  IOFlagsIsWriteable* = IOFlags.isWritable

proc g_io_channel_get_flags(self: ptr IOChannel00): IOFlags {.
    importc, libprag.}

proc getFlags*(self: IOChannel): IOFlags =
  g_io_channel_get_flags(cast[ptr IOChannel00](self.impl))

proc flags*(self: IOChannel): IOFlags =
  g_io_channel_get_flags(cast[ptr IOChannel00](self.impl))

type
  IOError* {.size: sizeof(cint), pure.} = enum
    none = 0
    again = 1
    inval = 2
    unknown = 3

proc g_io_channel_read(self: ptr IOChannel00; buf: cstring; count: uint64;
    bytesRead: ptr uint64): IOError {.
    importc, libprag.}

proc read*(self: IOChannel; buf: cstring; count: uint64; bytesRead: ptr uint64): IOError =
  g_io_channel_read(cast[ptr IOChannel00](self.impl), buf, count, bytesRead)

proc g_io_channel_seek(self: ptr IOChannel00; offset: int64; `type`: SeekType): IOError {.
    importc, libprag.}

proc seek*(self: IOChannel; offset: int64; `type`: SeekType): IOError =
  g_io_channel_seek(cast[ptr IOChannel00](self.impl), offset, `type`)

proc g_io_channel_write(self: ptr IOChannel00; buf: cstring; count: uint64;
    bytesWritten: ptr uint64): IOError {.
    importc, libprag.}

proc write*(self: IOChannel; buf: cstring; count: uint64; bytesWritten: ptr uint64): IOError =
  g_io_channel_write(cast[ptr IOChannel00](self.impl), buf, count, bytesWritten)

type
  IOStatus* {.size: sizeof(cint), pure.} = enum
    error = 0
    normal = 1
    eof = 2
    again = 3

proc g_io_channel_flush(self: ptr IOChannel00; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc flush*(self: IOChannel): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_flush(cast[ptr IOChannel00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_read_chars(self: ptr IOChannel00; buf: ptr uint8; count: uint64;
    bytesRead: var uint64; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc readChars*(self: IOChannel; buf: var (seq[uint8] | string);
    bytesRead: var uint64 = cast[var uint64](nil)): IOStatus =
  let count = uint64(buf.len)
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_read_chars(cast[ptr IOChannel00](self.impl), cast[ptr uint8](unsafeaddr(buf[0])), count, bytesRead, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_read_line(self: ptr IOChannel00; strReturn: var cstring;
    length: var uint64; terminatorPos: var uint64; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc readLine*(self: IOChannel; strReturn: var string; length: var uint64 = cast[var uint64](nil);
    terminatorPos: var uint64 = cast[var uint64](nil)): IOStatus =
  var gerror: ptr glib.Error
  var strReturn_00: cstring
  let resul0 = g_io_channel_read_line(cast[ptr IOChannel00](self.impl), strReturn_00, length, terminatorPos, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0
  if strReturn.addr != nil:
    strReturn = $(strReturn_00)

proc g_io_channel_read_line_string(self: ptr IOChannel00; buffer: String;
    terminatorPos: ptr uint64; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc readLineString*(self: IOChannel; buffer: String; terminatorPos: ptr uint64): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_read_line_string(cast[ptr IOChannel00](self.impl), buffer, terminatorPos, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_read_to_end(self: ptr IOChannel00; strReturn: var ptr uint8;
    length: var uint64; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc readToEnd*(self: IOChannel; strReturn: var (seq[uint8] | string);
    length: var uint64): IOStatus =
  var gerror: ptr glib.Error
  var strReturn_00: ptr uint8
  let resul0 = g_io_channel_read_to_end(cast[ptr IOChannel00](self.impl), strReturn_00, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0
  strReturn.setLen(length)
  copyMem(unsafeaddr strReturn[0], strReturn_00, length.int * sizeof(strReturn[0]))
  cogfree(strReturn_00)

proc g_io_channel_read_unichar(self: ptr IOChannel00; thechar: var gunichar;
    error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc readUnichar*(self: IOChannel; thechar: var gunichar): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_read_unichar(cast[ptr IOChannel00](self.impl), thechar, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_seek_position(self: ptr IOChannel00; offset: int64; `type`: SeekType;
    error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc seekPosition*(self: IOChannel; offset: int64; `type`: SeekType): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_seek_position(cast[ptr IOChannel00](self.impl), offset, `type`, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_set_encoding(self: ptr IOChannel00; encoding: cstring;
    error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc setEncoding*(self: IOChannel; encoding: cstring = nil): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_set_encoding(cast[ptr IOChannel00](self.impl), encoding, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_set_flags(self: ptr IOChannel00; flags: IOFlags; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc setFlags*(self: IOChannel; flags: IOFlags): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_set_flags(cast[ptr IOChannel00](self.impl), flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_shutdown(self: ptr IOChannel00; flush: gboolean; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc shutdown*(self: IOChannel; flush: bool): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_shutdown(cast[ptr IOChannel00](self.impl), gboolean(flush), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_write_chars(self: ptr IOChannel00; buf: ptr uint8; count: int64;
    bytesWritten: var uint64; error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc writeChars*(self: IOChannel; buf: seq[uint8] | string;
    count: int64; bytesWritten: var uint64): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_write_chars(cast[ptr IOChannel00](self.impl), cast[ptr uint8](unsafeaddr(buf[0])), count, bytesWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_io_channel_write_unichar(self: ptr IOChannel00; thechar: gunichar;
    error: ptr ptr glib.Error = nil): IOStatus {.
    importc, libprag.}

proc writeUnichar*(self: IOChannel; thechar: gunichar): IOStatus =
  var gerror: ptr glib.Error
  let resul0 = g_io_channel_write_unichar(cast[ptr IOChannel00](self.impl), thechar, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

type
  IOChannelError* {.size: sizeof(cint), pure.} = enum
    fbig = 0
    inval = 1
    io = 2
    isdir = 3
    nospc = 4
    nxio = 5
    overflow = 6
    pipe = 7
    failed = 8

proc g_io_channel_error_from_errno(en: int32): IOChannelError {.
    importc, libprag.}

proc errorFromErrno*(en: int): IOChannelError =
  g_io_channel_error_from_errno(int32(en))

type
  IOFunc* = proc (source: ptr IOChannel00; condition: IOCondition; data: pointer): gboolean {.cdecl.}

type
  IOFuncs00* {.pure.} = object
  IOFuncs* = ref object
    impl*: ptr IOFuncs00
    ignoreFinalizer*: bool

const KEY_FILE_DESKTOP_GROUP* = "Desktop Entry"

const KEY_FILE_DESKTOP_KEY_ACTIONS* = "Actions"

const KEY_FILE_DESKTOP_KEY_CATEGORIES* = "Categories"

const KEY_FILE_DESKTOP_KEY_COMMENT* = "Comment"

const KEY_FILE_DESKTOP_KEY_DBUS_ACTIVATABLE* = "DBusActivatable"

const KEY_FILE_DESKTOP_KEY_EXEC* = "Exec"

const KEY_FILE_DESKTOP_KEY_GENERIC_NAME* = "GenericName"

const KEY_FILE_DESKTOP_KEY_HIDDEN* = "Hidden"

const KEY_FILE_DESKTOP_KEY_ICON* = "Icon"

const KEY_FILE_DESKTOP_KEY_MIME_TYPE* = "MimeType"

const KEY_FILE_DESKTOP_KEY_NAME* = "Name"

const KEY_FILE_DESKTOP_KEY_NOT_SHOW_IN* = "NotShowIn"

const KEY_FILE_DESKTOP_KEY_NO_DISPLAY* = "NoDisplay"

const KEY_FILE_DESKTOP_KEY_ONLY_SHOW_IN* = "OnlyShowIn"

const KEY_FILE_DESKTOP_KEY_PATH* = "Path"

const KEY_FILE_DESKTOP_KEY_STARTUP_NOTIFY* = "StartupNotify"

const KEY_FILE_DESKTOP_KEY_STARTUP_WM_CLASS* = "StartupWMClass"

const KEY_FILE_DESKTOP_KEY_TERMINAL* = "Terminal"

const KEY_FILE_DESKTOP_KEY_TRY_EXEC* = "TryExec"

const KEY_FILE_DESKTOP_KEY_TYPE* = "Type"

const KEY_FILE_DESKTOP_KEY_URL* = "URL"

const KEY_FILE_DESKTOP_KEY_VERSION* = "Version"

const KEY_FILE_DESKTOP_TYPE_APPLICATION* = "Application"

const KEY_FILE_DESKTOP_TYPE_DIRECTORY* = "Directory"

const KEY_FILE_DESKTOP_TYPE_LINK* = "Link"

type
  KeyFile00* {.pure.} = object
  KeyFile* = ref object
    impl*: ptr KeyFile00
    ignoreFinalizer*: bool

proc g_key_file_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGKeyFile*(self: KeyFile) =
  if not self.ignoreFinalizer:
    boxedFree(g_key_file_get_type(), cast[ptr KeyFile00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(KeyFile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_key_file_get_type(), cast[ptr KeyFile00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var KeyFile) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGKeyFile)

proc g_key_file_unref(self: ptr KeyFile00) {.
    importc, libprag.}

proc unref*(self: KeyFile) =
  g_key_file_unref(cast[ptr KeyFile00](self.impl))

proc finalizerunref*(self: KeyFile) =
  if not self.ignoreFinalizer:
    g_key_file_unref(cast[ptr KeyFile00](self.impl))

proc g_key_file_get_boolean(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getBoolean*(self: KeyFile; groupName: cstring; key: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_boolean(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_get_boolean_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; length: var uint64; error: ptr ptr glib.Error = nil): ptr gboolean {.
    importc, libprag.}

proc getBooleanList*(self: KeyFile; groupName: cstring; key: cstring;
    length: var uint64): ptr gboolean =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_boolean_list(cast[ptr KeyFile00](self.impl), groupName, key, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_key_file_get_comment(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getComment*(self: KeyFile; groupName: cstring = nil; key: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_comment(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_double(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): cdouble {.
    importc, libprag.}

proc getDouble*(self: KeyFile; groupName: cstring; key: cstring): cdouble =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_double(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_key_file_get_double_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; length: var uint64; error: ptr ptr glib.Error = nil): ptr cdouble {.
    importc, libprag.}

proc getDoubleList*(self: KeyFile; groupName: cstring; key: cstring;
    length: var uint64): ptr cdouble =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_double_list(cast[ptr KeyFile00](self.impl), groupName, key, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_key_file_get_groups(self: ptr KeyFile00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc getGroups*(self: KeyFile; length: var uint64 = cast[var uint64](nil)): seq[string] =
  let resul0 = g_key_file_get_groups(cast[ptr KeyFile00](self.impl), length)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_key_file_get_int64(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc getInt64*(self: KeyFile; groupName: cstring; key: cstring): int64 =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_int64(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_key_file_get_integer(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): int32 {.
    importc, libprag.}

proc getInteger*(self: KeyFile; groupName: cstring; key: cstring): int =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_integer(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int(resul0)

proc g_key_file_get_integer_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; length: var uint64; error: ptr ptr glib.Error = nil): ptr int32 {.
    importc, libprag.}

proc getIntegerList*(self: KeyFile; groupName: cstring; key: cstring;
    length: var uint64): seq[int32] =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_integer_list(cast[ptr KeyFile00](self.impl), groupName, key, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int32ArrayToSeq(resul0, length.int)
  cogfree(resul0)

proc g_key_file_get_keys(self: ptr KeyFile00; groupName: cstring; length: var uint64;
    error: ptr ptr glib.Error = nil): ptr cstring {.
    importc, libprag.}

proc getKeys*(self: KeyFile; groupName: cstring; length: var uint64 = cast[var uint64](nil)): seq[string] =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_keys(cast[ptr KeyFile00](self.impl), groupName, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = cstringArrayToSeq(resul0)

proc g_key_file_get_locale_for_key(self: ptr KeyFile00; groupName: cstring;
    key: cstring; locale: cstring): cstring {.
    importc, libprag.}

proc getLocaleForKey*(self: KeyFile; groupName: cstring; key: cstring;
    locale: cstring = nil): string =
  let resul0 = g_key_file_get_locale_for_key(cast[ptr KeyFile00](self.impl), groupName, key, locale)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_locale_string(self: ptr KeyFile00; groupName: cstring;
    key: cstring; locale: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getLocaleString*(self: KeyFile; groupName: cstring; key: cstring;
    locale: cstring = nil): string =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_locale_string(cast[ptr KeyFile00](self.impl), groupName, key, locale, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_locale_string_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; locale: cstring; length: var uint64; error: ptr ptr glib.Error = nil): ptr cstring {.
    importc, libprag.}

proc getLocaleStringList*(self: KeyFile; groupName: cstring;
    key: cstring; locale: cstring = nil; length: var uint64 = cast[var uint64](nil)): seq[string] =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_locale_string_list(cast[ptr KeyFile00](self.impl), groupName, key, locale, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = cstringArrayToSeq(resul0)

proc g_key_file_get_start_group(self: ptr KeyFile00): cstring {.
    importc, libprag.}

proc getStartGroup*(self: KeyFile): string =
  let resul0 = g_key_file_get_start_group(cast[ptr KeyFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc startGroup*(self: KeyFile): string =
  let resul0 = g_key_file_get_start_group(cast[ptr KeyFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_string(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getString*(self: KeyFile; groupName: cstring; key: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_string(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_string_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; length: var uint64; error: ptr ptr glib.Error = nil): ptr cstring {.
    importc, libprag.}

proc getStringList*(self: KeyFile; groupName: cstring; key: cstring;
    length: var uint64 = cast[var uint64](nil)): seq[string] =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_string_list(cast[ptr KeyFile00](self.impl), groupName, key, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = cstringArrayToSeq(resul0)

proc g_key_file_get_uint64(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): uint64 {.
    importc, libprag.}

proc getUint64*(self: KeyFile; groupName: cstring; key: cstring): uint64 =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_uint64(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc g_key_file_get_value(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getValue*(self: KeyFile; groupName: cstring; key: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_get_value(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_key_file_has_group(self: ptr KeyFile00; groupName: cstring): gboolean {.
    importc, libprag.}

proc hasGroup*(self: KeyFile; groupName: cstring): bool =
  toBool(g_key_file_has_group(cast[ptr KeyFile00](self.impl), groupName))

proc g_key_file_remove_comment(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeComment*(self: KeyFile; groupName: cstring = nil; key: cstring = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_remove_comment(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_remove_group(self: ptr KeyFile00; groupName: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeGroup*(self: KeyFile; groupName: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_remove_group(cast[ptr KeyFile00](self.impl), groupName, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_remove_key(self: ptr KeyFile00; groupName: cstring; key: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeKey*(self: KeyFile; groupName: cstring; key: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_remove_key(cast[ptr KeyFile00](self.impl), groupName, key, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_save_to_file(self: ptr KeyFile00; filename: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToFile*(self: KeyFile; filename: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_save_to_file(cast[ptr KeyFile00](self.impl), filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_set_boolean(self: ptr KeyFile00; groupName: cstring; key: cstring;
    value: gboolean) {.
    importc, libprag.}

proc setBoolean*(self: KeyFile; groupName: cstring; key: cstring;
    value: bool) =
  g_key_file_set_boolean(cast[ptr KeyFile00](self.impl), groupName, key, gboolean(value))

proc g_key_file_set_boolean_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; list: ptr gboolean; length: uint64) {.
    importc, libprag.}

proc setBooleanList*(self: KeyFile; groupName: cstring; key: cstring;
    list: ptr gboolean; length: uint64) =
  g_key_file_set_boolean_list(cast[ptr KeyFile00](self.impl), groupName, key, list, length)

proc g_key_file_set_comment(self: ptr KeyFile00; groupName: cstring; key: cstring;
    comment: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setComment*(self: KeyFile; groupName: cstring = nil; key: cstring = nil;
    comment: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_set_comment(cast[ptr KeyFile00](self.impl), groupName, key, comment, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_set_double(self: ptr KeyFile00; groupName: cstring; key: cstring;
    value: cdouble) {.
    importc, libprag.}

proc setDouble*(self: KeyFile; groupName: cstring; key: cstring;
    value: cdouble) =
  g_key_file_set_double(cast[ptr KeyFile00](self.impl), groupName, key, value)

proc g_key_file_set_double_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; list: ptr cdouble; length: uint64) {.
    importc, libprag.}

proc setDoubleList*(self: KeyFile; groupName: cstring; key: cstring;
    list: ptr cdouble; length: uint64) =
  g_key_file_set_double_list(cast[ptr KeyFile00](self.impl), groupName, key, list, length)

proc g_key_file_set_int64(self: ptr KeyFile00; groupName: cstring; key: cstring;
    value: int64) {.
    importc, libprag.}

proc setInt64*(self: KeyFile; groupName: cstring; key: cstring;
    value: int64) =
  g_key_file_set_int64(cast[ptr KeyFile00](self.impl), groupName, key, value)

proc g_key_file_set_integer(self: ptr KeyFile00; groupName: cstring; key: cstring;
    value: int32) {.
    importc, libprag.}

proc setInteger*(self: KeyFile; groupName: cstring; key: cstring;
    value: int) =
  g_key_file_set_integer(cast[ptr KeyFile00](self.impl), groupName, key, int32(value))

proc g_key_file_set_integer_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; list: ptr int32; length: uint64) {.
    importc, libprag.}

proc setIntegerList*(self: KeyFile; groupName: cstring; key: cstring;
    list: seq[int32]) =
  let length = uint64(list.len)
  g_key_file_set_integer_list(cast[ptr KeyFile00](self.impl), groupName, key, cast[ptr int32](unsafeaddr(list[0])), length)

proc g_key_file_set_list_separator(self: ptr KeyFile00; separator: int8) {.
    importc, libprag.}

proc setListSeparator*(self: KeyFile; separator: int8) =
  g_key_file_set_list_separator(cast[ptr KeyFile00](self.impl), separator)

proc `listSeparator=`*(self: KeyFile; separator: int8) =
  g_key_file_set_list_separator(cast[ptr KeyFile00](self.impl), separator)

proc g_key_file_set_locale_string(self: ptr KeyFile00; groupName: cstring;
    key: cstring; locale: cstring; string: cstring) {.
    importc, libprag.}

proc setLocaleString*(self: KeyFile; groupName: cstring; key: cstring;
    locale: cstring; string: cstring) =
  g_key_file_set_locale_string(cast[ptr KeyFile00](self.impl), groupName, key, locale, string)

proc g_key_file_set_locale_string_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; locale: cstring; list: ptr cstring; length: uint64) {.
    importc, libprag.}

proc setLocaleStringList*(self: KeyFile; groupName: cstring;
    key: cstring; locale: cstring; list: openArray[string]; length: uint64) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  g_key_file_set_locale_string_list(cast[ptr KeyFile00](self.impl), groupName, key, locale, seq2CstringArray(list, fs469n23), length)

proc g_key_file_set_string(self: ptr KeyFile00; groupName: cstring; key: cstring;
    string: cstring) {.
    importc, libprag.}

proc setString*(self: KeyFile; groupName: cstring; key: cstring;
    string: cstring) =
  g_key_file_set_string(cast[ptr KeyFile00](self.impl), groupName, key, string)

proc g_key_file_set_string_list(self: ptr KeyFile00; groupName: cstring;
    key: cstring; list: ptr cstring; length: uint64) {.
    importc, libprag.}

proc setStringList*(self: KeyFile; groupName: cstring; key: cstring;
    list: openArray[string]; length: uint64) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  g_key_file_set_string_list(cast[ptr KeyFile00](self.impl), groupName, key, seq2CstringArray(list, fs469n23), length)

proc g_key_file_set_uint64(self: ptr KeyFile00; groupName: cstring; key: cstring;
    value: uint64) {.
    importc, libprag.}

proc setUint64*(self: KeyFile; groupName: cstring; key: cstring;
    value: uint64) =
  g_key_file_set_uint64(cast[ptr KeyFile00](self.impl), groupName, key, value)

proc g_key_file_set_value(self: ptr KeyFile00; groupName: cstring; key: cstring;
    value: cstring) {.
    importc, libprag.}

proc setValue*(self: KeyFile; groupName: cstring; key: cstring;
    value: cstring) =
  g_key_file_set_value(cast[ptr KeyFile00](self.impl), groupName, key, value)

proc g_key_file_to_data(self: ptr KeyFile00; length: var uint64; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc toData*(self: KeyFile; length: var uint64 = cast[var uint64](nil)): string =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_to_data(cast[ptr KeyFile00](self.impl), length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_key_file_new(): ptr KeyFile00 {.
    importc, libprag.}

proc newKeyFile*(): KeyFile =
  fnew(result, gBoxedFreeGKeyFile)
  result.impl = g_key_file_new()

proc newKeyFile*(tdesc: typedesc): tdesc =
  assert(result is KeyFile)
  fnew(result, gBoxedFreeGKeyFile)
  result.impl = g_key_file_new()

proc initKeyFile*[T](result: var T) {.deprecated.} =
  assert(result is KeyFile)
  fnew(result, gBoxedFreeGKeyFile)
  result.impl = g_key_file_new()

type
  KeyFileFlag* {.size: sizeof(cint), pure.} = enum
    keepComments = 0
    keepTranslations = 1

  KeyFileFlags* {.size: sizeof(cint).} = set[KeyFileFlag]

const
  KeyFileFlagsNone* = KeyFileFlags({})
proc none*(t: typedesc[KeyFileFlags]): KeyFileFlags = KeyFileFlags({})

proc g_key_file_load_from_bytes(self: ptr KeyFile00; bytes: ptr Bytes00;
    flags: KeyFileFlags; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromBytes*(self: KeyFile; bytes: Bytes; flags: KeyFileFlags): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_load_from_bytes(cast[ptr KeyFile00](self.impl), cast[ptr Bytes00](bytes.impl), flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_load_from_data(self: ptr KeyFile00; data: cstring; length: uint64;
    flags: KeyFileFlags; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromData*(self: KeyFile; data: cstring; length: uint64;
    flags: KeyFileFlags): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_load_from_data(cast[ptr KeyFile00](self.impl), data, length, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_key_file_load_from_data_dirs(self: ptr KeyFile00; file: cstring; fullPath: var cstring;
    flags: KeyFileFlags; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromDataDirs*(self: KeyFile; file: cstring; fullPath: var string = cast[var string](nil);
    flags: KeyFileFlags): bool =
  var gerror: ptr glib.Error
  var fullPath_00: cstring
  let resul0 = g_key_file_load_from_data_dirs(cast[ptr KeyFile00](self.impl), file, fullPath_00, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if fullPath.addr != nil:
    fullPath = $(fullPath_00)

proc g_key_file_load_from_dirs(self: ptr KeyFile00; file: cstring; searchDirs: ptr cstring;
    fullPath: var cstring; flags: KeyFileFlags; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromDirs*(self: KeyFile; file: cstring; searchDirs: openArray[string];
    fullPath: var string = cast[var string](nil); flags: KeyFileFlags): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  var fullPath_00: cstring
  let resul0 = g_key_file_load_from_dirs(cast[ptr KeyFile00](self.impl), file, seq2CstringArray(searchDirs, fs469n23), fullPath_00, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if fullPath.addr != nil:
    fullPath = $(fullPath_00)

proc g_key_file_load_from_file(self: ptr KeyFile00; file: cstring; flags: KeyFileFlags;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFromFile*(self: KeyFile; file: cstring; flags: KeyFileFlags): bool =
  var gerror: ptr glib.Error
  let resul0 = g_key_file_load_from_file(cast[ptr KeyFile00](self.impl), file, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  KeyFileError* {.size: sizeof(cint), pure.} = enum
    unknownEncoding = 0
    parse = 1
    notFound = 2
    keyNotFound = 3
    groupNotFound = 4
    invalidValue = 5

const LITTLE_ENDIAN* = 1234'i32

const LN10* = 2.302585'f64

const LN2* = 0.693147'f64

const LOG_2_BASE_10* = 0.30103'f64

const LOG_DOMAIN* = 0'i8

const LOG_FATAL_MASK* = 5'i32

const LOG_LEVEL_USER_SHIFT* = 8'i32

type
  List* {.pure, byRef.} = object
    data*: pointer
    next*: ptr glib.List
    prev*: ptr glib.List

proc g_list_free*(list: ptr glib.List) {.importc: "g_list_free", libprag.}

proc g_list_prepend*(list: ptr glib.List; data: pointer): ptr glib.List  {.importc:  "g_list_prepend", libprag.}

type
  LogField* {.pure, byRef.} = object
    key*: cstring
    value*: pointer
    length*: int64

type
  LogLevelFlags* {.size: sizeof(cint), pure.} = enum
    levelMask = -4
    flagRecursion = 1
    flagFatal = 2
    levelError = 4
    levelCritical = 8
    levelWarning = 16
    levelMessage = 32
    levelInfo = 64
    levelDebug = 128

type
  LogFunc* = proc (logDomain: cstring; logLevel: LogLevelFlags; message: cstring; userData: pointer) {.cdecl.}

type
  LogWriterOutput* {.size: sizeof(cint), pure.} = enum
    unhandled = 0
    handled = 1

type
  LogWriterFunc* = proc (logLevel: LogLevelFlags; fields: ptr LogField; nFields: uint64; userData: pointer): LogWriterOutput {.cdecl.}

const MAJOR_VERSION* = 2'i32

const MAXINT16* = 32767'i16

const MAXINT32* = 2147483647'i32

const MAXINT64* = 9223372036854775807'i64

const MAXINT8* = 127'i8

const MAXUINT16* = 65535'u16

const MAXUINT32* = 4294967295'u32

const MAXUINT64* = 18446744073709551615'u64

const MAXUINT8* = 255'u8

const MICRO_VERSION* = 2'i32

const MINOR_VERSION* = 66'i32

const MODULE_SUFFIX* = "so"

type
  MainContext00* {.pure.} = object
  MainContext* = ref object
    impl*: ptr MainContext00
    ignoreFinalizer*: bool

proc g_main_context_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGMainContext*(self: MainContext) =
  if not self.ignoreFinalizer:
    boxedFree(g_main_context_get_type(), cast[ptr MainContext00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MainContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_main_context_get_type(), cast[ptr MainContext00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MainContext) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGMainContext)

proc g_main_context_unref(self: ptr MainContext00) {.
    importc, libprag.}

proc unref*(self: MainContext) =
  g_main_context_unref(cast[ptr MainContext00](self.impl))

proc finalizerunref*(self: MainContext) =
  if not self.ignoreFinalizer:
    g_main_context_unref(cast[ptr MainContext00](self.impl))

proc g_main_context_acquire(self: ptr MainContext00): gboolean {.
    importc, libprag.}

proc acquire*(self: MainContext): bool =
  toBool(g_main_context_acquire(cast[ptr MainContext00](self.impl)))

proc g_main_context_dispatch(self: ptr MainContext00) {.
    importc, libprag.}

proc dispatch*(self: MainContext) =
  g_main_context_dispatch(cast[ptr MainContext00](self.impl))

proc g_main_context_is_owner(self: ptr MainContext00): gboolean {.
    importc, libprag.}

proc isOwner*(self: MainContext): bool =
  toBool(g_main_context_is_owner(cast[ptr MainContext00](self.impl)))

proc g_main_context_iteration(self: ptr MainContext00; mayBlock: gboolean): gboolean {.
    importc, libprag.}

proc iteration*(self: MainContext; mayBlock: bool): bool =
  toBool(g_main_context_iteration(cast[ptr MainContext00](self.impl), gboolean(mayBlock)))

proc g_main_context_pending(self: ptr MainContext00): gboolean {.
    importc, libprag.}

proc pending*(self: MainContext): bool =
  toBool(g_main_context_pending(cast[ptr MainContext00](self.impl)))

proc g_main_context_pop_thread_default(self: ptr MainContext00) {.
    importc, libprag.}

proc popThreadDefault*(self: MainContext) =
  g_main_context_pop_thread_default(cast[ptr MainContext00](self.impl))

proc g_main_context_prepare(self: ptr MainContext00; priority: var int32): gboolean {.
    importc, libprag.}

proc prepare*(self: MainContext; priority: var int = cast[var int](nil)): bool =
  var priority_00: int32
  result = toBool(g_main_context_prepare(cast[ptr MainContext00](self.impl), priority_00))
  if priority.addr != nil:
    priority = int(priority_00)

proc g_main_context_push_thread_default(self: ptr MainContext00) {.
    importc, libprag.}

proc pushThreadDefault*(self: MainContext) =
  g_main_context_push_thread_default(cast[ptr MainContext00](self.impl))

proc g_main_context_ref(self: ptr MainContext00): ptr MainContext00 {.
    importc, libprag.}

proc `ref`*(self: MainContext): MainContext =
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_context_ref(cast[ptr MainContext00](self.impl))

proc g_main_context_release(self: ptr MainContext00) {.
    importc, libprag.}

proc release*(self: MainContext) =
  g_main_context_release(cast[ptr MainContext00](self.impl))

proc g_main_context_new(): ptr MainContext00 {.
    importc, libprag.}

proc newMainContext*(): MainContext =
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_context_new()

proc newMainContext*(tdesc: typedesc): tdesc =
  assert(result is MainContext)
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_context_new()

proc initMainContext*[T](result: var T) {.deprecated.} =
  assert(result is MainContext)
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_context_new()

proc g_main_context_wakeup(self: ptr MainContext00) {.
    importc, libprag.}

proc wakeup*(self: MainContext) =
  g_main_context_wakeup(cast[ptr MainContext00](self.impl))

proc g_main_context_default(): ptr MainContext00 {.
    importc, libprag.}

proc defaultMainContext*(): MainContext =
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_context_default()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), result.impl))

proc g_main_context_get_thread_default(): ptr MainContext00 {.
    importc, libprag.}

proc getThreadDefault*(): MainContext =
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_context_get_thread_default()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), result.impl))

proc g_main_context_ref_thread_default(): ptr MainContext00 {.
    importc, libprag.}

proc refThreadDefault*(): MainContext =
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_context_ref_thread_default()

type
  SourceFuncs00* {.pure.} = object
  SourceFuncs* = ref object
    impl*: ptr SourceFuncs00
    ignoreFinalizer*: bool

type
  Source00* {.pure.} = object
  Source* = ref object
    impl*: ptr Source00
    ignoreFinalizer*: bool

proc g_source_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGSource*(self: Source) =
  if not self.ignoreFinalizer:
    boxedFree(g_source_get_type(), cast[ptr Source00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Source()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_source_get_type(), cast[ptr Source00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Source) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGSource)

proc g_source_unref(self: ptr Source00) {.
    importc, libprag.}

proc unref*(self: Source) =
  g_source_unref(cast[ptr Source00](self.impl))

proc finalizerunref*(self: Source) =
  if not self.ignoreFinalizer:
    g_source_unref(cast[ptr Source00](self.impl))

proc g_source_add_child_source(self: ptr Source00; childSource: ptr Source00) {.
    importc, libprag.}

proc addChildSource*(self: Source; childSource: Source) =
  g_source_add_child_source(cast[ptr Source00](self.impl), cast[ptr Source00](childSource.impl))

proc g_source_add_unix_fd(self: ptr Source00; fd: int32; events: IOCondition): pointer {.
    importc, libprag.}

proc addUnixFd*(self: Source; fd: int; events: IOCondition): pointer =
  g_source_add_unix_fd(cast[ptr Source00](self.impl), int32(fd), events)

proc g_source_attach(self: ptr Source00; context: ptr MainContext00): uint32 {.
    importc, libprag.}

proc attach*(self: Source; context: MainContext = nil): int =
  int(g_source_attach(cast[ptr Source00](self.impl), if context.isNil: nil else: cast[ptr MainContext00](context.impl)))

proc g_source_destroy(self: ptr Source00) {.
    importc, libprag.}

proc destroy*(self: Source) =
  g_source_destroy(cast[ptr Source00](self.impl))

proc finalizerdestroy*(self: Source) =
  if not self.ignoreFinalizer:
    g_source_destroy(cast[ptr Source00](self.impl))

proc g_source_get_can_recurse(self: ptr Source00): gboolean {.
    importc, libprag.}

proc getCanRecurse*(self: Source): bool =
  toBool(g_source_get_can_recurse(cast[ptr Source00](self.impl)))

proc canRecurse*(self: Source): bool =
  toBool(g_source_get_can_recurse(cast[ptr Source00](self.impl)))

proc g_source_get_context(self: ptr Source00): ptr MainContext00 {.
    importc, libprag.}

proc getContext*(self: Source): MainContext =
  let impl0 = g_source_get_context(cast[ptr Source00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGMainContext)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), impl0))

proc context*(self: Source): MainContext =
  let impl0 = g_source_get_context(cast[ptr Source00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGMainContext)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), impl0))

proc g_source_get_current_time(self: ptr Source00; timeval: TimeVal) {.
    importc, libprag.}

proc getCurrentTime*(self: Source; timeval: TimeVal) =
  g_source_get_current_time(cast[ptr Source00](self.impl), timeval)

proc g_source_get_id(self: ptr Source00): uint32 {.
    importc, libprag.}

proc getId*(self: Source): int =
  int(g_source_get_id(cast[ptr Source00](self.impl)))

proc id*(self: Source): int =
  int(g_source_get_id(cast[ptr Source00](self.impl)))

proc g_source_get_name(self: ptr Source00): cstring {.
    importc, libprag.}

proc getName*(self: Source): string =
  result = $g_source_get_name(cast[ptr Source00](self.impl))

proc name*(self: Source): string =
  result = $g_source_get_name(cast[ptr Source00](self.impl))

proc g_source_get_priority(self: ptr Source00): int32 {.
    importc, libprag.}

proc getPriority*(self: Source): int =
  int(g_source_get_priority(cast[ptr Source00](self.impl)))

proc priority*(self: Source): int =
  int(g_source_get_priority(cast[ptr Source00](self.impl)))

proc g_source_get_ready_time(self: ptr Source00): int64 {.
    importc, libprag.}

proc getReadyTime*(self: Source): int64 =
  g_source_get_ready_time(cast[ptr Source00](self.impl))

proc readyTime*(self: Source): int64 =
  g_source_get_ready_time(cast[ptr Source00](self.impl))

proc g_source_get_time(self: ptr Source00): int64 {.
    importc, libprag.}

proc getTime*(self: Source): int64 =
  g_source_get_time(cast[ptr Source00](self.impl))

proc time*(self: Source): int64 =
  g_source_get_time(cast[ptr Source00](self.impl))

proc g_source_is_destroyed(self: ptr Source00): gboolean {.
    importc, libprag.}

proc isDestroyed*(self: Source): bool =
  toBool(g_source_is_destroyed(cast[ptr Source00](self.impl)))

proc g_source_modify_unix_fd(self: ptr Source00; tag: pointer; newEvents: IOCondition) {.
    importc, libprag.}

proc modifyUnixFd*(self: Source; tag: pointer; newEvents: IOCondition) =
  g_source_modify_unix_fd(cast[ptr Source00](self.impl), tag, newEvents)

proc g_source_query_unix_fd(self: ptr Source00; tag: pointer): IOCondition {.
    importc, libprag.}

proc queryUnixFd*(self: Source; tag: pointer): IOCondition =
  g_source_query_unix_fd(cast[ptr Source00](self.impl), tag)

proc g_source_ref(self: ptr Source00): ptr Source00 {.
    importc, libprag.}

proc `ref`*(self: Source): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_source_ref(cast[ptr Source00](self.impl))

proc g_source_remove_child_source(self: ptr Source00; childSource: ptr Source00) {.
    importc, libprag.}

proc removeChildSource*(self: Source; childSource: Source) =
  g_source_remove_child_source(cast[ptr Source00](self.impl), cast[ptr Source00](childSource.impl))

proc g_source_remove_unix_fd(self: ptr Source00; tag: pointer) {.
    importc, libprag.}

proc removeUnixFd*(self: Source; tag: pointer) =
  g_source_remove_unix_fd(cast[ptr Source00](self.impl), tag)

proc g_source_set_can_recurse(self: ptr Source00; canRecurse: gboolean) {.
    importc, libprag.}

proc setCanRecurse*(self: Source; canRecurse: bool = true) =
  g_source_set_can_recurse(cast[ptr Source00](self.impl), gboolean(canRecurse))

proc `canRecurse=`*(self: Source; canRecurse: bool) =
  g_source_set_can_recurse(cast[ptr Source00](self.impl), gboolean(canRecurse))

proc g_source_set_funcs(self: ptr Source00; funcs: ptr SourceFuncs00) {.
    importc, libprag.}

proc setFuncs*(self: Source; funcs: SourceFuncs) =
  g_source_set_funcs(cast[ptr Source00](self.impl), cast[ptr SourceFuncs00](funcs.impl))

proc `funcs=`*(self: Source; funcs: SourceFuncs) =
  g_source_set_funcs(cast[ptr Source00](self.impl), cast[ptr SourceFuncs00](funcs.impl))

proc g_source_set_name(self: ptr Source00; name: cstring) {.
    importc, libprag.}

proc setName*(self: Source; name: cstring) =
  g_source_set_name(cast[ptr Source00](self.impl), name)

proc `name=`*(self: Source; name: cstring) =
  g_source_set_name(cast[ptr Source00](self.impl), name)

proc g_source_set_priority(self: ptr Source00; priority: int32) {.
    importc, libprag.}

proc setPriority*(self: Source; priority: int) =
  g_source_set_priority(cast[ptr Source00](self.impl), int32(priority))

proc `priority=`*(self: Source; priority: int) =
  g_source_set_priority(cast[ptr Source00](self.impl), int32(priority))

proc g_source_set_ready_time(self: ptr Source00; readyTime: int64) {.
    importc, libprag.}

proc setReadyTime*(self: Source; readyTime: int64) =
  g_source_set_ready_time(cast[ptr Source00](self.impl), readyTime)

proc `readyTime=`*(self: Source; readyTime: int64) =
  g_source_set_ready_time(cast[ptr Source00](self.impl), readyTime)

proc g_source_new(sourceFuncs: ptr SourceFuncs00; structSize: uint32): ptr Source00 {.
    importc, libprag.}

proc newSource*(sourceFuncs: SourceFuncs; structSize: int): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_source_new(cast[ptr SourceFuncs00](sourceFuncs.impl), uint32(structSize))

proc newSource*(tdesc: typedesc; sourceFuncs: SourceFuncs; structSize: int): tdesc =
  assert(result is Source)
  fnew(result, gBoxedFreeGSource)
  result.impl = g_source_new(cast[ptr SourceFuncs00](sourceFuncs.impl), uint32(structSize))

proc initSource*[T](result: var T; sourceFuncs: SourceFuncs; structSize: int) {.deprecated.} =
  assert(result is Source)
  fnew(result, gBoxedFreeGSource)
  result.impl = g_source_new(cast[ptr SourceFuncs00](sourceFuncs.impl), uint32(structSize))

proc g_source_remove(tag: uint32): gboolean {.
    importc, libprag.}

proc remove*(tag: int): bool =
  toBool(g_source_remove(uint32(tag)))

proc g_source_remove_by_funcs_user_data(funcs: ptr SourceFuncs00; userData: pointer): gboolean {.
    importc, libprag.}

proc removeByFuncsUserData*(funcs: SourceFuncs; userData: pointer): bool =
  toBool(g_source_remove_by_funcs_user_data(cast[ptr SourceFuncs00](funcs.impl), userData))

proc g_source_remove_by_user_data(userData: pointer): gboolean {.
    importc, libprag.}

proc removeByUserData*(userData: pointer): bool =
  toBool(g_source_remove_by_user_data(userData))

proc g_source_set_name_by_id(tag: uint32; name: cstring) {.
    importc, libprag.}

proc setNameById*(tag: int; name: cstring) =
  g_source_set_name_by_id(uint32(tag), name)

proc `nameById=`*(tag: uint32; name: cstring) {.
    importc: "g_source_set_name_by_id", libprag.}

proc g_main_context_find_source_by_funcs_user_data(self: ptr MainContext00;
    funcs: ptr SourceFuncs00; userData: pointer): ptr Source00 {.
    importc, libprag.}

proc findSourceByFuncsUserData*(self: MainContext; funcs: SourceFuncs;
    userData: pointer): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_main_context_find_source_by_funcs_user_data(cast[ptr MainContext00](self.impl), cast[ptr SourceFuncs00](funcs.impl), userData)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_source_get_type(), result.impl))

proc g_main_context_find_source_by_id(self: ptr MainContext00; sourceId: uint32): ptr Source00 {.
    importc, libprag.}

proc findSourceById*(self: MainContext; sourceId: int): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_main_context_find_source_by_id(cast[ptr MainContext00](self.impl), uint32(sourceId))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_source_get_type(), result.impl))

proc g_main_context_find_source_by_user_data(self: ptr MainContext00; userData: pointer): ptr Source00 {.
    importc, libprag.}

proc findSourceByUserData*(self: MainContext; userData: pointer): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_main_context_find_source_by_user_data(cast[ptr MainContext00](self.impl), userData)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_source_get_type(), result.impl))

type
  SourceCallbackFuncs00* {.pure.} = object
  SourceCallbackFuncs* = ref object
    impl*: ptr SourceCallbackFuncs00
    ignoreFinalizer*: bool

proc g_source_set_callback_indirect(self: ptr Source00; callbackData: pointer;
    callbackFuncs: ptr SourceCallbackFuncs00) {.
    importc, libprag.}

proc setCallbackIndirect*(self: Source; callbackData: pointer;
    callbackFuncs: SourceCallbackFuncs) =
  g_source_set_callback_indirect(cast[ptr Source00](self.impl), callbackData, cast[ptr SourceCallbackFuncs00](callbackFuncs.impl))

type
  PollFD* {.pure, byRef.} = object
    fd*: int32
    events*: uint16
    revents*: uint16

proc g_pollfd_get_type*(): GType {.importc, gobjectlibprag.}

proc g_main_context_add_poll(self: ptr MainContext00; fd: PollFD; priority: int32) {.
    importc, libprag.}

proc addPoll*(self: MainContext; fd: PollFD; priority: int) =
  g_main_context_add_poll(cast[ptr MainContext00](self.impl), fd, int32(priority))

proc g_main_context_check(self: ptr MainContext00; maxPriority: int32; fds: ptr PollFD;
    nFds: int32): gboolean {.
    importc, libprag.}

proc check*(self: MainContext; maxPriority: int; fds: ptr PollFD;
    nFds: int): bool =
  toBool(g_main_context_check(cast[ptr MainContext00](self.impl), int32(maxPriority), fds, int32(nFds)))

proc g_main_context_query(self: ptr MainContext00; maxPriority: int32; timeout: var int32;
    fds: var ptr PollFD; nFds: int32): int32 {.
    importc, libprag.}

proc query*(self: MainContext; maxPriority: int; timeout: var int;
    fds: var ptr PollFD; nFds: int): int =
  var timeout_00: int32
  result = int(g_main_context_query(cast[ptr MainContext00](self.impl), int32(maxPriority), timeout_00, fds, int32(nFds)))
  if timeout.addr != nil:
    timeout = int(timeout_00)

proc g_main_context_remove_poll(self: ptr MainContext00; fd: PollFD) {.
    importc, libprag.}

proc removePoll*(self: MainContext; fd: PollFD) =
  g_main_context_remove_poll(cast[ptr MainContext00](self.impl), fd)

proc g_source_add_poll(self: ptr Source00; fd: PollFD) {.
    importc, libprag.}

proc addPoll*(self: Source; fd: PollFD) =
  g_source_add_poll(cast[ptr Source00](self.impl), fd)

proc g_source_remove_poll(self: ptr Source00; fd: PollFD) {.
    importc, libprag.}

proc removePoll*(self: Source; fd: PollFD) =
  g_source_remove_poll(cast[ptr Source00](self.impl), fd)

type
  MainLoop00* {.pure.} = object
  MainLoop* = ref object
    impl*: ptr MainLoop00
    ignoreFinalizer*: bool

proc g_main_loop_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGMainLoop*(self: MainLoop) =
  if not self.ignoreFinalizer:
    boxedFree(g_main_loop_get_type(), cast[ptr MainLoop00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MainLoop()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_main_loop_get_type(), cast[ptr MainLoop00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MainLoop) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGMainLoop)

proc g_main_loop_unref(self: ptr MainLoop00) {.
    importc, libprag.}

proc unref*(self: MainLoop) =
  g_main_loop_unref(cast[ptr MainLoop00](self.impl))

proc finalizerunref*(self: MainLoop) =
  if not self.ignoreFinalizer:
    g_main_loop_unref(cast[ptr MainLoop00](self.impl))

proc g_main_loop_get_context(self: ptr MainLoop00): ptr MainContext00 {.
    importc, libprag.}

proc getContext*(self: MainLoop): MainContext =
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_loop_get_context(cast[ptr MainLoop00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), result.impl))

proc context*(self: MainLoop): MainContext =
  fnew(result, gBoxedFreeGMainContext)
  result.impl = g_main_loop_get_context(cast[ptr MainLoop00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_main_context_get_type(), result.impl))

proc g_main_loop_is_running(self: ptr MainLoop00): gboolean {.
    importc, libprag.}

proc isRunning*(self: MainLoop): bool =
  toBool(g_main_loop_is_running(cast[ptr MainLoop00](self.impl)))

proc g_main_loop_quit(self: ptr MainLoop00) {.
    importc, libprag.}

proc quit*(self: MainLoop) =
  g_main_loop_quit(cast[ptr MainLoop00](self.impl))

proc g_main_loop_ref(self: ptr MainLoop00): ptr MainLoop00 {.
    importc, libprag.}

proc `ref`*(self: MainLoop): MainLoop =
  fnew(result, gBoxedFreeGMainLoop)
  result.impl = g_main_loop_ref(cast[ptr MainLoop00](self.impl))

proc g_main_loop_run(self: ptr MainLoop00) {.
    importc, libprag.}

proc run*(self: MainLoop) =
  g_main_loop_run(cast[ptr MainLoop00](self.impl))

proc g_main_loop_new(context: ptr MainContext00; isRunning: gboolean): ptr MainLoop00 {.
    importc, libprag.}

proc newMainLoop*(context: MainContext = nil; isRunning: bool): MainLoop =
  fnew(result, gBoxedFreeGMainLoop)
  result.impl = g_main_loop_new(if context.isNil: nil else: cast[ptr MainContext00](context.impl), gboolean(isRunning))

proc newMainLoop*(tdesc: typedesc; context: MainContext = nil; isRunning: bool): tdesc =
  assert(result is MainLoop)
  fnew(result, gBoxedFreeGMainLoop)
  result.impl = g_main_loop_new(if context.isNil: nil else: cast[ptr MainContext00](context.impl), gboolean(isRunning))

proc initMainLoop*[T](result: var T; context: MainContext = nil; isRunning: bool) {.deprecated.} =
  assert(result is MainLoop)
  fnew(result, gBoxedFreeGMainLoop)
  result.impl = g_main_loop_new(if context.isNil: nil else: cast[ptr MainContext00](context.impl), gboolean(isRunning))

type
  MappedFile00* {.pure.} = object
  MappedFile* = ref object
    impl*: ptr MappedFile00
    ignoreFinalizer*: bool

proc g_mapped_file_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGMappedFile*(self: MappedFile) =
  if not self.ignoreFinalizer:
    boxedFree(g_mapped_file_get_type(), cast[ptr MappedFile00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MappedFile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_mapped_file_get_type(), cast[ptr MappedFile00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MappedFile) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGMappedFile)

proc g_mapped_file_free(self: ptr MappedFile00) {.
    importc, libprag.}

proc free*(self: MappedFile) =
  g_mapped_file_free(cast[ptr MappedFile00](self.impl))

proc finalizerfree*(self: MappedFile) =
  if not self.ignoreFinalizer:
    g_mapped_file_free(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_new_from_fd(fd: int32; writable: gboolean; error: ptr ptr glib.Error = nil): ptr MappedFile00 {.
    importc, libprag.}

proc newMappedFileFromFd*(fd: int; writable: bool): MappedFile =
  var gerror: ptr glib.Error
  let impl0 = g_mapped_file_new_from_fd(int32(fd), gboolean(writable), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGMappedFile)
  result.impl = impl0

proc newMappedFileFromFd*(tdesc: typedesc; fd: int; writable: bool): tdesc =
  var gerror: ptr glib.Error
  assert(result is MappedFile)
  let impl0 = g_mapped_file_new_from_fd(int32(fd), gboolean(writable), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGMappedFile)
  result.impl = impl0

proc initMappedFileFromFd*[T](result: var T; fd: int; writable: bool) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is MappedFile)
  let impl0 = g_mapped_file_new_from_fd(int32(fd), gboolean(writable), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGMappedFile)
  result.impl = impl0

proc g_mapped_file_new(filename: cstring; writable: gboolean; error: ptr ptr glib.Error = nil): ptr MappedFile00 {.
    importc, libprag.}

proc newMappedFile*(filename: cstring; writable: bool): MappedFile =
  var gerror: ptr glib.Error
  let impl0 = g_mapped_file_new(filename, gboolean(writable), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGMappedFile)
  result.impl = impl0

proc newMappedFile*(tdesc: typedesc; filename: cstring; writable: bool): tdesc =
  var gerror: ptr glib.Error
  assert(result is MappedFile)
  let impl0 = g_mapped_file_new(filename, gboolean(writable), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGMappedFile)
  result.impl = impl0

proc initMappedFile*[T](result: var T; filename: cstring; writable: bool) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is MappedFile)
  let impl0 = g_mapped_file_new(filename, gboolean(writable), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGMappedFile)
  result.impl = impl0

proc g_mapped_file_get_bytes(self: ptr MappedFile00): ptr Bytes00 {.
    importc, libprag.}

proc getBytes*(self: MappedFile): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_mapped_file_get_bytes(cast[ptr MappedFile00](self.impl))

proc bytes*(self: MappedFile): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_mapped_file_get_bytes(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_get_contents(self: ptr MappedFile00): cstring {.
    importc, libprag.}

proc getContents*(self: MappedFile): string =
  let resul0 = g_mapped_file_get_contents(cast[ptr MappedFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc contents*(self: MappedFile): string =
  let resul0 = g_mapped_file_get_contents(cast[ptr MappedFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_mapped_file_get_length(self: ptr MappedFile00): uint64 {.
    importc, libprag.}

proc getLength*(self: MappedFile): uint64 =
  g_mapped_file_get_length(cast[ptr MappedFile00](self.impl))

proc length*(self: MappedFile): uint64 =
  g_mapped_file_get_length(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_ref(self: ptr MappedFile00): ptr MappedFile00 {.
    importc, libprag.}

proc `ref`*(self: MappedFile): MappedFile =
  fnew(result, gBoxedFreeGMappedFile)
  result.impl = g_mapped_file_ref(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_unref(self: ptr MappedFile00) {.
    importc, libprag.}

proc unref*(self: MappedFile) =
  g_mapped_file_unref(cast[ptr MappedFile00](self.impl))

proc finalizerunref*(self: MappedFile) =
  if not self.ignoreFinalizer:
    g_mapped_file_unref(cast[ptr MappedFile00](self.impl))

type
  MarkupCollectType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    string = 1
    strdup = 2
    boolean = 3
    tristate = 4
    optional = 65536

type
  MarkupError* {.size: sizeof(cint), pure.} = enum
    badUtf8 = 0
    empty = 1
    parse = 2
    unknownElement = 3
    unknownAttribute = 4
    invalidContent = 5
    missingAttribute = 6

type
  MarkupParseContext00* {.pure.} = object
  MarkupParseContext* = ref object
    impl*: ptr MarkupParseContext00
    ignoreFinalizer*: bool

proc g_markup_parse_context_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGMarkupParseContext*(self: MarkupParseContext) =
  if not self.ignoreFinalizer:
    boxedFree(g_markup_parse_context_get_type(), cast[ptr MarkupParseContext00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MarkupParseContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_markup_parse_context_get_type(), cast[ptr MarkupParseContext00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MarkupParseContext) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGMarkupParseContext)

proc g_markup_parse_context_free(self: ptr MarkupParseContext00) {.
    importc, libprag.}

proc free*(self: MarkupParseContext) =
  g_markup_parse_context_free(cast[ptr MarkupParseContext00](self.impl))

proc finalizerfree*(self: MarkupParseContext) =
  if not self.ignoreFinalizer:
    g_markup_parse_context_free(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_end_parse(self: ptr MarkupParseContext00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc endParse*(self: MarkupParseContext): bool =
  var gerror: ptr glib.Error
  let resul0 = g_markup_parse_context_end_parse(cast[ptr MarkupParseContext00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_markup_parse_context_get_element(self: ptr MarkupParseContext00): cstring {.
    importc, libprag.}

proc getElement*(self: MarkupParseContext): string =
  result = $g_markup_parse_context_get_element(cast[ptr MarkupParseContext00](self.impl))

proc element*(self: MarkupParseContext): string =
  result = $g_markup_parse_context_get_element(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_get_position(self: ptr MarkupParseContext00;
    lineNumber: var int32; charNumber: var int32) {.
    importc, libprag.}

proc getPosition*(self: MarkupParseContext; lineNumber: var int = cast[var int](nil);
    charNumber: var int = cast[var int](nil)) =
  var charNumber_00: int32
  var lineNumber_00: int32
  g_markup_parse_context_get_position(cast[ptr MarkupParseContext00](self.impl), lineNumber_00, charNumber_00)
  if charNumber.addr != nil:
    charNumber = int(charNumber_00)
  if lineNumber.addr != nil:
    lineNumber = int(lineNumber_00)

proc g_markup_parse_context_get_user_data(self: ptr MarkupParseContext00): pointer {.
    importc, libprag.}

proc getUserData*(self: MarkupParseContext): pointer =
  g_markup_parse_context_get_user_data(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_parse(self: ptr MarkupParseContext00; text: cstring;
    textLen: int64; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc parse*(self: MarkupParseContext; text: cstring;
    textLen: int64): bool =
  var gerror: ptr glib.Error
  let resul0 = g_markup_parse_context_parse(cast[ptr MarkupParseContext00](self.impl), text, textLen, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_markup_parse_context_pop(self: ptr MarkupParseContext00): pointer {.
    importc, libprag.}

proc pop*(self: MarkupParseContext): pointer =
  g_markup_parse_context_pop(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_ref(self: ptr MarkupParseContext00): ptr MarkupParseContext00 {.
    importc, libprag.}

proc `ref`*(self: MarkupParseContext): MarkupParseContext =
  fnew(result, gBoxedFreeGMarkupParseContext)
  result.impl = g_markup_parse_context_ref(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_unref(self: ptr MarkupParseContext00) {.
    importc, libprag.}

proc unref*(self: MarkupParseContext) =
  g_markup_parse_context_unref(cast[ptr MarkupParseContext00](self.impl))

proc finalizerunref*(self: MarkupParseContext) =
  if not self.ignoreFinalizer:
    g_markup_parse_context_unref(cast[ptr MarkupParseContext00](self.impl))

type
  MarkupParser* {.pure, byRef.} = object
    startElement*: proc(context: ptr MarkupParseContext00; elementName: cstring; attributeNames: cstring;
    attributeValues: cstring; userData: pointer; error: ptr ptr glib.Error = nil) {.cdecl.}
    endElement*: proc(context: ptr MarkupParseContext00; elementName: cstring; userData: pointer;
    error: ptr ptr glib.Error = nil) {.cdecl.}
    text*: proc(context: ptr MarkupParseContext00; text: cstring; textLen: uint64;
    userData: pointer; error: ptr ptr glib.Error = nil) {.cdecl.}
    passthrough*: proc(context: ptr MarkupParseContext00; passthroughText: cstring; textLen: uint64;
    userData: pointer; error: ptr ptr glib.Error = nil) {.cdecl.}
    error*: proc(context: ptr MarkupParseContext00; error: ptr glib.Error; userData: pointer) {.cdecl.}

proc g_markup_parse_context_push(self: ptr MarkupParseContext00; parser: MarkupParser;
    userData: pointer) {.
    importc, libprag.}

proc push*(self: MarkupParseContext; parser: MarkupParser;
    userData: pointer) =
  g_markup_parse_context_push(cast[ptr MarkupParseContext00](self.impl), parser, userData)

type
  MarkupParseFlag* {.size: sizeof(cint), pure.} = enum
    doNotUseThisUnsupportedFlag = 0
    treatCdataAsText = 1
    prefixErrorPosition = 2
    ignoreQualified = 3

  MarkupParseFlags* {.size: sizeof(cint).} = set[MarkupParseFlag]

proc g_markup_parse_context_new(parser: MarkupParser; flags: MarkupParseFlags;
    userData: pointer; userDataDnotify: DestroyNotify): ptr MarkupParseContext00 {.
    importc, libprag.}

proc newMarkupParseContext*(parser: MarkupParser; flags: MarkupParseFlags;
    userData: pointer; userDataDnotify: DestroyNotify): MarkupParseContext =
  fnew(result, gBoxedFreeGMarkupParseContext)
  result.impl = g_markup_parse_context_new(parser, flags, userData, userDataDnotify)

proc newMarkupParseContext*(tdesc: typedesc; parser: MarkupParser; flags: MarkupParseFlags;
    userData: pointer; userDataDnotify: DestroyNotify): tdesc =
  assert(result is MarkupParseContext)
  fnew(result, gBoxedFreeGMarkupParseContext)
  result.impl = g_markup_parse_context_new(parser, flags, userData, userDataDnotify)

proc initMarkupParseContext*[T](result: var T; parser: MarkupParser; flags: MarkupParseFlags;
    userData: pointer; userDataDnotify: DestroyNotify) {.deprecated.} =
  assert(result is MarkupParseContext)
  fnew(result, gBoxedFreeGMarkupParseContext)
  result.impl = g_markup_parse_context_new(parser, flags, userData, userDataDnotify)

type
  MatchInfo00* {.pure.} = object
  MatchInfo* = ref object
    impl*: ptr MatchInfo00
    ignoreFinalizer*: bool

proc g_match_info_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGMatchInfo*(self: MatchInfo) =
  if not self.ignoreFinalizer:
    boxedFree(g_match_info_get_type(), cast[ptr MatchInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MatchInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_match_info_get_type(), cast[ptr MatchInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MatchInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGMatchInfo)

proc g_match_info_free(self: ptr MatchInfo00) {.
    importc, libprag.}

proc free*(self: MatchInfo) =
  g_match_info_free(cast[ptr MatchInfo00](self.impl))

proc finalizerfree*(self: MatchInfo) =
  if not self.ignoreFinalizer:
    g_match_info_free(cast[ptr MatchInfo00](self.impl))

proc g_match_info_fetch(self: ptr MatchInfo00; matchNum: int32): cstring {.
    importc, libprag.}

proc fetch*(self: MatchInfo; matchNum: int): string =
  let resul0 = g_match_info_fetch(cast[ptr MatchInfo00](self.impl), int32(matchNum))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_match_info_fetch_all(self: ptr MatchInfo00): ptr cstring {.
    importc, libprag.}

proc fetchAll*(self: MatchInfo): seq[string] =
  let resul0 = g_match_info_fetch_all(cast[ptr MatchInfo00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_match_info_fetch_named(self: ptr MatchInfo00; name: cstring): cstring {.
    importc, libprag.}

proc fetchNamed*(self: MatchInfo; name: cstring): string =
  let resul0 = g_match_info_fetch_named(cast[ptr MatchInfo00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_match_info_fetch_named_pos(self: ptr MatchInfo00; name: cstring; startPos: var int32;
    endPos: var int32): gboolean {.
    importc, libprag.}

proc fetchNamedPos*(self: MatchInfo; name: cstring; startPos: var int = cast[var int](nil);
    endPos: var int = cast[var int](nil)): bool =
  var endPos_00: int32
  var startPos_00: int32
  result = toBool(g_match_info_fetch_named_pos(cast[ptr MatchInfo00](self.impl), name, startPos_00, endPos_00))
  if endPos.addr != nil:
    endPos = int(endPos_00)
  if startPos.addr != nil:
    startPos = int(startPos_00)

proc g_match_info_fetch_pos(self: ptr MatchInfo00; matchNum: int32; startPos: var int32;
    endPos: var int32): gboolean {.
    importc, libprag.}

proc fetchPos*(self: MatchInfo; matchNum: int; startPos: var int = cast[var int](nil);
    endPos: var int = cast[var int](nil)): bool =
  var endPos_00: int32
  var startPos_00: int32
  result = toBool(g_match_info_fetch_pos(cast[ptr MatchInfo00](self.impl), int32(matchNum), startPos_00, endPos_00))
  if endPos.addr != nil:
    endPos = int(endPos_00)
  if startPos.addr != nil:
    startPos = int(startPos_00)

proc g_match_info_expand_references(self: ptr MatchInfo00; stringToExpand: cstring;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc expandReferences*(self: MatchInfo; stringToExpand: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_match_info_expand_references(cast[ptr MatchInfo00](self.impl), stringToExpand, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_match_info_get_match_count(self: ptr MatchInfo00): int32 {.
    importc, libprag.}

proc getMatchCount*(self: MatchInfo): int =
  int(g_match_info_get_match_count(cast[ptr MatchInfo00](self.impl)))

proc matchCount*(self: MatchInfo): int =
  int(g_match_info_get_match_count(cast[ptr MatchInfo00](self.impl)))

proc g_match_info_get_string(self: ptr MatchInfo00): cstring {.
    importc, libprag.}

proc getString*(self: MatchInfo): string =
  result = $g_match_info_get_string(cast[ptr MatchInfo00](self.impl))

proc g_match_info_is_partial_match(self: ptr MatchInfo00): gboolean {.
    importc, libprag.}

proc isPartialMatch*(self: MatchInfo): bool =
  toBool(g_match_info_is_partial_match(cast[ptr MatchInfo00](self.impl)))

proc g_match_info_matches(self: ptr MatchInfo00): gboolean {.
    importc, libprag.}

proc matches*(self: MatchInfo): bool =
  toBool(g_match_info_matches(cast[ptr MatchInfo00](self.impl)))

proc g_match_info_next(self: ptr MatchInfo00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc next*(self: MatchInfo): bool =
  var gerror: ptr glib.Error
  let resul0 = g_match_info_next(cast[ptr MatchInfo00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_match_info_ref(self: ptr MatchInfo00): ptr MatchInfo00 {.
    importc, libprag.}

proc `ref`*(self: MatchInfo): MatchInfo =
  fnew(result, gBoxedFreeGMatchInfo)
  result.impl = g_match_info_ref(cast[ptr MatchInfo00](self.impl))

proc g_match_info_unref(self: ptr MatchInfo00) {.
    importc, libprag.}

proc unref*(self: MatchInfo) =
  g_match_info_unref(cast[ptr MatchInfo00](self.impl))

proc finalizerunref*(self: MatchInfo) =
  if not self.ignoreFinalizer:
    g_match_info_unref(cast[ptr MatchInfo00](self.impl))

type
  Regex00* {.pure.} = object
  Regex* = ref object
    impl*: ptr Regex00
    ignoreFinalizer*: bool

proc g_regex_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGRegex*(self: Regex) =
  if not self.ignoreFinalizer:
    boxedFree(g_regex_get_type(), cast[ptr Regex00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Regex()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_regex_get_type(), cast[ptr Regex00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Regex) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGRegex)

proc g_regex_unref(self: ptr Regex00) {.
    importc, libprag.}

proc unref*(self: Regex) =
  g_regex_unref(cast[ptr Regex00](self.impl))

proc finalizerunref*(self: Regex) =
  if not self.ignoreFinalizer:
    g_regex_unref(cast[ptr Regex00](self.impl))

proc g_regex_get_capture_count(self: ptr Regex00): int32 {.
    importc, libprag.}

proc getCaptureCount*(self: Regex): int =
  int(g_regex_get_capture_count(cast[ptr Regex00](self.impl)))

proc captureCount*(self: Regex): int =
  int(g_regex_get_capture_count(cast[ptr Regex00](self.impl)))

proc g_regex_get_has_cr_or_lf(self: ptr Regex00): gboolean {.
    importc, libprag.}

proc getHasCrOrLf*(self: Regex): bool =
  toBool(g_regex_get_has_cr_or_lf(cast[ptr Regex00](self.impl)))

proc hasCrOrLf*(self: Regex): bool =
  toBool(g_regex_get_has_cr_or_lf(cast[ptr Regex00](self.impl)))

proc g_regex_get_max_backref(self: ptr Regex00): int32 {.
    importc, libprag.}

proc getMaxBackref*(self: Regex): int =
  int(g_regex_get_max_backref(cast[ptr Regex00](self.impl)))

proc maxBackref*(self: Regex): int =
  int(g_regex_get_max_backref(cast[ptr Regex00](self.impl)))

proc g_regex_get_max_lookbehind(self: ptr Regex00): int32 {.
    importc, libprag.}

proc getMaxLookbehind*(self: Regex): int =
  int(g_regex_get_max_lookbehind(cast[ptr Regex00](self.impl)))

proc maxLookbehind*(self: Regex): int =
  int(g_regex_get_max_lookbehind(cast[ptr Regex00](self.impl)))

proc g_regex_get_pattern(self: ptr Regex00): cstring {.
    importc, libprag.}

proc getPattern*(self: Regex): string =
  result = $g_regex_get_pattern(cast[ptr Regex00](self.impl))

proc pattern*(self: Regex): string =
  result = $g_regex_get_pattern(cast[ptr Regex00](self.impl))

proc g_regex_get_string_number(self: ptr Regex00; name: cstring): int32 {.
    importc, libprag.}

proc getStringNumber*(self: Regex; name: cstring): int =
  int(g_regex_get_string_number(cast[ptr Regex00](self.impl), name))

proc g_regex_ref(self: ptr Regex00): ptr Regex00 {.
    importc, libprag.}

proc `ref`*(self: Regex): Regex =
  fnew(result, gBoxedFreeGRegex)
  result.impl = g_regex_ref(cast[ptr Regex00](self.impl))

proc g_regex_check_replacement(replacement: cstring; hasReferences: var gboolean;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc checkReplacement*(replacement: cstring; hasReferences: var bool = cast[var bool](nil)): bool =
  var gerror: ptr glib.Error
  var hasReferences_00: gboolean
  let resul0 = g_regex_check_replacement(replacement, hasReferences_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if hasReferences.addr != nil:
    hasReferences = toBool(hasReferences_00)

proc g_regex_escape_nul(string: cstring; length: int32): cstring {.
    importc, libprag.}

proc escapeNul*(string: cstring; length: int): string =
  let resul0 = g_regex_escape_nul(string, int32(length))
  result = $resul0
  cogfree(resul0)

proc g_regex_escape_string(string: ptr cstring; length: int32): cstring {.
    importc, libprag.}

proc escapeString*(string: openArray[string]; length: int): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = g_regex_escape_string(seq2CstringArray(string, fs469n23), int32(length))
  result = $resul0
  cogfree(resul0)

proc g_match_info_get_regex(self: ptr MatchInfo00): ptr Regex00 {.
    importc, libprag.}

proc getRegex*(self: MatchInfo): Regex =
  fnew(result, gBoxedFreeGRegex)
  result.impl = g_match_info_get_regex(cast[ptr MatchInfo00](self.impl))

proc regex*(self: MatchInfo): Regex =
  fnew(result, gBoxedFreeGRegex)
  result.impl = g_match_info_get_regex(cast[ptr MatchInfo00](self.impl))

type
  RegexMatchFlags* {.size: sizeof(cint), pure.} = enum
    anchored = 16
    notbol = 128
    noteol = 256
    notempty = 1024
    partial = 32768
    newlineCr = 1048576
    newlineLf = 2097152
    newlineCrlf = 3145728
    newlineAny = 4194304
    newlineAnycrlf = 5242880
    bsrAnycrlf = 8388608
    bsrAny = 16777216
    partialHard = 134217728
    notemptyAtstart = 268435456

const
  RegexMatchFlagsPartialSoft* = RegexMatchFlags.partial

proc g_regex_get_match_flags(self: ptr Regex00): RegexMatchFlags {.
    importc, libprag.}

proc getMatchFlags*(self: Regex): RegexMatchFlags =
  g_regex_get_match_flags(cast[ptr Regex00](self.impl))

proc matchFlags*(self: Regex): RegexMatchFlags =
  g_regex_get_match_flags(cast[ptr Regex00](self.impl))

proc g_regex_match(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags;
    matchInfo: var ptr MatchInfo00): gboolean {.
    importc, libprag.}

proc match*(self: Regex; string: cstring; matchOptions: RegexMatchFlags;
    matchInfo: var MatchInfo = cast[var MatchInfo](nil)): bool =
  if addr(matchInfo) != nil:
    fnew(matchInfo, gBoxedFreeGMatchInfo)
  toBool(g_regex_match(cast[ptr Regex00](self.impl), string, matchOptions, cast[var ptr MatchInfo00](if addr(matchInfo) == nil: nil else: addr matchInfo.impl)))

proc g_regex_match_all(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags;
    matchInfo: var ptr MatchInfo00): gboolean {.
    importc, libprag.}

proc matchAll*(self: Regex; string: cstring; matchOptions: RegexMatchFlags;
    matchInfo: var MatchInfo = cast[var MatchInfo](nil)): bool =
  if addr(matchInfo) != nil:
    fnew(matchInfo, gBoxedFreeGMatchInfo)
  toBool(g_regex_match_all(cast[ptr Regex00](self.impl), string, matchOptions, cast[var ptr MatchInfo00](if addr(matchInfo) == nil: nil else: addr matchInfo.impl)))

proc g_regex_match_all_full(self: ptr Regex00; string: ptr cstring; stringLen: int64;
    startPosition: int32; matchOptions: RegexMatchFlags; matchInfo: var ptr MatchInfo00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc matchAllFull*(self: Regex; string: openArray[string]; stringLen: int64;
    startPosition: int; matchOptions: RegexMatchFlags; matchInfo: var MatchInfo = cast[var MatchInfo](nil)): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  if addr(matchInfo) != nil:
    fnew(matchInfo, gBoxedFreeGMatchInfo)
  var gerror: ptr glib.Error
  let resul0 = g_regex_match_all_full(cast[ptr Regex00](self.impl), seq2CstringArray(string, fs469n23), stringLen, int32(startPosition), matchOptions, cast[var ptr MatchInfo00](if addr(matchInfo) == nil: nil else: addr matchInfo.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_regex_match_full(self: ptr Regex00; string: ptr cstring; stringLen: int64;
    startPosition: int32; matchOptions: RegexMatchFlags; matchInfo: var ptr MatchInfo00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc matchFull*(self: Regex; string: openArray[string]; stringLen: int64;
    startPosition: int; matchOptions: RegexMatchFlags; matchInfo: var MatchInfo = cast[var MatchInfo](nil)): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  if addr(matchInfo) != nil:
    fnew(matchInfo, gBoxedFreeGMatchInfo)
  var gerror: ptr glib.Error
  let resul0 = g_regex_match_full(cast[ptr Regex00](self.impl), seq2CstringArray(string, fs469n23), stringLen, int32(startPosition), matchOptions, cast[var ptr MatchInfo00](if addr(matchInfo) == nil: nil else: addr matchInfo.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_regex_replace(self: ptr Regex00; string: ptr cstring; stringLen: int64;
    startPosition: int32; replacement: cstring; matchOptions: RegexMatchFlags;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc replace*(self: Regex; string: openArray[string]; stringLen: int64;
    startPosition: int; replacement: cstring; matchOptions: RegexMatchFlags): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let resul0 = g_regex_replace(cast[ptr Regex00](self.impl), seq2CstringArray(string, fs469n23), stringLen, int32(startPosition), replacement, matchOptions, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_regex_replace_literal(self: ptr Regex00; string: ptr cstring; stringLen: int64;
    startPosition: int32; replacement: cstring; matchOptions: RegexMatchFlags;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc replaceLiteral*(self: Regex; string: openArray[string]; stringLen: int64;
    startPosition: int; replacement: cstring; matchOptions: RegexMatchFlags): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let resul0 = g_regex_replace_literal(cast[ptr Regex00](self.impl), seq2CstringArray(string, fs469n23), stringLen, int32(startPosition), replacement, matchOptions, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_regex_split(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags): ptr cstring {.
    importc, libprag.}

proc split*(self: Regex; string: cstring; matchOptions: RegexMatchFlags): seq[string] =
  let resul0 = g_regex_split(cast[ptr Regex00](self.impl), string, matchOptions)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_regex_split_full(self: ptr Regex00; string: ptr cstring; stringLen: int64;
    startPosition: int32; matchOptions: RegexMatchFlags; maxTokens: int32;
    error: ptr ptr glib.Error = nil): ptr cstring {.
    importc, libprag.}

proc splitFull*(self: Regex; string: openArray[string]; stringLen: int64;
    startPosition: int; matchOptions: RegexMatchFlags; maxTokens: int): seq[string] =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let resul0 = g_regex_split_full(cast[ptr Regex00](self.impl), seq2CstringArray(string, fs469n23), stringLen, int32(startPosition), matchOptions, int32(maxTokens), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = cstringArrayToSeq(resul0)

type
  RegexCompileFlags* {.size: sizeof(cint), pure.} = enum
    caseless = 1
    multiline = 2
    dotall = 4
    extended = 8
    anchored = 16
    dollarEndonly = 32
    ungreedy = 512
    raw = 2048
    noAutoCapture = 4096
    optimize = 8192
    firstline = 262144
    dupnames = 524288
    newlineCr = 1048576
    newlineLf = 2097152
    newlineCrlf = 3145728
    newlineAnycrlf = 5242880
    bsrAnycrlf = 8388608
    javascriptCompat = 33554432

proc g_regex_get_compile_flags(self: ptr Regex00): RegexCompileFlags {.
    importc, libprag.}

proc getCompileFlags*(self: Regex): RegexCompileFlags =
  g_regex_get_compile_flags(cast[ptr Regex00](self.impl))

proc compileFlags*(self: Regex): RegexCompileFlags =
  g_regex_get_compile_flags(cast[ptr Regex00](self.impl))

proc g_regex_new(pattern: cstring; compileOptions: RegexCompileFlags; matchOptions: RegexMatchFlags;
    error: ptr ptr glib.Error = nil): ptr Regex00 {.
    importc, libprag.}

proc newRegex*(pattern: cstring; compileOptions: RegexCompileFlags; matchOptions: RegexMatchFlags): Regex =
  var gerror: ptr glib.Error
  let impl0 = g_regex_new(pattern, compileOptions, matchOptions, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGRegex)
  result.impl = impl0

proc newRegex*(tdesc: typedesc; pattern: cstring; compileOptions: RegexCompileFlags; matchOptions: RegexMatchFlags): tdesc =
  var gerror: ptr glib.Error
  assert(result is Regex)
  let impl0 = g_regex_new(pattern, compileOptions, matchOptions, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGRegex)
  result.impl = impl0

proc initRegex*[T](result: var T; pattern: cstring; compileOptions: RegexCompileFlags; matchOptions: RegexMatchFlags) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Regex)
  let impl0 = g_regex_new(pattern, compileOptions, matchOptions, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGRegex)
  result.impl = impl0

proc g_regex_match_simple(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags;
    matchOptions: RegexMatchFlags): gboolean {.
    importc, libprag.}

proc matchSimple*(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags;
    matchOptions: RegexMatchFlags): bool =
  toBool(g_regex_match_simple(pattern, string, compileOptions, matchOptions))

proc g_regex_split_simple(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags;
    matchOptions: RegexMatchFlags): ptr cstring {.
    importc, libprag.}

proc splitSimple*(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags;
    matchOptions: RegexMatchFlags): seq[string] =
  let resul0 = g_regex_split_simple(pattern, string, compileOptions, matchOptions)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

type
  MemVTable00* {.pure.} = object
  MemVTable* = ref object
    impl*: ptr MemVTable00
    ignoreFinalizer*: bool

type
  Mutex* {.pure, byRef, union.} = object
    p*: pointer
    i*: array[2, uint32]

proc g_mutex_clear(self: Mutex) {.
    importc, libprag.}

proc clear*(self: Mutex) =
  g_mutex_clear(self)

proc g_mutex_init(self: Mutex) {.
    importc, libprag.}

proc init*(self: Mutex) =
  g_mutex_init(self)

proc g_mutex_lock(self: Mutex) {.
    importc, libprag.}

proc lock*(self: Mutex) =
  g_mutex_lock(self)

proc g_mutex_trylock(self: Mutex): gboolean {.
    importc, libprag.}

proc trylock*(self: Mutex): bool =
  toBool(g_mutex_trylock(self))

proc g_mutex_unlock(self: Mutex) {.
    importc, libprag.}

proc unlock*(self: Mutex) =
  g_mutex_unlock(self)

proc g_cond_wait(self: Cond; mutex: Mutex) {.
    importc, libprag.}

proc wait*(self: Cond; mutex: Mutex) =
  g_cond_wait(self, mutex)

proc g_cond_wait_until(self: Cond; mutex: Mutex; endTime: int64): gboolean {.
    importc, libprag.}

proc waitUntil*(self: Cond; mutex: Mutex; endTime: int64): bool =
  toBool(g_cond_wait_until(self, mutex, endTime))

proc g_main_context_wait(self: ptr MainContext00; cond: Cond; mutex: Mutex): gboolean {.
    importc, libprag.}

proc wait*(self: MainContext; cond: Cond; mutex: Mutex): bool =
  toBool(g_main_context_wait(cast[ptr MainContext00](self.impl), cond, mutex))

type
  Node00* {.pure.} = object
  Node* = ref object
    impl*: ptr Node00
    ignoreFinalizer*: bool

proc g_node_destroy(self: ptr Node00) {.
    importc, libprag.}

proc destroy*(self: Node) =
  g_node_destroy(cast[ptr Node00](self.impl))

proc finalizerdestroy*(self: Node) =
  if not self.ignoreFinalizer:
    g_node_destroy(cast[ptr Node00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Node()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_node_destroy(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Node) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerdestroy)

proc g_node_child_position(self: ptr Node00; child: ptr Node00): int32 {.
    importc, libprag.}

proc childPosition*(self: Node; child: Node): int =
  int(g_node_child_position(cast[ptr Node00](self.impl), cast[ptr Node00](child.impl)))

proc g_node_depth(self: ptr Node00): uint32 {.
    importc, libprag.}

proc depth*(self: Node): int =
  int(g_node_depth(cast[ptr Node00](self.impl)))

proc g_node_child_index(self: ptr Node00; data: pointer): int32 {.
    importc, libprag.}

proc childIndex*(self: Node; data: pointer): int =
  int(g_node_child_index(cast[ptr Node00](self.impl), data))

proc g_node_is_ancestor(self: ptr Node00; descendant: ptr Node00): gboolean {.
    importc, libprag.}

proc isAncestor*(self: Node; descendant: Node): bool =
  toBool(g_node_is_ancestor(cast[ptr Node00](self.impl), cast[ptr Node00](descendant.impl)))

proc g_node_max_height(self: ptr Node00): uint32 {.
    importc, libprag.}

proc maxHeight*(self: Node): int =
  int(g_node_max_height(cast[ptr Node00](self.impl)))

proc g_node_n_children(self: ptr Node00): uint32 {.
    importc, libprag.}

proc nChildren*(self: Node): int =
  int(g_node_n_children(cast[ptr Node00](self.impl)))

proc g_node_reverse_children(self: ptr Node00) {.
    importc, libprag.}

proc reverseChildren*(self: Node) =
  g_node_reverse_children(cast[ptr Node00](self.impl))

proc g_node_unlink(self: ptr Node00) {.
    importc, libprag.}

proc unlink*(self: Node) =
  g_node_unlink(cast[ptr Node00](self.impl))

type
  TraverseFlags* {.size: sizeof(cint), pure.} = enum
    leafs = 1
    nonLeafs = 2
    all = 3

const
  TraverseFlagsMask* = TraverseFlags.all
  TraverseFlagsLeaves* = TraverseFlags.leafs
  TraverseFlagsNonLeaves* = TraverseFlags.nonLeafs

proc g_node_n_nodes(self: ptr Node00; flags: TraverseFlags): uint32 {.
    importc, libprag.}

proc nNodes*(self: Node; flags: TraverseFlags): int =
  int(g_node_n_nodes(cast[ptr Node00](self.impl), flags))

type
  NodeForeachFunc* = proc (node: ptr Node00; data: pointer) {.cdecl.}

type
  NodeTraverseFunc* = proc (node: ptr Node00; data: pointer): gboolean {.cdecl.}

type
  NormalizeMode* {.size: sizeof(cint), pure.} = enum
    default = 0
    defaultCompose = 1
    all = 2
    allCompose = 3

const
  NormalizeModeNfkd* = NormalizeMode.all
  NormalizeModeNfkc* = NormalizeMode.allCompose
  NormalizeModeNfd* = NormalizeMode.default
  NormalizeModeNfc* = NormalizeMode.defaultCompose

type
  NumberParserError* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    outOfBounds = 1

const OPTION_REMAINING* = ""

type
  OnceStatus* {.size: sizeof(cint), pure.} = enum
    notcalled = 0
    progress = 1
    ready = 2

type
  Once* {.pure, byRef.} = object
    status*: OnceStatus
    retval*: pointer

proc g_once_init_enter(location: pointer): gboolean {.
    importc, libprag.}

proc initEnter*(location: pointer): bool =
  toBool(g_once_init_enter(location))

proc initLeave*(location: pointer; resu: uint64) {.
    importc: "g_once_init_leave", libprag.}

type
  OptionArg* {.size: sizeof(cint), pure.} = enum
    none = 0
    string = 1
    int = 2
    callback = 3
    filename = 4
    stringArray = 5
    filenameArray = 6
    double = 7
    int64 = 8

type
  OptionArgFunc* = proc (optionName: cstring; value: cstring; data: pointer; error: ptr ptr glib.Error = nil): gboolean {.cdecl.}

type
  OptionContext00* {.pure.} = object
  OptionContext* = ref object
    impl*: ptr OptionContext00
    ignoreFinalizer*: bool

proc g_option_context_free(self: ptr OptionContext00) {.
    importc, libprag.}

proc free*(self: OptionContext) =
  g_option_context_free(cast[ptr OptionContext00](self.impl))

proc finalizerfree*(self: OptionContext) =
  if not self.ignoreFinalizer:
    g_option_context_free(cast[ptr OptionContext00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(OptionContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_option_context_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var OptionContext) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_option_context_get_description(self: ptr OptionContext00): cstring {.
    importc, libprag.}

proc getDescription*(self: OptionContext): string =
  result = $g_option_context_get_description(cast[ptr OptionContext00](self.impl))

proc description*(self: OptionContext): string =
  result = $g_option_context_get_description(cast[ptr OptionContext00](self.impl))

proc g_option_context_get_help_enabled(self: ptr OptionContext00): gboolean {.
    importc, libprag.}

proc getHelpEnabled*(self: OptionContext): bool =
  toBool(g_option_context_get_help_enabled(cast[ptr OptionContext00](self.impl)))

proc helpEnabled*(self: OptionContext): bool =
  toBool(g_option_context_get_help_enabled(cast[ptr OptionContext00](self.impl)))

proc g_option_context_get_ignore_unknown_options(self: ptr OptionContext00): gboolean {.
    importc, libprag.}

proc getIgnoreUnknownOptions*(self: OptionContext): bool =
  toBool(g_option_context_get_ignore_unknown_options(cast[ptr OptionContext00](self.impl)))

proc ignoreUnknownOptions*(self: OptionContext): bool =
  toBool(g_option_context_get_ignore_unknown_options(cast[ptr OptionContext00](self.impl)))

proc g_option_context_get_strict_posix(self: ptr OptionContext00): gboolean {.
    importc, libprag.}

proc getStrictPosix*(self: OptionContext): bool =
  toBool(g_option_context_get_strict_posix(cast[ptr OptionContext00](self.impl)))

proc strictPosix*(self: OptionContext): bool =
  toBool(g_option_context_get_strict_posix(cast[ptr OptionContext00](self.impl)))

proc g_option_context_get_summary(self: ptr OptionContext00): cstring {.
    importc, libprag.}

proc getSummary*(self: OptionContext): string =
  result = $g_option_context_get_summary(cast[ptr OptionContext00](self.impl))

proc summary*(self: OptionContext): string =
  result = $g_option_context_get_summary(cast[ptr OptionContext00](self.impl))

proc g_option_context_parse(self: ptr OptionContext00; argc: var int32; argv: var ptr cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc parse*(self: OptionContext; argc: var int; argv: var seq[string]): bool =
  var gerror: ptr glib.Error
  var argc_00 = int32(argc)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var argv_00 = seq2CstringArray(argv, fs469n23)
  let resul0 = g_option_context_parse(cast[ptr OptionContext00](self.impl), argc_00, argv_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  argc = int(argc_00)
  argv = cstringArrayToSeq(argv_00)

proc g_option_context_parse_strv(self: ptr OptionContext00; arguments: var ptr cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc parseStrv*(self: OptionContext; arguments: var seq[string]): bool =
  var gerror: ptr glib.Error
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var arguments_00 = seq2CstringArray(arguments, fs469n23)
  let resul0 = g_option_context_parse_strv(cast[ptr OptionContext00](self.impl), arguments_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  arguments = cstringArrayToSeq(arguments_00)

proc g_option_context_set_description(self: ptr OptionContext00; description: cstring) {.
    importc, libprag.}

proc setDescription*(self: OptionContext; description: cstring = nil) =
  g_option_context_set_description(cast[ptr OptionContext00](self.impl), description)

proc `description=`*(self: OptionContext; description: cstring = nil) =
  g_option_context_set_description(cast[ptr OptionContext00](self.impl), description)

proc g_option_context_set_help_enabled(self: ptr OptionContext00; helpEnabled: gboolean) {.
    importc, libprag.}

proc setHelpEnabled*(self: OptionContext; helpEnabled: bool = true) =
  g_option_context_set_help_enabled(cast[ptr OptionContext00](self.impl), gboolean(helpEnabled))

proc `helpEnabled=`*(self: OptionContext; helpEnabled: bool) =
  g_option_context_set_help_enabled(cast[ptr OptionContext00](self.impl), gboolean(helpEnabled))

proc g_option_context_set_ignore_unknown_options(self: ptr OptionContext00;
    ignoreUnknown: gboolean) {.
    importc, libprag.}

proc setIgnoreUnknownOptions*(self: OptionContext; ignoreUnknown: bool = true) =
  g_option_context_set_ignore_unknown_options(cast[ptr OptionContext00](self.impl), gboolean(ignoreUnknown))

proc `ignoreUnknownOptions=`*(self: OptionContext; ignoreUnknown: bool) =
  g_option_context_set_ignore_unknown_options(cast[ptr OptionContext00](self.impl), gboolean(ignoreUnknown))

proc g_option_context_set_strict_posix(self: ptr OptionContext00; strictPosix: gboolean) {.
    importc, libprag.}

proc setStrictPosix*(self: OptionContext; strictPosix: bool = true) =
  g_option_context_set_strict_posix(cast[ptr OptionContext00](self.impl), gboolean(strictPosix))

proc `strictPosix=`*(self: OptionContext; strictPosix: bool) =
  g_option_context_set_strict_posix(cast[ptr OptionContext00](self.impl), gboolean(strictPosix))

proc g_option_context_set_summary(self: ptr OptionContext00; summary: cstring) {.
    importc, libprag.}

proc setSummary*(self: OptionContext; summary: cstring = nil) =
  g_option_context_set_summary(cast[ptr OptionContext00](self.impl), summary)

proc `summary=`*(self: OptionContext; summary: cstring = nil) =
  g_option_context_set_summary(cast[ptr OptionContext00](self.impl), summary)

proc g_option_context_set_translation_domain(self: ptr OptionContext00; domain: cstring) {.
    importc, libprag.}

proc setTranslationDomain*(self: OptionContext; domain: cstring) =
  g_option_context_set_translation_domain(cast[ptr OptionContext00](self.impl), domain)

proc `translationDomain=`*(self: OptionContext; domain: cstring) =
  g_option_context_set_translation_domain(cast[ptr OptionContext00](self.impl), domain)

type
  OptionEntry* {.pure, byRef.} = object
    longName*: cstring
    shortName*: int8
    flags*: int32
    arg*: OptionArg
    argData*: pointer
    description*: cstring
    argDescription*: cstring

proc g_option_context_add_main_entries(self: ptr OptionContext00; entries: ptr OptionEntry;
    translationDomain: cstring) {.
    importc, libprag.}

proc addMainEntries*(self: OptionContext; entries: ptr OptionEntry;
    translationDomain: cstring = nil) =
  g_option_context_add_main_entries(cast[ptr OptionContext00](self.impl), entries, translationDomain)

type
  OptionGroup00* {.pure.} = object
  OptionGroup* = ref object
    impl*: ptr OptionGroup00
    ignoreFinalizer*: bool

proc g_option_group_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGOptionGroup*(self: OptionGroup) =
  if not self.ignoreFinalizer:
    boxedFree(g_option_group_get_type(), cast[ptr OptionGroup00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(OptionGroup()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_option_group_get_type(), cast[ptr OptionGroup00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var OptionGroup) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGOptionGroup)

proc g_option_group_free(self: ptr OptionGroup00) {.
    importc, libprag.}

proc free*(self: OptionGroup) =
  g_option_group_free(cast[ptr OptionGroup00](self.impl))

proc finalizerfree*(self: OptionGroup) =
  if not self.ignoreFinalizer:
    g_option_group_free(cast[ptr OptionGroup00](self.impl))

proc g_option_group_add_entries(self: ptr OptionGroup00; entries: ptr OptionEntry) {.
    importc, libprag.}

proc addEntries*(self: OptionGroup; entries: ptr OptionEntry) =
  g_option_group_add_entries(cast[ptr OptionGroup00](self.impl), entries)

proc g_option_group_new(name: cstring; description: cstring; helpDescription: cstring;
    userData: pointer; destroy: DestroyNotify): ptr OptionGroup00 {.
    importc, libprag.}

proc newOptionGroup*(name: cstring; description: cstring; helpDescription: cstring;
    userData: pointer; destroy: DestroyNotify): OptionGroup =
  fnew(result, gBoxedFreeGOptionGroup)
  result.impl = g_option_group_new(name, description, helpDescription, userData, destroy)

proc newOptionGroup*(tdesc: typedesc; name: cstring; description: cstring; helpDescription: cstring;
    userData: pointer; destroy: DestroyNotify): tdesc =
  assert(result is OptionGroup)
  fnew(result, gBoxedFreeGOptionGroup)
  result.impl = g_option_group_new(name, description, helpDescription, userData, destroy)

proc initOptionGroup*[T](result: var T; name: cstring; description: cstring; helpDescription: cstring;
    userData: pointer; destroy: DestroyNotify) {.deprecated.} =
  assert(result is OptionGroup)
  fnew(result, gBoxedFreeGOptionGroup)
  result.impl = g_option_group_new(name, description, helpDescription, userData, destroy)

proc g_option_group_ref(self: ptr OptionGroup00): ptr OptionGroup00 {.
    importc, libprag.}

proc `ref`*(self: OptionGroup): OptionGroup =
  fnew(result, gBoxedFreeGOptionGroup)
  result.impl = g_option_group_ref(cast[ptr OptionGroup00](self.impl))

proc g_option_group_set_translation_domain(self: ptr OptionGroup00; domain: cstring) {.
    importc, libprag.}

proc setTranslationDomain*(self: OptionGroup; domain: cstring) =
  g_option_group_set_translation_domain(cast[ptr OptionGroup00](self.impl), domain)

proc `translationDomain=`*(self: OptionGroup; domain: cstring) =
  g_option_group_set_translation_domain(cast[ptr OptionGroup00](self.impl), domain)

proc g_option_group_unref(self: ptr OptionGroup00) {.
    importc, libprag.}

proc unref*(self: OptionGroup) =
  g_option_group_unref(cast[ptr OptionGroup00](self.impl))

proc finalizerunref*(self: OptionGroup) =
  if not self.ignoreFinalizer:
    g_option_group_unref(cast[ptr OptionGroup00](self.impl))

proc g_option_context_add_group(self: ptr OptionContext00; group: ptr OptionGroup00) {.
    importc, libprag.}

proc addGroup*(self: OptionContext; group: OptionGroup) =
  g_option_context_add_group(cast[ptr OptionContext00](self.impl), cast[ptr OptionGroup00](g_boxed_copy(g_option_group_get_type(), group.impl)))

proc g_option_context_get_help(self: ptr OptionContext00; mainHelp: gboolean;
    group: ptr OptionGroup00): cstring {.
    importc, libprag.}

proc getHelp*(self: OptionContext; mainHelp: bool; group: OptionGroup = nil): string =
  let resul0 = g_option_context_get_help(cast[ptr OptionContext00](self.impl), gboolean(mainHelp), if group.isNil: nil else: cast[ptr OptionGroup00](group.impl))
  result = $resul0
  cogfree(resul0)

proc g_option_context_get_main_group(self: ptr OptionContext00): ptr OptionGroup00 {.
    importc, libprag.}

proc getMainGroup*(self: OptionContext): OptionGroup =
  fnew(result, gBoxedFreeGOptionGroup)
  result.impl = g_option_context_get_main_group(cast[ptr OptionContext00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_option_group_get_type(), result.impl))

proc mainGroup*(self: OptionContext): OptionGroup =
  fnew(result, gBoxedFreeGOptionGroup)
  result.impl = g_option_context_get_main_group(cast[ptr OptionContext00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_option_group_get_type(), result.impl))

proc g_option_context_set_main_group(self: ptr OptionContext00; group: ptr OptionGroup00) {.
    importc, libprag.}

proc setMainGroup*(self: OptionContext; group: OptionGroup) =
  g_option_context_set_main_group(cast[ptr OptionContext00](self.impl), cast[ptr OptionGroup00](g_boxed_copy(g_option_group_get_type(), group.impl)))

proc `mainGroup=`*(self: OptionContext; group: OptionGroup) =
  g_option_context_set_main_group(cast[ptr OptionContext00](self.impl), cast[ptr OptionGroup00](g_boxed_copy(g_option_group_get_type(), group.impl)))

type
  OptionError* {.size: sizeof(cint), pure.} = enum
    unknownOption = 0
    badValue = 1
    failed = 2

type
  OptionErrorFunc* = proc (context: ptr OptionContext00; group: ptr OptionGroup00; data: pointer;
    error: ptr ptr glib.Error = nil) {.cdecl.}

type
  OptionFlag* {.size: sizeof(cint), pure.} = enum
    hidden = 0
    inMain = 1
    reverse = 2
    noArg = 3
    filename = 4
    optionalArg = 5
    noalias = 6

  OptionFlags* {.size: sizeof(cint).} = set[OptionFlag]

const
  OptionFlagsNone* = OptionFlags({})
proc none*(t: typedesc[OptionFlags]): OptionFlags = OptionFlags({})

type
  OptionParseFunc* = proc (context: ptr OptionContext00; group: ptr OptionGroup00; data: pointer;
    error: ptr ptr glib.Error = nil): gboolean {.cdecl.}

const PDP_ENDIAN* = 3412'i32

const PI* = 3.141593'f64

const PID_FORMAT* = "i"

const PI_2* = 1.570796'f64

const PI_4* = 0.785398'f64

const POLLFD_FORMAT* = "%d"

const PRIORITY_DEFAULT* = 0'i32

const PRIORITY_DEFAULT_IDLE* = 200'i32

const PRIORITY_HIGH* = -100'i32

const PRIORITY_HIGH_IDLE* = 100'i32

const PRIORITY_LOW* = 300'i32

type
  PatternSpec00* {.pure.} = object
  PatternSpec* = ref object
    impl*: ptr PatternSpec00
    ignoreFinalizer*: bool

proc g_pattern_spec_free(self: ptr PatternSpec00) {.
    importc, libprag.}

proc free*(self: PatternSpec) =
  g_pattern_spec_free(cast[ptr PatternSpec00](self.impl))

proc finalizerfree*(self: PatternSpec) =
  if not self.ignoreFinalizer:
    g_pattern_spec_free(cast[ptr PatternSpec00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PatternSpec()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_pattern_spec_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var PatternSpec) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_pattern_spec_equal(self: ptr PatternSpec00; pspec2: ptr PatternSpec00): gboolean {.
    importc, libprag.}

proc equal*(self: PatternSpec; pspec2: PatternSpec): bool =
  toBool(g_pattern_spec_equal(cast[ptr PatternSpec00](self.impl), cast[ptr PatternSpec00](pspec2.impl)))

type
  PollFunc* = proc (ufds: PollFD; nfsd: uint32; timeout: int32): int32 {.cdecl.}

type
  PrintFunc* = proc (string: cstring) {.cdecl.}

type
  PtrArray00* {.pure.} = object
  PtrArray* = ref object
    impl*: ptr PtrArray00
    ignoreFinalizer*: bool

proc g_ptr_array_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGPtrArray*(self: PtrArray) =
  if not self.ignoreFinalizer:
    boxedFree(g_ptr_array_get_type(), cast[ptr PtrArray00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PtrArray()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_ptr_array_get_type(), cast[ptr PtrArray00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var PtrArray) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGPtrArray)

type
  Queue00* {.pure.} = object
  Queue* = ref object
    impl*: ptr Queue00
    ignoreFinalizer*: bool

proc g_queue_free(self: ptr Queue00) {.
    importc, libprag.}

proc free*(self: Queue) =
  g_queue_free(cast[ptr Queue00](self.impl))

proc finalizerfree*(self: Queue) =
  if not self.ignoreFinalizer:
    g_queue_free(cast[ptr Queue00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Queue()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_queue_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Queue) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_queue_clear_full(self: ptr Queue00; freeFunc: DestroyNotify) {.
    importc, libprag.}

proc clearFull*(self: Queue; freeFunc: DestroyNotify) =
  g_queue_clear_full(cast[ptr Queue00](self.impl), freeFunc)

proc g_queue_clear(self: ptr Queue00) {.
    importc, libprag.}

proc clear*(self: Queue) =
  g_queue_clear(cast[ptr Queue00](self.impl))

proc g_queue_free_full(self: ptr Queue00; freeFunc: DestroyNotify) {.
    importc, libprag.}

proc freeFull*(self: Queue; freeFunc: DestroyNotify) =
  g_queue_free_full(cast[ptr Queue00](self.impl), freeFunc)

proc g_queue_get_length(self: ptr Queue00): uint32 {.
    importc, libprag.}

proc getLength*(self: Queue): int =
  int(g_queue_get_length(cast[ptr Queue00](self.impl)))

proc length*(self: Queue): int =
  int(g_queue_get_length(cast[ptr Queue00](self.impl)))

proc g_queue_index(self: ptr Queue00; data: pointer): int32 {.
    importc, libprag.}

proc index*(self: Queue; data: pointer): int =
  int(g_queue_index(cast[ptr Queue00](self.impl), data))

proc g_queue_init(self: ptr Queue00) {.
    importc, libprag.}

proc init*(self: Queue) =
  g_queue_init(cast[ptr Queue00](self.impl))

proc g_queue_is_empty(self: ptr Queue00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: Queue): bool =
  toBool(g_queue_is_empty(cast[ptr Queue00](self.impl)))

proc g_queue_peek_head(self: ptr Queue00): pointer {.
    importc, libprag.}

proc peekHead*(self: Queue): pointer =
  g_queue_peek_head(cast[ptr Queue00](self.impl))

proc g_queue_peek_nth(self: ptr Queue00; n: uint32): pointer {.
    importc, libprag.}

proc peekNth*(self: Queue; n: int): pointer =
  g_queue_peek_nth(cast[ptr Queue00](self.impl), uint32(n))

proc g_queue_peek_tail(self: ptr Queue00): pointer {.
    importc, libprag.}

proc peekTail*(self: Queue): pointer =
  g_queue_peek_tail(cast[ptr Queue00](self.impl))

proc g_queue_pop_head(self: ptr Queue00): pointer {.
    importc, libprag.}

proc popHead*(self: Queue): pointer =
  g_queue_pop_head(cast[ptr Queue00](self.impl))

proc g_queue_pop_nth(self: ptr Queue00; n: uint32): pointer {.
    importc, libprag.}

proc popNth*(self: Queue; n: int): pointer =
  g_queue_pop_nth(cast[ptr Queue00](self.impl), uint32(n))

proc g_queue_pop_tail(self: ptr Queue00): pointer {.
    importc, libprag.}

proc popTail*(self: Queue): pointer =
  g_queue_pop_tail(cast[ptr Queue00](self.impl))

proc g_queue_push_head(self: ptr Queue00; data: pointer) {.
    importc, libprag.}

proc pushHead*(self: Queue; data: pointer) =
  g_queue_push_head(cast[ptr Queue00](self.impl), data)

proc g_queue_push_nth(self: ptr Queue00; data: pointer; n: int32) {.
    importc, libprag.}

proc pushNth*(self: Queue; data: pointer; n: int) =
  g_queue_push_nth(cast[ptr Queue00](self.impl), data, int32(n))

proc g_queue_push_tail(self: ptr Queue00; data: pointer) {.
    importc, libprag.}

proc pushTail*(self: Queue; data: pointer) =
  g_queue_push_tail(cast[ptr Queue00](self.impl), data)

proc g_queue_remove(self: ptr Queue00; data: pointer): gboolean {.
    importc, libprag.}

proc remove*(self: Queue; data: pointer): bool =
  toBool(g_queue_remove(cast[ptr Queue00](self.impl), data))

proc g_queue_remove_all(self: ptr Queue00; data: pointer): uint32 {.
    importc, libprag.}

proc removeAll*(self: Queue; data: pointer): int =
  int(g_queue_remove_all(cast[ptr Queue00](self.impl), data))

proc g_queue_reverse(self: ptr Queue00) {.
    importc, libprag.}

proc reverse*(self: Queue) =
  g_queue_reverse(cast[ptr Queue00](self.impl))

type
  RWLock* {.pure, byRef.} = object
    p*: pointer
    i*: array[2, uint32]

proc g_rw_lock_clear(self: RWLock) {.
    importc, libprag.}

proc clear*(self: RWLock) =
  g_rw_lock_clear(self)

proc g_rw_lock_init(self: RWLock) {.
    importc, libprag.}

proc init*(self: RWLock) =
  g_rw_lock_init(self)

proc g_rw_lock_reader_lock(self: RWLock) {.
    importc, libprag.}

proc readerLock*(self: RWLock) =
  g_rw_lock_reader_lock(self)

proc g_rw_lock_reader_trylock(self: RWLock): gboolean {.
    importc, libprag.}

proc readerTrylock*(self: RWLock): bool =
  toBool(g_rw_lock_reader_trylock(self))

proc g_rw_lock_reader_unlock(self: RWLock) {.
    importc, libprag.}

proc readerUnlock*(self: RWLock) =
  g_rw_lock_reader_unlock(self)

proc g_rw_lock_writer_lock(self: RWLock) {.
    importc, libprag.}

proc writerLock*(self: RWLock) =
  g_rw_lock_writer_lock(self)

proc g_rw_lock_writer_trylock(self: RWLock): gboolean {.
    importc, libprag.}

proc writerTrylock*(self: RWLock): bool =
  toBool(g_rw_lock_writer_trylock(self))

proc g_rw_lock_writer_unlock(self: RWLock) {.
    importc, libprag.}

proc writerUnlock*(self: RWLock) =
  g_rw_lock_writer_unlock(self)

type
  Rand00* {.pure.} = object
  Rand* = ref object
    impl*: ptr Rand00
    ignoreFinalizer*: bool

proc g_rand_free(self: ptr Rand00) {.
    importc, libprag.}

proc free*(self: Rand) =
  g_rand_free(cast[ptr Rand00](self.impl))

proc finalizerfree*(self: Rand) =
  if not self.ignoreFinalizer:
    g_rand_free(cast[ptr Rand00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Rand()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_rand_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Rand) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_rand_double_range(self: ptr Rand00; begin: cdouble; `end`: cdouble): cdouble {.
    importc, libprag.}

proc doubleRange*(self: Rand; begin: cdouble; `end`: cdouble): cdouble =
  g_rand_double_range(cast[ptr Rand00](self.impl), begin, `end`)

proc g_rand_double(self: ptr Rand00): cdouble {.
    importc, libprag.}

proc double*(self: Rand): cdouble =
  g_rand_double(cast[ptr Rand00](self.impl))

proc g_rand_int(self: ptr Rand00): uint32 {.
    importc, libprag.}

proc intP*(self: Rand): int =
  int(g_rand_int(cast[ptr Rand00](self.impl)))

proc g_rand_int_range(self: ptr Rand00; begin: int32; `end`: int32): int32 {.
    importc, libprag.}

proc intRange*(self: Rand; begin: int; `end`: int): int =
  int(g_rand_int_range(cast[ptr Rand00](self.impl), int32(begin), int32(`end`)))

proc g_rand_set_seed(self: ptr Rand00; seed: uint32) {.
    importc, libprag.}

proc setSeed*(self: Rand; seed: int) =
  g_rand_set_seed(cast[ptr Rand00](self.impl), uint32(seed))

proc `seed=`*(self: Rand; seed: int) =
  g_rand_set_seed(cast[ptr Rand00](self.impl), uint32(seed))

proc g_rand_set_seed_array(self: ptr Rand00; seed: ptr uint32; seedLength: uint32) {.
    importc, libprag.}

proc setSeedArray*(self: Rand; seed: ptr uint32; seedLength: int) =
  g_rand_set_seed_array(cast[ptr Rand00](self.impl), seed, uint32(seedLength))

type
  RecMutex* {.pure, byRef.} = object
    p*: pointer
    i*: array[2, uint32]

proc g_rec_mutex_clear(self: RecMutex) {.
    importc, libprag.}

proc clear*(self: RecMutex) =
  g_rec_mutex_clear(self)

proc g_rec_mutex_init(self: RecMutex) {.
    importc, libprag.}

proc init*(self: RecMutex) =
  g_rec_mutex_init(self)

proc g_rec_mutex_lock(self: RecMutex) {.
    importc, libprag.}

proc lock*(self: RecMutex) =
  g_rec_mutex_lock(self)

proc g_rec_mutex_trylock(self: RecMutex): gboolean {.
    importc, libprag.}

proc trylock*(self: RecMutex): bool =
  toBool(g_rec_mutex_trylock(self))

proc g_rec_mutex_unlock(self: RecMutex) {.
    importc, libprag.}

proc unlock*(self: RecMutex) =
  g_rec_mutex_unlock(self)

type
  RegexError* {.size: sizeof(cint), pure.} = enum
    compile = 0
    optimize = 1
    replace = 2
    match = 3
    internal = 4
    strayBackslash = 101
    missingControlChar = 102
    unrecognizedEscape = 103
    quantifiersOutOfOrder = 104
    quantifierTooBig = 105
    unterminatedCharacterClass = 106
    invalidEscapeInCharacterClass = 107
    rangeOutOfOrder = 108
    nothingToRepeat = 109
    unrecognizedCharacter = 112
    posixNamedClassOutsideClass = 113
    unmatchedParenthesis = 114
    inexistentSubpatternReference = 115
    unterminatedComment = 118
    expressionTooLarge = 120
    memoryError = 121
    variableLengthLookbehind = 125
    malformedCondition = 126
    tooManyConditionalBranches = 127
    assertionExpected = 128
    unknownPosixClassName = 130
    posixCollatingElementsNotSupported = 131
    hexCodeTooLarge = 134
    invalidCondition = 135
    singleByteMatchInLookbehind = 136
    infiniteLoop = 140
    missingSubpatternNameTerminator = 142
    duplicateSubpatternName = 143
    malformedProperty = 146
    unknownProperty = 147
    subpatternNameTooLong = 148
    tooManySubpatterns = 149
    invalidOctalValue = 151
    tooManyBranchesInDefine = 154
    defineRepetion = 155
    inconsistentNewlineOptions = 156
    missingBackReference = 157
    invalidRelativeReference = 158
    backtrackingControlVerbArgumentForbidden = 159
    unknownBacktrackingControlVerb = 160
    numberTooBig = 161
    missingSubpatternName = 162
    missingDigit = 163
    invalidDataCharacter = 164
    extraSubpatternName = 165
    backtrackingControlVerbArgumentRequired = 166
    invalidControlChar = 168
    missingName = 169
    notSupportedInClass = 171
    tooManyForwardReferences = 172
    nameTooLong = 175
    characterValueTooLarge = 176

type
  RegexEvalCallback* = proc (matchInfo: ptr MatchInfo00; resu: String; userData: pointer): gboolean {.cdecl.}

const SEARCHPATH_SEPARATOR* = 58'i32

const SEARCHPATH_SEPARATOR_S* = ":"

const SIZEOF_LONG* = 8'i32

const SIZEOF_SIZE_T* = 8'i32

const SIZEOF_SSIZE_T* = 8'i32

const SIZEOF_VOID_P* = 8'i32

type
  SList* {.pure, byRef.} = object
    data*: pointer
    next*: ptr glib.SList

proc g_slist_free*(list: ptr glib.SList) {.importc: "g_slist_free", libprag.}

proc g_slist_prepend*(list: ptr glib.SList; data: pointer): ptr glib.SList  {.importc:  "g_slist_prepend", libprag.}

const SOURCE_CONTINUE* = true

const SOURCE_REMOVE* = false

const SQRT2* = 1.414214'f64

const STR_DELIMITERS* = "_-|> <."

const SYSDEF_AF_INET* = 2'i32

const SYSDEF_AF_INET6* = 10'i32

const SYSDEF_AF_UNIX* = 1'i32

const SYSDEF_MSG_DONTROUTE* = 4'i32

const SYSDEF_MSG_OOB* = 1'i32

const SYSDEF_MSG_PEEK* = 2'i32

type
  Scanner00* {.pure.} = object
  Scanner* = ref object
    impl*: ptr Scanner00
    ignoreFinalizer*: bool

proc g_scanner_destroy(self: ptr Scanner00) {.
    importc, libprag.}

proc destroy*(self: Scanner) =
  g_scanner_destroy(cast[ptr Scanner00](self.impl))

proc finalizerdestroy*(self: Scanner) =
  if not self.ignoreFinalizer:
    g_scanner_destroy(cast[ptr Scanner00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Scanner()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_scanner_destroy(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Scanner) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerdestroy)

proc g_scanner_cur_position(self: ptr Scanner00): uint32 {.
    importc, libprag.}

proc curPosition*(self: Scanner): int =
  int(g_scanner_cur_position(cast[ptr Scanner00](self.impl)))

proc g_scanner_cur_line(self: ptr Scanner00): uint32 {.
    importc, libprag.}

proc curLine*(self: Scanner): int =
  int(g_scanner_cur_line(cast[ptr Scanner00](self.impl)))

proc g_scanner_eof(self: ptr Scanner00): gboolean {.
    importc, libprag.}

proc eof*(self: Scanner): bool =
  toBool(g_scanner_eof(cast[ptr Scanner00](self.impl)))

proc g_scanner_input_file(self: ptr Scanner00; inputFd: int32) {.
    importc, libprag.}

proc inputFile*(self: Scanner; inputFd: int) =
  g_scanner_input_file(cast[ptr Scanner00](self.impl), int32(inputFd))

proc g_scanner_input_text(self: ptr Scanner00; text: cstring; textLen: uint32) {.
    importc, libprag.}

proc inputText*(self: Scanner; text: cstring; textLen: int) =
  g_scanner_input_text(cast[ptr Scanner00](self.impl), text, uint32(textLen))

proc g_scanner_lookup_symbol(self: ptr Scanner00; symbol: cstring): pointer {.
    importc, libprag.}

proc lookupSymbol*(self: Scanner; symbol: cstring): pointer =
  g_scanner_lookup_symbol(cast[ptr Scanner00](self.impl), symbol)

proc g_scanner_scope_add_symbol(self: ptr Scanner00; scopeId: uint32; symbol: cstring;
    value: pointer) {.
    importc, libprag.}

proc scopeAddSymbol*(self: Scanner; scopeId: int; symbol: cstring;
    value: pointer) =
  g_scanner_scope_add_symbol(cast[ptr Scanner00](self.impl), uint32(scopeId), symbol, value)

proc g_scanner_scope_lookup_symbol(self: ptr Scanner00; scopeId: uint32;
    symbol: cstring): pointer {.
    importc, libprag.}

proc scopeLookupSymbol*(self: Scanner; scopeId: int; symbol: cstring): pointer =
  g_scanner_scope_lookup_symbol(cast[ptr Scanner00](self.impl), uint32(scopeId), symbol)

proc g_scanner_scope_remove_symbol(self: ptr Scanner00; scopeId: uint32;
    symbol: cstring) {.
    importc, libprag.}

proc scopeRemoveSymbol*(self: Scanner; scopeId: int; symbol: cstring) =
  g_scanner_scope_remove_symbol(cast[ptr Scanner00](self.impl), uint32(scopeId), symbol)

proc g_scanner_set_scope(self: ptr Scanner00; scopeId: uint32): uint32 {.
    importc, libprag.}

proc setScope*(self: Scanner; scopeId: int): int =
  int(g_scanner_set_scope(cast[ptr Scanner00](self.impl), uint32(scopeId)))

proc g_scanner_sync_file_offset(self: ptr Scanner00) {.
    importc, libprag.}

proc syncFileOffset*(self: Scanner) =
  g_scanner_sync_file_offset(cast[ptr Scanner00](self.impl))

type
  TokenType* {.size: sizeof(cint), pure.} = enum
    eof = 0
    leftParen = 40
    rightParen = 41
    comma = 44
    equalSign = 61
    leftBrace = 91
    rightBrace = 93
    leftCurly = 123
    rightCurly = 125
    none = 256
    error = 257
    char = 258
    binary = 259
    octal = 260
    int = 261
    hex = 262
    float = 263
    string = 264
    symbol = 265
    identifier = 266
    identifierNull = 267
    commentSingle = 268
    commentMulti = 269

proc g_scanner_cur_token(self: ptr Scanner00): TokenType {.
    importc, libprag.}

proc curToken*(self: Scanner): TokenType =
  g_scanner_cur_token(cast[ptr Scanner00](self.impl))

proc g_scanner_get_next_token(self: ptr Scanner00): TokenType {.
    importc, libprag.}

proc getNextToken*(self: Scanner): TokenType =
  g_scanner_get_next_token(cast[ptr Scanner00](self.impl))

proc nextToken*(self: Scanner): TokenType =
  g_scanner_get_next_token(cast[ptr Scanner00](self.impl))

proc g_scanner_peek_next_token(self: ptr Scanner00): TokenType {.
    importc, libprag.}

proc peekNextToken*(self: Scanner): TokenType =
  g_scanner_peek_next_token(cast[ptr Scanner00](self.impl))

proc g_scanner_unexp_token(self: ptr Scanner00; expectedToken: TokenType;
    identifierSpec: cstring; symbolSpec: cstring; symbolName: cstring; message: cstring;
    isError: int32) {.
    importc, libprag.}

proc unexpToken*(self: Scanner; expectedToken: TokenType; identifierSpec: cstring;
    symbolSpec: cstring; symbolName: cstring; message: cstring; isError: int) =
  g_scanner_unexp_token(cast[ptr Scanner00](self.impl), expectedToken, identifierSpec, symbolSpec, symbolName, message, int32(isError))

type
  ScannerConfig00* {.pure.} = object
  ScannerConfig* = ref object
    impl*: ptr ScannerConfig00
    ignoreFinalizer*: bool

type
  ScannerMsgFunc* = proc (scanner: ptr Scanner00; message: cstring; error: gboolean) {.cdecl.}

type
  Sequence00* {.pure.} = object
  Sequence* = ref object
    impl*: ptr Sequence00
    ignoreFinalizer*: bool

proc g_sequence_free(self: ptr Sequence00) {.
    importc, libprag.}

proc free*(self: Sequence) =
  g_sequence_free(cast[ptr Sequence00](self.impl))

proc finalizerfree*(self: Sequence) =
  if not self.ignoreFinalizer:
    g_sequence_free(cast[ptr Sequence00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Sequence()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_sequence_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Sequence) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_sequence_get_length(self: ptr Sequence00): int32 {.
    importc, libprag.}

proc getLength*(self: Sequence): int =
  int(g_sequence_get_length(cast[ptr Sequence00](self.impl)))

proc length*(self: Sequence): int =
  int(g_sequence_get_length(cast[ptr Sequence00](self.impl)))

proc g_sequence_is_empty(self: ptr Sequence00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: Sequence): bool =
  toBool(g_sequence_is_empty(cast[ptr Sequence00](self.impl)))

type
  SequenceIter* {.pure, byRef.} = object

proc g_sequence_iter_compare(self: SequenceIter; b: SequenceIter): int32 {.
    importc, libprag.}

proc compare*(self: SequenceIter; b: SequenceIter): int =
  int(g_sequence_iter_compare(self, b))

proc g_sequence_iter_get_position(self: SequenceIter): int32 {.
    importc, libprag.}

proc getPosition*(self: SequenceIter): int =
  int(g_sequence_iter_get_position(self))

proc position*(self: SequenceIter): int =
  int(g_sequence_iter_get_position(self))

proc g_sequence_iter_get_sequence(self: SequenceIter): ptr Sequence00 {.
    importc, libprag.}

proc getSequence*(self: SequenceIter): Sequence =
  fnew(result, finalizerfree)
  result.impl = g_sequence_iter_get_sequence(self)
  result.ignoreFinalizer = true

proc sequence*(self: SequenceIter): Sequence =
  fnew(result, finalizerfree)
  result.impl = g_sequence_iter_get_sequence(self)
  result.ignoreFinalizer = true

proc g_sequence_iter_is_begin(self: SequenceIter): gboolean {.
    importc, libprag.}

proc isBegin*(self: SequenceIter): bool =
  toBool(g_sequence_iter_is_begin(self))

proc g_sequence_iter_is_end(self: SequenceIter): gboolean {.
    importc, libprag.}

proc isEnd*(self: SequenceIter): bool =
  toBool(g_sequence_iter_is_end(self))

proc g_sequence_iter_move(self: SequenceIter; delta: int32): ptr SequenceIter {.
    importc, libprag.}

proc move*(self: SequenceIter; delta: int): ptr SequenceIter =
  g_sequence_iter_move(self, int32(delta))

proc g_sequence_iter_next(self: SequenceIter): ptr SequenceIter {.
    importc, libprag.}

proc next*(self: SequenceIter): ptr SequenceIter =
  g_sequence_iter_next(self)

proc g_sequence_iter_prev(self: SequenceIter): ptr SequenceIter {.
    importc, libprag.}

proc prev*(self: SequenceIter): ptr SequenceIter =
  g_sequence_iter_prev(self)

proc g_sequence_append(self: ptr Sequence00; data: pointer): ptr SequenceIter {.
    importc, libprag.}

proc append*(self: Sequence; data: pointer): ptr SequenceIter =
  g_sequence_append(cast[ptr Sequence00](self.impl), data)

proc g_sequence_get_begin_iter(self: ptr Sequence00): ptr SequenceIter {.
    importc, libprag.}

proc getBeginIter*(self: Sequence): ptr SequenceIter =
  g_sequence_get_begin_iter(cast[ptr Sequence00](self.impl))

proc beginIter*(self: Sequence): ptr SequenceIter =
  g_sequence_get_begin_iter(cast[ptr Sequence00](self.impl))

proc g_sequence_get_end_iter(self: ptr Sequence00): ptr SequenceIter {.
    importc, libprag.}

proc getEndIter*(self: Sequence): ptr SequenceIter =
  g_sequence_get_end_iter(cast[ptr Sequence00](self.impl))

proc endIter*(self: Sequence): ptr SequenceIter =
  g_sequence_get_end_iter(cast[ptr Sequence00](self.impl))

proc g_sequence_get_iter_at_pos(self: ptr Sequence00; pos: int32): ptr SequenceIter {.
    importc, libprag.}

proc getIterAtPos*(self: Sequence; pos: int): ptr SequenceIter =
  g_sequence_get_iter_at_pos(cast[ptr Sequence00](self.impl), int32(pos))

proc g_sequence_prepend(self: ptr Sequence00; data: pointer): ptr SequenceIter {.
    importc, libprag.}

proc prepend*(self: Sequence; data: pointer): ptr SequenceIter =
  g_sequence_prepend(cast[ptr Sequence00](self.impl), data)

proc getSequence*(iter: SequenceIter): pointer {.
    importc: "g_sequence_get", libprag.}

proc insertBefore*(iter: SequenceIter; data: pointer): ptr SequenceIter {.
    importc: "g_sequence_insert_before", libprag.}

proc move*(src: SequenceIter; dest: SequenceIter) {.
    importc: "g_sequence_move", libprag.}

proc moveRange*(dest: SequenceIter; begin: SequenceIter; `end`: SequenceIter) {.
    importc: "g_sequence_move_range", libprag.}

proc rangeGetMidpoint*(begin: SequenceIter; `end`: SequenceIter): ptr SequenceIter {.
    importc: "g_sequence_range_get_midpoint", libprag.}

proc remove*(iter: SequenceIter) {.
    importc: "g_sequence_remove", libprag.}

proc removeRange*(begin: SequenceIter; `end`: SequenceIter) {.
    importc: "g_sequence_remove_range", libprag.}

proc set*(iter: SequenceIter; data: pointer) {.
    importc: "g_sequence_set", libprag.}

proc swap*(a: SequenceIter; b: SequenceIter) {.
    importc: "g_sequence_swap", libprag.}

type
  SequenceIterCompareFunc* = proc (a: SequenceIter; b: SequenceIter; data: pointer): int32 {.cdecl.}

type
  ShellError* {.size: sizeof(cint), pure.} = enum
    badQuoting = 0
    emptyString = 1
    failed = 2

type
  SliceConfig* {.size: sizeof(cint), pure.} = enum
    alwaysMalloc = 1
    bypassMagazines = 2
    workingSetMsecs = 3
    colorIncrement = 4
    chunkSizes = 5
    contentionCounter = 6

type
  SourceDisposeFunc* = proc (source: ptr Source00) {.cdecl.}

type
  SourceDummyMarshal* = proc () {.cdecl.}

type
  SourceFunc* = proc (userData: pointer): gboolean {.cdecl.}

proc g_main_context_invoke_full(self: ptr MainContext00; priority: int32;
    function: SourceFunc; data: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc invokeFull*(self: MainContext; priority: int; function: SourceFunc;
    data: pointer; notify: DestroyNotify) =
  g_main_context_invoke_full(cast[ptr MainContext00](self.impl), int32(priority), function, data, notify)

proc g_source_set_callback(self: ptr Source00; `func`: SourceFunc; data: pointer;
    notify: DestroyNotify) {.
    importc, libprag.}

proc setCallback*(self: Source; `func`: SourceFunc; data: pointer;
    notify: DestroyNotify) =
  g_source_set_callback(cast[ptr Source00](self.impl), `func`, data, notify)

type
  SpawnChildSetupFunc* = proc (userData: pointer) {.cdecl.}

type
  SpawnError* {.size: sizeof(cint), pure.} = enum
    fork = 0
    read = 1
    chdir = 2
    acces = 3
    perm = 4
    tooBig = 5
    noexec = 6
    nametoolong = 7
    noent = 8
    nomem = 9
    notdir = 10
    loop = 11
    txtbusy = 12
    io = 13
    nfile = 14
    mfile = 15
    inval = 16
    isdir = 17
    libbad = 18
    failed = 19

type
  SpawnFlag* {.size: sizeof(cint), pure.} = enum
    leaveDescriptorsOpen = 0
    doNotReapChild = 1
    searchPath = 2
    stdoutToDevNull = 3
    stderrToDevNull = 4
    childInheritsStdin = 5
    fileAndArgvZero = 6
    searchPathFromEnvp = 7
    cloexecPipes = 8

  SpawnFlags* {.size: sizeof(cint).} = set[SpawnFlag]

const
  SpawnFlagsDefault* = SpawnFlags({})
proc default*(t: typedesc[SpawnFlags]): SpawnFlags = SpawnFlags({})

type
  StatBuf* {.pure, byRef.} = object

type
  StringChunk00* {.pure.} = object
  StringChunk* = ref object
    impl*: ptr StringChunk00
    ignoreFinalizer*: bool

proc g_string_chunk_free(self: ptr StringChunk00) {.
    importc, libprag.}

proc free*(self: StringChunk) =
  g_string_chunk_free(cast[ptr StringChunk00](self.impl))

proc finalizerfree*(self: StringChunk) =
  if not self.ignoreFinalizer:
    g_string_chunk_free(cast[ptr StringChunk00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StringChunk()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_string_chunk_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var StringChunk) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_string_chunk_clear(self: ptr StringChunk00) {.
    importc, libprag.}

proc clear*(self: StringChunk) =
  g_string_chunk_clear(cast[ptr StringChunk00](self.impl))

proc g_string_chunk_insert(self: ptr StringChunk00; string: cstring): cstring {.
    importc, libprag.}

proc insert*(self: StringChunk; string: cstring): string =
  let resul0 = g_string_chunk_insert(cast[ptr StringChunk00](self.impl), string)
  result = $resul0
  cogfree(resul0)

proc g_string_chunk_insert_const(self: ptr StringChunk00; string: cstring): cstring {.
    importc, libprag.}

proc insertConst*(self: StringChunk; string: cstring): string =
  let resul0 = g_string_chunk_insert_const(cast[ptr StringChunk00](self.impl), string)
  result = $resul0
  cogfree(resul0)

proc g_string_chunk_insert_len(self: ptr StringChunk00; string: cstring;
    len: int64): cstring {.
    importc, libprag.}

proc insertLen*(self: StringChunk; string: cstring; len: int64): string =
  let resul0 = g_string_chunk_insert_len(cast[ptr StringChunk00](self.impl), string, len)
  result = $resul0
  cogfree(resul0)

const TEST_OPTION_ISOLATE_DIRS* = "isolate_dirs"

const TIME_SPAN_DAY* = 86400000000'i64

const TIME_SPAN_HOUR* = 3600000000'i64

const TIME_SPAN_MILLISECOND* = 1000'i64

const TIME_SPAN_MINUTE* = 60000000'i64

const TIME_SPAN_SECOND* = 1000000'i64

type
  TestCase00* {.pure.} = object
  TestCase* = ref object
    impl*: ptr TestCase00
    ignoreFinalizer*: bool

type
  TestConfig00* {.pure.} = object
  TestConfig* = ref object
    impl*: ptr TestConfig00
    ignoreFinalizer*: bool

type
  TestDataFunc* = proc (userData: pointer) {.cdecl.}

type
  TestFileType* {.size: sizeof(cint), pure.} = enum
    dist = 0
    built = 1

type
  TestFixtureFunc* = proc (fixture: pointer; userData: pointer) {.cdecl.}

type
  TestFunc* = proc () {.cdecl.}

type
  TestLogBuffer00* {.pure.} = object
  TestLogBuffer* = ref object
    impl*: ptr TestLogBuffer00
    ignoreFinalizer*: bool

proc g_test_log_buffer_free(self: ptr TestLogBuffer00) {.
    importc, libprag.}

proc free*(self: TestLogBuffer) =
  g_test_log_buffer_free(cast[ptr TestLogBuffer00](self.impl))

proc finalizerfree*(self: TestLogBuffer) =
  if not self.ignoreFinalizer:
    g_test_log_buffer_free(cast[ptr TestLogBuffer00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TestLogBuffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_test_log_buffer_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var TestLogBuffer) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_test_log_buffer_push(self: ptr TestLogBuffer00; nBytes: uint32; bytes: ptr uint8) {.
    importc, libprag.}

proc push*(self: TestLogBuffer; nBytes: int; bytes: ptr uint8) =
  g_test_log_buffer_push(cast[ptr TestLogBuffer00](self.impl), uint32(nBytes), bytes)

type
  TestLogFatalFunc* = proc (logDomain: cstring; logLevel: LogLevelFlags; message: cstring; userData: pointer): gboolean {.cdecl.}

type
  TestLogMsg00* {.pure.} = object
  TestLogMsg* = ref object
    impl*: ptr TestLogMsg00
    ignoreFinalizer*: bool

proc g_test_log_msg_free(self: ptr TestLogMsg00) {.
    importc, libprag.}

proc free*(self: TestLogMsg) =
  g_test_log_msg_free(cast[ptr TestLogMsg00](self.impl))

proc finalizerfree*(self: TestLogMsg) =
  if not self.ignoreFinalizer:
    g_test_log_msg_free(cast[ptr TestLogMsg00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TestLogMsg()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_test_log_msg_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var TestLogMsg) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

type
  TestLogType* {.size: sizeof(cint), pure.} = enum
    none = 0
    error = 1
    startBinary = 2
    listCase = 3
    skipCase = 4
    startCase = 5
    stopCase = 6
    minResult = 7
    maxResult = 8
    message = 9
    startSuite = 10
    stopSuite = 11

type
  TestResult* {.size: sizeof(cint), pure.} = enum
    success = 0
    skipped = 1
    failure = 2
    incomplete = 3

type
  TestSubprocessFlag* {.size: sizeof(cint), pure.} = enum
    stdin = 0
    stdout = 1
    stderr = 2

  TestSubprocessFlags* {.size: sizeof(cint).} = set[TestSubprocessFlag]

type
  TestSuite00* {.pure.} = object
  TestSuite* = ref object
    impl*: ptr TestSuite00
    ignoreFinalizer*: bool

proc g_test_suite_add(self: ptr TestSuite00; testCase: ptr TestCase00) {.
    importc, libprag.}

proc add*(self: TestSuite; testCase: TestCase) =
  g_test_suite_add(cast[ptr TestSuite00](self.impl), cast[ptr TestCase00](testCase.impl))

proc g_test_suite_add_suite(self: ptr TestSuite00; nestedsuite: ptr TestSuite00) {.
    importc, libprag.}

proc addSuite*(self: TestSuite; nestedsuite: TestSuite) =
  g_test_suite_add_suite(cast[ptr TestSuite00](self.impl), cast[ptr TestSuite00](nestedsuite.impl))

type
  TestTrapFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    silenceStdout = 7
    silenceStderr = 8
    inheritStdin = 9

  TestTrapFlags* {.size: sizeof(cint).} = set[TestTrapFlag]

type
  Thread00* {.pure.} = object
  Thread* = ref object
    impl*: ptr Thread00
    ignoreFinalizer*: bool

proc g_thread_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGThread*(self: Thread) =
  if not self.ignoreFinalizer:
    boxedFree(g_thread_get_type(), cast[ptr Thread00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Thread()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_thread_get_type(), cast[ptr Thread00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Thread) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGThread)

proc g_thread_unref(self: ptr Thread00) {.
    importc, libprag.}

proc unref*(self: Thread) =
  g_thread_unref(cast[ptr Thread00](g_boxed_copy(g_thread_get_type(), self.impl)))

proc finalizerunref*(self: Thread) =
  if not self.ignoreFinalizer:
    g_thread_unref(cast[ptr Thread00](self.impl))

proc g_thread_join(self: ptr Thread00): pointer {.
    importc, libprag.}

proc join*(self: Thread): pointer =
  g_thread_join(cast[ptr Thread00](g_boxed_copy(g_thread_get_type(), self.impl)))

proc g_thread_ref(self: ptr Thread00): ptr Thread00 {.
    importc, libprag.}

proc `ref`*(self: Thread): Thread =
  fnew(result, gBoxedFreeGThread)
  result.impl = g_thread_ref(cast[ptr Thread00](self.impl))

proc exit*(retval: pointer) {.
    importc: "g_thread_exit", libprag.}

proc g_thread_self(): ptr Thread00 {.
    importc, libprag.}

proc self*(): Thread =
  fnew(result, gBoxedFreeGThread)
  result.impl = g_thread_self()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_thread_get_type(), result.impl))

proc `yield`*() {.
    importc: "g_thread_yield", libprag.}

type
  ThreadError* {.size: sizeof(cint), pure.} = enum
    threadErrorAgain = 0

type
  ThreadFunc* = proc (data: pointer): pointer {.cdecl.}

proc g_thread_try_new(name: cstring; `func`: ThreadFunc; data: pointer; error: ptr ptr glib.Error = nil): ptr Thread00 {.
    importc, libprag.}

proc tryNew*(name: cstring = nil; `func`: ThreadFunc; data: pointer): Thread =
  var gerror: ptr glib.Error
  let impl0 = g_thread_try_new(name, `func`, data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGThread)
  result.impl = impl0

proc tryNew*(tdesc: typedesc; name: cstring = nil; `func`: ThreadFunc; data: pointer): tdesc =
  var gerror: ptr glib.Error
  assert(result is Thread)
  let impl0 = g_thread_try_new(name, `func`, data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGThread)
  result.impl = impl0

proc tryNew*[T](result: var T; name: cstring = nil; `func`: ThreadFunc; data: pointer) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Thread)
  let impl0 = g_thread_try_new(name, `func`, data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGThread)
  result.impl = impl0

proc g_thread_new(name: cstring; `func`: ThreadFunc; data: pointer): ptr Thread00 {.
    importc, libprag.}

proc newThread*(name: cstring = nil; `func`: ThreadFunc; data: pointer): Thread =
  fnew(result, gBoxedFreeGThread)
  result.impl = g_thread_new(name, `func`, data)

proc newThread*(tdesc: typedesc; name: cstring = nil; `func`: ThreadFunc; data: pointer): tdesc =
  assert(result is Thread)
  fnew(result, gBoxedFreeGThread)
  result.impl = g_thread_new(name, `func`, data)

proc initThread*[T](result: var T; name: cstring = nil; `func`: ThreadFunc; data: pointer) {.deprecated.} =
  assert(result is Thread)
  fnew(result, gBoxedFreeGThread)
  result.impl = g_thread_new(name, `func`, data)

type
  ThreadPool00* {.pure.} = object
  ThreadPool* = ref object
    impl*: ptr ThreadPool00
    ignoreFinalizer*: bool

proc g_thread_pool_free(self: ptr ThreadPool00; immediate: gboolean; wait: gboolean) {.
    importc, libprag.}

proc free*(self: ThreadPool; immediate: bool; wait: bool) =
  g_thread_pool_free(cast[ptr ThreadPool00](self.impl), gboolean(immediate), gboolean(wait))

proc g_thread_pool_get_max_threads(self: ptr ThreadPool00): int32 {.
    importc, libprag.}

proc getMaxThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_max_threads(cast[ptr ThreadPool00](self.impl)))

proc maxThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_max_threads(cast[ptr ThreadPool00](self.impl)))

proc g_thread_pool_get_num_threads(self: ptr ThreadPool00): uint32 {.
    importc, libprag.}

proc getNumThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_num_threads(cast[ptr ThreadPool00](self.impl)))

proc numThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_num_threads(cast[ptr ThreadPool00](self.impl)))

proc g_thread_pool_move_to_front(self: ptr ThreadPool00; data: pointer): gboolean {.
    importc, libprag.}

proc moveToFront*(self: ThreadPool; data: pointer): bool =
  toBool(g_thread_pool_move_to_front(cast[ptr ThreadPool00](self.impl), data))

proc g_thread_pool_push(self: ptr ThreadPool00; data: pointer; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc push*(self: ThreadPool; data: pointer): bool =
  var gerror: ptr glib.Error
  let resul0 = g_thread_pool_push(cast[ptr ThreadPool00](self.impl), data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_thread_pool_set_max_threads(self: ptr ThreadPool00; maxThreads: int32;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setMaxThreads*(self: ThreadPool; maxThreads: int): bool =
  var gerror: ptr glib.Error
  let resul0 = g_thread_pool_set_max_threads(cast[ptr ThreadPool00](self.impl), int32(maxThreads), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_thread_pool_unprocessed(self: ptr ThreadPool00): uint32 {.
    importc, libprag.}

proc unprocessed*(self: ThreadPool): int =
  int(g_thread_pool_unprocessed(cast[ptr ThreadPool00](self.impl)))

proc g_thread_pool_get_max_idle_time(): uint32 {.
    importc, libprag.}

proc getMaxIdleTime*(): int =
  int(g_thread_pool_get_max_idle_time())

proc g_thread_pool_get_max_unused_threads(): int32 {.
    importc, libprag.}

proc getMaxUnusedThreads*(): int =
  int(g_thread_pool_get_max_unused_threads())

proc g_thread_pool_get_num_unused_threads(): uint32 {.
    importc, libprag.}

proc getNumUnusedThreads*(): int =
  int(g_thread_pool_get_num_unused_threads())

proc g_thread_pool_set_max_idle_time(interval: uint32) {.
    importc, libprag.}

proc setMaxIdleTime*(interval: int) =
  g_thread_pool_set_max_idle_time(uint32(interval))

proc g_thread_pool_set_max_unused_threads(maxThreads: int32) {.
    importc, libprag.}

proc setMaxUnusedThreads*(maxThreads: int) =
  g_thread_pool_set_max_unused_threads(int32(maxThreads))

proc stopUnusedThreads*() {.
    importc: "g_thread_pool_stop_unused_threads", libprag.}

type
  Timer00* {.pure.} = object
  Timer* = ref object
    impl*: ptr Timer00
    ignoreFinalizer*: bool

proc g_timer_destroy(self: ptr Timer00) {.
    importc, libprag.}

proc destroy*(self: Timer) =
  g_timer_destroy(cast[ptr Timer00](self.impl))

proc finalizerdestroy*(self: Timer) =
  if not self.ignoreFinalizer:
    g_timer_destroy(cast[ptr Timer00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Timer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_timer_destroy(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Timer) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerdestroy)

proc g_timer_continue(self: ptr Timer00) {.
    importc, libprag.}

proc `continue`*(self: Timer) =
  g_timer_continue(cast[ptr Timer00](self.impl))

proc g_timer_elapsed(self: ptr Timer00; microseconds: ptr uint64): cdouble {.
    importc, libprag.}

proc elapsed*(self: Timer; microseconds: ptr uint64): cdouble =
  g_timer_elapsed(cast[ptr Timer00](self.impl), microseconds)

proc g_timer_is_active(self: ptr Timer00): gboolean {.
    importc, libprag.}

proc isActive*(self: Timer): bool =
  toBool(g_timer_is_active(cast[ptr Timer00](self.impl)))

proc g_timer_reset(self: ptr Timer00) {.
    importc, libprag.}

proc reset*(self: Timer) =
  g_timer_reset(cast[ptr Timer00](self.impl))

proc g_timer_start(self: ptr Timer00) {.
    importc, libprag.}

proc start*(self: Timer) =
  g_timer_start(cast[ptr Timer00](self.impl))

proc g_timer_stop(self: ptr Timer00) {.
    importc, libprag.}

proc stop*(self: Timer) =
  g_timer_stop(cast[ptr Timer00](self.impl))

type
  TokenValue00* {.pure, union.} = object
  TokenValue* = ref object
    impl*: ptr TokenValue00
    ignoreFinalizer*: bool

type
  TranslateFunc* = proc (str: cstring; data: pointer): cstring {.cdecl.}

proc g_option_context_set_translate_func(self: ptr OptionContext00; `func`: TranslateFunc;
    data: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc setTranslateFunc*(self: OptionContext; `func`: TranslateFunc;
    data: pointer; destroyNotify: DestroyNotify) =
  g_option_context_set_translate_func(cast[ptr OptionContext00](self.impl), `func`, data, destroyNotify)

proc g_option_group_set_translate_func(self: ptr OptionGroup00; `func`: TranslateFunc;
    data: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc setTranslateFunc*(self: OptionGroup; `func`: TranslateFunc;
    data: pointer; destroyNotify: DestroyNotify) =
  g_option_group_set_translate_func(cast[ptr OptionGroup00](self.impl), `func`, data, destroyNotify)

type
  TrashStack00* {.pure.} = object
  TrashStack* = ref object
    impl*: ptr TrashStack00
    ignoreFinalizer*: bool

proc g_trash_stack_height(stackP: ptr TrashStack00): uint32 {.
    importc, libprag.}

proc height*(stackP: TrashStack): int =
  int(g_trash_stack_height(cast[ptr TrashStack00](stackP.impl)))

proc g_trash_stack_peek(stackP: ptr TrashStack00): pointer {.
    importc, libprag.}

proc peek*(stackP: TrashStack): pointer =
  g_trash_stack_peek(cast[ptr TrashStack00](stackP.impl))

proc g_trash_stack_pop(stackP: ptr TrashStack00): pointer {.
    importc, libprag.}

proc pop*(stackP: TrashStack): pointer =
  g_trash_stack_pop(cast[ptr TrashStack00](stackP.impl))

proc g_trash_stack_push(stackP: ptr TrashStack00; dataP: pointer) {.
    importc, libprag.}

proc push*(stackP: TrashStack; dataP: pointer) =
  g_trash_stack_push(cast[ptr TrashStack00](stackP.impl), dataP)

type
  TraverseFunc* = proc (key: pointer; value: pointer; data: pointer): gboolean {.cdecl.}

type
  TraverseType* {.size: sizeof(cint), pure.} = enum
    inOrder = 0
    preOrder = 1
    postOrder = 2
    levelOrder = 3

type
  Tree00* {.pure.} = object
  Tree* = ref object
    impl*: ptr Tree00
    ignoreFinalizer*: bool

proc g_tree_unref(self: ptr Tree00) {.
    importc, libprag.}

proc unref*(self: Tree) =
  g_tree_unref(cast[ptr Tree00](self.impl))

proc finalizerunref*(self: Tree) =
  if not self.ignoreFinalizer:
    g_tree_unref(cast[ptr Tree00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Tree()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_tree_unref(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Tree) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerunref)

proc g_tree_height(self: ptr Tree00): int32 {.
    importc, libprag.}

proc height*(self: Tree): int =
  int(g_tree_height(cast[ptr Tree00](self.impl)))

proc g_tree_insert(self: ptr Tree00; key: pointer; value: pointer) {.
    importc, libprag.}

proc insert*(self: Tree; key: pointer; value: pointer) =
  g_tree_insert(cast[ptr Tree00](self.impl), key, value)

proc g_tree_lookup(self: ptr Tree00; key: pointer): pointer {.
    importc, libprag.}

proc lookup*(self: Tree; key: pointer): pointer =
  g_tree_lookup(cast[ptr Tree00](self.impl), key)

proc g_tree_lookup_extended(self: ptr Tree00; lookupKey: pointer; origKey: var pointer;
    value: var pointer): gboolean {.
    importc, libprag.}

proc lookupExtended*(self: Tree; lookupKey: pointer; origKey: var pointer = cast[var pointer](nil);
    value: var pointer = cast[var pointer](nil)): bool =
  toBool(g_tree_lookup_extended(cast[ptr Tree00](self.impl), lookupKey, origKey, value))

proc g_tree_nnodes(self: ptr Tree00): int32 {.
    importc, libprag.}

proc nnodes*(self: Tree): int =
  int(g_tree_nnodes(cast[ptr Tree00](self.impl)))

proc g_tree_remove(self: ptr Tree00; key: pointer): gboolean {.
    importc, libprag.}

proc remove*(self: Tree; key: pointer): bool =
  toBool(g_tree_remove(cast[ptr Tree00](self.impl), key))

proc g_tree_replace(self: ptr Tree00; key: pointer; value: pointer) {.
    importc, libprag.}

proc replace*(self: Tree; key: pointer; value: pointer) =
  g_tree_replace(cast[ptr Tree00](self.impl), key, value)

proc g_tree_steal(self: ptr Tree00; key: pointer): gboolean {.
    importc, libprag.}

proc steal*(self: Tree; key: pointer): bool =
  toBool(g_tree_steal(cast[ptr Tree00](self.impl), key))

proc g_tree_destroy(self: ptr Tree00) {.
    importc, libprag.}

proc destroy*(self: Tree) =
  g_tree_destroy(cast[ptr Tree00](self.impl))

proc finalizerdestroy*(self: Tree) =
  if not self.ignoreFinalizer:
    g_tree_destroy(cast[ptr Tree00](self.impl))

const UNICHAR_MAX_DECOMPOSITION_LENGTH* = 18'i32

const URI_RESERVED_CHARS_GENERIC_DELIMITERS* = ":/?#[]@"

const URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS* = "!$&'()*+,;="

const USEC_PER_SEC* = 1000000'i32

type
  UnicodeBreakType* {.size: sizeof(cint), pure.} = enum
    mandatory = 0
    carriageReturn = 1
    lineFeed = 2
    combiningMark = 3
    surrogate = 4
    zeroWidthSpace = 5
    inseparable = 6
    nonBreakingGlue = 7
    contingent = 8
    space = 9
    after = 10
    before = 11
    beforeAndAfter = 12
    hyphen = 13
    nonStarter = 14
    openPunctuation = 15
    closePunctuation = 16
    quotation = 17
    exclamation = 18
    ideographic = 19
    numeric = 20
    infixSeparator = 21
    symbol = 22
    alphabetic = 23
    prefix = 24
    postfix = 25
    complexContext = 26
    ambiguous = 27
    unknown = 28
    nextLine = 29
    wordJoiner = 30
    hangulLJamo = 31
    hangulVJamo = 32
    hangulTJamo = 33
    hangulLvSyllable = 34
    hangulLvtSyllable = 35
    closeParanthesis = 36
    conditionalJapaneseStarter = 37
    hebrewLetter = 38
    regionalIndicator = 39
    emojiBase = 40
    emojiModifier = 41
    zeroWidthJoiner = 42

type
  UnicodeScript* {.size: sizeof(cint), pure.} = enum
    invalidCode = -1
    common = 0
    inherited = 1
    arabic = 2
    armenian = 3
    bengali = 4
    bopomofo = 5
    cherokee = 6
    coptic = 7
    cyrillic = 8
    deseret = 9
    devanagari = 10
    ethiopic = 11
    georgian = 12
    gothic = 13
    greek = 14
    gujarati = 15
    gurmukhi = 16
    han = 17
    hangul = 18
    hebrew = 19
    hiragana = 20
    kannada = 21
    katakana = 22
    khmer = 23
    lao = 24
    latin = 25
    malayalam = 26
    mongolian = 27
    myanmar = 28
    ogham = 29
    oldItalic = 30
    oriya = 31
    runic = 32
    sinhala = 33
    syriac = 34
    tamil = 35
    telugu = 36
    thaana = 37
    thai = 38
    tibetan = 39
    canadianAboriginal = 40
    yi = 41
    tagalog = 42
    hanunoo = 43
    buhid = 44
    tagbanwa = 45
    braille = 46
    cypriot = 47
    limbu = 48
    osmanya = 49
    shavian = 50
    linearB = 51
    taiLe = 52
    ugaritic = 53
    newTaiLue = 54
    buginese = 55
    glagolitic = 56
    tifinagh = 57
    sylotiNagri = 58
    oldPersian = 59
    kharoshthi = 60
    unknown = 61
    balinese = 62
    cuneiform = 63
    phoenician = 64
    phagsPa = 65
    nko = 66
    kayahLi = 67
    lepcha = 68
    rejang = 69
    sundanese = 70
    saurashtra = 71
    cham = 72
    olChiki = 73
    vai = 74
    carian = 75
    lycian = 76
    lydian = 77
    avestan = 78
    bamum = 79
    egyptianHieroglyphs = 80
    imperialAramaic = 81
    inscriptionalPahlavi = 82
    inscriptionalParthian = 83
    javanese = 84
    kaithi = 85
    lisu = 86
    meeteiMayek = 87
    oldSouthArabian = 88
    oldTurkic = 89
    samaritan = 90
    taiTham = 91
    taiViet = 92
    batak = 93
    brahmi = 94
    mandaic = 95
    chakma = 96
    meroiticCursive = 97
    meroiticHieroglyphs = 98
    miao = 99
    sharada = 100
    soraSompeng = 101
    takri = 102
    bassaVah = 103
    caucasianAlbanian = 104
    duployan = 105
    elbasan = 106
    grantha = 107
    khojki = 108
    khudawadi = 109
    linearA = 110
    mahajani = 111
    manichaean = 112
    mendeKikakui = 113
    modi = 114
    mro = 115
    nabataean = 116
    oldNorthArabian = 117
    oldPermic = 118
    pahawhHmong = 119
    palmyrene = 120
    pauCinHau = 121
    psalterPahlavi = 122
    siddham = 123
    tirhuta = 124
    warangCiti = 125
    ahom = 126
    anatolianHieroglyphs = 127
    hatran = 128
    multani = 129
    oldHungarian = 130
    signwriting = 131
    adlam = 132
    bhaiksuki = 133
    marchen = 134
    newa = 135
    osage = 136
    tangut = 137
    masaramGondi = 138
    nushu = 139
    soyombo = 140
    zanabazarSquare = 141
    dogra = 142
    gunjalaGondi = 143
    hanifiRohingya = 144
    makasar = 145
    medefaidrin = 146
    oldSogdian = 147
    sogdian = 148
    elymaic = 149
    nandinagari = 150
    nyiakengPuachueHmong = 151
    wancho = 152
    chorasmian = 153
    divesAkuru = 154
    khitanSmallScript = 155
    yezidi = 156

type
  UnicodeType* {.size: sizeof(cint), pure.} = enum
    control = 0
    format = 1
    unassigned = 2
    privateUse = 3
    surrogate = 4
    lowercaseLetter = 5
    modifierLetter = 6
    otherLetter = 7
    titlecaseLetter = 8
    uppercaseLetter = 9
    spacingMark = 10
    enclosingMark = 11
    nonSpacingMark = 12
    decimalNumber = 13
    letterNumber = 14
    otherNumber = 15
    connectPunctuation = 16
    dashPunctuation = 17
    closePunctuation = 18
    finalPunctuation = 19
    initialPunctuation = 20
    otherPunctuation = 21
    openPunctuation = 22
    currencySymbol = 23
    modifierSymbol = 24
    mathSymbol = 25
    otherSymbol = 26
    lineSeparator = 27
    paragraphSeparator = 28
    spaceSeparator = 29

type
  UnixFDSourceFunc* = proc (fd: int32; condition: IOCondition; userData: pointer): gboolean {.cdecl.}

type
  Uri00* {.pure.} = object
  Uri* = ref object
    impl*: ptr Uri00
    ignoreFinalizer*: bool

proc g_uri_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGUri*(self: Uri) =
  if not self.ignoreFinalizer:
    boxedFree(g_uri_get_type(), cast[ptr Uri00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Uri()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_uri_get_type(), cast[ptr Uri00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Uri) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGUri)

proc g_uri_get_auth_params(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getAuthParams*(self: Uri): string =
  let resul0 = g_uri_get_auth_params(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc authParams*(self: Uri): string =
  let resul0 = g_uri_get_auth_params(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc g_uri_get_fragment(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getFragment*(self: Uri): string =
  let resul0 = g_uri_get_fragment(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc fragment*(self: Uri): string =
  let resul0 = g_uri_get_fragment(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc g_uri_get_host(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getHost*(self: Uri): string =
  result = $g_uri_get_host(cast[ptr Uri00](self.impl))

proc host*(self: Uri): string =
  result = $g_uri_get_host(cast[ptr Uri00](self.impl))

proc g_uri_get_password(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getPassword*(self: Uri): string =
  let resul0 = g_uri_get_password(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc password*(self: Uri): string =
  let resul0 = g_uri_get_password(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc g_uri_get_path(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getPath*(self: Uri): string =
  result = $g_uri_get_path(cast[ptr Uri00](self.impl))

proc path*(self: Uri): string =
  result = $g_uri_get_path(cast[ptr Uri00](self.impl))

proc g_uri_get_port(self: ptr Uri00): int32 {.
    importc, libprag.}

proc getPort*(self: Uri): int =
  int(g_uri_get_port(cast[ptr Uri00](self.impl)))

proc port*(self: Uri): int =
  int(g_uri_get_port(cast[ptr Uri00](self.impl)))

proc g_uri_get_query(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getQuery*(self: Uri): string =
  let resul0 = g_uri_get_query(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc query*(self: Uri): string =
  let resul0 = g_uri_get_query(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc g_uri_get_scheme(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getScheme*(self: Uri): string =
  result = $g_uri_get_scheme(cast[ptr Uri00](self.impl))

proc scheme*(self: Uri): string =
  result = $g_uri_get_scheme(cast[ptr Uri00](self.impl))

proc g_uri_get_user(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getUser*(self: Uri): string =
  let resul0 = g_uri_get_user(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc user*(self: Uri): string =
  let resul0 = g_uri_get_user(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc g_uri_get_userinfo(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getUserinfo*(self: Uri): string =
  let resul0 = g_uri_get_userinfo(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc userinfo*(self: Uri): string =
  let resul0 = g_uri_get_userinfo(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc g_uri_to_string(self: ptr Uri00): cstring {.
    importc, libprag.}

proc toString*(self: Uri): string =
  let resul0 = g_uri_to_string(cast[ptr Uri00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_uri_escape_bytes(unescaped: ptr uint8; length: uint64; reservedCharsAllowed: cstring): cstring {.
    importc, libprag.}

proc escapeBytes*(unescaped: seq[uint8] | string; reservedCharsAllowed: cstring = nil): string =
  let length = uint64(unescaped.len)
  let resul0 = g_uri_escape_bytes(cast[ptr uint8](unsafeaddr(unescaped[0])), length, reservedCharsAllowed)
  result = $resul0
  cogfree(resul0)

proc g_uri_escape_string(unescaped: cstring; reservedCharsAllowed: cstring;
    allowUtf8: gboolean): cstring {.
    importc, libprag.}

proc escapeString*(unescaped: cstring; reservedCharsAllowed: cstring = nil;
    allowUtf8: bool): string =
  let resul0 = g_uri_escape_string(unescaped, reservedCharsAllowed, gboolean(allowUtf8))
  result = $resul0
  cogfree(resul0)

proc g_uri_list_extract_uris(uriList: cstring): ptr cstring {.
    importc, libprag.}

proc listExtractUris*(uriList: cstring): seq[string] =
  let resul0 = g_uri_list_extract_uris(uriList)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_uri_parse_scheme(uri: cstring): cstring {.
    importc, libprag.}

proc parseScheme*(uri: cstring): string =
  let resul0 = g_uri_parse_scheme(uri)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_uri_peek_scheme(uri: cstring): cstring {.
    importc, libprag.}

proc peekScheme*(uri: cstring): string =
  let resul0 = g_uri_peek_scheme(uri)
  if resul0.isNil:
    return
  result = $resul0

proc g_uri_unescape_bytes(escapedString: cstring; length: int64; illegalCharacters: cstring;
    error: ptr ptr glib.Error = nil): ptr Bytes00 {.
    importc, libprag.}

proc unescapeBytes*(escapedString: cstring; length: int64; illegalCharacters: cstring = nil): Bytes =
  var gerror: ptr glib.Error
  let impl0 = g_uri_unescape_bytes(escapedString, length, illegalCharacters, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc g_uri_unescape_segment(escapedString: cstring; escapedStringEnd: cstring;
    illegalCharacters: cstring): cstring {.
    importc, libprag.}

proc unescapeSegment*(escapedString: cstring = nil; escapedStringEnd: cstring = nil;
    illegalCharacters: cstring = nil): string =
  let resul0 = g_uri_unescape_segment(escapedString, escapedStringEnd, illegalCharacters)
  result = $resul0
  cogfree(resul0)

proc g_uri_unescape_string(escapedString: cstring; illegalCharacters: cstring): cstring {.
    importc, libprag.}

proc unescapeString*(escapedString: cstring; illegalCharacters: cstring = nil): string =
  let resul0 = g_uri_unescape_string(escapedString, illegalCharacters)
  result = $resul0
  cogfree(resul0)

type
  UriHideFlag* {.size: sizeof(cint), pure.} = enum
    userinfo = 0
    password = 1
    authParams = 2
    query = 3
    fragment = 4

  UriHideFlags* {.size: sizeof(cint).} = set[UriHideFlag]

const
  UriHideFlagsNone* = UriHideFlags({})
proc none*(t: typedesc[UriHideFlags]): UriHideFlags = UriHideFlags({})

proc g_uri_to_string_partial(self: ptr Uri00; flags: UriHideFlags): cstring {.
    importc, libprag.}

proc toStringPartial*(self: Uri; flags: UriHideFlags): string =
  let resul0 = g_uri_to_string_partial(cast[ptr Uri00](self.impl), flags)
  result = $resul0
  cogfree(resul0)

type
  UriParamsFlag* {.size: sizeof(cint), pure.} = enum
    caseInsensitive = 0
    wwwForm = 1
    parseRelaxed = 2

  UriParamsFlags* {.size: sizeof(cint).} = set[UriParamsFlag]

const
  UriParamsFlagsNone* = UriParamsFlags({})
proc none*(t: typedesc[UriParamsFlags]): UriParamsFlags = UriParamsFlags({})

proc parseParams*(params: cstring; length: int64; separators: cstring;
    flags: UriParamsFlags; error: ptr ptr glib.Error = nil): ptr HashTable00 {.
    importc: "g_uri_parse_params", libprag.}

type
  UriFlag* {.size: sizeof(cint), pure.} = enum
    parseRelaxed = 0
    hasPassword = 1
    hasAuthParams = 2
    encoded = 3
    nonDns = 4
    encodedQuery = 5
    encodedPath = 6
    encodedFragment = 7

  UriFlags* {.size: sizeof(cint).} = set[UriFlag]

const
  UriFlagsNone* = UriFlags({})
proc none*(t: typedesc[UriFlags]): UriFlags = UriFlags({})

proc g_uri_get_flags(self: ptr Uri00): UriFlags {.
    importc, libprag.}

proc getFlags*(self: Uri): UriFlags =
  g_uri_get_flags(cast[ptr Uri00](self.impl))

proc flags*(self: Uri): UriFlags =
  g_uri_get_flags(cast[ptr Uri00](self.impl))

proc g_uri_parse_relative(self: ptr Uri00; uriRef: cstring; flags: UriFlags;
    error: ptr ptr glib.Error = nil): ptr Uri00 {.
    importc, libprag.}

proc parseRelative*(self: Uri; uriRef: cstring; flags: UriFlags): Uri =
  var gerror: ptr glib.Error
  let impl0 = g_uri_parse_relative(cast[ptr Uri00](self.impl), uriRef, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGUri)
  result.impl = impl0

proc g_uri_build(flags: UriFlags; scheme: cstring; userinfo: cstring; host: cstring;
    port: int32; path: cstring; query: cstring; fragment: cstring): ptr Uri00 {.
    importc, libprag.}

proc build*(flags: UriFlags; scheme: cstring; userinfo: cstring = nil;
    host: cstring = nil; port: int; path: cstring; query: cstring = nil; fragment: cstring = nil): Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = g_uri_build(flags, scheme, userinfo, host, int32(port), path, query, fragment)

proc g_uri_build_with_user(flags: UriFlags; scheme: cstring; user: cstring;
    password: cstring; authParams: cstring; host: cstring; port: int32; path: cstring;
    query: cstring; fragment: cstring): ptr Uri00 {.
    importc, libprag.}

proc buildWithUser*(flags: UriFlags; scheme: cstring; user: cstring = nil;
    password: cstring = nil; authParams: cstring = nil; host: cstring = nil;
    port: int; path: cstring; query: cstring = nil; fragment: cstring = nil): Uri =
  fnew(result, gBoxedFreeGUri)
  result.impl = g_uri_build_with_user(flags, scheme, user, password, authParams, host, int32(port), path, query, fragment)

proc g_uri_is_valid(uriString: cstring; flags: UriFlags; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc isValid*(uriString: cstring; flags: UriFlags): bool =
  var gerror: ptr glib.Error
  let resul0 = g_uri_is_valid(uriString, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_uri_join(flags: UriFlags; scheme: cstring; userinfo: cstring; host: cstring;
    port: int32; path: cstring; query: cstring; fragment: cstring): cstring {.
    importc, libprag.}

proc join*(flags: UriFlags; scheme: cstring = nil; userinfo: cstring = nil;
    host: cstring = nil; port: int; path: cstring; query: cstring = nil; fragment: cstring = nil): string =
  let resul0 = g_uri_join(flags, scheme, userinfo, host, int32(port), path, query, fragment)
  result = $resul0
  cogfree(resul0)

proc g_uri_join_with_user(flags: UriFlags; scheme: cstring; user: cstring;
    password: cstring; authParams: cstring; host: cstring; port: int32; path: cstring;
    query: cstring; fragment: cstring): cstring {.
    importc, libprag.}

proc joinWithUser*(flags: UriFlags; scheme: cstring = nil; user: cstring = nil;
    password: cstring = nil; authParams: cstring = nil; host: cstring = nil;
    port: int; path: cstring; query: cstring = nil; fragment: cstring = nil): string =
  let resul0 = g_uri_join_with_user(flags, scheme, user, password, authParams, host, int32(port), path, query, fragment)
  result = $resul0
  cogfree(resul0)

proc g_uri_parse(uriString: cstring; flags: UriFlags; error: ptr ptr glib.Error = nil): ptr Uri00 {.
    importc, libprag.}

proc parse*(uriString: cstring; flags: UriFlags): Uri =
  var gerror: ptr glib.Error
  let impl0 = g_uri_parse(uriString, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGUri)
  result.impl = impl0

proc g_uri_resolve_relative(baseUriString: cstring; uriRef: cstring; flags: UriFlags;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc resolveRelative*(baseUriString: cstring = nil; uriRef: cstring;
    flags: UriFlags): string =
  var gerror: ptr glib.Error
  let resul0 = g_uri_resolve_relative(baseUriString, uriRef, flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_uri_split(uriRef: cstring; flags: UriFlags; scheme: var cstring; userinfo: var cstring;
    host: var cstring; port: var int32; path: var cstring; query: var cstring;
    fragment: var cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc split*(uriRef: cstring; flags: UriFlags; scheme: var string = cast[var string](nil);
    userinfo: var string = cast[var string](nil); host: var string = cast[var string](nil);
    port: var int = cast[var int](nil); path: var string = cast[var string](nil);
    query: var string = cast[var string](nil); fragment: var string = cast[var string](nil)): bool =
  var gerror: ptr glib.Error
  var path_00: cstring
  var query_00: cstring
  var fragment_00: cstring
  var port_00: int32
  var userinfo_00: cstring
  var host_00: cstring
  var scheme_00: cstring
  let resul0 = g_uri_split(uriRef, flags, scheme_00, userinfo_00, host_00, port_00, path_00, query_00, fragment_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if path.addr != nil:
    path = $(path_00)
  if query.addr != nil:
    query = $(query_00)
  if fragment.addr != nil:
    fragment = $(fragment_00)
  if port.addr != nil:
    port = int(port_00)
  if userinfo.addr != nil:
    userinfo = $(userinfo_00)
  if host.addr != nil:
    host = $(host_00)
  if scheme.addr != nil:
    scheme = $(scheme_00)

proc g_uri_split_network(uriString: cstring; flags: UriFlags; scheme: var cstring;
    host: var cstring; port: var int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc splitNetwork*(uriString: cstring; flags: UriFlags; scheme: var string = cast[var string](nil);
    host: var string = cast[var string](nil); port: var int = cast[var int](nil)): bool =
  var gerror: ptr glib.Error
  var port_00: int32
  var host_00: cstring
  var scheme_00: cstring
  let resul0 = g_uri_split_network(uriString, flags, scheme_00, host_00, port_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if port.addr != nil:
    port = int(port_00)
  if host.addr != nil:
    host = $(host_00)
  if scheme.addr != nil:
    scheme = $(scheme_00)

proc g_uri_split_with_user(uriRef: cstring; flags: UriFlags; scheme: var cstring;
    user: var cstring; password: var cstring; authParams: var cstring; host: var cstring;
    port: var int32; path: var cstring; query: var cstring; fragment: var cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc splitWithUser*(uriRef: cstring; flags: UriFlags; scheme: var string = cast[var string](nil);
    user: var string = cast[var string](nil); password: var string = cast[var string](nil);
    authParams: var string = cast[var string](nil); host: var string = cast[var string](nil);
    port: var int = cast[var int](nil); path: var string = cast[var string](nil);
    query: var string = cast[var string](nil); fragment: var string = cast[var string](nil)): bool =
  var gerror: ptr glib.Error
  var path_00: cstring
  var query_00: cstring
  var user_00: cstring
  var fragment_00: cstring
  var authParams_00: cstring
  var password_00: cstring
  var port_00: int32
  var host_00: cstring
  var scheme_00: cstring
  let resul0 = g_uri_split_with_user(uriRef, flags, scheme_00, user_00, password_00, authParams_00, host_00, port_00, path_00, query_00, fragment_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if path.addr != nil:
    path = $(path_00)
  if query.addr != nil:
    query = $(query_00)
  if user.addr != nil:
    user = $(user_00)
  if fragment.addr != nil:
    fragment = $(fragment_00)
  if authParams.addr != nil:
    authParams = $(authParams_00)
  if password.addr != nil:
    password = $(password_00)
  if port.addr != nil:
    port = int(port_00)
  if host.addr != nil:
    host = $(host_00)
  if scheme.addr != nil:
    scheme = $(scheme_00)

type
  UriError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    badScheme = 1
    badUser = 2
    badPassword = 3
    badAuthParams = 4
    badHost = 5
    badPort = 6
    badPath = 7
    badQuery = 8
    badFragment = 9

type
  UriParamsIter00* {.pure.} = object
  UriParamsIter* = ref object
    impl*: ptr UriParamsIter00
    ignoreFinalizer*: bool

proc g_uri_params_iter_init(self: ptr UriParamsIter00; params: cstring; length: int64;
    separators: cstring; flags: UriParamsFlags) {.
    importc, libprag.}

proc init*(self: UriParamsIter; params: cstring; length: int64;
    separators: cstring; flags: UriParamsFlags) =
  g_uri_params_iter_init(cast[ptr UriParamsIter00](self.impl), params, length, separators, flags)

proc g_uri_params_iter_next(self: ptr UriParamsIter00; attribute: var cstring;
    value: var cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc next*(self: UriParamsIter; attribute: var string = cast[var string](nil);
    value: var string = cast[var string](nil)): bool =
  var gerror: ptr glib.Error
  var attribute_00: cstring
  var value_00: cstring
  let resul0 = g_uri_params_iter_next(cast[ptr UriParamsIter00](self.impl), attribute_00, value_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if attribute.addr != nil:
    attribute = $(attribute_00)
  if value.addr != nil:
    value = $(value_00)

type
  UserDirectory* {.size: sizeof(cint), pure.} = enum
    directoryDesktop = 0
    directoryDocuments = 1
    directoryDownload = 2
    directoryMusic = 3
    directoryPictures = 4
    directoryPublicShare = 5
    directoryTemplates = 6
    directoryVideos = 7
    nDirectories = 8

const VA_COPY_AS_ARRAY* = 1'i32

const VERSION_MIN_REQUIRED* = 2'i32

type
  Variant00* {.pure.} = object
  Variant* = ref object
    impl*: ptr Variant00
    ignoreFinalizer*: bool

proc g_variant_ref_sink(self: ptr Variant00): ptr Variant00 {.importc, libprag.}

proc g_variant_unref(self: ptr Variant00) {.
    importc, libprag.}

proc unref*(self: Variant) =
  g_variant_unref(cast[ptr Variant00](self.impl))

proc finalizerunref*(self: Variant) =
  if not self.ignoreFinalizer:
    g_variant_unref(cast[ptr Variant00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Variant()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_variant_unref(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Variant) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerunref)

proc g_variant_new_boolean(value: gboolean): ptr Variant00 {.
    importc, libprag.}

proc newVariantBoolean*(value: bool): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_boolean(gboolean(value))
  discard g_variant_ref_sink(result.impl)

proc newVariantBoolean*(tdesc: typedesc; value: bool): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_boolean(gboolean(value))
  discard g_variant_ref_sink(result.impl)

proc initVariantBoolean*[T](result: var T; value: bool) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_boolean(gboolean(value))
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_byte(value: uint8): ptr Variant00 {.
    importc, libprag.}

proc newVariantByte*(value: uint8): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_byte(value)
  discard g_variant_ref_sink(result.impl)

proc newVariantByte*(tdesc: typedesc; value: uint8): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_byte(value)
  discard g_variant_ref_sink(result.impl)

proc initVariantByte*[T](result: var T; value: uint8) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_byte(value)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_bytestring(string: ptr uint8): ptr Variant00 {.
    importc, libprag.}

proc newVariantBytestring*(string: seq[uint8] | string): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_bytestring(cast[ptr uint8](unsafeaddr(string[0])))
  discard g_variant_ref_sink(result.impl)

proc newVariantBytestring*(tdesc: typedesc; string: seq[uint8] | string): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_bytestring(cast[ptr uint8](unsafeaddr(string[0])))
  discard g_variant_ref_sink(result.impl)

proc initVariantBytestring*[T](result: var T; string: seq[uint8] | string) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_bytestring(cast[ptr uint8](unsafeaddr(string[0])))
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_bytestring_array(strv: ptr cstring; length: int64): ptr Variant00 {.
    importc, libprag.}

proc newVariantBytestringArray*(strv: openArray[string]; length: int64): Variant =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_bytestring_array(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc newVariantBytestringArray*(tdesc: typedesc; strv: openArray[string]; length: int64): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_bytestring_array(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc initVariantBytestringArray*[T](result: var T; strv: openArray[string]; length: int64) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_bytestring_array(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_dict_entry(key: ptr Variant00; value: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc newVariantDictEntry*(key: Variant; value: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_dict_entry(cast[ptr Variant00](key.impl), cast[ptr Variant00](value.impl))
  discard g_variant_ref_sink(result.impl)

proc newVariantDictEntry*(tdesc: typedesc; key: Variant; value: Variant): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_dict_entry(cast[ptr Variant00](key.impl), cast[ptr Variant00](value.impl))
  discard g_variant_ref_sink(result.impl)

proc initVariantDictEntry*[T](result: var T; key: Variant; value: Variant) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_dict_entry(cast[ptr Variant00](key.impl), cast[ptr Variant00](value.impl))
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_double(value: cdouble): ptr Variant00 {.
    importc, libprag.}

proc newVariantDouble*(value: cdouble): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_double(value)
  discard g_variant_ref_sink(result.impl)

proc newVariantDouble*(tdesc: typedesc; value: cdouble): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_double(value)
  discard g_variant_ref_sink(result.impl)

proc initVariantDouble*[T](result: var T; value: cdouble) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_double(value)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_handle(value: int32): ptr Variant00 {.
    importc, libprag.}

proc newVariantHandle*(value: int): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_handle(int32(value))
  discard g_variant_ref_sink(result.impl)

proc newVariantHandle*(tdesc: typedesc; value: int): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_handle(int32(value))
  discard g_variant_ref_sink(result.impl)

proc initVariantHandle*[T](result: var T; value: int) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_handle(int32(value))
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_int16(value: int16): ptr Variant00 {.
    importc, libprag.}

proc newVariantInt16*(value: int16): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int16(value)
  discard g_variant_ref_sink(result.impl)

proc newVariantInt16*(tdesc: typedesc; value: int16): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int16(value)
  discard g_variant_ref_sink(result.impl)

proc initVariantInt16*[T](result: var T; value: int16) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int16(value)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_int32(value: int32): ptr Variant00 {.
    importc, libprag.}

proc newVariantInt32*(value: int): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int32(int32(value))
  discard g_variant_ref_sink(result.impl)

proc newVariantInt32*(tdesc: typedesc; value: int): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int32(int32(value))
  discard g_variant_ref_sink(result.impl)

proc initVariantInt32*[T](result: var T; value: int) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int32(int32(value))
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_int64(value: int64): ptr Variant00 {.
    importc, libprag.}

proc newVariantInt64*(value: int64): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int64(value)
  discard g_variant_ref_sink(result.impl)

proc newVariantInt64*(tdesc: typedesc; value: int64): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int64(value)
  discard g_variant_ref_sink(result.impl)

proc initVariantInt64*[T](result: var T; value: int64) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_int64(value)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_object_path(objectPath: cstring): ptr Variant00 {.
    importc, libprag.}

proc newVariantObjectPath*(objectPath: cstring): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_object_path(objectPath)
  discard g_variant_ref_sink(result.impl)

proc newVariantObjectPath*(tdesc: typedesc; objectPath: cstring): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_object_path(objectPath)
  discard g_variant_ref_sink(result.impl)

proc initVariantObjectPath*[T](result: var T; objectPath: cstring) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_object_path(objectPath)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_objv(strv: ptr cstring; length: int64): ptr Variant00 {.
    importc, libprag.}

proc newVariantObjv*(strv: openArray[string]; length: int64): Variant =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_objv(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc newVariantObjv*(tdesc: typedesc; strv: openArray[string]; length: int64): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_objv(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc initVariantObjv*[T](result: var T; strv: openArray[string]; length: int64) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_objv(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_signature(signature: cstring): ptr Variant00 {.
    importc, libprag.}

proc newVariantSignature*(signature: cstring): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_signature(signature)
  discard g_variant_ref_sink(result.impl)

proc newVariantSignature*(tdesc: typedesc; signature: cstring): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_signature(signature)
  discard g_variant_ref_sink(result.impl)

proc initVariantSignature*[T](result: var T; signature: cstring) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_signature(signature)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_string(string: cstring): ptr Variant00 {.
    importc, libprag.}

proc newVariantString*(string: cstring): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_string(string)
  discard g_variant_ref_sink(result.impl)

proc newVariantString*(tdesc: typedesc; string: cstring): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_string(string)
  discard g_variant_ref_sink(result.impl)

proc initVariantString*[T](result: var T; string: cstring) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_string(string)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_strv(strv: ptr cstring; length: int64): ptr Variant00 {.
    importc, libprag.}

proc newVariantStrv*(strv: openArray[string]; length: int64): Variant =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_strv(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc newVariantStrv*(tdesc: typedesc; strv: openArray[string]; length: int64): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_strv(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc initVariantStrv*[T](result: var T; strv: openArray[string]; length: int64) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_strv(seq2CstringArray(strv, fs469n23), length)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_tuple(children: ptr ptr Variant00; nChildren: uint64): ptr Variant00 {.
    importc, libprag.}

proc newVariantTuple*(children: ptr ptr Variant00; nChildren: uint64): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_tuple(children, nChildren)
  discard g_variant_ref_sink(result.impl)

proc newVariantTuple*(tdesc: typedesc; children: ptr ptr Variant00; nChildren: uint64): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_tuple(children, nChildren)
  discard g_variant_ref_sink(result.impl)

proc initVariantTuple*[T](result: var T; children: ptr ptr Variant00; nChildren: uint64) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_tuple(children, nChildren)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_uint16(value: uint16): ptr Variant00 {.
    importc, libprag.}

proc newVariantUint16*(value: uint16): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint16(value)
  discard g_variant_ref_sink(result.impl)

proc newVariantUint16*(tdesc: typedesc; value: uint16): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint16(value)
  discard g_variant_ref_sink(result.impl)

proc initVariantUint16*[T](result: var T; value: uint16) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint16(value)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_uint32(value: uint32): ptr Variant00 {.
    importc, libprag.}

proc newVariantUint32*(value: int): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint32(uint32(value))
  discard g_variant_ref_sink(result.impl)

proc newVariantUint32*(tdesc: typedesc; value: int): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint32(uint32(value))
  discard g_variant_ref_sink(result.impl)

proc initVariantUint32*[T](result: var T; value: int) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint32(uint32(value))
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_uint64(value: uint64): ptr Variant00 {.
    importc, libprag.}

proc newVariantUint64*(value: uint64): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint64(value)
  discard g_variant_ref_sink(result.impl)

proc newVariantUint64*(tdesc: typedesc; value: uint64): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint64(value)
  discard g_variant_ref_sink(result.impl)

proc initVariantUint64*[T](result: var T; value: uint64) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_uint64(value)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_variant(value: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc newVariantVariant*(value: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_variant(cast[ptr Variant00](value.impl))
  discard g_variant_ref_sink(result.impl)

proc newVariantVariant*(tdesc: typedesc; value: Variant): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_variant(cast[ptr Variant00](value.impl))
  discard g_variant_ref_sink(result.impl)

proc initVariantVariant*[T](result: var T; value: Variant) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_variant(cast[ptr Variant00](value.impl))
  discard g_variant_ref_sink(result.impl)

proc g_variant_byteswap(self: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc byteswap*(self: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_byteswap(cast[ptr Variant00](self.impl))

proc g_variant_check_format_string(self: ptr Variant00; formatString: cstring;
    copyOnly: gboolean): gboolean {.
    importc, libprag.}

proc checkFormatString*(self: Variant; formatString: cstring;
    copyOnly: bool): bool =
  toBool(g_variant_check_format_string(cast[ptr Variant00](self.impl), formatString, gboolean(copyOnly)))

proc g_variant_compare(self: ptr Variant00; two: ptr Variant00): int32 {.
    importc, libprag.}

proc compare*(self: Variant; two: Variant): int =
  int(g_variant_compare(cast[ptr Variant00](self.impl), cast[ptr Variant00](two.impl)))

proc g_variant_dup_bytestring(self: ptr Variant00; length: var uint64): ptr uint8 {.
    importc, libprag.}

proc dupBytestring*(self: Variant; length: var uint64 = cast[var uint64](nil)): seq[uint8] =
  let resul0 = g_variant_dup_bytestring(cast[ptr Variant00](self.impl), length)
  result = uint8ArrayZT2seq(resul0)
  cogfree(resul0)

proc g_variant_dup_bytestring_array(self: ptr Variant00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc dupBytestringArray*(self: Variant; length: var uint64 = cast[var uint64](nil)): seq[string] =
  let resul0 = g_variant_dup_bytestring_array(cast[ptr Variant00](self.impl), length)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_variant_dup_objv(self: ptr Variant00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc dupObjv*(self: Variant; length: var uint64 = cast[var uint64](nil)): seq[string] =
  let resul0 = g_variant_dup_objv(cast[ptr Variant00](self.impl), length)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_variant_dup_string(self: ptr Variant00; length: var uint64): cstring {.
    importc, libprag.}

proc dupString*(self: Variant; length: var uint64): string =
  let resul0 = g_variant_dup_string(cast[ptr Variant00](self.impl), length)
  result = $resul0
  cogfree(resul0)

proc g_variant_dup_strv(self: ptr Variant00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc dupStrv*(self: Variant; length: var uint64 = cast[var uint64](nil)): seq[string] =
  let resul0 = g_variant_dup_strv(cast[ptr Variant00](self.impl), length)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_variant_equal(self: ptr Variant00; two: ptr Variant00): gboolean {.
    importc, libprag.}

proc equal*(self: Variant; two: Variant): bool =
  toBool(g_variant_equal(cast[ptr Variant00](self.impl), cast[ptr Variant00](two.impl)))

proc g_variant_get_boolean(self: ptr Variant00): gboolean {.
    importc, libprag.}

proc getBoolean*(self: Variant): bool =
  toBool(g_variant_get_boolean(cast[ptr Variant00](self.impl)))

proc boolean*(self: Variant): bool =
  toBool(g_variant_get_boolean(cast[ptr Variant00](self.impl)))

proc g_variant_get_byte(self: ptr Variant00): uint8 {.
    importc, libprag.}

proc getByte*(self: Variant): uint8 =
  g_variant_get_byte(cast[ptr Variant00](self.impl))

proc byte*(self: Variant): uint8 =
  g_variant_get_byte(cast[ptr Variant00](self.impl))

proc g_variant_get_bytestring(self: ptr Variant00): ptr uint8 {.
    importc, libprag.}

proc getBytestring*(self: Variant): seq[uint8] =
  result = uint8ArrayZT2seq(g_variant_get_bytestring(cast[ptr Variant00](self.impl)))

proc bytestring*(self: Variant): seq[uint8] =
  result = uint8ArrayZT2seq(g_variant_get_bytestring(cast[ptr Variant00](self.impl)))

proc g_variant_get_bytestring_array(self: ptr Variant00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc getBytestringArray*(self: Variant; length: var uint64 = cast[var uint64](nil)): seq[string] =
  cstringArrayToSeq(g_variant_get_bytestring_array(cast[ptr Variant00](self.impl), length))

proc g_variant_get_child_value(self: ptr Variant00; index: uint64): ptr Variant00 {.
    importc, libprag.}

proc getChildValue*(self: Variant; index: uint64): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_get_child_value(cast[ptr Variant00](self.impl), index)

proc g_variant_get_data(self: ptr Variant00): pointer {.
    importc, libprag.}

proc getData*(self: Variant): pointer =
  g_variant_get_data(cast[ptr Variant00](self.impl))

proc g_variant_get_data_as_bytes(self: ptr Variant00): ptr Bytes00 {.
    importc, libprag.}

proc getDataAsBytes*(self: Variant): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_variant_get_data_as_bytes(cast[ptr Variant00](self.impl))

proc dataAsBytes*(self: Variant): Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = g_variant_get_data_as_bytes(cast[ptr Variant00](self.impl))

proc g_variant_get_double(self: ptr Variant00): cdouble {.
    importc, libprag.}

proc getDouble*(self: Variant): cdouble =
  g_variant_get_double(cast[ptr Variant00](self.impl))

proc double*(self: Variant): cdouble =
  g_variant_get_double(cast[ptr Variant00](self.impl))

proc g_variant_get_handle(self: ptr Variant00): int32 {.
    importc, libprag.}

proc getHandle*(self: Variant): int =
  int(g_variant_get_handle(cast[ptr Variant00](self.impl)))

proc handle*(self: Variant): int =
  int(g_variant_get_handle(cast[ptr Variant00](self.impl)))

proc g_variant_get_int16(self: ptr Variant00): int16 {.
    importc, libprag.}

proc getInt16*(self: Variant): int16 =
  g_variant_get_int16(cast[ptr Variant00](self.impl))

proc g_variant_get_int32(self: ptr Variant00): int32 {.
    importc, libprag.}

proc getInt32*(self: Variant): int =
  int(g_variant_get_int32(cast[ptr Variant00](self.impl)))

proc g_variant_get_int64(self: ptr Variant00): int64 {.
    importc, libprag.}

proc getInt64*(self: Variant): int64 =
  g_variant_get_int64(cast[ptr Variant00](self.impl))

proc g_variant_get_maybe(self: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc getMaybe*(self: Variant): Variant =
  let impl0 = g_variant_get_maybe(cast[ptr Variant00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0

proc maybe*(self: Variant): Variant =
  let impl0 = g_variant_get_maybe(cast[ptr Variant00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0

proc g_variant_get_normal_form(self: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc getNormalForm*(self: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_get_normal_form(cast[ptr Variant00](self.impl))

proc normalForm*(self: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_get_normal_form(cast[ptr Variant00](self.impl))

proc g_variant_get_objv(self: ptr Variant00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc getObjv*(self: Variant; length: var uint64 = cast[var uint64](nil)): seq[string] =
  cstringArrayToSeq(g_variant_get_objv(cast[ptr Variant00](self.impl), length))

proc g_variant_get_size(self: ptr Variant00): uint64 {.
    importc, libprag.}

proc getSize*(self: Variant): uint64 =
  g_variant_get_size(cast[ptr Variant00](self.impl))

proc size*(self: Variant): uint64 =
  g_variant_get_size(cast[ptr Variant00](self.impl))

proc g_variant_get_string(self: ptr Variant00; length: var uint64): cstring {.
    importc, libprag.}

proc getString*(self: Variant; length: var uint64 = cast[var uint64](nil)): string =
  result = $g_variant_get_string(cast[ptr Variant00](self.impl), length)

proc g_variant_get_strv(self: ptr Variant00; length: var uint64): ptr cstring {.
    importc, libprag.}

proc getStrv*(self: Variant; length: var uint64 = cast[var uint64](nil)): seq[string] =
  cstringArrayToSeq(g_variant_get_strv(cast[ptr Variant00](self.impl), length))

proc g_variant_get_type_string(self: ptr Variant00): cstring {.
    importc, libprag.}

proc getTypeString*(self: Variant): string =
  result = $g_variant_get_type_string(cast[ptr Variant00](self.impl))

proc typeString*(self: Variant): string =
  result = $g_variant_get_type_string(cast[ptr Variant00](self.impl))

proc g_variant_get_uint16(self: ptr Variant00): uint16 {.
    importc, libprag.}

proc getUint16*(self: Variant): uint16 =
  g_variant_get_uint16(cast[ptr Variant00](self.impl))

proc g_variant_get_uint32(self: ptr Variant00): uint32 {.
    importc, libprag.}

proc getUint32*(self: Variant): int =
  int(g_variant_get_uint32(cast[ptr Variant00](self.impl)))

proc g_variant_get_uint64(self: ptr Variant00): uint64 {.
    importc, libprag.}

proc getUint64*(self: Variant): uint64 =
  g_variant_get_uint64(cast[ptr Variant00](self.impl))

proc g_variant_get_variant(self: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc getVariant*(self: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_get_variant(cast[ptr Variant00](self.impl))

proc variant*(self: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_get_variant(cast[ptr Variant00](self.impl))

proc g_variant_hash(self: ptr Variant00): uint32 {.
    importc, libprag.}

proc hash*(self: Variant): int =
  int(g_variant_hash(cast[ptr Variant00](self.impl)))

proc g_variant_is_container(self: ptr Variant00): gboolean {.
    importc, libprag.}

proc isContainer*(self: Variant): bool =
  toBool(g_variant_is_container(cast[ptr Variant00](self.impl)))

proc g_variant_is_floating(self: ptr Variant00): gboolean {.
    importc, libprag.}

proc isFloating*(self: Variant): bool =
  toBool(g_variant_is_floating(cast[ptr Variant00](self.impl)))

proc g_variant_is_normal_form(self: ptr Variant00): gboolean {.
    importc, libprag.}

proc isNormalForm*(self: Variant): bool =
  toBool(g_variant_is_normal_form(cast[ptr Variant00](self.impl)))

proc g_variant_n_children(self: ptr Variant00): uint64 {.
    importc, libprag.}

proc nChildren*(self: Variant): uint64 =
  g_variant_n_children(cast[ptr Variant00](self.impl))

proc g_variant_print(self: ptr Variant00; typeAnnotate: gboolean): cstring {.
    importc, libprag.}

proc print*(self: Variant; typeAnnotate: bool): string =
  let resul0 = g_variant_print(cast[ptr Variant00](self.impl), gboolean(typeAnnotate))
  result = $resul0
  cogfree(resul0)

proc g_variant_ref(self: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc `ref`*(self: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_ref(cast[ptr Variant00](self.impl))

proc g_variant_store(self: ptr Variant00; data: pointer) {.
    importc, libprag.}

proc store*(self: Variant; data: pointer) =
  g_variant_store(cast[ptr Variant00](self.impl), data)

proc g_variant_take_ref(self: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc takeRef*(self: Variant): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_take_ref(cast[ptr Variant00](self.impl))

proc g_variant_is_object_path(string: cstring): gboolean {.
    importc, libprag.}

proc isObjectPath*(string: cstring): bool =
  toBool(g_variant_is_object_path(string))

proc g_variant_is_signature(string: cstring): gboolean {.
    importc, libprag.}

proc isSignature*(string: cstring): bool =
  toBool(g_variant_is_signature(string))

proc g_variant_parse_error_print_context(error: ptr glib.Error; sourceStr: cstring): cstring {.
    importc, libprag.}

proc parseErrorPrintContext*(error: ptr glib.Error; sourceStr: cstring): string =
  let resul0 = g_variant_parse_error_print_context(error, sourceStr)
  result = $resul0
  cogfree(resul0)

proc g_variant_parse_error_quark(): uint32 {.
    importc, libprag.}

proc parseErrorQuark*(): int =
  int(g_variant_parse_error_quark())

proc g_variant_parser_get_error_quark(): uint32 {.
    importc, libprag.}

proc parserGetErrorQuark*(): int =
  int(g_variant_parser_get_error_quark())

type
  VariantClass* {.size: sizeof(cint), pure.} = enum
    `tuple` = 40
    array = 97
    boolean = 98
    double = 100
    signature = 103
    handle = 104
    int32 = 105
    maybe = 109
    int16 = 110
    objectPath = 111
    uint16 = 113
    string = 115
    uint64 = 116
    uint32 = 117
    variant = 118
    int64 = 120
    byte = 121
    dictEntry = 123

proc g_variant_classify(self: ptr Variant00): VariantClass {.
    importc, libprag.}

proc classify*(self: Variant): VariantClass =
  g_variant_classify(cast[ptr Variant00](self.impl))

type
  VariantType00* {.pure.} = object
  VariantType* = ref object
    impl*: ptr VariantType00
    ignoreFinalizer*: bool

proc g_variant_type_get_gtype*(): GType {.importc, gobjectlibprag.}

proc g_variant_type_free(self: ptr VariantType00) {.
    importc, libprag.}

proc free*(self: VariantType) =
  g_variant_type_free(cast[ptr VariantType00](self.impl))

proc finalizerfree*(self: VariantType) =
  if not self.ignoreFinalizer:
    g_variant_type_free(cast[ptr VariantType00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VariantType()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_variant_type_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var VariantType) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc g_variant_type_new_array(element: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc newVariantTypeArray*(element: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_array(cast[ptr VariantType00](element.impl))

proc newVariantTypeArray*(tdesc: typedesc; element: VariantType): tdesc =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_array(cast[ptr VariantType00](element.impl))

proc initVariantTypeArray*[T](result: var T; element: VariantType) {.deprecated.} =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_array(cast[ptr VariantType00](element.impl))

proc g_variant_type_new_dict_entry(key: ptr VariantType00; value: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc newVariantTypeDictEntry*(key: VariantType; value: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_dict_entry(cast[ptr VariantType00](key.impl), cast[ptr VariantType00](value.impl))

proc newVariantTypeDictEntry*(tdesc: typedesc; key: VariantType; value: VariantType): tdesc =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_dict_entry(cast[ptr VariantType00](key.impl), cast[ptr VariantType00](value.impl))

proc initVariantTypeDictEntry*[T](result: var T; key: VariantType; value: VariantType) {.deprecated.} =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_dict_entry(cast[ptr VariantType00](key.impl), cast[ptr VariantType00](value.impl))

proc g_variant_type_new_maybe(element: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc newVariantTypeMaybe*(element: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_maybe(cast[ptr VariantType00](element.impl))

proc newVariantTypeMaybe*(tdesc: typedesc; element: VariantType): tdesc =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_maybe(cast[ptr VariantType00](element.impl))

proc initVariantTypeMaybe*[T](result: var T; element: VariantType) {.deprecated.} =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_maybe(cast[ptr VariantType00](element.impl))

proc g_variant_type_new_tuple(items: ptr ptr VariantType00; length: int32): ptr VariantType00 {.
    importc, libprag.}

proc newVariantTypeTuple*(items: ptr ptr VariantType00; length: int): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_tuple(items, int32(length))

proc newVariantTypeTuple*(tdesc: typedesc; items: ptr ptr VariantType00; length: int): tdesc =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_tuple(items, int32(length))

proc initVariantTypeTuple*[T](result: var T; items: ptr ptr VariantType00; length: int) {.deprecated.} =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new_tuple(items, int32(length))

proc g_variant_type_copy(self: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc copy*(self: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_copy(cast[ptr VariantType00](self.impl))

proc g_variant_type_dup_string(self: ptr VariantType00): cstring {.
    importc, libprag.}

proc dupString*(self: VariantType): string =
  let resul0 = g_variant_type_dup_string(cast[ptr VariantType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_variant_type_element(self: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc element*(self: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_element(cast[ptr VariantType00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_variant_type_get_gtype(), result.impl))

proc g_variant_type_equal(self: ptr VariantType00; type2: ptr VariantType00): gboolean {.
    importc, libprag.}

proc equal*(self: VariantType; type2: VariantType): bool =
  toBool(g_variant_type_equal(cast[ptr VariantType00](self.impl), cast[ptr VariantType00](type2.impl)))

proc g_variant_type_first(self: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc first*(self: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_first(cast[ptr VariantType00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_variant_type_get_gtype(), result.impl))

proc g_variant_type_new(typeString: cstring): ptr VariantType00 {.
    importc, libprag.}

proc newVariantType*(typeString: cstring): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new(typeString)

proc newVariantType*(tdesc: typedesc; typeString: cstring): tdesc =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new(typeString)

proc initVariantType*[T](result: var T; typeString: cstring) {.deprecated.} =
  assert(result is VariantType)
  fnew(result, finalizerfree)
  result.impl = g_variant_type_new(typeString)

proc g_variant_type_get_string_length(self: ptr VariantType00): uint64 {.
    importc, libprag.}

proc getStringLength*(self: VariantType): uint64 =
  g_variant_type_get_string_length(cast[ptr VariantType00](self.impl))

proc stringLength*(self: VariantType): uint64 =
  g_variant_type_get_string_length(cast[ptr VariantType00](self.impl))

proc g_variant_type_hash(self: ptr VariantType00): uint32 {.
    importc, libprag.}

proc hash*(self: VariantType): int =
  int(g_variant_type_hash(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_array(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isArray*(self: VariantType): bool =
  toBool(g_variant_type_is_array(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_basic(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isBasic*(self: VariantType): bool =
  toBool(g_variant_type_is_basic(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_container(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isContainer*(self: VariantType): bool =
  toBool(g_variant_type_is_container(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_definite(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isDefinite*(self: VariantType): bool =
  toBool(g_variant_type_is_definite(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_dict_entry(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isDictEntry*(self: VariantType): bool =
  toBool(g_variant_type_is_dict_entry(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_maybe(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isMaybe*(self: VariantType): bool =
  toBool(g_variant_type_is_maybe(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_subtype_of(self: ptr VariantType00; supertype: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isSubtypeOf*(self: VariantType; supertype: VariantType): bool =
  toBool(g_variant_type_is_subtype_of(cast[ptr VariantType00](self.impl), cast[ptr VariantType00](supertype.impl)))

proc g_variant_type_is_tuple(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isTuple*(self: VariantType): bool =
  toBool(g_variant_type_is_tuple(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_variant(self: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isVariant*(self: VariantType): bool =
  toBool(g_variant_type_is_variant(cast[ptr VariantType00](self.impl)))

proc g_variant_type_key(self: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc key*(self: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_key(cast[ptr VariantType00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_variant_type_get_gtype(), result.impl))

proc g_variant_type_n_items(self: ptr VariantType00): uint64 {.
    importc, libprag.}

proc nItems*(self: VariantType): uint64 =
  g_variant_type_n_items(cast[ptr VariantType00](self.impl))

proc g_variant_type_next(self: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc next*(self: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_next(cast[ptr VariantType00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_variant_type_get_gtype(), result.impl))

proc g_variant_type_value(self: ptr VariantType00): ptr VariantType00 {.
    importc, libprag.}

proc value*(self: VariantType): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_type_value(cast[ptr VariantType00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_variant_type_get_gtype(), result.impl))

proc g_variant_type_string_is_valid(typeString: cstring): gboolean {.
    importc, libprag.}

proc stringIsValid*(typeString: cstring): bool =
  toBool(g_variant_type_string_is_valid(typeString))

proc g_variant_type_string_scan(string: cstring; limit: cstring; endptr: var cstring): gboolean {.
    importc, libprag.}

proc stringScan*(string: cstring; limit: cstring = nil; endptr: var string = cast[var string](nil)): bool =
  var endptr_00: cstring
  result = toBool(g_variant_type_string_scan(string, limit, endptr_00))
  if endptr.addr != nil:
    endptr = $(endptr_00)

proc g_variant_new_fixed_array(elementType: ptr VariantType00; elements: pointer;
    nElements: uint64; elementSize: uint64): ptr Variant00 {.
    importc, libprag.}

proc newVariantFixedArray*(elementType: VariantType; elements: pointer;
    nElements: uint64; elementSize: uint64): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_fixed_array(cast[ptr VariantType00](elementType.impl), elements, nElements, elementSize)
  discard g_variant_ref_sink(result.impl)

proc newVariantFixedArray*(tdesc: typedesc; elementType: VariantType; elements: pointer;
    nElements: uint64; elementSize: uint64): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_fixed_array(cast[ptr VariantType00](elementType.impl), elements, nElements, elementSize)
  discard g_variant_ref_sink(result.impl)

proc initVariantFixedArray*[T](result: var T; elementType: VariantType; elements: pointer;
    nElements: uint64; elementSize: uint64) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_fixed_array(cast[ptr VariantType00](elementType.impl), elements, nElements, elementSize)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_from_bytes(`type`: ptr VariantType00; bytes: ptr Bytes00;
    trusted: gboolean): ptr Variant00 {.
    importc, libprag.}

proc newVariantFromBytes*(`type`: VariantType; bytes: Bytes; trusted: bool): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_from_bytes(cast[ptr VariantType00](`type`.impl), cast[ptr Bytes00](bytes.impl), gboolean(trusted))
  discard g_variant_ref_sink(result.impl)

proc newVariantFromBytes*(tdesc: typedesc; `type`: VariantType; bytes: Bytes; trusted: bool): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_from_bytes(cast[ptr VariantType00](`type`.impl), cast[ptr Bytes00](bytes.impl), gboolean(trusted))
  discard g_variant_ref_sink(result.impl)

proc initVariantFromBytes*[T](result: var T; `type`: VariantType; bytes: Bytes; trusted: bool) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_from_bytes(cast[ptr VariantType00](`type`.impl), cast[ptr Bytes00](bytes.impl), gboolean(trusted))
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_from_data(`type`: ptr VariantType00; data: ptr uint8;
    size: uint64; trusted: gboolean; notify: DestroyNotify; userData: pointer): ptr Variant00 {.
    importc, libprag.}

proc newVariantFromData*(`type`: VariantType; data: seq[uint8] | string;
    trusted: bool; notify: DestroyNotify; userData: pointer): Variant =
  let size = uint64(data.len)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_from_data(cast[ptr VariantType00](`type`.impl), cast[ptr uint8](unsafeaddr(data[0])), size, gboolean(trusted), notify, userData)
  discard g_variant_ref_sink(result.impl)

proc newVariantFromData*(tdesc: typedesc; `type`: VariantType; data: seq[uint8] | string;
    trusted: bool; notify: DestroyNotify; userData: pointer): tdesc =
  let size = uint64(data.len)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_from_data(cast[ptr VariantType00](`type`.impl), cast[ptr uint8](unsafeaddr(data[0])), size, gboolean(trusted), notify, userData)
  discard g_variant_ref_sink(result.impl)

proc initVariantFromData*[T](result: var T; `type`: VariantType; data: seq[uint8] | string;
    trusted: bool; notify: DestroyNotify; userData: pointer) {.deprecated.} =
  let size = uint64(data.len)
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_from_data(cast[ptr VariantType00](`type`.impl), cast[ptr uint8](unsafeaddr(data[0])), size, gboolean(trusted), notify, userData)
  discard g_variant_ref_sink(result.impl)

proc g_variant_new_maybe(childType: ptr VariantType00; child: ptr Variant00): ptr Variant00 {.
    importc, libprag.}

proc newVariantMaybe*(childType: VariantType = nil; child: Variant = nil): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_maybe(if childType.isNil: nil else: cast[ptr VariantType00](childType.impl), if child.isNil: nil else: cast[ptr Variant00](child.impl))
  discard g_variant_ref_sink(result.impl)

proc newVariantMaybe*(tdesc: typedesc; childType: VariantType = nil; child: Variant = nil): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_maybe(if childType.isNil: nil else: cast[ptr VariantType00](childType.impl), if child.isNil: nil else: cast[ptr Variant00](child.impl))
  discard g_variant_ref_sink(result.impl)

proc initVariantMaybe*[T](result: var T; childType: VariantType = nil; child: Variant = nil) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_maybe(if childType.isNil: nil else: cast[ptr VariantType00](childType.impl), if child.isNil: nil else: cast[ptr Variant00](child.impl))
  discard g_variant_ref_sink(result.impl)

proc g_variant_get_type(self: ptr Variant00): ptr VariantType00 {.
    importc, libprag.}

proc getType*(self: Variant): VariantType =
  fnew(result, finalizerfree)
  result.impl = g_variant_get_type(cast[ptr Variant00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_variant_type_get_gtype(), result.impl))

proc g_variant_is_of_type(self: ptr Variant00; `type`: ptr VariantType00): gboolean {.
    importc, libprag.}

proc isOfType*(self: Variant; `type`: VariantType): bool =
  toBool(g_variant_is_of_type(cast[ptr Variant00](self.impl), cast[ptr VariantType00](`type`.impl)))

proc g_variant_lookup_value(self: ptr Variant00; key: cstring; expectedType: ptr VariantType00): ptr Variant00 {.
    importc, libprag.}

proc lookupValue*(self: Variant; key: cstring; expectedType: VariantType = nil): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_lookup_value(cast[ptr Variant00](self.impl), key, if expectedType.isNil: nil else: cast[ptr VariantType00](expectedType.impl))

proc g_variant_new_array(childType: ptr VariantType00; children: ptr ptr Variant00;
    nChildren: uint64): ptr Variant00 {.
    importc, libprag.}

proc newVariantArray*(childType: VariantType = nil; children: ptr ptr Variant00;
    nChildren: uint64): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_new_array(if childType.isNil: nil else: cast[ptr VariantType00](childType.impl), children, nChildren)
  discard g_variant_ref_sink(result.impl)

proc newVariantArray*(tdesc: typedesc; childType: VariantType = nil; children: ptr ptr Variant00;
    nChildren: uint64): tdesc =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_array(if childType.isNil: nil else: cast[ptr VariantType00](childType.impl), children, nChildren)
  discard g_variant_ref_sink(result.impl)

proc initVariantArray*[T](result: var T; childType: VariantType = nil; children: ptr ptr Variant00;
    nChildren: uint64) {.deprecated.} =
  assert(result is Variant)
  fnew(result, finalizerunref)
  result.impl = g_variant_new_array(if childType.isNil: nil else: cast[ptr VariantType00](childType.impl), children, nChildren)
  discard g_variant_ref_sink(result.impl)

proc g_variant_parse(`type`: ptr VariantType00; text: cstring; limit: cstring;
    endptr: cstring; error: ptr ptr glib.Error = nil): ptr Variant00 {.
    importc, libprag.}

proc parse*(`type`: VariantType = nil; text: cstring; limit: cstring = nil;
    endptr: cstring = nil): Variant =
  var gerror: ptr glib.Error
  let impl0 = g_variant_parse(if `type`.isNil: nil else: cast[ptr VariantType00](`type`.impl), text, limit, endptr, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, finalizerunref)
  result.impl = impl0

type
  VariantBuilder00* {.pure.} = object
  VariantBuilder* = ref object
    impl*: ptr VariantBuilder00
    ignoreFinalizer*: bool

proc g_variant_builder_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGVariantBuilder*(self: VariantBuilder) =
  if not self.ignoreFinalizer:
    boxedFree(g_variant_builder_get_type(), cast[ptr VariantBuilder00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VariantBuilder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_variant_builder_get_type(), cast[ptr VariantBuilder00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VariantBuilder) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGVariantBuilder)

proc g_variant_builder_unref(self: ptr VariantBuilder00) {.
    importc, libprag.}

proc unref*(self: VariantBuilder) =
  g_variant_builder_unref(cast[ptr VariantBuilder00](g_boxed_copy(g_variant_builder_get_type(), self.impl)))

proc finalizerunref*(self: VariantBuilder) =
  if not self.ignoreFinalizer:
    g_variant_builder_unref(cast[ptr VariantBuilder00](self.impl))

proc g_variant_builder_add_value(self: ptr VariantBuilder00; value: ptr Variant00) {.
    importc, libprag.}

proc addValue*(self: VariantBuilder; value: Variant) =
  g_variant_builder_add_value(cast[ptr VariantBuilder00](self.impl), cast[ptr Variant00](value.impl))

proc g_variant_builder_close(self: ptr VariantBuilder00) {.
    importc, libprag.}

proc close*(self: VariantBuilder) =
  g_variant_builder_close(cast[ptr VariantBuilder00](self.impl))

proc g_variant_builder_end(self: ptr VariantBuilder00): ptr Variant00 {.
    importc, libprag.}

proc `end`*(self: VariantBuilder): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_builder_end(cast[ptr VariantBuilder00](self.impl))
  result.ignoreFinalizer = true # GVariant

proc g_variant_builder_open(self: ptr VariantBuilder00; `type`: ptr VariantType00) {.
    importc, libprag.}

proc open*(self: VariantBuilder; `type`: VariantType) =
  g_variant_builder_open(cast[ptr VariantBuilder00](self.impl), cast[ptr VariantType00](`type`.impl))

proc g_variant_builder_ref(self: ptr VariantBuilder00): ptr VariantBuilder00 {.
    importc, libprag.}

proc `ref`*(self: VariantBuilder): VariantBuilder =
  fnew(result, gBoxedFreeGVariantBuilder)
  result.impl = g_variant_builder_ref(cast[ptr VariantBuilder00](self.impl))

proc g_variant_builder_new(`type`: ptr VariantType00): ptr VariantBuilder00 {.
    importc, libprag.}

proc newVariantBuilder*(`type`: VariantType): VariantBuilder =
  fnew(result, gBoxedFreeGVariantBuilder)
  result.impl = g_variant_builder_new(cast[ptr VariantType00](`type`.impl))

proc newVariantBuilder*(tdesc: typedesc; `type`: VariantType): tdesc =
  assert(result is VariantBuilder)
  fnew(result, gBoxedFreeGVariantBuilder)
  result.impl = g_variant_builder_new(cast[ptr VariantType00](`type`.impl))

proc initVariantBuilder*[T](result: var T; `type`: VariantType) {.deprecated.} =
  assert(result is VariantBuilder)
  fnew(result, gBoxedFreeGVariantBuilder)
  result.impl = g_variant_builder_new(cast[ptr VariantType00](`type`.impl))

type
  VariantDict00* {.pure.} = object
  VariantDict* = ref object
    impl*: ptr VariantDict00
    ignoreFinalizer*: bool

proc g_variant_dict_get_type*(): GType {.importc, gobjectlibprag.}

proc gBoxedFreeGVariantDict*(self: VariantDict) =
  if not self.ignoreFinalizer:
    boxedFree(g_variant_dict_get_type(), cast[ptr VariantDict00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VariantDict()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_variant_dict_get_type(), cast[ptr VariantDict00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VariantDict) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGVariantDict)

proc g_variant_dict_unref(self: ptr VariantDict00) {.
    importc, libprag.}

proc unref*(self: VariantDict) =
  g_variant_dict_unref(cast[ptr VariantDict00](g_boxed_copy(g_variant_dict_get_type(), self.impl)))

proc finalizerunref*(self: VariantDict) =
  if not self.ignoreFinalizer:
    g_variant_dict_unref(cast[ptr VariantDict00](self.impl))

proc g_variant_dict_clear(self: ptr VariantDict00) {.
    importc, libprag.}

proc clear*(self: VariantDict) =
  g_variant_dict_clear(cast[ptr VariantDict00](self.impl))

proc g_variant_dict_contains(self: ptr VariantDict00; key: cstring): gboolean {.
    importc, libprag.}

proc contains*(self: VariantDict; key: cstring): bool =
  toBool(g_variant_dict_contains(cast[ptr VariantDict00](self.impl), key))

proc g_variant_dict_end(self: ptr VariantDict00): ptr Variant00 {.
    importc, libprag.}

proc `end`*(self: VariantDict): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_dict_end(cast[ptr VariantDict00](self.impl))
  result.ignoreFinalizer = true # GVariant

proc g_variant_dict_insert_value(self: ptr VariantDict00; key: cstring; value: ptr Variant00) {.
    importc, libprag.}

proc insertValue*(self: VariantDict; key: cstring; value: Variant) =
  g_variant_dict_insert_value(cast[ptr VariantDict00](self.impl), key, cast[ptr Variant00](value.impl))

proc g_variant_dict_lookup_value(self: ptr VariantDict00; key: cstring; expectedType: ptr VariantType00): ptr Variant00 {.
    importc, libprag.}

proc lookupValue*(self: VariantDict; key: cstring; expectedType: VariantType = nil): Variant =
  fnew(result, finalizerunref)
  result.impl = g_variant_dict_lookup_value(cast[ptr VariantDict00](self.impl), key, if expectedType.isNil: nil else: cast[ptr VariantType00](expectedType.impl))

proc g_variant_dict_ref(self: ptr VariantDict00): ptr VariantDict00 {.
    importc, libprag.}

proc `ref`*(self: VariantDict): VariantDict =
  fnew(result, gBoxedFreeGVariantDict)
  result.impl = g_variant_dict_ref(cast[ptr VariantDict00](self.impl))

proc g_variant_dict_remove(self: ptr VariantDict00; key: cstring): gboolean {.
    importc, libprag.}

proc remove*(self: VariantDict; key: cstring): bool =
  toBool(g_variant_dict_remove(cast[ptr VariantDict00](self.impl), key))

proc g_variant_dict_new(fromAsv: ptr Variant00): ptr VariantDict00 {.
    importc, libprag.}

proc newVariantDict*(fromAsv: Variant = nil): VariantDict =
  fnew(result, gBoxedFreeGVariantDict)
  result.impl = g_variant_dict_new(if fromAsv.isNil: nil else: cast[ptr Variant00](fromAsv.impl))

proc newVariantDict*(tdesc: typedesc; fromAsv: Variant = nil): tdesc =
  assert(result is VariantDict)
  fnew(result, gBoxedFreeGVariantDict)
  result.impl = g_variant_dict_new(if fromAsv.isNil: nil else: cast[ptr Variant00](fromAsv.impl))

proc initVariantDict*[T](result: var T; fromAsv: Variant = nil) {.deprecated.} =
  assert(result is VariantDict)
  fnew(result, gBoxedFreeGVariantDict)
  result.impl = g_variant_dict_new(if fromAsv.isNil: nil else: cast[ptr Variant00](fromAsv.impl))

type
  VariantParseError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    basicTypeExpected = 1
    cannotInferType = 2
    definiteTypeExpected = 3
    inputNotAtEnd = 4
    invalidCharacter = 5
    invalidFormatString = 6
    invalidObjectPath = 7
    invalidSignature = 8
    invalidTypeString = 9
    noCommonType = 10
    numberOutOfRange = 11
    numberTooBig = 12
    typeError = 13
    unexpectedToken = 14
    unknownKeyword = 15
    unterminatedStringConstant = 16
    valueExpected = 17
    recursion = 18

type
  VoidFunc* = proc () {.cdecl.}

const WIN32_MSG_HANDLE* = 19981206'i32

proc g_access(filename: cstring; mode: int32): int32 {.
    importc, libprag.}

proc access*(filename: cstring; mode: int): int =
  int(g_access(filename, int32(mode)))

proc g_ascii_digit_value(c: int8): int32 {.
    importc, libprag.}

proc asciiDigitValue*(c: int8): int =
  int(g_ascii_digit_value(c))

proc g_ascii_dtostr(buffer: cstring; bufLen: int32; d: cdouble): cstring {.
    importc, libprag.}

proc asciiDtostr*(buffer: cstring; bufLen: int; d: cdouble): string =
  let resul0 = g_ascii_dtostr(buffer, int32(bufLen), d)
  result = $resul0
  cogfree(resul0)

proc g_ascii_formatd(buffer: cstring; bufLen: int32; format: cstring; d: cdouble): cstring {.
    importc, libprag.}

proc asciiFormatd*(buffer: cstring; bufLen: int; format: cstring; d: cdouble): string =
  let resul0 = g_ascii_formatd(buffer, int32(bufLen), format, d)
  result = $resul0
  cogfree(resul0)

proc g_ascii_strcasecmp(s1: cstring; s2: cstring): int32 {.
    importc, libprag.}

proc asciiStrcasecmp*(s1: cstring; s2: cstring): int =
  int(g_ascii_strcasecmp(s1, s2))

proc g_ascii_strdown(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc asciiStrdown*(str: cstring; len: int64): string =
  let resul0 = g_ascii_strdown(str, len)
  result = $resul0
  cogfree(resul0)

proc g_ascii_string_to_signed(str: cstring; base: uint32; min: int64; max: int64;
    outNum: var int64; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc asciiStringToSigned*(str: cstring; base: int; min: int64; max: int64;
    outNum: var int64 = cast[var int64](nil)): bool =
  var gerror: ptr glib.Error
  let resul0 = g_ascii_string_to_signed(str, uint32(base), min, max, outNum, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_ascii_string_to_unsigned(str: cstring; base: uint32; min: uint64;
    max: uint64; outNum: var uint64; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc asciiStringToUnsigned*(str: cstring; base: int; min: uint64; max: uint64;
    outNum: var uint64 = cast[var uint64](nil)): bool =
  var gerror: ptr glib.Error
  let resul0 = g_ascii_string_to_unsigned(str, uint32(base), min, max, outNum, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_ascii_strncasecmp(s1: cstring; s2: cstring; n: uint64): int32 {.
    importc, libprag.}

proc asciiStrncasecmp*(s1: cstring; s2: cstring; n: uint64): int =
  int(g_ascii_strncasecmp(s1, s2, n))

proc g_ascii_strtod(nptr: cstring; endptr: var cstring): cdouble {.
    importc, libprag.}

proc asciiStrtod*(nptr: cstring; endptr: var string = cast[var string](nil)): cdouble =
  var endptr_00: cstring
  result = g_ascii_strtod(nptr, endptr_00)
  if endptr.addr != nil:
    endptr = $(endptr_00)

proc g_ascii_strtoll(nptr: cstring; endptr: var cstring; base: uint32): int64 {.
    importc, libprag.}

proc asciiStrtoll*(nptr: cstring; endptr: var string = cast[var string](nil);
    base: int): int64 =
  var endptr_00: cstring
  result = g_ascii_strtoll(nptr, endptr_00, uint32(base))
  if endptr.addr != nil:
    endptr = $(endptr_00)

proc g_ascii_strtoull(nptr: cstring; endptr: var cstring; base: uint32): uint64 {.
    importc, libprag.}

proc asciiStrtoull*(nptr: cstring; endptr: var string = cast[var string](nil);
    base: int): uint64 =
  var endptr_00: cstring
  result = g_ascii_strtoull(nptr, endptr_00, uint32(base))
  if endptr.addr != nil:
    endptr = $(endptr_00)

proc g_ascii_strup(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc asciiStrup*(str: cstring; len: int64): string =
  let resul0 = g_ascii_strup(str, len)
  result = $resul0
  cogfree(resul0)

proc asciiTolower*(c: int8): int8 {.
    importc: "g_ascii_tolower", libprag.}

proc asciiToupper*(c: int8): int8 {.
    importc: "g_ascii_toupper", libprag.}

proc g_ascii_xdigit_value(c: int8): int32 {.
    importc, libprag.}

proc asciiXdigitValue*(c: int8): int =
  int(g_ascii_xdigit_value(c))

proc g_assert_warning(logDomain: cstring; file: cstring; line: int32; prettyFunction: cstring;
    expression: cstring) {.
    importc, libprag.}

proc assertWarning*(logDomain: cstring; file: cstring; line: int; prettyFunction: cstring;
    expression: cstring) =
  g_assert_warning(logDomain, file, int32(line), prettyFunction, expression)

proc g_assertion_message(domain: cstring; file: cstring; line: int32; `func`: cstring;
    message: cstring) {.
    importc, libprag.}

proc assertionMessage*(domain: cstring; file: cstring; line: int; `func`: cstring;
    message: cstring) =
  g_assertion_message(domain, file, int32(line), `func`, message)

proc g_assertion_message_cmpstr(domain: cstring; file: cstring; line: int32;
    `func`: cstring; expr: cstring; arg1: cstring; cmp: cstring; arg2: cstring) {.
    importc, libprag.}

proc assertionMessageCmpstr*(domain: cstring; file: cstring; line: int;
    `func`: cstring; expr: cstring; arg1: cstring; cmp: cstring; arg2: cstring) =
  g_assertion_message_cmpstr(domain, file, int32(line), `func`, expr, arg1, cmp, arg2)

proc g_assertion_message_error(domain: cstring; file: cstring; line: int32;
    `func`: cstring; expr: cstring; error: ptr glib.Error; errorDomain: uint32;
    errorCode: int32) {.
    importc, libprag.}

proc assertionMessageError*(domain: cstring; file: cstring; line: int;
    `func`: cstring; expr: cstring; error: ptr glib.Error; errorDomain: int;
    errorCode: int) =
  g_assertion_message_error(domain, file, int32(line), `func`, expr, error, uint32(errorDomain), int32(errorCode))

proc atexit*(`func`: VoidFunc) {.
    importc: "g_atexit", libprag.}

proc g_atomic_int_add(atomic: ptr int32; val: int32): int32 {.
    importc, libprag.}

proc atomicIntAdd*(atomic: ptr int32; val: int): int =
  int(g_atomic_int_add(atomic, int32(val)))

proc g_atomic_int_and(atomic: ptr uint32; val: uint32): uint32 {.
    importc, libprag.}

proc atomicIntAnd*(atomic: ptr uint32; val: int): int =
  int(g_atomic_int_and(atomic, uint32(val)))

proc g_atomic_int_compare_and_exchange(atomic: ptr int32; oldval: int32;
    newval: int32): gboolean {.
    importc, libprag.}

proc atomicIntCompareAndExchange*(atomic: ptr int32; oldval: int; newval: int): bool =
  toBool(g_atomic_int_compare_and_exchange(atomic, int32(oldval), int32(newval)))

proc g_atomic_int_dec_and_test(atomic: ptr int32): gboolean {.
    importc, libprag.}

proc atomicIntDecAndTest*(atomic: ptr int32): bool =
  toBool(g_atomic_int_dec_and_test(atomic))

proc g_atomic_int_exchange_and_add(atomic: ptr int32; val: int32): int32 {.
    importc, libprag.}

proc atomicIntExchangeAndAdd*(atomic: ptr int32; val: int): int =
  int(g_atomic_int_exchange_and_add(atomic, int32(val)))

proc g_atomic_int_get(atomic: ptr int32): int32 {.
    importc, libprag.}

proc atomicIntGet*(atomic: ptr int32): int =
  int(g_atomic_int_get(atomic))

proc atomicIntInc*(atomic: ptr int32) {.
    importc: "g_atomic_int_inc", libprag.}

proc g_atomic_int_or(atomic: ptr uint32; val: uint32): uint32 {.
    importc, libprag.}

proc atomicIntOr*(atomic: ptr uint32; val: int): int =
  int(g_atomic_int_or(atomic, uint32(val)))

proc g_atomic_int_set(atomic: ptr int32; newval: int32) {.
    importc, libprag.}

proc atomicIntSet*(atomic: ptr int32; newval: int) =
  g_atomic_int_set(atomic, int32(newval))

proc g_atomic_int_xor(atomic: ptr uint32; val: uint32): uint32 {.
    importc, libprag.}

proc atomicIntXor*(atomic: ptr uint32; val: int): int =
  int(g_atomic_int_xor(atomic, uint32(val)))

proc atomicPointerAdd*(atomic: pointer; val: int64): int64 {.
    importc: "g_atomic_pointer_add", libprag.}

proc atomicPointerAnd*(atomic: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_and", libprag.}

proc g_atomic_pointer_compare_and_exchange(atomic: pointer; oldval: pointer;
    newval: pointer): gboolean {.
    importc, libprag.}

proc atomicPointerCompareAndExchange*(atomic: pointer; oldval: pointer;
    newval: pointer): bool =
  toBool(g_atomic_pointer_compare_and_exchange(atomic, oldval, newval))

proc atomicPointerGet*(atomic: pointer): pointer {.
    importc: "g_atomic_pointer_get", libprag.}

proc atomicPointerOr*(atomic: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_or", libprag.}

proc atomicPointerSet*(atomic: pointer; newval: pointer) {.
    importc: "g_atomic_pointer_set", libprag.}

proc atomicPointerXor*(atomic: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_xor", libprag.}

proc atomicRcBoxAcquire*(memBlock: pointer): pointer {.
    importc: "g_atomic_rc_box_acquire", libprag.}

proc atomicRcBoxAlloc*(blockSize: uint64): pointer {.
    importc: "g_atomic_rc_box_alloc", libprag.}

proc atomicRcBoxAlloc0*(blockSize: uint64): pointer {.
    importc: "g_atomic_rc_box_alloc0", libprag.}

proc atomicRcBoxDup*(blockSize: uint64; memBlock: pointer): pointer {.
    importc: "g_atomic_rc_box_dup", libprag.}

proc atomicRcBoxGetSize*(memBlock: pointer): uint64 {.
    importc: "g_atomic_rc_box_get_size", libprag.}

proc atomicRcBoxRelease*(memBlock: pointer) {.
    importc: "g_atomic_rc_box_release", libprag.}

proc atomicRcBoxReleaseFull*(memBlock: pointer; clearFunc: DestroyNotify) {.
    importc: "g_atomic_rc_box_release_full", libprag.}

proc g_atomic_ref_count_compare(arc: ptr int32; val: int32): gboolean {.
    importc, libprag.}

proc atomicRefCountCompare*(arc: ptr int32; val: int): bool =
  toBool(g_atomic_ref_count_compare(arc, int32(val)))

proc g_atomic_ref_count_dec(arc: ptr int32): gboolean {.
    importc, libprag.}

proc atomicRefCountDec*(arc: ptr int32): bool =
  toBool(g_atomic_ref_count_dec(arc))

proc atomicRefCountInc*(arc: ptr int32) {.
    importc: "g_atomic_ref_count_inc", libprag.}

proc atomicRefCountInit*(arc: ptr int32) {.
    importc: "g_atomic_ref_count_init", libprag.}

proc g_base64_decode(text: cstring; outLen: var uint64): ptr uint8 {.
    importc, libprag.}

proc base64Decode*(text: cstring; outLen: var uint64): seq[uint8] =
  let resul0 = g_base64_decode(text, outLen)
  result = uint8ArrayToSeq(resul0, outLen.int)
  cogfree(resul0)

proc g_base64_encode(data: ptr uint8; len: uint64): cstring {.
    importc, libprag.}

proc base64Encode*(data: seq[uint8] | string): string =
  let len = uint64(data.len)
  let resul0 = g_base64_encode(cast[ptr uint8](unsafeaddr(data[0])), len)
  result = $resul0
  cogfree(resul0)

proc g_basename(fileName: cstring): cstring {.
    importc, libprag.}

proc basename*(fileName: cstring): string =
  result = $g_basename(fileName)

proc g_bit_lock(address: ptr int32; lockBit: int32) {.
    importc, libprag.}

proc bitLock*(address: ptr int32; lockBit: int) =
  g_bit_lock(address, int32(lockBit))

proc g_bit_nth_lsf(mask: uint64; nthBit: int32): int32 {.
    importc, libprag.}

proc bitNthLsf*(mask: uint64; nthBit: int): int =
  int(g_bit_nth_lsf(mask, int32(nthBit)))

proc g_bit_nth_msf(mask: uint64; nthBit: int32): int32 {.
    importc, libprag.}

proc bitNthMsf*(mask: uint64; nthBit: int): int =
  int(g_bit_nth_msf(mask, int32(nthBit)))

proc g_bit_storage(number: uint64): uint32 {.
    importc, libprag.}

proc bitStorage*(number: uint64): int =
  int(g_bit_storage(number))

proc g_bit_trylock(address: ptr int32; lockBit: int32): gboolean {.
    importc, libprag.}

proc bitTrylock*(address: ptr int32; lockBit: int): bool =
  toBool(g_bit_trylock(address, int32(lockBit)))

proc g_bit_unlock(address: ptr int32; lockBit: int32) {.
    importc, libprag.}

proc bitUnlock*(address: ptr int32; lockBit: int) =
  g_bit_unlock(address, int32(lockBit))

proc g_build_filenamev(args: ptr cstring): cstring {.
    importc, libprag.}

proc buildFilenamev*(args: varargs[string, `$`]): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = g_build_filenamev(seq2CstringArray(args, fs469n23))
  result = $resul0
  cogfree(resul0)

proc g_build_pathv(separator: cstring; args: ptr cstring): cstring {.
    importc, libprag.}

proc buildPathv*(separator: cstring; args: varargs[string, `$`]): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = g_build_pathv(separator, seq2CstringArray(args, fs469n23))
  result = $resul0
  cogfree(resul0)

proc g_canonicalize_filename(filename: cstring; relativeTo: cstring): cstring {.
    importc, libprag.}

proc canonicalizeFilename*(filename: cstring; relativeTo: cstring = nil): string =
  let resul0 = g_canonicalize_filename(filename, relativeTo)
  result = $resul0
  cogfree(resul0)

proc g_chdir(path: cstring): int32 {.
    importc, libprag.}

proc chdir*(path: cstring): int =
  int(g_chdir(path))

proc glib_check_version(requiredMajor: uint32; requiredMinor: uint32; requiredMicro: uint32): cstring {.
    importc, libprag.}

proc checkVersion*(requiredMajor: int; requiredMinor: int; requiredMicro: int): string =
  result = $glib_check_version(uint32(requiredMajor), uint32(requiredMinor), uint32(requiredMicro))

proc g_child_watch_add_full(priority: int32; pid: int32; function: ChildWatchFunc;
    data: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc childWatchAdd*(priority: int; pid: int; function: ChildWatchFunc;
    data: pointer; notify: DestroyNotify): int =
  int(g_child_watch_add_full(int32(priority), int32(pid), function, data, notify))

proc g_child_watch_source_new(pid: int32): ptr Source00 {.
    importc, libprag.}

proc newChildWatchSource*(pid: int): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_child_watch_source_new(int32(pid))

proc clearError*(error: ptr ptr glib.Error = nil) {.
    importc: "g_clear_error", libprag.}

proc g_close(fd: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc close*(fd: int): bool =
  var gerror: ptr glib.Error
  let resul0 = g_close(int32(fd), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_compute_checksum_for_bytes(checksumType: ChecksumType; data: ptr Bytes00): cstring {.
    importc, libprag.}

proc computeChecksumForBytes*(checksumType: ChecksumType; data: Bytes): string =
  let resul0 = g_compute_checksum_for_bytes(checksumType, cast[ptr Bytes00](data.impl))
  result = $resul0
  cogfree(resul0)

proc g_compute_checksum_for_data(checksumType: ChecksumType; data: ptr uint8;
    length: uint64): cstring {.
    importc, libprag.}

proc computeChecksumForData*(checksumType: ChecksumType; data: seq[uint8] | string): string =
  let length = uint64(data.len)
  let resul0 = g_compute_checksum_for_data(checksumType, cast[ptr uint8](unsafeaddr(data[0])), length)
  result = $resul0
  cogfree(resul0)

proc g_compute_checksum_for_string(checksumType: ChecksumType; str: cstring;
    length: int64): cstring {.
    importc, libprag.}

proc computeChecksumForString*(checksumType: ChecksumType; str: cstring;
    length: int64): string =
  let resul0 = g_compute_checksum_for_string(checksumType, str, length)
  result = $resul0
  cogfree(resul0)

proc g_compute_hmac_for_bytes(digestType: ChecksumType; key: ptr Bytes00;
    data: ptr Bytes00): cstring {.
    importc, libprag.}

proc computeHmacForBytes*(digestType: ChecksumType; key: Bytes; data: Bytes): string =
  let resul0 = g_compute_hmac_for_bytes(digestType, cast[ptr Bytes00](key.impl), cast[ptr Bytes00](data.impl))
  result = $resul0
  cogfree(resul0)

proc g_compute_hmac_for_string(digestType: ChecksumType; key: ptr uint8;
    keyLen: uint64; str: cstring; length: int64): cstring {.
    importc, libprag.}

proc computeHmacForString*(digestType: ChecksumType; key: seq[uint8] | string;
    str: cstring; length: int64): string =
  let keyLen = uint64(key.len)
  let resul0 = g_compute_hmac_for_string(digestType, cast[ptr uint8](unsafeaddr(key[0])), keyLen, str, length)
  result = $resul0
  cogfree(resul0)

proc g_convert(str: ptr uint8; len: int64; toCodeset: cstring; fromCodeset: cstring;
    bytesRead: var uint64; bytesWritten: var uint64; error: ptr ptr glib.Error = nil): ptr uint8 {.
    importc, libprag.}

proc convert*(str: seq[uint8] | string; toCodeset: cstring; fromCodeset: cstring;
    bytesRead: var uint64 = cast[var uint64](nil); bytesWritten: var uint64 = cast[var uint64](nil)): seq[uint8] =
  let len = int64(str.len)
  var gerror: ptr glib.Error
  let resul0 = g_convert(cast[ptr uint8](unsafeaddr(str[0])), len, toCodeset, fromCodeset, bytesRead, bytesWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = uint8ArrayToSeq(resul0, len.int)
  cogfree(resul0)

proc g_convert_error_quark(): uint32 {.
    importc, libprag.}

proc convertErrorQuark*(): int =
  int(g_convert_error_quark())

proc g_convert_with_fallback(str: ptr uint8; len: int64; toCodeset: cstring;
    fromCodeset: cstring; fallback: cstring; bytesRead: var uint64; bytesWritten: var uint64;
    error: ptr ptr glib.Error = nil): ptr uint8 {.
    importc, libprag.}

proc convertWithFallback*(str: seq[uint8] | string; toCodeset: cstring;
    fromCodeset: cstring; fallback: cstring; bytesRead: var uint64 = cast[var uint64](nil);
    bytesWritten: var uint64 = cast[var uint64](nil)): seq[uint8] =
  let len = int64(str.len)
  var gerror: ptr glib.Error
  let resul0 = g_convert_with_fallback(cast[ptr uint8](unsafeaddr(str[0])), len, toCodeset, fromCodeset, fallback, bytesRead, bytesWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = uint8ArrayToSeq(resul0, len.int)
  cogfree(resul0)

proc datalistForeach*(datalist: Data; `func`: DataForeachFunc; userData: pointer) {.
    importc: "g_datalist_foreach", libprag.}

proc datalistGetData*(datalist: Data; key: cstring): pointer {.
    importc: "g_datalist_get_data", libprag.}

proc g_datalist_get_flags(datalist: Data): uint32 {.
    importc, libprag.}

proc datalistGetFlags*(datalist: Data): int =
  int(g_datalist_get_flags(datalist))

proc g_datalist_id_get_data(datalist: Data; keyId: uint32): pointer {.
    importc, libprag.}

proc datalistIdGetData*(datalist: Data; keyId: int): pointer =
  g_datalist_id_get_data(datalist, uint32(keyId))

proc g_datalist_set_flags(datalist: Data; flags: uint32) {.
    importc, libprag.}

proc datalistSetFlags*(datalist: Data; flags: int) =
  g_datalist_set_flags(datalist, uint32(flags))

proc g_datalist_unset_flags(datalist: Data; flags: uint32) {.
    importc, libprag.}

proc datalistUnsetFlags*(datalist: Data; flags: int) =
  g_datalist_unset_flags(datalist, uint32(flags))

proc datasetDestroy*(datasetLocation: pointer) {.
    importc: "g_dataset_destroy", libprag.}

proc datasetForeach*(datasetLocation: pointer; `func`: DataForeachFunc;
    userData: pointer) {.
    importc: "g_dataset_foreach", libprag.}

proc g_dataset_id_get_data(datasetLocation: pointer; keyId: uint32): pointer {.
    importc, libprag.}

proc datasetIdGetData*(datasetLocation: pointer; keyId: int): pointer =
  g_dataset_id_get_data(datasetLocation, uint32(keyId))

proc g_dcgettext(domain: cstring; msgid: cstring; category: int32): cstring {.
    importc, libprag.}

proc dcgettext*(domain: cstring = nil; msgid: cstring; category: int): string =
  result = $g_dcgettext(domain, msgid, int32(category))

proc g_dgettext(domain: cstring; msgid: cstring): cstring {.
    importc, libprag.}

proc dgettext*(domain: cstring = nil; msgid: cstring): string =
  result = $g_dgettext(domain, msgid)

proc g_direct_equal(v1: pointer; v2: pointer): gboolean {.
    importc, libprag.}

proc directEqual*(v1: pointer; v2: pointer): bool =
  toBool(g_direct_equal(v1, v2))

proc g_direct_hash(v: pointer): uint32 {.
    importc, libprag.}

proc directHash*(v: pointer): int =
  int(g_direct_hash(v))

proc g_dngettext(domain: cstring; msgid: cstring; msgidPlural: cstring; n: uint64): cstring {.
    importc, libprag.}

proc dngettext*(domain: cstring = nil; msgid: cstring; msgidPlural: cstring;
    n: uint64): string =
  result = $g_dngettext(domain, msgid, msgidPlural, n)

proc g_double_equal(v1: pointer; v2: pointer): gboolean {.
    importc, libprag.}

proc doubleEqual*(v1: pointer; v2: pointer): bool =
  toBool(g_double_equal(v1, v2))

proc g_double_hash(v: pointer): uint32 {.
    importc, libprag.}

proc doubleHash*(v: pointer): int =
  int(g_double_hash(v))

proc g_dpgettext(domain: cstring; msgctxtid: cstring; msgidoffset: uint64): cstring {.
    importc, libprag.}

proc dpgettext*(domain: cstring = nil; msgctxtid: cstring; msgidoffset: uint64): string =
  result = $g_dpgettext(domain, msgctxtid, msgidoffset)

proc g_dpgettext2(domain: cstring; context: cstring; msgid: cstring): cstring {.
    importc, libprag.}

proc dpgettext2*(domain: cstring = nil; context: cstring; msgid: cstring): string =
  result = $g_dpgettext2(domain, context, msgid)

proc g_environ_getenv(envp: ptr cstring; variable: cstring): cstring {.
    importc, libprag.}

proc environGetenv*(envp: openArray[string]; variable: cstring): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  result = $g_environ_getenv(seq2CstringArray(envp, fs469n23), variable)

proc g_environ_setenv(envp: ptr cstring; variable: cstring; value: cstring;
    overwrite: gboolean): ptr cstring {.
    importc, libprag.}

proc environSetenv*(envp: openArray[string]; variable: cstring; value: cstring;
    overwrite: bool): seq[string] =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = g_environ_setenv(seq2CstringArray(envp, fs469n23), variable, value, gboolean(overwrite))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_environ_unsetenv(envp: ptr cstring; variable: cstring): ptr cstring {.
    importc, libprag.}

proc environUnsetenv*(envp: openArray[string]; variable: cstring): seq[string] =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = g_environ_unsetenv(seq2CstringArray(envp, fs469n23), variable)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_file_error_from_errno(errNo: int32): FileError {.
    importc, libprag.}

proc fileErrorFromErrno*(errNo: int): FileError =
  g_file_error_from_errno(int32(errNo))

proc g_file_error_quark(): uint32 {.
    importc, libprag.}

proc fileErrorQuark*(): int =
  int(g_file_error_quark())

proc g_file_open_tmp(tmpl: cstring; nameUsed: var cstring; error: ptr ptr glib.Error = nil): int32 {.
    importc, libprag.}

proc fileOpenTmp*(tmpl: cstring = nil; nameUsed: var string): int =
  var gerror: ptr glib.Error
  var nameUsed_00: cstring
  let resul0 = g_file_open_tmp(tmpl, nameUsed_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int(resul0)
  if nameUsed.addr != nil:
    nameUsed = $(nameUsed_00)

proc g_file_read_link(filename: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc fileReadLink*(filename: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_file_read_link(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_file_set_contents(filename: cstring; contents: ptr uint8; length: int64;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc fileSetContents*(filename: cstring; contents: seq[uint8] | string): bool =
  let length = int64(contents.len)
  var gerror: ptr glib.Error
  let resul0 = g_file_set_contents(filename, cast[ptr uint8](unsafeaddr(contents[0])), length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_file_set_contents_full(filename: cstring; contents: ptr uint8; length: int64;
    flags: FileSetContentsFlags; mode: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc fileSetContentsFull*(filename: cstring; contents: seq[uint8] | string;
    flags: FileSetContentsFlags; mode: int): bool =
  let length = int64(contents.len)
  var gerror: ptr glib.Error
  let resul0 = g_file_set_contents_full(filename, cast[ptr uint8](unsafeaddr(contents[0])), length, flags, int32(mode), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_file_test(filename: cstring; test: FileTest): gboolean {.
    importc, libprag.}

proc fileTest*(filename: cstring; test: FileTest): bool =
  toBool(g_file_test(filename, test))

proc g_filename_display_basename(filename: cstring): cstring {.
    importc, libprag.}

proc filenameDisplayBasename*(filename: cstring): string =
  let resul0 = g_filename_display_basename(filename)
  result = $resul0
  cogfree(resul0)

proc g_filename_display_name(filename: cstring): cstring {.
    importc, libprag.}

proc filenameDisplayName*(filename: cstring): string =
  let resul0 = g_filename_display_name(filename)
  result = $resul0
  cogfree(resul0)

proc g_filename_from_uri(uri: cstring; hostname: var cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc filenameFromUri*(uri: cstring; hostname: var string = cast[var string](nil)): string =
  var gerror: ptr glib.Error
  var hostname_00: cstring
  let resul0 = g_filename_from_uri(uri, hostname_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)
  if hostname.addr != nil:
    hostname = $(hostname_00)

proc g_filename_from_utf8(utf8string: cstring; len: int64; bytesRead: var uint64;
    bytesWritten: var uint64; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc filenameFromUtf8*(utf8string: cstring; len: int64; bytesRead: var uint64 = cast[var uint64](nil);
    bytesWritten: var uint64 = cast[var uint64](nil)): string =
  var gerror: ptr glib.Error
  let resul0 = g_filename_from_utf8(utf8string, len, bytesRead, bytesWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_filename_to_uri(filename: cstring; hostname: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc filenameToUri*(filename: cstring; hostname: cstring = nil): string =
  var gerror: ptr glib.Error
  let resul0 = g_filename_to_uri(filename, hostname, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_filename_to_utf8(opsysstring: cstring; len: int64; bytesRead: var uint64;
    bytesWritten: var uint64; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc filenameToUtf8*(opsysstring: cstring; len: int64; bytesRead: var uint64 = cast[var uint64](nil);
    bytesWritten: var uint64 = cast[var uint64](nil)): string =
  var gerror: ptr glib.Error
  let resul0 = g_filename_to_utf8(opsysstring, len, bytesRead, bytesWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_find_program_in_path(program: cstring): cstring {.
    importc, libprag.}

proc findProgramInPath*(program: cstring): string =
  let resul0 = g_find_program_in_path(program)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_format_size(size: uint64): cstring {.
    importc, libprag.}

proc formatSize*(size: uint64): string =
  let resul0 = g_format_size(size)
  result = $resul0
  cogfree(resul0)

proc g_format_size_for_display(size: int64): cstring {.
    importc, libprag.}

proc formatSizeForDisplay*(size: int64): string =
  let resul0 = g_format_size_for_display(size)
  result = $resul0
  cogfree(resul0)

proc g_format_size_full(size: uint64; flags: FormatSizeFlags): cstring {.
    importc, libprag.}

proc formatSizeFull*(size: uint64; flags: FormatSizeFlags): string =
  let resul0 = g_format_size_full(size, flags)
  result = $resul0
  cogfree(resul0)

proc g_free(mem: pointer) {.
    importc, libprag.}

proc free*(mem: pointer) =
  g_free(mem)

proc g_get_application_name(): cstring {.
    importc, libprag.}

proc getApplicationName*(): string =
  let resul0 = g_get_application_name()
  if resul0.isNil:
    return
  result = $resul0

proc g_get_charset(charset: var cstring): gboolean {.
    importc, libprag.}

proc getCharset*(charset: var string = cast[var string](nil)): bool =
  var charset_00: cstring
  result = toBool(g_get_charset(charset_00))
  if charset.addr != nil:
    charset = $(charset_00)

proc charset*(charset: var string = cast[var string](nil)): bool =
  var charset_00: cstring
  result = toBool(g_get_charset(charset_00))
  if charset.addr != nil:
    charset = $(charset_00)

proc g_get_codeset(): cstring {.
    importc, libprag.}

proc getCodeset*(): string =
  let resul0 = g_get_codeset()
  result = $resul0
  cogfree(resul0)

proc g_get_console_charset(charset: var cstring): gboolean {.
    importc, libprag.}

proc getConsoleCharset*(charset: var string = cast[var string](nil)): bool =
  var charset_00: cstring
  result = toBool(g_get_console_charset(charset_00))
  if charset.addr != nil:
    charset = $(charset_00)

proc consoleCharset*(charset: var string = cast[var string](nil)): bool =
  var charset_00: cstring
  result = toBool(g_get_console_charset(charset_00))
  if charset.addr != nil:
    charset = $(charset_00)

proc g_get_current_dir(): cstring {.
    importc, libprag.}

proc getCurrentDir*(): string =
  let resul0 = g_get_current_dir()
  result = $resul0
  cogfree(resul0)

proc getCurrentTime*(resu: TimeVal) {.
    importc: "g_get_current_time", libprag.}

proc g_get_environ(): ptr cstring {.
    importc, libprag.}

proc getEnviron*(): seq[string] =
  let resul0 = g_get_environ()
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_get_filename_charsets(filenameCharsets: var ptr cstring): gboolean {.
    importc, libprag.}

proc getFilenameCharsets*(filenameCharsets: var seq[string]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var filenameCharsets_00 = seq2CstringArray(filenameCharsets, fs469n23)
  result = toBool(g_get_filename_charsets(filenameCharsets_00))
  if filenameCharsets.addr != nil:
    filenameCharsets = cstringArrayToSeq(filenameCharsets_00)

proc filenameCharsets*(filenameCharsets: var seq[string]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var filenameCharsets_00 = seq2CstringArray(filenameCharsets, fs469n23)
  result = toBool(g_get_filename_charsets(filenameCharsets_00))
  if filenameCharsets.addr != nil:
    filenameCharsets = cstringArrayToSeq(filenameCharsets_00)

proc g_get_home_dir(): cstring {.
    importc, libprag.}

proc getHomeDir*(): string =
  result = $g_get_home_dir()

proc g_get_host_name(): cstring {.
    importc, libprag.}

proc getHostName*(): string =
  result = $g_get_host_name()

proc g_get_language_names(): ptr cstring {.
    importc, libprag.}

proc getLanguageNames*(): seq[string] =
  cstringArrayToSeq(g_get_language_names())

proc g_get_language_names_with_category(categoryName: cstring): ptr cstring {.
    importc, libprag.}

proc getLanguageNamesWithCategory*(categoryName: cstring): seq[string] =
  cstringArrayToSeq(g_get_language_names_with_category(categoryName))

proc languageNamesWithCategory*(categoryName: cstring): seq[string] =
  cstringArrayToSeq(g_get_language_names_with_category(categoryName))

proc g_get_locale_variants(locale: cstring): ptr cstring {.
    importc, libprag.}

proc getLocaleVariants*(locale: cstring): seq[string] =
  let resul0 = g_get_locale_variants(locale)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc localeVariants*(locale: cstring): seq[string] =
  let resul0 = g_get_locale_variants(locale)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc getMonotonicTime*(): int64 {.
    importc: "g_get_monotonic_time", libprag.}

proc g_get_num_processors(): uint32 {.
    importc, libprag.}

proc getNumProcessors*(): int =
  int(g_get_num_processors())

proc g_get_os_info(keyName: cstring): cstring {.
    importc, libprag.}

proc getOsInfo*(keyName: cstring): string =
  let resul0 = g_get_os_info(keyName)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc osInfo*(keyName: cstring): string =
  let resul0 = g_get_os_info(keyName)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_get_prgname(): cstring {.
    importc, libprag.}

proc getPrgname*(): string =
  let resul0 = g_get_prgname()
  if resul0.isNil:
    return
  result = $resul0

proc g_get_real_name(): cstring {.
    importc, libprag.}

proc getRealName*(): string =
  result = $g_get_real_name()

proc getRealTime*(): int64 {.
    importc: "g_get_real_time", libprag.}

proc g_get_system_config_dirs(): ptr cstring {.
    importc, libprag.}

proc getSystemConfigDirs*(): seq[string] =
  cstringArrayToSeq(g_get_system_config_dirs())

proc g_get_system_data_dirs(): ptr cstring {.
    importc, libprag.}

proc getSystemDataDirs*(): seq[string] =
  cstringArrayToSeq(g_get_system_data_dirs())

proc g_get_tmp_dir(): cstring {.
    importc, libprag.}

proc getTmpDir*(): string =
  result = $g_get_tmp_dir()

proc g_get_user_cache_dir(): cstring {.
    importc, libprag.}

proc getUserCacheDir*(): string =
  result = $g_get_user_cache_dir()

proc g_get_user_config_dir(): cstring {.
    importc, libprag.}

proc getUserConfigDir*(): string =
  result = $g_get_user_config_dir()

proc g_get_user_data_dir(): cstring {.
    importc, libprag.}

proc getUserDataDir*(): string =
  result = $g_get_user_data_dir()

proc g_get_user_name(): cstring {.
    importc, libprag.}

proc getUserName*(): string =
  result = $g_get_user_name()

proc g_get_user_runtime_dir(): cstring {.
    importc, libprag.}

proc getUserRuntimeDir*(): string =
  result = $g_get_user_runtime_dir()

proc g_get_user_special_dir(directory: UserDirectory): cstring {.
    importc, libprag.}

proc getUserSpecialDir*(directory: UserDirectory): string =
  result = $g_get_user_special_dir(directory)

proc userSpecialDir*(directory: UserDirectory): string =
  result = $g_get_user_special_dir(directory)

proc g_getenv(variable: cstring): cstring {.
    importc, libprag.}

proc getenv*(variable: cstring): string =
  result = $g_getenv(variable)

proc env*(variable: cstring): string =
  result = $g_getenv(variable)

proc g_hostname_is_ascii_encoded(hostname: cstring): gboolean {.
    importc, libprag.}

proc hostnameIsAsciiEncoded*(hostname: cstring): bool =
  toBool(g_hostname_is_ascii_encoded(hostname))

proc g_hostname_is_ip_address(hostname: cstring): gboolean {.
    importc, libprag.}

proc hostnameIsIpAddress*(hostname: cstring): bool =
  toBool(g_hostname_is_ip_address(hostname))

proc g_hostname_is_non_ascii(hostname: cstring): gboolean {.
    importc, libprag.}

proc hostnameIsNonAscii*(hostname: cstring): bool =
  toBool(g_hostname_is_non_ascii(hostname))

proc g_hostname_to_ascii(hostname: cstring): cstring {.
    importc, libprag.}

proc hostnameToAscii*(hostname: cstring): string =
  let resul0 = g_hostname_to_ascii(hostname)
  result = $resul0
  cogfree(resul0)

proc g_hostname_to_unicode(hostname: cstring): cstring {.
    importc, libprag.}

proc hostnameToUnicode*(hostname: cstring): string =
  let resul0 = g_hostname_to_unicode(hostname)
  result = $resul0
  cogfree(resul0)

proc g_idle_add_full*(priority: int32; function: SourceFunc; data: pointer;
    notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc idleAdd*(priority: int; function: SourceFunc; data: pointer;
    notify: DestroyNotify): int =
  int(g_idle_add_full(int32(priority), function, data, notify))

proc g_idle_remove_by_data(data: pointer): gboolean {.
    importc, libprag.}

proc idleRemoveByData*(data: pointer): bool =
  toBool(g_idle_remove_by_data(data))

proc g_idle_source_new(): ptr Source00 {.
    importc, libprag.}

proc newIdleSource*(): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_idle_source_new()

proc g_int64_equal(v1: pointer; v2: pointer): gboolean {.
    importc, libprag.}

proc int64Equal*(v1: pointer; v2: pointer): bool =
  toBool(g_int64_equal(v1, v2))

proc g_int64_hash(v: pointer): uint32 {.
    importc, libprag.}

proc int64Hash*(v: pointer): int =
  int(g_int64_hash(v))

proc g_int_equal(v1: pointer; v2: pointer): gboolean {.
    importc, libprag.}

proc intEqual*(v1: pointer; v2: pointer): bool =
  toBool(g_int_equal(v1, v2))

proc g_int_hash(v: pointer): uint32 {.
    importc, libprag.}

proc intHash*(v: pointer): int =
  int(g_int_hash(v))

proc g_intern_static_string(string: cstring): cstring {.
    importc, libprag.}

proc internStaticString*(string: cstring = nil): string =
  result = $g_intern_static_string(string)

proc g_intern_string(string: cstring): cstring {.
    importc, libprag.}

proc internString*(string: cstring = nil): string =
  result = $g_intern_string(string)

proc g_io_add_watch_full*(channel: ptr IOChannel00; priority: int32; condition: IOCondition;
    `func`: IOFunc; userData: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc ioAddWatch*(channel: IOChannel; priority: int; condition: IOCondition;
    `func`: IOFunc; userData: pointer; notify: DestroyNotify): int =
  int(g_io_add_watch_full(cast[ptr IOChannel00](channel.impl), int32(priority), condition, `func`, userData, notify))

proc g_io_create_watch(channel: ptr IOChannel00; condition: IOCondition): ptr Source00 {.
    importc, libprag.}

proc ioCreateWatch*(channel: IOChannel; condition: IOCondition): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_io_create_watch(cast[ptr IOChannel00](channel.impl), condition)

proc g_listenv(): ptr cstring {.
    importc, libprag.}

proc listenv*(): seq[string] =
  let resul0 = g_listenv()
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc g_locale_from_utf8(utf8string: cstring; len: int64; bytesRead: var uint64;
    bytesWritten: var uint64; error: ptr ptr glib.Error = nil): ptr uint8 {.
    importc, libprag.}

proc localeFromUtf8*(utf8string: cstring; len: int64; bytesRead: var uint64 = cast[var uint64](nil);
    bytesWritten: var uint64 = cast[var uint64](nil)): seq[uint8] =
  var gerror: ptr glib.Error
  let resul0 = g_locale_from_utf8(utf8string, len, bytesRead, bytesWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = uint8ArrayToSeq(resul0, bytesWritten.int)
  cogfree(resul0)

proc g_locale_to_utf8(opsysstring: ptr uint8; len: int64; bytesRead: var uint64;
    bytesWritten: var uint64; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc localeToUtf8*(opsysstring: seq[uint8] | string; bytesRead: var uint64 = cast[var uint64](nil);
    bytesWritten: var uint64 = cast[var uint64](nil)): string =
  let len = int64(opsysstring.len)
  var gerror: ptr glib.Error
  let resul0 = g_locale_to_utf8(cast[ptr uint8](unsafeaddr(opsysstring[0])), len, bytesRead, bytesWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc logDefaultHandler*(logDomain: cstring; logLevel: LogLevelFlags; message: cstring;
    unusedData: pointer) {.
    importc: "g_log_default_handler", libprag.}

proc g_log_remove_handler(logDomain: cstring; handlerId: uint32) {.
    importc, libprag.}

proc logRemoveHandler*(logDomain: cstring; handlerId: int) =
  g_log_remove_handler(logDomain, uint32(handlerId))

proc logSetAlwaysFatal*(fatalMask: LogLevelFlags): LogLevelFlags {.
    importc: "g_log_set_always_fatal", libprag.}

proc logSetFatalMask*(logDomain: cstring; fatalMask: LogLevelFlags): LogLevelFlags {.
    importc: "g_log_set_fatal_mask", libprag.}

proc g_log_set_handler_full(logDomain: cstring; logLevels: LogLevelFlags;
    logFunc: LogFunc; userData: pointer; destroy: DestroyNotify): uint32 {.
    importc, libprag.}

proc logSetHandler*(logDomain: cstring = nil; logLevels: LogLevelFlags;
    logFunc: LogFunc; userData: pointer; destroy: DestroyNotify): int =
  int(g_log_set_handler_full(logDomain, logLevels, logFunc, userData, destroy))

proc logSetWriterFunc*(`func`: LogWriterFunc; userData: pointer; userDataFree: DestroyNotify) {.
    importc: "g_log_set_writer_func", libprag.}

proc logStructuredArray*(logLevel: LogLevelFlags; fields: ptr LogField;
    nFields: uint64) {.
    importc: "g_log_structured_array", libprag.}

proc g_log_variant(logDomain: cstring; logLevel: LogLevelFlags; fields: ptr Variant00) {.
    importc, libprag.}

proc logVariant*(logDomain: cstring = nil; logLevel: LogLevelFlags; fields: Variant) =
  g_log_variant(logDomain, logLevel, cast[ptr Variant00](fields.impl))

proc logWriterDefault*(logLevel: LogLevelFlags; fields: ptr LogField;
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_default", libprag.}

proc g_log_writer_format_fields(logLevel: LogLevelFlags; fields: ptr LogField;
    nFields: uint64; useColor: gboolean): cstring {.
    importc, libprag.}

proc logWriterFormatFields*(logLevel: LogLevelFlags; fields: ptr LogField;
    nFields: uint64; useColor: bool): string =
  let resul0 = g_log_writer_format_fields(logLevel, fields, nFields, gboolean(useColor))
  result = $resul0
  cogfree(resul0)

proc g_log_writer_is_journald(outputFd: int32): gboolean {.
    importc, libprag.}

proc logWriterIsJournald*(outputFd: int): bool =
  toBool(g_log_writer_is_journald(int32(outputFd)))

proc logWriterJournald*(logLevel: LogLevelFlags; fields: ptr LogField;
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_journald", libprag.}

proc logWriterStandardStreams*(logLevel: LogLevelFlags; fields: ptr LogField;
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_standard_streams", libprag.}

proc g_log_writer_supports_color(outputFd: int32): gboolean {.
    importc, libprag.}

proc logWriterSupportsColor*(outputFd: int): bool =
  toBool(g_log_writer_supports_color(int32(outputFd)))

proc g_main_current_source(): ptr Source00 {.
    importc, libprag.}

proc mainCurrentSource*(): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_main_current_source()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_source_get_type(), result.impl))

proc g_main_depth(): int32 {.
    importc, libprag.}

proc mainDepth*(): int =
  int(g_main_depth())

proc malloc*(nBytes: uint64): pointer {.
    importc: "g_malloc", libprag.}

proc malloc0*(nBytes: uint64): pointer {.
    importc: "g_malloc0", libprag.}

proc malloc0N*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_malloc0_n", libprag.}

proc mallocN*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_malloc_n", libprag.}

proc g_markup_error_quark(): uint32 {.
    importc, libprag.}

proc markupErrorQuark*(): int =
  int(g_markup_error_quark())

proc g_markup_escape_text(text: cstring; length: int64): cstring {.
    importc, libprag.}

proc markupEscapeText*(text: cstring; length: int64): string =
  let resul0 = g_markup_escape_text(text, length)
  result = $resul0
  cogfree(resul0)

proc g_mem_is_system_malloc(): gboolean {.
    importc, libprag.}

proc memIsSystemMalloc*(): bool =
  toBool(g_mem_is_system_malloc())

proc memProfile*() {.
    importc: "g_mem_profile", libprag.}

proc g_mem_set_vtable(vtable: ptr MemVTable00) {.
    importc, libprag.}

proc memSetVtable*(vtable: MemVTable) =
  g_mem_set_vtable(cast[ptr MemVTable00](vtable.impl))

proc g_memdup(mem: pointer; byteSize: uint32): pointer {.
    importc, libprag.}

proc memdup*(mem: pointer; byteSize: int): pointer =
  g_memdup(mem, uint32(byteSize))

proc g_mkdir_with_parents(pathname: cstring; mode: int32): int32 {.
    importc, libprag.}

proc mkdirWithParents*(pathname: cstring; mode: int): int =
  int(g_mkdir_with_parents(pathname, int32(mode)))

proc nullifyPointer*(nullifyLocation: pointer) {.
    importc: "g_nullify_pointer", libprag.}

proc g_number_parser_error_quark(): uint32 {.
    importc, libprag.}

proc numberParserErrorQuark*(): int =
  int(g_number_parser_error_quark())

proc onErrorQuery*(prgName: cstring) {.
    importc: "g_on_error_query", libprag.}

proc onErrorStackTrace*(prgName: cstring) {.
    importc: "g_on_error_stack_trace", libprag.}

proc g_option_error_quark(): uint32 {.
    importc, libprag.}

proc optionErrorQuark*(): int =
  int(g_option_error_quark())

proc g_parse_debug_string(string: cstring; keys: ptr DebugKey; nkeys: uint32): uint32 {.
    importc, libprag.}

proc parseDebugString*(string: cstring = nil; keys: ptr DebugKey; nkeys: int): int =
  int(g_parse_debug_string(string, keys, uint32(nkeys)))

proc g_path_get_basename(fileName: cstring): cstring {.
    importc, libprag.}

proc pathGetBasename*(fileName: cstring): string =
  let resul0 = g_path_get_basename(fileName)
  result = $resul0
  cogfree(resul0)

proc g_path_get_dirname(fileName: cstring): cstring {.
    importc, libprag.}

proc pathGetDirname*(fileName: cstring): string =
  let resul0 = g_path_get_dirname(fileName)
  result = $resul0
  cogfree(resul0)

proc g_path_is_absolute(fileName: cstring): gboolean {.
    importc, libprag.}

proc pathIsAbsolute*(fileName: cstring): bool =
  toBool(g_path_is_absolute(fileName))

proc g_path_skip_root(fileName: cstring): cstring {.
    importc, libprag.}

proc pathSkipRoot*(fileName: cstring): string =
  let resul0 = g_path_skip_root(fileName)
  if resul0.isNil:
    return
  result = $resul0

proc g_pattern_match(pspec: ptr PatternSpec00; stringLength: uint32; string: cstring;
    stringReversed: cstring): gboolean {.
    importc, libprag.}

proc patternMatch*(pspec: PatternSpec; stringLength: int; string: cstring;
    stringReversed: cstring = nil): bool =
  toBool(g_pattern_match(cast[ptr PatternSpec00](pspec.impl), uint32(stringLength), string, stringReversed))

proc g_pattern_match_simple(pattern: cstring; string: cstring): gboolean {.
    importc, libprag.}

proc patternMatchSimple*(pattern: cstring; string: cstring): bool =
  toBool(g_pattern_match_simple(pattern, string))

proc g_pattern_match_string(pspec: ptr PatternSpec00; string: cstring): gboolean {.
    importc, libprag.}

proc patternMatchString*(pspec: PatternSpec; string: cstring): bool =
  toBool(g_pattern_match_string(cast[ptr PatternSpec00](pspec.impl), string))

proc g_pointer_bit_lock(address: pointer; lockBit: int32) {.
    importc, libprag.}

proc pointerBitLock*(address: pointer; lockBit: int) =
  g_pointer_bit_lock(address, int32(lockBit))

proc g_pointer_bit_trylock(address: pointer; lockBit: int32): gboolean {.
    importc, libprag.}

proc pointerBitTrylock*(address: pointer; lockBit: int): bool =
  toBool(g_pointer_bit_trylock(address, int32(lockBit)))

proc g_pointer_bit_unlock(address: pointer; lockBit: int32) {.
    importc, libprag.}

proc pointerBitUnlock*(address: pointer; lockBit: int) =
  g_pointer_bit_unlock(address, int32(lockBit))

proc g_poll(fds: PollFD; nfds: uint32; timeout: int32): int32 {.
    importc, libprag.}

proc poll*(fds: PollFD; nfds: int; timeout: int): int =
  int(g_poll(fds, uint32(nfds), int32(timeout)))

proc propagateError*(dest: var ptr glib.Error; src: ptr glib.Error) {.
    importc: "g_propagate_error", libprag.}

proc g_quark_from_static_string*(string: cstring): uint32 {.
    importc, libprag.}

proc quarkFromStaticString*(string: cstring = nil): int =
  int(g_quark_from_static_string(string))

proc g_quark_from_string(string: cstring): uint32 {.
    importc, libprag.}

proc quarkFromString*(string: cstring = nil): int =
  int(g_quark_from_string(string))

proc g_quark_to_string(quark: uint32): cstring {.
    importc, libprag.}

proc quarkToString*(quark: int): string =
  result = $g_quark_to_string(uint32(quark))

proc g_quark_try_string*(string: cstring): uint32 {.
    importc, libprag.}

proc quarkTryString*(string: cstring = nil): int =
  int(g_quark_try_string(string))

proc randomDouble*(): cdouble {.
    importc: "g_random_double", libprag.}

proc randomDoubleRange*(begin: cdouble; `end`: cdouble): cdouble {.
    importc: "g_random_double_range", libprag.}

proc g_random_int(): uint32 {.
    importc, libprag.}

proc randomInt*(): int =
  int(g_random_int())

proc g_random_int_range(begin: int32; `end`: int32): int32 {.
    importc, libprag.}

proc randomIntRange*(begin: int; `end`: int): int =
  int(g_random_int_range(int32(begin), int32(`end`)))

proc g_random_set_seed(seed: uint32) {.
    importc, libprag.}

proc randomSetSeed*(seed: int) =
  g_random_set_seed(uint32(seed))

proc rcBoxAcquire*(memBlock: pointer): pointer {.
    importc: "g_rc_box_acquire", libprag.}

proc rcBoxAlloc*(blockSize: uint64): pointer {.
    importc: "g_rc_box_alloc", libprag.}

proc rcBoxAlloc0*(blockSize: uint64): pointer {.
    importc: "g_rc_box_alloc0", libprag.}

proc rcBoxDup*(blockSize: uint64; memBlock: pointer): pointer {.
    importc: "g_rc_box_dup", libprag.}

proc rcBoxGetSize*(memBlock: pointer): uint64 {.
    importc: "g_rc_box_get_size", libprag.}

proc rcBoxRelease*(memBlock: pointer) {.
    importc: "g_rc_box_release", libprag.}

proc rcBoxReleaseFull*(memBlock: pointer; clearFunc: DestroyNotify) {.
    importc: "g_rc_box_release_full", libprag.}

proc realloc*(mem: pointer; nBytes: uint64): pointer {.
    importc: "g_realloc", libprag.}

proc reallocN*(mem: pointer; nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_realloc_n", libprag.}

proc g_ref_count_compare(rc: ptr int32; val: int32): gboolean {.
    importc, libprag.}

proc refCountCompare*(rc: ptr int32; val: int): bool =
  toBool(g_ref_count_compare(rc, int32(val)))

proc g_ref_count_dec(rc: ptr int32): gboolean {.
    importc, libprag.}

proc refCountDec*(rc: ptr int32): bool =
  toBool(g_ref_count_dec(rc))

proc refCountInc*(rc: ptr int32) {.
    importc: "g_ref_count_inc", libprag.}

proc refCountInit*(rc: ptr int32) {.
    importc: "g_ref_count_init", libprag.}

proc g_ref_string_acquire(str: cstring): cstring {.
    importc, libprag.}

proc refStringAcquire*(str: cstring): string =
  let resul0 = g_ref_string_acquire(str)
  result = $resul0
  cogfree(resul0)

proc refStringLength*(str: cstring): uint64 {.
    importc: "g_ref_string_length", libprag.}

proc g_ref_string_new(str: cstring): cstring {.
    importc, libprag.}

proc refStringNew*(str: cstring): string =
  let resul0 = g_ref_string_new(str)
  result = $resul0
  cogfree(resul0)

proc g_ref_string_new_intern(str: cstring): cstring {.
    importc, libprag.}

proc refStringNewIntern*(str: cstring): string =
  let resul0 = g_ref_string_new_intern(str)
  result = $resul0
  cogfree(resul0)

proc g_ref_string_new_len(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc refStringNewLen*(str: cstring; len: int64): string =
  let resul0 = g_ref_string_new_len(str, len)
  result = $resul0
  cogfree(resul0)

proc refStringRelease*(str: cstring) {.
    importc: "g_ref_string_release", libprag.}

proc reloadUserSpecialDirsCache*() {.
    importc: "g_reload_user_special_dirs_cache", libprag.}

proc g_rmdir(filename: cstring): int32 {.
    importc, libprag.}

proc rmdir*(filename: cstring): int =
  int(g_rmdir(filename))

proc setApplicationName*(applicationName: cstring) {.
    importc: "g_set_application_name", libprag.}

proc g_set_error_literal(err: var ptr glib.Error; domain: uint32; code: int32;
    message: cstring) {.
    importc, libprag.}

proc setErrorLiteral*(err: var ptr glib.Error = cast[var ptr glib.Error](nil);
    domain: int; code: int; message: cstring) =
  g_set_error_literal(err, uint32(domain), int32(code), message)

proc setPrgname*(prgname: cstring) {.
    importc: "g_set_prgname", libprag.}

proc g_setenv(variable: cstring; value: cstring; overwrite: gboolean): gboolean {.
    importc, libprag.}

proc setenv*(variable: cstring; value: cstring; overwrite: bool): bool =
  toBool(g_setenv(variable, value, gboolean(overwrite)))

proc g_shell_error_quark(): uint32 {.
    importc, libprag.}

proc shellErrorQuark*(): int =
  int(g_shell_error_quark())

proc g_shell_parse_argv(commandLine: cstring; argcp: var int32; argvp: var ptr cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc shellParseArgv*(commandLine: cstring; argcp: var int = cast[var int](nil);
    argvp: var seq[string] = cast[var seq[string]](nil)): bool =
  var gerror: ptr glib.Error
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var argvp_00 = seq2CstringArray(argvp, fs469n23)
  var argcp_00: int32
  let resul0 = g_shell_parse_argv(commandLine, argcp_00, argvp_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if argvp.addr != nil:
    argvp = cstringArrayToSeq(argvp_00)
  if argcp.addr != nil:
    argcp = int(argcp_00)

proc g_shell_quote(unquotedString: cstring): cstring {.
    importc, libprag.}

proc shellQuote*(unquotedString: cstring): string =
  let resul0 = g_shell_quote(unquotedString)
  result = $resul0
  cogfree(resul0)

proc g_shell_unquote(quotedString: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc shellUnquote*(quotedString: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = g_shell_unquote(quotedString, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc sliceAlloc*(blockSize: uint64): pointer {.
    importc: "g_slice_alloc", libprag.}

proc sliceAlloc0*(blockSize: uint64): pointer {.
    importc: "g_slice_alloc0", libprag.}

proc sliceCopy*(blockSize: uint64; memBlock: pointer): pointer {.
    importc: "g_slice_copy", libprag.}

proc sliceFree1*(blockSize: uint64; memBlock: pointer) {.
    importc: "g_slice_free1", libprag.}

proc sliceFreeChainWithOffset*(blockSize: uint64; memChain: pointer;
    nextOffset: uint64) {.
    importc: "g_slice_free_chain_with_offset", libprag.}

proc sliceGetConfig*(ckey: SliceConfig): int64 {.
    importc: "g_slice_get_config", libprag.}

proc sliceGetConfigState*(ckey: SliceConfig; address: int64; nValues: ptr uint32): ptr int64 {.
    importc: "g_slice_get_config_state", libprag.}

proc sliceSetConfig*(ckey: SliceConfig; value: int64) {.
    importc: "g_slice_set_config", libprag.}

proc g_spaced_primes_closest(num: uint32): uint32 {.
    importc, libprag.}

proc spacedPrimesClosest*(num: int): int =
  int(g_spaced_primes_closest(uint32(num)))

proc g_spawn_async(workingDirectory: cstring; argv: ptr cstring; envp: ptr cstring;
    flags: SpawnFlags; childSetup: SpawnChildSetupFunc; userData: pointer;
    childPid: var int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc spawnAsync*(workingDirectory: cstring = nil; argv: openArray[string];
    envp: openArray[string]; flags: SpawnFlags; childSetup: SpawnChildSetupFunc;
    userData: pointer; childPid: var int = cast[var int](nil)): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var gerror: ptr glib.Error
  var childPid_00: int32
  let resul0 = g_spawn_async(workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envp, fs469n232), flags, childSetup, userData, childPid_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if childPid.addr != nil:
    childPid = int(childPid_00)

proc g_spawn_async_with_fds(workingDirectory: cstring; argv: ptr cstring;
    envp: ptr cstring; flags: SpawnFlags; childSetup: SpawnChildSetupFunc;
    userData: pointer; childPid: var int32; stdinFd: int32; stdoutFd: int32;
    stderrFd: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc spawnAsyncWithFds*(workingDirectory: cstring = nil; argv: openArray[string];
    envp: openArray[string]; flags: SpawnFlags; childSetup: SpawnChildSetupFunc;
    userData: pointer; childPid: var int = cast[var int](nil); stdinFd: int;
    stdoutFd: int; stderrFd: int): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var gerror: ptr glib.Error
  var childPid_00: int32
  let resul0 = g_spawn_async_with_fds(workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envp, fs469n232), flags, childSetup, userData, childPid_00, int32(stdinFd), int32(stdoutFd), int32(stderrFd), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if childPid.addr != nil:
    childPid = int(childPid_00)

proc g_spawn_async_with_pipes(workingDirectory: cstring; argv: ptr cstring;
    envp: ptr cstring; flags: SpawnFlags; childSetup: SpawnChildSetupFunc;
    userData: pointer; childPid: var int32; standardInput: var int32; standardOutput: var int32;
    standardError: var int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc spawnAsyncWithPipes*(workingDirectory: cstring = nil; argv: openArray[string];
    envp: openArray[string]; flags: SpawnFlags; childSetup: SpawnChildSetupFunc;
    userData: pointer; childPid: var int = cast[var int](nil); standardInput: var int = cast[var int](nil);
    standardOutput: var int = cast[var int](nil); standardError: var int = cast[var int](nil)): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var gerror: ptr glib.Error
  var childPid_00: int32
  var standardInput_00: int32
  var standardOutput_00: int32
  var standardError_00: int32
  let resul0 = g_spawn_async_with_pipes(workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envp, fs469n232), flags, childSetup, userData, childPid_00, standardInput_00, standardOutput_00, standardError_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if childPid.addr != nil:
    childPid = int(childPid_00)
  if standardInput.addr != nil:
    standardInput = int(standardInput_00)
  if standardOutput.addr != nil:
    standardOutput = int(standardOutput_00)
  if standardError.addr != nil:
    standardError = int(standardError_00)

proc g_spawn_check_exit_status(exitStatus: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc spawnCheckExitStatus*(exitStatus: int): bool =
  var gerror: ptr glib.Error
  let resul0 = g_spawn_check_exit_status(int32(exitStatus), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_spawn_close_pid(pid: int32) {.
    importc, libprag.}

proc spawnClosePid*(pid: int) =
  g_spawn_close_pid(int32(pid))

proc g_spawn_command_line_async(commandLine: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc spawnCommandLineAsync*(commandLine: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = g_spawn_command_line_async(commandLine, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_spawn_error_quark(): uint32 {.
    importc, libprag.}

proc spawnErrorQuark*(): int =
  int(g_spawn_error_quark())

proc g_spawn_exit_error_quark(): uint32 {.
    importc, libprag.}

proc spawnExitErrorQuark*(): int =
  int(g_spawn_exit_error_quark())

proc g_stpcpy(dest: cstring; src: cstring): cstring {.
    importc, libprag.}

proc stpcpy*(dest: cstring; src: cstring): string =
  let resul0 = g_stpcpy(dest, src)
  result = $resul0
  cogfree(resul0)

proc g_str_equal(v1: pointer; v2: pointer): gboolean {.
    importc, libprag.}

proc strEqual*(v1: pointer; v2: pointer): bool =
  toBool(g_str_equal(v1, v2))

proc g_str_has_prefix(str: cstring; prefix: cstring): gboolean {.
    importc, libprag.}

proc strHasPrefix*(str: cstring; prefix: cstring): bool =
  toBool(g_str_has_prefix(str, prefix))

proc g_str_has_suffix(str: cstring; suffix: cstring): gboolean {.
    importc, libprag.}

proc strHasSuffix*(str: cstring; suffix: cstring): bool =
  toBool(g_str_has_suffix(str, suffix))

proc g_str_hash(v: pointer): uint32 {.
    importc, libprag.}

proc strHash*(v: pointer): int =
  int(g_str_hash(v))

proc g_str_is_ascii(str: cstring): gboolean {.
    importc, libprag.}

proc strIsAscii*(str: cstring): bool =
  toBool(g_str_is_ascii(str))

proc g_str_match_string(searchTerm: cstring; potentialHit: cstring; acceptAlternates: gboolean): gboolean {.
    importc, libprag.}

proc strMatchString*(searchTerm: cstring; potentialHit: cstring; acceptAlternates: bool): bool =
  toBool(g_str_match_string(searchTerm, potentialHit, gboolean(acceptAlternates)))

proc g_str_to_ascii(str: cstring; fromLocale: cstring): cstring {.
    importc, libprag.}

proc strToAscii*(str: cstring; fromLocale: cstring = nil): string =
  let resul0 = g_str_to_ascii(str, fromLocale)
  result = $resul0
  cogfree(resul0)

proc g_str_tokenize_and_fold(string: cstring; translitLocale: cstring; asciiAlternates: var ptr cstring): ptr cstring {.
    importc, libprag.}

proc strTokenizeAndFold*(string: cstring; translitLocale: cstring = nil;
    asciiAlternates: var seq[string]): seq[string] =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var asciiAlternates_00 = seq2CstringArray(asciiAlternates, fs469n23)
  let resul0 = g_str_tokenize_and_fold(string, translitLocale, asciiAlternates_00)
  result = cstringArrayToSeq(resul0)
  if asciiAlternates.addr != nil:
    asciiAlternates = cstringArrayToSeq(asciiAlternates_00)

proc g_strcanon(string: cstring; validChars: cstring; substitutor: int8): cstring {.
    importc, libprag.}

proc strcanon*(string: cstring; validChars: cstring; substitutor: int8): string =
  let resul0 = g_strcanon(string, validChars, substitutor)
  result = $resul0
  cogfree(resul0)

proc g_strcasecmp(s1: cstring; s2: cstring): int32 {.
    importc, libprag.}

proc strcasecmp*(s1: cstring; s2: cstring): int =
  int(g_strcasecmp(s1, s2))

proc g_strchomp(string: cstring): cstring {.
    importc, libprag.}

proc strchomp*(string: cstring): string =
  let resul0 = g_strchomp(string)
  result = $resul0
  cogfree(resul0)

proc g_strchug(string: cstring): cstring {.
    importc, libprag.}

proc strchug*(string: cstring): string =
  let resul0 = g_strchug(string)
  result = $resul0
  cogfree(resul0)

proc g_strcmp0(str1: cstring; str2: cstring): int32 {.
    importc, libprag.}

proc strcmp0*(str1: cstring = nil; str2: cstring = nil): int =
  int(g_strcmp0(str1, str2))

proc g_strcompress(source: cstring): cstring {.
    importc, libprag.}

proc strcompress*(source: cstring): string =
  let resul0 = g_strcompress(source)
  result = $resul0
  cogfree(resul0)

proc g_strdelimit(string: cstring; delimiters: cstring; newDelimiter: int8): cstring {.
    importc, libprag.}

proc strdelimit*(string: cstring; delimiters: cstring = nil; newDelimiter: int8): string =
  let resul0 = g_strdelimit(string, delimiters, newDelimiter)
  result = $resul0
  cogfree(resul0)

proc g_strdown(string: cstring): cstring {.
    importc, libprag.}

proc strdown*(string: cstring): string =
  let resul0 = g_strdown(string)
  result = $resul0
  cogfree(resul0)

proc g_strdup*(str: cstring): cstring {.
    importc, libprag.}

proc strdup*(str: cstring = nil): string =
  let resul0 = g_strdup(str)
  result = $resul0
  cogfree(resul0)

proc g_strerror(errnum: int32): cstring {.
    importc, libprag.}

proc strerror*(errnum: int): string =
  result = $g_strerror(int32(errnum))

proc g_strescape(source: cstring; exceptions: cstring): cstring {.
    importc, libprag.}

proc strescape*(source: cstring; exceptions: cstring = nil): string =
  let resul0 = g_strescape(source, exceptions)
  result = $resul0
  cogfree(resul0)

proc stringNew*(init: cstring): ptr String {.
    importc: "g_string_new", libprag.}

proc stringNewLen*(init: cstring; len: int64): ptr String {.
    importc: "g_string_new_len", libprag.}

proc stringSizedNew*(dflSize: uint64): ptr String {.
    importc: "g_string_sized_new", libprag.}

proc g_strip_context(msgid: cstring; msgval: cstring): cstring {.
    importc, libprag.}

proc stripContext*(msgid: cstring; msgval: cstring): string =
  result = $g_strip_context(msgid, msgval)

proc g_strjoinv(separator: cstring; strArray: cstring): cstring {.
    importc, libprag.}

proc strjoinv*(separator: cstring = nil; strArray: cstring): string =
  let resul0 = g_strjoinv(separator, strArray)
  result = $resul0
  cogfree(resul0)

proc strlcat*(dest: cstring; src: cstring; destSize: uint64): uint64 {.
    importc: "g_strlcat", libprag.}

proc strlcpy*(dest: cstring; src: cstring; destSize: uint64): uint64 {.
    importc: "g_strlcpy", libprag.}

proc g_strncasecmp(s1: cstring; s2: cstring; n: uint32): int32 {.
    importc, libprag.}

proc strncasecmp*(s1: cstring; s2: cstring; n: int): int =
  int(g_strncasecmp(s1, s2, uint32(n)))

proc g_strndup(str: cstring; n: uint64): cstring {.
    importc, libprag.}

proc strndup*(str: cstring; n: uint64): string =
  let resul0 = g_strndup(str, n)
  result = $resul0
  cogfree(resul0)

proc g_strnfill(length: uint64; fillChar: int8): cstring {.
    importc, libprag.}

proc strnfill*(length: uint64; fillChar: int8): string =
  let resul0 = g_strnfill(length, fillChar)
  result = $resul0
  cogfree(resul0)

proc g_strreverse(string: cstring): cstring {.
    importc, libprag.}

proc strreverse*(string: cstring): string =
  let resul0 = g_strreverse(string)
  result = $resul0
  cogfree(resul0)

proc g_strrstr(haystack: cstring; needle: cstring): cstring {.
    importc, libprag.}

proc strrstr*(haystack: cstring; needle: cstring): string =
  let resul0 = g_strrstr(haystack, needle)
  result = $resul0
  cogfree(resul0)

proc g_strrstr_len(haystack: cstring; haystackLen: int64; needle: cstring): cstring {.
    importc, libprag.}

proc strrstrLen*(haystack: cstring; haystackLen: int64; needle: cstring): string =
  let resul0 = g_strrstr_len(haystack, haystackLen, needle)
  result = $resul0
  cogfree(resul0)

proc g_strsignal(signum: int32): cstring {.
    importc, libprag.}

proc strsignal*(signum: int): string =
  result = $g_strsignal(int32(signum))

proc g_strstr_len(haystack: cstring; haystackLen: int64; needle: cstring): cstring {.
    importc, libprag.}

proc strstrLen*(haystack: cstring; haystackLen: int64; needle: cstring): string =
  let resul0 = g_strstr_len(haystack, haystackLen, needle)
  result = $resul0
  cogfree(resul0)

proc g_strtod(nptr: cstring; endptr: var cstring): cdouble {.
    importc, libprag.}

proc strtod*(nptr: cstring; endptr: var string = cast[var string](nil)): cdouble =
  var endptr_00: cstring
  result = g_strtod(nptr, endptr_00)
  if endptr.addr != nil:
    endptr = $(endptr_00)

proc g_strup(string: cstring): cstring {.
    importc, libprag.}

proc strup*(string: cstring): string =
  let resul0 = g_strup(string)
  result = $resul0
  cogfree(resul0)

proc g_strv_contains(strv: cstring; str: cstring): gboolean {.
    importc, libprag.}

proc strvContains*(strv: cstring; str: cstring): bool =
  toBool(g_strv_contains(strv, str))

proc g_strv_equal(strv1: cstring; strv2: cstring): gboolean {.
    importc, libprag.}

proc strvEqual*(strv1: cstring; strv2: cstring): bool =
  toBool(g_strv_equal(strv1, strv2))

proc strvGetType*(): GType {.
    importc: "g_strv_get_type", libprag.}

proc g_strv_length(strArray: cstring): uint32 {.
    importc, libprag.}

proc strvLength*(strArray: cstring): int =
  int(g_strv_length(strArray))

proc testAddDataFunc*(testpath: cstring; testData: pointer; testFunc: TestDataFunc) {.
    importc: "g_test_add_data_func", libprag.}

proc testAddDataFuncFull*(testpath: cstring; testData: pointer; testFunc: TestDataFunc;
    dataFreeFunc: DestroyNotify) {.
    importc: "g_test_add_data_func_full", libprag.}

proc testAddFunc*(testpath: cstring; testFunc: TestFunc) {.
    importc: "g_test_add_func", libprag.}

proc g_test_assert_expected_messages_internal(domain: cstring; file: cstring;
    line: int32; `func`: cstring) {.
    importc, libprag.}

proc testAssertExpectedMessagesInternal*(domain: cstring; file: cstring;
    line: int; `func`: cstring) =
  g_test_assert_expected_messages_internal(domain, file, int32(line), `func`)

proc testBug*(bugUriSnippet: cstring) {.
    importc: "g_test_bug", libprag.}

proc testBugBase*(uriPattern: cstring) {.
    importc: "g_test_bug_base", libprag.}

proc testExpectMessage*(logDomain: cstring; logLevel: LogLevelFlags; pattern: cstring) {.
    importc: "g_test_expect_message", libprag.}

proc testFail*() {.
    importc: "g_test_fail", libprag.}

proc g_test_failed(): gboolean {.
    importc, libprag.}

proc testFailed*(): bool =
  toBool(g_test_failed())

proc g_test_get_dir(fileType: TestFileType): cstring {.
    importc, libprag.}

proc testGetDir*(fileType: TestFileType): string =
  result = $g_test_get_dir(fileType)

proc testIncomplete*(msg: cstring) {.
    importc: "g_test_incomplete", libprag.}

proc g_test_log_type_name(logType: TestLogType): cstring {.
    importc, libprag.}

proc testLogTypeName*(logType: TestLogType): string =
  result = $g_test_log_type_name(logType)

proc testQueueDestroy*(destroyFunc: DestroyNotify; destroyData: pointer) {.
    importc: "g_test_queue_destroy", libprag.}

proc testQueueFree*(gfreePointer: pointer) {.
    importc: "g_test_queue_free", libprag.}

proc testRandDouble*(): cdouble {.
    importc: "g_test_rand_double", libprag.}

proc testRandDoubleRange*(rangeStart: cdouble; rangeEnd: cdouble): cdouble {.
    importc: "g_test_rand_double_range", libprag.}

proc g_test_rand_int(): int32 {.
    importc, libprag.}

proc testRandInt*(): int =
  int(g_test_rand_int())

proc g_test_rand_int_range(begin: int32; `end`: int32): int32 {.
    importc, libprag.}

proc testRandIntRange*(begin: int; `end`: int): int =
  int(g_test_rand_int_range(int32(begin), int32(`end`)))

proc g_test_run(): int32 {.
    importc, libprag.}

proc testRun*(): int =
  int(g_test_run())

proc g_test_run_suite(suite: ptr TestSuite00): int32 {.
    importc, libprag.}

proc testRunSuite*(suite: TestSuite): int =
  int(g_test_run_suite(cast[ptr TestSuite00](suite.impl)))

proc testSetNonfatalAssertions*() {.
    importc: "g_test_set_nonfatal_assertions", libprag.}

proc testSkip*(msg: cstring) {.
    importc: "g_test_skip", libprag.}

proc g_test_subprocess(): gboolean {.
    importc, libprag.}

proc testSubprocess*(): bool =
  toBool(g_test_subprocess())

proc testSummary*(summary: cstring) {.
    importc: "g_test_summary", libprag.}

proc testTimerElapsed*(): cdouble {.
    importc: "g_test_timer_elapsed", libprag.}

proc testTimerLast*(): cdouble {.
    importc: "g_test_timer_last", libprag.}

proc testTimerStart*() {.
    importc: "g_test_timer_start", libprag.}

proc g_test_trap_assertions(domain: cstring; file: cstring; line: int32;
    `func`: cstring; assertionFlags: uint64; pattern: cstring) {.
    importc, libprag.}

proc testTrapAssertions*(domain: cstring; file: cstring; line: int; `func`: cstring;
    assertionFlags: uint64; pattern: cstring) =
  g_test_trap_assertions(domain, file, int32(line), `func`, assertionFlags, pattern)

proc g_test_trap_fork(usecTimeout: uint64; testTrapFlags: TestTrapFlags): gboolean {.
    importc, libprag.}

proc testTrapFork*(usecTimeout: uint64; testTrapFlags: TestTrapFlags): bool =
  toBool(g_test_trap_fork(usecTimeout, testTrapFlags))

proc g_test_trap_has_passed(): gboolean {.
    importc, libprag.}

proc testTrapHasPassed*(): bool =
  toBool(g_test_trap_has_passed())

proc g_test_trap_reached_timeout(): gboolean {.
    importc, libprag.}

proc testTrapReachedTimeout*(): bool =
  toBool(g_test_trap_reached_timeout())

proc testTrapSubprocess*(testPath: cstring; usecTimeout: uint64; testFlags: TestSubprocessFlags) {.
    importc: "g_test_trap_subprocess", libprag.}

proc g_timeout_add_full*(priority: int32; interval: uint32; function: SourceFunc;
    data: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc timeoutAdd*(priority: int; interval: int; function: SourceFunc;
    data: pointer; notify: DestroyNotify): int =
  int(g_timeout_add_full(int32(priority), uint32(interval), function, data, notify))

proc g_timeout_add_seconds_full(priority: int32; interval: uint32; function: SourceFunc;
    data: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc timeoutAddSeconds*(priority: int; interval: int; function: SourceFunc;
    data: pointer; notify: DestroyNotify): int =
  int(g_timeout_add_seconds_full(int32(priority), uint32(interval), function, data, notify))

proc g_timeout_source_new(interval: uint32): ptr Source00 {.
    importc, libprag.}

proc newTimeoutSource*(interval: int): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_timeout_source_new(uint32(interval))

proc g_timeout_source_new_seconds(interval: uint32): ptr Source00 {.
    importc, libprag.}

proc timeoutSourceNewSeconds*(interval: int): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_timeout_source_new_seconds(uint32(interval))

proc tryMalloc*(nBytes: uint64): pointer {.
    importc: "g_try_malloc", libprag.}

proc tryMalloc0*(nBytes: uint64): pointer {.
    importc: "g_try_malloc0", libprag.}

proc tryMalloc0N*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_malloc0_n", libprag.}

proc tryMallocN*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_malloc_n", libprag.}

proc tryRealloc*(mem: pointer; nBytes: uint64): pointer {.
    importc: "g_try_realloc", libprag.}

proc tryReallocN*(mem: pointer; nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_realloc_n", libprag.}

proc ucs4ToUtf16*(str: ptr gunichar; len: int64; itemsRead: var int64;
    itemsWritten: var int64; error: ptr ptr glib.Error = nil): ptr uint16 {.
    importc: "g_ucs4_to_utf16", libprag.}

proc g_ucs4_to_utf8(str: ptr gunichar; len: int64; itemsRead: var int64;
    itemsWritten: var int64; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc ucs4ToUtf8*(str: ptr gunichar; len: int64; itemsRead: var int64 = cast[var int64](nil);
    itemsWritten: var int64 = cast[var int64](nil)): string =
  var gerror: ptr glib.Error
  let resul0 = g_ucs4_to_utf8(str, len, itemsRead, itemsWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc unicharBreakType*(c: gunichar): UnicodeBreakType {.
    importc: "g_unichar_break_type", libprag.}

proc g_unichar_combining_class(uc: gunichar): int32 {.
    importc, libprag.}

proc unicharCombiningClass*(uc: gunichar): int =
  int(g_unichar_combining_class(uc))

proc g_unichar_compose(a: gunichar; b: gunichar; ch: var gunichar): gboolean {.
    importc, libprag.}

proc unicharCompose*(a: gunichar; b: gunichar; ch: var gunichar): bool =
  toBool(g_unichar_compose(a, b, ch))

proc g_unichar_decompose(ch: gunichar; a: var gunichar; b: var gunichar): gboolean {.
    importc, libprag.}

proc unicharDecompose*(ch: gunichar; a: var gunichar; b: var gunichar): bool =
  toBool(g_unichar_decompose(ch, a, b))

proc g_unichar_digit_value(c: gunichar): int32 {.
    importc, libprag.}

proc unicharDigitValue*(c: gunichar): int =
  int(g_unichar_digit_value(c))

proc g_unichar_fully_decompose(ch: gunichar; compat: gboolean; resu: var gunichar;
    resultLen: uint64): uint64 {.
    importc, libprag.}

proc unicharFullyDecompose*(ch: gunichar; compat: bool; resu: var gunichar = cast[var gunichar](nil);
    resultLen: uint64): uint64 =
  g_unichar_fully_decompose(ch, gboolean(compat), resu, resultLen)

proc g_unichar_get_mirror_char(ch: gunichar; mirroredCh: ptr gunichar): gboolean {.
    importc, libprag.}

proc unicharGetMirrorChar*(ch: gunichar; mirroredCh: ptr gunichar): bool =
  toBool(g_unichar_get_mirror_char(ch, mirroredCh))

proc unicharGetScript*(ch: gunichar): UnicodeScript {.
    importc: "g_unichar_get_script", libprag.}

proc g_unichar_isalnum(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsalnum*(c: gunichar): bool =
  toBool(g_unichar_isalnum(c))

proc g_unichar_isalpha(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsalpha*(c: gunichar): bool =
  toBool(g_unichar_isalpha(c))

proc g_unichar_iscntrl(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIscntrl*(c: gunichar): bool =
  toBool(g_unichar_iscntrl(c))

proc g_unichar_isdefined(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsdefined*(c: gunichar): bool =
  toBool(g_unichar_isdefined(c))

proc g_unichar_isdigit(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsdigit*(c: gunichar): bool =
  toBool(g_unichar_isdigit(c))

proc g_unichar_isgraph(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsgraph*(c: gunichar): bool =
  toBool(g_unichar_isgraph(c))

proc g_unichar_islower(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIslower*(c: gunichar): bool =
  toBool(g_unichar_islower(c))

proc g_unichar_ismark(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsmark*(c: gunichar): bool =
  toBool(g_unichar_ismark(c))

proc g_unichar_isprint(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsprint*(c: gunichar): bool =
  toBool(g_unichar_isprint(c))

proc g_unichar_ispunct(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIspunct*(c: gunichar): bool =
  toBool(g_unichar_ispunct(c))

proc g_unichar_isspace(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsspace*(c: gunichar): bool =
  toBool(g_unichar_isspace(c))

proc g_unichar_istitle(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIstitle*(c: gunichar): bool =
  toBool(g_unichar_istitle(c))

proc g_unichar_isupper(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsupper*(c: gunichar): bool =
  toBool(g_unichar_isupper(c))

proc g_unichar_iswide(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIswide*(c: gunichar): bool =
  toBool(g_unichar_iswide(c))

proc g_unichar_iswide_cjk(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIswideCjk*(c: gunichar): bool =
  toBool(g_unichar_iswide_cjk(c))

proc g_unichar_isxdigit(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIsxdigit*(c: gunichar): bool =
  toBool(g_unichar_isxdigit(c))

proc g_unichar_iszerowidth(c: gunichar): gboolean {.
    importc, libprag.}

proc unicharIszerowidth*(c: gunichar): bool =
  toBool(g_unichar_iszerowidth(c))

proc g_unichar_to_utf8(c: gunichar; outbuf: var cstring): int32 {.
    importc, libprag.}

proc unicharToUtf8*(c: gunichar; outbuf: var string = cast[var string](nil)): int =
  var outbuf_00: cstring
  result = int(g_unichar_to_utf8(c, outbuf_00))
  if outbuf.addr != nil:
    outbuf = $(outbuf_00)

proc unicharTolower*(c: gunichar): gunichar {.
    importc: "g_unichar_tolower", libprag.}

proc unicharTotitle*(c: gunichar): gunichar {.
    importc: "g_unichar_totitle", libprag.}

proc unicharToupper*(c: gunichar): gunichar {.
    importc: "g_unichar_toupper", libprag.}

proc unicharType*(c: gunichar): UnicodeType {.
    importc: "g_unichar_type", libprag.}

proc g_unichar_validate(ch: gunichar): gboolean {.
    importc, libprag.}

proc unicharValidate*(ch: gunichar): bool =
  toBool(g_unichar_validate(ch))

proc g_unichar_xdigit_value(c: gunichar): int32 {.
    importc, libprag.}

proc unicharXdigitValue*(c: gunichar): int =
  int(g_unichar_xdigit_value(c))

proc unicodeCanonicalDecomposition*(ch: gunichar; resultLen: ptr uint64): ptr gunichar {.
    importc: "g_unicode_canonical_decomposition", libprag.}

proc unicodeCanonicalOrdering*(string: ptr gunichar; len: uint64) {.
    importc: "g_unicode_canonical_ordering", libprag.}

proc g_unicode_script_from_iso15924(iso15924: uint32): UnicodeScript {.
    importc, libprag.}

proc unicodeScriptFromIso15924*(iso15924: int): UnicodeScript =
  g_unicode_script_from_iso15924(uint32(iso15924))

proc g_unicode_script_to_iso15924(script: UnicodeScript): uint32 {.
    importc, libprag.}

proc unicodeScriptToIso15924*(script: UnicodeScript): int =
  int(g_unicode_script_to_iso15924(script))

proc g_unix_error_quark(): uint32 {.
    importc, libprag.}

proc unixErrorQuark*(): int =
  int(g_unix_error_quark())

proc g_unix_fd_add_full(priority: int32; fd: int32; condition: IOCondition;
    function: UnixFDSourceFunc; userData: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc unixFdAddFull*(priority: int; fd: int; condition: IOCondition; function: UnixFDSourceFunc;
    userData: pointer; notify: DestroyNotify): int =
  int(g_unix_fd_add_full(int32(priority), int32(fd), condition, function, userData, notify))

proc g_unix_fd_source_new(fd: int32; condition: IOCondition): ptr Source00 {.
    importc, libprag.}

proc newUnixFdSource*(fd: int; condition: IOCondition): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_unix_fd_source_new(int32(fd), condition)

proc unixGetPasswdEntry*(userName: cstring; error: ptr ptr glib.Error = nil): pointer {.
    importc: "g_unix_get_passwd_entry", libprag.}

proc g_unix_open_pipe(fds: ptr int32; flags: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc unixOpenPipe*(fds: ptr int32; flags: int): bool =
  var gerror: ptr glib.Error
  let resul0 = g_unix_open_pipe(fds, int32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_unix_set_fd_nonblocking(fd: int32; nonblock: gboolean; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc unixSetFdNonblocking*(fd: int; nonblock: bool): bool =
  var gerror: ptr glib.Error
  let resul0 = g_unix_set_fd_nonblocking(int32(fd), gboolean(nonblock), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc g_unix_signal_add_full(priority: int32; signum: int32; handler: SourceFunc;
    userData: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc unixSignalAdd*(priority: int; signum: int; handler: SourceFunc;
    userData: pointer; notify: DestroyNotify): int =
  int(g_unix_signal_add_full(int32(priority), int32(signum), handler, userData, notify))

proc g_unix_signal_source_new(signum: int32): ptr Source00 {.
    importc, libprag.}

proc newUnixSignalSource*(signum: int): Source =
  fnew(result, gBoxedFreeGSource)
  result.impl = g_unix_signal_source_new(int32(signum))

proc g_unlink(filename: cstring): int32 {.
    importc, libprag.}

proc unlink*(filename: cstring): int =
  int(g_unlink(filename))

proc unsetenv*(variable: cstring) {.
    importc: "g_unsetenv", libprag.}

proc usleep*(microseconds: uint64) {.
    importc: "g_usleep", libprag.}

proc utf16ToUcs4*(str: ptr uint16; len: int64; itemsRead: var int64; itemsWritten: var int64;
    error: ptr ptr glib.Error = nil): ptr gunichar {.
    importc: "g_utf16_to_ucs4", libprag.}

proc g_utf16_to_utf8(str: ptr uint16; len: int64; itemsRead: var int64; itemsWritten: var int64;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc utf16ToUtf8*(str: ptr uint16; len: int64; itemsRead: var int64 = cast[var int64](nil);
    itemsWritten: var int64 = cast[var int64](nil)): string =
  var gerror: ptr glib.Error
  let resul0 = g_utf16_to_utf8(str, len, itemsRead, itemsWritten, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc g_utf8_casefold(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc utf8Casefold*(str: cstring; len: int64): string =
  let resul0 = g_utf8_casefold(str, len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_collate(str1: cstring; str2: cstring): int32 {.
    importc, libprag.}

proc utf8Collate*(str1: cstring; str2: cstring): int =
  int(g_utf8_collate(str1, str2))

proc g_utf8_collate_key(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc utf8CollateKey*(str: cstring; len: int64): string =
  let resul0 = g_utf8_collate_key(str, len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_collate_key_for_filename(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc utf8CollateKeyForFilename*(str: cstring; len: int64): string =
  let resul0 = g_utf8_collate_key_for_filename(str, len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_find_next_char(p: cstring; `end`: cstring): cstring {.
    importc, libprag.}

proc utf8FindNextChar*(p: cstring; `end`: cstring = nil): string =
  let resul0 = g_utf8_find_next_char(p, `end`)
  if resul0.isNil:
    return
  result = $resul0

proc g_utf8_find_prev_char(str: cstring; p: cstring): cstring {.
    importc, libprag.}

proc utf8FindPrevChar*(str: cstring; p: cstring): string =
  let resul0 = g_utf8_find_prev_char(str, p)
  if resul0.isNil:
    return
  result = $resul0

proc utf8GetChar*(p: cstring): gunichar {.
    importc: "g_utf8_get_char", libprag.}

proc utf8GetCharValidated*(p: cstring; maxLen: int64): gunichar {.
    importc: "g_utf8_get_char_validated", libprag.}

proc g_utf8_make_valid(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc utf8MakeValid*(str: cstring; len: int64): string =
  let resul0 = g_utf8_make_valid(str, len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_normalize(str: cstring; len: int64; mode: NormalizeMode): cstring {.
    importc, libprag.}

proc utf8Normalize*(str: cstring; len: int64; mode: NormalizeMode): string =
  let resul0 = g_utf8_normalize(str, len, mode)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc g_utf8_offset_to_pointer(str: cstring; offset: int64): cstring {.
    importc, libprag.}

proc utf8OffsetToPointer*(str: cstring; offset: int64): string =
  result = $g_utf8_offset_to_pointer(str, offset)

proc utf8PointerToOffset*(str: cstring; pos: cstring): int64 {.
    importc: "g_utf8_pointer_to_offset", libprag.}

proc g_utf8_prev_char(p: cstring): cstring {.
    importc, libprag.}

proc utf8PrevChar*(p: cstring): string =
  result = $g_utf8_prev_char(p)

proc g_utf8_strchr(p: cstring; len: int64; c: gunichar): cstring {.
    importc, libprag.}

proc utf8Strchr*(p: cstring; len: int64; c: gunichar): string =
  let resul0 = g_utf8_strchr(p, len, c)
  if resul0.isNil:
    return
  result = $resul0

proc g_utf8_strdown(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc utf8Strdown*(str: cstring; len: int64): string =
  let resul0 = g_utf8_strdown(str, len)
  result = $resul0
  cogfree(resul0)

proc utf8Strlen*(p: cstring; max: int64): int64 {.
    importc: "g_utf8_strlen", libprag.}

proc g_utf8_strncpy(dest: cstring; src: cstring; n: uint64): cstring {.
    importc, libprag.}

proc utf8Strncpy*(dest: cstring; src: cstring; n: uint64): string =
  result = $g_utf8_strncpy(dest, src, n)

proc g_utf8_strrchr(p: cstring; len: int64; c: gunichar): cstring {.
    importc, libprag.}

proc utf8Strrchr*(p: cstring; len: int64; c: gunichar): string =
  let resul0 = g_utf8_strrchr(p, len, c)
  if resul0.isNil:
    return
  result = $resul0

proc g_utf8_strreverse(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc utf8Strreverse*(str: cstring; len: int64): string =
  let resul0 = g_utf8_strreverse(str, len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_strup(str: cstring; len: int64): cstring {.
    importc, libprag.}

proc utf8Strup*(str: cstring; len: int64): string =
  let resul0 = g_utf8_strup(str, len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_substring(str: cstring; startPos: int64; endPos: int64): cstring {.
    importc, libprag.}

proc utf8Substring*(str: cstring; startPos: int64; endPos: int64): string =
  let resul0 = g_utf8_substring(str, startPos, endPos)
  result = $resul0
  cogfree(resul0)

proc utf8ToUcs4*(str: cstring; len: int64; itemsRead: var int64; itemsWritten: var int64;
    error: ptr ptr glib.Error = nil): ptr gunichar {.
    importc: "g_utf8_to_ucs4", libprag.}

proc utf8ToUcs4Fast*(str: cstring; len: int64; itemsWritten: var int64): ptr gunichar {.
    importc: "g_utf8_to_ucs4_fast", libprag.}

proc utf8ToUtf16*(str: cstring; len: int64; itemsRead: var int64; itemsWritten: var int64;
    error: ptr ptr glib.Error = nil): ptr uint16 {.
    importc: "g_utf8_to_utf16", libprag.}

proc g_utf8_validate(str: ptr uint8; maxLen: int64; `end`: var cstring): gboolean {.
    importc, libprag.}

proc utf8Validate*(str: seq[uint8] | string; `end`: var string = cast[var string](nil)): bool =
  let maxLen = int64(str.len)
  var end_00: cstring
  result = toBool(g_utf8_validate(cast[ptr uint8](unsafeaddr(str[0])), maxLen, end_00))
  if `end`.addr != nil:
    `end` = $(end_00)

proc g_utf8_validate_len(str: ptr uint8; maxLen: uint64; `end`: var cstring): gboolean {.
    importc, libprag.}

proc utf8ValidateLen*(str: seq[uint8] | string; `end`: var string = cast[var string](nil)): bool =
  let maxLen = uint64(str.len)
  var end_00: cstring
  result = toBool(g_utf8_validate_len(cast[ptr uint8](unsafeaddr(str[0])), maxLen, end_00))
  if `end`.addr != nil:
    `end` = $(end_00)

proc g_uuid_string_is_valid(str: cstring): gboolean {.
    importc, libprag.}

proc uuidStringIsValid*(str: cstring): bool =
  toBool(g_uuid_string_is_valid(str))

proc g_uuid_string_random(): cstring {.
    importc, libprag.}

proc uuidStringRandom*(): string =
  let resul0 = g_uuid_string_random()
  result = $resul0
  cogfree(resul0)

proc variantGetGtype*(): GType {.
    importc: "g_variant_get_gtype", libprag.}
# === remaining symbols:

when not declared(g_thread_new):
  proc g_thread_new(name: cstring; fn: ThreadFunc; data:pointer): ptr Thread00 {.importc, libprag.}

  proc newThread*(name: string; fn: ThreadFunc; data:pointer): Thread =
    fnew(result, finalizerunref)
    result.impl = g_thread_new(name, fn, data)

#include gimplglib will not work as glib does not import gobject

