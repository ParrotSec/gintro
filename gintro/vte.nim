# dependencies:
# xlib-2.0
# GLib-2.0
# Gdk-3.0
# HarfBuzz-0.0
# GdkPixbuf-2.0
# cairo-1.0
# Gtk-3.0
# GObject-2.0
# Pango-1.0
# Gio-2.0
# GModule-2.0
# Atk-1.0
# immediate dependencies:
# Pango-1.0
# Gtk-3.0
# Gdk-3.0
# libraries:
# libvte-2.91.so.0
{.warning[UnusedImport]: off.}
import xlib, glib, gdk, harfbuzz, gdkpixbuf, cairo, gtk, gobject, pango, gio, gmodule, atk
const Lib = "libvte-2.91.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
import glib


proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  CharAttributes00* {.pure.} = object
  CharAttributes* = ref object
    impl*: ptr CharAttributes00
    ignoreFinalizer*: bool

type
  CursorBlinkMode* {.size: sizeof(cint), pure.} = enum
    system = 0
    on = 1
    off = 2

type
  CursorShape* {.size: sizeof(cint), pure.} = enum
    `block` = 0
    ibeam = 1
    underline = 2

type
  EraseBinding* {.size: sizeof(cint), pure.} = enum
    auto = 0
    asciiBackspace = 1
    asciiDelete = 2
    deleteSequence = 3
    tty = 4

type
  FeatureFlags* {.size: sizeof(cint), pure.} = enum
    flagsMask = -1
    flagBidi = 1
    flagIcu = 2
    flagSystemd = 4
    flagSixel = 8

type
  Format* {.size: sizeof(cint), pure.} = enum
    text = 1
    html = 2

const MAJOR_VERSION* = 0'i32

const MICRO_VERSION* = 3'i32

const MINOR_VERSION* = 62'i32

type
  Pty* = ref object of gobject.Object
  Pty00* = object of gobject.Object00

proc vte_pty_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Pty()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc vte_pty_new_foreign_sync(fd: int32; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr Pty00 {.
    importc, libprag.}

proc newPtyForeignSync*(fd: int; cancellable: gio.Cancellable = nil): Pty =
  var gerror: ptr glib.Error
  let gobj = vte_pty_new_foreign_sync(int32(fd), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPtyForeignSync*(tdesc: typedesc; fd: int; cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pty)
  let gobj = vte_pty_new_foreign_sync(int32(fd), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPtyForeignSync*[T](result: var T; fd: int; cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pty)
  let gobj = vte_pty_new_foreign_sync(int32(fd), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc vte_pty_child_setup(self: ptr Pty00) {.
    importc, libprag.}

proc childSetup*(self: Pty) =
  vte_pty_child_setup(cast[ptr Pty00](self.impl))

proc vte_pty_close(self: ptr Pty00) {.
    importc, libprag.}

proc close*(self: Pty) =
  vte_pty_close(cast[ptr Pty00](self.impl))

proc vte_pty_get_fd(self: ptr Pty00): int32 {.
    importc, libprag.}

proc getFd*(self: Pty): int =
  int(vte_pty_get_fd(cast[ptr Pty00](self.impl)))

proc fd*(self: Pty): int =
  int(vte_pty_get_fd(cast[ptr Pty00](self.impl)))

proc vte_pty_get_size(self: ptr Pty00; rows: var int32; columns: var int32;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getSize*(self: Pty; rows: var int = cast[var int](nil); columns: var int = cast[var int](nil)): bool =
  var gerror: ptr glib.Error
  var rows_00: int32
  var columns_00: int32
  let resul0 = vte_pty_get_size(cast[ptr Pty00](self.impl), rows_00, columns_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if rows.addr != nil:
    rows = int(rows_00)
  if columns.addr != nil:
    columns = int(columns_00)

proc vte_pty_set_size(self: ptr Pty00; rows: int32; columns: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setSize*(self: Pty; rows: int; columns: int): bool =
  var gerror: ptr glib.Error
  let resul0 = vte_pty_set_size(cast[ptr Pty00](self.impl), int32(rows), int32(columns), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc vte_pty_set_utf8(self: ptr Pty00; utf8: gboolean; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setUtf8*(self: Pty; utf8: bool = true): bool =
  var gerror: ptr glib.Error
  let resul0 = vte_pty_set_utf8(cast[ptr Pty00](self.impl), gboolean(utf8), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc vte_pty_spawn_async(self: ptr Pty00; workingDirectory: cstring; argv: ptr cstring;
    envv: ptr cstring; spawnFlags: glib.SpawnFlags; childSetup: SpawnChildSetupFunc;
    childSetupData: pointer; childSetupDataDestroy: DestroyNotify; timeout: int32;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc spawnAsync*(self: Pty; workingDirectory: cstring = nil; argv: openArray[string];
    envv: openArray[string]; spawnFlags: glib.SpawnFlags; childSetup: SpawnChildSetupFunc;
    childSetupData: pointer; childSetupDataDestroy: DestroyNotify; timeout: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  vte_pty_spawn_async(cast[ptr Pty00](self.impl), workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envv, fs469n232), spawnFlags, childSetup, childSetupData, childSetupDataDestroy, int32(timeout), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc vte_pty_spawn_finish(self: ptr Pty00; resu: ptr gio.AsyncResult00; childPid: var int32;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc spawnFinish*(self: Pty; resu: gio.AsyncResult; childPid: var int = cast[var int](nil)): bool =
  var gerror: ptr glib.Error
  var childPid_00: int32
  let resul0 = vte_pty_spawn_finish(cast[ptr Pty00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), childPid_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if childPid.addr != nil:
    childPid = int(childPid_00)

proc vte_pty_spawn_with_fds_async(self: ptr Pty00; workingDirectory: cstring;
    argv: ptr cstring; envv: ptr cstring; fds: ptr int32; nFds: int32; mapFds: ptr int32;
    nMapFds: int32; spawnFlags: glib.SpawnFlags; childSetup: SpawnChildSetupFunc;
    childSetupData: pointer; childSetupDataDestroy: DestroyNotify; timeout: int32;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc spawnWithFdsAsync*(self: Pty; workingDirectory: cstring = nil;
    argv: openArray[string]; envv: openArray[string]; fds: seq[int32]; nFds: int;
    mapFds: seq[int32]; spawnFlags: glib.SpawnFlags; childSetup: SpawnChildSetupFunc;
    childSetupData: pointer; childSetupDataDestroy: DestroyNotify; timeout: int;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  let nMapFds = int(mapFds.len)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  vte_pty_spawn_with_fds_async(cast[ptr Pty00](self.impl), workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envv, fs469n232), cast[ptr int32](unsafeaddr(fds[0])), int32(nFds), cast[ptr int32](unsafeaddr(mapFds[0])), int32(nMapFds), spawnFlags, childSetup, childSetupData, childSetupDataDestroy, int32(timeout), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

type
  PtyFlag* {.size: sizeof(cint), pure.} = enum
    noLastlog = 0
    noUtmp = 1
    noWtmp = 2
    noHelper = 3
    noFallback = 4
    noSession = 5
    noCtty = 6

  PtyFlags* {.size: sizeof(cint).} = set[PtyFlag]

const
  PtyFlagsDefault* = PtyFlags({})
proc default*(t: typedesc[PtyFlags]): PtyFlags = PtyFlags({})

proc vte_pty_new_sync(flags: PtyFlags; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr Pty00 {.
    importc, libprag.}

proc newPtySync*(flags: PtyFlags; cancellable: gio.Cancellable = nil): Pty =
  var gerror: ptr glib.Error
  let gobj = vte_pty_new_sync(flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPtySync*(tdesc: typedesc; flags: PtyFlags; cancellable: gio.Cancellable = nil): tdesc =
  var gerror: ptr glib.Error
  assert(result is Pty)
  let gobj = vte_pty_new_sync(flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPtySync*[T](result: var T; flags: PtyFlags; cancellable: gio.Cancellable = nil) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Pty)
  let gobj = vte_pty_new_sync(flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PtyError* {.size: sizeof(cint), pure.} = enum
    ptyHelperFailed = 0
    pty98Failed = 1

const REGEX_FLAGS_DEFAULT* = 1075314688'i32

type
  Regex00* {.pure.} = object
  Regex* = ref object
    impl*: ptr Regex00
    ignoreFinalizer*: bool

proc vte_regex_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeVteRegex*(self: Regex) =
  if not self.ignoreFinalizer:
    boxedFree(vte_regex_get_type(), cast[ptr Regex00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Regex()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(vte_regex_get_type(), cast[ptr Regex00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Regex) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeVteRegex)

proc vte_regex_unref*(self: ptr Regex00): ptr Regex00 {.
    importc, libprag.}

proc unref*(self: Regex) =
  discard vte_regex_unref(cast[ptr Regex00](self.impl))

proc vte_regex_new_for_search(pattern: cstring; patternLength: int64; flags: uint32;
    error: ptr ptr glib.Error = nil): ptr Regex00 {.
    importc, libprag.}

proc newRegexForSearch*(pattern: cstring; patternLength: int64; flags: int): Regex =
  var gerror: ptr glib.Error
  let impl0 = vte_regex_new_for_search(pattern, patternLength, uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeVteRegex)
  result.impl = impl0

proc newRegexForSearch*(tdesc: typedesc; pattern: cstring; patternLength: int64; flags: int): tdesc =
  var gerror: ptr glib.Error
  assert(result is Regex)
  let impl0 = vte_regex_new_for_search(pattern, patternLength, uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeVteRegex)
  result.impl = impl0

proc initRegexForSearch*[T](result: var T; pattern: cstring; patternLength: int64; flags: int) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Regex)
  let impl0 = vte_regex_new_for_search(pattern, patternLength, uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeVteRegex)
  result.impl = impl0

proc vte_regex_jit(self: ptr Regex00; flags: uint32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc jit*(self: Regex; flags: int): bool =
  var gerror: ptr glib.Error
  let resul0 = vte_regex_jit(cast[ptr Regex00](self.impl), uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc vte_regex_ref(self: ptr Regex00): ptr Regex00 {.
    importc, libprag.}

proc `ref`*(self: Regex): Regex =
  fnew(result, gBoxedFreeVteRegex)
  result.impl = vte_regex_ref(cast[ptr Regex00](self.impl))

proc vte_regex_substitute(self: ptr Regex00; subject: cstring; replacement: cstring;
    flags: uint32; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc substitute*(self: Regex; subject: cstring; replacement: cstring;
    flags: int): string =
  var gerror: ptr glib.Error
  let resul0 = vte_regex_substitute(cast[ptr Regex00](self.impl), subject, replacement, uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc vte_regex_new_for_match(pattern: cstring; patternLength: int64; flags: uint32;
    error: ptr ptr glib.Error = nil): ptr Regex00 {.
    importc, libprag.}

proc newRegexForMatch*(pattern: cstring; patternLength: int64; flags: int): Regex =
  var gerror: ptr glib.Error
  let impl0 = vte_regex_new_for_match(pattern, patternLength, uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeVteRegex)
  result.impl = impl0

proc newRegexForMatch*(tdesc: typedesc; pattern: cstring; patternLength: int64; flags: int): tdesc =
  var gerror: ptr glib.Error
  assert(result is Regex)
  let impl0 = vte_regex_new_for_match(pattern, patternLength, uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeVteRegex)
  result.impl = impl0

proc initRegexForMatch*[T](result: var T; pattern: cstring; patternLength: int64; flags: int) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Regex)
  let impl0 = vte_regex_new_for_match(pattern, patternLength, uint32(flags), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeVteRegex)
  result.impl = impl0

type
  RegexError* {.size: sizeof(cint), pure.} = enum
    incompatible = 2147483646
    notSupported = 2147483647

const SPAWN_NO_PARENT_ENVV* = 33554432'i32

const SPAWN_NO_SYSTEMD_SCOPE* = 67108864'i32

const SPAWN_REQUIRE_SYSTEMD_SCOPE* = 134217728'i32

type
  Terminal* = ref object of gtk.Widget
  Terminal00* = object of gtk.Widget00

proc vte_terminal_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Terminal()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scBell*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "bell", cast[GCallback](p), xdata, nil, cf)

proc scCharSizeChanged*(self: Terminal;  p: proc (self: ptr Terminal00; width: uint32; height: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "char-size-changed", cast[GCallback](p), xdata, nil, cf)

proc scChildExited*(self: Terminal;  p: proc (self: ptr Terminal00; status: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "child-exited", cast[GCallback](p), xdata, nil, cf)

proc scCommit*(self: Terminal;  p: proc (self: ptr Terminal00; text: cstring; size: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "commit", cast[GCallback](p), xdata, nil, cf)

proc scContentsChanged*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "contents-changed", cast[GCallback](p), xdata, nil, cf)

proc scCopyClipboard*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "copy-clipboard", cast[GCallback](p), xdata, nil, cf)

proc scCurrentDirectoryUriChanged*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "current-directory-uri-changed", cast[GCallback](p), xdata, nil, cf)

proc scCurrentFileUriChanged*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "current-file-uri-changed", cast[GCallback](p), xdata, nil, cf)

proc scCursorMoved*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "cursor-moved", cast[GCallback](p), xdata, nil, cf)

proc scDecreaseFontSize*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "decrease-font-size", cast[GCallback](p), xdata, nil, cf)

proc scDeiconifyWindow*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "deiconify-window", cast[GCallback](p), xdata, nil, cf)

proc scEncodingChanged*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "encoding-changed", cast[GCallback](p), xdata, nil, cf)

proc scEof*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "eof", cast[GCallback](p), xdata, nil, cf)

proc scHyperlinkHoverUriChanged*(self: Terminal;  p: proc (self: ptr Terminal00; uri: cstring; bbox: gdk.Rectangle; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "hyperlink-hover-uri-changed", cast[GCallback](p), xdata, nil, cf)

proc scIconTitleChanged*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "icon-title-changed", cast[GCallback](p), xdata, nil, cf)

proc scIconifyWindow*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "iconify-window", cast[GCallback](p), xdata, nil, cf)

proc scIncreaseFontSize*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "increase-font-size", cast[GCallback](p), xdata, nil, cf)

proc scLowerWindow*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "lower-window", cast[GCallback](p), xdata, nil, cf)

proc scMaximizeWindow*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "maximize-window", cast[GCallback](p), xdata, nil, cf)

proc scMoveWindow*(self: Terminal;  p: proc (self: ptr Terminal00; x: uint32; y: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-window", cast[GCallback](p), xdata, nil, cf)

proc scPasteClipboard*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "paste-clipboard", cast[GCallback](p), xdata, nil, cf)

proc scRaiseWindow*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "raise-window", cast[GCallback](p), xdata, nil, cf)

proc scRefreshWindow*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "refresh-window", cast[GCallback](p), xdata, nil, cf)

proc scResizeWindow*(self: Terminal;  p: proc (self: ptr Terminal00; width: uint32; height: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "resize-window", cast[GCallback](p), xdata, nil, cf)

proc scRestoreWindow*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "restore-window", cast[GCallback](p), xdata, nil, cf)

proc scSelectionChanged*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "selection-changed", cast[GCallback](p), xdata, nil, cf)

proc scTextDeleted*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-deleted", cast[GCallback](p), xdata, nil, cf)

proc scTextInserted*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-inserted", cast[GCallback](p), xdata, nil, cf)

proc scTextModified*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-modified", cast[GCallback](p), xdata, nil, cf)

proc scTextScrolled*(self: Terminal;  p: proc (self: ptr Terminal00; delta: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-scrolled", cast[GCallback](p), xdata, nil, cf)

proc scWindowTitleChanged*(self: Terminal;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "window-title-changed", cast[GCallback](p), xdata, nil, cf)

proc vte_terminal_new(): ptr Terminal00 {.
    importc, libprag.}

proc newTerminal*(): Terminal =
  let gobj = vte_terminal_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTerminal*(tdesc: typedesc): tdesc =
  assert(result is Terminal)
  let gobj = vte_terminal_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTerminal*[T](result: var T) {.deprecated.} =
  assert(result is Terminal)
  let gobj = vte_terminal_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc vte_terminal_copy_clipboard(self: ptr Terminal00) {.
    importc, libprag.}

proc copyClipboard*(self: Terminal) =
  vte_terminal_copy_clipboard(cast[ptr Terminal00](self.impl))

proc vte_terminal_copy_clipboard_format(self: ptr Terminal00; format: Format) {.
    importc, libprag.}

proc copyClipboardFormat*(self: Terminal; format: Format) =
  vte_terminal_copy_clipboard_format(cast[ptr Terminal00](self.impl), format)

proc vte_terminal_copy_primary(self: ptr Terminal00) {.
    importc, libprag.}

proc copyPrimary*(self: Terminal) =
  vte_terminal_copy_primary(cast[ptr Terminal00](self.impl))

proc vte_terminal_event_check_gregex_simple(self: ptr Terminal00; event: ptr gdk.Event00;
    regexes: ptr ptr glib.Regex00; nRegexes: var uint64; matchFlags: glib.RegexMatchFlags;
    matches: var ptr cstring): gboolean {.
    importc, libprag.}

proc eventCheckGregexSimple*(self: Terminal; event: gdk.Event;
    regexes: ptr ptr glib.Regex00; nRegexes: var uint64; matchFlags: glib.RegexMatchFlags;
    matches: var seq[string]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var matches_00 = seq2CstringArray(matches, fs469n23)
  result = toBool(vte_terminal_event_check_gregex_simple(cast[ptr Terminal00](self.impl), cast[ptr gdk.Event00](event.impl), regexes, nRegexes, matchFlags, matches_00))
  if matches.addr != nil:
    matches = cstringArrayToSeq(matches_00)

proc vte_terminal_event_check_regex_array(self: ptr Terminal00; event: ptr gdk.Event00;
    regexes: ptr ptr Regex00; nRegexes: uint64; matchFlags: uint32; nMatches: var uint64): ptr cstring {.
    importc, libprag.}

proc eventCheckRegexSimple*(self: Terminal; event: gdk.Event;
    regexes: ptr ptr Regex00; nRegexes: uint64; matchFlags: int; nMatches: var uint64 = cast[var uint64](nil)): seq[string] =
  let resul0 = vte_terminal_event_check_regex_array(cast[ptr Terminal00](self.impl), cast[ptr gdk.Event00](event.impl), regexes, nRegexes, uint32(matchFlags), nMatches)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc vte_terminal_feed(self: ptr Terminal00; data: ptr uint8; length: int64) {.
    importc, libprag.}

proc feed*(self: Terminal; data: seq[uint8] | string) =
  let length = int64(data.len)
  vte_terminal_feed(cast[ptr Terminal00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

proc vte_terminal_feed_child(self: ptr Terminal00; text: ptr uint8; length: int64) {.
    importc, libprag.}

proc feedChild*(self: Terminal; text: seq[uint8] | string) =
  let length = int64(text.len)
  vte_terminal_feed_child(cast[ptr Terminal00](self.impl), cast[ptr uint8](unsafeaddr(text[0])), length)

proc vte_terminal_feed_child_binary(self: ptr Terminal00; data: ptr uint8;
    length: uint64) {.
    importc, libprag.}

proc feedChildBinary*(self: Terminal; data: seq[uint8] | string) =
  let length = uint64(data.len)
  vte_terminal_feed_child_binary(cast[ptr Terminal00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), length)

proc vte_terminal_get_allow_bold(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getAllowBold*(self: Terminal): bool =
  toBool(vte_terminal_get_allow_bold(cast[ptr Terminal00](self.impl)))

proc allowBold*(self: Terminal): bool =
  toBool(vte_terminal_get_allow_bold(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_allow_hyperlink(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getAllowHyperlink*(self: Terminal): bool =
  toBool(vte_terminal_get_allow_hyperlink(cast[ptr Terminal00](self.impl)))

proc allowHyperlink*(self: Terminal): bool =
  toBool(vte_terminal_get_allow_hyperlink(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_audible_bell(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getAudibleBell*(self: Terminal): bool =
  toBool(vte_terminal_get_audible_bell(cast[ptr Terminal00](self.impl)))

proc audibleBell*(self: Terminal): bool =
  toBool(vte_terminal_get_audible_bell(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_bold_is_bright(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getBoldIsBright*(self: Terminal): bool =
  toBool(vte_terminal_get_bold_is_bright(cast[ptr Terminal00](self.impl)))

proc boldIsBright*(self: Terminal): bool =
  toBool(vte_terminal_get_bold_is_bright(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_cell_height_scale(self: ptr Terminal00): cdouble {.
    importc, libprag.}

proc getCellHeightScale*(self: Terminal): cdouble =
  vte_terminal_get_cell_height_scale(cast[ptr Terminal00](self.impl))

proc cellHeightScale*(self: Terminal): cdouble =
  vte_terminal_get_cell_height_scale(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_cell_width_scale(self: ptr Terminal00): cdouble {.
    importc, libprag.}

proc getCellWidthScale*(self: Terminal): cdouble =
  vte_terminal_get_cell_width_scale(cast[ptr Terminal00](self.impl))

proc cellWidthScale*(self: Terminal): cdouble =
  vte_terminal_get_cell_width_scale(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_char_height(self: ptr Terminal00): int64 {.
    importc, libprag.}

proc getCharHeight*(self: Terminal): int64 =
  vte_terminal_get_char_height(cast[ptr Terminal00](self.impl))

proc charHeight*(self: Terminal): int64 =
  vte_terminal_get_char_height(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_char_width(self: ptr Terminal00): int64 {.
    importc, libprag.}

proc getCharWidth*(self: Terminal): int64 =
  vte_terminal_get_char_width(cast[ptr Terminal00](self.impl))

proc charWidth*(self: Terminal): int64 =
  vte_terminal_get_char_width(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_cjk_ambiguous_width(self: ptr Terminal00): int32 {.
    importc, libprag.}

proc getCjkAmbiguousWidth*(self: Terminal): int =
  int(vte_terminal_get_cjk_ambiguous_width(cast[ptr Terminal00](self.impl)))

proc cjkAmbiguousWidth*(self: Terminal): int =
  int(vte_terminal_get_cjk_ambiguous_width(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_color_background_for_draw(self: ptr Terminal00; color: var gdk.RGBA) {.
    importc, libprag.}

proc getColorBackgroundForDraw*(self: Terminal; color: var gdk.RGBA) =
  vte_terminal_get_color_background_for_draw(cast[ptr Terminal00](self.impl), color)

proc getColorBackgroundForDraw*(self: Terminal): gdk.RGBA =
  vte_terminal_get_color_background_for_draw(cast[ptr Terminal00](self.impl), result)

proc vte_terminal_get_column_count(self: ptr Terminal00): int64 {.
    importc, libprag.}

proc getColumnCount*(self: Terminal): int64 =
  vte_terminal_get_column_count(cast[ptr Terminal00](self.impl))

proc columnCount*(self: Terminal): int64 =
  vte_terminal_get_column_count(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_current_directory_uri(self: ptr Terminal00): cstring {.
    importc, libprag.}

proc getCurrentDirectoryUri*(self: Terminal): string =
  let resul0 = vte_terminal_get_current_directory_uri(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc currentDirectoryUri*(self: Terminal): string =
  let resul0 = vte_terminal_get_current_directory_uri(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vte_terminal_get_current_file_uri(self: ptr Terminal00): cstring {.
    importc, libprag.}

proc getCurrentFileUri*(self: Terminal): string =
  let resul0 = vte_terminal_get_current_file_uri(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc currentFileUri*(self: Terminal): string =
  let resul0 = vte_terminal_get_current_file_uri(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vte_terminal_get_cursor_blink_mode(self: ptr Terminal00): CursorBlinkMode {.
    importc, libprag.}

proc getCursorBlinkMode*(self: Terminal): CursorBlinkMode =
  vte_terminal_get_cursor_blink_mode(cast[ptr Terminal00](self.impl))

proc cursorBlinkMode*(self: Terminal): CursorBlinkMode =
  vte_terminal_get_cursor_blink_mode(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_cursor_position(self: ptr Terminal00; column: var int64;
    row: var int64) {.
    importc, libprag.}

proc getCursorPosition*(self: Terminal; column: var int64 = cast[var int64](nil);
    row: var int64 = cast[var int64](nil)) =
  vte_terminal_get_cursor_position(cast[ptr Terminal00](self.impl), column, row)

proc vte_terminal_get_cursor_shape(self: ptr Terminal00): CursorShape {.
    importc, libprag.}

proc getCursorShape*(self: Terminal): CursorShape =
  vte_terminal_get_cursor_shape(cast[ptr Terminal00](self.impl))

proc cursorShape*(self: Terminal): CursorShape =
  vte_terminal_get_cursor_shape(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_enable_bidi(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getEnableBidi*(self: Terminal): bool =
  toBool(vte_terminal_get_enable_bidi(cast[ptr Terminal00](self.impl)))

proc enableBidi*(self: Terminal): bool =
  toBool(vte_terminal_get_enable_bidi(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_enable_shaping(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getEnableShaping*(self: Terminal): bool =
  toBool(vte_terminal_get_enable_shaping(cast[ptr Terminal00](self.impl)))

proc enableShaping*(self: Terminal): bool =
  toBool(vte_terminal_get_enable_shaping(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_enable_sixel(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getEnableSixel*(self: Terminal): bool =
  toBool(vte_terminal_get_enable_sixel(cast[ptr Terminal00](self.impl)))

proc enableSixel*(self: Terminal): bool =
  toBool(vte_terminal_get_enable_sixel(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_encoding(self: ptr Terminal00): cstring {.
    importc, libprag.}

proc getEncoding*(self: Terminal): string =
  let resul0 = vte_terminal_get_encoding(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc encoding*(self: Terminal): string =
  let resul0 = vte_terminal_get_encoding(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vte_terminal_get_font(self: ptr Terminal00): ptr pango.FontDescription00 {.
    importc, libprag.}

proc getFont*(self: Terminal): pango.FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = vte_terminal_get_font(cast[ptr Terminal00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_font_description_get_type(), result.impl))

proc font*(self: Terminal): pango.FontDescription =
  fnew(result, gBoxedFreePangoFontDescription)
  result.impl = vte_terminal_get_font(cast[ptr Terminal00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(pango_font_description_get_type(), result.impl))

proc vte_terminal_get_font_scale(self: ptr Terminal00): cdouble {.
    importc, libprag.}

proc getFontScale*(self: Terminal): cdouble =
  vte_terminal_get_font_scale(cast[ptr Terminal00](self.impl))

proc fontScale*(self: Terminal): cdouble =
  vte_terminal_get_font_scale(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_geometry_hints(self: ptr Terminal00; hints: var gdk.Geometry;
    minRows: int32; minColumns: int32) {.
    importc, libprag.}

proc getGeometryHints*(self: Terminal; hints: var gdk.Geometry;
    minRows: int; minColumns: int) =
  vte_terminal_get_geometry_hints(cast[ptr Terminal00](self.impl), hints, int32(minRows), int32(minColumns))

proc vte_terminal_get_has_selection(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getHasSelection*(self: Terminal): bool =
  toBool(vte_terminal_get_has_selection(cast[ptr Terminal00](self.impl)))

proc hasSelection*(self: Terminal): bool =
  toBool(vte_terminal_get_has_selection(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_icon_title(self: ptr Terminal00): cstring {.
    importc, libprag.}

proc getIconTitle*(self: Terminal): string =
  let resul0 = vte_terminal_get_icon_title(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconTitle*(self: Terminal): string =
  let resul0 = vte_terminal_get_icon_title(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vte_terminal_get_input_enabled(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getInputEnabled*(self: Terminal): bool =
  toBool(vte_terminal_get_input_enabled(cast[ptr Terminal00](self.impl)))

proc inputEnabled*(self: Terminal): bool =
  toBool(vte_terminal_get_input_enabled(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_mouse_autohide(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getMouseAutohide*(self: Terminal): bool =
  toBool(vte_terminal_get_mouse_autohide(cast[ptr Terminal00](self.impl)))

proc mouseAutohide*(self: Terminal): bool =
  toBool(vte_terminal_get_mouse_autohide(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_pty(self: ptr Terminal00): ptr Pty00 {.
    importc, libprag.}

proc getPty*(self: Terminal): Pty =
  let gobj = vte_terminal_get_pty(cast[ptr Terminal00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pty*(self: Terminal): Pty =
  let gobj = vte_terminal_get_pty(cast[ptr Terminal00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc vte_terminal_get_rewrap_on_resize(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getRewrapOnResize*(self: Terminal): bool =
  toBool(vte_terminal_get_rewrap_on_resize(cast[ptr Terminal00](self.impl)))

proc rewrapOnResize*(self: Terminal): bool =
  toBool(vte_terminal_get_rewrap_on_resize(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_row_count(self: ptr Terminal00): int64 {.
    importc, libprag.}

proc getRowCount*(self: Terminal): int64 =
  vte_terminal_get_row_count(cast[ptr Terminal00](self.impl))

proc rowCount*(self: Terminal): int64 =
  vte_terminal_get_row_count(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_scroll_on_keystroke(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getScrollOnKeystroke*(self: Terminal): bool =
  toBool(vte_terminal_get_scroll_on_keystroke(cast[ptr Terminal00](self.impl)))

proc scrollOnKeystroke*(self: Terminal): bool =
  toBool(vte_terminal_get_scroll_on_keystroke(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_scroll_on_output(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc getScrollOnOutput*(self: Terminal): bool =
  toBool(vte_terminal_get_scroll_on_output(cast[ptr Terminal00](self.impl)))

proc scrollOnOutput*(self: Terminal): bool =
  toBool(vte_terminal_get_scroll_on_output(cast[ptr Terminal00](self.impl)))

proc vte_terminal_get_scrollback_lines(self: ptr Terminal00): int64 {.
    importc, libprag.}

proc getScrollbackLines*(self: Terminal): int64 =
  vte_terminal_get_scrollback_lines(cast[ptr Terminal00](self.impl))

proc scrollbackLines*(self: Terminal): int64 =
  vte_terminal_get_scrollback_lines(cast[ptr Terminal00](self.impl))

proc vte_terminal_get_window_title(self: ptr Terminal00): cstring {.
    importc, libprag.}

proc getWindowTitle*(self: Terminal): string =
  let resul0 = vte_terminal_get_window_title(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc windowTitle*(self: Terminal): string =
  let resul0 = vte_terminal_get_window_title(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vte_terminal_get_word_char_exceptions(self: ptr Terminal00): cstring {.
    importc, libprag.}

proc getWordCharExceptions*(self: Terminal): string =
  let resul0 = vte_terminal_get_word_char_exceptions(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc wordCharExceptions*(self: Terminal): string =
  let resul0 = vte_terminal_get_word_char_exceptions(cast[ptr Terminal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc vte_terminal_hyperlink_check_event(self: ptr Terminal00; event: ptr gdk.Event00): cstring {.
    importc, libprag.}

proc hyperlinkCheckEvent*(self: Terminal; event: gdk.Event): string =
  let resul0 = vte_terminal_hyperlink_check_event(cast[ptr Terminal00](self.impl), cast[ptr gdk.Event00](event.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc vte_terminal_match_add_gregex(self: ptr Terminal00; gregex: ptr glib.Regex00;
    gflags: glib.RegexMatchFlags): int32 {.
    importc, libprag.}

proc matchAddGregex*(self: Terminal; gregex: glib.Regex; gflags: glib.RegexMatchFlags): int =
  int(vte_terminal_match_add_gregex(cast[ptr Terminal00](self.impl), cast[ptr glib.Regex00](gregex.impl), gflags))

proc vte_terminal_match_add_regex(self: ptr Terminal00; regex: ptr Regex00;
    flags: uint32): int32 {.
    importc, libprag.}

proc matchAddRegex*(self: Terminal; regex: Regex; flags: int): int =
  int(vte_terminal_match_add_regex(cast[ptr Terminal00](self.impl), cast[ptr Regex00](regex.impl), uint32(flags)))

proc vte_terminal_match_check(self: ptr Terminal00; column: int64; row: int64;
    tag: var int32): cstring {.
    importc, libprag.}

proc matchCheck*(self: Terminal; column: int64; row: int64;
    tag: var int = cast[var int](nil)): string =
  var tag_00: int32
  let resul0 = vte_terminal_match_check(cast[ptr Terminal00](self.impl), column, row, tag_00)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)
  if tag.addr != nil:
    tag = int(tag_00)

proc vte_terminal_match_check_event(self: ptr Terminal00; event: ptr gdk.Event00;
    tag: var int32): cstring {.
    importc, libprag.}

proc matchCheckEvent*(self: Terminal; event: gdk.Event; tag: var int = cast[var int](nil)): string =
  var tag_00: int32
  let resul0 = vte_terminal_match_check_event(cast[ptr Terminal00](self.impl), cast[ptr gdk.Event00](event.impl), tag_00)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)
  if tag.addr != nil:
    tag = int(tag_00)

proc vte_terminal_match_remove(self: ptr Terminal00; tag: int32) {.
    importc, libprag.}

proc matchRemove*(self: Terminal; tag: int) =
  vte_terminal_match_remove(cast[ptr Terminal00](self.impl), int32(tag))

proc vte_terminal_match_remove_all(self: ptr Terminal00) {.
    importc, libprag.}

proc matchRemoveAll*(self: Terminal) =
  vte_terminal_match_remove_all(cast[ptr Terminal00](self.impl))

proc vte_terminal_match_set_cursor(self: ptr Terminal00; tag: int32; cursor: ptr gdk.Cursor00) {.
    importc, libprag.}

proc matchSetCursor*(self: Terminal; tag: int; cursor: gdk.Cursor = nil) =
  vte_terminal_match_set_cursor(cast[ptr Terminal00](self.impl), int32(tag), if cursor.isNil: nil else: cast[ptr gdk.Cursor00](cursor.impl))

proc vte_terminal_match_set_cursor_name(self: ptr Terminal00; tag: int32;
    cursorName: cstring) {.
    importc, libprag.}

proc matchSetCursorName*(self: Terminal; tag: int; cursorName: cstring) =
  vte_terminal_match_set_cursor_name(cast[ptr Terminal00](self.impl), int32(tag), cursorName)

proc vte_terminal_match_set_cursor_type(self: ptr Terminal00; tag: int32;
    cursorType: gdk.CursorType) {.
    importc, libprag.}

proc matchSetCursorType*(self: Terminal; tag: int; cursorType: gdk.CursorType) =
  vte_terminal_match_set_cursor_type(cast[ptr Terminal00](self.impl), int32(tag), cursorType)

proc vte_terminal_paste_clipboard(self: ptr Terminal00) {.
    importc, libprag.}

proc pasteClipboard*(self: Terminal) =
  vte_terminal_paste_clipboard(cast[ptr Terminal00](self.impl))

proc vte_terminal_paste_primary(self: ptr Terminal00) {.
    importc, libprag.}

proc pastePrimary*(self: Terminal) =
  vte_terminal_paste_primary(cast[ptr Terminal00](self.impl))

proc vte_terminal_pty_new_sync(self: ptr Terminal00; flags: PtyFlags; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): ptr Pty00 {.
    importc, libprag.}

proc ptyNewSync*(self: Terminal; flags: PtyFlags; cancellable: gio.Cancellable = nil): Pty =
  var gerror: ptr glib.Error
  let gobj = vte_terminal_pty_new_sync(cast[ptr Terminal00](self.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, vte.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc vte_terminal_reset(self: ptr Terminal00; clearTabstops: gboolean; clearHistory: gboolean) {.
    importc, libprag.}

proc reset*(self: Terminal; clearTabstops: bool; clearHistory: bool) =
  vte_terminal_reset(cast[ptr Terminal00](self.impl), gboolean(clearTabstops), gboolean(clearHistory))

proc vte_terminal_search_find_next(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc searchFindNext*(self: Terminal): bool =
  toBool(vte_terminal_search_find_next(cast[ptr Terminal00](self.impl)))

proc vte_terminal_search_find_previous(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc searchFindPrevious*(self: Terminal): bool =
  toBool(vte_terminal_search_find_previous(cast[ptr Terminal00](self.impl)))

proc vte_terminal_search_get_gregex(self: ptr Terminal00): ptr glib.Regex00 {.
    importc, libprag.}

proc searchGetGregex*(self: Terminal): glib.Regex =
  fnew(result, gBoxedFreeGRegex)
  result.impl = vte_terminal_search_get_gregex(cast[ptr Terminal00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_regex_get_type(), result.impl))

proc vte_terminal_search_get_regex(self: ptr Terminal00): ptr Regex00 {.
    importc, libprag.}

proc searchGetRegex*(self: Terminal): Regex =
  fnew(result, gBoxedFreeVteRegex)
  result.impl = vte_terminal_search_get_regex(cast[ptr Terminal00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(vte_regex_get_type(), result.impl))

proc vte_terminal_search_get_wrap_around(self: ptr Terminal00): gboolean {.
    importc, libprag.}

proc searchGetWrapAround*(self: Terminal): bool =
  toBool(vte_terminal_search_get_wrap_around(cast[ptr Terminal00](self.impl)))

proc vte_terminal_search_set_gregex(self: ptr Terminal00; gregex: ptr glib.Regex00;
    gflags: glib.RegexMatchFlags) {.
    importc, libprag.}

proc searchSetGregex*(self: Terminal; gregex: glib.Regex = nil;
    gflags: glib.RegexMatchFlags) =
  vte_terminal_search_set_gregex(cast[ptr Terminal00](self.impl), if gregex.isNil: nil else: cast[ptr glib.Regex00](gregex.impl), gflags)

proc vte_terminal_search_set_regex(self: ptr Terminal00; regex: ptr Regex00;
    flags: uint32) {.
    importc, libprag.}

proc searchSetRegex*(self: Terminal; regex: Regex = nil; flags: int) =
  vte_terminal_search_set_regex(cast[ptr Terminal00](self.impl), if regex.isNil: nil else: cast[ptr Regex00](regex.impl), uint32(flags))

proc vte_terminal_search_set_wrap_around(self: ptr Terminal00; wrapAround: gboolean) {.
    importc, libprag.}

proc searchSetWrapAround*(self: Terminal; wrapAround: bool = true) =
  vte_terminal_search_set_wrap_around(cast[ptr Terminal00](self.impl), gboolean(wrapAround))

proc vte_terminal_select_all(self: ptr Terminal00) {.
    importc, libprag.}

proc selectAll*(self: Terminal) =
  vte_terminal_select_all(cast[ptr Terminal00](self.impl))

proc vte_terminal_set_allow_bold(self: ptr Terminal00; allowBold: gboolean) {.
    importc, libprag.}

proc setAllowBold*(self: Terminal; allowBold: bool = true) =
  vte_terminal_set_allow_bold(cast[ptr Terminal00](self.impl), gboolean(allowBold))

proc `allowBold=`*(self: Terminal; allowBold: bool) =
  vte_terminal_set_allow_bold(cast[ptr Terminal00](self.impl), gboolean(allowBold))

proc vte_terminal_set_allow_hyperlink(self: ptr Terminal00; allowHyperlink: gboolean) {.
    importc, libprag.}

proc setAllowHyperlink*(self: Terminal; allowHyperlink: bool = true) =
  vte_terminal_set_allow_hyperlink(cast[ptr Terminal00](self.impl), gboolean(allowHyperlink))

proc `allowHyperlink=`*(self: Terminal; allowHyperlink: bool) =
  vte_terminal_set_allow_hyperlink(cast[ptr Terminal00](self.impl), gboolean(allowHyperlink))

proc vte_terminal_set_audible_bell(self: ptr Terminal00; isAudible: gboolean) {.
    importc, libprag.}

proc setAudibleBell*(self: Terminal; isAudible: bool = true) =
  vte_terminal_set_audible_bell(cast[ptr Terminal00](self.impl), gboolean(isAudible))

proc `audibleBell=`*(self: Terminal; isAudible: bool) =
  vte_terminal_set_audible_bell(cast[ptr Terminal00](self.impl), gboolean(isAudible))

proc vte_terminal_set_backspace_binding(self: ptr Terminal00; binding: EraseBinding) {.
    importc, libprag.}

proc setBackspaceBinding*(self: Terminal; binding: EraseBinding) =
  vte_terminal_set_backspace_binding(cast[ptr Terminal00](self.impl), binding)

proc `backspaceBinding=`*(self: Terminal; binding: EraseBinding) =
  vte_terminal_set_backspace_binding(cast[ptr Terminal00](self.impl), binding)

proc vte_terminal_set_bold_is_bright(self: ptr Terminal00; boldIsBright: gboolean) {.
    importc, libprag.}

proc setBoldIsBright*(self: Terminal; boldIsBright: bool = true) =
  vte_terminal_set_bold_is_bright(cast[ptr Terminal00](self.impl), gboolean(boldIsBright))

proc `boldIsBright=`*(self: Terminal; boldIsBright: bool) =
  vte_terminal_set_bold_is_bright(cast[ptr Terminal00](self.impl), gboolean(boldIsBright))

proc vte_terminal_set_cell_height_scale(self: ptr Terminal00; scale: cdouble) {.
    importc, libprag.}

proc setCellHeightScale*(self: Terminal; scale: cdouble) =
  vte_terminal_set_cell_height_scale(cast[ptr Terminal00](self.impl), scale)

proc `cellHeightScale=`*(self: Terminal; scale: cdouble) =
  vte_terminal_set_cell_height_scale(cast[ptr Terminal00](self.impl), scale)

proc vte_terminal_set_cell_width_scale(self: ptr Terminal00; scale: cdouble) {.
    importc, libprag.}

proc setCellWidthScale*(self: Terminal; scale: cdouble) =
  vte_terminal_set_cell_width_scale(cast[ptr Terminal00](self.impl), scale)

proc `cellWidthScale=`*(self: Terminal; scale: cdouble) =
  vte_terminal_set_cell_width_scale(cast[ptr Terminal00](self.impl), scale)

proc vte_terminal_set_cjk_ambiguous_width(self: ptr Terminal00; width: int32) {.
    importc, libprag.}

proc setCjkAmbiguousWidth*(self: Terminal; width: int) =
  vte_terminal_set_cjk_ambiguous_width(cast[ptr Terminal00](self.impl), int32(width))

proc `cjkAmbiguousWidth=`*(self: Terminal; width: int) =
  vte_terminal_set_cjk_ambiguous_width(cast[ptr Terminal00](self.impl), int32(width))

proc vte_terminal_set_clear_background(self: ptr Terminal00; setting: gboolean) {.
    importc, libprag.}

proc setClearBackground*(self: Terminal; setting: bool = true) =
  vte_terminal_set_clear_background(cast[ptr Terminal00](self.impl), gboolean(setting))

proc `clearBackground=`*(self: Terminal; setting: bool) =
  vte_terminal_set_clear_background(cast[ptr Terminal00](self.impl), gboolean(setting))

proc vte_terminal_set_color_background(self: ptr Terminal00; background: gdk.RGBA) {.
    importc, libprag.}

proc setColorBackground*(self: Terminal; background: gdk.RGBA) =
  vte_terminal_set_color_background(cast[ptr Terminal00](self.impl), background)

proc `colorBackground=`*(self: Terminal; background: gdk.RGBA) =
  vte_terminal_set_color_background(cast[ptr Terminal00](self.impl), background)

proc vte_terminal_set_color_bold(self: ptr Terminal00; bold: gdk.RGBA) {.
    importc, libprag.}

proc setColorBold*(self: Terminal; bold: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_bold(cast[ptr Terminal00](self.impl), bold)

proc `colorBold=`*(self: Terminal; bold: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_bold(cast[ptr Terminal00](self.impl), bold)

proc vte_terminal_set_color_cursor(self: ptr Terminal00; cursorBackground: gdk.RGBA) {.
    importc, libprag.}

proc setColorCursor*(self: Terminal; cursorBackground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_cursor(cast[ptr Terminal00](self.impl), cursorBackground)

proc `colorCursor=`*(self: Terminal; cursorBackground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_cursor(cast[ptr Terminal00](self.impl), cursorBackground)

proc vte_terminal_set_color_cursor_foreground(self: ptr Terminal00; cursorForeground: gdk.RGBA) {.
    importc, libprag.}

proc setColorCursorForeground*(self: Terminal; cursorForeground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_cursor_foreground(cast[ptr Terminal00](self.impl), cursorForeground)

proc `colorCursorForeground=`*(self: Terminal; cursorForeground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_cursor_foreground(cast[ptr Terminal00](self.impl), cursorForeground)

proc vte_terminal_set_color_foreground(self: ptr Terminal00; foreground: gdk.RGBA) {.
    importc, libprag.}

proc setColorForeground*(self: Terminal; foreground: gdk.RGBA) =
  vte_terminal_set_color_foreground(cast[ptr Terminal00](self.impl), foreground)

proc `colorForeground=`*(self: Terminal; foreground: gdk.RGBA) =
  vte_terminal_set_color_foreground(cast[ptr Terminal00](self.impl), foreground)

proc vte_terminal_set_color_highlight(self: ptr Terminal00; highlightBackground: gdk.RGBA) {.
    importc, libprag.}

proc setColorHighlight*(self: Terminal; highlightBackground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_highlight(cast[ptr Terminal00](self.impl), highlightBackground)

proc `colorHighlight=`*(self: Terminal; highlightBackground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_highlight(cast[ptr Terminal00](self.impl), highlightBackground)

proc vte_terminal_set_color_highlight_foreground(self: ptr Terminal00; highlightForeground: gdk.RGBA) {.
    importc, libprag.}

proc setColorHighlightForeground*(self: Terminal; highlightForeground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_highlight_foreground(cast[ptr Terminal00](self.impl), highlightForeground)

proc `colorHighlightForeground=`*(self: Terminal; highlightForeground: gdk.RGBA = cast[var gdk.RGBA](nil)) =
  vte_terminal_set_color_highlight_foreground(cast[ptr Terminal00](self.impl), highlightForeground)

proc vte_terminal_set_colors(self: ptr Terminal00; foreground: gdk.RGBA;
    background: gdk.RGBA; palette: ptr gdk.RGBA; paletteSize: uint64) {.
    importc, libprag.}

proc setColors*(self: Terminal; foreground: gdk.RGBA = cast[var gdk.RGBA](nil);
    background: gdk.RGBA = cast[var gdk.RGBA](nil); palette: ptr gdk.RGBA;
    paletteSize: uint64) =
  vte_terminal_set_colors(cast[ptr Terminal00](self.impl), foreground, background, palette, paletteSize)

proc vte_terminal_set_cursor_blink_mode(self: ptr Terminal00; mode: CursorBlinkMode) {.
    importc, libprag.}

proc setCursorBlinkMode*(self: Terminal; mode: CursorBlinkMode) =
  vte_terminal_set_cursor_blink_mode(cast[ptr Terminal00](self.impl), mode)

proc `cursorBlinkMode=`*(self: Terminal; mode: CursorBlinkMode) =
  vte_terminal_set_cursor_blink_mode(cast[ptr Terminal00](self.impl), mode)

proc vte_terminal_set_cursor_shape(self: ptr Terminal00; shape: CursorShape) {.
    importc, libprag.}

proc setCursorShape*(self: Terminal; shape: CursorShape) =
  vte_terminal_set_cursor_shape(cast[ptr Terminal00](self.impl), shape)

proc `cursorShape=`*(self: Terminal; shape: CursorShape) =
  vte_terminal_set_cursor_shape(cast[ptr Terminal00](self.impl), shape)

proc vte_terminal_set_default_colors(self: ptr Terminal00) {.
    importc, libprag.}

proc setDefaultColors*(self: Terminal) =
  vte_terminal_set_default_colors(cast[ptr Terminal00](self.impl))

proc vte_terminal_set_delete_binding(self: ptr Terminal00; binding: EraseBinding) {.
    importc, libprag.}

proc setDeleteBinding*(self: Terminal; binding: EraseBinding) =
  vte_terminal_set_delete_binding(cast[ptr Terminal00](self.impl), binding)

proc `deleteBinding=`*(self: Terminal; binding: EraseBinding) =
  vte_terminal_set_delete_binding(cast[ptr Terminal00](self.impl), binding)

proc vte_terminal_set_enable_bidi(self: ptr Terminal00; enableBidi: gboolean) {.
    importc, libprag.}

proc setEnableBidi*(self: Terminal; enableBidi: bool = true) =
  vte_terminal_set_enable_bidi(cast[ptr Terminal00](self.impl), gboolean(enableBidi))

proc `enableBidi=`*(self: Terminal; enableBidi: bool) =
  vte_terminal_set_enable_bidi(cast[ptr Terminal00](self.impl), gboolean(enableBidi))

proc vte_terminal_set_enable_shaping(self: ptr Terminal00; enableShaping: gboolean) {.
    importc, libprag.}

proc setEnableShaping*(self: Terminal; enableShaping: bool = true) =
  vte_terminal_set_enable_shaping(cast[ptr Terminal00](self.impl), gboolean(enableShaping))

proc `enableShaping=`*(self: Terminal; enableShaping: bool) =
  vte_terminal_set_enable_shaping(cast[ptr Terminal00](self.impl), gboolean(enableShaping))

proc vte_terminal_set_enable_sixel(self: ptr Terminal00; enabled: gboolean) {.
    importc, libprag.}

proc setEnableSixel*(self: Terminal; enabled: bool = true) =
  vte_terminal_set_enable_sixel(cast[ptr Terminal00](self.impl), gboolean(enabled))

proc `enableSixel=`*(self: Terminal; enabled: bool) =
  vte_terminal_set_enable_sixel(cast[ptr Terminal00](self.impl), gboolean(enabled))

proc vte_terminal_set_encoding(self: ptr Terminal00; codeset: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setEncoding*(self: Terminal; codeset: cstring = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = vte_terminal_set_encoding(cast[ptr Terminal00](self.impl), codeset, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc vte_terminal_set_font(self: ptr Terminal00; fontDesc: ptr pango.FontDescription00) {.
    importc, libprag.}

proc setFont*(self: Terminal; fontDesc: pango.FontDescription = nil) =
  vte_terminal_set_font(cast[ptr Terminal00](self.impl), if fontDesc.isNil: nil else: cast[ptr pango.FontDescription00](fontDesc.impl))

proc `font=`*(self: Terminal; fontDesc: pango.FontDescription = nil) =
  vte_terminal_set_font(cast[ptr Terminal00](self.impl), if fontDesc.isNil: nil else: cast[ptr pango.FontDescription00](fontDesc.impl))

proc vte_terminal_set_font_scale(self: ptr Terminal00; scale: cdouble) {.
    importc, libprag.}

proc setFontScale*(self: Terminal; scale: cdouble) =
  vte_terminal_set_font_scale(cast[ptr Terminal00](self.impl), scale)

proc `fontScale=`*(self: Terminal; scale: cdouble) =
  vte_terminal_set_font_scale(cast[ptr Terminal00](self.impl), scale)

proc vte_terminal_set_geometry_hints_for_window(self: ptr Terminal00; window: ptr gtk.Window00) {.
    importc, libprag.}

proc setGeometryHintsForWindow*(self: Terminal; window: gtk.Window) =
  vte_terminal_set_geometry_hints_for_window(cast[ptr Terminal00](self.impl), cast[ptr gtk.Window00](window.impl))

proc `geometryHintsForWindow=`*(self: Terminal; window: gtk.Window) =
  vte_terminal_set_geometry_hints_for_window(cast[ptr Terminal00](self.impl), cast[ptr gtk.Window00](window.impl))

proc vte_terminal_set_input_enabled(self: ptr Terminal00; enabled: gboolean) {.
    importc, libprag.}

proc setInputEnabled*(self: Terminal; enabled: bool = true) =
  vte_terminal_set_input_enabled(cast[ptr Terminal00](self.impl), gboolean(enabled))

proc `inputEnabled=`*(self: Terminal; enabled: bool) =
  vte_terminal_set_input_enabled(cast[ptr Terminal00](self.impl), gboolean(enabled))

proc vte_terminal_set_mouse_autohide(self: ptr Terminal00; setting: gboolean) {.
    importc, libprag.}

proc setMouseAutohide*(self: Terminal; setting: bool = true) =
  vte_terminal_set_mouse_autohide(cast[ptr Terminal00](self.impl), gboolean(setting))

proc `mouseAutohide=`*(self: Terminal; setting: bool) =
  vte_terminal_set_mouse_autohide(cast[ptr Terminal00](self.impl), gboolean(setting))

proc vte_terminal_set_pty(self: ptr Terminal00; pty: ptr Pty00) {.
    importc, libprag.}

proc setPty*(self: Terminal; pty: Pty = nil) =
  vte_terminal_set_pty(cast[ptr Terminal00](self.impl), if pty.isNil: nil else: cast[ptr Pty00](pty.impl))

proc `pty=`*(self: Terminal; pty: Pty = nil) =
  vte_terminal_set_pty(cast[ptr Terminal00](self.impl), if pty.isNil: nil else: cast[ptr Pty00](pty.impl))

proc vte_terminal_set_rewrap_on_resize(self: ptr Terminal00; rewrap: gboolean) {.
    importc, libprag.}

proc setRewrapOnResize*(self: Terminal; rewrap: bool = true) =
  vte_terminal_set_rewrap_on_resize(cast[ptr Terminal00](self.impl), gboolean(rewrap))

proc `rewrapOnResize=`*(self: Terminal; rewrap: bool) =
  vte_terminal_set_rewrap_on_resize(cast[ptr Terminal00](self.impl), gboolean(rewrap))

proc vte_terminal_set_scroll_on_keystroke(self: ptr Terminal00; scroll: gboolean) {.
    importc, libprag.}

proc setScrollOnKeystroke*(self: Terminal; scroll: bool = true) =
  vte_terminal_set_scroll_on_keystroke(cast[ptr Terminal00](self.impl), gboolean(scroll))

proc `scrollOnKeystroke=`*(self: Terminal; scroll: bool) =
  vte_terminal_set_scroll_on_keystroke(cast[ptr Terminal00](self.impl), gboolean(scroll))

proc vte_terminal_set_scroll_on_output(self: ptr Terminal00; scroll: gboolean) {.
    importc, libprag.}

proc setScrollOnOutput*(self: Terminal; scroll: bool = true) =
  vte_terminal_set_scroll_on_output(cast[ptr Terminal00](self.impl), gboolean(scroll))

proc `scrollOnOutput=`*(self: Terminal; scroll: bool) =
  vte_terminal_set_scroll_on_output(cast[ptr Terminal00](self.impl), gboolean(scroll))

proc vte_terminal_set_scrollback_lines(self: ptr Terminal00; lines: int64) {.
    importc, libprag.}

proc setScrollbackLines*(self: Terminal; lines: int64) =
  vte_terminal_set_scrollback_lines(cast[ptr Terminal00](self.impl), lines)

proc `scrollbackLines=`*(self: Terminal; lines: int64) =
  vte_terminal_set_scrollback_lines(cast[ptr Terminal00](self.impl), lines)

proc vte_terminal_set_size(self: ptr Terminal00; columns: int64; rows: int64) {.
    importc, libprag.}

proc setSize*(self: Terminal; columns: int64; rows: int64) =
  vte_terminal_set_size(cast[ptr Terminal00](self.impl), columns, rows)

proc vte_terminal_set_word_char_exceptions(self: ptr Terminal00; exceptions: cstring) {.
    importc, libprag.}

proc setWordCharExceptions*(self: Terminal; exceptions: cstring) =
  vte_terminal_set_word_char_exceptions(cast[ptr Terminal00](self.impl), exceptions)

proc `wordCharExceptions=`*(self: Terminal; exceptions: cstring) =
  vte_terminal_set_word_char_exceptions(cast[ptr Terminal00](self.impl), exceptions)

proc vte_terminal_spawn_sync(self: ptr Terminal00; ptyFlags: PtyFlags; workingDirectory: cstring;
    argv: ptr cstring; envv: ptr cstring; spawnFlags: glib.SpawnFlags; childSetup: SpawnChildSetupFunc;
    childSetupData: pointer; childPid: var int32; cancellable: ptr gio.Cancellable00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc spawnSync*(self: Terminal; ptyFlags: PtyFlags; workingDirectory: cstring = nil;
    argv: openArray[string]; envv: openArray[string]; spawnFlags: glib.SpawnFlags;
    childSetup: SpawnChildSetupFunc; childSetupData: pointer; childPid: var int = cast[var int](nil);
    cancellable: gio.Cancellable = nil): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var gerror: ptr glib.Error
  var childPid_00: int32
  let resul0 = vte_terminal_spawn_sync(cast[ptr Terminal00](self.impl), ptyFlags, workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envv, fs469n232), spawnFlags, childSetup, childSetupData, childPid_00, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if childPid.addr != nil:
    childPid = int(childPid_00)

proc vte_terminal_unselect_all(self: ptr Terminal00) {.
    importc, libprag.}

proc unselectAll*(self: Terminal) =
  vte_terminal_unselect_all(cast[ptr Terminal00](self.impl))

proc vte_terminal_watch_child(self: ptr Terminal00; childPid: int32) {.
    importc, libprag.}

proc watchChild*(self: Terminal; childPid: int) =
  vte_terminal_watch_child(cast[ptr Terminal00](self.impl), int32(childPid))

type
  SelectionFunc* = proc (terminal: ptr Terminal00; column: int64; row: int64; data: pointer): gboolean {.cdecl.}

proc vte_terminal_get_text(self: ptr Terminal00; isSelected: SelectionFunc;
    userData: pointer; attributes: var ptr GArray00): cstring {.
    importc, libprag.}

proc getText*(self: Terminal; isSelected: SelectionFunc; userData: pointer;
    attributes: var ptr GArray00): string =
  let resul0 = vte_terminal_get_text(cast[ptr Terminal00](self.impl), isSelected, userData, attributes)
  result = $resul0
  cogfree(resul0)

proc vte_terminal_get_text_include_trailing_spaces(self: ptr Terminal00;
    isSelected: SelectionFunc; userData: pointer; attributes: var ptr GArray00): cstring {.
    importc, libprag.}

proc getTextIncludeTrailingSpaces*(self: Terminal; isSelected: SelectionFunc;
    userData: pointer; attributes: var ptr GArray00): string =
  let resul0 = vte_terminal_get_text_include_trailing_spaces(cast[ptr Terminal00](self.impl), isSelected, userData, attributes)
  result = $resul0
  cogfree(resul0)

proc vte_terminal_get_text_range(self: ptr Terminal00; startRow: int64; startCol: int64;
    endRow: int64; endCol: int64; isSelected: SelectionFunc; userData: pointer;
    attributes: var ptr GArray00): cstring {.
    importc, libprag.}

proc getTextRange*(self: Terminal; startRow: int64; startCol: int64;
    endRow: int64; endCol: int64; isSelected: SelectionFunc; userData: pointer;
    attributes: var ptr GArray00): string =
  let resul0 = vte_terminal_get_text_range(cast[ptr Terminal00](self.impl), startRow, startCol, endRow, endCol, isSelected, userData, attributes)
  result = $resul0
  cogfree(resul0)

type
  TextBlinkMode* {.size: sizeof(cint), pure.} = enum
    never = 0
    focused = 1
    unfocused = 2
    always = 3

proc vte_terminal_get_text_blink_mode(self: ptr Terminal00): TextBlinkMode {.
    importc, libprag.}

proc getTextBlinkMode*(self: Terminal): TextBlinkMode =
  vte_terminal_get_text_blink_mode(cast[ptr Terminal00](self.impl))

proc textBlinkMode*(self: Terminal): TextBlinkMode =
  vte_terminal_get_text_blink_mode(cast[ptr Terminal00](self.impl))

proc vte_terminal_set_text_blink_mode(self: ptr Terminal00; textBlinkMode: TextBlinkMode) {.
    importc, libprag.}

proc setTextBlinkMode*(self: Terminal; textBlinkMode: TextBlinkMode) =
  vte_terminal_set_text_blink_mode(cast[ptr Terminal00](self.impl), textBlinkMode)

proc `textBlinkMode=`*(self: Terminal; textBlinkMode: TextBlinkMode) =
  vte_terminal_set_text_blink_mode(cast[ptr Terminal00](self.impl), textBlinkMode)

type
  WriteFlags* {.size: sizeof(cint), pure.} = enum
    default = 0

proc vte_terminal_write_contents_sync(self: ptr Terminal00; stream: ptr gio.OutputStream00;
    flags: WriteFlags; cancellable: ptr gio.Cancellable00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc writeContentsSync*(self: Terminal; stream: gio.OutputStream;
    flags: WriteFlags; cancellable: gio.Cancellable = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = vte_terminal_write_contents_sync(cast[ptr Terminal00](self.impl), cast[ptr gio.OutputStream00](stream.impl), flags, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

const TEST_FLAGS_ALL* = 18446744073709551615'u64

const TEST_FLAGS_NONE* = 0'u64

type
  TerminalSpawnAsyncCallback* = proc (terminal: ptr Terminal00; pid: int32; error: ptr glib.Error; userData: pointer) {.cdecl.}

proc vte_terminal_spawn_async(self: ptr Terminal00; ptyFlags: PtyFlags; workingDirectory: cstring;
    argv: ptr cstring; envv: ptr cstring; spawnFlags: glib.SpawnFlags; childSetup: SpawnChildSetupFunc;
    childSetupData: pointer; childSetupDataDestroy: DestroyNotify; timeout: int32;
    cancellable: ptr gio.Cancellable00; callback: TerminalSpawnAsyncCallback;
    userData: pointer) {.
    importc, libprag.}

proc spawnAsync*(self: Terminal; ptyFlags: PtyFlags; workingDirectory: cstring = nil;
    argv: openArray[string]; envv: openArray[string]; spawnFlags: glib.SpawnFlags;
    childSetup: SpawnChildSetupFunc; childSetupData: pointer; childSetupDataDestroy: DestroyNotify;
    timeout: int; cancellable: gio.Cancellable = nil; callback: TerminalSpawnAsyncCallback;
    userData: pointer) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  vte_terminal_spawn_async(cast[ptr Terminal00](self.impl), ptyFlags, workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envv, fs469n232), spawnFlags, childSetup, childSetupData, childSetupDataDestroy, int32(timeout), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc vte_terminal_spawn_with_fds_async(self: ptr Terminal00; ptyFlags: PtyFlags;
    workingDirectory: cstring; argv: ptr cstring; envv: ptr cstring; fds: ptr int32;
    nFds: int32; mapFds: ptr int32; nMapFds: int32; spawnFlags: glib.SpawnFlags;
    childSetup: SpawnChildSetupFunc; childSetupData: pointer; childSetupDataDestroy: DestroyNotify;
    timeout: int32; cancellable: ptr gio.Cancellable00; callback: TerminalSpawnAsyncCallback;
    userData: pointer) {.
    importc, libprag.}

proc spawnWithFdsAsync*(self: Terminal; ptyFlags: PtyFlags;
    workingDirectory: cstring = nil; argv: openArray[string]; envv: openArray[string];
    fds: seq[int32]; nFds: int; mapFds: seq[int32]; spawnFlags: glib.SpawnFlags;
    childSetup: SpawnChildSetupFunc; childSetupData: pointer; childSetupDataDestroy: DestroyNotify;
    timeout: int; cancellable: gio.Cancellable = nil; callback: TerminalSpawnAsyncCallback;
    userData: pointer) =
  let nMapFds = int(mapFds.len)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  vte_terminal_spawn_with_fds_async(cast[ptr Terminal00](self.impl), ptyFlags, workingDirectory, seq2CstringArray(argv, fs469n23), seq2CstringArray(envv, fs469n232), cast[ptr int32](unsafeaddr(fds[0])), int32(nFds), cast[ptr int32](unsafeaddr(mapFds[0])), int32(nMapFds), spawnFlags, childSetup, childSetupData, childSetupDataDestroy, int32(timeout), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc vte_get_encoding_supported(encoding: cstring): gboolean {.
    importc, libprag.}

proc getEncodingSupported*(encoding: cstring): bool =
  toBool(vte_get_encoding_supported(encoding))

proc encodingSupported*(encoding: cstring): bool =
  toBool(vte_get_encoding_supported(encoding))

proc vte_get_encodings(includeAliases: gboolean): ptr cstring {.
    importc, libprag.}

proc getEncodings*(includeAliases: bool): seq[string] =
  let resul0 = vte_get_encodings(gboolean(includeAliases))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc encodings*(includeAliases: bool): seq[string] =
  let resul0 = vte_get_encodings(gboolean(includeAliases))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc getFeatureFlags*(): FeatureFlags {.
    importc: "vte_get_feature_flags", libprag.}

proc vte_get_features(): cstring {.
    importc, libprag.}

proc getFeatures*(): string =
  result = $vte_get_features()

proc vte_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(vte_get_major_version())

proc vte_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(vte_get_micro_version())

proc vte_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(vte_get_minor_version())

proc vte_get_user_shell(): cstring {.
    importc, libprag.}

proc getUserShell*(): string =
  let resul0 = vte_get_user_shell()
  result = $resul0
  cogfree(resul0)
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc initable*(x: vte.Pty): gio.Initable = cast[gio.Initable](x)

proc implementorIface*(x: vte.Terminal): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: vte.Terminal): gtk.Buildable = cast[gtk.Buildable](x)

proc scrollable*(x: vte.Terminal): gtk.Scrollable = cast[gtk.Scrollable](x)
