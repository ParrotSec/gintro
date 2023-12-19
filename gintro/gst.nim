# dependencies:
# GObject-2.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# GObject-2.0
# GModule-2.0
# GLib-2.0
# libraries:
# libgstreamer-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, glib, gmodule
const Lib = "libgstreamer-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const ALLOCATOR_SYSMEM* = "SystemMemory"

type
  AllocationParams00* {.pure.} = object
  AllocationParams* = ref object
    impl*: ptr AllocationParams00
    ignoreFinalizer*: bool

proc gst_allocation_params_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstAllocationParams*(self: AllocationParams) =
  if not self.ignoreFinalizer:
    boxedFree(gst_allocation_params_get_type(), cast[ptr AllocationParams00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AllocationParams()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_allocation_params_get_type(), cast[ptr AllocationParams00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AllocationParams) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstAllocationParams)

proc gst_allocation_params_free(self: ptr AllocationParams00) {.
    importc, libprag.}

proc free*(self: AllocationParams) =
  gst_allocation_params_free(cast[ptr AllocationParams00](g_boxed_copy(gst_allocation_params_get_type(), self.impl)))

proc finalizerfree*(self: AllocationParams) =
  if not self.ignoreFinalizer:
    gst_allocation_params_free(cast[ptr AllocationParams00](self.impl))

proc gst_allocation_params_copy(self: ptr AllocationParams00): ptr AllocationParams00 {.
    importc, libprag.}

proc copy*(self: AllocationParams): AllocationParams =
  let impl0 = gst_allocation_params_copy(cast[ptr AllocationParams00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstAllocationParams)
  result.impl = impl0

proc gst_allocation_params_init(self: ptr AllocationParams00) {.
    importc, libprag.}

proc init*(self: AllocationParams) =
  gst_allocation_params_init(cast[ptr AllocationParams00](self.impl))

type
  Object* = ref object of gobject.InitiallyUnowned
  Object00* = object of gobject.InitiallyUnowned00

proc gst_object_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Object()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDeepNotify*(self: Object;  p: proc (self: ptr Object00; propObject: ptr Object00; prop: ptr gobject.ParamSpec00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "deep-notify", cast[GCallback](p), xdata, nil, cf)

proc gst_object_check_uniqueness(list: ptr glib.List; name: cstring): gboolean {.
    importc, libprag.}

proc checkUniqueness*(list: seq[Object]; name: cstring): bool =
  var tempResGL = seq2GList(list)
  result = toBool(gst_object_check_uniqueness(tempResGL, name))
  g_list_free(tempResGL)

proc gst_object_default_deep_notify(`object`: ptr gobject.Object00; orig: ptr Object00;
    pspec: ptr gobject.ParamSpec00; excludedProps: ptr cstring) {.
    importc, libprag.}

proc defaultDeepNotify*(`object`: gobject.Object; orig: Object;
    pspec: gobject.ParamSpec; excludedProps: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gst_object_default_deep_notify(cast[ptr gobject.Object00](`object`.impl), cast[ptr Object00](orig.impl), cast[ptr gobject.ParamSpec00](pspec.impl), seq2CstringArray(excludedProps, fs469n23))

proc gst_object_default_error(self: ptr Object00; error: ptr glib.Error;
    debug: cstring) {.
    importc, libprag.}

proc defaultError*(self: Object; error: ptr glib.Error; debug: cstring = nil) =
  gst_object_default_error(cast[ptr Object00](self.impl), error, debug)

proc gst_object_get_control_rate(self: ptr Object00): uint64 {.
    importc, libprag.}

proc getControlRate*(self: Object): uint64 =
  gst_object_get_control_rate(cast[ptr Object00](self.impl))

proc controlRate*(self: Object): uint64 =
  gst_object_get_control_rate(cast[ptr Object00](self.impl))

proc gst_object_get_g_value_array(self: ptr Object00; propertyName: cstring;
    timestamp: uint64; interval: uint64; nValues: uint32; values: ptr gobject.Value): gboolean {.
    importc, libprag.}

proc getGValueArray*(self: Object; propertyName: cstring; timestamp: uint64;
    interval: uint64; nValues: int; values: ptr gobject.Value): bool =
  toBool(gst_object_get_g_value_array(cast[ptr Object00](self.impl), propertyName, timestamp, interval, uint32(nValues), values))

proc gst_object_get_name(self: ptr Object00): cstring {.
    importc, libprag.}

proc getName*(self: Object): string =
  let resul0 = gst_object_get_name(cast[ptr Object00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc name*(self: Object): string =
  let resul0 = gst_object_get_name(cast[ptr Object00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_object_get_parent(self: ptr Object00): ptr Object00 {.
    importc, libprag.}

proc getParent*(self: Object): Object =
  let gobj = gst_object_get_parent(cast[ptr Object00](self.impl))
  if gobj.isNil:
    return nil
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

proc parent*(self: Object): Object =
  let gobj = gst_object_get_parent(cast[ptr Object00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_object_get_path_string(self: ptr Object00): cstring {.
    importc, libprag.}

proc getPathString*(self: Object): string =
  let resul0 = gst_object_get_path_string(cast[ptr Object00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pathString*(self: Object): string =
  let resul0 = gst_object_get_path_string(cast[ptr Object00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_object_get_value(self: ptr Object00; propertyName: cstring; timestamp: uint64): ptr gobject.Value {.
    importc, libprag.}

proc getValueObject*(self: Object; propertyName: cstring; timestamp: uint64): ptr gobject.Value =
  gst_object_get_value(cast[ptr Object00](self.impl), propertyName, timestamp)

proc gst_object_has_active_control_bindings(self: ptr Object00): gboolean {.
    importc, libprag.}

proc hasActiveControlBindings*(self: Object): bool =
  toBool(gst_object_has_active_control_bindings(cast[ptr Object00](self.impl)))

proc gst_object_has_ancestor(self: ptr Object00; ancestor: ptr Object00): gboolean {.
    importc, libprag.}

proc hasAncestor*(self: Object; ancestor: Object): bool =
  toBool(gst_object_has_ancestor(cast[ptr Object00](self.impl), cast[ptr Object00](ancestor.impl)))

proc gst_object_has_as_ancestor(self: ptr Object00; ancestor: ptr Object00): gboolean {.
    importc, libprag.}

proc hasAsAncestor*(self: Object; ancestor: Object): bool =
  toBool(gst_object_has_as_ancestor(cast[ptr Object00](self.impl), cast[ptr Object00](ancestor.impl)))

proc gst_object_has_as_parent(self: ptr Object00; parent: ptr Object00): gboolean {.
    importc, libprag.}

proc hasAsParent*(self: Object; parent: Object): bool =
  toBool(gst_object_has_as_parent(cast[ptr Object00](self.impl), cast[ptr Object00](parent.impl)))

proc gst_object_ref(self: ptr Object00): ptr Object00 {.
    importc, libprag.}

proc `ref`*(self: Object): Object =
  let gobj = gst_object_ref(cast[ptr Object00](self.impl))
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

proc gst_object_set_control_binding_disabled(self: ptr Object00; propertyName: cstring;
    disabled: gboolean) {.
    importc, libprag.}

proc setControlBindingDisabled*(self: Object; propertyName: cstring;
    disabled: bool) =
  gst_object_set_control_binding_disabled(cast[ptr Object00](self.impl), propertyName, gboolean(disabled))

proc gst_object_set_control_bindings_disabled(self: ptr Object00; disabled: gboolean) {.
    importc, libprag.}

proc setControlBindingsDisabled*(self: Object; disabled: bool = true) =
  gst_object_set_control_bindings_disabled(cast[ptr Object00](self.impl), gboolean(disabled))

proc `controlBindingsDisabled=`*(self: Object; disabled: bool) =
  gst_object_set_control_bindings_disabled(cast[ptr Object00](self.impl), gboolean(disabled))

proc gst_object_set_control_rate(self: ptr Object00; controlRate: uint64) {.
    importc, libprag.}

proc setControlRate*(self: Object; controlRate: uint64) =
  gst_object_set_control_rate(cast[ptr Object00](self.impl), controlRate)

proc `controlRate=`*(self: Object; controlRate: uint64) =
  gst_object_set_control_rate(cast[ptr Object00](self.impl), controlRate)

proc gst_object_set_name(self: ptr Object00; name: cstring): gboolean {.
    importc, libprag.}

proc setName*(self: Object; name: cstring = nil): bool =
  toBool(gst_object_set_name(cast[ptr Object00](self.impl), name))

proc gst_object_set_parent(self: ptr Object00; parent: ptr Object00): gboolean {.
    importc, libprag.}

proc setParent*(self: Object; parent: Object): bool =
  toBool(gst_object_set_parent(cast[ptr Object00](self.impl), cast[ptr Object00](parent.impl)))

proc gst_object_suggest_next_sync(self: ptr Object00): uint64 {.
    importc, libprag.}

proc suggestNextSync*(self: Object): uint64 =
  gst_object_suggest_next_sync(cast[ptr Object00](self.impl))

proc gst_object_sync_values(self: ptr Object00; timestamp: uint64): gboolean {.
    importc, libprag.}

proc syncValues*(self: Object; timestamp: uint64): bool =
  toBool(gst_object_sync_values(cast[ptr Object00](self.impl), timestamp))

proc gst_object_unparent(self: ptr Object00) {.
    importc, libprag.}

proc unparent*(self: Object) =
  gst_object_unparent(cast[ptr Object00](self.impl))

proc gst_object_unref(self: ptr Object00) {.
    importc, libprag.}

proc unref*(self: Object) =
  gst_object_unref(cast[ptr Object00](self.impl))

type
  Allocator* = ref object of Object
  Allocator00* = object of Object00

proc gst_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Allocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_allocator_find(name: cstring): ptr Allocator00 {.
    importc, libprag.}

proc findAllocator*(name: cstring = nil): Allocator =
  let gobj = gst_allocator_find(name)
  if gobj.isNil:
    return nil
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

proc gst_allocator_register(name: cstring; allocator: ptr Allocator00) {.
    importc, libprag.}

proc registerAllocator*(name: cstring; allocator: Allocator) =
  gst_allocator_register(name, cast[ptr Allocator00](g_object_ref(allocator.impl)))

proc gst_allocator_set_default(self: ptr Allocator00) {.
    importc, libprag.}

proc setDefault*(self: Allocator) =
  gst_allocator_set_default(cast[ptr Allocator00](g_object_ref(self.impl)))

type
  ControlBinding* = ref object of Object
  ControlBinding00* = object of Object00

proc gst_control_binding_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ControlBinding()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_control_binding_get_g_value_array(self: ptr ControlBinding00; timestamp: uint64;
    interval: uint64; nValues: uint32; values: ptr gobject.Value): gboolean {.
    importc, libprag.}

proc getGValueArray*(self: ControlBinding; timestamp: uint64;
    interval: uint64; nValues: int; values: ptr gobject.Value): bool =
  toBool(gst_control_binding_get_g_value_array(cast[ptr ControlBinding00](self.impl), timestamp, interval, uint32(nValues), values))

proc gst_control_binding_get_value(self: ptr ControlBinding00; timestamp: uint64): ptr gobject.Value {.
    importc, libprag.}

proc getValueControlBinding*(self: ControlBinding; timestamp: uint64): ptr gobject.Value =
  gst_control_binding_get_value(cast[ptr ControlBinding00](self.impl), timestamp)

proc gst_control_binding_is_disabled(self: ptr ControlBinding00): gboolean {.
    importc, libprag.}

proc isDisabled*(self: ControlBinding): bool =
  toBool(gst_control_binding_is_disabled(cast[ptr ControlBinding00](self.impl)))

proc gst_control_binding_set_disabled(self: ptr ControlBinding00; disabled: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: ControlBinding; disabled: bool = true) =
  gst_control_binding_set_disabled(cast[ptr ControlBinding00](self.impl), gboolean(disabled))

proc `disabled=`*(self: ControlBinding; disabled: bool) =
  gst_control_binding_set_disabled(cast[ptr ControlBinding00](self.impl), gboolean(disabled))

proc gst_control_binding_sync_values(self: ptr ControlBinding00; `object`: ptr Object00;
    timestamp: uint64; lastSync: uint64): gboolean {.
    importc, libprag.}

proc syncValues*(self: ControlBinding; `object`: Object;
    timestamp: uint64; lastSync: uint64): bool =
  toBool(gst_control_binding_sync_values(cast[ptr ControlBinding00](self.impl), cast[ptr Object00](`object`.impl), timestamp, lastSync))

proc gst_object_add_control_binding(self: ptr Object00; binding: ptr ControlBinding00): gboolean {.
    importc, libprag.}

proc addControlBinding*(self: Object; binding: ControlBinding): bool =
  toBool(gst_object_add_control_binding(cast[ptr Object00](self.impl), cast[ptr ControlBinding00](binding.impl)))

proc gst_object_get_control_binding(self: ptr Object00; propertyName: cstring): ptr ControlBinding00 {.
    importc, libprag.}

proc getControlBinding*(self: Object; propertyName: cstring): ControlBinding =
  let gobj = gst_object_get_control_binding(cast[ptr Object00](self.impl), propertyName)
  if gobj.isNil:
    return nil
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

proc gst_object_remove_control_binding(self: ptr Object00; binding: ptr ControlBinding00): gboolean {.
    importc, libprag.}

proc removeControlBinding*(self: Object; binding: ControlBinding): bool =
  toBool(gst_object_remove_control_binding(cast[ptr Object00](self.impl), cast[ptr ControlBinding00](binding.impl)))

type
  Memory00* {.pure.} = object
  Memory* = ref object
    impl*: ptr Memory00
    ignoreFinalizer*: bool

proc gst_memory_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMemory*(self: Memory) =
  if not self.ignoreFinalizer:
    boxedFree(gst_memory_get_type(), cast[ptr Memory00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Memory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_memory_get_type(), cast[ptr Memory00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Memory) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMemory)

proc gst_memory_copy(self: ptr Memory00; offset: int64; size: int64): ptr Memory00 {.
    importc, libprag.}

proc copy*(self: Memory; offset: int64; size: int64): Memory =
  fnew(result, gBoxedFreeGstMemory)
  result.impl = gst_memory_copy(cast[ptr Memory00](self.impl), offset, size)

proc gst_memory_get_sizes(self: ptr Memory00; offset: var uint64; maxsize: var uint64): uint64 {.
    importc, libprag.}

proc getSizes*(self: Memory; offset: var uint64 = cast[var uint64](nil);
    maxsize: var uint64 = cast[var uint64](nil)): uint64 =
  gst_memory_get_sizes(cast[ptr Memory00](self.impl), offset, maxsize)

proc gst_memory_is_span(self: ptr Memory00; mem2: ptr Memory00; offset: var uint64): gboolean {.
    importc, libprag.}

proc isSpan*(self: Memory; mem2: Memory; offset: var uint64): bool =
  toBool(gst_memory_is_span(cast[ptr Memory00](self.impl), cast[ptr Memory00](mem2.impl), offset))

proc gst_memory_is_type(self: ptr Memory00; memType: cstring): gboolean {.
    importc, libprag.}

proc isType*(self: Memory; memType: cstring): bool =
  toBool(gst_memory_is_type(cast[ptr Memory00](self.impl), memType))

proc gst_memory_resize(self: ptr Memory00; offset: int64; size: uint64) {.
    importc, libprag.}

proc resize*(self: Memory; offset: int64; size: uint64) =
  gst_memory_resize(cast[ptr Memory00](self.impl), offset, size)

proc gst_memory_share(self: ptr Memory00; offset: int64; size: int64): ptr Memory00 {.
    importc, libprag.}

proc share*(self: Memory; offset: int64; size: int64): Memory =
  fnew(result, gBoxedFreeGstMemory)
  result.impl = gst_memory_share(cast[ptr Memory00](self.impl), offset, size)

proc gst_allocator_alloc(self: ptr Allocator00; size: uint64; params: ptr AllocationParams00): ptr Memory00 {.
    importc, libprag.}

proc alloc*(self: Allocator; size: uint64; params: AllocationParams = nil): Memory =
  let impl0 = gst_allocator_alloc(cast[ptr Allocator00](self.impl), size, if params.isNil: nil else: cast[ptr AllocationParams00](params.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc gst_allocator_free(self: ptr Allocator00; memory: ptr Memory00) {.
    importc, libprag.}

proc free*(self: Allocator; memory: Memory) =
  gst_allocator_free(cast[ptr Allocator00](self.impl), cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), memory.impl)))

type
  MemoryFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    readonly = 1
    noShare = 4
    zeroPrefixed = 5
    zeroPadded = 6
    physicallyContiguous = 7
    notMappable = 8
    last = 20

  MemoryFlags* {.size: sizeof(cint).} = set[MemoryFlag]

proc gst_memory_new_wrapped(flags: MemoryFlags; data: ptr uint8; maxsize: uint64;
    offset: uint64; size: uint64; userData: pointer; notify: DestroyNotify): ptr Memory00 {.
    importc, libprag.}

proc newMemoryWrapped*(flags: MemoryFlags; data: seq[uint8] | string;
    maxsize: uint64; offset: uint64; userData: pointer; notify: DestroyNotify): Memory =
  let size = uint64(data.len)
  let impl0 = gst_memory_new_wrapped(flags, cast[ptr uint8](unsafeaddr(data[0])), maxsize, offset, size, userData, notify)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc newMemoryWrapped*(tdesc: typedesc; flags: MemoryFlags; data: seq[uint8] | string;
    maxsize: uint64; offset: uint64; userData: pointer; notify: DestroyNotify): tdesc =
  let size = uint64(data.len)
  assert(result is Memory)
  let impl0 = gst_memory_new_wrapped(flags, cast[ptr uint8](unsafeaddr(data[0])), maxsize, offset, size, userData, notify)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc initMemoryWrapped*[T](result: var T; flags: MemoryFlags; data: seq[uint8] | string;
    maxsize: uint64; offset: uint64; userData: pointer; notify: DestroyNotify) {.deprecated.} =
  let size = uint64(data.len)
  assert(result is Memory)
  let impl0 = gst_memory_new_wrapped(flags, cast[ptr uint8](unsafeaddr(data[0])), maxsize, offset, size, userData, notify)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

type
  MapFlag* {.size: sizeof(cint), pure.} = enum
    read = 0
    write = 1
    flagLast = 16

  MapFlags* {.size: sizeof(cint).} = set[MapFlag]

type
  MapInfo* {.pure, byRef.} = object
    memory*: ptr Memory00
    flags*: MapFlags
    data*: ptr uint8
    size*: uint64
    maxsize*: uint64
    userData*: array[4, pointer]
    gstReserved*: array[4, pointer]

proc gst_memory_make_mapped(self: ptr Memory00; info: var MapInfo; flags: MapFlags): ptr Memory00 {.
    importc, libprag.}

proc makeMapped*(self: Memory; info: var MapInfo; flags: MapFlags): Memory =
  let impl0 = gst_memory_make_mapped(cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), self.impl)), info, flags)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc gst_memory_map(self: ptr Memory00; info: var MapInfo; flags: MapFlags): gboolean {.
    importc, libprag.}

proc map*(self: Memory; info: var MapInfo; flags: MapFlags): bool =
  toBool(gst_memory_map(cast[ptr Memory00](self.impl), info, flags))

proc gst_memory_unmap(self: ptr Memory00; info: MapInfo) {.
    importc, libprag.}

proc unmap*(self: Memory; info: MapInfo) =
  gst_memory_unmap(cast[ptr Memory00](self.impl), info)

type
  AllocatorFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    customAlloc = 4
    last = 20

  AllocatorFlags* {.size: sizeof(cint).} = set[AllocatorFlag]

type
  AtomicQueue00* {.pure.} = object
  AtomicQueue* = ref object
    impl*: ptr AtomicQueue00
    ignoreFinalizer*: bool

proc gst_atomic_queue_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstAtomicQueue*(self: AtomicQueue) =
  if not self.ignoreFinalizer:
    boxedFree(gst_atomic_queue_get_type(), cast[ptr AtomicQueue00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AtomicQueue()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_atomic_queue_get_type(), cast[ptr AtomicQueue00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AtomicQueue) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstAtomicQueue)

proc gst_atomic_queue_unref(self: ptr AtomicQueue00) {.
    importc, libprag.}

proc unref*(self: AtomicQueue) =
  gst_atomic_queue_unref(cast[ptr AtomicQueue00](self.impl))

proc finalizerunref*(self: AtomicQueue) =
  if not self.ignoreFinalizer:
    gst_atomic_queue_unref(cast[ptr AtomicQueue00](self.impl))

proc gst_atomic_queue_length(self: ptr AtomicQueue00): uint32 {.
    importc, libprag.}

proc length*(self: AtomicQueue): int =
  int(gst_atomic_queue_length(cast[ptr AtomicQueue00](self.impl)))

proc gst_atomic_queue_peek(self: ptr AtomicQueue00): pointer {.
    importc, libprag.}

proc peek*(self: AtomicQueue): pointer =
  gst_atomic_queue_peek(cast[ptr AtomicQueue00](self.impl))

proc gst_atomic_queue_pop(self: ptr AtomicQueue00): pointer {.
    importc, libprag.}

proc pop*(self: AtomicQueue): pointer =
  gst_atomic_queue_pop(cast[ptr AtomicQueue00](self.impl))

proc gst_atomic_queue_push(self: ptr AtomicQueue00; data: pointer) {.
    importc, libprag.}

proc push*(self: AtomicQueue; data: pointer) =
  gst_atomic_queue_push(cast[ptr AtomicQueue00](self.impl), data)

proc gst_atomic_queue_ref(self: ptr AtomicQueue00) {.
    importc, libprag.}

proc `ref`*(self: AtomicQueue) =
  gst_atomic_queue_ref(cast[ptr AtomicQueue00](self.impl))

proc gst_atomic_queue_new(initialSize: uint32): ptr AtomicQueue00 {.
    importc, libprag.}

proc newAtomicQueue*(initialSize: int): AtomicQueue =
  fnew(result, gBoxedFreeGstAtomicQueue)
  result.impl = gst_atomic_queue_new(uint32(initialSize))

proc newAtomicQueue*(tdesc: typedesc; initialSize: int): tdesc =
  assert(result is AtomicQueue)
  fnew(result, gBoxedFreeGstAtomicQueue)
  result.impl = gst_atomic_queue_new(uint32(initialSize))

proc initAtomicQueue*[T](result: var T; initialSize: int) {.deprecated.} =
  assert(result is AtomicQueue)
  fnew(result, gBoxedFreeGstAtomicQueue)
  result.impl = gst_atomic_queue_new(uint32(initialSize))

const BUFFER_COPY_ALL* = "INTERFCE (unsuported)"

const BUFFER_COPY_METADATA* = "INTERFCE (unsuported)"

const BUFFER_OFFSET_NONE* = 18446744073709551615'u64

type
  Pad* = ref object of Object
  Pad00* = object of Object00

proc gst_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Pad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scLinked*(self: Pad;  p: proc (self: ptr Pad00; peer: ptr Pad00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "linked", cast[GCallback](p), xdata, nil, cf)

proc scUnlinked*(self: Pad;  p: proc (self: ptr Pad00; peer: ptr Pad00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "unlinked", cast[GCallback](p), xdata, nil, cf)

proc gst_pad_can_link(self: ptr Pad00; sinkpad: ptr Pad00): gboolean {.
    importc, libprag.}

proc canLink*(self: Pad; sinkpad: Pad): bool =
  toBool(gst_pad_can_link(cast[ptr Pad00](self.impl), cast[ptr Pad00](sinkpad.impl)))

proc gst_pad_check_reconfigure(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc checkReconfigure*(self: Pad): bool =
  toBool(gst_pad_check_reconfigure(cast[ptr Pad00](self.impl)))

proc gst_pad_get_element_private(self: ptr Pad00): pointer {.
    importc, libprag.}

proc getElementPrivate*(self: Pad): pointer =
  gst_pad_get_element_private(cast[ptr Pad00](self.impl))

proc gst_pad_get_offset(self: ptr Pad00): int64 {.
    importc, libprag.}

proc getOffset*(self: Pad): int64 =
  gst_pad_get_offset(cast[ptr Pad00](self.impl))

proc offset*(self: Pad): int64 =
  gst_pad_get_offset(cast[ptr Pad00](self.impl))

proc gst_pad_get_peer(self: ptr Pad00): ptr Pad00 {.
    importc, libprag.}

proc getPeer*(self: Pad): Pad =
  let gobj = gst_pad_get_peer(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc peer*(self: Pad): Pad =
  let gobj = gst_pad_get_peer(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_pad_get_single_internal_link(self: ptr Pad00): ptr Pad00 {.
    importc, libprag.}

proc getSingleInternalLink*(self: Pad): Pad =
  let gobj = gst_pad_get_single_internal_link(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc singleInternalLink*(self: Pad): Pad =
  let gobj = gst_pad_get_single_internal_link(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_pad_get_stream_id(self: ptr Pad00): cstring {.
    importc, libprag.}

proc getStreamId*(self: Pad): string =
  let resul0 = gst_pad_get_stream_id(cast[ptr Pad00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc streamId*(self: Pad): string =
  let resul0 = gst_pad_get_stream_id(cast[ptr Pad00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_pad_has_current_caps(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc hasCurrentCaps*(self: Pad): bool =
  toBool(gst_pad_has_current_caps(cast[ptr Pad00](self.impl)))

proc gst_pad_is_active(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc isActive*(self: Pad): bool =
  toBool(gst_pad_is_active(cast[ptr Pad00](self.impl)))

proc gst_pad_is_blocked(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc isBlocked*(self: Pad): bool =
  toBool(gst_pad_is_blocked(cast[ptr Pad00](self.impl)))

proc gst_pad_is_blocking(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc isBlocking*(self: Pad): bool =
  toBool(gst_pad_is_blocking(cast[ptr Pad00](self.impl)))

proc gst_pad_is_linked(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc isLinked*(self: Pad): bool =
  toBool(gst_pad_is_linked(cast[ptr Pad00](self.impl)))

proc gst_pad_link_maybe_ghosting(self: ptr Pad00; sink: ptr Pad00): gboolean {.
    importc, libprag.}

proc linkMaybeGhosting*(self: Pad; sink: Pad): bool =
  toBool(gst_pad_link_maybe_ghosting(cast[ptr Pad00](self.impl), cast[ptr Pad00](sink.impl)))

proc gst_pad_mark_reconfigure(self: ptr Pad00) {.
    importc, libprag.}

proc markReconfigure*(self: Pad) =
  gst_pad_mark_reconfigure(cast[ptr Pad00](self.impl))

proc gst_pad_needs_reconfigure(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc needsReconfigure*(self: Pad): bool =
  toBool(gst_pad_needs_reconfigure(cast[ptr Pad00](self.impl)))

proc gst_pad_pause_task(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc pauseTask*(self: Pad): bool =
  toBool(gst_pad_pause_task(cast[ptr Pad00](self.impl)))

proc gst_pad_remove_probe(self: ptr Pad00; id: uint64) {.
    importc, libprag.}

proc removeProbe*(self: Pad; id: uint64) =
  gst_pad_remove_probe(cast[ptr Pad00](self.impl), id)

proc gst_pad_set_active(self: ptr Pad00; active: gboolean): gboolean {.
    importc, libprag.}

proc setActive*(self: Pad; active: bool = true): bool =
  toBool(gst_pad_set_active(cast[ptr Pad00](self.impl), gboolean(active)))

proc gst_pad_set_element_private(self: ptr Pad00; priv: pointer) {.
    importc, libprag.}

proc setElementPrivate*(self: Pad; priv: pointer) =
  gst_pad_set_element_private(cast[ptr Pad00](self.impl), priv)

proc `elementPrivate=`*(self: Pad; priv: pointer) =
  gst_pad_set_element_private(cast[ptr Pad00](self.impl), priv)

proc gst_pad_set_offset(self: ptr Pad00; offset: int64) {.
    importc, libprag.}

proc setOffset*(self: Pad; offset: int64) =
  gst_pad_set_offset(cast[ptr Pad00](self.impl), offset)

proc `offset=`*(self: Pad; offset: int64) =
  gst_pad_set_offset(cast[ptr Pad00](self.impl), offset)

proc gst_pad_stop_task(self: ptr Pad00): gboolean {.
    importc, libprag.}

proc stopTask*(self: Pad): bool =
  toBool(gst_pad_stop_task(cast[ptr Pad00](self.impl)))

proc gst_pad_unlink(self: ptr Pad00; sinkpad: ptr Pad00): gboolean {.
    importc, libprag.}

proc unlink*(self: Pad; sinkpad: Pad): bool =
  toBool(gst_pad_unlink(cast[ptr Pad00](self.impl), cast[ptr Pad00](sinkpad.impl)))

proc gst_pad_use_fixed_caps(self: ptr Pad00) {.
    importc, libprag.}

proc useFixedCaps*(self: Pad) =
  gst_pad_use_fixed_caps(cast[ptr Pad00](self.impl))

type
  Element* = ref object of Object
  Element00* = object of Object00

proc gst_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Element()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scNoMorePads*(self: Element;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "no-more-pads", cast[GCallback](p), xdata, nil, cf)

proc scPadAdded*(self: Element;  p: proc (self: ptr Element00; newPad: ptr Pad00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pad-added", cast[GCallback](p), xdata, nil, cf)

proc scPadRemoved*(self: Element;  p: proc (self: ptr Element00; oldPad: ptr Pad00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pad-removed", cast[GCallback](p), xdata, nil, cf)

proc gst_element_abort_state(self: ptr Element00) {.
    importc, libprag.}

proc abortState*(self: Element) =
  gst_element_abort_state(cast[ptr Element00](self.impl))

proc gst_element_add_pad(self: ptr Element00; pad: ptr Pad00): gboolean {.
    importc, libprag.}

proc addPad*(self: Element; pad: Pad): bool =
  toBool(gst_element_add_pad(cast[ptr Element00](self.impl), cast[ptr Pad00](pad.impl)))

proc gst_element_add_property_deep_notify_watch(self: ptr Element00; propertyName: cstring;
    includeValue: gboolean): uint64 {.
    importc, libprag.}

proc addPropertyDeepNotifyWatch*(self: Element; propertyName: cstring = nil;
    includeValue: bool): uint64 =
  gst_element_add_property_deep_notify_watch(cast[ptr Element00](self.impl), propertyName, gboolean(includeValue))

proc gst_element_add_property_notify_watch(self: ptr Element00; propertyName: cstring;
    includeValue: gboolean): uint64 {.
    importc, libprag.}

proc addPropertyNotifyWatch*(self: Element; propertyName: cstring = nil;
    includeValue: bool): uint64 =
  gst_element_add_property_notify_watch(cast[ptr Element00](self.impl), propertyName, gboolean(includeValue))

proc gst_element_create_all_pads(self: ptr Element00) {.
    importc, libprag.}

proc createAllPads*(self: Element) =
  gst_element_create_all_pads(cast[ptr Element00](self.impl))

proc gst_element_get_base_time(self: ptr Element00): uint64 {.
    importc, libprag.}

proc getBaseTime*(self: Element): uint64 =
  gst_element_get_base_time(cast[ptr Element00](self.impl))

proc baseTime*(self: Element): uint64 =
  gst_element_get_base_time(cast[ptr Element00](self.impl))

proc gst_element_get_current_clock_time(self: ptr Element00): uint64 {.
    importc, libprag.}

proc getCurrentClockTime*(self: Element): uint64 =
  gst_element_get_current_clock_time(cast[ptr Element00](self.impl))

proc currentClockTime*(self: Element): uint64 =
  gst_element_get_current_clock_time(cast[ptr Element00](self.impl))

proc gst_element_get_current_running_time(self: ptr Element00): uint64 {.
    importc, libprag.}

proc getCurrentRunningTime*(self: Element): uint64 =
  gst_element_get_current_running_time(cast[ptr Element00](self.impl))

proc currentRunningTime*(self: Element): uint64 =
  gst_element_get_current_running_time(cast[ptr Element00](self.impl))

proc gst_element_get_metadata(self: ptr Element00; key: cstring): cstring {.
    importc, libprag.}

proc getMetadata*(self: Element; key: cstring): string =
  result = $gst_element_get_metadata(cast[ptr Element00](self.impl), key)

proc gst_element_get_request_pad(self: ptr Element00; name: cstring): ptr Pad00 {.
    importc, libprag.}

proc getRequestPad*(self: Element; name: cstring): Pad =
  let gobj = gst_element_get_request_pad(cast[ptr Element00](self.impl), name)
  if gobj.isNil:
    return nil
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

proc gst_element_get_start_time(self: ptr Element00): uint64 {.
    importc, libprag.}

proc getStartTime*(self: Element): uint64 =
  gst_element_get_start_time(cast[ptr Element00](self.impl))

proc startTime*(self: Element): uint64 =
  gst_element_get_start_time(cast[ptr Element00](self.impl))

proc gst_element_get_static_pad(self: ptr Element00; name: cstring): ptr Pad00 {.
    importc, libprag.}

proc getStaticPad*(self: Element; name: cstring): Pad =
  let gobj = gst_element_get_static_pad(cast[ptr Element00](self.impl), name)
  if gobj.isNil:
    return nil
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

proc gst_element_is_locked_state(self: ptr Element00): gboolean {.
    importc, libprag.}

proc isLockedState*(self: Element): bool =
  toBool(gst_element_is_locked_state(cast[ptr Element00](self.impl)))

proc gst_element_link(self: ptr Element00; dest: ptr Element00): gboolean {.
    importc, libprag.}

proc link*(self: Element; dest: Element): bool =
  toBool(gst_element_link(cast[ptr Element00](self.impl), cast[ptr Element00](dest.impl)))

proc gst_element_link_pads(self: ptr Element00; srcpadname: cstring; dest: ptr Element00;
    destpadname: cstring): gboolean {.
    importc, libprag.}

proc linkPads*(self: Element; srcpadname: cstring = nil; dest: Element;
    destpadname: cstring = nil): bool =
  toBool(gst_element_link_pads(cast[ptr Element00](self.impl), srcpadname, cast[ptr Element00](dest.impl), destpadname))

proc gst_element_lost_state(self: ptr Element00) {.
    importc, libprag.}

proc lostState*(self: Element) =
  gst_element_lost_state(cast[ptr Element00](self.impl))

proc gst_element_no_more_pads(self: ptr Element00) {.
    importc, libprag.}

proc noMorePads*(self: Element) =
  gst_element_no_more_pads(cast[ptr Element00](self.impl))

proc gst_element_release_request_pad(self: ptr Element00; pad: ptr Pad00) {.
    importc, libprag.}

proc releaseRequestPad*(self: Element; pad: Pad) =
  gst_element_release_request_pad(cast[ptr Element00](self.impl), cast[ptr Pad00](pad.impl))

proc gst_element_remove_pad(self: ptr Element00; pad: ptr Pad00): gboolean {.
    importc, libprag.}

proc removePad*(self: Element; pad: Pad): bool =
  toBool(gst_element_remove_pad(cast[ptr Element00](self.impl), cast[ptr Pad00](pad.impl)))

proc gst_element_remove_property_notify_watch(self: ptr Element00; watchId: uint64) {.
    importc, libprag.}

proc removePropertyNotifyWatch*(self: Element; watchId: uint64) =
  gst_element_remove_property_notify_watch(cast[ptr Element00](self.impl), watchId)

proc gst_element_set_base_time(self: ptr Element00; time: uint64) {.
    importc, libprag.}

proc setBaseTime*(self: Element; time: uint64) =
  gst_element_set_base_time(cast[ptr Element00](self.impl), time)

proc `baseTime=`*(self: Element; time: uint64) =
  gst_element_set_base_time(cast[ptr Element00](self.impl), time)

proc gst_element_set_locked_state(self: ptr Element00; lockedState: gboolean): gboolean {.
    importc, libprag.}

proc setLockedState*(self: Element; lockedState: bool = true): bool =
  toBool(gst_element_set_locked_state(cast[ptr Element00](self.impl), gboolean(lockedState)))

proc gst_element_set_start_time(self: ptr Element00; time: uint64) {.
    importc, libprag.}

proc setStartTime*(self: Element; time: uint64) =
  gst_element_set_start_time(cast[ptr Element00](self.impl), time)

proc `startTime=`*(self: Element; time: uint64) =
  gst_element_set_start_time(cast[ptr Element00](self.impl), time)

proc gst_element_sync_state_with_parent(self: ptr Element00): gboolean {.
    importc, libprag.}

proc syncStateWithParent*(self: Element): bool =
  toBool(gst_element_sync_state_with_parent(cast[ptr Element00](self.impl)))

proc gst_element_unlink(self: ptr Element00; dest: ptr Element00) {.
    importc, libprag.}

proc unlink*(self: Element; dest: Element) =
  gst_element_unlink(cast[ptr Element00](self.impl), cast[ptr Element00](dest.impl))

proc gst_element_unlink_pads(self: ptr Element00; srcpadname: cstring; dest: ptr Element00;
    destpadname: cstring) {.
    importc, libprag.}

proc unlinkPads*(self: Element; srcpadname: cstring; dest: Element;
    destpadname: cstring) =
  gst_element_unlink_pads(cast[ptr Element00](self.impl), srcpadname, cast[ptr Element00](dest.impl), destpadname)

type
  Bin* = ref object of Element
  Bin00* = object of Element00

proc gst_bin_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Bin()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDeepElementAdded*(self: Bin;  p: proc (self: ptr Bin00; subBin: ptr Bin00; element: ptr Element00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "deep-element-added", cast[GCallback](p), xdata, nil, cf)

proc scDeepElementRemoved*(self: Bin;  p: proc (self: ptr Bin00; subBin: ptr Bin00; element: ptr Element00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "deep-element-removed", cast[GCallback](p), xdata, nil, cf)

proc scDoLatency*(self: Bin;  p: proc (self: ptr Bin00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "do-latency", cast[GCallback](p), xdata, nil, cf)

proc scElementAdded*(self: Bin;  p: proc (self: ptr Bin00; element: ptr Element00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "element-added", cast[GCallback](p), xdata, nil, cf)

proc scElementRemoved*(self: Bin;  p: proc (self: ptr Bin00; element: ptr Element00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "element-removed", cast[GCallback](p), xdata, nil, cf)

proc gst_bin_new(name: cstring): ptr Bin00 {.
    importc, libprag.}

proc newBin*(name: cstring = nil): Bin =
  let gobj = gst_bin_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBin*(tdesc: typedesc; name: cstring = nil): tdesc =
  assert(result is Bin)
  let gobj = gst_bin_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBin*[T](result: var T; name: cstring = nil) {.deprecated.} =
  assert(result is Bin)
  let gobj = gst_bin_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_bin_add(self: ptr Bin00; element: ptr Element00): gboolean {.
    importc, libprag.}

proc add*(self: Bin; element: Element): bool =
  toBool(gst_bin_add(cast[ptr Bin00](self.impl), cast[ptr Element00](element.impl)))

proc gst_bin_get_by_interface(self: ptr Bin00; iface: GType): ptr Element00 {.
    importc, libprag.}

proc getByInterface*(self: Bin; iface: GType): Element =
  let gobj = gst_bin_get_by_interface(cast[ptr Bin00](self.impl), iface)
  if gobj.isNil:
    return nil
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

proc gst_bin_get_by_name(self: ptr Bin00; name: cstring): ptr Element00 {.
    importc, libprag.}

proc getByName*(self: Bin; name: cstring): Element =
  let gobj = gst_bin_get_by_name(cast[ptr Bin00](self.impl), name)
  if gobj.isNil:
    return nil
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

proc gst_bin_get_by_name_recurse_up(self: ptr Bin00; name: cstring): ptr Element00 {.
    importc, libprag.}

proc getByNameRecurseUp*(self: Bin; name: cstring): Element =
  let gobj = gst_bin_get_by_name_recurse_up(cast[ptr Bin00](self.impl), name)
  if gobj.isNil:
    return nil
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

proc gst_bin_recalculate_latency(self: ptr Bin00): gboolean {.
    importc, libprag.}

proc recalculateLatency*(self: Bin): bool =
  toBool(gst_bin_recalculate_latency(cast[ptr Bin00](self.impl)))

proc gst_bin_remove(self: ptr Bin00; element: ptr Element00): gboolean {.
    importc, libprag.}

proc remove*(self: Bin; element: Element): bool =
  toBool(gst_bin_remove(cast[ptr Bin00](self.impl), cast[ptr Element00](element.impl)))

proc gst_bin_sync_children_states(self: ptr Bin00): gboolean {.
    importc, libprag.}

proc syncChildrenStates*(self: Bin): bool =
  toBool(gst_bin_sync_children_states(cast[ptr Bin00](self.impl)))

proc gst_pad_create_stream_id(self: ptr Pad00; parent: ptr Element00; streamId: cstring): cstring {.
    importc, libprag.}

proc createStreamId*(self: Pad; parent: Element; streamId: cstring = nil): string =
  let resul0 = gst_pad_create_stream_id(cast[ptr Pad00](self.impl), cast[ptr Element00](parent.impl), streamId)
  result = $resul0
  cogfree(resul0)

proc gst_pad_get_parent_element(self: ptr Pad00): ptr Element00 {.
    importc, libprag.}

proc getParentElement*(self: Pad): Element =
  let gobj = gst_pad_get_parent_element(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc parentElement*(self: Pad): Element =
  let gobj = gst_pad_get_parent_element(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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
  StaticPadTemplate00* {.pure.} = object
  StaticPadTemplate* = ref object
    impl*: ptr StaticPadTemplate00
    ignoreFinalizer*: bool

proc gst_pad_new_from_static_template(templ: ptr StaticPadTemplate00; name: cstring): ptr Pad00 {.
    importc, libprag.}

proc newPadFromStaticTemplate*(templ: StaticPadTemplate; name: cstring): Pad =
  let gobj = gst_pad_new_from_static_template(cast[ptr StaticPadTemplate00](templ.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPadFromStaticTemplate*(tdesc: typedesc; templ: StaticPadTemplate; name: cstring): tdesc =
  assert(result is Pad)
  let gobj = gst_pad_new_from_static_template(cast[ptr StaticPadTemplate00](templ.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPadFromStaticTemplate*[T](result: var T; templ: StaticPadTemplate; name: cstring) {.deprecated.} =
  assert(result is Pad)
  let gobj = gst_pad_new_from_static_template(cast[ptr StaticPadTemplate00](templ.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PadMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    push = 1
    pull = 2

proc gst_pad_mode_get_name(mode: PadMode): cstring {.
    importc, libprag.}

proc getName*(mode: PadMode): string =
  result = $gst_pad_mode_get_name(mode)

proc name*(mode: PadMode): string =
  result = $gst_pad_mode_get_name(mode)

proc gst_pad_activate_mode(self: ptr Pad00; mode: PadMode; active: gboolean): gboolean {.
    importc, libprag.}

proc activateMode*(self: Pad; mode: PadMode; active: bool): bool =
  toBool(gst_pad_activate_mode(cast[ptr Pad00](self.impl), mode, gboolean(active)))

type
  PadProbeType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    idle = 1
    `block` = 2
    blocking = 3
    buffer = 16
    bufferList = 32
    eventDownstream = 64
    dataDownstream = 112
    blockDownstream = 114
    dataUpstream = 128
    blockUpstream = 130
    eventBoth = 192
    dataBoth = 240
    eventFlush = 256
    queryDownstream = 512
    queryUpstream = 1024
    queryBoth = 1536
    allBoth = 1776
    push = 4096
    pull = 8192
    scheduling = 12288

const
  PadProbeTypeEventUpstream* = PadProbeType.dataUpstream

type
  FlowReturn* {.size: sizeof(cint), pure.} = enum
    customError_2 = -102
    customError_1 = -101
    customError = -100
    notSupported = -6
    error = -5
    notNegotiated = -4
    eos = -3
    flushing = -2
    notLinked = -1
    ok = 0
    customSuccess = 100
    customSuccess_1 = 101
    customSuccess_2 = 102

proc gst_pad_get_last_flow_return(self: ptr Pad00): FlowReturn {.
    importc, libprag.}

proc getLastFlowReturn*(self: Pad): FlowReturn =
  gst_pad_get_last_flow_return(cast[ptr Pad00](self.impl))

proc lastFlowReturn*(self: Pad): FlowReturn =
  gst_pad_get_last_flow_return(cast[ptr Pad00](self.impl))

type
  EventType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    flushStart = 2563
    flushStop = 5127
    streamStart = 10254
    caps = 12814
    segment = 17934
    streamCollection = 19230
    tag = 20510
    buffersize = 23054
    sinkMessage = 25630
    streamGroupDone = 26894
    eos = 28174
    toc = 30750
    protection = 33310
    segmentDone = 38406
    gap = 40966
    instantRateChange = 46090
    qos = 48641
    seek = 51201
    navigation = 53761
    latency = 56321
    step = 58881
    reconfigure = 61441
    tocSelect = 64001
    selectStreams = 66561
    instantRateSyncTime = 66817
    customUpstream = 69121
    customDownstream = 71686
    customDownstreamOob = 74242
    customDownstreamSticky = 76830
    customBoth = 79367
    customBothOob = 81923

proc gst_event_type_get_name(`type`: EventType): cstring {.
    importc, libprag.}

proc getName*(`type`: EventType): string =
  result = $gst_event_type_get_name(`type`)

proc name*(`type`: EventType): string =
  result = $gst_event_type_get_name(`type`)

proc gst_event_type_to_quark(`type`: EventType): uint32 {.
    importc, libprag.}

proc toQuark*(`type`: EventType): int =
  int(gst_event_type_to_quark(`type`))

type
  EventTypeFlag* {.size: sizeof(cint), pure.} = enum
    upstream = 0
    downstream = 1
    serialized = 2
    sticky = 3
    stickyMulti = 4

  EventTypeFlags* {.size: sizeof(cint).} = set[EventTypeFlag]

proc getFlags*(`type`: EventType): EventTypeFlags {.
    importc: "gst_event_type_get_flags", libprag.}

proc flags*(`type`: EventType): EventTypeFlags {.
    importc: "gst_event_type_get_flags", libprag.}

type
  Stream* = ref object of Object
  Stream00* = object of Object00

proc gst_stream_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Stream()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_stream_get_stream_id(self: ptr Stream00): cstring {.
    importc, libprag.}

proc getStreamId*(self: Stream): string =
  let resul0 = gst_stream_get_stream_id(cast[ptr Stream00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc streamId*(self: Stream): string =
  let resul0 = gst_stream_get_stream_id(cast[ptr Stream00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_pad_get_stream(self: ptr Pad00): ptr Stream00 {.
    importc, libprag.}

proc getStream*(self: Pad): Stream =
  let gobj = gst_pad_get_stream(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc stream*(self: Pad): Stream =
  let gobj = gst_pad_get_stream(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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
  StreamFlag* {.size: sizeof(cint), pure.} = enum
    sparse = 0
    select = 1
    unselect = 2

  StreamFlags* {.size: sizeof(cint).} = set[StreamFlag]

const
  StreamFlagsNone* = StreamFlags({})
proc none*(t: typedesc[StreamFlags]): StreamFlags = StreamFlags({})

proc gst_stream_get_stream_flags(self: ptr Stream00): StreamFlags {.
    importc, libprag.}

proc getStreamFlags*(self: Stream): StreamFlags =
  gst_stream_get_stream_flags(cast[ptr Stream00](self.impl))

proc streamFlags*(self: Stream): StreamFlags =
  gst_stream_get_stream_flags(cast[ptr Stream00](self.impl))

proc gst_stream_set_stream_flags(self: ptr Stream00; flags: StreamFlags) {.
    importc, libprag.}

proc setStreamFlags*(self: Stream; flags: StreamFlags) =
  gst_stream_set_stream_flags(cast[ptr Stream00](self.impl), flags)

proc `streamFlags=`*(self: Stream; flags: StreamFlags) =
  gst_stream_set_stream_flags(cast[ptr Stream00](self.impl), flags)

type
  StreamType* {.size: sizeof(cint), pure.} = enum
    unknown = 1
    audio = 2
    video = 4
    container = 8
    text = 16

proc gst_stream_type_get_name(stype: StreamType): cstring {.
    importc, libprag.}

proc getName*(stype: StreamType): string =
  result = $gst_stream_type_get_name(stype)

proc name*(stype: StreamType): string =
  result = $gst_stream_type_get_name(stype)

proc gst_stream_get_stream_type(self: ptr Stream00): StreamType {.
    importc, libprag.}

proc getStreamType*(self: Stream): StreamType =
  gst_stream_get_stream_type(cast[ptr Stream00](self.impl))

proc streamType*(self: Stream): StreamType =
  gst_stream_get_stream_type(cast[ptr Stream00](self.impl))

proc gst_stream_set_stream_type(self: ptr Stream00; streamType: StreamType) {.
    importc, libprag.}

proc setStreamType*(self: Stream; streamType: StreamType) =
  gst_stream_set_stream_type(cast[ptr Stream00](self.impl), streamType)

proc `streamType=`*(self: Stream; streamType: StreamType) =
  gst_stream_set_stream_type(cast[ptr Stream00](self.impl), streamType)

type
  TagList00* {.pure.} = object
  TagList* = ref object
    impl*: ptr TagList00
    ignoreFinalizer*: bool

proc gst_tag_list_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstTagList*(self: TagList) =
  if not self.ignoreFinalizer:
    boxedFree(gst_tag_list_get_type(), cast[ptr TagList00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TagList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_tag_list_get_type(), cast[ptr TagList00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TagList) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstTagList)

proc gst_tag_list_new_empty(): ptr TagList00 {.
    importc, libprag.}

proc newTagListEmpty*(): TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_new_empty()

proc newTagListEmpty*(tdesc: typedesc): tdesc =
  assert(result is TagList)
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_new_empty()

proc initTagListEmpty*[T](result: var T) {.deprecated.} =
  assert(result is TagList)
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_new_empty()

proc gst_tag_list_new_from_string(str: cstring): ptr TagList00 {.
    importc, libprag.}

proc newTagListFromString*(str: cstring): TagList =
  let impl0 = gst_tag_list_new_from_string(str)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = impl0

proc newTagListFromString*(tdesc: typedesc; str: cstring): tdesc =
  assert(result is TagList)
  let impl0 = gst_tag_list_new_from_string(str)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = impl0

proc initTagListFromString*[T](result: var T; str: cstring) {.deprecated.} =
  assert(result is TagList)
  let impl0 = gst_tag_list_new_from_string(str)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = impl0

proc gst_tag_list_copy(self: ptr TagList00): ptr TagList00 {.
    importc, libprag.}

proc copy*(self: TagList): TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_copy(cast[ptr TagList00](self.impl))

proc gst_tag_list_get_boolean(self: ptr TagList00; tag: cstring; value: var gboolean): gboolean {.
    importc, libprag.}

proc getBoolean*(self: TagList; tag: cstring; value: var bool): bool =
  var value_00: gboolean
  result = toBool(gst_tag_list_get_boolean(cast[ptr TagList00](self.impl), tag, value_00))
  if value.addr != nil:
    value = toBool(value_00)

proc gst_tag_list_get_boolean_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var gboolean): gboolean {.
    importc, libprag.}

proc getBooleanIndex*(self: TagList; tag: cstring; index: int;
    value: var bool): bool =
  var value_00: gboolean
  result = toBool(gst_tag_list_get_boolean_index(cast[ptr TagList00](self.impl), tag, uint32(index), value_00))
  if value.addr != nil:
    value = toBool(value_00)

proc gst_tag_list_get_date(self: ptr TagList00; tag: cstring; value: var ptr glib.Date00): gboolean {.
    importc, libprag.}

proc getDate*(self: TagList; tag: cstring; value: var glib.Date): bool =
  fnew(value, gBoxedFreeGDate)
  toBool(gst_tag_list_get_date(cast[ptr TagList00](self.impl), tag, cast[var ptr glib.Date00](addr value.impl)))

proc gst_tag_list_get_date_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var ptr glib.Date00): gboolean {.
    importc, libprag.}

proc getDateIndex*(self: TagList; tag: cstring; index: int;
    value: var glib.Date): bool =
  fnew(value, gBoxedFreeGDate)
  toBool(gst_tag_list_get_date_index(cast[ptr TagList00](self.impl), tag, uint32(index), cast[var ptr glib.Date00](addr value.impl)))

proc gst_tag_list_get_double(self: ptr TagList00; tag: cstring; value: var cdouble): gboolean {.
    importc, libprag.}

proc getDouble*(self: TagList; tag: cstring; value: var cdouble): bool =
  toBool(gst_tag_list_get_double(cast[ptr TagList00](self.impl), tag, value))

proc gst_tag_list_get_double_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var cdouble): gboolean {.
    importc, libprag.}

proc getDoubleIndex*(self: TagList; tag: cstring; index: int;
    value: var cdouble): bool =
  toBool(gst_tag_list_get_double_index(cast[ptr TagList00](self.impl), tag, uint32(index), value))

proc gst_tag_list_get_float(self: ptr TagList00; tag: cstring; value: var cfloat): gboolean {.
    importc, libprag.}

proc getFloat*(self: TagList; tag: cstring; value: var cfloat): bool =
  toBool(gst_tag_list_get_float(cast[ptr TagList00](self.impl), tag, value))

proc gst_tag_list_get_float_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var cfloat): gboolean {.
    importc, libprag.}

proc getFloatIndex*(self: TagList; tag: cstring; index: int;
    value: var cfloat): bool =
  toBool(gst_tag_list_get_float_index(cast[ptr TagList00](self.impl), tag, uint32(index), value))

proc gst_tag_list_get_int(self: ptr TagList00; tag: cstring; value: var int32): gboolean {.
    importc, libprag.}

proc getInt*(self: TagList; tag: cstring; value: var int): bool =
  var value_00: int32
  result = toBool(gst_tag_list_get_int(cast[ptr TagList00](self.impl), tag, value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_tag_list_get_int64(self: ptr TagList00; tag: cstring; value: var int64): gboolean {.
    importc, libprag.}

proc getInt64*(self: TagList; tag: cstring; value: var int64): bool =
  toBool(gst_tag_list_get_int64(cast[ptr TagList00](self.impl), tag, value))

proc gst_tag_list_get_int64_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var int64): gboolean {.
    importc, libprag.}

proc getInt64Index*(self: TagList; tag: cstring; index: int;
    value: var int64): bool =
  toBool(gst_tag_list_get_int64_index(cast[ptr TagList00](self.impl), tag, uint32(index), value))

proc gst_tag_list_get_int_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var int32): gboolean {.
    importc, libprag.}

proc getIntIndex*(self: TagList; tag: cstring; index: int;
    value: var int): bool =
  var value_00: int32
  result = toBool(gst_tag_list_get_int_index(cast[ptr TagList00](self.impl), tag, uint32(index), value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_tag_list_get_pointer(self: ptr TagList00; tag: cstring; value: var pointer): gboolean {.
    importc, libprag.}

proc getPointer*(self: TagList; tag: cstring; value: var pointer): bool =
  toBool(gst_tag_list_get_pointer(cast[ptr TagList00](self.impl), tag, value))

proc gst_tag_list_get_pointer_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var pointer): gboolean {.
    importc, libprag.}

proc getPointerIndex*(self: TagList; tag: cstring; index: int;
    value: var pointer): bool =
  toBool(gst_tag_list_get_pointer_index(cast[ptr TagList00](self.impl), tag, uint32(index), value))

proc gst_tag_list_get_string(self: ptr TagList00; tag: cstring; value: var cstring): gboolean {.
    importc, libprag.}

proc getString*(self: TagList; tag: cstring; value: var string): bool =
  var value_00: cstring
  result = toBool(gst_tag_list_get_string(cast[ptr TagList00](self.impl), tag, value_00))
  if value.addr != nil:
    value = $(value_00)

proc gst_tag_list_get_string_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var cstring): gboolean {.
    importc, libprag.}

proc getStringIndex*(self: TagList; tag: cstring; index: int;
    value: var string): bool =
  var value_00: cstring
  result = toBool(gst_tag_list_get_string_index(cast[ptr TagList00](self.impl), tag, uint32(index), value_00))
  if value.addr != nil:
    value = $(value_00)

proc gst_tag_list_get_tag_size(self: ptr TagList00; tag: cstring): uint32 {.
    importc, libprag.}

proc getTagSize*(self: TagList; tag: cstring): int =
  int(gst_tag_list_get_tag_size(cast[ptr TagList00](self.impl), tag))

proc gst_tag_list_get_uint(self: ptr TagList00; tag: cstring; value: var uint32): gboolean {.
    importc, libprag.}

proc getUint*(self: TagList; tag: cstring; value: var int): bool =
  var value_00: uint32
  result = toBool(gst_tag_list_get_uint(cast[ptr TagList00](self.impl), tag, value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_tag_list_get_uint64(self: ptr TagList00; tag: cstring; value: var uint64): gboolean {.
    importc, libprag.}

proc getUint64*(self: TagList; tag: cstring; value: var uint64): bool =
  toBool(gst_tag_list_get_uint64(cast[ptr TagList00](self.impl), tag, value))

proc gst_tag_list_get_uint64_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var uint64): gboolean {.
    importc, libprag.}

proc getUint64Index*(self: TagList; tag: cstring; index: int;
    value: var uint64): bool =
  toBool(gst_tag_list_get_uint64_index(cast[ptr TagList00](self.impl), tag, uint32(index), value))

proc gst_tag_list_get_uint_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var uint32): gboolean {.
    importc, libprag.}

proc getUintIndex*(self: TagList; tag: cstring; index: int;
    value: var int): bool =
  var value_00: uint32
  result = toBool(gst_tag_list_get_uint_index(cast[ptr TagList00](self.impl), tag, uint32(index), value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_tag_list_get_value_index(self: ptr TagList00; tag: cstring; index: uint32): ptr gobject.Value {.
    importc, libprag.}

proc getValueIndex*(self: TagList; tag: cstring; index: int): ptr gobject.Value =
  gst_tag_list_get_value_index(cast[ptr TagList00](self.impl), tag, uint32(index))

proc gst_tag_list_is_empty(self: ptr TagList00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: TagList): bool =
  toBool(gst_tag_list_is_empty(cast[ptr TagList00](self.impl)))

proc gst_tag_list_is_equal(self: ptr TagList00; list2: ptr TagList00): gboolean {.
    importc, libprag.}

proc isEqual*(self: TagList; list2: TagList): bool =
  toBool(gst_tag_list_is_equal(cast[ptr TagList00](self.impl), cast[ptr TagList00](list2.impl)))

proc gst_tag_list_n_tags(self: ptr TagList00): int32 {.
    importc, libprag.}

proc nTags*(self: TagList): int =
  int(gst_tag_list_n_tags(cast[ptr TagList00](self.impl)))

proc gst_tag_list_nth_tag_name(self: ptr TagList00; index: uint32): cstring {.
    importc, libprag.}

proc nthTagName*(self: TagList; index: int): string =
  result = $gst_tag_list_nth_tag_name(cast[ptr TagList00](self.impl), uint32(index))

proc gst_tag_list_peek_string_index(self: ptr TagList00; tag: cstring; index: uint32;
    value: var cstring): gboolean {.
    importc, libprag.}

proc peekStringIndex*(self: TagList; tag: cstring; index: int;
    value: var string): bool =
  var value_00: cstring
  result = toBool(gst_tag_list_peek_string_index(cast[ptr TagList00](self.impl), tag, uint32(index), value_00))
  if value.addr != nil:
    value = $(value_00)

proc gst_tag_list_remove_tag(self: ptr TagList00; tag: cstring) {.
    importc, libprag.}

proc removeTag*(self: TagList; tag: cstring) =
  gst_tag_list_remove_tag(cast[ptr TagList00](self.impl), tag)

proc gst_tag_list_to_string(self: ptr TagList00): cstring {.
    importc, libprag.}

proc toString*(self: TagList): string =
  let resul0 = gst_tag_list_to_string(cast[ptr TagList00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_tag_list_copy_value(dest: var gobject.Value; list: ptr TagList00;
    tag: cstring): gboolean {.
    importc, libprag.}

proc copyValue*(dest: var gobject.Value; list: TagList; tag: cstring): bool =
  toBool(gst_tag_list_copy_value(dest, cast[ptr TagList00](list.impl), tag))

proc gst_stream_get_tags(self: ptr Stream00): ptr TagList00 {.
    importc, libprag.}

proc getTags*(self: Stream): TagList =
  let impl0 = gst_stream_get_tags(cast[ptr Stream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = impl0

proc tags*(self: Stream): TagList =
  let impl0 = gst_stream_get_tags(cast[ptr Stream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = impl0

proc gst_stream_set_tags(self: ptr Stream00; tags: ptr TagList00) {.
    importc, libprag.}

proc setTags*(self: Stream; tags: TagList = nil) =
  gst_stream_set_tags(cast[ptr Stream00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](tags.impl))

proc `tags=`*(self: Stream; tags: TagList = nil) =
  gst_stream_set_tags(cast[ptr Stream00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](tags.impl))

type
  DateTime00* {.pure.} = object
  DateTime* = ref object
    impl*: ptr DateTime00
    ignoreFinalizer*: bool

proc gst_date_time_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstDateTime*(self: DateTime) =
  if not self.ignoreFinalizer:
    boxedFree(gst_date_time_get_type(), cast[ptr DateTime00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DateTime()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_date_time_get_type(), cast[ptr DateTime00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var DateTime) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstDateTime)

proc gst_date_time_unref(self: ptr DateTime00) {.
    importc, libprag.}

proc unref*(self: DateTime) =
  gst_date_time_unref(cast[ptr DateTime00](g_boxed_copy(gst_date_time_get_type(), self.impl)))

proc finalizerunref*(self: DateTime) =
  if not self.ignoreFinalizer:
    gst_date_time_unref(cast[ptr DateTime00](self.impl))

proc gst_date_time_new_from_g_date_time(dt: ptr glib.DateTime00): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromGDateTime*(dt: glib.DateTime): DateTime =
  let impl0 = gst_date_time_new_from_g_date_time(cast[ptr glib.DateTime00](g_boxed_copy(g_date_time_get_type(), dt.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeFromGDateTime*(tdesc: typedesc; dt: glib.DateTime): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_g_date_time(cast[ptr glib.DateTime00](g_boxed_copy(g_date_time_get_type(), dt.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeFromGDateTime*[T](result: var T; dt: glib.DateTime) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_g_date_time(cast[ptr glib.DateTime00](g_boxed_copy(g_date_time_get_type(), dt.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_from_iso8601_string(string: cstring): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromIso8601String*(string: cstring): DateTime =
  let impl0 = gst_date_time_new_from_iso8601_string(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeFromIso8601String*(tdesc: typedesc; string: cstring): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_iso8601_string(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeFromIso8601String*[T](result: var T; string: cstring) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_iso8601_string(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_from_unix_epoch_local_time(secs: int64): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromUnixEpochLocalTime*(secs: int64): DateTime =
  let impl0 = gst_date_time_new_from_unix_epoch_local_time(secs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeFromUnixEpochLocalTime*(tdesc: typedesc; secs: int64): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_local_time(secs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeFromUnixEpochLocalTime*[T](result: var T; secs: int64) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_local_time(secs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_from_unix_epoch_local_time_usecs(usecs: int64): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromUnixEpochLocalTimeUsecs*(usecs: int64): DateTime =
  let impl0 = gst_date_time_new_from_unix_epoch_local_time_usecs(usecs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeFromUnixEpochLocalTimeUsecs*(tdesc: typedesc; usecs: int64): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_local_time_usecs(usecs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeFromUnixEpochLocalTimeUsecs*[T](result: var T; usecs: int64) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_local_time_usecs(usecs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_from_unix_epoch_utc(secs: int64): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromUnixEpochUtc*(secs: int64): DateTime =
  let impl0 = gst_date_time_new_from_unix_epoch_utc(secs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeFromUnixEpochUtc*(tdesc: typedesc; secs: int64): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_utc(secs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeFromUnixEpochUtc*[T](result: var T; secs: int64) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_utc(secs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_from_unix_epoch_utc_usecs(usecs: int64): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeFromUnixEpochUtcUsecs*(usecs: int64): DateTime =
  let impl0 = gst_date_time_new_from_unix_epoch_utc_usecs(usecs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeFromUnixEpochUtcUsecs*(tdesc: typedesc; usecs: int64): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_utc_usecs(usecs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeFromUnixEpochUtcUsecs*[T](result: var T; usecs: int64) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_from_unix_epoch_utc_usecs(usecs)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_local_time(year: int32; month: int32; day: int32;
    hour: int32; minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeLocalTime*(year: int; month: int; day: int; hour: int;
    minute: int; seconds: cdouble): DateTime =
  let impl0 = gst_date_time_new_local_time(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeLocalTime*(tdesc: typedesc; year: int; month: int; day: int; hour: int;
    minute: int; seconds: cdouble): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_local_time(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeLocalTime*[T](result: var T; year: int; month: int; day: int; hour: int;
    minute: int; seconds: cdouble) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_local_time(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_now_local_time(): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeNowLocalTime*(): DateTime =
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_date_time_new_now_local_time()

proc newDateTimeNowLocalTime*(tdesc: typedesc): tdesc =
  assert(result is DateTime)
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_date_time_new_now_local_time()

proc initDateTimeNowLocalTime*[T](result: var T) {.deprecated.} =
  assert(result is DateTime)
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_date_time_new_now_local_time()

proc gst_date_time_new_now_utc(): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeNowUtc*(): DateTime =
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_date_time_new_now_utc()

proc newDateTimeNowUtc*(tdesc: typedesc): tdesc =
  assert(result is DateTime)
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_date_time_new_now_utc()

proc initDateTimeNowUtc*[T](result: var T) {.deprecated.} =
  assert(result is DateTime)
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_date_time_new_now_utc()

proc gst_date_time_new_y(year: int32): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeY*(year: int): DateTime =
  let impl0 = gst_date_time_new_y(int32(year))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeY*(tdesc: typedesc; year: int): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_y(int32(year))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeY*[T](result: var T; year: int) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_y(int32(year))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_ym(year: int32; month: int32): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeYm*(year: int; month: int): DateTime =
  let impl0 = gst_date_time_new_ym(int32(year), int32(month))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeYm*(tdesc: typedesc; year: int; month: int): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_ym(int32(year), int32(month))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeYm*[T](result: var T; year: int; month: int) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_ym(int32(year), int32(month))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_new_ymd(year: int32; month: int32; day: int32): ptr DateTime00 {.
    importc, libprag.}

proc newDateTimeYmd*(year: int; month: int; day: int): DateTime =
  let impl0 = gst_date_time_new_ymd(int32(year), int32(month), int32(day))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTimeYmd*(tdesc: typedesc; year: int; month: int; day: int): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_ymd(int32(year), int32(month), int32(day))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTimeYmd*[T](result: var T; year: int; month: int; day: int) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new_ymd(int32(year), int32(month), int32(day))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_date_time_get_day(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getDay*(self: DateTime): int =
  int(gst_date_time_get_day(cast[ptr DateTime00](self.impl)))

proc day*(self: DateTime): int =
  int(gst_date_time_get_day(cast[ptr DateTime00](self.impl)))

proc gst_date_time_get_hour(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getHour*(self: DateTime): int =
  int(gst_date_time_get_hour(cast[ptr DateTime00](self.impl)))

proc hour*(self: DateTime): int =
  int(gst_date_time_get_hour(cast[ptr DateTime00](self.impl)))

proc gst_date_time_get_microsecond(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getMicrosecond*(self: DateTime): int =
  int(gst_date_time_get_microsecond(cast[ptr DateTime00](self.impl)))

proc microsecond*(self: DateTime): int =
  int(gst_date_time_get_microsecond(cast[ptr DateTime00](self.impl)))

proc gst_date_time_get_minute(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getMinute*(self: DateTime): int =
  int(gst_date_time_get_minute(cast[ptr DateTime00](self.impl)))

proc minute*(self: DateTime): int =
  int(gst_date_time_get_minute(cast[ptr DateTime00](self.impl)))

proc gst_date_time_get_month(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getMonth*(self: DateTime): int =
  int(gst_date_time_get_month(cast[ptr DateTime00](self.impl)))

proc month*(self: DateTime): int =
  int(gst_date_time_get_month(cast[ptr DateTime00](self.impl)))

proc gst_date_time_get_second(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getSecond*(self: DateTime): int =
  int(gst_date_time_get_second(cast[ptr DateTime00](self.impl)))

proc second*(self: DateTime): int =
  int(gst_date_time_get_second(cast[ptr DateTime00](self.impl)))

proc gst_date_time_get_time_zone_offset(self: ptr DateTime00): cfloat {.
    importc, libprag.}

proc getTimeZoneOffset*(self: DateTime): cfloat =
  gst_date_time_get_time_zone_offset(cast[ptr DateTime00](self.impl))

proc timeZoneOffset*(self: DateTime): cfloat =
  gst_date_time_get_time_zone_offset(cast[ptr DateTime00](self.impl))

proc gst_date_time_get_year(self: ptr DateTime00): int32 {.
    importc, libprag.}

proc getYear*(self: DateTime): int =
  int(gst_date_time_get_year(cast[ptr DateTime00](self.impl)))

proc year*(self: DateTime): int =
  int(gst_date_time_get_year(cast[ptr DateTime00](self.impl)))

proc gst_date_time_has_day(self: ptr DateTime00): gboolean {.
    importc, libprag.}

proc hasDay*(self: DateTime): bool =
  toBool(gst_date_time_has_day(cast[ptr DateTime00](self.impl)))

proc gst_date_time_has_month(self: ptr DateTime00): gboolean {.
    importc, libprag.}

proc hasMonth*(self: DateTime): bool =
  toBool(gst_date_time_has_month(cast[ptr DateTime00](self.impl)))

proc gst_date_time_has_second(self: ptr DateTime00): gboolean {.
    importc, libprag.}

proc hasSecond*(self: DateTime): bool =
  toBool(gst_date_time_has_second(cast[ptr DateTime00](self.impl)))

proc gst_date_time_has_time(self: ptr DateTime00): gboolean {.
    importc, libprag.}

proc hasTime*(self: DateTime): bool =
  toBool(gst_date_time_has_time(cast[ptr DateTime00](self.impl)))

proc gst_date_time_has_year(self: ptr DateTime00): gboolean {.
    importc, libprag.}

proc hasYear*(self: DateTime): bool =
  toBool(gst_date_time_has_year(cast[ptr DateTime00](self.impl)))

proc gst_date_time_ref(self: ptr DateTime00): ptr DateTime00 {.
    importc, libprag.}

proc `ref`*(self: DateTime): DateTime =
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = gst_date_time_ref(cast[ptr DateTime00](self.impl))

proc gst_date_time_to_g_date_time(self: ptr DateTime00): ptr glib.DateTime00 {.
    importc, libprag.}

proc toGDateTime*(self: DateTime): glib.DateTime =
  let impl0 = gst_date_time_to_g_date_time(cast[ptr DateTime00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc gst_date_time_to_iso8601_string(self: ptr DateTime00): cstring {.
    importc, libprag.}

proc toIso8601String*(self: DateTime): string =
  let resul0 = gst_date_time_to_iso8601_string(cast[ptr DateTime00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_date_time_new(tzoffset: cfloat; year: int32; month: int32; day: int32;
    hour: int32; minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc, libprag.}

proc newDateTime*(tzoffset: cfloat; year: int; month: int; day: int;
    hour: int; minute: int; seconds: cdouble): DateTime =
  let impl0 = gst_date_time_new(tzoffset, int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc newDateTime*(tdesc: typedesc; tzoffset: cfloat; year: int; month: int; day: int;
    hour: int; minute: int; seconds: cdouble): tdesc =
  assert(result is DateTime)
  let impl0 = gst_date_time_new(tzoffset, int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc initDateTime*[T](result: var T; tzoffset: cfloat; year: int; month: int; day: int;
    hour: int; minute: int; seconds: cdouble) {.deprecated.} =
  assert(result is DateTime)
  let impl0 = gst_date_time_new(tzoffset, int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstDateTime)
  result.impl = impl0

proc gst_tag_list_get_date_time(self: ptr TagList00; tag: cstring; value: var ptr DateTime00): gboolean {.
    importc, libprag.}

proc getDateTime*(self: TagList; tag: cstring; value: var DateTime): bool =
  fnew(value, gBoxedFreeGstDateTime)
  toBool(gst_tag_list_get_date_time(cast[ptr TagList00](self.impl), tag, cast[var ptr DateTime00](addr value.impl)))

proc gst_tag_list_get_date_time_index(self: ptr TagList00; tag: cstring;
    index: uint32; value: var ptr DateTime00): gboolean {.
    importc, libprag.}

proc getDateTimeIndex*(self: TagList; tag: cstring; index: int;
    value: var DateTime): bool =
  fnew(value, gBoxedFreeGstDateTime)
  toBool(gst_tag_list_get_date_time_index(cast[ptr TagList00](self.impl), tag, uint32(index), cast[var ptr DateTime00](addr value.impl)))

type
  Sample00* {.pure.} = object
  Sample* = ref object
    impl*: ptr Sample00
    ignoreFinalizer*: bool

proc gst_sample_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstSample*(self: Sample) =
  if not self.ignoreFinalizer:
    boxedFree(gst_sample_get_type(), cast[ptr Sample00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Sample()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_sample_get_type(), cast[ptr Sample00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Sample) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstSample)

proc gst_tag_list_get_sample(self: ptr TagList00; tag: cstring; sample: var ptr Sample00): gboolean {.
    importc, libprag.}

proc getSample*(self: TagList; tag: cstring; sample: var Sample): bool =
  fnew(sample, gBoxedFreeGstSample)
  toBool(gst_tag_list_get_sample(cast[ptr TagList00](self.impl), tag, cast[var ptr Sample00](addr sample.impl)))

proc gst_tag_list_get_sample_index(self: ptr TagList00; tag: cstring; index: uint32;
    sample: var ptr Sample00): gboolean {.
    importc, libprag.}

proc getSampleIndex*(self: TagList; tag: cstring; index: int;
    sample: var Sample): bool =
  fnew(sample, gBoxedFreeGstSample)
  toBool(gst_tag_list_get_sample_index(cast[ptr TagList00](self.impl), tag, uint32(index), cast[var ptr Sample00](addr sample.impl)))

type
  Structure00* {.pure.} = object
  Structure* = ref object
    impl*: ptr Structure00
    ignoreFinalizer*: bool

proc gst_structure_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstStructure*(self: Structure) =
  if not self.ignoreFinalizer:
    boxedFree(gst_structure_get_type(), cast[ptr Structure00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Structure()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_structure_get_type(), cast[ptr Structure00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Structure) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstStructure)

proc gst_structure_free(self: ptr Structure00) {.
    importc, libprag.}

proc free*(self: Structure) =
  gst_structure_free(cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), self.impl)))

proc finalizerfree*(self: Structure) =
  if not self.ignoreFinalizer:
    gst_structure_free(cast[ptr Structure00](self.impl))

proc gst_structure_new_empty(name: cstring): ptr Structure00 {.
    importc, libprag.}

proc newStructureEmpty*(name: cstring): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_structure_new_empty(name)

proc newStructureEmpty*(tdesc: typedesc; name: cstring): tdesc =
  assert(result is Structure)
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_structure_new_empty(name)

proc initStructureEmpty*[T](result: var T; name: cstring) {.deprecated.} =
  assert(result is Structure)
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_structure_new_empty(name)

proc gst_structure_new_from_string(string: cstring): ptr Structure00 {.
    importc, libprag.}

proc newStructureFromString*(string: cstring): Structure =
  let impl0 = gst_structure_new_from_string(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0

proc newStructureFromString*(tdesc: typedesc; string: cstring): tdesc =
  assert(result is Structure)
  let impl0 = gst_structure_new_from_string(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0

proc initStructureFromString*[T](result: var T; string: cstring) {.deprecated.} =
  assert(result is Structure)
  let impl0 = gst_structure_new_from_string(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0

proc gst_structure_new_id_empty(quark: uint32): ptr Structure00 {.
    importc, libprag.}

proc newStructureIdEmpty*(quark: int): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_structure_new_id_empty(uint32(quark))

proc newStructureIdEmpty*(tdesc: typedesc; quark: int): tdesc =
  assert(result is Structure)
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_structure_new_id_empty(uint32(quark))

proc initStructureIdEmpty*[T](result: var T; quark: int) {.deprecated.} =
  assert(result is Structure)
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_structure_new_id_empty(uint32(quark))

proc gst_structure_can_intersect(self: ptr Structure00; struct2: ptr Structure00): gboolean {.
    importc, libprag.}

proc canIntersect*(self: Structure; struct2: Structure): bool =
  toBool(gst_structure_can_intersect(cast[ptr Structure00](self.impl), cast[ptr Structure00](struct2.impl)))

proc gst_structure_copy(self: ptr Structure00): ptr Structure00 {.
    importc, libprag.}

proc copy*(self: Structure): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_structure_copy(cast[ptr Structure00](self.impl))

proc gst_structure_fixate(self: ptr Structure00) {.
    importc, libprag.}

proc fixate*(self: Structure) =
  gst_structure_fixate(cast[ptr Structure00](self.impl))

proc gst_structure_fixate_field(self: ptr Structure00; fieldName: cstring): gboolean {.
    importc, libprag.}

proc fixateField*(self: Structure; fieldName: cstring): bool =
  toBool(gst_structure_fixate_field(cast[ptr Structure00](self.impl), fieldName))

proc gst_structure_fixate_field_boolean(self: ptr Structure00; fieldName: cstring;
    target: gboolean): gboolean {.
    importc, libprag.}

proc fixateFieldBoolean*(self: Structure; fieldName: cstring;
    target: bool): bool =
  toBool(gst_structure_fixate_field_boolean(cast[ptr Structure00](self.impl), fieldName, gboolean(target)))

proc gst_structure_fixate_field_nearest_double(self: ptr Structure00; fieldName: cstring;
    target: cdouble): gboolean {.
    importc, libprag.}

proc fixateFieldNearestDouble*(self: Structure; fieldName: cstring;
    target: cdouble): bool =
  toBool(gst_structure_fixate_field_nearest_double(cast[ptr Structure00](self.impl), fieldName, target))

proc gst_structure_fixate_field_nearest_fraction(self: ptr Structure00; fieldName: cstring;
    targetNumerator: int32; targetDenominator: int32): gboolean {.
    importc, libprag.}

proc fixateFieldNearestFraction*(self: Structure; fieldName: cstring;
    targetNumerator: int; targetDenominator: int): bool =
  toBool(gst_structure_fixate_field_nearest_fraction(cast[ptr Structure00](self.impl), fieldName, int32(targetNumerator), int32(targetDenominator)))

proc gst_structure_fixate_field_nearest_int(self: ptr Structure00; fieldName: cstring;
    target: int32): gboolean {.
    importc, libprag.}

proc fixateFieldNearestInt*(self: Structure; fieldName: cstring;
    target: int): bool =
  toBool(gst_structure_fixate_field_nearest_int(cast[ptr Structure00](self.impl), fieldName, int32(target)))

proc gst_structure_fixate_field_string(self: ptr Structure00; fieldName: cstring;
    target: cstring): gboolean {.
    importc, libprag.}

proc fixateFieldString*(self: Structure; fieldName: cstring;
    target: cstring): bool =
  toBool(gst_structure_fixate_field_string(cast[ptr Structure00](self.impl), fieldName, target))

proc gst_structure_get_array(self: ptr Structure00; fieldname: cstring; array: var ptr gobject.ValueArray00): gboolean {.
    importc, libprag.}

proc getArray*(self: Structure; fieldname: cstring; array: var gobject.ValueArray): bool =
  fnew(array, gBoxedFreeGValueArray)
  toBool(gst_structure_get_array(cast[ptr Structure00](self.impl), fieldname, cast[var ptr gobject.ValueArray00](addr array.impl)))

proc gst_structure_get_boolean(self: ptr Structure00; fieldname: cstring;
    value: var gboolean): gboolean {.
    importc, libprag.}

proc getBoolean*(self: Structure; fieldname: cstring; value: var bool): bool =
  var value_00: gboolean
  result = toBool(gst_structure_get_boolean(cast[ptr Structure00](self.impl), fieldname, value_00))
  if value.addr != nil:
    value = toBool(value_00)

proc gst_structure_get_clock_time(self: ptr Structure00; fieldname: cstring;
    value: var uint64): gboolean {.
    importc, libprag.}

proc getClockTime*(self: Structure; fieldname: cstring; value: var uint64): bool =
  toBool(gst_structure_get_clock_time(cast[ptr Structure00](self.impl), fieldname, value))

proc gst_structure_get_date(self: ptr Structure00; fieldname: cstring; value: var ptr glib.Date00): gboolean {.
    importc, libprag.}

proc getDate*(self: Structure; fieldname: cstring; value: var glib.Date): bool =
  fnew(value, gBoxedFreeGDate)
  toBool(gst_structure_get_date(cast[ptr Structure00](self.impl), fieldname, cast[var ptr glib.Date00](addr value.impl)))

proc gst_structure_get_date_time(self: ptr Structure00; fieldname: cstring;
    value: var ptr DateTime00): gboolean {.
    importc, libprag.}

proc getDateTime*(self: Structure; fieldname: cstring; value: var DateTime): bool =
  fnew(value, gBoxedFreeGstDateTime)
  toBool(gst_structure_get_date_time(cast[ptr Structure00](self.impl), fieldname, cast[var ptr DateTime00](addr value.impl)))

proc gst_structure_get_double(self: ptr Structure00; fieldname: cstring;
    value: var cdouble): gboolean {.
    importc, libprag.}

proc getDouble*(self: Structure; fieldname: cstring; value: var cdouble): bool =
  toBool(gst_structure_get_double(cast[ptr Structure00](self.impl), fieldname, value))

proc gst_structure_get_enum(self: ptr Structure00; fieldname: cstring; enumtype: GType;
    value: var int32): gboolean {.
    importc, libprag.}

proc getEnum*(self: Structure; fieldname: cstring; enumtype: GType;
    value: var int): bool =
  var value_00: int32
  result = toBool(gst_structure_get_enum(cast[ptr Structure00](self.impl), fieldname, enumtype, value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_structure_get_field_type(self: ptr Structure00; fieldname: cstring): GType {.
    importc, libprag.}

proc getFieldType*(self: Structure; fieldname: cstring): GType =
  gst_structure_get_field_type(cast[ptr Structure00](self.impl), fieldname)

proc gst_structure_get_flagset(self: ptr Structure00; fieldname: cstring;
    valueFlags: var uint32; valueMask: var uint32): gboolean {.
    importc, libprag.}

proc getFlagset*(self: Structure; fieldname: cstring; valueFlags: var int = cast[var int](nil);
    valueMask: var int = cast[var int](nil)): bool =
  var valueMask_00: uint32
  var valueFlags_00: uint32
  result = toBool(gst_structure_get_flagset(cast[ptr Structure00](self.impl), fieldname, valueFlags_00, valueMask_00))
  if valueMask.addr != nil:
    valueMask = int(valueMask_00)
  if valueFlags.addr != nil:
    valueFlags = int(valueFlags_00)

proc gst_structure_get_fraction(self: ptr Structure00; fieldname: cstring;
    valueNumerator: var int32; valueDenominator: var int32): gboolean {.
    importc, libprag.}

proc getFraction*(self: Structure; fieldname: cstring; valueNumerator: var int;
    valueDenominator: var int): bool =
  var valueNumerator_00: int32
  var valueDenominator_00: int32
  result = toBool(gst_structure_get_fraction(cast[ptr Structure00](self.impl), fieldname, valueNumerator_00, valueDenominator_00))
  if valueNumerator.addr != nil:
    valueNumerator = int(valueNumerator_00)
  if valueDenominator.addr != nil:
    valueDenominator = int(valueDenominator_00)

proc gst_structure_get_int(self: ptr Structure00; fieldname: cstring; value: var int32): gboolean {.
    importc, libprag.}

proc getInt*(self: Structure; fieldname: cstring; value: var int): bool =
  var value_00: int32
  result = toBool(gst_structure_get_int(cast[ptr Structure00](self.impl), fieldname, value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_structure_get_int64(self: ptr Structure00; fieldname: cstring; value: var int64): gboolean {.
    importc, libprag.}

proc getInt64*(self: Structure; fieldname: cstring; value: var int64): bool =
  toBool(gst_structure_get_int64(cast[ptr Structure00](self.impl), fieldname, value))

proc gst_structure_get_list(self: ptr Structure00; fieldname: cstring; array: var ptr gobject.ValueArray00): gboolean {.
    importc, libprag.}

proc getListStructure*(self: Structure; fieldname: cstring; array: var gobject.ValueArray): bool =
  fnew(array, gBoxedFreeGValueArray)
  toBool(gst_structure_get_list(cast[ptr Structure00](self.impl), fieldname, cast[var ptr gobject.ValueArray00](addr array.impl)))

proc gst_structure_get_name(self: ptr Structure00): cstring {.
    importc, libprag.}

proc getName*(self: Structure): string =
  result = $gst_structure_get_name(cast[ptr Structure00](self.impl))

proc name*(self: Structure): string =
  result = $gst_structure_get_name(cast[ptr Structure00](self.impl))

proc gst_structure_get_name_id(self: ptr Structure00): uint32 {.
    importc, libprag.}

proc getNameId*(self: Structure): int =
  int(gst_structure_get_name_id(cast[ptr Structure00](self.impl)))

proc nameId*(self: Structure): int =
  int(gst_structure_get_name_id(cast[ptr Structure00](self.impl)))

proc gst_structure_get_string(self: ptr Structure00; fieldname: cstring): cstring {.
    importc, libprag.}

proc getString*(self: Structure; fieldname: cstring): string =
  let resul0 = gst_structure_get_string(cast[ptr Structure00](self.impl), fieldname)
  if resul0.isNil:
    return
  result = $resul0

proc gst_structure_get_uint(self: ptr Structure00; fieldname: cstring; value: var uint32): gboolean {.
    importc, libprag.}

proc getUint*(self: Structure; fieldname: cstring; value: var int): bool =
  var value_00: uint32
  result = toBool(gst_structure_get_uint(cast[ptr Structure00](self.impl), fieldname, value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_structure_get_uint64(self: ptr Structure00; fieldname: cstring;
    value: var uint64): gboolean {.
    importc, libprag.}

proc getUint64*(self: Structure; fieldname: cstring; value: var uint64): bool =
  toBool(gst_structure_get_uint64(cast[ptr Structure00](self.impl), fieldname, value))

proc gst_structure_get_value(self: ptr Structure00; fieldname: cstring): ptr gobject.Value {.
    importc, libprag.}

proc getValueStructure*(self: Structure; fieldname: cstring): ptr gobject.Value =
  gst_structure_get_value(cast[ptr Structure00](self.impl), fieldname)

proc gst_structure_has_field(self: ptr Structure00; fieldname: cstring): gboolean {.
    importc, libprag.}

proc hasField*(self: Structure; fieldname: cstring): bool =
  toBool(gst_structure_has_field(cast[ptr Structure00](self.impl), fieldname))

proc gst_structure_has_field_typed(self: ptr Structure00; fieldname: cstring;
    `type`: GType): gboolean {.
    importc, libprag.}

proc hasFieldTyped*(self: Structure; fieldname: cstring; `type`: GType): bool =
  toBool(gst_structure_has_field_typed(cast[ptr Structure00](self.impl), fieldname, `type`))

proc gst_structure_has_name(self: ptr Structure00; name: cstring): gboolean {.
    importc, libprag.}

proc hasName*(self: Structure; name: cstring): bool =
  toBool(gst_structure_has_name(cast[ptr Structure00](self.impl), name))

proc gst_structure_id_get_value(self: ptr Structure00; field: uint32): ptr gobject.Value {.
    importc, libprag.}

proc idGetValue*(self: Structure; field: int): ptr gobject.Value =
  gst_structure_id_get_value(cast[ptr Structure00](self.impl), uint32(field))

proc gst_structure_id_has_field(self: ptr Structure00; field: uint32): gboolean {.
    importc, libprag.}

proc idHasField*(self: Structure; field: int): bool =
  toBool(gst_structure_id_has_field(cast[ptr Structure00](self.impl), uint32(field)))

proc gst_structure_id_has_field_typed(self: ptr Structure00; field: uint32;
    `type`: GType): gboolean {.
    importc, libprag.}

proc idHasFieldTyped*(self: Structure; field: int; `type`: GType): bool =
  toBool(gst_structure_id_has_field_typed(cast[ptr Structure00](self.impl), uint32(field), `type`))

proc gst_structure_id_set_value(self: ptr Structure00; field: uint32; value: gobject.Value) {.
    importc, libprag.}

proc idSetValue*(self: Structure; field: int; value: gobject.Value) =
  gst_structure_id_set_value(cast[ptr Structure00](self.impl), uint32(field), value)

proc gst_structure_id_take_value(self: ptr Structure00; field: uint32; value: gobject.Value) {.
    importc, libprag.}

proc idTakeValue*(self: Structure; field: int; value: gobject.Value) =
  gst_structure_id_take_value(cast[ptr Structure00](self.impl), uint32(field), value)

proc gst_structure_intersect(self: ptr Structure00; struct2: ptr Structure00): ptr Structure00 {.
    importc, libprag.}

proc intersect*(self: Structure; struct2: Structure): Structure =
  let impl0 = gst_structure_intersect(cast[ptr Structure00](self.impl), cast[ptr Structure00](struct2.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0

proc gst_structure_is_equal(self: ptr Structure00; structure2: ptr Structure00): gboolean {.
    importc, libprag.}

proc isEqual*(self: Structure; structure2: Structure): bool =
  toBool(gst_structure_is_equal(cast[ptr Structure00](self.impl), cast[ptr Structure00](structure2.impl)))

proc gst_structure_is_subset(self: ptr Structure00; superset: ptr Structure00): gboolean {.
    importc, libprag.}

proc isSubset*(self: Structure; superset: Structure): bool =
  toBool(gst_structure_is_subset(cast[ptr Structure00](self.impl), cast[ptr Structure00](superset.impl)))

proc gst_structure_n_fields(self: ptr Structure00): int32 {.
    importc, libprag.}

proc nFields*(self: Structure): int =
  int(gst_structure_n_fields(cast[ptr Structure00](self.impl)))

proc gst_structure_nth_field_name(self: ptr Structure00; index: uint32): cstring {.
    importc, libprag.}

proc nthFieldName*(self: Structure; index: int): string =
  result = $gst_structure_nth_field_name(cast[ptr Structure00](self.impl), uint32(index))

proc gst_structure_remove_all_fields(self: ptr Structure00) {.
    importc, libprag.}

proc removeAllFields*(self: Structure) =
  gst_structure_remove_all_fields(cast[ptr Structure00](self.impl))

proc gst_structure_remove_field(self: ptr Structure00; fieldname: cstring) {.
    importc, libprag.}

proc removeField*(self: Structure; fieldname: cstring) =
  gst_structure_remove_field(cast[ptr Structure00](self.impl), fieldname)

proc gst_structure_set_array(self: ptr Structure00; fieldname: cstring; array: ptr gobject.ValueArray00) {.
    importc, libprag.}

proc setArray*(self: Structure; fieldname: cstring; array: gobject.ValueArray) =
  gst_structure_set_array(cast[ptr Structure00](self.impl), fieldname, cast[ptr gobject.ValueArray00](array.impl))

proc gst_structure_set_list(self: ptr Structure00; fieldname: cstring; array: ptr gobject.ValueArray00) {.
    importc, libprag.}

proc setList*(self: Structure; fieldname: cstring; array: gobject.ValueArray) =
  gst_structure_set_list(cast[ptr Structure00](self.impl), fieldname, cast[ptr gobject.ValueArray00](array.impl))

proc gst_structure_set_name(self: ptr Structure00; name: cstring) {.
    importc, libprag.}

proc setName*(self: Structure; name: cstring) =
  gst_structure_set_name(cast[ptr Structure00](self.impl), name)

proc `name=`*(self: Structure; name: cstring) =
  gst_structure_set_name(cast[ptr Structure00](self.impl), name)

proc gst_structure_set_parent_refcount(self: ptr Structure00; refcount: ptr int32): gboolean {.
    importc, libprag.}

proc setParentRefcount*(self: Structure; refcount: ptr int32): bool =
  toBool(gst_structure_set_parent_refcount(cast[ptr Structure00](self.impl), refcount))

proc gst_structure_set_value(self: ptr Structure00; fieldname: cstring; value: gobject.Value) {.
    importc, libprag.}

proc setValue*(self: Structure; fieldname: cstring; value: gobject.Value) =
  gst_structure_set_value(cast[ptr Structure00](self.impl), fieldname, value)

proc gst_structure_take_value(self: ptr Structure00; fieldname: cstring;
    value: gobject.Value) {.
    importc, libprag.}

proc takeValue*(self: Structure; fieldname: cstring; value: gobject.Value) =
  gst_structure_take_value(cast[ptr Structure00](self.impl), fieldname, value)

proc gst_structure_to_string(self: ptr Structure00): cstring {.
    importc, libprag.}

proc toString*(self: Structure): string =
  let resul0 = gst_structure_to_string(cast[ptr Structure00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_sample_get_info(self: ptr Sample00): ptr Structure00 {.
    importc, libprag.}

proc getInfoSample*(self: Sample): Structure =
  let impl0 = gst_sample_get_info(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc infoSample*(self: Sample): Structure =
  let impl0 = gst_sample_get_info(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc gst_sample_set_info(self: ptr Sample00; info: ptr Structure00): gboolean {.
    importc, libprag.}

proc setInfo*(self: Sample; info: Structure): bool =
  toBool(gst_sample_set_info(cast[ptr Sample00](self.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), info.impl))))

type
  Segment00* {.pure.} = object
  Segment* = ref object
    impl*: ptr Segment00
    ignoreFinalizer*: bool

proc gst_segment_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstSegment*(self: Segment) =
  if not self.ignoreFinalizer:
    boxedFree(gst_segment_get_type(), cast[ptr Segment00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Segment()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_segment_get_type(), cast[ptr Segment00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Segment) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstSegment)

proc gst_segment_free(self: ptr Segment00) {.
    importc, libprag.}

proc free*(self: Segment) =
  gst_segment_free(cast[ptr Segment00](g_boxed_copy(gst_segment_get_type(), self.impl)))

proc finalizerfree*(self: Segment) =
  if not self.ignoreFinalizer:
    gst_segment_free(cast[ptr Segment00](self.impl))

proc gst_segment_copy(self: ptr Segment00): ptr Segment00 {.
    importc, libprag.}

proc copy*(self: Segment): Segment =
  fnew(result, gBoxedFreeGstSegment)
  result.impl = gst_segment_copy(cast[ptr Segment00](self.impl))

proc gst_segment_copy_into(self: ptr Segment00; dest: ptr Segment00) {.
    importc, libprag.}

proc copyInto*(self: Segment; dest: Segment) =
  gst_segment_copy_into(cast[ptr Segment00](self.impl), cast[ptr Segment00](dest.impl))

proc gst_segment_new(): ptr Segment00 {.
    importc, libprag.}

proc newSegment*(): Segment =
  fnew(result, gBoxedFreeGstSegment)
  result.impl = gst_segment_new()

proc newSegment*(tdesc: typedesc): tdesc =
  assert(result is Segment)
  fnew(result, gBoxedFreeGstSegment)
  result.impl = gst_segment_new()

proc initSegment*[T](result: var T) {.deprecated.} =
  assert(result is Segment)
  fnew(result, gBoxedFreeGstSegment)
  result.impl = gst_segment_new()

proc gst_segment_is_equal(self: ptr Segment00; s1: ptr Segment00): gboolean {.
    importc, libprag.}

proc isEqual*(self: Segment; s1: Segment): bool =
  toBool(gst_segment_is_equal(cast[ptr Segment00](self.impl), cast[ptr Segment00](s1.impl)))

proc gst_sample_get_segment(self: ptr Sample00): ptr Segment00 {.
    importc, libprag.}

proc getSegment*(self: Sample): Segment =
  fnew(result, gBoxedFreeGstSegment)
  result.impl = gst_sample_get_segment(cast[ptr Sample00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_segment_get_type(), result.impl))

proc segment*(self: Sample): Segment =
  fnew(result, gBoxedFreeGstSegment)
  result.impl = gst_sample_get_segment(cast[ptr Sample00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_segment_get_type(), result.impl))

proc gst_sample_set_segment(self: ptr Sample00; segment: ptr Segment00) {.
    importc, libprag.}

proc setSegment*(self: Sample; segment: Segment) =
  gst_sample_set_segment(cast[ptr Sample00](self.impl), cast[ptr Segment00](segment.impl))

proc `segment=`*(self: Sample; segment: Segment) =
  gst_sample_set_segment(cast[ptr Sample00](self.impl), cast[ptr Segment00](segment.impl))

type
  TagMergeMode* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    replaceAll = 1
    replace = 2
    append = 3
    prepend = 4
    keep = 5
    keepAll = 6
    count = 7

proc gst_tag_list_add_value(self: ptr TagList00; mode: TagMergeMode; tag: cstring;
    value: gobject.Value) {.
    importc, libprag.}

proc addValue*(self: TagList; mode: TagMergeMode; tag: cstring;
    value: gobject.Value) =
  gst_tag_list_add_value(cast[ptr TagList00](self.impl), mode, tag, value)

proc gst_tag_list_insert(self: ptr TagList00; `from`: ptr TagList00; mode: TagMergeMode) {.
    importc, libprag.}

proc insert*(self: TagList; `from`: TagList; mode: TagMergeMode) =
  gst_tag_list_insert(cast[ptr TagList00](self.impl), cast[ptr TagList00](`from`.impl), mode)

proc gst_tag_list_merge(self: ptr TagList00; list2: ptr TagList00; mode: TagMergeMode): ptr TagList00 {.
    importc, libprag.}

proc merge*(self: TagList; list2: TagList = nil; mode: TagMergeMode): TagList =
  let impl0 = gst_tag_list_merge(cast[ptr TagList00](self.impl), if list2.isNil: nil else: cast[ptr TagList00](list2.impl), mode)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = impl0

type
  TagScope* {.size: sizeof(cint), pure.} = enum
    stream = 0
    global = 1

proc gst_tag_list_get_scope(self: ptr TagList00): TagScope {.
    importc, libprag.}

proc getScope*(self: TagList): TagScope =
  gst_tag_list_get_scope(cast[ptr TagList00](self.impl))

proc scope*(self: TagList): TagScope =
  gst_tag_list_get_scope(cast[ptr TagList00](self.impl))

proc gst_tag_list_set_scope(self: ptr TagList00; scope: TagScope) {.
    importc, libprag.}

proc setScope*(self: TagList; scope: TagScope) =
  gst_tag_list_set_scope(cast[ptr TagList00](self.impl), scope)

proc `scope=`*(self: TagList; scope: TagScope) =
  gst_tag_list_set_scope(cast[ptr TagList00](self.impl), scope)

type
  TaskState* {.size: sizeof(cint), pure.} = enum
    started = 0
    stopped = 1
    paused = 2

proc gst_pad_get_task_state(self: ptr Pad00): TaskState {.
    importc, libprag.}

proc getTaskState*(self: Pad): TaskState =
  gst_pad_get_task_state(cast[ptr Pad00](self.impl))

proc taskState*(self: Pad): TaskState =
  gst_pad_get_task_state(cast[ptr Pad00](self.impl))

type
  PadLinkReturn* {.size: sizeof(cint), pure.} = enum
    refused = -6
    nosched = -5
    noformat = -4
    wrongDirection = -3
    wasLinked = -2
    wrongHierarchy = -1
    ok = 0

proc gst_pad_link_get_name(ret: PadLinkReturn): cstring {.
    importc, libprag.}

proc linkGetName*(ret: PadLinkReturn): string =
  result = $gst_pad_link_get_name(ret)

proc gst_pad_link(self: ptr Pad00; sinkpad: ptr Pad00): PadLinkReturn {.
    importc, libprag.}

proc link*(self: Pad; sinkpad: Pad): PadLinkReturn =
  gst_pad_link(cast[ptr Pad00](self.impl), cast[ptr Pad00](sinkpad.impl))

type
  Buffer00* {.pure.} = object
  Buffer* = ref object
    impl*: ptr Buffer00
    ignoreFinalizer*: bool

proc gst_buffer_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstBuffer*(self: Buffer) =
  if not self.ignoreFinalizer:
    boxedFree(gst_buffer_get_type(), cast[ptr Buffer00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Buffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_buffer_get_type(), cast[ptr Buffer00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Buffer) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstBuffer)

proc gst_buffer_new(): ptr Buffer00 {.
    importc, libprag.}

proc newBuffer*(): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new()

proc newBuffer*(tdesc: typedesc): tdesc =
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new()

proc initBuffer*[T](result: var T) {.deprecated.} =
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new()

proc gst_buffer_new_allocate(allocator: ptr Allocator00; size: uint64; params: ptr AllocationParams00): ptr Buffer00 {.
    importc, libprag.}

proc newBufferAllocate*(allocator: Allocator = nil; size: uint64; params: AllocationParams = nil): Buffer =
  let impl0 = gst_buffer_new_allocate(if allocator.isNil: nil else: cast[ptr Allocator00](allocator.impl), size, if params.isNil: nil else: cast[ptr AllocationParams00](params.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc newBufferAllocate*(tdesc: typedesc; allocator: Allocator = nil; size: uint64; params: AllocationParams = nil): tdesc =
  assert(result is Buffer)
  let impl0 = gst_buffer_new_allocate(if allocator.isNil: nil else: cast[ptr Allocator00](allocator.impl), size, if params.isNil: nil else: cast[ptr AllocationParams00](params.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc initBufferAllocate*[T](result: var T; allocator: Allocator = nil; size: uint64; params: AllocationParams = nil) {.deprecated.} =
  assert(result is Buffer)
  let impl0 = gst_buffer_new_allocate(if allocator.isNil: nil else: cast[ptr Allocator00](allocator.impl), size, if params.isNil: nil else: cast[ptr AllocationParams00](params.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_buffer_new_wrapped(data: ptr uint8; size: uint64): ptr Buffer00 {.
    importc, libprag.}

proc newBufferWrapped*(data: seq[uint8] | string): Buffer =
  let size = uint64(data.len)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped(cast[ptr uint8](unsafeaddr(data[0])), size)

proc newBufferWrapped*(tdesc: typedesc; data: seq[uint8] | string): tdesc =
  let size = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped(cast[ptr uint8](unsafeaddr(data[0])), size)

proc initBufferWrapped*[T](result: var T; data: seq[uint8] | string) {.deprecated.} =
  let size = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped(cast[ptr uint8](unsafeaddr(data[0])), size)

proc gst_buffer_new_wrapped_bytes(bytes: ptr glib.Bytes00): ptr Buffer00 {.
    importc, libprag.}

proc newBufferWrappedBytes*(bytes: glib.Bytes): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped_bytes(cast[ptr glib.Bytes00](bytes.impl))

proc newBufferWrappedBytes*(tdesc: typedesc; bytes: glib.Bytes): tdesc =
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped_bytes(cast[ptr glib.Bytes00](bytes.impl))

proc initBufferWrappedBytes*[T](result: var T; bytes: glib.Bytes) {.deprecated.} =
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped_bytes(cast[ptr glib.Bytes00](bytes.impl))

proc gst_buffer_new_wrapped_full(flags: MemoryFlags; data: ptr uint8; maxsize: uint64;
    offset: uint64; size: uint64; userData: pointer; notify: DestroyNotify): ptr Buffer00 {.
    importc, libprag.}

proc newBufferWrappedFull*(flags: MemoryFlags; data: seq[uint8] | string;
    maxsize: uint64; offset: uint64; userData: pointer; notify: DestroyNotify): Buffer =
  let size = uint64(data.len)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped_full(flags, cast[ptr uint8](unsafeaddr(data[0])), maxsize, offset, size, userData, notify)

proc newBufferWrappedFull*(tdesc: typedesc; flags: MemoryFlags; data: seq[uint8] | string;
    maxsize: uint64; offset: uint64; userData: pointer; notify: DestroyNotify): tdesc =
  let size = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped_full(flags, cast[ptr uint8](unsafeaddr(data[0])), maxsize, offset, size, userData, notify)

proc initBufferWrappedFull*[T](result: var T; flags: MemoryFlags; data: seq[uint8] | string;
    maxsize: uint64; offset: uint64; userData: pointer; notify: DestroyNotify) {.deprecated.} =
  let size = uint64(data.len)
  assert(result is Buffer)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_new_wrapped_full(flags, cast[ptr uint8](unsafeaddr(data[0])), maxsize, offset, size, userData, notify)

proc gst_buffer_append(self: ptr Buffer00; buf2: ptr Buffer00): ptr Buffer00 {.
    importc, libprag.}

proc append*(self: Buffer; buf2: Buffer): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_append(cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), self.impl)), cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), buf2.impl)))

proc gst_buffer_append_memory(self: ptr Buffer00; mem: ptr Memory00) {.
    importc, libprag.}

proc appendMemory*(self: Buffer; mem: Memory) =
  gst_buffer_append_memory(cast[ptr Buffer00](self.impl), cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), mem.impl)))

proc gst_buffer_append_region(self: ptr Buffer00; buf2: ptr Buffer00; offset: int64;
    size: int64): ptr Buffer00 {.
    importc, libprag.}

proc appendRegion*(self: Buffer; buf2: Buffer; offset: int64;
    size: int64): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_append_region(cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), self.impl)), cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), buf2.impl)), offset, size)

proc gst_buffer_copy_deep(self: ptr Buffer00): ptr Buffer00 {.
    importc, libprag.}

proc copyDeep*(self: Buffer): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_copy_deep(cast[ptr Buffer00](self.impl))

proc gst_buffer_extract(self: ptr Buffer00; offset: uint64; dest: ptr uint8;
    size: var uint64): uint64 {.
    importc, libprag.}

proc extract*(self: Buffer; offset: uint64; dest: var (seq[uint8] | string);
    size: var uint64): uint64 =
  gst_buffer_extract(cast[ptr Buffer00](self.impl), offset, cast[ptr uint8](unsafeaddr(dest[0])), size)

proc gst_buffer_extract_dup(self: ptr Buffer00; offset: uint64; size: uint64;
    dest: var ptr uint8; destSize: var uint64) {.
    importc, libprag.}

proc extractDup*(self: Buffer; offset: uint64; size: uint64; dest: var (seq[uint8] | string);
    destSize: var uint64) =
  var dest_00: ptr uint8
  gst_buffer_extract_dup(cast[ptr Buffer00](self.impl), offset, size, dest_00, destSize)
  dest.setLen(destSize)
  copyMem(unsafeaddr dest[0], dest_00, destSize.int * sizeof(dest[0]))
  cogfree(dest_00)

proc gst_buffer_fill(self: ptr Buffer00; offset: uint64; src: ptr uint8;
    size: uint64): uint64 {.
    importc, libprag.}

proc fill*(self: Buffer; offset: uint64; src: seq[uint8] | string): uint64 =
  let size = uint64(src.len)
  gst_buffer_fill(cast[ptr Buffer00](self.impl), offset, cast[ptr uint8](unsafeaddr(src[0])), size)

proc gst_buffer_find_memory(self: ptr Buffer00; offset: uint64; size: uint64;
    idx: var uint32; length: var uint32; skip: var uint64): gboolean {.
    importc, libprag.}

proc findMemory*(self: Buffer; offset: uint64; size: uint64; idx: var int;
    length: var int; skip: var uint64): bool =
  var length_00: uint32
  var idx_00: uint32
  result = toBool(gst_buffer_find_memory(cast[ptr Buffer00](self.impl), offset, size, idx_00, length_00, skip))
  if length.addr != nil:
    length = int(length_00)
  if idx.addr != nil:
    idx = int(idx_00)

proc gst_buffer_get_all_memory(self: ptr Buffer00): ptr Memory00 {.
    importc, libprag.}

proc getAllMemory*(self: Buffer): Memory =
  let impl0 = gst_buffer_get_all_memory(cast[ptr Buffer00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc allMemory*(self: Buffer): Memory =
  let impl0 = gst_buffer_get_all_memory(cast[ptr Buffer00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc gst_buffer_get_memory(self: ptr Buffer00; idx: uint32): ptr Memory00 {.
    importc, libprag.}

proc getMemory*(self: Buffer; idx: int): Memory =
  let impl0 = gst_buffer_get_memory(cast[ptr Buffer00](self.impl), uint32(idx))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc gst_buffer_get_memory_range(self: ptr Buffer00; idx: uint32; length: int32): ptr Memory00 {.
    importc, libprag.}

proc getMemoryRange*(self: Buffer; idx: int; length: int): Memory =
  let impl0 = gst_buffer_get_memory_range(cast[ptr Buffer00](self.impl), uint32(idx), int32(length))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = impl0

proc gst_buffer_get_n_meta(self: ptr Buffer00; apiType: GType): uint32 {.
    importc, libprag.}

proc getNMeta*(self: Buffer; apiType: GType): int =
  int(gst_buffer_get_n_meta(cast[ptr Buffer00](self.impl), apiType))

proc gst_buffer_get_size(self: ptr Buffer00): uint64 {.
    importc, libprag.}

proc getSizeBuffer*(self: Buffer): uint64 =
  gst_buffer_get_size(cast[ptr Buffer00](self.impl))

proc sizeBuffer*(self: Buffer): uint64 =
  gst_buffer_get_size(cast[ptr Buffer00](self.impl))

proc gst_buffer_get_sizes(self: ptr Buffer00; offset: var uint64; maxsize: var uint64): uint64 {.
    importc, libprag.}

proc getSizes*(self: Buffer; offset: var uint64 = cast[var uint64](nil);
    maxsize: var uint64 = cast[var uint64](nil)): uint64 =
  gst_buffer_get_sizes(cast[ptr Buffer00](self.impl), offset, maxsize)

proc gst_buffer_get_sizes_range(self: ptr Buffer00; idx: uint32; length: int32;
    offset: var uint64; maxsize: var uint64): uint64 {.
    importc, libprag.}

proc getSizesRange*(self: Buffer; idx: int; length: int; offset: var uint64 = cast[var uint64](nil);
    maxsize: var uint64 = cast[var uint64](nil)): uint64 =
  gst_buffer_get_sizes_range(cast[ptr Buffer00](self.impl), uint32(idx), int32(length), offset, maxsize)

proc gst_buffer_insert_memory(self: ptr Buffer00; idx: int32; mem: ptr Memory00) {.
    importc, libprag.}

proc insertMemory*(self: Buffer; idx: int; mem: Memory) =
  gst_buffer_insert_memory(cast[ptr Buffer00](self.impl), int32(idx), cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), mem.impl)))

proc gst_buffer_is_all_memory_writable(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc isAllMemoryWritable*(self: Buffer): bool =
  toBool(gst_buffer_is_all_memory_writable(cast[ptr Buffer00](self.impl)))

proc gst_buffer_is_memory_range_writable(self: ptr Buffer00; idx: uint32;
    length: int32): gboolean {.
    importc, libprag.}

proc isMemoryRangeWritable*(self: Buffer; idx: int; length: int): bool =
  toBool(gst_buffer_is_memory_range_writable(cast[ptr Buffer00](self.impl), uint32(idx), int32(length)))

proc gst_buffer_map(self: ptr Buffer00; info: var MapInfo; flags: MapFlags): gboolean {.
    importc, libprag.}

proc map*(self: Buffer; info: var MapInfo; flags: MapFlags): bool =
  toBool(gst_buffer_map(cast[ptr Buffer00](self.impl), info, flags))

proc gst_buffer_map_range(self: ptr Buffer00; idx: uint32; length: int32;
    info: var MapInfo; flags: MapFlags): gboolean {.
    importc, libprag.}

proc mapRange*(self: Buffer; idx: int; length: int; info: var MapInfo;
    flags: MapFlags): bool =
  toBool(gst_buffer_map_range(cast[ptr Buffer00](self.impl), uint32(idx), int32(length), info, flags))

proc gst_buffer_memcmp(self: ptr Buffer00; offset: uint64; mem: ptr uint8;
    size: uint64): int32 {.
    importc, libprag.}

proc memcmp*(self: Buffer; offset: uint64; mem: seq[uint8] | string): int =
  let size = uint64(mem.len)
  int(gst_buffer_memcmp(cast[ptr Buffer00](self.impl), offset, cast[ptr uint8](unsafeaddr(mem[0])), size))

proc gst_buffer_memset(self: ptr Buffer00; offset: uint64; val: uint8; size: uint64): uint64 {.
    importc, libprag.}

proc memset*(self: Buffer; offset: uint64; val: uint8; size: uint64): uint64 =
  gst_buffer_memset(cast[ptr Buffer00](self.impl), offset, val, size)

proc gst_buffer_n_memory(self: ptr Buffer00): uint32 {.
    importc, libprag.}

proc nMemory*(self: Buffer): int =
  int(gst_buffer_n_memory(cast[ptr Buffer00](self.impl)))

proc gst_buffer_peek_memory(self: ptr Buffer00; idx: uint32): ptr Memory00 {.
    importc, libprag.}

proc peekMemory*(self: Buffer; idx: int): Memory =
  let impl0 = gst_buffer_peek_memory(cast[ptr Buffer00](self.impl), uint32(idx))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMemory)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_memory_get_type(), impl0))

proc gst_buffer_prepend_memory(self: ptr Buffer00; mem: ptr Memory00) {.
    importc, libprag.}

proc prependMemory*(self: Buffer; mem: Memory) =
  gst_buffer_prepend_memory(cast[ptr Buffer00](self.impl), cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), mem.impl)))

proc gst_buffer_remove_all_memory(self: ptr Buffer00) {.
    importc, libprag.}

proc removeAllMemory*(self: Buffer) =
  gst_buffer_remove_all_memory(cast[ptr Buffer00](self.impl))

proc gst_buffer_remove_memory(self: ptr Buffer00; idx: uint32) {.
    importc, libprag.}

proc removeMemory*(self: Buffer; idx: int) =
  gst_buffer_remove_memory(cast[ptr Buffer00](self.impl), uint32(idx))

proc gst_buffer_remove_memory_range(self: ptr Buffer00; idx: uint32; length: int32) {.
    importc, libprag.}

proc removeMemoryRange*(self: Buffer; idx: int; length: int) =
  gst_buffer_remove_memory_range(cast[ptr Buffer00](self.impl), uint32(idx), int32(length))

proc gst_buffer_replace_all_memory(self: ptr Buffer00; mem: ptr Memory00) {.
    importc, libprag.}

proc replaceAllMemory*(self: Buffer; mem: Memory) =
  gst_buffer_replace_all_memory(cast[ptr Buffer00](self.impl), cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), mem.impl)))

proc gst_buffer_replace_memory(self: ptr Buffer00; idx: uint32; mem: ptr Memory00) {.
    importc, libprag.}

proc replaceMemory*(self: Buffer; idx: int; mem: Memory) =
  gst_buffer_replace_memory(cast[ptr Buffer00](self.impl), uint32(idx), cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), mem.impl)))

proc gst_buffer_replace_memory_range(self: ptr Buffer00; idx: uint32; length: int32;
    mem: ptr Memory00) {.
    importc, libprag.}

proc replaceMemoryRange*(self: Buffer; idx: int; length: int;
    mem: Memory) =
  gst_buffer_replace_memory_range(cast[ptr Buffer00](self.impl), uint32(idx), int32(length), cast[ptr Memory00](g_boxed_copy(gst_memory_get_type(), mem.impl)))

proc gst_buffer_resize(self: ptr Buffer00; offset: int64; size: int64) {.
    importc, libprag.}

proc resize*(self: Buffer; offset: int64; size: int64) =
  gst_buffer_resize(cast[ptr Buffer00](self.impl), offset, size)

proc gst_buffer_resize_range(self: ptr Buffer00; idx: uint32; length: int32;
    offset: int64; size: int64): gboolean {.
    importc, libprag.}

proc resizeRange*(self: Buffer; idx: int; length: int; offset: int64;
    size: int64): bool =
  toBool(gst_buffer_resize_range(cast[ptr Buffer00](self.impl), uint32(idx), int32(length), offset, size))

proc gst_buffer_set_size(self: ptr Buffer00; size: int64) {.
    importc, libprag.}

proc setSize*(self: Buffer; size: int64) =
  gst_buffer_set_size(cast[ptr Buffer00](self.impl), size)

proc `size=`*(self: Buffer; size: int64) =
  gst_buffer_set_size(cast[ptr Buffer00](self.impl), size)

proc gst_buffer_unmap(self: ptr Buffer00; info: MapInfo) {.
    importc, libprag.}

proc unmap*(self: Buffer; info: MapInfo) =
  gst_buffer_unmap(cast[ptr Buffer00](self.impl), info)

proc gst_buffer_get_max_memory(): uint32 {.
    importc, libprag.}

proc getMaxMemory*(): int =
  int(gst_buffer_get_max_memory())

proc gst_pad_chain(self: ptr Pad00; buffer: ptr Buffer00): FlowReturn {.
    importc, libprag.}

proc chain*(self: Pad; buffer: Buffer): FlowReturn =
  gst_pad_chain(cast[ptr Pad00](self.impl), cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_pad_get_range(self: ptr Pad00; offset: uint64; size: uint32; buffer: var ptr Buffer00): FlowReturn {.
    importc, libprag.}

proc getRange*(self: Pad; offset: uint64; size: int; buffer: var Buffer): FlowReturn =
  fnew(buffer, gBoxedFreeGstBuffer)
  gst_pad_get_range(cast[ptr Pad00](self.impl), offset, uint32(size), cast[var ptr Buffer00](addr buffer.impl))

proc gst_pad_pull_range(self: ptr Pad00; offset: uint64; size: uint32; buffer: var ptr Buffer00): FlowReturn {.
    importc, libprag.}

proc pullRange*(self: Pad; offset: uint64; size: int; buffer: var Buffer): FlowReturn =
  fnew(buffer, gBoxedFreeGstBuffer)
  gst_pad_pull_range(cast[ptr Pad00](self.impl), offset, uint32(size), cast[var ptr Buffer00](addr buffer.impl))

proc gst_pad_push(self: ptr Pad00; buffer: ptr Buffer00): FlowReturn {.
    importc, libprag.}

proc push*(self: Pad; buffer: Buffer): FlowReturn =
  gst_pad_push(cast[ptr Pad00](self.impl), cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_sample_get_buffer(self: ptr Sample00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: Sample): Buffer =
  let impl0 = gst_sample_get_buffer(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), impl0))

proc buffer*(self: Sample): Buffer =
  let impl0 = gst_sample_get_buffer(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), impl0))

proc gst_sample_set_buffer(self: ptr Sample00; buffer: ptr Buffer00) {.
    importc, libprag.}

proc setBuffer*(self: Sample; buffer: Buffer) =
  gst_sample_set_buffer(cast[ptr Sample00](self.impl), cast[ptr Buffer00](buffer.impl))

proc `buffer=`*(self: Sample; buffer: Buffer) =
  gst_sample_set_buffer(cast[ptr Sample00](self.impl), cast[ptr Buffer00](buffer.impl))

type
  MetaInfo00* {.pure.} = object
  MetaInfo* = ref object
    impl*: ptr MetaInfo00
    ignoreFinalizer*: bool

type
  ParentBufferMeta00* {.pure.} = object
  ParentBufferMeta* = ref object
    impl*: ptr ParentBufferMeta00
    ignoreFinalizer*: bool

proc gst_parent_buffer_meta_get_info(): ptr MetaInfo00 {.
    importc, libprag.}

proc getInfoParentBufferMeta*(): MetaInfo =
  new(result)
  result.impl = gst_parent_buffer_meta_get_info()
  result.ignoreFinalizer = true

proc gst_buffer_add_parent_buffer_meta(self: ptr Buffer00; `ref`: ptr Buffer00): ptr ParentBufferMeta00 {.
    importc, libprag.}

proc addParentBufferMeta*(self: Buffer; `ref`: Buffer): ParentBufferMeta =
  let impl0 = gst_buffer_add_parent_buffer_meta(cast[ptr Buffer00](self.impl), cast[ptr Buffer00](`ref`.impl))
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

type
  ProtectionMeta00* {.pure.} = object
  ProtectionMeta* = ref object
    impl*: ptr ProtectionMeta00
    ignoreFinalizer*: bool

proc gst_protection_meta_get_info(): ptr MetaInfo00 {.
    importc, libprag.}

proc getInfoProtectionMeta*(): MetaInfo =
  new(result)
  result.impl = gst_protection_meta_get_info()
  result.ignoreFinalizer = true

proc gst_buffer_add_protection_meta(self: ptr Buffer00; info: ptr Structure00): ptr ProtectionMeta00 {.
    importc, libprag.}

proc addProtectionMeta*(self: Buffer; info: Structure): ProtectionMeta =
  new(result)
  result.impl = gst_buffer_add_protection_meta(cast[ptr Buffer00](self.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), info.impl)))
  result.ignoreFinalizer = true

type
  BufferCopyFlag* {.size: sizeof(cint), pure.} = enum
    flags = 0
    timestamps = 1
    meta = 2
    memory = 3
    merge = 4
    deep = 5

  BufferCopyFlags* {.size: sizeof(cint).} = set[BufferCopyFlag]

const
  BufferCopyFlagsNone* = BufferCopyFlags({})
proc none*(t: typedesc[BufferCopyFlags]): BufferCopyFlags = BufferCopyFlags({})

proc gst_buffer_copy_into(self: ptr Buffer00; src: ptr Buffer00; flags: BufferCopyFlags;
    offset: uint64; size: uint64): gboolean {.
    importc, libprag.}

proc copyInto*(self: Buffer; src: Buffer; flags: BufferCopyFlags;
    offset: uint64; size: uint64): bool =
  toBool(gst_buffer_copy_into(cast[ptr Buffer00](self.impl), cast[ptr Buffer00](src.impl), flags, offset, size))

proc gst_buffer_copy_region(self: ptr Buffer00; flags: BufferCopyFlags; offset: uint64;
    size: uint64): ptr Buffer00 {.
    importc, libprag.}

proc copyRegion*(self: Buffer; flags: BufferCopyFlags; offset: uint64;
    size: uint64): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_copy_region(cast[ptr Buffer00](self.impl), flags, offset, size)

type
  Meta00* {.pure.} = object
  Meta* = ref object
    impl*: ptr Meta00
    ignoreFinalizer*: bool

proc gst_meta_compare_seqnum(self: ptr Meta00; meta2: ptr Meta00): int32 {.
    importc, libprag.}

proc compareSeqnum*(self: Meta; meta2: Meta): int =
  int(gst_meta_compare_seqnum(cast[ptr Meta00](self.impl), cast[ptr Meta00](meta2.impl)))

proc gst_meta_get_seqnum(self: ptr Meta00): uint64 {.
    importc, libprag.}

proc getSeqnum*(self: Meta): uint64 =
  gst_meta_get_seqnum(cast[ptr Meta00](self.impl))

proc seqnum*(self: Meta): uint64 =
  gst_meta_get_seqnum(cast[ptr Meta00](self.impl))

proc gst_meta_api_type_get_tags(api: GType): ptr cstring {.
    importc, libprag.}

proc apiTypeGetTags*(api: GType): seq[string] =
  cstringArrayToSeq(gst_meta_api_type_get_tags(api))

proc gst_meta_api_type_has_tag(api: GType; tag: uint32): gboolean {.
    importc, libprag.}

proc apiTypeHasTag*(api: GType; tag: int): bool =
  toBool(gst_meta_api_type_has_tag(api, uint32(tag)))

proc gst_meta_api_type_register(api: cstring; tags: ptr cstring): GType {.
    importc, libprag.}

proc apiTypeRegister*(api: cstring; tags: varargs[string, `$`]): GType =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gst_meta_api_type_register(api, seq2CstringArray(tags, fs469n23))

proc gst_meta_get_info(impl: cstring): ptr MetaInfo00 {.
    importc, libprag.}

proc getInfoMeta*(impl: cstring): MetaInfo =
  let impl0 = gst_meta_get_info(impl)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc infoMeta*(impl: cstring): MetaInfo =
  let impl0 = gst_meta_get_info(impl)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc gst_buffer_add_meta(self: ptr Buffer00; info: ptr MetaInfo00; params: pointer): ptr Meta00 {.
    importc, libprag.}

proc addMeta*(self: Buffer; info: MetaInfo; params: pointer): Meta =
  let impl0 = gst_buffer_add_meta(cast[ptr Buffer00](self.impl), cast[ptr MetaInfo00](info.impl), params)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc gst_buffer_get_meta(self: ptr Buffer00; api: GType): ptr Meta00 {.
    importc, libprag.}

proc getMeta*(self: Buffer; api: GType): Meta =
  let impl0 = gst_buffer_get_meta(cast[ptr Buffer00](self.impl), api)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc gst_buffer_remove_meta(self: ptr Buffer00; meta: ptr Meta00): gboolean {.
    importc, libprag.}

proc removeMeta*(self: Buffer; meta: Meta): bool =
  toBool(gst_buffer_remove_meta(cast[ptr Buffer00](self.impl), cast[ptr Meta00](meta.impl)))

type
  BufferFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    live = 4
    decodeOnly = 5
    discont = 6
    resync = 7
    corrupted = 8
    marker = 9
    header = 10
    gap = 11
    droppable = 12
    deltaUnit = 13
    tagMemory = 14
    syncAfter = 15
    nonDroppable = 16
    last = 20

  BufferFlags* {.size: sizeof(cint).} = set[BufferFlag]

proc gst_buffer_get_flags(self: ptr Buffer00): BufferFlags {.
    importc, libprag.}

proc getFlags*(self: Buffer): BufferFlags =
  gst_buffer_get_flags(cast[ptr Buffer00](self.impl))

proc flags*(self: Buffer): BufferFlags =
  gst_buffer_get_flags(cast[ptr Buffer00](self.impl))

proc gst_buffer_has_flags(self: ptr Buffer00; flags: BufferFlags): gboolean {.
    importc, libprag.}

proc hasFlags*(self: Buffer; flags: BufferFlags): bool =
  toBool(gst_buffer_has_flags(cast[ptr Buffer00](self.impl), flags))

proc gst_buffer_set_flags(self: ptr Buffer00; flags: BufferFlags): gboolean {.
    importc, libprag.}

proc setFlags*(self: Buffer; flags: BufferFlags): bool =
  toBool(gst_buffer_set_flags(cast[ptr Buffer00](self.impl), flags))

proc gst_buffer_unset_flags(self: ptr Buffer00; flags: BufferFlags): gboolean {.
    importc, libprag.}

proc unsetFlags*(self: Buffer; flags: BufferFlags): bool =
  toBool(gst_buffer_unset_flags(cast[ptr Buffer00](self.impl), flags))

type
  BufferList00* {.pure.} = object
  BufferList* = ref object
    impl*: ptr BufferList00
    ignoreFinalizer*: bool

proc gst_buffer_list_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstBufferList*(self: BufferList) =
  if not self.ignoreFinalizer:
    boxedFree(gst_buffer_list_get_type(), cast[ptr BufferList00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BufferList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_buffer_list_get_type(), cast[ptr BufferList00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var BufferList) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstBufferList)

proc gst_buffer_list_new(): ptr BufferList00 {.
    importc, libprag.}

proc newBufferList*(): BufferList =
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = gst_buffer_list_new()

proc newBufferList*(tdesc: typedesc): tdesc =
  assert(result is BufferList)
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = gst_buffer_list_new()

proc initBufferList*[T](result: var T) {.deprecated.} =
  assert(result is BufferList)
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = gst_buffer_list_new()

proc gst_buffer_list_new_sized(size: uint32): ptr BufferList00 {.
    importc, libprag.}

proc newBufferListSized*(size: int): BufferList =
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = gst_buffer_list_new_sized(uint32(size))

proc newBufferListSized*(tdesc: typedesc; size: int): tdesc =
  assert(result is BufferList)
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = gst_buffer_list_new_sized(uint32(size))

proc initBufferListSized*[T](result: var T; size: int) {.deprecated.} =
  assert(result is BufferList)
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = gst_buffer_list_new_sized(uint32(size))

proc gst_buffer_list_calculate_size(self: ptr BufferList00): uint64 {.
    importc, libprag.}

proc calculateSize*(self: BufferList): uint64 =
  gst_buffer_list_calculate_size(cast[ptr BufferList00](self.impl))

proc gst_buffer_list_copy_deep(self: ptr BufferList00): ptr BufferList00 {.
    importc, libprag.}

proc copyDeep*(self: BufferList): BufferList =
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = gst_buffer_list_copy_deep(cast[ptr BufferList00](self.impl))

proc gst_buffer_list_get(self: ptr BufferList00; idx: uint32): ptr Buffer00 {.
    importc, libprag.}

proc getBufferList*(self: BufferList; idx: int): Buffer =
  let impl0 = gst_buffer_list_get(cast[ptr BufferList00](self.impl), uint32(idx))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), impl0))

proc gst_buffer_list_get_writable(self: ptr BufferList00; idx: uint32): ptr Buffer00 {.
    importc, libprag.}

proc getWritable*(self: BufferList; idx: int): Buffer =
  let impl0 = gst_buffer_list_get_writable(cast[ptr BufferList00](self.impl), uint32(idx))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), impl0))

proc gst_buffer_list_insert(self: ptr BufferList00; idx: int32; buffer: ptr Buffer00) {.
    importc, libprag.}

proc insert*(self: BufferList; idx: int; buffer: Buffer) =
  gst_buffer_list_insert(cast[ptr BufferList00](self.impl), int32(idx), cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_buffer_list_length(self: ptr BufferList00): uint32 {.
    importc, libprag.}

proc length*(self: BufferList): int =
  int(gst_buffer_list_length(cast[ptr BufferList00](self.impl)))

proc gst_buffer_list_remove(self: ptr BufferList00; idx: uint32; length: uint32) {.
    importc, libprag.}

proc remove*(self: BufferList; idx: int; length: int) =
  gst_buffer_list_remove(cast[ptr BufferList00](self.impl), uint32(idx), uint32(length))

proc gst_pad_chain_list(self: ptr Pad00; list: ptr BufferList00): FlowReturn {.
    importc, libprag.}

proc chainList*(self: Pad; list: BufferList): FlowReturn =
  gst_pad_chain_list(cast[ptr Pad00](self.impl), cast[ptr BufferList00](g_boxed_copy(gst_buffer_list_get_type(), list.impl)))

proc gst_pad_push_list(self: ptr Pad00; list: ptr BufferList00): FlowReturn {.
    importc, libprag.}

proc pushList*(self: Pad; list: BufferList): FlowReturn =
  gst_pad_push_list(cast[ptr Pad00](self.impl), cast[ptr BufferList00](g_boxed_copy(gst_buffer_list_get_type(), list.impl)))

proc gst_sample_get_buffer_list(self: ptr Sample00): ptr BufferList00 {.
    importc, libprag.}

proc getBufferList*(self: Sample): BufferList =
  let impl0 = gst_sample_get_buffer_list(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_list_get_type(), impl0))

proc bufferList*(self: Sample): BufferList =
  let impl0 = gst_sample_get_buffer_list(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_list_get_type(), impl0))

proc gst_sample_set_buffer_list(self: ptr Sample00; bufferList: ptr BufferList00) {.
    importc, libprag.}

proc setBufferList*(self: Sample; bufferList: BufferList) =
  gst_sample_set_buffer_list(cast[ptr Sample00](self.impl), cast[ptr BufferList00](bufferList.impl))

proc `bufferList=`*(self: Sample; bufferList: BufferList) =
  gst_sample_set_buffer_list(cast[ptr Sample00](self.impl), cast[ptr BufferList00](bufferList.impl))

type
  URIType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    sink = 1
    src = 2

proc gst_element_make_from_uri(`type`: URIType; uri: cstring; elementname: cstring;
    error: ptr ptr glib.Error = nil): ptr Element00 {.
    importc, libprag.}

proc makeFromUri*(`type`: URIType; uri: cstring; elementname: cstring = nil): Element =
  var gerror: ptr glib.Error
  let gobj = gst_element_make_from_uri(`type`, uri, elementname, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Plugin* = ref object of Object
  Plugin00* = object of Object00

proc gst_plugin_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Plugin()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc listFreePlugin*(list: ptr glib.List) {.
    importc: "gst_plugin_list_free", libprag.}

proc gst_plugin_load_by_name(name: cstring): ptr Plugin00 {.
    importc, libprag.}

proc loadByName*(name: cstring): Plugin =
  let gobj = gst_plugin_load_by_name(name)
  if gobj.isNil:
    return nil
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

proc gst_plugin_load_file(filename: cstring; error: ptr ptr glib.Error = nil): ptr Plugin00 {.
    importc, libprag.}

proc loadFile*(filename: cstring): Plugin =
  var gerror: ptr glib.Error
  let gobj = gst_plugin_load_file(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
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

proc gst_plugin_get_cache_data(self: ptr Plugin00): ptr Structure00 {.
    importc, libprag.}

proc getCacheData*(self: Plugin): Structure =
  let impl0 = gst_plugin_get_cache_data(cast[ptr Plugin00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc cacheData*(self: Plugin): Structure =
  let impl0 = gst_plugin_get_cache_data(cast[ptr Plugin00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc gst_plugin_get_description(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getDescription*(self: Plugin): string =
  result = $gst_plugin_get_description(cast[ptr Plugin00](self.impl))

proc description*(self: Plugin): string =
  result = $gst_plugin_get_description(cast[ptr Plugin00](self.impl))

proc gst_plugin_get_filename(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getFilename*(self: Plugin): string =
  let resul0 = gst_plugin_get_filename(cast[ptr Plugin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc filename*(self: Plugin): string =
  let resul0 = gst_plugin_get_filename(cast[ptr Plugin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_plugin_get_license(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getLicense*(self: Plugin): string =
  result = $gst_plugin_get_license(cast[ptr Plugin00](self.impl))

proc license*(self: Plugin): string =
  result = $gst_plugin_get_license(cast[ptr Plugin00](self.impl))

proc gst_plugin_get_name(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getName*(self: Plugin): string =
  result = $gst_plugin_get_name(cast[ptr Plugin00](self.impl))

proc name*(self: Plugin): string =
  result = $gst_plugin_get_name(cast[ptr Plugin00](self.impl))

proc gst_plugin_get_origin(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getOrigin*(self: Plugin): string =
  result = $gst_plugin_get_origin(cast[ptr Plugin00](self.impl))

proc origin*(self: Plugin): string =
  result = $gst_plugin_get_origin(cast[ptr Plugin00](self.impl))

proc gst_plugin_get_package(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getPackage*(self: Plugin): string =
  result = $gst_plugin_get_package(cast[ptr Plugin00](self.impl))

proc package*(self: Plugin): string =
  result = $gst_plugin_get_package(cast[ptr Plugin00](self.impl))

proc gst_plugin_get_release_date_string(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getReleaseDateString*(self: Plugin): string =
  let resul0 = gst_plugin_get_release_date_string(cast[ptr Plugin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc releaseDateString*(self: Plugin): string =
  let resul0 = gst_plugin_get_release_date_string(cast[ptr Plugin00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_plugin_get_source(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getSource*(self: Plugin): string =
  result = $gst_plugin_get_source(cast[ptr Plugin00](self.impl))

proc source*(self: Plugin): string =
  result = $gst_plugin_get_source(cast[ptr Plugin00](self.impl))

proc gst_plugin_get_version(self: ptr Plugin00): cstring {.
    importc, libprag.}

proc getVersion*(self: Plugin): string =
  result = $gst_plugin_get_version(cast[ptr Plugin00](self.impl))

proc version*(self: Plugin): string =
  result = $gst_plugin_get_version(cast[ptr Plugin00](self.impl))

proc gst_plugin_is_loaded(self: ptr Plugin00): gboolean {.
    importc, libprag.}

proc isLoaded*(self: Plugin): bool =
  toBool(gst_plugin_is_loaded(cast[ptr Plugin00](self.impl)))

proc gst_plugin_load(self: ptr Plugin00): ptr Plugin00 {.
    importc, libprag.}

proc load*(self: Plugin): Plugin =
  let gobj = gst_plugin_load(cast[ptr Plugin00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_plugin_set_cache_data(self: ptr Plugin00; cacheData: ptr Structure00) {.
    importc, libprag.}

proc setCacheData*(self: Plugin; cacheData: Structure) =
  gst_plugin_set_cache_data(cast[ptr Plugin00](self.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), cacheData.impl)))

proc `cacheData=`*(self: Plugin; cacheData: Structure) =
  gst_plugin_set_cache_data(cast[ptr Plugin00](self.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), cacheData.impl)))

proc gst_element_register(plugin: ptr Plugin00; name: cstring; rank: uint32;
    `type`: GType): gboolean {.
    importc, libprag.}

proc registerElement*(plugin: Plugin = nil; name: cstring; rank: int;
    `type`: GType): bool =
  toBool(gst_element_register(if plugin.isNil: nil else: cast[ptr Plugin00](plugin.impl), name, uint32(rank), `type`))

type
  PluginDependencyFlag* {.size: sizeof(cint), pure.} = enum
    recurse = 0
    pathsAreDefaultOnly = 1
    fileNameIsSuffix = 2
    fileNameIsPrefix = 3
    pathsAreRelativeToExe = 4

  PluginDependencyFlags* {.size: sizeof(cint).} = set[PluginDependencyFlag]

const
  PluginDependencyFlagsNone* = PluginDependencyFlags({})
proc none*(t: typedesc[PluginDependencyFlags]): PluginDependencyFlags = PluginDependencyFlags({})

proc gst_plugin_add_dependency(self: ptr Plugin00; envVars: ptr cstring;
    paths: ptr cstring; names: ptr cstring; flags: PluginDependencyFlags) {.
    importc, libprag.}

proc addDependency*(self: Plugin; envVars: openArray[string];
    paths: openArray[string]; names: openArray[string]; flags: PluginDependencyFlags) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var fs469n232x: array[256, pointer]
  var fs469n232: cstringArray = cast[cstringArray](addr fs469n232x)
  var fs469n233x: array[256, pointer]
  var fs469n233: cstringArray = cast[cstringArray](addr fs469n233x)
  gst_plugin_add_dependency(cast[ptr Plugin00](self.impl), seq2CstringArray(envVars, fs469n23), seq2CstringArray(paths, fs469n232), seq2CstringArray(names, fs469n232), flags)

proc gst_plugin_add_dependency_simple(self: ptr Plugin00; envVars: cstring;
    paths: cstring; names: cstring; flags: PluginDependencyFlags) {.
    importc, libprag.}

proc addDependencySimple*(self: Plugin; envVars: cstring = nil;
    paths: cstring = nil; names: cstring = nil; flags: PluginDependencyFlags) =
  gst_plugin_add_dependency_simple(cast[ptr Plugin00](self.impl), envVars, paths, names, flags)

type
  StateChange* {.size: sizeof(cint), pure.} = enum
    nullToNull = 9
    nullToReady = 10
    readyToNull = 17
    readyToReady = 18
    readyToPaused = 19
    pausedToReady = 26
    pausedToPaused = 27
    pausedToPlaying = 28
    playingToPaused = 35
    playingToPlaying = 36

proc gst_state_change_get_name(transition: StateChange): cstring {.
    importc, libprag.}

proc getName*(transition: StateChange): string =
  result = $gst_state_change_get_name(transition)

proc name*(transition: StateChange): string =
  result = $gst_state_change_get_name(transition)

type
  StateChangeReturn* {.size: sizeof(cint), pure.} = enum
    failure = 0
    success = 1
    async = 2
    noPreroll = 3

proc gst_element_state_change_return_get_name(stateRet: StateChangeReturn): cstring {.
    importc, libprag.}

proc stateChangeReturnGetName*(stateRet: StateChangeReturn): string =
  result = $gst_element_state_change_return_get_name(stateRet)

proc gst_element_change_state(self: ptr Element00; transition: StateChange): StateChangeReturn {.
    importc, libprag.}

proc changeState*(self: Element; transition: StateChange): StateChangeReturn =
  gst_element_change_state(cast[ptr Element00](self.impl), transition)

proc gst_element_continue_state(self: ptr Element00; ret: StateChangeReturn): StateChangeReturn {.
    importc, libprag.}

proc continueState*(self: Element; ret: StateChangeReturn): StateChangeReturn =
  gst_element_continue_state(cast[ptr Element00](self.impl), ret)

type
  PluginFeature* = ref object of Object
  PluginFeature00* = object of Object00

proc gst_plugin_feature_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PluginFeature()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_plugin_feature_list_copy(list: ptr glib.List): ptr glib.List {.
    importc, libprag.}

proc listCopy*(list: seq[PluginFeature]): seq[PluginFeature] =
  var tempResGL = seq2GList(list)
  let resul0 = gst_plugin_feature_list_copy(tempResGL)
  g_list_free(tempResGL)
  result = glistObjects2seq(PluginFeature, resul0, true)
  g_list_free(resul0)

proc listDebug*(list: ptr glib.List) {.
    importc: "gst_plugin_feature_list_debug", libprag.}

proc listFreePluginFeature*(list: ptr glib.List) {.
    importc: "gst_plugin_feature_list_free", libprag.}

proc gst_plugin_feature_rank_compare_func(p1: pointer; p2: pointer): int32 {.
    importc, libprag.}

proc rankCompareFunc*(p1: pointer; p2: pointer): int =
  int(gst_plugin_feature_rank_compare_func(p1, p2))

proc gst_plugin_feature_check_version(self: ptr PluginFeature00; minMajor: uint32;
    minMinor: uint32; minMicro: uint32): gboolean {.
    importc, libprag.}

proc checkVersion*(self: PluginFeature; minMajor: int;
    minMinor: int; minMicro: int): bool =
  toBool(gst_plugin_feature_check_version(cast[ptr PluginFeature00](self.impl), uint32(minMajor), uint32(minMinor), uint32(minMicro)))

proc gst_plugin_feature_get_plugin(self: ptr PluginFeature00): ptr Plugin00 {.
    importc, libprag.}

proc getPlugin*(self: PluginFeature): Plugin =
  let gobj = gst_plugin_feature_get_plugin(cast[ptr PluginFeature00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_plugin_feature_get_plugin_name(self: ptr PluginFeature00): cstring {.
    importc, libprag.}

proc getPluginName*(self: PluginFeature): string =
  let resul0 = gst_plugin_feature_get_plugin_name(cast[ptr PluginFeature00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc pluginName*(self: PluginFeature): string =
  let resul0 = gst_plugin_feature_get_plugin_name(cast[ptr PluginFeature00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_plugin_feature_get_rank(self: ptr PluginFeature00): uint32 {.
    importc, libprag.}

proc getRank*(self: PluginFeature): int =
  int(gst_plugin_feature_get_rank(cast[ptr PluginFeature00](self.impl)))

proc rank*(self: PluginFeature): int =
  int(gst_plugin_feature_get_rank(cast[ptr PluginFeature00](self.impl)))

proc gst_plugin_feature_load(self: ptr PluginFeature00): ptr PluginFeature00 {.
    importc, libprag.}

proc load*(self: PluginFeature): PluginFeature =
  let gobj = gst_plugin_feature_load(cast[ptr PluginFeature00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_plugin_feature_set_rank(self: ptr PluginFeature00; rank: uint32) {.
    importc, libprag.}

proc setRank*(self: PluginFeature; rank: int) =
  gst_plugin_feature_set_rank(cast[ptr PluginFeature00](self.impl), uint32(rank))

proc `rank=`*(self: PluginFeature; rank: int) =
  gst_plugin_feature_set_rank(cast[ptr PluginFeature00](self.impl), uint32(rank))

type
  ElementFactory* = ref object of PluginFeature
  ElementFactory00* = object of PluginFeature00

proc gst_element_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ElementFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_element_factory_find(name: cstring): ptr ElementFactory00 {.
    importc, libprag.}

proc findElementFactory*(name: cstring): ElementFactory =
  let gobj = gst_element_factory_find(name)
  if gobj.isNil:
    return nil
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

proc gst_element_factory_make(factoryname: cstring; name: cstring): ptr Element00 {.
    importc, libprag.}

proc make*(factoryname: cstring; name: cstring = nil): Element =
  let gobj = gst_element_factory_make(factoryname, name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_element_factory_create(self: ptr ElementFactory00; name: cstring): ptr Element00 {.
    importc, libprag.}

proc create*(self: ElementFactory; name: cstring = nil): Element =
  let gobj = gst_element_factory_create(cast[ptr ElementFactory00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_element_factory_get_element_type(self: ptr ElementFactory00): GType {.
    importc, libprag.}

proc getElementType*(self: ElementFactory): GType =
  gst_element_factory_get_element_type(cast[ptr ElementFactory00](self.impl))

proc elementType*(self: ElementFactory): GType =
  gst_element_factory_get_element_type(cast[ptr ElementFactory00](self.impl))

proc gst_element_factory_get_metadata(self: ptr ElementFactory00; key: cstring): cstring {.
    importc, libprag.}

proc getMetadata*(self: ElementFactory; key: cstring): string =
  let resul0 = gst_element_factory_get_metadata(cast[ptr ElementFactory00](self.impl), key)
  if resul0.isNil:
    return
  result = $resul0

proc gst_element_factory_get_metadata_keys(self: ptr ElementFactory00): ptr cstring {.
    importc, libprag.}

proc getMetadataKeys*(self: ElementFactory): seq[string] =
  let resul0 = gst_element_factory_get_metadata_keys(cast[ptr ElementFactory00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc metadataKeys*(self: ElementFactory): seq[string] =
  let resul0 = gst_element_factory_get_metadata_keys(cast[ptr ElementFactory00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_element_factory_get_num_pad_templates(self: ptr ElementFactory00): uint32 {.
    importc, libprag.}

proc getNumPadTemplates*(self: ElementFactory): int =
  int(gst_element_factory_get_num_pad_templates(cast[ptr ElementFactory00](self.impl)))

proc numPadTemplates*(self: ElementFactory): int =
  int(gst_element_factory_get_num_pad_templates(cast[ptr ElementFactory00](self.impl)))

proc gst_element_factory_get_static_pad_templates(self: ptr ElementFactory00): ptr glib.List {.
    importc, libprag.}

proc getStaticPadTemplates*(self: ElementFactory): seq[StaticPadTemplate] =
  discard

proc staticPadTemplates*(self: ElementFactory): seq[StaticPadTemplate] =
  discard

proc gst_element_factory_get_uri_protocols(self: ptr ElementFactory00): ptr cstring {.
    importc, libprag.}

proc getUriProtocols*(self: ElementFactory): seq[string] =
  cstringArrayToSeq(gst_element_factory_get_uri_protocols(cast[ptr ElementFactory00](self.impl)))

proc uriProtocols*(self: ElementFactory): seq[string] =
  cstringArrayToSeq(gst_element_factory_get_uri_protocols(cast[ptr ElementFactory00](self.impl)))

proc gst_element_factory_get_uri_type(self: ptr ElementFactory00): URIType {.
    importc, libprag.}

proc getUriType*(self: ElementFactory): URIType =
  gst_element_factory_get_uri_type(cast[ptr ElementFactory00](self.impl))

proc uriType*(self: ElementFactory): URIType =
  gst_element_factory_get_uri_type(cast[ptr ElementFactory00](self.impl))

proc gst_element_factory_has_interface(self: ptr ElementFactory00; interfacename: cstring): gboolean {.
    importc, libprag.}

proc hasInterface*(self: ElementFactory; interfacename: cstring): bool =
  toBool(gst_element_factory_has_interface(cast[ptr ElementFactory00](self.impl), interfacename))

proc gst_element_factory_list_is_type(self: ptr ElementFactory00; `type`: uint64): gboolean {.
    importc, libprag.}

proc listIsType*(self: ElementFactory; `type`: uint64): bool =
  toBool(gst_element_factory_list_is_type(cast[ptr ElementFactory00](self.impl), `type`))

proc gst_element_get_factory(self: ptr Element00): ptr ElementFactory00 {.
    importc, libprag.}

proc getFactory*(self: Element): ElementFactory =
  let gobj = gst_element_get_factory(cast[ptr Element00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc factory*(self: Element): ElementFactory =
  let gobj = gst_element_get_factory(cast[ptr Element00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Rank* {.size: sizeof(cint), pure.} = enum
    none = 0
    marginal = 64
    secondary = 128
    primary = 256

proc gst_element_factory_list_get_elements(`type`: uint64; minrank: Rank): ptr glib.List {.
    importc, libprag.}

proc listGetElements*(`type`: uint64; minrank: Rank): seq[ElementFactory] =
  let resul0 = gst_element_factory_list_get_elements(`type`, minrank)
  result = glistObjects2seq(ElementFactory, resul0, true)
  g_list_free(resul0)

type
  Caps00* {.pure.} = object
  Caps* = ref object
    impl*: ptr Caps00
    ignoreFinalizer*: bool

proc gst_caps_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstCaps*(self: Caps) =
  if not self.ignoreFinalizer:
    boxedFree(gst_caps_get_type(), cast[ptr Caps00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Caps()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_caps_get_type(), cast[ptr Caps00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Caps) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstCaps)

proc gst_caps_new_any(): ptr Caps00 {.
    importc, libprag.}

proc newCapsAny*(): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_any()

proc newCapsAny*(tdesc: typedesc): tdesc =
  assert(result is Caps)
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_any()

proc initCapsAny*[T](result: var T) {.deprecated.} =
  assert(result is Caps)
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_any()

proc gst_caps_new_empty(): ptr Caps00 {.
    importc, libprag.}

proc newCapsEmpty*(): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_empty()

proc newCapsEmpty*(tdesc: typedesc): tdesc =
  assert(result is Caps)
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_empty()

proc initCapsEmpty*[T](result: var T) {.deprecated.} =
  assert(result is Caps)
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_empty()

proc gst_caps_new_empty_simple(mediaType: cstring): ptr Caps00 {.
    importc, libprag.}

proc newCapsEmptySimple*(mediaType: cstring): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_empty_simple(mediaType)

proc newCapsEmptySimple*(tdesc: typedesc; mediaType: cstring): tdesc =
  assert(result is Caps)
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_empty_simple(mediaType)

proc initCapsEmptySimple*[T](result: var T; mediaType: cstring) {.deprecated.} =
  assert(result is Caps)
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_new_empty_simple(mediaType)

proc gst_caps_append(self: ptr Caps00; caps2: ptr Caps00) {.
    importc, libprag.}

proc append*(self: Caps; caps2: Caps) =
  gst_caps_append(cast[ptr Caps00](self.impl), cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps2.impl)))

proc gst_caps_append_structure(self: ptr Caps00; structure: ptr Structure00) {.
    importc, libprag.}

proc appendStructure*(self: Caps; structure: Structure) =
  gst_caps_append_structure(cast[ptr Caps00](self.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))

proc gst_caps_can_intersect(self: ptr Caps00; caps2: ptr Caps00): gboolean {.
    importc, libprag.}

proc canIntersect*(self: Caps; caps2: Caps): bool =
  toBool(gst_caps_can_intersect(cast[ptr Caps00](self.impl), cast[ptr Caps00](caps2.impl)))

proc gst_caps_copy(self: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc copy*(self: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_copy(cast[ptr Caps00](self.impl))

proc gst_caps_copy_nth(self: ptr Caps00; nth: uint32): ptr Caps00 {.
    importc, libprag.}

proc copyNth*(self: Caps; nth: int): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_copy_nth(cast[ptr Caps00](self.impl), uint32(nth))

proc gst_caps_fixate(self: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc fixate*(self: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_fixate(cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), self.impl)))

proc gst_caps_get_size(self: ptr Caps00): uint32 {.
    importc, libprag.}

proc getSizeCaps*(self: Caps): int =
  int(gst_caps_get_size(cast[ptr Caps00](self.impl)))

proc sizeCaps*(self: Caps): int =
  int(gst_caps_get_size(cast[ptr Caps00](self.impl)))

proc gst_caps_get_structure(self: ptr Caps00; index: uint32): ptr Structure00 {.
    importc, libprag.}

proc getStructure*(self: Caps; index: int): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_caps_get_structure(cast[ptr Caps00](self.impl), uint32(index))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_caps_intersect(self: ptr Caps00; caps2: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc intersect*(self: Caps; caps2: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_intersect(cast[ptr Caps00](self.impl), cast[ptr Caps00](caps2.impl))

proc gst_caps_is_always_compatible(self: ptr Caps00; caps2: ptr Caps00): gboolean {.
    importc, libprag.}

proc isAlwaysCompatible*(self: Caps; caps2: Caps): bool =
  toBool(gst_caps_is_always_compatible(cast[ptr Caps00](self.impl), cast[ptr Caps00](caps2.impl)))

proc gst_caps_is_any(self: ptr Caps00): gboolean {.
    importc, libprag.}

proc isAny*(self: Caps): bool =
  toBool(gst_caps_is_any(cast[ptr Caps00](self.impl)))

proc gst_caps_is_empty(self: ptr Caps00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: Caps): bool =
  toBool(gst_caps_is_empty(cast[ptr Caps00](self.impl)))

proc gst_caps_is_equal(self: ptr Caps00; caps2: ptr Caps00): gboolean {.
    importc, libprag.}

proc isEqual*(self: Caps; caps2: Caps): bool =
  toBool(gst_caps_is_equal(cast[ptr Caps00](self.impl), cast[ptr Caps00](caps2.impl)))

proc gst_caps_is_equal_fixed(self: ptr Caps00; caps2: ptr Caps00): gboolean {.
    importc, libprag.}

proc isEqualFixed*(self: Caps; caps2: Caps): bool =
  toBool(gst_caps_is_equal_fixed(cast[ptr Caps00](self.impl), cast[ptr Caps00](caps2.impl)))

proc gst_caps_is_fixed(self: ptr Caps00): gboolean {.
    importc, libprag.}

proc isFixed*(self: Caps): bool =
  toBool(gst_caps_is_fixed(cast[ptr Caps00](self.impl)))

proc gst_caps_is_strictly_equal(self: ptr Caps00; caps2: ptr Caps00): gboolean {.
    importc, libprag.}

proc isStrictlyEqual*(self: Caps; caps2: Caps): bool =
  toBool(gst_caps_is_strictly_equal(cast[ptr Caps00](self.impl), cast[ptr Caps00](caps2.impl)))

proc gst_caps_is_subset(self: ptr Caps00; superset: ptr Caps00): gboolean {.
    importc, libprag.}

proc isSubset*(self: Caps; superset: Caps): bool =
  toBool(gst_caps_is_subset(cast[ptr Caps00](self.impl), cast[ptr Caps00](superset.impl)))

proc gst_caps_is_subset_structure(self: ptr Caps00; structure: ptr Structure00): gboolean {.
    importc, libprag.}

proc isSubsetStructure*(self: Caps; structure: Structure): bool =
  toBool(gst_caps_is_subset_structure(cast[ptr Caps00](self.impl), cast[ptr Structure00](structure.impl)))

proc gst_caps_merge(self: ptr Caps00; caps2: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc merge*(self: Caps; caps2: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_merge(cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), self.impl)), cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps2.impl)))

proc gst_caps_merge_structure(self: ptr Caps00; structure: ptr Structure00): ptr Caps00 {.
    importc, libprag.}

proc mergeStructure*(self: Caps; structure: Structure): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_merge_structure(cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), self.impl)), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))

proc gst_caps_normalize(self: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc normalize*(self: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_normalize(cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), self.impl)))

proc gst_caps_remove_structure(self: ptr Caps00; idx: uint32) {.
    importc, libprag.}

proc removeStructure*(self: Caps; idx: int) =
  gst_caps_remove_structure(cast[ptr Caps00](self.impl), uint32(idx))

proc gst_caps_set_value(self: ptr Caps00; field: cstring; value: gobject.Value) {.
    importc, libprag.}

proc setValue*(self: Caps; field: cstring; value: gobject.Value) =
  gst_caps_set_value(cast[ptr Caps00](self.impl), field, value)

proc gst_caps_simplify(self: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc simplify*(self: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_simplify(cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), self.impl)))

proc gst_caps_steal_structure(self: ptr Caps00; index: uint32): ptr Structure00 {.
    importc, libprag.}

proc stealStructure*(self: Caps; index: int): Structure =
  let impl0 = gst_caps_steal_structure(cast[ptr Caps00](self.impl), uint32(index))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0

proc gst_caps_subtract(self: ptr Caps00; subtrahend: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc subtract*(self: Caps; subtrahend: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_subtract(cast[ptr Caps00](self.impl), cast[ptr Caps00](subtrahend.impl))

proc gst_caps_to_string(self: ptr Caps00): cstring {.
    importc, libprag.}

proc toString*(self: Caps): string =
  let resul0 = gst_caps_to_string(cast[ptr Caps00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_caps_truncate(self: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc truncate*(self: Caps): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_truncate(cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), self.impl)))

proc gst_caps_from_string(string: cstring): ptr Caps00 {.
    importc, libprag.}

proc fromStringCaps*(string: cstring): Caps =
  let impl0 = gst_caps_from_string(string)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_pad_get_allowed_caps(self: ptr Pad00): ptr Caps00 {.
    importc, libprag.}

proc getAllowedCaps*(self: Pad): Caps =
  let impl0 = gst_pad_get_allowed_caps(cast[ptr Pad00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc allowedCaps*(self: Pad): Caps =
  let impl0 = gst_pad_get_allowed_caps(cast[ptr Pad00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_pad_get_current_caps(self: ptr Pad00): ptr Caps00 {.
    importc, libprag.}

proc getCurrentCaps*(self: Pad): Caps =
  let impl0 = gst_pad_get_current_caps(cast[ptr Pad00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc currentCaps*(self: Pad): Caps =
  let impl0 = gst_pad_get_current_caps(cast[ptr Pad00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_pad_get_pad_template_caps(self: ptr Pad00): ptr Caps00 {.
    importc, libprag.}

proc getPadTemplateCaps*(self: Pad): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_get_pad_template_caps(cast[ptr Pad00](self.impl))

proc padTemplateCaps*(self: Pad): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_get_pad_template_caps(cast[ptr Pad00](self.impl))

proc gst_pad_peer_query_accept_caps(self: ptr Pad00; caps: ptr Caps00): gboolean {.
    importc, libprag.}

proc peerQueryAcceptCaps*(self: Pad; caps: Caps): bool =
  toBool(gst_pad_peer_query_accept_caps(cast[ptr Pad00](self.impl), cast[ptr Caps00](caps.impl)))

proc gst_pad_peer_query_caps(self: ptr Pad00; filter: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc peerQueryCaps*(self: Pad; filter: Caps = nil): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_peer_query_caps(cast[ptr Pad00](self.impl), if filter.isNil: nil else: cast[ptr Caps00](filter.impl))

proc gst_pad_query_accept_caps(self: ptr Pad00; caps: ptr Caps00): gboolean {.
    importc, libprag.}

proc queryAcceptCaps*(self: Pad; caps: Caps): bool =
  toBool(gst_pad_query_accept_caps(cast[ptr Pad00](self.impl), cast[ptr Caps00](caps.impl)))

proc gst_pad_query_caps(self: ptr Pad00; filter: ptr Caps00): ptr Caps00 {.
    importc, libprag.}

proc queryCaps*(self: Pad; filter: Caps = nil): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_query_caps(cast[ptr Pad00](self.impl), if filter.isNil: nil else: cast[ptr Caps00](filter.impl))

proc gst_element_get_compatible_pad(self: ptr Element00; pad: ptr Pad00;
    caps: ptr Caps00): ptr Pad00 {.
    importc, libprag.}

proc getCompatiblePad*(self: Element; pad: Pad; caps: Caps = nil): Pad =
  let gobj = gst_element_get_compatible_pad(cast[ptr Element00](self.impl), cast[ptr Pad00](pad.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl))
  if gobj.isNil:
    return nil
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

proc gst_element_link_filtered(self: ptr Element00; dest: ptr Element00;
    filter: ptr Caps00): gboolean {.
    importc, libprag.}

proc linkFiltered*(self: Element; dest: Element; filter: Caps = nil): bool =
  toBool(gst_element_link_filtered(cast[ptr Element00](self.impl), cast[ptr Element00](dest.impl), if filter.isNil: nil else: cast[ptr Caps00](filter.impl)))

proc gst_element_link_pads_filtered(self: ptr Element00; srcpadname: cstring;
    dest: ptr Element00; destpadname: cstring; filter: ptr Caps00): gboolean {.
    importc, libprag.}

proc linkPadsFiltered*(self: Element; srcpadname: cstring = nil;
    dest: Element; destpadname: cstring = nil; filter: Caps = nil): bool =
  toBool(gst_element_link_pads_filtered(cast[ptr Element00](self.impl), srcpadname, cast[ptr Element00](dest.impl), destpadname, if filter.isNil: nil else: cast[ptr Caps00](filter.impl)))

proc gst_static_pad_template_get_caps(self: ptr StaticPadTemplate00): ptr Caps00 {.
    importc, libprag.}

proc getCaps*(self: StaticPadTemplate): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_static_pad_template_get_caps(cast[ptr StaticPadTemplate00](self.impl))

proc caps*(self: StaticPadTemplate): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_static_pad_template_get_caps(cast[ptr StaticPadTemplate00](self.impl))

proc gst_stream_new(streamId: cstring; caps: ptr Caps00; `type`: StreamType;
    flags: StreamFlags): ptr Stream00 {.
    importc, libprag.}

proc newStream*(streamId: cstring = nil; caps: Caps = nil; `type`: StreamType;
    flags: StreamFlags): Stream =
  let gobj = gst_stream_new(streamId, if caps.isNil: nil else: cast[ptr Caps00](caps.impl), `type`, flags)
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

proc newStream*(tdesc: typedesc; streamId: cstring = nil; caps: Caps = nil; `type`: StreamType;
    flags: StreamFlags): tdesc =
  assert(result is Stream)
  let gobj = gst_stream_new(streamId, if caps.isNil: nil else: cast[ptr Caps00](caps.impl), `type`, flags)
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

proc initStream*[T](result: var T; streamId: cstring = nil; caps: Caps = nil; `type`: StreamType;
    flags: StreamFlags) {.deprecated.} =
  assert(result is Stream)
  let gobj = gst_stream_new(streamId, if caps.isNil: nil else: cast[ptr Caps00](caps.impl), `type`, flags)
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

proc gst_stream_get_caps(self: ptr Stream00): ptr Caps00 {.
    importc, libprag.}

proc getCaps*(self: Stream): Caps =
  let impl0 = gst_stream_get_caps(cast[ptr Stream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc caps*(self: Stream): Caps =
  let impl0 = gst_stream_get_caps(cast[ptr Stream00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_stream_set_caps(self: ptr Stream00; caps: ptr Caps00) {.
    importc, libprag.}

proc setCaps*(self: Stream; caps: Caps = nil) =
  gst_stream_set_caps(cast[ptr Stream00](self.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl))

proc `caps=`*(self: Stream; caps: Caps = nil) =
  gst_stream_set_caps(cast[ptr Stream00](self.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl))

proc gst_sample_new(buffer: ptr Buffer00; caps: ptr Caps00; segment: ptr Segment00;
    info: ptr Structure00): ptr Sample00 {.
    importc, libprag.}

proc newSample*(buffer: Buffer = nil; caps: Caps = nil; segment: Segment = nil;
    info: Structure = nil): Sample =
  fnew(result, gBoxedFreeGstSample)
  result.impl = gst_sample_new(if buffer.isNil: nil else: cast[ptr Buffer00](buffer.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl), if segment.isNil: nil else: cast[ptr Segment00](segment.impl), if info.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), info.impl)))

proc newSample*(tdesc: typedesc; buffer: Buffer = nil; caps: Caps = nil; segment: Segment = nil;
    info: Structure = nil): tdesc =
  assert(result is Sample)
  fnew(result, gBoxedFreeGstSample)
  result.impl = gst_sample_new(if buffer.isNil: nil else: cast[ptr Buffer00](buffer.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl), if segment.isNil: nil else: cast[ptr Segment00](segment.impl), if info.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), info.impl)))

proc initSample*[T](result: var T; buffer: Buffer = nil; caps: Caps = nil; segment: Segment = nil;
    info: Structure = nil) {.deprecated.} =
  assert(result is Sample)
  fnew(result, gBoxedFreeGstSample)
  result.impl = gst_sample_new(if buffer.isNil: nil else: cast[ptr Buffer00](buffer.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl), if segment.isNil: nil else: cast[ptr Segment00](segment.impl), if info.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), info.impl)))

proc gst_sample_get_caps(self: ptr Sample00): ptr Caps00 {.
    importc, libprag.}

proc getCaps*(self: Sample): Caps =
  let impl0 = gst_sample_get_caps(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_get_type(), impl0))

proc caps*(self: Sample): Caps =
  let impl0 = gst_sample_get_caps(cast[ptr Sample00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_get_type(), impl0))

proc gst_sample_set_caps(self: ptr Sample00; caps: ptr Caps00) {.
    importc, libprag.}

proc setCaps*(self: Sample; caps: Caps) =
  gst_sample_set_caps(cast[ptr Sample00](self.impl), cast[ptr Caps00](caps.impl))

proc `caps=`*(self: Sample; caps: Caps) =
  gst_sample_set_caps(cast[ptr Sample00](self.impl), cast[ptr Caps00](caps.impl))

proc gst_element_factory_can_sink_all_caps(self: ptr ElementFactory00; caps: ptr Caps00): gboolean {.
    importc, libprag.}

proc canSinkAllCaps*(self: ElementFactory; caps: Caps): bool =
  toBool(gst_element_factory_can_sink_all_caps(cast[ptr ElementFactory00](self.impl), cast[ptr Caps00](caps.impl)))

proc gst_element_factory_can_sink_any_caps(self: ptr ElementFactory00; caps: ptr Caps00): gboolean {.
    importc, libprag.}

proc canSinkAnyCaps*(self: ElementFactory; caps: Caps): bool =
  toBool(gst_element_factory_can_sink_any_caps(cast[ptr ElementFactory00](self.impl), cast[ptr Caps00](caps.impl)))

proc gst_element_factory_can_src_all_caps(self: ptr ElementFactory00; caps: ptr Caps00): gboolean {.
    importc, libprag.}

proc canSrcAllCaps*(self: ElementFactory; caps: Caps): bool =
  toBool(gst_element_factory_can_src_all_caps(cast[ptr ElementFactory00](self.impl), cast[ptr Caps00](caps.impl)))

proc gst_element_factory_can_src_any_caps(self: ptr ElementFactory00; caps: ptr Caps00): gboolean {.
    importc, libprag.}

proc canSrcAnyCaps*(self: ElementFactory; caps: Caps): bool =
  toBool(gst_element_factory_can_src_any_caps(cast[ptr ElementFactory00](self.impl), cast[ptr Caps00](caps.impl)))

type
  ReferenceTimestampMeta00* {.pure.} = object
  ReferenceTimestampMeta* = ref object
    impl*: ptr ReferenceTimestampMeta00
    ignoreFinalizer*: bool

proc gst_reference_timestamp_meta_get_info(): ptr MetaInfo00 {.
    importc, libprag.}

proc getInfoReferenceTimestampMeta*(): MetaInfo =
  new(result)
  result.impl = gst_reference_timestamp_meta_get_info()
  result.ignoreFinalizer = true

proc gst_buffer_add_reference_timestamp_meta(self: ptr Buffer00; reference: ptr Caps00;
    timestamp: uint64; duration: uint64): ptr ReferenceTimestampMeta00 {.
    importc, libprag.}

proc addReferenceTimestampMeta*(self: Buffer; reference: Caps;
    timestamp: uint64; duration: uint64): ReferenceTimestampMeta =
  let impl0 = gst_buffer_add_reference_timestamp_meta(cast[ptr Buffer00](self.impl), cast[ptr Caps00](reference.impl), timestamp, duration)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc gst_buffer_get_reference_timestamp_meta(self: ptr Buffer00; reference: ptr Caps00): ptr ReferenceTimestampMeta00 {.
    importc, libprag.}

proc getReferenceTimestampMeta*(self: Buffer; reference: Caps = nil): ReferenceTimestampMeta =
  let impl0 = gst_buffer_get_reference_timestamp_meta(cast[ptr Buffer00](self.impl), if reference.isNil: nil else: cast[ptr Caps00](reference.impl))
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

type
  CapsIntersectMode* {.size: sizeof(cint), pure.} = enum
    zigZag = 0
    first = 1

proc gst_caps_intersect_full(self: ptr Caps00; caps2: ptr Caps00; mode: CapsIntersectMode): ptr Caps00 {.
    importc, libprag.}

proc intersectFull*(self: Caps; caps2: Caps; mode: CapsIntersectMode): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_intersect_full(cast[ptr Caps00](self.impl), cast[ptr Caps00](caps2.impl), mode)

type
  CapsFeatures00* {.pure.} = object
  CapsFeatures* = ref object
    impl*: ptr CapsFeatures00
    ignoreFinalizer*: bool

proc gst_caps_features_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstCapsFeatures*(self: CapsFeatures) =
  if not self.ignoreFinalizer:
    boxedFree(gst_caps_features_get_type(), cast[ptr CapsFeatures00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CapsFeatures()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_caps_features_get_type(), cast[ptr CapsFeatures00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var CapsFeatures) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstCapsFeatures)

proc gst_caps_features_free(self: ptr CapsFeatures00) {.
    importc, libprag.}

proc free*(self: CapsFeatures) =
  gst_caps_features_free(cast[ptr CapsFeatures00](g_boxed_copy(gst_caps_features_get_type(), self.impl)))

proc finalizerfree*(self: CapsFeatures) =
  if not self.ignoreFinalizer:
    gst_caps_features_free(cast[ptr CapsFeatures00](self.impl))

proc gst_caps_features_new_empty(): ptr CapsFeatures00 {.
    importc, libprag.}

proc newCapsFeaturesEmpty*(): CapsFeatures =
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_caps_features_new_empty()

proc newCapsFeaturesEmpty*(tdesc: typedesc): tdesc =
  assert(result is CapsFeatures)
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_caps_features_new_empty()

proc initCapsFeaturesEmpty*[T](result: var T) {.deprecated.} =
  assert(result is CapsFeatures)
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_caps_features_new_empty()

proc gst_caps_features_add(self: ptr CapsFeatures00; feature: cstring) {.
    importc, libprag.}

proc add*(self: CapsFeatures; feature: cstring) =
  gst_caps_features_add(cast[ptr CapsFeatures00](self.impl), feature)

proc gst_caps_features_add_id(self: ptr CapsFeatures00; feature: uint32) {.
    importc, libprag.}

proc addId*(self: CapsFeatures; feature: int) =
  gst_caps_features_add_id(cast[ptr CapsFeatures00](self.impl), uint32(feature))

proc gst_caps_features_contains(self: ptr CapsFeatures00; feature: cstring): gboolean {.
    importc, libprag.}

proc contains*(self: CapsFeatures; feature: cstring): bool =
  toBool(gst_caps_features_contains(cast[ptr CapsFeatures00](self.impl), feature))

proc gst_caps_features_contains_id(self: ptr CapsFeatures00; feature: uint32): gboolean {.
    importc, libprag.}

proc containsId*(self: CapsFeatures; feature: int): bool =
  toBool(gst_caps_features_contains_id(cast[ptr CapsFeatures00](self.impl), uint32(feature)))

proc gst_caps_features_copy(self: ptr CapsFeatures00): ptr CapsFeatures00 {.
    importc, libprag.}

proc copy*(self: CapsFeatures): CapsFeatures =
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_caps_features_copy(cast[ptr CapsFeatures00](self.impl))

proc gst_caps_features_new_any(): ptr CapsFeatures00 {.
    importc, libprag.}

proc newCapsFeaturesAny*(): CapsFeatures =
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_caps_features_new_any()

proc newCapsFeaturesAny*(tdesc: typedesc): tdesc =
  assert(result is CapsFeatures)
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_caps_features_new_any()

proc initCapsFeaturesAny*[T](result: var T) {.deprecated.} =
  assert(result is CapsFeatures)
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_caps_features_new_any()

proc gst_caps_features_get_nth(self: ptr CapsFeatures00; i: uint32): cstring {.
    importc, libprag.}

proc getNth*(self: CapsFeatures; i: int): string =
  let resul0 = gst_caps_features_get_nth(cast[ptr CapsFeatures00](self.impl), uint32(i))
  if resul0.isNil:
    return
  result = $resul0

proc gst_caps_features_get_nth_id(self: ptr CapsFeatures00; i: uint32): uint32 {.
    importc, libprag.}

proc getNthId*(self: CapsFeatures; i: int): int =
  int(gst_caps_features_get_nth_id(cast[ptr CapsFeatures00](self.impl), uint32(i)))

proc gst_caps_features_get_size(self: ptr CapsFeatures00): uint32 {.
    importc, libprag.}

proc getSizeCapsFeatures*(self: CapsFeatures): int =
  int(gst_caps_features_get_size(cast[ptr CapsFeatures00](self.impl)))

proc sizeCapsFeatures*(self: CapsFeatures): int =
  int(gst_caps_features_get_size(cast[ptr CapsFeatures00](self.impl)))

proc gst_caps_features_is_any(self: ptr CapsFeatures00): gboolean {.
    importc, libprag.}

proc isAny*(self: CapsFeatures): bool =
  toBool(gst_caps_features_is_any(cast[ptr CapsFeatures00](self.impl)))

proc gst_caps_features_is_equal(self: ptr CapsFeatures00; features2: ptr CapsFeatures00): gboolean {.
    importc, libprag.}

proc isEqual*(self: CapsFeatures; features2: CapsFeatures): bool =
  toBool(gst_caps_features_is_equal(cast[ptr CapsFeatures00](self.impl), cast[ptr CapsFeatures00](features2.impl)))

proc gst_caps_features_remove(self: ptr CapsFeatures00; feature: cstring) {.
    importc, libprag.}

proc remove*(self: CapsFeatures; feature: cstring) =
  gst_caps_features_remove(cast[ptr CapsFeatures00](self.impl), feature)

proc gst_caps_features_remove_id(self: ptr CapsFeatures00; feature: uint32) {.
    importc, libprag.}

proc removeId*(self: CapsFeatures; feature: int) =
  gst_caps_features_remove_id(cast[ptr CapsFeatures00](self.impl), uint32(feature))

proc gst_caps_features_set_parent_refcount(self: ptr CapsFeatures00; refcount: ptr int32): gboolean {.
    importc, libprag.}

proc setParentRefcount*(self: CapsFeatures; refcount: ptr int32): bool =
  toBool(gst_caps_features_set_parent_refcount(cast[ptr CapsFeatures00](self.impl), refcount))

proc gst_caps_features_to_string(self: ptr CapsFeatures00): cstring {.
    importc, libprag.}

proc toString*(self: CapsFeatures): string =
  let resul0 = gst_caps_features_to_string(cast[ptr CapsFeatures00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_caps_features_from_string(features: cstring): ptr CapsFeatures00 {.
    importc, libprag.}

proc fromStringCapsFeatures*(features: cstring): CapsFeatures =
  let impl0 = gst_caps_features_from_string(features)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = impl0

proc gst_caps_append_structure_full(self: ptr Caps00; structure: ptr Structure00;
    features: ptr CapsFeatures00) {.
    importc, libprag.}

proc appendStructureFull*(self: Caps; structure: Structure; features: CapsFeatures = nil) =
  gst_caps_append_structure_full(cast[ptr Caps00](self.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)), if features.isNil: nil else: cast[ptr CapsFeatures00](g_boxed_copy(gst_caps_features_get_type(), features.impl)))

proc gst_caps_get_features(self: ptr Caps00; index: uint32): ptr CapsFeatures00 {.
    importc, libprag.}

proc getFeatures*(self: Caps; index: int): CapsFeatures =
  let impl0 = gst_caps_get_features(cast[ptr Caps00](self.impl), uint32(index))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_features_get_type(), impl0))

proc gst_caps_is_subset_structure_full(self: ptr Caps00; structure: ptr Structure00;
    features: ptr CapsFeatures00): gboolean {.
    importc, libprag.}

proc isSubsetStructureFull*(self: Caps; structure: Structure;
    features: CapsFeatures = nil): bool =
  toBool(gst_caps_is_subset_structure_full(cast[ptr Caps00](self.impl), cast[ptr Structure00](structure.impl), if features.isNil: nil else: cast[ptr CapsFeatures00](features.impl)))

proc gst_caps_merge_structure_full(self: ptr Caps00; structure: ptr Structure00;
    features: ptr CapsFeatures00): ptr Caps00 {.
    importc, libprag.}

proc mergeStructureFull*(self: Caps; structure: Structure; features: CapsFeatures = nil): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_caps_merge_structure_full(cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), self.impl)), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)), if features.isNil: nil else: cast[ptr CapsFeatures00](g_boxed_copy(gst_caps_features_get_type(), features.impl)))

proc gst_caps_set_features(self: ptr Caps00; index: uint32; features: ptr CapsFeatures00) {.
    importc, libprag.}

proc setFeatures*(self: Caps; index: int; features: CapsFeatures = nil) =
  gst_caps_set_features(cast[ptr Caps00](self.impl), uint32(index), if features.isNil: nil else: cast[ptr CapsFeatures00](g_boxed_copy(gst_caps_features_get_type(), features.impl)))

proc gst_caps_set_features_simple(self: ptr Caps00; features: ptr CapsFeatures00) {.
    importc, libprag.}

proc setFeaturesSimple*(self: Caps; features: CapsFeatures = nil) =
  gst_caps_set_features_simple(cast[ptr Caps00](self.impl), if features.isNil: nil else: cast[ptr CapsFeatures00](g_boxed_copy(gst_caps_features_get_type(), features.impl)))

proc `featuresSimple=`*(self: Caps; features: CapsFeatures = nil) =
  gst_caps_set_features_simple(cast[ptr Caps00](self.impl), if features.isNil: nil else: cast[ptr CapsFeatures00](g_boxed_copy(gst_caps_features_get_type(), features.impl)))

type
  PadLinkCheck* {.size: sizeof(cint), pure.} = enum
    nothing = 0
    hierarchy = 1
    templateCaps = 2
    caps = 4
    default = 5
    noReconfigure = 8

proc gst_pad_link_full(self: ptr Pad00; sinkpad: ptr Pad00; flags: PadLinkCheck): PadLinkReturn {.
    importc, libprag.}

proc linkFull*(self: Pad; sinkpad: Pad; flags: PadLinkCheck): PadLinkReturn =
  gst_pad_link_full(cast[ptr Pad00](self.impl), cast[ptr Pad00](sinkpad.impl), flags)

proc gst_pad_link_maybe_ghosting_full(self: ptr Pad00; sink: ptr Pad00; flags: PadLinkCheck): gboolean {.
    importc, libprag.}

proc linkMaybeGhostingFull*(self: Pad; sink: Pad; flags: PadLinkCheck): bool =
  toBool(gst_pad_link_maybe_ghosting_full(cast[ptr Pad00](self.impl), cast[ptr Pad00](sink.impl), flags))

proc gst_element_link_pads_full(self: ptr Element00; srcpadname: cstring;
    dest: ptr Element00; destpadname: cstring; flags: PadLinkCheck): gboolean {.
    importc, libprag.}

proc linkPadsFull*(self: Element; srcpadname: cstring = nil;
    dest: Element; destpadname: cstring = nil; flags: PadLinkCheck): bool =
  toBool(gst_element_link_pads_full(cast[ptr Element00](self.impl), srcpadname, cast[ptr Element00](dest.impl), destpadname, flags))

type
  MessageFlag* {.size: sizeof(cint), pure.} = enum
    eos = 0
    error = 1
    warning = 2
    info = 3
    tag = 4
    buffering = 5
    stateChanged = 6
    stateDirty = 7
    stepDone = 8
    clockProvide = 9
    clockLost = 10
    newClock = 11
    structureChange = 12
    streamStatus = 13
    application = 14
    element = 15
    segmentStart = 16
    segmentDone = 17
    durationChanged = 18
    latency = 19
    asyncStart = 20
    asyncDone = 21
    requestState = 22
    stepStart = 23
    qos = 24
    progress = 25
    toc = 26
    resetTime = 27
    streamStart = 28
    needContext = 29
    haveContext = 30
    extended = 31

  MessageType* {.size: sizeof(cint).} = set[MessageFlag]

proc gst_message_type_get_name(`type`: MessageType): cstring {.
    importc, libprag.}

proc getName*(`type`: MessageType): string =
  result = $gst_message_type_get_name(`type`)

proc name*(`type`: MessageType): string =
  result = $gst_message_type_get_name(`type`)

proc gst_message_type_to_quark(`type`: MessageType): uint32 {.
    importc, libprag.}

proc toQuark*(`type`: MessageType): int =
  int(gst_message_type_to_quark(`type`))

proc gst_element_message_full(self: ptr Element00; `type`: MessageType; domain: uint32;
    code: int32; text: cstring; debug: cstring; file: cstring; function: cstring;
    line: int32) {.
    importc, libprag.}

proc messageFull*(self: Element; `type`: MessageType; domain: int;
    code: int; text: cstring = nil; debug: cstring = nil; file: cstring; function: cstring;
    line: int) =
  gst_element_message_full(cast[ptr Element00](self.impl), `type`, uint32(domain), int32(code), text, debug, file, function, int32(line))

proc gst_element_message_full_with_details(self: ptr Element00; `type`: MessageType;
    domain: uint32; code: int32; text: cstring; debug: cstring; file: cstring;
    function: cstring; line: int32; structure: ptr Structure00) {.
    importc, libprag.}

proc messageFullWithDetails*(self: Element; `type`: MessageType;
    domain: int; code: int; text: cstring = nil; debug: cstring = nil; file: cstring;
    function: cstring; line: int; structure: Structure) =
  gst_element_message_full_with_details(cast[ptr Element00](self.impl), `type`, uint32(domain), int32(code), text, debug, file, function, int32(line), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))

type
  Query00* {.pure.} = object
  Query* = ref object
    impl*: ptr Query00
    ignoreFinalizer*: bool

proc gst_query_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstQuery*(self: Query) =
  if not self.ignoreFinalizer:
    boxedFree(gst_query_get_type(), cast[ptr Query00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Query()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_query_get_type(), cast[ptr Query00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Query) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstQuery)

proc gst_query_new_accept_caps(caps: ptr Caps00): ptr Query00 {.
    importc, libprag.}

proc newQueryAcceptCaps*(caps: Caps): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_accept_caps(cast[ptr Caps00](caps.impl))

proc newQueryAcceptCaps*(tdesc: typedesc; caps: Caps): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_accept_caps(cast[ptr Caps00](caps.impl))

proc initQueryAcceptCaps*[T](result: var T; caps: Caps) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_accept_caps(cast[ptr Caps00](caps.impl))

proc gst_query_new_allocation(caps: ptr Caps00; needPool: gboolean): ptr Query00 {.
    importc, libprag.}

proc newQueryAllocation*(caps: Caps; needPool: bool): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_allocation(cast[ptr Caps00](caps.impl), gboolean(needPool))

proc newQueryAllocation*(tdesc: typedesc; caps: Caps; needPool: bool): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_allocation(cast[ptr Caps00](caps.impl), gboolean(needPool))

proc initQueryAllocation*[T](result: var T; caps: Caps; needPool: bool) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_allocation(cast[ptr Caps00](caps.impl), gboolean(needPool))

proc gst_query_new_bitrate(): ptr Query00 {.
    importc, libprag.}

proc newQueryBitrate*(): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_bitrate()

proc newQueryBitrate*(tdesc: typedesc): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_bitrate()

proc initQueryBitrate*[T](result: var T) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_bitrate()

proc gst_query_new_caps(filter: ptr Caps00): ptr Query00 {.
    importc, libprag.}

proc newQueryCaps*(filter: Caps): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_caps(cast[ptr Caps00](filter.impl))

proc newQueryCaps*(tdesc: typedesc; filter: Caps): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_caps(cast[ptr Caps00](filter.impl))

proc initQueryCaps*[T](result: var T; filter: Caps) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_caps(cast[ptr Caps00](filter.impl))

proc gst_query_new_context(contextType: cstring): ptr Query00 {.
    importc, libprag.}

proc newQueryContext*(contextType: cstring): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_context(contextType)

proc newQueryContext*(tdesc: typedesc; contextType: cstring): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_context(contextType)

proc initQueryContext*[T](result: var T; contextType: cstring) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_context(contextType)

proc gst_query_new_drain(): ptr Query00 {.
    importc, libprag.}

proc newQueryDrain*(): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_drain()

proc newQueryDrain*(tdesc: typedesc): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_drain()

proc initQueryDrain*[T](result: var T) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_drain()

proc gst_query_new_formats(): ptr Query00 {.
    importc, libprag.}

proc newQueryFormats*(): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_formats()

proc newQueryFormats*(tdesc: typedesc): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_formats()

proc initQueryFormats*[T](result: var T) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_formats()

proc gst_query_new_latency(): ptr Query00 {.
    importc, libprag.}

proc newQueryLatency*(): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_latency()

proc newQueryLatency*(tdesc: typedesc): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_latency()

proc initQueryLatency*[T](result: var T) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_latency()

proc gst_query_new_scheduling(): ptr Query00 {.
    importc, libprag.}

proc newQueryScheduling*(): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_scheduling()

proc newQueryScheduling*(tdesc: typedesc): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_scheduling()

proc initQueryScheduling*[T](result: var T) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_scheduling()

proc gst_query_new_uri(): ptr Query00 {.
    importc, libprag.}

proc newQueryUri*(): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_uri()

proc newQueryUri*(tdesc: typedesc): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_uri()

proc initQueryUri*[T](result: var T) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_uri()

proc gst_query_add_allocation_meta(self: ptr Query00; api: GType; params: ptr Structure00) {.
    importc, libprag.}

proc addAllocationMeta*(self: Query; api: GType; params: Structure = nil) =
  gst_query_add_allocation_meta(cast[ptr Query00](self.impl), api, if params.isNil: nil else: cast[ptr Structure00](params.impl))

proc gst_query_add_allocation_param(self: ptr Query00; allocator: ptr Allocator00;
    params: ptr AllocationParams00) {.
    importc, libprag.}

proc addAllocationParam*(self: Query; allocator: Allocator = nil;
    params: AllocationParams = nil) =
  gst_query_add_allocation_param(cast[ptr Query00](self.impl), if allocator.isNil: nil else: cast[ptr Allocator00](allocator.impl), if params.isNil: nil else: cast[ptr AllocationParams00](params.impl))

proc gst_query_add_buffering_range(self: ptr Query00; start: int64; stop: int64): gboolean {.
    importc, libprag.}

proc addBufferingRange*(self: Query; start: int64; stop: int64): bool =
  toBool(gst_query_add_buffering_range(cast[ptr Query00](self.impl), start, stop))

proc gst_query_add_scheduling_mode(self: ptr Query00; mode: PadMode) {.
    importc, libprag.}

proc addSchedulingMode*(self: Query; mode: PadMode) =
  gst_query_add_scheduling_mode(cast[ptr Query00](self.impl), mode)

proc gst_query_find_allocation_meta(self: ptr Query00; api: GType; index: var uint32): gboolean {.
    importc, libprag.}

proc findAllocationMeta*(self: Query; api: GType; index: var int = cast[var int](nil)): bool =
  var index_00: uint32
  result = toBool(gst_query_find_allocation_meta(cast[ptr Query00](self.impl), api, index_00))
  if index.addr != nil:
    index = int(index_00)

proc gst_query_get_n_allocation_metas(self: ptr Query00): uint32 {.
    importc, libprag.}

proc getNAllocationMetas*(self: Query): int =
  int(gst_query_get_n_allocation_metas(cast[ptr Query00](self.impl)))

proc nAllocationMetas*(self: Query): int =
  int(gst_query_get_n_allocation_metas(cast[ptr Query00](self.impl)))

proc gst_query_get_n_allocation_params(self: ptr Query00): uint32 {.
    importc, libprag.}

proc getNAllocationParams*(self: Query): int =
  int(gst_query_get_n_allocation_params(cast[ptr Query00](self.impl)))

proc nAllocationParams*(self: Query): int =
  int(gst_query_get_n_allocation_params(cast[ptr Query00](self.impl)))

proc gst_query_get_n_allocation_pools(self: ptr Query00): uint32 {.
    importc, libprag.}

proc getNAllocationPools*(self: Query): int =
  int(gst_query_get_n_allocation_pools(cast[ptr Query00](self.impl)))

proc nAllocationPools*(self: Query): int =
  int(gst_query_get_n_allocation_pools(cast[ptr Query00](self.impl)))

proc gst_query_get_n_buffering_ranges(self: ptr Query00): uint32 {.
    importc, libprag.}

proc getNBufferingRanges*(self: Query): int =
  int(gst_query_get_n_buffering_ranges(cast[ptr Query00](self.impl)))

proc nBufferingRanges*(self: Query): int =
  int(gst_query_get_n_buffering_ranges(cast[ptr Query00](self.impl)))

proc gst_query_get_n_scheduling_modes(self: ptr Query00): uint32 {.
    importc, libprag.}

proc getNSchedulingModes*(self: Query): int =
  int(gst_query_get_n_scheduling_modes(cast[ptr Query00](self.impl)))

proc nSchedulingModes*(self: Query): int =
  int(gst_query_get_n_scheduling_modes(cast[ptr Query00](self.impl)))

proc gst_query_get_structure(self: ptr Query00): ptr Structure00 {.
    importc, libprag.}

proc getStructure*(self: Query): Structure =
  let impl0 = gst_query_get_structure(cast[ptr Query00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc structure*(self: Query): Structure =
  let impl0 = gst_query_get_structure(cast[ptr Query00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc gst_query_has_scheduling_mode(self: ptr Query00; mode: PadMode): gboolean {.
    importc, libprag.}

proc hasSchedulingMode*(self: Query; mode: PadMode): bool =
  toBool(gst_query_has_scheduling_mode(cast[ptr Query00](self.impl), mode))

proc gst_query_parse_accept_caps(self: ptr Query00; caps: var ptr Caps00) {.
    importc, libprag.}

proc parseAcceptCaps*(self: Query; caps: var Caps) =
  fnew(caps, gBoxedFreeGstCaps)
  gst_query_parse_accept_caps(cast[ptr Query00](self.impl), cast[var ptr Caps00](addr caps.impl))
  caps.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl))

proc parseAcceptCaps*(self: Query): Caps =
  fnew(result, gBoxedFreeGstCaps)
  gst_query_parse_accept_caps(cast[ptr Query00](self.impl), cast[var ptr Caps00](addr result.impl))
  result.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), result.impl))

proc gst_query_parse_accept_caps_result(self: ptr Query00; resu: var gboolean) {.
    importc, libprag.}

proc parseAcceptCapsResult*(self: Query; resu: var bool = cast[var bool](nil)) =
  var resu_00: gboolean
  gst_query_parse_accept_caps_result(cast[ptr Query00](self.impl), resu_00)
  if resu.addr != nil:
    resu = toBool(resu_00)

proc parseAcceptCapsResult*(self: Query): bool  =
  var result_00: gboolean
  gst_query_parse_accept_caps_result(cast[ptr Query00](self.impl), result_00)
  if result.addr != nil:
    result = toBool(result_00)

proc gst_query_parse_allocation(self: ptr Query00; caps: var ptr Caps00;
    needPool: var gboolean) {.
    importc, libprag.}

proc parseAllocation*(self: Query; caps: var Caps = cast[var Caps](nil);
    needPool: var bool = cast[var bool](nil)) =
  if addr(caps) != nil:
    fnew(caps, gBoxedFreeGstCaps)
  var needPool_00: gboolean
  gst_query_parse_allocation(cast[ptr Query00](self.impl), cast[var ptr Caps00](if addr(caps) == nil: nil else: addr caps.impl), needPool_00)
  caps.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl))
  if needPool.addr != nil:
    needPool = toBool(needPool_00)

proc gst_query_parse_bitrate(self: ptr Query00; nominalBitrate: var uint32) {.
    importc, libprag.}

proc parseBitrate*(self: Query; nominalBitrate: var int = cast[var int](nil)) =
  var nominalBitrate_00: uint32
  gst_query_parse_bitrate(cast[ptr Query00](self.impl), nominalBitrate_00)
  if nominalBitrate.addr != nil:
    nominalBitrate = int(nominalBitrate_00)

proc parseBitrate*(self: Query): int  =
  var result_00: uint32
  gst_query_parse_bitrate(cast[ptr Query00](self.impl), result_00)
  if result.addr != nil:
    result = int(result_00)

proc gst_query_parse_buffering_percent(self: ptr Query00; busy: var gboolean;
    percent: var int32) {.
    importc, libprag.}

proc parseBufferingPercent*(self: Query; busy: var bool = cast[var bool](nil);
    percent: var int = cast[var int](nil)) =
  var percent_00: int32
  var busy_00: gboolean
  gst_query_parse_buffering_percent(cast[ptr Query00](self.impl), busy_00, percent_00)
  if percent.addr != nil:
    percent = int(percent_00)
  if busy.addr != nil:
    busy = toBool(busy_00)

proc gst_query_parse_caps(self: ptr Query00; filter: var ptr Caps00) {.
    importc, libprag.}

proc parseCaps*(self: Query; filter: var Caps) =
  fnew(filter, gBoxedFreeGstCaps)
  gst_query_parse_caps(cast[ptr Query00](self.impl), cast[var ptr Caps00](addr filter.impl))
  filter.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), filter.impl))

proc parseCaps*(self: Query): Caps =
  fnew(result, gBoxedFreeGstCaps)
  gst_query_parse_caps(cast[ptr Query00](self.impl), cast[var ptr Caps00](addr result.impl))
  result.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), result.impl))

proc gst_query_parse_caps_result(self: ptr Query00; caps: var ptr Caps00) {.
    importc, libprag.}

proc parseCapsResult*(self: Query; caps: var Caps) =
  fnew(caps, gBoxedFreeGstCaps)
  gst_query_parse_caps_result(cast[ptr Query00](self.impl), cast[var ptr Caps00](addr caps.impl))
  caps.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl))

proc parseCapsResult*(self: Query): Caps =
  fnew(result, gBoxedFreeGstCaps)
  gst_query_parse_caps_result(cast[ptr Query00](self.impl), cast[var ptr Caps00](addr result.impl))
  result.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), result.impl))

proc gst_query_parse_context_type(self: ptr Query00; contextType: var cstring): gboolean {.
    importc, libprag.}

proc parseContextType*(self: Query; contextType: var string = cast[var string](nil)): bool =
  var contextType_00: cstring
  result = toBool(gst_query_parse_context_type(cast[ptr Query00](self.impl), contextType_00))
  if contextType.addr != nil:
    contextType = $(contextType_00)

proc gst_query_parse_latency(self: ptr Query00; live: var gboolean; minLatency: var uint64;
    maxLatency: var uint64) {.
    importc, libprag.}

proc parseLatency*(self: Query; live: var bool = cast[var bool](nil);
    minLatency: var uint64 = cast[var uint64](nil); maxLatency: var uint64 = cast[var uint64](nil)) =
  var live_00: gboolean
  gst_query_parse_latency(cast[ptr Query00](self.impl), live_00, minLatency, maxLatency)
  if live.addr != nil:
    live = toBool(live_00)

proc gst_query_parse_n_formats(self: ptr Query00; nFormats: var uint32) {.
    importc, libprag.}

proc parseNFormats*(self: Query; nFormats: var int = cast[var int](nil)) =
  var nFormats_00: uint32
  gst_query_parse_n_formats(cast[ptr Query00](self.impl), nFormats_00)
  if nFormats.addr != nil:
    nFormats = int(nFormats_00)

proc parseNFormats*(self: Query): int  =
  var result_00: uint32
  gst_query_parse_n_formats(cast[ptr Query00](self.impl), result_00)
  if result.addr != nil:
    result = int(result_00)

proc gst_query_parse_nth_allocation_meta(self: ptr Query00; index: uint32;
    params: var ptr Structure00): GType {.
    importc, libprag.}

proc parseNthAllocationMeta*(self: Query; index: int; params: var Structure = cast[var Structure](nil)): GType =
  if addr(params) != nil:
    fnew(params, gBoxedFreeGstStructure)
  result = gst_query_parse_nth_allocation_meta(cast[ptr Query00](self.impl), uint32(index), cast[var ptr Structure00](if addr(params) == nil: nil else: addr params.impl))
  params.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), params.impl))

proc gst_query_parse_nth_allocation_param(self: ptr Query00; index: uint32;
    allocator: var ptr Allocator00; params: var AllocationParams00) {.
    importc, libprag.}

proc parseNthAllocationParam*(self: Query; index: int; allocator: var Allocator = cast[var Allocator](nil);
    params: var AllocationParams00 = cast[var AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr Allocator00
  gst_query_parse_nth_allocation_param(cast[ptr Query00](self.impl), uint32(index), cast[var ptr Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gst.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_query_parse_nth_buffering_range(self: ptr Query00; index: uint32;
    start: var int64; stop: var int64): gboolean {.
    importc, libprag.}

proc parseNthBufferingRange*(self: Query; index: int; start: var int64 = cast[var int64](nil);
    stop: var int64 = cast[var int64](nil)): bool =
  toBool(gst_query_parse_nth_buffering_range(cast[ptr Query00](self.impl), uint32(index), start, stop))

proc gst_query_parse_nth_scheduling_mode(self: ptr Query00; index: uint32): PadMode {.
    importc, libprag.}

proc parseNthSchedulingMode*(self: Query; index: int): PadMode =
  gst_query_parse_nth_scheduling_mode(cast[ptr Query00](self.impl), uint32(index))

proc gst_query_parse_uri(self: ptr Query00; uri: var cstring) {.
    importc, libprag.}

proc parseUri*(self: Query; uri: var string = cast[var string](nil)) =
  var uri_00: cstring
  gst_query_parse_uri(cast[ptr Query00](self.impl), uri_00)
  if uri.addr != nil:
    uri = $(uri_00)

proc parseUri*(self: Query): string  =
  var result_00: cstring
  gst_query_parse_uri(cast[ptr Query00](self.impl), result_00)
  if result.addr != nil:
    result = $(result_00)

proc gst_query_parse_uri_redirection(self: ptr Query00; uri: var cstring) {.
    importc, libprag.}

proc parseUriRedirection*(self: Query; uri: var string = cast[var string](nil)) =
  var uri_00: cstring
  gst_query_parse_uri_redirection(cast[ptr Query00](self.impl), uri_00)
  if uri.addr != nil:
    uri = $(uri_00)

proc parseUriRedirection*(self: Query): string  =
  var result_00: cstring
  gst_query_parse_uri_redirection(cast[ptr Query00](self.impl), result_00)
  if result.addr != nil:
    result = $(result_00)

proc gst_query_parse_uri_redirection_permanent(self: ptr Query00; permanent: var gboolean) {.
    importc, libprag.}

proc parseUriRedirectionPermanent*(self: Query; permanent: var bool = cast[var bool](nil)) =
  var permanent_00: gboolean
  gst_query_parse_uri_redirection_permanent(cast[ptr Query00](self.impl), permanent_00)
  if permanent.addr != nil:
    permanent = toBool(permanent_00)

proc parseUriRedirectionPermanent*(self: Query): bool  =
  var result_00: gboolean
  gst_query_parse_uri_redirection_permanent(cast[ptr Query00](self.impl), result_00)
  if result.addr != nil:
    result = toBool(result_00)

proc gst_query_remove_nth_allocation_meta(self: ptr Query00; index: uint32) {.
    importc, libprag.}

proc removeNthAllocationMeta*(self: Query; index: int) =
  gst_query_remove_nth_allocation_meta(cast[ptr Query00](self.impl), uint32(index))

proc gst_query_remove_nth_allocation_param(self: ptr Query00; index: uint32) {.
    importc, libprag.}

proc removeNthAllocationParam*(self: Query; index: int) =
  gst_query_remove_nth_allocation_param(cast[ptr Query00](self.impl), uint32(index))

proc gst_query_remove_nth_allocation_pool(self: ptr Query00; index: uint32) {.
    importc, libprag.}

proc removeNthAllocationPool*(self: Query; index: int) =
  gst_query_remove_nth_allocation_pool(cast[ptr Query00](self.impl), uint32(index))

proc gst_query_set_accept_caps_result(self: ptr Query00; resu: gboolean) {.
    importc, libprag.}

proc setAcceptCapsResult*(self: Query; resu: bool = true) =
  gst_query_set_accept_caps_result(cast[ptr Query00](self.impl), gboolean(resu))

proc `acceptCapsResult=`*(self: Query; resu: bool) =
  gst_query_set_accept_caps_result(cast[ptr Query00](self.impl), gboolean(resu))

proc gst_query_set_bitrate(self: ptr Query00; nominalBitrate: uint32) {.
    importc, libprag.}

proc setBitrate*(self: Query; nominalBitrate: int) =
  gst_query_set_bitrate(cast[ptr Query00](self.impl), uint32(nominalBitrate))

proc `bitrate=`*(self: Query; nominalBitrate: int) =
  gst_query_set_bitrate(cast[ptr Query00](self.impl), uint32(nominalBitrate))

proc gst_query_set_buffering_percent(self: ptr Query00; busy: gboolean; percent: int32) {.
    importc, libprag.}

proc setBufferingPercent*(self: Query; busy: bool; percent: int) =
  gst_query_set_buffering_percent(cast[ptr Query00](self.impl), gboolean(busy), int32(percent))

proc gst_query_set_caps_result(self: ptr Query00; caps: ptr Caps00) {.
    importc, libprag.}

proc setCapsResult*(self: Query; caps: Caps) =
  gst_query_set_caps_result(cast[ptr Query00](self.impl), cast[ptr Caps00](caps.impl))

proc `capsResult=`*(self: Query; caps: Caps) =
  gst_query_set_caps_result(cast[ptr Query00](self.impl), cast[ptr Caps00](caps.impl))

proc gst_query_set_latency(self: ptr Query00; live: gboolean; minLatency: uint64;
    maxLatency: uint64) {.
    importc, libprag.}

proc setLatency*(self: Query; live: bool; minLatency: uint64; maxLatency: uint64) =
  gst_query_set_latency(cast[ptr Query00](self.impl), gboolean(live), minLatency, maxLatency)

proc gst_query_set_nth_allocation_param(self: ptr Query00; index: uint32;
    allocator: ptr Allocator00; params: ptr AllocationParams00) {.
    importc, libprag.}

proc setNthAllocationParam*(self: Query; index: int; allocator: Allocator = nil;
    params: AllocationParams = nil) =
  gst_query_set_nth_allocation_param(cast[ptr Query00](self.impl), uint32(index), if allocator.isNil: nil else: cast[ptr Allocator00](allocator.impl), if params.isNil: nil else: cast[ptr AllocationParams00](params.impl))

proc gst_query_set_uri(self: ptr Query00; uri: cstring) {.
    importc, libprag.}

proc setUri*(self: Query; uri: cstring) =
  gst_query_set_uri(cast[ptr Query00](self.impl), uri)

proc `uri=`*(self: Query; uri: cstring) =
  gst_query_set_uri(cast[ptr Query00](self.impl), uri)

proc gst_query_set_uri_redirection(self: ptr Query00; uri: cstring) {.
    importc, libprag.}

proc setUriRedirection*(self: Query; uri: cstring) =
  gst_query_set_uri_redirection(cast[ptr Query00](self.impl), uri)

proc `uriRedirection=`*(self: Query; uri: cstring) =
  gst_query_set_uri_redirection(cast[ptr Query00](self.impl), uri)

proc gst_query_set_uri_redirection_permanent(self: ptr Query00; permanent: gboolean) {.
    importc, libprag.}

proc setUriRedirectionPermanent*(self: Query; permanent: bool = true) =
  gst_query_set_uri_redirection_permanent(cast[ptr Query00](self.impl), gboolean(permanent))

proc `uriRedirectionPermanent=`*(self: Query; permanent: bool) =
  gst_query_set_uri_redirection_permanent(cast[ptr Query00](self.impl), gboolean(permanent))

proc gst_query_writable_structure(self: ptr Query00): ptr Structure00 {.
    importc, libprag.}

proc writableStructure*(self: Query): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_query_writable_structure(cast[ptr Query00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_pad_peer_query(self: ptr Pad00; query: ptr Query00): gboolean {.
    importc, libprag.}

proc peerQuery*(self: Pad; query: Query): bool =
  toBool(gst_pad_peer_query(cast[ptr Pad00](self.impl), cast[ptr Query00](query.impl)))

proc gst_pad_proxy_query_accept_caps(self: ptr Pad00; query: ptr Query00): gboolean {.
    importc, libprag.}

proc proxyQueryAcceptCaps*(self: Pad; query: Query): bool =
  toBool(gst_pad_proxy_query_accept_caps(cast[ptr Pad00](self.impl), cast[ptr Query00](query.impl)))

proc gst_pad_proxy_query_caps(self: ptr Pad00; query: ptr Query00): gboolean {.
    importc, libprag.}

proc proxyQueryCaps*(self: Pad; query: Query): bool =
  toBool(gst_pad_proxy_query_caps(cast[ptr Pad00](self.impl), cast[ptr Query00](query.impl)))

proc gst_pad_query(self: ptr Pad00; query: ptr Query00): gboolean {.
    importc, libprag.}

proc query*(self: Pad; query: Query): bool =
  toBool(gst_pad_query(cast[ptr Pad00](self.impl), cast[ptr Query00](query.impl)))

proc gst_pad_query_default(self: ptr Pad00; parent: ptr Object00; query: ptr Query00): gboolean {.
    importc, libprag.}

proc queryDefault*(self: Pad; parent: Object = nil; query: Query): bool =
  toBool(gst_pad_query_default(cast[ptr Pad00](self.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl), cast[ptr Query00](query.impl)))

proc gst_element_query(self: ptr Element00; query: ptr Query00): gboolean {.
    importc, libprag.}

proc query*(self: Element; query: Query): bool =
  toBool(gst_element_query(cast[ptr Element00](self.impl), cast[ptr Query00](query.impl)))

type
  QueryType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    position = 2563
    duration = 5123
    latency = 7683
    jitter = 10243
    rate = 12803
    seeking = 15363
    segment = 17923
    convert = 20483
    formats = 23043
    buffering = 28163
    custom = 30723
    uri = 33283
    allocation = 35846
    scheduling = 38401
    acceptCaps = 40963
    caps = 43523
    drain = 46086
    context = 48643
    bitrate = 51202

proc gst_query_type_get_name(`type`: QueryType): cstring {.
    importc, libprag.}

proc getName*(`type`: QueryType): string =
  result = $gst_query_type_get_name(`type`)

proc name*(`type`: QueryType): string =
  result = $gst_query_type_get_name(`type`)

proc gst_query_type_to_quark(`type`: QueryType): uint32 {.
    importc, libprag.}

proc toQuark*(`type`: QueryType): int =
  int(gst_query_type_to_quark(`type`))

proc gst_query_new_custom(`type`: QueryType; structure: ptr Structure00): ptr Query00 {.
    importc, libprag.}

proc newQueryCustom*(`type`: QueryType; structure: Structure = nil): Query =
  let impl0 = gst_query_new_custom(`type`, if structure.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstQuery)
  result.impl = impl0

proc newQueryCustom*(tdesc: typedesc; `type`: QueryType; structure: Structure = nil): tdesc =
  assert(result is Query)
  let impl0 = gst_query_new_custom(`type`, if structure.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstQuery)
  result.impl = impl0

proc initQueryCustom*[T](result: var T; `type`: QueryType; structure: Structure = nil) {.deprecated.} =
  assert(result is Query)
  let impl0 = gst_query_new_custom(`type`, if structure.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstQuery)
  result.impl = impl0

type
  QueryTypeFlag* {.size: sizeof(cint), pure.} = enum
    upstream = 0
    downstream = 1
    serialized = 2

  QueryTypeFlags* {.size: sizeof(cint).} = set[QueryTypeFlag]

proc getFlags*(`type`: QueryType): QueryTypeFlags {.
    importc: "gst_query_type_get_flags", libprag.}

proc flags*(`type`: QueryType): QueryTypeFlags {.
    importc: "gst_query_type_get_flags", libprag.}

type
  BufferingMode* {.size: sizeof(cint), pure.} = enum
    stream = 0
    download = 1
    timeshift = 2
    live = 3

proc gst_query_parse_buffering_stats(self: ptr Query00; mode: var BufferingMode;
    avgIn: var int32; avgOut: var int32; bufferingLeft: var int64) {.
    importc, libprag.}

proc parseBufferingStats*(self: Query; mode: var BufferingMode = cast[var BufferingMode](nil);
    avgIn: var int = cast[var int](nil); avgOut: var int = cast[var int](nil);
    bufferingLeft: var int64 = cast[var int64](nil)) =
  var avgOut_00: int32
  var avgIn_00: int32
  gst_query_parse_buffering_stats(cast[ptr Query00](self.impl), mode, avgIn_00, avgOut_00, bufferingLeft)
  if avgOut.addr != nil:
    avgOut = int(avgOut_00)
  if avgIn.addr != nil:
    avgIn = int(avgIn_00)

proc gst_query_set_buffering_stats(self: ptr Query00; mode: BufferingMode;
    avgIn: int32; avgOut: int32; bufferingLeft: int64) {.
    importc, libprag.}

proc setBufferingStats*(self: Query; mode: BufferingMode; avgIn: int;
    avgOut: int; bufferingLeft: int64) =
  gst_query_set_buffering_stats(cast[ptr Query00](self.impl), mode, int32(avgIn), int32(avgOut), bufferingLeft)

type
  BufferPool* = ref object of Object
  BufferPool00* = object of Object00

proc gst_buffer_pool_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BufferPool()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_buffer_pool_new(): ptr BufferPool00 {.
    importc, libprag.}

proc newBufferPool*(): BufferPool =
  let gobj = gst_buffer_pool_new()
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

proc newBufferPool*(tdesc: typedesc): tdesc =
  assert(result is BufferPool)
  let gobj = gst_buffer_pool_new()
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

proc initBufferPool*[T](result: var T) {.deprecated.} =
  assert(result is BufferPool)
  let gobj = gst_buffer_pool_new()
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

proc gst_buffer_pool_config_add_option(config: ptr Structure00; option: cstring) {.
    importc, libprag.}

proc configAddOption*(config: Structure; option: cstring) =
  gst_buffer_pool_config_add_option(cast[ptr Structure00](config.impl), option)

proc gst_buffer_pool_config_get_allocator(config: ptr Structure00; allocator: var ptr Allocator00;
    params: var AllocationParams00): gboolean {.
    importc, libprag.}

proc configGetAllocator*(config: Structure; allocator: var Allocator = cast[var Allocator](nil);
    params: var AllocationParams00 = cast[var AllocationParams00](nil)): bool =
  var tmpoutgobjectarg: ptr Allocator00
  result = toBool(gst_buffer_pool_config_get_allocator(cast[ptr Structure00](config.impl), cast[var ptr Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params))
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gst.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_buffer_pool_config_get_option(config: ptr Structure00; index: uint32): cstring {.
    importc, libprag.}

proc configGetOption*(config: Structure; index: int): string =
  let resul0 = gst_buffer_pool_config_get_option(cast[ptr Structure00](config.impl), uint32(index))
  if resul0.isNil:
    return
  result = $resul0

proc gst_buffer_pool_config_get_params(config: ptr Structure00; caps: var ptr Caps00;
    size: var uint32; minBuffers: var uint32; maxBuffers: var uint32): gboolean {.
    importc, libprag.}

proc configGetParams*(config: Structure; caps: var Caps = cast[var Caps](nil);
    size: var int = cast[var int](nil); minBuffers: var int = cast[var int](nil);
    maxBuffers: var int = cast[var int](nil)): bool =
  if addr(caps) != nil:
    fnew(caps, gBoxedFreeGstCaps)
  var minBuffers_00: uint32
  var maxBuffers_00: uint32
  var size_00: uint32
  result = toBool(gst_buffer_pool_config_get_params(cast[ptr Structure00](config.impl), cast[var ptr Caps00](if addr(caps) == nil: nil else: addr caps.impl), size_00, minBuffers_00, maxBuffers_00))
  if minBuffers.addr != nil:
    minBuffers = int(minBuffers_00)
  if maxBuffers.addr != nil:
    maxBuffers = int(maxBuffers_00)
  if size.addr != nil:
    size = int(size_00)
  if caps != nil and caps.impl == nil:
    caps.ignoreFinalizer = true
    caps = nil

proc gst_buffer_pool_config_has_option(config: ptr Structure00; option: cstring): gboolean {.
    importc, libprag.}

proc configHasOption*(config: Structure; option: cstring): bool =
  toBool(gst_buffer_pool_config_has_option(cast[ptr Structure00](config.impl), option))

proc gst_buffer_pool_config_n_options(config: ptr Structure00): uint32 {.
    importc, libprag.}

proc configNOptions*(config: Structure): int =
  int(gst_buffer_pool_config_n_options(cast[ptr Structure00](config.impl)))

proc gst_buffer_pool_config_set_allocator(config: ptr Structure00; allocator: ptr Allocator00;
    params: ptr AllocationParams00) {.
    importc, libprag.}

proc configSetAllocator*(config: Structure; allocator: Allocator = nil;
    params: AllocationParams = nil) =
  gst_buffer_pool_config_set_allocator(cast[ptr Structure00](config.impl), if allocator.isNil: nil else: cast[ptr Allocator00](allocator.impl), if params.isNil: nil else: cast[ptr AllocationParams00](params.impl))

proc gst_buffer_pool_config_set_params(config: ptr Structure00; caps: ptr Caps00;
    size: uint32; minBuffers: uint32; maxBuffers: uint32) {.
    importc, libprag.}

proc configSetParams*(config: Structure; caps: Caps = nil;
    size: int; minBuffers: int; maxBuffers: int) =
  gst_buffer_pool_config_set_params(cast[ptr Structure00](config.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl), uint32(size), uint32(minBuffers), uint32(maxBuffers))

proc gst_buffer_pool_config_validate_params(config: ptr Structure00; caps: ptr Caps00;
    size: uint32; minBuffers: uint32; maxBuffers: uint32): gboolean {.
    importc, libprag.}

proc configValidateParams*(config: Structure; caps: Caps = nil;
    size: int; minBuffers: int; maxBuffers: int): bool =
  toBool(gst_buffer_pool_config_validate_params(cast[ptr Structure00](config.impl), if caps.isNil: nil else: cast[ptr Caps00](caps.impl), uint32(size), uint32(minBuffers), uint32(maxBuffers)))

proc gst_buffer_pool_get_config(self: ptr BufferPool00): ptr Structure00 {.
    importc, libprag.}

proc getConfig*(self: BufferPool): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_buffer_pool_get_config(cast[ptr BufferPool00](self.impl))

proc config*(self: BufferPool): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_buffer_pool_get_config(cast[ptr BufferPool00](self.impl))

proc gst_buffer_pool_get_options(self: ptr BufferPool00): ptr cstring {.
    importc, libprag.}

proc getOptions*(self: BufferPool): seq[string] =
  cstringArrayToSeq(gst_buffer_pool_get_options(cast[ptr BufferPool00](self.impl)))

proc options*(self: BufferPool): seq[string] =
  cstringArrayToSeq(gst_buffer_pool_get_options(cast[ptr BufferPool00](self.impl)))

proc gst_buffer_pool_has_option(self: ptr BufferPool00; option: cstring): gboolean {.
    importc, libprag.}

proc hasOption*(self: BufferPool; option: cstring): bool =
  toBool(gst_buffer_pool_has_option(cast[ptr BufferPool00](self.impl), option))

proc gst_buffer_pool_is_active(self: ptr BufferPool00): gboolean {.
    importc, libprag.}

proc isActive*(self: BufferPool): bool =
  toBool(gst_buffer_pool_is_active(cast[ptr BufferPool00](self.impl)))

proc gst_buffer_pool_release_buffer(self: ptr BufferPool00; buffer: ptr Buffer00) {.
    importc, libprag.}

proc releaseBuffer*(self: BufferPool; buffer: Buffer) =
  gst_buffer_pool_release_buffer(cast[ptr BufferPool00](self.impl), cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_buffer_pool_set_active(self: ptr BufferPool00; active: gboolean): gboolean {.
    importc, libprag.}

proc setActive*(self: BufferPool; active: bool = true): bool =
  toBool(gst_buffer_pool_set_active(cast[ptr BufferPool00](self.impl), gboolean(active)))

proc gst_buffer_pool_set_config(self: ptr BufferPool00; config: ptr Structure00): gboolean {.
    importc, libprag.}

proc setConfig*(self: BufferPool; config: Structure): bool =
  toBool(gst_buffer_pool_set_config(cast[ptr BufferPool00](self.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), config.impl))))

proc gst_buffer_pool_set_flushing(self: ptr BufferPool00; flushing: gboolean) {.
    importc, libprag.}

proc setFlushing*(self: BufferPool; flushing: bool = true) =
  gst_buffer_pool_set_flushing(cast[ptr BufferPool00](self.impl), gboolean(flushing))

proc `flushing=`*(self: BufferPool; flushing: bool) =
  gst_buffer_pool_set_flushing(cast[ptr BufferPool00](self.impl), gboolean(flushing))

proc gst_query_add_allocation_pool(self: ptr Query00; pool: ptr BufferPool00;
    size: uint32; minBuffers: uint32; maxBuffers: uint32) {.
    importc, libprag.}

proc addAllocationPool*(self: Query; pool: BufferPool = nil; size: int;
    minBuffers: int; maxBuffers: int) =
  gst_query_add_allocation_pool(cast[ptr Query00](self.impl), if pool.isNil: nil else: cast[ptr BufferPool00](pool.impl), uint32(size), uint32(minBuffers), uint32(maxBuffers))

proc gst_query_parse_nth_allocation_pool(self: ptr Query00; index: uint32;
    pool: var ptr BufferPool00; size: var uint32; minBuffers: var uint32; maxBuffers: var uint32) {.
    importc, libprag.}

proc parseNthAllocationPool*(self: Query; index: int; pool: var BufferPool = cast[var BufferPool](nil);
    size: var int = cast[var int](nil); minBuffers: var int = cast[var int](nil);
    maxBuffers: var int = cast[var int](nil)) =
  var tmpoutgobjectarg: ptr BufferPool00
  var minBuffers_00: uint32
  var maxBuffers_00: uint32
  var size_00: uint32
  gst_query_parse_nth_allocation_pool(cast[ptr Query00](self.impl), uint32(index), cast[var ptr BufferPool00](if addr(pool) == nil: nil else: addr tmpoutgobjectarg), size_00, minBuffers_00, maxBuffers_00)
  if minBuffers.addr != nil:
    minBuffers = int(minBuffers_00)
  if maxBuffers.addr != nil:
    maxBuffers = int(maxBuffers_00)
  if size.addr != nil:
    size = int(size_00)
#  dothemagic(pool
  if addr(pool) != nil:
    pool = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      pool = cast[type(pool)](argqdata)
      assert(pool.impl == tmpoutgobjectarg)
    else:
      fnew(pool, gst.finalizeGObject)
      pool.impl = tmpoutgobjectarg
      GC_ref(pool)
      if g_object_is_floating(pool.impl).int != 0:
        discard g_object_ref_sink(pool.impl)
      g_object_add_toggle_ref(pool.impl, toggleNotify, addr(pool[]))
      g_object_unref(pool.impl)
      assert(g_object_get_qdata(pool.impl, Quark) == nil)
      g_object_set_qdata(pool.impl, Quark, addr(pool[]))


proc gst_query_set_nth_allocation_pool(self: ptr Query00; index: uint32;
    pool: ptr BufferPool00; size: uint32; minBuffers: uint32; maxBuffers: uint32) {.
    importc, libprag.}

proc setNthAllocationPool*(self: Query; index: int; pool: BufferPool = nil;
    size: int; minBuffers: int; maxBuffers: int) =
  gst_query_set_nth_allocation_pool(cast[ptr Query00](self.impl), uint32(index), if pool.isNil: nil else: cast[ptr BufferPool00](pool.impl), uint32(size), uint32(minBuffers), uint32(maxBuffers))

type
  BufferPoolAcquireParams00* {.pure.} = object
  BufferPoolAcquireParams* = ref object
    impl*: ptr BufferPoolAcquireParams00
    ignoreFinalizer*: bool

proc gst_buffer_pool_acquire_buffer(self: ptr BufferPool00; buffer: var ptr Buffer00;
    params: ptr BufferPoolAcquireParams00): FlowReturn {.
    importc, libprag.}

proc acquireBuffer*(self: BufferPool; buffer: var Buffer;
    params: BufferPoolAcquireParams = nil): FlowReturn =
  fnew(buffer, gBoxedFreeGstBuffer)
  gst_buffer_pool_acquire_buffer(cast[ptr BufferPool00](self.impl), cast[var ptr Buffer00](addr buffer.impl), if params.isNil: nil else: cast[ptr BufferPoolAcquireParams00](params.impl))

type
  SchedulingFlag* {.size: sizeof(cint), pure.} = enum
    seekable = 0
    sequential = 1
    bandwidthLimited = 2

  SchedulingFlags* {.size: sizeof(cint).} = set[SchedulingFlag]

proc gst_query_has_scheduling_mode_with_flags(self: ptr Query00; mode: PadMode;
    flags: SchedulingFlags): gboolean {.
    importc, libprag.}

proc hasSchedulingModeWithFlags*(self: Query; mode: PadMode;
    flags: SchedulingFlags): bool =
  toBool(gst_query_has_scheduling_mode_with_flags(cast[ptr Query00](self.impl), mode, flags))

proc gst_query_parse_scheduling(self: ptr Query00; flags: var SchedulingFlags;
    minsize: var int32; maxsize: var int32; align: var int32) {.
    importc, libprag.}

proc parseScheduling*(self: Query; flags: var SchedulingFlags = cast[var SchedulingFlags](nil);
    minsize: var int = cast[var int](nil); maxsize: var int = cast[var int](nil);
    align: var int = cast[var int](nil)) =
  var align_00: int32
  var maxsize_00: int32
  var minsize_00: int32
  gst_query_parse_scheduling(cast[ptr Query00](self.impl), flags, minsize_00, maxsize_00, align_00)
  if align.addr != nil:
    align = int(align_00)
  if maxsize.addr != nil:
    maxsize = int(maxsize_00)
  if minsize.addr != nil:
    minsize = int(minsize_00)

proc gst_query_set_scheduling(self: ptr Query00; flags: SchedulingFlags;
    minsize: int32; maxsize: int32; align: int32) {.
    importc, libprag.}

proc setScheduling*(self: Query; flags: SchedulingFlags; minsize: int;
    maxsize: int; align: int) =
  gst_query_set_scheduling(cast[ptr Query00](self.impl), flags, int32(minsize), int32(maxsize), int32(align))

type
  PadTemplate* = ref object of Object
  PadTemplate00* = object of Object00

proc gst_pad_template_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PadTemplate()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scPadCreated*(self: PadTemplate;  p: proc (self: ptr PadTemplate00; pad: ptr Pad00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pad-created", cast[GCallback](p), xdata, nil, cf)

proc gst_pad_template_new_from_static_pad_template_with_gtype(padTemplate: ptr StaticPadTemplate00;
    padType: GType): ptr PadTemplate00 {.
    importc, libprag.}

proc newPadTemplateFromStaticPadTemplateWithGtype*(padTemplate: StaticPadTemplate;
    padType: GType): PadTemplate =
  let gobj = gst_pad_template_new_from_static_pad_template_with_gtype(cast[ptr StaticPadTemplate00](padTemplate.impl), padType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPadTemplateFromStaticPadTemplateWithGtype*(tdesc: typedesc; padTemplate: StaticPadTemplate;
    padType: GType): tdesc =
  assert(result is PadTemplate)
  let gobj = gst_pad_template_new_from_static_pad_template_with_gtype(cast[ptr StaticPadTemplate00](padTemplate.impl), padType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPadTemplateFromStaticPadTemplateWithGtype*[T](result: var T; padTemplate: StaticPadTemplate;
    padType: GType) {.deprecated.} =
  assert(result is PadTemplate)
  let gobj = gst_pad_template_new_from_static_pad_template_with_gtype(cast[ptr StaticPadTemplate00](padTemplate.impl), padType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_pad_template_get_caps(self: ptr PadTemplate00): ptr Caps00 {.
    importc, libprag.}

proc getCaps*(self: PadTemplate): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_template_get_caps(cast[ptr PadTemplate00](self.impl))

proc caps*(self: PadTemplate): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_template_get_caps(cast[ptr PadTemplate00](self.impl))

proc gst_pad_template_get_documentation_caps(self: ptr PadTemplate00): ptr Caps00 {.
    importc, libprag.}

proc getDocumentationCaps*(self: PadTemplate): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_template_get_documentation_caps(cast[ptr PadTemplate00](self.impl))

proc documentationCaps*(self: PadTemplate): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_pad_template_get_documentation_caps(cast[ptr PadTemplate00](self.impl))

proc gst_pad_template_pad_created(self: ptr PadTemplate00; pad: ptr Pad00) {.
    importc, libprag.}

proc padCreated*(self: PadTemplate; pad: Pad) =
  gst_pad_template_pad_created(cast[ptr PadTemplate00](self.impl), cast[ptr Pad00](pad.impl))

proc gst_pad_template_set_documentation_caps(self: ptr PadTemplate00; caps: ptr Caps00) {.
    importc, libprag.}

proc setDocumentationCaps*(self: PadTemplate; caps: Caps) =
  gst_pad_template_set_documentation_caps(cast[ptr PadTemplate00](self.impl), cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl)))

proc `documentationCaps=`*(self: PadTemplate; caps: Caps) =
  gst_pad_template_set_documentation_caps(cast[ptr PadTemplate00](self.impl), cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl)))

proc gst_pad_new_from_template(templ: ptr PadTemplate00; name: cstring): ptr Pad00 {.
    importc, libprag.}

proc newPadFromTemplate*(templ: PadTemplate; name: cstring = nil): Pad =
  let gobj = gst_pad_new_from_template(cast[ptr PadTemplate00](templ.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPadFromTemplate*(tdesc: typedesc; templ: PadTemplate; name: cstring = nil): tdesc =
  assert(result is Pad)
  let gobj = gst_pad_new_from_template(cast[ptr PadTemplate00](templ.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPadFromTemplate*[T](result: var T; templ: PadTemplate; name: cstring = nil) {.deprecated.} =
  assert(result is Pad)
  let gobj = gst_pad_new_from_template(cast[ptr PadTemplate00](templ.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_pad_get_pad_template(self: ptr Pad00): ptr PadTemplate00 {.
    importc, libprag.}

proc getPadTemplate*(self: Pad): PadTemplate =
  let gobj = gst_pad_get_pad_template(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc padTemplate*(self: Pad): PadTemplate =
  let gobj = gst_pad_get_pad_template(cast[ptr Pad00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_element_get_compatible_pad_template(self: ptr Element00; compattempl: ptr PadTemplate00): ptr PadTemplate00 {.
    importc, libprag.}

proc getCompatiblePadTemplate*(self: Element; compattempl: PadTemplate): PadTemplate =
  let gobj = gst_element_get_compatible_pad_template(cast[ptr Element00](self.impl), cast[ptr PadTemplate00](compattempl.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_element_get_pad_template(self: ptr Element00; name: cstring): ptr PadTemplate00 {.
    importc, libprag.}

proc getPadTemplate*(self: Element; name: cstring): PadTemplate =
  let gobj = gst_element_get_pad_template(cast[ptr Element00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_element_get_pad_template_list(self: ptr Element00): ptr glib.List {.
    importc, libprag.}

proc getPadTemplateList*(self: Element): seq[PadTemplate] =
  result = glistObjects2seq(PadTemplate, gst_element_get_pad_template_list(cast[ptr Element00](self.impl)), false)

proc padTemplateList*(self: Element): seq[PadTemplate] =
  result = glistObjects2seq(PadTemplate, gst_element_get_pad_template_list(cast[ptr Element00](self.impl)), false)

proc gst_element_request_pad(self: ptr Element00; templ: ptr PadTemplate00;
    name: cstring; caps: ptr Caps00): ptr Pad00 {.
    importc, libprag.}

proc requestPad*(self: Element; templ: PadTemplate; name: cstring = nil;
    caps: Caps = nil): Pad =
  let gobj = gst_element_request_pad(cast[ptr Element00](self.impl), cast[ptr PadTemplate00](templ.impl), name, if caps.isNil: nil else: cast[ptr Caps00](caps.impl))
  if gobj.isNil:
    return nil
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

proc gst_static_pad_template_get(self: ptr StaticPadTemplate00): ptr PadTemplate00 {.
    importc, libprag.}

proc getStaticPadTemplate*(self: StaticPadTemplate): PadTemplate =
  let gobj = gst_static_pad_template_get(cast[ptr StaticPadTemplate00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc staticPadTemplate*(self: StaticPadTemplate): PadTemplate =
  let gobj = gst_static_pad_template_get(cast[ptr StaticPadTemplate00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Format* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    default = 1
    bytes = 2
    time = 3
    buffers = 4
    percent = 5

proc getByNick*(nick: cstring): Format {.
    importc: "gst_format_get_by_nick", libprag.}

proc byNick*(nick: cstring): Format {.
    importc: "gst_format_get_by_nick", libprag.}

proc gst_format_get_name(format: Format): cstring {.
    importc, libprag.}

proc getName*(format: Format): string =
  let resul0 = gst_format_get_name(format)
  if resul0.isNil:
    return
  result = $resul0

proc name*(format: Format): string =
  let resul0 = gst_format_get_name(format)
  if resul0.isNil:
    return
  result = $resul0

proc registerFormat*(nick: cstring; description: cstring): Format {.
    importc: "gst_format_register", libprag.}

proc gst_format_to_quark(format: Format): uint32 {.
    importc, libprag.}

proc toQuark*(format: Format): int =
  int(gst_format_to_quark(format))

proc gst_pad_peer_query_convert(self: ptr Pad00; srcFormat: Format; srcVal: int64;
    destFormat: Format; destVal: var int64): gboolean {.
    importc, libprag.}

proc peerQueryConvert*(self: Pad; srcFormat: Format; srcVal: int64;
    destFormat: Format; destVal: var int64): bool =
  toBool(gst_pad_peer_query_convert(cast[ptr Pad00](self.impl), srcFormat, srcVal, destFormat, destVal))

proc gst_pad_peer_query_duration(self: ptr Pad00; format: Format; duration: var int64): gboolean {.
    importc, libprag.}

proc peerQueryDuration*(self: Pad; format: Format; duration: var int64 = cast[var int64](nil)): bool =
  toBool(gst_pad_peer_query_duration(cast[ptr Pad00](self.impl), format, duration))

proc gst_pad_peer_query_position(self: ptr Pad00; format: Format; cur: var int64): gboolean {.
    importc, libprag.}

proc peerQueryPosition*(self: Pad; format: Format; cur: var int64 = cast[var int64](nil)): bool =
  toBool(gst_pad_peer_query_position(cast[ptr Pad00](self.impl), format, cur))

proc gst_pad_query_convert(self: ptr Pad00; srcFormat: Format; srcVal: int64;
    destFormat: Format; destVal: var int64): gboolean {.
    importc, libprag.}

proc queryConvert*(self: Pad; srcFormat: Format; srcVal: int64; destFormat: Format;
    destVal: var int64): bool =
  toBool(gst_pad_query_convert(cast[ptr Pad00](self.impl), srcFormat, srcVal, destFormat, destVal))

proc gst_pad_query_duration(self: ptr Pad00; format: Format; duration: var int64): gboolean {.
    importc, libprag.}

proc queryDuration*(self: Pad; format: Format; duration: var int64 = cast[var int64](nil)): bool =
  toBool(gst_pad_query_duration(cast[ptr Pad00](self.impl), format, duration))

proc gst_pad_query_position(self: ptr Pad00; format: Format; cur: var int64): gboolean {.
    importc, libprag.}

proc queryPosition*(self: Pad; format: Format; cur: var int64 = cast[var int64](nil)): bool =
  toBool(gst_pad_query_position(cast[ptr Pad00](self.impl), format, cur))

proc gst_element_query_convert(self: ptr Element00; srcFormat: Format; srcVal: int64;
    destFormat: Format; destVal: var int64): gboolean {.
    importc, libprag.}

proc queryConvert*(self: Element; srcFormat: Format; srcVal: int64;
    destFormat: Format; destVal: var int64): bool =
  toBool(gst_element_query_convert(cast[ptr Element00](self.impl), srcFormat, srcVal, destFormat, destVal))

proc gst_element_query_duration(self: ptr Element00; format: Format; duration: var int64): gboolean {.
    importc, libprag.}

proc queryDuration*(self: Element; format: Format; duration: var int64 = cast[var int64](nil)): bool =
  toBool(gst_element_query_duration(cast[ptr Element00](self.impl), format, duration))

proc gst_element_query_position(self: ptr Element00; format: Format; cur: var int64): gboolean {.
    importc, libprag.}

proc queryPosition*(self: Element; format: Format; cur: var int64 = cast[var int64](nil)): bool =
  toBool(gst_element_query_position(cast[ptr Element00](self.impl), format, cur))

proc gst_segment_clip(self: ptr Segment00; format: Format; start: uint64;
    stop: uint64; clipStart: var uint64; clipStop: var uint64): gboolean {.
    importc, libprag.}

proc clip*(self: Segment; format: Format; start: uint64; stop: uint64;
    clipStart: var uint64 = cast[var uint64](nil); clipStop: var uint64 = cast[var uint64](nil)): bool =
  toBool(gst_segment_clip(cast[ptr Segment00](self.impl), format, start, stop, clipStart, clipStop))

proc gst_segment_init(self: ptr Segment00; format: Format) {.
    importc, libprag.}

proc init*(self: Segment; format: Format) =
  gst_segment_init(cast[ptr Segment00](self.impl), format)

proc gst_segment_offset_running_time(self: ptr Segment00; format: Format;
    offset: int64): gboolean {.
    importc, libprag.}

proc offsetRunningTime*(self: Segment; format: Format; offset: int64): bool =
  toBool(gst_segment_offset_running_time(cast[ptr Segment00](self.impl), format, offset))

proc gst_segment_position_from_running_time(self: ptr Segment00; format: Format;
    runningTime: uint64): uint64 {.
    importc, libprag.}

proc positionFromRunningTime*(self: Segment; format: Format;
    runningTime: uint64): uint64 =
  gst_segment_position_from_running_time(cast[ptr Segment00](self.impl), format, runningTime)

proc gst_segment_position_from_running_time_full(self: ptr Segment00; format: Format;
    runningTime: uint64; position: var uint64): int32 {.
    importc, libprag.}

proc positionFromRunningTimeFull*(self: Segment; format: Format;
    runningTime: uint64; position: var uint64): int =
  int(gst_segment_position_from_running_time_full(cast[ptr Segment00](self.impl), format, runningTime, position))

proc gst_segment_position_from_stream_time(self: ptr Segment00; format: Format;
    streamTime: uint64): uint64 {.
    importc, libprag.}

proc positionFromStreamTime*(self: Segment; format: Format;
    streamTime: uint64): uint64 =
  gst_segment_position_from_stream_time(cast[ptr Segment00](self.impl), format, streamTime)

proc gst_segment_position_from_stream_time_full(self: ptr Segment00; format: Format;
    streamTime: uint64; position: var uint64): int32 {.
    importc, libprag.}

proc positionFromStreamTimeFull*(self: Segment; format: Format;
    streamTime: uint64; position: var uint64): int =
  int(gst_segment_position_from_stream_time_full(cast[ptr Segment00](self.impl), format, streamTime, position))

proc gst_segment_set_running_time(self: ptr Segment00; format: Format; runningTime: uint64): gboolean {.
    importc, libprag.}

proc setRunningTime*(self: Segment; format: Format; runningTime: uint64): bool =
  toBool(gst_segment_set_running_time(cast[ptr Segment00](self.impl), format, runningTime))

proc gst_segment_to_position(self: ptr Segment00; format: Format; runningTime: uint64): uint64 {.
    importc, libprag.}

proc toPosition*(self: Segment; format: Format; runningTime: uint64): uint64 =
  gst_segment_to_position(cast[ptr Segment00](self.impl), format, runningTime)

proc gst_segment_to_running_time(self: ptr Segment00; format: Format; position: uint64): uint64 {.
    importc, libprag.}

proc toRunningTime*(self: Segment; format: Format; position: uint64): uint64 =
  gst_segment_to_running_time(cast[ptr Segment00](self.impl), format, position)

proc gst_segment_to_running_time_full(self: ptr Segment00; format: Format;
    position: uint64; runningTime: var uint64): int32 {.
    importc, libprag.}

proc toRunningTimeFull*(self: Segment; format: Format; position: uint64;
    runningTime: var uint64 = cast[var uint64](nil)): int =
  int(gst_segment_to_running_time_full(cast[ptr Segment00](self.impl), format, position, runningTime))

proc gst_segment_to_stream_time(self: ptr Segment00; format: Format; position: uint64): uint64 {.
    importc, libprag.}

proc toStreamTime*(self: Segment; format: Format; position: uint64): uint64 =
  gst_segment_to_stream_time(cast[ptr Segment00](self.impl), format, position)

proc gst_segment_to_stream_time_full(self: ptr Segment00; format: Format;
    position: uint64; streamTime: var uint64): int32 {.
    importc, libprag.}

proc toStreamTimeFull*(self: Segment; format: Format; position: uint64;
    streamTime: var uint64): int =
  int(gst_segment_to_stream_time_full(cast[ptr Segment00](self.impl), format, position, streamTime))

proc gst_query_new_buffering(format: Format): ptr Query00 {.
    importc, libprag.}

proc newQueryBuffering*(format: Format): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_buffering(format)

proc newQueryBuffering*(tdesc: typedesc; format: Format): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_buffering(format)

proc initQueryBuffering*[T](result: var T; format: Format) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_buffering(format)

proc gst_query_new_convert(srcFormat: Format; value: int64; destFormat: Format): ptr Query00 {.
    importc, libprag.}

proc newQueryConvert*(srcFormat: Format; value: int64; destFormat: Format): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_convert(srcFormat, value, destFormat)

proc newQueryConvert*(tdesc: typedesc; srcFormat: Format; value: int64; destFormat: Format): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_convert(srcFormat, value, destFormat)

proc initQueryConvert*[T](result: var T; srcFormat: Format; value: int64; destFormat: Format) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_convert(srcFormat, value, destFormat)

proc gst_query_new_duration(format: Format): ptr Query00 {.
    importc, libprag.}

proc newQueryDuration*(format: Format): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_duration(format)

proc newQueryDuration*(tdesc: typedesc; format: Format): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_duration(format)

proc initQueryDuration*[T](result: var T; format: Format) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_duration(format)

proc gst_query_new_position(format: Format): ptr Query00 {.
    importc, libprag.}

proc newQueryPosition*(format: Format): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_position(format)

proc newQueryPosition*(tdesc: typedesc; format: Format): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_position(format)

proc initQueryPosition*[T](result: var T; format: Format) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_position(format)

proc gst_query_new_seeking(format: Format): ptr Query00 {.
    importc, libprag.}

proc newQuerySeeking*(format: Format): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_seeking(format)

proc newQuerySeeking*(tdesc: typedesc; format: Format): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_seeking(format)

proc initQuerySeeking*[T](result: var T; format: Format) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_seeking(format)

proc gst_query_new_segment(format: Format): ptr Query00 {.
    importc, libprag.}

proc newQuerySegment*(format: Format): Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_segment(format)

proc newQuerySegment*(tdesc: typedesc; format: Format): tdesc =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_segment(format)

proc initQuerySegment*[T](result: var T; format: Format) {.deprecated.} =
  assert(result is Query)
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_query_new_segment(format)

proc gst_query_parse_buffering_range(self: ptr Query00; format: var Format;
    start: var int64; stop: var int64; estimatedTotal: var int64) {.
    importc, libprag.}

proc parseBufferingRange*(self: Query; format: var Format = cast[var Format](nil);
    start: var int64 = cast[var int64](nil); stop: var int64 = cast[var int64](nil);
    estimatedTotal: var int64 = cast[var int64](nil)) =
  gst_query_parse_buffering_range(cast[ptr Query00](self.impl), format, start, stop, estimatedTotal)

proc gst_query_parse_convert(self: ptr Query00; srcFormat: var Format; srcValue: var int64;
    destFormat: var Format; destValue: var int64) {.
    importc, libprag.}

proc parseConvert*(self: Query; srcFormat: var Format = cast[var Format](nil);
    srcValue: var int64 = cast[var int64](nil); destFormat: var Format = cast[var Format](nil);
    destValue: var int64 = cast[var int64](nil)) =
  gst_query_parse_convert(cast[ptr Query00](self.impl), srcFormat, srcValue, destFormat, destValue)

proc gst_query_parse_duration(self: ptr Query00; format: var Format; duration: var int64) {.
    importc, libprag.}

proc parseDuration*(self: Query; format: var Format = cast[var Format](nil);
    duration: var int64 = cast[var int64](nil)) =
  gst_query_parse_duration(cast[ptr Query00](self.impl), format, duration)

proc gst_query_parse_nth_format(self: ptr Query00; nth: uint32; format: var Format) {.
    importc, libprag.}

proc parseNthFormat*(self: Query; nth: int; format: var Format = cast[var Format](nil)) =
  gst_query_parse_nth_format(cast[ptr Query00](self.impl), uint32(nth), format)

proc gst_query_parse_position(self: ptr Query00; format: var Format; cur: var int64) {.
    importc, libprag.}

proc parsePosition*(self: Query; format: var Format = cast[var Format](nil);
    cur: var int64 = cast[var int64](nil)) =
  gst_query_parse_position(cast[ptr Query00](self.impl), format, cur)

proc gst_query_parse_seeking(self: ptr Query00; format: var Format; seekable: var gboolean;
    segmentStart: var int64; segmentEnd: var int64) {.
    importc, libprag.}

proc parseSeeking*(self: Query; format: var Format = cast[var Format](nil);
    seekable: var bool = cast[var bool](nil); segmentStart: var int64 = cast[var int64](nil);
    segmentEnd: var int64 = cast[var int64](nil)) =
  var seekable_00: gboolean
  gst_query_parse_seeking(cast[ptr Query00](self.impl), format, seekable_00, segmentStart, segmentEnd)
  if seekable.addr != nil:
    seekable = toBool(seekable_00)

proc gst_query_parse_segment(self: ptr Query00; rate: var cdouble; format: var Format;
    startValue: var int64; stopValue: var int64) {.
    importc, libprag.}

proc parseSegment*(self: Query; rate: var cdouble = cast[var cdouble](nil);
    format: var Format = cast[var Format](nil); startValue: var int64 = cast[var int64](nil);
    stopValue: var int64 = cast[var int64](nil)) =
  gst_query_parse_segment(cast[ptr Query00](self.impl), rate, format, startValue, stopValue)

proc gst_query_set_buffering_range(self: ptr Query00; format: Format; start: int64;
    stop: int64; estimatedTotal: int64) {.
    importc, libprag.}

proc setBufferingRange*(self: Query; format: Format; start: int64;
    stop: int64; estimatedTotal: int64) =
  gst_query_set_buffering_range(cast[ptr Query00](self.impl), format, start, stop, estimatedTotal)

proc gst_query_set_convert(self: ptr Query00; srcFormat: Format; srcValue: int64;
    destFormat: Format; destValue: int64) {.
    importc, libprag.}

proc setConvert*(self: Query; srcFormat: Format; srcValue: int64;
    destFormat: Format; destValue: int64) =
  gst_query_set_convert(cast[ptr Query00](self.impl), srcFormat, srcValue, destFormat, destValue)

proc gst_query_set_duration(self: ptr Query00; format: Format; duration: int64) {.
    importc, libprag.}

proc setDuration*(self: Query; format: Format; duration: int64) =
  gst_query_set_duration(cast[ptr Query00](self.impl), format, duration)

proc gst_query_set_formatsv(self: ptr Query00; nFormats: int32; formats: ptr Format) {.
    importc, libprag.}

proc setFormatsv*(self: Query; nFormats: int; formats: ptr Format) =
  gst_query_set_formatsv(cast[ptr Query00](self.impl), int32(nFormats), formats)

proc gst_query_set_position(self: ptr Query00; format: Format; cur: int64) {.
    importc, libprag.}

proc setPosition*(self: Query; format: Format; cur: int64) =
  gst_query_set_position(cast[ptr Query00](self.impl), format, cur)

proc gst_query_set_seeking(self: ptr Query00; format: Format; seekable: gboolean;
    segmentStart: int64; segmentEnd: int64) {.
    importc, libprag.}

proc setSeeking*(self: Query; format: Format; seekable: bool; segmentStart: int64;
    segmentEnd: int64) =
  gst_query_set_seeking(cast[ptr Query00](self.impl), format, gboolean(seekable), segmentStart, segmentEnd)

proc gst_query_set_segment(self: ptr Query00; rate: cdouble; format: Format;
    startValue: int64; stopValue: int64) {.
    importc, libprag.}

proc setSegment*(self: Query; rate: cdouble; format: Format; startValue: int64;
    stopValue: int64) =
  gst_query_set_segment(cast[ptr Query00](self.impl), rate, format, startValue, stopValue)

type
  SeekFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    flush = 1
    accurate = 2
    keyUnit = 4
    segment = 8
    skip = 16
    snapBefore = 32
    snapAfter = 64
    snapNearest = 96
    trickmodeKeyUnits = 128
    trickmodeNoAudio = 256
    trickmodeForwardPredicted = 512
    instantRateChange = 1024

const
  SeekFlagsTrickmode* = SeekFlags.skip

proc gst_element_seek_simple(self: ptr Element00; format: Format; seekFlags: SeekFlags;
    seekPos: int64): gboolean {.
    importc, libprag.}

proc seekSimple*(self: Element; format: Format; seekFlags: SeekFlags;
    seekPos: int64): bool =
  toBool(gst_element_seek_simple(cast[ptr Element00](self.impl), format, seekFlags, seekPos))

type
  SeekType* {.size: sizeof(cint), pure.} = enum
    none = 0
    set = 1
    `end` = 2

proc gst_element_seek(self: ptr Element00; rate: cdouble; format: Format;
    flags: SeekFlags; startType: SeekType; start: int64; stopType: SeekType;
    stop: int64): gboolean {.
    importc, libprag.}

proc seek*(self: Element; rate: cdouble; format: Format; flags: SeekFlags;
    startType: SeekType; start: int64; stopType: SeekType; stop: int64): bool =
  toBool(gst_element_seek(cast[ptr Element00](self.impl), rate, format, flags, startType, start, stopType, stop))

proc gst_segment_do_seek(self: ptr Segment00; rate: cdouble; format: Format;
    flags: SeekFlags; startType: SeekType; start: uint64; stopType: SeekType;
    stop: uint64; update: var gboolean): gboolean {.
    importc, libprag.}

proc doSeek*(self: Segment; rate: cdouble; format: Format; flags: SeekFlags;
    startType: SeekType; start: uint64; stopType: SeekType; stop: uint64; update: var bool = cast[var bool](nil)): bool =
  var update_00: gboolean
  result = toBool(gst_segment_do_seek(cast[ptr Segment00](self.impl), rate, format, flags, startType, start, stopType, stop, update_00))
  if update.addr != nil:
    update = toBool(update_00)

type
  FormatDefinition00* {.pure.} = object
  FormatDefinition* = ref object
    impl*: ptr FormatDefinition00
    ignoreFinalizer*: bool

proc gst_format_get_details(format: Format): ptr FormatDefinition00 {.
    importc, libprag.}

proc getDetails*(format: Format): FormatDefinition =
  let impl0 = gst_format_get_details(format)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc details*(format: Format): FormatDefinition =
  let impl0 = gst_format_get_details(format)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

type
  Event00* {.pure.} = object
  Event* = ref object
    impl*: ptr Event00
    ignoreFinalizer*: bool

proc gst_event_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstEvent*(self: Event) =
  if not self.ignoreFinalizer:
    boxedFree(gst_event_get_type(), cast[ptr Event00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Event()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_event_get_type(), cast[ptr Event00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Event) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstEvent)

proc gst_event_new_buffer_size(format: Format; minsize: int64; maxsize: int64;
    async: gboolean): ptr Event00 {.
    importc, libprag.}

proc newEventBufferSize*(format: Format; minsize: int64; maxsize: int64;
    async: bool): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_buffer_size(format, minsize, maxsize, gboolean(async))

proc newEventBufferSize*(tdesc: typedesc; format: Format; minsize: int64; maxsize: int64;
    async: bool): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_buffer_size(format, minsize, maxsize, gboolean(async))

proc initEventBufferSize*[T](result: var T; format: Format; minsize: int64; maxsize: int64;
    async: bool) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_buffer_size(format, minsize, maxsize, gboolean(async))

proc gst_event_new_caps(caps: ptr Caps00): ptr Event00 {.
    importc, libprag.}

proc newEventCaps*(caps: Caps): Event =
  let impl0 = gst_event_new_caps(cast[ptr Caps00](caps.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc newEventCaps*(tdesc: typedesc; caps: Caps): tdesc =
  assert(result is Event)
  let impl0 = gst_event_new_caps(cast[ptr Caps00](caps.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc initEventCaps*[T](result: var T; caps: Caps) {.deprecated.} =
  assert(result is Event)
  let impl0 = gst_event_new_caps(cast[ptr Caps00](caps.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc gst_event_new_custom(`type`: EventType; structure: ptr Structure00): ptr Event00 {.
    importc, libprag.}

proc newEventCustom*(`type`: EventType; structure: Structure): Event =
  let impl0 = gst_event_new_custom(`type`, cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc newEventCustom*(tdesc: typedesc; `type`: EventType; structure: Structure): tdesc =
  assert(result is Event)
  let impl0 = gst_event_new_custom(`type`, cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc initEventCustom*[T](result: var T; `type`: EventType; structure: Structure) {.deprecated.} =
  assert(result is Event)
  let impl0 = gst_event_new_custom(`type`, cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc gst_event_new_eos(): ptr Event00 {.
    importc, libprag.}

proc newEventEos*(): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_eos()

proc newEventEos*(tdesc: typedesc): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_eos()

proc initEventEos*[T](result: var T) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_eos()

proc gst_event_new_flush_start(): ptr Event00 {.
    importc, libprag.}

proc newEventFlushStart*(): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_flush_start()

proc newEventFlushStart*(tdesc: typedesc): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_flush_start()

proc initEventFlushStart*[T](result: var T) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_flush_start()

proc gst_event_new_flush_stop(resetTime: gboolean): ptr Event00 {.
    importc, libprag.}

proc newEventFlushStop*(resetTime: bool): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_flush_stop(gboolean(resetTime))

proc newEventFlushStop*(tdesc: typedesc; resetTime: bool): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_flush_stop(gboolean(resetTime))

proc initEventFlushStop*[T](result: var T; resetTime: bool) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_flush_stop(gboolean(resetTime))

proc gst_event_new_gap(timestamp: uint64; duration: uint64): ptr Event00 {.
    importc, libprag.}

proc newEventGap*(timestamp: uint64; duration: uint64): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_gap(timestamp, duration)

proc newEventGap*(tdesc: typedesc; timestamp: uint64; duration: uint64): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_gap(timestamp, duration)

proc initEventGap*[T](result: var T; timestamp: uint64; duration: uint64) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_gap(timestamp, duration)

proc gst_event_new_instant_rate_sync_time(rateMultiplier: cdouble; runningTime: uint64;
    upstreamRunningTime: uint64): ptr Event00 {.
    importc, libprag.}

proc newEventInstantRateSyncTime*(rateMultiplier: cdouble; runningTime: uint64;
    upstreamRunningTime: uint64): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_instant_rate_sync_time(rateMultiplier, runningTime, upstreamRunningTime)

proc newEventInstantRateSyncTime*(tdesc: typedesc; rateMultiplier: cdouble; runningTime: uint64;
    upstreamRunningTime: uint64): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_instant_rate_sync_time(rateMultiplier, runningTime, upstreamRunningTime)

proc initEventInstantRateSyncTime*[T](result: var T; rateMultiplier: cdouble; runningTime: uint64;
    upstreamRunningTime: uint64) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_instant_rate_sync_time(rateMultiplier, runningTime, upstreamRunningTime)

proc gst_event_new_latency(latency: uint64): ptr Event00 {.
    importc, libprag.}

proc newEventLatency*(latency: uint64): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_latency(latency)

proc newEventLatency*(tdesc: typedesc; latency: uint64): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_latency(latency)

proc initEventLatency*[T](result: var T; latency: uint64) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_latency(latency)

proc gst_event_new_navigation(structure: ptr Structure00): ptr Event00 {.
    importc, libprag.}

proc newEventNavigation*(structure: Structure): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_navigation(cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))

proc newEventNavigation*(tdesc: typedesc; structure: Structure): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_navigation(cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))

proc initEventNavigation*[T](result: var T; structure: Structure) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_navigation(cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))

proc gst_event_new_protection(systemId: cstring; data: ptr Buffer00; origin: cstring): ptr Event00 {.
    importc, libprag.}

proc newEventProtection*(systemId: cstring; data: Buffer; origin: cstring): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_protection(systemId, cast[ptr Buffer00](data.impl), origin)

proc newEventProtection*(tdesc: typedesc; systemId: cstring; data: Buffer; origin: cstring): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_protection(systemId, cast[ptr Buffer00](data.impl), origin)

proc initEventProtection*[T](result: var T; systemId: cstring; data: Buffer; origin: cstring) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_protection(systemId, cast[ptr Buffer00](data.impl), origin)

proc gst_event_new_reconfigure(): ptr Event00 {.
    importc, libprag.}

proc newEventReconfigure*(): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_reconfigure()

proc newEventReconfigure*(tdesc: typedesc): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_reconfigure()

proc initEventReconfigure*[T](result: var T) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_reconfigure()

proc gst_event_new_seek(rate: cdouble; format: Format; flags: SeekFlags;
    startType: SeekType; start: int64; stopType: SeekType; stop: int64): ptr Event00 {.
    importc, libprag.}

proc newEventSeek*(rate: cdouble; format: Format; flags: SeekFlags;
    startType: SeekType; start: int64; stopType: SeekType; stop: int64): Event =
  let impl0 = gst_event_new_seek(rate, format, flags, startType, start, stopType, stop)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc newEventSeek*(tdesc: typedesc; rate: cdouble; format: Format; flags: SeekFlags;
    startType: SeekType; start: int64; stopType: SeekType; stop: int64): tdesc =
  assert(result is Event)
  let impl0 = gst_event_new_seek(rate, format, flags, startType, start, stopType, stop)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc initEventSeek*[T](result: var T; rate: cdouble; format: Format; flags: SeekFlags;
    startType: SeekType; start: int64; stopType: SeekType; stop: int64) {.deprecated.} =
  assert(result is Event)
  let impl0 = gst_event_new_seek(rate, format, flags, startType, start, stopType, stop)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc gst_event_new_segment(segment: ptr Segment00): ptr Event00 {.
    importc, libprag.}

proc newEventSegment*(segment: Segment): Event =
  let impl0 = gst_event_new_segment(cast[ptr Segment00](segment.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc newEventSegment*(tdesc: typedesc; segment: Segment): tdesc =
  assert(result is Event)
  let impl0 = gst_event_new_segment(cast[ptr Segment00](segment.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc initEventSegment*[T](result: var T; segment: Segment) {.deprecated.} =
  assert(result is Event)
  let impl0 = gst_event_new_segment(cast[ptr Segment00](segment.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc gst_event_new_segment_done(format: Format; position: int64): ptr Event00 {.
    importc, libprag.}

proc newEventSegmentDone*(format: Format; position: int64): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_segment_done(format, position)

proc newEventSegmentDone*(tdesc: typedesc; format: Format; position: int64): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_segment_done(format, position)

proc initEventSegmentDone*[T](result: var T; format: Format; position: int64) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_segment_done(format, position)

proc gst_event_new_select_streams(streams: ptr glib.List): ptr Event00 {.
    importc, libprag.}

proc newEventSelectStreams*(streams: seq[cstring]): Event =
  var tempResGL = seq2GList(streams)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_select_streams(tempResGL)

proc newEventSelectStreams*(tdesc: typedesc; streams: seq[cstring]): tdesc =
  var tempResGL = seq2GList(streams)
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_select_streams(tempResGL)

proc initEventSelectStreams*[T](result: var T; streams: seq[cstring]) {.deprecated.} =
  var tempResGL = seq2GList(streams)
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_select_streams(tempResGL)

proc gst_event_new_step(format: Format; amount: uint64; rate: cdouble; flush: gboolean;
    intermediate: gboolean): ptr Event00 {.
    importc, libprag.}

proc newEventStep*(format: Format; amount: uint64; rate: cdouble; flush: bool;
    intermediate: bool): Event =
  let impl0 = gst_event_new_step(format, amount, rate, gboolean(flush), gboolean(intermediate))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc newEventStep*(tdesc: typedesc; format: Format; amount: uint64; rate: cdouble; flush: bool;
    intermediate: bool): tdesc =
  assert(result is Event)
  let impl0 = gst_event_new_step(format, amount, rate, gboolean(flush), gboolean(intermediate))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc initEventStep*[T](result: var T; format: Format; amount: uint64; rate: cdouble; flush: bool;
    intermediate: bool) {.deprecated.} =
  assert(result is Event)
  let impl0 = gst_event_new_step(format, amount, rate, gboolean(flush), gboolean(intermediate))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc gst_event_new_stream_group_done(groupId: uint32): ptr Event00 {.
    importc, libprag.}

proc newEventStreamGroupDone*(groupId: int): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_group_done(uint32(groupId))

proc newEventStreamGroupDone*(tdesc: typedesc; groupId: int): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_group_done(uint32(groupId))

proc initEventStreamGroupDone*[T](result: var T; groupId: int) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_group_done(uint32(groupId))

proc gst_event_new_stream_start(streamId: cstring): ptr Event00 {.
    importc, libprag.}

proc newEventStreamStart*(streamId: cstring): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_start(streamId)

proc newEventStreamStart*(tdesc: typedesc; streamId: cstring): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_start(streamId)

proc initEventStreamStart*[T](result: var T; streamId: cstring) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_start(streamId)

proc gst_event_new_tag(taglist: ptr TagList00): ptr Event00 {.
    importc, libprag.}

proc newEventTag*(taglist: TagList): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_tag(cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), taglist.impl)))

proc newEventTag*(tdesc: typedesc; taglist: TagList): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_tag(cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), taglist.impl)))

proc initEventTag*[T](result: var T; taglist: TagList) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_tag(cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), taglist.impl)))

proc gst_event_new_toc_select(uid: cstring): ptr Event00 {.
    importc, libprag.}

proc newEventTocSelect*(uid: cstring): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_toc_select(uid)

proc newEventTocSelect*(tdesc: typedesc; uid: cstring): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_toc_select(uid)

proc initEventTocSelect*[T](result: var T; uid: cstring) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_toc_select(uid)

proc gst_event_copy_segment(self: ptr Event00; segment: ptr Segment00) {.
    importc, libprag.}

proc copySegment*(self: Event; segment: Segment) =
  gst_event_copy_segment(cast[ptr Event00](self.impl), cast[ptr Segment00](segment.impl))

proc gst_event_get_running_time_offset(self: ptr Event00): int64 {.
    importc, libprag.}

proc getRunningTimeOffset*(self: Event): int64 =
  gst_event_get_running_time_offset(cast[ptr Event00](self.impl))

proc runningTimeOffset*(self: Event): int64 =
  gst_event_get_running_time_offset(cast[ptr Event00](self.impl))

proc gst_event_get_seqnum(self: ptr Event00): uint32 {.
    importc, libprag.}

proc getSeqnum*(self: Event): int =
  int(gst_event_get_seqnum(cast[ptr Event00](self.impl)))

proc seqnum*(self: Event): int =
  int(gst_event_get_seqnum(cast[ptr Event00](self.impl)))

proc gst_event_get_structure(self: ptr Event00): ptr Structure00 {.
    importc, libprag.}

proc getStructure*(self: Event): Structure =
  let impl0 = gst_event_get_structure(cast[ptr Event00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc structure*(self: Event): Structure =
  let impl0 = gst_event_get_structure(cast[ptr Event00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc gst_event_has_name(self: ptr Event00; name: cstring): gboolean {.
    importc, libprag.}

proc hasName*(self: Event; name: cstring): bool =
  toBool(gst_event_has_name(cast[ptr Event00](self.impl), name))

proc gst_event_has_name_id(self: ptr Event00; name: uint32): gboolean {.
    importc, libprag.}

proc hasNameId*(self: Event; name: int): bool =
  toBool(gst_event_has_name_id(cast[ptr Event00](self.impl), uint32(name)))

proc gst_event_parse_buffer_size(self: ptr Event00; format: var Format; minsize: var int64;
    maxsize: var int64; async: var gboolean) {.
    importc, libprag.}

proc parseBufferSize*(self: Event; format: var Format; minsize: var int64;
    maxsize: var int64; async: var bool) =
  var async_00: gboolean
  gst_event_parse_buffer_size(cast[ptr Event00](self.impl), format, minsize, maxsize, async_00)
  if async.addr != nil:
    async = toBool(async_00)

proc gst_event_parse_caps(self: ptr Event00; caps: var ptr Caps00) {.
    importc, libprag.}

proc parseCaps*(self: Event; caps: var Caps) =
  fnew(caps, gBoxedFreeGstCaps)
  gst_event_parse_caps(cast[ptr Event00](self.impl), cast[var ptr Caps00](addr caps.impl))
  caps.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl))

proc parseCaps*(self: Event): Caps =
  fnew(result, gBoxedFreeGstCaps)
  gst_event_parse_caps(cast[ptr Event00](self.impl), cast[var ptr Caps00](addr result.impl))
  result.impl = cast[ptr Caps00](g_boxed_copy(gst_caps_get_type(), result.impl))

proc gst_event_parse_flush_stop(self: ptr Event00; resetTime: var gboolean) {.
    importc, libprag.}

proc parseFlushStop*(self: Event; resetTime: var bool) =
  var resetTime_00: gboolean
  gst_event_parse_flush_stop(cast[ptr Event00](self.impl), resetTime_00)
  if resetTime.addr != nil:
    resetTime = toBool(resetTime_00)

proc parseFlushStop*(self: Event): bool =
  var result_00: gboolean
  gst_event_parse_flush_stop(cast[ptr Event00](self.impl), result_00)
  if result.addr != nil:
    result = toBool(result_00)

proc gst_event_parse_gap(self: ptr Event00; timestamp: var uint64; duration: var uint64) {.
    importc, libprag.}

proc parseGap*(self: Event; timestamp: var uint64 = cast[var uint64](nil);
    duration: var uint64 = cast[var uint64](nil)) =
  gst_event_parse_gap(cast[ptr Event00](self.impl), timestamp, duration)

proc gst_event_parse_group_id(self: ptr Event00; groupId: var uint32): gboolean {.
    importc, libprag.}

proc parseGroupId*(self: Event; groupId: var int): bool =
  var groupId_00: uint32
  result = toBool(gst_event_parse_group_id(cast[ptr Event00](self.impl), groupId_00))
  if groupId.addr != nil:
    groupId = int(groupId_00)

proc gst_event_parse_instant_rate_sync_time(self: ptr Event00; rateMultiplier: var cdouble;
    runningTime: var uint64; upstreamRunningTime: var uint64) {.
    importc, libprag.}

proc parseInstantRateSyncTime*(self: Event; rateMultiplier: var cdouble = cast[var cdouble](nil);
    runningTime: var uint64 = cast[var uint64](nil); upstreamRunningTime: var uint64 = cast[var uint64](nil)) =
  gst_event_parse_instant_rate_sync_time(cast[ptr Event00](self.impl), rateMultiplier, runningTime, upstreamRunningTime)

proc gst_event_parse_latency(self: ptr Event00; latency: var uint64) {.
    importc, libprag.}

proc parseLatency*(self: Event; latency: var uint64) =
  gst_event_parse_latency(cast[ptr Event00](self.impl), latency)

proc parseLatency*(self: Event): uint64 =
  gst_event_parse_latency(cast[ptr Event00](self.impl), result)

proc gst_event_parse_protection(self: ptr Event00; systemId: var cstring;
    data: var ptr Buffer00; origin: var cstring) {.
    importc, libprag.}

proc parseProtection*(self: Event; systemId: var string = cast[var string](nil);
    data: var Buffer = cast[var Buffer](nil); origin: var string = cast[var string](nil)) =
  if addr(data) != nil:
    fnew(data, gBoxedFreeGstBuffer)
  var origin_00: cstring
  var systemId_00: cstring
  gst_event_parse_protection(cast[ptr Event00](self.impl), systemId_00, cast[var ptr Buffer00](if addr(data) == nil: nil else: addr data.impl), origin_00)
  data.impl = cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), data.impl))
  if origin.addr != nil:
    origin = $(origin_00)
  if systemId.addr != nil:
    systemId = $(systemId_00)

proc gst_event_parse_seek(self: ptr Event00; rate: var cdouble; format: var Format;
    flags: var SeekFlags; startType: var SeekType; start: var int64; stopType: var SeekType;
    stop: var int64) {.
    importc, libprag.}

proc parseSeek*(self: Event; rate: var cdouble; format: var Format;
    flags: var SeekFlags; startType: var SeekType; start: var int64; stopType: var SeekType;
    stop: var int64) =
  gst_event_parse_seek(cast[ptr Event00](self.impl), rate, format, flags, startType, start, stopType, stop)

proc gst_event_parse_seek_trickmode_interval(self: ptr Event00; interval: var uint64) {.
    importc, libprag.}

proc parseSeekTrickmodeInterval*(self: Event; interval: var uint64) =
  gst_event_parse_seek_trickmode_interval(cast[ptr Event00](self.impl), interval)

proc parseSeekTrickmodeInterval*(self: Event): uint64 =
  gst_event_parse_seek_trickmode_interval(cast[ptr Event00](self.impl), result)

proc gst_event_parse_segment(self: ptr Event00; segment: var ptr Segment00) {.
    importc, libprag.}

proc parseSegment*(self: Event; segment: var Segment) =
  fnew(segment, gBoxedFreeGstSegment)
  gst_event_parse_segment(cast[ptr Event00](self.impl), cast[var ptr Segment00](addr segment.impl))
  segment.impl = cast[ptr Segment00](g_boxed_copy(gst_segment_get_type(), segment.impl))

proc parseSegment*(self: Event): Segment =
  fnew(result, gBoxedFreeGstSegment)
  gst_event_parse_segment(cast[ptr Event00](self.impl), cast[var ptr Segment00](addr result.impl))
  result.impl = cast[ptr Segment00](g_boxed_copy(gst_segment_get_type(), result.impl))

proc gst_event_parse_segment_done(self: ptr Event00; format: var Format;
    position: var int64) {.
    importc, libprag.}

proc parseSegmentDone*(self: Event; format: var Format = cast[var Format](nil);
    position: var int64 = cast[var int64](nil)) =
  gst_event_parse_segment_done(cast[ptr Event00](self.impl), format, position)

proc gst_event_parse_select_streams(self: ptr Event00; streams: var ptr glib.List) {.
    importc, libprag.}

proc parseSelectStreams*(self: Event; streams: var seq[cstring]) =
  var tempResGL = seq2GList(streams)
  gst_event_parse_select_streams(cast[ptr Event00](self.impl), tempResGL)

proc parseSelectStreams*(self: Event): seq[cstring] =
  var tempResGL = seq2GList(result)
  gst_event_parse_select_streams(cast[ptr Event00](self.impl), tempResGL)

proc gst_event_parse_step(self: ptr Event00; format: var Format; amount: var uint64;
    rate: var cdouble; flush: var gboolean; intermediate: var gboolean) {.
    importc, libprag.}

proc parseStep*(self: Event; format: var Format = cast[var Format](nil);
    amount: var uint64 = cast[var uint64](nil); rate: var cdouble = cast[var cdouble](nil);
    flush: var bool = cast[var bool](nil); intermediate: var bool = cast[var bool](nil)) =
  var intermediate_00: gboolean
  var flush_00: gboolean
  gst_event_parse_step(cast[ptr Event00](self.impl), format, amount, rate, flush_00, intermediate_00)
  if intermediate.addr != nil:
    intermediate = toBool(intermediate_00)
  if flush.addr != nil:
    flush = toBool(flush_00)

proc gst_event_parse_stream(self: ptr Event00; stream: var ptr Stream00) {.
    importc, libprag.}

proc parseStream*(self: Event; stream: var Stream) =
  var tmpoutgobjectarg: ptr Stream00
  gst_event_parse_stream(cast[ptr Event00](self.impl), tmpoutgobjectarg)
#  dothemagic(stream
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    stream = cast[type(stream)](argqdata)
    assert(stream.impl == tmpoutgobjectarg)
  else:
    fnew(stream, gst.finalizeGObject)
    stream.impl = tmpoutgobjectarg
    GC_ref(stream)
    if g_object_is_floating(stream.impl).int != 0:
      discard g_object_ref_sink(stream.impl)
    g_object_add_toggle_ref(stream.impl, toggleNotify, addr(stream[]))
    g_object_unref(stream.impl)
    assert(g_object_get_qdata(stream.impl, Quark) == nil)
    g_object_set_qdata(stream.impl, Quark, addr(stream[]))


proc parseStream*(self: Event): Stream =
  var tmpoutgobjectarg: ptr Stream00
  gst_event_parse_stream(cast[ptr Event00](self.impl), tmpoutgobjectarg)
#  dothemagic(result
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    result = cast[type(result)](argqdata)
    assert(result.impl == tmpoutgobjectarg)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = tmpoutgobjectarg
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))


proc gst_event_parse_stream_flags(self: ptr Event00; flags: var StreamFlags) {.
    importc, libprag.}

proc parseStreamFlags*(self: Event; flags: var StreamFlags) =
  gst_event_parse_stream_flags(cast[ptr Event00](self.impl), flags)

proc parseStreamFlags*(self: Event): StreamFlags =
  gst_event_parse_stream_flags(cast[ptr Event00](self.impl), result)

proc gst_event_parse_stream_group_done(self: ptr Event00; groupId: var uint32) {.
    importc, libprag.}

proc parseStreamGroupDone*(self: Event; groupId: var int) =
  var groupId_00: uint32
  gst_event_parse_stream_group_done(cast[ptr Event00](self.impl), groupId_00)
  if groupId.addr != nil:
    groupId = int(groupId_00)

proc parseStreamGroupDone*(self: Event): int =
  var result_00: uint32
  gst_event_parse_stream_group_done(cast[ptr Event00](self.impl), result_00)
  if result.addr != nil:
    result = int(result_00)

proc gst_event_parse_stream_start(self: ptr Event00; streamId: var cstring) {.
    importc, libprag.}

proc parseStreamStart*(self: Event; streamId: var string) =
  var streamId_00: cstring
  gst_event_parse_stream_start(cast[ptr Event00](self.impl), streamId_00)
  if streamId.addr != nil:
    streamId = $(streamId_00)

proc parseStreamStart*(self: Event): string =
  var result_00: cstring
  gst_event_parse_stream_start(cast[ptr Event00](self.impl), result_00)
  if result.addr != nil:
    result = $(result_00)

proc gst_event_parse_tag(self: ptr Event00; taglist: var ptr TagList00) {.
    importc, libprag.}

proc parseTag*(self: Event; taglist: var TagList) =
  fnew(taglist, gBoxedFreeGstTagList)
  gst_event_parse_tag(cast[ptr Event00](self.impl), cast[var ptr TagList00](addr taglist.impl))
  taglist.impl = cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), taglist.impl))

proc parseTag*(self: Event): TagList =
  fnew(result, gBoxedFreeGstTagList)
  gst_event_parse_tag(cast[ptr Event00](self.impl), cast[var ptr TagList00](addr result.impl))
  result.impl = cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc gst_event_parse_toc_select(self: ptr Event00; uid: var cstring) {.
    importc, libprag.}

proc parseTocSelect*(self: Event; uid: var string = cast[var string](nil)) =
  var uid_00: cstring
  gst_event_parse_toc_select(cast[ptr Event00](self.impl), uid_00)
  if uid.addr != nil:
    uid = $(uid_00)

proc parseTocSelect*(self: Event): string  =
  var result_00: cstring
  gst_event_parse_toc_select(cast[ptr Event00](self.impl), result_00)
  if result.addr != nil:
    result = $(result_00)

proc gst_event_set_group_id(self: ptr Event00; groupId: uint32) {.
    importc, libprag.}

proc setGroupId*(self: Event; groupId: int) =
  gst_event_set_group_id(cast[ptr Event00](self.impl), uint32(groupId))

proc `groupId=`*(self: Event; groupId: int) =
  gst_event_set_group_id(cast[ptr Event00](self.impl), uint32(groupId))

proc gst_event_set_running_time_offset(self: ptr Event00; offset: int64) {.
    importc, libprag.}

proc setRunningTimeOffset*(self: Event; offset: int64) =
  gst_event_set_running_time_offset(cast[ptr Event00](self.impl), offset)

proc `runningTimeOffset=`*(self: Event; offset: int64) =
  gst_event_set_running_time_offset(cast[ptr Event00](self.impl), offset)

proc gst_event_set_seek_trickmode_interval(self: ptr Event00; interval: uint64) {.
    importc, libprag.}

proc setSeekTrickmodeInterval*(self: Event; interval: uint64) =
  gst_event_set_seek_trickmode_interval(cast[ptr Event00](self.impl), interval)

proc `seekTrickmodeInterval=`*(self: Event; interval: uint64) =
  gst_event_set_seek_trickmode_interval(cast[ptr Event00](self.impl), interval)

proc gst_event_set_seqnum(self: ptr Event00; seqnum: uint32) {.
    importc, libprag.}

proc setSeqnum*(self: Event; seqnum: int) =
  gst_event_set_seqnum(cast[ptr Event00](self.impl), uint32(seqnum))

proc `seqnum=`*(self: Event; seqnum: int) =
  gst_event_set_seqnum(cast[ptr Event00](self.impl), uint32(seqnum))

proc gst_event_set_stream(self: ptr Event00; stream: ptr Stream00) {.
    importc, libprag.}

proc setStream*(self: Event; stream: Stream) =
  gst_event_set_stream(cast[ptr Event00](self.impl), cast[ptr Stream00](stream.impl))

proc `stream=`*(self: Event; stream: Stream) =
  gst_event_set_stream(cast[ptr Event00](self.impl), cast[ptr Stream00](stream.impl))

proc gst_event_set_stream_flags(self: ptr Event00; flags: StreamFlags) {.
    importc, libprag.}

proc setStreamFlags*(self: Event; flags: StreamFlags) =
  gst_event_set_stream_flags(cast[ptr Event00](self.impl), flags)

proc `streamFlags=`*(self: Event; flags: StreamFlags) =
  gst_event_set_stream_flags(cast[ptr Event00](self.impl), flags)

proc gst_event_writable_structure(self: ptr Event00): ptr Structure00 {.
    importc, libprag.}

proc writableStructure*(self: Event): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_event_writable_structure(cast[ptr Event00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_pad_event_default(self: ptr Pad00; parent: ptr Object00; event: ptr Event00): gboolean {.
    importc, libprag.}

proc eventDefault*(self: Pad; parent: Object = nil; event: Event): bool =
  toBool(gst_pad_event_default(cast[ptr Pad00](self.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl), cast[ptr Event00](g_boxed_copy(gst_event_get_type(), event.impl))))

proc gst_pad_get_sticky_event(self: ptr Pad00; eventType: EventType; idx: uint32): ptr Event00 {.
    importc, libprag.}

proc getStickyEvent*(self: Pad; eventType: EventType; idx: int): Event =
  let impl0 = gst_pad_get_sticky_event(cast[ptr Pad00](self.impl), eventType, uint32(idx))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc gst_pad_push_event(self: ptr Pad00; event: ptr Event00): gboolean {.
    importc, libprag.}

proc pushEvent*(self: Pad; event: Event): bool =
  toBool(gst_pad_push_event(cast[ptr Pad00](self.impl), cast[ptr Event00](g_boxed_copy(gst_event_get_type(), event.impl))))

proc gst_pad_send_event(self: ptr Pad00; event: ptr Event00): gboolean {.
    importc, libprag.}

proc sendEvent*(self: Pad; event: Event): bool =
  toBool(gst_pad_send_event(cast[ptr Pad00](self.impl), cast[ptr Event00](g_boxed_copy(gst_event_get_type(), event.impl))))

proc gst_pad_store_sticky_event(self: ptr Pad00; event: ptr Event00): FlowReturn {.
    importc, libprag.}

proc storeStickyEvent*(self: Pad; event: Event): FlowReturn =
  gst_pad_store_sticky_event(cast[ptr Pad00](self.impl), cast[ptr Event00](event.impl))

proc gst_element_send_event(self: ptr Element00; event: ptr Event00): gboolean {.
    importc, libprag.}

proc sendEvent*(self: Element; event: Event): bool =
  toBool(gst_element_send_event(cast[ptr Element00](self.impl), cast[ptr Event00](g_boxed_copy(gst_event_get_type(), event.impl))))

type
  SegmentFlag* {.size: sizeof(cint), pure.} = enum
    reset = 0
    segment = 3
    skip = 4
    trickmodeKeyUnits = 7
    trickmodeNoAudio = 8
    trickmodeForwardPredicted = 9

  SegmentFlags* {.size: sizeof(cint).} = set[SegmentFlag]

const
  SegmentTrickmode* = SegmentFlag.skip
  SegmentFlagsNone* = SegmentFlags({})
proc none*(t: typedesc[SegmentFlags]): SegmentFlags = SegmentFlags({})

proc gst_event_new_instant_rate_change(rateMultiplier: cdouble; newFlags: SegmentFlags): ptr Event00 {.
    importc, libprag.}

proc newEventInstantRateChange*(rateMultiplier: cdouble; newFlags: SegmentFlags): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_instant_rate_change(rateMultiplier, newFlags)

proc newEventInstantRateChange*(tdesc: typedesc; rateMultiplier: cdouble; newFlags: SegmentFlags): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_instant_rate_change(rateMultiplier, newFlags)

proc initEventInstantRateChange*[T](result: var T; rateMultiplier: cdouble; newFlags: SegmentFlags) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_instant_rate_change(rateMultiplier, newFlags)

proc gst_event_parse_instant_rate_change(self: ptr Event00; rateMultiplier: var cdouble;
    newFlags: var SegmentFlags) {.
    importc, libprag.}

proc parseInstantRateChange*(self: Event; rateMultiplier: var cdouble = cast[var cdouble](nil);
    newFlags: var SegmentFlags = cast[var SegmentFlags](nil)) =
  gst_event_parse_instant_rate_change(cast[ptr Event00](self.impl), rateMultiplier, newFlags)

type
  QOSType* {.size: sizeof(cint), pure.} = enum
    overflow = 0
    underflow = 1
    throttle = 2

proc gst_event_new_qos(`type`: QOSType; proportion: cdouble; diff: int64;
    timestamp: uint64): ptr Event00 {.
    importc, libprag.}

proc newEventQos*(`type`: QOSType; proportion: cdouble; diff: int64;
    timestamp: uint64): Event =
  let impl0 = gst_event_new_qos(`type`, proportion, diff, timestamp)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc newEventQos*(tdesc: typedesc; `type`: QOSType; proportion: cdouble; diff: int64;
    timestamp: uint64): tdesc =
  assert(result is Event)
  let impl0 = gst_event_new_qos(`type`, proportion, diff, timestamp)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc initEventQos*[T](result: var T; `type`: QOSType; proportion: cdouble; diff: int64;
    timestamp: uint64) {.deprecated.} =
  assert(result is Event)
  let impl0 = gst_event_new_qos(`type`, proportion, diff, timestamp)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = impl0

proc gst_event_parse_qos(self: ptr Event00; `type`: var QOSType; proportion: var cdouble;
    diff: var int64; timestamp: var uint64) {.
    importc, libprag.}

proc parseQos*(self: Event; `type`: var QOSType; proportion: var cdouble;
    diff: var int64; timestamp: var uint64) =
  gst_event_parse_qos(cast[ptr Event00](self.impl), `type`, proportion, diff, timestamp)

type
  StreamCollection* = ref object of Object
  StreamCollection00* = object of Object00

proc gst_stream_collection_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StreamCollection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scStreamNotify*(self: StreamCollection;  p: proc (self: ptr StreamCollection00; `object`: ptr Stream00; p0: ptr gobject.ParamSpec00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "stream-notify", cast[GCallback](p), xdata, nil, cf)

proc gst_stream_collection_new(upstreamId: cstring): ptr StreamCollection00 {.
    importc, libprag.}

proc newStreamCollection*(upstreamId: cstring = nil): StreamCollection =
  let gobj = gst_stream_collection_new(upstreamId)
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

proc newStreamCollection*(tdesc: typedesc; upstreamId: cstring = nil): tdesc =
  assert(result is StreamCollection)
  let gobj = gst_stream_collection_new(upstreamId)
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

proc initStreamCollection*[T](result: var T; upstreamId: cstring = nil) {.deprecated.} =
  assert(result is StreamCollection)
  let gobj = gst_stream_collection_new(upstreamId)
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

proc gst_stream_collection_add_stream(self: ptr StreamCollection00; stream: ptr Stream00): gboolean {.
    importc, libprag.}

proc addStream*(self: StreamCollection; stream: Stream): bool =
  toBool(gst_stream_collection_add_stream(cast[ptr StreamCollection00](self.impl), cast[ptr Stream00](g_object_ref(stream.impl))))

proc gst_stream_collection_get_size(self: ptr StreamCollection00): uint32 {.
    importc, libprag.}

proc getSizeStreamCollection*(self: StreamCollection): int =
  int(gst_stream_collection_get_size(cast[ptr StreamCollection00](self.impl)))

proc sizeStreamCollection*(self: StreamCollection): int =
  int(gst_stream_collection_get_size(cast[ptr StreamCollection00](self.impl)))

proc gst_stream_collection_get_stream(self: ptr StreamCollection00; index: uint32): ptr Stream00 {.
    importc, libprag.}

proc getStream*(self: StreamCollection; index: int): Stream =
  let gobj = gst_stream_collection_get_stream(cast[ptr StreamCollection00](self.impl), uint32(index))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_stream_collection_get_upstream_id(self: ptr StreamCollection00): cstring {.
    importc, libprag.}

proc getUpstreamId*(self: StreamCollection): string =
  let resul0 = gst_stream_collection_get_upstream_id(cast[ptr StreamCollection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc upstreamId*(self: StreamCollection): string =
  let resul0 = gst_stream_collection_get_upstream_id(cast[ptr StreamCollection00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_event_new_stream_collection(collection: ptr StreamCollection00): ptr Event00 {.
    importc, libprag.}

proc newEventStreamCollection*(collection: StreamCollection): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_collection(cast[ptr StreamCollection00](collection.impl))

proc newEventStreamCollection*(tdesc: typedesc; collection: StreamCollection): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_collection(cast[ptr StreamCollection00](collection.impl))

proc initEventStreamCollection*[T](result: var T; collection: StreamCollection) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_stream_collection(cast[ptr StreamCollection00](collection.impl))

proc gst_event_parse_stream_collection(self: ptr Event00; collection: var ptr StreamCollection00) {.
    importc, libprag.}

proc parseStreamCollection*(self: Event; collection: var StreamCollection) =
  var tmpoutgobjectarg: ptr StreamCollection00
  gst_event_parse_stream_collection(cast[ptr Event00](self.impl), tmpoutgobjectarg)
#  dothemagic(collection
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    collection = cast[type(collection)](argqdata)
    assert(collection.impl == tmpoutgobjectarg)
  else:
    fnew(collection, gst.finalizeGObject)
    collection.impl = tmpoutgobjectarg
    GC_ref(collection)
    if g_object_is_floating(collection.impl).int != 0:
      discard g_object_ref_sink(collection.impl)
    g_object_add_toggle_ref(collection.impl, toggleNotify, addr(collection[]))
    g_object_unref(collection.impl)
    assert(g_object_get_qdata(collection.impl, Quark) == nil)
    g_object_set_qdata(collection.impl, Quark, addr(collection[]))


proc parseStreamCollection*(self: Event): StreamCollection =
  var tmpoutgobjectarg: ptr StreamCollection00
  gst_event_parse_stream_collection(cast[ptr Event00](self.impl), tmpoutgobjectarg)
#  dothemagic(result
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    result = cast[type(result)](argqdata)
    assert(result.impl == tmpoutgobjectarg)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = tmpoutgobjectarg
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))


type
  Toc00* {.pure.} = object
  Toc* = ref object
    impl*: ptr Toc00
    ignoreFinalizer*: bool

proc gst_toc_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstToc*(self: Toc) =
  if not self.ignoreFinalizer:
    boxedFree(gst_toc_get_type(), cast[ptr Toc00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Toc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_toc_get_type(), cast[ptr Toc00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Toc) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstToc)

proc gst_toc_dump(self: ptr Toc00) {.
    importc, libprag.}

proc dump*(self: Toc) =
  gst_toc_dump(cast[ptr Toc00](self.impl))

proc gst_toc_get_tags(self: ptr Toc00): ptr TagList00 {.
    importc, libprag.}

proc getTags*(self: Toc): TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_toc_get_tags(cast[ptr Toc00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc tags*(self: Toc): TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_toc_get_tags(cast[ptr Toc00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc gst_toc_merge_tags(self: ptr Toc00; tags: ptr TagList00; mode: TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: Toc; tags: TagList = nil; mode: TagMergeMode) =
  gst_toc_merge_tags(cast[ptr Toc00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](tags.impl), mode)

proc gst_toc_set_tags(self: ptr Toc00; tags: ptr TagList00) {.
    importc, libprag.}

proc setTags*(self: Toc; tags: TagList = nil) =
  gst_toc_set_tags(cast[ptr Toc00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tags.impl)))

proc `tags=`*(self: Toc; tags: TagList = nil) =
  gst_toc_set_tags(cast[ptr Toc00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tags.impl)))

proc gst_event_new_toc(toc: ptr Toc00; updated: gboolean): ptr Event00 {.
    importc, libprag.}

proc newEventToc*(toc: Toc; updated: bool): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_toc(cast[ptr Toc00](toc.impl), gboolean(updated))

proc newEventToc*(tdesc: typedesc; toc: Toc; updated: bool): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_toc(cast[ptr Toc00](toc.impl), gboolean(updated))

proc initEventToc*[T](result: var T; toc: Toc; updated: bool) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_toc(cast[ptr Toc00](toc.impl), gboolean(updated))

proc gst_event_parse_toc(self: ptr Event00; toc: var ptr Toc00; updated: var gboolean) {.
    importc, libprag.}

proc parseToc*(self: Event; toc: var Toc; updated: var bool) =
  fnew(toc, gBoxedFreeGstToc)
  var updated_00: gboolean
  gst_event_parse_toc(cast[ptr Event00](self.impl), cast[var ptr Toc00](addr toc.impl), updated_00)
  if updated.addr != nil:
    updated = toBool(updated_00)

type
  TocEntry00* {.pure.} = object
  TocEntry* = ref object
    impl*: ptr TocEntry00
    ignoreFinalizer*: bool

proc gst_toc_entry_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstTocEntry*(self: TocEntry) =
  if not self.ignoreFinalizer:
    boxedFree(gst_toc_entry_get_type(), cast[ptr TocEntry00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TocEntry()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_toc_entry_get_type(), cast[ptr TocEntry00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TocEntry) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstTocEntry)

proc gst_toc_entry_append_sub_entry(self: ptr TocEntry00; subentry: ptr TocEntry00) {.
    importc, libprag.}

proc appendSubEntry*(self: TocEntry; subentry: TocEntry) =
  gst_toc_entry_append_sub_entry(cast[ptr TocEntry00](self.impl), cast[ptr TocEntry00](g_boxed_copy(gst_toc_entry_get_type(), subentry.impl)))

proc gst_toc_entry_get_parent(self: ptr TocEntry00): ptr TocEntry00 {.
    importc, libprag.}

proc getParent*(self: TocEntry): TocEntry =
  let impl0 = gst_toc_entry_get_parent(cast[ptr TocEntry00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTocEntry)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_entry_get_type(), impl0))

proc parent*(self: TocEntry): TocEntry =
  let impl0 = gst_toc_entry_get_parent(cast[ptr TocEntry00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTocEntry)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_entry_get_type(), impl0))

proc gst_toc_entry_get_start_stop_times(self: ptr TocEntry00; start: var int64;
    stop: var int64): gboolean {.
    importc, libprag.}

proc getStartStopTimes*(self: TocEntry; start: var int64 = cast[var int64](nil);
    stop: var int64 = cast[var int64](nil)): bool =
  toBool(gst_toc_entry_get_start_stop_times(cast[ptr TocEntry00](self.impl), start, stop))

proc gst_toc_entry_get_sub_entries(self: ptr TocEntry00): ptr glib.List {.
    importc, libprag.}

proc getSubEntries*(self: TocEntry): seq[TocEntry] =
  discard

proc subEntries*(self: TocEntry): seq[TocEntry] =
  discard

proc gst_toc_entry_get_tags(self: ptr TocEntry00): ptr TagList00 {.
    importc, libprag.}

proc getTags*(self: TocEntry): TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_toc_entry_get_tags(cast[ptr TocEntry00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc tags*(self: TocEntry): TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_toc_entry_get_tags(cast[ptr TocEntry00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc gst_toc_entry_get_toc(self: ptr TocEntry00): ptr Toc00 {.
    importc, libprag.}

proc getToc*(self: TocEntry): Toc =
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_toc_entry_get_toc(cast[ptr TocEntry00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_get_type(), result.impl))

proc toc*(self: TocEntry): Toc =
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_toc_entry_get_toc(cast[ptr TocEntry00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_get_type(), result.impl))

proc gst_toc_entry_get_uid(self: ptr TocEntry00): cstring {.
    importc, libprag.}

proc getUid*(self: TocEntry): string =
  result = $gst_toc_entry_get_uid(cast[ptr TocEntry00](self.impl))

proc uid*(self: TocEntry): string =
  result = $gst_toc_entry_get_uid(cast[ptr TocEntry00](self.impl))

proc gst_toc_entry_is_alternative(self: ptr TocEntry00): gboolean {.
    importc, libprag.}

proc isAlternative*(self: TocEntry): bool =
  toBool(gst_toc_entry_is_alternative(cast[ptr TocEntry00](self.impl)))

proc gst_toc_entry_is_sequence(self: ptr TocEntry00): gboolean {.
    importc, libprag.}

proc isSequence*(self: TocEntry): bool =
  toBool(gst_toc_entry_is_sequence(cast[ptr TocEntry00](self.impl)))

proc gst_toc_entry_merge_tags(self: ptr TocEntry00; tags: ptr TagList00;
    mode: TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: TocEntry; tags: TagList = nil; mode: TagMergeMode) =
  gst_toc_entry_merge_tags(cast[ptr TocEntry00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](tags.impl), mode)

proc gst_toc_entry_set_start_stop_times(self: ptr TocEntry00; start: int64;
    stop: int64) {.
    importc, libprag.}

proc setStartStopTimes*(self: TocEntry; start: int64; stop: int64) =
  gst_toc_entry_set_start_stop_times(cast[ptr TocEntry00](self.impl), start, stop)

proc gst_toc_entry_set_tags(self: ptr TocEntry00; tags: ptr TagList00) {.
    importc, libprag.}

proc setTags*(self: TocEntry; tags: TagList = nil) =
  gst_toc_entry_set_tags(cast[ptr TocEntry00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tags.impl)))

proc `tags=`*(self: TocEntry; tags: TagList = nil) =
  gst_toc_entry_set_tags(cast[ptr TocEntry00](self.impl), if tags.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tags.impl)))

proc gst_toc_append_entry(self: ptr Toc00; entry: ptr TocEntry00) {.
    importc, libprag.}

proc appendEntry*(self: Toc; entry: TocEntry) =
  gst_toc_append_entry(cast[ptr Toc00](self.impl), cast[ptr TocEntry00](g_boxed_copy(gst_toc_entry_get_type(), entry.impl)))

proc gst_toc_find_entry(self: ptr Toc00; uid: cstring): ptr TocEntry00 {.
    importc, libprag.}

proc findEntry*(self: Toc; uid: cstring): TocEntry =
  let impl0 = gst_toc_find_entry(cast[ptr Toc00](self.impl), uid)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTocEntry)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_entry_get_type(), impl0))

proc gst_toc_get_entries(self: ptr Toc00): ptr glib.List {.
    importc, libprag.}

proc getEntries*(self: Toc): seq[TocEntry] =
  discard

proc entries*(self: Toc): seq[TocEntry] =
  discard

type
  TocEntryType* {.size: sizeof(cint), pure.} = enum
    angle = -3
    version = -2
    edition = -1
    invalid = 0
    title = 1
    track = 2
    chapter = 3

proc gst_toc_entry_type_get_nick(`type`: TocEntryType): cstring {.
    importc, libprag.}

proc getNick*(`type`: TocEntryType): string =
  result = $gst_toc_entry_type_get_nick(`type`)

proc nick*(`type`: TocEntryType): string =
  result = $gst_toc_entry_type_get_nick(`type`)

proc gst_toc_entry_new(`type`: TocEntryType; uid: cstring): ptr TocEntry00 {.
    importc, libprag.}

proc newTocEntry*(`type`: TocEntryType; uid: cstring): TocEntry =
  fnew(result, gBoxedFreeGstTocEntry)
  result.impl = gst_toc_entry_new(`type`, uid)

proc newTocEntry*(tdesc: typedesc; `type`: TocEntryType; uid: cstring): tdesc =
  assert(result is TocEntry)
  fnew(result, gBoxedFreeGstTocEntry)
  result.impl = gst_toc_entry_new(`type`, uid)

proc initTocEntry*[T](result: var T; `type`: TocEntryType; uid: cstring) {.deprecated.} =
  assert(result is TocEntry)
  fnew(result, gBoxedFreeGstTocEntry)
  result.impl = gst_toc_entry_new(`type`, uid)

proc gst_toc_entry_get_entry_type(self: ptr TocEntry00): TocEntryType {.
    importc, libprag.}

proc getEntryType*(self: TocEntry): TocEntryType =
  gst_toc_entry_get_entry_type(cast[ptr TocEntry00](self.impl))

proc entryType*(self: TocEntry): TocEntryType =
  gst_toc_entry_get_entry_type(cast[ptr TocEntry00](self.impl))

type
  TocLoopType* {.size: sizeof(cint), pure.} = enum
    none = 0
    forward = 1
    reverse = 2
    pingPong = 3

proc gst_toc_entry_get_loop(self: ptr TocEntry00; loopType: var TocLoopType;
    repeatCount: var int32): gboolean {.
    importc, libprag.}

proc getLoop*(self: TocEntry; loopType: var TocLoopType = cast[var TocLoopType](nil);
    repeatCount: var int = cast[var int](nil)): bool =
  var repeatCount_00: int32
  result = toBool(gst_toc_entry_get_loop(cast[ptr TocEntry00](self.impl), loopType, repeatCount_00))
  if repeatCount.addr != nil:
    repeatCount = int(repeatCount_00)

proc gst_toc_entry_set_loop(self: ptr TocEntry00; loopType: TocLoopType;
    repeatCount: int32) {.
    importc, libprag.}

proc setLoop*(self: TocEntry; loopType: TocLoopType; repeatCount: int) =
  gst_toc_entry_set_loop(cast[ptr TocEntry00](self.impl), loopType, int32(repeatCount))

type
  TocScope* {.size: sizeof(cint), pure.} = enum
    global = 1
    current = 2

proc gst_toc_new(scope: TocScope): ptr Toc00 {.
    importc, libprag.}

proc newToc*(scope: TocScope): Toc =
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_toc_new(scope)

proc newToc*(tdesc: typedesc; scope: TocScope): tdesc =
  assert(result is Toc)
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_toc_new(scope)

proc initToc*[T](result: var T; scope: TocScope) {.deprecated.} =
  assert(result is Toc)
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_toc_new(scope)

proc gst_toc_get_scope(self: ptr Toc00): TocScope {.
    importc, libprag.}

proc getScope*(self: Toc): TocScope =
  gst_toc_get_scope(cast[ptr Toc00](self.impl))

proc scope*(self: Toc): TocScope =
  gst_toc_get_scope(cast[ptr Toc00](self.impl))

type
  BusSyncReply* {.size: sizeof(cint), pure.} = enum
    drop = 0
    pass = 1
    async = 2

type
  Clock* = ref object of Object
  Clock00* = object of Object00

proc gst_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Clock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scSynced*(self: Clock;  p: proc (self: ptr Clock00; synced: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "synced", cast[GCallback](p), xdata, nil, cf)

proc gst_clock_id_compare_func(id1: pointer; id2: pointer): int32 {.
    importc, libprag.}

proc idCompareFunc*(id1: pointer; id2: pointer): int =
  int(gst_clock_id_compare_func(id1, id2))

proc gst_clock_id_get_clock(id: pointer): ptr Clock00 {.
    importc, libprag.}

proc idGetClock*(id: pointer): Clock =
  let gobj = gst_clock_id_get_clock(id)
  if gobj.isNil:
    return nil
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

proc idGetTime*(id: pointer): uint64 {.
    importc: "gst_clock_id_get_time", libprag.}

proc idRef*(id: pointer): pointer {.
    importc: "gst_clock_id_ref", libprag.}

proc idUnref*(id: pointer) {.
    importc: "gst_clock_id_unref", libprag.}

proc idUnschedule*(id: pointer) {.
    importc: "gst_clock_id_unschedule", libprag.}

proc gst_clock_id_uses_clock(id: pointer; clock: ptr Clock00): gboolean {.
    importc, libprag.}

proc idUsesClock*(id: pointer; clock: Clock): bool =
  toBool(gst_clock_id_uses_clock(id, cast[ptr Clock00](clock.impl)))

proc gst_clock_add_observation(self: ptr Clock00; slave: uint64; master: uint64;
    rSquared: var cdouble): gboolean {.
    importc, libprag.}

proc addObservation*(self: Clock; slave: uint64; master: uint64;
    rSquared: var cdouble): bool =
  toBool(gst_clock_add_observation(cast[ptr Clock00](self.impl), slave, master, rSquared))

proc gst_clock_add_observation_unapplied(self: ptr Clock00; slave: uint64;
    master: uint64; rSquared: var cdouble; internal: var uint64; external: var uint64;
    rateNum: var uint64; rateDenom: var uint64): gboolean {.
    importc, libprag.}

proc addObservationUnapplied*(self: Clock; slave: uint64; master: uint64;
    rSquared: var cdouble; internal: var uint64 = cast[var uint64](nil); external: var uint64 = cast[var uint64](nil);
    rateNum: var uint64 = cast[var uint64](nil); rateDenom: var uint64 = cast[var uint64](nil)): bool =
  toBool(gst_clock_add_observation_unapplied(cast[ptr Clock00](self.impl), slave, master, rSquared, internal, external, rateNum, rateDenom))

proc gst_clock_adjust_unlocked(self: ptr Clock00; internal: uint64): uint64 {.
    importc, libprag.}

proc adjustUnlocked*(self: Clock; internal: uint64): uint64 =
  gst_clock_adjust_unlocked(cast[ptr Clock00](self.impl), internal)

proc gst_clock_adjust_with_calibration(self: ptr Clock00; internalTarget: uint64;
    cinternal: uint64; cexternal: uint64; cnum: uint64; cdenom: uint64): uint64 {.
    importc, libprag.}

proc adjustWithCalibration*(self: Clock; internalTarget: uint64;
    cinternal: uint64; cexternal: uint64; cnum: uint64; cdenom: uint64): uint64 =
  gst_clock_adjust_with_calibration(cast[ptr Clock00](self.impl), internalTarget, cinternal, cexternal, cnum, cdenom)

proc gst_clock_get_calibration(self: ptr Clock00; internal: var uint64; external: var uint64;
    rateNum: var uint64; rateDenom: var uint64) {.
    importc, libprag.}

proc getCalibration*(self: Clock; internal: var uint64 = cast[var uint64](nil);
    external: var uint64 = cast[var uint64](nil); rateNum: var uint64 = cast[var uint64](nil);
    rateDenom: var uint64 = cast[var uint64](nil)) =
  gst_clock_get_calibration(cast[ptr Clock00](self.impl), internal, external, rateNum, rateDenom)

proc gst_clock_get_internal_time(self: ptr Clock00): uint64 {.
    importc, libprag.}

proc getInternalTime*(self: Clock): uint64 =
  gst_clock_get_internal_time(cast[ptr Clock00](self.impl))

proc internalTime*(self: Clock): uint64 =
  gst_clock_get_internal_time(cast[ptr Clock00](self.impl))

proc gst_clock_get_master(self: ptr Clock00): ptr Clock00 {.
    importc, libprag.}

proc getMaster*(self: Clock): Clock =
  let gobj = gst_clock_get_master(cast[ptr Clock00](self.impl))
  if gobj.isNil:
    return nil
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

proc master*(self: Clock): Clock =
  let gobj = gst_clock_get_master(cast[ptr Clock00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_clock_get_resolution(self: ptr Clock00): uint64 {.
    importc, libprag.}

proc getResolution*(self: Clock): uint64 =
  gst_clock_get_resolution(cast[ptr Clock00](self.impl))

proc resolution*(self: Clock): uint64 =
  gst_clock_get_resolution(cast[ptr Clock00](self.impl))

proc gst_clock_get_time(self: ptr Clock00): uint64 {.
    importc, libprag.}

proc getTime*(self: Clock): uint64 =
  gst_clock_get_time(cast[ptr Clock00](self.impl))

proc time*(self: Clock): uint64 =
  gst_clock_get_time(cast[ptr Clock00](self.impl))

proc gst_clock_get_timeout(self: ptr Clock00): uint64 {.
    importc, libprag.}

proc getTimeout*(self: Clock): uint64 =
  gst_clock_get_timeout(cast[ptr Clock00](self.impl))

proc timeout*(self: Clock): uint64 =
  gst_clock_get_timeout(cast[ptr Clock00](self.impl))

proc gst_clock_is_synced(self: ptr Clock00): gboolean {.
    importc, libprag.}

proc isSynced*(self: Clock): bool =
  toBool(gst_clock_is_synced(cast[ptr Clock00](self.impl)))

proc gst_clock_new_periodic_id(self: ptr Clock00; startTime: uint64; interval: uint64): pointer {.
    importc, libprag.}

proc newPeriodicId*(self: Clock; startTime: uint64; interval: uint64): pointer =
  gst_clock_new_periodic_id(cast[ptr Clock00](self.impl), startTime, interval)

proc gst_clock_new_single_shot_id(self: ptr Clock00; time: uint64): pointer {.
    importc, libprag.}

proc newSingleShotId*(self: Clock; time: uint64): pointer =
  gst_clock_new_single_shot_id(cast[ptr Clock00](self.impl), time)

proc gst_clock_periodic_id_reinit(self: ptr Clock00; id: pointer; startTime: uint64;
    interval: uint64): gboolean {.
    importc, libprag.}

proc periodicIdReinit*(self: Clock; id: pointer; startTime: uint64;
    interval: uint64): bool =
  toBool(gst_clock_periodic_id_reinit(cast[ptr Clock00](self.impl), id, startTime, interval))

proc gst_clock_set_calibration(self: ptr Clock00; internal: uint64; external: uint64;
    rateNum: uint64; rateDenom: uint64) {.
    importc, libprag.}

proc setCalibration*(self: Clock; internal: uint64; external: uint64;
    rateNum: uint64; rateDenom: uint64) =
  gst_clock_set_calibration(cast[ptr Clock00](self.impl), internal, external, rateNum, rateDenom)

proc gst_clock_set_master(self: ptr Clock00; master: ptr Clock00): gboolean {.
    importc, libprag.}

proc setMaster*(self: Clock; master: Clock = nil): bool =
  toBool(gst_clock_set_master(cast[ptr Clock00](self.impl), if master.isNil: nil else: cast[ptr Clock00](master.impl)))

proc gst_clock_set_resolution(self: ptr Clock00; resolution: uint64): uint64 {.
    importc, libprag.}

proc setResolution*(self: Clock; resolution: uint64): uint64 =
  gst_clock_set_resolution(cast[ptr Clock00](self.impl), resolution)

proc gst_clock_set_synced(self: ptr Clock00; synced: gboolean) {.
    importc, libprag.}

proc setSynced*(self: Clock; synced: bool = true) =
  gst_clock_set_synced(cast[ptr Clock00](self.impl), gboolean(synced))

proc `synced=`*(self: Clock; synced: bool) =
  gst_clock_set_synced(cast[ptr Clock00](self.impl), gboolean(synced))

proc gst_clock_set_timeout(self: ptr Clock00; timeout: uint64) {.
    importc, libprag.}

proc setTimeout*(self: Clock; timeout: uint64) =
  gst_clock_set_timeout(cast[ptr Clock00](self.impl), timeout)

proc `timeout=`*(self: Clock; timeout: uint64) =
  gst_clock_set_timeout(cast[ptr Clock00](self.impl), timeout)

proc gst_clock_single_shot_id_reinit(self: ptr Clock00; id: pointer; time: uint64): gboolean {.
    importc, libprag.}

proc singleShotIdReinit*(self: Clock; id: pointer; time: uint64): bool =
  toBool(gst_clock_single_shot_id_reinit(cast[ptr Clock00](self.impl), id, time))

proc gst_clock_unadjust_unlocked(self: ptr Clock00; external: uint64): uint64 {.
    importc, libprag.}

proc unadjustUnlocked*(self: Clock; external: uint64): uint64 =
  gst_clock_unadjust_unlocked(cast[ptr Clock00](self.impl), external)

proc gst_clock_unadjust_with_calibration(self: ptr Clock00; externalTarget: uint64;
    cinternal: uint64; cexternal: uint64; cnum: uint64; cdenom: uint64): uint64 {.
    importc, libprag.}

proc unadjustWithCalibration*(self: Clock; externalTarget: uint64;
    cinternal: uint64; cexternal: uint64; cnum: uint64; cdenom: uint64): uint64 =
  gst_clock_unadjust_with_calibration(cast[ptr Clock00](self.impl), externalTarget, cinternal, cexternal, cnum, cdenom)

proc gst_clock_wait_for_sync(self: ptr Clock00; timeout: uint64): gboolean {.
    importc, libprag.}

proc waitForSync*(self: Clock; timeout: uint64): bool =
  toBool(gst_clock_wait_for_sync(cast[ptr Clock00](self.impl), timeout))

proc gst_element_get_clock(self: ptr Element00): ptr Clock00 {.
    importc, libprag.}

proc getClock*(self: Element): Clock =
  let gobj = gst_element_get_clock(cast[ptr Element00](self.impl))
  if gobj.isNil:
    return nil
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

proc clock*(self: Element): Clock =
  let gobj = gst_element_get_clock(cast[ptr Element00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_element_provide_clock(self: ptr Element00): ptr Clock00 {.
    importc, libprag.}

proc provideClock*(self: Element): Clock =
  let gobj = gst_element_provide_clock(cast[ptr Element00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_element_set_clock(self: ptr Element00; clock: ptr Clock00): gboolean {.
    importc, libprag.}

proc setClock*(self: Element; clock: Clock = nil): bool =
  toBool(gst_element_set_clock(cast[ptr Element00](self.impl), if clock.isNil: nil else: cast[ptr Clock00](clock.impl)))

type
  ClockReturn* {.size: sizeof(cint), pure.} = enum
    ok = 0
    early = 1
    unscheduled = 2
    busy = 3
    badtime = 4
    error = 5
    unsupported = 6
    done = 7

proc idWait*(id: pointer; jitter: var int64): ClockReturn {.
    importc: "gst_clock_id_wait", libprag.}

type
  Context00* {.pure.} = object
  Context* = ref object
    impl*: ptr Context00
    ignoreFinalizer*: bool

proc gst_context_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstContext*(self: Context) =
  if not self.ignoreFinalizer:
    boxedFree(gst_context_get_type(), cast[ptr Context00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Context()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_context_get_type(), cast[ptr Context00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Context) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstContext)

proc gst_context_new(contextType: cstring; persistent: gboolean): ptr Context00 {.
    importc, libprag.}

proc newContext*(contextType: cstring; persistent: bool): Context =
  fnew(result, gBoxedFreeGstContext)
  result.impl = gst_context_new(contextType, gboolean(persistent))

proc newContext*(tdesc: typedesc; contextType: cstring; persistent: bool): tdesc =
  assert(result is Context)
  fnew(result, gBoxedFreeGstContext)
  result.impl = gst_context_new(contextType, gboolean(persistent))

proc initContext*[T](result: var T; contextType: cstring; persistent: bool) {.deprecated.} =
  assert(result is Context)
  fnew(result, gBoxedFreeGstContext)
  result.impl = gst_context_new(contextType, gboolean(persistent))

proc gst_context_get_context_type(self: ptr Context00): cstring {.
    importc, libprag.}

proc getContextType*(self: Context): string =
  result = $gst_context_get_context_type(cast[ptr Context00](self.impl))

proc contextType*(self: Context): string =
  result = $gst_context_get_context_type(cast[ptr Context00](self.impl))

proc gst_context_get_structure(self: ptr Context00): ptr Structure00 {.
    importc, libprag.}

proc getStructure*(self: Context): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_context_get_structure(cast[ptr Context00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc structure*(self: Context): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_context_get_structure(cast[ptr Context00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_context_has_context_type(self: ptr Context00; contextType: cstring): gboolean {.
    importc, libprag.}

proc hasContextType*(self: Context; contextType: cstring): bool =
  toBool(gst_context_has_context_type(cast[ptr Context00](self.impl), contextType))

proc gst_context_is_persistent(self: ptr Context00): gboolean {.
    importc, libprag.}

proc isPersistent*(self: Context): bool =
  toBool(gst_context_is_persistent(cast[ptr Context00](self.impl)))

proc gst_context_writable_structure(self: ptr Context00): ptr Structure00 {.
    importc, libprag.}

proc writableStructure*(self: Context): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_context_writable_structure(cast[ptr Context00](self.impl))

proc gst_element_get_context(self: ptr Element00; contextType: cstring): ptr Context00 {.
    importc, libprag.}

proc getContext*(self: Element; contextType: cstring): Context =
  let impl0 = gst_element_get_context(cast[ptr Element00](self.impl), contextType)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstContext)
  result.impl = impl0

proc gst_element_get_context_unlocked(self: ptr Element00; contextType: cstring): ptr Context00 {.
    importc, libprag.}

proc getContextUnlocked*(self: Element; contextType: cstring): Context =
  let impl0 = gst_element_get_context_unlocked(cast[ptr Element00](self.impl), contextType)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstContext)
  result.impl = impl0

proc gst_element_get_contexts(self: ptr Element00): ptr glib.List {.
    importc, libprag.}

proc getContexts*(self: Element): seq[Context] =
  let resul0 = gst_element_get_contexts(cast[ptr Element00](self.impl))
  result = glistStructs2seq[Context](resul0, false)
  g_list_free(resul0)

proc contexts*(self: Element): seq[Context] =
  let resul0 = gst_element_get_contexts(cast[ptr Element00](self.impl))
  result = glistStructs2seq[Context](resul0, false)
  g_list_free(resul0)

proc gst_element_set_context(self: ptr Element00; context: ptr Context00) {.
    importc, libprag.}

proc setContext*(self: Element; context: Context) =
  gst_element_set_context(cast[ptr Element00](self.impl), cast[ptr Context00](context.impl))

proc `context=`*(self: Element; context: Context) =
  gst_element_set_context(cast[ptr Element00](self.impl), cast[ptr Context00](context.impl))

proc gst_query_parse_context(self: ptr Query00; context: var ptr Context00) {.
    importc, libprag.}

proc parseContext*(self: Query; context: var Context) =
  fnew(context, gBoxedFreeGstContext)
  gst_query_parse_context(cast[ptr Query00](self.impl), cast[var ptr Context00](addr context.impl))
  context.impl = cast[ptr Context00](g_boxed_copy(gst_context_get_type(), context.impl))

proc parseContext*(self: Query): Context =
  fnew(result, gBoxedFreeGstContext)
  gst_query_parse_context(cast[ptr Query00](self.impl), cast[var ptr Context00](addr result.impl))
  result.impl = cast[ptr Context00](g_boxed_copy(gst_context_get_type(), result.impl))

proc gst_query_set_context(self: ptr Query00; context: ptr Context00) {.
    importc, libprag.}

proc setContext*(self: Query; context: Context) =
  gst_query_set_context(cast[ptr Query00](self.impl), cast[ptr Context00](context.impl))

proc `context=`*(self: Query; context: Context) =
  gst_query_set_context(cast[ptr Query00](self.impl), cast[ptr Context00](context.impl))

type
  State* {.size: sizeof(cint), pure.} = enum
    voidPending = 0
    null = 1
    ready = 2
    paused = 3
    playing = 4

proc gst_element_state_get_name(state: State): cstring {.
    importc, libprag.}

proc stateGetName*(state: State): string =
  result = $gst_element_state_get_name(state)

proc gst_element_get_state(self: ptr Element00; state: var State; pending: var State;
    timeout: uint64): StateChangeReturn {.
    importc, libprag.}

proc getState*(self: Element; state: var State = cast[var State](nil);
    pending: var State = cast[var State](nil); timeout: uint64): StateChangeReturn =
  gst_element_get_state(cast[ptr Element00](self.impl), state, pending, timeout)

proc gst_element_set_state(self: ptr Element00; state: State): StateChangeReturn {.
    importc, libprag.}

proc setState*(self: Element; state: State): StateChangeReturn =
  gst_element_set_state(cast[ptr Element00](self.impl), state)

type
  PadDirection* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    src = 1
    sink = 2

proc gst_pad_new(name: cstring; direction: PadDirection): ptr Pad00 {.
    importc, libprag.}

proc newPad*(name: cstring = nil; direction: PadDirection): Pad =
  let gobj = gst_pad_new(name, direction)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPad*(tdesc: typedesc; name: cstring = nil; direction: PadDirection): tdesc =
  assert(result is Pad)
  let gobj = gst_pad_new(name, direction)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPad*[T](result: var T; name: cstring = nil; direction: PadDirection) {.deprecated.} =
  assert(result is Pad)
  let gobj = gst_pad_new(name, direction)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_pad_get_direction(self: ptr Pad00): PadDirection {.
    importc, libprag.}

proc getDirection*(self: Pad): PadDirection =
  gst_pad_get_direction(cast[ptr Pad00](self.impl))

proc direction*(self: Pad): PadDirection =
  gst_pad_get_direction(cast[ptr Pad00](self.impl))

proc gst_bin_find_unlinked_pad(self: ptr Bin00; direction: PadDirection): ptr Pad00 {.
    importc, libprag.}

proc findUnlinkedPad*(self: Bin; direction: PadDirection): Pad =
  let gobj = gst_bin_find_unlinked_pad(cast[ptr Bin00](self.impl), direction)
  if gobj.isNil:
    return nil
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

proc gst_element_factory_list_filter(list: ptr glib.List; caps: ptr Caps00;
    direction: PadDirection; subsetonly: gboolean): ptr glib.List {.
    importc, libprag.}

proc listFilter*(list: seq[ElementFactory]; caps: Caps;
    direction: PadDirection; subsetonly: bool): seq[ElementFactory] =
  var tempResGL = seq2GList(list)
  let resul0 = gst_element_factory_list_filter(tempResGL, cast[ptr Caps00](caps.impl), direction, gboolean(subsetonly))
  g_list_free(tempResGL)
  result = glistObjects2seq(ElementFactory, resul0, true)
  g_list_free(resul0)

type
  PadPresence* {.size: sizeof(cint), pure.} = enum
    always = 0
    sometimes = 1
    request = 2

proc gst_pad_template_new(nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: ptr Caps00): ptr PadTemplate00 {.
    importc, libprag.}

proc newPadTemplate*(nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: Caps): PadTemplate =
  let gobj = gst_pad_template_new(nameTemplate, direction, presence, cast[ptr Caps00](caps.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPadTemplate*(tdesc: typedesc; nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: Caps): tdesc =
  assert(result is PadTemplate)
  let gobj = gst_pad_template_new(nameTemplate, direction, presence, cast[ptr Caps00](caps.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPadTemplate*[T](result: var T; nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: Caps) {.deprecated.} =
  assert(result is PadTemplate)
  let gobj = gst_pad_template_new(nameTemplate, direction, presence, cast[ptr Caps00](caps.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_pad_template_new_with_gtype(nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: ptr Caps00; padType: GType): ptr PadTemplate00 {.
    importc, libprag.}

proc newPadTemplateWithGtype*(nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: Caps; padType: GType): PadTemplate =
  let gobj = gst_pad_template_new_with_gtype(nameTemplate, direction, presence, cast[ptr Caps00](caps.impl), padType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPadTemplateWithGtype*(tdesc: typedesc; nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: Caps; padType: GType): tdesc =
  assert(result is PadTemplate)
  let gobj = gst_pad_template_new_with_gtype(nameTemplate, direction, presence, cast[ptr Caps00](caps.impl), padType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPadTemplateWithGtype*[T](result: var T; nameTemplate: cstring; direction: PadDirection;
    presence: PadPresence; caps: Caps; padType: GType) {.deprecated.} =
  assert(result is PadTemplate)
  let gobj = gst_pad_template_new_with_gtype(nameTemplate, direction, presence, cast[ptr Caps00](caps.impl), padType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Iterator00* {.pure.} = object
  Iterator* = ref object
    impl*: ptr Iterator00
    ignoreFinalizer*: bool

proc gst_iterator_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstIterator*(self: Iterator) =
  if not self.ignoreFinalizer:
    boxedFree(gst_iterator_get_type(), cast[ptr Iterator00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Iterator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_iterator_get_type(), cast[ptr Iterator00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Iterator) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstIterator)

proc gst_iterator_free(self: ptr Iterator00) {.
    importc, libprag.}

proc free*(self: Iterator) =
  gst_iterator_free(cast[ptr Iterator00](self.impl))

proc finalizerfree*(self: Iterator) =
  if not self.ignoreFinalizer:
    gst_iterator_free(cast[ptr Iterator00](self.impl))

proc gst_iterator_copy(self: ptr Iterator00): ptr Iterator00 {.
    importc, libprag.}

proc copy*(self: Iterator): Iterator =
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_iterator_copy(cast[ptr Iterator00](self.impl))

proc gst_iterator_filter(self: ptr Iterator00; `func`: CompareFunc; userData: gobject.Value): ptr Iterator00 {.
    importc, libprag.}

proc filter*(self: Iterator; `func`: CompareFunc; userData: gobject.Value): Iterator =
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_iterator_filter(cast[ptr Iterator00](self.impl), `func`, userData)

proc gst_iterator_find_custom(self: ptr Iterator00; `func`: CompareFunc;
    elem: var gobject.Value; userData: pointer): gboolean {.
    importc, libprag.}

proc findCustom*(self: Iterator; `func`: CompareFunc; elem: var gobject.Value;
    userData: pointer): bool =
  toBool(gst_iterator_find_custom(cast[ptr Iterator00](self.impl), `func`, elem, userData))

proc gst_iterator_new_single(`type`: GType; `object`: gobject.Value): ptr Iterator00 {.
    importc, libprag.}

proc newIteratorSingle*(`type`: GType; `object`: gobject.Value): Iterator =
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_iterator_new_single(`type`, `object`)

proc newIteratorSingle*(tdesc: typedesc; `type`: GType; `object`: gobject.Value): tdesc =
  assert(result is Iterator)
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_iterator_new_single(`type`, `object`)

proc initIteratorSingle*[T](result: var T; `type`: GType; `object`: gobject.Value) {.deprecated.} =
  assert(result is Iterator)
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_iterator_new_single(`type`, `object`)

proc gst_iterator_push(self: ptr Iterator00; other: ptr Iterator00) {.
    importc, libprag.}

proc push*(self: Iterator; other: Iterator) =
  gst_iterator_push(cast[ptr Iterator00](self.impl), cast[ptr Iterator00](other.impl))

proc gst_iterator_resync(self: ptr Iterator00) {.
    importc, libprag.}

proc resync*(self: Iterator) =
  gst_iterator_resync(cast[ptr Iterator00](self.impl))

proc gst_pad_iterate_internal_links(self: ptr Pad00): ptr Iterator00 {.
    importc, libprag.}

proc iterateInternalLinks*(self: Pad): Iterator =
  let impl0 = gst_pad_iterate_internal_links(cast[ptr Pad00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_pad_iterate_internal_links_default(self: ptr Pad00; parent: ptr Object00): ptr Iterator00 {.
    importc, libprag.}

proc iterateInternalLinksDefault*(self: Pad; parent: Object = nil): Iterator =
  let impl0 = gst_pad_iterate_internal_links_default(cast[ptr Pad00](self.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_element_iterate_pads(self: ptr Element00): ptr Iterator00 {.
    importc, libprag.}

proc iteratePads*(self: Element): Iterator =
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_element_iterate_pads(cast[ptr Element00](self.impl))

proc gst_element_iterate_sink_pads(self: ptr Element00): ptr Iterator00 {.
    importc, libprag.}

proc iterateSinkPads*(self: Element): Iterator =
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_element_iterate_sink_pads(cast[ptr Element00](self.impl))

proc gst_element_iterate_src_pads(self: ptr Element00): ptr Iterator00 {.
    importc, libprag.}

proc iterateSrcPads*(self: Element): Iterator =
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_element_iterate_src_pads(cast[ptr Element00](self.impl))

proc gst_bin_iterate_all_by_element_factory_name(self: ptr Bin00; factoryName: cstring): ptr Iterator00 {.
    importc, libprag.}

proc iterateAllByElementFactoryName*(self: Bin; factoryName: cstring): Iterator =
  let impl0 = gst_bin_iterate_all_by_element_factory_name(cast[ptr Bin00](self.impl), factoryName)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_bin_iterate_all_by_interface(self: ptr Bin00; iface: GType): ptr Iterator00 {.
    importc, libprag.}

proc iterateAllByInterface*(self: Bin; iface: GType): Iterator =
  let impl0 = gst_bin_iterate_all_by_interface(cast[ptr Bin00](self.impl), iface)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_bin_iterate_elements(self: ptr Bin00): ptr Iterator00 {.
    importc, libprag.}

proc iterateElements*(self: Bin): Iterator =
  let impl0 = gst_bin_iterate_elements(cast[ptr Bin00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_bin_iterate_recurse(self: ptr Bin00): ptr Iterator00 {.
    importc, libprag.}

proc iterateRecurse*(self: Bin): Iterator =
  let impl0 = gst_bin_iterate_recurse(cast[ptr Bin00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_bin_iterate_sinks(self: ptr Bin00): ptr Iterator00 {.
    importc, libprag.}

proc iterateSinks*(self: Bin): Iterator =
  let impl0 = gst_bin_iterate_sinks(cast[ptr Bin00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_bin_iterate_sorted(self: ptr Bin00): ptr Iterator00 {.
    importc, libprag.}

proc iterateSorted*(self: Bin): Iterator =
  let impl0 = gst_bin_iterate_sorted(cast[ptr Bin00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_bin_iterate_sources(self: ptr Bin00): ptr Iterator00 {.
    importc, libprag.}

proc iterateSources*(self: Bin): Iterator =
  let impl0 = gst_bin_iterate_sources(cast[ptr Bin00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_format_iterate_definitions(): ptr Iterator00 {.
    importc, libprag.}

proc iterateDefinitions*(): Iterator =
  fnew(result, gBoxedFreeGstIterator)
  result.impl = gst_format_iterate_definitions()

type
  IteratorResult* {.size: sizeof(cint), pure.} = enum
    done = 0
    ok = 1
    resync = 2
    error = 3

proc gst_iterator_next(self: ptr Iterator00; elem: var gobject.Value): IteratorResult {.
    importc, libprag.}

proc next*(self: Iterator; elem: var gobject.Value): IteratorResult =
  gst_iterator_next(cast[ptr Iterator00](self.impl), elem)

type
  ElementFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    lockedState = 4
    sink = 5
    source = 6
    provideClock = 7
    requireClock = 8
    indexable = 9
    last = 14

  ElementFlags* {.size: sizeof(cint).} = set[ElementFlag]

proc gst_bin_get_suppressed_flags(self: ptr Bin00): ElementFlags {.
    importc, libprag.}

proc getSuppressedFlags*(self: Bin): ElementFlags =
  gst_bin_get_suppressed_flags(cast[ptr Bin00](self.impl))

proc suppressedFlags*(self: Bin): ElementFlags =
  gst_bin_get_suppressed_flags(cast[ptr Bin00](self.impl))

proc gst_bin_set_suppressed_flags(self: ptr Bin00; flags: ElementFlags) {.
    importc, libprag.}

proc setSuppressedFlags*(self: Bin; flags: ElementFlags) =
  gst_bin_set_suppressed_flags(cast[ptr Bin00](self.impl), flags)

proc `suppressedFlags=`*(self: Bin; flags: ElementFlags) =
  gst_bin_set_suppressed_flags(cast[ptr Bin00](self.impl), flags)

type
  BinFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    noResync = 14
    streamsAware = 15
    last = 19

  BinFlags* {.size: sizeof(cint).} = set[BinFlag]

type
  Bitmask* = ref object of RootRef
    impl*: ptr Bitmask00
    ignoreFinalizer*: bool
  Bitmask00*{.inheritable, pure.} = object

proc gst_bitmask_get_type*(): GType {.importc, libprag.}

type
  BufferForeachMetaFunc* = proc (buffer: ptr Buffer00; meta: var ptr Meta00; userData: pointer): gboolean {.cdecl.}

proc gst_buffer_foreach_meta(self: ptr Buffer00; `func`: BufferForeachMetaFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc foreachMeta*(self: Buffer; `func`: BufferForeachMetaFunc;
    userData: pointer): bool =
  toBool(gst_buffer_foreach_meta(cast[ptr Buffer00](self.impl), `func`, userData))

type
  BufferListFunc* = proc (buffer: var ptr Buffer00; idx: uint32; userData: pointer): gboolean {.cdecl.}

proc gst_buffer_list_foreach(self: ptr BufferList00; `func`: BufferListFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc foreach*(self: BufferList; `func`: BufferListFunc; userData: pointer): bool =
  toBool(gst_buffer_list_foreach(cast[ptr BufferList00](self.impl), `func`, userData))

type
  BufferPoolAcquireFlag* {.size: sizeof(cint), pure.} = enum
    keyUnit = 0
    dontwait = 1
    discont = 2
    last = 16

  BufferPoolAcquireFlags* {.size: sizeof(cint).} = set[BufferPoolAcquireFlag]

const
  BufferPoolAcquireFlagsNone* = BufferPoolAcquireFlags({})
proc none*(t: typedesc[BufferPoolAcquireFlags]): BufferPoolAcquireFlags = BufferPoolAcquireFlags({})

type
  BusFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    flushing = 4
    flagLast = 5

  BusFlags* {.size: sizeof(cint).} = set[BusFlag]

const CAN_INLINE* = 1'i32

const CAPS_FEATURE_MEMORY_SYSTEM_MEMORY* = "memory:SystemMemory"

const CLOCK_TIME_NONE* = 18446744073709551615'u64

type
  CapsFilterMapFunc* = proc (features: ptr CapsFeatures00; structure: ptr Structure00; userData: pointer): gboolean {.cdecl.}

proc gst_caps_filter_and_map_in_place(self: ptr Caps00; `func`: CapsFilterMapFunc;
    userData: pointer) {.
    importc, libprag.}

proc filterAndMapInPlace*(self: Caps; `func`: CapsFilterMapFunc;
    userData: pointer) =
  gst_caps_filter_and_map_in_place(cast[ptr Caps00](self.impl), `func`, userData)

type
  CapsFlags* {.size: sizeof(cint), pure.} = enum
    any = 16

type
  CapsForeachFunc* = proc (features: ptr CapsFeatures00; structure: ptr Structure00; userData: pointer): gboolean {.cdecl.}

proc gst_caps_foreach(self: ptr Caps00; `func`: CapsForeachFunc; userData: pointer): gboolean {.
    importc, libprag.}

proc foreach*(self: Caps; `func`: CapsForeachFunc; userData: pointer): bool =
  toBool(gst_caps_foreach(cast[ptr Caps00](self.impl), `func`, userData))

type
  CapsMapFunc* = proc (features: ptr CapsFeatures00; structure: ptr Structure00; userData: pointer): gboolean {.cdecl.}

proc gst_caps_map_in_place(self: ptr Caps00; `func`: CapsMapFunc; userData: pointer): gboolean {.
    importc, libprag.}

proc mapInPlace*(self: Caps; `func`: CapsMapFunc; userData: pointer): bool =
  toBool(gst_caps_map_in_place(cast[ptr Caps00](self.impl), `func`, userData))

type
  Pipeline* = ref object of Bin
  Pipeline00* = object of Bin00

proc gst_pipeline_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Pipeline()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_pipeline_new(name: cstring): ptr Pipeline00 {.
    importc, libprag.}

proc newPipeline*(name: cstring = nil): Pipeline =
  let gobj = gst_pipeline_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPipeline*(tdesc: typedesc; name: cstring = nil): tdesc =
  assert(result is Pipeline)
  let gobj = gst_pipeline_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPipeline*[T](result: var T; name: cstring = nil) {.deprecated.} =
  assert(result is Pipeline)
  let gobj = gst_pipeline_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_pipeline_auto_clock(self: ptr Pipeline00) {.
    importc, libprag.}

proc autoClock*(self: Pipeline) =
  gst_pipeline_auto_clock(cast[ptr Pipeline00](self.impl))

proc gst_pipeline_get_auto_flush_bus(self: ptr Pipeline00): gboolean {.
    importc, libprag.}

proc getAutoFlushBus*(self: Pipeline): bool =
  toBool(gst_pipeline_get_auto_flush_bus(cast[ptr Pipeline00](self.impl)))

proc autoFlushBus*(self: Pipeline): bool =
  toBool(gst_pipeline_get_auto_flush_bus(cast[ptr Pipeline00](self.impl)))

proc gst_pipeline_get_delay(self: ptr Pipeline00): uint64 {.
    importc, libprag.}

proc getDelay*(self: Pipeline): uint64 =
  gst_pipeline_get_delay(cast[ptr Pipeline00](self.impl))

proc delay*(self: Pipeline): uint64 =
  gst_pipeline_get_delay(cast[ptr Pipeline00](self.impl))

proc gst_pipeline_get_latency(self: ptr Pipeline00): uint64 {.
    importc, libprag.}

proc getLatency*(self: Pipeline): uint64 =
  gst_pipeline_get_latency(cast[ptr Pipeline00](self.impl))

proc latency*(self: Pipeline): uint64 =
  gst_pipeline_get_latency(cast[ptr Pipeline00](self.impl))

proc gst_pipeline_get_pipeline_clock(self: ptr Pipeline00): ptr Clock00 {.
    importc, libprag.}

proc getPipelineClock*(self: Pipeline): Clock =
  let gobj = gst_pipeline_get_pipeline_clock(cast[ptr Pipeline00](self.impl))
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

proc pipelineClock*(self: Pipeline): Clock =
  let gobj = gst_pipeline_get_pipeline_clock(cast[ptr Pipeline00](self.impl))
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

proc gst_pipeline_set_auto_flush_bus(self: ptr Pipeline00; autoFlush: gboolean) {.
    importc, libprag.}

proc setAutoFlushBus*(self: Pipeline; autoFlush: bool = true) =
  gst_pipeline_set_auto_flush_bus(cast[ptr Pipeline00](self.impl), gboolean(autoFlush))

proc `autoFlushBus=`*(self: Pipeline; autoFlush: bool) =
  gst_pipeline_set_auto_flush_bus(cast[ptr Pipeline00](self.impl), gboolean(autoFlush))

proc gst_pipeline_set_delay(self: ptr Pipeline00; delay: uint64) {.
    importc, libprag.}

proc setDelay*(self: Pipeline; delay: uint64) =
  gst_pipeline_set_delay(cast[ptr Pipeline00](self.impl), delay)

proc `delay=`*(self: Pipeline; delay: uint64) =
  gst_pipeline_set_delay(cast[ptr Pipeline00](self.impl), delay)

proc gst_pipeline_set_latency(self: ptr Pipeline00; latency: uint64) {.
    importc, libprag.}

proc setLatency*(self: Pipeline; latency: uint64) =
  gst_pipeline_set_latency(cast[ptr Pipeline00](self.impl), latency)

proc `latency=`*(self: Pipeline; latency: uint64) =
  gst_pipeline_set_latency(cast[ptr Pipeline00](self.impl), latency)

proc gst_pipeline_use_clock(self: ptr Pipeline00; clock: ptr Clock00) {.
    importc, libprag.}

proc useClock*(self: Pipeline; clock: Clock = nil) =
  gst_pipeline_use_clock(cast[ptr Pipeline00](self.impl), if clock.isNil: nil else: cast[ptr Clock00](clock.impl))

type
  ChildProxy00* = object of gobject.Object00
  ChildProxy* = ref object of gobject.Object

proc scChildAdded*(self: ChildProxy | Pipeline | Bin;  p: proc (self: ptr ChildProxy00; `object`: ptr gobject.Object00; name: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "child-added", cast[GCallback](p), xdata, nil, cf)

proc scChildRemoved*(self: ChildProxy | Pipeline | Bin;  p: proc (self: ptr ChildProxy00; `object`: ptr gobject.Object00; name: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "child-removed", cast[GCallback](p), xdata, nil, cf)

proc gst_child_proxy_child_added(self: ptr ChildProxy00; child: ptr gobject.Object00;
    name: cstring) {.
    importc, libprag.}

proc childAdded*(self: ChildProxy | Pipeline | Bin; child: gobject.Object;
    name: cstring) =
  gst_child_proxy_child_added(cast[ptr ChildProxy00](self.impl), cast[ptr gobject.Object00](child.impl), name)

proc gst_child_proxy_child_removed(self: ptr ChildProxy00; child: ptr gobject.Object00;
    name: cstring) {.
    importc, libprag.}

proc childRemoved*(self: ChildProxy | Pipeline | Bin; child: gobject.Object;
    name: cstring) =
  gst_child_proxy_child_removed(cast[ptr ChildProxy00](self.impl), cast[ptr gobject.Object00](child.impl), name)

proc gst_child_proxy_get_child_by_index(self: ptr ChildProxy00; index: uint32): ptr gobject.Object00 {.
    importc, libprag.}

proc getChildByIndex*(self: ChildProxy | Pipeline | Bin;
    index: int): gobject.Object =
  let gobj = gst_child_proxy_get_child_by_index(cast[ptr ChildProxy00](self.impl), uint32(index))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_child_proxy_get_child_by_name(self: ptr ChildProxy00; name: cstring): ptr gobject.Object00 {.
    importc, libprag.}

proc getChildByName*(self: ChildProxy | Pipeline | Bin;
    name: cstring): gobject.Object =
  let gobj = gst_child_proxy_get_child_by_name(cast[ptr ChildProxy00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_child_proxy_get_children_count(self: ptr ChildProxy00): uint32 {.
    importc, libprag.}

proc getChildrenCount*(self: ChildProxy | Pipeline | Bin): int =
  int(gst_child_proxy_get_children_count(cast[ptr ChildProxy00](self.impl)))

proc childrenCount*(self: ChildProxy | Pipeline | Bin): int =
  int(gst_child_proxy_get_children_count(cast[ptr ChildProxy00](self.impl)))

proc gst_child_proxy_get_property(self: ptr ChildProxy00; name: cstring;
    value: var gobject.Value) {.
    importc, libprag.}

proc getProperty*(self: ChildProxy | Pipeline | Bin; name: cstring;
    value: var gobject.Value) =
  gst_child_proxy_get_property(cast[ptr ChildProxy00](self.impl), name, value)

proc gst_child_proxy_lookup(self: ptr ChildProxy00; name: cstring; target: var ptr gobject.Object00;
    pspec: var ptr gobject.ParamSpec00): gboolean {.
    importc, libprag.}

proc lookup*(self: ChildProxy | Pipeline | Bin; name: cstring;
    target: var gobject.Object = cast[var gobject.Object](nil); pspec: var gobject.ParamSpec = cast[var gobject.ParamSpec](nil)): bool =
  var tmpoutgobjectarg: ptr gobject.Object00
  if addr(pspec) != nil:
    fnew(pspec, gobject.finalizeGObject)
  result = toBool(gst_child_proxy_lookup(cast[ptr ChildProxy00](self.impl), name, cast[var ptr gobject.Object00](if addr(target) == nil: nil else: addr tmpoutgobjectarg), cast[var ptr gobject.ParamSpec00](if addr(pspec) == nil: nil else: addr pspec.impl)))
#  dothemagic(target
  if addr(target) != nil:
    target = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      target = cast[type(target)](argqdata)
      assert(target.impl == tmpoutgobjectarg)
    else:
      fnew(target, gst.finalizeGObject)
      target.impl = tmpoutgobjectarg
      GC_ref(target)
      if g_object_is_floating(target.impl).int != 0:
        discard g_object_ref_sink(target.impl)
      g_object_add_toggle_ref(target.impl, toggleNotify, addr(target[]))
      g_object_unref(target.impl)
      assert(g_object_get_qdata(target.impl, Quark) == nil)
      g_object_set_qdata(target.impl, Quark, addr(target[]))


proc gst_child_proxy_set_property(self: ptr ChildProxy00; name: cstring;
    value: gobject.Value) {.
    importc, libprag.}

proc setProperty*(self: ChildProxy | Pipeline | Bin; name: cstring;
    value: gobject.Value) =
  gst_child_proxy_set_property(cast[ptr ChildProxy00](self.impl), name, value)

type
  ClockCallback* = proc (clock: ptr Clock00; time: uint64; id: pointer; userData: pointer): gboolean {.cdecl.}

proc idWaitAsync*(id: pointer; `func`: ClockCallback; userData: pointer;
    destroyData: DestroyNotify): ClockReturn {.
    importc: "gst_clock_id_wait_async", libprag.}

type
  ClockEntry00* {.pure.} = object
  ClockEntry* = ref object
    impl*: ptr ClockEntry00
    ignoreFinalizer*: bool

type
  ClockEntryType* {.size: sizeof(cint), pure.} = enum
    single = 0
    periodic = 1

type
  ClockFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    canDoSingleSync = 4
    canDoSingleAsync = 5
    canDoPeriodicSync = 6
    canDoPeriodicAsync = 7
    canSetResolution = 8
    canSetMaster = 9
    needsStartupSync = 10
    last = 12

  ClockFlags* {.size: sizeof(cint).} = set[ClockFlag]

type
  ClockType* {.size: sizeof(cint), pure.} = enum
    realtime = 0
    monotonic = 1
    other = 2
    tai = 3

type
  ControlBindingConvert* = proc (binding: ptr ControlBinding00; srcValue: cdouble; destValue: gobject.Value) {.cdecl.}

type
  ControlSource* = ref object of Object
  ControlSource00* = object of Object00

proc gst_control_source_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ControlSource()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_control_source_get_value(self: ptr ControlSource00; timestamp: uint64;
    value: var cdouble): gboolean {.
    importc, libprag.}

proc controlSourceGetValue*(self: ControlSource; timestamp: uint64;
    value: var cdouble): bool =
  toBool(gst_control_source_get_value(cast[ptr ControlSource00](self.impl), timestamp, value))

proc gst_control_source_get_value_array(self: ptr ControlSource00; timestamp: uint64;
    interval: uint64; nValues: uint32; values: ptr cdouble): gboolean {.
    importc, libprag.}

proc controlSourceGetValueArray*(self: ControlSource; timestamp: uint64;
    interval: uint64; nValues: int; values: ptr cdouble): bool =
  toBool(gst_control_source_get_value_array(cast[ptr ControlSource00](self.impl), timestamp, interval, uint32(nValues), values))

type
  ControlSourceGetValue* = proc (self: ptr ControlSource00; timestamp: uint64; value: ptr cdouble): gboolean {.cdecl.}

type
  ControlSourceGetValueArray* = proc (self: ptr ControlSource00; timestamp: uint64; interval: uint64; nValues: uint32;
    values: ptr cdouble): gboolean {.cdecl.}

type
  CoreError* {.size: sizeof(cint), pure.} = enum
    failed = 1
    tooLazy = 2
    notImplemented = 3
    stateChange = 4
    pad = 5
    thread = 6
    negotiation = 7
    event = 8
    seek = 9
    caps = 10
    tag = 11
    missingPlugin = 12
    clock = 13
    disabled = 14
    numErrors = 15

const DEBUG_BG_MASK* = 240'i32

const DEBUG_FG_MASK* = 15'i32

const DEBUG_FORMAT_MASK* = 65280'i32

type
  DebugCategory00* {.pure.} = object
  DebugCategory* = ref object
    impl*: ptr DebugCategory00
    ignoreFinalizer*: bool

proc gst_debug_category_free(self: ptr DebugCategory00) {.
    importc, libprag.}

proc free*(self: DebugCategory) =
  gst_debug_category_free(cast[ptr DebugCategory00](self.impl))

proc finalizerfree*(self: DebugCategory) =
  if not self.ignoreFinalizer:
    gst_debug_category_free(cast[ptr DebugCategory00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DebugCategory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_debug_category_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var DebugCategory) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_debug_category_get_color(self: ptr DebugCategory00): uint32 {.
    importc, libprag.}

proc getColor*(self: DebugCategory): int =
  int(gst_debug_category_get_color(cast[ptr DebugCategory00](self.impl)))

proc color*(self: DebugCategory): int =
  int(gst_debug_category_get_color(cast[ptr DebugCategory00](self.impl)))

proc gst_debug_category_get_description(self: ptr DebugCategory00): cstring {.
    importc, libprag.}

proc getDescription*(self: DebugCategory): string =
  result = $gst_debug_category_get_description(cast[ptr DebugCategory00](self.impl))

proc description*(self: DebugCategory): string =
  result = $gst_debug_category_get_description(cast[ptr DebugCategory00](self.impl))

proc gst_debug_category_get_name(self: ptr DebugCategory00): cstring {.
    importc, libprag.}

proc getName*(self: DebugCategory): string =
  result = $gst_debug_category_get_name(cast[ptr DebugCategory00](self.impl))

proc name*(self: DebugCategory): string =
  result = $gst_debug_category_get_name(cast[ptr DebugCategory00](self.impl))

proc gst_debug_category_reset_threshold(self: ptr DebugCategory00) {.
    importc, libprag.}

proc resetThreshold*(self: DebugCategory) =
  gst_debug_category_reset_threshold(cast[ptr DebugCategory00](self.impl))

type
  DebugLevel* {.size: sizeof(cint), pure.} = enum
    none = 0
    error = 1
    warning = 2
    fixme = 3
    info = 4
    debug = 5
    log = 6
    trace = 7
    memdump = 9
    count = 10

proc gst_debug_level_get_name(level: DebugLevel): cstring {.
    importc, libprag.}

proc getName*(level: DebugLevel): string =
  result = $gst_debug_level_get_name(level)

proc name*(level: DebugLevel): string =
  result = $gst_debug_level_get_name(level)

proc gst_debug_category_get_threshold(self: ptr DebugCategory00): DebugLevel {.
    importc, libprag.}

proc getThreshold*(self: DebugCategory): DebugLevel =
  gst_debug_category_get_threshold(cast[ptr DebugCategory00](self.impl))

proc threshold*(self: DebugCategory): DebugLevel =
  gst_debug_category_get_threshold(cast[ptr DebugCategory00](self.impl))

proc gst_debug_category_set_threshold(self: ptr DebugCategory00; level: DebugLevel) {.
    importc, libprag.}

proc setThreshold*(self: DebugCategory; level: DebugLevel) =
  gst_debug_category_set_threshold(cast[ptr DebugCategory00](self.impl), level)

proc `threshold=`*(self: DebugCategory; level: DebugLevel) =
  gst_debug_category_set_threshold(cast[ptr DebugCategory00](self.impl), level)

type
  DebugColorFlags* {.size: sizeof(cint), pure.} = enum
    bgBlack = 0
    fgRed = 1
    fgGreen = 2
    fgYellow = 3
    fgBlue = 4
    fgMagenta = 5
    fgCyan = 6
    fgWhite = 7
    bgRed = 16
    bgGreen = 32
    bgYellow = 48
    bgBlue = 64
    bgMagenta = 80
    bgCyan = 96
    bgWhite = 112
    bold = 256
    underline = 512

const
  DebugColorFlagsFgBlack* = DebugColorFlags.bgBlack

type
  DebugColorMode* {.size: sizeof(cint), pure.} = enum
    off = 0
    on = 1
    unix = 2

type
  DebugFuncPtr* = proc () {.cdecl.}

type
  DebugGraphDetails* {.size: sizeof(cint), pure.} = enum
    mediaType = 1
    capsDetails = 2
    nonDefaultParams = 4
    states = 8
    all = 15
    fullParams = 16
    verbose = 4294967295

type
  DebugMessage00* {.pure.} = object
  DebugMessage* = ref object
    impl*: ptr DebugMessage00
    ignoreFinalizer*: bool

proc gst_debug_message_get(self: ptr DebugMessage00): cstring {.
    importc, libprag.}

proc getDebugMessage*(self: DebugMessage): string =
  let resul0 = gst_debug_message_get(cast[ptr DebugMessage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc debugMessage*(self: DebugMessage): string =
  let resul0 = gst_debug_message_get(cast[ptr DebugMessage00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

type
  Device* = ref object of Object
  Device00* = object of Object00

proc gst_device_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Device()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scRemoved*(self: Device;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "removed", cast[GCallback](p), xdata, nil, cf)

proc gst_device_create_element(self: ptr Device00; name: cstring): ptr Element00 {.
    importc, libprag.}

proc createElement*(self: Device; name: cstring = nil): Element =
  let gobj = gst_device_create_element(cast[ptr Device00](self.impl), name)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_device_get_caps(self: ptr Device00): ptr Caps00 {.
    importc, libprag.}

proc getCaps*(self: Device): Caps =
  let impl0 = gst_device_get_caps(cast[ptr Device00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc caps*(self: Device): Caps =
  let impl0 = gst_device_get_caps(cast[ptr Device00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_device_get_device_class(self: ptr Device00): cstring {.
    importc, libprag.}

proc getDeviceClass*(self: Device): string =
  let resul0 = gst_device_get_device_class(cast[ptr Device00](self.impl))
  result = $resul0
  cogfree(resul0)

proc deviceClass*(self: Device): string =
  let resul0 = gst_device_get_device_class(cast[ptr Device00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_device_get_display_name(self: ptr Device00): cstring {.
    importc, libprag.}

proc getDisplayName*(self: Device): string =
  let resul0 = gst_device_get_display_name(cast[ptr Device00](self.impl))
  result = $resul0
  cogfree(resul0)

proc displayName*(self: Device): string =
  let resul0 = gst_device_get_display_name(cast[ptr Device00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_device_get_properties(self: ptr Device00): ptr Structure00 {.
    importc, libprag.}

proc getProperties*(self: Device): Structure =
  let impl0 = gst_device_get_properties(cast[ptr Device00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0

proc properties*(self: Device): Structure =
  let impl0 = gst_device_get_properties(cast[ptr Device00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0

proc gst_device_has_classes(self: ptr Device00; classes: cstring): gboolean {.
    importc, libprag.}

proc hasClasses*(self: Device; classes: cstring): bool =
  toBool(gst_device_has_classes(cast[ptr Device00](self.impl), classes))

proc gst_device_has_classesv(self: ptr Device00; classes: ptr cstring): gboolean {.
    importc, libprag.}

proc hasClassesv*(self: Device; classes: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  toBool(gst_device_has_classesv(cast[ptr Device00](self.impl), seq2CstringArray(classes, fs469n23)))

proc gst_device_reconfigure_element(self: ptr Device00; element: ptr Element00): gboolean {.
    importc, libprag.}

proc reconfigureElement*(self: Device; element: Element): bool =
  toBool(gst_device_reconfigure_element(cast[ptr Device00](self.impl), cast[ptr Element00](element.impl)))

type
  DeviceMonitor* = ref object of Object
  DeviceMonitor00* = object of Object00

proc gst_device_monitor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceMonitor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_device_monitor_new(): ptr DeviceMonitor00 {.
    importc, libprag.}

proc newDeviceMonitor*(): DeviceMonitor =
  let gobj = gst_device_monitor_new()
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

proc newDeviceMonitor*(tdesc: typedesc): tdesc =
  assert(result is DeviceMonitor)
  let gobj = gst_device_monitor_new()
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

proc initDeviceMonitor*[T](result: var T) {.deprecated.} =
  assert(result is DeviceMonitor)
  let gobj = gst_device_monitor_new()
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

proc gst_device_monitor_add_filter(self: ptr DeviceMonitor00; classes: cstring;
    caps: ptr Caps00): uint32 {.
    importc, libprag.}

proc addFilter*(self: DeviceMonitor; classes: cstring = nil;
    caps: Caps = nil): int =
  int(gst_device_monitor_add_filter(cast[ptr DeviceMonitor00](self.impl), classes, if caps.isNil: nil else: cast[ptr Caps00](caps.impl)))

proc gst_device_monitor_get_devices(self: ptr DeviceMonitor00): ptr glib.List {.
    importc, libprag.}

proc getDevices*(self: DeviceMonitor): seq[Device] =
  let resul0 = gst_device_monitor_get_devices(cast[ptr DeviceMonitor00](self.impl))
  if resul0.isNil:
    return
  result = glistObjects2seq(Device, resul0, true)
  g_list_free(resul0)

proc devices*(self: DeviceMonitor): seq[Device] =
  let resul0 = gst_device_monitor_get_devices(cast[ptr DeviceMonitor00](self.impl))
  if resul0.isNil:
    return
  result = glistObjects2seq(Device, resul0, true)
  g_list_free(resul0)

proc gst_device_monitor_get_providers(self: ptr DeviceMonitor00): ptr cstring {.
    importc, libprag.}

proc getProviders*(self: DeviceMonitor): seq[string] =
  let resul0 = gst_device_monitor_get_providers(cast[ptr DeviceMonitor00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc providers*(self: DeviceMonitor): seq[string] =
  let resul0 = gst_device_monitor_get_providers(cast[ptr DeviceMonitor00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_device_monitor_get_show_all_devices(self: ptr DeviceMonitor00): gboolean {.
    importc, libprag.}

proc getShowAllDevices*(self: DeviceMonitor): bool =
  toBool(gst_device_monitor_get_show_all_devices(cast[ptr DeviceMonitor00](self.impl)))

proc showAllDevices*(self: DeviceMonitor): bool =
  toBool(gst_device_monitor_get_show_all_devices(cast[ptr DeviceMonitor00](self.impl)))

proc gst_device_monitor_remove_filter(self: ptr DeviceMonitor00; filterId: uint32): gboolean {.
    importc, libprag.}

proc removeFilter*(self: DeviceMonitor; filterId: int): bool =
  toBool(gst_device_monitor_remove_filter(cast[ptr DeviceMonitor00](self.impl), uint32(filterId)))

proc gst_device_monitor_set_show_all_devices(self: ptr DeviceMonitor00; showAll: gboolean) {.
    importc, libprag.}

proc setShowAllDevices*(self: DeviceMonitor; showAll: bool = true) =
  gst_device_monitor_set_show_all_devices(cast[ptr DeviceMonitor00](self.impl), gboolean(showAll))

proc `showAllDevices=`*(self: DeviceMonitor; showAll: bool) =
  gst_device_monitor_set_show_all_devices(cast[ptr DeviceMonitor00](self.impl), gboolean(showAll))

proc gst_device_monitor_start(self: ptr DeviceMonitor00): gboolean {.
    importc, libprag.}

proc start*(self: DeviceMonitor): bool =
  toBool(gst_device_monitor_start(cast[ptr DeviceMonitor00](self.impl)))

proc gst_device_monitor_stop(self: ptr DeviceMonitor00) {.
    importc, libprag.}

proc stop*(self: DeviceMonitor) =
  gst_device_monitor_stop(cast[ptr DeviceMonitor00](self.impl))

type
  DeviceProvider* = ref object of Object
  DeviceProvider00* = object of Object00

proc gst_device_provider_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceProvider()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scProviderHidden*(self: DeviceProvider;  p: proc (self: ptr DeviceProvider00; `object`: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "provider-hidden", cast[GCallback](p), xdata, nil, cf)

proc scProviderUnhidden*(self: DeviceProvider;  p: proc (self: ptr DeviceProvider00; `object`: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "provider-unhidden", cast[GCallback](p), xdata, nil, cf)

proc gst_device_provider_register(plugin: ptr Plugin00; name: cstring; rank: uint32;
    `type`: GType): gboolean {.
    importc, libprag.}

proc registerDeviceProvider*(plugin: Plugin = nil; name: cstring; rank: int;
    `type`: GType): bool =
  toBool(gst_device_provider_register(if plugin.isNil: nil else: cast[ptr Plugin00](plugin.impl), name, uint32(rank), `type`))

proc gst_device_provider_can_monitor(self: ptr DeviceProvider00): gboolean {.
    importc, libprag.}

proc canMonitor*(self: DeviceProvider): bool =
  toBool(gst_device_provider_can_monitor(cast[ptr DeviceProvider00](self.impl)))

proc gst_device_provider_device_add(self: ptr DeviceProvider00; device: ptr Device00) {.
    importc, libprag.}

proc deviceAdd*(self: DeviceProvider; device: Device) =
  gst_device_provider_device_add(cast[ptr DeviceProvider00](self.impl), cast[ptr Device00](device.impl))

proc gst_device_provider_device_changed(self: ptr DeviceProvider00; device: ptr Device00;
    changedDevice: ptr Device00) {.
    importc, libprag.}

proc deviceChanged*(self: DeviceProvider; device: Device;
    changedDevice: Device) =
  gst_device_provider_device_changed(cast[ptr DeviceProvider00](self.impl), cast[ptr Device00](device.impl), cast[ptr Device00](changedDevice.impl))

proc gst_device_provider_device_remove(self: ptr DeviceProvider00; device: ptr Device00) {.
    importc, libprag.}

proc deviceRemove*(self: DeviceProvider; device: Device) =
  gst_device_provider_device_remove(cast[ptr DeviceProvider00](self.impl), cast[ptr Device00](device.impl))

proc gst_device_provider_get_devices(self: ptr DeviceProvider00): ptr glib.List {.
    importc, libprag.}

proc getDevices*(self: DeviceProvider): seq[Device] =
  let resul0 = gst_device_provider_get_devices(cast[ptr DeviceProvider00](self.impl))
  result = glistObjects2seq(Device, resul0, true)
  g_list_free(resul0)

proc devices*(self: DeviceProvider): seq[Device] =
  let resul0 = gst_device_provider_get_devices(cast[ptr DeviceProvider00](self.impl))
  result = glistObjects2seq(Device, resul0, true)
  g_list_free(resul0)

proc gst_device_provider_get_hidden_providers(self: ptr DeviceProvider00): ptr cstring {.
    importc, libprag.}

proc getHiddenProviders*(self: DeviceProvider): seq[string] =
  let resul0 = gst_device_provider_get_hidden_providers(cast[ptr DeviceProvider00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc hiddenProviders*(self: DeviceProvider): seq[string] =
  let resul0 = gst_device_provider_get_hidden_providers(cast[ptr DeviceProvider00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_device_provider_get_metadata(self: ptr DeviceProvider00; key: cstring): cstring {.
    importc, libprag.}

proc getMetadata*(self: DeviceProvider; key: cstring): string =
  result = $gst_device_provider_get_metadata(cast[ptr DeviceProvider00](self.impl), key)

proc gst_device_provider_hide_provider(self: ptr DeviceProvider00; name: cstring) {.
    importc, libprag.}

proc hideProvider*(self: DeviceProvider; name: cstring) =
  gst_device_provider_hide_provider(cast[ptr DeviceProvider00](self.impl), name)

proc gst_device_provider_start(self: ptr DeviceProvider00): gboolean {.
    importc, libprag.}

proc start*(self: DeviceProvider): bool =
  toBool(gst_device_provider_start(cast[ptr DeviceProvider00](self.impl)))

proc gst_device_provider_stop(self: ptr DeviceProvider00) {.
    importc, libprag.}

proc stop*(self: DeviceProvider) =
  gst_device_provider_stop(cast[ptr DeviceProvider00](self.impl))

proc gst_device_provider_unhide_provider(self: ptr DeviceProvider00; name: cstring) {.
    importc, libprag.}

proc unhideProvider*(self: DeviceProvider; name: cstring) =
  gst_device_provider_unhide_provider(cast[ptr DeviceProvider00](self.impl), name)

type
  DeviceProviderFactory* = ref object of PluginFeature
  DeviceProviderFactory00* = object of PluginFeature00

proc gst_device_provider_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DeviceProviderFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_device_provider_factory_find(name: cstring): ptr DeviceProviderFactory00 {.
    importc, libprag.}

proc findDeviceProviderFactory*(name: cstring): DeviceProviderFactory =
  let gobj = gst_device_provider_factory_find(name)
  if gobj.isNil:
    return nil
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

proc gst_device_provider_factory_get_by_name(factoryname: cstring): ptr DeviceProvider00 {.
    importc, libprag.}

proc getByName*(factoryname: cstring): DeviceProvider =
  let gobj = gst_device_provider_factory_get_by_name(factoryname)
  if gobj.isNil:
    return nil
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

proc byName*(factoryname: cstring): DeviceProvider =
  let gobj = gst_device_provider_factory_get_by_name(factoryname)
  if gobj.isNil:
    return nil
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

proc gst_device_provider_factory_list_get_device_providers(minrank: Rank): ptr glib.List {.
    importc, libprag.}

proc listGetDeviceProviders*(minrank: Rank): seq[DeviceProviderFactory] =
  let resul0 = gst_device_provider_factory_list_get_device_providers(minrank)
  result = glistObjects2seq(DeviceProviderFactory, resul0, true)
  g_list_free(resul0)

proc gst_device_provider_factory_get(self: ptr DeviceProviderFactory00): ptr DeviceProvider00 {.
    importc, libprag.}

proc getDeviceProviderFactory*(self: DeviceProviderFactory): DeviceProvider =
  let gobj = gst_device_provider_factory_get(cast[ptr DeviceProviderFactory00](self.impl))
  if gobj.isNil:
    return nil
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

proc deviceProviderFactory*(self: DeviceProviderFactory): DeviceProvider =
  let gobj = gst_device_provider_factory_get(cast[ptr DeviceProviderFactory00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_device_provider_factory_get_device_provider_type(self: ptr DeviceProviderFactory00): GType {.
    importc, libprag.}

proc getDeviceProviderType*(self: DeviceProviderFactory): GType =
  gst_device_provider_factory_get_device_provider_type(cast[ptr DeviceProviderFactory00](self.impl))

proc deviceProviderType*(self: DeviceProviderFactory): GType =
  gst_device_provider_factory_get_device_provider_type(cast[ptr DeviceProviderFactory00](self.impl))

proc gst_device_provider_factory_get_metadata(self: ptr DeviceProviderFactory00;
    key: cstring): cstring {.
    importc, libprag.}

proc getMetadata*(self: DeviceProviderFactory;
    key: cstring): string =
  let resul0 = gst_device_provider_factory_get_metadata(cast[ptr DeviceProviderFactory00](self.impl), key)
  if resul0.isNil:
    return
  result = $resul0

proc gst_device_provider_factory_get_metadata_keys(self: ptr DeviceProviderFactory00): ptr cstring {.
    importc, libprag.}

proc getMetadataKeys*(self: DeviceProviderFactory): seq[string] =
  let resul0 = gst_device_provider_factory_get_metadata_keys(cast[ptr DeviceProviderFactory00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc metadataKeys*(self: DeviceProviderFactory): seq[string] =
  let resul0 = gst_device_provider_factory_get_metadata_keys(cast[ptr DeviceProviderFactory00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_device_provider_factory_has_classes(self: ptr DeviceProviderFactory00;
    classes: cstring): gboolean {.
    importc, libprag.}

proc hasClasses*(self: DeviceProviderFactory;
    classes: cstring = nil): bool =
  toBool(gst_device_provider_factory_has_classes(cast[ptr DeviceProviderFactory00](self.impl), classes))

proc gst_device_provider_factory_has_classesv(self: ptr DeviceProviderFactory00;
    classes: ptr cstring): gboolean {.
    importc, libprag.}

proc hasClassesv*(self: DeviceProviderFactory;
    classes: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  toBool(gst_device_provider_factory_has_classesv(cast[ptr DeviceProviderFactory00](self.impl), seq2CstringArray(classes, fs469n23)))

proc gst_device_provider_get_factory(self: ptr DeviceProvider00): ptr DeviceProviderFactory00 {.
    importc, libprag.}

proc getFactory*(self: DeviceProvider): DeviceProviderFactory =
  let gobj = gst_device_provider_get_factory(cast[ptr DeviceProvider00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc factory*(self: DeviceProvider): DeviceProviderFactory =
  let gobj = gst_device_provider_get_factory(cast[ptr DeviceProvider00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DoubleRange* = ref object of RootRef
    impl*: ptr DoubleRange00
    ignoreFinalizer*: bool
  DoubleRange00*{.inheritable, pure.} = object

proc gst_double_range_get_type*(): GType {.importc, libprag.}

type
  DynamicTypeFactory* = ref object of PluginFeature
  DynamicTypeFactory00* = object of PluginFeature00

proc gst_dynamic_type_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DynamicTypeFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc load*(factoryname: cstring): GType {.
    importc: "gst_dynamic_type_factory_load", libprag.}

const ELEMENT_FACTORY_KLASS_DECODER* = "Decoder"

const ELEMENT_FACTORY_KLASS_DECRYPTOR* = "Decryptor"

const ELEMENT_FACTORY_KLASS_DEMUXER* = "Demuxer"

const ELEMENT_FACTORY_KLASS_DEPAYLOADER* = "Depayloader"

const ELEMENT_FACTORY_KLASS_ENCODER* = "Encoder"

const ELEMENT_FACTORY_KLASS_ENCRYPTOR* = "Encryptor"

const ELEMENT_FACTORY_KLASS_FORMATTER* = "Formatter"

const ELEMENT_FACTORY_KLASS_HARDWARE* = "Hardware"

const ELEMENT_FACTORY_KLASS_MEDIA_AUDIO* = "Audio"

const ELEMENT_FACTORY_KLASS_MEDIA_IMAGE* = "Image"

const ELEMENT_FACTORY_KLASS_MEDIA_METADATA* = "Metadata"

const ELEMENT_FACTORY_KLASS_MEDIA_SUBTITLE* = "Subtitle"

const ELEMENT_FACTORY_KLASS_MEDIA_VIDEO* = "Video"

const ELEMENT_FACTORY_KLASS_MUXER* = "Muxer"

const ELEMENT_FACTORY_KLASS_PARSER* = "Parser"

const ELEMENT_FACTORY_KLASS_PAYLOADER* = "Payloader"

const ELEMENT_FACTORY_KLASS_SINK* = "Sink"

const ELEMENT_FACTORY_KLASS_SRC* = "Source"

const ELEMENT_FACTORY_TYPE_ANY* = 562949953421311'u64

const ELEMENT_FACTORY_TYPE_AUDIOVIDEO_SINKS* = 3940649673949188'u64

const ELEMENT_FACTORY_TYPE_AUDIO_ENCODER* = 1125899906842626'u64

const ELEMENT_FACTORY_TYPE_DECODABLE* = 1377'u64

const ELEMENT_FACTORY_TYPE_DECODER* = 1'u64

const ELEMENT_FACTORY_TYPE_DECRYPTOR* = 1024'u64

const ELEMENT_FACTORY_TYPE_DEMUXER* = 32'u64

const ELEMENT_FACTORY_TYPE_DEPAYLOADER* = 256'u64

const ELEMENT_FACTORY_TYPE_ENCODER* = 2'u64

const ELEMENT_FACTORY_TYPE_ENCRYPTOR* = 2048'u64

const ELEMENT_FACTORY_TYPE_FORMATTER* = 512'u64

const ELEMENT_FACTORY_TYPE_HARDWARE* = 4096'u64

const ELEMENT_FACTORY_TYPE_MAX_ELEMENTS* = 281474976710656'u64

const ELEMENT_FACTORY_TYPE_MEDIA_ANY* = 18446462598732840960'u64

const ELEMENT_FACTORY_TYPE_MEDIA_AUDIO* = 1125899906842624'u64

const ELEMENT_FACTORY_TYPE_MEDIA_IMAGE* = 2251799813685248'u64

const ELEMENT_FACTORY_TYPE_MEDIA_METADATA* = 9007199254740992'u64

const ELEMENT_FACTORY_TYPE_MEDIA_SUBTITLE* = 4503599627370496'u64

const ELEMENT_FACTORY_TYPE_MEDIA_VIDEO* = 562949953421312'u64

const ELEMENT_FACTORY_TYPE_MUXER* = 16'u64

const ELEMENT_FACTORY_TYPE_PARSER* = 64'u64

const ELEMENT_FACTORY_TYPE_PAYLOADER* = 128'u64

const ELEMENT_FACTORY_TYPE_SINK* = 4'u64

const ELEMENT_FACTORY_TYPE_SRC* = 8'u64

const ELEMENT_FACTORY_TYPE_VIDEO_ENCODER* = 2814749767106562'u64

const ELEMENT_METADATA_AUTHOR* = "author"

const ELEMENT_METADATA_DESCRIPTION* = "description"

const ELEMENT_METADATA_DOC_URI* = "doc-uri"

const ELEMENT_METADATA_ICON_NAME* = "icon-name"

const ELEMENT_METADATA_KLASS* = "klass"

const ELEMENT_METADATA_LONGNAME* = "long-name"

const EVENT_NUM_SHIFT* = 8'i32

const EVENT_TYPE_BOTH* = "INTERFCE (unsuported)"

type
  ElementCallAsyncFunc* = proc (element: ptr Element00; userData: pointer) {.cdecl.}

proc gst_element_call_async(self: ptr Element00; `func`: ElementCallAsyncFunc;
    userData: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc callAsync*(self: Element; `func`: ElementCallAsyncFunc;
    userData: pointer; destroyNotify: DestroyNotify) =
  gst_element_call_async(cast[ptr Element00](self.impl), `func`, userData, destroyNotify)

type
  ElementForeachPadFunc* = proc (element: ptr Element00; pad: ptr Pad00; userData: pointer): gboolean {.cdecl.}

proc gst_element_foreach_pad(self: ptr Element00; `func`: ElementForeachPadFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc foreachPad*(self: Element; `func`: ElementForeachPadFunc;
    userData: pointer): bool =
  toBool(gst_element_foreach_pad(cast[ptr Element00](self.impl), `func`, userData))

proc gst_element_foreach_sink_pad(self: ptr Element00; `func`: ElementForeachPadFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc foreachSinkPad*(self: Element; `func`: ElementForeachPadFunc;
    userData: pointer): bool =
  toBool(gst_element_foreach_sink_pad(cast[ptr Element00](self.impl), `func`, userData))

proc gst_element_foreach_src_pad(self: ptr Element00; `func`: ElementForeachPadFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc foreachSrcPad*(self: Element; `func`: ElementForeachPadFunc;
    userData: pointer): bool =
  toBool(gst_element_foreach_src_pad(cast[ptr Element00](self.impl), `func`, userData))

const FLAG_SET_MASK_EXACT* = 4294967295'u32

const FORMAT_PERCENT_MAX* = 1000000'i64

const FORMAT_PERCENT_SCALE* = 10000'i64

type
  FlagSet* = ref object of RootRef
    impl*: ptr FlagSet00
    ignoreFinalizer*: bool
  FlagSet00*{.inheritable, pure.} = object

proc gst_flagset_get_type*(): GType {.importc, libprag.}

proc registerFlagSet*(flagsType: GType): GType {.
    importc: "gst_flagset_register", libprag.}

type
  Fraction* = ref object of RootRef
    impl*: ptr Fraction00
    ignoreFinalizer*: bool
  Fraction00*{.inheritable, pure.} = object

proc gst_fraction_get_type*(): GType {.importc, libprag.}

type
  FractionRange* = ref object of RootRef
    impl*: ptr FractionRange00
    ignoreFinalizer*: bool
  FractionRange00*{.inheritable, pure.} = object

proc gst_fraction_range_get_type*(): GType {.importc, libprag.}

const GROUP_ID_INVALID* = 0'i32

type
  ProxyPad* = ref object of Pad
  ProxyPad00* = object of Pad00

proc gst_proxy_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ProxyPad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_proxy_pad_chain_default(pad: ptr Pad00; parent: ptr Object00; buffer: ptr Buffer00): FlowReturn {.
    importc, libprag.}

proc chainDefault*(pad: Pad; parent: Object = nil; buffer: Buffer): FlowReturn =
  gst_proxy_pad_chain_default(cast[ptr Pad00](pad.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl), cast[ptr Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_proxy_pad_chain_list_default(pad: ptr Pad00; parent: ptr Object00;
    list: ptr BufferList00): FlowReturn {.
    importc, libprag.}

proc chainListDefault*(pad: Pad; parent: Object = nil; list: BufferList): FlowReturn =
  gst_proxy_pad_chain_list_default(cast[ptr Pad00](pad.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl), cast[ptr BufferList00](g_boxed_copy(gst_buffer_list_get_type(), list.impl)))

proc gst_proxy_pad_getrange_default(pad: ptr Pad00; parent: ptr Object00;
    offset: uint64; size: uint32; buffer: var ptr Buffer00): FlowReturn {.
    importc, libprag.}

proc getrangeDefault*(pad: Pad; parent: Object; offset: uint64;
    size: int; buffer: var Buffer): FlowReturn =
  fnew(buffer, gBoxedFreeGstBuffer)
  gst_proxy_pad_getrange_default(cast[ptr Pad00](pad.impl), cast[ptr Object00](parent.impl), offset, uint32(size), cast[var ptr Buffer00](addr buffer.impl))

proc gst_proxy_pad_iterate_internal_links_default(pad: ptr Pad00; parent: ptr Object00): ptr Iterator00 {.
    importc, libprag.}

proc iterateInternalLinksDefault*(pad: Pad; parent: Object = nil): Iterator =
  let impl0 = gst_proxy_pad_iterate_internal_links_default(cast[ptr Pad00](pad.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstIterator)
  result.impl = impl0

proc gst_proxy_pad_get_internal(self: ptr ProxyPad00): ptr ProxyPad00 {.
    importc, libprag.}

proc getInternal*(self: ProxyPad): ProxyPad =
  let gobj = gst_proxy_pad_get_internal(cast[ptr ProxyPad00](self.impl))
  if gobj.isNil:
    return nil
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

proc internal*(self: ProxyPad): ProxyPad =
  let gobj = gst_proxy_pad_get_internal(cast[ptr ProxyPad00](self.impl))
  if gobj.isNil:
    return nil
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
  GhostPad* = ref object of ProxyPad
  GhostPad00* = object of ProxyPad00

proc gst_ghost_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GhostPad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_ghost_pad_new(name: cstring; target: ptr Pad00): ptr GhostPad00 {.
    importc, libprag.}

proc newGhostPad*(name: cstring = nil; target: Pad): GhostPad =
  let gobj = gst_ghost_pad_new(name, cast[ptr Pad00](target.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGhostPad*(tdesc: typedesc; name: cstring = nil; target: Pad): tdesc =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new(name, cast[ptr Pad00](target.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGhostPad*[T](result: var T; name: cstring = nil; target: Pad) {.deprecated.} =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new(name, cast[ptr Pad00](target.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_ghost_pad_new_from_template(name: cstring; target: ptr Pad00; templ: ptr PadTemplate00): ptr GhostPad00 {.
    importc, libprag.}

proc newGhostPadFromTemplate*(name: cstring = nil; target: Pad; templ: PadTemplate): GhostPad =
  let gobj = gst_ghost_pad_new_from_template(name, cast[ptr Pad00](target.impl), cast[ptr PadTemplate00](templ.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGhostPadFromTemplate*(tdesc: typedesc; name: cstring = nil; target: Pad; templ: PadTemplate): tdesc =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new_from_template(name, cast[ptr Pad00](target.impl), cast[ptr PadTemplate00](templ.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGhostPadFromTemplate*[T](result: var T; name: cstring = nil; target: Pad; templ: PadTemplate) {.deprecated.} =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new_from_template(name, cast[ptr Pad00](target.impl), cast[ptr PadTemplate00](templ.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_ghost_pad_new_no_target(name: cstring; dir: PadDirection): ptr GhostPad00 {.
    importc, libprag.}

proc newGhostPadNoTarget*(name: cstring = nil; dir: PadDirection): GhostPad =
  let gobj = gst_ghost_pad_new_no_target(name, dir)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGhostPadNoTarget*(tdesc: typedesc; name: cstring = nil; dir: PadDirection): tdesc =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new_no_target(name, dir)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGhostPadNoTarget*[T](result: var T; name: cstring = nil; dir: PadDirection) {.deprecated.} =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new_no_target(name, dir)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_ghost_pad_new_no_target_from_template(name: cstring; templ: ptr PadTemplate00): ptr GhostPad00 {.
    importc, libprag.}

proc newGhostPadNoTargetFromTemplate*(name: cstring = nil; templ: PadTemplate): GhostPad =
  let gobj = gst_ghost_pad_new_no_target_from_template(name, cast[ptr PadTemplate00](templ.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGhostPadNoTargetFromTemplate*(tdesc: typedesc; name: cstring = nil; templ: PadTemplate): tdesc =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new_no_target_from_template(name, cast[ptr PadTemplate00](templ.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGhostPadNoTargetFromTemplate*[T](result: var T; name: cstring = nil; templ: PadTemplate) {.deprecated.} =
  assert(result is GhostPad)
  let gobj = gst_ghost_pad_new_no_target_from_template(name, cast[ptr PadTemplate00](templ.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_ghost_pad_activate_mode_default(pad: ptr Pad00; parent: ptr Object00;
    mode: PadMode; active: gboolean): gboolean {.
    importc, libprag.}

proc activateModeDefault*(pad: Pad; parent: Object = nil;
    mode: PadMode; active: bool): bool =
  toBool(gst_ghost_pad_activate_mode_default(cast[ptr Pad00](pad.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl), mode, gboolean(active)))

proc gst_ghost_pad_internal_activate_mode_default(pad: ptr Pad00; parent: ptr Object00;
    mode: PadMode; active: gboolean): gboolean {.
    importc, libprag.}

proc internalActivateModeDefault*(pad: Pad; parent: Object = nil;
    mode: PadMode; active: bool): bool =
  toBool(gst_ghost_pad_internal_activate_mode_default(cast[ptr Pad00](pad.impl), if parent.isNil: nil else: cast[ptr Object00](parent.impl), mode, gboolean(active)))

proc gst_ghost_pad_construct(self: ptr GhostPad00): gboolean {.
    importc, libprag.}

proc construct*(self: GhostPad): bool =
  toBool(gst_ghost_pad_construct(cast[ptr GhostPad00](self.impl)))

proc gst_ghost_pad_get_target(self: ptr GhostPad00): ptr Pad00 {.
    importc, libprag.}

proc getTarget*(self: GhostPad): Pad =
  let gobj = gst_ghost_pad_get_target(cast[ptr GhostPad00](self.impl))
  if gobj.isNil:
    return nil
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

proc target*(self: GhostPad): Pad =
  let gobj = gst_ghost_pad_get_target(cast[ptr GhostPad00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_ghost_pad_set_target(self: ptr GhostPad00; newtarget: ptr Pad00): gboolean {.
    importc, libprag.}

proc setTarget*(self: GhostPad; newtarget: Pad = nil): bool =
  toBool(gst_ghost_pad_set_target(cast[ptr GhostPad00](self.impl), if newtarget.isNil: nil else: cast[ptr Pad00](newtarget.impl)))

type
  Int64Range* = ref object of RootRef
    impl*: ptr Int64Range00
    ignoreFinalizer*: bool
  Int64Range00*{.inheritable, pure.} = object

proc gst_int64_range_get_type*(): GType {.importc, libprag.}

type
  IntRange* = ref object of RootRef
    impl*: ptr IntRange00
    ignoreFinalizer*: bool
  IntRange00*{.inheritable, pure.} = object

proc gst_int_range_get_type*(): GType {.importc, libprag.}

type
  IteratorCopyFunction* = proc (it: ptr Iterator00; copy: ptr Iterator00) {.cdecl.}

type
  IteratorFoldFunction* = proc (item: gobject.Value; ret: gobject.Value; userData: pointer): gboolean {.cdecl.}

proc gst_iterator_fold(self: ptr Iterator00; `func`: IteratorFoldFunction;
    ret: gobject.Value; userData: pointer): IteratorResult {.
    importc, libprag.}

proc fold*(self: Iterator; `func`: IteratorFoldFunction; ret: gobject.Value;
    userData: pointer): IteratorResult =
  gst_iterator_fold(cast[ptr Iterator00](self.impl), `func`, ret, userData)

type
  IteratorForeachFunction* = proc (item: gobject.Value; userData: pointer) {.cdecl.}

proc gst_iterator_foreach(self: ptr Iterator00; `func`: IteratorForeachFunction;
    userData: pointer): IteratorResult {.
    importc, libprag.}

proc foreach*(self: Iterator; `func`: IteratorForeachFunction;
    userData: pointer): IteratorResult =
  gst_iterator_foreach(cast[ptr Iterator00](self.impl), `func`, userData)

type
  IteratorFreeFunction* = proc (it: ptr Iterator00) {.cdecl.}

type
  IteratorItem* {.size: sizeof(cint), pure.} = enum
    skip = 0
    pass = 1
    `end` = 2

type
  IteratorItemFunction* = proc (it: ptr Iterator00; item: gobject.Value): IteratorItem {.cdecl.}

type
  IteratorNextFunction* = proc (it: ptr Iterator00; resu: gobject.Value): IteratorResult {.cdecl.}

type
  IteratorResyncFunction* = proc (it: ptr Iterator00) {.cdecl.}

const LICENSE_UNKNOWN* = "unknown"

const LOCK_FLAG_READWRITE* = "INTERFCE (unsuported)"

type
  LibraryError* {.size: sizeof(cint), pure.} = enum
    failed = 1
    tooLazy = 2
    init = 3
    shutdown = 4
    settings = 5
    encode = 6
    numErrors = 7

type
  LockFlag* {.size: sizeof(cint), pure.} = enum
    read = 0
    write = 1
    exclusive = 2
    last = 8

  LockFlags* {.size: sizeof(cint).} = set[LockFlag]

type
  LogFunction* = proc (category: ptr DebugCategory00; level: DebugLevel; file: cstring; function: cstring;
    line: int32; `object`: ptr gobject.Object00; message: ptr DebugMessage00;
    userData: pointer) {.cdecl.}

const MAP_READWRITE* = "INTERFCE (unsuported)"

const META_TAG_MEMORY_STR* = "memory"

const MSECOND* = 1000000'i64

type
  MemoryCopyFunction* = proc (mem: ptr Memory00; offset: int64; size: int64): ptr Memory00 {.cdecl.}

type
  MemoryIsSpanFunction* = proc (mem1: ptr Memory00; mem2: ptr Memory00; offset: ptr uint64): gboolean {.cdecl.}

type
  MemoryMapFullFunction* = proc (mem: ptr Memory00; info: MapInfo; maxsize: uint64): pointer {.cdecl.}

type
  MemoryMapFunction* = proc (mem: ptr Memory00; maxsize: uint64; flags: MapFlags): pointer {.cdecl.}

type
  MemoryShareFunction* = proc (mem: ptr Memory00; offset: int64; size: int64): ptr Memory00 {.cdecl.}

type
  MemoryUnmapFullFunction* = proc (mem: ptr Memory00; info: MapInfo) {.cdecl.}

type
  MemoryUnmapFunction* = proc (mem: ptr Memory00) {.cdecl.}

type
  MetaFlag* {.size: sizeof(cint), pure.} = enum
    readonly = 0
    pooled = 1
    locked = 2
    last = 16

  MetaFlags* {.size: sizeof(cint).} = set[MetaFlag]

const
  MetaFlagsNone* = MetaFlags({})
proc none*(t: typedesc[MetaFlags]): MetaFlags = MetaFlags({})

type
  MetaFreeFunction* = proc (meta: ptr Meta00; buffer: ptr Buffer00) {.cdecl.}

type
  MetaInitFunction* = proc (meta: ptr Meta00; params: pointer; buffer: ptr Buffer00): gboolean {.cdecl.}

type
  MetaTransformCopy00* {.pure.} = object
  MetaTransformCopy* = ref object
    impl*: ptr MetaTransformCopy00
    ignoreFinalizer*: bool

type
  MetaTransformFunction* = proc (transbuf: ptr Buffer00; meta: ptr Meta00; buffer: ptr Buffer00; `type`: uint32;
    data: pointer): gboolean {.cdecl.}

proc gst_meta_register(api: GType; impl: cstring; size: uint64; initFunc: MetaInitFunction;
    freeFunc: MetaFreeFunction; transformFunc: MetaTransformFunction): ptr MetaInfo00 {.
    importc, libprag.}

proc registerMeta*(api: GType; impl: cstring; size: uint64; initFunc: MetaInitFunction;
    freeFunc: MetaFreeFunction; transformFunc: MetaTransformFunction): MetaInfo =
  let impl0 = gst_meta_register(api, impl, size, initFunc, freeFunc, transformFunc)
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

type
  MiniObjectFlag* {.size: sizeof(cint), pure.} = enum
    lockable = 0
    lockReadonly = 1
    mayBeLeaked = 2
    last = 4

  MiniObjectFlags* {.size: sizeof(cint).} = set[MiniObjectFlag]
type

  MiniObjectFreeFunction* = proc (obj: ptr MiniObject00) {.cdecl.}

  MiniObjectDisposeFunction* = proc (obj: ptr MiniObject00): gboolean {.cdecl.}

  MiniObject00* {.pure.} = object
    `type`*: GType
    refcount*: int32
    lockstate*: int32
    flags*: uint32
    copy*: pointer
    dispose*: MiniObjectDisposeFunction
    free*: MiniObjectFreeFunction
    privUint*: uint32
    privPointer*: pointer
  MiniObject* = ref object
    impl*: ptr MiniObject00
    ignoreFinalizer*: bool

proc gst_mini_object_add_parent(self: ptr MiniObject00; parent: ptr MiniObject00) {.
    importc, libprag.}

proc addParent*(self: MiniObject; parent: MiniObject) =
  gst_mini_object_add_parent(cast[ptr MiniObject00](self.impl), cast[ptr MiniObject00](parent.impl))

proc gst_mini_object_get_qdata(self: ptr MiniObject00; quark: uint32): pointer {.
    importc, libprag.}

proc getQdata*(self: MiniObject; quark: int): pointer =
  gst_mini_object_get_qdata(cast[ptr MiniObject00](self.impl), uint32(quark))

proc gst_mini_object_is_writable(self: ptr MiniObject00): gboolean {.
    importc, libprag.}

proc isWritable*(self: MiniObject): bool =
  toBool(gst_mini_object_is_writable(cast[ptr MiniObject00](self.impl)))

proc gst_mini_object_lock(self: ptr MiniObject00; flags: LockFlags): gboolean {.
    importc, libprag.}

proc lock*(self: MiniObject; flags: LockFlags): bool =
  toBool(gst_mini_object_lock(cast[ptr MiniObject00](self.impl), flags))

proc gst_mini_object_remove_parent(self: ptr MiniObject00; parent: ptr MiniObject00) {.
    importc, libprag.}

proc removeParent*(self: MiniObject; parent: MiniObject) =
  gst_mini_object_remove_parent(cast[ptr MiniObject00](self.impl), cast[ptr MiniObject00](parent.impl))

proc gst_mini_object_set_qdata(self: ptr MiniObject00; quark: uint32; data: pointer;
    destroy: DestroyNotify) {.
    importc, libprag.}

proc setQdata*(self: MiniObject; quark: int; data: pointer;
    destroy: DestroyNotify) =
  gst_mini_object_set_qdata(cast[ptr MiniObject00](self.impl), uint32(quark), data, destroy)

proc gst_mini_object_steal_qdata(self: ptr MiniObject00; quark: uint32): pointer {.
    importc, libprag.}

proc stealQdata*(self: MiniObject; quark: int): pointer =
  gst_mini_object_steal_qdata(cast[ptr MiniObject00](self.impl), uint32(quark))

proc gst_mini_object_unlock(self: ptr MiniObject00; flags: LockFlags) {.
    importc, libprag.}

proc unlock*(self: MiniObject; flags: LockFlags) =
  gst_mini_object_unlock(cast[ptr MiniObject00](self.impl), flags)

type
  MiniObjectNotify* = proc (userData: pointer; obj: ptr MiniObject00) {.cdecl.}

type
  Message00* {.pure.} = object
    miniObject*: MiniObject00
    `type`*: MessageType
    timestamp*: uint64
    src*: ptr Object00
    seqnum*: uint32
    lock*: glib.Mutex
    cond*: glib.Cond
  Message* = ref object
    impl*: ptr Message00
    ignoreFinalizer*: bool

proc gst_message_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMessage*(self: Message) =
  if not self.ignoreFinalizer:
    boxedFree(gst_message_get_type(), cast[ptr Message00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Message()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_message_get_type(), cast[ptr Message00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Message) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMessage)

proc gst_message_new_application(src: ptr Object00; structure: ptr Structure00): ptr Message00 {.
    importc, libprag.}

proc newMessageApplication*(src: Object = nil; structure: Structure): Message =
  let impl0 = gst_message_new_application(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageApplication*(tdesc: typedesc; src: Object = nil; structure: Structure): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_application(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageApplication*[T](result: var T; src: Object = nil; structure: Structure) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_application(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_new_async_done(src: ptr Object00; runningTime: uint64): ptr Message00 {.
    importc, libprag.}

proc newMessageAsyncDone*(src: Object = nil; runningTime: uint64): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_async_done(if src.isNil: nil else: cast[ptr Object00](src.impl), runningTime)

proc newMessageAsyncDone*(tdesc: typedesc; src: Object = nil; runningTime: uint64): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_async_done(if src.isNil: nil else: cast[ptr Object00](src.impl), runningTime)

proc initMessageAsyncDone*[T](result: var T; src: Object = nil; runningTime: uint64) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_async_done(if src.isNil: nil else: cast[ptr Object00](src.impl), runningTime)

proc gst_message_new_async_start(src: ptr Object00): ptr Message00 {.
    importc, libprag.}

proc newMessageAsyncStart*(src: Object = nil): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_async_start(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc newMessageAsyncStart*(tdesc: typedesc; src: Object = nil): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_async_start(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc initMessageAsyncStart*[T](result: var T; src: Object = nil) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_async_start(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc gst_message_new_buffering(src: ptr Object00; percent: int32): ptr Message00 {.
    importc, libprag.}

proc newMessageBuffering*(src: Object = nil; percent: int): Message =
  let impl0 = gst_message_new_buffering(if src.isNil: nil else: cast[ptr Object00](src.impl), int32(percent))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageBuffering*(tdesc: typedesc; src: Object = nil; percent: int): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_buffering(if src.isNil: nil else: cast[ptr Object00](src.impl), int32(percent))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageBuffering*[T](result: var T; src: Object = nil; percent: int) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_buffering(if src.isNil: nil else: cast[ptr Object00](src.impl), int32(percent))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_new_clock_lost(src: ptr Object00; clock: ptr Clock00): ptr Message00 {.
    importc, libprag.}

proc newMessageClockLost*(src: Object = nil; clock: Clock): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_clock_lost(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl))

proc newMessageClockLost*(tdesc: typedesc; src: Object = nil; clock: Clock): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_clock_lost(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl))

proc initMessageClockLost*[T](result: var T; src: Object = nil; clock: Clock) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_clock_lost(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl))

proc gst_message_new_clock_provide(src: ptr Object00; clock: ptr Clock00;
    ready: gboolean): ptr Message00 {.
    importc, libprag.}

proc newMessageClockProvide*(src: Object = nil; clock: Clock; ready: bool): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_clock_provide(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl), gboolean(ready))

proc newMessageClockProvide*(tdesc: typedesc; src: Object = nil; clock: Clock; ready: bool): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_clock_provide(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl), gboolean(ready))

proc initMessageClockProvide*[T](result: var T; src: Object = nil; clock: Clock; ready: bool) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_clock_provide(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl), gboolean(ready))

proc gst_message_new_custom(`type`: MessageType; src: ptr Object00; structure: ptr Structure00): ptr Message00 {.
    importc, libprag.}

proc newMessageCustom*(`type`: MessageType; src: Object = nil; structure: Structure = nil): Message =
  let impl0 = gst_message_new_custom(`type`, if src.isNil: nil else: cast[ptr Object00](src.impl), if structure.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageCustom*(tdesc: typedesc; `type`: MessageType; src: Object = nil; structure: Structure = nil): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_custom(`type`, if src.isNil: nil else: cast[ptr Object00](src.impl), if structure.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageCustom*[T](result: var T; `type`: MessageType; src: Object = nil; structure: Structure = nil) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_custom(`type`, if src.isNil: nil else: cast[ptr Object00](src.impl), if structure.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_new_device_added(src: ptr Object00; device: ptr Device00): ptr Message00 {.
    importc, libprag.}

proc newMessageDeviceAdded*(src: Object; device: Device): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_added(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl))

proc newMessageDeviceAdded*(tdesc: typedesc; src: Object; device: Device): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_added(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl))

proc initMessageDeviceAdded*[T](result: var T; src: Object; device: Device) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_added(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl))

proc gst_message_new_device_changed(src: ptr Object00; device: ptr Device00;
    changedDevice: ptr Device00): ptr Message00 {.
    importc, libprag.}

proc newMessageDeviceChanged*(src: Object; device: Device; changedDevice: Device): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_changed(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl), cast[ptr Device00](changedDevice.impl))

proc newMessageDeviceChanged*(tdesc: typedesc; src: Object; device: Device; changedDevice: Device): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_changed(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl), cast[ptr Device00](changedDevice.impl))

proc initMessageDeviceChanged*[T](result: var T; src: Object; device: Device; changedDevice: Device) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_changed(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl), cast[ptr Device00](changedDevice.impl))

proc gst_message_new_device_removed(src: ptr Object00; device: ptr Device00): ptr Message00 {.
    importc, libprag.}

proc newMessageDeviceRemoved*(src: Object; device: Device): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_removed(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl))

proc newMessageDeviceRemoved*(tdesc: typedesc; src: Object; device: Device): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_removed(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl))

proc initMessageDeviceRemoved*[T](result: var T; src: Object; device: Device) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_device_removed(cast[ptr Object00](src.impl), cast[ptr Device00](device.impl))

proc gst_message_new_duration_changed(src: ptr Object00): ptr Message00 {.
    importc, libprag.}

proc newMessageDurationChanged*(src: Object = nil): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_duration_changed(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc newMessageDurationChanged*(tdesc: typedesc; src: Object = nil): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_duration_changed(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc initMessageDurationChanged*[T](result: var T; src: Object = nil) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_duration_changed(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc gst_message_new_element(src: ptr Object00; structure: ptr Structure00): ptr Message00 {.
    importc, libprag.}

proc newMessageElement*(src: Object = nil; structure: Structure): Message =
  let impl0 = gst_message_new_element(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageElement*(tdesc: typedesc; src: Object = nil; structure: Structure): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_element(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageElement*[T](result: var T; src: Object = nil; structure: Structure) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_element(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_new_eos(src: ptr Object00): ptr Message00 {.
    importc, libprag.}

proc newMessageEos*(src: Object = nil): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_eos(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc newMessageEos*(tdesc: typedesc; src: Object = nil): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_eos(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc initMessageEos*[T](result: var T; src: Object = nil) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_eos(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc gst_message_new_error(src: ptr Object00; error: ptr glib.Error; debug: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessageError*(src: Object = nil; error: ptr glib.Error; debug: cstring): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_error(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc newMessageError*(tdesc: typedesc; src: Object = nil; error: ptr glib.Error; debug: cstring): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_error(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc initMessageError*[T](result: var T; src: Object = nil; error: ptr glib.Error; debug: cstring) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_error(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc gst_message_new_error_with_details(src: ptr Object00; error: ptr glib.Error;
    debug: cstring; details: ptr Structure00): ptr Message00 {.
    importc, libprag.}

proc newMessageErrorWithDetails*(src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil): Message =
  let impl0 = gst_message_new_error_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageErrorWithDetails*(tdesc: typedesc; src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_error_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageErrorWithDetails*[T](result: var T; src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_error_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_new_have_context(src: ptr Object00; context: ptr Context00): ptr Message00 {.
    importc, libprag.}

proc newMessageHaveContext*(src: Object = nil; context: Context): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_have_context(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Context00](g_boxed_copy(gst_context_get_type(), context.impl)))

proc newMessageHaveContext*(tdesc: typedesc; src: Object = nil; context: Context): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_have_context(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Context00](g_boxed_copy(gst_context_get_type(), context.impl)))

proc initMessageHaveContext*[T](result: var T; src: Object = nil; context: Context) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_have_context(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Context00](g_boxed_copy(gst_context_get_type(), context.impl)))

proc gst_message_new_info(src: ptr Object00; error: ptr glib.Error; debug: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessageInfo*(src: Object = nil; error: ptr glib.Error; debug: cstring): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_info(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc newMessageInfo*(tdesc: typedesc; src: Object = nil; error: ptr glib.Error; debug: cstring): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_info(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc initMessageInfo*[T](result: var T; src: Object = nil; error: ptr glib.Error; debug: cstring) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_info(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc gst_message_new_info_with_details(src: ptr Object00; error: ptr glib.Error;
    debug: cstring; details: ptr Structure00): ptr Message00 {.
    importc, libprag.}

proc newMessageInfoWithDetails*(src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil): Message =
  let impl0 = gst_message_new_info_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageInfoWithDetails*(tdesc: typedesc; src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_info_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageInfoWithDetails*[T](result: var T; src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_info_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_new_instant_rate_request(src: ptr Object00; rateMultiplier: cdouble): ptr Message00 {.
    importc, libprag.}

proc newMessageInstantRateRequest*(src: Object; rateMultiplier: cdouble): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_instant_rate_request(cast[ptr Object00](src.impl), rateMultiplier)

proc newMessageInstantRateRequest*(tdesc: typedesc; src: Object; rateMultiplier: cdouble): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_instant_rate_request(cast[ptr Object00](src.impl), rateMultiplier)

proc initMessageInstantRateRequest*[T](result: var T; src: Object; rateMultiplier: cdouble) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_instant_rate_request(cast[ptr Object00](src.impl), rateMultiplier)

proc gst_message_new_latency(src: ptr Object00): ptr Message00 {.
    importc, libprag.}

proc newMessageLatency*(src: Object = nil): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_latency(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc newMessageLatency*(tdesc: typedesc; src: Object = nil): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_latency(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc initMessageLatency*[T](result: var T; src: Object = nil) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_latency(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc gst_message_new_need_context(src: ptr Object00; contextType: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessageNeedContext*(src: Object = nil; contextType: cstring): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_need_context(if src.isNil: nil else: cast[ptr Object00](src.impl), contextType)

proc newMessageNeedContext*(tdesc: typedesc; src: Object = nil; contextType: cstring): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_need_context(if src.isNil: nil else: cast[ptr Object00](src.impl), contextType)

proc initMessageNeedContext*[T](result: var T; src: Object = nil; contextType: cstring) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_need_context(if src.isNil: nil else: cast[ptr Object00](src.impl), contextType)

proc gst_message_new_new_clock(src: ptr Object00; clock: ptr Clock00): ptr Message00 {.
    importc, libprag.}

proc newMessageNewClock*(src: Object = nil; clock: Clock): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_new_clock(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl))

proc newMessageNewClock*(tdesc: typedesc; src: Object = nil; clock: Clock): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_new_clock(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl))

proc initMessageNewClock*[T](result: var T; src: Object = nil; clock: Clock) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_new_clock(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr Clock00](clock.impl))

proc gst_message_new_property_notify(src: ptr Object00; propertyName: cstring;
    val: gobject.Value): ptr Message00 {.
    importc, libprag.}

proc newMessagePropertyNotify*(src: Object; propertyName: cstring;
    val: gobject.Value = cast[var gobject.Value](nil)): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_property_notify(cast[ptr Object00](src.impl), propertyName, val)

proc newMessagePropertyNotify*(tdesc: typedesc; src: Object; propertyName: cstring;
    val: gobject.Value = cast[var gobject.Value](nil)): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_property_notify(cast[ptr Object00](src.impl), propertyName, val)

proc initMessagePropertyNotify*[T](result: var T; src: Object; propertyName: cstring;
    val: gobject.Value = cast[var gobject.Value](nil)) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_property_notify(cast[ptr Object00](src.impl), propertyName, val)

proc gst_message_new_qos(src: ptr Object00; live: gboolean; runningTime: uint64;
    streamTime: uint64; timestamp: uint64; duration: uint64): ptr Message00 {.
    importc, libprag.}

proc newMessageQos*(src: Object; live: bool; runningTime: uint64; streamTime: uint64;
    timestamp: uint64; duration: uint64): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_qos(cast[ptr Object00](src.impl), gboolean(live), runningTime, streamTime, timestamp, duration)

proc newMessageQos*(tdesc: typedesc; src: Object; live: bool; runningTime: uint64; streamTime: uint64;
    timestamp: uint64; duration: uint64): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_qos(cast[ptr Object00](src.impl), gboolean(live), runningTime, streamTime, timestamp, duration)

proc initMessageQos*[T](result: var T; src: Object; live: bool; runningTime: uint64; streamTime: uint64;
    timestamp: uint64; duration: uint64) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_qos(cast[ptr Object00](src.impl), gboolean(live), runningTime, streamTime, timestamp, duration)

proc gst_message_new_redirect(src: ptr Object00; location: cstring; tagList: ptr TagList00;
    entryStruct: ptr Structure00): ptr Message00 {.
    importc, libprag.}

proc newMessageRedirect*(src: Object; location: cstring; tagList: TagList = nil;
    entryStruct: Structure = nil): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_redirect(cast[ptr Object00](src.impl), location, if tagList.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl)), if entryStruct.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), entryStruct.impl)))

proc newMessageRedirect*(tdesc: typedesc; src: Object; location: cstring; tagList: TagList = nil;
    entryStruct: Structure = nil): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_redirect(cast[ptr Object00](src.impl), location, if tagList.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl)), if entryStruct.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), entryStruct.impl)))

proc initMessageRedirect*[T](result: var T; src: Object; location: cstring; tagList: TagList = nil;
    entryStruct: Structure = nil) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_redirect(cast[ptr Object00](src.impl), location, if tagList.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl)), if entryStruct.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), entryStruct.impl)))

proc gst_message_new_request_state(src: ptr Object00; state: State): ptr Message00 {.
    importc, libprag.}

proc newMessageRequestState*(src: Object = nil; state: State): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_request_state(if src.isNil: nil else: cast[ptr Object00](src.impl), state)

proc newMessageRequestState*(tdesc: typedesc; src: Object = nil; state: State): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_request_state(if src.isNil: nil else: cast[ptr Object00](src.impl), state)

proc initMessageRequestState*[T](result: var T; src: Object = nil; state: State) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_request_state(if src.isNil: nil else: cast[ptr Object00](src.impl), state)

proc gst_message_new_reset_time(src: ptr Object00; runningTime: uint64): ptr Message00 {.
    importc, libprag.}

proc newMessageResetTime*(src: Object = nil; runningTime: uint64): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_reset_time(if src.isNil: nil else: cast[ptr Object00](src.impl), runningTime)

proc newMessageResetTime*(tdesc: typedesc; src: Object = nil; runningTime: uint64): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_reset_time(if src.isNil: nil else: cast[ptr Object00](src.impl), runningTime)

proc initMessageResetTime*[T](result: var T; src: Object = nil; runningTime: uint64) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_reset_time(if src.isNil: nil else: cast[ptr Object00](src.impl), runningTime)

proc gst_message_new_segment_done(src: ptr Object00; format: Format; position: int64): ptr Message00 {.
    importc, libprag.}

proc newMessageSegmentDone*(src: Object = nil; format: Format; position: int64): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_segment_done(if src.isNil: nil else: cast[ptr Object00](src.impl), format, position)

proc newMessageSegmentDone*(tdesc: typedesc; src: Object = nil; format: Format; position: int64): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_segment_done(if src.isNil: nil else: cast[ptr Object00](src.impl), format, position)

proc initMessageSegmentDone*[T](result: var T; src: Object = nil; format: Format; position: int64) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_segment_done(if src.isNil: nil else: cast[ptr Object00](src.impl), format, position)

proc gst_message_new_segment_start(src: ptr Object00; format: Format; position: int64): ptr Message00 {.
    importc, libprag.}

proc newMessageSegmentStart*(src: Object = nil; format: Format; position: int64): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_segment_start(if src.isNil: nil else: cast[ptr Object00](src.impl), format, position)

proc newMessageSegmentStart*(tdesc: typedesc; src: Object = nil; format: Format; position: int64): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_segment_start(if src.isNil: nil else: cast[ptr Object00](src.impl), format, position)

proc initMessageSegmentStart*[T](result: var T; src: Object = nil; format: Format; position: int64) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_segment_start(if src.isNil: nil else: cast[ptr Object00](src.impl), format, position)

proc gst_message_new_state_dirty(src: ptr Object00): ptr Message00 {.
    importc, libprag.}

proc newMessageStateDirty*(src: Object = nil): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_state_dirty(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc newMessageStateDirty*(tdesc: typedesc; src: Object = nil): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_state_dirty(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc initMessageStateDirty*[T](result: var T; src: Object = nil) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_state_dirty(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc gst_message_new_step_done(src: ptr Object00; format: Format; amount: uint64;
    rate: cdouble; flush: gboolean; intermediate: gboolean; duration: uint64;
    eos: gboolean): ptr Message00 {.
    importc, libprag.}

proc newMessageStepDone*(src: Object; format: Format; amount: uint64;
    rate: cdouble; flush: bool; intermediate: bool; duration: uint64; eos: bool): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_step_done(cast[ptr Object00](src.impl), format, amount, rate, gboolean(flush), gboolean(intermediate), duration, gboolean(eos))

proc newMessageStepDone*(tdesc: typedesc; src: Object; format: Format; amount: uint64;
    rate: cdouble; flush: bool; intermediate: bool; duration: uint64; eos: bool): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_step_done(cast[ptr Object00](src.impl), format, amount, rate, gboolean(flush), gboolean(intermediate), duration, gboolean(eos))

proc initMessageStepDone*[T](result: var T; src: Object; format: Format; amount: uint64;
    rate: cdouble; flush: bool; intermediate: bool; duration: uint64; eos: bool) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_step_done(cast[ptr Object00](src.impl), format, amount, rate, gboolean(flush), gboolean(intermediate), duration, gboolean(eos))

proc gst_message_new_step_start(src: ptr Object00; active: gboolean; format: Format;
    amount: uint64; rate: cdouble; flush: gboolean; intermediate: gboolean): ptr Message00 {.
    importc, libprag.}

proc newMessageStepStart*(src: Object; active: bool; format: Format;
    amount: uint64; rate: cdouble; flush: bool; intermediate: bool): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_step_start(cast[ptr Object00](src.impl), gboolean(active), format, amount, rate, gboolean(flush), gboolean(intermediate))

proc newMessageStepStart*(tdesc: typedesc; src: Object; active: bool; format: Format;
    amount: uint64; rate: cdouble; flush: bool; intermediate: bool): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_step_start(cast[ptr Object00](src.impl), gboolean(active), format, amount, rate, gboolean(flush), gboolean(intermediate))

proc initMessageStepStart*[T](result: var T; src: Object; active: bool; format: Format;
    amount: uint64; rate: cdouble; flush: bool; intermediate: bool) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_step_start(cast[ptr Object00](src.impl), gboolean(active), format, amount, rate, gboolean(flush), gboolean(intermediate))

proc gst_message_new_stream_collection(src: ptr Object00; collection: ptr StreamCollection00): ptr Message00 {.
    importc, libprag.}

proc newMessageStreamCollection*(src: Object; collection: StreamCollection): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_collection(cast[ptr Object00](src.impl), cast[ptr StreamCollection00](collection.impl))

proc newMessageStreamCollection*(tdesc: typedesc; src: Object; collection: StreamCollection): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_collection(cast[ptr Object00](src.impl), cast[ptr StreamCollection00](collection.impl))

proc initMessageStreamCollection*[T](result: var T; src: Object; collection: StreamCollection) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_collection(cast[ptr Object00](src.impl), cast[ptr StreamCollection00](collection.impl))

proc gst_message_new_stream_start(src: ptr Object00): ptr Message00 {.
    importc, libprag.}

proc newMessageStreamStart*(src: Object = nil): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_start(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc newMessageStreamStart*(tdesc: typedesc; src: Object = nil): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_start(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc initMessageStreamStart*[T](result: var T; src: Object = nil) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_start(if src.isNil: nil else: cast[ptr Object00](src.impl))

proc gst_message_new_streams_selected(src: ptr Object00; collection: ptr StreamCollection00): ptr Message00 {.
    importc, libprag.}

proc newMessageStreamsSelected*(src: Object; collection: StreamCollection): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_streams_selected(cast[ptr Object00](src.impl), cast[ptr StreamCollection00](collection.impl))

proc newMessageStreamsSelected*(tdesc: typedesc; src: Object; collection: StreamCollection): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_streams_selected(cast[ptr Object00](src.impl), cast[ptr StreamCollection00](collection.impl))

proc initMessageStreamsSelected*[T](result: var T; src: Object; collection: StreamCollection) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_streams_selected(cast[ptr Object00](src.impl), cast[ptr StreamCollection00](collection.impl))

proc gst_message_new_tag(src: ptr Object00; tagList: ptr TagList00): ptr Message00 {.
    importc, libprag.}

proc newMessageTag*(src: Object = nil; tagList: TagList): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_tag(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl)))

proc newMessageTag*(tdesc: typedesc; src: Object = nil; tagList: TagList): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_tag(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl)))

proc initMessageTag*[T](result: var T; src: Object = nil; tagList: TagList) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_tag(if src.isNil: nil else: cast[ptr Object00](src.impl), cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl)))

proc gst_message_new_toc(src: ptr Object00; toc: ptr Toc00; updated: gboolean): ptr Message00 {.
    importc, libprag.}

proc newMessageToc*(src: Object; toc: Toc; updated: bool): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_toc(cast[ptr Object00](src.impl), cast[ptr Toc00](toc.impl), gboolean(updated))

proc newMessageToc*(tdesc: typedesc; src: Object; toc: Toc; updated: bool): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_toc(cast[ptr Object00](src.impl), cast[ptr Toc00](toc.impl), gboolean(updated))

proc initMessageToc*[T](result: var T; src: Object; toc: Toc; updated: bool) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_toc(cast[ptr Object00](src.impl), cast[ptr Toc00](toc.impl), gboolean(updated))

proc gst_message_new_warning(src: ptr Object00; error: ptr glib.Error; debug: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessageWarning*(src: Object = nil; error: ptr glib.Error; debug: cstring): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_warning(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc newMessageWarning*(tdesc: typedesc; src: Object = nil; error: ptr glib.Error; debug: cstring): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_warning(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc initMessageWarning*[T](result: var T; src: Object = nil; error: ptr glib.Error; debug: cstring) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_warning(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug)

proc gst_message_new_warning_with_details(src: ptr Object00; error: ptr glib.Error;
    debug: cstring; details: ptr Structure00): ptr Message00 {.
    importc, libprag.}

proc newMessageWarningWithDetails*(src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil): Message =
  let impl0 = gst_message_new_warning_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageWarningWithDetails*(tdesc: typedesc; src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_warning_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageWarningWithDetails*[T](result: var T; src: Object = nil; error: ptr glib.Error;
    debug: cstring; details: Structure = nil) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_warning_with_details(if src.isNil: nil else: cast[ptr Object00](src.impl), error, debug, if details.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), details.impl)))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_add_redirect_entry(self: ptr Message00; location: cstring;
    tagList: ptr TagList00; entryStruct: ptr Structure00) {.
    importc, libprag.}

proc addRedirectEntry*(self: Message; location: cstring; tagList: TagList = nil;
    entryStruct: Structure = nil) =
  gst_message_add_redirect_entry(cast[ptr Message00](self.impl), location, if tagList.isNil: nil else: cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl)), if entryStruct.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), entryStruct.impl)))

proc gst_message_get_num_redirect_entries(self: ptr Message00): uint64 {.
    importc, libprag.}

proc getNumRedirectEntries*(self: Message): uint64 =
  gst_message_get_num_redirect_entries(cast[ptr Message00](self.impl))

proc numRedirectEntries*(self: Message): uint64 =
  gst_message_get_num_redirect_entries(cast[ptr Message00](self.impl))

proc gst_message_get_seqnum(self: ptr Message00): uint32 {.
    importc, libprag.}

proc getSeqnum*(self: Message): int =
  int(gst_message_get_seqnum(cast[ptr Message00](self.impl)))

proc seqnum*(self: Message): int =
  int(gst_message_get_seqnum(cast[ptr Message00](self.impl)))

proc gst_message_get_stream_status_object(self: ptr Message00): ptr gobject.Value {.
    importc, libprag.}

proc getStreamStatusObject*(self: Message): ptr gobject.Value =
  gst_message_get_stream_status_object(cast[ptr Message00](self.impl))

proc streamStatusObject*(self: Message): ptr gobject.Value =
  gst_message_get_stream_status_object(cast[ptr Message00](self.impl))

proc gst_message_get_structure(self: ptr Message00): ptr Structure00 {.
    importc, libprag.}

proc getStructure*(self: Message): Structure =
  let impl0 = gst_message_get_structure(cast[ptr Message00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc structure*(self: Message): Structure =
  let impl0 = gst_message_get_structure(cast[ptr Message00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc gst_message_has_name(self: ptr Message00; name: cstring): gboolean {.
    importc, libprag.}

proc hasName*(self: Message; name: cstring): bool =
  toBool(gst_message_has_name(cast[ptr Message00](self.impl), name))

proc gst_message_parse_async_done(self: ptr Message00; runningTime: var uint64) {.
    importc, libprag.}

proc parseAsyncDone*(self: Message; runningTime: var uint64 = cast[var uint64](nil)) =
  gst_message_parse_async_done(cast[ptr Message00](self.impl), runningTime)

proc parseAsyncDone*(self: Message): uint64  =
  gst_message_parse_async_done(cast[ptr Message00](self.impl), result)

proc gst_message_parse_buffering(self: ptr Message00; percent: var int32) {.
    importc, libprag.}

proc parseBuffering*(self: Message; percent: var int = cast[var int](nil)) =
  var percent_00: int32
  gst_message_parse_buffering(cast[ptr Message00](self.impl), percent_00)
  if percent.addr != nil:
    percent = int(percent_00)

proc parseBuffering*(self: Message): int  =
  var result_00: int32
  gst_message_parse_buffering(cast[ptr Message00](self.impl), result_00)
  if result.addr != nil:
    result = int(result_00)

proc gst_message_parse_buffering_stats(self: ptr Message00; mode: var BufferingMode;
    avgIn: var int32; avgOut: var int32; bufferingLeft: var int64) {.
    importc, libprag.}

proc parseBufferingStats*(self: Message; mode: var BufferingMode = cast[var BufferingMode](nil);
    avgIn: var int = cast[var int](nil); avgOut: var int = cast[var int](nil);
    bufferingLeft: var int64 = cast[var int64](nil)) =
  var avgOut_00: int32
  var avgIn_00: int32
  gst_message_parse_buffering_stats(cast[ptr Message00](self.impl), mode, avgIn_00, avgOut_00, bufferingLeft)
  if avgOut.addr != nil:
    avgOut = int(avgOut_00)
  if avgIn.addr != nil:
    avgIn = int(avgIn_00)

proc gst_message_parse_clock_lost(self: ptr Message00; clock: var ptr Clock00) {.
    importc, libprag.}

proc parseClockLost*(self: Message; clock: var Clock = cast[var Clock](nil)) =
  var tmpoutgobjectarg: ptr Clock00
  gst_message_parse_clock_lost(cast[ptr Message00](self.impl), cast[var ptr Clock00](if addr(clock) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(clock
  if addr(clock) != nil:
    clock = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      clock = cast[type(clock)](argqdata)
      assert(clock.impl == tmpoutgobjectarg)
    else:
      fnew(clock, gst.finalizeGObject)
      clock.impl = tmpoutgobjectarg
      GC_ref(clock)
      if g_object_is_floating(clock.impl).int != 0:
        discard g_object_ref_sink(clock.impl)
      g_object_add_toggle_ref(clock.impl, toggleNotify, addr(clock[]))
      g_object_unref(clock.impl)
      assert(g_object_get_qdata(clock.impl, Quark) == nil)
      g_object_set_qdata(clock.impl, Quark, addr(clock[]))


proc parseClockLost*(self: Message): Clock  =
  var tmpoutgobjectarg: ptr Clock00
  gst_message_parse_clock_lost(cast[ptr Message00](self.impl), cast[var ptr Clock00](if addr(result) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(result
  if addr(result) != nil:
    result = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      result = cast[type(result)](argqdata)
      assert(result.impl == tmpoutgobjectarg)
    else:
      fnew(result, gst.finalizeGObject)
      result.impl = tmpoutgobjectarg
      GC_ref(result)
      if g_object_is_floating(result.impl).int != 0:
        discard g_object_ref_sink(result.impl)
      g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
      g_object_unref(result.impl)
      assert(g_object_get_qdata(result.impl, Quark) == nil)
      g_object_set_qdata(result.impl, Quark, addr(result[]))


proc gst_message_parse_clock_provide(self: ptr Message00; clock: var ptr Clock00;
    ready: var gboolean) {.
    importc, libprag.}

proc parseClockProvide*(self: Message; clock: var Clock = cast[var Clock](nil);
    ready: var bool = cast[var bool](nil)) =
  var tmpoutgobjectarg: ptr Clock00
  var ready_00: gboolean
  gst_message_parse_clock_provide(cast[ptr Message00](self.impl), cast[var ptr Clock00](if addr(clock) == nil: nil else: addr tmpoutgobjectarg), ready_00)
  if ready.addr != nil:
    ready = toBool(ready_00)
#  dothemagic(clock
  if addr(clock) != nil:
    clock = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      clock = cast[type(clock)](argqdata)
      assert(clock.impl == tmpoutgobjectarg)
    else:
      fnew(clock, gst.finalizeGObject)
      clock.impl = tmpoutgobjectarg
      GC_ref(clock)
      if g_object_is_floating(clock.impl).int != 0:
        discard g_object_ref_sink(clock.impl)
      g_object_add_toggle_ref(clock.impl, toggleNotify, addr(clock[]))
      g_object_unref(clock.impl)
      assert(g_object_get_qdata(clock.impl, Quark) == nil)
      g_object_set_qdata(clock.impl, Quark, addr(clock[]))


proc gst_message_parse_context_type(self: ptr Message00; contextType: var cstring): gboolean {.
    importc, libprag.}

proc parseContextType*(self: Message; contextType: var string = cast[var string](nil)): bool =
  var contextType_00: cstring
  result = toBool(gst_message_parse_context_type(cast[ptr Message00](self.impl), contextType_00))
  if contextType.addr != nil:
    contextType = $(contextType_00)

proc gst_message_parse_device_added(self: ptr Message00; device: var ptr Device00) {.
    importc, libprag.}

proc parseDeviceAdded*(self: Message; device: var Device = cast[var Device](nil)) =
  var tmpoutgobjectarg: ptr Device00
  gst_message_parse_device_added(cast[ptr Message00](self.impl), cast[var ptr Device00](if addr(device) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(device
  if addr(device) != nil:
    device = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      device = cast[type(device)](argqdata)
      assert(device.impl == tmpoutgobjectarg)
    else:
      fnew(device, gst.finalizeGObject)
      device.impl = tmpoutgobjectarg
      GC_ref(device)
      if g_object_is_floating(device.impl).int != 0:
        discard g_object_ref_sink(device.impl)
      g_object_add_toggle_ref(device.impl, toggleNotify, addr(device[]))
      g_object_unref(device.impl)
      assert(g_object_get_qdata(device.impl, Quark) == nil)
      g_object_set_qdata(device.impl, Quark, addr(device[]))


proc parseDeviceAdded*(self: Message): Device  =
  var tmpoutgobjectarg: ptr Device00
  gst_message_parse_device_added(cast[ptr Message00](self.impl), cast[var ptr Device00](if addr(result) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(result
  if addr(result) != nil:
    result = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      result = cast[type(result)](argqdata)
      assert(result.impl == tmpoutgobjectarg)
    else:
      fnew(result, gst.finalizeGObject)
      result.impl = tmpoutgobjectarg
      GC_ref(result)
      if g_object_is_floating(result.impl).int != 0:
        discard g_object_ref_sink(result.impl)
      g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
      g_object_unref(result.impl)
      assert(g_object_get_qdata(result.impl, Quark) == nil)
      g_object_set_qdata(result.impl, Quark, addr(result[]))


proc gst_message_parse_device_changed(self: ptr Message00; device: var ptr Device00;
    changedDevice: var ptr Device00) {.
    importc, libprag.}

proc parseDeviceChanged*(self: Message; device: var Device = cast[var Device](nil);
    changedDevice: var Device = cast[var Device](nil)) =
  var tmpoutgobjectarg: ptr Device00
  gst_message_parse_device_changed(cast[ptr Message00](self.impl), cast[var ptr Device00](if addr(device) == nil: nil else: addr tmpoutgobjectarg), cast[var ptr Device00](if addr(changedDevice) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(changedDevice
  if addr(changedDevice) != nil:
    changedDevice = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      changedDevice = cast[type(changedDevice)](argqdata)
      assert(changedDevice.impl == tmpoutgobjectarg)
    else:
      fnew(changedDevice, gst.finalizeGObject)
      changedDevice.impl = tmpoutgobjectarg
      GC_ref(changedDevice)
      if g_object_is_floating(changedDevice.impl).int != 0:
        discard g_object_ref_sink(changedDevice.impl)
      g_object_add_toggle_ref(changedDevice.impl, toggleNotify, addr(changedDevice[]))
      g_object_unref(changedDevice.impl)
      assert(g_object_get_qdata(changedDevice.impl, Quark) == nil)
      g_object_set_qdata(changedDevice.impl, Quark, addr(changedDevice[]))


proc gst_message_parse_device_removed(self: ptr Message00; device: var ptr Device00) {.
    importc, libprag.}

proc parseDeviceRemoved*(self: Message; device: var Device = cast[var Device](nil)) =
  var tmpoutgobjectarg: ptr Device00
  gst_message_parse_device_removed(cast[ptr Message00](self.impl), cast[var ptr Device00](if addr(device) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(device
  if addr(device) != nil:
    device = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      device = cast[type(device)](argqdata)
      assert(device.impl == tmpoutgobjectarg)
    else:
      fnew(device, gst.finalizeGObject)
      device.impl = tmpoutgobjectarg
      GC_ref(device)
      if g_object_is_floating(device.impl).int != 0:
        discard g_object_ref_sink(device.impl)
      g_object_add_toggle_ref(device.impl, toggleNotify, addr(device[]))
      g_object_unref(device.impl)
      assert(g_object_get_qdata(device.impl, Quark) == nil)
      g_object_set_qdata(device.impl, Quark, addr(device[]))


proc parseDeviceRemoved*(self: Message): Device  =
  var tmpoutgobjectarg: ptr Device00
  gst_message_parse_device_removed(cast[ptr Message00](self.impl), cast[var ptr Device00](if addr(result) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(result
  if addr(result) != nil:
    result = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      result = cast[type(result)](argqdata)
      assert(result.impl == tmpoutgobjectarg)
    else:
      fnew(result, gst.finalizeGObject)
      result.impl = tmpoutgobjectarg
      GC_ref(result)
      if g_object_is_floating(result.impl).int != 0:
        discard g_object_ref_sink(result.impl)
      g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
      g_object_unref(result.impl)
      assert(g_object_get_qdata(result.impl, Quark) == nil)
      g_object_set_qdata(result.impl, Quark, addr(result[]))


proc gst_message_parse_error(self: ptr Message00; gerror: var ptr glib.Error;
    debug: var cstring) {.
    importc, libprag.}

proc parseError*(self: Message; gerror: var ptr glib.Error = cast[var ptr glib.Error](nil);
    debug: var string = cast[var string](nil)) =
  var debug_00: cstring
  gst_message_parse_error(cast[ptr Message00](self.impl), gerror, debug_00)
  if debug.addr != nil:
    debug = $(debug_00)

proc gst_message_parse_error_details(self: ptr Message00; structure: var ptr Structure00) {.
    importc, libprag.}

proc parseErrorDetails*(self: Message; structure: var Structure) =
  fnew(structure, gBoxedFreeGstStructure)
  gst_message_parse_error_details(cast[ptr Message00](self.impl), cast[var ptr Structure00](addr structure.impl))
  structure.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl))

proc parseErrorDetails*(self: Message): Structure =
  fnew(result, gBoxedFreeGstStructure)
  gst_message_parse_error_details(cast[ptr Message00](self.impl), cast[var ptr Structure00](addr result.impl))
  result.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_message_parse_group_id(self: ptr Message00; groupId: var uint32): gboolean {.
    importc, libprag.}

proc parseGroupId*(self: Message; groupId: var int = cast[var int](nil)): bool =
  var groupId_00: uint32
  result = toBool(gst_message_parse_group_id(cast[ptr Message00](self.impl), groupId_00))
  if groupId.addr != nil:
    groupId = int(groupId_00)

proc gst_message_parse_have_context(self: ptr Message00; context: var ptr Context00) {.
    importc, libprag.}

proc parseHaveContext*(self: Message; context: var Context = cast[var Context](nil)) =
  if addr(context) != nil:
    fnew(context, gBoxedFreeGstContext)
  gst_message_parse_have_context(cast[ptr Message00](self.impl), cast[var ptr Context00](if addr(context) == nil: nil else: addr context.impl))

proc parseHaveContext*(self: Message): Context  =
  if addr(result) != nil:
    fnew(result, gBoxedFreeGstContext)
  gst_message_parse_have_context(cast[ptr Message00](self.impl), cast[var ptr Context00](if addr(result) == nil: nil else: addr result.impl))

proc gst_message_parse_info(self: ptr Message00; gerror: var ptr glib.Error;
    debug: var cstring) {.
    importc, libprag.}

proc parseInfo*(self: Message; gerror: var ptr glib.Error = cast[var ptr glib.Error](nil);
    debug: var string = cast[var string](nil)) =
  var debug_00: cstring
  gst_message_parse_info(cast[ptr Message00](self.impl), gerror, debug_00)
  if debug.addr != nil:
    debug = $(debug_00)

proc gst_message_parse_info_details(self: ptr Message00; structure: var ptr Structure00) {.
    importc, libprag.}

proc parseInfoDetails*(self: Message; structure: var Structure) =
  fnew(structure, gBoxedFreeGstStructure)
  gst_message_parse_info_details(cast[ptr Message00](self.impl), cast[var ptr Structure00](addr structure.impl))
  structure.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl))

proc parseInfoDetails*(self: Message): Structure =
  fnew(result, gBoxedFreeGstStructure)
  gst_message_parse_info_details(cast[ptr Message00](self.impl), cast[var ptr Structure00](addr result.impl))
  result.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_message_parse_instant_rate_request(self: ptr Message00; rateMultiplier: var cdouble) {.
    importc, libprag.}

proc parseInstantRateRequest*(self: Message; rateMultiplier: var cdouble = cast[var cdouble](nil)) =
  gst_message_parse_instant_rate_request(cast[ptr Message00](self.impl), rateMultiplier)

proc parseInstantRateRequest*(self: Message): cdouble  =
  gst_message_parse_instant_rate_request(cast[ptr Message00](self.impl), result)

proc gst_message_parse_new_clock(self: ptr Message00; clock: var ptr Clock00) {.
    importc, libprag.}

proc parseNewClock*(self: Message; clock: var Clock = cast[var Clock](nil)) =
  var tmpoutgobjectarg: ptr Clock00
  gst_message_parse_new_clock(cast[ptr Message00](self.impl), cast[var ptr Clock00](if addr(clock) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(clock
  if addr(clock) != nil:
    clock = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      clock = cast[type(clock)](argqdata)
      assert(clock.impl == tmpoutgobjectarg)
    else:
      fnew(clock, gst.finalizeGObject)
      clock.impl = tmpoutgobjectarg
      GC_ref(clock)
      if g_object_is_floating(clock.impl).int != 0:
        discard g_object_ref_sink(clock.impl)
      g_object_add_toggle_ref(clock.impl, toggleNotify, addr(clock[]))
      g_object_unref(clock.impl)
      assert(g_object_get_qdata(clock.impl, Quark) == nil)
      g_object_set_qdata(clock.impl, Quark, addr(clock[]))


proc parseNewClock*(self: Message): Clock  =
  var tmpoutgobjectarg: ptr Clock00
  gst_message_parse_new_clock(cast[ptr Message00](self.impl), cast[var ptr Clock00](if addr(result) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(result
  if addr(result) != nil:
    result = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      result = cast[type(result)](argqdata)
      assert(result.impl == tmpoutgobjectarg)
    else:
      fnew(result, gst.finalizeGObject)
      result.impl = tmpoutgobjectarg
      GC_ref(result)
      if g_object_is_floating(result.impl).int != 0:
        discard g_object_ref_sink(result.impl)
      g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
      g_object_unref(result.impl)
      assert(g_object_get_qdata(result.impl, Quark) == nil)
      g_object_set_qdata(result.impl, Quark, addr(result[]))


proc gst_message_parse_property_notify(self: ptr Message00; `object`: var ptr Object00;
    propertyName: var cstring; propertyValue: var gobject.Value) {.
    importc, libprag.}

proc parsePropertyNotify*(self: Message; `object`: var Object = cast[var Object](nil);
    propertyName: var string = cast[var string](nil); propertyValue: var gobject.Value = cast[var gobject.Value](nil)) =
  var tmpoutgobjectarg: ptr Object00
  var propertyName_00: cstring
  gst_message_parse_property_notify(cast[ptr Message00](self.impl), cast[var ptr Object00](if addr(`object`) == nil: nil else: addr tmpoutgobjectarg), propertyName_00, propertyValue)
  if propertyName.addr != nil:
    propertyName = $(propertyName_00)
#  dothemagic(`object`
  if addr(`object`) != nil:
    `object` = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      `object` = cast[type(`object`)](argqdata)
      assert(`object`.impl == tmpoutgobjectarg)
    else:
      fnew(`object`, gst.finalizeGObject)
      `object`.impl = tmpoutgobjectarg
      GC_ref(`object`)
      if g_object_is_floating(`object`.impl).int != 0:
        discard g_object_ref_sink(`object`.impl)
      g_object_add_toggle_ref(`object`.impl, toggleNotify, addr(`object`[]))
      g_object_unref(`object`.impl)
      assert(g_object_get_qdata(`object`.impl, Quark) == nil)
      g_object_set_qdata(`object`.impl, Quark, addr(`object`[]))


proc gst_message_parse_qos(self: ptr Message00; live: var gboolean; runningTime: var uint64;
    streamTime: var uint64; timestamp: var uint64; duration: var uint64) {.
    importc, libprag.}

proc parseQos*(self: Message; live: var bool = cast[var bool](nil);
    runningTime: var uint64 = cast[var uint64](nil); streamTime: var uint64 = cast[var uint64](nil);
    timestamp: var uint64 = cast[var uint64](nil); duration: var uint64 = cast[var uint64](nil)) =
  var live_00: gboolean
  gst_message_parse_qos(cast[ptr Message00](self.impl), live_00, runningTime, streamTime, timestamp, duration)
  if live.addr != nil:
    live = toBool(live_00)

proc gst_message_parse_qos_stats(self: ptr Message00; format: var Format;
    processed: var uint64; dropped: var uint64) {.
    importc, libprag.}

proc parseQosStats*(self: Message; format: var Format = cast[var Format](nil);
    processed: var uint64 = cast[var uint64](nil); dropped: var uint64 = cast[var uint64](nil)) =
  gst_message_parse_qos_stats(cast[ptr Message00](self.impl), format, processed, dropped)

proc gst_message_parse_qos_values(self: ptr Message00; jitter: var int64;
    proportion: var cdouble; quality: var int32) {.
    importc, libprag.}

proc parseQosValues*(self: Message; jitter: var int64 = cast[var int64](nil);
    proportion: var cdouble = cast[var cdouble](nil); quality: var int = cast[var int](nil)) =
  var quality_00: int32
  gst_message_parse_qos_values(cast[ptr Message00](self.impl), jitter, proportion, quality_00)
  if quality.addr != nil:
    quality = int(quality_00)

proc gst_message_parse_redirect_entry(self: ptr Message00; entryIndex: uint64;
    location: var cstring; tagList: var ptr TagList00; entryStruct: var ptr Structure00) {.
    importc, libprag.}

proc parseRedirectEntry*(self: Message; entryIndex: uint64;
    location: var string = cast[var string](nil); tagList: var TagList = cast[var TagList](nil);
    entryStruct: var Structure = cast[var Structure](nil)) =
  if addr(tagList) != nil:
    fnew(tagList, gBoxedFreeGstTagList)
  if addr(entryStruct) != nil:
    fnew(entryStruct, gBoxedFreeGstStructure)
  var location_00: cstring
  gst_message_parse_redirect_entry(cast[ptr Message00](self.impl), entryIndex, location_00, cast[var ptr TagList00](if addr(tagList) == nil: nil else: addr tagList.impl), cast[var ptr Structure00](if addr(entryStruct) == nil: nil else: addr entryStruct.impl))
  tagList.impl = cast[ptr TagList00](g_boxed_copy(gst_tag_list_get_type(), tagList.impl))
  entryStruct.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), entryStruct.impl))
  if location.addr != nil:
    location = $(location_00)

proc gst_message_parse_request_state(self: ptr Message00; state: var State) {.
    importc, libprag.}

proc parseRequestState*(self: Message; state: var State = cast[var State](nil)) =
  gst_message_parse_request_state(cast[ptr Message00](self.impl), state)

proc parseRequestState*(self: Message): State  =
  gst_message_parse_request_state(cast[ptr Message00](self.impl), result)

proc gst_message_parse_reset_time(self: ptr Message00; runningTime: var uint64) {.
    importc, libprag.}

proc parseResetTime*(self: Message; runningTime: var uint64 = cast[var uint64](nil)) =
  gst_message_parse_reset_time(cast[ptr Message00](self.impl), runningTime)

proc parseResetTime*(self: Message): uint64  =
  gst_message_parse_reset_time(cast[ptr Message00](self.impl), result)

proc gst_message_parse_segment_done(self: ptr Message00; format: var Format;
    position: var int64) {.
    importc, libprag.}

proc parseSegmentDone*(self: Message; format: var Format = cast[var Format](nil);
    position: var int64 = cast[var int64](nil)) =
  gst_message_parse_segment_done(cast[ptr Message00](self.impl), format, position)

proc gst_message_parse_segment_start(self: ptr Message00; format: var Format;
    position: var int64) {.
    importc, libprag.}

proc parseSegmentStart*(self: Message; format: var Format = cast[var Format](nil);
    position: var int64 = cast[var int64](nil)) =
  gst_message_parse_segment_start(cast[ptr Message00](self.impl), format, position)

proc gst_message_parse_state_changed(self: ptr Message00; oldstate: var State;
    newstate: var State; pending: var State) {.
    importc, libprag.}

proc parseStateChanged*(self: Message; oldstate: var State = cast[var State](nil);
    newstate: var State = cast[var State](nil); pending: var State = cast[var State](nil)) =
  gst_message_parse_state_changed(cast[ptr Message00](self.impl), oldstate, newstate, pending)

proc gst_message_parse_step_done(self: ptr Message00; format: var Format;
    amount: var uint64; rate: var cdouble; flush: var gboolean; intermediate: var gboolean;
    duration: var uint64; eos: var gboolean) {.
    importc, libprag.}

proc parseStepDone*(self: Message; format: var Format = cast[var Format](nil);
    amount: var uint64 = cast[var uint64](nil); rate: var cdouble = cast[var cdouble](nil);
    flush: var bool = cast[var bool](nil); intermediate: var bool = cast[var bool](nil);
    duration: var uint64 = cast[var uint64](nil); eos: var bool = cast[var bool](nil)) =
  var intermediate_00: gboolean
  var flush_00: gboolean
  var eos_00: gboolean
  gst_message_parse_step_done(cast[ptr Message00](self.impl), format, amount, rate, flush_00, intermediate_00, duration, eos_00)
  if intermediate.addr != nil:
    intermediate = toBool(intermediate_00)
  if flush.addr != nil:
    flush = toBool(flush_00)
  if eos.addr != nil:
    eos = toBool(eos_00)

proc gst_message_parse_step_start(self: ptr Message00; active: var gboolean;
    format: var Format; amount: var uint64; rate: var cdouble; flush: var gboolean;
    intermediate: var gboolean) {.
    importc, libprag.}

proc parseStepStart*(self: Message; active: var bool = cast[var bool](nil);
    format: var Format = cast[var Format](nil); amount: var uint64 = cast[var uint64](nil);
    rate: var cdouble = cast[var cdouble](nil); flush: var bool = cast[var bool](nil);
    intermediate: var bool = cast[var bool](nil)) =
  var intermediate_00: gboolean
  var flush_00: gboolean
  var active_00: gboolean
  gst_message_parse_step_start(cast[ptr Message00](self.impl), active_00, format, amount, rate, flush_00, intermediate_00)
  if intermediate.addr != nil:
    intermediate = toBool(intermediate_00)
  if flush.addr != nil:
    flush = toBool(flush_00)
  if active.addr != nil:
    active = toBool(active_00)

proc gst_message_parse_stream_collection(self: ptr Message00; collection: var ptr StreamCollection00) {.
    importc, libprag.}

proc parseStreamCollection*(self: Message; collection: var StreamCollection = cast[var StreamCollection](nil)) =
  var tmpoutgobjectarg: ptr StreamCollection00
  gst_message_parse_stream_collection(cast[ptr Message00](self.impl), cast[var ptr StreamCollection00](if addr(collection) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(collection
  if addr(collection) != nil:
    collection = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      collection = cast[type(collection)](argqdata)
      assert(collection.impl == tmpoutgobjectarg)
    else:
      fnew(collection, gst.finalizeGObject)
      collection.impl = tmpoutgobjectarg
      GC_ref(collection)
      if g_object_is_floating(collection.impl).int != 0:
        discard g_object_ref_sink(collection.impl)
      g_object_add_toggle_ref(collection.impl, toggleNotify, addr(collection[]))
      g_object_unref(collection.impl)
      assert(g_object_get_qdata(collection.impl, Quark) == nil)
      g_object_set_qdata(collection.impl, Quark, addr(collection[]))


proc parseStreamCollection*(self: Message): StreamCollection  =
  var tmpoutgobjectarg: ptr StreamCollection00
  gst_message_parse_stream_collection(cast[ptr Message00](self.impl), cast[var ptr StreamCollection00](if addr(result) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(result
  if addr(result) != nil:
    result = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      result = cast[type(result)](argqdata)
      assert(result.impl == tmpoutgobjectarg)
    else:
      fnew(result, gst.finalizeGObject)
      result.impl = tmpoutgobjectarg
      GC_ref(result)
      if g_object_is_floating(result.impl).int != 0:
        discard g_object_ref_sink(result.impl)
      g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
      g_object_unref(result.impl)
      assert(g_object_get_qdata(result.impl, Quark) == nil)
      g_object_set_qdata(result.impl, Quark, addr(result[]))


proc gst_message_parse_streams_selected(self: ptr Message00; collection: var ptr StreamCollection00) {.
    importc, libprag.}

proc parseStreamsSelected*(self: Message; collection: var StreamCollection = cast[var StreamCollection](nil)) =
  var tmpoutgobjectarg: ptr StreamCollection00
  gst_message_parse_streams_selected(cast[ptr Message00](self.impl), cast[var ptr StreamCollection00](if addr(collection) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(collection
  if addr(collection) != nil:
    collection = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      collection = cast[type(collection)](argqdata)
      assert(collection.impl == tmpoutgobjectarg)
    else:
      fnew(collection, gst.finalizeGObject)
      collection.impl = tmpoutgobjectarg
      GC_ref(collection)
      if g_object_is_floating(collection.impl).int != 0:
        discard g_object_ref_sink(collection.impl)
      g_object_add_toggle_ref(collection.impl, toggleNotify, addr(collection[]))
      g_object_unref(collection.impl)
      assert(g_object_get_qdata(collection.impl, Quark) == nil)
      g_object_set_qdata(collection.impl, Quark, addr(collection[]))


proc parseStreamsSelected*(self: Message): StreamCollection  =
  var tmpoutgobjectarg: ptr StreamCollection00
  gst_message_parse_streams_selected(cast[ptr Message00](self.impl), cast[var ptr StreamCollection00](if addr(result) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(result
  if addr(result) != nil:
    result = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      result = cast[type(result)](argqdata)
      assert(result.impl == tmpoutgobjectarg)
    else:
      fnew(result, gst.finalizeGObject)
      result.impl = tmpoutgobjectarg
      GC_ref(result)
      if g_object_is_floating(result.impl).int != 0:
        discard g_object_ref_sink(result.impl)
      g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
      g_object_unref(result.impl)
      assert(g_object_get_qdata(result.impl, Quark) == nil)
      g_object_set_qdata(result.impl, Quark, addr(result[]))


proc gst_message_parse_tag(self: ptr Message00; tagList: var ptr TagList00) {.
    importc, libprag.}

proc parseTag*(self: Message; tagList: var TagList) =
  fnew(tagList, gBoxedFreeGstTagList)
  gst_message_parse_tag(cast[ptr Message00](self.impl), cast[var ptr TagList00](addr tagList.impl))

proc parseTag*(self: Message): TagList =
  fnew(result, gBoxedFreeGstTagList)
  gst_message_parse_tag(cast[ptr Message00](self.impl), cast[var ptr TagList00](addr result.impl))

proc gst_message_parse_toc(self: ptr Message00; toc: var ptr Toc00; updated: var gboolean) {.
    importc, libprag.}

proc parseToc*(self: Message; toc: var Toc; updated: var bool) =
  fnew(toc, gBoxedFreeGstToc)
  var updated_00: gboolean
  gst_message_parse_toc(cast[ptr Message00](self.impl), cast[var ptr Toc00](addr toc.impl), updated_00)
  if updated.addr != nil:
    updated = toBool(updated_00)

proc gst_message_parse_warning(self: ptr Message00; gerror: var ptr glib.Error;
    debug: var cstring) {.
    importc, libprag.}

proc parseWarning*(self: Message; gerror: var ptr glib.Error = cast[var ptr glib.Error](nil);
    debug: var string = cast[var string](nil)) =
  var debug_00: cstring
  gst_message_parse_warning(cast[ptr Message00](self.impl), gerror, debug_00)
  if debug.addr != nil:
    debug = $(debug_00)

proc gst_message_parse_warning_details(self: ptr Message00; structure: var ptr Structure00) {.
    importc, libprag.}

proc parseWarningDetails*(self: Message; structure: var Structure) =
  fnew(structure, gBoxedFreeGstStructure)
  gst_message_parse_warning_details(cast[ptr Message00](self.impl), cast[var ptr Structure00](addr structure.impl))
  structure.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), structure.impl))

proc parseWarningDetails*(self: Message): Structure =
  fnew(result, gBoxedFreeGstStructure)
  gst_message_parse_warning_details(cast[ptr Message00](self.impl), cast[var ptr Structure00](addr result.impl))
  result.impl = cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_message_set_buffering_stats(self: ptr Message00; mode: BufferingMode;
    avgIn: int32; avgOut: int32; bufferingLeft: int64) {.
    importc, libprag.}

proc setBufferingStats*(self: Message; mode: BufferingMode;
    avgIn: int; avgOut: int; bufferingLeft: int64) =
  gst_message_set_buffering_stats(cast[ptr Message00](self.impl), mode, int32(avgIn), int32(avgOut), bufferingLeft)

proc gst_message_set_group_id(self: ptr Message00; groupId: uint32) {.
    importc, libprag.}

proc setGroupId*(self: Message; groupId: int) =
  gst_message_set_group_id(cast[ptr Message00](self.impl), uint32(groupId))

proc `groupId=`*(self: Message; groupId: int) =
  gst_message_set_group_id(cast[ptr Message00](self.impl), uint32(groupId))

proc gst_message_set_qos_stats(self: ptr Message00; format: Format; processed: uint64;
    dropped: uint64) {.
    importc, libprag.}

proc setQosStats*(self: Message; format: Format; processed: uint64;
    dropped: uint64) =
  gst_message_set_qos_stats(cast[ptr Message00](self.impl), format, processed, dropped)

proc gst_message_set_qos_values(self: ptr Message00; jitter: int64; proportion: cdouble;
    quality: int32) {.
    importc, libprag.}

proc setQosValues*(self: Message; jitter: int64; proportion: cdouble;
    quality: int) =
  gst_message_set_qos_values(cast[ptr Message00](self.impl), jitter, proportion, int32(quality))

proc gst_message_set_seqnum(self: ptr Message00; seqnum: uint32) {.
    importc, libprag.}

proc setSeqnum*(self: Message; seqnum: int) =
  gst_message_set_seqnum(cast[ptr Message00](self.impl), uint32(seqnum))

proc `seqnum=`*(self: Message; seqnum: int) =
  gst_message_set_seqnum(cast[ptr Message00](self.impl), uint32(seqnum))

proc gst_message_set_stream_status_object(self: ptr Message00; `object`: gobject.Value) {.
    importc, libprag.}

proc setStreamStatusObject*(self: Message; `object`: gobject.Value) =
  gst_message_set_stream_status_object(cast[ptr Message00](self.impl), `object`)

proc `streamStatusObject=`*(self: Message; `object`: gobject.Value) =
  gst_message_set_stream_status_object(cast[ptr Message00](self.impl), `object`)

proc gst_message_streams_selected_add(self: ptr Message00; stream: ptr Stream00) {.
    importc, libprag.}

proc streamsSelectedAdd*(self: Message; stream: Stream) =
  gst_message_streams_selected_add(cast[ptr Message00](self.impl), cast[ptr Stream00](stream.impl))

proc gst_message_streams_selected_get_size(self: ptr Message00): uint32 {.
    importc, libprag.}

proc streamsSelectedGetSize*(self: Message): int =
  int(gst_message_streams_selected_get_size(cast[ptr Message00](self.impl)))

proc gst_message_streams_selected_get_stream(self: ptr Message00; idx: uint32): ptr Stream00 {.
    importc, libprag.}

proc streamsSelectedGetStream*(self: Message; idx: int): Stream =
  let gobj = gst_message_streams_selected_get_stream(cast[ptr Message00](self.impl), uint32(idx))
  if gobj.isNil:
    return nil
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

proc gst_message_writable_structure(self: ptr Message00): ptr Structure00 {.
    importc, libprag.}

proc writableStructure*(self: Message): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_message_writable_structure(cast[ptr Message00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))
type

  BusSyncHandler* = proc (bus: ptr Bus00; message: ptr Message00; userData: pointer): BusSyncReply {.cdecl.}

  Bus* = ref object of Object
  Bus00* = object of Object00

proc gst_bus_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Bus()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scMessage*(self: Bus;  p: proc (self: ptr Bus00; message: ptr Message00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "message", cast[GCallback](p), xdata, nil, cf)

proc scSyncMessage*(self: Bus;  p: proc (self: ptr Bus00; message: ptr Message00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "sync-message", cast[GCallback](p), xdata, nil, cf)

proc gst_bus_new(): ptr Bus00 {.
    importc, libprag.}

proc newBus*(): Bus =
  let gobj = gst_bus_new()
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

proc newBus*(tdesc: typedesc): tdesc =
  assert(result is Bus)
  let gobj = gst_bus_new()
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

proc initBus*[T](result: var T) {.deprecated.} =
  assert(result is Bus)
  let gobj = gst_bus_new()
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

proc gst_bus_add_signal_watch(self: ptr Bus00) {.
    importc, libprag.}

proc addSignalWatch*(self: Bus) =
  gst_bus_add_signal_watch(cast[ptr Bus00](self.impl))

proc gst_bus_add_signal_watch_full(self: ptr Bus00; priority: int32) {.
    importc, libprag.}

proc addSignalWatchFull*(self: Bus; priority: int) =
  gst_bus_add_signal_watch_full(cast[ptr Bus00](self.impl), int32(priority))

proc gst_bus_async_signal_func(self: ptr Bus00; message: ptr Message00; data: pointer): gboolean {.
    importc, libprag.}

proc asyncSignalFunc*(self: Bus; message: Message; data: pointer): bool =
  toBool(gst_bus_async_signal_func(cast[ptr Bus00](self.impl), cast[ptr Message00](message.impl), data))

proc gst_bus_create_watch(self: ptr Bus00): ptr glib.Source00 {.
    importc, libprag.}

proc createWatch*(self: Bus): glib.Source =
  let impl0 = gst_bus_create_watch(cast[ptr Bus00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGSource)
  result.impl = impl0

proc gst_bus_disable_sync_message_emission(self: ptr Bus00) {.
    importc, libprag.}

proc disableSyncMessageEmission*(self: Bus) =
  gst_bus_disable_sync_message_emission(cast[ptr Bus00](self.impl))

proc gst_bus_enable_sync_message_emission(self: ptr Bus00) {.
    importc, libprag.}

proc enableSyncMessageEmission*(self: Bus) =
  gst_bus_enable_sync_message_emission(cast[ptr Bus00](self.impl))

proc gst_bus_get_pollfd(self: ptr Bus00; fd: var glib.PollFD) {.
    importc, libprag.}

proc getPollfd*(self: Bus; fd: var glib.PollFD) =
  gst_bus_get_pollfd(cast[ptr Bus00](self.impl), fd)

proc getPollfd*(self: Bus): glib.PollFD =
  gst_bus_get_pollfd(cast[ptr Bus00](self.impl), result)

proc gst_bus_have_pending(self: ptr Bus00): gboolean {.
    importc, libprag.}

proc havePending*(self: Bus): bool =
  toBool(gst_bus_have_pending(cast[ptr Bus00](self.impl)))

proc gst_bus_peek(self: ptr Bus00): ptr Message00 {.
    importc, libprag.}

proc peek*(self: Bus): Message =
  let impl0 = gst_bus_peek(cast[ptr Bus00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_bus_poll(self: ptr Bus00; events: MessageType; timeout: uint64): ptr Message00 {.
    importc, libprag.}

proc poll*(self: Bus; events: MessageType; timeout: uint64): Message =
  let impl0 = gst_bus_poll(cast[ptr Bus00](self.impl), events, timeout)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_bus_pop(self: ptr Bus00): ptr Message00 {.
    importc, libprag.}

proc pop*(self: Bus): Message =
  let impl0 = gst_bus_pop(cast[ptr Bus00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_bus_pop_filtered(self: ptr Bus00; types: MessageType): ptr Message00 {.
    importc, libprag.}

proc popFiltered*(self: Bus; types: MessageType): Message =
  let impl0 = gst_bus_pop_filtered(cast[ptr Bus00](self.impl), types)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_bus_post(self: ptr Bus00; message: ptr Message00): gboolean {.
    importc, libprag.}

proc post*(self: Bus; message: Message): bool =
  toBool(gst_bus_post(cast[ptr Bus00](self.impl), cast[ptr Message00](g_boxed_copy(gst_message_get_type(), message.impl))))

proc gst_bus_remove_signal_watch(self: ptr Bus00) {.
    importc, libprag.}

proc removeSignalWatch*(self: Bus) =
  gst_bus_remove_signal_watch(cast[ptr Bus00](self.impl))

proc gst_bus_remove_watch(self: ptr Bus00): gboolean {.
    importc, libprag.}

proc removeWatch*(self: Bus): bool =
  toBool(gst_bus_remove_watch(cast[ptr Bus00](self.impl)))

proc gst_bus_set_flushing(self: ptr Bus00; flushing: gboolean) {.
    importc, libprag.}

proc setFlushing*(self: Bus; flushing: bool = true) =
  gst_bus_set_flushing(cast[ptr Bus00](self.impl), gboolean(flushing))

proc `flushing=`*(self: Bus; flushing: bool) =
  gst_bus_set_flushing(cast[ptr Bus00](self.impl), gboolean(flushing))

proc gst_bus_set_sync_handler(self: ptr Bus00; `func`: BusSyncHandler; userData: pointer;
    notify: DestroyNotify) {.
    importc, libprag.}

proc setSyncHandler*(self: Bus; `func`: BusSyncHandler; userData: pointer;
    notify: DestroyNotify) =
  gst_bus_set_sync_handler(cast[ptr Bus00](self.impl), `func`, userData, notify)

proc gst_bus_sync_signal_handler(self: ptr Bus00; message: ptr Message00;
    data: pointer): BusSyncReply {.
    importc, libprag.}

proc syncSignalHandler*(self: Bus; message: Message; data: pointer): BusSyncReply =
  gst_bus_sync_signal_handler(cast[ptr Bus00](self.impl), cast[ptr Message00](message.impl), data)

proc gst_bus_timed_pop(self: ptr Bus00; timeout: uint64): ptr Message00 {.
    importc, libprag.}

proc timedPop*(self: Bus; timeout: uint64): Message =
  let impl0 = gst_bus_timed_pop(cast[ptr Bus00](self.impl), timeout)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_bus_timed_pop_filtered(self: ptr Bus00; timeout: uint64; types: MessageType): ptr Message00 {.
    importc, libprag.}

proc timedPopFiltered*(self: Bus; timeout: uint64; types: MessageType): Message =
  let impl0 = gst_bus_timed_pop_filtered(cast[ptr Bus00](self.impl), timeout, types)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_element_get_bus(self: ptr Element00): ptr Bus00 {.
    importc, libprag.}

proc getBus*(self: Element): Bus =
  let gobj = gst_element_get_bus(cast[ptr Element00](self.impl))
  if gobj.isNil:
    return nil
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

proc bus*(self: Element): Bus =
  let gobj = gst_element_get_bus(cast[ptr Element00](self.impl))
  if gobj.isNil:
    return nil
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

proc gst_element_post_message(self: ptr Element00; message: ptr Message00): gboolean {.
    importc, libprag.}

proc postMessage*(self: Element; message: Message): bool =
  toBool(gst_element_post_message(cast[ptr Element00](self.impl), cast[ptr Message00](g_boxed_copy(gst_message_get_type(), message.impl))))

proc gst_element_set_bus(self: ptr Element00; bus: ptr Bus00) {.
    importc, libprag.}

proc setBus*(self: Element; bus: Bus = nil) =
  gst_element_set_bus(cast[ptr Element00](self.impl), if bus.isNil: nil else: cast[ptr Bus00](bus.impl))

proc `bus=`*(self: Element; bus: Bus = nil) =
  gst_element_set_bus(cast[ptr Element00](self.impl), if bus.isNil: nil else: cast[ptr Bus00](bus.impl))

proc gst_event_new_sink_message(name: cstring; msg: ptr Message00): ptr Event00 {.
    importc, libprag.}

proc newEventSinkMessage*(name: cstring; msg: Message): Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_sink_message(name, cast[ptr Message00](msg.impl))

proc newEventSinkMessage*(tdesc: typedesc; name: cstring; msg: Message): tdesc =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_sink_message(name, cast[ptr Message00](msg.impl))

proc initEventSinkMessage*[T](result: var T; name: cstring; msg: Message) {.deprecated.} =
  assert(result is Event)
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_event_new_sink_message(name, cast[ptr Message00](msg.impl))

proc gst_event_parse_sink_message(self: ptr Event00; msg: var ptr Message00) {.
    importc, libprag.}

proc parseSinkMessage*(self: Event; msg: var Message) =
  fnew(msg, gBoxedFreeGstMessage)
  gst_event_parse_sink_message(cast[ptr Event00](self.impl), cast[var ptr Message00](addr msg.impl))

proc parseSinkMessage*(self: Event): Message =
  fnew(result, gBoxedFreeGstMessage)
  gst_event_parse_sink_message(cast[ptr Event00](self.impl), cast[var ptr Message00](addr result.impl))

proc gst_pipeline_get_bus(self: ptr Pipeline00): ptr Bus00 {.
    importc, libprag.}

proc getBus*(self: Pipeline): Bus =
  let gobj = gst_pipeline_get_bus(cast[ptr Pipeline00](self.impl))
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

proc bus*(self: Pipeline): Bus =
  let gobj = gst_pipeline_get_bus(cast[ptr Pipeline00](self.impl))
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

proc gst_device_monitor_get_bus(self: ptr DeviceMonitor00): ptr Bus00 {.
    importc, libprag.}

proc getBus*(self: DeviceMonitor): Bus =
  let gobj = gst_device_monitor_get_bus(cast[ptr DeviceMonitor00](self.impl))
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

proc bus*(self: DeviceMonitor): Bus =
  let gobj = gst_device_monitor_get_bus(cast[ptr DeviceMonitor00](self.impl))
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

proc gst_device_provider_get_bus(self: ptr DeviceProvider00): ptr Bus00 {.
    importc, libprag.}

proc getBus*(self: DeviceProvider): Bus =
  let gobj = gst_device_provider_get_bus(cast[ptr DeviceProvider00](self.impl))
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

proc bus*(self: DeviceProvider): Bus =
  let gobj = gst_device_provider_get_bus(cast[ptr DeviceProvider00](self.impl))
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
  ProgressType* {.size: sizeof(cint), pure.} = enum
    start = 0
    `continue` = 1
    complete = 2
    canceled = 3
    error = 4

type
  BusFunc* = proc (bus: ptr Bus00; message: ptr Message00; userData: pointer): gboolean {.cdecl.}

proc gst_message_new_progress(src: ptr Object00; `type`: ProgressType; code: cstring;
    text: cstring): ptr Message00 {.
    importc, libprag.}

proc newMessageProgress*(src: Object; `type`: ProgressType; code: cstring;
    text: cstring): Message =
  let impl0 = gst_message_new_progress(cast[ptr Object00](src.impl), `type`, code, text)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc newMessageProgress*(tdesc: typedesc; src: Object; `type`: ProgressType; code: cstring;
    text: cstring): tdesc =
  assert(result is Message)
  let impl0 = gst_message_new_progress(cast[ptr Object00](src.impl), `type`, code, text)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc initMessageProgress*[T](result: var T; src: Object; `type`: ProgressType; code: cstring;
    text: cstring) {.deprecated.} =
  assert(result is Message)
  let impl0 = gst_message_new_progress(cast[ptr Object00](src.impl), `type`, code, text)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMessage)
  result.impl = impl0

proc gst_message_parse_progress(self: ptr Message00; `type`: var ProgressType;
    code: var cstring; text: var cstring) {.
    importc, libprag.}

proc parseProgress*(self: Message; `type`: var ProgressType = cast[var ProgressType](nil);
    code: var string = cast[var string](nil); text: var string = cast[var string](nil)) =
  var code_00: cstring
  var text_00: cstring
  gst_message_parse_progress(cast[ptr Message00](self.impl), `type`, code_00, text_00)
  if code.addr != nil:
    code = $(code_00)
  if text.addr != nil:
    text = $(text_00)

proc gst_bus_add_watch_full*(self: ptr Bus00; priority: int32; `func`: BusFunc;
    userData: pointer; notify: DestroyNotify): uint32 {.
    importc, libprag.}

proc addWatch*(self: Bus; priority: int; `func`: BusFunc; userData: pointer;
    notify: DestroyNotify): int =
  int(gst_bus_add_watch_full(cast[ptr Bus00](self.impl), int32(priority), `func`, userData, notify))

type
  StreamStatusType* {.size: sizeof(cint), pure.} = enum
    create = 0
    enter = 1
    leave = 2
    destroy = 3
    start = 8
    pause = 9
    stop = 10

proc gst_message_new_stream_status(src: ptr Object00; `type`: StreamStatusType;
    owner: ptr Element00): ptr Message00 {.
    importc, libprag.}

proc newMessageStreamStatus*(src: Object; `type`: StreamStatusType;
    owner: Element): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_status(cast[ptr Object00](src.impl), `type`, cast[ptr Element00](owner.impl))

proc newMessageStreamStatus*(tdesc: typedesc; src: Object; `type`: StreamStatusType;
    owner: Element): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_status(cast[ptr Object00](src.impl), `type`, cast[ptr Element00](owner.impl))

proc initMessageStreamStatus*[T](result: var T; src: Object; `type`: StreamStatusType;
    owner: Element) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_stream_status(cast[ptr Object00](src.impl), `type`, cast[ptr Element00](owner.impl))

proc gst_message_parse_stream_status(self: ptr Message00; `type`: var StreamStatusType;
    owner: var ptr Element00) {.
    importc, libprag.}

proc parseStreamStatus*(self: Message; `type`: var StreamStatusType;
    owner: var Element) =
  var tmpoutgobjectarg: ptr Element00
  gst_message_parse_stream_status(cast[ptr Message00](self.impl), `type`, tmpoutgobjectarg)
#  dothemagic(owner
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    owner = cast[type(owner)](argqdata)
    assert(owner.impl == tmpoutgobjectarg)
  else:
    fnew(owner, gst.finalizeGObject)
    owner.impl = tmpoutgobjectarg
    GC_ref(owner)
    if g_object_is_floating(owner.impl).int != 0:
      discard g_object_ref_sink(owner.impl)
    g_object_add_toggle_ref(owner.impl, toggleNotify, addr(owner[]))
    g_object_unref(owner.impl)
    assert(g_object_get_qdata(owner.impl, Quark) == nil)
    g_object_set_qdata(owner.impl, Quark, addr(owner[]))


type
  StructureChangeType* {.size: sizeof(cint), pure.} = enum
    link = 0
    unlink = 1

proc gst_message_new_structure_change(src: ptr Object00; `type`: StructureChangeType;
    owner: ptr Element00; busy: gboolean): ptr Message00 {.
    importc, libprag.}

proc newMessageStructureChange*(src: Object = nil; `type`: StructureChangeType;
    owner: Element; busy: bool): Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_structure_change(if src.isNil: nil else: cast[ptr Object00](src.impl), `type`, cast[ptr Element00](owner.impl), gboolean(busy))

proc newMessageStructureChange*(tdesc: typedesc; src: Object = nil; `type`: StructureChangeType;
    owner: Element; busy: bool): tdesc =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_structure_change(if src.isNil: nil else: cast[ptr Object00](src.impl), `type`, cast[ptr Element00](owner.impl), gboolean(busy))

proc initMessageStructureChange*[T](result: var T; src: Object = nil; `type`: StructureChangeType;
    owner: Element; busy: bool) {.deprecated.} =
  assert(result is Message)
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_message_new_structure_change(if src.isNil: nil else: cast[ptr Object00](src.impl), `type`, cast[ptr Element00](owner.impl), gboolean(busy))

proc gst_message_parse_structure_change(self: ptr Message00; `type`: var StructureChangeType;
    owner: var ptr Element00; busy: var gboolean) {.
    importc, libprag.}

proc parseStructureChange*(self: Message; `type`: var StructureChangeType;
    owner: var Element = cast[var Element](nil); busy: var bool = cast[var bool](nil)) =
  var tmpoutgobjectarg: ptr Element00
  var busy_00: gboolean
  gst_message_parse_structure_change(cast[ptr Message00](self.impl), `type`, cast[var ptr Element00](if addr(owner) == nil: nil else: addr tmpoutgobjectarg), busy_00)
  if busy.addr != nil:
    busy = toBool(busy_00)
#  dothemagic(owner
  if addr(owner) != nil:
    owner = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      owner = cast[type(owner)](argqdata)
      assert(owner.impl == tmpoutgobjectarg)
    else:
      fnew(owner, gst.finalizeGObject)
      owner.impl = tmpoutgobjectarg
      GC_ref(owner)
      if g_object_is_floating(owner.impl).int != 0:
        discard g_object_ref_sink(owner.impl)
      g_object_add_toggle_ref(owner.impl, toggleNotify, addr(owner[]))
      g_object_unref(owner.impl)
      assert(g_object_get_qdata(owner.impl, Quark) == nil)
      g_object_set_qdata(owner.impl, Quark, addr(owner[]))


const NSECOND* = 1'i64

type
  ObjectClass00* {.pure.} = object
  ObjectClass* = ref object
    impl*: ptr ObjectClass00
    ignoreFinalizer*: bool

type
  ObjectFlag* {.size: sizeof(cint), pure.} = enum
    mayBeLeaked = 0
    last = 4

  ObjectFlags* {.size: sizeof(cint).} = set[ObjectFlag]

const PARAM_CONDITIONALLY_AVAILABLE* = 16384'i32

const PARAM_CONTROLLABLE* = 512'i32

const PARAM_DOC_SHOW_DEFAULT* = 8192'i32

const PARAM_MUTABLE_PAUSED* = 2048'i32

const PARAM_MUTABLE_PLAYING* = 4096'i32

const PARAM_MUTABLE_READY* = 1024'i32

const PARAM_USER_SHIFT* = 65536'i32

const PROTECTION_SYSTEM_ID_CAPS_FIELD* = "protection-system"

const PROTECTION_UNSPECIFIED_SYSTEM_ID* = "unspecified-system-id"

type
  PadActivateFunction* = proc (pad: ptr Pad00; parent: ptr Object00): gboolean {.cdecl.}

proc gst_pad_set_activate_function_full(self: ptr Pad00; activate: PadActivateFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setActivateFunctionFull*(self: Pad; activate: PadActivateFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_activate_function_full(cast[ptr Pad00](self.impl), activate, userData, notify)

type
  PadActivateModeFunction* = proc (pad: ptr Pad00; parent: ptr Object00; mode: PadMode; active: gboolean): gboolean {.cdecl.}

proc gst_pad_set_activatemode_function_full(self: ptr Pad00; activatemode: PadActivateModeFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setActivatemodeFunctionFull*(self: Pad; activatemode: PadActivateModeFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_activatemode_function_full(cast[ptr Pad00](self.impl), activatemode, userData, notify)

type
  PadChainFunction* = proc (pad: ptr Pad00; parent: ptr Object00; buffer: ptr Buffer00): FlowReturn {.cdecl.}

proc gst_pad_set_chain_function_full(self: ptr Pad00; chain: PadChainFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setChainFunctionFull*(self: Pad; chain: PadChainFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_chain_function_full(cast[ptr Pad00](self.impl), chain, userData, notify)

type
  PadChainListFunction* = proc (pad: ptr Pad00; parent: ptr Object00; list: ptr BufferList00): FlowReturn {.cdecl.}

proc gst_pad_set_chain_list_function_full(self: ptr Pad00; chainlist: PadChainListFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setChainListFunctionFull*(self: Pad; chainlist: PadChainListFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_chain_list_function_full(cast[ptr Pad00](self.impl), chainlist, userData, notify)

type
  PadEventFullFunction* = proc (pad: ptr Pad00; parent: ptr Object00; event: ptr Event00): FlowReturn {.cdecl.}

proc gst_pad_set_event_full_function_full(self: ptr Pad00; event: PadEventFullFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setEventFullFunctionFull*(self: Pad; event: PadEventFullFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_event_full_function_full(cast[ptr Pad00](self.impl), event, userData, notify)

type
  PadEventFunction* = proc (pad: ptr Pad00; parent: ptr Object00; event: ptr Event00): gboolean {.cdecl.}

proc gst_pad_set_event_function_full(self: ptr Pad00; event: PadEventFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setEventFunctionFull*(self: Pad; event: PadEventFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_event_function_full(cast[ptr Pad00](self.impl), event, userData, notify)

type
  PadFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    blocked = 4
    flushing = 5
    eos = 6
    blocking = 7
    needParent = 8
    needReconfigure = 9
    pendingEvents = 10
    fixedCaps = 11
    proxyCaps = 12
    proxyAllocation = 13
    proxyScheduling = 14
    acceptIntersect = 15
    acceptTemplate = 16
    last = 20

  PadFlags* {.size: sizeof(cint).} = set[PadFlag]

type
  PadForwardFunction* = proc (pad: ptr Pad00; userData: pointer): gboolean {.cdecl.}

proc gst_pad_forward(self: ptr Pad00; forward: PadForwardFunction; userData: pointer): gboolean {.
    importc, libprag.}

proc forward*(self: Pad; forward: PadForwardFunction; userData: pointer): bool =
  toBool(gst_pad_forward(cast[ptr Pad00](self.impl), forward, userData))

type
  PadGetRangeFunction* = proc (pad: ptr Pad00; parent: ptr Object00; offset: uint64; length: uint32;
    buffer: ptr Buffer00): FlowReturn {.cdecl.}

proc gst_pad_set_getrange_function_full(self: ptr Pad00; get: PadGetRangeFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setGetrangeFunctionFull*(self: Pad; get: PadGetRangeFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_getrange_function_full(cast[ptr Pad00](self.impl), get, userData, notify)

type
  PadIterIntLinkFunction* = proc (pad: ptr Pad00; parent: ptr Object00): ptr Iterator00 {.cdecl.}

proc gst_pad_set_iterate_internal_links_function_full(self: ptr Pad00; iterintlink: PadIterIntLinkFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setIterateInternalLinksFunctionFull*(self: Pad; iterintlink: PadIterIntLinkFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_iterate_internal_links_function_full(cast[ptr Pad00](self.impl), iterintlink, userData, notify)

type
  PadLinkFunction* = proc (pad: ptr Pad00; parent: ptr Object00; peer: ptr Pad00): PadLinkReturn {.cdecl.}

proc gst_pad_set_link_function_full(self: ptr Pad00; link: PadLinkFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setLinkFunctionFull*(self: Pad; link: PadLinkFunction; userData: pointer;
    notify: DestroyNotify) =
  gst_pad_set_link_function_full(cast[ptr Pad00](self.impl), link, userData, notify)

type
  PadProbeInfo00* {.pure.} = object
  PadProbeInfo* = ref object
    impl*: ptr PadProbeInfo00
    ignoreFinalizer*: bool

proc gst_pad_probe_info_get_buffer(self: ptr PadProbeInfo00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: PadProbeInfo): Buffer =
  let impl0 = gst_pad_probe_info_get_buffer(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), impl0))

proc buffer*(self: PadProbeInfo): Buffer =
  let impl0 = gst_pad_probe_info_get_buffer(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), impl0))

proc gst_pad_probe_info_get_buffer_list(self: ptr PadProbeInfo00): ptr BufferList00 {.
    importc, libprag.}

proc getBufferList*(self: PadProbeInfo): BufferList =
  let impl0 = gst_pad_probe_info_get_buffer_list(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_list_get_type(), impl0))

proc bufferList*(self: PadProbeInfo): BufferList =
  let impl0 = gst_pad_probe_info_get_buffer_list(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_list_get_type(), impl0))

proc gst_pad_probe_info_get_event(self: ptr PadProbeInfo00): ptr Event00 {.
    importc, libprag.}

proc getEvent*(self: PadProbeInfo): Event =
  let impl0 = gst_pad_probe_info_get_event(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_event_get_type(), impl0))

proc event*(self: PadProbeInfo): Event =
  let impl0 = gst_pad_probe_info_get_event(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstEvent)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_event_get_type(), impl0))

proc gst_pad_probe_info_get_query(self: ptr PadProbeInfo00): ptr Query00 {.
    importc, libprag.}

proc getQuery*(self: PadProbeInfo): Query =
  let impl0 = gst_pad_probe_info_get_query(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstQuery)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_query_get_type(), impl0))

proc query*(self: PadProbeInfo): Query =
  let impl0 = gst_pad_probe_info_get_query(cast[ptr PadProbeInfo00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstQuery)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_query_get_type(), impl0))

type
  PadProbeReturn* {.size: sizeof(cint), pure.} = enum
    drop = 0
    ok = 1
    remove = 2
    pass = 3
    handled = 4

type
  PadProbeCallback* = proc (pad: ptr Pad00; info: ptr PadProbeInfo00; userData: pointer): PadProbeReturn {.cdecl.}

proc gst_pad_add_probe(self: ptr Pad00; mask: PadProbeType; callback: PadProbeCallback;
    userData: pointer; destroyData: DestroyNotify): uint64 {.
    importc, libprag.}

proc addProbe*(self: Pad; mask: PadProbeType; callback: PadProbeCallback;
    userData: pointer; destroyData: DestroyNotify): uint64 =
  gst_pad_add_probe(cast[ptr Pad00](self.impl), mask, callback, userData, destroyData)

type
  PadQueryFunction* = proc (pad: ptr Pad00; parent: ptr Object00; query: ptr Query00): gboolean {.cdecl.}

proc gst_pad_set_query_function_full(self: ptr Pad00; query: PadQueryFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setQueryFunctionFull*(self: Pad; query: PadQueryFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_query_function_full(cast[ptr Pad00](self.impl), query, userData, notify)

type
  PadStickyEventsForeachFunction* = proc (pad: ptr Pad00; event: ptr Event00; userData: pointer): gboolean {.cdecl.}

proc gst_pad_sticky_events_foreach(self: ptr Pad00; foreachFunc: PadStickyEventsForeachFunction;
    userData: pointer) {.
    importc, libprag.}

proc stickyEventsForeach*(self: Pad; foreachFunc: PadStickyEventsForeachFunction;
    userData: pointer) =
  gst_pad_sticky_events_foreach(cast[ptr Pad00](self.impl), foreachFunc, userData)

type
  PadTemplateFlags* {.size: sizeof(cint), pure.} = enum
    last = 256

type
  PadUnlinkFunction* = proc (pad: ptr Pad00; parent: ptr Object00) {.cdecl.}

proc gst_pad_set_unlink_function_full(self: ptr Pad00; unlink: PadUnlinkFunction;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setUnlinkFunctionFull*(self: Pad; unlink: PadUnlinkFunction;
    userData: pointer; notify: DestroyNotify) =
  gst_pad_set_unlink_function_full(cast[ptr Pad00](self.impl), unlink, userData, notify)

type
  ParamArray* = ref object of gobject.ParamSpec
  ParamArray00* = object of gobject.ParamSpec00

proc gst_param_spec_array_get_type*(): GType {.importc, libprag.}

proc g_param_spec_unref*(self: ptr ParamArray00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamArray) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamArray()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(cast[ptr ParamArray00](self.impl))
      self.impl = nil

type
  ParamFraction* = ref object of gobject.ParamSpec
  ParamFraction00* = object of gobject.ParamSpec00

proc gst_param_spec_fraction_get_type*(): GType {.importc, libprag.}

proc g_param_spec_unref*(self: ptr ParamFraction00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamFraction) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamFraction()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(cast[ptr ParamFraction00](self.impl))
      self.impl = nil

type
  ParamSpecArray00* {.pure.} = object
  ParamSpecArray* = ref object
    impl*: ptr ParamSpecArray00
    ignoreFinalizer*: bool

type
  ParamSpecFraction00* {.pure.} = object
  ParamSpecFraction* = ref object
    impl*: ptr ParamSpecFraction00
    ignoreFinalizer*: bool

type
  ParseContext00* {.pure.} = object
  ParseContext* = ref object
    impl*: ptr ParseContext00
    ignoreFinalizer*: bool

proc gst_parse_context_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstParseContext*(self: ParseContext) =
  if not self.ignoreFinalizer:
    boxedFree(gst_parse_context_get_type(), cast[ptr ParseContext00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParseContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_parse_context_get_type(), cast[ptr ParseContext00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ParseContext) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstParseContext)

proc gst_parse_context_free(self: ptr ParseContext00) {.
    importc, libprag.}

proc free*(self: ParseContext) =
  gst_parse_context_free(cast[ptr ParseContext00](g_boxed_copy(gst_parse_context_get_type(), self.impl)))

proc finalizerfree*(self: ParseContext) =
  if not self.ignoreFinalizer:
    gst_parse_context_free(cast[ptr ParseContext00](self.impl))

proc gst_parse_context_copy(self: ptr ParseContext00): ptr ParseContext00 {.
    importc, libprag.}

proc copy*(self: ParseContext): ParseContext =
  let impl0 = gst_parse_context_copy(cast[ptr ParseContext00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstParseContext)
  result.impl = impl0

proc gst_parse_context_new(): ptr ParseContext00 {.
    importc, libprag.}

proc newParseContext*(): ParseContext =
  let impl0 = gst_parse_context_new()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstParseContext)
  result.impl = impl0

proc newParseContext*(tdesc: typedesc): tdesc =
  assert(result is ParseContext)
  let impl0 = gst_parse_context_new()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstParseContext)
  result.impl = impl0

proc initParseContext*[T](result: var T) {.deprecated.} =
  assert(result is ParseContext)
  let impl0 = gst_parse_context_new()
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstParseContext)
  result.impl = impl0

proc gst_parse_context_get_missing_elements(self: ptr ParseContext00): ptr cstring {.
    importc, libprag.}

proc getMissingElements*(self: ParseContext): seq[string] =
  let resul0 = gst_parse_context_get_missing_elements(cast[ptr ParseContext00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc missingElements*(self: ParseContext): seq[string] =
  let resul0 = gst_parse_context_get_missing_elements(cast[ptr ParseContext00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

type
  ParseError* {.size: sizeof(cint), pure.} = enum
    syntax = 0
    noSuchElement = 1
    noSuchProperty = 2
    link = 3
    couldNotSetProperty = 4
    emptyBin = 5
    empty = 6
    delayedLink = 7

type
  ParseFlag* {.size: sizeof(cint), pure.} = enum
    fatalErrors = 0
    noSingleElementBins = 1
    placeInBin = 2

  ParseFlags* {.size: sizeof(cint).} = set[ParseFlag]

const
  ParseFlagsNone* = ParseFlags({})
proc none*(t: typedesc[ParseFlags]): ParseFlags = ParseFlags({})

type
  PipelineFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    fixedClock = 19
    last = 23

  PipelineFlags* {.size: sizeof(cint).} = set[PipelineFlag]

type
  PluginAPIFlags* {.size: sizeof(cint), pure.} = enum
    members = 1

type
  PluginDesc00* {.pure.} = object
  PluginDesc* = ref object
    impl*: ptr PluginDesc00
    ignoreFinalizer*: bool

type
  PluginError* {.size: sizeof(cint), pure.} = enum
    module = 0
    dependencies = 1
    nameMismatch = 2

type
  PluginFeatureFilter* = proc (feature: ptr PluginFeature00; userData: pointer): gboolean {.cdecl.}

type
  PluginFilter* = proc (plugin: ptr Plugin00; userData: pointer): gboolean {.cdecl.}

type
  PluginFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    cached = 4
    blacklisted = 5

  PluginFlags* {.size: sizeof(cint).} = set[PluginFlag]

type
  PluginInitFullFunc* = proc (plugin: ptr Plugin00; userData: pointer): gboolean {.cdecl.}

proc gst_plugin_register_static_full(majorVersion: int32; minorVersion: int32;
    name: cstring; description: cstring; initFullFunc: PluginInitFullFunc;
    version: cstring; license: cstring; source: cstring; package: cstring;
    origin: cstring; userData: pointer): gboolean {.
    importc, libprag.}

proc registerStaticFull*(majorVersion: int; minorVersion: int;
    name: cstring; description: cstring; initFullFunc: PluginInitFullFunc;
    version: cstring; license: cstring; source: cstring; package: cstring;
    origin: cstring; userData: pointer): bool =
  toBool(gst_plugin_register_static_full(int32(majorVersion), int32(minorVersion), name, description, initFullFunc, version, license, source, package, origin, userData))

type
  PluginInitFunc* = proc (plugin: ptr Plugin00): gboolean {.cdecl.}

proc gst_plugin_register_static(majorVersion: int32; minorVersion: int32;
    name: cstring; description: cstring; initFunc: PluginInitFunc; version: cstring;
    license: cstring; source: cstring; package: cstring; origin: cstring): gboolean {.
    importc, libprag.}

proc registerStatic*(majorVersion: int; minorVersion: int; name: cstring;
    description: cstring; initFunc: PluginInitFunc; version: cstring; license: cstring;
    source: cstring; package: cstring; origin: cstring): bool =
  toBool(gst_plugin_register_static(int32(majorVersion), int32(minorVersion), name, description, initFunc, version, license, source, package, origin))

type
  Poll00* {.pure.} = object
  Poll* = ref object
    impl*: ptr Poll00
    ignoreFinalizer*: bool

proc gst_poll_free(self: ptr Poll00) {.
    importc, libprag.}

proc free*(self: Poll) =
  gst_poll_free(cast[ptr Poll00](self.impl))

proc finalizerfree*(self: Poll) =
  if not self.ignoreFinalizer:
    gst_poll_free(cast[ptr Poll00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Poll()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_poll_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var Poll) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_poll_get_read_gpollfd(self: ptr Poll00; fd: glib.PollFD) {.
    importc, libprag.}

proc getReadGpollfd*(self: Poll; fd: glib.PollFD) =
  gst_poll_get_read_gpollfd(cast[ptr Poll00](self.impl), fd)

proc gst_poll_read_control(self: ptr Poll00): gboolean {.
    importc, libprag.}

proc readControl*(self: Poll): bool =
  toBool(gst_poll_read_control(cast[ptr Poll00](self.impl)))

proc gst_poll_restart(self: ptr Poll00) {.
    importc, libprag.}

proc restart*(self: Poll) =
  gst_poll_restart(cast[ptr Poll00](self.impl))

proc gst_poll_set_controllable(self: ptr Poll00; controllable: gboolean): gboolean {.
    importc, libprag.}

proc setControllable*(self: Poll; controllable: bool = true): bool =
  toBool(gst_poll_set_controllable(cast[ptr Poll00](self.impl), gboolean(controllable)))

proc gst_poll_set_flushing(self: ptr Poll00; flushing: gboolean) {.
    importc, libprag.}

proc setFlushing*(self: Poll; flushing: bool = true) =
  gst_poll_set_flushing(cast[ptr Poll00](self.impl), gboolean(flushing))

proc `flushing=`*(self: Poll; flushing: bool) =
  gst_poll_set_flushing(cast[ptr Poll00](self.impl), gboolean(flushing))

proc gst_poll_wait(self: ptr Poll00; timeout: uint64): int32 {.
    importc, libprag.}

proc wait*(self: Poll; timeout: uint64): int =
  int(gst_poll_wait(cast[ptr Poll00](self.impl), timeout))

proc gst_poll_write_control(self: ptr Poll00): gboolean {.
    importc, libprag.}

proc writeControl*(self: Poll): bool =
  toBool(gst_poll_write_control(cast[ptr Poll00](self.impl)))

type
  PollFD* {.pure, byRef.} = object
    fd*: int32
    idx*: int32

proc gst_poll_fd_init(self: PollFD) {.
    importc, libprag.}

proc init*(self: PollFD) =
  gst_poll_fd_init(self)

proc gst_poll_fd_can_read(self: ptr Poll00; fd: PollFD): gboolean {.
    importc, libprag.}

proc fdCanRead*(self: Poll; fd: PollFD): bool =
  toBool(gst_poll_fd_can_read(cast[ptr Poll00](self.impl), fd))

proc gst_poll_fd_can_write(self: ptr Poll00; fd: PollFD): gboolean {.
    importc, libprag.}

proc fdCanWrite*(self: Poll; fd: PollFD): bool =
  toBool(gst_poll_fd_can_write(cast[ptr Poll00](self.impl), fd))

proc gst_poll_fd_ctl_pri(self: ptr Poll00; fd: PollFD; active: gboolean): gboolean {.
    importc, libprag.}

proc fdCtlPri*(self: Poll; fd: PollFD; active: bool): bool =
  toBool(gst_poll_fd_ctl_pri(cast[ptr Poll00](self.impl), fd, gboolean(active)))

proc gst_poll_fd_ctl_read(self: ptr Poll00; fd: PollFD; active: gboolean): gboolean {.
    importc, libprag.}

proc fdCtlRead*(self: Poll; fd: PollFD; active: bool): bool =
  toBool(gst_poll_fd_ctl_read(cast[ptr Poll00](self.impl), fd, gboolean(active)))

proc gst_poll_fd_ctl_write(self: ptr Poll00; fd: PollFD; active: gboolean): gboolean {.
    importc, libprag.}

proc fdCtlWrite*(self: Poll; fd: PollFD; active: bool): bool =
  toBool(gst_poll_fd_ctl_write(cast[ptr Poll00](self.impl), fd, gboolean(active)))

proc gst_poll_fd_has_closed(self: ptr Poll00; fd: PollFD): gboolean {.
    importc, libprag.}

proc fdHasClosed*(self: Poll; fd: PollFD): bool =
  toBool(gst_poll_fd_has_closed(cast[ptr Poll00](self.impl), fd))

proc gst_poll_fd_has_error(self: ptr Poll00; fd: PollFD): gboolean {.
    importc, libprag.}

proc fdHasError*(self: Poll; fd: PollFD): bool =
  toBool(gst_poll_fd_has_error(cast[ptr Poll00](self.impl), fd))

proc gst_poll_fd_has_pri(self: ptr Poll00; fd: PollFD): gboolean {.
    importc, libprag.}

proc fdHasPri*(self: Poll; fd: PollFD): bool =
  toBool(gst_poll_fd_has_pri(cast[ptr Poll00](self.impl), fd))

proc gst_poll_fd_ignored(self: ptr Poll00; fd: PollFD) {.
    importc, libprag.}

proc fdIgnored*(self: Poll; fd: PollFD) =
  gst_poll_fd_ignored(cast[ptr Poll00](self.impl), fd)

proc gst_poll_add_fd(self: ptr Poll00; fd: PollFD): gboolean {.
    importc, libprag.}

proc addFd*(self: Poll; fd: PollFD): bool =
  toBool(gst_poll_add_fd(cast[ptr Poll00](self.impl), fd))

proc gst_poll_remove_fd(self: ptr Poll00; fd: PollFD): gboolean {.
    importc, libprag.}

proc removeFd*(self: Poll; fd: PollFD): bool =
  toBool(gst_poll_remove_fd(cast[ptr Poll00](self.impl), fd))

type
  Preset00* = object of gobject.Object00
  Preset* = ref object of gobject.Object

proc gst_preset_get_app_dir(): cstring {.
    importc, libprag.}

proc getAppDir*(): string =
  let resul0 = gst_preset_get_app_dir()
  if resul0.isNil:
    return
  result = $resul0

proc gst_preset_set_app_dir(appDir: cstring): gboolean {.
    importc, libprag.}

proc setAppDir*(appDir: cstring): bool =
  toBool(gst_preset_set_app_dir(appDir))

proc gst_preset_delete_preset(self: ptr Preset00; name: cstring): gboolean {.
    importc, libprag.}

proc deletePreset*(self: Preset; name: cstring): bool =
  toBool(gst_preset_delete_preset(cast[ptr Preset00](self.impl), name))

proc gst_preset_get_meta(self: ptr Preset00; name: cstring; tag: cstring;
    value: var cstring): gboolean {.
    importc, libprag.}

proc getMeta*(self: Preset; name: cstring; tag: cstring; value: var string): bool =
  var value_00: cstring
  result = toBool(gst_preset_get_meta(cast[ptr Preset00](self.impl), name, tag, value_00))
  if value.addr != nil:
    value = $(value_00)

proc gst_preset_get_preset_names(self: ptr Preset00): ptr cstring {.
    importc, libprag.}

proc getPresetNames*(self: Preset): seq[string] =
  let resul0 = gst_preset_get_preset_names(cast[ptr Preset00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc presetNames*(self: Preset): seq[string] =
  let resul0 = gst_preset_get_preset_names(cast[ptr Preset00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_preset_get_property_names(self: ptr Preset00): ptr cstring {.
    importc, libprag.}

proc getPropertyNames*(self: Preset): seq[string] =
  let resul0 = gst_preset_get_property_names(cast[ptr Preset00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc propertyNames*(self: Preset): seq[string] =
  let resul0 = gst_preset_get_property_names(cast[ptr Preset00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_preset_is_editable(self: ptr Preset00): gboolean {.
    importc, libprag.}

proc isEditable*(self: Preset): bool =
  toBool(gst_preset_is_editable(cast[ptr Preset00](self.impl)))

proc gst_preset_load_preset(self: ptr Preset00; name: cstring): gboolean {.
    importc, libprag.}

proc loadPreset*(self: Preset; name: cstring): bool =
  toBool(gst_preset_load_preset(cast[ptr Preset00](self.impl), name))

proc gst_preset_rename_preset(self: ptr Preset00; oldName: cstring; newName: cstring): gboolean {.
    importc, libprag.}

proc renamePreset*(self: Preset; oldName: cstring; newName: cstring): bool =
  toBool(gst_preset_rename_preset(cast[ptr Preset00](self.impl), oldName, newName))

proc gst_preset_save_preset(self: ptr Preset00; name: cstring): gboolean {.
    importc, libprag.}

proc savePreset*(self: Preset; name: cstring): bool =
  toBool(gst_preset_save_preset(cast[ptr Preset00](self.impl), name))

proc gst_preset_set_meta(self: ptr Preset00; name: cstring; tag: cstring;
    value: cstring): gboolean {.
    importc, libprag.}

proc setMeta*(self: Preset; name: cstring; tag: cstring; value: cstring = nil): bool =
  toBool(gst_preset_set_meta(cast[ptr Preset00](self.impl), name, tag, value))

type
  Promise00* {.pure.} = object
  Promise* = ref object
    impl*: ptr Promise00
    ignoreFinalizer*: bool

proc gst_promise_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstPromise*(self: Promise) =
  if not self.ignoreFinalizer:
    boxedFree(gst_promise_get_type(), cast[ptr Promise00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Promise()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_promise_get_type(), cast[ptr Promise00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Promise) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstPromise)

proc gst_promise_new(): ptr Promise00 {.
    importc, libprag.}

proc newPromise*(): Promise =
  fnew(result, gBoxedFreeGstPromise)
  result.impl = gst_promise_new()

proc newPromise*(tdesc: typedesc): tdesc =
  assert(result is Promise)
  fnew(result, gBoxedFreeGstPromise)
  result.impl = gst_promise_new()

proc initPromise*[T](result: var T) {.deprecated.} =
  assert(result is Promise)
  fnew(result, gBoxedFreeGstPromise)
  result.impl = gst_promise_new()

proc gst_promise_expire(self: ptr Promise00) {.
    importc, libprag.}

proc expire*(self: Promise) =
  gst_promise_expire(cast[ptr Promise00](self.impl))

proc gst_promise_get_reply(self: ptr Promise00): ptr Structure00 {.
    importc, libprag.}

proc getReply*(self: Promise): Structure =
  let impl0 = gst_promise_get_reply(cast[ptr Promise00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc reply*(self: Promise): Structure =
  let impl0 = gst_promise_get_reply(cast[ptr Promise00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc gst_promise_interrupt(self: ptr Promise00) {.
    importc, libprag.}

proc interrupt*(self: Promise) =
  gst_promise_interrupt(cast[ptr Promise00](self.impl))

proc gst_promise_reply(self: ptr Promise00; s: ptr Structure00) {.
    importc, libprag.}

proc reply*(self: Promise; s: Structure = nil) =
  gst_promise_reply(cast[ptr Promise00](self.impl), if s.isNil: nil else: cast[ptr Structure00](g_boxed_copy(gst_structure_get_type(), s.impl)))

type
  PromiseResult* {.size: sizeof(cint), pure.} = enum
    pending = 0
    interrupted = 1
    replied = 2
    expired = 3

proc gst_promise_wait(self: ptr Promise00): PromiseResult {.
    importc, libprag.}

proc wait*(self: Promise): PromiseResult =
  gst_promise_wait(cast[ptr Promise00](self.impl))

type
  PromiseChangeFunc* = proc (promise: ptr Promise00; userData: pointer) {.cdecl.}

proc gst_promise_new_with_change_func(`func`: PromiseChangeFunc; userData: pointer;
    notify: DestroyNotify): ptr Promise00 {.
    importc, libprag.}

proc newPromiseWithChangeFunc*(`func`: PromiseChangeFunc; userData: pointer;
    notify: DestroyNotify): Promise =
  fnew(result, gBoxedFreeGstPromise)
  result.impl = gst_promise_new_with_change_func(`func`, userData, notify)

proc newPromiseWithChangeFunc*(tdesc: typedesc; `func`: PromiseChangeFunc; userData: pointer;
    notify: DestroyNotify): tdesc =
  assert(result is Promise)
  fnew(result, gBoxedFreeGstPromise)
  result.impl = gst_promise_new_with_change_func(`func`, userData, notify)

proc initPromiseWithChangeFunc*[T](result: var T; `func`: PromiseChangeFunc; userData: pointer;
    notify: DestroyNotify) {.deprecated.} =
  assert(result is Promise)
  fnew(result, gBoxedFreeGstPromise)
  result.impl = gst_promise_new_with_change_func(`func`, userData, notify)

const QUERY_NUM_SHIFT* = 8'i32

const QUERY_TYPE_BOTH* = "INTERFCE (unsuported)"

type
  Registry* = ref object of Object
  Registry00* = object of Object00

proc gst_registry_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Registry()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scFeatureAdded*(self: Registry;  p: proc (self: ptr Registry00; feature: ptr PluginFeature00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "feature-added", cast[GCallback](p), xdata, nil, cf)

proc scPluginAdded*(self: Registry;  p: proc (self: ptr Registry00; plugin: ptr Plugin00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "plugin-added", cast[GCallback](p), xdata, nil, cf)

proc gst_registry_fork_is_enabled(): gboolean {.
    importc, libprag.}

proc forkIsEnabled*(): bool =
  toBool(gst_registry_fork_is_enabled())

proc gst_registry_fork_set_enabled(enabled: gboolean) {.
    importc, libprag.}

proc forkSetEnabled*(enabled: bool = true) =
  gst_registry_fork_set_enabled(gboolean(enabled))

proc gst_registry_get(): ptr Registry00 {.
    importc, libprag.}

proc getRegistry*(): Registry =
  let gobj = gst_registry_get()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_registry_add_feature(self: ptr Registry00; feature: ptr PluginFeature00): gboolean {.
    importc, libprag.}

proc addFeature*(self: Registry; feature: PluginFeature): bool =
  toBool(gst_registry_add_feature(cast[ptr Registry00](self.impl), cast[ptr PluginFeature00](feature.impl)))

proc gst_registry_add_plugin(self: ptr Registry00; plugin: ptr Plugin00): gboolean {.
    importc, libprag.}

proc addPlugin*(self: Registry; plugin: Plugin): bool =
  toBool(gst_registry_add_plugin(cast[ptr Registry00](self.impl), cast[ptr Plugin00](plugin.impl)))

proc gst_registry_check_feature_version(self: ptr Registry00; featureName: cstring;
    minMajor: uint32; minMinor: uint32; minMicro: uint32): gboolean {.
    importc, libprag.}

proc checkFeatureVersion*(self: Registry; featureName: cstring;
    minMajor: int; minMinor: int; minMicro: int): bool =
  toBool(gst_registry_check_feature_version(cast[ptr Registry00](self.impl), featureName, uint32(minMajor), uint32(minMinor), uint32(minMicro)))

proc gst_registry_feature_filter(self: ptr Registry00; filter: PluginFeatureFilter;
    first: gboolean; userData: pointer): ptr glib.List {.
    importc, libprag.}

proc featureFilter*(self: Registry; filter: PluginFeatureFilter;
    first: bool; userData: pointer): seq[PluginFeature] =
  let resul0 = gst_registry_feature_filter(cast[ptr Registry00](self.impl), filter, gboolean(first), userData)
  result = glistObjects2seq(PluginFeature, resul0, true)
  g_list_free(resul0)

proc gst_registry_find_feature(self: ptr Registry00; name: cstring; `type`: GType): ptr PluginFeature00 {.
    importc, libprag.}

proc findFeature*(self: Registry; name: cstring; `type`: GType): PluginFeature =
  let gobj = gst_registry_find_feature(cast[ptr Registry00](self.impl), name, `type`)
  if gobj.isNil:
    return nil
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

proc gst_registry_find_plugin(self: ptr Registry00; name: cstring): ptr Plugin00 {.
    importc, libprag.}

proc findPlugin*(self: Registry; name: cstring): Plugin =
  let gobj = gst_registry_find_plugin(cast[ptr Registry00](self.impl), name)
  if gobj.isNil:
    return nil
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

proc gst_registry_get_feature_list(self: ptr Registry00; `type`: GType): ptr glib.List {.
    importc, libprag.}

proc getFeatureList*(self: Registry; `type`: GType): seq[PluginFeature] =
  let resul0 = gst_registry_get_feature_list(cast[ptr Registry00](self.impl), `type`)
  result = glistObjects2seq(PluginFeature, resul0, true)
  g_list_free(resul0)

proc gst_registry_get_feature_list_by_plugin(self: ptr Registry00; name: cstring): ptr glib.List {.
    importc, libprag.}

proc getFeatureListByPlugin*(self: Registry; name: cstring): seq[PluginFeature] =
  let resul0 = gst_registry_get_feature_list_by_plugin(cast[ptr Registry00](self.impl), name)
  result = glistObjects2seq(PluginFeature, resul0, true)
  g_list_free(resul0)

proc gst_registry_get_feature_list_cookie(self: ptr Registry00): uint32 {.
    importc, libprag.}

proc getFeatureListCookie*(self: Registry): int =
  int(gst_registry_get_feature_list_cookie(cast[ptr Registry00](self.impl)))

proc featureListCookie*(self: Registry): int =
  int(gst_registry_get_feature_list_cookie(cast[ptr Registry00](self.impl)))

proc gst_registry_get_plugin_list(self: ptr Registry00): ptr glib.List {.
    importc, libprag.}

proc getPluginList*(self: Registry): seq[Plugin] =
  let resul0 = gst_registry_get_plugin_list(cast[ptr Registry00](self.impl))
  result = glistObjects2seq(Plugin, resul0, true)
  g_list_free(resul0)

proc pluginList*(self: Registry): seq[Plugin] =
  let resul0 = gst_registry_get_plugin_list(cast[ptr Registry00](self.impl))
  result = glistObjects2seq(Plugin, resul0, true)
  g_list_free(resul0)

proc gst_registry_lookup(self: ptr Registry00; filename: cstring): ptr Plugin00 {.
    importc, libprag.}

proc lookup*(self: Registry; filename: cstring): Plugin =
  let gobj = gst_registry_lookup(cast[ptr Registry00](self.impl), filename)
  if gobj.isNil:
    return nil
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

proc gst_registry_lookup_feature(self: ptr Registry00; name: cstring): ptr PluginFeature00 {.
    importc, libprag.}

proc lookupFeature*(self: Registry; name: cstring): PluginFeature =
  let gobj = gst_registry_lookup_feature(cast[ptr Registry00](self.impl), name)
  if gobj.isNil:
    return nil
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

proc gst_registry_plugin_filter(self: ptr Registry00; filter: PluginFilter;
    first: gboolean; userData: pointer): ptr glib.List {.
    importc, libprag.}

proc pluginFilter*(self: Registry; filter: PluginFilter; first: bool;
    userData: pointer): seq[Plugin] =
  let resul0 = gst_registry_plugin_filter(cast[ptr Registry00](self.impl), filter, gboolean(first), userData)
  result = glistObjects2seq(Plugin, resul0, true)
  g_list_free(resul0)

proc gst_registry_remove_feature(self: ptr Registry00; feature: ptr PluginFeature00) {.
    importc, libprag.}

proc removeFeature*(self: Registry; feature: PluginFeature) =
  gst_registry_remove_feature(cast[ptr Registry00](self.impl), cast[ptr PluginFeature00](feature.impl))

proc gst_registry_remove_plugin(self: ptr Registry00; plugin: ptr Plugin00) {.
    importc, libprag.}

proc removePlugin*(self: Registry; plugin: Plugin) =
  gst_registry_remove_plugin(cast[ptr Registry00](self.impl), cast[ptr Plugin00](plugin.impl))

proc gst_registry_scan_path(self: ptr Registry00; path: cstring): gboolean {.
    importc, libprag.}

proc scanPath*(self: Registry; path: cstring): bool =
  toBool(gst_registry_scan_path(cast[ptr Registry00](self.impl), path))

type
  ResourceError* {.size: sizeof(cint), pure.} = enum
    failed = 1
    tooLazy = 2
    notFound = 3
    busy = 4
    openRead = 5
    openWrite = 6
    openReadWrite = 7
    close = 8
    read = 9
    write = 10
    seek = 11
    sync = 12
    settings = 13
    noSpaceLeft = 14
    notAuthorized = 15
    numErrors = 16

const SECOND* = 1000000000'i64

const SEGMENT_INSTANT_FLAGS* = 912'i32

const SEQNUM_INVALID* = 0'i32

type
  SearchMode* {.size: sizeof(cint), pure.} = enum
    exact = 0
    before = 1
    after = 2

type
  StackTraceFlag* {.size: sizeof(cint), pure.} = enum
    full = 0

  StackTraceFlags* {.size: sizeof(cint).} = set[StackTraceFlag]

const
  StackTraceFlagsNone* = StackTraceFlags({})
proc none*(t: typedesc[StackTraceFlags]): StackTraceFlags = StackTraceFlags({})

type
  StaticCaps* {.pure, byRef.} = object
    caps*: ptr Caps00
    string*: cstring
    gstReserved*: array[4, pointer]

proc gst_static_caps_cleanup(self: StaticCaps) {.
    importc, libprag.}

proc cleanup*(self: StaticCaps) =
  gst_static_caps_cleanup(self)

proc gst_static_caps_get(self: StaticCaps): ptr Caps00 {.
    importc, libprag.}

proc getStaticCaps*(self: StaticCaps): Caps =
  let impl0 = gst_static_caps_get(self)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc staticCaps*(self: StaticCaps): Caps =
  let impl0 = gst_static_caps_get(self)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

type
  StreamError* {.size: sizeof(cint), pure.} = enum
    failed = 1
    tooLazy = 2
    notImplemented = 3
    typeNotFound = 4
    wrongType = 5
    codecNotFound = 6
    decode = 7
    encode = 8
    demux = 9
    mux = 10
    format = 11
    decrypt = 12
    decryptNokey = 13
    numErrors = 14

type
  StructureFilterMapFunc* = proc (fieldId: uint32; value: gobject.Value; userData: pointer): gboolean {.cdecl.}

proc gst_structure_filter_and_map_in_place(self: ptr Structure00; `func`: StructureFilterMapFunc;
    userData: pointer) {.
    importc, libprag.}

proc filterAndMapInPlace*(self: Structure; `func`: StructureFilterMapFunc;
    userData: pointer) =
  gst_structure_filter_and_map_in_place(cast[ptr Structure00](self.impl), `func`, userData)

type
  StructureForeachFunc* = proc (fieldId: uint32; value: gobject.Value; userData: pointer): gboolean {.cdecl.}

proc gst_structure_foreach(self: ptr Structure00; `func`: StructureForeachFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc foreach*(self: Structure; `func`: StructureForeachFunc;
    userData: pointer): bool =
  toBool(gst_structure_foreach(cast[ptr Structure00](self.impl), `func`, userData))

type
  StructureMapFunc* = proc (fieldId: uint32; value: gobject.Value; userData: pointer): gboolean {.cdecl.}

proc gst_structure_map_in_place(self: ptr Structure00; `func`: StructureMapFunc;
    userData: pointer): gboolean {.
    importc, libprag.}

proc mapInPlace*(self: Structure; `func`: StructureMapFunc;
    userData: pointer): bool =
  toBool(gst_structure_map_in_place(cast[ptr Structure00](self.impl), `func`, userData))

type
  SystemClock* = ref object of Clock
  SystemClock00* = object of Clock00

proc gst_system_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SystemClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_system_clock_obtain(): ptr Clock00 {.
    importc, libprag.}

proc obtain*(): Clock =
  let gobj = gst_system_clock_obtain()
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

proc gst_system_clock_set_default(newClock: ptr Clock00) {.
    importc, libprag.}

proc setDefault*(newClock: Clock = nil) =
  gst_system_clock_set_default(if newClock.isNil: nil else: cast[ptr Clock00](newClock.impl))

const TAG_ALBUM* = "album"

const TAG_ALBUM_ARTIST* = "album-artist"

const TAG_ALBUM_ARTIST_SORTNAME* = "album-artist-sortname"

const TAG_ALBUM_GAIN* = "replaygain-album-gain"

const TAG_ALBUM_PEAK* = "replaygain-album-peak"

const TAG_ALBUM_SORTNAME* = "album-sortname"

const TAG_ALBUM_VOLUME_COUNT* = "album-disc-count"

const TAG_ALBUM_VOLUME_NUMBER* = "album-disc-number"

const TAG_APPLICATION_DATA* = "application-data"

const TAG_APPLICATION_NAME* = "application-name"

const TAG_ARTIST* = "artist"

const TAG_ARTIST_SORTNAME* = "artist-sortname"

const TAG_ATTACHMENT* = "attachment"

const TAG_AUDIO_CODEC* = "audio-codec"

const TAG_BEATS_PER_MINUTE* = "beats-per-minute"

const TAG_BITRATE* = "bitrate"

const TAG_CODEC* = "codec"

const TAG_COMMENT* = "comment"

const TAG_COMPOSER* = "composer"

const TAG_COMPOSER_SORTNAME* = "composer-sortname"

const TAG_CONDUCTOR* = "conductor"

const TAG_CONTACT* = "contact"

const TAG_CONTAINER_FORMAT* = "container-format"

const TAG_COPYRIGHT* = "copyright"

const TAG_COPYRIGHT_URI* = "copyright-uri"

const TAG_DATE* = "date"

const TAG_DATE_TIME* = "datetime"

const TAG_DESCRIPTION* = "description"

const TAG_DEVICE_MANUFACTURER* = "device-manufacturer"

const TAG_DEVICE_MODEL* = "device-model"

const TAG_DURATION* = "duration"

const TAG_ENCODED_BY* = "encoded-by"

const TAG_ENCODER* = "encoder"

const TAG_ENCODER_VERSION* = "encoder-version"

const TAG_EXTENDED_COMMENT* = "extended-comment"

const TAG_GENRE* = "genre"

const TAG_GEO_LOCATION_CAPTURE_DIRECTION* = "geo-location-capture-direction"

const TAG_GEO_LOCATION_CITY* = "geo-location-city"

const TAG_GEO_LOCATION_COUNTRY* = "geo-location-country"

const TAG_GEO_LOCATION_ELEVATION* = "geo-location-elevation"

const TAG_GEO_LOCATION_HORIZONTAL_ERROR* = "geo-location-horizontal-error"

const TAG_GEO_LOCATION_LATITUDE* = "geo-location-latitude"

const TAG_GEO_LOCATION_LONGITUDE* = "geo-location-longitude"

const TAG_GEO_LOCATION_MOVEMENT_DIRECTION* = "geo-location-movement-direction"

const TAG_GEO_LOCATION_MOVEMENT_SPEED* = "geo-location-movement-speed"

const TAG_GEO_LOCATION_NAME* = "geo-location-name"

const TAG_GEO_LOCATION_SUBLOCATION* = "geo-location-sublocation"

const TAG_GROUPING* = "grouping"

const TAG_HOMEPAGE* = "homepage"

const TAG_IMAGE* = "image"

const TAG_IMAGE_ORIENTATION* = "image-orientation"

const TAG_INTERPRETED_BY* = "interpreted-by"

const TAG_ISRC* = "isrc"

const TAG_KEYWORDS* = "keywords"

const TAG_LANGUAGE_CODE* = "language-code"

const TAG_LANGUAGE_NAME* = "language-name"

const TAG_LICENSE* = "license"

const TAG_LICENSE_URI* = "license-uri"

const TAG_LOCATION* = "location"

const TAG_LYRICS* = "lyrics"

const TAG_MAXIMUM_BITRATE* = "maximum-bitrate"

const TAG_MIDI_BASE_NOTE* = "midi-base-note"

const TAG_MINIMUM_BITRATE* = "minimum-bitrate"

const TAG_NOMINAL_BITRATE* = "nominal-bitrate"

const TAG_ORGANIZATION* = "organization"

const TAG_PERFORMER* = "performer"

const TAG_PREVIEW_IMAGE* = "preview-image"

const TAG_PRIVATE_DATA* = "private-data"

const TAG_PUBLISHER* = "publisher"

const TAG_REFERENCE_LEVEL* = "replaygain-reference-level"

const TAG_SERIAL* = "serial"

const TAG_SHOW_EPISODE_NUMBER* = "show-episode-number"

const TAG_SHOW_NAME* = "show-name"

const TAG_SHOW_SEASON_NUMBER* = "show-season-number"

const TAG_SHOW_SORTNAME* = "show-sortname"

const TAG_SUBTITLE_CODEC* = "subtitle-codec"

const TAG_TITLE* = "title"

const TAG_TITLE_SORTNAME* = "title-sortname"

const TAG_TRACK_COUNT* = "track-count"

const TAG_TRACK_GAIN* = "replaygain-track-gain"

const TAG_TRACK_NUMBER* = "track-number"

const TAG_TRACK_PEAK* = "replaygain-track-peak"

const TAG_USER_RATING* = "user-rating"

const TAG_VERSION* = "version"

const TAG_VIDEO_CODEC* = "video-codec"

const TOC_REPEAT_COUNT_INFINITE* = -1'i32

type
  TagFlag* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    meta = 1
    encoded = 2
    decoded = 3
    count = 4

type
  TagForeachFunc* = proc (list: ptr TagList00; tag: cstring; userData: pointer) {.cdecl.}

proc gst_tag_list_foreach(self: ptr TagList00; `func`: TagForeachFunc; userData: pointer) {.
    importc, libprag.}

proc foreach*(self: TagList; `func`: TagForeachFunc; userData: pointer) =
  gst_tag_list_foreach(cast[ptr TagList00](self.impl), `func`, userData)

type
  TagMergeFunc* = proc (dest: gobject.Value; src: gobject.Value) {.cdecl.}

type
  TagSetter00* = object of gobject.Object00
  TagSetter* = ref object of gobject.Object

proc gst_tag_setter_add_tag_value(self: ptr TagSetter00; mode: TagMergeMode;
    tag: cstring; value: gobject.Value) {.
    importc, libprag.}

proc addTagValue*(self: TagSetter; mode: TagMergeMode; tag: cstring;
    value: gobject.Value) =
  gst_tag_setter_add_tag_value(cast[ptr TagSetter00](self.impl), mode, tag, value)

proc gst_tag_setter_get_tag_list(self: ptr TagSetter00): ptr TagList00 {.
    importc, libprag.}

proc getTagList*(self: TagSetter): TagList =
  let impl0 = gst_tag_setter_get_tag_list(cast[ptr TagSetter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), impl0))

proc tagList*(self: TagSetter): TagList =
  let impl0 = gst_tag_setter_get_tag_list(cast[ptr TagSetter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstTagList)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), impl0))

proc gst_tag_setter_get_tag_merge_mode(self: ptr TagSetter00): TagMergeMode {.
    importc, libprag.}

proc getTagMergeMode*(self: TagSetter): TagMergeMode =
  gst_tag_setter_get_tag_merge_mode(cast[ptr TagSetter00](self.impl))

proc tagMergeMode*(self: TagSetter): TagMergeMode =
  gst_tag_setter_get_tag_merge_mode(cast[ptr TagSetter00](self.impl))

proc gst_tag_setter_merge_tags(self: ptr TagSetter00; list: ptr TagList00;
    mode: TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: TagSetter; list: TagList; mode: TagMergeMode) =
  gst_tag_setter_merge_tags(cast[ptr TagSetter00](self.impl), cast[ptr TagList00](list.impl), mode)

proc gst_tag_setter_reset_tags(self: ptr TagSetter00) {.
    importc, libprag.}

proc resetTags*(self: TagSetter) =
  gst_tag_setter_reset_tags(cast[ptr TagSetter00](self.impl))

proc gst_tag_setter_set_tag_merge_mode(self: ptr TagSetter00; mode: TagMergeMode) {.
    importc, libprag.}

proc setTagMergeMode*(self: TagSetter; mode: TagMergeMode) =
  gst_tag_setter_set_tag_merge_mode(cast[ptr TagSetter00](self.impl), mode)

proc `tagMergeMode=`*(self: TagSetter; mode: TagMergeMode) =
  gst_tag_setter_set_tag_merge_mode(cast[ptr TagSetter00](self.impl), mode)

type
  Task* = ref object of Object
  Task00* = object of Object00

proc gst_task_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Task()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc cleanupAll*() {.
    importc: "gst_task_cleanup_all", libprag.}

proc gst_task_get_state(self: ptr Task00): TaskState {.
    importc, libprag.}

proc getState*(self: Task): TaskState =
  gst_task_get_state(cast[ptr Task00](self.impl))

proc state*(self: Task): TaskState =
  gst_task_get_state(cast[ptr Task00](self.impl))

proc gst_task_join(self: ptr Task00): gboolean {.
    importc, libprag.}

proc join*(self: Task): bool =
  toBool(gst_task_join(cast[ptr Task00](self.impl)))

proc gst_task_pause(self: ptr Task00): gboolean {.
    importc, libprag.}

proc pause*(self: Task): bool =
  toBool(gst_task_pause(cast[ptr Task00](self.impl)))

proc gst_task_resume(self: ptr Task00): gboolean {.
    importc, libprag.}

proc resume*(self: Task): bool =
  toBool(gst_task_resume(cast[ptr Task00](self.impl)))

proc gst_task_set_lock(self: ptr Task00; mutex: glib.RecMutex) {.
    importc, libprag.}

proc setLock*(self: Task; mutex: glib.RecMutex) =
  gst_task_set_lock(cast[ptr Task00](self.impl), mutex)

proc `lock=`*(self: Task; mutex: glib.RecMutex) =
  gst_task_set_lock(cast[ptr Task00](self.impl), mutex)

proc gst_task_set_state(self: ptr Task00; state: TaskState): gboolean {.
    importc, libprag.}

proc setState*(self: Task; state: TaskState): bool =
  toBool(gst_task_set_state(cast[ptr Task00](self.impl), state))

proc gst_task_start(self: ptr Task00): gboolean {.
    importc, libprag.}

proc start*(self: Task): bool =
  toBool(gst_task_start(cast[ptr Task00](self.impl)))

proc gst_task_stop(self: ptr Task00): gboolean {.
    importc, libprag.}

proc stop*(self: Task): bool =
  toBool(gst_task_stop(cast[ptr Task00](self.impl)))

type
  TaskPool* = ref object of Object
  TaskPool00* = object of Object00

proc gst_task_pool_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TaskPool()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_task_pool_new(): ptr TaskPool00 {.
    importc, libprag.}

proc newTaskPool*(): TaskPool =
  let gobj = gst_task_pool_new()
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

proc newTaskPool*(tdesc: typedesc): tdesc =
  assert(result is TaskPool)
  let gobj = gst_task_pool_new()
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

proc initTaskPool*[T](result: var T) {.deprecated.} =
  assert(result is TaskPool)
  let gobj = gst_task_pool_new()
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

proc gst_task_pool_cleanup(self: ptr TaskPool00) {.
    importc, libprag.}

proc cleanup*(self: TaskPool) =
  gst_task_pool_cleanup(cast[ptr TaskPool00](self.impl))

proc gst_task_pool_join(self: ptr TaskPool00; id: pointer) {.
    importc, libprag.}

proc join*(self: TaskPool; id: pointer) =
  gst_task_pool_join(cast[ptr TaskPool00](self.impl), id)

proc gst_task_pool_prepare(self: ptr TaskPool00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc prepare*(self: TaskPool) =
  var gerror: ptr glib.Error
  gst_task_pool_prepare(cast[ptr TaskPool00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc gst_task_get_pool(self: ptr Task00): ptr TaskPool00 {.
    importc, libprag.}

proc getPool*(self: Task): TaskPool =
  let gobj = gst_task_get_pool(cast[ptr Task00](self.impl))
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

proc pool*(self: Task): TaskPool =
  let gobj = gst_task_get_pool(cast[ptr Task00](self.impl))
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

proc gst_task_set_pool(self: ptr Task00; pool: ptr TaskPool00) {.
    importc, libprag.}

proc setPool*(self: Task; pool: TaskPool) =
  gst_task_set_pool(cast[ptr Task00](self.impl), cast[ptr TaskPool00](pool.impl))

proc `pool=`*(self: Task; pool: TaskPool) =
  gst_task_set_pool(cast[ptr Task00](self.impl), cast[ptr TaskPool00](pool.impl))

type
  TaskFunction* = proc (userData: pointer) {.cdecl.}

proc gst_pad_start_task(self: ptr Pad00; `func`: TaskFunction; userData: pointer;
    notify: DestroyNotify): gboolean {.
    importc, libprag.}

proc startTask*(self: Pad; `func`: TaskFunction; userData: pointer;
    notify: DestroyNotify): bool =
  toBool(gst_pad_start_task(cast[ptr Pad00](self.impl), `func`, userData, notify))

proc gst_task_new(`func`: TaskFunction; userData: pointer; notify: DestroyNotify): ptr Task00 {.
    importc, libprag.}

proc newTask*(`func`: TaskFunction; userData: pointer; notify: DestroyNotify): Task =
  let gobj = gst_task_new(`func`, userData, notify)
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

proc newTask*(tdesc: typedesc; `func`: TaskFunction; userData: pointer; notify: DestroyNotify): tdesc =
  assert(result is Task)
  let gobj = gst_task_new(`func`, userData, notify)
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

proc initTask*[T](result: var T; `func`: TaskFunction; userData: pointer; notify: DestroyNotify) {.deprecated.} =
  assert(result is Task)
  let gobj = gst_task_new(`func`, userData, notify)
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
  TaskPoolFunction* = proc (userData: pointer) {.cdecl.}

proc gst_task_pool_push(self: ptr TaskPool00; `func`: TaskPoolFunction; userData: pointer;
    error: ptr ptr glib.Error = nil): pointer {.
    importc, libprag.}

proc push*(self: TaskPool; `func`: TaskPoolFunction; userData: pointer): pointer =
  var gerror: ptr glib.Error
  let resul0 = gst_task_pool_push(cast[ptr TaskPool00](self.impl), `func`, userData, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  if resul0.isNil:
    return
  result = resul0

type
  TaskThreadFunc* = proc (task: ptr Task00; thread: ptr glib.Thread00; userData: pointer) {.cdecl.}

proc gst_task_set_enter_callback(self: ptr Task00; enterFunc: TaskThreadFunc;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setEnterCallback*(self: Task; enterFunc: TaskThreadFunc; userData: pointer;
    notify: DestroyNotify) =
  gst_task_set_enter_callback(cast[ptr Task00](self.impl), enterFunc, userData, notify)

proc gst_task_set_leave_callback(self: ptr Task00; leaveFunc: TaskThreadFunc;
    userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setLeaveCallback*(self: Task; leaveFunc: TaskThreadFunc; userData: pointer;
    notify: DestroyNotify) =
  gst_task_set_leave_callback(cast[ptr Task00](self.impl), leaveFunc, userData, notify)

type
  TimedValue* {.pure, byRef.} = object
    timestamp*: uint64
    value*: cdouble

type
  TocSetter00* = object of gobject.Object00
  TocSetter* = ref object of gobject.Object

proc gst_toc_setter_get_toc(self: ptr TocSetter00): ptr Toc00 {.
    importc, libprag.}

proc getToc*(self: TocSetter): Toc =
  let impl0 = gst_toc_setter_get_toc(cast[ptr TocSetter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstToc)
  result.impl = impl0

proc toc*(self: TocSetter): Toc =
  let impl0 = gst_toc_setter_get_toc(cast[ptr TocSetter00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstToc)
  result.impl = impl0

proc gst_toc_setter_reset(self: ptr TocSetter00) {.
    importc, libprag.}

proc reset*(self: TocSetter) =
  gst_toc_setter_reset(cast[ptr TocSetter00](self.impl))

proc gst_toc_setter_set_toc(self: ptr TocSetter00; toc: ptr Toc00) {.
    importc, libprag.}

proc setToc*(self: TocSetter; toc: Toc = nil) =
  gst_toc_setter_set_toc(cast[ptr TocSetter00](self.impl), if toc.isNil: nil else: cast[ptr Toc00](toc.impl))

proc `toc=`*(self: TocSetter; toc: Toc = nil) =
  gst_toc_setter_set_toc(cast[ptr TocSetter00](self.impl), if toc.isNil: nil else: cast[ptr Toc00](toc.impl))

type
  Tracer* = ref object of Object
  Tracer00* = object of Object00

proc gst_tracer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Tracer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_tracer_register(plugin: ptr Plugin00; name: cstring; `type`: GType): gboolean {.
    importc, libprag.}

proc registerTracer*(plugin: Plugin = nil; name: cstring; `type`: GType): bool =
  toBool(gst_tracer_register(if plugin.isNil: nil else: cast[ptr Plugin00](plugin.impl), name, `type`))

type
  TracerFactory* = ref object of PluginFeature
  TracerFactory00* = object of PluginFeature00

proc gst_tracer_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TracerFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_tracer_factory_get_list(): ptr glib.List {.
    importc, libprag.}

proc getListTracerFactory*(): seq[TracerFactory] =
  let resul0 = gst_tracer_factory_get_list()
  result = glistObjects2seq(TracerFactory, resul0, true)
  g_list_free(resul0)

proc gst_tracer_factory_get_tracer_type(self: ptr TracerFactory00): GType {.
    importc, libprag.}

proc getTracerType*(self: TracerFactory): GType =
  gst_tracer_factory_get_tracer_type(cast[ptr TracerFactory00](self.impl))

proc tracerType*(self: TracerFactory): GType =
  gst_tracer_factory_get_tracer_type(cast[ptr TracerFactory00](self.impl))

type
  TracerRecord* = ref object of Object
  TracerRecord00* = object of Object00

proc gst_tracer_record_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TracerRecord()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  TracerValueFlag* {.size: sizeof(cint), pure.} = enum
    optional = 0
    aggregated = 1

  TracerValueFlags* {.size: sizeof(cint).} = set[TracerValueFlag]

const
  TracerValueFlagsNone* = TracerValueFlags({})
proc none*(t: typedesc[TracerValueFlags]): TracerValueFlags = TracerValueFlags({})

type
  TracerValueScope* {.size: sizeof(cint), pure.} = enum
    process = 0
    thread = 1
    element = 2
    pad = 3

type
  TypeFind00* {.pure.} = object
  TypeFind* = ref object
    impl*: ptr TypeFind00
    ignoreFinalizer*: bool

proc gst_type_find_get_length(self: ptr TypeFind00): uint64 {.
    importc, libprag.}

proc getLength*(self: TypeFind): uint64 =
  gst_type_find_get_length(cast[ptr TypeFind00](self.impl))

proc length*(self: TypeFind): uint64 =
  gst_type_find_get_length(cast[ptr TypeFind00](self.impl))

proc gst_type_find_peek(self: ptr TypeFind00; offset: int64; size: var uint32): ptr uint8 {.
    importc, libprag.}

proc peek*(self: TypeFind; offset: int64; size: var int): seq[uint8] =
  var size_00: uint32
  let resul0 = gst_type_find_peek(cast[ptr TypeFind00](self.impl), offset, size_00)
  if resul0.isNil:
    return
  result = uint8ArrayToSeq(resul0, size.int)
  if size.addr != nil:
    size = int(size_00)

proc gst_type_find_suggest(self: ptr TypeFind00; probability: uint32; caps: ptr Caps00) {.
    importc, libprag.}

proc suggest*(self: TypeFind; probability: int; caps: Caps) =
  gst_type_find_suggest(cast[ptr TypeFind00](self.impl), uint32(probability), cast[ptr Caps00](caps.impl))

type
  TypeFindFactory* = ref object of PluginFeature
  TypeFindFactory00* = object of PluginFeature00

proc gst_type_find_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TypeFindFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_type_find_factory_get_list(): ptr glib.List {.
    importc, libprag.}

proc getListTypeFindFactory*(): seq[TypeFindFactory] =
  let resul0 = gst_type_find_factory_get_list()
  result = glistObjects2seq(TypeFindFactory, resul0, true)
  g_list_free(resul0)

proc gst_type_find_factory_call_function(self: ptr TypeFindFactory00; find: ptr TypeFind00) {.
    importc, libprag.}

proc callFunction*(self: TypeFindFactory; find: TypeFind) =
  gst_type_find_factory_call_function(cast[ptr TypeFindFactory00](self.impl), cast[ptr TypeFind00](find.impl))

proc gst_type_find_factory_get_caps(self: ptr TypeFindFactory00): ptr Caps00 {.
    importc, libprag.}

proc getCaps*(self: TypeFindFactory): Caps =
  let impl0 = gst_type_find_factory_get_caps(cast[ptr TypeFindFactory00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_get_type(), impl0))

proc caps*(self: TypeFindFactory): Caps =
  let impl0 = gst_type_find_factory_get_caps(cast[ptr TypeFindFactory00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_get_type(), impl0))

proc gst_type_find_factory_get_extensions(self: ptr TypeFindFactory00): ptr cstring {.
    importc, libprag.}

proc getExtensions*(self: TypeFindFactory): seq[string] =
  let resul0 = gst_type_find_factory_get_extensions(cast[ptr TypeFindFactory00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc extensions*(self: TypeFindFactory): seq[string] =
  let resul0 = gst_type_find_factory_get_extensions(cast[ptr TypeFindFactory00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gst_type_find_factory_has_function(self: ptr TypeFindFactory00): gboolean {.
    importc, libprag.}

proc hasFunction*(self: TypeFindFactory): bool =
  toBool(gst_type_find_factory_has_function(cast[ptr TypeFindFactory00](self.impl)))

type
  TypeFindFunction* = proc (find: ptr TypeFind00; userData: pointer) {.cdecl.}

proc gst_type_find_register(plugin: ptr Plugin00; name: cstring; rank: uint32;
    `func`: TypeFindFunction; extensions: cstring; possibleCaps: ptr Caps00;
    data: pointer; dataNotify: DestroyNotify): gboolean {.
    importc, libprag.}

proc registerTypeFind*(plugin: Plugin = nil; name: cstring; rank: int;
    `func`: TypeFindFunction; extensions: cstring = nil; possibleCaps: Caps = nil;
    data: pointer; dataNotify: DestroyNotify): bool =
  toBool(gst_type_find_register(if plugin.isNil: nil else: cast[ptr Plugin00](plugin.impl), name, uint32(rank), `func`, extensions, if possibleCaps.isNil: nil else: cast[ptr Caps00](possibleCaps.impl), data, dataNotify))

type
  TypeFindProbability* {.size: sizeof(cint), pure.} = enum
    none = 0
    minimum = 1
    possible = 50
    likely = 80
    nearlyCertain = 99
    maximum = 100

type
  URIError* {.size: sizeof(cint), pure.} = enum
    unsupportedProtocol = 0
    badUri = 1
    badState = 2
    badReference = 3

type
  URIHandler00* = object of gobject.Object00
  URIHandler* = ref object of gobject.Object

proc gst_uri_handler_get_protocols(self: ptr URIHandler00): ptr cstring {.
    importc, libprag.}

proc getProtocols*(self: URIHandler): seq[string] =
  let resul0 = gst_uri_handler_get_protocols(cast[ptr URIHandler00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc protocols*(self: URIHandler): seq[string] =
  let resul0 = gst_uri_handler_get_protocols(cast[ptr URIHandler00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gst_uri_handler_get_uri(self: ptr URIHandler00): cstring {.
    importc, libprag.}

proc getUri*(self: URIHandler): string =
  let resul0 = gst_uri_handler_get_uri(cast[ptr URIHandler00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc uri*(self: URIHandler): string =
  let resul0 = gst_uri_handler_get_uri(cast[ptr URIHandler00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_uri_handler_get_uri_type(self: ptr URIHandler00): URIType {.
    importc, libprag.}

proc getUriType*(self: URIHandler): URIType =
  gst_uri_handler_get_uri_type(cast[ptr URIHandler00](self.impl))

proc uriType*(self: URIHandler): URIType =
  gst_uri_handler_get_uri_type(cast[ptr URIHandler00](self.impl))

proc gst_uri_handler_set_uri(self: ptr URIHandler00; uri: cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc setUri*(self: URIHandler; uri: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_uri_handler_set_uri(cast[ptr URIHandler00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

const URI_NO_PORT* = 0'i32

const USECOND* = 1000'i64

type
  Uri00* {.pure.} = object
  Uri* = ref object
    impl*: ptr Uri00
    ignoreFinalizer*: bool

proc gst_uri_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstUri*(self: Uri) =
  if not self.ignoreFinalizer:
    boxedFree(gst_uri_get_type(), cast[ptr Uri00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Uri()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_uri_get_type(), cast[ptr Uri00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Uri) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstUri)

proc gst_uri_new(scheme: cstring; userinfo: cstring; host: cstring; port: uint32;
    path: cstring; query: cstring; fragment: cstring): ptr Uri00 {.
    importc, libprag.}

proc newUri*(scheme: cstring = nil; userinfo: cstring = nil; host: cstring = nil;
    port: int; path: cstring = nil; query: cstring = nil; fragment: cstring = nil): Uri =
  fnew(result, gBoxedFreeGstUri)
  result.impl = gst_uri_new(scheme, userinfo, host, uint32(port), path, query, fragment)

proc newUri*(tdesc: typedesc; scheme: cstring = nil; userinfo: cstring = nil; host: cstring = nil;
    port: int; path: cstring = nil; query: cstring = nil; fragment: cstring = nil): tdesc =
  assert(result is Uri)
  fnew(result, gBoxedFreeGstUri)
  result.impl = gst_uri_new(scheme, userinfo, host, uint32(port), path, query, fragment)

proc initUri*[T](result: var T; scheme: cstring = nil; userinfo: cstring = nil; host: cstring = nil;
    port: int; path: cstring = nil; query: cstring = nil; fragment: cstring = nil) {.deprecated.} =
  assert(result is Uri)
  fnew(result, gBoxedFreeGstUri)
  result.impl = gst_uri_new(scheme, userinfo, host, uint32(port), path, query, fragment)

proc gst_uri_append_path(self: ptr Uri00; relativePath: cstring): gboolean {.
    importc, libprag.}

proc appendPath*(self: Uri; relativePath: cstring): bool =
  toBool(gst_uri_append_path(cast[ptr Uri00](self.impl), relativePath))

proc gst_uri_append_path_segment(self: ptr Uri00; pathSegment: cstring): gboolean {.
    importc, libprag.}

proc appendPathSegment*(self: Uri; pathSegment: cstring): bool =
  toBool(gst_uri_append_path_segment(cast[ptr Uri00](self.impl), pathSegment))

proc gst_uri_equal(self: ptr Uri00; second: ptr Uri00): gboolean {.
    importc, libprag.}

proc equal*(self: Uri; second: Uri): bool =
  toBool(gst_uri_equal(cast[ptr Uri00](self.impl), cast[ptr Uri00](second.impl)))

proc gst_uri_from_string_with_base(self: ptr Uri00; uri: cstring): ptr Uri00 {.
    importc, libprag.}

proc fromStringWithBase*(self: Uri; uri: cstring): Uri =
  fnew(result, gBoxedFreeGstUri)
  result.impl = gst_uri_from_string_with_base(cast[ptr Uri00](self.impl), uri)

proc gst_uri_get_fragment(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getFragment*(self: Uri): string =
  let resul0 = gst_uri_get_fragment(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc fragment*(self: Uri): string =
  let resul0 = gst_uri_get_fragment(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_uri_get_host(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getHost*(self: Uri): string =
  let resul0 = gst_uri_get_host(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc host*(self: Uri): string =
  let resul0 = gst_uri_get_host(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_uri_get_media_fragment_table(self: ptr Uri00): ptr HashTable00 {.
    importc, libprag.}

proc getMediaFragmentTable*(self: Uri): ptr HashTable00 =
  gst_uri_get_media_fragment_table(cast[ptr Uri00](self.impl))

proc mediaFragmentTable*(self: Uri): ptr HashTable00 =
  gst_uri_get_media_fragment_table(cast[ptr Uri00](self.impl))

proc gst_uri_get_path(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getPath*(self: Uri): string =
  let resul0 = gst_uri_get_path(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc path*(self: Uri): string =
  let resul0 = gst_uri_get_path(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_uri_get_path_segments(self: ptr Uri00): ptr glib.List {.
    importc, libprag.}

proc getPathSegments*(self: Uri): seq[cstring] =
  let resul0 = gst_uri_get_path_segments(cast[ptr Uri00](self.impl))
  g_list_free(resul0)

proc pathSegments*(self: Uri): seq[cstring] =
  let resul0 = gst_uri_get_path_segments(cast[ptr Uri00](self.impl))
  g_list_free(resul0)

proc gst_uri_get_path_string(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getPathString*(self: Uri): string =
  let resul0 = gst_uri_get_path_string(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc pathString*(self: Uri): string =
  let resul0 = gst_uri_get_path_string(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_uri_get_port(self: ptr Uri00): uint32 {.
    importc, libprag.}

proc getPort*(self: Uri): int =
  int(gst_uri_get_port(cast[ptr Uri00](self.impl)))

proc port*(self: Uri): int =
  int(gst_uri_get_port(cast[ptr Uri00](self.impl)))

proc gst_uri_get_query_keys(self: ptr Uri00): ptr glib.List {.
    importc, libprag.}

proc getQueryKeys*(self: Uri): seq[cstring] =
  let resul0 = gst_uri_get_query_keys(cast[ptr Uri00](self.impl))
  g_list_free(resul0)

proc queryKeys*(self: Uri): seq[cstring] =
  let resul0 = gst_uri_get_query_keys(cast[ptr Uri00](self.impl))
  g_list_free(resul0)

proc gst_uri_get_query_string(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getQueryString*(self: Uri): string =
  let resul0 = gst_uri_get_query_string(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc queryString*(self: Uri): string =
  let resul0 = gst_uri_get_query_string(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_uri_get_query_table(self: ptr Uri00): ptr HashTable00 {.
    importc, libprag.}

proc getQueryTable*(self: Uri): ptr HashTable00 =
  gst_uri_get_query_table(cast[ptr Uri00](self.impl))

proc queryTable*(self: Uri): ptr HashTable00 =
  gst_uri_get_query_table(cast[ptr Uri00](self.impl))

proc gst_uri_get_query_value(self: ptr Uri00; queryKey: cstring): cstring {.
    importc, libprag.}

proc getQueryValue*(self: Uri; queryKey: cstring): string =
  let resul0 = gst_uri_get_query_value(cast[ptr Uri00](self.impl), queryKey)
  if resul0.isNil:
    return
  result = $resul0

proc gst_uri_get_scheme(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getScheme*(self: Uri): string =
  let resul0 = gst_uri_get_scheme(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc scheme*(self: Uri): string =
  let resul0 = gst_uri_get_scheme(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_uri_get_userinfo(self: ptr Uri00): cstring {.
    importc, libprag.}

proc getUserinfo*(self: Uri): string =
  let resul0 = gst_uri_get_userinfo(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc userinfo*(self: Uri): string =
  let resul0 = gst_uri_get_userinfo(cast[ptr Uri00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gst_uri_is_normalized(self: ptr Uri00): gboolean {.
    importc, libprag.}

proc isNormalized*(self: Uri): bool =
  toBool(gst_uri_is_normalized(cast[ptr Uri00](self.impl)))

proc gst_uri_is_writable(self: ptr Uri00): gboolean {.
    importc, libprag.}

proc isWritable*(self: Uri): bool =
  toBool(gst_uri_is_writable(cast[ptr Uri00](self.impl)))

proc gst_uri_join(self: ptr Uri00; refUri: ptr Uri00): ptr Uri00 {.
    importc, libprag.}

proc join*(self: Uri; refUri: Uri = nil): Uri =
  let impl0 = gst_uri_join(cast[ptr Uri00](self.impl), if refUri.isNil: nil else: cast[ptr Uri00](refUri.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstUri)
  result.impl = impl0

proc gst_uri_make_writable(self: ptr Uri00): ptr Uri00 {.
    importc, libprag.}

proc makeWritable*(self: Uri): Uri =
  fnew(result, gBoxedFreeGstUri)
  result.impl = gst_uri_make_writable(cast[ptr Uri00](g_boxed_copy(gst_uri_get_type(), self.impl)))

proc gst_uri_new_with_base(self: ptr Uri00; scheme: cstring; userinfo: cstring;
    host: cstring; port: uint32; path: cstring; query: cstring; fragment: cstring): ptr Uri00 {.
    importc, libprag.}

proc newUriWithBase*(self: Uri; scheme: cstring = nil; userinfo: cstring = nil;
    host: cstring = nil; port: int; path: cstring = nil; query: cstring = nil;
    fragment: cstring = nil): Uri =
  fnew(result, gBoxedFreeGstUri)
  result.impl = gst_uri_new_with_base(cast[ptr Uri00](self.impl), scheme, userinfo, host, uint32(port), path, query, fragment)

proc gst_uri_normalize(self: ptr Uri00): gboolean {.
    importc, libprag.}

proc normalize*(self: Uri): bool =
  toBool(gst_uri_normalize(cast[ptr Uri00](self.impl)))

proc gst_uri_query_has_key(self: ptr Uri00; queryKey: cstring): gboolean {.
    importc, libprag.}

proc queryHasKey*(self: Uri; queryKey: cstring): bool =
  toBool(gst_uri_query_has_key(cast[ptr Uri00](self.impl), queryKey))

proc gst_uri_remove_query_key(self: ptr Uri00; queryKey: cstring): gboolean {.
    importc, libprag.}

proc removeQueryKey*(self: Uri; queryKey: cstring): bool =
  toBool(gst_uri_remove_query_key(cast[ptr Uri00](self.impl), queryKey))

proc gst_uri_set_fragment(self: ptr Uri00; fragment: cstring): gboolean {.
    importc, libprag.}

proc setFragment*(self: Uri; fragment: cstring = nil): bool =
  toBool(gst_uri_set_fragment(cast[ptr Uri00](self.impl), fragment))

proc gst_uri_set_host(self: ptr Uri00; host: cstring): gboolean {.
    importc, libprag.}

proc setHost*(self: Uri; host: cstring): bool =
  toBool(gst_uri_set_host(cast[ptr Uri00](self.impl), host))

proc gst_uri_set_path(self: ptr Uri00; path: cstring): gboolean {.
    importc, libprag.}

proc setPath*(self: Uri; path: cstring): bool =
  toBool(gst_uri_set_path(cast[ptr Uri00](self.impl), path))

proc gst_uri_set_path_segments(self: ptr Uri00; pathSegments: ptr glib.List): gboolean {.
    importc, libprag.}

proc setPathSegments*(self: Uri; pathSegments: seq[cstring]): bool =
  var tempResGL = seq2GList(pathSegments)
  toBool(gst_uri_set_path_segments(cast[ptr Uri00](self.impl), tempResGL))

proc gst_uri_set_path_string(self: ptr Uri00; path: cstring): gboolean {.
    importc, libprag.}

proc setPathString*(self: Uri; path: cstring): bool =
  toBool(gst_uri_set_path_string(cast[ptr Uri00](self.impl), path))

proc gst_uri_set_port(self: ptr Uri00; port: uint32): gboolean {.
    importc, libprag.}

proc setPort*(self: Uri; port: int): bool =
  toBool(gst_uri_set_port(cast[ptr Uri00](self.impl), uint32(port)))

proc gst_uri_set_query_string(self: ptr Uri00; query: cstring): gboolean {.
    importc, libprag.}

proc setQueryString*(self: Uri; query: cstring): bool =
  toBool(gst_uri_set_query_string(cast[ptr Uri00](self.impl), query))

proc gst_uri_set_query_table(self: ptr Uri00; queryTable: ptr HashTable00): gboolean {.
    importc, libprag.}

proc setQueryTable*(self: Uri; queryTable: ptr HashTable00): bool =
  toBool(gst_uri_set_query_table(cast[ptr Uri00](self.impl), queryTable))

proc gst_uri_set_query_value(self: ptr Uri00; queryKey: cstring; queryValue: cstring): gboolean {.
    importc, libprag.}

proc setQueryValue*(self: Uri; queryKey: cstring; queryValue: cstring = nil): bool =
  toBool(gst_uri_set_query_value(cast[ptr Uri00](self.impl), queryKey, queryValue))

proc gst_uri_set_scheme(self: ptr Uri00; scheme: cstring): gboolean {.
    importc, libprag.}

proc setScheme*(self: Uri; scheme: cstring): bool =
  toBool(gst_uri_set_scheme(cast[ptr Uri00](self.impl), scheme))

proc gst_uri_set_userinfo(self: ptr Uri00; userinfo: cstring): gboolean {.
    importc, libprag.}

proc setUserinfo*(self: Uri; userinfo: cstring): bool =
  toBool(gst_uri_set_userinfo(cast[ptr Uri00](self.impl), userinfo))

proc gst_uri_to_string(self: ptr Uri00): cstring {.
    importc, libprag.}

proc toString*(self: Uri): string =
  let resul0 = gst_uri_to_string(cast[ptr Uri00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_uri_construct(protocol: cstring; location: cstring): cstring {.
    importc, libprag.}

proc construct*(protocol: cstring; location: cstring): string =
  let resul0 = gst_uri_construct(protocol, location)
  result = $resul0
  cogfree(resul0)

proc gst_uri_from_string(uri: cstring): ptr Uri00 {.
    importc, libprag.}

proc fromStringUri*(uri: cstring): Uri =
  let impl0 = gst_uri_from_string(uri)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstUri)
  result.impl = impl0

proc gst_uri_from_string_escaped(uri: cstring): ptr Uri00 {.
    importc, libprag.}

proc fromStringEscaped*(uri: cstring): Uri =
  let impl0 = gst_uri_from_string_escaped(uri)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstUri)
  result.impl = impl0

proc gst_uri_get_location(uri: cstring): cstring {.
    importc, libprag.}

proc getLocation*(uri: cstring): string =
  let resul0 = gst_uri_get_location(uri)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc location*(uri: cstring): string =
  let resul0 = gst_uri_get_location(uri)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_uri_get_protocol(uri: cstring): cstring {.
    importc, libprag.}

proc getProtocol*(uri: cstring): string =
  let resul0 = gst_uri_get_protocol(uri)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc protocol*(uri: cstring): string =
  let resul0 = gst_uri_get_protocol(uri)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_uri_has_protocol(uri: cstring; protocol: cstring): gboolean {.
    importc, libprag.}

proc hasProtocol*(uri: cstring; protocol: cstring): bool =
  toBool(gst_uri_has_protocol(uri, protocol))

proc gst_uri_is_valid(uri: cstring): gboolean {.
    importc, libprag.}

proc isValid*(uri: cstring): bool =
  toBool(gst_uri_is_valid(uri))

proc gst_uri_join_strings(baseUri: cstring; refUri: cstring): cstring {.
    importc, libprag.}

proc joinStrings*(baseUri: cstring; refUri: cstring): string =
  let resul0 = gst_uri_join_strings(baseUri, refUri)
  result = $resul0
  cogfree(resul0)

proc gst_uri_protocol_is_supported(`type`: URIType; protocol: cstring): gboolean {.
    importc, libprag.}

proc protocolIsSupported*(`type`: URIType; protocol: cstring): bool =
  toBool(gst_uri_protocol_is_supported(`type`, protocol))

proc gst_uri_protocol_is_valid(protocol: cstring): gboolean {.
    importc, libprag.}

proc protocolIsValid*(protocol: cstring): bool =
  toBool(gst_uri_protocol_is_valid(protocol))

const VALUE_EQUAL* = 0'i32

const VALUE_GREATER_THAN* = 1'i32

const VALUE_LESS_THAN* = -1'i32

const VALUE_UNORDERED* = 2'i32

const VERSION_MAJOR* = 1'i32

const VERSION_MICRO* = 4'i32

const VERSION_MINOR* = 18'i32

const VERSION_NANO* = 0'i32

type
  ValueArray* = ref object of RootRef
    impl*: ptr ValueArray00
    ignoreFinalizer*: bool
  ValueArray00*{.inheritable, pure.} = object

proc gst_value_array_get_type*(): GType {.importc, libprag.}

proc appendAndTakeValueValueArray*(value: gobject.Value; appendValue: gobject.Value) {.
    importc: "gst_value_array_append_and_take_value", libprag.}

proc appendValueValueArray*(value: gobject.Value; appendValue: gobject.Value) {.
    importc: "gst_value_array_append_value", libprag.}

proc gst_value_array_get_size(value: gobject.Value): uint32 {.
    importc, libprag.}

proc getSizeValueArray*(value: gobject.Value): int =
  int(gst_value_array_get_size(value))

proc sizeValueArray*(value: gobject.Value): int =
  int(gst_value_array_get_size(value))

proc gst_value_array_get_value(value: gobject.Value; index: uint32): ptr gobject.Value {.
    importc, libprag.}

proc getValueValueArray*(value: gobject.Value; index: int): ptr gobject.Value =
  gst_value_array_get_value(value, uint32(index))

proc gst_value_array_init(value: gobject.Value; prealloc: uint32): ptr gobject.Value {.
    importc, libprag.}

proc arrayInit*(value: gobject.Value; prealloc: int): ptr gobject.Value =
  gst_value_array_init(value, uint32(prealloc))

proc prependValueValueArray*(value: gobject.Value; prependValue: gobject.Value) {.
    importc: "gst_value_array_prepend_value", libprag.}

type
  ValueCompareFunc* = proc (value1: gobject.Value; value2: gobject.Value): int32 {.cdecl.}

type
  ValueDeserializeFunc* = proc (dest: gobject.Value; s: cstring): gboolean {.cdecl.}

type
  ValueList* = ref object of RootRef
    impl*: ptr ValueList00
    ignoreFinalizer*: bool
  ValueList00*{.inheritable, pure.} = object

proc gst_value_list_get_type*(): GType {.importc, libprag.}

proc appendAndTakeValueValueList*(value: gobject.Value; appendValue: gobject.Value) {.
    importc: "gst_value_list_append_and_take_value", libprag.}

proc appendValueValueList*(value: gobject.Value; appendValue: gobject.Value) {.
    importc: "gst_value_list_append_value", libprag.}

proc concat*(dest: var gobject.Value; value1: gobject.Value;
    value2: gobject.Value) {.
    importc: "gst_value_list_concat", libprag.}

proc gst_value_list_get_size(value: gobject.Value): uint32 {.
    importc, libprag.}

proc getSizeValueList*(value: gobject.Value): int =
  int(gst_value_list_get_size(value))

proc sizeValueList*(value: gobject.Value): int =
  int(gst_value_list_get_size(value))

proc gst_value_list_get_value(value: gobject.Value; index: uint32): ptr gobject.Value {.
    importc, libprag.}

proc getValueValueList*(value: gobject.Value; index: int): ptr gobject.Value =
  gst_value_list_get_value(value, uint32(index))

proc gst_value_list_init(value: gobject.Value; prealloc: uint32): ptr gobject.Value {.
    importc, libprag.}

proc listInit*(value: gobject.Value; prealloc: int): ptr gobject.Value =
  gst_value_list_init(value, uint32(prealloc))

proc merge*(dest: var gobject.Value; value1: gobject.Value;
    value2: gobject.Value) {.
    importc: "gst_value_list_merge", libprag.}

proc prependValueValueList*(value: gobject.Value; prependValue: gobject.Value) {.
    importc: "gst_value_list_prepend_value", libprag.}

type
  ValueSerializeFunc* = proc (value1: gobject.Value): cstring {.cdecl.}

type
  ValueTable00* {.pure.} = object
  ValueTable* = ref object
    impl*: ptr ValueTable00
    ignoreFinalizer*: bool

proc debugAddLogFunction*(`func`: LogFunction; userData: pointer; notify: DestroyNotify) {.
    importc: "gst_debug_add_log_function", libprag.}

proc gst_debug_add_ring_buffer_logger(maxSizePerThread: uint32; threadTimeout: uint32) {.
    importc, libprag.}

proc debugAddRingBufferLogger*(maxSizePerThread: int; threadTimeout: int) =
  gst_debug_add_ring_buffer_logger(uint32(maxSizePerThread), uint32(threadTimeout))

proc gst_debug_bin_to_dot_data(bin: ptr Bin00; details: DebugGraphDetails): cstring {.
    importc, libprag.}

proc debugBinToDotData*(bin: Bin; details: DebugGraphDetails): string =
  let resul0 = gst_debug_bin_to_dot_data(cast[ptr Bin00](bin.impl), details)
  result = $resul0
  cogfree(resul0)

proc gst_debug_bin_to_dot_file(bin: ptr Bin00; details: DebugGraphDetails;
    fileName: cstring) {.
    importc, libprag.}

proc debugBinToDotFile*(bin: Bin; details: DebugGraphDetails; fileName: cstring) =
  gst_debug_bin_to_dot_file(cast[ptr Bin00](bin.impl), details, fileName)

proc gst_debug_bin_to_dot_file_with_ts(bin: ptr Bin00; details: DebugGraphDetails;
    fileName: cstring) {.
    importc, libprag.}

proc debugBinToDotFileWithTs*(bin: Bin; details: DebugGraphDetails;
    fileName: cstring) =
  gst_debug_bin_to_dot_file_with_ts(cast[ptr Bin00](bin.impl), details, fileName)

proc gst_debug_construct_term_color(colorinfo: uint32): cstring {.
    importc, libprag.}

proc debugConstructTermColor*(colorinfo: int): string =
  let resul0 = gst_debug_construct_term_color(uint32(colorinfo))
  result = $resul0
  cogfree(resul0)

proc gst_debug_construct_win_color(colorinfo: uint32): int32 {.
    importc, libprag.}

proc debugConstructWinColor*(colorinfo: int): int =
  int(gst_debug_construct_win_color(uint32(colorinfo)))

proc debugGetAllCategories*(): ptr glib.SList {.
    importc: "gst_debug_get_all_categories", libprag.}

proc debugGetColorMode*(): DebugColorMode {.
    importc: "gst_debug_get_color_mode", libprag.}

proc debugGetDefaultThreshold*(): DebugLevel {.
    importc: "gst_debug_get_default_threshold", libprag.}

proc gst_debug_get_stack_trace(flags: StackTraceFlags): cstring {.
    importc, libprag.}

proc debugGetStackTrace*(flags: StackTraceFlags): string =
  let resul0 = gst_debug_get_stack_trace(flags)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gst_debug_is_active(): gboolean {.
    importc, libprag.}

proc debugIsActive*(): bool =
  toBool(gst_debug_is_active())

proc gst_debug_is_colored(): gboolean {.
    importc, libprag.}

proc debugIsColored*(): bool =
  toBool(gst_debug_is_colored())

proc gst_debug_log_default(category: ptr DebugCategory00; level: DebugLevel;
    file: cstring; function: cstring; line: int32; `object`: ptr gobject.Object00;
    message: ptr DebugMessage00; userData: pointer) {.
    importc, libprag.}

proc debugLogDefault*(category: DebugCategory; level: DebugLevel; file: cstring;
    function: cstring; line: int; `object`: gobject.Object = nil; message: DebugMessage;
    userData: pointer) =
  gst_debug_log_default(cast[ptr DebugCategory00](category.impl), level, file, function, int32(line), if `object`.isNil: nil else: cast[ptr gobject.Object00](`object`.impl), cast[ptr DebugMessage00](message.impl), userData)

proc gst_debug_log_get_line(category: ptr DebugCategory00; level: DebugLevel;
    file: cstring; function: cstring; line: int32; `object`: ptr gobject.Object00;
    message: ptr DebugMessage00): cstring {.
    importc, libprag.}

proc debugLogGetLine*(category: DebugCategory; level: DebugLevel; file: cstring;
    function: cstring; line: int; `object`: gobject.Object = nil; message: DebugMessage): string =
  let resul0 = gst_debug_log_get_line(cast[ptr DebugCategory00](category.impl), level, file, function, int32(line), if `object`.isNil: nil else: cast[ptr gobject.Object00](`object`.impl), cast[ptr DebugMessage00](message.impl))
  result = $resul0
  cogfree(resul0)

proc debugPrintStackTrace*() {.
    importc: "gst_debug_print_stack_trace", libprag.}

proc gst_debug_remove_log_function(`func`: LogFunction): uint32 {.
    importc, libprag.}

proc debugRemoveLogFunction*(`func`: LogFunction): int =
  int(gst_debug_remove_log_function(`func`))

proc gst_debug_remove_log_function_by_data(data: pointer): uint32 {.
    importc, libprag.}

proc debugRemoveLogFunctionByData*(data: pointer): int =
  int(gst_debug_remove_log_function_by_data(data))

proc debugRemoveRingBufferLogger*() {.
    importc: "gst_debug_remove_ring_buffer_logger", libprag.}

proc gst_debug_ring_buffer_logger_get_logs(): ptr cstring {.
    importc, libprag.}

proc debugRingBufferLoggerGetLogs*(): seq[string] =
  let resul0 = gst_debug_ring_buffer_logger_get_logs()
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_debug_set_active(active: gboolean) {.
    importc, libprag.}

proc debugSetActive*(active: bool = true) =
  gst_debug_set_active(gboolean(active))

proc debugSetColorMode*(mode: DebugColorMode) {.
    importc: "gst_debug_set_color_mode", libprag.}

proc debugSetColorModeFromString*(mode: cstring) {.
    importc: "gst_debug_set_color_mode_from_string", libprag.}

proc gst_debug_set_colored(colored: gboolean) {.
    importc, libprag.}

proc debugSetColored*(colored: bool = true) =
  gst_debug_set_colored(gboolean(colored))

proc debugSetDefaultThreshold*(level: DebugLevel) {.
    importc: "gst_debug_set_default_threshold", libprag.}

proc debugSetThresholdForName*(name: cstring; level: DebugLevel) {.
    importc: "gst_debug_set_threshold_for_name", libprag.}

proc gst_debug_set_threshold_from_string(list: cstring; reset: gboolean) {.
    importc, libprag.}

proc debugSetThresholdFromString*(list: cstring; reset: bool) =
  gst_debug_set_threshold_from_string(list, gboolean(reset))

proc debugUnsetThresholdForName*(name: cstring) {.
    importc: "gst_debug_unset_threshold_for_name", libprag.}

proc deinit*() {.
    importc: "gst_deinit", libprag.}

proc gst_dynamic_type_register(plugin: ptr Plugin00; `type`: GType): gboolean {.
    importc, libprag.}

proc dynamicTypeRegister*(plugin: Plugin; `type`: GType): bool =
  toBool(gst_dynamic_type_register(cast[ptr Plugin00](plugin.impl), `type`))

proc gst_error_get_message(domain: uint32; code: int32): cstring {.
    importc, libprag.}

proc errorGetMessage*(domain: int; code: int): string =
  let resul0 = gst_error_get_message(uint32(domain), int32(code))
  result = $resul0
  cogfree(resul0)

proc gst_filename_to_uri(filename: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc filenameToUri*(filename: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = gst_filename_to_uri(filename, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc gst_flow_get_name(ret: FlowReturn): cstring {.
    importc, libprag.}

proc flowGetName*(ret: FlowReturn): string =
  result = $gst_flow_get_name(ret)

proc gst_flow_to_quark(ret: FlowReturn): uint32 {.
    importc, libprag.}

proc flowToQuark*(ret: FlowReturn): int =
  int(gst_flow_to_quark(ret))

proc gst_formats_contains(formats: ptr Format; format: Format): gboolean {.
    importc, libprag.}

proc formatsContains*(formats: ptr Format; format: Format): bool =
  toBool(gst_formats_contains(formats, format))

proc gst_get_main_executable_path(): cstring {.
    importc, libprag.}

proc getMainExecutablePath*(): string =
  let resul0 = gst_get_main_executable_path()
  if resul0.isNil:
    return
  result = $resul0

proc gst_init(argc: var int32; argv: var ptr cstring) {.
    importc, libprag.}

proc init*(argc: var int; argv: var seq[string]) =
  var argc_00 = int32(argc)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var argv_00 = seq2CstringArray(argv, fs469n23)
  gst_init(argc_00, argv_00)
  argc = int(argc_00)
  argv = cstringArrayToSeq(argv_00)

proc gst_init_check(argc: var int32; argv: var ptr cstring; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc initCheck*(argc: var int; argv: var seq[string]): bool =
  var gerror: ptr glib.Error
  var argc_00 = int32(argc)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var argv_00 = seq2CstringArray(argv, fs469n23)
  let resul0 = gst_init_check(argc_00, argv_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  argc = int(argc_00)
  argv = cstringArrayToSeq(argv_00)

proc gst_is_caps_features(obj: pointer): gboolean {.
    importc, libprag.}

proc isCapsFeatures*(obj: pointer): bool =
  toBool(gst_is_caps_features(obj))

proc gst_is_initialized(): gboolean {.
    importc, libprag.}

proc isInitialized*(): bool =
  toBool(gst_is_initialized())

proc parentBufferMetaApiGetType*(): GType {.
    importc: "gst_parent_buffer_meta_api_get_type", libprag.}

proc gst_parse_bin_from_description(binDescription: cstring; ghostUnlinkedPads: gboolean;
    error: ptr ptr glib.Error = nil): ptr Bin00 {.
    importc, libprag.}

proc parseBinFromDescription*(binDescription: cstring; ghostUnlinkedPads: bool): Bin =
  var gerror: ptr glib.Error
  let gobj = gst_parse_bin_from_description(binDescription, gboolean(ghostUnlinkedPads), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_parse_bin_from_description_full(binDescription: cstring; ghostUnlinkedPads: gboolean;
    context: ptr ParseContext00; flags: ParseFlags; error: ptr ptr glib.Error = nil): ptr Element00 {.
    importc, libprag.}

proc parseBinFromDescriptionFull*(binDescription: cstring; ghostUnlinkedPads: bool;
    context: ParseContext = nil; flags: ParseFlags): Element =
  var gerror: ptr glib.Error
  let gobj = gst_parse_bin_from_description_full(binDescription, gboolean(ghostUnlinkedPads), if context.isNil: nil else: cast[ptr ParseContext00](context.impl), flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_parse_launch(pipelineDescription: cstring; error: ptr ptr glib.Error = nil): ptr Element00 {.
    importc, libprag.}

proc parseLaunch*(pipelineDescription: cstring): Element =
  var gerror: ptr glib.Error
  let gobj = gst_parse_launch(pipelineDescription, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_parse_launch_full(pipelineDescription: cstring; context: ptr ParseContext00;
    flags: ParseFlags; error: ptr ptr glib.Error = nil): ptr Element00 {.
    importc, libprag.}

proc parseLaunchFull*(pipelineDescription: cstring; context: ParseContext = nil;
    flags: ParseFlags): Element =
  var gerror: ptr glib.Error
  let gobj = gst_parse_launch_full(pipelineDescription, if context.isNil: nil else: cast[ptr ParseContext00](context.impl), flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_parse_launchv(argv: ptr cstring; error: ptr ptr glib.Error = nil): ptr Element00 {.
    importc, libprag.}

proc parseLaunchv*(argv: varargs[string, `$`]): Element =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let gobj = gst_parse_launchv(seq2CstringArray(argv, fs469n23), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_parse_launchv_full(argv: ptr cstring; context: ptr ParseContext00;
    flags: ParseFlags; error: ptr ptr glib.Error = nil): ptr Element00 {.
    importc, libprag.}

proc parseLaunchvFull*(argv: openArray[string]; context: ParseContext = nil;
    flags: ParseFlags): Element =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var gerror: ptr glib.Error
  let gobj = gst_parse_launchv_full(seq2CstringArray(argv, fs469n23), if context.isNil: nil else: cast[ptr ParseContext00](context.impl), flags, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gst.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_protection_filter_systems_by_available_decryptors(systemIdentifiers: ptr cstring): ptr cstring {.
    importc, libprag.}

proc protectionFilterSystemsByAvailableDecryptors*(systemIdentifiers: varargs[string, `$`]): seq[string] =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = gst_protection_filter_systems_by_available_decryptors(seq2CstringArray(systemIdentifiers, fs469n23))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc protectionMetaApiGetType*(): GType {.
    importc: "gst_protection_meta_api_get_type", libprag.}

proc gst_protection_select_system(systemIdentifiers: ptr cstring): cstring {.
    importc, libprag.}

proc protectionSelectSystem*(systemIdentifiers: varargs[string, `$`]): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = gst_protection_select_system(seq2CstringArray(systemIdentifiers, fs469n23))
  if resul0.isNil:
    return
  result = $resul0

proc referenceTimestampMetaApiGetType*(): GType {.
    importc: "gst_reference_timestamp_meta_api_get_type", libprag.}

proc gst_segtrap_is_enabled(): gboolean {.
    importc, libprag.}

proc segtrapIsEnabled*(): bool =
  toBool(gst_segtrap_is_enabled())

proc gst_segtrap_set_enabled(enabled: gboolean) {.
    importc, libprag.}

proc segtrapSetEnabled*(enabled: bool = true) =
  gst_segtrap_set_enabled(gboolean(enabled))

proc staticCapsGetType*(): GType {.
    importc: "gst_static_caps_get_type", libprag.}

proc staticPadTemplateGetType*(): GType {.
    importc: "gst_static_pad_template_get_type", libprag.}

proc gst_tag_exists(tag: cstring): gboolean {.
    importc, libprag.}

proc tagExists*(tag: cstring): bool =
  toBool(gst_tag_exists(tag))

proc gst_tag_get_description(tag: cstring): cstring {.
    importc, libprag.}

proc tagGetDescription*(tag: cstring): string =
  let resul0 = gst_tag_get_description(tag)
  if resul0.isNil:
    return
  result = $resul0

proc tagGetFlag*(tag: cstring): TagFlag {.
    importc: "gst_tag_get_flag", libprag.}

proc gst_tag_get_nick(tag: cstring): cstring {.
    importc, libprag.}

proc tagGetNick*(tag: cstring): string =
  let resul0 = gst_tag_get_nick(tag)
  if resul0.isNil:
    return
  result = $resul0

proc tagGetType*(tag: cstring): GType {.
    importc: "gst_tag_get_type", libprag.}

proc gst_tag_is_fixed(tag: cstring): gboolean {.
    importc, libprag.}

proc tagIsFixed*(tag: cstring): bool =
  toBool(gst_tag_is_fixed(tag))

proc tagMergeStringsWithComma*(dest: var gobject.Value; src: gobject.Value) {.
    importc: "gst_tag_merge_strings_with_comma", libprag.}

proc tagMergeUseFirst*(dest: var gobject.Value; src: gobject.Value) {.
    importc: "gst_tag_merge_use_first", libprag.}

proc gst_tracing_get_active_tracers(): ptr glib.List {.
    importc, libprag.}

proc tracingGetActiveTracers*(): seq[Tracer] =
  let resul0 = gst_tracing_get_active_tracers()
  result = glistObjects2seq(Tracer, resul0, true)
  g_list_free(resul0)

proc gst_tracing_register_hook(tracer: ptr Tracer00; detail: cstring; `func`: Callback) {.
    importc, libprag.}

proc tracingRegisterHook*(tracer: Tracer; detail: cstring; `func`: Callback) =
  gst_tracing_register_hook(cast[ptr Tracer00](tracer.impl), detail, `func`)

proc typeFindGetType*(): GType {.
    importc: "gst_type_find_get_type", libprag.}

proc gst_type_is_plugin_api(`type`: GType; flags: var PluginAPIFlags): gboolean {.
    importc, libprag.}

proc typeIsPluginApi*(`type`: GType; flags: var PluginAPIFlags): bool =
  toBool(gst_type_is_plugin_api(`type`, flags))

proc typeMarkAsPluginApi*(`type`: GType; flags: PluginAPIFlags) {.
    importc: "gst_type_mark_as_plugin_api", libprag.}

proc gst_update_registry(): gboolean {.
    importc, libprag.}

proc updateRegistry*(): bool =
  toBool(gst_update_registry())

proc gst_util_array_binary_search(array: pointer; numElements: uint32; elementSize: uint64;
    searchFunc: CompareDataFunc; mode: SearchMode; searchData: pointer; userData: pointer): pointer {.
    importc, libprag.}

proc utilArrayBinarySearch*(array: pointer; numElements: int; elementSize: uint64;
    searchFunc: CompareDataFunc; mode: SearchMode; searchData: pointer; userData: pointer): pointer =
  gst_util_array_binary_search(array, uint32(numElements), elementSize, searchFunc, mode, searchData, userData)

proc gst_util_double_to_fraction(src: cdouble; destN: var int32; destD: var int32) {.
    importc, libprag.}

proc utilDoubleToFraction*(src: cdouble; destN: var int; destD: var int) =
  var destD_00: int32
  var destN_00: int32
  gst_util_double_to_fraction(src, destN_00, destD_00)
  if destD.addr != nil:
    destD = int(destD_00)
  if destN.addr != nil:
    destN = int(destN_00)

proc gst_util_dump_buffer(buf: ptr Buffer00) {.
    importc, libprag.}

proc utilDumpBuffer*(buf: Buffer) =
  gst_util_dump_buffer(cast[ptr Buffer00](buf.impl))

proc gst_util_dump_mem(mem: ptr uint8; size: uint32) {.
    importc, libprag.}

proc utilDumpMem*(mem: seq[uint8] | string) =
  let size = int(mem.len)
  gst_util_dump_mem(cast[ptr uint8](unsafeaddr(mem[0])), uint32(size))

proc gst_util_fraction_add(aN: int32; aD: int32; bN: int32; bD: int32; resN: var int32;
    resD: var int32): gboolean {.
    importc, libprag.}

proc utilFractionAdd*(aN: int; aD: int; bN: int; bD: int; resN: var int;
    resD: var int): bool =
  var resN_00: int32
  var resD_00: int32
  result = toBool(gst_util_fraction_add(int32(aN), int32(aD), int32(bN), int32(bD), resN_00, resD_00))
  if resN.addr != nil:
    resN = int(resN_00)
  if resD.addr != nil:
    resD = int(resD_00)

proc gst_util_fraction_compare(aN: int32; aD: int32; bN: int32; bD: int32): int32 {.
    importc, libprag.}

proc utilFractionCompare*(aN: int; aD: int; bN: int; bD: int): int =
  int(gst_util_fraction_compare(int32(aN), int32(aD), int32(bN), int32(bD)))

proc gst_util_fraction_multiply(aN: int32; aD: int32; bN: int32; bD: int32;
    resN: var int32; resD: var int32): gboolean {.
    importc, libprag.}

proc utilFractionMultiply*(aN: int; aD: int; bN: int; bD: int; resN: var int;
    resD: var int): bool =
  var resN_00: int32
  var resD_00: int32
  result = toBool(gst_util_fraction_multiply(int32(aN), int32(aD), int32(bN), int32(bD), resN_00, resD_00))
  if resN.addr != nil:
    resN = int(resN_00)
  if resD.addr != nil:
    resD = int(resD_00)

proc gst_util_fraction_to_double(srcN: int32; srcD: int32; dest: var cdouble) {.
    importc, libprag.}

proc utilFractionToDouble*(srcN: int; srcD: int; dest: var cdouble) =
  gst_util_fraction_to_double(int32(srcN), int32(srcD), dest)

proc utilGdoubleToGuint64*(value: cdouble): uint64 {.
    importc: "gst_util_gdouble_to_guint64", libprag.}

proc gst_util_get_object_array(`object`: ptr gobject.Object00; name: cstring;
    array: var ptr gobject.ValueArray00): gboolean {.
    importc, libprag.}

proc utilGetObjectArray*(`object`: gobject.Object; name: cstring; array: var gobject.ValueArray): bool =
  fnew(array, gBoxedFreeGValueArray)
  toBool(gst_util_get_object_array(cast[ptr gobject.Object00](`object`.impl), name, cast[var ptr gobject.ValueArray00](addr array.impl)))

proc utilGetTimestamp*(): uint64 {.
    importc: "gst_util_get_timestamp", libprag.}

proc gst_util_greatest_common_divisor(a: int32; b: int32): int32 {.
    importc, libprag.}

proc utilGreatestCommonDivisor*(a: int; b: int): int =
  int(gst_util_greatest_common_divisor(int32(a), int32(b)))

proc utilGreatestCommonDivisorInt64*(a: int64; b: int64): int64 {.
    importc: "gst_util_greatest_common_divisor_int64", libprag.}

proc gst_util_group_id_next(): uint32 {.
    importc, libprag.}

proc utilGroupIdNext*(): int =
  int(gst_util_group_id_next())

proc utilGuint64ToGdouble*(value: uint64): cdouble {.
    importc: "gst_util_guint64_to_gdouble", libprag.}

proc gst_util_seqnum_compare(s1: uint32; s2: uint32): int32 {.
    importc, libprag.}

proc utilSeqnumCompare*(s1: int; s2: int): int =
  int(gst_util_seqnum_compare(uint32(s1), uint32(s2)))

proc gst_util_seqnum_next(): uint32 {.
    importc, libprag.}

proc utilSeqnumNext*(): int =
  int(gst_util_seqnum_next())

proc gst_util_set_object_arg(`object`: ptr gobject.Object00; name: cstring;
    value: cstring) {.
    importc, libprag.}

proc utilSetObjectArg*(`object`: gobject.Object; name: cstring; value: cstring) =
  gst_util_set_object_arg(cast[ptr gobject.Object00](`object`.impl), name, value)

proc gst_util_set_object_array(`object`: ptr gobject.Object00; name: cstring;
    array: ptr gobject.ValueArray00): gboolean {.
    importc, libprag.}

proc utilSetObjectArray*(`object`: gobject.Object; name: cstring; array: gobject.ValueArray): bool =
  toBool(gst_util_set_object_array(cast[ptr gobject.Object00](`object`.impl), name, cast[ptr gobject.ValueArray00](array.impl)))

proc utilSetValueFromString*(value: var gobject.Value; valueStr: cstring) {.
    importc: "gst_util_set_value_from_string", libprag.}

proc utilUint64Scale*(val: uint64; num: uint64; denom: uint64): uint64 {.
    importc: "gst_util_uint64_scale", libprag.}

proc utilUint64ScaleCeil*(val: uint64; num: uint64; denom: uint64): uint64 {.
    importc: "gst_util_uint64_scale_ceil", libprag.}

proc gst_util_uint64_scale_int(val: uint64; num: int32; denom: int32): uint64 {.
    importc, libprag.}

proc utilUint64ScaleInt*(val: uint64; num: int; denom: int): uint64 =
  gst_util_uint64_scale_int(val, int32(num), int32(denom))

proc gst_util_uint64_scale_int_ceil(val: uint64; num: int32; denom: int32): uint64 {.
    importc, libprag.}

proc utilUint64ScaleIntCeil*(val: uint64; num: int; denom: int): uint64 =
  gst_util_uint64_scale_int_ceil(val, int32(num), int32(denom))

proc gst_util_uint64_scale_int_round(val: uint64; num: int32; denom: int32): uint64 {.
    importc, libprag.}

proc utilUint64ScaleIntRound*(val: uint64; num: int; denom: int): uint64 =
  gst_util_uint64_scale_int_round(val, int32(num), int32(denom))

proc utilUint64ScaleRound*(val: uint64; num: uint64; denom: uint64): uint64 {.
    importc: "gst_util_uint64_scale_round", libprag.}

proc gst_value_can_compare(value1: gobject.Value; value2: gobject.Value): gboolean {.
    importc, libprag.}

proc valueCanCompare*(value1: gobject.Value; value2: gobject.Value): bool =
  toBool(gst_value_can_compare(value1, value2))

proc gst_value_can_intersect(value1: gobject.Value; value2: gobject.Value): gboolean {.
    importc, libprag.}

proc valueCanIntersect*(value1: gobject.Value; value2: gobject.Value): bool =
  toBool(gst_value_can_intersect(value1, value2))

proc gst_value_can_subtract(minuend: gobject.Value; subtrahend: gobject.Value): gboolean {.
    importc, libprag.}

proc valueCanSubtract*(minuend: gobject.Value; subtrahend: gobject.Value): bool =
  toBool(gst_value_can_subtract(minuend, subtrahend))

proc gst_value_can_union(value1: gobject.Value; value2: gobject.Value): gboolean {.
    importc, libprag.}

proc valueCanUnion*(value1: gobject.Value; value2: gobject.Value): bool =
  toBool(gst_value_can_union(value1, value2))

proc gst_value_compare(value1: gobject.Value; value2: gobject.Value): int32 {.
    importc, libprag.}

proc valueCompare*(value1: gobject.Value; value2: gobject.Value): int =
  int(gst_value_compare(value1, value2))

proc gst_value_deserialize(dest: var gobject.Value; src: cstring): gboolean {.
    importc, libprag.}

proc valueDeserialize*(dest: var gobject.Value; src: cstring): bool =
  toBool(gst_value_deserialize(dest, src))

proc gst_value_fixate(dest: gobject.Value; src: gobject.Value): gboolean {.
    importc, libprag.}

proc valueFixate*(dest: gobject.Value; src: gobject.Value): bool =
  toBool(gst_value_fixate(dest, src))

proc gst_value_fraction_multiply(product: gobject.Value; factor1: gobject.Value;
    factor2: gobject.Value): gboolean {.
    importc, libprag.}

proc valueFractionMultiply*(product: gobject.Value; factor1: gobject.Value;
    factor2: gobject.Value): bool =
  toBool(gst_value_fraction_multiply(product, factor1, factor2))

proc gst_value_fraction_subtract(dest: gobject.Value; minuend: gobject.Value;
    subtrahend: gobject.Value): gboolean {.
    importc, libprag.}

proc valueFractionSubtract*(dest: gobject.Value; minuend: gobject.Value;
    subtrahend: gobject.Value): bool =
  toBool(gst_value_fraction_subtract(dest, minuend, subtrahend))

proc valueGetBitmask*(value: gobject.Value): uint64 {.
    importc: "gst_value_get_bitmask", libprag.}

proc gst_value_get_caps(value: gobject.Value): ptr Caps00 {.
    importc, libprag.}

proc valueGetCaps*(value: gobject.Value): Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_value_get_caps(value)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_get_type(), result.impl))

proc gst_value_get_caps_features(value: gobject.Value): ptr CapsFeatures00 {.
    importc, libprag.}

proc valueGetCapsFeatures*(value: gobject.Value): CapsFeatures =
  fnew(result, gBoxedFreeGstCapsFeatures)
  result.impl = gst_value_get_caps_features(value)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_caps_features_get_type(), result.impl))

proc valueGetDoubleRangeMax*(value: gobject.Value): cdouble {.
    importc: "gst_value_get_double_range_max", libprag.}

proc valueGetDoubleRangeMin*(value: gobject.Value): cdouble {.
    importc: "gst_value_get_double_range_min", libprag.}

proc gst_value_get_flagset_flags(value: gobject.Value): uint32 {.
    importc, libprag.}

proc valueGetFlagsetFlags*(value: gobject.Value): int =
  int(gst_value_get_flagset_flags(value))

proc gst_value_get_flagset_mask(value: gobject.Value): uint32 {.
    importc, libprag.}

proc valueGetFlagsetMask*(value: gobject.Value): int =
  int(gst_value_get_flagset_mask(value))

proc gst_value_get_fraction_denominator(value: gobject.Value): int32 {.
    importc, libprag.}

proc valueGetFractionDenominator*(value: gobject.Value): int =
  int(gst_value_get_fraction_denominator(value))

proc gst_value_get_fraction_numerator(value: gobject.Value): int32 {.
    importc, libprag.}

proc valueGetFractionNumerator*(value: gobject.Value): int =
  int(gst_value_get_fraction_numerator(value))

proc valueGetFractionRangeMax*(value: gobject.Value): ptr gobject.Value {.
    importc: "gst_value_get_fraction_range_max", libprag.}

proc valueGetFractionRangeMin*(value: gobject.Value): ptr gobject.Value {.
    importc: "gst_value_get_fraction_range_min", libprag.}

proc valueGetInt64RangeMax*(value: gobject.Value): int64 {.
    importc: "gst_value_get_int64_range_max", libprag.}

proc valueGetInt64RangeMin*(value: gobject.Value): int64 {.
    importc: "gst_value_get_int64_range_min", libprag.}

proc valueGetInt64RangeStep*(value: gobject.Value): int64 {.
    importc: "gst_value_get_int64_range_step", libprag.}

proc gst_value_get_int_range_max(value: gobject.Value): int32 {.
    importc, libprag.}

proc valueGetIntRangeMax*(value: gobject.Value): int =
  int(gst_value_get_int_range_max(value))

proc gst_value_get_int_range_min(value: gobject.Value): int32 {.
    importc, libprag.}

proc valueGetIntRangeMin*(value: gobject.Value): int =
  int(gst_value_get_int_range_min(value))

proc gst_value_get_int_range_step(value: gobject.Value): int32 {.
    importc, libprag.}

proc valueGetIntRangeStep*(value: gobject.Value): int =
  int(gst_value_get_int_range_step(value))

proc gst_value_get_structure(value: gobject.Value): ptr Structure00 {.
    importc, libprag.}

proc valueGetStructure*(value: gobject.Value): Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_value_get_structure(value)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc valueInitAndCopy*(dest: var gobject.Value; src: gobject.Value) {.
    importc: "gst_value_init_and_copy", libprag.}

proc gst_value_intersect(dest: var gobject.Value; value1: gobject.Value;
    value2: gobject.Value): gboolean {.
    importc, libprag.}

proc valueIntersect*(dest: var gobject.Value = cast[var gobject.Value](nil);
    value1: gobject.Value; value2: gobject.Value): bool =
  toBool(gst_value_intersect(dest, value1, value2))

proc gst_value_is_fixed(value: gobject.Value): gboolean {.
    importc, libprag.}

proc valueIsFixed*(value: gobject.Value): bool =
  toBool(gst_value_is_fixed(value))

proc gst_value_is_subset(value1: gobject.Value; value2: gobject.Value): gboolean {.
    importc, libprag.}

proc valueIsSubset*(value1: gobject.Value; value2: gobject.Value): bool =
  toBool(gst_value_is_subset(value1, value2))

proc gst_value_register(table: ptr ValueTable00) {.
    importc, libprag.}

proc valueRegister*(table: ValueTable) =
  gst_value_register(cast[ptr ValueTable00](table.impl))

proc gst_value_serialize(value: gobject.Value): cstring {.
    importc, libprag.}

proc valueSerialize*(value: gobject.Value): string =
  let resul0 = gst_value_serialize(value)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc valueSetBitmask*(value: gobject.Value; bitmask: uint64) {.
    importc: "gst_value_set_bitmask", libprag.}

proc gst_value_set_caps(value: gobject.Value; caps: ptr Caps00) {.
    importc, libprag.}

proc valueSetCaps*(value: gobject.Value; caps: Caps) =
  gst_value_set_caps(value, cast[ptr Caps00](caps.impl))

proc gst_value_set_caps_features(value: gobject.Value; features: ptr CapsFeatures00) {.
    importc, libprag.}

proc valueSetCapsFeatures*(value: gobject.Value; features: CapsFeatures) =
  gst_value_set_caps_features(value, cast[ptr CapsFeatures00](features.impl))

proc valueSetDoubleRange*(value: gobject.Value; start: cdouble; `end`: cdouble) {.
    importc: "gst_value_set_double_range", libprag.}

proc gst_value_set_flagset(value: gobject.Value; flags: uint32; mask: uint32) {.
    importc, libprag.}

proc valueSetFlagset*(value: gobject.Value; flags: int; mask: int) =
  gst_value_set_flagset(value, uint32(flags), uint32(mask))

proc gst_value_set_fraction(value: gobject.Value; numerator: int32; denominator: int32) {.
    importc, libprag.}

proc valueSetFraction*(value: gobject.Value; numerator: int; denominator: int) =
  gst_value_set_fraction(value, int32(numerator), int32(denominator))

proc valueSetFractionRange*(value: gobject.Value; start: gobject.Value;
    `end`: gobject.Value) {.
    importc: "gst_value_set_fraction_range", libprag.}

proc gst_value_set_fraction_range_full(value: gobject.Value; numeratorStart: int32;
    denominatorStart: int32; numeratorEnd: int32; denominatorEnd: int32) {.
    importc, libprag.}

proc valueSetFractionRangeFull*(value: gobject.Value; numeratorStart: int;
    denominatorStart: int; numeratorEnd: int; denominatorEnd: int) =
  gst_value_set_fraction_range_full(value, int32(numeratorStart), int32(denominatorStart), int32(numeratorEnd), int32(denominatorEnd))

proc valueSetInt64Range*(value: gobject.Value; start: int64; `end`: int64) {.
    importc: "gst_value_set_int64_range", libprag.}

proc valueSetInt64RangeStep*(value: gobject.Value; start: int64; `end`: int64;
    step: int64) {.
    importc: "gst_value_set_int64_range_step", libprag.}

proc gst_value_set_int_range(value: gobject.Value; start: int32; `end`: int32) {.
    importc, libprag.}

proc valueSetIntRange*(value: gobject.Value; start: int; `end`: int) =
  gst_value_set_int_range(value, int32(start), int32(`end`))

proc gst_value_set_int_range_step(value: gobject.Value; start: int32; `end`: int32;
    step: int32) {.
    importc, libprag.}

proc valueSetIntRangeStep*(value: gobject.Value; start: int; `end`: int;
    step: int) =
  gst_value_set_int_range_step(value, int32(start), int32(`end`), int32(step))

proc gst_value_set_structure(value: gobject.Value; structure: ptr Structure00) {.
    importc, libprag.}

proc valueSetStructure*(value: gobject.Value; structure: Structure) =
  gst_value_set_structure(value, cast[ptr Structure00](structure.impl))

proc gst_value_subtract(dest: var gobject.Value; minuend: gobject.Value;
    subtrahend: gobject.Value): gboolean {.
    importc, libprag.}

proc valueSubtract*(dest: var gobject.Value = cast[var gobject.Value](nil);
    minuend: gobject.Value; subtrahend: gobject.Value): bool =
  toBool(gst_value_subtract(dest, minuend, subtrahend))

proc gst_value_union(dest: var gobject.Value; value1: gobject.Value; value2: gobject.Value): gboolean {.
    importc, libprag.}

proc valueUnion*(dest: var gobject.Value; value1: gobject.Value; value2: gobject.Value): bool =
  toBool(gst_value_union(dest, value1, value2))

proc gst_version(major: var uint32; minor: var uint32; micro: var uint32;
    nano: var uint32) {.
    importc, libprag.}

proc version*(major: var int; minor: var int; micro: var int; nano: var int) =
  var nano_00: uint32
  var major_00: uint32
  var minor_00: uint32
  var micro_00: uint32
  gst_version(major_00, minor_00, micro_00, nano_00)
  if nano.addr != nil:
    nano = int(nano_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)
  if micro.addr != nil:
    micro = int(micro_00)

proc gst_version_string(): cstring {.
    importc, libprag.}

proc versionString*(): string =
  let resul0 = gst_version_string()
  result = $resul0
  cogfree(resul0)
# === remaining symbols:
proc init* =
  var argc: int32 = 0
  #var argv: cstringArray = nil
  var argv: ptr cstring = nil
  gst_init(argc,  argv)

proc getType*(m: gst.Message): gst.MessageType =
  m.impl.type

proc gst_structure_from_string(string: cstring; `end`: var cstring): ptr Structure00 {.
    importc, libprag.}

proc fromStringStructure*(string: cstring; `end`: var string): Structure =
  var end_00 = cstring(`end`)
  let impl0 = gst_structure_from_string(string, end_00)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0
  `end` = $(end_00)

# https://discourse.gnome.org/t/gst-buffer-copy-is-missing-in-gir-file/5327
# GstMiniObject * gst_mini_object_copy (const GstMiniObject *mini_object);
proc gst_buffer_copy(self: ptr Buffer00): ptr Buffer00 {.
    importc: "gst_mini_object_copy", libprag.}

proc copy*(self: Buffer): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_copy(cast[ptr Buffer00](self.impl))

include gimplgst

