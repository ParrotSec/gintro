# dependencies:
# GObject-2.0
# GLib-2.0
# immediate dependencies:
# GObject-2.0
# libraries:
# libjavascriptcoregtk-4.0.so.18
{.warning[UnusedImport]: off.}
import gobject, glib
const Lib = "libjavascriptcoregtk-4.0.so.18"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  CheckSyntaxMode* {.size: sizeof(cint), pure.} = enum
    script = 0
    module = 1

type
  CheckSyntaxResult* {.size: sizeof(cint), pure.} = enum
    success = 0
    recoverableError = 1
    irrecoverableError = 2
    unterminatedLiteralError = 3
    outOfMemoryError = 4
    stackOverflowError = 5

type
  Class* = ref object of gobject.Object
  Class00* = object of gobject.Object00

proc jsc_class_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Class()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc jsc_class_add_method_variadic(self: ptr Class00; name: cstring; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType) {.
    importc, libprag.}

proc addMethodVariadic*(self: Class; name: cstring; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType) =
  jsc_class_add_method_variadic(cast[ptr Class00](self.impl), name, callback, userData, destroyNotify, returnType)

proc jsc_class_add_methodv(self: ptr Class00; name: cstring; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: uint32;
    parameterTypes: ptr GType) {.
    importc, libprag.}

proc addMethod*(self: Class; name: cstring; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: int;
    parameterTypes: ptr GType) =
  jsc_class_add_methodv(cast[ptr Class00](self.impl), name, callback, userData, destroyNotify, returnType, uint32(nParameters), parameterTypes)

proc jsc_class_add_property(self: ptr Class00; name: cstring; propertyType: GType;
    getter: Callback; setter: Callback; userData: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc addProperty*(self: Class; name: cstring; propertyType: GType;
    getter: Callback; setter: Callback; userData: pointer; destroyNotify: DestroyNotify) =
  jsc_class_add_property(cast[ptr Class00](self.impl), name, propertyType, getter, setter, userData, destroyNotify)

proc jsc_class_get_name(self: ptr Class00): cstring {.
    importc, libprag.}

proc getName*(self: Class): string =
  result = $jsc_class_get_name(cast[ptr Class00](self.impl))

proc name*(self: Class): string =
  result = $jsc_class_get_name(cast[ptr Class00](self.impl))

proc jsc_class_get_parent(self: ptr Class00): ptr Class00 {.
    importc, libprag.}

proc getParent*(self: Class): Class =
  let gobj = jsc_class_get_parent(cast[ptr Class00](self.impl))
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

proc parent*(self: Class): Class =
  let gobj = jsc_class_get_parent(cast[ptr Class00](self.impl))
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
  Value* = ref object of gobject.Object
  Value00* = object of gobject.Object00

proc jsc_value_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Value()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc jsc_value_constructor_callv(self: ptr Value00; nParameters: uint32;
    parameters: ptr Value00): ptr Value00 {.
    importc, libprag.}

proc constructorCall*(self: Value; nParameters: int; parameters: ptr Value00): Value =
  let gobj = jsc_value_constructor_callv(cast[ptr Value00](self.impl), uint32(nParameters), parameters)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_function_callv(self: ptr Value00; nParameters: uint32; parameters: ptr Value00): ptr Value00 {.
    importc, libprag.}

proc functionCall*(self: Value; nParameters: int; parameters: ptr Value00): Value =
  let gobj = jsc_value_function_callv(cast[ptr Value00](self.impl), uint32(nParameters), parameters)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_is_array(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isArray*(self: Value): bool =
  toBool(jsc_value_is_array(cast[ptr Value00](self.impl)))

proc jsc_value_is_boolean(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isBoolean*(self: Value): bool =
  toBool(jsc_value_is_boolean(cast[ptr Value00](self.impl)))

proc jsc_value_is_constructor(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isConstructor*(self: Value): bool =
  toBool(jsc_value_is_constructor(cast[ptr Value00](self.impl)))

proc jsc_value_is_function(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isFunction*(self: Value): bool =
  toBool(jsc_value_is_function(cast[ptr Value00](self.impl)))

proc jsc_value_is_null(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isNull*(self: Value): bool =
  toBool(jsc_value_is_null(cast[ptr Value00](self.impl)))

proc jsc_value_is_number(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isNumber*(self: Value): bool =
  toBool(jsc_value_is_number(cast[ptr Value00](self.impl)))

proc jsc_value_is_object(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isObject*(self: Value): bool =
  toBool(jsc_value_is_object(cast[ptr Value00](self.impl)))

proc jsc_value_is_string(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isString*(self: Value): bool =
  toBool(jsc_value_is_string(cast[ptr Value00](self.impl)))

proc jsc_value_is_undefined(self: ptr Value00): gboolean {.
    importc, libprag.}

proc isUndefined*(self: Value): bool =
  toBool(jsc_value_is_undefined(cast[ptr Value00](self.impl)))

proc jsc_value_object_delete_property(self: ptr Value00; name: cstring): gboolean {.
    importc, libprag.}

proc objectDeleteProperty*(self: Value; name: cstring): bool =
  toBool(jsc_value_object_delete_property(cast[ptr Value00](self.impl), name))

proc jsc_value_object_enumerate_properties(self: ptr Value00): ptr cstring {.
    importc, libprag.}

proc objectEnumerateProperties*(self: Value): seq[string] =
  let resul0 = jsc_value_object_enumerate_properties(cast[ptr Value00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc jsc_value_object_get_property(self: ptr Value00; name: cstring): ptr Value00 {.
    importc, libprag.}

proc objectGetProperty*(self: Value; name: cstring): Value =
  let gobj = jsc_value_object_get_property(cast[ptr Value00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_object_get_property_at_index(self: ptr Value00; index: uint32): ptr Value00 {.
    importc, libprag.}

proc objectGetPropertyAtIndex*(self: Value; index: int): Value =
  let gobj = jsc_value_object_get_property_at_index(cast[ptr Value00](self.impl), uint32(index))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_object_has_property(self: ptr Value00; name: cstring): gboolean {.
    importc, libprag.}

proc objectHasProperty*(self: Value; name: cstring): bool =
  toBool(jsc_value_object_has_property(cast[ptr Value00](self.impl), name))

proc jsc_value_object_invoke_methodv(self: ptr Value00; name: cstring; nParameters: uint32;
    parameters: ptr Value00): ptr Value00 {.
    importc, libprag.}

proc objectInvokeMethod*(self: Value; name: cstring; nParameters: int;
    parameters: ptr Value00): Value =
  let gobj = jsc_value_object_invoke_methodv(cast[ptr Value00](self.impl), name, uint32(nParameters), parameters)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_object_is_instance_of(self: ptr Value00; name: cstring): gboolean {.
    importc, libprag.}

proc objectIsInstanceOf*(self: Value; name: cstring): bool =
  toBool(jsc_value_object_is_instance_of(cast[ptr Value00](self.impl), name))

proc jsc_value_object_set_property(self: ptr Value00; name: cstring; property: ptr Value00) {.
    importc, libprag.}

proc objectSetProperty*(self: Value; name: cstring; property: Value) =
  jsc_value_object_set_property(cast[ptr Value00](self.impl), name, cast[ptr Value00](property.impl))

proc jsc_value_object_set_property_at_index(self: ptr Value00; index: uint32;
    property: ptr Value00) {.
    importc, libprag.}

proc objectSetPropertyAtIndex*(self: Value; index: int; property: Value) =
  jsc_value_object_set_property_at_index(cast[ptr Value00](self.impl), uint32(index), cast[ptr Value00](property.impl))

proc jsc_value_to_boolean(self: ptr Value00): gboolean {.
    importc, libprag.}

proc toBoolean*(self: Value): bool =
  toBool(jsc_value_to_boolean(cast[ptr Value00](self.impl)))

proc jsc_value_to_double(self: ptr Value00): cdouble {.
    importc, libprag.}

proc toDouble*(self: Value): cdouble =
  jsc_value_to_double(cast[ptr Value00](self.impl))

proc jsc_value_to_int32(self: ptr Value00): int32 {.
    importc, libprag.}

proc toInt32*(self: Value): int =
  int(jsc_value_to_int32(cast[ptr Value00](self.impl)))

proc jsc_value_to_json(self: ptr Value00; indent: uint32): cstring {.
    importc, libprag.}

proc toJson*(self: Value; indent: int): string =
  let resul0 = jsc_value_to_json(cast[ptr Value00](self.impl), uint32(indent))
  result = $resul0
  cogfree(resul0)

proc jsc_value_to_string(self: ptr Value00): cstring {.
    importc, libprag.}

proc toString*(self: Value): string =
  let resul0 = jsc_value_to_string(cast[ptr Value00](self.impl))
  result = $resul0
  cogfree(resul0)

proc jsc_value_to_string_as_bytes(self: ptr Value00): ptr glib.Bytes00 {.
    importc, libprag.}

proc toStringAsBytes*(self: Value): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = jsc_value_to_string_as_bytes(cast[ptr Value00](self.impl))

proc jsc_class_add_constructor_variadic(self: ptr Class00; name: cstring;
    callback: Callback; userData: pointer; destroyNotify: DestroyNotify; returnType: GType): ptr Value00 {.
    importc, libprag.}

proc addConstructorVariadic*(self: Class; name: cstring = nil;
    callback: Callback; userData: pointer; destroyNotify: DestroyNotify; returnType: GType): Value =
  let gobj = jsc_class_add_constructor_variadic(cast[ptr Class00](self.impl), name, callback, userData, destroyNotify, returnType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_class_add_constructorv(self: ptr Class00; name: cstring; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: uint32;
    parameterTypes: ptr GType): ptr Value00 {.
    importc, libprag.}

proc addConstructor*(self: Class; name: cstring = nil; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: int;
    parameterTypes: ptr GType): Value =
  let gobj = jsc_class_add_constructorv(cast[ptr Class00](self.impl), name, callback, userData, destroyNotify, returnType, uint32(nParameters), parameterTypes)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Context* = ref object of gobject.Object
  Context00* = object of gobject.Object00

proc jsc_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Context()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc jsc_context_new(): ptr Context00 {.
    importc, libprag.}

proc newContext*(): Context =
  let gobj = jsc_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContext*(tdesc: typedesc): tdesc =
  assert(result is Context)
  let gobj = jsc_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContext*[T](result: var T) {.deprecated.} =
  assert(result is Context)
  let gobj = jsc_context_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_context_get_current(): ptr Context00 {.
    importc, libprag.}

proc getCurrent*(): Context =
  let gobj = jsc_context_get_current()
  if gobj.isNil:
    return nil
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

proc jsc_context_clear_exception(self: ptr Context00) {.
    importc, libprag.}

proc clearException*(self: Context) =
  jsc_context_clear_exception(cast[ptr Context00](self.impl))

proc jsc_context_evaluate(self: ptr Context00; code: cstring; length: int64): ptr Value00 {.
    importc, libprag.}

proc evaluate*(self: Context; code: cstring; length: int64): Value =
  let gobj = jsc_context_evaluate(cast[ptr Context00](self.impl), code, length)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_context_evaluate_in_object(self: ptr Context00; code: cstring; length: int64;
    objectInstance: pointer; objectClass: ptr Class00; uri: cstring; lineNumber: uint32;
    `object`: var ptr Value00): ptr Value00 {.
    importc, libprag.}

proc evaluateInObject*(self: Context; code: cstring; length: int64;
    objectInstance: pointer; objectClass: Class = nil; uri: cstring; lineNumber: int;
    `object`: var Value): Value =
  var tmpoutgobjectarg: ptr Value00
  let gobj = jsc_context_evaluate_in_object(cast[ptr Context00](self.impl), code, length, objectInstance, if objectClass.isNil: nil else: cast[ptr Class00](objectClass.impl), uri, uint32(lineNumber), tmpoutgobjectarg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
#  dothemagic(`object`
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    `object` = cast[type(`object`)](argqdata)
    assert(`object`.impl == tmpoutgobjectarg)
  else:
    fnew(`object`, javascriptcore.finalizeGObject)
    `object`.impl = tmpoutgobjectarg
    GC_ref(`object`)
    if g_object_is_floating(`object`.impl).int != 0:
      discard g_object_ref_sink(`object`.impl)
    g_object_add_toggle_ref(`object`.impl, toggleNotify, addr(`object`[]))
    g_object_unref(`object`.impl)
    assert(g_object_get_qdata(`object`.impl, Quark) == nil)
    g_object_set_qdata(`object`.impl, Quark, addr(`object`[]))


proc jsc_context_evaluate_with_source_uri(self: ptr Context00; code: cstring;
    length: int64; uri: cstring; lineNumber: uint32): ptr Value00 {.
    importc, libprag.}

proc evaluateWithSourceUri*(self: Context; code: cstring; length: int64;
    uri: cstring; lineNumber: int): Value =
  let gobj = jsc_context_evaluate_with_source_uri(cast[ptr Context00](self.impl), code, length, uri, uint32(lineNumber))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_context_get_global_object(self: ptr Context00): ptr Value00 {.
    importc, libprag.}

proc getGlobalObject*(self: Context): Value =
  let gobj = jsc_context_get_global_object(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc globalObject*(self: Context): Value =
  let gobj = jsc_context_get_global_object(cast[ptr Context00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_context_get_value(self: ptr Context00; name: cstring): ptr Value00 {.
    importc, libprag.}

proc getValue*(self: Context; name: cstring): Value =
  let gobj = jsc_context_get_value(cast[ptr Context00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_context_pop_exception_handler(self: ptr Context00) {.
    importc, libprag.}

proc popExceptionHandler*(self: Context) =
  jsc_context_pop_exception_handler(cast[ptr Context00](self.impl))

proc jsc_context_set_value(self: ptr Context00; name: cstring; value: ptr Value00) {.
    importc, libprag.}

proc setValue*(self: Context; name: cstring; value: Value) =
  jsc_context_set_value(cast[ptr Context00](self.impl), name, cast[ptr Value00](value.impl))

proc jsc_context_throw(self: ptr Context00; errorMessage: cstring) {.
    importc, libprag.}

proc throw*(self: Context; errorMessage: cstring) =
  jsc_context_throw(cast[ptr Context00](self.impl), errorMessage)

proc jsc_context_throw_with_name(self: ptr Context00; errorName: cstring;
    errorMessage: cstring) {.
    importc, libprag.}

proc throwWithName*(self: Context; errorName: cstring; errorMessage: cstring) =
  jsc_context_throw_with_name(cast[ptr Context00](self.impl), errorName, errorMessage)

proc jsc_value_new_array_from_garray(context: ptr Context00; array: ptr PtrArray00): ptr Value00 {.
    importc, libprag.}

proc newValueArrayFromGarray*(context: Context; array: ptr PtrArray00): Value =
  let gobj = jsc_value_new_array_from_garray(cast[ptr Context00](context.impl), array)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueArrayFromGarray*(tdesc: typedesc; context: Context; array: ptr PtrArray00): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_array_from_garray(cast[ptr Context00](context.impl), array)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueArrayFromGarray*[T](result: var T; context: Context; array: ptr PtrArray00) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_array_from_garray(cast[ptr Context00](context.impl), array)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_array_from_strv(context: ptr Context00; strv: ptr cstring): ptr Value00 {.
    importc, libprag.}

proc newValueArrayFromStrv*(context: Context; strv: varargs[string, `$`]): Value =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let gobj = jsc_value_new_array_from_strv(cast[ptr Context00](context.impl), seq2CstringArray(strv, fs469n23))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueArrayFromStrv*(tdesc: typedesc; context: Context; strv: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Value)
  let gobj = jsc_value_new_array_from_strv(cast[ptr Context00](context.impl), seq2CstringArray(strv, fs469n23))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueArrayFromStrv*[T](result: var T; context: Context; strv: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is Value)
  let gobj = jsc_value_new_array_from_strv(cast[ptr Context00](context.impl), seq2CstringArray(strv, fs469n23))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_boolean(context: ptr Context00; value: gboolean): ptr Value00 {.
    importc, libprag.}

proc newValueBoolean*(context: Context; value: bool): Value =
  let gobj = jsc_value_new_boolean(cast[ptr Context00](context.impl), gboolean(value))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueBoolean*(tdesc: typedesc; context: Context; value: bool): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_boolean(cast[ptr Context00](context.impl), gboolean(value))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueBoolean*[T](result: var T; context: Context; value: bool) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_boolean(cast[ptr Context00](context.impl), gboolean(value))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_from_json(context: ptr Context00; json: cstring): ptr Value00 {.
    importc, libprag.}

proc newValueFromJson*(context: Context; json: cstring): Value =
  let gobj = jsc_value_new_from_json(cast[ptr Context00](context.impl), json)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueFromJson*(tdesc: typedesc; context: Context; json: cstring): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_from_json(cast[ptr Context00](context.impl), json)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueFromJson*[T](result: var T; context: Context; json: cstring) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_from_json(cast[ptr Context00](context.impl), json)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_function_variadic(context: ptr Context00; name: cstring;
    callback: Callback; userData: pointer; destroyNotify: DestroyNotify; returnType: GType): ptr Value00 {.
    importc, libprag.}

proc newValueFunctionVariadic*(context: Context; name: cstring = nil;
    callback: Callback; userData: pointer; destroyNotify: DestroyNotify; returnType: GType): Value =
  let gobj = jsc_value_new_function_variadic(cast[ptr Context00](context.impl), name, callback, userData, destroyNotify, returnType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueFunctionVariadic*(tdesc: typedesc; context: Context; name: cstring = nil;
    callback: Callback; userData: pointer; destroyNotify: DestroyNotify; returnType: GType): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_function_variadic(cast[ptr Context00](context.impl), name, callback, userData, destroyNotify, returnType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueFunctionVariadic*[T](result: var T; context: Context; name: cstring = nil;
    callback: Callback; userData: pointer; destroyNotify: DestroyNotify; returnType: GType) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_function_variadic(cast[ptr Context00](context.impl), name, callback, userData, destroyNotify, returnType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_functionv(context: ptr Context00; name: cstring; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: uint32;
    parameterTypes: ptr GType): ptr Value00 {.
    importc, libprag.}

proc newValueFunction*(context: Context; name: cstring = nil; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: int;
    parameterTypes: ptr GType): Value =
  let gobj = jsc_value_new_functionv(cast[ptr Context00](context.impl), name, callback, userData, destroyNotify, returnType, uint32(nParameters), parameterTypes)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueFunction*(tdesc: typedesc; context: Context; name: cstring = nil; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: int;
    parameterTypes: ptr GType): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_functionv(cast[ptr Context00](context.impl), name, callback, userData, destroyNotify, returnType, uint32(nParameters), parameterTypes)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueFunction*[T](result: var T; context: Context; name: cstring = nil; callback: Callback;
    userData: pointer; destroyNotify: DestroyNotify; returnType: GType; nParameters: int;
    parameterTypes: ptr GType) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_functionv(cast[ptr Context00](context.impl), name, callback, userData, destroyNotify, returnType, uint32(nParameters), parameterTypes)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_null(context: ptr Context00): ptr Value00 {.
    importc, libprag.}

proc newValueNull*(context: Context): Value =
  let gobj = jsc_value_new_null(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueNull*(tdesc: typedesc; context: Context): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_null(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueNull*[T](result: var T; context: Context) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_null(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_number(context: ptr Context00; number: cdouble): ptr Value00 {.
    importc, libprag.}

proc newValueNumber*(context: Context; number: cdouble): Value =
  let gobj = jsc_value_new_number(cast[ptr Context00](context.impl), number)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueNumber*(tdesc: typedesc; context: Context; number: cdouble): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_number(cast[ptr Context00](context.impl), number)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueNumber*[T](result: var T; context: Context; number: cdouble) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_number(cast[ptr Context00](context.impl), number)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_object(context: ptr Context00; instance: pointer; jscClass: ptr Class00): ptr Value00 {.
    importc, libprag.}

proc newValueObject*(context: Context; instance: pointer; jscClass: Class = nil): Value =
  let gobj = jsc_value_new_object(cast[ptr Context00](context.impl), instance, if jscClass.isNil: nil else: cast[ptr Class00](jscClass.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueObject*(tdesc: typedesc; context: Context; instance: pointer; jscClass: Class = nil): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_object(cast[ptr Context00](context.impl), instance, if jscClass.isNil: nil else: cast[ptr Class00](jscClass.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueObject*[T](result: var T; context: Context; instance: pointer; jscClass: Class = nil) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_object(cast[ptr Context00](context.impl), instance, if jscClass.isNil: nil else: cast[ptr Class00](jscClass.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_string(context: ptr Context00; string: cstring): ptr Value00 {.
    importc, libprag.}

proc newValueString*(context: Context; string: cstring = nil): Value =
  let gobj = jsc_value_new_string(cast[ptr Context00](context.impl), string)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueString*(tdesc: typedesc; context: Context; string: cstring = nil): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_string(cast[ptr Context00](context.impl), string)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueString*[T](result: var T; context: Context; string: cstring = nil) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_string(cast[ptr Context00](context.impl), string)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_string_from_bytes(context: ptr Context00; bytes: ptr glib.Bytes00): ptr Value00 {.
    importc, libprag.}

proc newValueStringFromBytes*(context: Context; bytes: glib.Bytes = nil): Value =
  let gobj = jsc_value_new_string_from_bytes(cast[ptr Context00](context.impl), if bytes.isNil: nil else: cast[ptr glib.Bytes00](bytes.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueStringFromBytes*(tdesc: typedesc; context: Context; bytes: glib.Bytes = nil): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_string_from_bytes(cast[ptr Context00](context.impl), if bytes.isNil: nil else: cast[ptr glib.Bytes00](bytes.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueStringFromBytes*[T](result: var T; context: Context; bytes: glib.Bytes = nil) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_string_from_bytes(cast[ptr Context00](context.impl), if bytes.isNil: nil else: cast[ptr glib.Bytes00](bytes.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_new_undefined(context: ptr Context00): ptr Value00 {.
    importc, libprag.}

proc newValueUndefined*(context: Context): Value =
  let gobj = jsc_value_new_undefined(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newValueUndefined*(tdesc: typedesc; context: Context): tdesc =
  assert(result is Value)
  let gobj = jsc_value_new_undefined(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initValueUndefined*[T](result: var T; context: Context) {.deprecated.} =
  assert(result is Value)
  let gobj = jsc_value_new_undefined(cast[ptr Context00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_value_get_context(self: ptr Value00): ptr Context00 {.
    importc, libprag.}

proc getContext*(self: Value): Context =
  let gobj = jsc_value_get_context(cast[ptr Value00](self.impl))
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

proc context*(self: Value): Context =
  let gobj = jsc_value_get_context(cast[ptr Value00](self.impl))
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
  VirtualMachine* = ref object of gobject.Object
  VirtualMachine00* = object of gobject.Object00

proc jsc_virtual_machine_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VirtualMachine()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc jsc_virtual_machine_new(): ptr VirtualMachine00 {.
    importc, libprag.}

proc newVirtualMachine*(): VirtualMachine =
  let gobj = jsc_virtual_machine_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newVirtualMachine*(tdesc: typedesc): tdesc =
  assert(result is VirtualMachine)
  let gobj = jsc_virtual_machine_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initVirtualMachine*[T](result: var T) {.deprecated.} =
  assert(result is VirtualMachine)
  let gobj = jsc_virtual_machine_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_context_new_with_virtual_machine(vm: ptr VirtualMachine00): ptr Context00 {.
    importc, libprag.}

proc newContextWithVirtualMachine*(vm: VirtualMachine): Context =
  let gobj = jsc_context_new_with_virtual_machine(cast[ptr VirtualMachine00](vm.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newContextWithVirtualMachine*(tdesc: typedesc; vm: VirtualMachine): tdesc =
  assert(result is Context)
  let gobj = jsc_context_new_with_virtual_machine(cast[ptr VirtualMachine00](vm.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContextWithVirtualMachine*[T](result: var T; vm: VirtualMachine) {.deprecated.} =
  assert(result is Context)
  let gobj = jsc_context_new_with_virtual_machine(cast[ptr VirtualMachine00](vm.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_context_get_virtual_machine(self: ptr Context00): ptr VirtualMachine00 {.
    importc, libprag.}

proc getVirtualMachine*(self: Context): VirtualMachine =
  let gobj = jsc_context_get_virtual_machine(cast[ptr Context00](self.impl))
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

proc virtualMachine*(self: Context): VirtualMachine =
  let gobj = jsc_context_get_virtual_machine(cast[ptr Context00](self.impl))
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
  ClassVTable00* {.pure.} = object
  ClassVTable* = ref object
    impl*: ptr ClassVTable00
    ignoreFinalizer*: bool

proc jsc_context_register_class(self: ptr Context00; name: cstring; parentClass: ptr Class00;
    vtable: ptr ClassVTable00; destroyNotify: DestroyNotify): ptr Class00 {.
    importc, libprag.}

proc registerClass*(self: Context; name: cstring; parentClass: Class = nil;
    vtable: ClassVTable = nil; destroyNotify: DestroyNotify): Class =
  let gobj = jsc_context_register_class(cast[ptr Context00](self.impl), name, if parentClass.isNil: nil else: cast[ptr Class00](parentClass.impl), if vtable.isNil: nil else: cast[ptr ClassVTable00](vtable.impl), destroyNotify)
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
  Exception* = ref object of gobject.Object
  Exception00* = object of gobject.Object00

proc jsc_exception_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Exception()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc jsc_exception_new(context: ptr Context00; message: cstring): ptr Exception00 {.
    importc, libprag.}

proc newException*(context: Context; message: cstring): Exception =
  let gobj = jsc_exception_new(cast[ptr Context00](context.impl), message)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newException*(tdesc: typedesc; context: Context; message: cstring): tdesc =
  assert(result is Exception)
  let gobj = jsc_exception_new(cast[ptr Context00](context.impl), message)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initException*[T](result: var T; context: Context; message: cstring) {.deprecated.} =
  assert(result is Exception)
  let gobj = jsc_exception_new(cast[ptr Context00](context.impl), message)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_exception_new_with_name(context: ptr Context00; name: cstring; message: cstring): ptr Exception00 {.
    importc, libprag.}

proc newExceptionWithName*(context: Context; name: cstring; message: cstring): Exception =
  let gobj = jsc_exception_new_with_name(cast[ptr Context00](context.impl), name, message)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newExceptionWithName*(tdesc: typedesc; context: Context; name: cstring; message: cstring): tdesc =
  assert(result is Exception)
  let gobj = jsc_exception_new_with_name(cast[ptr Context00](context.impl), name, message)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initExceptionWithName*[T](result: var T; context: Context; name: cstring; message: cstring) {.deprecated.} =
  assert(result is Exception)
  let gobj = jsc_exception_new_with_name(cast[ptr Context00](context.impl), name, message)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_exception_get_backtrace_string(self: ptr Exception00): cstring {.
    importc, libprag.}

proc getBacktraceString*(self: Exception): string =
  let resul0 = jsc_exception_get_backtrace_string(cast[ptr Exception00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc backtraceString*(self: Exception): string =
  let resul0 = jsc_exception_get_backtrace_string(cast[ptr Exception00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc jsc_exception_get_column_number(self: ptr Exception00): uint32 {.
    importc, libprag.}

proc getColumnNumber*(self: Exception): int =
  int(jsc_exception_get_column_number(cast[ptr Exception00](self.impl)))

proc columnNumber*(self: Exception): int =
  int(jsc_exception_get_column_number(cast[ptr Exception00](self.impl)))

proc jsc_exception_get_line_number(self: ptr Exception00): uint32 {.
    importc, libprag.}

proc getLineNumber*(self: Exception): int =
  int(jsc_exception_get_line_number(cast[ptr Exception00](self.impl)))

proc lineNumber*(self: Exception): int =
  int(jsc_exception_get_line_number(cast[ptr Exception00](self.impl)))

proc jsc_exception_get_message(self: ptr Exception00): cstring {.
    importc, libprag.}

proc getMessage*(self: Exception): string =
  result = $jsc_exception_get_message(cast[ptr Exception00](self.impl))

proc message*(self: Exception): string =
  result = $jsc_exception_get_message(cast[ptr Exception00](self.impl))

proc jsc_exception_get_name(self: ptr Exception00): cstring {.
    importc, libprag.}

proc getName*(self: Exception): string =
  result = $jsc_exception_get_name(cast[ptr Exception00](self.impl))

proc name*(self: Exception): string =
  result = $jsc_exception_get_name(cast[ptr Exception00](self.impl))

proc jsc_exception_get_source_uri(self: ptr Exception00): cstring {.
    importc, libprag.}

proc getSourceUri*(self: Exception): string =
  let resul0 = jsc_exception_get_source_uri(cast[ptr Exception00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc sourceUri*(self: Exception): string =
  let resul0 = jsc_exception_get_source_uri(cast[ptr Exception00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc jsc_exception_report(self: ptr Exception00): cstring {.
    importc, libprag.}

proc report*(self: Exception): string =
  let resul0 = jsc_exception_report(cast[ptr Exception00](self.impl))
  result = $resul0
  cogfree(resul0)

proc jsc_exception_to_string(self: ptr Exception00): cstring {.
    importc, libprag.}

proc toString*(self: Exception): string =
  let resul0 = jsc_exception_to_string(cast[ptr Exception00](self.impl))
  result = $resul0
  cogfree(resul0)

proc jsc_context_check_syntax(self: ptr Context00; code: cstring; length: int64;
    mode: CheckSyntaxMode; uri: cstring; lineNumber: uint32; exception: var ptr Exception00): CheckSyntaxResult {.
    importc, libprag.}

proc checkSyntax*(self: Context; code: cstring; length: int64;
    mode: CheckSyntaxMode; uri: cstring; lineNumber: int; exception: var Exception = cast[var Exception](nil)): CheckSyntaxResult =
  var tmpoutgobjectarg: ptr Exception00
  result = jsc_context_check_syntax(cast[ptr Context00](self.impl), code, length, mode, uri, uint32(lineNumber), cast[var ptr Exception00](if addr(exception) == nil: nil else: addr tmpoutgobjectarg))
#  dothemagic(exception
  if addr(exception) != nil:
    exception = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      exception = cast[type(exception)](argqdata)
      assert(exception.impl == tmpoutgobjectarg)
    else:
      fnew(exception, javascriptcore.finalizeGObject)
      exception.impl = tmpoutgobjectarg
      GC_ref(exception)
      if g_object_is_floating(exception.impl).int != 0:
        discard g_object_ref_sink(exception.impl)
      g_object_add_toggle_ref(exception.impl, toggleNotify, addr(exception[]))
      g_object_unref(exception.impl)
      assert(g_object_get_qdata(exception.impl, Quark) == nil)
      g_object_set_qdata(exception.impl, Quark, addr(exception[]))


proc jsc_context_get_exception(self: ptr Context00): ptr Exception00 {.
    importc, libprag.}

proc getException*(self: Context): Exception =
  let gobj = jsc_context_get_exception(cast[ptr Context00](self.impl))
  if gobj.isNil:
    return nil
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

proc exception*(self: Context): Exception =
  let gobj = jsc_context_get_exception(cast[ptr Context00](self.impl))
  if gobj.isNil:
    return nil
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

proc jsc_context_throw_exception(self: ptr Context00; exception: ptr Exception00) {.
    importc, libprag.}

proc throwException*(self: Context; exception: Exception) =
  jsc_context_throw_exception(cast[ptr Context00](self.impl), cast[ptr Exception00](exception.impl))

type
  ValuePropertyFlag* {.size: sizeof(cint), pure.} = enum
    configurable = 0
    enumerable = 1
    writable = 2

  ValuePropertyFlags* {.size: sizeof(cint).} = set[ValuePropertyFlag]

proc jsc_value_object_define_property_accessor(self: ptr Value00; propertyName: cstring;
    flags: ValuePropertyFlags; propertyType: GType; getter: Callback; setter: Callback;
    userData: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc objectDefinePropertyAccessor*(self: Value; propertyName: cstring;
    flags: ValuePropertyFlags; propertyType: GType; getter: Callback; setter: Callback;
    userData: pointer; destroyNotify: DestroyNotify) =
  jsc_value_object_define_property_accessor(cast[ptr Value00](self.impl), propertyName, flags, propertyType, getter, setter, userData, destroyNotify)

proc jsc_value_object_define_property_data(self: ptr Value00; propertyName: cstring;
    flags: ValuePropertyFlags; propertyValue: ptr Value00) {.
    importc, libprag.}

proc objectDefinePropertyData*(self: Value; propertyName: cstring;
    flags: ValuePropertyFlags; propertyValue: Value = nil) =
  jsc_value_object_define_property_data(cast[ptr Value00](self.impl), propertyName, flags, if propertyValue.isNil: nil else: cast[ptr Value00](propertyValue.impl))

type
  ClassDeletePropertyFunction* = proc (jscClass: ptr Class00; context: ptr Context00; instance: pointer; name: cstring): gboolean {.cdecl.}

type
  ClassEnumeratePropertiesFunction* = proc (jscClass: ptr Class00; context: ptr Context00; instance: pointer): ptr cstring {.cdecl.}

type
  ClassGetPropertyFunction* = proc (jscClass: ptr Class00; context: ptr Context00; instance: pointer; name: cstring): ptr Value00 {.cdecl.}

type
  ClassHasPropertyFunction* = proc (jscClass: ptr Class00; context: ptr Context00; instance: pointer; name: cstring): gboolean {.cdecl.}

type
  ClassSetPropertyFunction* = proc (jscClass: ptr Class00; context: ptr Context00; instance: pointer; name: cstring;
    value: ptr Value00): gboolean {.cdecl.}

type
  ExceptionHandler* = proc (context: ptr Context00; exception: ptr Exception00; userData: pointer) {.cdecl.}

proc jsc_context_push_exception_handler(self: ptr Context00; handler: ExceptionHandler;
    userData: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc pushExceptionHandler*(self: Context; handler: ExceptionHandler;
    userData: pointer; destroyNotify: DestroyNotify) =
  jsc_context_push_exception_handler(cast[ptr Context00](self.impl), handler, userData, destroyNotify)

const MAJOR_VERSION* = 2'i32

const MICRO_VERSION* = 0'i32

const MINOR_VERSION* = 36'i32

const OPTIONS_USE_DFG* = "useDFGJIT"

const OPTIONS_USE_FTL* = "useFTLJIT"

const OPTIONS_USE_JIT* = "useJIT"

const OPTIONS_USE_LLINT* = "useLLInt"

type
  OptionType* {.size: sizeof(cint), pure.} = enum
    boolean = 0
    int = 1
    uint = 2
    size = 3
    double = 4
    string = 5
    rangeString = 6

type
  OptionsFunc* = proc (option: cstring; `type`: OptionType; description: cstring; userData: pointer): gboolean {.cdecl.}

type
  WeakValue* = ref object of gobject.Object
  WeakValue00* = object of gobject.Object00

proc jsc_weak_value_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WeakValue()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCleared*(self: WeakValue;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "cleared", cast[GCallback](p), xdata, nil, cf)

proc jsc_weak_value_new(value: ptr Value00): ptr WeakValue00 {.
    importc, libprag.}

proc newWeakValue*(value: Value): WeakValue =
  let gobj = jsc_weak_value_new(cast[ptr Value00](value.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newWeakValue*(tdesc: typedesc; value: Value): tdesc =
  assert(result is WeakValue)
  let gobj = jsc_weak_value_new(cast[ptr Value00](value.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWeakValue*[T](result: var T; value: Value) {.deprecated.} =
  assert(result is WeakValue)
  let gobj = jsc_weak_value_new(cast[ptr Value00](value.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_weak_value_get_value(self: ptr WeakValue00): ptr Value00 {.
    importc, libprag.}

proc getValue*(self: WeakValue): Value =
  let gobj = jsc_weak_value_get_value(cast[ptr WeakValue00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc value*(self: WeakValue): Value =
  let gobj = jsc_weak_value_get_value(cast[ptr WeakValue00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, javascriptcore.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc jsc_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(jsc_get_major_version())

proc jsc_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(jsc_get_micro_version())

proc jsc_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(jsc_get_minor_version())

proc optionsForeach*(function: OptionsFunc; userData: pointer) {.
    importc: "jsc_options_foreach", libprag.}

proc jsc_options_get_boolean(option: cstring; value: var gboolean): gboolean {.
    importc, libprag.}

proc optionsGetBoolean*(option: cstring; value: var bool): bool =
  var value_00: gboolean
  result = toBool(jsc_options_get_boolean(option, value_00))
  if value.addr != nil:
    value = toBool(value_00)

proc jsc_options_get_double(option: cstring; value: var cdouble): gboolean {.
    importc, libprag.}

proc optionsGetDouble*(option: cstring; value: var cdouble): bool =
  toBool(jsc_options_get_double(option, value))

proc jsc_options_get_int(option: cstring; value: var int32): gboolean {.
    importc, libprag.}

proc optionsGetInt*(option: cstring; value: var int): bool =
  var value_00: int32
  result = toBool(jsc_options_get_int(option, value_00))
  if value.addr != nil:
    value = int(value_00)

proc jsc_options_get_option_group(): ptr glib.OptionGroup00 {.
    importc, libprag.}

proc optionsGetOptionGroup*(): glib.OptionGroup =
  fnew(result, gBoxedFreeGOptionGroup)
  result.impl = jsc_options_get_option_group()

proc jsc_options_get_range_string(option: cstring; value: var cstring): gboolean {.
    importc, libprag.}

proc optionsGetRangeString*(option: cstring; value: var string): bool =
  var value_00: cstring
  result = toBool(jsc_options_get_range_string(option, value_00))
  if value.addr != nil:
    value = $(value_00)

proc jsc_options_get_size(option: cstring; value: var uint64): gboolean {.
    importc, libprag.}

proc optionsGetSize*(option: cstring; value: var uint64): bool =
  toBool(jsc_options_get_size(option, value))

proc jsc_options_get_string(option: cstring; value: var cstring): gboolean {.
    importc, libprag.}

proc optionsGetString*(option: cstring; value: var string): bool =
  var value_00: cstring
  result = toBool(jsc_options_get_string(option, value_00))
  if value.addr != nil:
    value = $(value_00)

proc jsc_options_get_uint(option: cstring; value: var uint32): gboolean {.
    importc, libprag.}

proc optionsGetUint*(option: cstring; value: var int): bool =
  var value_00: uint32
  result = toBool(jsc_options_get_uint(option, value_00))
  if value.addr != nil:
    value = int(value_00)

proc jsc_options_set_boolean(option: cstring; value: gboolean): gboolean {.
    importc, libprag.}

proc optionsSetBoolean*(option: cstring; value: bool): bool =
  toBool(jsc_options_set_boolean(option, gboolean(value)))

proc jsc_options_set_double(option: cstring; value: cdouble): gboolean {.
    importc, libprag.}

proc optionsSetDouble*(option: cstring; value: cdouble): bool =
  toBool(jsc_options_set_double(option, value))

proc jsc_options_set_int(option: cstring; value: int32): gboolean {.
    importc, libprag.}

proc optionsSetInt*(option: cstring; value: int): bool =
  toBool(jsc_options_set_int(option, int32(value)))

proc jsc_options_set_range_string(option: cstring; value: cstring): gboolean {.
    importc, libprag.}

proc optionsSetRangeString*(option: cstring; value: cstring): bool =
  toBool(jsc_options_set_range_string(option, value))

proc jsc_options_set_size(option: cstring; value: uint64): gboolean {.
    importc, libprag.}

proc optionsSetSize*(option: cstring; value: uint64): bool =
  toBool(jsc_options_set_size(option, value))

proc jsc_options_set_string(option: cstring; value: cstring): gboolean {.
    importc, libprag.}

proc optionsSetString*(option: cstring; value: cstring): bool =
  toBool(jsc_options_set_string(option, value))

proc jsc_options_set_uint(option: cstring; value: uint32): gboolean {.
    importc, libprag.}

proc optionsSetUint*(option: cstring; value: int): bool =
  toBool(jsc_options_set_uint(option, uint32(value)))
# === remaining symbols:
