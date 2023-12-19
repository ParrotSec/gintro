# dependencies:
# GLib-2.0
# immediate dependencies:
# GLib-2.0
# libraries:
# libgobject-2.0.so.0
{.warning[UnusedImport]: off.}
import glib
const Lib = "libgobject-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
type
  GCallback* = proc () {.cdecl.}
type
  VaClosureMarshal* = pointer

proc boxedFree*(boxedType: GType; boxed: pointer) {.
    importc: "g_boxed_free", libprag.}

proc g_boxed_copy*(boxedType: GType; boxed: pointer): pointer {.
    importc , libprag.}

import times
var qt = "NGIQ" & $epochTime()
if g_quark_try_string(qt) != 0:
  qt = "NGIQ" & $epochTime()
let Quark* = g_quark_from_static_string(qt)

type
  TypeClass00* {.pure.} = object
  TypeClass* = ref object
    impl*: ptr TypeClass00
    ignoreFinalizer*: bool

proc g_type_class_unref(self: ptr TypeClass00) {.
    importc, libprag.}

proc unref*(self: TypeClass) =
  g_type_class_unref(cast[ptr TypeClass00](self.impl))

proc finalizerunref*(self: TypeClass) =
  if not self.ignoreFinalizer:
    g_type_class_unref(cast[ptr TypeClass00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TypeClass()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_type_class_unref(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var TypeClass) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerunref)

proc g_type_class_get_private(self: ptr TypeClass00; privateType: GType): pointer {.
    importc, libprag.}

proc getPrivate*(self: TypeClass; privateType: GType): pointer =
  g_type_class_get_private(cast[ptr TypeClass00](self.impl), privateType)

proc g_type_class_peek_parent(self: ptr TypeClass00): ptr TypeClass00 {.
    importc, libprag.}

proc peekParent*(self: TypeClass): TypeClass =
  fnew(result, finalizerunref)
  result.impl = g_type_class_peek_parent(cast[ptr TypeClass00](self.impl))
  result.ignoreFinalizer = true

proc g_type_class_add_private(self: ptr TypeClass00; privateSize: uint64) {.
    importc, libprag.}

proc addPrivate*(self: TypeClass; privateSize: uint64) =
  g_type_class_add_private(cast[ptr TypeClass00](self.impl), privateSize)

proc adjustPrivateOffset*(gClass: pointer; privateSizeOrOffset: ptr int32) {.
    importc: "g_type_class_adjust_private_offset", libprag.}

proc g_type_class_peek(`type`: GType): ptr TypeClass00 {.
    importc, libprag.}

proc peek*(`type`: GType): TypeClass =
  fnew(result, finalizerunref)
  result.impl = g_type_class_peek(`type`)
  result.ignoreFinalizer = true

proc g_type_class_peek_static(`type`: GType): ptr TypeClass00 {.
    importc, libprag.}

proc peekStatic*(`type`: GType): TypeClass =
  fnew(result, finalizerunref)
  result.impl = g_type_class_peek_static(`type`)
  result.ignoreFinalizer = true

proc g_type_class_ref(`type`: GType): ptr TypeClass00 {.
    importc, libprag.}

proc `ref`*(`type`: GType): TypeClass =
  fnew(result, finalizerunref)
  result.impl = g_type_class_ref(`type`)
  result.ignoreFinalizer = true

type
  BaseFinalizeFunc* = proc (gClass: ptr TypeClass00) {.cdecl.}

type
  BaseInitFunc* = proc (gClass: ptr TypeClass00) {.cdecl.}

type
  Object00*{.inheritable, pure.} = object
type
  GToggleNotify* = proc (data: pointer; obj: ptr Object00; isLastRef: gboolean) {.cdecl.}

proc g_object_add_toggle_ref*(obj: ptr Object00; notify: GToggleNotify; data: pointer) {.
    importc: "g_object_add_toggle_ref", libprag.}
proc g_object_remove_toggle_ref*(obj: ptr Object00; notify: GToggleNotify; data: pointer) {.
    importc: "g_object_remove_toggle_ref", libprag.}

proc g_object_set_qdata*(self: ptr Object00; quark: uint32; p: pointer) {.
    importc: "g_object_set_qdata", libprag.}
proc toggleNotify*(data: pointer; obj: ptr Object00; isLastRef: gboolean) {.cdecl.} =
  if isLastRef.int == 0:
    GC_ref(cast[RootRef](data))
  else:
    GC_unref(cast[RootRef](data))

proc finalizeGObject*[T](o: ref T) =
  g_object_set_qdata(o.impl, Quark, nil)

  if not o.ignoreFinalizer:
    g_object_remove_toggle_ref(o.impl, toggleNotify, addr(o[]))

proc g_object_get_type*(): GType {.importc, libprag.}
type
  Object* = ref object of RootRef
    impl*: ptr Object00
    ignoreFinalizer*: bool

proc refCount*(o: gobject.Object): int =
  let p = cast[ptr cuint](cast[int](o.impl) + sizeof(pointer))
  return p[].int

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Object()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc compatControl*(what: uint64; data: pointer): uint64 {.
    importc: "g_object_compat_control", libprag.}

proc g_object_force_floating(self: ptr Object00) {.
    importc, libprag.}

proc forceFloating*(self: Object) =
  g_object_force_floating(cast[ptr Object00](self.impl))

proc g_object_freeze_notify(self: ptr Object00) {.
    importc, libprag.}

proc freezeNotify*(self: Object) =
  g_object_freeze_notify(cast[ptr Object00](self.impl))

proc g_object_get_data(self: ptr Object00; key: cstring): pointer {.
    importc, libprag.}

proc getData*(self: Object; key: cstring): pointer =
  g_object_get_data(cast[ptr Object00](self.impl), key)

proc g_object_get_qdata*(self: ptr Object00; quark: uint32): pointer {.
    importc, libprag.}

proc getQdata*(self: Object; quark: int): pointer =
  g_object_get_qdata(cast[ptr Object00](self.impl), uint32(quark))

proc g_object_is_floating*(self: ptr Object00): gboolean {.
    importc, libprag.}

proc isFloating*(self: Object): bool =
  toBool(g_object_is_floating(cast[ptr Object00](self.impl)))

proc g_object_notify(self: ptr Object00; propertyName: cstring) {.
    importc, libprag.}

proc notify*(self: Object; propertyName: cstring) =
  g_object_notify(cast[ptr Object00](self.impl), propertyName)

proc g_object_ref*(self: ptr Object00): ptr Object00 {.
    importc, libprag.}

proc g_object_ref_sink*(self: ptr Object00): ptr Object00 {.
    importc, libprag.}

proc g_object_run_dispose(self: ptr Object00) {.
    importc, libprag.}

proc runDispose*(self: Object) =
  g_object_run_dispose(cast[ptr Object00](self.impl))

proc g_object_set_data(self: ptr Object00; key: cstring; data: pointer) {.
    importc, libprag.}

proc setData*(self: Object; key: cstring; data: pointer) =
  g_object_set_data(cast[ptr Object00](self.impl), key, data)

proc g_object_steal_data(self: ptr Object00; key: cstring): pointer {.
    importc, libprag.}

proc stealData*(self: Object; key: cstring): pointer =
  g_object_steal_data(cast[ptr Object00](self.impl), key)

proc g_object_steal_qdata(self: ptr Object00; quark: uint32): pointer {.
    importc, libprag.}

proc stealQdata*(self: Object; quark: int): pointer =
  g_object_steal_qdata(cast[ptr Object00](self.impl), uint32(quark))

proc g_object_thaw_notify(self: ptr Object00) {.
    importc, libprag.}

proc thawNotify*(self: Object) =
  g_object_thaw_notify(cast[ptr Object00](self.impl))

proc g_object_unref*(self: ptr Object00) {.
    importc, libprag.}

proc unref*(self: Object) =
  g_object_unref(cast[ptr Object00](self.impl))

proc genericGObjectUnref*(self: Object) =
  if not self.ignoreFinalizer:
    g_object_unref(cast[ptr Object00](self.impl))

type
  Binding* = ref object of Object
  Binding00* = object of Object00

proc g_binding_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Binding()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc g_binding_get_source(self: ptr Binding00): ptr Object00 {.
    importc, libprag.}

proc getSource*(self: Binding): Object =
  let gobj = g_binding_get_source(cast[ptr Binding00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc source*(self: Binding): Object =
  let gobj = g_binding_get_source(cast[ptr Binding00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_binding_get_source_property(self: ptr Binding00): cstring {.
    importc, libprag.}

proc getSourceProperty*(self: Binding): string =
  result = $g_binding_get_source_property(cast[ptr Binding00](self.impl))

proc sourceProperty*(self: Binding): string =
  result = $g_binding_get_source_property(cast[ptr Binding00](self.impl))

proc g_binding_get_target(self: ptr Binding00): ptr Object00 {.
    importc, libprag.}

proc getTarget*(self: Binding): Object =
  let gobj = g_binding_get_target(cast[ptr Binding00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc target*(self: Binding): Object =
  let gobj = g_binding_get_target(cast[ptr Binding00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_binding_get_target_property(self: ptr Binding00): cstring {.
    importc, libprag.}

proc getTargetProperty*(self: Binding): string =
  result = $g_binding_get_target_property(cast[ptr Binding00](self.impl))

proc targetProperty*(self: Binding): string =
  result = $g_binding_get_target_property(cast[ptr Binding00](self.impl))

proc g_binding_unbind(self: ptr Binding00) {.
    importc, libprag.}

proc unbind*(self: Binding) =
  g_binding_unbind(cast[ptr Binding00](self.impl))

type
  Parameter00* {.pure.} = object
  Parameter* = ref object
    impl*: ptr Parameter00
    ignoreFinalizer*: bool

proc g_object_newv(objectType: GType; nParameters: uint32; parameters: ptr Parameter00): ptr Object00 {.
    importc, libprag.}

proc newObjectv*(objectType: GType; nParameters: int; parameters: ptr Parameter00): Object {.deprecated.}  =
  let gobj = g_object_newv(objectType, uint32(nParameters), parameters)
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

proc newObjectv*(tdesc: typedesc; objectType: GType; nParameters: int; parameters: ptr Parameter00): tdesc {.deprecated.}  =
  assert(result is Object)
  let gobj = g_object_newv(objectType, uint32(nParameters), parameters)
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

proc initObjectv*[T](result: var T; objectType: GType; nParameters: int; parameters: ptr Parameter00) {.deprecated.} =
  assert(result is Object)
  let gobj = g_object_newv(objectType, uint32(nParameters), parameters)
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

type
  TypeInterface00* {.pure.} = object
  TypeInterface* = ref object
    impl*: ptr TypeInterface00
    ignoreFinalizer*: bool

type
  TypePlugin00* = object of gobject.Object00
  TypePlugin* = ref object of gobject.Object

type
  InterfaceInfo00* {.pure.} = object
  InterfaceInfo* = ref object
    impl*: ptr InterfaceInfo00
    ignoreFinalizer*: bool

type
  TypeModule* = ref object of Object
  TypeModule00* = object of Object00

proc g_type_module_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TypeModule()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc g_type_module_add_interface(self: ptr TypeModule00; instanceType: GType;
    interfaceType: GType; interfaceInfo: ptr InterfaceInfo00) {.
    importc, libprag.}

proc addInterface*(self: TypeModule; instanceType: GType; interfaceType: GType;
    interfaceInfo: InterfaceInfo) =
  g_type_module_add_interface(cast[ptr TypeModule00](self.impl), instanceType, interfaceType, cast[ptr InterfaceInfo00](interfaceInfo.impl))

proc g_type_module_set_name(self: ptr TypeModule00; name: cstring) {.
    importc, libprag.}

proc setName*(self: TypeModule; name: cstring) =
  g_type_module_set_name(cast[ptr TypeModule00](self.impl), name)

proc `name=`*(self: TypeModule; name: cstring) =
  g_type_module_set_name(cast[ptr TypeModule00](self.impl), name)

proc g_type_module_unuse(self: ptr TypeModule00) {.
    importc, libprag.}

proc unuse*(self: TypeModule) =
  g_type_module_unuse(cast[ptr TypeModule00](self.impl))

proc g_type_module_use(self: ptr TypeModule00): gboolean {.
    importc, libprag.}

proc use*(self: TypeModule): bool =
  toBool(g_type_module_use(cast[ptr TypeModule00](self.impl)))

proc g_type_plugin_complete_interface_info(self: ptr TypePlugin00; instanceType: GType;
    interfaceType: GType; info: ptr InterfaceInfo00) {.
    importc, libprag.}

proc completeInterfaceInfo*(self: TypePlugin | TypeModule;
    instanceType: GType; interfaceType: GType; info: InterfaceInfo) =
  g_type_plugin_complete_interface_info(cast[ptr TypePlugin00](self.impl), instanceType, interfaceType, cast[ptr InterfaceInfo00](info.impl))

proc g_type_plugin_unuse(self: ptr TypePlugin00) {.
    importc, libprag.}

proc unuse*(self: TypePlugin | TypeModule) =
  g_type_plugin_unuse(cast[ptr TypePlugin00](self.impl))

proc g_type_plugin_use(self: ptr TypePlugin00) {.
    importc, libprag.}

proc use*(self: TypePlugin | TypeModule) =
  g_type_plugin_use(cast[ptr TypePlugin00](self.impl))

type
  EnumValue* {.pure, byRef.} = object
    value*: int32
    valueName*: cstring
    valueNick*: cstring

proc g_type_module_register_enum(self: ptr TypeModule00; name: cstring; constStaticValues: EnumValue): GType {.
    importc, libprag.}

proc registerEnum*(self: TypeModule; name: cstring; constStaticValues: EnumValue): GType =
  g_type_module_register_enum(cast[ptr TypeModule00](self.impl), name, constStaticValues)

type
  FlagsValue* {.pure, byRef.} = object
    value*: uint32
    valueName*: cstring
    valueNick*: cstring

proc g_type_module_register_flags(self: ptr TypeModule00; name: cstring;
    constStaticValues: FlagsValue): GType {.
    importc, libprag.}

proc registerFlags*(self: TypeModule; name: cstring; constStaticValues: FlagsValue): GType =
  g_type_module_register_flags(cast[ptr TypeModule00](self.impl), name, constStaticValues)

type
  ParamSpec* = ref object of RootRef
    impl*: ptr ParamSpec00
    ignoreFinalizer*: bool
  ParamSpec00*{.inheritable, pure.} = object

proc g_param_spec_ref_sink*(self: ptr ParamSpec00): ptr ParamSpec00 {.
    importc, libprag.}

proc g_param_spec_unref*(self: ptr ParamSpec00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpec) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpec()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

proc g_object_notify_by_pspec(self: ptr Object00; pspec: ptr ParamSpec00) {.
    importc, libprag.}

proc notifyByPspec*(self: Object; pspec: ParamSpec) =
  g_object_notify_by_pspec(cast[ptr Object00](self.impl), cast[ptr ParamSpec00](pspec.impl))

type
  Closure00* {.pure.} = object
  Closure* = ref object
    impl*: ptr Closure00
    ignoreFinalizer*: bool

proc g_closure_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGClosure*(self: Closure) =
  if not self.ignoreFinalizer:
    boxedFree(g_closure_get_type(), cast[ptr Closure00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Closure()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_closure_get_type(), cast[ptr Closure00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Closure) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGClosure)

proc g_closure_unref(self: ptr Closure00) {.
    importc, libprag.}

proc unref*(self: Closure) =
  g_closure_unref(cast[ptr Closure00](self.impl))

proc finalizerunref*(self: Closure) =
  if not self.ignoreFinalizer:
    g_closure_unref(cast[ptr Closure00](self.impl))

proc g_closure_new_simple(sizeofClosure: uint32; data: pointer): ptr Closure00 {.
    importc, libprag.}

proc newClosureSimple*(sizeofClosure: int; data: pointer): Closure =
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_closure_new_simple(uint32(sizeofClosure), data)

proc newClosureSimple*(tdesc: typedesc; sizeofClosure: int; data: pointer): tdesc =
  assert(result is Closure)
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_closure_new_simple(uint32(sizeofClosure), data)

proc initClosureSimple*[T](result: var T; sizeofClosure: int; data: pointer) {.deprecated.} =
  assert(result is Closure)
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_closure_new_simple(uint32(sizeofClosure), data)

proc g_closure_invalidate(self: ptr Closure00) {.
    importc, libprag.}

proc invalidate*(self: Closure) =
  g_closure_invalidate(cast[ptr Closure00](self.impl))

proc g_closure_ref(self: ptr Closure00): ptr Closure00 {.
    importc, libprag.}

proc `ref`*(self: Closure): Closure =
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_closure_ref(cast[ptr Closure00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_closure_get_type(), result.impl))

proc g_closure_sink(self: ptr Closure00) {.
    importc, libprag.}

proc sink*(self: Closure) =
  g_closure_sink(cast[ptr Closure00](self.impl))

proc g_closure_new_object(sizeofClosure: uint32; `object`: ptr Object00): ptr Closure00 {.
    importc, libprag.}

proc newClosureObject*(sizeofClosure: int; `object`: Object): Closure =
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_closure_new_object(uint32(sizeofClosure), cast[ptr Object00](`object`.impl))

proc newClosureObject*(tdesc: typedesc; sizeofClosure: int; `object`: Object): tdesc =
  assert(result is Closure)
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_closure_new_object(uint32(sizeofClosure), cast[ptr Object00](`object`.impl))

proc initClosureObject*[T](result: var T; sizeofClosure: int; `object`: Object) {.deprecated.} =
  assert(result is Closure)
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_closure_new_object(uint32(sizeofClosure), cast[ptr Object00](`object`.impl))

proc g_object_watch_closure(self: ptr Object00; closure: ptr Closure00) {.
    importc, libprag.}

proc watchClosure*(self: Object; closure: Closure) =
  g_object_watch_closure(cast[ptr Object00](self.impl), cast[ptr Closure00](closure.impl))

type
  BindingFlag* {.size: sizeof(cint), pure.} = enum
    bidirectional = 0
    syncCreate = 1
    invertBoolean = 2

  BindingFlags* {.size: sizeof(cint).} = set[BindingFlag]

const
  BindingFlagsDefault* = BindingFlags({})
proc default*(t: typedesc[BindingFlags]): BindingFlags = BindingFlags({})

proc g_object_bind_property(self: ptr Object00; sourceProperty: cstring;
    target: ptr Object00; targetProperty: cstring; flags: BindingFlags): ptr Binding00 {.
    importc, libprag.}

proc bindProperty*(self: Object; sourceProperty: cstring; target: Object;
    targetProperty: cstring; flags: BindingFlags): Binding =
  let gobj = g_object_bind_property(cast[ptr Object00](self.impl), sourceProperty, cast[ptr Object00](target.impl), targetProperty, flags)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_object_bind_property_with_closures(self: ptr Object00; sourceProperty: cstring;
    target: ptr Object00; targetProperty: cstring; flags: BindingFlags; transformTo: ptr Closure00;
    transformFrom: ptr Closure00): ptr Binding00 {.
    importc, libprag.}

proc bindPropertyFull*(self: Object; sourceProperty: cstring;
    target: Object; targetProperty: cstring; flags: BindingFlags; transformTo: Closure;
    transformFrom: Closure): Binding =
  let gobj = g_object_bind_property_with_closures(cast[ptr Object00](self.impl), sourceProperty, cast[ptr Object00](target.impl), targetProperty, flags, cast[ptr Closure00](transformTo.impl), cast[ptr Closure00](transformFrom.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_binding_get_flags(self: ptr Binding00): BindingFlags {.
    importc, libprag.}

proc getFlags*(self: Binding): BindingFlags =
  g_binding_get_flags(cast[ptr Binding00](self.impl))

proc flags*(self: Binding): BindingFlags =
  g_binding_get_flags(cast[ptr Binding00](self.impl))

type
  BoxedCopyFunc* = proc (boxed: pointer): pointer {.cdecl.}

type
  BoxedFreeFunc* = proc (boxed: pointer) {.cdecl.}

type
  CClosure00* {.pure.} = object
  CClosure* = ref object
    impl*: ptr CClosure00
    ignoreFinalizer*: bool

type
  Callback* = proc () {.cdecl.}

type
  ClassFinalizeFunc* = proc (gClass: ptr TypeClass00; classData: pointer) {.cdecl.}

type
  ClassInitFunc* = proc (gClass: ptr TypeClass00; classData: pointer) {.cdecl.}

type
  ClosureNotify* = proc (data: pointer; closure: ptr Closure00) {.cdecl.}

type
  ClosureNotifyData00* {.pure.} = object
  ClosureNotifyData* = ref object
    impl*: ptr ClosureNotifyData00
    ignoreFinalizer*: bool

type
  ConnectFlag* {.size: sizeof(cint), pure.} = enum
    after = 0
    swapped = 1

  ConnectFlags* {.size: sizeof(cint).} = set[ConnectFlag]
proc g_signal_connect_data*(instance: pointer; detailedSignal: cstring; cHandler: GCallback;
    data: pointer; destroyData: ClosureNotify; connectFlags: ConnectFlags): culong {.
    importc: "g_signal_connect_data", libprag.}

type
  EnumClass* {.pure, byRef.} = object
    gTypeClass*: TypeClass00
    minimum*: int32
    maximum*: int32
    nValues*: uint32
    values*: ptr EnumValue

type
  FlagsClass* {.pure, byRef.} = object
    gTypeClass*: TypeClass00
    mask*: uint32
    nValues*: uint32
    values*: ptr FlagsValue

type
  InitiallyUnowned* = ref object of Object
  InitiallyUnowned00* = object of Object00

proc g_initially_unowned_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InitiallyUnowned()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  TypeInstance00* {.pure.} = object
  TypeInstance* = ref object
    impl*: ptr TypeInstance00
    ignoreFinalizer*: bool

proc g_type_instance_get_private(self: ptr TypeInstance00; privateType: GType): pointer {.
    importc, libprag.}

proc getPrivate*(self: TypeInstance; privateType: GType): pointer =
  g_type_instance_get_private(cast[ptr TypeInstance00](self.impl), privateType)

type
  InstanceInitFunc* = proc (instance: ptr TypeInstance00; gClass: ptr TypeClass00) {.cdecl.}

type
  TypeValueTable00* {.pure.} = object
  TypeValueTable* = ref object
    impl*: ptr TypeValueTable00
    ignoreFinalizer*: bool

type
  TypeInfo* {.pure, byRef.} = object
    classSize*: uint16
    baseInit*: BaseInitFunc
    baseFinalize*: BaseFinalizeFunc
    classInit*: ClassInitFunc
    classFinalize*: ClassFinalizeFunc
    classData*: pointer
    instanceSize*: uint16
    nPreallocs*: uint16
    instanceInit*: InstanceInitFunc
    valueTable*: ptr TypeValueTable00

proc g_type_plugin_complete_type_info(self: ptr TypePlugin00; gType: GType;
    info: TypeInfo; valueTable: ptr TypeValueTable00) {.
    importc, libprag.}

proc completeTypeInfo*(self: TypePlugin | TypeModule; gType: GType;
    info: TypeInfo; valueTable: TypeValueTable) =
  g_type_plugin_complete_type_info(cast[ptr TypePlugin00](self.impl), gType, info, cast[ptr TypeValueTable00](valueTable.impl))

type
  TypeFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    abstract = 4
    valueAbstract = 5

  TypeFlags* {.size: sizeof(cint).} = set[TypeFlag]

proc g_type_module_register_type(self: ptr TypeModule00; parentType: GType;
    typeName: cstring; typeInfo: TypeInfo; flags: TypeFlags): GType {.
    importc, libprag.}

proc registerType*(self: TypeModule; parentType: GType; typeName: cstring;
    typeInfo: TypeInfo; flags: TypeFlags): GType =
  g_type_module_register_type(cast[ptr TypeModule00](self.impl), parentType, typeName, typeInfo, flags)

type
  InterfaceFinalizeFunc* = proc (gIface: ptr TypeInterface00; ifaceData: pointer) {.cdecl.}

type
  InterfaceInitFunc* = proc (gIface: ptr TypeInterface00; ifaceData: pointer) {.cdecl.}

type
  ObjectClass00* {.pure.} = object
  ObjectClass* = ref object
    impl*: ptr ObjectClass00
    ignoreFinalizer*: bool

proc g_object_class_find_property(self: ptr ObjectClass00; propertyName: cstring): ptr ParamSpec00 {.
    importc, libprag.}

proc findProperty*(self: ObjectClass; propertyName: cstring): ParamSpec =
  fnew(result, generic_g_param_spec_unref)
  result.impl = g_object_class_find_property(cast[ptr ObjectClass00](self.impl), propertyName)
  result.impl = cast[typeof(result.impl)](g_param_spec_ref_sink(result.impl))

proc g_object_class_install_properties(self: ptr ObjectClass00; nPspecs: uint32;
    pspecs: ptr ptr ParamSpec00) {.
    importc, libprag.}

proc installProperties*(self: ObjectClass; nPspecs: int; pspecs: ptr ptr ParamSpec00) =
  g_object_class_install_properties(cast[ptr ObjectClass00](self.impl), uint32(nPspecs), pspecs)

proc g_object_class_install_property(self: ptr ObjectClass00; propertyId: uint32;
    pspec: ptr ParamSpec00) {.
    importc, libprag.}

proc installProperty*(self: ObjectClass; propertyId: int;
    pspec: ParamSpec) =
  g_object_class_install_property(cast[ptr ObjectClass00](self.impl), uint32(propertyId), cast[ptr ParamSpec00](pspec.impl))

proc g_object_class_list_properties(self: ptr ObjectClass00; nProperties: var uint32): ptr ptr ParamSpec00 {.
    importc, libprag.}

proc listProperties*(self: ObjectClass; nProperties: var int): ptr ptr ParamSpec00 =
  var nProperties_00: uint32
  result = g_object_class_list_properties(cast[ptr ObjectClass00](self.impl), nProperties_00)
  if nProperties.addr != nil:
    nProperties = int(nProperties_00)

proc g_object_class_override_property(self: ptr ObjectClass00; propertyId: uint32;
    name: cstring) {.
    importc, libprag.}

proc overrideProperty*(self: ObjectClass; propertyId: int;
    name: cstring) =
  g_object_class_override_property(cast[ptr ObjectClass00](self.impl), uint32(propertyId), name)

type
  ObjectFinalizeFunc* = proc (`object`: ptr Object00) {.cdecl.}

const PARAM_MASK* = 255'i32

const PARAM_STATIC_STRINGS* = 224'i32

const PARAM_USER_SHIFT* = 8'i32

type
  ParamFlags* {.size: sizeof(cint), pure.} = enum
    readable = 1
    writable = 2
    readwrite = 3
    construct = 4
    constructOnly = 8
    laxValidation = 16
    private = 32
    staticNick = 64
    staticBlurb = 128
    explicitNotify = 1073741824
    deprecated = 2147483648

const
  ParamFlagsStaticName* = ParamFlags.private

type
  ParamSpecBoolean* = ref object of ParamSpec
  ParamSpecBoolean00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecBoolean00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecBoolean) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecBoolean()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecBoxed* = ref object of ParamSpec
  ParamSpecBoxed00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecBoxed00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecBoxed) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecBoxed()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecChar* = ref object of ParamSpec
  ParamSpecChar00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecChar00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecChar) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecChar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecDouble* = ref object of ParamSpec
  ParamSpecDouble00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecDouble00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecDouble) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecDouble()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecEnum* = ref object of ParamSpec
  ParamSpecEnum00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecEnum00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecEnum) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecEnum()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecFlags* = ref object of ParamSpec
  ParamSpecFlags00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecFlags00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecFlags) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecFlags()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecFloat* = ref object of ParamSpec
  ParamSpecFloat00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecFloat00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecFloat) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecFloat()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecGType* = ref object of ParamSpec
  ParamSpecGType00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecGType00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecGType) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecGType()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecInt* = ref object of ParamSpec
  ParamSpecInt00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecInt00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecInt) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecInt()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecInt64* = ref object of ParamSpec
  ParamSpecInt6400* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecInt6400) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecInt64) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecInt64()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecLong* = ref object of ParamSpec
  ParamSpecLong00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecLong00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecLong) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecLong()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecObject* = ref object of ParamSpec
  ParamSpecObject00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecObject00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecObject) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecObject()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecOverride* = ref object of ParamSpec
  ParamSpecOverride00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecOverride00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecOverride) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecOverride()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecParam* = ref object of ParamSpec
  ParamSpecParam00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecParam00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecParam) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecParam()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecPointer* = ref object of ParamSpec
  ParamSpecPointer00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecPointer00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecPointer) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecPointer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecPool00* {.pure.} = object
  ParamSpecPool* = ref object
    impl*: ptr ParamSpecPool00
    ignoreFinalizer*: bool

type
  ParamSpecString* = ref object of ParamSpec
  ParamSpecString00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecString00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecString) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecString()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecTypeInfo00* {.pure.} = object
  ParamSpecTypeInfo* = ref object
    impl*: ptr ParamSpecTypeInfo00
    ignoreFinalizer*: bool

type
  ParamSpecUChar* = ref object of ParamSpec
  ParamSpecUChar00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecUChar00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecUChar) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecUChar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecUInt* = ref object of ParamSpec
  ParamSpecUInt00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecUInt00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecUInt) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecUInt()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecUInt64* = ref object of ParamSpec
  ParamSpecUInt6400* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecUInt6400) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecUInt64) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecUInt64()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecULong* = ref object of ParamSpec
  ParamSpecULong00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecULong00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecULong) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecULong()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecUnichar* = ref object of ParamSpec
  ParamSpecUnichar00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecUnichar00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecUnichar) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecUnichar()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecValueArray* = ref object of ParamSpec
  ParamSpecValueArray00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecValueArray00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecValueArray) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecValueArray()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

type
  ParamSpecVariant* = ref object of ParamSpec
  ParamSpecVariant00* = object of ParamSpec00

proc g_param_spec_unref*(self: ptr ParamSpecVariant00) {.importc, libprag.}

proc generic_g_param_spec_unref*(self: ParamSpecVariant) =
  if not self.ignoreFinalizer:
    g_param_spec_unref(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ParamSpecVariant()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      g_param_spec_unref(self.impl)
      self.impl = nil

const SIGNAL_FLAGS_MASK* = 511'i32

const SIGNAL_MATCH_MASK* = 63'i32

type
  SignalInvocationHint00* {.pure.} = object
  SignalInvocationHint* = ref object
    impl*: ptr SignalInvocationHint00
    ignoreFinalizer*: bool

type
  SignalFlag* {.size: sizeof(cint), pure.} = enum
    runFirst = 0
    runLast = 1
    runCleanup = 2
    noRecurse = 3
    detailed = 4
    action = 5
    noHooks = 6
    mustCollect = 7
    deprecated = 8

  SignalFlags* {.size: sizeof(cint).} = set[SignalFlag]

type
  SignalMatchType* {.size: sizeof(cint), pure.} = enum
    id = 1
    detail = 2
    closure = 4
    `func` = 8
    data = 16
    unblocked = 32

type
  SignalQuery* {.pure, byRef.} = object
    signalId*: uint32
    signalName*: cstring
    itype*: GType
    signalFlags*: SignalFlags
    returnType*: GType
    nParams*: uint32
    paramTypes*: ptr GType

const TYPE_FLAG_RESERVED_ID_BIT* = 1'u64

const TYPE_FUNDAMENTAL_MAX* = 255'i32

const TYPE_FUNDAMENTAL_SHIFT* = 2'i32

const TYPE_RESERVED_BSE_FIRST* = 32'i32

const TYPE_RESERVED_BSE_LAST* = 48'i32

const TYPE_RESERVED_GLIB_FIRST* = 22'i32

const TYPE_RESERVED_GLIB_LAST* = 31'i32

const TYPE_RESERVED_USER_FIRST* = 49'i32

type
  ToggleNotify* = proc (data: pointer; `object`: ptr Object00; isLastRef: gboolean) {.cdecl.}

type
  TypeCValue* {.pure, byRef, union.} = object

type
  TypeClassCacheFunc* = proc (cacheData: pointer; gClass: ptr TypeClass00): gboolean {.cdecl.}

type
  TypeDebugFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    objects = 1
    signals = 2
    instanceCount = 4
    mask = 7

type
  TypeFundamentalFlag* {.size: sizeof(cint), pure.} = enum
    classed = 0
    instantiatable = 1
    derivable = 2
    deepDerivable = 3

  TypeFundamentalFlags* {.size: sizeof(cint).} = set[TypeFundamentalFlag]

type
  TypeFundamentalInfo00* {.pure.} = object
  TypeFundamentalInfo* = ref object
    impl*: ptr TypeFundamentalInfo00
    ignoreFinalizer*: bool

type
  TypeInterfaceCheckFunc* = proc (checkData: pointer; gIface: ptr TypeInterface00) {.cdecl.}

type
  TypePluginClass00* {.pure.} = object
  TypePluginClass* = ref object
    impl*: ptr TypePluginClass00
    ignoreFinalizer*: bool

type
  TypePluginCompleteInterfaceInfo* = proc (plugin: ptr TypePlugin00; instanceType: GType; interfaceType: GType;
    info: ptr InterfaceInfo00) {.cdecl.}

type
  TypePluginCompleteTypeInfo* = proc (plugin: ptr TypePlugin00; gType: GType; info: TypeInfo; valueTable: ptr TypeValueTable00) {.cdecl.}

type
  TypePluginUnuse* = proc (plugin: ptr TypePlugin00) {.cdecl.}

type
  TypePluginUse* = proc (plugin: ptr TypePlugin00) {.cdecl.}

type
  TypeQuery* {.pure, byRef.} = object
    `type`*: GType
    typeName*: cstring
    classSize*: uint32
    instanceSize*: uint32

const VALUE_INTERNED_STRING* = 268435456'i32

const VALUE_NOCOPY_CONTENTS* = 134217728'i32

type
  ValueArray00* {.pure.} = object
  ValueArray* = ref object
    impl*: ptr ValueArray00
    ignoreFinalizer*: bool

proc g_value_array_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGValueArray*(self: ValueArray) =
  if not self.ignoreFinalizer:
    boxedFree(g_value_array_get_type(), cast[ptr ValueArray00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ValueArray()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(g_value_array_get_type(), cast[ptr ValueArray00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ValueArray) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGValueArray)

proc g_value_array_new(nPrealloced: uint32): ptr ValueArray00 {.
    importc, libprag.}

proc newValueArray*(nPrealloced: int): ValueArray {.deprecated.}  =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_new(uint32(nPrealloced))

proc newValueArray*(tdesc: typedesc; nPrealloced: int): tdesc {.deprecated.}  =
  assert(result is ValueArray)
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_new(uint32(nPrealloced))

proc initValueArray*[T](result: var T; nPrealloced: int) {.deprecated.} =
  assert(result is ValueArray)
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_new(uint32(nPrealloced))

proc g_value_array_copy(self: ptr ValueArray00): ptr ValueArray00 {.
    importc, libprag.}

proc copy*(self: ValueArray): ValueArray =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_copy(cast[ptr ValueArray00](self.impl))

proc g_value_array_remove(self: ptr ValueArray00; index: uint32): ptr ValueArray00 {.
    importc, libprag.}

proc remove*(self: ValueArray; index: int): ValueArray =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_remove(cast[ptr ValueArray00](self.impl), uint32(index))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_value_array_get_type(), result.impl))

proc g_value_array_sort_with_data(self: ptr ValueArray00; compareFunc: CompareDataFunc;
    userData: pointer): ptr ValueArray00 {.
    importc, libprag.}

proc sort*(self: ValueArray; compareFunc: CompareDataFunc;
    userData: pointer): ValueArray =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_sort_with_data(cast[ptr ValueArray00](self.impl), compareFunc, userData)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_value_array_get_type(), result.impl))

type
  WeakNotify* = proc (data: pointer; whereTheObjectWas: ptr Object00) {.cdecl.}

type
  WeakRef* {.pure, byRef.} = object

type
  ValueDataUnion* {.pure, byRef, union.} = object
    vInt*: int32
    vUint*: uint32
    vLong*: int64
    vUlong*: uint64
    vInt64*: int64
    vUint64*: uint64
    vFloat*: cfloat
    vDouble*: cdouble
    vPointer*: pointer

type
  Value* {.pure, byRef.} = object
    gType*: GType
    data*: array[2, ValueDataUnion]

proc g_value_get_type*(): GType {.importc, libprag.}

proc g_value_copy(self: Value; destValue: Value) {.
    importc, libprag.}

proc copy*(self: Value; destValue: Value) =
  g_value_copy(self, destValue)

proc g_value_dup_object(self: Value): ptr Object00 {.
    importc, libprag.}

proc dupObject*(self: Value): Object =
  let gobj = g_value_dup_object(self)
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

proc g_value_dup_string(self: Value): cstring {.
    importc, libprag.}

proc dupString*(self: Value): string =
  let resul0 = g_value_dup_string(self)
  result = $resul0
  cogfree(resul0)

proc g_value_dup_variant(self: Value): ptr glib.Variant00 {.
    importc, libprag.}

proc dupVariant*(self: Value): glib.Variant =
  let impl0 = g_value_dup_variant(self)
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0

proc g_value_fits_pointer(self: Value): gboolean {.
    importc, libprag.}

proc fitsPointer*(self: Value): bool =
  toBool(g_value_fits_pointer(self))

proc g_value_get_boolean(self: Value): gboolean {.
    importc, libprag.}

proc getBoolean*(self: Value): bool =
  toBool(g_value_get_boolean(self))

proc boolean*(self: Value): bool =
  toBool(g_value_get_boolean(self))

proc g_value_get_boxed(self: Value): pointer {.
    importc, libprag.}

proc getBoxed*(self: Value): pointer =
  g_value_get_boxed(self)

proc g_value_get_char(self: Value): int8 {.
    importc, libprag.}

proc getChar*(self: Value): int8 =
  g_value_get_char(self)

proc g_value_get_double(self: Value): cdouble {.
    importc, libprag.}

proc getDouble*(self: Value): cdouble =
  g_value_get_double(self)

proc double*(self: Value): cdouble =
  g_value_get_double(self)

proc g_value_get_enum(self: Value): int32 {.
    importc, libprag.}

proc getEnum*(self: Value): int =
  int(g_value_get_enum(self))

proc g_value_get_flags(self: Value): uint32 {.
    importc, libprag.}

proc getFlags*(self: Value): int =
  int(g_value_get_flags(self))

proc flags*(self: Value): int =
  int(g_value_get_flags(self))

proc g_value_get_float(self: Value): cfloat {.
    importc, libprag.}

proc getFloat*(self: Value): cfloat =
  g_value_get_float(self)

proc g_value_get_gtype(self: Value): GType {.
    importc, libprag.}

proc getGtype*(self: Value): GType =
  g_value_get_gtype(self)

proc gtype*(self: Value): GType =
  g_value_get_gtype(self)

proc g_value_get_int(self: Value): int32 {.
    importc, libprag.}

proc getInt*(self: Value): int =
  int(g_value_get_int(self))

proc g_value_get_int64(self: Value): int64 {.
    importc, libprag.}

proc getInt64*(self: Value): int64 =
  g_value_get_int64(self)

proc g_value_get_long(self: Value): int64 {.
    importc, libprag.}

proc getLong*(self: Value): int64 =
  g_value_get_long(self)

proc long*(self: Value): int64 =
  g_value_get_long(self)

proc g_value_get_object(self: Value): ptr Object00 {.
    importc, libprag.}

proc getObject*(self: Value): Object =
  let gobj = g_value_get_object(self)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gobject.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_value_get_param(self: Value): ptr ParamSpec00 {.
    importc, libprag.}

proc getParam*(self: Value): ParamSpec =
  fnew(result, generic_g_param_spec_unref)
  result.impl = g_value_get_param(self)
  result.impl = cast[typeof(result.impl)](g_param_spec_ref_sink(result.impl))

proc param*(self: Value): ParamSpec =
  fnew(result, generic_g_param_spec_unref)
  result.impl = g_value_get_param(self)
  result.impl = cast[typeof(result.impl)](g_param_spec_ref_sink(result.impl))

proc g_value_get_pointer(self: Value): pointer {.
    importc, libprag.}

proc getPointer*(self: Value): pointer =
  g_value_get_pointer(self)

proc g_value_get_schar(self: Value): int8 {.
    importc, libprag.}

proc getSchar*(self: Value): int8 =
  g_value_get_schar(self)

proc schar*(self: Value): int8 =
  g_value_get_schar(self)

proc g_value_get_string(self: Value): cstring {.
    importc, libprag.}

proc getString*(self: Value): string =
  result = $g_value_get_string(self)

proc g_value_get_uchar(self: Value): uint8 {.
    importc, libprag.}

proc getUchar*(self: Value): uint8 =
  g_value_get_uchar(self)

proc uchar*(self: Value): uint8 =
  g_value_get_uchar(self)

proc g_value_get_uint(self: Value): uint32 {.
    importc, libprag.}

proc getUint*(self: Value): int =
  int(g_value_get_uint(self))

proc g_value_get_uint64(self: Value): uint64 {.
    importc, libprag.}

proc getUint64*(self: Value): uint64 =
  g_value_get_uint64(self)

proc g_value_get_ulong(self: Value): uint64 {.
    importc, libprag.}

proc getUlong*(self: Value): uint64 =
  g_value_get_ulong(self)

proc ulong*(self: Value): uint64 =
  g_value_get_ulong(self)

proc g_value_get_variant(self: Value): ptr glib.Variant00 {.
    importc, libprag.}

proc getVariant*(self: Value): glib.Variant =
  let impl0 = g_value_get_variant(self)
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0
  result.ignoreFinalizer = true # GVariant

proc variant*(self: Value): glib.Variant =
  let impl0 = g_value_get_variant(self)
  if impl0.isNil:
    return nil
  fnew(result, finalizerunref)
  result.impl = impl0
  result.ignoreFinalizer = true # GVariant

proc g_value_init(self: Value; gType: GType): ptr Value {.
    importc, libprag.}

proc init*(self: Value; gType: GType): ptr Value =
  g_value_init(self, gType)

proc g_value_init_from_instance(self: Value; instance: ptr TypeInstance00) {.
    importc, libprag.}

proc initFromInstance*(self: Value; instance: TypeInstance) =
  g_value_init_from_instance(self, cast[ptr TypeInstance00](instance.impl))

proc g_value_peek_pointer(self: Value): pointer {.
    importc, libprag.}

proc peekPointer*(self: Value): pointer =
  g_value_peek_pointer(self)

proc g_value_reset(self: Value): ptr Value {.
    importc, libprag.}

proc reset*(self: Value): ptr Value =
  g_value_reset(self)

proc g_value_set_boolean(self: Value; vBoolean: gboolean) {.
    importc, libprag.}

proc setBoolean*(self: Value; vBoolean: bool = true) =
  g_value_set_boolean(self, gboolean(vBoolean))

proc `boolean=`*(self: Value; vBoolean: bool) =
  g_value_set_boolean(self, gboolean(vBoolean))

proc g_value_set_boxed(self: Value; vBoxed: pointer) {.
    importc, libprag.}

proc setBoxed*(self: Value; vBoxed: pointer) =
  g_value_set_boxed(self, vBoxed)

proc `boxed=`*(self: Value; vBoxed: pointer) =
  g_value_set_boxed(self, vBoxed)

proc g_value_set_boxed_take_ownership(self: Value; vBoxed: pointer) {.
    importc, libprag.}

proc setBoxedTakeOwnership*(self: Value; vBoxed: pointer) =
  g_value_set_boxed_take_ownership(self, vBoxed)

proc `boxedTakeOwnership=`*(self: Value; vBoxed: pointer) =
  g_value_set_boxed_take_ownership(self, vBoxed)

proc g_value_set_char(self: Value; vChar: int8) {.
    importc, libprag.}

proc setChar*(self: Value; vChar: int8) =
  g_value_set_char(self, vChar)

proc `char=`*(self: Value; vChar: int8) =
  g_value_set_char(self, vChar)

proc g_value_set_double(self: Value; vDouble: cdouble) {.
    importc, libprag.}

proc setDouble*(self: Value; vDouble: cdouble) =
  g_value_set_double(self, vDouble)

proc `double=`*(self: Value; vDouble: cdouble) =
  g_value_set_double(self, vDouble)

proc g_value_set_enum(self: Value; vEnum: int32) {.
    importc, libprag.}

proc setEnum*(self: Value; vEnum: int) =
  g_value_set_enum(self, int32(vEnum))

proc `enum=`*(self: Value; vEnum: int) =
  g_value_set_enum(self, int32(vEnum))

proc g_value_set_flags(self: Value; vFlags: uint32) {.
    importc, libprag.}

proc setFlags*(self: Value; vFlags: int) =
  g_value_set_flags(self, uint32(vFlags))

proc `flags=`*(self: Value; vFlags: int) =
  g_value_set_flags(self, uint32(vFlags))

proc g_value_set_float(self: Value; vFloat: cfloat) {.
    importc, libprag.}

proc setFloat*(self: Value; vFloat: cfloat) =
  g_value_set_float(self, vFloat)

proc `float=`*(self: Value; vFloat: cfloat) =
  g_value_set_float(self, vFloat)

proc g_value_set_gtype(self: Value; vGtype: GType) {.
    importc, libprag.}

proc setGtype*(self: Value; vGtype: GType) =
  g_value_set_gtype(self, vGtype)

proc `gtype=`*(self: Value; vGtype: GType) =
  g_value_set_gtype(self, vGtype)

proc g_value_set_instance(self: Value; instance: pointer) {.
    importc, libprag.}

proc setInstance*(self: Value; instance: pointer) =
  g_value_set_instance(self, instance)

proc `instance=`*(self: Value; instance: pointer) =
  g_value_set_instance(self, instance)

proc g_value_set_int(self: Value; vInt: int32) {.
    importc, libprag.}

proc setInt*(self: Value; vInt: int) =
  g_value_set_int(self, int32(vInt))

proc `int=`*(self: Value; vInt: int) =
  g_value_set_int(self, int32(vInt))

proc g_value_set_int64(self: Value; vInt64: int64) {.
    importc, libprag.}

proc setInt64*(self: Value; vInt64: int64) =
  g_value_set_int64(self, vInt64)

proc `int64=`*(self: Value; vInt64: int64) =
  g_value_set_int64(self, vInt64)

proc g_value_set_interned_string(self: Value; vString: cstring) {.
    importc, libprag.}

proc setInternedString*(self: Value; vString: cstring = nil) =
  g_value_set_interned_string(self, vString)

proc `internedString=`*(self: Value; vString: cstring = nil) =
  g_value_set_interned_string(self, vString)

proc g_value_set_long(self: Value; vLong: int64) {.
    importc, libprag.}

proc setLong*(self: Value; vLong: int64) =
  g_value_set_long(self, vLong)

proc `long=`*(self: Value; vLong: int64) =
  g_value_set_long(self, vLong)

proc g_value_set_object(self: Value; vObject: ptr Object00) {.
    importc, libprag.}

proc setObject*(self: Value; vObject: Object = nil) =
  g_value_set_object(self, if vObject.isNil: nil else: cast[ptr Object00](vObject.impl))

proc `object=`*(self: Value; vObject: Object = nil) =
  g_value_set_object(self, if vObject.isNil: nil else: cast[ptr Object00](vObject.impl))

proc g_value_set_param(self: Value; param: ptr ParamSpec00) {.
    importc, libprag.}

proc setParam*(self: Value; param: ParamSpec = nil) =
  g_value_set_param(self, if param.isNil: nil else: cast[ptr ParamSpec00](param.impl))

proc `param=`*(self: Value; param: ParamSpec = nil) =
  g_value_set_param(self, if param.isNil: nil else: cast[ptr ParamSpec00](param.impl))

proc g_value_set_pointer(self: Value; vPointer: pointer) {.
    importc, libprag.}

proc setPointer*(self: Value; vPointer: pointer) =
  g_value_set_pointer(self, vPointer)

proc `pointer=`*(self: Value; vPointer: pointer) =
  g_value_set_pointer(self, vPointer)

proc g_value_set_schar(self: Value; vChar: int8) {.
    importc, libprag.}

proc setSchar*(self: Value; vChar: int8) =
  g_value_set_schar(self, vChar)

proc `schar=`*(self: Value; vChar: int8) =
  g_value_set_schar(self, vChar)

proc g_value_set_static_boxed(self: Value; vBoxed: pointer) {.
    importc, libprag.}

proc setStaticBoxed*(self: Value; vBoxed: pointer) =
  g_value_set_static_boxed(self, vBoxed)

proc `staticBoxed=`*(self: Value; vBoxed: pointer) =
  g_value_set_static_boxed(self, vBoxed)

proc g_value_set_static_string(self: Value; vString: cstring) {.
    importc, libprag.}

proc setStaticString*(self: Value; vString: cstring = nil) =
  g_value_set_static_string(self, vString)

proc `staticString=`*(self: Value; vString: cstring = nil) =
  g_value_set_static_string(self, vString)

proc g_value_set_string(self: Value; vString: cstring) {.
    importc, libprag.}

proc setString*(self: Value; vString: cstring = nil) =
  g_value_set_string(self, vString)

proc `string=`*(self: Value; vString: cstring = nil) =
  g_value_set_string(self, vString)

proc g_value_set_string_take_ownership(self: Value; vString: cstring) {.
    importc, libprag.}

proc setStringTakeOwnership*(self: Value; vString: cstring = nil) =
  g_value_set_string_take_ownership(self, vString)

proc `stringTakeOwnership=`*(self: Value; vString: cstring = nil) =
  g_value_set_string_take_ownership(self, vString)

proc g_value_set_uchar(self: Value; vUchar: uint8) {.
    importc, libprag.}

proc setUchar*(self: Value; vUchar: uint8) =
  g_value_set_uchar(self, vUchar)

proc `uchar=`*(self: Value; vUchar: uint8) =
  g_value_set_uchar(self, vUchar)

proc g_value_set_uint(self: Value; vUint: uint32) {.
    importc, libprag.}

proc setUint*(self: Value; vUint: int) =
  g_value_set_uint(self, uint32(vUint))

proc `uint=`*(self: Value; vUint: int) =
  g_value_set_uint(self, uint32(vUint))

proc g_value_set_uint64(self: Value; vUint64: uint64) {.
    importc, libprag.}

proc setUint64*(self: Value; vUint64: uint64) =
  g_value_set_uint64(self, vUint64)

proc `uint64=`*(self: Value; vUint64: uint64) =
  g_value_set_uint64(self, vUint64)

proc g_value_set_ulong(self: Value; vUlong: uint64) {.
    importc, libprag.}

proc setUlong*(self: Value; vUlong: uint64) =
  g_value_set_ulong(self, vUlong)

proc `ulong=`*(self: Value; vUlong: uint64) =
  g_value_set_ulong(self, vUlong)

proc g_value_set_variant(self: Value; variant: ptr glib.Variant00) {.
    importc, libprag.}

proc setVariant*(self: Value; variant: glib.Variant = nil) =
  g_value_set_variant(self, if variant.isNil: nil else: cast[ptr glib.Variant00](variant.impl))

proc `variant=`*(self: Value; variant: glib.Variant = nil) =
  g_value_set_variant(self, if variant.isNil: nil else: cast[ptr glib.Variant00](variant.impl))

proc g_value_take_boxed(self: Value; vBoxed: pointer) {.
    importc, libprag.}

proc takeBoxed*(self: Value; vBoxed: pointer) =
  g_value_take_boxed(self, vBoxed)

proc g_value_take_string(self: Value; vString: cstring) {.
    importc, libprag.}

proc takeString*(self: Value; vString: cstring = nil) =
  g_value_take_string(self, vString)

proc g_value_take_variant(self: Value; variant: ptr glib.Variant00) {.
    importc, libprag.}

proc takeVariant*(self: Value; variant: glib.Variant = nil) =
  g_value_take_variant(self, if variant.isNil: nil else: cast[ptr glib.Variant00](variant.impl))

proc g_value_transform(self: Value; destValue: Value): gboolean {.
    importc, libprag.}

proc transform*(self: Value; destValue: Value): bool =
  toBool(g_value_transform(self, destValue))

proc g_value_unset(self: Value) {.
    importc, libprag.}

proc unset*(self: Value) =
  g_value_unset(self)

proc g_value_type_compatible(srcType: GType; destType: GType): gboolean {.
    importc, libprag.}

proc typeCompatible*(srcType: GType; destType: GType): bool =
  toBool(g_value_type_compatible(srcType, destType))

proc g_value_type_transformable(srcType: GType; destType: GType): gboolean {.
    importc, libprag.}

proc typeTransformable*(srcType: GType; destType: GType): bool =
  toBool(g_value_type_transformable(srcType, destType))
type

  ValueTransform* = proc (srcValue: Value; destValue: Value) {.cdecl.}

  SignalEmissionHook* = proc (ihint: ptr SignalInvocationHint00; nParamValues: uint32; paramValues: ptr Value;
    data: pointer): gboolean {.cdecl.}

proc g_object_get_property(self: ptr Object00; propertyName: cstring; value: Value) {.
    importc, libprag.}

proc getProperty*(self: Object; propertyName: cstring; value: Value) =
  g_object_get_property(cast[ptr Object00](self.impl), propertyName, value)

proc g_object_getv(self: ptr Object00; nProperties: uint32; names: ptr cstring;
    values: ptr Value) {.
    importc, libprag.}

proc getv*(self: Object; nProperties: int; names: openArray[string];
    values: ptr Value) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  g_object_getv(cast[ptr Object00](self.impl), uint32(nProperties), seq2CstringArray(names, fs469n23), values)

proc g_object_set_property(self: ptr Object00; propertyName: cstring; value: Value) {.
    importc, libprag.}

proc setProperty*(self: Object; propertyName: cstring; value: Value) =
  g_object_set_property(cast[ptr Object00](self.impl), propertyName, value)

proc g_closure_invoke(self: ptr Closure00; returnValue: var Value; nParamValues: uint32;
    paramValues: ptr Value; invocationHint: pointer) {.
    importc, libprag.}

proc invoke*(self: Closure; returnValue: var Value = cast[var Value](nil);
    nParamValues: int; paramValues: ptr Value; invocationHint: pointer) =
  g_closure_invoke(cast[ptr Closure00](self.impl), returnValue, uint32(nParamValues), paramValues, invocationHint)

proc g_cclosure_marshal_generic(closure: ptr Closure00; returnGvalue: Value;
    nParamValues: uint32; paramValues: Value; invocationHint: pointer; marshalData: pointer) {.
    importc, libprag.}

proc marshalGeneric*(closure: Closure; returnGvalue: Value; nParamValues: int;
    paramValues: Value; invocationHint: pointer; marshalData: pointer) =
  g_cclosure_marshal_generic(cast[ptr Closure00](closure.impl), returnGvalue, uint32(nParamValues), paramValues, invocationHint, marshalData)

proc g_value_array_append(self: ptr ValueArray00; value: Value): ptr ValueArray00 {.
    importc, libprag.}

proc append*(self: ValueArray; value: Value = cast[var Value](nil)): ValueArray =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_append(cast[ptr ValueArray00](self.impl), value)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_value_array_get_type(), result.impl))

proc g_value_array_get_nth(self: ptr ValueArray00; index: uint32): ptr Value {.
    importc, libprag.}

proc getNth*(self: ValueArray; index: int): ptr Value =
  g_value_array_get_nth(cast[ptr ValueArray00](self.impl), uint32(index))

proc g_value_array_insert(self: ptr ValueArray00; index: uint32; value: Value): ptr ValueArray00 {.
    importc, libprag.}

proc insert*(self: ValueArray; index: int; value: Value = cast[var Value](nil)): ValueArray =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_insert(cast[ptr ValueArray00](self.impl), uint32(index), value)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_value_array_get_type(), result.impl))

proc g_value_array_prepend(self: ptr ValueArray00; value: Value): ptr ValueArray00 {.
    importc, libprag.}

proc prepend*(self: ValueArray; value: Value = cast[var Value](nil)): ValueArray =
  fnew(result, gBoxedFreeGValueArray)
  result.impl = g_value_array_prepend(cast[ptr ValueArray00](self.impl), value)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_value_array_get_type(), result.impl))

proc boxedCopy*(boxedType: GType; srcBoxed: pointer): pointer {.
    importc: "g_boxed_copy", libprag.}

type
  SignalAccumulator* = proc (ihint: ptr SignalInvocationHint00; returnAccu: Value; handlerReturn: Value;
    data: pointer): gboolean {.cdecl.}

type
  ObjectSetPropertyFunc* = proc (`object`: ptr Object00; propertyId: uint32; value: Value; pspec: ptr ParamSpec00) {.cdecl.}

type
  ObjectGetPropertyFunc* = proc (`object`: ptr Object00; propertyId: uint32; value: Value; pspec: ptr ParamSpec00) {.cdecl.}

type
  ObjectConstructParam* {.pure, byRef.} = object
    pspec*: ptr ParamSpec00
    value*: ptr Value

type
  ClosureMarshal* = proc (closure: ptr Closure00; returnValue: Value; nParamValues: uint32; paramValues: ptr Value;
    invocationHint: pointer; marshalData: pointer) {.cdecl.}

type
  BindingTransformFunc* = proc (binding: ptr Binding00; fromValue: Value; toValue: Value; userData: pointer): gboolean {.cdecl.}

proc g_clear_signal_handler(handlerIdPtr: ptr uint64; instance: ptr Object00) {.
    importc, libprag.}

proc clearSignalHandler*(handlerIdPtr: ptr uint64; instance: Object) =
  g_clear_signal_handler(handlerIdPtr, cast[ptr Object00](instance.impl))

proc enumCompleteTypeInfo*(gEnumType: GType; info: var TypeInfo; constValues: EnumValue) {.
    importc: "g_enum_complete_type_info", libprag.}

proc g_enum_get_value(enumClass: EnumClass; value: int32): ptr EnumValue {.
    importc, libprag.}

proc enumGetValue*(enumClass: EnumClass; value: int): ptr EnumValue =
  g_enum_get_value(enumClass, int32(value))

proc enumGetValueByName*(enumClass: EnumClass; name: cstring): ptr EnumValue {.
    importc: "g_enum_get_value_by_name", libprag.}

proc enumGetValueByNick*(enumClass: EnumClass; nick: cstring): ptr EnumValue {.
    importc: "g_enum_get_value_by_nick", libprag.}

proc enumRegisterStatic*(name: cstring; constStaticValues: EnumValue): GType {.
    importc: "g_enum_register_static", libprag.}

proc g_enum_to_string(gEnumType: GType; value: int32): cstring {.
    importc, libprag.}

proc enumToString*(gEnumType: GType; value: int): string =
  let resul0 = g_enum_to_string(gEnumType, int32(value))
  result = $resul0
  cogfree(resul0)

proc flagsCompleteTypeInfo*(gFlagsType: GType; info: var TypeInfo; constValues: FlagsValue) {.
    importc: "g_flags_complete_type_info", libprag.}

proc g_flags_get_first_value(flagsClass: FlagsClass; value: uint32): ptr FlagsValue {.
    importc, libprag.}

proc flagsGetFirstValue*(flagsClass: FlagsClass; value: int): ptr FlagsValue =
  g_flags_get_first_value(flagsClass, uint32(value))

proc flagsGetValueByName*(flagsClass: FlagsClass; name: cstring): ptr FlagsValue {.
    importc: "g_flags_get_value_by_name", libprag.}

proc flagsGetValueByNick*(flagsClass: FlagsClass; nick: cstring): ptr FlagsValue {.
    importc: "g_flags_get_value_by_nick", libprag.}

proc flagsRegisterStatic*(name: cstring; constStaticValues: FlagsValue): GType {.
    importc: "g_flags_register_static", libprag.}

proc g_flags_to_string(flagsType: GType; value: uint32): cstring {.
    importc, libprag.}

proc flagsToString*(flagsType: GType; value: int): string =
  let resul0 = g_flags_to_string(flagsType, uint32(value))
  result = $resul0
  cogfree(resul0)

proc gtypeGetType*(): GType {.
    importc: "g_gtype_get_type", libprag.}

proc g_param_type_register_static(name: cstring; pspecInfo: ptr ParamSpecTypeInfo00): GType {.
    importc, libprag.}

proc paramTypeRegisterStatic*(name: cstring; pspecInfo: ParamSpecTypeInfo): GType =
  g_param_type_register_static(name, cast[ptr ParamSpecTypeInfo00](pspecInfo.impl))

proc g_param_value_convert(pspec: ptr ParamSpec00; srcValue: Value; destValue: Value;
    strictValidation: gboolean): gboolean {.
    importc, libprag.}

proc paramValueConvert*(pspec: ParamSpec; srcValue: Value; destValue: Value;
    strictValidation: bool): bool =
  toBool(g_param_value_convert(cast[ptr ParamSpec00](pspec.impl), srcValue, destValue, gboolean(strictValidation)))

proc g_param_value_defaults(pspec: ptr ParamSpec00; value: Value): gboolean {.
    importc, libprag.}

proc paramValueDefaults*(pspec: ParamSpec; value: Value): bool =
  toBool(g_param_value_defaults(cast[ptr ParamSpec00](pspec.impl), value))

proc g_param_value_set_default(pspec: ptr ParamSpec00; value: Value) {.
    importc, libprag.}

proc paramValueSetDefault*(pspec: ParamSpec; value: Value) =
  g_param_value_set_default(cast[ptr ParamSpec00](pspec.impl), value)

proc g_param_value_validate(pspec: ptr ParamSpec00; value: Value): gboolean {.
    importc, libprag.}

proc paramValueValidate*(pspec: ParamSpec; value: Value): bool =
  toBool(g_param_value_validate(cast[ptr ParamSpec00](pspec.impl), value))

proc g_param_values_cmp(pspec: ptr ParamSpec00; value1: Value; value2: Value): int32 {.
    importc, libprag.}

proc paramValuesCmp*(pspec: ParamSpec; value1: Value; value2: Value): int =
  int(g_param_values_cmp(cast[ptr ParamSpec00](pspec.impl), value1, value2))

proc pointerTypeRegisterStatic*(name: cstring): GType {.
    importc: "g_pointer_type_register_static", libprag.}

proc g_signal_accumulator_first_wins(ihint: ptr SignalInvocationHint00; returnAccu: Value;
    handlerReturn: Value; dummy: pointer): gboolean {.
    importc, libprag.}

proc signalAccumulatorFirstWins*(ihint: SignalInvocationHint; returnAccu: Value;
    handlerReturn: Value; dummy: pointer): bool =
  toBool(g_signal_accumulator_first_wins(cast[ptr SignalInvocationHint00](ihint.impl), returnAccu, handlerReturn, dummy))

proc g_signal_accumulator_true_handled(ihint: ptr SignalInvocationHint00;
    returnAccu: Value; handlerReturn: Value; dummy: pointer): gboolean {.
    importc, libprag.}

proc signalAccumulatorTrueHandled*(ihint: SignalInvocationHint; returnAccu: Value;
    handlerReturn: Value; dummy: pointer): bool =
  toBool(g_signal_accumulator_true_handled(cast[ptr SignalInvocationHint00](ihint.impl), returnAccu, handlerReturn, dummy))

proc g_signal_add_emission_hook(signalId: uint32; detail: uint32; hookFunc: SignalEmissionHook;
    hookData: pointer; dataDestroy: DestroyNotify): uint64 {.
    importc, libprag.}

proc signalAddEmissionHook*(signalId: int; detail: int; hookFunc: SignalEmissionHook;
    hookData: pointer; dataDestroy: DestroyNotify): uint64 =
  g_signal_add_emission_hook(uint32(signalId), uint32(detail), hookFunc, hookData, dataDestroy)

proc signalChainFromOverridden*(instanceAndParams: ptr Value; returnValue: Value) {.
    importc: "g_signal_chain_from_overridden", libprag.}

proc g_signal_connect_closure(instance: ptr Object00; detailedSignal: cstring;
    closure: ptr Closure00; after: gboolean): uint64 {.
    importc, libprag.}

proc signalConnectClosure*(instance: Object; detailedSignal: cstring;
    closure: Closure; after: bool): uint64 =
  g_signal_connect_closure(cast[ptr Object00](instance.impl), detailedSignal, cast[ptr Closure00](closure.impl), gboolean(after))

proc g_signal_connect_closure_by_id(instance: ptr Object00; signalId: uint32;
    detail: uint32; closure: ptr Closure00; after: gboolean): uint64 {.
    importc, libprag.}

proc signalConnectClosureById*(instance: Object; signalId: int; detail: int;
    closure: Closure; after: bool): uint64 =
  g_signal_connect_closure_by_id(cast[ptr Object00](instance.impl), uint32(signalId), uint32(detail), cast[ptr Closure00](closure.impl), gboolean(after))

proc g_signal_get_invocation_hint(instance: ptr Object00): ptr SignalInvocationHint00 {.
    importc, libprag.}

proc signalGetInvocationHint*(instance: Object): SignalInvocationHint =
  new(result)
  result.impl = g_signal_get_invocation_hint(cast[ptr Object00](instance.impl))
  result.ignoreFinalizer = true

proc g_signal_handler_block(instance: ptr Object00; handlerId: uint64) {.
    importc, libprag.}

proc signalHandlerBlock*(instance: Object; handlerId: uint64) =
  g_signal_handler_block(cast[ptr Object00](instance.impl), handlerId)

proc g_signal_handler_disconnect(instance: ptr Object00; handlerId: uint64) {.
    importc, libprag.}

proc signalHandlerDisconnect*(instance: Object; handlerId: uint64) =
  g_signal_handler_disconnect(cast[ptr Object00](instance.impl), handlerId)

proc g_signal_handler_find(instance: ptr Object00; mask: SignalMatchType;
    signalId: uint32; detail: uint32; closure: ptr Closure00; `func`: pointer;
    data: pointer): uint64 {.
    importc, libprag.}

proc signalHandlerFind*(instance: Object; mask: SignalMatchType; signalId: int;
    detail: int; closure: Closure = nil; `func`: pointer; data: pointer): uint64 =
  g_signal_handler_find(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), if closure.isNil: nil else: cast[ptr Closure00](closure.impl), `func`, data)

proc g_signal_handler_is_connected(instance: ptr Object00; handlerId: uint64): gboolean {.
    importc, libprag.}

proc signalHandlerIsConnected*(instance: Object; handlerId: uint64): bool =
  toBool(g_signal_handler_is_connected(cast[ptr Object00](instance.impl), handlerId))

proc g_signal_handler_unblock(instance: ptr Object00; handlerId: uint64) {.
    importc, libprag.}

proc signalHandlerUnblock*(instance: Object; handlerId: uint64) =
  g_signal_handler_unblock(cast[ptr Object00](instance.impl), handlerId)

proc g_signal_handlers_block_matched(instance: ptr Object00; mask: SignalMatchType;
    signalId: uint32; detail: uint32; closure: ptr Closure00; `func`: pointer;
    data: pointer): uint32 {.
    importc, libprag.}

proc signalHandlersBlockMatched*(instance: Object; mask: SignalMatchType;
    signalId: int; detail: int; closure: Closure = nil; `func`: pointer; data: pointer): int =
  int(g_signal_handlers_block_matched(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), if closure.isNil: nil else: cast[ptr Closure00](closure.impl), `func`, data))

proc g_signal_handlers_destroy(instance: ptr Object00) {.
    importc, libprag.}

proc signalHandlersDestroy*(instance: Object) =
  g_signal_handlers_destroy(cast[ptr Object00](instance.impl))

proc g_signal_handlers_disconnect_matched(instance: ptr Object00; mask: SignalMatchType;
    signalId: uint32; detail: uint32; closure: ptr Closure00; `func`: pointer;
    data: pointer): uint32 {.
    importc, libprag.}

proc signalHandlersDisconnectMatched*(instance: Object; mask: SignalMatchType;
    signalId: int; detail: int; closure: Closure = nil; `func`: pointer; data: pointer): int =
  int(g_signal_handlers_disconnect_matched(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), if closure.isNil: nil else: cast[ptr Closure00](closure.impl), `func`, data))

proc g_signal_handlers_unblock_matched(instance: ptr Object00; mask: SignalMatchType;
    signalId: uint32; detail: uint32; closure: ptr Closure00; `func`: pointer;
    data: pointer): uint32 {.
    importc, libprag.}

proc signalHandlersUnblockMatched*(instance: Object; mask: SignalMatchType;
    signalId: int; detail: int; closure: Closure = nil; `func`: pointer; data: pointer): int =
  int(g_signal_handlers_unblock_matched(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), if closure.isNil: nil else: cast[ptr Closure00](closure.impl), `func`, data))

proc g_signal_has_handler_pending(instance: ptr Object00; signalId: uint32;
    detail: uint32; mayBeBlocked: gboolean): gboolean {.
    importc, libprag.}

proc signalHasHandlerPending*(instance: Object; signalId: int; detail: int;
    mayBeBlocked: bool): bool =
  toBool(g_signal_has_handler_pending(cast[ptr Object00](instance.impl), uint32(signalId), uint32(detail), gboolean(mayBeBlocked)))

proc g_signal_is_valid_name(name: cstring): gboolean {.
    importc, libprag.}

proc signalIsValidName*(name: cstring): bool =
  toBool(g_signal_is_valid_name(name))

proc g_signal_list_ids(itype: GType; nIds: var uint32): ptr uint32 {.
    importc, libprag.}

proc signalListIds*(itype: GType; nIds: var int): seq[uint32] =
  var nIds_00: uint32
  let resul0 = g_signal_list_ids(itype, nIds_00)
  result = uint32ArrayToSeq(resul0, nIds.int)
  cogfree(resul0)
  if nIds.addr != nil:
    nIds = int(nIds_00)

proc g_signal_lookup(name: cstring; itype: GType): uint32 {.
    importc, libprag.}

proc signalLookup*(name: cstring; itype: GType): int =
  int(g_signal_lookup(name, itype))

proc g_signal_name(signalId: uint32): cstring {.
    importc, libprag.}

proc signalName*(signalId: int): string =
  result = $g_signal_name(uint32(signalId))

proc g_signal_override_class_closure(signalId: uint32; instanceType: GType;
    classClosure: ptr Closure00) {.
    importc, libprag.}

proc signalOverrideClassClosure*(signalId: int; instanceType: GType;
    classClosure: Closure) =
  g_signal_override_class_closure(uint32(signalId), instanceType, cast[ptr Closure00](classClosure.impl))

proc g_signal_parse_name(detailedSignal: cstring; itype: GType; signalIdP: var uint32;
    detailP: var uint32; forceDetailQuark: gboolean): gboolean {.
    importc, libprag.}

proc signalParseName*(detailedSignal: cstring; itype: GType; signalIdP: var int;
    detailP: var int; forceDetailQuark: bool): bool =
  var signalIdP_00: uint32
  var detailP_00: uint32
  result = toBool(g_signal_parse_name(detailedSignal, itype, signalIdP_00, detailP_00, gboolean(forceDetailQuark)))
  if signalIdP.addr != nil:
    signalIdP = int(signalIdP_00)
  if detailP.addr != nil:
    detailP = int(detailP_00)

proc g_signal_query(signalId: uint32; query: var SignalQuery) {.
    importc, libprag.}

proc signalQuery*(signalId: int; query: var SignalQuery) =
  g_signal_query(uint32(signalId), query)

proc signalQuery*(signalId: int): SignalQuery =
  g_signal_query(uint32(signalId), result)

proc g_signal_remove_emission_hook(signalId: uint32; hookId: uint64) {.
    importc, libprag.}

proc signalRemoveEmissionHook*(signalId: int; hookId: uint64) =
  g_signal_remove_emission_hook(uint32(signalId), hookId)

proc g_signal_set_va_marshaller(signalId: uint32; instanceType: GType; vaMarshaller: VaClosureMarshal) {.
    importc, libprag.}

proc signalSetVaMarshaller*(signalId: int; instanceType: GType; vaMarshaller: VaClosureMarshal) =
  g_signal_set_va_marshaller(uint32(signalId), instanceType, vaMarshaller)

proc g_signal_stop_emission(instance: ptr Object00; signalId: uint32; detail: uint32) {.
    importc, libprag.}

proc signalStopEmission*(instance: Object; signalId: int; detail: int) =
  g_signal_stop_emission(cast[ptr Object00](instance.impl), uint32(signalId), uint32(detail))

proc g_signal_stop_emission_by_name(instance: ptr Object00; detailedSignal: cstring) {.
    importc, libprag.}

proc signalStopEmissionByName*(instance: Object; detailedSignal: cstring) =
  g_signal_stop_emission_by_name(cast[ptr Object00](instance.impl), detailedSignal)

proc g_signal_type_cclosure_new(itype: GType; structOffset: uint32): ptr Closure00 {.
    importc, libprag.}

proc newSignalTypeCclosure*(itype: GType; structOffset: int): Closure =
  fnew(result, gBoxedFreeGClosure)
  result.impl = g_signal_type_cclosure_new(itype, uint32(structOffset))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(g_closure_get_type(), result.impl))

proc g_source_set_closure(source: ptr glib.Source00; closure: ptr Closure00) {.
    importc, libprag.}

proc sourceSetClosure*(source: glib.Source; closure: Closure) =
  g_source_set_closure(cast[ptr glib.Source00](source.impl), cast[ptr Closure00](closure.impl))

proc g_source_set_dummy_callback(source: ptr glib.Source00) {.
    importc, libprag.}

proc sourceSetDummyCallback*(source: glib.Source) =
  g_source_set_dummy_callback(cast[ptr glib.Source00](source.impl))

proc g_strdup_value_contents(value: Value): cstring {.
    importc, libprag.}

proc strdupValueContents*(value: Value): string =
  let resul0 = g_strdup_value_contents(value)
  result = $resul0
  cogfree(resul0)

proc typeAddClassPrivate*(classType: GType; privateSize: uint64) {.
    importc: "g_type_add_class_private", libprag.}

proc g_type_add_instance_private(classType: GType; privateSize: uint64): int32 {.
    importc, libprag.}

proc typeAddInstancePrivate*(classType: GType; privateSize: uint64): int =
  int(g_type_add_instance_private(classType, privateSize))

proc g_type_add_interface_static(instanceType: GType; interfaceType: GType;
    info: ptr InterfaceInfo00) {.
    importc, libprag.}

proc typeAddInterfaceStatic*(instanceType: GType; interfaceType: GType;
    info: InterfaceInfo) =
  g_type_add_interface_static(instanceType, interfaceType, cast[ptr InterfaceInfo00](info.impl))

proc g_type_check_class_is_a(gClass: ptr TypeClass00; isAType: GType): gboolean {.
    importc, libprag.}

proc typeCheckClassIsA*(gClass: TypeClass; isAType: GType): bool =
  toBool(g_type_check_class_is_a(cast[ptr TypeClass00](gClass.impl), isAType))

proc g_type_check_instance(instance: ptr TypeInstance00): gboolean {.
    importc, libprag.}

proc typeCheckInstance*(instance: TypeInstance): bool =
  toBool(g_type_check_instance(cast[ptr TypeInstance00](instance.impl)))

proc g_type_check_instance_is_a*(instance: ptr TypeInstance00; ifaceType: GType): gboolean {.
    importc, libprag.}

proc typeCheckInstanceIsA*(instance: TypeInstance; ifaceType: GType): bool =
  toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](instance.impl), ifaceType))

proc g_type_check_instance_is_fundamentally_a(instance: ptr TypeInstance00;
    fundamentalType: GType): gboolean {.
    importc, libprag.}

proc typeCheckInstanceIsFundamentallyA*(instance: TypeInstance; fundamentalType: GType): bool =
  toBool(g_type_check_instance_is_fundamentally_a(cast[ptr TypeInstance00](instance.impl), fundamentalType))

proc g_type_check_is_value_type(`type`: GType): gboolean {.
    importc, libprag.}

proc typeCheckIsValueType*(`type`: GType): bool =
  toBool(g_type_check_is_value_type(`type`))

proc g_type_check_value(value: Value): gboolean {.
    importc, libprag.}

proc typeCheckValue*(value: Value): bool =
  toBool(g_type_check_value(value))

proc g_type_check_value_holds(value: Value; `type`: GType): gboolean {.
    importc, libprag.}

proc typeCheckValueHolds*(value: Value; `type`: GType): bool =
  toBool(g_type_check_value_holds(value, `type`))

proc g_type_children(`type`: GType; nChildren: var uint32): ptr GType {.
    importc, libprag.}

proc typeChildren*(`type`: GType; nChildren: var int = cast[var int](nil)): ptr GType =
  var nChildren_00: uint32
  let resul0 = g_type_children(`type`, nChildren_00)
  result = resul0
  if nChildren.addr != nil:
    nChildren = int(nChildren_00)

proc g_type_default_interface_peek(gType: GType): ptr TypeInterface00 {.
    importc, libprag.}

proc typeDefaultInterfacePeek*(gType: GType): TypeInterface =
  new(result)
  result.impl = g_type_default_interface_peek(gType)
  result.ignoreFinalizer = true

proc g_type_default_interface_ref(gType: GType): ptr TypeInterface00 {.
    importc, libprag.}

proc typeDefaultInterfaceRef*(gType: GType): TypeInterface =
  new(result)
  result.impl = g_type_default_interface_ref(gType)
  result.ignoreFinalizer = true

proc g_type_default_interface_unref(gIface: ptr TypeInterface00) {.
    importc, libprag.}

proc typeDefaultInterfaceUnref*(gIface: TypeInterface) =
  g_type_default_interface_unref(cast[ptr TypeInterface00](gIface.impl))

proc g_type_depth(`type`: GType): uint32 {.
    importc, libprag.}

proc typeDepth*(`type`: GType): int =
  int(g_type_depth(`type`))

proc typeEnsure*(`type`: GType) {.
    importc: "g_type_ensure", libprag.}

proc g_type_free_instance(instance: ptr TypeInstance00) {.
    importc, libprag.}

proc typeFreeInstance*(instance: TypeInstance) =
  g_type_free_instance(cast[ptr TypeInstance00](instance.impl))

proc g_type_from_name*(name: cstring): GType {.
    importc, libprag.}

proc typeFromName*(name: cstring): GType {.
    importc: "g_type_from_name", libprag.}

proc typeFundamental*(typeId: GType): GType {.
    importc: "g_type_fundamental", libprag.}

proc typeFundamentalNext*(): GType {.
    importc: "g_type_fundamental_next", libprag.}

proc g_type_get_instance_count(`type`: GType): int32 {.
    importc, libprag.}

proc typeGetInstanceCount*(`type`: GType): int =
  int(g_type_get_instance_count(`type`))

proc g_type_get_qdata(`type`: GType; quark: uint32): pointer {.
    importc, libprag.}

proc typeGetQdata*(`type`: GType; quark: int): pointer =
  g_type_get_qdata(`type`, uint32(quark))

proc g_type_get_type_registration_serial(): uint32 {.
    importc, libprag.}

proc typeGetTypeRegistrationSerial*(): int =
  int(g_type_get_type_registration_serial())

proc typeInit*() {.
    importc: "g_type_init", libprag.}

proc typeInitWithDebugFlags*(debugFlags: TypeDebugFlags) {.
    importc: "g_type_init_with_debug_flags", libprag.}

proc g_type_interfaces(`type`: GType; nInterfaces: var uint32): ptr GType {.
    importc, libprag.}

proc typeInterfaces*(`type`: GType; nInterfaces: var int = cast[var int](nil)): ptr GType =
  var nInterfaces_00: uint32
  let resul0 = g_type_interfaces(`type`, nInterfaces_00)
  result = resul0
  if nInterfaces.addr != nil:
    nInterfaces = int(nInterfaces_00)

proc g_type_is_a(`type`: GType; isAType: GType): gboolean {.
    importc, libprag.}

proc typeIsA*(`type`: GType; isAType: GType): bool =
  toBool(g_type_is_a(`type`, isAType))

proc g_type_name(`type`: GType): cstring {.
    importc, libprag.}

proc typeName*(`type`: GType): string =
  result = $g_type_name(`type`)

proc g_type_name_from_class(gClass: ptr TypeClass00): cstring {.
    importc, libprag.}

proc typeNameFromClass*(gClass: TypeClass): string =
  result = $g_type_name_from_class(cast[ptr TypeClass00](gClass.impl))

proc g_type_name_from_instance(instance: ptr TypeInstance00): cstring {.
    importc, libprag.}

proc typeNameFromInstance*(instance: TypeInstance): string =
  result = $g_type_name_from_instance(cast[ptr TypeInstance00](instance.impl))

proc typeNextBase*(leafType: GType; rootType: GType): GType {.
    importc: "g_type_next_base", libprag.}

proc typeParent*(`type`: GType): GType {.
    importc: "g_type_parent", libprag.}

proc g_type_qname(`type`: GType): uint32 {.
    importc, libprag.}

proc typeQname*(`type`: GType): int =
  int(g_type_qname(`type`))

proc typeQuery*(`type`: GType; query: var TypeQuery) {.
    importc: "g_type_query", libprag.}

proc typeQuery*(`type`: GType): TypeQuery {.
    importc: "g_type_query", libprag.}

proc g_type_register_fundamental(typeId: GType; typeName: cstring; info: TypeInfo;
    finfo: ptr TypeFundamentalInfo00; flags: TypeFlags): GType {.
    importc, libprag.}

proc typeRegisterFundamental*(typeId: GType; typeName: cstring; info: TypeInfo;
    finfo: TypeFundamentalInfo; flags: TypeFlags): GType =
  g_type_register_fundamental(typeId, typeName, info, cast[ptr TypeFundamentalInfo00](finfo.impl), flags)

proc typeRegisterStatic*(parentType: GType; typeName: cstring; info: TypeInfo;
    flags: TypeFlags): GType {.
    importc: "g_type_register_static", libprag.}

proc g_type_set_qdata(`type`: GType; quark: uint32; data: pointer) {.
    importc, libprag.}

proc typeSetQdata*(`type`: GType; quark: int; data: pointer) =
  g_type_set_qdata(`type`, uint32(quark), data)

proc g_type_test_flags(`type`: GType; flags: uint32): gboolean {.
    importc, libprag.}

proc typeTestFlags*(`type`: GType; flags: int): bool =
  toBool(g_type_test_flags(`type`, uint32(flags)))
# === remaining symbols:

#proc refCount*(o: gobject.Object): int =
#  let p = cast[ptr cuint](cast[int](o.impl) + sizeof(pointer))
#  return p[].int

proc scNotify*(self: Object;  p: proc (self: ptr Object00; paramSpec: ptr ParamSpec00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags; sigName: cstring): culong =
  # g_signal_connect_data(self.impl, "notify::cursor-position", cast[GCallback](p), xdata, nil, cf)
  g_signal_connect_data(self.impl, sigName, cast[GCallback](p), xdata, nil, cf)

proc typeCheckInstanceIsA*(instance: Object; ifaceType: GType): bool =
  toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](instance.impl), ifaceType))

# similar to gobjectTemp()
proc glistObjects2seq*[T](t: typedesc[T]; l: ptr glib.List; elTransferFull: bool): seq[T] =
  var r: T
  var obj: ptr Object00
  var el = l
  while el != nil:
    obj = cast[ptr Object00](el.data)
    if obj == nil:
      continue
    let qdata = g_object_get_qdata(obj, Quark)
    if qdata != nil:
      r = cast[T](qdata)
      assert(r.impl == obj)
      result.add(r)
    else:
      fnew(r, finalizeGObject)#" % [mprefix])
      r.impl = obj
      GC_ref(r)
      if elTransferFull:
        if g_object_is_floating(r.impl).int != 0:
          discard g_object_ref_sink(r.impl)
      else:
        discard g_object_ref_sink(r.impl)
      g_object_add_toggle_ref(r.impl, toggleNotify, addr(r[]))
      g_object_unref(r.impl)
      assert(g_object_get_qdata(r.impl, Quark) == nil)
      g_object_set_qdata(r.impl, Quark, addr(r[]))
    el = el.next

proc gslistObjects2seq*[T](t: typedesc[T]; l: ptr glib.SList; elTransferFull: bool): seq[T] =
  var r: T
  var obj: ptr Object00
  var el = l
  while el != nil:
    obj = cast[ptr Object00](el.data)
    if obj == nil:
      continue
    let qdata = g_object_get_qdata(obj, Quark)
    if qdata != nil:
      r = cast[T](qdata)
      assert(r.impl == obj)
      result.add(r)
    else:
      fnew(r, finalizeGObject)#" % [mprefix])
      r.impl = obj
      GC_ref(r)
      if elTransferFull:
        if g_object_is_floating(r.impl).int != 0:
          discard g_object_ref_sink(r.impl)
      else:
        discard g_object_ref_sink(r.impl)
      g_object_add_toggle_ref(r.impl, toggleNotify, addr(r[]))
      g_object_unref(r.impl)
      assert(g_object_get_qdata(r.impl, Quark) == nil)
      g_object_set_qdata(r.impl, Quark, addr(r[]))
    el = el.next

proc glistStructs2seq*[T](l: ptr glib.List; igFin: bool): seq[T] =
  var r: T
  var el = l
  while el != nil:
    if el.data == nil:
      continue
    newWithFinalizer(r) # CAUTION: newWithFinalizer() seems to be rarely used, can we remove it fully?
    r.impl = cast[typeof(r.impl)](el.data)
    r.ignoreFinalizer = igFin
    result.add(r)
    el = el.next

proc gslistStructs2seq*[T](l: ptr glib.SList; igFin: bool): seq[T] =
  var r: T
  var el = l
  while el != nil:
    if el.data == nil:
      continue
    newWithFinalizer(r) # CAUTION: newWithFinalizer() seems to be rarely used, can we remove it fully?
    r.impl = cast[typeof(r.impl)](el.data)
    r.ignoreFinalizer = igFin
    result.add(r)
    el = el.next

# Not much tested, but in use for libnice simple_example.nim
# Some other modules may need a similar local proc, ie for pango.Item
proc seq2GList*[T](s: seq[T]): ptr glib.List =
  var l: ptr glib.List
  var i = s.len
  while i > 0:
    dec(i)
    when T is gobject.Object or compiles(T.impl): # https://github.com/StefanSalewski/gintro/issues/99#issuecomment-739435944
    # when compiles(s[i].impl == nil):
    # when T is gobject.Object: # or T is pango.Item:
      l = g_list_prepend(l, s[i].impl)
    elif T is cstring:
      l = g_list_prepend(l, s[i]) # cstring
    else:
      # {.error: "seq2GList was called with unsupported type".} # that would break compiling the modules currently
      discard # make it compile for these cases, of course will not work
  return l

proc seq2GSList*[T](s: seq[T]): ptr glib.SList =
  var l: ptr glib.SList
  var i = s.len
  while i > 0:
    dec(i)
    when T is gobject.Object or compiles(T.impl):
    # when compiles(s[i].impl == nil): # NiceCandidate
    # when T is gobject.Object: # or T is pango.Item:
      l = g_slist_prepend(l, s[i].impl)
    elif T is cstring:
      l = g_slist_prepend(l, s[i]) # cstring
    else:
      # {.error: "seq2GSList was called with unsupported type".}
      discard # make it compile for these cases, of course will not work
  return l

#include gimplgobj
include gimplglib
export glib.g_strdup


proc g_type_invalid_get_type*(): GType = g_type_from_name("(null)")

proc g_type_none_get_type*(): GType = g_type_from_name("void")

proc g_interface_get_type*(): GType = g_type_from_name("GInterface")

proc g_char_get_type*(): GType = g_type_from_name("gchar")

proc g_uchar_get_type*(): GType = g_type_from_name("guchar")

proc g_boolean_get_type*(): GType = g_type_from_name("gboolean")

proc g_int_get_type*(): GType = g_type_from_name("gint")

proc g_uint_get_type*(): GType = g_type_from_name("guint")

proc g_long_get_type*(): GType = g_type_from_name("glong")

proc g_ulong_get_type*(): GType = g_type_from_name("gulong")

proc g_int64_get_type*(): GType = g_type_from_name("gint64")

proc g_uint64_get_type*(): GType = g_type_from_name("guint64")

proc g_enum_get_type*(): GType = g_type_from_name("GEnum")

proc g_flags_get_type*(): GType = g_type_from_name("GFlags")

proc g_float_get_type*(): GType = g_type_from_name("gfloat")

proc g_double_get_type*(): GType = g_type_from_name("gdouble")

proc g_string_get_type*(): GType = g_type_from_name("gchararray")

proc g_pointer_get_type*(): GType = g_type_from_name("gpointer")

proc g_boxed_get_type*(): GType = g_type_from_name("GBoxed")

proc g_param_get_type*(): GType = g_type_from_name("GParam")

proc g_variant_get_type*(): GType = g_type_from_name("GVariant")
