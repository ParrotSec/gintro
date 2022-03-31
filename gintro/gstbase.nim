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
# libgstbase-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule
const Lib = "libgstbase-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  Adapter* = ref object of gobject.Object
  Adapter00* = object of gobject.Object00

proc gst_adapter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Adapter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_adapter_new(): ptr Adapter00 {.
    importc, libprag.}

proc newAdapter*(): Adapter =
  let gobj = gst_adapter_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstbase.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newAdapter*(tdesc: typedesc): tdesc =
  assert(result is Adapter)
  let gobj = gst_adapter_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstbase.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAdapter*[T](result: var T) {.deprecated.} =
  assert(result is Adapter)
  let gobj = gst_adapter_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstbase.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_adapter_available(self: ptr Adapter00): uint64 {.
    importc, libprag.}

proc available*(self: Adapter): uint64 =
  gst_adapter_available(cast[ptr Adapter00](self.impl))

proc gst_adapter_available_fast(self: ptr Adapter00): uint64 {.
    importc, libprag.}

proc availableFast*(self: Adapter): uint64 =
  gst_adapter_available_fast(cast[ptr Adapter00](self.impl))

proc gst_adapter_clear(self: ptr Adapter00) {.
    importc, libprag.}

proc clear*(self: Adapter) =
  gst_adapter_clear(cast[ptr Adapter00](self.impl))

proc gst_adapter_copy_bytes(self: ptr Adapter00; offset: uint64; size: uint64): ptr glib.Bytes00 {.
    importc, libprag.}

proc copy*(self: Adapter; offset: uint64; size: uint64): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gst_adapter_copy_bytes(cast[ptr Adapter00](self.impl), offset, size)

proc gst_adapter_distance_from_discont(self: ptr Adapter00): uint64 {.
    importc, libprag.}

proc distanceFromDiscont*(self: Adapter): uint64 =
  gst_adapter_distance_from_discont(cast[ptr Adapter00](self.impl))

proc gst_adapter_dts_at_discont(self: ptr Adapter00): uint64 {.
    importc, libprag.}

proc dtsAtDiscont*(self: Adapter): uint64 =
  gst_adapter_dts_at_discont(cast[ptr Adapter00](self.impl))

proc gst_adapter_flush(self: ptr Adapter00; flush: uint64) {.
    importc, libprag.}

proc flush*(self: Adapter; flush: uint64) =
  gst_adapter_flush(cast[ptr Adapter00](self.impl), flush)

proc gst_adapter_get_buffer(self: ptr Adapter00; nbytes: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: Adapter; nbytes: uint64): gst.Buffer =
  let impl0 = gst_adapter_get_buffer(cast[ptr Adapter00](self.impl), nbytes)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_adapter_get_buffer_fast(self: ptr Adapter00; nbytes: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc getBufferFast*(self: Adapter; nbytes: uint64): gst.Buffer =
  let impl0 = gst_adapter_get_buffer_fast(cast[ptr Adapter00](self.impl), nbytes)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_adapter_get_buffer_list(self: ptr Adapter00; nbytes: uint64): ptr gst.BufferList00 {.
    importc, libprag.}

proc getBufferList*(self: Adapter; nbytes: uint64): gst.BufferList =
  let impl0 = gst_adapter_get_buffer_list(cast[ptr Adapter00](self.impl), nbytes)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = impl0

proc gst_adapter_get_list(self: ptr Adapter00; nbytes: uint64): ptr glib.List {.
    importc, libprag.}

proc getListAdapter*(self: Adapter; nbytes: uint64): seq[gst.Buffer] =
  let resul0 = gst_adapter_get_list(cast[ptr Adapter00](self.impl), nbytes)
  if resul0.isNil:
    return
  result = glistStructs2seq[gst.Buffer](resul0, false)
  g_list_free(resul0)

proc gst_adapter_map(self: ptr Adapter00; size: var uint64): ptr uint8 {.
    importc, libprag.}

proc map*(self: Adapter; size: var uint64): seq[uint8] =
  let resul0 = gst_adapter_map(cast[ptr Adapter00](self.impl), size)
  if resul0.isNil:
    return
  result = uint8ArrayToSeq(resul0, size.int)

proc gst_adapter_masked_scan_uint32(self: ptr Adapter00; mask: uint32; pattern: uint32;
    offset: uint64; size: uint64): int64 {.
    importc, libprag.}

proc maskedScanUint32*(self: Adapter; mask: int; pattern: int;
    offset: uint64; size: uint64): int64 =
  gst_adapter_masked_scan_uint32(cast[ptr Adapter00](self.impl), uint32(mask), uint32(pattern), offset, size)

proc gst_adapter_masked_scan_uint32_peek(self: ptr Adapter00; mask: uint32;
    pattern: uint32; offset: uint64; size: uint64; value: var uint32): int64 {.
    importc, libprag.}

proc maskedScanUint32Peek*(self: Adapter; mask: int; pattern: int;
    offset: uint64; size: uint64; value: var int = cast[var int](nil)): int64 =
  var value_00: uint32
  result = gst_adapter_masked_scan_uint32_peek(cast[ptr Adapter00](self.impl), uint32(mask), uint32(pattern), offset, size, value_00)
  if value.addr != nil:
    value = int(value_00)

proc gst_adapter_offset_at_discont(self: ptr Adapter00): uint64 {.
    importc, libprag.}

proc offsetAtDiscont*(self: Adapter): uint64 =
  gst_adapter_offset_at_discont(cast[ptr Adapter00](self.impl))

proc gst_adapter_prev_dts(self: ptr Adapter00; distance: var uint64): uint64 {.
    importc, libprag.}

proc prevDts*(self: Adapter; distance: var uint64 = cast[var uint64](nil)): uint64 =
  gst_adapter_prev_dts(cast[ptr Adapter00](self.impl), distance)

proc gst_adapter_prev_dts_at_offset(self: ptr Adapter00; offset: uint64;
    distance: var uint64): uint64 {.
    importc, libprag.}

proc prevDtsAtOffset*(self: Adapter; offset: uint64; distance: var uint64 = cast[var uint64](nil)): uint64 =
  gst_adapter_prev_dts_at_offset(cast[ptr Adapter00](self.impl), offset, distance)

proc gst_adapter_prev_offset(self: ptr Adapter00; distance: var uint64): uint64 {.
    importc, libprag.}

proc prevOffset*(self: Adapter; distance: var uint64 = cast[var uint64](nil)): uint64 =
  gst_adapter_prev_offset(cast[ptr Adapter00](self.impl), distance)

proc gst_adapter_prev_pts(self: ptr Adapter00; distance: var uint64): uint64 {.
    importc, libprag.}

proc prevPts*(self: Adapter; distance: var uint64 = cast[var uint64](nil)): uint64 =
  gst_adapter_prev_pts(cast[ptr Adapter00](self.impl), distance)

proc gst_adapter_prev_pts_at_offset(self: ptr Adapter00; offset: uint64;
    distance: var uint64): uint64 {.
    importc, libprag.}

proc prevPtsAtOffset*(self: Adapter; offset: uint64; distance: var uint64 = cast[var uint64](nil)): uint64 =
  gst_adapter_prev_pts_at_offset(cast[ptr Adapter00](self.impl), offset, distance)

proc gst_adapter_pts_at_discont(self: ptr Adapter00): uint64 {.
    importc, libprag.}

proc ptsAtDiscont*(self: Adapter): uint64 =
  gst_adapter_pts_at_discont(cast[ptr Adapter00](self.impl))

proc gst_adapter_push(self: ptr Adapter00; buf: ptr gst.Buffer00) {.
    importc, libprag.}

proc push*(self: Adapter; buf: gst.Buffer) =
  gst_adapter_push(cast[ptr Adapter00](self.impl), cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buf.impl)))

proc gst_adapter_take(self: ptr Adapter00; nbytes: var uint64): ptr uint8 {.
    importc, libprag.}

proc take*(self: Adapter; nbytes: var uint64): seq[uint8] =
  let resul0 = gst_adapter_take(cast[ptr Adapter00](self.impl), nbytes)
  if resul0.isNil:
    return
  result = uint8ArrayToSeq(resul0, nbytes.int)
  cogfree(resul0)

proc gst_adapter_take_buffer(self: ptr Adapter00; nbytes: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc takeBuffer*(self: Adapter; nbytes: uint64): gst.Buffer =
  let impl0 = gst_adapter_take_buffer(cast[ptr Adapter00](self.impl), nbytes)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_adapter_take_buffer_fast(self: ptr Adapter00; nbytes: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc takeBufferFast*(self: Adapter; nbytes: uint64): gst.Buffer =
  let impl0 = gst_adapter_take_buffer_fast(cast[ptr Adapter00](self.impl), nbytes)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_adapter_take_buffer_list(self: ptr Adapter00; nbytes: uint64): ptr gst.BufferList00 {.
    importc, libprag.}

proc takeBufferList*(self: Adapter; nbytes: uint64): gst.BufferList =
  let impl0 = gst_adapter_take_buffer_list(cast[ptr Adapter00](self.impl), nbytes)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBufferList)
  result.impl = impl0

proc gst_adapter_take_list(self: ptr Adapter00; nbytes: uint64): ptr glib.List {.
    importc, libprag.}

proc takeList*(self: Adapter; nbytes: uint64): seq[gst.Buffer] =
  let resul0 = gst_adapter_take_list(cast[ptr Adapter00](self.impl), nbytes)
  if resul0.isNil:
    return
  result = glistStructs2seq[gst.Buffer](resul0, false)
  g_list_free(resul0)

proc gst_adapter_unmap(self: ptr Adapter00) {.
    importc, libprag.}

proc unmap*(self: Adapter) =
  gst_adapter_unmap(cast[ptr Adapter00](self.impl))

type
  Aggregator* = ref object of gst.Element
  Aggregator00* = object of gst.Element00

proc gst_aggregator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Aggregator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scSamplesSelected*(self: Aggregator;  p: proc (self: ptr Aggregator00; segment: ptr gst.Segment00; pts: uint64; dts: uint64; duration: uint64;
    info: ptr gst.Structure00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "samples-selected", cast[GCallback](p), xdata, nil, cf)

proc gst_aggregator_finish_buffer(self: ptr Aggregator00; buffer: ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc finishBuffer*(self: Aggregator; buffer: gst.Buffer): gst.FlowReturn =
  gst_aggregator_finish_buffer(cast[ptr Aggregator00](self.impl), cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_aggregator_finish_buffer_list(self: ptr Aggregator00; bufferlist: ptr gst.BufferList00): gst.FlowReturn {.
    importc, libprag.}

proc finishBufferList*(self: Aggregator; bufferlist: gst.BufferList): gst.FlowReturn =
  gst_aggregator_finish_buffer_list(cast[ptr Aggregator00](self.impl), cast[ptr gst.BufferList00](g_boxed_copy(gst_buffer_list_get_type(), bufferlist.impl)))

proc gst_aggregator_get_allocator(self: ptr Aggregator00; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: Aggregator; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_aggregator_get_allocator(cast[ptr Aggregator00](self.impl), cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstbase.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_aggregator_get_buffer_pool(self: ptr Aggregator00): ptr gst.BufferPool00 {.
    importc, libprag.}

proc getBufferPool*(self: Aggregator): gst.BufferPool =
  let gobj = gst_aggregator_get_buffer_pool(cast[ptr Aggregator00](self.impl))
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

proc bufferPool*(self: Aggregator): gst.BufferPool =
  let gobj = gst_aggregator_get_buffer_pool(cast[ptr Aggregator00](self.impl))
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

proc gst_aggregator_get_latency(self: ptr Aggregator00): uint64 {.
    importc, libprag.}

proc getLatency*(self: Aggregator): uint64 =
  gst_aggregator_get_latency(cast[ptr Aggregator00](self.impl))

proc latency*(self: Aggregator): uint64 =
  gst_aggregator_get_latency(cast[ptr Aggregator00](self.impl))

proc gst_aggregator_negotiate(self: ptr Aggregator00): gboolean {.
    importc, libprag.}

proc negotiate*(self: Aggregator): bool =
  toBool(gst_aggregator_negotiate(cast[ptr Aggregator00](self.impl)))

proc gst_aggregator_selected_samples(self: ptr Aggregator00; pts: uint64;
    dts: uint64; duration: uint64; info: ptr gst.Structure00) {.
    importc, libprag.}

proc selectedSamples*(self: Aggregator; pts: uint64; dts: uint64;
    duration: uint64; info: gst.Structure = nil) =
  gst_aggregator_selected_samples(cast[ptr Aggregator00](self.impl), pts, dts, duration, if info.isNil: nil else: cast[ptr gst.Structure00](info.impl))

proc gst_aggregator_set_latency(self: ptr Aggregator00; minLatency: uint64;
    maxLatency: uint64) {.
    importc, libprag.}

proc setLatency*(self: Aggregator; minLatency: uint64; maxLatency: uint64) =
  gst_aggregator_set_latency(cast[ptr Aggregator00](self.impl), minLatency, maxLatency)

proc gst_aggregator_set_src_caps(self: ptr Aggregator00; caps: ptr gst.Caps00) {.
    importc, libprag.}

proc setSrcCaps*(self: Aggregator; caps: gst.Caps) =
  gst_aggregator_set_src_caps(cast[ptr Aggregator00](self.impl), cast[ptr gst.Caps00](caps.impl))

proc `srcCaps=`*(self: Aggregator; caps: gst.Caps) =
  gst_aggregator_set_src_caps(cast[ptr Aggregator00](self.impl), cast[ptr gst.Caps00](caps.impl))

proc gst_aggregator_simple_get_next_time(self: ptr Aggregator00): uint64 {.
    importc, libprag.}

proc simpleGetNextTime*(self: Aggregator): uint64 =
  gst_aggregator_simple_get_next_time(cast[ptr Aggregator00](self.impl))

proc gst_aggregator_update_segment(self: ptr Aggregator00; segment: ptr gst.Segment00) {.
    importc, libprag.}

proc updateSegment*(self: Aggregator; segment: gst.Segment) =
  gst_aggregator_update_segment(cast[ptr Aggregator00](self.impl), cast[ptr gst.Segment00](segment.impl))

type
  AggregatorPad* = ref object of gst.Pad
  AggregatorPad00* = object of gst.Pad00

proc gst_aggregator_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AggregatorPad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scBufferConsumed*(self: AggregatorPad;  p: proc (self: ptr AggregatorPad00; `object`: ptr gst.Buffer00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "buffer-consumed", cast[GCallback](p), xdata, nil, cf)

proc gst_aggregator_pad_drop_buffer(self: ptr AggregatorPad00): gboolean {.
    importc, libprag.}

proc dropBuffer*(self: AggregatorPad): bool =
  toBool(gst_aggregator_pad_drop_buffer(cast[ptr AggregatorPad00](self.impl)))

proc gst_aggregator_pad_has_buffer(self: ptr AggregatorPad00): gboolean {.
    importc, libprag.}

proc hasBuffer*(self: AggregatorPad): bool =
  toBool(gst_aggregator_pad_has_buffer(cast[ptr AggregatorPad00](self.impl)))

proc gst_aggregator_pad_is_eos(self: ptr AggregatorPad00): gboolean {.
    importc, libprag.}

proc isEos*(self: AggregatorPad): bool =
  toBool(gst_aggregator_pad_is_eos(cast[ptr AggregatorPad00](self.impl)))

proc gst_aggregator_pad_peek_buffer(self: ptr AggregatorPad00): ptr gst.Buffer00 {.
    importc, libprag.}

proc peekBuffer*(self: AggregatorPad): gst.Buffer =
  let impl0 = gst_aggregator_pad_peek_buffer(cast[ptr AggregatorPad00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_aggregator_pad_pop_buffer(self: ptr AggregatorPad00): ptr gst.Buffer00 {.
    importc, libprag.}

proc popBuffer*(self: AggregatorPad): gst.Buffer =
  let impl0 = gst_aggregator_pad_pop_buffer(cast[ptr AggregatorPad00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_aggregator_peek_next_sample(self: ptr Aggregator00; pad: ptr AggregatorPad00): ptr gst.Sample00 {.
    importc, libprag.}

proc peekNextSample*(self: Aggregator; pad: AggregatorPad): gst.Sample =
  let impl0 = gst_aggregator_peek_next_sample(cast[ptr Aggregator00](self.impl), cast[ptr AggregatorPad00](pad.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstSample)
  result.impl = impl0

type
  AggregatorStartTimeSelection* {.size: sizeof(cint), pure.} = enum
    zero = 0
    first = 1
    set = 2

const BASE_PARSE_FLAG_DRAINING* = 2'i32

const BASE_PARSE_FLAG_LOST_SYNC* = 1'i32

const BASE_TRANSFORM_SINK_NAME* = "sink"

const BASE_TRANSFORM_SRC_NAME* = "src"

type
  BaseParse* = ref object of gst.Element
  BaseParse00* = object of gst.Element00

proc gst_base_parse_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BaseParse()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_base_parse_add_index_entry(self: ptr BaseParse00; offset: uint64;
    ts: uint64; key: gboolean; force: gboolean): gboolean {.
    importc, libprag.}

proc addIndexEntry*(self: BaseParse; offset: uint64; ts: uint64;
    key: bool; force: bool): bool =
  toBool(gst_base_parse_add_index_entry(cast[ptr BaseParse00](self.impl), offset, ts, gboolean(key), gboolean(force)))

proc gst_base_parse_convert_default(self: ptr BaseParse00; srcFormat: gst.Format;
    srcValue: int64; destFormat: gst.Format; destValue: var int64): gboolean {.
    importc, libprag.}

proc convertDefault*(self: BaseParse; srcFormat: gst.Format;
    srcValue: int64; destFormat: gst.Format; destValue: var int64): bool =
  toBool(gst_base_parse_convert_default(cast[ptr BaseParse00](self.impl), srcFormat, srcValue, destFormat, destValue))

proc gst_base_parse_drain(self: ptr BaseParse00) {.
    importc, libprag.}

proc drain*(self: BaseParse) =
  gst_base_parse_drain(cast[ptr BaseParse00](self.impl))

proc gst_base_parse_merge_tags(self: ptr BaseParse00; tags: ptr gst.TagList00;
    mode: gst.TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: BaseParse; tags: gst.TagList = nil;
    mode: gst.TagMergeMode) =
  gst_base_parse_merge_tags(cast[ptr BaseParse00](self.impl), if tags.isNil: nil else: cast[ptr gst.TagList00](tags.impl), mode)

proc gst_base_parse_set_average_bitrate(self: ptr BaseParse00; bitrate: uint32) {.
    importc, libprag.}

proc setAverageBitrate*(self: BaseParse; bitrate: int) =
  gst_base_parse_set_average_bitrate(cast[ptr BaseParse00](self.impl), uint32(bitrate))

proc `averageBitrate=`*(self: BaseParse; bitrate: int) =
  gst_base_parse_set_average_bitrate(cast[ptr BaseParse00](self.impl), uint32(bitrate))

proc gst_base_parse_set_duration(self: ptr BaseParse00; fmt: gst.Format;
    duration: int64; interval: int32) {.
    importc, libprag.}

proc setDuration*(self: BaseParse; fmt: gst.Format; duration: int64;
    interval: int) =
  gst_base_parse_set_duration(cast[ptr BaseParse00](self.impl), fmt, duration, int32(interval))

proc gst_base_parse_set_frame_rate(self: ptr BaseParse00; fpsNum: uint32;
    fpsDen: uint32; leadIn: uint32; leadOut: uint32) {.
    importc, libprag.}

proc setFrameRate*(self: BaseParse; fpsNum: int; fpsDen: int;
    leadIn: int; leadOut: int) =
  gst_base_parse_set_frame_rate(cast[ptr BaseParse00](self.impl), uint32(fpsNum), uint32(fpsDen), uint32(leadIn), uint32(leadOut))

proc gst_base_parse_set_has_timing_info(self: ptr BaseParse00; hasTiming: gboolean) {.
    importc, libprag.}

proc setHasTimingInfo*(self: BaseParse; hasTiming: bool = true) =
  gst_base_parse_set_has_timing_info(cast[ptr BaseParse00](self.impl), gboolean(hasTiming))

proc `hasTimingInfo=`*(self: BaseParse; hasTiming: bool) =
  gst_base_parse_set_has_timing_info(cast[ptr BaseParse00](self.impl), gboolean(hasTiming))

proc gst_base_parse_set_infer_ts(self: ptr BaseParse00; inferTs: gboolean) {.
    importc, libprag.}

proc setInferTs*(self: BaseParse; inferTs: bool = true) =
  gst_base_parse_set_infer_ts(cast[ptr BaseParse00](self.impl), gboolean(inferTs))

proc `inferTs=`*(self: BaseParse; inferTs: bool) =
  gst_base_parse_set_infer_ts(cast[ptr BaseParse00](self.impl), gboolean(inferTs))

proc gst_base_parse_set_latency(self: ptr BaseParse00; minLatency: uint64;
    maxLatency: uint64) {.
    importc, libprag.}

proc setLatency*(self: BaseParse; minLatency: uint64; maxLatency: uint64) =
  gst_base_parse_set_latency(cast[ptr BaseParse00](self.impl), minLatency, maxLatency)

proc gst_base_parse_set_min_frame_size(self: ptr BaseParse00; minSize: uint32) {.
    importc, libprag.}

proc setMinFrameSize*(self: BaseParse; minSize: int) =
  gst_base_parse_set_min_frame_size(cast[ptr BaseParse00](self.impl), uint32(minSize))

proc `minFrameSize=`*(self: BaseParse; minSize: int) =
  gst_base_parse_set_min_frame_size(cast[ptr BaseParse00](self.impl), uint32(minSize))

proc gst_base_parse_set_passthrough(self: ptr BaseParse00; passthrough: gboolean) {.
    importc, libprag.}

proc setPassthrough*(self: BaseParse; passthrough: bool = true) =
  gst_base_parse_set_passthrough(cast[ptr BaseParse00](self.impl), gboolean(passthrough))

proc `passthrough=`*(self: BaseParse; passthrough: bool) =
  gst_base_parse_set_passthrough(cast[ptr BaseParse00](self.impl), gboolean(passthrough))

proc gst_base_parse_set_pts_interpolation(self: ptr BaseParse00; ptsInterpolate: gboolean) {.
    importc, libprag.}

proc setPtsInterpolation*(self: BaseParse; ptsInterpolate: bool = true) =
  gst_base_parse_set_pts_interpolation(cast[ptr BaseParse00](self.impl), gboolean(ptsInterpolate))

proc `ptsInterpolation=`*(self: BaseParse; ptsInterpolate: bool) =
  gst_base_parse_set_pts_interpolation(cast[ptr BaseParse00](self.impl), gboolean(ptsInterpolate))

proc gst_base_parse_set_syncable(self: ptr BaseParse00; syncable: gboolean) {.
    importc, libprag.}

proc setSyncable*(self: BaseParse; syncable: bool = true) =
  gst_base_parse_set_syncable(cast[ptr BaseParse00](self.impl), gboolean(syncable))

proc `syncable=`*(self: BaseParse; syncable: bool) =
  gst_base_parse_set_syncable(cast[ptr BaseParse00](self.impl), gboolean(syncable))

proc gst_base_parse_set_ts_at_offset(self: ptr BaseParse00; offset: uint64) {.
    importc, libprag.}

proc setTsAtOffset*(self: BaseParse; offset: uint64) =
  gst_base_parse_set_ts_at_offset(cast[ptr BaseParse00](self.impl), offset)

proc `tsAtOffset=`*(self: BaseParse; offset: uint64) =
  gst_base_parse_set_ts_at_offset(cast[ptr BaseParse00](self.impl), offset)

type
  BaseParseFrame00* {.pure.} = object
  BaseParseFrame* = ref object
    impl*: ptr BaseParseFrame00
    ignoreFinalizer*: bool

proc gst_base_parse_frame_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstBaseParseFrame*(self: BaseParseFrame) =
  if not self.ignoreFinalizer:
    boxedFree(gst_base_parse_frame_get_type(), cast[ptr BaseParseFrame00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BaseParseFrame()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_base_parse_frame_get_type(), cast[ptr BaseParseFrame00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var BaseParseFrame) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstBaseParseFrame)

proc gst_base_parse_frame_free(self: ptr BaseParseFrame00) {.
    importc, libprag.}

proc free*(self: BaseParseFrame) =
  gst_base_parse_frame_free(cast[ptr BaseParseFrame00](self.impl))

proc finalizerfree*(self: BaseParseFrame) =
  if not self.ignoreFinalizer:
    gst_base_parse_frame_free(cast[ptr BaseParseFrame00](self.impl))

proc gst_base_parse_frame_copy(self: ptr BaseParseFrame00): ptr BaseParseFrame00 {.
    importc, libprag.}

proc copy*(self: BaseParseFrame): BaseParseFrame =
  fnew(result, gBoxedFreeGstBaseParseFrame)
  result.impl = gst_base_parse_frame_copy(cast[ptr BaseParseFrame00](self.impl))

proc gst_base_parse_frame_init(self: ptr BaseParseFrame00) {.
    importc, libprag.}

proc init*(self: BaseParseFrame) =
  gst_base_parse_frame_init(cast[ptr BaseParseFrame00](self.impl))

proc gst_base_parse_finish_frame(self: ptr BaseParse00; frame: ptr BaseParseFrame00;
    size: int32): gst.FlowReturn {.
    importc, libprag.}

proc finishFrame*(self: BaseParse; frame: BaseParseFrame;
    size: int): gst.FlowReturn =
  gst_base_parse_finish_frame(cast[ptr BaseParse00](self.impl), cast[ptr BaseParseFrame00](frame.impl), int32(size))

proc gst_base_parse_push_frame(self: ptr BaseParse00; frame: ptr BaseParseFrame00): gst.FlowReturn {.
    importc, libprag.}

proc pushFrame*(self: BaseParse; frame: BaseParseFrame): gst.FlowReturn =
  gst_base_parse_push_frame(cast[ptr BaseParse00](self.impl), cast[ptr BaseParseFrame00](frame.impl))

type
  BaseParseFrameFlag* {.size: sizeof(cint), pure.} = enum
    newFrame = 0
    noFrame = 1
    clip = 2
    drop = 3
    queue = 4

  BaseParseFrameFlags* {.size: sizeof(cint).} = set[BaseParseFrameFlag]

const
  BaseParseFrameFlagsNone* = BaseParseFrameFlags({})
proc none*(t: typedesc[BaseParseFrameFlags]): BaseParseFrameFlags = BaseParseFrameFlags({})

proc gst_base_parse_frame_new(buffer: ptr gst.Buffer00; flags: BaseParseFrameFlags;
    overhead: int32): ptr BaseParseFrame00 {.
    importc, libprag.}

proc newBaseParseFrame*(buffer: gst.Buffer; flags: BaseParseFrameFlags;
    overhead: int): BaseParseFrame =
  fnew(result, gBoxedFreeGstBaseParseFrame)
  result.impl = gst_base_parse_frame_new(cast[ptr gst.Buffer00](buffer.impl), flags, int32(overhead))

proc newBaseParseFrame*(tdesc: typedesc; buffer: gst.Buffer; flags: BaseParseFrameFlags;
    overhead: int): tdesc =
  assert(result is BaseParseFrame)
  fnew(result, gBoxedFreeGstBaseParseFrame)
  result.impl = gst_base_parse_frame_new(cast[ptr gst.Buffer00](buffer.impl), flags, int32(overhead))

proc initBaseParseFrame*[T](result: var T; buffer: gst.Buffer; flags: BaseParseFrameFlags;
    overhead: int) {.deprecated.} =
  assert(result is BaseParseFrame)
  fnew(result, gBoxedFreeGstBaseParseFrame)
  result.impl = gst_base_parse_frame_new(cast[ptr gst.Buffer00](buffer.impl), flags, int32(overhead))

type
  BaseSink* = ref object of gst.Element
  BaseSink00* = object of gst.Element00

proc gst_base_sink_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BaseSink()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_base_sink_do_preroll(self: ptr BaseSink00; obj: ptr gst.MiniObject00): gst.FlowReturn {.
    importc, libprag.}

proc doPreroll*(self: BaseSink; obj: gst.MiniObject): gst.FlowReturn =
  gst_base_sink_do_preroll(cast[ptr BaseSink00](self.impl), cast[ptr gst.MiniObject00](obj.impl))

proc gst_base_sink_get_blocksize(self: ptr BaseSink00): uint32 {.
    importc, libprag.}

proc getBlocksize*(self: BaseSink): int =
  int(gst_base_sink_get_blocksize(cast[ptr BaseSink00](self.impl)))

proc blocksize*(self: BaseSink): int =
  int(gst_base_sink_get_blocksize(cast[ptr BaseSink00](self.impl)))

proc gst_base_sink_get_drop_out_of_segment(self: ptr BaseSink00): gboolean {.
    importc, libprag.}

proc getDropOutOfSegment*(self: BaseSink): bool =
  toBool(gst_base_sink_get_drop_out_of_segment(cast[ptr BaseSink00](self.impl)))

proc dropOutOfSegment*(self: BaseSink): bool =
  toBool(gst_base_sink_get_drop_out_of_segment(cast[ptr BaseSink00](self.impl)))

proc gst_base_sink_get_last_sample(self: ptr BaseSink00): ptr gst.Sample00 {.
    importc, libprag.}

proc getLastSample*(self: BaseSink): gst.Sample =
  let impl0 = gst_base_sink_get_last_sample(cast[ptr BaseSink00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstSample)
  result.impl = impl0

proc lastSample*(self: BaseSink): gst.Sample =
  let impl0 = gst_base_sink_get_last_sample(cast[ptr BaseSink00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstSample)
  result.impl = impl0

proc gst_base_sink_get_latency(self: ptr BaseSink00): uint64 {.
    importc, libprag.}

proc getLatency*(self: BaseSink): uint64 =
  gst_base_sink_get_latency(cast[ptr BaseSink00](self.impl))

proc latency*(self: BaseSink): uint64 =
  gst_base_sink_get_latency(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_get_max_bitrate(self: ptr BaseSink00): uint64 {.
    importc, libprag.}

proc getMaxBitrate*(self: BaseSink): uint64 =
  gst_base_sink_get_max_bitrate(cast[ptr BaseSink00](self.impl))

proc maxBitrate*(self: BaseSink): uint64 =
  gst_base_sink_get_max_bitrate(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_get_max_lateness(self: ptr BaseSink00): int64 {.
    importc, libprag.}

proc getMaxLateness*(self: BaseSink): int64 =
  gst_base_sink_get_max_lateness(cast[ptr BaseSink00](self.impl))

proc maxLateness*(self: BaseSink): int64 =
  gst_base_sink_get_max_lateness(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_get_processing_deadline(self: ptr BaseSink00): uint64 {.
    importc, libprag.}

proc getProcessingDeadline*(self: BaseSink): uint64 =
  gst_base_sink_get_processing_deadline(cast[ptr BaseSink00](self.impl))

proc processingDeadline*(self: BaseSink): uint64 =
  gst_base_sink_get_processing_deadline(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_get_render_delay(self: ptr BaseSink00): uint64 {.
    importc, libprag.}

proc getRenderDelay*(self: BaseSink): uint64 =
  gst_base_sink_get_render_delay(cast[ptr BaseSink00](self.impl))

proc renderDelay*(self: BaseSink): uint64 =
  gst_base_sink_get_render_delay(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_get_stats(self: ptr BaseSink00): ptr gst.Structure00 {.
    importc, libprag.}

proc getStats*(self: BaseSink): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_base_sink_get_stats(cast[ptr BaseSink00](self.impl))

proc stats*(self: BaseSink): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_base_sink_get_stats(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_get_sync(self: ptr BaseSink00): gboolean {.
    importc, libprag.}

proc getSync*(self: BaseSink): bool =
  toBool(gst_base_sink_get_sync(cast[ptr BaseSink00](self.impl)))

proc sync*(self: BaseSink): bool =
  toBool(gst_base_sink_get_sync(cast[ptr BaseSink00](self.impl)))

proc gst_base_sink_get_throttle_time(self: ptr BaseSink00): uint64 {.
    importc, libprag.}

proc getThrottleTime*(self: BaseSink): uint64 =
  gst_base_sink_get_throttle_time(cast[ptr BaseSink00](self.impl))

proc throttleTime*(self: BaseSink): uint64 =
  gst_base_sink_get_throttle_time(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_get_ts_offset(self: ptr BaseSink00): int64 {.
    importc, libprag.}

proc getTsOffset*(self: BaseSink): int64 =
  gst_base_sink_get_ts_offset(cast[ptr BaseSink00](self.impl))

proc tsOffset*(self: BaseSink): int64 =
  gst_base_sink_get_ts_offset(cast[ptr BaseSink00](self.impl))

proc gst_base_sink_is_async_enabled(self: ptr BaseSink00): gboolean {.
    importc, libprag.}

proc isAsyncEnabled*(self: BaseSink): bool =
  toBool(gst_base_sink_is_async_enabled(cast[ptr BaseSink00](self.impl)))

proc gst_base_sink_is_last_sample_enabled(self: ptr BaseSink00): gboolean {.
    importc, libprag.}

proc isLastSampleEnabled*(self: BaseSink): bool =
  toBool(gst_base_sink_is_last_sample_enabled(cast[ptr BaseSink00](self.impl)))

proc gst_base_sink_is_qos_enabled(self: ptr BaseSink00): gboolean {.
    importc, libprag.}

proc isQosEnabled*(self: BaseSink): bool =
  toBool(gst_base_sink_is_qos_enabled(cast[ptr BaseSink00](self.impl)))

proc gst_base_sink_query_latency(self: ptr BaseSink00; live: var gboolean;
    upstreamLive: var gboolean; minLatency: var uint64; maxLatency: var uint64): gboolean {.
    importc, libprag.}

proc queryLatency*(self: BaseSink; live: var bool = cast[var bool](nil);
    upstreamLive: var bool = cast[var bool](nil); minLatency: var uint64 = cast[var uint64](nil);
    maxLatency: var uint64 = cast[var uint64](nil)): bool =
  var upstreamLive_00: gboolean
  var live_00: gboolean
  result = toBool(gst_base_sink_query_latency(cast[ptr BaseSink00](self.impl), live_00, upstreamLive_00, minLatency, maxLatency))
  if upstreamLive.addr != nil:
    upstreamLive = toBool(upstreamLive_00)
  if live.addr != nil:
    live = toBool(live_00)

proc gst_base_sink_set_async_enabled(self: ptr BaseSink00; enabled: gboolean) {.
    importc, libprag.}

proc setAsyncEnabled*(self: BaseSink; enabled: bool = true) =
  gst_base_sink_set_async_enabled(cast[ptr BaseSink00](self.impl), gboolean(enabled))

proc `asyncEnabled=`*(self: BaseSink; enabled: bool) =
  gst_base_sink_set_async_enabled(cast[ptr BaseSink00](self.impl), gboolean(enabled))

proc gst_base_sink_set_blocksize(self: ptr BaseSink00; blocksize: uint32) {.
    importc, libprag.}

proc setBlocksize*(self: BaseSink; blocksize: int) =
  gst_base_sink_set_blocksize(cast[ptr BaseSink00](self.impl), uint32(blocksize))

proc `blocksize=`*(self: BaseSink; blocksize: int) =
  gst_base_sink_set_blocksize(cast[ptr BaseSink00](self.impl), uint32(blocksize))

proc gst_base_sink_set_drop_out_of_segment(self: ptr BaseSink00; dropOutOfSegment: gboolean) {.
    importc, libprag.}

proc setDropOutOfSegment*(self: BaseSink; dropOutOfSegment: bool = true) =
  gst_base_sink_set_drop_out_of_segment(cast[ptr BaseSink00](self.impl), gboolean(dropOutOfSegment))

proc `dropOutOfSegment=`*(self: BaseSink; dropOutOfSegment: bool) =
  gst_base_sink_set_drop_out_of_segment(cast[ptr BaseSink00](self.impl), gboolean(dropOutOfSegment))

proc gst_base_sink_set_last_sample_enabled(self: ptr BaseSink00; enabled: gboolean) {.
    importc, libprag.}

proc setLastSampleEnabled*(self: BaseSink; enabled: bool = true) =
  gst_base_sink_set_last_sample_enabled(cast[ptr BaseSink00](self.impl), gboolean(enabled))

proc `lastSampleEnabled=`*(self: BaseSink; enabled: bool) =
  gst_base_sink_set_last_sample_enabled(cast[ptr BaseSink00](self.impl), gboolean(enabled))

proc gst_base_sink_set_max_bitrate(self: ptr BaseSink00; maxBitrate: uint64) {.
    importc, libprag.}

proc setMaxBitrate*(self: BaseSink; maxBitrate: uint64) =
  gst_base_sink_set_max_bitrate(cast[ptr BaseSink00](self.impl), maxBitrate)

proc `maxBitrate=`*(self: BaseSink; maxBitrate: uint64) =
  gst_base_sink_set_max_bitrate(cast[ptr BaseSink00](self.impl), maxBitrate)

proc gst_base_sink_set_max_lateness(self: ptr BaseSink00; maxLateness: int64) {.
    importc, libprag.}

proc setMaxLateness*(self: BaseSink; maxLateness: int64) =
  gst_base_sink_set_max_lateness(cast[ptr BaseSink00](self.impl), maxLateness)

proc `maxLateness=`*(self: BaseSink; maxLateness: int64) =
  gst_base_sink_set_max_lateness(cast[ptr BaseSink00](self.impl), maxLateness)

proc gst_base_sink_set_processing_deadline(self: ptr BaseSink00; processingDeadline: uint64) {.
    importc, libprag.}

proc setProcessingDeadline*(self: BaseSink; processingDeadline: uint64) =
  gst_base_sink_set_processing_deadline(cast[ptr BaseSink00](self.impl), processingDeadline)

proc `processingDeadline=`*(self: BaseSink; processingDeadline: uint64) =
  gst_base_sink_set_processing_deadline(cast[ptr BaseSink00](self.impl), processingDeadline)

proc gst_base_sink_set_qos_enabled(self: ptr BaseSink00; enabled: gboolean) {.
    importc, libprag.}

proc setQosEnabled*(self: BaseSink; enabled: bool = true) =
  gst_base_sink_set_qos_enabled(cast[ptr BaseSink00](self.impl), gboolean(enabled))

proc `qosEnabled=`*(self: BaseSink; enabled: bool) =
  gst_base_sink_set_qos_enabled(cast[ptr BaseSink00](self.impl), gboolean(enabled))

proc gst_base_sink_set_render_delay(self: ptr BaseSink00; delay: uint64) {.
    importc, libprag.}

proc setRenderDelay*(self: BaseSink; delay: uint64) =
  gst_base_sink_set_render_delay(cast[ptr BaseSink00](self.impl), delay)

proc `renderDelay=`*(self: BaseSink; delay: uint64) =
  gst_base_sink_set_render_delay(cast[ptr BaseSink00](self.impl), delay)

proc gst_base_sink_set_sync(self: ptr BaseSink00; sync: gboolean) {.
    importc, libprag.}

proc setSync*(self: BaseSink; sync: bool = true) =
  gst_base_sink_set_sync(cast[ptr BaseSink00](self.impl), gboolean(sync))

proc `sync=`*(self: BaseSink; sync: bool) =
  gst_base_sink_set_sync(cast[ptr BaseSink00](self.impl), gboolean(sync))

proc gst_base_sink_set_throttle_time(self: ptr BaseSink00; throttle: uint64) {.
    importc, libprag.}

proc setThrottleTime*(self: BaseSink; throttle: uint64) =
  gst_base_sink_set_throttle_time(cast[ptr BaseSink00](self.impl), throttle)

proc `throttleTime=`*(self: BaseSink; throttle: uint64) =
  gst_base_sink_set_throttle_time(cast[ptr BaseSink00](self.impl), throttle)

proc gst_base_sink_set_ts_offset(self: ptr BaseSink00; offset: int64) {.
    importc, libprag.}

proc setTsOffset*(self: BaseSink; offset: int64) =
  gst_base_sink_set_ts_offset(cast[ptr BaseSink00](self.impl), offset)

proc `tsOffset=`*(self: BaseSink; offset: int64) =
  gst_base_sink_set_ts_offset(cast[ptr BaseSink00](self.impl), offset)

proc gst_base_sink_wait(self: ptr BaseSink00; time: uint64; jitter: var int64): gst.FlowReturn {.
    importc, libprag.}

proc wait*(self: BaseSink; time: uint64; jitter: var int64 = cast[var int64](nil)): gst.FlowReturn =
  gst_base_sink_wait(cast[ptr BaseSink00](self.impl), time, jitter)

proc gst_base_sink_wait_clock(self: ptr BaseSink00; time: uint64; jitter: var int64): gst.ClockReturn {.
    importc, libprag.}

proc waitClock*(self: BaseSink; time: uint64; jitter: var int64 = cast[var int64](nil)): gst.ClockReturn =
  gst_base_sink_wait_clock(cast[ptr BaseSink00](self.impl), time, jitter)

proc gst_base_sink_wait_preroll(self: ptr BaseSink00): gst.FlowReturn {.
    importc, libprag.}

proc waitPreroll*(self: BaseSink): gst.FlowReturn =
  gst_base_sink_wait_preroll(cast[ptr BaseSink00](self.impl))

type
  BaseSrc* = ref object of gst.Element
  BaseSrc00* = object of gst.Element00

proc gst_base_src_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BaseSrc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_base_src_get_allocator(self: ptr BaseSrc00; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: BaseSrc; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_base_src_get_allocator(cast[ptr BaseSrc00](self.impl), cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstbase.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_base_src_get_blocksize(self: ptr BaseSrc00): uint32 {.
    importc, libprag.}

proc getBlocksize*(self: BaseSrc): int =
  int(gst_base_src_get_blocksize(cast[ptr BaseSrc00](self.impl)))

proc blocksize*(self: BaseSrc): int =
  int(gst_base_src_get_blocksize(cast[ptr BaseSrc00](self.impl)))

proc gst_base_src_get_buffer_pool(self: ptr BaseSrc00): ptr gst.BufferPool00 {.
    importc, libprag.}

proc getBufferPool*(self: BaseSrc): gst.BufferPool =
  let gobj = gst_base_src_get_buffer_pool(cast[ptr BaseSrc00](self.impl))
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

proc bufferPool*(self: BaseSrc): gst.BufferPool =
  let gobj = gst_base_src_get_buffer_pool(cast[ptr BaseSrc00](self.impl))
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

proc gst_base_src_get_do_timestamp(self: ptr BaseSrc00): gboolean {.
    importc, libprag.}

proc getDoTimestamp*(self: BaseSrc): bool =
  toBool(gst_base_src_get_do_timestamp(cast[ptr BaseSrc00](self.impl)))

proc doTimestamp*(self: BaseSrc): bool =
  toBool(gst_base_src_get_do_timestamp(cast[ptr BaseSrc00](self.impl)))

proc gst_base_src_is_async(self: ptr BaseSrc00): gboolean {.
    importc, libprag.}

proc isAsync*(self: BaseSrc): bool =
  toBool(gst_base_src_is_async(cast[ptr BaseSrc00](self.impl)))

proc gst_base_src_is_live(self: ptr BaseSrc00): gboolean {.
    importc, libprag.}

proc isLive*(self: BaseSrc): bool =
  toBool(gst_base_src_is_live(cast[ptr BaseSrc00](self.impl)))

proc gst_base_src_negotiate(self: ptr BaseSrc00): gboolean {.
    importc, libprag.}

proc negotiate*(self: BaseSrc): bool =
  toBool(gst_base_src_negotiate(cast[ptr BaseSrc00](self.impl)))

proc gst_base_src_new_seamless_segment(self: ptr BaseSrc00; start: int64;
    stop: int64; time: int64): gboolean {.
    importc, libprag.}

proc newSeamlessSegment*(self: BaseSrc; start: int64; stop: int64;
    time: int64): bool =
  toBool(gst_base_src_new_seamless_segment(cast[ptr BaseSrc00](self.impl), start, stop, time))

proc gst_base_src_new_segment(self: ptr BaseSrc00; segment: ptr gst.Segment00): gboolean {.
    importc, libprag.}

proc newSegment*(self: BaseSrc; segment: gst.Segment): bool =
  toBool(gst_base_src_new_segment(cast[ptr BaseSrc00](self.impl), cast[ptr gst.Segment00](segment.impl)))

proc gst_base_src_query_latency(self: ptr BaseSrc00; live: var gboolean;
    minLatency: var uint64; maxLatency: var uint64): gboolean {.
    importc, libprag.}

proc queryLatency*(self: BaseSrc; live: var bool = cast[var bool](nil);
    minLatency: var uint64 = cast[var uint64](nil); maxLatency: var uint64 = cast[var uint64](nil)): bool =
  var live_00: gboolean
  result = toBool(gst_base_src_query_latency(cast[ptr BaseSrc00](self.impl), live_00, minLatency, maxLatency))
  if live.addr != nil:
    live = toBool(live_00)

proc gst_base_src_set_async(self: ptr BaseSrc00; async: gboolean) {.
    importc, libprag.}

proc setAsync*(self: BaseSrc; async: bool = true) =
  gst_base_src_set_async(cast[ptr BaseSrc00](self.impl), gboolean(async))

proc `async=`*(self: BaseSrc; async: bool) =
  gst_base_src_set_async(cast[ptr BaseSrc00](self.impl), gboolean(async))

proc gst_base_src_set_automatic_eos(self: ptr BaseSrc00; automaticEos: gboolean) {.
    importc, libprag.}

proc setAutomaticEos*(self: BaseSrc; automaticEos: bool = true) =
  gst_base_src_set_automatic_eos(cast[ptr BaseSrc00](self.impl), gboolean(automaticEos))

proc `automaticEos=`*(self: BaseSrc; automaticEos: bool) =
  gst_base_src_set_automatic_eos(cast[ptr BaseSrc00](self.impl), gboolean(automaticEos))

proc gst_base_src_set_blocksize(self: ptr BaseSrc00; blocksize: uint32) {.
    importc, libprag.}

proc setBlocksize*(self: BaseSrc; blocksize: int) =
  gst_base_src_set_blocksize(cast[ptr BaseSrc00](self.impl), uint32(blocksize))

proc `blocksize=`*(self: BaseSrc; blocksize: int) =
  gst_base_src_set_blocksize(cast[ptr BaseSrc00](self.impl), uint32(blocksize))

proc gst_base_src_set_caps(self: ptr BaseSrc00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc setCaps*(self: BaseSrc; caps: gst.Caps): bool =
  toBool(gst_base_src_set_caps(cast[ptr BaseSrc00](self.impl), cast[ptr gst.Caps00](caps.impl)))

proc gst_base_src_set_do_timestamp(self: ptr BaseSrc00; timestamp: gboolean) {.
    importc, libprag.}

proc setDoTimestamp*(self: BaseSrc; timestamp: bool = true) =
  gst_base_src_set_do_timestamp(cast[ptr BaseSrc00](self.impl), gboolean(timestamp))

proc `doTimestamp=`*(self: BaseSrc; timestamp: bool) =
  gst_base_src_set_do_timestamp(cast[ptr BaseSrc00](self.impl), gboolean(timestamp))

proc gst_base_src_set_dynamic_size(self: ptr BaseSrc00; dynamic: gboolean) {.
    importc, libprag.}

proc setDynamicSize*(self: BaseSrc; dynamic: bool = true) =
  gst_base_src_set_dynamic_size(cast[ptr BaseSrc00](self.impl), gboolean(dynamic))

proc `dynamicSize=`*(self: BaseSrc; dynamic: bool) =
  gst_base_src_set_dynamic_size(cast[ptr BaseSrc00](self.impl), gboolean(dynamic))

proc gst_base_src_set_format(self: ptr BaseSrc00; format: gst.Format) {.
    importc, libprag.}

proc setFormat*(self: BaseSrc; format: gst.Format) =
  gst_base_src_set_format(cast[ptr BaseSrc00](self.impl), format)

proc `format=`*(self: BaseSrc; format: gst.Format) =
  gst_base_src_set_format(cast[ptr BaseSrc00](self.impl), format)

proc gst_base_src_set_live(self: ptr BaseSrc00; live: gboolean) {.
    importc, libprag.}

proc setLive*(self: BaseSrc; live: bool = true) =
  gst_base_src_set_live(cast[ptr BaseSrc00](self.impl), gboolean(live))

proc `live=`*(self: BaseSrc; live: bool) =
  gst_base_src_set_live(cast[ptr BaseSrc00](self.impl), gboolean(live))

proc gst_base_src_start_complete(self: ptr BaseSrc00; ret: gst.FlowReturn) {.
    importc, libprag.}

proc startComplete*(self: BaseSrc; ret: gst.FlowReturn) =
  gst_base_src_start_complete(cast[ptr BaseSrc00](self.impl), ret)

proc gst_base_src_start_wait(self: ptr BaseSrc00): gst.FlowReturn {.
    importc, libprag.}

proc startWait*(self: BaseSrc): gst.FlowReturn =
  gst_base_src_start_wait(cast[ptr BaseSrc00](self.impl))

proc gst_base_src_submit_buffer_list(self: ptr BaseSrc00; bufferList: ptr gst.BufferList00) {.
    importc, libprag.}

proc submitBufferList*(self: BaseSrc; bufferList: gst.BufferList) =
  gst_base_src_submit_buffer_list(cast[ptr BaseSrc00](self.impl), cast[ptr gst.BufferList00](g_boxed_copy(gst_buffer_list_get_type(), bufferList.impl)))

proc gst_base_src_wait_playing(self: ptr BaseSrc00): gst.FlowReturn {.
    importc, libprag.}

proc waitPlaying*(self: BaseSrc): gst.FlowReturn =
  gst_base_src_wait_playing(cast[ptr BaseSrc00](self.impl))

type
  BaseSrcFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    starting = 14
    started = 15
    last = 20

  BaseSrcFlags* {.size: sizeof(cint).} = set[BaseSrcFlag]

type
  BaseTransform* = ref object of gst.Element
  BaseTransform00* = object of gst.Element00

proc gst_base_transform_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BaseTransform()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_base_transform_get_allocator(self: ptr BaseTransform00; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: BaseTransform; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_base_transform_get_allocator(cast[ptr BaseTransform00](self.impl), cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstbase.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_base_transform_get_buffer_pool(self: ptr BaseTransform00): ptr gst.BufferPool00 {.
    importc, libprag.}

proc getBufferPool*(self: BaseTransform): gst.BufferPool =
  let gobj = gst_base_transform_get_buffer_pool(cast[ptr BaseTransform00](self.impl))
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

proc bufferPool*(self: BaseTransform): gst.BufferPool =
  let gobj = gst_base_transform_get_buffer_pool(cast[ptr BaseTransform00](self.impl))
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

proc gst_base_transform_is_in_place(self: ptr BaseTransform00): gboolean {.
    importc, libprag.}

proc isInPlace*(self: BaseTransform): bool =
  toBool(gst_base_transform_is_in_place(cast[ptr BaseTransform00](self.impl)))

proc gst_base_transform_is_passthrough(self: ptr BaseTransform00): gboolean {.
    importc, libprag.}

proc isPassthrough*(self: BaseTransform): bool =
  toBool(gst_base_transform_is_passthrough(cast[ptr BaseTransform00](self.impl)))

proc gst_base_transform_is_qos_enabled(self: ptr BaseTransform00): gboolean {.
    importc, libprag.}

proc isQosEnabled*(self: BaseTransform): bool =
  toBool(gst_base_transform_is_qos_enabled(cast[ptr BaseTransform00](self.impl)))

proc gst_base_transform_reconfigure(self: ptr BaseTransform00): gboolean {.
    importc, libprag.}

proc reconfigure*(self: BaseTransform): bool =
  toBool(gst_base_transform_reconfigure(cast[ptr BaseTransform00](self.impl)))

proc gst_base_transform_reconfigure_sink(self: ptr BaseTransform00) {.
    importc, libprag.}

proc reconfigureSink*(self: BaseTransform) =
  gst_base_transform_reconfigure_sink(cast[ptr BaseTransform00](self.impl))

proc gst_base_transform_reconfigure_src(self: ptr BaseTransform00) {.
    importc, libprag.}

proc reconfigureSrc*(self: BaseTransform) =
  gst_base_transform_reconfigure_src(cast[ptr BaseTransform00](self.impl))

proc gst_base_transform_set_gap_aware(self: ptr BaseTransform00; gapAware: gboolean) {.
    importc, libprag.}

proc setGapAware*(self: BaseTransform; gapAware: bool = true) =
  gst_base_transform_set_gap_aware(cast[ptr BaseTransform00](self.impl), gboolean(gapAware))

proc `gapAware=`*(self: BaseTransform; gapAware: bool) =
  gst_base_transform_set_gap_aware(cast[ptr BaseTransform00](self.impl), gboolean(gapAware))

proc gst_base_transform_set_in_place(self: ptr BaseTransform00; inPlace: gboolean) {.
    importc, libprag.}

proc setInPlace*(self: BaseTransform; inPlace: bool = true) =
  gst_base_transform_set_in_place(cast[ptr BaseTransform00](self.impl), gboolean(inPlace))

proc `inPlace=`*(self: BaseTransform; inPlace: bool) =
  gst_base_transform_set_in_place(cast[ptr BaseTransform00](self.impl), gboolean(inPlace))

proc gst_base_transform_set_passthrough(self: ptr BaseTransform00; passthrough: gboolean) {.
    importc, libprag.}

proc setPassthrough*(self: BaseTransform; passthrough: bool = true) =
  gst_base_transform_set_passthrough(cast[ptr BaseTransform00](self.impl), gboolean(passthrough))

proc `passthrough=`*(self: BaseTransform; passthrough: bool) =
  gst_base_transform_set_passthrough(cast[ptr BaseTransform00](self.impl), gboolean(passthrough))

proc gst_base_transform_set_prefer_passthrough(self: ptr BaseTransform00;
    preferPassthrough: gboolean) {.
    importc, libprag.}

proc setPreferPassthrough*(self: BaseTransform; preferPassthrough: bool = true) =
  gst_base_transform_set_prefer_passthrough(cast[ptr BaseTransform00](self.impl), gboolean(preferPassthrough))

proc `preferPassthrough=`*(self: BaseTransform; preferPassthrough: bool) =
  gst_base_transform_set_prefer_passthrough(cast[ptr BaseTransform00](self.impl), gboolean(preferPassthrough))

proc gst_base_transform_set_qos_enabled(self: ptr BaseTransform00; enabled: gboolean) {.
    importc, libprag.}

proc setQosEnabled*(self: BaseTransform; enabled: bool = true) =
  gst_base_transform_set_qos_enabled(cast[ptr BaseTransform00](self.impl), gboolean(enabled))

proc `qosEnabled=`*(self: BaseTransform; enabled: bool) =
  gst_base_transform_set_qos_enabled(cast[ptr BaseTransform00](self.impl), gboolean(enabled))

proc gst_base_transform_update_qos(self: ptr BaseTransform00; proportion: cdouble;
    diff: int64; timestamp: uint64) {.
    importc, libprag.}

proc updateQos*(self: BaseTransform; proportion: cdouble;
    diff: int64; timestamp: uint64) =
  gst_base_transform_update_qos(cast[ptr BaseTransform00](self.impl), proportion, diff, timestamp)

proc gst_base_transform_update_src_caps(self: ptr BaseTransform00; updatedCaps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc updateSrcCaps*(self: BaseTransform; updatedCaps: gst.Caps): bool =
  toBool(gst_base_transform_update_src_caps(cast[ptr BaseTransform00](self.impl), cast[ptr gst.Caps00](updatedCaps.impl)))

type
  BitReader00* {.pure.} = object
  BitReader* = ref object
    impl*: ptr BitReader00
    ignoreFinalizer*: bool

proc gst_bit_reader_free(self: ptr BitReader00) {.
    importc, libprag.}

proc free*(self: BitReader) =
  gst_bit_reader_free(cast[ptr BitReader00](self.impl))

proc finalizerfree*(self: BitReader) =
  if not self.ignoreFinalizer:
    gst_bit_reader_free(cast[ptr BitReader00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BitReader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_bit_reader_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var BitReader) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_bit_reader_get_bits_uint16(self: ptr BitReader00; val: var uint16;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc getBitsUint16*(self: BitReader; val: var uint16; nbits: int): bool =
  toBool(gst_bit_reader_get_bits_uint16(cast[ptr BitReader00](self.impl), val, uint32(nbits)))

proc gst_bit_reader_get_bits_uint32(self: ptr BitReader00; val: var uint32;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc getBitsUint32*(self: BitReader; val: var int; nbits: int): bool =
  var val_00: uint32
  result = toBool(gst_bit_reader_get_bits_uint32(cast[ptr BitReader00](self.impl), val_00, uint32(nbits)))
  if val.addr != nil:
    val = int(val_00)

proc gst_bit_reader_get_bits_uint64(self: ptr BitReader00; val: var uint64;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc getBitsUint64*(self: BitReader; val: var uint64; nbits: int): bool =
  toBool(gst_bit_reader_get_bits_uint64(cast[ptr BitReader00](self.impl), val, uint32(nbits)))

proc gst_bit_reader_get_bits_uint8(self: ptr BitReader00; val: var uint8;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc getBitsUint8*(self: BitReader; val: var uint8; nbits: int): bool =
  toBool(gst_bit_reader_get_bits_uint8(cast[ptr BitReader00](self.impl), val, uint32(nbits)))

proc gst_bit_reader_get_pos(self: ptr BitReader00): uint32 {.
    importc, libprag.}

proc getPos*(self: BitReader): int =
  int(gst_bit_reader_get_pos(cast[ptr BitReader00](self.impl)))

proc pos*(self: BitReader): int =
  int(gst_bit_reader_get_pos(cast[ptr BitReader00](self.impl)))

proc gst_bit_reader_get_remaining(self: ptr BitReader00): uint32 {.
    importc, libprag.}

proc getRemaining*(self: BitReader): int =
  int(gst_bit_reader_get_remaining(cast[ptr BitReader00](self.impl)))

proc remaining*(self: BitReader): int =
  int(gst_bit_reader_get_remaining(cast[ptr BitReader00](self.impl)))

proc gst_bit_reader_get_size(self: ptr BitReader00): uint32 {.
    importc, libprag.}

proc getSize*(self: BitReader): int =
  int(gst_bit_reader_get_size(cast[ptr BitReader00](self.impl)))

proc size*(self: BitReader): int =
  int(gst_bit_reader_get_size(cast[ptr BitReader00](self.impl)))

proc gst_bit_reader_init(self: ptr BitReader00; data: ptr uint8; size: uint32) {.
    importc, libprag.}

proc init*(self: BitReader; data: seq[uint8] | string) =
  let size = int(data.len)
  gst_bit_reader_init(cast[ptr BitReader00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(size))

proc gst_bit_reader_peek_bits_uint16(self: ptr BitReader00; val: var uint16;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc peekBitsUint16*(self: BitReader; val: var uint16; nbits: int): bool =
  toBool(gst_bit_reader_peek_bits_uint16(cast[ptr BitReader00](self.impl), val, uint32(nbits)))

proc gst_bit_reader_peek_bits_uint32(self: ptr BitReader00; val: var uint32;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc peekBitsUint32*(self: BitReader; val: var int; nbits: int): bool =
  var val_00: uint32
  result = toBool(gst_bit_reader_peek_bits_uint32(cast[ptr BitReader00](self.impl), val_00, uint32(nbits)))
  if val.addr != nil:
    val = int(val_00)

proc gst_bit_reader_peek_bits_uint64(self: ptr BitReader00; val: var uint64;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc peekBitsUint64*(self: BitReader; val: var uint64; nbits: int): bool =
  toBool(gst_bit_reader_peek_bits_uint64(cast[ptr BitReader00](self.impl), val, uint32(nbits)))

proc gst_bit_reader_peek_bits_uint8(self: ptr BitReader00; val: var uint8;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc peekBitsUint8*(self: BitReader; val: var uint8; nbits: int): bool =
  toBool(gst_bit_reader_peek_bits_uint8(cast[ptr BitReader00](self.impl), val, uint32(nbits)))

proc gst_bit_reader_set_pos(self: ptr BitReader00; pos: uint32): gboolean {.
    importc, libprag.}

proc setPos*(self: BitReader; pos: int): bool =
  toBool(gst_bit_reader_set_pos(cast[ptr BitReader00](self.impl), uint32(pos)))

proc gst_bit_reader_skip(self: ptr BitReader00; nbits: uint32): gboolean {.
    importc, libprag.}

proc skip*(self: BitReader; nbits: int): bool =
  toBool(gst_bit_reader_skip(cast[ptr BitReader00](self.impl), uint32(nbits)))

proc gst_bit_reader_skip_to_byte(self: ptr BitReader00): gboolean {.
    importc, libprag.}

proc skipToByte*(self: BitReader): bool =
  toBool(gst_bit_reader_skip_to_byte(cast[ptr BitReader00](self.impl)))

type
  BitWriter00* {.pure.} = object
  BitWriter* = ref object
    impl*: ptr BitWriter00
    ignoreFinalizer*: bool

proc gst_bit_writer_free(self: ptr BitWriter00) {.
    importc, libprag.}

proc free*(self: BitWriter) =
  gst_bit_writer_free(cast[ptr BitWriter00](self.impl))

proc finalizerfree*(self: BitWriter) =
  if not self.ignoreFinalizer:
    gst_bit_writer_free(cast[ptr BitWriter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(BitWriter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_bit_writer_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var BitWriter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_bit_writer_align_bytes(self: ptr BitWriter00; trailingBit: uint8): gboolean {.
    importc, libprag.}

proc alignBytes*(self: BitWriter; trailingBit: uint8): bool =
  toBool(gst_bit_writer_align_bytes(cast[ptr BitWriter00](self.impl), trailingBit))

proc gst_bit_writer_free_and_get_buffer(self: ptr BitWriter00): ptr gst.Buffer00 {.
    importc, libprag.}

proc freeAndGetBuffer*(self: BitWriter): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_bit_writer_free_and_get_buffer(cast[ptr BitWriter00](self.impl))

proc gst_bit_writer_get_data(self: ptr BitWriter00): ptr uint8 {.
    importc, libprag.}

proc getData*(self: BitWriter): ptr uint8 =
  gst_bit_writer_get_data(cast[ptr BitWriter00](self.impl))

proc data*(self: BitWriter): ptr uint8 =
  gst_bit_writer_get_data(cast[ptr BitWriter00](self.impl))

proc gst_bit_writer_get_remaining(self: ptr BitWriter00): uint32 {.
    importc, libprag.}

proc getRemaining*(self: BitWriter): int =
  int(gst_bit_writer_get_remaining(cast[ptr BitWriter00](self.impl)))

proc remaining*(self: BitWriter): int =
  int(gst_bit_writer_get_remaining(cast[ptr BitWriter00](self.impl)))

proc gst_bit_writer_get_size(self: ptr BitWriter00): uint32 {.
    importc, libprag.}

proc getSize*(self: BitWriter): int =
  int(gst_bit_writer_get_size(cast[ptr BitWriter00](self.impl)))

proc size*(self: BitWriter): int =
  int(gst_bit_writer_get_size(cast[ptr BitWriter00](self.impl)))

proc gst_bit_writer_put_bits_uint16(self: ptr BitWriter00; value: uint16;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc putBitsUint16*(self: BitWriter; value: uint16; nbits: int): bool =
  toBool(gst_bit_writer_put_bits_uint16(cast[ptr BitWriter00](self.impl), value, uint32(nbits)))

proc gst_bit_writer_put_bits_uint32(self: ptr BitWriter00; value: uint32;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc putBitsUint32*(self: BitWriter; value: int; nbits: int): bool =
  toBool(gst_bit_writer_put_bits_uint32(cast[ptr BitWriter00](self.impl), uint32(value), uint32(nbits)))

proc gst_bit_writer_put_bits_uint64(self: ptr BitWriter00; value: uint64;
    nbits: uint32): gboolean {.
    importc, libprag.}

proc putBitsUint64*(self: BitWriter; value: uint64; nbits: int): bool =
  toBool(gst_bit_writer_put_bits_uint64(cast[ptr BitWriter00](self.impl), value, uint32(nbits)))

proc gst_bit_writer_put_bits_uint8(self: ptr BitWriter00; value: uint8; nbits: uint32): gboolean {.
    importc, libprag.}

proc putBitsUint8*(self: BitWriter; value: uint8; nbits: int): bool =
  toBool(gst_bit_writer_put_bits_uint8(cast[ptr BitWriter00](self.impl), value, uint32(nbits)))

proc gst_bit_writer_put_bytes(self: ptr BitWriter00; data: ptr uint8; nbytes: uint32): gboolean {.
    importc, libprag.}

proc putBytes*(self: BitWriter; data: ptr uint8; nbytes: int): bool =
  toBool(gst_bit_writer_put_bytes(cast[ptr BitWriter00](self.impl), data, uint32(nbytes)))

proc gst_bit_writer_reset(self: ptr BitWriter00) {.
    importc, libprag.}

proc reset*(self: BitWriter) =
  gst_bit_writer_reset(cast[ptr BitWriter00](self.impl))

proc gst_bit_writer_reset_and_get_buffer(self: ptr BitWriter00): ptr gst.Buffer00 {.
    importc, libprag.}

proc resetAndGetBuffer*(self: BitWriter): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_bit_writer_reset_and_get_buffer(cast[ptr BitWriter00](self.impl))

proc gst_bit_writer_set_pos(self: ptr BitWriter00; pos: uint32): gboolean {.
    importc, libprag.}

proc setPos*(self: BitWriter; pos: int): bool =
  toBool(gst_bit_writer_set_pos(cast[ptr BitWriter00](self.impl), uint32(pos)))

type
  ByteReader00* {.pure.} = object
  ByteReader* = ref object
    impl*: ptr ByteReader00
    ignoreFinalizer*: bool

proc gst_byte_reader_free(self: ptr ByteReader00) {.
    importc, libprag.}

proc free*(self: ByteReader) =
  gst_byte_reader_free(cast[ptr ByteReader00](self.impl))

proc finalizerfree*(self: ByteReader) =
  if not self.ignoreFinalizer:
    gst_byte_reader_free(cast[ptr ByteReader00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ByteReader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_byte_reader_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var ByteReader) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_byte_reader_dup_string_utf16(self: ptr ByteReader00; str: var ptr uint16): gboolean {.
    importc, libprag.}

proc dupStringUtf16*(self: ByteReader; str: var ptr uint16): bool =
  toBool(gst_byte_reader_dup_string_utf16(cast[ptr ByteReader00](self.impl), str))

proc gst_byte_reader_dup_string_utf8(self: ptr ByteReader00; str: var ptr cstring): gboolean {.
    importc, libprag.}

proc dupStringUtf8*(self: ByteReader; str: var seq[string]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var str_00 = seq2CstringArray(str, fs469n23)
  result = toBool(gst_byte_reader_dup_string_utf8(cast[ptr ByteReader00](self.impl), str_00))
  if str.addr != nil:
    str = cstringArrayToSeq(str_00)

proc gst_byte_reader_dup_data(self: ptr ByteReader00; size: var uint32; val: var ptr uint8): gboolean {.
    importc, libprag.}

proc dupData*(self: ByteReader; size: var int; val: var (seq[uint8] | string)): bool =
  var val_00: ptr uint8
  var size_00: uint32
  result = toBool(gst_byte_reader_dup_data(cast[ptr ByteReader00](self.impl), size_00, val_00))
  val.setLen(size)
  copyMem(unsafeaddr val[0], val_00, size.int * sizeof(val[0]))
  cogfree(val_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_byte_reader_get_data(self: ptr ByteReader00; size: var uint32; val: var ptr uint8): gboolean {.
    importc, libprag.}

proc getData*(self: ByteReader; size: var int; val: var (seq[uint8] | string)): bool =
  var val_00: ptr uint8
  var size_00: uint32
  result = toBool(gst_byte_reader_get_data(cast[ptr ByteReader00](self.impl), size_00, val_00))
  val.setLen(size)
  copyMem(unsafeaddr val[0], val_00, size.int * sizeof(val[0]))
  cogfree(val_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_byte_reader_get_float32_be(self: ptr ByteReader00; val: var cfloat): gboolean {.
    importc, libprag.}

proc getFloat32Be*(self: ByteReader; val: var cfloat): bool =
  toBool(gst_byte_reader_get_float32_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_float32_le(self: ptr ByteReader00; val: var cfloat): gboolean {.
    importc, libprag.}

proc getFloat32Le*(self: ByteReader; val: var cfloat): bool =
  toBool(gst_byte_reader_get_float32_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_float64_be(self: ptr ByteReader00; val: var cdouble): gboolean {.
    importc, libprag.}

proc getFloat64Be*(self: ByteReader; val: var cdouble): bool =
  toBool(gst_byte_reader_get_float64_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_float64_le(self: ptr ByteReader00; val: var cdouble): gboolean {.
    importc, libprag.}

proc getFloat64Le*(self: ByteReader; val: var cdouble): bool =
  toBool(gst_byte_reader_get_float64_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_int16_be(self: ptr ByteReader00; val: var int16): gboolean {.
    importc, libprag.}

proc getInt16Be*(self: ByteReader; val: var int16): bool =
  toBool(gst_byte_reader_get_int16_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_int16_le(self: ptr ByteReader00; val: var int16): gboolean {.
    importc, libprag.}

proc getInt16Le*(self: ByteReader; val: var int16): bool =
  toBool(gst_byte_reader_get_int16_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_int24_be(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc getInt24Be*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_get_int24_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_int24_le(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc getInt24Le*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_get_int24_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_int32_be(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc getInt32Be*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_get_int32_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_int32_le(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc getInt32Le*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_get_int32_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_int64_be(self: ptr ByteReader00; val: var int64): gboolean {.
    importc, libprag.}

proc getInt64Be*(self: ByteReader; val: var int64): bool =
  toBool(gst_byte_reader_get_int64_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_int64_le(self: ptr ByteReader00; val: var int64): gboolean {.
    importc, libprag.}

proc getInt64Le*(self: ByteReader; val: var int64): bool =
  toBool(gst_byte_reader_get_int64_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_int8(self: ptr ByteReader00; val: var int8): gboolean {.
    importc, libprag.}

proc getInt8*(self: ByteReader; val: var int8): bool =
  toBool(gst_byte_reader_get_int8(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_pos(self: ptr ByteReader00): uint32 {.
    importc, libprag.}

proc getPos*(self: ByteReader): int =
  int(gst_byte_reader_get_pos(cast[ptr ByteReader00](self.impl)))

proc pos*(self: ByteReader): int =
  int(gst_byte_reader_get_pos(cast[ptr ByteReader00](self.impl)))

proc gst_byte_reader_get_remaining(self: ptr ByteReader00): uint32 {.
    importc, libprag.}

proc getRemaining*(self: ByteReader): int =
  int(gst_byte_reader_get_remaining(cast[ptr ByteReader00](self.impl)))

proc remaining*(self: ByteReader): int =
  int(gst_byte_reader_get_remaining(cast[ptr ByteReader00](self.impl)))

proc gst_byte_reader_get_size(self: ptr ByteReader00): uint32 {.
    importc, libprag.}

proc getSize*(self: ByteReader): int =
  int(gst_byte_reader_get_size(cast[ptr ByteReader00](self.impl)))

proc size*(self: ByteReader): int =
  int(gst_byte_reader_get_size(cast[ptr ByteReader00](self.impl)))

proc gst_byte_reader_get_string_utf8(self: ptr ByteReader00; str: var ptr cstring): gboolean {.
    importc, libprag.}

proc getStringUtf8*(self: ByteReader; str: var seq[string]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var str_00 = seq2CstringArray(str, fs469n23)
  result = toBool(gst_byte_reader_get_string_utf8(cast[ptr ByteReader00](self.impl), str_00))
  if str.addr != nil:
    str = cstringArrayToSeq(str_00)

proc gst_byte_reader_get_uint16_be(self: ptr ByteReader00; val: var uint16): gboolean {.
    importc, libprag.}

proc getUint16Be*(self: ByteReader; val: var uint16): bool =
  toBool(gst_byte_reader_get_uint16_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_uint16_le(self: ptr ByteReader00; val: var uint16): gboolean {.
    importc, libprag.}

proc getUint16Le*(self: ByteReader; val: var uint16): bool =
  toBool(gst_byte_reader_get_uint16_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_uint24_be(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc getUint24Be*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_get_uint24_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_uint24_le(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc getUint24Le*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_get_uint24_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_uint32_be(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc getUint32Be*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_get_uint32_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_uint32_le(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc getUint32Le*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_get_uint32_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_get_uint64_be(self: ptr ByteReader00; val: var uint64): gboolean {.
    importc, libprag.}

proc getUint64Be*(self: ByteReader; val: var uint64): bool =
  toBool(gst_byte_reader_get_uint64_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_uint64_le(self: ptr ByteReader00; val: var uint64): gboolean {.
    importc, libprag.}

proc getUint64Le*(self: ByteReader; val: var uint64): bool =
  toBool(gst_byte_reader_get_uint64_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_get_uint8(self: ptr ByteReader00; val: var uint8): gboolean {.
    importc, libprag.}

proc getUint8*(self: ByteReader; val: var uint8): bool =
  toBool(gst_byte_reader_get_uint8(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_init(self: ptr ByteReader00; data: ptr uint8; size: uint32) {.
    importc, libprag.}

proc init*(self: ByteReader; data: seq[uint8] | string) =
  let size = int(data.len)
  gst_byte_reader_init(cast[ptr ByteReader00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(size))

proc gst_byte_reader_masked_scan_uint32(self: ptr ByteReader00; mask: uint32;
    pattern: uint32; offset: uint32; size: uint32): uint32 {.
    importc, libprag.}

proc maskedScanUint32*(self: ByteReader; mask: int; pattern: int;
    offset: int; size: int): int =
  int(gst_byte_reader_masked_scan_uint32(cast[ptr ByteReader00](self.impl), uint32(mask), uint32(pattern), uint32(offset), uint32(size)))

proc gst_byte_reader_masked_scan_uint32_peek(self: ptr ByteReader00; mask: uint32;
    pattern: uint32; offset: uint32; size: uint32; value: var uint32): uint32 {.
    importc, libprag.}

proc maskedScanUint32Peek*(self: ByteReader; mask: int;
    pattern: int; offset: int; size: int; value: var int): int =
  var value_00: uint32
  result = int(gst_byte_reader_masked_scan_uint32_peek(cast[ptr ByteReader00](self.impl), uint32(mask), uint32(pattern), uint32(offset), uint32(size), value_00))
  if value.addr != nil:
    value = int(value_00)

proc gst_byte_reader_peek_data(self: ptr ByteReader00; size: var uint32;
    val: var ptr uint8): gboolean {.
    importc, libprag.}

proc peekData*(self: ByteReader; size: var int; val: var (seq[uint8] | string)): bool =
  var val_00: ptr uint8
  var size_00: uint32
  result = toBool(gst_byte_reader_peek_data(cast[ptr ByteReader00](self.impl), size_00, val_00))
  val.setLen(size)
  copyMem(unsafeaddr val[0], val_00, size.int * sizeof(val[0]))
  cogfree(val_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_byte_reader_peek_float32_be(self: ptr ByteReader00; val: var cfloat): gboolean {.
    importc, libprag.}

proc peekFloat32Be*(self: ByteReader; val: var cfloat): bool =
  toBool(gst_byte_reader_peek_float32_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_float32_le(self: ptr ByteReader00; val: var cfloat): gboolean {.
    importc, libprag.}

proc peekFloat32Le*(self: ByteReader; val: var cfloat): bool =
  toBool(gst_byte_reader_peek_float32_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_float64_be(self: ptr ByteReader00; val: var cdouble): gboolean {.
    importc, libprag.}

proc peekFloat64Be*(self: ByteReader; val: var cdouble): bool =
  toBool(gst_byte_reader_peek_float64_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_float64_le(self: ptr ByteReader00; val: var cdouble): gboolean {.
    importc, libprag.}

proc peekFloat64Le*(self: ByteReader; val: var cdouble): bool =
  toBool(gst_byte_reader_peek_float64_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_int16_be(self: ptr ByteReader00; val: var int16): gboolean {.
    importc, libprag.}

proc peekInt16Be*(self: ByteReader; val: var int16): bool =
  toBool(gst_byte_reader_peek_int16_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_int16_le(self: ptr ByteReader00; val: var int16): gboolean {.
    importc, libprag.}

proc peekInt16Le*(self: ByteReader; val: var int16): bool =
  toBool(gst_byte_reader_peek_int16_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_int24_be(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc peekInt24Be*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_peek_int24_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_int24_le(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc peekInt24Le*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_peek_int24_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_int32_be(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc peekInt32Be*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_peek_int32_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_int32_le(self: ptr ByteReader00; val: var int32): gboolean {.
    importc, libprag.}

proc peekInt32Le*(self: ByteReader; val: var int): bool =
  var val_00: int32
  result = toBool(gst_byte_reader_peek_int32_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_int64_be(self: ptr ByteReader00; val: var int64): gboolean {.
    importc, libprag.}

proc peekInt64Be*(self: ByteReader; val: var int64): bool =
  toBool(gst_byte_reader_peek_int64_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_int64_le(self: ptr ByteReader00; val: var int64): gboolean {.
    importc, libprag.}

proc peekInt64Le*(self: ByteReader; val: var int64): bool =
  toBool(gst_byte_reader_peek_int64_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_int8(self: ptr ByteReader00; val: var int8): gboolean {.
    importc, libprag.}

proc peekInt8*(self: ByteReader; val: var int8): bool =
  toBool(gst_byte_reader_peek_int8(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_string_utf8(self: ptr ByteReader00; str: var ptr cstring): gboolean {.
    importc, libprag.}

proc peekStringUtf8*(self: ByteReader; str: var seq[string]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var str_00 = seq2CstringArray(str, fs469n23)
  result = toBool(gst_byte_reader_peek_string_utf8(cast[ptr ByteReader00](self.impl), str_00))
  if str.addr != nil:
    str = cstringArrayToSeq(str_00)

proc gst_byte_reader_peek_uint16_be(self: ptr ByteReader00; val: var uint16): gboolean {.
    importc, libprag.}

proc peekUint16Be*(self: ByteReader; val: var uint16): bool =
  toBool(gst_byte_reader_peek_uint16_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_uint16_le(self: ptr ByteReader00; val: var uint16): gboolean {.
    importc, libprag.}

proc peekUint16Le*(self: ByteReader; val: var uint16): bool =
  toBool(gst_byte_reader_peek_uint16_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_uint24_be(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc peekUint24Be*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_peek_uint24_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_uint24_le(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc peekUint24Le*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_peek_uint24_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_uint32_be(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc peekUint32Be*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_peek_uint32_be(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_uint32_le(self: ptr ByteReader00; val: var uint32): gboolean {.
    importc, libprag.}

proc peekUint32Le*(self: ByteReader; val: var int): bool =
  var val_00: uint32
  result = toBool(gst_byte_reader_peek_uint32_le(cast[ptr ByteReader00](self.impl), val_00))
  if val.addr != nil:
    val = int(val_00)

proc gst_byte_reader_peek_uint64_be(self: ptr ByteReader00; val: var uint64): gboolean {.
    importc, libprag.}

proc peekUint64Be*(self: ByteReader; val: var uint64): bool =
  toBool(gst_byte_reader_peek_uint64_be(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_uint64_le(self: ptr ByteReader00; val: var uint64): gboolean {.
    importc, libprag.}

proc peekUint64Le*(self: ByteReader; val: var uint64): bool =
  toBool(gst_byte_reader_peek_uint64_le(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_peek_uint8(self: ptr ByteReader00; val: var uint8): gboolean {.
    importc, libprag.}

proc peekUint8*(self: ByteReader; val: var uint8): bool =
  toBool(gst_byte_reader_peek_uint8(cast[ptr ByteReader00](self.impl), val))

proc gst_byte_reader_set_pos(self: ptr ByteReader00; pos: uint32): gboolean {.
    importc, libprag.}

proc setPos*(self: ByteReader; pos: int): bool =
  toBool(gst_byte_reader_set_pos(cast[ptr ByteReader00](self.impl), uint32(pos)))

proc gst_byte_reader_skip(self: ptr ByteReader00; nbytes: uint32): gboolean {.
    importc, libprag.}

proc skip*(self: ByteReader; nbytes: int): bool =
  toBool(gst_byte_reader_skip(cast[ptr ByteReader00](self.impl), uint32(nbytes)))

proc gst_byte_reader_skip_string_utf16(self: ptr ByteReader00): gboolean {.
    importc, libprag.}

proc skipStringUtf16*(self: ByteReader): bool =
  toBool(gst_byte_reader_skip_string_utf16(cast[ptr ByteReader00](self.impl)))

proc gst_byte_reader_skip_string_utf32(self: ptr ByteReader00): gboolean {.
    importc, libprag.}

proc skipStringUtf32*(self: ByteReader): bool =
  toBool(gst_byte_reader_skip_string_utf32(cast[ptr ByteReader00](self.impl)))

proc gst_byte_reader_skip_string_utf8(self: ptr ByteReader00): gboolean {.
    importc, libprag.}

proc skipStringUtf8*(self: ByteReader): bool =
  toBool(gst_byte_reader_skip_string_utf8(cast[ptr ByteReader00](self.impl)))

type
  ByteWriter00* {.pure.} = object
  ByteWriter* = ref object
    impl*: ptr ByteWriter00
    ignoreFinalizer*: bool

proc gst_byte_writer_free(self: ptr ByteWriter00) {.
    importc, libprag.}

proc free*(self: ByteWriter) =
  gst_byte_writer_free(cast[ptr ByteWriter00](self.impl))

proc finalizerfree*(self: ByteWriter) =
  if not self.ignoreFinalizer:
    gst_byte_writer_free(cast[ptr ByteWriter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ByteWriter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_byte_writer_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var ByteWriter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_byte_writer_fill(self: ptr ByteWriter00; value: uint8; size: uint32): gboolean {.
    importc, libprag.}

proc fill*(self: ByteWriter; value: uint8; size: int): bool =
  toBool(gst_byte_writer_fill(cast[ptr ByteWriter00](self.impl), value, uint32(size)))

proc gst_byte_writer_ensure_free_space(self: ptr ByteWriter00; size: uint32): gboolean {.
    importc, libprag.}

proc ensureFreeSpace*(self: ByteWriter; size: int): bool =
  toBool(gst_byte_writer_ensure_free_space(cast[ptr ByteWriter00](self.impl), uint32(size)))

proc gst_byte_writer_free_and_get_buffer(self: ptr ByteWriter00): ptr gst.Buffer00 {.
    importc, libprag.}

proc freeAndGetBuffer*(self: ByteWriter): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_byte_writer_free_and_get_buffer(cast[ptr ByteWriter00](self.impl))

proc gst_byte_writer_free_and_get_data(self: ptr ByteWriter00): ptr uint8 {.
    importc, libprag.}

proc freeAndGetData*(self: ByteWriter): ptr uint8 =
  gst_byte_writer_free_and_get_data(cast[ptr ByteWriter00](self.impl))

proc gst_byte_writer_get_remaining(self: ptr ByteWriter00): uint32 {.
    importc, libprag.}

proc getRemaining*(self: ByteWriter): int =
  int(gst_byte_writer_get_remaining(cast[ptr ByteWriter00](self.impl)))

proc remaining*(self: ByteWriter): int =
  int(gst_byte_writer_get_remaining(cast[ptr ByteWriter00](self.impl)))

proc gst_byte_writer_init(self: ptr ByteWriter00) {.
    importc, libprag.}

proc init*(self: ByteWriter) =
  gst_byte_writer_init(cast[ptr ByteWriter00](self.impl))

proc gst_byte_writer_init_with_data(self: ptr ByteWriter00; data: ptr uint8;
    size: uint32; initialized: gboolean) {.
    importc, libprag.}

proc initWithData*(self: ByteWriter; data: seq[uint8] | string;
    initialized: bool) =
  let size = int(data.len)
  gst_byte_writer_init_with_data(cast[ptr ByteWriter00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(size), gboolean(initialized))

proc gst_byte_writer_init_with_size(self: ptr ByteWriter00; size: uint32;
    fixed: gboolean) {.
    importc, libprag.}

proc initWithSize*(self: ByteWriter; size: int; fixed: bool) =
  gst_byte_writer_init_with_size(cast[ptr ByteWriter00](self.impl), uint32(size), gboolean(fixed))

proc gst_byte_writer_put_buffer(self: ptr ByteWriter00; buffer: ptr gst.Buffer00;
    offset: uint64; size: int64): gboolean {.
    importc, libprag.}

proc putBuffer*(self: ByteWriter; buffer: gst.Buffer; offset: uint64;
    size: int64): bool =
  toBool(gst_byte_writer_put_buffer(cast[ptr ByteWriter00](self.impl), cast[ptr gst.Buffer00](buffer.impl), offset, size))

proc gst_byte_writer_put_data(self: ptr ByteWriter00; data: ptr uint8; size: uint32): gboolean {.
    importc, libprag.}

proc putData*(self: ByteWriter; data: seq[uint8] | string): bool =
  let size = int(data.len)
  toBool(gst_byte_writer_put_data(cast[ptr ByteWriter00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(size)))

proc gst_byte_writer_put_float32_be(self: ptr ByteWriter00; val: cfloat): gboolean {.
    importc, libprag.}

proc putFloat32Be*(self: ByteWriter; val: cfloat): bool =
  toBool(gst_byte_writer_put_float32_be(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_float32_le(self: ptr ByteWriter00; val: cfloat): gboolean {.
    importc, libprag.}

proc putFloat32Le*(self: ByteWriter; val: cfloat): bool =
  toBool(gst_byte_writer_put_float32_le(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_float64_be(self: ptr ByteWriter00; val: cdouble): gboolean {.
    importc, libprag.}

proc putFloat64Be*(self: ByteWriter; val: cdouble): bool =
  toBool(gst_byte_writer_put_float64_be(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_float64_le(self: ptr ByteWriter00; val: cdouble): gboolean {.
    importc, libprag.}

proc putFloat64Le*(self: ByteWriter; val: cdouble): bool =
  toBool(gst_byte_writer_put_float64_le(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_int16_be(self: ptr ByteWriter00; val: int16): gboolean {.
    importc, libprag.}

proc putInt16Be*(self: ByteWriter; val: int16): bool =
  toBool(gst_byte_writer_put_int16_be(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_int16_le(self: ptr ByteWriter00; val: int16): gboolean {.
    importc, libprag.}

proc putInt16Le*(self: ByteWriter; val: int16): bool =
  toBool(gst_byte_writer_put_int16_le(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_int24_be(self: ptr ByteWriter00; val: int32): gboolean {.
    importc, libprag.}

proc putInt24Be*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_int24_be(cast[ptr ByteWriter00](self.impl), int32(val)))

proc gst_byte_writer_put_int24_le(self: ptr ByteWriter00; val: int32): gboolean {.
    importc, libprag.}

proc putInt24Le*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_int24_le(cast[ptr ByteWriter00](self.impl), int32(val)))

proc gst_byte_writer_put_int32_be(self: ptr ByteWriter00; val: int32): gboolean {.
    importc, libprag.}

proc putInt32Be*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_int32_be(cast[ptr ByteWriter00](self.impl), int32(val)))

proc gst_byte_writer_put_int32_le(self: ptr ByteWriter00; val: int32): gboolean {.
    importc, libprag.}

proc putInt32Le*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_int32_le(cast[ptr ByteWriter00](self.impl), int32(val)))

proc gst_byte_writer_put_int64_be(self: ptr ByteWriter00; val: int64): gboolean {.
    importc, libprag.}

proc putInt64Be*(self: ByteWriter; val: int64): bool =
  toBool(gst_byte_writer_put_int64_be(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_int64_le(self: ptr ByteWriter00; val: int64): gboolean {.
    importc, libprag.}

proc putInt64Le*(self: ByteWriter; val: int64): bool =
  toBool(gst_byte_writer_put_int64_le(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_int8(self: ptr ByteWriter00; val: int8): gboolean {.
    importc, libprag.}

proc putInt8*(self: ByteWriter; val: int8): bool =
  toBool(gst_byte_writer_put_int8(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_string_utf16(self: ptr ByteWriter00; data: ptr uint16): gboolean {.
    importc, libprag.}

proc putStringUtf16*(self: ByteWriter; data: ptr uint16): bool =
  toBool(gst_byte_writer_put_string_utf16(cast[ptr ByteWriter00](self.impl), data))

proc gst_byte_writer_put_string_utf32(self: ptr ByteWriter00; data: ptr uint32): gboolean {.
    importc, libprag.}

proc putStringUtf32*(self: ByteWriter; data: seq[uint32]): bool =
  toBool(gst_byte_writer_put_string_utf32(cast[ptr ByteWriter00](self.impl), cast[ptr uint32](unsafeaddr(data[0]))))

proc gst_byte_writer_put_string_utf8(self: ptr ByteWriter00; data: cstring): gboolean {.
    importc, libprag.}

proc putStringUtf8*(self: ByteWriter; data: cstring): bool =
  toBool(gst_byte_writer_put_string_utf8(cast[ptr ByteWriter00](self.impl), data))

proc gst_byte_writer_put_uint16_be(self: ptr ByteWriter00; val: uint16): gboolean {.
    importc, libprag.}

proc putUint16Be*(self: ByteWriter; val: uint16): bool =
  toBool(gst_byte_writer_put_uint16_be(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_uint16_le(self: ptr ByteWriter00; val: uint16): gboolean {.
    importc, libprag.}

proc putUint16Le*(self: ByteWriter; val: uint16): bool =
  toBool(gst_byte_writer_put_uint16_le(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_uint24_be(self: ptr ByteWriter00; val: uint32): gboolean {.
    importc, libprag.}

proc putUint24Be*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_uint24_be(cast[ptr ByteWriter00](self.impl), uint32(val)))

proc gst_byte_writer_put_uint24_le(self: ptr ByteWriter00; val: uint32): gboolean {.
    importc, libprag.}

proc putUint24Le*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_uint24_le(cast[ptr ByteWriter00](self.impl), uint32(val)))

proc gst_byte_writer_put_uint32_be(self: ptr ByteWriter00; val: uint32): gboolean {.
    importc, libprag.}

proc putUint32Be*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_uint32_be(cast[ptr ByteWriter00](self.impl), uint32(val)))

proc gst_byte_writer_put_uint32_le(self: ptr ByteWriter00; val: uint32): gboolean {.
    importc, libprag.}

proc putUint32Le*(self: ByteWriter; val: int): bool =
  toBool(gst_byte_writer_put_uint32_le(cast[ptr ByteWriter00](self.impl), uint32(val)))

proc gst_byte_writer_put_uint64_be(self: ptr ByteWriter00; val: uint64): gboolean {.
    importc, libprag.}

proc putUint64Be*(self: ByteWriter; val: uint64): bool =
  toBool(gst_byte_writer_put_uint64_be(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_uint64_le(self: ptr ByteWriter00; val: uint64): gboolean {.
    importc, libprag.}

proc putUint64Le*(self: ByteWriter; val: uint64): bool =
  toBool(gst_byte_writer_put_uint64_le(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_put_uint8(self: ptr ByteWriter00; val: uint8): gboolean {.
    importc, libprag.}

proc putUint8*(self: ByteWriter; val: uint8): bool =
  toBool(gst_byte_writer_put_uint8(cast[ptr ByteWriter00](self.impl), val))

proc gst_byte_writer_reset(self: ptr ByteWriter00) {.
    importc, libprag.}

proc reset*(self: ByteWriter) =
  gst_byte_writer_reset(cast[ptr ByteWriter00](self.impl))

proc gst_byte_writer_reset_and_get_buffer(self: ptr ByteWriter00): ptr gst.Buffer00 {.
    importc, libprag.}

proc resetAndGetBuffer*(self: ByteWriter): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_byte_writer_reset_and_get_buffer(cast[ptr ByteWriter00](self.impl))

type
  CollectData00* {.pure.} = object
  CollectData* = ref object
    impl*: ptr CollectData00
    ignoreFinalizer*: bool

type
  CollectDataDestroyNotify* = proc (data: ptr CollectData00) {.cdecl.}

type
  CollectPads* = ref object of gst.Object
  CollectPads00* = object of gst.Object00

proc gst_collect_pads_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CollectPads()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_collect_pads_new(): ptr CollectPads00 {.
    importc, libprag.}

proc newCollectPads*(): CollectPads =
  let gobj = gst_collect_pads_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstbase.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCollectPads*(tdesc: typedesc): tdesc =
  assert(result is CollectPads)
  let gobj = gst_collect_pads_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstbase.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCollectPads*[T](result: var T) {.deprecated.} =
  assert(result is CollectPads)
  let gobj = gst_collect_pads_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstbase.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_collect_pads_add_pad(self: ptr CollectPads00; pad: ptr gst.Pad00;
    size: uint32; destroyNotify: CollectDataDestroyNotify; lock: gboolean): ptr CollectData00 {.
    importc, libprag.}

proc addPad*(self: CollectPads; pad: gst.Pad; size: int;
    destroyNotify: CollectDataDestroyNotify; lock: bool): CollectData =
  let impl0 = gst_collect_pads_add_pad(cast[ptr CollectPads00](self.impl), cast[ptr gst.Pad00](pad.impl), uint32(size), destroyNotify, gboolean(lock))
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc gst_collect_pads_available(self: ptr CollectPads00): uint32 {.
    importc, libprag.}

proc available*(self: CollectPads): int =
  int(gst_collect_pads_available(cast[ptr CollectPads00](self.impl)))

proc gst_collect_pads_clip_running_time(self: ptr CollectPads00; cdata: ptr CollectData00;
    buf: ptr gst.Buffer00; outbuf: var ptr gst.Buffer00; userData: pointer): gst.FlowReturn {.
    importc, libprag.}

proc clipRunningTime*(self: CollectPads; cdata: CollectData;
    buf: gst.Buffer; outbuf: var gst.Buffer = cast[var gst.Buffer](nil); userData: pointer): gst.FlowReturn =
  if addr(outbuf) != nil:
    fnew(outbuf, gBoxedFreeGstBuffer)
  gst_collect_pads_clip_running_time(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](cdata.impl), cast[ptr gst.Buffer00](buf.impl), cast[var ptr gst.Buffer00](if addr(outbuf) == nil: nil else: addr outbuf.impl), userData)

proc gst_collect_pads_event_default(self: ptr CollectPads00; data: ptr CollectData00;
    event: ptr gst.Event00; `discard`: gboolean): gboolean {.
    importc, libprag.}

proc eventDefault*(self: CollectPads; data: CollectData;
    event: gst.Event; `discard`: bool): bool =
  toBool(gst_collect_pads_event_default(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl), cast[ptr gst.Event00](event.impl), gboolean(`discard`)))

proc gst_collect_pads_flush(self: ptr CollectPads00; data: ptr CollectData00;
    size: uint32): uint32 {.
    importc, libprag.}

proc flush*(self: CollectPads; data: CollectData; size: int): int =
  int(gst_collect_pads_flush(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl), uint32(size)))

proc gst_collect_pads_peek(self: ptr CollectPads00; data: ptr CollectData00): ptr gst.Buffer00 {.
    importc, libprag.}

proc peek*(self: CollectPads; data: CollectData): gst.Buffer =
  let impl0 = gst_collect_pads_peek(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_collect_pads_pop(self: ptr CollectPads00; data: ptr CollectData00): ptr gst.Buffer00 {.
    importc, libprag.}

proc pop*(self: CollectPads; data: CollectData): gst.Buffer =
  let impl0 = gst_collect_pads_pop(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_collect_pads_query_default(self: ptr CollectPads00; data: ptr CollectData00;
    query: ptr gst.Query00; `discard`: gboolean): gboolean {.
    importc, libprag.}

proc queryDefault*(self: CollectPads; data: CollectData;
    query: gst.Query; `discard`: bool): bool =
  toBool(gst_collect_pads_query_default(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl), cast[ptr gst.Query00](query.impl), gboolean(`discard`)))

proc gst_collect_pads_read_buffer(self: ptr CollectPads00; data: ptr CollectData00;
    size: uint32): ptr gst.Buffer00 {.
    importc, libprag.}

proc readBuffer*(self: CollectPads; data: CollectData; size: int): gst.Buffer =
  let impl0 = gst_collect_pads_read_buffer(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl), uint32(size))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

proc gst_collect_pads_remove_pad(self: ptr CollectPads00; pad: ptr gst.Pad00): gboolean {.
    importc, libprag.}

proc removePad*(self: CollectPads; pad: gst.Pad): bool =
  toBool(gst_collect_pads_remove_pad(cast[ptr CollectPads00](self.impl), cast[ptr gst.Pad00](pad.impl)))

proc gst_collect_pads_set_flushing(self: ptr CollectPads00; flushing: gboolean) {.
    importc, libprag.}

proc setFlushing*(self: CollectPads; flushing: bool = true) =
  gst_collect_pads_set_flushing(cast[ptr CollectPads00](self.impl), gboolean(flushing))

proc `flushing=`*(self: CollectPads; flushing: bool) =
  gst_collect_pads_set_flushing(cast[ptr CollectPads00](self.impl), gboolean(flushing))

proc gst_collect_pads_set_waiting(self: ptr CollectPads00; data: ptr CollectData00;
    waiting: gboolean) {.
    importc, libprag.}

proc setWaiting*(self: CollectPads; data: CollectData; waiting: bool) =
  gst_collect_pads_set_waiting(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl), gboolean(waiting))

proc gst_collect_pads_src_event_default(self: ptr CollectPads00; pad: ptr gst.Pad00;
    event: ptr gst.Event00): gboolean {.
    importc, libprag.}

proc srcEventDefault*(self: CollectPads; pad: gst.Pad;
    event: gst.Event): bool =
  toBool(gst_collect_pads_src_event_default(cast[ptr CollectPads00](self.impl), cast[ptr gst.Pad00](pad.impl), cast[ptr gst.Event00](event.impl)))

proc gst_collect_pads_start(self: ptr CollectPads00) {.
    importc, libprag.}

proc start*(self: CollectPads) =
  gst_collect_pads_start(cast[ptr CollectPads00](self.impl))

proc gst_collect_pads_stop(self: ptr CollectPads00) {.
    importc, libprag.}

proc stop*(self: CollectPads) =
  gst_collect_pads_stop(cast[ptr CollectPads00](self.impl))

proc gst_collect_pads_take_buffer(self: ptr CollectPads00; data: ptr CollectData00;
    size: uint32): ptr gst.Buffer00 {.
    importc, libprag.}

proc takeBuffer*(self: CollectPads; data: CollectData; size: int): gst.Buffer =
  let impl0 = gst_collect_pads_take_buffer(cast[ptr CollectPads00](self.impl), cast[ptr CollectData00](data.impl), uint32(size))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = impl0

type
  CollectPadsBufferFunction* = proc (pads: ptr CollectPads00; data: ptr CollectData00; buffer: ptr gst.Buffer00;
    userData: pointer): gst.FlowReturn {.cdecl.}

proc gst_collect_pads_set_buffer_function(self: ptr CollectPads00; `func`: CollectPadsBufferFunction;
    userData: pointer) {.
    importc, libprag.}

proc setBufferFunction*(self: CollectPads; `func`: CollectPadsBufferFunction;
    userData: pointer) =
  gst_collect_pads_set_buffer_function(cast[ptr CollectPads00](self.impl), `func`, userData)

type
  CollectPadsClipFunction* = proc (pads: ptr CollectPads00; data: ptr CollectData00; inbuffer: ptr gst.Buffer00;
    outbuffer: var ptr gst.Buffer00; userData: pointer): gst.FlowReturn {.cdecl.}

proc gst_collect_pads_set_clip_function(self: ptr CollectPads00; clipfunc: CollectPadsClipFunction;
    userData: pointer) {.
    importc, libprag.}

proc setClipFunction*(self: CollectPads; clipfunc: CollectPadsClipFunction;
    userData: pointer) =
  gst_collect_pads_set_clip_function(cast[ptr CollectPads00](self.impl), clipfunc, userData)

type
  CollectPadsCompareFunction* = proc (pads: ptr CollectPads00; data1: ptr CollectData00; timestamp1: uint64;
    data2: ptr CollectData00; timestamp2: uint64; userData: pointer): int32 {.cdecl.}

proc gst_collect_pads_set_compare_function(self: ptr CollectPads00; `func`: CollectPadsCompareFunction;
    userData: pointer) {.
    importc, libprag.}

proc setCompareFunction*(self: CollectPads; `func`: CollectPadsCompareFunction;
    userData: pointer) =
  gst_collect_pads_set_compare_function(cast[ptr CollectPads00](self.impl), `func`, userData)

type
  CollectPadsEventFunction* = proc (pads: ptr CollectPads00; pad: ptr CollectData00; event: ptr gst.Event00;
    userData: pointer): gboolean {.cdecl.}

proc gst_collect_pads_set_event_function(self: ptr CollectPads00; `func`: CollectPadsEventFunction;
    userData: pointer) {.
    importc, libprag.}

proc setEventFunction*(self: CollectPads; `func`: CollectPadsEventFunction;
    userData: pointer) =
  gst_collect_pads_set_event_function(cast[ptr CollectPads00](self.impl), `func`, userData)

type
  CollectPadsFlushFunction* = proc (pads: ptr CollectPads00; userData: pointer) {.cdecl.}

proc gst_collect_pads_set_flush_function(self: ptr CollectPads00; `func`: CollectPadsFlushFunction;
    userData: pointer) {.
    importc, libprag.}

proc setFlushFunction*(self: CollectPads; `func`: CollectPadsFlushFunction;
    userData: pointer) =
  gst_collect_pads_set_flush_function(cast[ptr CollectPads00](self.impl), `func`, userData)

type
  CollectPadsFunction* = proc (pads: ptr CollectPads00; userData: pointer): gst.FlowReturn {.cdecl.}

proc gst_collect_pads_set_function(self: ptr CollectPads00; `func`: CollectPadsFunction;
    userData: pointer) {.
    importc, libprag.}

proc setFunction*(self: CollectPads; `func`: CollectPadsFunction;
    userData: pointer) =
  gst_collect_pads_set_function(cast[ptr CollectPads00](self.impl), `func`, userData)

type
  CollectPadsQueryFunction* = proc (pads: ptr CollectPads00; pad: ptr CollectData00; query: ptr gst.Query00;
    userData: pointer): gboolean {.cdecl.}

proc gst_collect_pads_set_query_function(self: ptr CollectPads00; `func`: CollectPadsQueryFunction;
    userData: pointer) {.
    importc, libprag.}

proc setQueryFunction*(self: CollectPads; `func`: CollectPadsQueryFunction;
    userData: pointer) =
  gst_collect_pads_set_query_function(cast[ptr CollectPads00](self.impl), `func`, userData)

type
  CollectPadsStateFlag* {.size: sizeof(cint), pure.} = enum
    eos = 0
    flushing = 1
    newSegment = 2
    waiting = 3
    locked = 4

  CollectPadsStateFlags* {.size: sizeof(cint).} = set[CollectPadsStateFlag]

type
  DataQueue* = ref object of gobject.Object
  DataQueue00* = object of gobject.Object00

proc gst_data_queue_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DataQueue()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  DataQueueEmptyCallback* = proc (queue: ptr DataQueue00; checkdata: pointer) {.cdecl.}

type
  DataQueueFullCallback* = proc (queue: ptr DataQueue00; checkdata: pointer) {.cdecl.}

type
  FlowCombiner00* {.pure.} = object
  FlowCombiner* = ref object
    impl*: ptr FlowCombiner00
    ignoreFinalizer*: bool

proc gst_flow_combiner_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstFlowCombiner*(self: FlowCombiner) =
  if not self.ignoreFinalizer:
    boxedFree(gst_flow_combiner_get_type(), cast[ptr FlowCombiner00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FlowCombiner()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_flow_combiner_get_type(), cast[ptr FlowCombiner00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var FlowCombiner) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstFlowCombiner)

proc gst_flow_combiner_free(self: ptr FlowCombiner00) {.
    importc, libprag.}

proc free*(self: FlowCombiner) =
  gst_flow_combiner_free(cast[ptr FlowCombiner00](self.impl))

proc finalizerfree*(self: FlowCombiner) =
  if not self.ignoreFinalizer:
    gst_flow_combiner_free(cast[ptr FlowCombiner00](self.impl))

proc gst_flow_combiner_add_pad(self: ptr FlowCombiner00; pad: ptr gst.Pad00) {.
    importc, libprag.}

proc addPad*(self: FlowCombiner; pad: gst.Pad) =
  gst_flow_combiner_add_pad(cast[ptr FlowCombiner00](self.impl), cast[ptr gst.Pad00](pad.impl))

proc gst_flow_combiner_clear(self: ptr FlowCombiner00) {.
    importc, libprag.}

proc clear*(self: FlowCombiner) =
  gst_flow_combiner_clear(cast[ptr FlowCombiner00](self.impl))

proc gst_flow_combiner_new(): ptr FlowCombiner00 {.
    importc, libprag.}

proc newFlowCombiner*(): FlowCombiner =
  fnew(result, gBoxedFreeGstFlowCombiner)
  result.impl = gst_flow_combiner_new()

proc newFlowCombiner*(tdesc: typedesc): tdesc =
  assert(result is FlowCombiner)
  fnew(result, gBoxedFreeGstFlowCombiner)
  result.impl = gst_flow_combiner_new()

proc initFlowCombiner*[T](result: var T) {.deprecated.} =
  assert(result is FlowCombiner)
  fnew(result, gBoxedFreeGstFlowCombiner)
  result.impl = gst_flow_combiner_new()

proc gst_flow_combiner_ref(self: ptr FlowCombiner00): ptr FlowCombiner00 {.
    importc, libprag.}

proc `ref`*(self: FlowCombiner): FlowCombiner =
  fnew(result, gBoxedFreeGstFlowCombiner)
  result.impl = gst_flow_combiner_ref(cast[ptr FlowCombiner00](self.impl))

proc gst_flow_combiner_remove_pad(self: ptr FlowCombiner00; pad: ptr gst.Pad00) {.
    importc, libprag.}

proc removePad*(self: FlowCombiner; pad: gst.Pad) =
  gst_flow_combiner_remove_pad(cast[ptr FlowCombiner00](self.impl), cast[ptr gst.Pad00](pad.impl))

proc gst_flow_combiner_reset(self: ptr FlowCombiner00) {.
    importc, libprag.}

proc reset*(self: FlowCombiner) =
  gst_flow_combiner_reset(cast[ptr FlowCombiner00](self.impl))

proc gst_flow_combiner_unref(self: ptr FlowCombiner00) {.
    importc, libprag.}

proc unref*(self: FlowCombiner) =
  gst_flow_combiner_unref(cast[ptr FlowCombiner00](self.impl))

proc finalizerunref*(self: FlowCombiner) =
  if not self.ignoreFinalizer:
    gst_flow_combiner_unref(cast[ptr FlowCombiner00](self.impl))

proc gst_flow_combiner_update_flow(self: ptr FlowCombiner00; fret: gst.FlowReturn): gst.FlowReturn {.
    importc, libprag.}

proc updateFlow*(self: FlowCombiner; fret: gst.FlowReturn): gst.FlowReturn =
  gst_flow_combiner_update_flow(cast[ptr FlowCombiner00](self.impl), fret)

proc gst_flow_combiner_update_pad_flow(self: ptr FlowCombiner00; pad: ptr gst.Pad00;
    fret: gst.FlowReturn): gst.FlowReturn {.
    importc, libprag.}

proc updatePadFlow*(self: FlowCombiner; pad: gst.Pad;
    fret: gst.FlowReturn): gst.FlowReturn =
  gst_flow_combiner_update_pad_flow(cast[ptr FlowCombiner00](self.impl), cast[ptr gst.Pad00](pad.impl), fret)

type
  PushSrc* = ref object of BaseSrc
  PushSrc00* = object of BaseSrc00

proc gst_push_src_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PushSrc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  TypeFindHelperGetRangeFunction* = proc (obj: ptr gst.Object00; parent: ptr gst.Object00; offset: uint64; length: uint32;
    buffer: var ptr gst.Buffer00): gst.FlowReturn {.cdecl.}

proc gst_type_find_helper(src: ptr gst.Pad00; size: uint64): ptr gst.Caps00 {.
    importc, libprag.}

proc typeFindHelper*(src: gst.Pad; size: uint64): gst.Caps =
  let impl0 = gst_type_find_helper(cast[ptr gst.Pad00](src.impl), size)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_type_find_helper_for_buffer(obj: ptr gst.Object00; buf: ptr gst.Buffer00;
    prob: var gst.TypeFindProbability): ptr gst.Caps00 {.
    importc, libprag.}

proc typeFindHelperForBuffer*(obj: gst.Object = nil; buf: gst.Buffer;
    prob: var gst.TypeFindProbability = cast[var gst.TypeFindProbability](nil)): gst.Caps =
  let impl0 = gst_type_find_helper_for_buffer(if obj.isNil: nil else: cast[ptr gst.Object00](obj.impl), cast[ptr gst.Buffer00](buf.impl), prob)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_type_find_helper_for_buffer_with_extension(obj: ptr gst.Object00;
    buf: ptr gst.Buffer00; extension: cstring; prob: var gst.TypeFindProbability): ptr gst.Caps00 {.
    importc, libprag.}

proc typeFindHelperForBufferWithExtension*(obj: gst.Object = nil;
    buf: gst.Buffer; extension: cstring = nil; prob: var gst.TypeFindProbability = cast[var gst.TypeFindProbability](nil)): gst.Caps =
  let impl0 = gst_type_find_helper_for_buffer_with_extension(if obj.isNil: nil else: cast[ptr gst.Object00](obj.impl), cast[ptr gst.Buffer00](buf.impl), extension, prob)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_type_find_helper_for_data(obj: ptr gst.Object00; data: ptr uint8;
    size: uint64; prob: var gst.TypeFindProbability): ptr gst.Caps00 {.
    importc, libprag.}

proc typeFindHelperForData*(obj: gst.Object = nil; data: seq[uint8] | string;
    prob: var gst.TypeFindProbability = cast[var gst.TypeFindProbability](nil)): gst.Caps =
  let size = uint64(data.len)
  let impl0 = gst_type_find_helper_for_data(if obj.isNil: nil else: cast[ptr gst.Object00](obj.impl), cast[ptr uint8](unsafeaddr(data[0])), size, prob)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_type_find_helper_for_data_with_extension(obj: ptr gst.Object00;
    data: ptr uint8; size: uint64; extension: cstring; prob: var gst.TypeFindProbability): ptr gst.Caps00 {.
    importc, libprag.}

proc typeFindHelperForDataWithExtension*(obj: gst.Object = nil;
    data: seq[uint8] | string; extension: cstring = nil; prob: var gst.TypeFindProbability = cast[var gst.TypeFindProbability](nil)): gst.Caps =
  let size = uint64(data.len)
  let impl0 = gst_type_find_helper_for_data_with_extension(if obj.isNil: nil else: cast[ptr gst.Object00](obj.impl), cast[ptr uint8](unsafeaddr(data[0])), size, extension, prob)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_type_find_helper_for_extension(obj: ptr gst.Object00; extension: cstring): ptr gst.Caps00 {.
    importc, libprag.}

proc typeFindHelperForExtension*(obj: gst.Object = nil; extension: cstring): gst.Caps =
  let impl0 = gst_type_find_helper_for_extension(if obj.isNil: nil else: cast[ptr gst.Object00](obj.impl), extension)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_type_find_helper_get_range(obj: ptr gst.Object00; parent: ptr gst.Object00;
    `func`: TypeFindHelperGetRangeFunction; size: uint64; extension: cstring;
    prob: var gst.TypeFindProbability): ptr gst.Caps00 {.
    importc, libprag.}

proc typeFindHelperGetRange*(obj: gst.Object; parent: gst.Object = nil;
    `func`: TypeFindHelperGetRangeFunction; size: uint64; extension: cstring = nil;
    prob: var gst.TypeFindProbability = cast[var gst.TypeFindProbability](nil)): gst.Caps =
  let impl0 = gst_type_find_helper_get_range(cast[ptr gst.Object00](obj.impl), if parent.isNil: nil else: cast[ptr gst.Object00](parent.impl), `func`, size, extension, prob)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstCaps)
  result.impl = impl0

proc gst_type_find_helper_get_range_full(obj: ptr gst.Object00; parent: ptr gst.Object00;
    `func`: TypeFindHelperGetRangeFunction; size: uint64; extension: cstring;
    caps: var ptr gst.Caps00; prob: var gst.TypeFindProbability): gst.FlowReturn {.
    importc, libprag.}

proc typeFindHelperGetRangeFull*(obj: gst.Object; parent: gst.Object = nil;
    `func`: TypeFindHelperGetRangeFunction; size: uint64; extension: cstring = nil;
    caps: var gst.Caps; prob: var gst.TypeFindProbability = cast[var gst.TypeFindProbability](nil)): gst.FlowReturn =
  fnew(caps, gBoxedFreeGstCaps)
  gst_type_find_helper_get_range_full(cast[ptr gst.Object00](obj.impl), if parent.isNil: nil else: cast[ptr gst.Object00](parent.impl), `func`, size, extension, cast[var ptr gst.Caps00](addr caps.impl), prob)
# === remaining symbols:
