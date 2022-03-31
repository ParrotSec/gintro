# dependencies:
# GObject-2.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gst-1.0
# GObject-2.0
# GModule-2.0
# GLib-2.0
# libraries:
# libgstcontroller-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule
const Lib = "libgstcontroller-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  ARGBControlBinding* = ref object of gst.ControlBinding
  ARGBControlBinding00* = object of gst.ControlBinding00

proc gst_argb_control_binding_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ARGBControlBinding()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_argb_control_binding_new(`object`: ptr gst.Object00; propertyName: cstring;
    csA: ptr gst.ControlSource00; csR: ptr gst.ControlSource00; csG: ptr gst.ControlSource00;
    csB: ptr gst.ControlSource00): ptr ARGBControlBinding00 {.
    importc, libprag.}

proc newARGBControlBinding*(`object`: gst.Object; propertyName: cstring;
    csA: gst.ControlSource; csR: gst.ControlSource; csG: gst.ControlSource;
    csB: gst.ControlSource): ARGBControlBinding =
  let gobj = gst_argb_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](csA.impl), cast[ptr gst.ControlSource00](csR.impl), cast[ptr gst.ControlSource00](csG.impl), cast[ptr gst.ControlSource00](csB.impl))
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

proc newARGBControlBinding*(tdesc: typedesc; `object`: gst.Object; propertyName: cstring;
    csA: gst.ControlSource; csR: gst.ControlSource; csG: gst.ControlSource;
    csB: gst.ControlSource): tdesc =
  assert(result is ARGBControlBinding)
  let gobj = gst_argb_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](csA.impl), cast[ptr gst.ControlSource00](csR.impl), cast[ptr gst.ControlSource00](csG.impl), cast[ptr gst.ControlSource00](csB.impl))
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

proc initARGBControlBinding*[T](result: var T; `object`: gst.Object; propertyName: cstring;
    csA: gst.ControlSource; csR: gst.ControlSource; csG: gst.ControlSource;
    csB: gst.ControlSource) {.deprecated.} =
  assert(result is ARGBControlBinding)
  let gobj = gst_argb_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](csA.impl), cast[ptr gst.ControlSource00](csR.impl), cast[ptr gst.ControlSource00](csG.impl), cast[ptr gst.ControlSource00](csB.impl))
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
  ControlPoint00* {.pure.} = object
  ControlPoint* = ref object
    impl*: ptr ControlPoint00
    ignoreFinalizer*: bool

proc gst_control_point_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstControlPoint*(self: ControlPoint) =
  if not self.ignoreFinalizer:
    boxedFree(gst_control_point_get_type(), cast[ptr ControlPoint00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ControlPoint()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_control_point_get_type(), cast[ptr ControlPoint00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ControlPoint) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstControlPoint)

proc gst_control_point_free(self: ptr ControlPoint00) {.
    importc, libprag.}

proc free*(self: ControlPoint) =
  gst_control_point_free(cast[ptr ControlPoint00](self.impl))

proc finalizerfree*(self: ControlPoint) =
  if not self.ignoreFinalizer:
    gst_control_point_free(cast[ptr ControlPoint00](self.impl))

proc gst_control_point_copy(self: ptr ControlPoint00): ptr ControlPoint00 {.
    importc, libprag.}

proc copy*(self: ControlPoint): ControlPoint =
  fnew(result, gBoxedFreeGstControlPoint)
  result.impl = gst_control_point_copy(cast[ptr ControlPoint00](self.impl))

type
  DirectControlBinding* = ref object of gst.ControlBinding
  DirectControlBinding00* = object of gst.ControlBinding00

proc gst_direct_control_binding_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DirectControlBinding()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_direct_control_binding_new(`object`: ptr gst.Object00; propertyName: cstring;
    cs: ptr gst.ControlSource00): ptr DirectControlBinding00 {.
    importc, libprag.}

proc newDirectControlBinding*(`object`: gst.Object; propertyName: cstring;
    cs: gst.ControlSource): DirectControlBinding =
  let gobj = gst_direct_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](cs.impl))
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

proc newDirectControlBinding*(tdesc: typedesc; `object`: gst.Object; propertyName: cstring;
    cs: gst.ControlSource): tdesc =
  assert(result is DirectControlBinding)
  let gobj = gst_direct_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](cs.impl))
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

proc initDirectControlBinding*[T](result: var T; `object`: gst.Object; propertyName: cstring;
    cs: gst.ControlSource) {.deprecated.} =
  assert(result is DirectControlBinding)
  let gobj = gst_direct_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](cs.impl))
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

proc gst_direct_control_binding_new_absolute(`object`: ptr gst.Object00;
    propertyName: cstring; cs: ptr gst.ControlSource00): ptr DirectControlBinding00 {.
    importc, libprag.}

proc newDirectControlBindingAbsolute*(`object`: gst.Object; propertyName: cstring;
    cs: gst.ControlSource): DirectControlBinding =
  let gobj = gst_direct_control_binding_new_absolute(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](cs.impl))
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

proc newDirectControlBindingAbsolute*(tdesc: typedesc; `object`: gst.Object; propertyName: cstring;
    cs: gst.ControlSource): tdesc =
  assert(result is DirectControlBinding)
  let gobj = gst_direct_control_binding_new_absolute(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](cs.impl))
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

proc initDirectControlBindingAbsolute*[T](result: var T; `object`: gst.Object; propertyName: cstring;
    cs: gst.ControlSource) {.deprecated.} =
  assert(result is DirectControlBinding)
  let gobj = gst_direct_control_binding_new_absolute(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.ControlSource00](cs.impl))
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
  DirectControlBindingConvertGValue* = proc (self: ptr DirectControlBinding00; srcValue: cdouble; destValue: gobject.Value) {.cdecl.}

type
  DirectControlBindingConvertValue* = proc (self: ptr DirectControlBinding00; srcValue: cdouble; destValue: pointer) {.cdecl.}

type
  TimedValueControlSource* = ref object of gst.ControlSource
  TimedValueControlSource00* = object of gst.ControlSource00

proc gst_timed_value_control_source_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TimedValueControlSource()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scValueAdded*(self: TimedValueControlSource;  p: proc (self: ptr TimedValueControlSource00; timedValue: ptr ControlPoint00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "value-added", cast[GCallback](p), xdata, nil, cf)

proc scValueChanged*(self: TimedValueControlSource;  p: proc (self: ptr TimedValueControlSource00; timedValue: ptr ControlPoint00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "value-changed", cast[GCallback](p), xdata, nil, cf)

proc scValueRemoved*(self: TimedValueControlSource;  p: proc (self: ptr TimedValueControlSource00; timedValue: ptr ControlPoint00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "value-removed", cast[GCallback](p), xdata, nil, cf)

proc gst_timed_value_control_source_find_control_point_iter(self: ptr TimedValueControlSource00;
    timestamp: uint64): ptr glib.SequenceIter {.
    importc, libprag.}

proc findControlPointIter*(self: TimedValueControlSource;
    timestamp: uint64): ptr glib.SequenceIter =
  gst_timed_value_control_source_find_control_point_iter(cast[ptr TimedValueControlSource00](self.impl), timestamp)

proc gst_timed_value_control_source_get_all(self: ptr TimedValueControlSource00): ptr glib.List {.
    importc, libprag.}

proc getAll*(self: TimedValueControlSource): seq[gst.TimedValue] =
  let resul0 = gst_timed_value_control_source_get_all(cast[ptr TimedValueControlSource00](self.impl))
  g_list_free(resul0)

proc all*(self: TimedValueControlSource): seq[gst.TimedValue] =
  let resul0 = gst_timed_value_control_source_get_all(cast[ptr TimedValueControlSource00](self.impl))
  g_list_free(resul0)

proc gst_timed_value_control_source_get_count(self: ptr TimedValueControlSource00): int32 {.
    importc, libprag.}

proc getCount*(self: TimedValueControlSource): int =
  int(gst_timed_value_control_source_get_count(cast[ptr TimedValueControlSource00](self.impl)))

proc count*(self: TimedValueControlSource): int =
  int(gst_timed_value_control_source_get_count(cast[ptr TimedValueControlSource00](self.impl)))

proc gst_timed_value_control_source_set(self: ptr TimedValueControlSource00;
    timestamp: uint64; value: cdouble): gboolean {.
    importc, libprag.}

proc set*(self: TimedValueControlSource; timestamp: uint64;
    value: cdouble): bool =
  toBool(gst_timed_value_control_source_set(cast[ptr TimedValueControlSource00](self.impl), timestamp, value))

proc gst_timed_value_control_source_set_from_list(self: ptr TimedValueControlSource00;
    timedvalues: ptr glib.SList): gboolean {.
    importc, libprag.}

proc setFromList*(self: TimedValueControlSource;
    timedvalues: seq[gst.TimedValue]): bool =
  var tempResGL = seq2GSList(timedvalues)
  result = toBool(gst_timed_value_control_source_set_from_list(cast[ptr TimedValueControlSource00](self.impl), tempResGL))
  g_slist_free(tempResGL)

proc gst_timed_value_control_source_unset(self: ptr TimedValueControlSource00;
    timestamp: uint64): gboolean {.
    importc, libprag.}

proc unset*(self: TimedValueControlSource;
    timestamp: uint64): bool =
  toBool(gst_timed_value_control_source_unset(cast[ptr TimedValueControlSource00](self.impl), timestamp))

proc gst_timed_value_control_source_unset_all(self: ptr TimedValueControlSource00) {.
    importc, libprag.}

proc unsetAll*(self: TimedValueControlSource) =
  gst_timed_value_control_source_unset_all(cast[ptr TimedValueControlSource00](self.impl))

type
  InterpolationControlSource* = ref object of TimedValueControlSource
  InterpolationControlSource00* = object of TimedValueControlSource00

proc gst_interpolation_control_source_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InterpolationControlSource()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_interpolation_control_source_new(): ptr InterpolationControlSource00 {.
    importc, libprag.}

proc newInterpolationControlSource*(): InterpolationControlSource =
  let gobj = gst_interpolation_control_source_new()
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

proc newInterpolationControlSource*(tdesc: typedesc): tdesc =
  assert(result is InterpolationControlSource)
  let gobj = gst_interpolation_control_source_new()
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

proc initInterpolationControlSource*[T](result: var T) {.deprecated.} =
  assert(result is InterpolationControlSource)
  let gobj = gst_interpolation_control_source_new()
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
  InterpolationMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    linear = 1
    cubic = 2
    cubicMonotonic = 3

type
  LFOControlSource* = ref object of gst.ControlSource
  LFOControlSource00* = object of gst.ControlSource00

proc gst_lfo_control_source_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LFOControlSource()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_lfo_control_source_new(): ptr LFOControlSource00 {.
    importc, libprag.}

proc newLFOControlSource*(): LFOControlSource =
  let gobj = gst_lfo_control_source_new()
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

proc newLFOControlSource*(tdesc: typedesc): tdesc =
  assert(result is LFOControlSource)
  let gobj = gst_lfo_control_source_new()
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

proc initLFOControlSource*[T](result: var T) {.deprecated.} =
  assert(result is LFOControlSource)
  let gobj = gst_lfo_control_source_new()
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
  LFOWaveform* {.size: sizeof(cint), pure.} = enum
    sine = 0
    square = 1
    saw = 2
    reverseSaw = 3
    triangle = 4

type
  ProxyControlBinding* = ref object of gst.ControlBinding
  ProxyControlBinding00* = object of gst.ControlBinding00

proc gst_proxy_control_binding_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ProxyControlBinding()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_proxy_control_binding_new(`object`: ptr gst.Object00; propertyName: cstring;
    refObject: ptr gst.Object00; refPropertyName: cstring): ptr ProxyControlBinding00 {.
    importc, libprag.}

proc newProxyControlBinding*(`object`: gst.Object; propertyName: cstring;
    refObject: gst.Object; refPropertyName: cstring): ProxyControlBinding =
  let gobj = gst_proxy_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.Object00](refObject.impl), refPropertyName)
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

proc newProxyControlBinding*(tdesc: typedesc; `object`: gst.Object; propertyName: cstring;
    refObject: gst.Object; refPropertyName: cstring): tdesc =
  assert(result is ProxyControlBinding)
  let gobj = gst_proxy_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.Object00](refObject.impl), refPropertyName)
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

proc initProxyControlBinding*[T](result: var T; `object`: gst.Object; propertyName: cstring;
    refObject: gst.Object; refPropertyName: cstring) {.deprecated.} =
  assert(result is ProxyControlBinding)
  let gobj = gst_proxy_control_binding_new(cast[ptr gst.Object00](`object`.impl), propertyName, cast[ptr gst.Object00](refObject.impl), refPropertyName)
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
  TriggerControlSource* = ref object of TimedValueControlSource
  TriggerControlSource00* = object of TimedValueControlSource00

proc gst_trigger_control_source_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TriggerControlSource()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_trigger_control_source_new(): ptr TriggerControlSource00 {.
    importc, libprag.}

proc newTriggerControlSource*(): TriggerControlSource =
  let gobj = gst_trigger_control_source_new()
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

proc newTriggerControlSource*(tdesc: typedesc): tdesc =
  assert(result is TriggerControlSource)
  let gobj = gst_trigger_control_source_new()
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

proc initTriggerControlSource*[T](result: var T) {.deprecated.} =
  assert(result is TriggerControlSource)
  let gobj = gst_trigger_control_source_new()
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

proc gst_timed_value_control_invalidate_cache(self: ptr TimedValueControlSource00) {.
    importc, libprag.}

proc timedValueControlInvalidateCache*(self: TimedValueControlSource) =
  gst_timed_value_control_invalidate_cache(cast[ptr TimedValueControlSource00](self.impl))
# === remaining symbols:
