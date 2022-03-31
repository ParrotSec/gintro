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
# libgstcheck-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule
const Lib = "libgstcheck-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  CheckABIStruct* {.pure, byRef.} = object
    name*: cstring
    size*: int32
    abiSize*: int32

type
  CheckLogFilter00* {.pure.} = object
  CheckLogFilter* = ref object
    impl*: ptr CheckLogFilter00
    ignoreFinalizer*: bool

type
  CheckLogFilterFunc* = proc (logDomain: cstring; logLevel: glib.LogLevelFlags; message: cstring;
    userData: pointer): gboolean {.cdecl.}

type
  Harness* {.pure, byRef.} = object
    element*: ptr gst.Element00
    srcpad*: ptr gst.Pad00
    sinkpad*: ptr gst.Pad00
    srcHarness*: ptr Harness
    sinkHarness*: ptr Harness
    priv*: ptr HarnessPrivate00

proc gst_harness_add_element_sink_pad(self: Harness; sinkpad: ptr gst.Pad00) {.
    importc, libprag.}

proc addElementSinkPad*(self: Harness; sinkpad: gst.Pad) =
  gst_harness_add_element_sink_pad(self, cast[ptr gst.Pad00](sinkpad.impl))

proc gst_harness_add_element_src_pad(self: Harness; srcpad: ptr gst.Pad00) {.
    importc, libprag.}

proc addElementSrcPad*(self: Harness; srcpad: gst.Pad) =
  gst_harness_add_element_src_pad(self, cast[ptr gst.Pad00](srcpad.impl))

proc gst_harness_add_probe(self: Harness; elementName: cstring; padName: cstring;
    mask: gst.PadProbeType; callback: PadProbeCallback; userData: pointer;
    destroyData: DestroyNotify) {.
    importc, libprag.}

proc addProbe*(self: Harness; elementName: cstring; padName: cstring;
    mask: gst.PadProbeType; callback: PadProbeCallback; userData: pointer;
    destroyData: DestroyNotify) =
  gst_harness_add_probe(self, elementName, padName, mask, callback, userData, destroyData)

proc gst_harness_add_propose_allocation_meta(self: Harness; api: GType; params: ptr gst.Structure00) {.
    importc, libprag.}

proc addProposeAllocationMeta*(self: Harness; api: GType; params: gst.Structure = nil) =
  gst_harness_add_propose_allocation_meta(self, api, if params.isNil: nil else: cast[ptr gst.Structure00](params.impl))

proc gst_harness_add_sink(self: Harness; sinkElementName: cstring) {.
    importc, libprag.}

proc addSink*(self: Harness; sinkElementName: cstring) =
  gst_harness_add_sink(self, sinkElementName)

proc gst_harness_add_sink_harness(self: Harness; sinkHarness: Harness) {.
    importc, libprag.}

proc addSinkHarness*(self: Harness; sinkHarness: Harness) =
  gst_harness_add_sink_harness(self, sinkHarness)

proc gst_harness_add_sink_parse(self: Harness; launchline: cstring) {.
    importc, libprag.}

proc addSinkParse*(self: Harness; launchline: cstring) =
  gst_harness_add_sink_parse(self, launchline)

proc gst_harness_add_src(self: Harness; srcElementName: cstring; hasClockWait: gboolean) {.
    importc, libprag.}

proc addSrc*(self: Harness; srcElementName: cstring; hasClockWait: bool) =
  gst_harness_add_src(self, srcElementName, gboolean(hasClockWait))

proc gst_harness_add_src_harness(self: Harness; srcHarness: Harness; hasClockWait: gboolean) {.
    importc, libprag.}

proc addSrcHarness*(self: Harness; srcHarness: Harness; hasClockWait: bool) =
  gst_harness_add_src_harness(self, srcHarness, gboolean(hasClockWait))

proc gst_harness_add_src_parse(self: Harness; launchline: cstring; hasClockWait: gboolean) {.
    importc, libprag.}

proc addSrcParse*(self: Harness; launchline: cstring; hasClockWait: bool) =
  gst_harness_add_src_parse(self, launchline, gboolean(hasClockWait))

proc gst_harness_buffers_in_queue(self: Harness): uint32 {.
    importc, libprag.}

proc buffersInQueue*(self: Harness): int =
  int(gst_harness_buffers_in_queue(self))

proc gst_harness_buffers_received(self: Harness): uint32 {.
    importc, libprag.}

proc buffersReceived*(self: Harness): int =
  int(gst_harness_buffers_received(self))

proc gst_harness_crank_multiple_clock_waits(self: Harness; waits: uint32): gboolean {.
    importc, libprag.}

proc crankMultipleClockWaits*(self: Harness; waits: int): bool =
  toBool(gst_harness_crank_multiple_clock_waits(self, uint32(waits)))

proc gst_harness_crank_single_clock_wait(self: Harness): gboolean {.
    importc, libprag.}

proc crankSingleClockWait*(self: Harness): bool =
  toBool(gst_harness_crank_single_clock_wait(self))

proc gst_harness_create_buffer(self: Harness; size: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc createBuffer*(self: Harness; size: uint64): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_harness_create_buffer(self, size)

proc gst_harness_dump_to_file(self: Harness; filename: cstring) {.
    importc, libprag.}

proc dumpToFile*(self: Harness; filename: cstring) =
  gst_harness_dump_to_file(self, filename)

proc gst_harness_events_in_queue(self: Harness): uint32 {.
    importc, libprag.}

proc eventsInQueue*(self: Harness): int =
  int(gst_harness_events_in_queue(self))

proc gst_harness_events_received(self: Harness): uint32 {.
    importc, libprag.}

proc eventsReceived*(self: Harness): int =
  int(gst_harness_events_received(self))

proc gst_harness_find_element(self: Harness; elementName: cstring): ptr gst.Element00 {.
    importc, libprag.}

proc findElement*(self: Harness; elementName: cstring): gst.Element =
  let gobj = gst_harness_find_element(self, elementName)
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

proc gst_harness_get_allocator(self: Harness; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: Harness; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_harness_get_allocator(self, cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstcheck.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_harness_get_last_pushed_timestamp(self: Harness): uint64 {.
    importc, libprag.}

proc getLastPushedTimestamp*(self: Harness): uint64 =
  gst_harness_get_last_pushed_timestamp(self)

proc lastPushedTimestamp*(self: Harness): uint64 =
  gst_harness_get_last_pushed_timestamp(self)

proc gst_harness_play(self: Harness) {.
    importc, libprag.}

proc play*(self: Harness) =
  gst_harness_play(self)

proc gst_harness_pull(self: Harness): ptr gst.Buffer00 {.
    importc, libprag.}

proc pull*(self: Harness): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_harness_pull(self)

proc gst_harness_pull_event(self: Harness): ptr gst.Event00 {.
    importc, libprag.}

proc pullEvent*(self: Harness): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_harness_pull_event(self)

proc gst_harness_pull_until_eos(self: Harness; buf: var ptr gst.Buffer00): gboolean {.
    importc, libprag.}

proc pullUntilEos*(self: Harness; buf: var gst.Buffer): bool =
  fnew(buf, gBoxedFreeGstBuffer)
  toBool(gst_harness_pull_until_eos(self, cast[var ptr gst.Buffer00](addr buf.impl)))

proc gst_harness_pull_upstream_event(self: Harness): ptr gst.Event00 {.
    importc, libprag.}

proc pullUpstreamEvent*(self: Harness): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_harness_pull_upstream_event(self)

proc gst_harness_push(self: Harness; buffer: ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc push*(self: Harness; buffer: gst.Buffer): gst.FlowReturn =
  gst_harness_push(self, cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_harness_push_and_pull(self: Harness; buffer: ptr gst.Buffer00): ptr gst.Buffer00 {.
    importc, libprag.}

proc pushAndPull*(self: Harness; buffer: gst.Buffer): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_harness_push_and_pull(self, cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)))

proc gst_harness_push_event(self: Harness; event: ptr gst.Event00): gboolean {.
    importc, libprag.}

proc pushEvent*(self: Harness; event: gst.Event): bool =
  toBool(gst_harness_push_event(self, cast[ptr gst.Event00](event.impl)))

proc gst_harness_push_from_src(self: Harness): gst.FlowReturn {.
    importc, libprag.}

proc pushFromSrc*(self: Harness): gst.FlowReturn =
  gst_harness_push_from_src(self)

proc gst_harness_push_to_sink(self: Harness): gst.FlowReturn {.
    importc, libprag.}

proc pushToSink*(self: Harness): gst.FlowReturn =
  gst_harness_push_to_sink(self)

proc gst_harness_push_upstream_event(self: Harness; event: ptr gst.Event00): gboolean {.
    importc, libprag.}

proc pushUpstreamEvent*(self: Harness; event: gst.Event): bool =
  toBool(gst_harness_push_upstream_event(self, cast[ptr gst.Event00](event.impl)))

proc gst_harness_query_latency(self: Harness): uint64 {.
    importc, libprag.}

proc queryLatency*(self: Harness): uint64 =
  gst_harness_query_latency(self)

proc gst_harness_set_blocking_push_mode(self: Harness) {.
    importc, libprag.}

proc setBlockingPushMode*(self: Harness) =
  gst_harness_set_blocking_push_mode(self)

proc gst_harness_set_caps(self: Harness; `in`: ptr gst.Caps00; `out`: ptr gst.Caps00) {.
    importc, libprag.}

proc setCaps*(self: Harness; `in`: gst.Caps; `out`: gst.Caps) =
  gst_harness_set_caps(self, cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), `in`.impl)), cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), `out`.impl)))

proc gst_harness_set_caps_str(self: Harness; `in`: cstring; `out`: cstring) {.
    importc, libprag.}

proc setCapsStr*(self: Harness; `in`: cstring; `out`: cstring) =
  gst_harness_set_caps_str(self, `in`, `out`)

proc gst_harness_set_drop_buffers(self: Harness; dropBuffers: gboolean) {.
    importc, libprag.}

proc setDropBuffers*(self: Harness; dropBuffers: bool = true) =
  gst_harness_set_drop_buffers(self, gboolean(dropBuffers))

proc `dropBuffers=`*(self: Harness; dropBuffers: bool) =
  gst_harness_set_drop_buffers(self, gboolean(dropBuffers))

proc gst_harness_set_forwarding(self: Harness; forwarding: gboolean) {.
    importc, libprag.}

proc setForwarding*(self: Harness; forwarding: bool = true) =
  gst_harness_set_forwarding(self, gboolean(forwarding))

proc `forwarding=`*(self: Harness; forwarding: bool) =
  gst_harness_set_forwarding(self, gboolean(forwarding))

proc gst_harness_set_propose_allocator(self: Harness; allocator: ptr gst.Allocator00;
    params: ptr gst.AllocationParams00) {.
    importc, libprag.}

proc setProposeAllocator*(self: Harness; allocator: gst.Allocator = nil;
    params: gst.AllocationParams = nil) =
  gst_harness_set_propose_allocator(self, if allocator.isNil: nil else: cast[ptr gst.Allocator00](g_object_ref(allocator.impl)), if params.isNil: nil else: cast[ptr gst.AllocationParams00](params.impl))

proc gst_harness_set_sink_caps(self: Harness; caps: ptr gst.Caps00) {.
    importc, libprag.}

proc setSinkCaps*(self: Harness; caps: gst.Caps) =
  gst_harness_set_sink_caps(self, cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl)))

proc `sinkCaps=`*(self: Harness; caps: gst.Caps) =
  gst_harness_set_sink_caps(self, cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl)))

proc gst_harness_set_sink_caps_str(self: Harness; str: cstring) {.
    importc, libprag.}

proc setSinkCapsStr*(self: Harness; str: cstring) =
  gst_harness_set_sink_caps_str(self, str)

proc `sinkCapsStr=`*(self: Harness; str: cstring) =
  gst_harness_set_sink_caps_str(self, str)

proc gst_harness_set_src_caps(self: Harness; caps: ptr gst.Caps00) {.
    importc, libprag.}

proc setSrcCaps*(self: Harness; caps: gst.Caps) =
  gst_harness_set_src_caps(self, cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl)))

proc `srcCaps=`*(self: Harness; caps: gst.Caps) =
  gst_harness_set_src_caps(self, cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl)))

proc gst_harness_set_src_caps_str(self: Harness; str: cstring) {.
    importc, libprag.}

proc setSrcCapsStr*(self: Harness; str: cstring) =
  gst_harness_set_src_caps_str(self, str)

proc `srcCapsStr=`*(self: Harness; str: cstring) =
  gst_harness_set_src_caps_str(self, str)

proc gst_harness_set_time(self: Harness; time: uint64): gboolean {.
    importc, libprag.}

proc setTime*(self: Harness; time: uint64): bool =
  toBool(gst_harness_set_time(self, time))

proc gst_harness_set_upstream_latency(self: Harness; latency: uint64) {.
    importc, libprag.}

proc setUpstreamLatency*(self: Harness; latency: uint64) =
  gst_harness_set_upstream_latency(self, latency)

proc `upstreamLatency=`*(self: Harness; latency: uint64) =
  gst_harness_set_upstream_latency(self, latency)

proc gst_harness_sink_push_many(self: Harness; pushes: int32): gst.FlowReturn {.
    importc, libprag.}

proc sinkPushMany*(self: Harness; pushes: int): gst.FlowReturn =
  gst_harness_sink_push_many(self, int32(pushes))

proc gst_harness_src_crank_and_push_many(self: Harness; cranks: int32; pushes: int32): gst.FlowReturn {.
    importc, libprag.}

proc srcCrankAndPushMany*(self: Harness; cranks: int; pushes: int): gst.FlowReturn =
  gst_harness_src_crank_and_push_many(self, int32(cranks), int32(pushes))

proc gst_harness_src_push_event(self: Harness): gboolean {.
    importc, libprag.}

proc srcPushEvent*(self: Harness): bool =
  toBool(gst_harness_src_push_event(self))

proc gst_harness_take_all_data_as_buffer(self: Harness): ptr gst.Buffer00 {.
    importc, libprag.}

proc takeAllDataAsBuffer*(self: Harness): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_harness_take_all_data_as_buffer(self)

proc gst_harness_take_all_data_as_bytes(self: Harness): ptr glib.Bytes00 {.
    importc, libprag.}

proc takeAllData*(self: Harness): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gst_harness_take_all_data_as_bytes(self)

proc gst_harness_teardown(self: Harness) {.
    importc, libprag.}

proc teardown*(self: Harness) =
  gst_harness_teardown(self)

proc gst_harness_try_pull(self: Harness): ptr gst.Buffer00 {.
    importc, libprag.}

proc tryPull*(self: Harness): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_harness_try_pull(self)

proc gst_harness_try_pull_event(self: Harness): ptr gst.Event00 {.
    importc, libprag.}

proc tryPullEvent*(self: Harness): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_harness_try_pull_event(self)

proc gst_harness_try_pull_upstream_event(self: Harness): ptr gst.Event00 {.
    importc, libprag.}

proc tryPullUpstreamEvent*(self: Harness): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_harness_try_pull_upstream_event(self)

proc gst_harness_upstream_events_in_queue(self: Harness): uint32 {.
    importc, libprag.}

proc upstreamEventsInQueue*(self: Harness): int =
  int(gst_harness_upstream_events_in_queue(self))

proc gst_harness_upstream_events_received(self: Harness): uint32 {.
    importc, libprag.}

proc upstreamEventsReceived*(self: Harness): int =
  int(gst_harness_upstream_events_received(self))

proc gst_harness_use_systemclock(self: Harness) {.
    importc, libprag.}

proc useSystemclock*(self: Harness) =
  gst_harness_use_systemclock(self)

proc gst_harness_use_testclock(self: Harness) {.
    importc, libprag.}

proc useTestclock*(self: Harness) =
  gst_harness_use_testclock(self)

proc gst_harness_wait_for_clock_id_waits(self: Harness; waits: uint32; timeout: uint32): gboolean {.
    importc, libprag.}

proc waitForClockIdWaits*(self: Harness; waits: int; timeout: int): bool =
  toBool(gst_harness_wait_for_clock_id_waits(self, uint32(waits), uint32(timeout)))

type
  TestClock* = ref object of gst.Clock
  TestClock00* = object of gst.Clock00

proc gst_test_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TestClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_test_clock_new(): ptr TestClock00 {.
    importc, libprag.}

proc newTestClock*(): TestClock =
  let gobj = gst_test_clock_new()
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

proc newTestClock*(tdesc: typedesc): tdesc =
  assert(result is TestClock)
  let gobj = gst_test_clock_new()
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

proc initTestClock*[T](result: var T) {.deprecated.} =
  assert(result is TestClock)
  let gobj = gst_test_clock_new()
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

proc gst_test_clock_new_with_start_time(startTime: uint64): ptr TestClock00 {.
    importc, libprag.}

proc newTestClockWithStartTime*(startTime: uint64): TestClock =
  let gobj = gst_test_clock_new_with_start_time(startTime)
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

proc newTestClockWithStartTime*(tdesc: typedesc; startTime: uint64): tdesc =
  assert(result is TestClock)
  let gobj = gst_test_clock_new_with_start_time(startTime)
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

proc initTestClockWithStartTime*[T](result: var T; startTime: uint64) {.deprecated.} =
  assert(result is TestClock)
  let gobj = gst_test_clock_new_with_start_time(startTime)
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

proc idListGetLatestTime*(pendingList: ptr glib.List): uint64 {.
    importc: "gst_test_clock_id_list_get_latest_time", libprag.}

proc gst_test_clock_advance_time(self: ptr TestClock00; delta: int64) {.
    importc, libprag.}

proc advanceTime*(self: TestClock; delta: int64) =
  gst_test_clock_advance_time(cast[ptr TestClock00](self.impl), delta)

proc gst_test_clock_crank(self: ptr TestClock00): gboolean {.
    importc, libprag.}

proc crank*(self: TestClock): bool =
  toBool(gst_test_clock_crank(cast[ptr TestClock00](self.impl)))

proc gst_test_clock_get_next_entry_time(self: ptr TestClock00): uint64 {.
    importc, libprag.}

proc getNextEntryTime*(self: TestClock): uint64 =
  gst_test_clock_get_next_entry_time(cast[ptr TestClock00](self.impl))

proc nextEntryTime*(self: TestClock): uint64 =
  gst_test_clock_get_next_entry_time(cast[ptr TestClock00](self.impl))

proc gst_test_clock_has_id(self: ptr TestClock00; id: pointer): gboolean {.
    importc, libprag.}

proc hasId*(self: TestClock; id: pointer): bool =
  toBool(gst_test_clock_has_id(cast[ptr TestClock00](self.impl), id))

proc gst_test_clock_peek_id_count(self: ptr TestClock00): uint32 {.
    importc, libprag.}

proc peekIdCount*(self: TestClock): int =
  int(gst_test_clock_peek_id_count(cast[ptr TestClock00](self.impl)))

proc gst_test_clock_peek_next_pending_id(self: ptr TestClock00; pendingId: var pointer): gboolean {.
    importc, libprag.}

proc peekNextPendingId*(self: TestClock; pendingId: var pointer = cast[var pointer](nil)): bool =
  toBool(gst_test_clock_peek_next_pending_id(cast[ptr TestClock00](self.impl), pendingId))

proc gst_test_clock_process_id(self: ptr TestClock00; pendingId: pointer): gboolean {.
    importc, libprag.}

proc processId*(self: TestClock; pendingId: pointer): bool =
  toBool(gst_test_clock_process_id(cast[ptr TestClock00](self.impl), pendingId))

proc gst_test_clock_process_id_list(self: ptr TestClock00; pendingList: ptr glib.List): uint32 {.
    importc, libprag.}

proc processIdList*(self: TestClock; pendingList: seq[pointer]): int =
  var tempResGL = seq2GList(pendingList)
  result = int(gst_test_clock_process_id_list(cast[ptr TestClock00](self.impl), tempResGL))
  g_list_free(tempResGL)

proc gst_test_clock_process_next_clock_id(self: ptr TestClock00): pointer {.
    importc, libprag.}

proc processNextClockId*(self: TestClock): pointer =
  gst_test_clock_process_next_clock_id(cast[ptr TestClock00](self.impl))

proc gst_test_clock_set_time(self: ptr TestClock00; newTime: uint64) {.
    importc, libprag.}

proc setTime*(self: TestClock; newTime: uint64) =
  gst_test_clock_set_time(cast[ptr TestClock00](self.impl), newTime)

proc `time=`*(self: TestClock; newTime: uint64) =
  gst_test_clock_set_time(cast[ptr TestClock00](self.impl), newTime)

proc gst_test_clock_timed_wait_for_multiple_pending_ids(self: ptr TestClock00;
    count: uint32; timeoutMs: uint32; pendingList: var ptr glib.List): gboolean {.
    importc, libprag.}

proc timedWaitForMultiplePendingIds*(self: TestClock;
    count: int; timeoutMs: int; pendingList: var seq[pointer] = cast[var seq[pointer]](nil)): bool =
  var tempResGL = seq2GList(pendingList)
  toBool(gst_test_clock_timed_wait_for_multiple_pending_ids(cast[ptr TestClock00](self.impl), uint32(count), uint32(timeoutMs), tempResGL))

proc gst_test_clock_wait_for_multiple_pending_ids(self: ptr TestClock00;
    count: uint32; pendingList: var ptr glib.List) {.
    importc, libprag.}

proc waitForMultiplePendingIds*(self: TestClock; count: int;
    pendingList: var seq[pointer] = cast[var seq[pointer]](nil)) =
  var tempResGL = seq2GList(pendingList)
  gst_test_clock_wait_for_multiple_pending_ids(cast[ptr TestClock00](self.impl), uint32(count), tempResGL)

proc gst_test_clock_wait_for_next_pending_id(self: ptr TestClock00; pendingId: var pointer) {.
    importc, libprag.}

proc waitForNextPendingId*(self: TestClock; pendingId: var pointer = cast[var pointer](nil)) =
  gst_test_clock_wait_for_next_pending_id(cast[ptr TestClock00](self.impl), pendingId)

proc waitForNextPendingId*(self: TestClock): pointer  =
  gst_test_clock_wait_for_next_pending_id(cast[ptr TestClock00](self.impl), result)

proc gst_test_clock_wait_for_pending_id_count(self: ptr TestClock00; count: uint32) {.
    importc, libprag.}

proc waitForPendingIdCount*(self: TestClock; count: int) =
  gst_test_clock_wait_for_pending_id_count(cast[ptr TestClock00](self.impl), uint32(count))

proc gst_harness_get_testclock(self: Harness): ptr TestClock00 {.
    importc, libprag.}

proc getTestclock*(self: Harness): TestClock =
  let gobj = gst_harness_get_testclock(self)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstcheck.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc testclock*(self: Harness): TestClock =
  let gobj = gst_harness_get_testclock(self)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstcheck.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  HarnessThread* {.pure, byRef.} = object

proc gst_harness_stress_thread_stop(t: HarnessThread): uint32 {.
    importc, libprag.}

proc stressThreadStop*(t: HarnessThread): int =
  int(gst_harness_stress_thread_stop(t))

type
  HarnessPrepareBufferFunc* = proc (h: Harness; data: pointer): ptr gst.Buffer00 {.cdecl.}

type
  HarnessPrepareEventFunc* = proc (h: Harness; data: pointer): ptr gst.Event00 {.cdecl.}

type
  StreamConsistency* {.pure, byRef.} = object

proc gst_buffer_straw_get_buffer(bin: ptr gst.Element00; pad: ptr gst.Pad00): ptr gst.Buffer00 {.
    importc, libprag.}

proc bufferStrawGetBuffer*(bin: gst.Element; pad: gst.Pad): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_straw_get_buffer(cast[ptr gst.Element00](bin.impl), cast[ptr gst.Pad00](pad.impl))

proc gst_buffer_straw_start_pipeline(bin: ptr gst.Element00; pad: ptr gst.Pad00) {.
    importc, libprag.}

proc bufferStrawStartPipeline*(bin: gst.Element; pad: gst.Pad) =
  gst_buffer_straw_start_pipeline(cast[ptr gst.Element00](bin.impl), cast[ptr gst.Pad00](pad.impl))

proc gst_buffer_straw_stop_pipeline(bin: ptr gst.Element00; pad: ptr gst.Pad00) {.
    importc, libprag.}

proc bufferStrawStopPipeline*(bin: gst.Element; pad: gst.Pad) =
  gst_buffer_straw_stop_pipeline(cast[ptr gst.Element00](bin.impl), cast[ptr gst.Pad00](pad.impl))

proc gst_check_abi_list(list: CheckABIStruct; haveAbiSizes: gboolean) {.
    importc, libprag.}

proc checkAbiList*(list: CheckABIStruct; haveAbiSizes: bool) =
  gst_check_abi_list(list, gboolean(haveAbiSizes))

proc gst_check_buffer_data(buffer: ptr gst.Buffer00; data: pointer; size: uint64) {.
    importc, libprag.}

proc checkBufferData*(buffer: gst.Buffer; data: pointer; size: uint64) =
  gst_check_buffer_data(cast[ptr gst.Buffer00](buffer.impl), data, size)

proc gst_check_caps_equal(caps1: ptr gst.Caps00; caps2: ptr gst.Caps00) {.
    importc, libprag.}

proc checkCapsEqual*(caps1: gst.Caps; caps2: gst.Caps) =
  gst_check_caps_equal(cast[ptr gst.Caps00](caps1.impl), cast[ptr gst.Caps00](caps2.impl))

proc gst_check_chain_func(pad: ptr gst.Pad00; parent: ptr gst.Object00; buffer: ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc checkChainFunc*(pad: gst.Pad; parent: gst.Object; buffer: gst.Buffer): gst.FlowReturn =
  gst_check_chain_func(cast[ptr gst.Pad00](pad.impl), cast[ptr gst.Object00](parent.impl), cast[ptr gst.Buffer00](buffer.impl))

proc checkClearLogFilter*() {.
    importc: "gst_check_clear_log_filter", libprag.}

proc checkDropBuffers*() {.
    importc: "gst_check_drop_buffers", libprag.}

proc gst_check_element_push_buffer(elementName: cstring; bufferIn: ptr gst.Buffer00;
    capsIn: ptr gst.Caps00; bufferOut: ptr gst.Buffer00; capsOut: ptr gst.Caps00) {.
    importc, libprag.}

proc checkElementPushBuffer*(elementName: cstring; bufferIn: gst.Buffer;
    capsIn: gst.Caps; bufferOut: gst.Buffer; capsOut: gst.Caps) =
  gst_check_element_push_buffer(elementName, cast[ptr gst.Buffer00](bufferIn.impl), cast[ptr gst.Caps00](capsIn.impl), cast[ptr gst.Buffer00](bufferOut.impl), cast[ptr gst.Caps00](capsOut.impl))

proc gst_check_element_push_buffer_list(elementName: cstring; bufferIn: ptr glib.List;
    capsIn: ptr gst.Caps00; bufferOut: ptr glib.List; capsOut: ptr gst.Caps00;
    lastFlowReturn: gst.FlowReturn) {.
    importc, libprag.}

proc checkElementPushBufferList*(elementName: cstring; bufferIn: seq[gst.Buffer];
    capsIn: gst.Caps; bufferOut: seq[gst.Buffer]; capsOut: gst.Caps; lastFlowReturn: gst.FlowReturn) =
  var tempResGL = seq2GList(bufferOut)
  gst_check_element_push_buffer_list(elementName, tempResGL, cast[ptr gst.Caps00](capsIn.impl), tempResGL, cast[ptr gst.Caps00](capsOut.impl), lastFlowReturn)

proc checkInit*(argc: ptr int32; argv: cstring) {.
    importc: "gst_check_init", libprag.}

proc gst_check_message_error(message: ptr gst.Message00; `type`: gst.MessageType;
    domain: uint32; code: int32) {.
    importc, libprag.}

proc checkMessageError*(message: gst.Message; `type`: gst.MessageType;
    domain: int; code: int) =
  gst_check_message_error(cast[ptr gst.Message00](message.impl), `type`, uint32(domain), int32(code))

proc checkObjectDestroyedOnUnref*(objectToUnref: pointer) {.
    importc: "gst_check_object_destroyed_on_unref", libprag.}

proc gst_check_remove_log_filter(filter: ptr CheckLogFilter00) {.
    importc, libprag.}

proc checkRemoveLogFilter*(filter: CheckLogFilter) =
  gst_check_remove_log_filter(cast[ptr CheckLogFilter00](filter.impl))

proc gst_check_setup_element(factory: cstring): ptr gst.Element00 {.
    importc, libprag.}

proc checkSetupElement*(factory: cstring): gst.Element =
  let gobj = gst_check_setup_element(factory)
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

proc gst_check_setup_events(srcpad: ptr gst.Pad00; element: ptr gst.Element00;
    caps: ptr gst.Caps00; format: gst.Format) {.
    importc, libprag.}

proc checkSetupEvents*(srcpad: gst.Pad; element: gst.Element; caps: gst.Caps = nil;
    format: gst.Format) =
  gst_check_setup_events(cast[ptr gst.Pad00](srcpad.impl), cast[ptr gst.Element00](element.impl), if caps.isNil: nil else: cast[ptr gst.Caps00](caps.impl), format)

proc gst_check_setup_events_with_stream_id(srcpad: ptr gst.Pad00; element: ptr gst.Element00;
    caps: ptr gst.Caps00; format: gst.Format; streamId: cstring) {.
    importc, libprag.}

proc checkSetupEventsWithStreamId*(srcpad: gst.Pad; element: gst.Element;
    caps: gst.Caps = nil; format: gst.Format; streamId: cstring) =
  gst_check_setup_events_with_stream_id(cast[ptr gst.Pad00](srcpad.impl), cast[ptr gst.Element00](element.impl), if caps.isNil: nil else: cast[ptr gst.Caps00](caps.impl), format, streamId)

proc gst_check_setup_sink_pad(element: ptr gst.Element00; tmpl: ptr gst.StaticPadTemplate00): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSinkPad*(element: gst.Element; tmpl: gst.StaticPadTemplate): gst.Pad =
  let gobj = gst_check_setup_sink_pad(cast[ptr gst.Element00](element.impl), cast[ptr gst.StaticPadTemplate00](tmpl.impl))
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

proc gst_check_setup_sink_pad_by_name(element: ptr gst.Element00; tmpl: ptr gst.StaticPadTemplate00;
    name: cstring): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSinkPadByName*(element: gst.Element; tmpl: gst.StaticPadTemplate;
    name: cstring): gst.Pad =
  let gobj = gst_check_setup_sink_pad_by_name(cast[ptr gst.Element00](element.impl), cast[ptr gst.StaticPadTemplate00](tmpl.impl), name)
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

proc gst_check_setup_sink_pad_by_name_from_template(element: ptr gst.Element00;
    tmpl: ptr gst.PadTemplate00; name: cstring): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSinkPadByNameFromTemplate*(element: gst.Element;
    tmpl: gst.PadTemplate; name: cstring): gst.Pad =
  let gobj = gst_check_setup_sink_pad_by_name_from_template(cast[ptr gst.Element00](element.impl), cast[ptr gst.PadTemplate00](tmpl.impl), name)
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

proc gst_check_setup_sink_pad_from_template(element: ptr gst.Element00; tmpl: ptr gst.PadTemplate00): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSinkPadFromTemplate*(element: gst.Element; tmpl: gst.PadTemplate): gst.Pad =
  let gobj = gst_check_setup_sink_pad_from_template(cast[ptr gst.Element00](element.impl), cast[ptr gst.PadTemplate00](tmpl.impl))
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

proc gst_check_setup_src_pad(element: ptr gst.Element00; tmpl: ptr gst.StaticPadTemplate00): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSrcPad*(element: gst.Element; tmpl: gst.StaticPadTemplate): gst.Pad =
  let gobj = gst_check_setup_src_pad(cast[ptr gst.Element00](element.impl), cast[ptr gst.StaticPadTemplate00](tmpl.impl))
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

proc gst_check_setup_src_pad_by_name(element: ptr gst.Element00; tmpl: ptr gst.StaticPadTemplate00;
    name: cstring): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSrcPadByName*(element: gst.Element; tmpl: gst.StaticPadTemplate;
    name: cstring): gst.Pad =
  let gobj = gst_check_setup_src_pad_by_name(cast[ptr gst.Element00](element.impl), cast[ptr gst.StaticPadTemplate00](tmpl.impl), name)
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

proc gst_check_setup_src_pad_by_name_from_template(element: ptr gst.Element00;
    tmpl: ptr gst.PadTemplate00; name: cstring): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSrcPadByNameFromTemplate*(element: gst.Element;
    tmpl: gst.PadTemplate; name: cstring): gst.Pad =
  let gobj = gst_check_setup_src_pad_by_name_from_template(cast[ptr gst.Element00](element.impl), cast[ptr gst.PadTemplate00](tmpl.impl), name)
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

proc gst_check_setup_src_pad_from_template(element: ptr gst.Element00; tmpl: ptr gst.PadTemplate00): ptr gst.Pad00 {.
    importc, libprag.}

proc checkSetupSrcPadFromTemplate*(element: gst.Element; tmpl: gst.PadTemplate): gst.Pad =
  let gobj = gst_check_setup_src_pad_from_template(cast[ptr gst.Element00](element.impl), cast[ptr gst.PadTemplate00](tmpl.impl))
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

proc gst_check_teardown_element(element: ptr gst.Element00) {.
    importc, libprag.}

proc checkTeardownElement*(element: gst.Element) =
  gst_check_teardown_element(cast[ptr gst.Element00](element.impl))

proc gst_check_teardown_pad_by_name(element: ptr gst.Element00; name: cstring) {.
    importc, libprag.}

proc checkTeardownPadByName*(element: gst.Element; name: cstring) =
  gst_check_teardown_pad_by_name(cast[ptr gst.Element00](element.impl), name)

proc gst_check_teardown_sink_pad(element: ptr gst.Element00) {.
    importc, libprag.}

proc checkTeardownSinkPad*(element: gst.Element) =
  gst_check_teardown_sink_pad(cast[ptr gst.Element00](element.impl))

proc gst_check_teardown_src_pad(element: ptr gst.Element00) {.
    importc, libprag.}

proc checkTeardownSrcPad*(element: gst.Element) =
  gst_check_teardown_src_pad(cast[ptr gst.Element00](element.impl))

proc gst_consistency_checker_add_pad(consist: StreamConsistency; pad: ptr gst.Pad00): gboolean {.
    importc, libprag.}

proc consistencyCheckerAddPad*(consist: StreamConsistency; pad: gst.Pad): bool =
  toBool(gst_consistency_checker_add_pad(consist, cast[ptr gst.Pad00](pad.impl)))

proc consistencyCheckerFree*(consist: StreamConsistency) {.
    importc: "gst_consistency_checker_free", libprag.}

proc consistencyCheckerReset*(consist: StreamConsistency) {.
    importc: "gst_consistency_checker_reset", libprag.}
# === remaining symbols:
