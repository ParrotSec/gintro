# dependencies:
# GObject-2.0
# GLib-2.0
# immediate dependencies:
# GObject-2.0
# libraries:
# libatk-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, glib
const Lib = "libatk-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Action00* = object of gobject.Object00
  Action* = ref object of gobject.Object

type
  PropertyValues00* {.pure.} = object
  PropertyValues* = ref object
    impl*: ptr PropertyValues00
    ignoreFinalizer*: bool

type
  Object* = ref object of gobject.Object
  Object00* = object of gobject.Object00

proc atk_object_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Object()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActiveDescendantChanged*(self: Object;  p: proc (self: ptr Object00; arg1: ptr ptr Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "active-descendant-changed", cast[GCallback](p), xdata, nil, cf)

proc scChildrenChanged*(self: Object;  p: proc (self: ptr Object00; arg1: uint32; arg2: ptr ptr Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "children-changed", cast[GCallback](p), xdata, nil, cf)

proc scFocusEvent*(self: Object;  p: proc (self: ptr Object00; arg1: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "focus-event", cast[GCallback](p), xdata, nil, cf)

proc scPropertyChange*(self: Object;  p: proc (self: ptr Object00; arg1: ptr ptr PropertyValues00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "property-change", cast[GCallback](p), xdata, nil, cf)

proc scStateChange*(self: Object;  p: proc (self: ptr Object00; arg1: cstring; arg2: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "state-change", cast[GCallback](p), xdata, nil, cf)

proc scVisibleDataChanged*(self: Object;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "visible-data-changed", cast[GCallback](p), xdata, nil, cf)

proc atk_object_get_accessible_id(self: ptr Object00): cstring {.
    importc, libprag.}

proc getAccessibleId*(self: Object): string =
  result = $atk_object_get_accessible_id(cast[ptr Object00](self.impl))

proc accessibleId*(self: Object): string =
  result = $atk_object_get_accessible_id(cast[ptr Object00](self.impl))

proc atk_object_get_attributes(self: ptr Object00): ptr glib.SList {.
    importc, libprag.}

proc getAttributes*(self: Object): seq[pointer] =
  let resul0 = atk_object_get_attributes(cast[ptr Object00](self.impl))
  g_slist_free(resul0)

proc attributes*(self: Object): seq[pointer] =
  let resul0 = atk_object_get_attributes(cast[ptr Object00](self.impl))
  g_slist_free(resul0)

proc atk_object_get_description(self: ptr Object00): cstring {.
    importc, libprag.}

proc getDescription*(self: Object): string =
  result = $atk_object_get_description(cast[ptr Object00](self.impl))

proc description*(self: Object): string =
  result = $atk_object_get_description(cast[ptr Object00](self.impl))

proc atk_object_get_index_in_parent(self: ptr Object00): int32 {.
    importc, libprag.}

proc getIndexInParent*(self: Object): int =
  int(atk_object_get_index_in_parent(cast[ptr Object00](self.impl)))

proc indexInParent*(self: Object): int =
  int(atk_object_get_index_in_parent(cast[ptr Object00](self.impl)))

proc atk_object_get_mdi_zorder(self: ptr Object00): int32 {.
    importc, libprag.}

proc getMdiZorder*(self: Object): int =
  int(atk_object_get_mdi_zorder(cast[ptr Object00](self.impl)))

proc mdiZorder*(self: Object): int =
  int(atk_object_get_mdi_zorder(cast[ptr Object00](self.impl)))

proc atk_object_get_n_accessible_children(self: ptr Object00): int32 {.
    importc, libprag.}

proc getNAccessibleChildren*(self: Object): int =
  int(atk_object_get_n_accessible_children(cast[ptr Object00](self.impl)))

proc nAccessibleChildren*(self: Object): int =
  int(atk_object_get_n_accessible_children(cast[ptr Object00](self.impl)))

proc atk_object_get_name(self: ptr Object00): cstring {.
    importc, libprag.}

proc getName*(self: Object): string =
  result = $atk_object_get_name(cast[ptr Object00](self.impl))

proc name*(self: Object): string =
  result = $atk_object_get_name(cast[ptr Object00](self.impl))

proc atk_object_get_object_locale(self: ptr Object00): cstring {.
    importc, libprag.}

proc getObjectLocale*(self: Object): string =
  result = $atk_object_get_object_locale(cast[ptr Object00](self.impl))

proc objectLocale*(self: Object): string =
  result = $atk_object_get_object_locale(cast[ptr Object00](self.impl))

proc atk_object_get_parent(self: ptr Object00): ptr Object00 {.
    importc, libprag.}

proc getParent*(self: Object): Object =
  let gobj = atk_object_get_parent(cast[ptr Object00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parent*(self: Object): Object =
  let gobj = atk_object_get_parent(cast[ptr Object00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_object_initialize(self: ptr Object00; data: pointer) {.
    importc, libprag.}

proc initialize*(self: Object; data: pointer) =
  atk_object_initialize(cast[ptr Object00](self.impl), data)

proc atk_object_notify_state_change(self: ptr Object00; state: uint64; value: gboolean) {.
    importc, libprag.}

proc notifyStateChange*(self: Object; state: uint64; value: bool) =
  atk_object_notify_state_change(cast[ptr Object00](self.impl), state, gboolean(value))

proc atk_object_peek_parent(self: ptr Object00): ptr Object00 {.
    importc, libprag.}

proc peekParent*(self: Object): Object =
  let gobj = atk_object_peek_parent(cast[ptr Object00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_object_ref_accessible_child(self: ptr Object00; i: int32): ptr Object00 {.
    importc, libprag.}

proc refAccessibleChild*(self: Object; i: int): Object =
  let gobj = atk_object_ref_accessible_child(cast[ptr Object00](self.impl), int32(i))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_object_remove_property_change_handler(self: ptr Object00; handlerId: uint32) {.
    importc, libprag.}

proc removePropertyChangeHandler*(self: Object; handlerId: int) =
  atk_object_remove_property_change_handler(cast[ptr Object00](self.impl), uint32(handlerId))

proc atk_object_set_accessible_id(self: ptr Object00; name: cstring) {.
    importc, libprag.}

proc setAccessibleId*(self: Object; name: cstring) =
  atk_object_set_accessible_id(cast[ptr Object00](self.impl), name)

proc `accessibleId=`*(self: Object; name: cstring) =
  atk_object_set_accessible_id(cast[ptr Object00](self.impl), name)

proc atk_object_set_description(self: ptr Object00; description: cstring) {.
    importc, libprag.}

proc setDescription*(self: Object; description: cstring) =
  atk_object_set_description(cast[ptr Object00](self.impl), description)

proc `description=`*(self: Object; description: cstring) =
  atk_object_set_description(cast[ptr Object00](self.impl), description)

proc atk_object_set_name(self: ptr Object00; name: cstring) {.
    importc, libprag.}

proc setName*(self: Object; name: cstring) =
  atk_object_set_name(cast[ptr Object00](self.impl), name)

proc `name=`*(self: Object; name: cstring) =
  atk_object_set_name(cast[ptr Object00](self.impl), name)

proc atk_object_set_parent(self: ptr Object00; parent: ptr Object00) {.
    importc, libprag.}

proc setParent*(self: Object; parent: Object) =
  atk_object_set_parent(cast[ptr Object00](self.impl), cast[ptr Object00](parent.impl))

proc `parent=`*(self: Object; parent: Object) =
  atk_object_set_parent(cast[ptr Object00](self.impl), cast[ptr Object00](parent.impl))

type
  NoOpObject* = ref object of Object
  NoOpObject00* = object of Object00

proc atk_no_op_object_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NoOpObject()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_no_op_object_new(obj: ptr gobject.Object00): ptr NoOpObject00 {.
    importc, libprag.}

proc newNoOpObject*(obj: gobject.Object): NoOpObject =
  let gobj = atk_no_op_object_new(cast[ptr gobject.Object00](obj.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNoOpObject*(tdesc: typedesc; obj: gobject.Object): tdesc =
  assert(result is NoOpObject)
  let gobj = atk_no_op_object_new(cast[ptr gobject.Object00](obj.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNoOpObject*[T](result: var T; obj: gobject.Object) {.deprecated.} =
  assert(result is NoOpObject)
  let gobj = atk_no_op_object_new(cast[ptr gobject.Object00](obj.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Hyperlink* = ref object of gobject.Object
  Hyperlink00* = object of gobject.Object00

proc atk_hyperlink_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Hyperlink()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scLinkActivated*(self: Hyperlink;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "link-activated", cast[GCallback](p), xdata, nil, cf)

proc atk_hyperlink_get_end_index(self: ptr Hyperlink00): int32 {.
    importc, libprag.}

proc getEndIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_end_index(cast[ptr Hyperlink00](self.impl)))

proc endIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_end_index(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_get_n_anchors(self: ptr Hyperlink00): int32 {.
    importc, libprag.}

proc getNAnchors*(self: Hyperlink): int =
  int(atk_hyperlink_get_n_anchors(cast[ptr Hyperlink00](self.impl)))

proc nAnchors*(self: Hyperlink): int =
  int(atk_hyperlink_get_n_anchors(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_get_object(self: ptr Hyperlink00; i: int32): ptr Object00 {.
    importc, libprag.}

proc getObject*(self: Hyperlink; i: int): Object =
  let gobj = atk_hyperlink_get_object(cast[ptr Hyperlink00](self.impl), int32(i))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_hyperlink_get_start_index(self: ptr Hyperlink00): int32 {.
    importc, libprag.}

proc getStartIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_start_index(cast[ptr Hyperlink00](self.impl)))

proc startIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_start_index(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_get_uri(self: ptr Hyperlink00; i: int32): cstring {.
    importc, libprag.}

proc getUri*(self: Hyperlink; i: int): string =
  let resul0 = atk_hyperlink_get_uri(cast[ptr Hyperlink00](self.impl), int32(i))
  result = $resul0
  cogfree(resul0)

proc atk_hyperlink_is_inline(self: ptr Hyperlink00): gboolean {.
    importc, libprag.}

proc isInline*(self: Hyperlink): bool =
  toBool(atk_hyperlink_is_inline(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_is_selected_link(self: ptr Hyperlink00): gboolean {.
    importc, libprag.}

proc isSelectedLink*(self: Hyperlink): bool =
  toBool(atk_hyperlink_is_selected_link(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_is_valid(self: ptr Hyperlink00): gboolean {.
    importc, libprag.}

proc isValid*(self: Hyperlink): bool =
  toBool(atk_hyperlink_is_valid(cast[ptr Hyperlink00](self.impl)))

proc atk_action_do_action(self: ptr Action00; i: int32): gboolean {.
    importc, libprag.}

proc doAction*(self: Action | NoOpObject | Hyperlink; i: int): bool =
  toBool(atk_action_do_action(cast[ptr Action00](self.impl), int32(i)))

proc atk_action_get_description(self: ptr Action00; i: int32): cstring {.
    importc, libprag.}

proc getDescription*(self: Action | NoOpObject | Hyperlink; i: int): string =
  let resul0 = atk_action_get_description(cast[ptr Action00](self.impl), int32(i))
  if resul0.isNil:
    return
  result = $resul0

proc atk_action_get_keybinding(self: ptr Action00; i: int32): cstring {.
    importc, libprag.}

proc getKeybinding*(self: Action | NoOpObject | Hyperlink; i: int): string =
  let resul0 = atk_action_get_keybinding(cast[ptr Action00](self.impl), int32(i))
  if resul0.isNil:
    return
  result = $resul0

proc atk_action_get_localized_name(self: ptr Action00; i: int32): cstring {.
    importc, libprag.}

proc getLocalizedName*(self: Action | NoOpObject | Hyperlink;
    i: int): string =
  let resul0 = atk_action_get_localized_name(cast[ptr Action00](self.impl), int32(i))
  if resul0.isNil:
    return
  result = $resul0

proc atk_action_get_n_actions(self: ptr Action00): int32 {.
    importc, libprag.}

proc getNActions*(self: Action | NoOpObject | Hyperlink): int =
  int(atk_action_get_n_actions(cast[ptr Action00](self.impl)))

proc nActions*(self: Action | NoOpObject | Hyperlink): int =
  int(atk_action_get_n_actions(cast[ptr Action00](self.impl)))

proc atk_action_get_name(self: ptr Action00; i: int32): cstring {.
    importc, libprag.}

proc getName*(self: Action | NoOpObject | Hyperlink; i: int): string =
  let resul0 = atk_action_get_name(cast[ptr Action00](self.impl), int32(i))
  if resul0.isNil:
    return
  result = $resul0

proc atk_action_set_description(self: ptr Action00; i: int32; desc: cstring): gboolean {.
    importc, libprag.}

proc setDescription*(self: Action | NoOpObject | Hyperlink; i: int;
    desc: cstring): bool =
  toBool(atk_action_set_description(cast[ptr Action00](self.impl), int32(i), desc))

type
  Layer* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    background = 1
    canvas = 2
    widget = 3
    mdi = 4
    popup = 5
    overlay = 6
    window = 7

proc atk_object_get_layer(self: ptr Object00): Layer {.
    importc, libprag.}

proc getLayer*(self: Object): Layer =
  atk_object_get_layer(cast[ptr Object00](self.impl))

proc layer*(self: Object): Layer =
  atk_object_get_layer(cast[ptr Object00](self.impl))

type
  RelationSet* = ref object of gobject.Object
  RelationSet00* = object of gobject.Object00

proc atk_relation_set_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RelationSet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_relation_set_new(): ptr RelationSet00 {.
    importc, libprag.}

proc newRelationSet*(): RelationSet =
  let gobj = atk_relation_set_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRelationSet*(tdesc: typedesc): tdesc =
  assert(result is RelationSet)
  let gobj = atk_relation_set_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRelationSet*[T](result: var T) {.deprecated.} =
  assert(result is RelationSet)
  let gobj = atk_relation_set_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_relation_set_get_n_relations(self: ptr RelationSet00): int32 {.
    importc, libprag.}

proc getNRelations*(self: RelationSet): int =
  int(atk_relation_set_get_n_relations(cast[ptr RelationSet00](self.impl)))

proc nRelations*(self: RelationSet): int =
  int(atk_relation_set_get_n_relations(cast[ptr RelationSet00](self.impl)))

proc atk_object_ref_relation_set(self: ptr Object00): ptr RelationSet00 {.
    importc, libprag.}

proc refRelationSet*(self: Object): RelationSet =
  let gobj = atk_object_ref_relation_set(cast[ptr Object00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Relation* = ref object of gobject.Object
  Relation00* = object of gobject.Object00

proc atk_relation_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Relation()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_relation_add_target(self: ptr Relation00; target: ptr Object00) {.
    importc, libprag.}

proc addTarget*(self: Relation; target: Object) =
  atk_relation_add_target(cast[ptr Relation00](self.impl), cast[ptr Object00](target.impl))

proc atk_relation_get_target(self: ptr Relation00): ptr PtrArray00 {.
    importc, libprag.}

proc getTarget*(self: Relation): ptr PtrArray00 =
  atk_relation_get_target(cast[ptr Relation00](self.impl))

proc target*(self: Relation): ptr PtrArray00 =
  atk_relation_get_target(cast[ptr Relation00](self.impl))

proc atk_relation_remove_target(self: ptr Relation00; target: ptr Object00): gboolean {.
    importc, libprag.}

proc removeTarget*(self: Relation; target: Object): bool =
  toBool(atk_relation_remove_target(cast[ptr Relation00](self.impl), cast[ptr Object00](target.impl)))

proc atk_relation_set_add(self: ptr RelationSet00; relation: ptr Relation00) {.
    importc, libprag.}

proc add*(self: RelationSet; relation: Relation) =
  atk_relation_set_add(cast[ptr RelationSet00](self.impl), cast[ptr Relation00](relation.impl))

proc atk_relation_set_get_relation(self: ptr RelationSet00; i: int32): ptr Relation00 {.
    importc, libprag.}

proc getRelation*(self: RelationSet; i: int): Relation =
  let gobj = atk_relation_set_get_relation(cast[ptr RelationSet00](self.impl), int32(i))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_relation_set_remove(self: ptr RelationSet00; relation: ptr Relation00) {.
    importc, libprag.}

proc remove*(self: RelationSet; relation: Relation) =
  atk_relation_set_remove(cast[ptr RelationSet00](self.impl), cast[ptr Relation00](relation.impl))

type
  StateSet* = ref object of gobject.Object
  StateSet00* = object of gobject.Object00

proc atk_state_set_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StateSet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_state_set_new(): ptr StateSet00 {.
    importc, libprag.}

proc newStateSet*(): StateSet =
  let gobj = atk_state_set_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStateSet*(tdesc: typedesc): tdesc =
  assert(result is StateSet)
  let gobj = atk_state_set_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStateSet*[T](result: var T) {.deprecated.} =
  assert(result is StateSet)
  let gobj = atk_state_set_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_state_set_and_sets(self: ptr StateSet00; compareSet: ptr StateSet00): ptr StateSet00 {.
    importc, libprag.}

proc andSets*(self: StateSet; compareSet: StateSet): StateSet =
  let gobj = atk_state_set_and_sets(cast[ptr StateSet00](self.impl), cast[ptr StateSet00](compareSet.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_state_set_clear_states(self: ptr StateSet00) {.
    importc, libprag.}

proc clearStates*(self: StateSet) =
  atk_state_set_clear_states(cast[ptr StateSet00](self.impl))

proc atk_state_set_is_empty(self: ptr StateSet00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: StateSet): bool =
  toBool(atk_state_set_is_empty(cast[ptr StateSet00](self.impl)))

proc atk_state_set_or_sets(self: ptr StateSet00; compareSet: ptr StateSet00): ptr StateSet00 {.
    importc, libprag.}

proc orSets*(self: StateSet; compareSet: StateSet): StateSet =
  let gobj = atk_state_set_or_sets(cast[ptr StateSet00](self.impl), cast[ptr StateSet00](compareSet.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_state_set_xor_sets(self: ptr StateSet00; compareSet: ptr StateSet00): ptr StateSet00 {.
    importc, libprag.}

proc xorSets*(self: StateSet; compareSet: StateSet): StateSet =
  let gobj = atk_state_set_xor_sets(cast[ptr StateSet00](self.impl), cast[ptr StateSet00](compareSet.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_object_ref_state_set(self: ptr Object00): ptr StateSet00 {.
    importc, libprag.}

proc refStateSet*(self: Object): StateSet =
  let gobj = atk_object_ref_state_set(cast[ptr Object00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  StateType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    active = 1
    armed = 2
    busy = 3
    checked = 4
    defunct = 5
    editable = 6
    enabled = 7
    expandable = 8
    expanded = 9
    focusable = 10
    focused = 11
    horizontal = 12
    iconified = 13
    modal = 14
    multiLine = 15
    multiselectable = 16
    opaque = 17
    pressed = 18
    resizable = 19
    selectable = 20
    selected = 21
    sensitive = 22
    showing = 23
    singleLine = 24
    stale = 25
    transient = 26
    vertical = 27
    visible = 28
    managesDescendants = 29
    indeterminate = 30
    truncated = 31
    required = 32
    invalidEntry = 33
    supportsAutocompletion = 34
    selectableText = 35
    default = 36
    animated = 37
    visited = 38
    checkable = 39
    hasPopup = 40
    hasTooltip = 41
    readOnly = 42
    lastDefined = 43

proc stateTypeForName*(name: cstring): StateType {.
    importc: "atk_state_type_for_name", libprag.}

proc atk_state_type_get_name(`type`: StateType): cstring {.
    importc, libprag.}

proc getName*(`type`: StateType): string =
  result = $atk_state_type_get_name(`type`)

proc name*(`type`: StateType): string =
  result = $atk_state_type_get_name(`type`)

proc registerStateType*(name: cstring): StateType {.
    importc: "atk_state_type_register", libprag.}

proc atk_state_set_add_state(self: ptr StateSet00; `type`: StateType): gboolean {.
    importc, libprag.}

proc addState*(self: StateSet; `type`: StateType): bool =
  toBool(atk_state_set_add_state(cast[ptr StateSet00](self.impl), `type`))

proc atk_state_set_add_states(self: ptr StateSet00; types: ptr StateType;
    nTypes: int32) {.
    importc, libprag.}

proc addStates*(self: StateSet; types: ptr StateType; nTypes: int) =
  atk_state_set_add_states(cast[ptr StateSet00](self.impl), types, int32(nTypes))

proc atk_state_set_contains_state(self: ptr StateSet00; `type`: StateType): gboolean {.
    importc, libprag.}

proc containsState*(self: StateSet; `type`: StateType): bool =
  toBool(atk_state_set_contains_state(cast[ptr StateSet00](self.impl), `type`))

proc atk_state_set_contains_states(self: ptr StateSet00; types: ptr StateType;
    nTypes: int32): gboolean {.
    importc, libprag.}

proc containsStates*(self: StateSet; types: ptr StateType;
    nTypes: int): bool =
  toBool(atk_state_set_contains_states(cast[ptr StateSet00](self.impl), types, int32(nTypes)))

proc atk_state_set_remove_state(self: ptr StateSet00; `type`: StateType): gboolean {.
    importc, libprag.}

proc removeState*(self: StateSet; `type`: StateType): bool =
  toBool(atk_state_set_remove_state(cast[ptr StateSet00](self.impl), `type`))

type
  RelationType* {.size: sizeof(cint), pure.} = enum
    null = 0
    controlledBy = 1
    controllerFor = 2
    labelFor = 3
    labelledBy = 4
    memberOf = 5
    nodeChildOf = 6
    flowsTo = 7
    flowsFrom = 8
    subwindowOf = 9
    embeds = 10
    embeddedBy = 11
    popupFor = 12
    parentWindowOf = 13
    describedBy = 14
    descriptionFor = 15
    nodeParentOf = 16
    details = 17
    detailsFor = 18
    errorMessage = 19
    errorFor = 20
    lastDefined = 21

proc relationTypeForName*(name: cstring): RelationType {.
    importc: "atk_relation_type_for_name", libprag.}

proc atk_relation_type_get_name(`type`: RelationType): cstring {.
    importc, libprag.}

proc getName*(`type`: RelationType): string =
  result = $atk_relation_type_get_name(`type`)

proc name*(`type`: RelationType): string =
  result = $atk_relation_type_get_name(`type`)

proc registerRelationType*(name: cstring): RelationType {.
    importc: "atk_relation_type_register", libprag.}

proc atk_object_add_relationship(self: ptr Object00; relationship: RelationType;
    target: ptr Object00): gboolean {.
    importc, libprag.}

proc addRelationship*(self: Object; relationship: RelationType;
    target: Object): bool =
  toBool(atk_object_add_relationship(cast[ptr Object00](self.impl), relationship, cast[ptr Object00](target.impl)))

proc atk_object_remove_relationship(self: ptr Object00; relationship: RelationType;
    target: ptr Object00): gboolean {.
    importc, libprag.}

proc removeRelationship*(self: Object; relationship: RelationType;
    target: Object): bool =
  toBool(atk_object_remove_relationship(cast[ptr Object00](self.impl), relationship, cast[ptr Object00](target.impl)))

proc atk_relation_set_add_relation_by_type(self: ptr RelationSet00; relationship: RelationType;
    target: ptr Object00) {.
    importc, libprag.}

proc addRelationByType*(self: RelationSet; relationship: RelationType;
    target: Object) =
  atk_relation_set_add_relation_by_type(cast[ptr RelationSet00](self.impl), relationship, cast[ptr Object00](target.impl))

proc atk_relation_set_contains(self: ptr RelationSet00; relationship: RelationType): gboolean {.
    importc, libprag.}

proc contains*(self: RelationSet; relationship: RelationType): bool =
  toBool(atk_relation_set_contains(cast[ptr RelationSet00](self.impl), relationship))

proc atk_relation_set_contains_target(self: ptr RelationSet00; relationship: RelationType;
    target: ptr Object00): gboolean {.
    importc, libprag.}

proc containsTarget*(self: RelationSet; relationship: RelationType;
    target: Object): bool =
  toBool(atk_relation_set_contains_target(cast[ptr RelationSet00](self.impl), relationship, cast[ptr Object00](target.impl)))

proc atk_relation_set_get_relation_by_type(self: ptr RelationSet00; relationship: RelationType): ptr Relation00 {.
    importc, libprag.}

proc getRelationByType*(self: RelationSet; relationship: RelationType): Relation =
  let gobj = atk_relation_set_get_relation_by_type(cast[ptr RelationSet00](self.impl), relationship)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_relation_new(targets: ptr ptr Object00; nTargets: int32; relationship: RelationType): ptr Relation00 {.
    importc, libprag.}

proc newRelation*(targets: ptr ptr Object00; nTargets: int; relationship: RelationType): Relation =
  let gobj = atk_relation_new(targets, int32(nTargets), relationship)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRelation*(tdesc: typedesc; targets: ptr ptr Object00; nTargets: int; relationship: RelationType): tdesc =
  assert(result is Relation)
  let gobj = atk_relation_new(targets, int32(nTargets), relationship)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRelation*[T](result: var T; targets: ptr ptr Object00; nTargets: int; relationship: RelationType) {.deprecated.} =
  assert(result is Relation)
  let gobj = atk_relation_new(targets, int32(nTargets), relationship)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_relation_get_relation_type(self: ptr Relation00): RelationType {.
    importc, libprag.}

proc getRelationType*(self: Relation): RelationType =
  atk_relation_get_relation_type(cast[ptr Relation00](self.impl))

proc relationType*(self: Relation): RelationType =
  atk_relation_get_relation_type(cast[ptr Relation00](self.impl))

type
  Role* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    acceleratorLabel = 1
    alert = 2
    animation = 3
    arrow = 4
    calendar = 5
    canvas = 6
    checkBox = 7
    checkMenuItem = 8
    colorChooser = 9
    columnHeader = 10
    comboBox = 11
    dateEditor = 12
    desktopIcon = 13
    desktopFrame = 14
    dial = 15
    dialog = 16
    directoryPane = 17
    drawingArea = 18
    fileChooser = 19
    filler = 20
    fontChooser = 21
    frame = 22
    glassPane = 23
    htmlContainer = 24
    icon = 25
    image = 26
    internalFrame = 27
    label = 28
    layeredPane = 29
    list = 30
    listItem = 31
    menu = 32
    menuBar = 33
    menuItem = 34
    optionPane = 35
    pageTab = 36
    pageTabList = 37
    panel = 38
    passwordText = 39
    popupMenu = 40
    progressBar = 41
    pushButton = 42
    radioButton = 43
    radioMenuItem = 44
    rootPane = 45
    rowHeader = 46
    scrollBar = 47
    scrollPane = 48
    separator = 49
    slider = 50
    splitPane = 51
    spinButton = 52
    statusbar = 53
    table = 54
    tableCell = 55
    tableColumnHeader = 56
    tableRowHeader = 57
    tearOffMenuItem = 58
    terminal = 59
    text = 60
    toggleButton = 61
    toolBar = 62
    toolTip = 63
    tree = 64
    treeTable = 65
    unknown = 66
    viewport = 67
    window = 68
    header = 69
    footer = 70
    paragraph = 71
    ruler = 72
    application = 73
    autocomplete = 74
    editBar = 75
    embedded = 76
    entry = 77
    chart = 78
    caption = 79
    documentFrame = 80
    heading = 81
    page = 82
    section = 83
    redundantObject = 84
    form = 85
    link = 86
    inputMethodWindow = 87
    tableRow = 88
    treeItem = 89
    documentSpreadsheet = 90
    documentPresentation = 91
    documentText = 92
    documentWeb = 93
    documentEmail = 94
    comment = 95
    listBox = 96
    grouping = 97
    imageMap = 98
    notification = 99
    infoBar = 100
    levelBar = 101
    titleBar = 102
    blockQuote = 103
    audio = 104
    video = 105
    definition = 106
    article = 107
    landmark = 108
    log = 109
    marquee = 110
    math = 111
    rating = 112
    timer = 113
    descriptionList = 114
    descriptionTerm = 115
    descriptionValue = 116
    `static` = 117
    mathFraction = 118
    mathRoot = 119
    subscript = 120
    superscript = 121
    footnote = 122
    contentDeletion = 123
    contentInsertion = 124
    mark = 125
    suggestion = 126
    lastDefined = 127

proc roleForName*(name: cstring): Role {.
    importc: "atk_role_for_name", libprag.}

proc atk_role_get_localized_name(role: Role): cstring {.
    importc, libprag.}

proc getLocalizedName*(role: Role): string =
  result = $atk_role_get_localized_name(role)

proc localizedName*(role: Role): string =
  result = $atk_role_get_localized_name(role)

proc atk_role_get_name(role: Role): cstring {.
    importc, libprag.}

proc getName*(role: Role): string =
  result = $atk_role_get_name(role)

proc name*(role: Role): string =
  result = $atk_role_get_name(role)

proc registerAtkRole*(name: cstring): Role {.
    importc: "atk_role_register", libprag.}

proc atk_object_get_role(self: ptr Object00): Role {.
    importc, libprag.}

proc getRole*(self: Object): Role =
  atk_object_get_role(cast[ptr Object00](self.impl))

proc role*(self: Object): Role =
  atk_object_get_role(cast[ptr Object00](self.impl))

proc atk_object_set_role(self: ptr Object00; role: Role) {.
    importc, libprag.}

proc setRole*(self: Object; role: Role) =
  atk_object_set_role(cast[ptr Object00](self.impl), role)

proc `role=`*(self: Object; role: Role) =
  atk_object_set_role(cast[ptr Object00](self.impl), role)

type
  Attribute00* {.pure.} = object
  Attribute* = ref object
    impl*: ptr Attribute00
    ignoreFinalizer*: bool

proc setFree*(attribSet: ptr glib.SList) {.
    importc: "atk_attribute_set_free", libprag.}

const BINARY_AGE* = 23610'i32

type
  Rectangle* {.pure, byRef.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32

proc atk_rectangle_get_type*(): GType {.importc, libprag.}

type
  Plug* = ref object of Object
  Plug00* = object of Object00

proc atk_plug_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Plug()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_plug_new(): ptr Plug00 {.
    importc, libprag.}

proc newPlug*(): Plug =
  let gobj = atk_plug_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPlug*(tdesc: typedesc): tdesc =
  assert(result is Plug)
  let gobj = atk_plug_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPlug*[T](result: var T) {.deprecated.} =
  assert(result is Plug)
  let gobj = atk_plug_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_plug_get_id(self: ptr Plug00): cstring {.
    importc, libprag.}

proc getId*(self: Plug): string =
  let resul0 = atk_plug_get_id(cast[ptr Plug00](self.impl))
  result = $resul0
  cogfree(resul0)

proc id*(self: Plug): string =
  let resul0 = atk_plug_get_id(cast[ptr Plug00](self.impl))
  result = $resul0
  cogfree(resul0)

proc atk_plug_set_child(self: ptr Plug00; child: ptr Object00) {.
    importc, libprag.}

proc setChild*(self: Plug; child: Object) =
  atk_plug_set_child(cast[ptr Plug00](self.impl), cast[ptr Object00](child.impl))

proc `child=`*(self: Plug; child: Object) =
  atk_plug_set_child(cast[ptr Plug00](self.impl), cast[ptr Object00](child.impl))

type
  Socket* = ref object of Object
  Socket00* = object of Object00

proc atk_socket_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Socket()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_socket_new(): ptr Socket00 {.
    importc, libprag.}

proc newSocket*(): Socket =
  let gobj = atk_socket_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSocket*(tdesc: typedesc): tdesc =
  assert(result is Socket)
  let gobj = atk_socket_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocket*[T](result: var T) {.deprecated.} =
  assert(result is Socket)
  let gobj = atk_socket_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_socket_embed(self: ptr Socket00; plugId: cstring) {.
    importc, libprag.}

proc embed*(self: Socket; plugId: cstring) =
  atk_socket_embed(cast[ptr Socket00](self.impl), plugId)

proc atk_socket_is_occupied(self: ptr Socket00): gboolean {.
    importc, libprag.}

proc isOccupied*(self: Socket): bool =
  toBool(atk_socket_is_occupied(cast[ptr Socket00](self.impl)))

type
  Component00* = object of gobject.Object00
  Component* = ref object of gobject.Object

proc scBoundsChanged*(self: Component | NoOpObject | Plug | Socket;  p: proc (self: ptr Component00; arg1: Rectangle; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "bounds-changed", cast[GCallback](p), xdata, nil, cf)

proc atk_component_get_alpha(self: ptr Component00): cdouble {.
    importc, libprag.}

proc getAlpha*(self: Component | NoOpObject | Plug | Socket): cdouble =
  atk_component_get_alpha(cast[ptr Component00](self.impl))

proc alpha*(self: Component | NoOpObject | Plug | Socket): cdouble =
  atk_component_get_alpha(cast[ptr Component00](self.impl))

proc atk_component_get_layer(self: ptr Component00): Layer {.
    importc, libprag.}

proc getLayer*(self: Component | NoOpObject | Plug | Socket): Layer =
  atk_component_get_layer(cast[ptr Component00](self.impl))

proc layer*(self: Component | NoOpObject | Plug | Socket): Layer =
  atk_component_get_layer(cast[ptr Component00](self.impl))

proc atk_component_get_mdi_zorder(self: ptr Component00): int32 {.
    importc, libprag.}

proc getMdiZorder*(self: Component | NoOpObject | Plug | Socket): int =
  int(atk_component_get_mdi_zorder(cast[ptr Component00](self.impl)))

proc mdiZorder*(self: Component | NoOpObject | Plug | Socket): int =
  int(atk_component_get_mdi_zorder(cast[ptr Component00](self.impl)))

proc atk_component_get_size(self: ptr Component00; width: var int32; height: var int32) {.
    importc, libprag.}

proc getSize*(self: Component | NoOpObject | Plug | Socket;
    width: var int = cast[var int](nil); height: var int = cast[var int](nil)) =
  var width_00: int32
  var height_00: int32
  atk_component_get_size(cast[ptr Component00](self.impl), width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc atk_component_grab_focus(self: ptr Component00): gboolean {.
    importc, libprag.}

proc grabFocus*(self: Component | NoOpObject | Plug | Socket): bool =
  toBool(atk_component_grab_focus(cast[ptr Component00](self.impl)))

proc atk_component_remove_focus_handler(self: ptr Component00; handlerId: uint32) {.
    importc, libprag.}

proc removeFocusHandler*(self: Component | NoOpObject | Plug | Socket;
    handlerId: int) =
  atk_component_remove_focus_handler(cast[ptr Component00](self.impl), uint32(handlerId))

proc atk_component_set_size(self: ptr Component00; width: int32; height: int32): gboolean {.
    importc, libprag.}

proc setSize*(self: Component | NoOpObject | Plug | Socket;
    width: int; height: int): bool =
  toBool(atk_component_set_size(cast[ptr Component00](self.impl), int32(width), int32(height)))

type
  ScrollType* {.size: sizeof(cint), pure.} = enum
    topLeft = 0
    bottomRight = 1
    topEdge = 2
    bottomEdge = 3
    leftEdge = 4
    rightEdge = 5
    anywhere = 6

proc atk_component_scroll_to(self: ptr Component00; `type`: ScrollType): gboolean {.
    importc, libprag.}

proc scrollTo*(self: Component | NoOpObject | Plug | Socket;
    `type`: ScrollType): bool =
  toBool(atk_component_scroll_to(cast[ptr Component00](self.impl), `type`))

type
  CoordType* {.size: sizeof(cint), pure.} = enum
    screen = 0
    window = 1
    parent = 2

proc atk_component_contains(self: ptr Component00; x: int32; y: int32; coordType: CoordType): gboolean {.
    importc, libprag.}

proc contains*(self: Component | NoOpObject | Plug | Socket;
    x: int; y: int; coordType: CoordType): bool =
  toBool(atk_component_contains(cast[ptr Component00](self.impl), int32(x), int32(y), coordType))

proc atk_component_get_extents(self: ptr Component00; x: var int32; y: var int32;
    width: var int32; height: var int32; coordType: CoordType) {.
    importc, libprag.}

proc getExtents*(self: Component | NoOpObject | Plug | Socket;
    x: var int = cast[var int](nil); y: var int = cast[var int](nil); width: var int = cast[var int](nil);
    height: var int = cast[var int](nil); coordType: CoordType) =
  var width_00: int32
  var y_00: int32
  var x_00: int32
  var height_00: int32
  atk_component_get_extents(cast[ptr Component00](self.impl), x_00, y_00, width_00, height_00, coordType)
  if width.addr != nil:
    width = int(width_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)
  if height.addr != nil:
    height = int(height_00)

proc atk_component_get_position(self: ptr Component00; x: var int32; y: var int32;
    coordType: CoordType) {.
    importc, libprag.}

proc getPosition*(self: Component | NoOpObject | Plug | Socket;
    x: var int = cast[var int](nil); y: var int = cast[var int](nil); coordType: CoordType) =
  var y_00: int32
  var x_00: int32
  atk_component_get_position(cast[ptr Component00](self.impl), x_00, y_00, coordType)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc atk_component_ref_accessible_at_point(self: ptr Component00; x: int32;
    y: int32; coordType: CoordType): ptr Object00 {.
    importc, libprag.}

proc refAccessibleAtPoint*(self: Component | NoOpObject | Plug | Socket;
    x: int; y: int; coordType: CoordType): Object =
  let gobj = atk_component_ref_accessible_at_point(cast[ptr Component00](self.impl), int32(x), int32(y), coordType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_component_scroll_to_point(self: ptr Component00; coords: CoordType;
    x: int32; y: int32): gboolean {.
    importc, libprag.}

proc scrollToPoint*(self: Component | NoOpObject | Plug | Socket;
    coords: CoordType; x: int; y: int): bool =
  toBool(atk_component_scroll_to_point(cast[ptr Component00](self.impl), coords, int32(x), int32(y)))

proc atk_component_set_extents(self: ptr Component00; x: int32; y: int32;
    width: int32; height: int32; coordType: CoordType): gboolean {.
    importc, libprag.}

proc setExtents*(self: Component | NoOpObject | Plug | Socket;
    x: int; y: int; width: int; height: int; coordType: CoordType): bool =
  toBool(atk_component_set_extents(cast[ptr Component00](self.impl), int32(x), int32(y), int32(width), int32(height), coordType))

proc atk_component_set_position(self: ptr Component00; x: int32; y: int32;
    coordType: CoordType): gboolean {.
    importc, libprag.}

proc setPosition*(self: Component | NoOpObject | Plug | Socket;
    x: int; y: int; coordType: CoordType): bool =
  toBool(atk_component_set_position(cast[ptr Component00](self.impl), int32(x), int32(y), coordType))

type
  Document00* = object of gobject.Object00
  Document* = ref object of gobject.Object

proc scLoadComplete*(self: Document | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "load-complete", cast[GCallback](p), xdata, nil, cf)

proc scLoadStopped*(self: Document | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "load-stopped", cast[GCallback](p), xdata, nil, cf)

proc scPageChanged*(self: Document | NoOpObject;  p: proc (self: ptr Document00; pageNumber: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "page-changed", cast[GCallback](p), xdata, nil, cf)

proc scReload*(self: Document | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "reload", cast[GCallback](p), xdata, nil, cf)

proc atk_document_get_attribute_value(self: ptr Document00; attributeName: cstring): cstring {.
    importc, libprag.}

proc getAttributeValue*(self: Document | NoOpObject; attributeName: cstring): string =
  let resul0 = atk_document_get_attribute_value(cast[ptr Document00](self.impl), attributeName)
  if resul0.isNil:
    return
  result = $resul0

proc atk_document_get_attributes(self: ptr Document00): ptr glib.SList {.
    importc, libprag.}

proc getAttributes*(self: Document | NoOpObject): seq[pointer] =
  discard

proc attributes*(self: Document | NoOpObject): seq[pointer] =
  discard

proc atk_document_get_current_page_number(self: ptr Document00): int32 {.
    importc, libprag.}

proc getCurrentPageNumber*(self: Document | NoOpObject): int =
  int(atk_document_get_current_page_number(cast[ptr Document00](self.impl)))

proc currentPageNumber*(self: Document | NoOpObject): int =
  int(atk_document_get_current_page_number(cast[ptr Document00](self.impl)))

proc atk_document_get_document(self: ptr Document00): pointer {.
    importc, libprag.}

proc getDocument*(self: Document | NoOpObject): pointer =
  atk_document_get_document(cast[ptr Document00](self.impl))

proc atk_document_get_document_type(self: ptr Document00): cstring {.
    importc, libprag.}

proc getDocumentType*(self: Document | NoOpObject): string =
  result = $atk_document_get_document_type(cast[ptr Document00](self.impl))

proc documentType*(self: Document | NoOpObject): string =
  result = $atk_document_get_document_type(cast[ptr Document00](self.impl))

proc atk_document_get_locale(self: ptr Document00): cstring {.
    importc, libprag.}

proc getLocale*(self: Document | NoOpObject): string =
  result = $atk_document_get_locale(cast[ptr Document00](self.impl))

proc locale*(self: Document | NoOpObject): string =
  result = $atk_document_get_locale(cast[ptr Document00](self.impl))

proc atk_document_get_page_count(self: ptr Document00): int32 {.
    importc, libprag.}

proc getPageCount*(self: Document | NoOpObject): int =
  int(atk_document_get_page_count(cast[ptr Document00](self.impl)))

proc pageCount*(self: Document | NoOpObject): int =
  int(atk_document_get_page_count(cast[ptr Document00](self.impl)))

proc atk_document_set_attribute_value(self: ptr Document00; attributeName: cstring;
    attributeValue: cstring): gboolean {.
    importc, libprag.}

proc setAttributeValue*(self: Document | NoOpObject; attributeName: cstring;
    attributeValue: cstring): bool =
  toBool(atk_document_set_attribute_value(cast[ptr Document00](self.impl), attributeName, attributeValue))

type
  EditableText00* = object of gobject.Object00
  EditableText* = ref object of gobject.Object

proc atk_editable_text_copy_text(self: ptr EditableText00; startPos: int32;
    endPos: int32) {.
    importc, libprag.}

proc copyText*(self: EditableText | NoOpObject; startPos: int;
    endPos: int) =
  atk_editable_text_copy_text(cast[ptr EditableText00](self.impl), int32(startPos), int32(endPos))

proc atk_editable_text_cut_text(self: ptr EditableText00; startPos: int32;
    endPos: int32) {.
    importc, libprag.}

proc cutText*(self: EditableText | NoOpObject; startPos: int;
    endPos: int) =
  atk_editable_text_cut_text(cast[ptr EditableText00](self.impl), int32(startPos), int32(endPos))

proc atk_editable_text_delete_text(self: ptr EditableText00; startPos: int32;
    endPos: int32) {.
    importc, libprag.}

proc deleteText*(self: EditableText | NoOpObject; startPos: int;
    endPos: int) =
  atk_editable_text_delete_text(cast[ptr EditableText00](self.impl), int32(startPos), int32(endPos))

proc atk_editable_text_insert_text(self: ptr EditableText00; string: cstring;
    length: int32; position: ptr int32) {.
    importc, libprag.}

proc insertText*(self: EditableText | NoOpObject; string: cstring;
    length: int; position: ptr int32) =
  atk_editable_text_insert_text(cast[ptr EditableText00](self.impl), string, int32(length), position)

proc atk_editable_text_paste_text(self: ptr EditableText00; position: int32) {.
    importc, libprag.}

proc pasteText*(self: EditableText | NoOpObject; position: int) =
  atk_editable_text_paste_text(cast[ptr EditableText00](self.impl), int32(position))

proc atk_editable_text_set_run_attributes(self: ptr EditableText00; attribSet: ptr glib.SList;
    startOffset: int32; endOffset: int32): gboolean {.
    importc, libprag.}

proc setRunAttributes*(self: EditableText | NoOpObject;
    attribSet: seq[pointer]; startOffset: int; endOffset: int): bool =
  var tempResGL = seq2GSList(attribSet)
  result = toBool(atk_editable_text_set_run_attributes(cast[ptr EditableText00](self.impl), tempResGL, int32(startOffset), int32(endOffset)))
  g_slist_free(tempResGL)

proc atk_editable_text_set_text_contents(self: ptr EditableText00; string: cstring) {.
    importc, libprag.}

proc setTextContents*(self: EditableText | NoOpObject;
    string: cstring) =
  atk_editable_text_set_text_contents(cast[ptr EditableText00](self.impl), string)

proc `textContents=`*(self: EditableText | NoOpObject;
    string: cstring) =
  atk_editable_text_set_text_contents(cast[ptr EditableText00](self.impl), string)

type
  EventListener* = proc (obj: ptr Object00) {.cdecl.}

type
  EventListenerInit* = proc () {.cdecl.}

type
  FocusHandler* = proc (`object`: ptr Object00; focusIn: gboolean) {.cdecl.}

type
  Function* = proc (userData: pointer): gboolean {.cdecl.}

type
  GObjectAccessible* = ref object of Object
  GObjectAccessible00* = object of Object00

proc atk_gobject_accessible_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GObjectAccessible()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_gobject_accessible_for_object(obj: ptr gobject.Object00): ptr Object00 {.
    importc, libprag.}

proc forObject*(obj: gobject.Object): Object =
  let gobj = atk_gobject_accessible_for_object(cast[ptr gobject.Object00](obj.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_gobject_accessible_get_object(self: ptr GObjectAccessible00): ptr gobject.Object00 {.
    importc, libprag.}

proc getObject*(self: GObjectAccessible): gobject.Object =
  let gobj = atk_gobject_accessible_get_object(cast[ptr GObjectAccessible00](self.impl))
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

type
  HyperlinkImpl00* = object of gobject.Object00
  HyperlinkImpl* = ref object of gobject.Object

proc atk_hyperlink_impl_get_hyperlink(self: ptr HyperlinkImpl00): ptr Hyperlink00 {.
    importc, libprag.}

proc getHyperlink*(self: HyperlinkImpl): Hyperlink =
  let gobj = atk_hyperlink_impl_get_hyperlink(cast[ptr HyperlinkImpl00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc hyperlink*(self: HyperlinkImpl): Hyperlink =
  let gobj = atk_hyperlink_impl_get_hyperlink(cast[ptr HyperlinkImpl00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  HyperlinkStateFlags* {.size: sizeof(cint), pure.} = enum
    inline = 1

type
  Hypertext00* = object of gobject.Object00
  Hypertext* = ref object of gobject.Object

proc scLinkSelected*(self: Hypertext | NoOpObject;  p: proc (self: ptr Hypertext00; arg1: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "link-selected", cast[GCallback](p), xdata, nil, cf)

proc atk_hypertext_get_link(self: ptr Hypertext00; linkIndex: int32): ptr Hyperlink00 {.
    importc, libprag.}

proc getLink*(self: Hypertext | NoOpObject; linkIndex: int): Hyperlink =
  let gobj = atk_hypertext_get_link(cast[ptr Hypertext00](self.impl), int32(linkIndex))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_hypertext_get_link_index(self: ptr Hypertext00; charIndex: int32): int32 {.
    importc, libprag.}

proc getLinkIndex*(self: Hypertext | NoOpObject; charIndex: int): int =
  int(atk_hypertext_get_link_index(cast[ptr Hypertext00](self.impl), int32(charIndex)))

proc atk_hypertext_get_n_links(self: ptr Hypertext00): int32 {.
    importc, libprag.}

proc getNLinks*(self: Hypertext | NoOpObject): int =
  int(atk_hypertext_get_n_links(cast[ptr Hypertext00](self.impl)))

proc nLinks*(self: Hypertext | NoOpObject): int =
  int(atk_hypertext_get_n_links(cast[ptr Hypertext00](self.impl)))

const INTERFACE_AGE* = 1'i32

type
  Image00* = object of gobject.Object00
  Image* = ref object of gobject.Object

proc atk_image_get_image_description(self: ptr Image00): cstring {.
    importc, libprag.}

proc getImageDescription*(self: Image | NoOpObject): string =
  result = $atk_image_get_image_description(cast[ptr Image00](self.impl))

proc imageDescription*(self: Image | NoOpObject): string =
  result = $atk_image_get_image_description(cast[ptr Image00](self.impl))

proc atk_image_get_image_locale(self: ptr Image00): cstring {.
    importc, libprag.}

proc getImageLocale*(self: Image | NoOpObject): string =
  let resul0 = atk_image_get_image_locale(cast[ptr Image00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc imageLocale*(self: Image | NoOpObject): string =
  let resul0 = atk_image_get_image_locale(cast[ptr Image00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc atk_image_get_image_position(self: ptr Image00; x: var int32; y: var int32;
    coordType: CoordType) {.
    importc, libprag.}

proc getImagePosition*(self: Image | NoOpObject; x: var int = cast[var int](nil);
    y: var int = cast[var int](nil); coordType: CoordType) =
  var y_00: int32
  var x_00: int32
  atk_image_get_image_position(cast[ptr Image00](self.impl), x_00, y_00, coordType)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc atk_image_get_image_size(self: ptr Image00; width: var int32; height: var int32) {.
    importc, libprag.}

proc getImageSize*(self: Image | NoOpObject; width: var int = cast[var int](nil);
    height: var int = cast[var int](nil)) =
  var width_00: int32
  var height_00: int32
  atk_image_get_image_size(cast[ptr Image00](self.impl), width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc atk_image_set_image_description(self: ptr Image00; description: cstring): gboolean {.
    importc, libprag.}

proc setImageDescription*(self: Image | NoOpObject; description: cstring): bool =
  toBool(atk_image_set_image_description(cast[ptr Image00](self.impl), description))

type
  Implementor00* {.pure.} = object
  Implementor* = ref object
    impl*: ptr Implementor00
    ignoreFinalizer*: bool

proc atk_implementor_ref_accessible(self: ptr Implementor00): ptr Object00 {.
    importc, libprag.}

proc refAccessible*(self: Implementor): Object =
  let gobj = atk_implementor_ref_accessible(cast[ptr Implementor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ImplementorIface00* = object of gobject.Object00
  ImplementorIface* = ref object of gobject.Object

type
  KeyEventStruct00* {.pure.} = object
  KeyEventStruct* = ref object
    impl*: ptr KeyEventStruct00
    ignoreFinalizer*: bool

type
  KeyEventType* {.size: sizeof(cint), pure.} = enum
    press = 0
    release = 1
    lastDefined = 2

type
  KeySnoopFunc* = proc (event: ptr KeyEventStruct00; userData: pointer): int32 {.cdecl.}

const MAJOR_VERSION* = 2'i32

const MICRO_VERSION* = 0'i32

const MINOR_VERSION* = 36'i32

type
  Misc* = ref object of gobject.Object
  Misc00* = object of gobject.Object00

proc atk_misc_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Misc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_misc_get_instance(): ptr Misc00 {.
    importc, libprag.}

proc getInstance*(): Misc =
  let gobj = atk_misc_get_instance()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_misc_threads_enter(self: ptr Misc00) {.
    importc, libprag.}

proc threadsEnter*(self: Misc) =
  atk_misc_threads_enter(cast[ptr Misc00](self.impl))

proc atk_misc_threads_leave(self: ptr Misc00) {.
    importc, libprag.}

proc threadsLeave*(self: Misc) =
  atk_misc_threads_leave(cast[ptr Misc00](self.impl))

type
  ObjectFactory* = ref object of gobject.Object
  ObjectFactory00* = object of gobject.Object00

proc atk_object_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ObjectFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_object_factory_create_accessible(self: ptr ObjectFactory00; obj: ptr gobject.Object00): ptr Object00 {.
    importc, libprag.}

proc createAccessible*(self: ObjectFactory; obj: gobject.Object): Object =
  let gobj = atk_object_factory_create_accessible(cast[ptr ObjectFactory00](self.impl), cast[ptr gobject.Object00](obj.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_object_factory_get_accessible_type(self: ptr ObjectFactory00): GType {.
    importc, libprag.}

proc getAccessibleType*(self: ObjectFactory): GType =
  atk_object_factory_get_accessible_type(cast[ptr ObjectFactory00](self.impl))

proc accessibleType*(self: ObjectFactory): GType =
  atk_object_factory_get_accessible_type(cast[ptr ObjectFactory00](self.impl))

proc atk_object_factory_invalidate(self: ptr ObjectFactory00) {.
    importc, libprag.}

proc invalidate*(self: ObjectFactory) =
  atk_object_factory_invalidate(cast[ptr ObjectFactory00](self.impl))

type
  NoOpObjectFactory* = ref object of ObjectFactory
  NoOpObjectFactory00* = object of ObjectFactory00

proc atk_no_op_object_factory_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(NoOpObjectFactory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_no_op_object_factory_new(): ptr NoOpObjectFactory00 {.
    importc, libprag.}

proc newNoOpObjectFactory*(): NoOpObjectFactory =
  let gobj = atk_no_op_object_factory_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newNoOpObjectFactory*(tdesc: typedesc): tdesc =
  assert(result is NoOpObjectFactory)
  let gobj = atk_no_op_object_factory_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNoOpObjectFactory*[T](result: var T) {.deprecated.} =
  assert(result is NoOpObjectFactory)
  let gobj = atk_no_op_object_factory_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ObjectClass00* {.pure.} = object
  ObjectClass* = ref object
    impl*: ptr ObjectClass00
    ignoreFinalizer*: bool

type
  PropertyChangeHandler* = proc (obj: ptr Object00; vals: ptr PropertyValues00) {.cdecl.}

type
  Range00* {.pure.} = object
  Range* = ref object
    impl*: ptr Range00
    ignoreFinalizer*: bool

proc atk_range_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeAtkRange*(self: Range) =
  if not self.ignoreFinalizer:
    boxedFree(atk_range_get_type(), cast[ptr Range00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Range()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(atk_range_get_type(), cast[ptr Range00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Range) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeAtkRange)

proc atk_range_free(self: ptr Range00) {.
    importc, libprag.}

proc free*(self: Range) =
  atk_range_free(cast[ptr Range00](self.impl))

proc finalizerfree*(self: Range) =
  if not self.ignoreFinalizer:
    atk_range_free(cast[ptr Range00](self.impl))

proc atk_range_copy(self: ptr Range00): ptr Range00 {.
    importc, libprag.}

proc copy*(self: Range): Range =
  fnew(result, gBoxedFreeAtkRange)
  result.impl = atk_range_copy(cast[ptr Range00](self.impl))

proc atk_range_new(lowerLimit: cdouble; upperLimit: cdouble; description: cstring): ptr Range00 {.
    importc, libprag.}

proc newRange*(lowerLimit: cdouble; upperLimit: cdouble; description: cstring): Range =
  fnew(result, gBoxedFreeAtkRange)
  result.impl = atk_range_new(lowerLimit, upperLimit, description)

proc newRange*(tdesc: typedesc; lowerLimit: cdouble; upperLimit: cdouble; description: cstring): tdesc =
  assert(result is Range)
  fnew(result, gBoxedFreeAtkRange)
  result.impl = atk_range_new(lowerLimit, upperLimit, description)

proc initRange*[T](result: var T; lowerLimit: cdouble; upperLimit: cdouble; description: cstring) {.deprecated.} =
  assert(result is Range)
  fnew(result, gBoxedFreeAtkRange)
  result.impl = atk_range_new(lowerLimit, upperLimit, description)

proc atk_range_get_description(self: ptr Range00): cstring {.
    importc, libprag.}

proc getDescription*(self: Range): string =
  result = $atk_range_get_description(cast[ptr Range00](self.impl))

proc description*(self: Range): string =
  result = $atk_range_get_description(cast[ptr Range00](self.impl))

proc atk_range_get_lower_limit(self: ptr Range00): cdouble {.
    importc, libprag.}

proc getLowerLimit*(self: Range): cdouble =
  atk_range_get_lower_limit(cast[ptr Range00](self.impl))

proc lowerLimit*(self: Range): cdouble =
  atk_range_get_lower_limit(cast[ptr Range00](self.impl))

proc atk_range_get_upper_limit(self: ptr Range00): cdouble {.
    importc, libprag.}

proc getUpperLimit*(self: Range): cdouble =
  atk_range_get_upper_limit(cast[ptr Range00](self.impl))

proc upperLimit*(self: Range): cdouble =
  atk_range_get_upper_limit(cast[ptr Range00](self.impl))

type
  Registry* = ref object of gobject.Object
  Registry00* = object of gobject.Object00

proc atk_registry_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Registry()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc atk_registry_get_factory(self: ptr Registry00; `type`: GType): ptr ObjectFactory00 {.
    importc, libprag.}

proc getFactory*(self: Registry; `type`: GType): ObjectFactory =
  let gobj = atk_registry_get_factory(cast[ptr Registry00](self.impl), `type`)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_registry_get_factory_type(self: ptr Registry00; `type`: GType): GType {.
    importc, libprag.}

proc getFactoryType*(self: Registry; `type`: GType): GType =
  atk_registry_get_factory_type(cast[ptr Registry00](self.impl), `type`)

proc atk_registry_set_factory_type(self: ptr Registry00; `type`: GType; factoryType: GType) {.
    importc, libprag.}

proc setFactoryType*(self: Registry; `type`: GType; factoryType: GType) =
  atk_registry_set_factory_type(cast[ptr Registry00](self.impl), `type`, factoryType)

type
  Selection00* = object of gobject.Object00
  Selection* = ref object of gobject.Object

proc scSelectionChanged*(self: Selection | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "selection-changed", cast[GCallback](p), xdata, nil, cf)

proc atk_selection_add_selection(self: ptr Selection00; i: int32): gboolean {.
    importc, libprag.}

proc addSelection*(self: Selection | NoOpObject; i: int): bool =
  toBool(atk_selection_add_selection(cast[ptr Selection00](self.impl), int32(i)))

proc atk_selection_clear_selection(self: ptr Selection00): gboolean {.
    importc, libprag.}

proc clearSelection*(self: Selection | NoOpObject): bool =
  toBool(atk_selection_clear_selection(cast[ptr Selection00](self.impl)))

proc atk_selection_get_selection_count(self: ptr Selection00): int32 {.
    importc, libprag.}

proc getSelectionCount*(self: Selection | NoOpObject): int =
  int(atk_selection_get_selection_count(cast[ptr Selection00](self.impl)))

proc selectionCount*(self: Selection | NoOpObject): int =
  int(atk_selection_get_selection_count(cast[ptr Selection00](self.impl)))

proc atk_selection_is_child_selected(self: ptr Selection00; i: int32): gboolean {.
    importc, libprag.}

proc isChildSelected*(self: Selection | NoOpObject; i: int): bool =
  toBool(atk_selection_is_child_selected(cast[ptr Selection00](self.impl), int32(i)))

proc atk_selection_ref_selection(self: ptr Selection00; i: int32): ptr Object00 {.
    importc, libprag.}

proc refSelection*(self: Selection | NoOpObject; i: int): Object =
  let gobj = atk_selection_ref_selection(cast[ptr Selection00](self.impl), int32(i))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_selection_remove_selection(self: ptr Selection00; i: int32): gboolean {.
    importc, libprag.}

proc removeSelection*(self: Selection | NoOpObject; i: int): bool =
  toBool(atk_selection_remove_selection(cast[ptr Selection00](self.impl), int32(i)))

proc atk_selection_select_all_selection(self: ptr Selection00): gboolean {.
    importc, libprag.}

proc selectAllSelection*(self: Selection | NoOpObject): bool =
  toBool(atk_selection_select_all_selection(cast[ptr Selection00](self.impl)))

type
  StreamableContent00* = object of gobject.Object00
  StreamableContent* = ref object of gobject.Object

proc atk_streamable_content_get_mime_type(self: ptr StreamableContent00;
    i: int32): cstring {.
    importc, libprag.}

proc getMimeType*(self: StreamableContent; i: int): string =
  result = $atk_streamable_content_get_mime_type(cast[ptr StreamableContent00](self.impl), int32(i))

proc atk_streamable_content_get_n_mime_types(self: ptr StreamableContent00): int32 {.
    importc, libprag.}

proc getNMimeTypes*(self: StreamableContent): int =
  int(atk_streamable_content_get_n_mime_types(cast[ptr StreamableContent00](self.impl)))

proc nMimeTypes*(self: StreamableContent): int =
  int(atk_streamable_content_get_n_mime_types(cast[ptr StreamableContent00](self.impl)))

proc atk_streamable_content_get_stream(self: ptr StreamableContent00; mimeType: cstring): ptr glib.IOChannel00 {.
    importc, libprag.}

proc getStream*(self: StreamableContent; mimeType: cstring): glib.IOChannel =
  fnew(result, gBoxedFreeGIOChannel)
  result.impl = atk_streamable_content_get_stream(cast[ptr StreamableContent00](self.impl), mimeType)

proc atk_streamable_content_get_uri(self: ptr StreamableContent00; mimeType: cstring): cstring {.
    importc, libprag.}

proc getUri*(self: StreamableContent; mimeType: cstring): string =
  let resul0 = atk_streamable_content_get_uri(cast[ptr StreamableContent00](self.impl), mimeType)
  if resul0.isNil:
    return
  result = $resul0

type
  Table00* = object of gobject.Object00
  Table* = ref object of gobject.Object

proc scColumnDeleted*(self: Table | NoOpObject;  p: proc (self: ptr Table00; arg1: int32; arg2: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "column-deleted", cast[GCallback](p), xdata, nil, cf)

proc scColumnInserted*(self: Table | NoOpObject;  p: proc (self: ptr Table00; arg1: int32; arg2: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "column-inserted", cast[GCallback](p), xdata, nil, cf)

proc scColumnReordered*(self: Table | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "column-reordered", cast[GCallback](p), xdata, nil, cf)

proc scModelChanged*(self: Table | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "model-changed", cast[GCallback](p), xdata, nil, cf)

proc scRowDeleted*(self: Table | NoOpObject;  p: proc (self: ptr Table00; arg1: int32; arg2: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "row-deleted", cast[GCallback](p), xdata, nil, cf)

proc scRowInserted*(self: Table | NoOpObject;  p: proc (self: ptr Table00; arg1: int32; arg2: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "row-inserted", cast[GCallback](p), xdata, nil, cf)

proc scRowReordered*(self: Table | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "row-reordered", cast[GCallback](p), xdata, nil, cf)

proc atk_table_add_column_selection(self: ptr Table00; column: int32): gboolean {.
    importc, libprag.}

proc addColumnSelection*(self: Table | NoOpObject; column: int): bool =
  toBool(atk_table_add_column_selection(cast[ptr Table00](self.impl), int32(column)))

proc atk_table_add_row_selection(self: ptr Table00; row: int32): gboolean {.
    importc, libprag.}

proc addRowSelection*(self: Table | NoOpObject; row: int): bool =
  toBool(atk_table_add_row_selection(cast[ptr Table00](self.impl), int32(row)))

proc atk_table_get_caption(self: ptr Table00): ptr Object00 {.
    importc, libprag.}

proc getCaption*(self: Table | NoOpObject): Object =
  let gobj = atk_table_get_caption(cast[ptr Table00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc caption*(self: Table | NoOpObject): Object =
  let gobj = atk_table_get_caption(cast[ptr Table00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_table_get_column_at_index(self: ptr Table00; index: int32): int32 {.
    importc, libprag.}

proc getColumnAtIndex*(self: Table | NoOpObject; index: int): int =
  int(atk_table_get_column_at_index(cast[ptr Table00](self.impl), int32(index)))

proc atk_table_get_column_description(self: ptr Table00; column: int32): cstring {.
    importc, libprag.}

proc getColumnDescription*(self: Table | NoOpObject; column: int): string =
  result = $atk_table_get_column_description(cast[ptr Table00](self.impl), int32(column))

proc atk_table_get_column_extent_at(self: ptr Table00; row: int32; column: int32): int32 {.
    importc, libprag.}

proc getColumnExtentAt*(self: Table | NoOpObject; row: int; column: int): int =
  int(atk_table_get_column_extent_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_get_column_header(self: ptr Table00; column: int32): ptr Object00 {.
    importc, libprag.}

proc getColumnHeader*(self: Table | NoOpObject; column: int): Object =
  let gobj = atk_table_get_column_header(cast[ptr Table00](self.impl), int32(column))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_table_get_index_at(self: ptr Table00; row: int32; column: int32): int32 {.
    importc, libprag.}

proc getIndexAt*(self: Table | NoOpObject; row: int; column: int): int =
  int(atk_table_get_index_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_get_n_columns(self: ptr Table00): int32 {.
    importc, libprag.}

proc getNColumns*(self: Table | NoOpObject): int =
  int(atk_table_get_n_columns(cast[ptr Table00](self.impl)))

proc nColumns*(self: Table | NoOpObject): int =
  int(atk_table_get_n_columns(cast[ptr Table00](self.impl)))

proc atk_table_get_n_rows(self: ptr Table00): int32 {.
    importc, libprag.}

proc getNRows*(self: Table | NoOpObject): int =
  int(atk_table_get_n_rows(cast[ptr Table00](self.impl)))

proc nRows*(self: Table | NoOpObject): int =
  int(atk_table_get_n_rows(cast[ptr Table00](self.impl)))

proc atk_table_get_row_at_index(self: ptr Table00; index: int32): int32 {.
    importc, libprag.}

proc getRowAtIndex*(self: Table | NoOpObject; index: int): int =
  int(atk_table_get_row_at_index(cast[ptr Table00](self.impl), int32(index)))

proc atk_table_get_row_description(self: ptr Table00; row: int32): cstring {.
    importc, libprag.}

proc getRowDescription*(self: Table | NoOpObject; row: int): string =
  let resul0 = atk_table_get_row_description(cast[ptr Table00](self.impl), int32(row))
  if resul0.isNil:
    return
  result = $resul0

proc atk_table_get_row_extent_at(self: ptr Table00; row: int32; column: int32): int32 {.
    importc, libprag.}

proc getRowExtentAt*(self: Table | NoOpObject; row: int; column: int): int =
  int(atk_table_get_row_extent_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_get_row_header(self: ptr Table00; row: int32): ptr Object00 {.
    importc, libprag.}

proc getRowHeader*(self: Table | NoOpObject; row: int): Object =
  let gobj = atk_table_get_row_header(cast[ptr Table00](self.impl), int32(row))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_table_get_selected_columns(self: ptr Table00; selected: ptr int32): int32 {.
    importc, libprag.}

proc getSelectedColumns*(self: Table | NoOpObject; selected: ptr int32): int =
  int(atk_table_get_selected_columns(cast[ptr Table00](self.impl), selected))

proc atk_table_get_selected_rows(self: ptr Table00; selected: ptr int32): int32 {.
    importc, libprag.}

proc getSelectedRows*(self: Table | NoOpObject; selected: ptr int32): int =
  int(atk_table_get_selected_rows(cast[ptr Table00](self.impl), selected))

proc atk_table_get_summary(self: ptr Table00): ptr Object00 {.
    importc, libprag.}

proc getSummary*(self: Table | NoOpObject): Object =
  let gobj = atk_table_get_summary(cast[ptr Table00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc summary*(self: Table | NoOpObject): Object =
  let gobj = atk_table_get_summary(cast[ptr Table00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_table_is_column_selected(self: ptr Table00; column: int32): gboolean {.
    importc, libprag.}

proc isColumnSelected*(self: Table | NoOpObject; column: int): bool =
  toBool(atk_table_is_column_selected(cast[ptr Table00](self.impl), int32(column)))

proc atk_table_is_row_selected(self: ptr Table00; row: int32): gboolean {.
    importc, libprag.}

proc isRowSelected*(self: Table | NoOpObject; row: int): bool =
  toBool(atk_table_is_row_selected(cast[ptr Table00](self.impl), int32(row)))

proc atk_table_is_selected(self: ptr Table00; row: int32; column: int32): gboolean {.
    importc, libprag.}

proc isSelected*(self: Table | NoOpObject; row: int; column: int): bool =
  toBool(atk_table_is_selected(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_ref_at(self: ptr Table00; row: int32; column: int32): ptr Object00 {.
    importc, libprag.}

proc refAt*(self: Table | NoOpObject; row: int; column: int): Object =
  let gobj = atk_table_ref_at(cast[ptr Table00](self.impl), int32(row), int32(column))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_table_remove_column_selection(self: ptr Table00; column: int32): gboolean {.
    importc, libprag.}

proc removeColumnSelection*(self: Table | NoOpObject; column: int): bool =
  toBool(atk_table_remove_column_selection(cast[ptr Table00](self.impl), int32(column)))

proc atk_table_remove_row_selection(self: ptr Table00; row: int32): gboolean {.
    importc, libprag.}

proc removeRowSelection*(self: Table | NoOpObject; row: int): bool =
  toBool(atk_table_remove_row_selection(cast[ptr Table00](self.impl), int32(row)))

proc atk_table_set_caption(self: ptr Table00; caption: ptr Object00) {.
    importc, libprag.}

proc setCaption*(self: Table | NoOpObject; caption: Object) =
  atk_table_set_caption(cast[ptr Table00](self.impl), cast[ptr Object00](caption.impl))

proc `caption=`*(self: Table | NoOpObject; caption: Object) =
  atk_table_set_caption(cast[ptr Table00](self.impl), cast[ptr Object00](caption.impl))

proc atk_table_set_column_description(self: ptr Table00; column: int32; description: cstring) {.
    importc, libprag.}

proc setColumnDescription*(self: Table | NoOpObject; column: int;
    description: cstring) =
  atk_table_set_column_description(cast[ptr Table00](self.impl), int32(column), description)

proc atk_table_set_column_header(self: ptr Table00; column: int32; header: ptr Object00) {.
    importc, libprag.}

proc setColumnHeader*(self: Table | NoOpObject; column: int; header: Object) =
  atk_table_set_column_header(cast[ptr Table00](self.impl), int32(column), cast[ptr Object00](header.impl))

proc atk_table_set_row_description(self: ptr Table00; row: int32; description: cstring) {.
    importc, libprag.}

proc setRowDescription*(self: Table | NoOpObject; row: int; description: cstring) =
  atk_table_set_row_description(cast[ptr Table00](self.impl), int32(row), description)

proc atk_table_set_row_header(self: ptr Table00; row: int32; header: ptr Object00) {.
    importc, libprag.}

proc setRowHeader*(self: Table | NoOpObject; row: int; header: Object) =
  atk_table_set_row_header(cast[ptr Table00](self.impl), int32(row), cast[ptr Object00](header.impl))

proc atk_table_set_summary(self: ptr Table00; accessible: ptr Object00) {.
    importc, libprag.}

proc setSummary*(self: Table | NoOpObject; accessible: Object) =
  atk_table_set_summary(cast[ptr Table00](self.impl), cast[ptr Object00](accessible.impl))

proc `summary=`*(self: Table | NoOpObject; accessible: Object) =
  atk_table_set_summary(cast[ptr Table00](self.impl), cast[ptr Object00](accessible.impl))

type
  TableCell00* = object of gobject.Object00
  TableCell* = ref object of gobject.Object

proc atk_table_cell_get_column_header_cells(self: ptr TableCell00): ptr PtrArray00 {.
    importc, libprag.}

proc getColumnHeaderCells*(self: TableCell | NoOpObject): ptr PtrArray00 =
  atk_table_cell_get_column_header_cells(cast[ptr TableCell00](self.impl))

proc columnHeaderCells*(self: TableCell | NoOpObject): ptr PtrArray00 =
  atk_table_cell_get_column_header_cells(cast[ptr TableCell00](self.impl))

proc atk_table_cell_get_column_span(self: ptr TableCell00): int32 {.
    importc, libprag.}

proc getColumnSpan*(self: TableCell | NoOpObject): int =
  int(atk_table_cell_get_column_span(cast[ptr TableCell00](self.impl)))

proc columnSpan*(self: TableCell | NoOpObject): int =
  int(atk_table_cell_get_column_span(cast[ptr TableCell00](self.impl)))

proc atk_table_cell_get_position(self: ptr TableCell00; row: var int32; column: var int32): gboolean {.
    importc, libprag.}

proc getPosition*(self: TableCell | NoOpObject; row: var int;
    column: var int): bool =
  var row_00: int32
  var column_00: int32
  result = toBool(atk_table_cell_get_position(cast[ptr TableCell00](self.impl), row_00, column_00))
  if row.addr != nil:
    row = int(row_00)
  if column.addr != nil:
    column = int(column_00)

proc atk_table_cell_get_row_column_span(self: ptr TableCell00; row: var int32;
    column: var int32; rowSpan: var int32; columnSpan: var int32): gboolean {.
    importc, libprag.}

proc getRowColumnSpan*(self: TableCell | NoOpObject; row: var int;
    column: var int; rowSpan: var int; columnSpan: var int): bool =
  var row_00: int32
  var column_00: int32
  var columnSpan_00: int32
  var rowSpan_00: int32
  result = toBool(atk_table_cell_get_row_column_span(cast[ptr TableCell00](self.impl), row_00, column_00, rowSpan_00, columnSpan_00))
  if row.addr != nil:
    row = int(row_00)
  if column.addr != nil:
    column = int(column_00)
  if columnSpan.addr != nil:
    columnSpan = int(columnSpan_00)
  if rowSpan.addr != nil:
    rowSpan = int(rowSpan_00)

proc atk_table_cell_get_row_header_cells(self: ptr TableCell00): ptr PtrArray00 {.
    importc, libprag.}

proc getRowHeaderCells*(self: TableCell | NoOpObject): ptr PtrArray00 =
  atk_table_cell_get_row_header_cells(cast[ptr TableCell00](self.impl))

proc rowHeaderCells*(self: TableCell | NoOpObject): ptr PtrArray00 =
  atk_table_cell_get_row_header_cells(cast[ptr TableCell00](self.impl))

proc atk_table_cell_get_row_span(self: ptr TableCell00): int32 {.
    importc, libprag.}

proc getRowSpan*(self: TableCell | NoOpObject): int =
  int(atk_table_cell_get_row_span(cast[ptr TableCell00](self.impl)))

proc rowSpan*(self: TableCell | NoOpObject): int =
  int(atk_table_cell_get_row_span(cast[ptr TableCell00](self.impl)))

proc atk_table_cell_get_table(self: ptr TableCell00): ptr Object00 {.
    importc, libprag.}

proc getTable*(self: TableCell | NoOpObject): Object =
  let gobj = atk_table_cell_get_table(cast[ptr TableCell00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc table*(self: TableCell | NoOpObject): Object =
  let gobj = atk_table_cell_get_table(cast[ptr TableCell00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Text00* = object of gobject.Object00
  Text* = ref object of gobject.Object

proc scTextAttributesChanged*(self: Text | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-attributes-changed", cast[GCallback](p), xdata, nil, cf)

proc scTextCaretMoved*(self: Text | NoOpObject;  p: proc (self: ptr Text00; arg1: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-caret-moved", cast[GCallback](p), xdata, nil, cf)

proc scTextChanged*(self: Text | NoOpObject;  p: proc (self: ptr Text00; arg1: int32; arg2: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-changed", cast[GCallback](p), xdata, nil, cf)

proc scTextInsert*(self: Text | NoOpObject;  p: proc (self: ptr Text00; arg1: int32; arg2: int32; arg3: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-insert", cast[GCallback](p), xdata, nil, cf)

proc scTextRemove*(self: Text | NoOpObject;  p: proc (self: ptr Text00; arg1: int32; arg2: int32; arg3: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-remove", cast[GCallback](p), xdata, nil, cf)

proc scTextSelectionChanged*(self: Text | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "text-selection-changed", cast[GCallback](p), xdata, nil, cf)

proc atk_text_add_selection(self: ptr Text00; startOffset: int32; endOffset: int32): gboolean {.
    importc, libprag.}

proc addSelection*(self: Text | NoOpObject; startOffset: int; endOffset: int): bool =
  toBool(atk_text_add_selection(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset)))

proc atk_text_get_caret_offset(self: ptr Text00): int32 {.
    importc, libprag.}

proc getCaretOffset*(self: Text | NoOpObject): int =
  int(atk_text_get_caret_offset(cast[ptr Text00](self.impl)))

proc caretOffset*(self: Text | NoOpObject): int =
  int(atk_text_get_caret_offset(cast[ptr Text00](self.impl)))

proc atk_text_get_character_at_offset(self: ptr Text00; offset: int32): gunichar {.
    importc, libprag.}

proc getCharacterAtOffset*(self: Text | NoOpObject; offset: int): gunichar =
  atk_text_get_character_at_offset(cast[ptr Text00](self.impl), int32(offset))

proc atk_text_get_character_count(self: ptr Text00): int32 {.
    importc, libprag.}

proc getCharacterCount*(self: Text | NoOpObject): int =
  int(atk_text_get_character_count(cast[ptr Text00](self.impl)))

proc characterCount*(self: Text | NoOpObject): int =
  int(atk_text_get_character_count(cast[ptr Text00](self.impl)))

proc atk_text_get_character_extents(self: ptr Text00; offset: int32; x: var int32;
    y: var int32; width: var int32; height: var int32; coords: CoordType) {.
    importc, libprag.}

proc getCharacterExtents*(self: Text | NoOpObject; offset: int;
    x: var int = cast[var int](nil); y: var int = cast[var int](nil); width: var int = cast[var int](nil);
    height: var int = cast[var int](nil); coords: CoordType) =
  var width_00: int32
  var y_00: int32
  var x_00: int32
  var height_00: int32
  atk_text_get_character_extents(cast[ptr Text00](self.impl), int32(offset), x_00, y_00, width_00, height_00, coords)
  if width.addr != nil:
    width = int(width_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)
  if height.addr != nil:
    height = int(height_00)

proc atk_text_get_default_attributes(self: ptr Text00): ptr glib.SList {.
    importc, libprag.}

proc getDefaultAttributes*(self: Text | NoOpObject): seq[pointer] =
  let resul0 = atk_text_get_default_attributes(cast[ptr Text00](self.impl))
  g_slist_free(resul0)

proc defaultAttributes*(self: Text | NoOpObject): seq[pointer] =
  let resul0 = atk_text_get_default_attributes(cast[ptr Text00](self.impl))
  g_slist_free(resul0)

proc atk_text_get_n_selections(self: ptr Text00): int32 {.
    importc, libprag.}

proc getNSelections*(self: Text | NoOpObject): int =
  int(atk_text_get_n_selections(cast[ptr Text00](self.impl)))

proc nSelections*(self: Text | NoOpObject): int =
  int(atk_text_get_n_selections(cast[ptr Text00](self.impl)))

proc atk_text_get_offset_at_point(self: ptr Text00; x: int32; y: int32; coords: CoordType): int32 {.
    importc, libprag.}

proc getOffsetAtPoint*(self: Text | NoOpObject; x: int; y: int;
    coords: CoordType): int =
  int(atk_text_get_offset_at_point(cast[ptr Text00](self.impl), int32(x), int32(y), coords))

proc atk_text_get_run_attributes(self: ptr Text00; offset: int32; startOffset: var int32;
    endOffset: var int32): ptr glib.SList {.
    importc, libprag.}

proc getRunAttributes*(self: Text | NoOpObject; offset: int; startOffset: var int;
    endOffset: var int): seq[pointer] =
  var startOffset_00: int32
  var endOffset_00: int32
  let resul0 = atk_text_get_run_attributes(cast[ptr Text00](self.impl), int32(offset), startOffset_00, endOffset_00)
  g_slist_free(resul0)
  if startOffset.addr != nil:
    startOffset = int(startOffset_00)
  if endOffset.addr != nil:
    endOffset = int(endOffset_00)

proc atk_text_get_selection(self: ptr Text00; selectionNum: int32; startOffset: var int32;
    endOffset: var int32): cstring {.
    importc, libprag.}

proc getSelection*(self: Text | NoOpObject; selectionNum: int; startOffset: var int;
    endOffset: var int): string =
  var startOffset_00: int32
  var endOffset_00: int32
  let resul0 = atk_text_get_selection(cast[ptr Text00](self.impl), int32(selectionNum), startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  if startOffset.addr != nil:
    startOffset = int(startOffset_00)
  if endOffset.addr != nil:
    endOffset = int(endOffset_00)

proc atk_text_get_text(self: ptr Text00; startOffset: int32; endOffset: int32): cstring {.
    importc, libprag.}

proc getText*(self: Text | NoOpObject; startOffset: int; endOffset: int): string =
  let resul0 = atk_text_get_text(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset))
  result = $resul0
  cogfree(resul0)

proc atk_text_remove_selection(self: ptr Text00; selectionNum: int32): gboolean {.
    importc, libprag.}

proc removeSelection*(self: Text | NoOpObject; selectionNum: int): bool =
  toBool(atk_text_remove_selection(cast[ptr Text00](self.impl), int32(selectionNum)))

proc atk_text_scroll_substring_to(self: ptr Text00; startOffset: int32; endOffset: int32;
    `type`: ScrollType): gboolean {.
    importc, libprag.}

proc scrollSubstringTo*(self: Text | NoOpObject; startOffset: int;
    endOffset: int; `type`: ScrollType): bool =
  toBool(atk_text_scroll_substring_to(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset), `type`))

proc atk_text_scroll_substring_to_point(self: ptr Text00; startOffset: int32;
    endOffset: int32; coords: CoordType; x: int32; y: int32): gboolean {.
    importc, libprag.}

proc scrollSubstringToPoint*(self: Text | NoOpObject; startOffset: int;
    endOffset: int; coords: CoordType; x: int; y: int): bool =
  toBool(atk_text_scroll_substring_to_point(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset), coords, int32(x), int32(y)))

proc atk_text_set_caret_offset(self: ptr Text00; offset: int32): gboolean {.
    importc, libprag.}

proc setCaretOffset*(self: Text | NoOpObject; offset: int): bool =
  toBool(atk_text_set_caret_offset(cast[ptr Text00](self.impl), int32(offset)))

proc atk_text_set_selection(self: ptr Text00; selectionNum: int32; startOffset: int32;
    endOffset: int32): gboolean {.
    importc, libprag.}

proc setSelection*(self: Text | NoOpObject; selectionNum: int; startOffset: int;
    endOffset: int): bool =
  toBool(atk_text_set_selection(cast[ptr Text00](self.impl), int32(selectionNum), int32(startOffset), int32(endOffset)))

type
  TextRange00* {.pure.} = object
  TextRange* = ref object
    impl*: ptr TextRange00
    ignoreFinalizer*: bool

proc atk_text_range_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeAtkTextRange*(self: TextRange) =
  if not self.ignoreFinalizer:
    boxedFree(atk_text_range_get_type(), cast[ptr TextRange00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TextRange()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(atk_text_range_get_type(), cast[ptr TextRange00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var TextRange) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeAtkTextRange)

proc freeRanges*(ranges: ptr ptr TextRange00) {.
    importc: "atk_text_free_ranges", libprag.}

type
  TextRectangle* {.pure, byRef.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32

proc atk_text_get_range_extents(self: ptr Text00; startOffset: int32; endOffset: int32;
    coordType: CoordType; rect: var TextRectangle) {.
    importc, libprag.}

proc getRangeExtents*(self: Text | NoOpObject; startOffset: int;
    endOffset: int; coordType: CoordType; rect: var TextRectangle) =
  atk_text_get_range_extents(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset), coordType, rect)

type
  TextClipType* {.size: sizeof(cint), pure.} = enum
    none = 0
    min = 1
    max = 2
    both = 3

proc atk_text_get_bounded_ranges(self: ptr Text00; rect: TextRectangle; coordType: CoordType;
    xClipType: TextClipType; yClipType: TextClipType): ptr ptr TextRange00 {.
    importc, libprag.}

proc getBoundedRanges*(self: Text | NoOpObject; rect: TextRectangle;
    coordType: CoordType; xClipType: TextClipType; yClipType: TextClipType): ptr ptr TextRange00 =
  atk_text_get_bounded_ranges(cast[ptr Text00](self.impl), rect, coordType, xClipType, yClipType)

type
  TextGranularity* {.size: sizeof(cint), pure.} = enum
    char = 0
    word = 1
    sentence = 2
    line = 3
    paragraph = 4

proc atk_text_get_string_at_offset(self: ptr Text00; offset: int32; granularity: TextGranularity;
    startOffset: var int32; endOffset: var int32): cstring {.
    importc, libprag.}

proc getStringAtOffset*(self: Text | NoOpObject; offset: int;
    granularity: TextGranularity; startOffset: var int; endOffset: var int): string =
  var startOffset_00: int32
  var endOffset_00: int32
  let resul0 = atk_text_get_string_at_offset(cast[ptr Text00](self.impl), int32(offset), granularity, startOffset_00, endOffset_00)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)
  if startOffset.addr != nil:
    startOffset = int(startOffset_00)
  if endOffset.addr != nil:
    endOffset = int(endOffset_00)

type
  TextBoundary* {.size: sizeof(cint), pure.} = enum
    char = 0
    wordStart = 1
    wordEnd = 2
    sentenceStart = 3
    sentenceEnd = 4
    lineStart = 5
    lineEnd = 6

proc atk_text_get_text_after_offset(self: ptr Text00; offset: int32; boundaryType: TextBoundary;
    startOffset: var int32; endOffset: var int32): cstring {.
    importc, libprag.}

proc getTextAfterOffset*(self: Text | NoOpObject; offset: int;
    boundaryType: TextBoundary; startOffset: var int; endOffset: var int): string =
  var startOffset_00: int32
  var endOffset_00: int32
  let resul0 = atk_text_get_text_after_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  if startOffset.addr != nil:
    startOffset = int(startOffset_00)
  if endOffset.addr != nil:
    endOffset = int(endOffset_00)

proc atk_text_get_text_at_offset(self: ptr Text00; offset: int32; boundaryType: TextBoundary;
    startOffset: var int32; endOffset: var int32): cstring {.
    importc, libprag.}

proc getTextAtOffset*(self: Text | NoOpObject; offset: int; boundaryType: TextBoundary;
    startOffset: var int; endOffset: var int): string =
  var startOffset_00: int32
  var endOffset_00: int32
  let resul0 = atk_text_get_text_at_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  if startOffset.addr != nil:
    startOffset = int(startOffset_00)
  if endOffset.addr != nil:
    endOffset = int(endOffset_00)

proc atk_text_get_text_before_offset(self: ptr Text00; offset: int32; boundaryType: TextBoundary;
    startOffset: var int32; endOffset: var int32): cstring {.
    importc, libprag.}

proc getTextBeforeOffset*(self: Text | NoOpObject; offset: int;
    boundaryType: TextBoundary; startOffset: var int; endOffset: var int): string =
  var startOffset_00: int32
  var endOffset_00: int32
  let resul0 = atk_text_get_text_before_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  if startOffset.addr != nil:
    startOffset = int(startOffset_00)
  if endOffset.addr != nil:
    endOffset = int(endOffset_00)

type
  TextAttribute* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    leftMargin = 1
    rightMargin = 2
    indent = 3
    invisible = 4
    editable = 5
    pixelsAboveLines = 6
    pixelsBelowLines = 7
    pixelsInsideWrap = 8
    bgFullHeight = 9
    rise = 10
    underline = 11
    strikethrough = 12
    size = 13
    scale = 14
    weight = 15
    language = 16
    familyName = 17
    bgColor = 18
    fgColor = 19
    bgStipple = 20
    fgStipple = 21
    wrapMode = 22
    direction = 23
    justification = 24
    stretch = 25
    variant = 26
    style = 27
    textPosition = 28
    lastDefined = 29

proc textAttributeForName*(name: cstring): TextAttribute {.
    importc: "atk_text_attribute_for_name", libprag.}

proc atk_text_attribute_get_name(attr: TextAttribute): cstring {.
    importc, libprag.}

proc getName*(attr: TextAttribute): string =
  result = $atk_text_attribute_get_name(attr)

proc name*(attr: TextAttribute): string =
  result = $atk_text_attribute_get_name(attr)

proc atk_text_attribute_get_value(attr: TextAttribute; index: int32): cstring {.
    importc, libprag.}

proc getValue*(attr: TextAttribute; index: int): string =
  let resul0 = atk_text_attribute_get_value(attr, int32(index))
  if resul0.isNil:
    return
  result = $resul0

proc registerTextAttribute*(name: cstring): TextAttribute {.
    importc: "atk_text_attribute_register", libprag.}

type
  Util* = ref object of gobject.Object
  Util00* = object of gobject.Object00

proc atk_util_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Util()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

const VERSION_MIN_REQUIRED* = 2'i32

type
  Value00* = object of gobject.Object00
  Value* = ref object of gobject.Object

proc scValueChanged*(self: Value | NoOpObject;  p: proc (self: ptr Value00; value: cdouble; text: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "value-changed", cast[GCallback](p), xdata, nil, cf)

proc atk_value_get_current_value(self: ptr Value00; value: var gobject.Value) {.
    importc, libprag.}

proc getCurrentValue*(self: Value | NoOpObject; value: var gobject.Value) =
  atk_value_get_current_value(cast[ptr Value00](self.impl), value)

proc getCurrentValue*(self: Value | NoOpObject): gobject.Value =
  atk_value_get_current_value(cast[ptr Value00](self.impl), result)

proc atk_value_get_increment(self: ptr Value00): cdouble {.
    importc, libprag.}

proc getIncrement*(self: Value | NoOpObject): cdouble =
  atk_value_get_increment(cast[ptr Value00](self.impl))

proc increment*(self: Value | NoOpObject): cdouble =
  atk_value_get_increment(cast[ptr Value00](self.impl))

proc atk_value_get_maximum_value(self: ptr Value00; value: var gobject.Value) {.
    importc, libprag.}

proc getMaximumValue*(self: Value | NoOpObject; value: var gobject.Value) =
  atk_value_get_maximum_value(cast[ptr Value00](self.impl), value)

proc getMaximumValue*(self: Value | NoOpObject): gobject.Value =
  atk_value_get_maximum_value(cast[ptr Value00](self.impl), result)

proc atk_value_get_minimum_increment(self: ptr Value00; value: var gobject.Value) {.
    importc, libprag.}

proc getMinimumIncrement*(self: Value | NoOpObject; value: var gobject.Value) =
  atk_value_get_minimum_increment(cast[ptr Value00](self.impl), value)

proc getMinimumIncrement*(self: Value | NoOpObject): gobject.Value =
  atk_value_get_minimum_increment(cast[ptr Value00](self.impl), result)

proc atk_value_get_minimum_value(self: ptr Value00; value: var gobject.Value) {.
    importc, libprag.}

proc getMinimumValue*(self: Value | NoOpObject; value: var gobject.Value) =
  atk_value_get_minimum_value(cast[ptr Value00](self.impl), value)

proc getMinimumValue*(self: Value | NoOpObject): gobject.Value =
  atk_value_get_minimum_value(cast[ptr Value00](self.impl), result)

proc atk_value_get_range(self: ptr Value00): ptr Range00 {.
    importc, libprag.}

proc getRange*(self: Value | NoOpObject): Range =
  let impl0 = atk_value_get_range(cast[ptr Value00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeAtkRange)
  result.impl = impl0

proc range*(self: Value | NoOpObject): Range =
  let impl0 = atk_value_get_range(cast[ptr Value00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeAtkRange)
  result.impl = impl0

proc atk_value_get_sub_ranges(self: ptr Value00): ptr glib.SList {.
    importc, libprag.}

proc getSubRanges*(self: Value | NoOpObject): seq[Range] =
  let resul0 = atk_value_get_sub_ranges(cast[ptr Value00](self.impl))
  result = gslistStructs2seq[Range](resul0, false)
  g_slist_free(resul0)

proc subRanges*(self: Value | NoOpObject): seq[Range] =
  let resul0 = atk_value_get_sub_ranges(cast[ptr Value00](self.impl))
  result = gslistStructs2seq[Range](resul0, false)
  g_slist_free(resul0)

proc atk_value_get_value_and_text(self: ptr Value00; value: var cdouble;
    text: var cstring) {.
    importc, libprag.}

proc getValueAndText*(self: Value | NoOpObject; value: var cdouble;
    text: var string = cast[var string](nil)) =
  var text_00: cstring
  atk_value_get_value_and_text(cast[ptr Value00](self.impl), value, text_00)
  if text.addr != nil:
    text = $(text_00)

proc atk_value_set_current_value(self: ptr Value00; value: gobject.Value): gboolean {.
    importc, libprag.}

proc setCurrentValue*(self: Value | NoOpObject; value: gobject.Value): bool =
  toBool(atk_value_set_current_value(cast[ptr Value00](self.impl), value))

proc atk_value_set_value(self: ptr Value00; newValue: cdouble) {.
    importc, libprag.}

proc setValue*(self: Value | NoOpObject; newValue: cdouble) =
  atk_value_set_value(cast[ptr Value00](self.impl), newValue)

proc `value=`*(self: Value | NoOpObject; newValue: cdouble) =
  atk_value_set_value(cast[ptr Value00](self.impl), newValue)

type
  ValueType* {.size: sizeof(cint), pure.} = enum
    veryWeak = 0
    weak = 1
    acceptable = 2
    strong = 3
    veryStrong = 4
    veryLow = 5
    low = 6
    medium = 7
    high = 8
    veryHigh = 9
    veryBad = 10
    bad = 11
    good = 12
    veryGood = 13
    best = 14
    lastDefined = 15

proc atk_value_type_get_localized_name(valueType: ValueType): cstring {.
    importc, libprag.}

proc getLocalizedName*(valueType: ValueType): string =
  result = $atk_value_type_get_localized_name(valueType)

proc localizedName*(valueType: ValueType): string =
  result = $atk_value_type_get_localized_name(valueType)

proc atk_value_type_get_name(valueType: ValueType): cstring {.
    importc, libprag.}

proc getName*(valueType: ValueType): string =
  result = $atk_value_type_get_name(valueType)

proc name*(valueType: ValueType): string =
  result = $atk_value_type_get_name(valueType)

type
  Window00* = object of gobject.Object00
  Window* = ref object of gobject.Object

proc scActivate*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cf)

proc scCreate*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create", cast[GCallback](p), xdata, nil, cf)

proc scDeactivate*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "deactivate", cast[GCallback](p), xdata, nil, cf)

proc scDestroy*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "destroy", cast[GCallback](p), xdata, nil, cf)

proc scMaximize*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "maximize", cast[GCallback](p), xdata, nil, cf)

proc scMinimize*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "minimize", cast[GCallback](p), xdata, nil, cf)

proc scMove*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move", cast[GCallback](p), xdata, nil, cf)

proc scResize*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "resize", cast[GCallback](p), xdata, nil, cf)

proc scRestore*(self: Window | NoOpObject;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "restore", cast[GCallback](p), xdata, nil, cf)

proc atk_focus_tracker_notify(`object`: ptr Object00) {.
    importc, libprag.}

proc focusTrackerNotify*(`object`: Object) =
  atk_focus_tracker_notify(cast[ptr Object00](`object`.impl))

proc atk_get_binary_age(): uint32 {.
    importc, libprag.}

proc getBinaryAge*(): int =
  int(atk_get_binary_age())

proc atk_get_default_registry(): ptr Registry00 {.
    importc, libprag.}

proc getDefaultRegistry*(): Registry =
  let gobj = atk_get_default_registry()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_get_focus_object(): ptr Object00 {.
    importc, libprag.}

proc getFocusObject*(): Object =
  let gobj = atk_get_focus_object()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_get_interface_age(): uint32 {.
    importc, libprag.}

proc getInterfaceAge*(): int =
  int(atk_get_interface_age())

proc atk_get_major_version(): uint32 {.
    importc, libprag.}

proc getMajorVersion*(): int =
  int(atk_get_major_version())

proc atk_get_micro_version(): uint32 {.
    importc, libprag.}

proc getMicroVersion*(): int =
  int(atk_get_micro_version())

proc atk_get_minor_version(): uint32 {.
    importc, libprag.}

proc getMinorVersion*(): int =
  int(atk_get_minor_version())

proc atk_get_root(): ptr Object00 {.
    importc, libprag.}

proc getRoot*(): Object =
  let gobj = atk_get_root()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, atk.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_get_toolkit_name(): cstring {.
    importc, libprag.}

proc getToolkitName*(): string =
  result = $atk_get_toolkit_name()

proc atk_get_toolkit_version(): cstring {.
    importc, libprag.}

proc getToolkitVersion*(): string =
  result = $atk_get_toolkit_version()

proc atk_get_version(): cstring {.
    importc, libprag.}

proc getVersion*(): string =
  result = $atk_get_version()

proc atk_remove_focus_tracker(trackerId: uint32) {.
    importc, libprag.}

proc removeFocusTracker*(trackerId: int) =
  atk_remove_focus_tracker(uint32(trackerId))

proc atk_remove_global_event_listener(listenerId: uint32) {.
    importc, libprag.}

proc removeGlobalEventListener*(listenerId: int) =
  atk_remove_global_event_listener(uint32(listenerId))

proc atk_remove_key_event_listener(listenerId: uint32) {.
    importc, libprag.}

proc removeKeyEventListener*(listenerId: int) =
  atk_remove_key_event_listener(uint32(listenerId))
# === remaining symbols:
