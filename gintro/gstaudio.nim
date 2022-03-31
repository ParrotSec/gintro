# dependencies:
# GObject-2.0
# GstBase-1.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# GstBase-1.0
# Gst-1.0
# GObject-2.0
# GModule-2.0
# GLib-2.0
# libraries:
# libgstaudio-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gst, glib, gmodule
const Lib = "libgstaudio-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const AUDIO_CHANNELS_RANGE* = "(int) [ 1, max ]"

const AUDIO_CONVERTER_OPT_DITHER_METHOD* = "GstAudioConverter.dither-method"

const AUDIO_CONVERTER_OPT_MIX_MATRIX* = "GstAudioConverter.mix-matrix"

const AUDIO_CONVERTER_OPT_NOISE_SHAPING_METHOD* = "GstAudioConverter.noise-shaping-method"

const AUDIO_CONVERTER_OPT_QUANTIZATION* = "GstAudioConverter.quantization"

const AUDIO_CONVERTER_OPT_RESAMPLER_METHOD* = "GstAudioConverter.resampler-method"

const AUDIO_DECODER_MAX_ERRORS* = 10'i32

const AUDIO_DECODER_SINK_NAME* = "sink"

const AUDIO_DECODER_SRC_NAME* = "src"

const AUDIO_DEF_CHANNELS* = 2'i32

const AUDIO_DEF_FORMAT* = "S16LE"

const AUDIO_DEF_RATE* = 44100'i32

const AUDIO_ENCODER_SINK_NAME* = "sink"

const AUDIO_ENCODER_SRC_NAME* = "src"

const AUDIO_FORMATS_ALL* = "{ F64BE, F64LE, F32BE, F32LE, S32BE, S32LE, U32BE, U32LE, S24_32BE, S24_32LE, U24_32BE, U24_32LE, S24BE, S24LE, U24BE, U24LE, S20BE, S20LE, U20BE, U20LE, S18BE, S18LE, U18BE, U18LE, S16BE, S16LE, U16BE, U16LE, S8, U8 }"

const AUDIO_RATE_RANGE* = "(int) [ 1, max ]"

const AUDIO_RESAMPLER_OPT_CUBIC_B* = "GstAudioResampler.cubic-b"

const AUDIO_RESAMPLER_OPT_CUBIC_C* = "GstAudioResampler.cubic-c"

const AUDIO_RESAMPLER_OPT_CUTOFF* = "GstAudioResampler.cutoff"

const AUDIO_RESAMPLER_OPT_FILTER_INTERPOLATION* = "GstAudioResampler.filter-interpolation"

const AUDIO_RESAMPLER_OPT_FILTER_MODE* = "GstAudioResampler.filter-mode"

const AUDIO_RESAMPLER_OPT_FILTER_MODE_THRESHOLD* = "GstAudioResampler.filter-mode-threshold"

const AUDIO_RESAMPLER_OPT_FILTER_OVERSAMPLE* = "GstAudioResampler.filter-oversample"

const AUDIO_RESAMPLER_OPT_MAX_PHASE_ERROR* = "GstAudioResampler.max-phase-error"

const AUDIO_RESAMPLER_OPT_N_TAPS* = "GstAudioResampler.n-taps"

const AUDIO_RESAMPLER_OPT_STOP_ATTENUATION* = "GstAudioResampler.stop-attenutation"

const AUDIO_RESAMPLER_OPT_TRANSITION_BANDWIDTH* = "GstAudioResampler.transition-bandwidth"

const AUDIO_RESAMPLER_QUALITY_DEFAULT* = 4'i32

const AUDIO_RESAMPLER_QUALITY_MAX* = 10'i32

const AUDIO_RESAMPLER_QUALITY_MIN* = 0'i32

type
  AudioAggregator* = ref object of gstbase.Aggregator
  AudioAggregator00* = object of gstbase.Aggregator00

proc gst_audio_aggregator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioAggregator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AudioAggregatorPad* = ref object of gstbase.AggregatorPad
  AudioAggregatorPad00* = object of gstbase.AggregatorPad00

proc gst_audio_aggregator_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioAggregatorPad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_audio_aggregator_set_sink_caps(self: ptr AudioAggregator00; pad: ptr AudioAggregatorPad00;
    caps: ptr gst.Caps00) {.
    importc, libprag.}

proc setSinkCaps*(self: AudioAggregator; pad: AudioAggregatorPad;
    caps: gst.Caps) =
  gst_audio_aggregator_set_sink_caps(cast[ptr AudioAggregator00](self.impl), cast[ptr AudioAggregatorPad00](pad.impl), cast[ptr gst.Caps00](caps.impl))

type
  AudioAggregatorConvertPad* = ref object of AudioAggregatorPad
  AudioAggregatorConvertPad00* = object of AudioAggregatorPad00

proc gst_audio_aggregator_convert_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioAggregatorConvertPad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AudioBaseSink* = ref object of gstbase.BaseSink
  AudioBaseSink00* = object of gstbase.BaseSink00

proc gst_audio_base_sink_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioBaseSink()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_audio_base_sink_get_alignment_threshold(self: ptr AudioBaseSink00): uint64 {.
    importc, libprag.}

proc getAlignmentThreshold*(self: AudioBaseSink): uint64 =
  gst_audio_base_sink_get_alignment_threshold(cast[ptr AudioBaseSink00](self.impl))

proc alignmentThreshold*(self: AudioBaseSink): uint64 =
  gst_audio_base_sink_get_alignment_threshold(cast[ptr AudioBaseSink00](self.impl))

proc gst_audio_base_sink_get_discont_wait(self: ptr AudioBaseSink00): uint64 {.
    importc, libprag.}

proc getDiscontWait*(self: AudioBaseSink): uint64 =
  gst_audio_base_sink_get_discont_wait(cast[ptr AudioBaseSink00](self.impl))

proc discontWait*(self: AudioBaseSink): uint64 =
  gst_audio_base_sink_get_discont_wait(cast[ptr AudioBaseSink00](self.impl))

proc gst_audio_base_sink_get_drift_tolerance(self: ptr AudioBaseSink00): int64 {.
    importc, libprag.}

proc getDriftTolerance*(self: AudioBaseSink): int64 =
  gst_audio_base_sink_get_drift_tolerance(cast[ptr AudioBaseSink00](self.impl))

proc driftTolerance*(self: AudioBaseSink): int64 =
  gst_audio_base_sink_get_drift_tolerance(cast[ptr AudioBaseSink00](self.impl))

proc gst_audio_base_sink_get_provide_clock(self: ptr AudioBaseSink00): gboolean {.
    importc, libprag.}

proc getProvideClock*(self: AudioBaseSink): bool =
  toBool(gst_audio_base_sink_get_provide_clock(cast[ptr AudioBaseSink00](self.impl)))

proc provideClock*(self: AudioBaseSink): bool =
  toBool(gst_audio_base_sink_get_provide_clock(cast[ptr AudioBaseSink00](self.impl)))

proc gst_audio_base_sink_report_device_failure(self: ptr AudioBaseSink00) {.
    importc, libprag.}

proc reportDeviceFailure*(self: AudioBaseSink) =
  gst_audio_base_sink_report_device_failure(cast[ptr AudioBaseSink00](self.impl))

proc gst_audio_base_sink_set_alignment_threshold(self: ptr AudioBaseSink00;
    alignmentThreshold: uint64) {.
    importc, libprag.}

proc setAlignmentThreshold*(self: AudioBaseSink; alignmentThreshold: uint64) =
  gst_audio_base_sink_set_alignment_threshold(cast[ptr AudioBaseSink00](self.impl), alignmentThreshold)

proc `alignmentThreshold=`*(self: AudioBaseSink; alignmentThreshold: uint64) =
  gst_audio_base_sink_set_alignment_threshold(cast[ptr AudioBaseSink00](self.impl), alignmentThreshold)

proc gst_audio_base_sink_set_discont_wait(self: ptr AudioBaseSink00; discontWait: uint64) {.
    importc, libprag.}

proc setDiscontWait*(self: AudioBaseSink; discontWait: uint64) =
  gst_audio_base_sink_set_discont_wait(cast[ptr AudioBaseSink00](self.impl), discontWait)

proc `discontWait=`*(self: AudioBaseSink; discontWait: uint64) =
  gst_audio_base_sink_set_discont_wait(cast[ptr AudioBaseSink00](self.impl), discontWait)

proc gst_audio_base_sink_set_drift_tolerance(self: ptr AudioBaseSink00; driftTolerance: int64) {.
    importc, libprag.}

proc setDriftTolerance*(self: AudioBaseSink; driftTolerance: int64) =
  gst_audio_base_sink_set_drift_tolerance(cast[ptr AudioBaseSink00](self.impl), driftTolerance)

proc `driftTolerance=`*(self: AudioBaseSink; driftTolerance: int64) =
  gst_audio_base_sink_set_drift_tolerance(cast[ptr AudioBaseSink00](self.impl), driftTolerance)

proc gst_audio_base_sink_set_provide_clock(self: ptr AudioBaseSink00; provide: gboolean) {.
    importc, libprag.}

proc setProvideClock*(self: AudioBaseSink; provide: bool = true) =
  gst_audio_base_sink_set_provide_clock(cast[ptr AudioBaseSink00](self.impl), gboolean(provide))

proc `provideClock=`*(self: AudioBaseSink; provide: bool) =
  gst_audio_base_sink_set_provide_clock(cast[ptr AudioBaseSink00](self.impl), gboolean(provide))

type
  AudioRingBuffer* = ref object of gst.Object
  AudioRingBuffer00* = object of gst.Object00

proc gst_audio_ring_buffer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioRingBuffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_audio_ring_buffer_activate(self: ptr AudioRingBuffer00; active: gboolean): gboolean {.
    importc, libprag.}

proc activate*(self: AudioRingBuffer; active: bool): bool =
  toBool(gst_audio_ring_buffer_activate(cast[ptr AudioRingBuffer00](self.impl), gboolean(active)))

proc gst_audio_ring_buffer_advance(self: ptr AudioRingBuffer00; advance: uint32) {.
    importc, libprag.}

proc advance*(self: AudioRingBuffer; advance: int) =
  gst_audio_ring_buffer_advance(cast[ptr AudioRingBuffer00](self.impl), uint32(advance))

proc gst_audio_ring_buffer_clear(self: ptr AudioRingBuffer00; segment: int32) {.
    importc, libprag.}

proc clear*(self: AudioRingBuffer; segment: int) =
  gst_audio_ring_buffer_clear(cast[ptr AudioRingBuffer00](self.impl), int32(segment))

proc gst_audio_ring_buffer_clear_all(self: ptr AudioRingBuffer00) {.
    importc, libprag.}

proc clearAll*(self: AudioRingBuffer) =
  gst_audio_ring_buffer_clear_all(cast[ptr AudioRingBuffer00](self.impl))

proc gst_audio_ring_buffer_close_device(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc closeDevice*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_close_device(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_commit(self: ptr AudioRingBuffer00; sample: ptr uint64;
    data: ptr uint8; inSamples: int32; outSamples: int32; accum: var int32): uint32 {.
    importc, libprag.}

proc commit*(self: AudioRingBuffer; sample: ptr uint64;
    data: seq[uint8] | string; outSamples: int; accum: var int): int =
  let inSamples = int(data.len)
  var accum_00 = int32(accum)
  result = int(gst_audio_ring_buffer_commit(cast[ptr AudioRingBuffer00](self.impl), sample, cast[ptr uint8](unsafeaddr(data[0])), int32(inSamples), int32(outSamples), accum_00))
  accum = int(accum_00)

proc gst_audio_ring_buffer_convert(self: ptr AudioRingBuffer00; srcFmt: gst.Format;
    srcVal: int64; destFmt: gst.Format; destVal: var int64): gboolean {.
    importc, libprag.}

proc convert*(self: AudioRingBuffer; srcFmt: gst.Format;
    srcVal: int64; destFmt: gst.Format; destVal: var int64): bool =
  toBool(gst_audio_ring_buffer_convert(cast[ptr AudioRingBuffer00](self.impl), srcFmt, srcVal, destFmt, destVal))

proc gst_audio_ring_buffer_delay(self: ptr AudioRingBuffer00): uint32 {.
    importc, libprag.}

proc delay*(self: AudioRingBuffer): int =
  int(gst_audio_ring_buffer_delay(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_device_is_open(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc deviceIsOpen*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_device_is_open(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_is_acquired(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc isAcquired*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_is_acquired(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_is_active(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc isActive*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_is_active(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_is_flushing(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc isFlushing*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_is_flushing(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_may_start(self: ptr AudioRingBuffer00; allowed: gboolean) {.
    importc, libprag.}

proc mayStart*(self: AudioRingBuffer; allowed: bool) =
  gst_audio_ring_buffer_may_start(cast[ptr AudioRingBuffer00](self.impl), gboolean(allowed))

proc gst_audio_ring_buffer_open_device(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc openDevice*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_open_device(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_pause(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc pause*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_pause(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_prepare_read(self: ptr AudioRingBuffer00; segment: var int32;
    readptr: var ptr uint8; len: var int32): gboolean {.
    importc, libprag.}

proc prepareRead*(self: AudioRingBuffer; segment: var int;
    readptr: var (seq[uint8] | string); len: var int): bool =
  var segment_00: int32
  var len_00: int32
  var readptr_00: ptr uint8
  result = toBool(gst_audio_ring_buffer_prepare_read(cast[ptr AudioRingBuffer00](self.impl), segment_00, readptr_00, len_00))
  if segment.addr != nil:
    segment = int(segment_00)
  if len.addr != nil:
    len = int(len_00)
  readptr.setLen(len)
  copyMem(unsafeaddr readptr[0], readptr_00, len.int * sizeof(readptr[0]))
  cogfree(readptr_00)

proc gst_audio_ring_buffer_read(self: ptr AudioRingBuffer00; sample: uint64;
    data: ptr uint8; len: uint32; timestamp: var uint64): uint32 {.
    importc, libprag.}

proc read*(self: AudioRingBuffer; sample: uint64; data: seq[uint8] | string;
    timestamp: var uint64): int =
  let len = int(data.len)
  int(gst_audio_ring_buffer_read(cast[ptr AudioRingBuffer00](self.impl), sample, cast[ptr uint8](unsafeaddr(data[0])), uint32(len), timestamp))

proc gst_audio_ring_buffer_release(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc release*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_release(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_samples_done(self: ptr AudioRingBuffer00): uint64 {.
    importc, libprag.}

proc samplesDone*(self: AudioRingBuffer): uint64 =
  gst_audio_ring_buffer_samples_done(cast[ptr AudioRingBuffer00](self.impl))

proc gst_audio_ring_buffer_set_flushing(self: ptr AudioRingBuffer00; flushing: gboolean) {.
    importc, libprag.}

proc setFlushing*(self: AudioRingBuffer; flushing: bool = true) =
  gst_audio_ring_buffer_set_flushing(cast[ptr AudioRingBuffer00](self.impl), gboolean(flushing))

proc `flushing=`*(self: AudioRingBuffer; flushing: bool) =
  gst_audio_ring_buffer_set_flushing(cast[ptr AudioRingBuffer00](self.impl), gboolean(flushing))

proc gst_audio_ring_buffer_set_sample(self: ptr AudioRingBuffer00; sample: uint64) {.
    importc, libprag.}

proc setSample*(self: AudioRingBuffer; sample: uint64) =
  gst_audio_ring_buffer_set_sample(cast[ptr AudioRingBuffer00](self.impl), sample)

proc `sample=`*(self: AudioRingBuffer; sample: uint64) =
  gst_audio_ring_buffer_set_sample(cast[ptr AudioRingBuffer00](self.impl), sample)

proc gst_audio_ring_buffer_set_timestamp(self: ptr AudioRingBuffer00; readseg: int32;
    timestamp: uint64) {.
    importc, libprag.}

proc setTimestamp*(self: AudioRingBuffer; readseg: int;
    timestamp: uint64) =
  gst_audio_ring_buffer_set_timestamp(cast[ptr AudioRingBuffer00](self.impl), int32(readseg), timestamp)

proc gst_audio_ring_buffer_start(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc start*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_start(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_ring_buffer_stop(self: ptr AudioRingBuffer00): gboolean {.
    importc, libprag.}

proc stop*(self: AudioRingBuffer): bool =
  toBool(gst_audio_ring_buffer_stop(cast[ptr AudioRingBuffer00](self.impl)))

proc gst_audio_base_sink_create_ringbuffer(self: ptr AudioBaseSink00): ptr AudioRingBuffer00 {.
    importc, libprag.}

proc createRingbuffer*(self: AudioBaseSink): AudioRingBuffer =
  let gobj = gst_audio_base_sink_create_ringbuffer(cast[ptr AudioBaseSink00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstaudio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  AudioRingBufferSpec00* {.pure.} = object
  AudioRingBufferSpec* = ref object
    impl*: ptr AudioRingBufferSpec00
    ignoreFinalizer*: bool

proc gst_audio_ring_buffer_debug_spec_buff(spec: ptr AudioRingBufferSpec00) {.
    importc, libprag.}

proc debugSpecBuff*(spec: AudioRingBufferSpec) =
  gst_audio_ring_buffer_debug_spec_buff(cast[ptr AudioRingBufferSpec00](spec.impl))

proc gst_audio_ring_buffer_debug_spec_caps(spec: ptr AudioRingBufferSpec00) {.
    importc, libprag.}

proc debugSpecCaps*(spec: AudioRingBufferSpec) =
  gst_audio_ring_buffer_debug_spec_caps(cast[ptr AudioRingBufferSpec00](spec.impl))

proc gst_audio_ring_buffer_parse_caps(spec: ptr AudioRingBufferSpec00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc parseCaps*(spec: AudioRingBufferSpec; caps: gst.Caps): bool =
  toBool(gst_audio_ring_buffer_parse_caps(cast[ptr AudioRingBufferSpec00](spec.impl), cast[ptr gst.Caps00](caps.impl)))

proc gst_audio_ring_buffer_acquire(self: ptr AudioRingBuffer00; spec: ptr AudioRingBufferSpec00): gboolean {.
    importc, libprag.}

proc acquire*(self: AudioRingBuffer; spec: AudioRingBufferSpec): bool =
  toBool(gst_audio_ring_buffer_acquire(cast[ptr AudioRingBuffer00](self.impl), cast[ptr AudioRingBufferSpec00](spec.impl)))

type
  AudioChannelPosition* {.size: sizeof(cint), pure.} = enum
    none = -3
    mono = -2
    invalid = -1
    frontLeft = 0
    frontRight = 1
    frontCenter = 2
    lfe1 = 3
    rearLeft = 4
    rearRight = 5
    frontLeftOfCenter = 6
    frontRightOfCenter = 7
    rearCenter = 8
    lfe2 = 9
    sideLeft = 10
    sideRight = 11
    topFrontLeft = 12
    topFrontRight = 13
    topFrontCenter = 14
    topCenter = 15
    topRearLeft = 16
    topRearRight = 17
    topSideLeft = 18
    topSideRight = 19
    topRearCenter = 20
    bottomFrontCenter = 21
    bottomFrontLeft = 22
    bottomFrontRight = 23
    wideLeft = 24
    wideRight = 25
    surroundLeft = 26
    surroundRight = 27

proc gst_audio_ring_buffer_set_channel_positions(self: ptr AudioRingBuffer00;
    position: ptr AudioChannelPosition) {.
    importc, libprag.}

proc setChannelPositions*(self: AudioRingBuffer; position: ptr AudioChannelPosition) =
  gst_audio_ring_buffer_set_channel_positions(cast[ptr AudioRingBuffer00](self.impl), position)

proc `channelPositions=`*(self: AudioRingBuffer; position: ptr AudioChannelPosition) =
  gst_audio_ring_buffer_set_channel_positions(cast[ptr AudioRingBuffer00](self.impl), position)

type
  AudioBaseSinkSlaveMethod* {.size: sizeof(cint), pure.} = enum
    resample = 0
    skew = 1
    none = 2
    custom = 3

proc gst_audio_base_sink_get_slave_method(self: ptr AudioBaseSink00): AudioBaseSinkSlaveMethod {.
    importc, libprag.}

proc getSlaveMethod*(self: AudioBaseSink): AudioBaseSinkSlaveMethod =
  gst_audio_base_sink_get_slave_method(cast[ptr AudioBaseSink00](self.impl))

proc slaveMethod*(self: AudioBaseSink): AudioBaseSinkSlaveMethod =
  gst_audio_base_sink_get_slave_method(cast[ptr AudioBaseSink00](self.impl))

proc gst_audio_base_sink_set_slave_method(self: ptr AudioBaseSink00; `method`: AudioBaseSinkSlaveMethod) {.
    importc, libprag.}

proc setSlaveMethod*(self: AudioBaseSink; `method`: AudioBaseSinkSlaveMethod) =
  gst_audio_base_sink_set_slave_method(cast[ptr AudioBaseSink00](self.impl), `method`)

proc `slaveMethod=`*(self: AudioBaseSink; `method`: AudioBaseSinkSlaveMethod) =
  gst_audio_base_sink_set_slave_method(cast[ptr AudioBaseSink00](self.impl), `method`)

type
  AudioBaseSinkDiscontReason* {.size: sizeof(cint), pure.} = enum
    noDiscont = 0
    newCaps = 1
    flush = 2
    syncLatency = 3
    alignment = 4
    deviceFailure = 5

type
  AudioBaseSinkCustomSlavingCallback* = proc (sink: ptr AudioBaseSink00; etime: uint64; itime: uint64; requestedSkew: ptr int64;
    discontReason: AudioBaseSinkDiscontReason; userData: pointer) {.cdecl.}

proc gst_audio_base_sink_set_custom_slaving_callback(self: ptr AudioBaseSink00;
    callback: AudioBaseSinkCustomSlavingCallback; userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setCustomSlavingCallback*(self: AudioBaseSink;
    callback: AudioBaseSinkCustomSlavingCallback; userData: pointer; notify: DestroyNotify) =
  gst_audio_base_sink_set_custom_slaving_callback(cast[ptr AudioBaseSink00](self.impl), callback, userData, notify)

type
  AudioBaseSrc* = ref object of gstbase.PushSrc
  AudioBaseSrc00* = object of gstbase.PushSrc00

proc gst_audio_base_src_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioBaseSrc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_audio_base_src_create_ringbuffer(self: ptr AudioBaseSrc00): ptr AudioRingBuffer00 {.
    importc, libprag.}

proc createRingbuffer*(self: AudioBaseSrc): AudioRingBuffer =
  let gobj = gst_audio_base_src_create_ringbuffer(cast[ptr AudioBaseSrc00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstaudio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_audio_base_src_get_provide_clock(self: ptr AudioBaseSrc00): gboolean {.
    importc, libprag.}

proc getProvideClock*(self: AudioBaseSrc): bool =
  toBool(gst_audio_base_src_get_provide_clock(cast[ptr AudioBaseSrc00](self.impl)))

proc provideClock*(self: AudioBaseSrc): bool =
  toBool(gst_audio_base_src_get_provide_clock(cast[ptr AudioBaseSrc00](self.impl)))

proc gst_audio_base_src_set_provide_clock(self: ptr AudioBaseSrc00; provide: gboolean) {.
    importc, libprag.}

proc setProvideClock*(self: AudioBaseSrc; provide: bool = true) =
  gst_audio_base_src_set_provide_clock(cast[ptr AudioBaseSrc00](self.impl), gboolean(provide))

proc `provideClock=`*(self: AudioBaseSrc; provide: bool) =
  gst_audio_base_src_set_provide_clock(cast[ptr AudioBaseSrc00](self.impl), gboolean(provide))

type
  AudioBaseSrcSlaveMethod* {.size: sizeof(cint), pure.} = enum
    resample = 0
    reTimestamp = 1
    skew = 2
    none = 3

proc gst_audio_base_src_get_slave_method(self: ptr AudioBaseSrc00): AudioBaseSrcSlaveMethod {.
    importc, libprag.}

proc getSlaveMethod*(self: AudioBaseSrc): AudioBaseSrcSlaveMethod =
  gst_audio_base_src_get_slave_method(cast[ptr AudioBaseSrc00](self.impl))

proc slaveMethod*(self: AudioBaseSrc): AudioBaseSrcSlaveMethod =
  gst_audio_base_src_get_slave_method(cast[ptr AudioBaseSrc00](self.impl))

proc gst_audio_base_src_set_slave_method(self: ptr AudioBaseSrc00; `method`: AudioBaseSrcSlaveMethod) {.
    importc, libprag.}

proc setSlaveMethod*(self: AudioBaseSrc; `method`: AudioBaseSrcSlaveMethod) =
  gst_audio_base_src_set_slave_method(cast[ptr AudioBaseSrc00](self.impl), `method`)

proc `slaveMethod=`*(self: AudioBaseSrc; `method`: AudioBaseSrcSlaveMethod) =
  gst_audio_base_src_set_slave_method(cast[ptr AudioBaseSrc00](self.impl), `method`)

type
  AudioBuffer00* {.pure.} = object
  AudioBuffer* = ref object
    impl*: ptr AudioBuffer00
    ignoreFinalizer*: bool

proc gst_audio_buffer_unmap(self: ptr AudioBuffer00) {.
    importc, libprag.}

proc unmap*(self: AudioBuffer) =
  gst_audio_buffer_unmap(cast[ptr AudioBuffer00](self.impl))

proc gst_audio_buffer_clip(buffer: ptr gst.Buffer00; segment: ptr gst.Segment00;
    rate: int32; bpf: int32): ptr gst.Buffer00 {.
    importc, libprag.}

proc clip*(buffer: gst.Buffer; segment: gst.Segment; rate: int;
    bpf: int): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_audio_buffer_clip(cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)), cast[ptr gst.Segment00](segment.impl), int32(rate), int32(bpf))

proc gst_audio_buffer_truncate(buffer: ptr gst.Buffer00; bpf: int32; trim: uint64;
    samples: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc truncate*(buffer: gst.Buffer; bpf: int; trim: uint64;
    samples: uint64): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_audio_buffer_truncate(cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)), int32(bpf), trim, samples)

type
  AudioInfo00* {.pure.} = object
  AudioInfo* = ref object
    impl*: ptr AudioInfo00
    ignoreFinalizer*: bool

proc gst_audio_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstAudioInfo*(self: AudioInfo) =
  if not self.ignoreFinalizer:
    boxedFree(gst_audio_info_get_type(), cast[ptr AudioInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_audio_info_get_type(), cast[ptr AudioInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AudioInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstAudioInfo)

proc gst_audio_info_free(self: ptr AudioInfo00) {.
    importc, libprag.}

proc free*(self: AudioInfo) =
  gst_audio_info_free(cast[ptr AudioInfo00](self.impl))

proc finalizerfree*(self: AudioInfo) =
  if not self.ignoreFinalizer:
    gst_audio_info_free(cast[ptr AudioInfo00](self.impl))

proc gst_audio_info_convert(self: ptr AudioInfo00; srcFmt: gst.Format; srcVal: int64;
    destFmt: gst.Format; destVal: var int64): gboolean {.
    importc, libprag.}

proc convert*(self: AudioInfo; srcFmt: gst.Format; srcVal: int64;
    destFmt: gst.Format; destVal: var int64): bool =
  toBool(gst_audio_info_convert(cast[ptr AudioInfo00](self.impl), srcFmt, srcVal, destFmt, destVal))

proc gst_audio_info_copy(self: ptr AudioInfo00): ptr AudioInfo00 {.
    importc, libprag.}

proc copy*(self: AudioInfo): AudioInfo =
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_info_copy(cast[ptr AudioInfo00](self.impl))

proc gst_audio_info_new(): ptr AudioInfo00 {.
    importc, libprag.}

proc newAudioInfo*(): AudioInfo =
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_info_new()

proc newAudioInfo*(tdesc: typedesc): tdesc =
  assert(result is AudioInfo)
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_info_new()

proc initAudioInfo*[T](result: var T) {.deprecated.} =
  assert(result is AudioInfo)
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_info_new()

proc gst_audio_info_from_caps(self: ptr AudioInfo00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc fromCaps*(self: AudioInfo; caps: gst.Caps): bool =
  toBool(gst_audio_info_from_caps(cast[ptr AudioInfo00](self.impl), cast[ptr gst.Caps00](caps.impl)))

proc gst_audio_info_init(self: ptr AudioInfo00) {.
    importc, libprag.}

proc init*(self: AudioInfo) =
  gst_audio_info_init(cast[ptr AudioInfo00](self.impl))

proc gst_audio_info_is_equal(self: ptr AudioInfo00; other: ptr AudioInfo00): gboolean {.
    importc, libprag.}

proc isEqual*(self: AudioInfo; other: AudioInfo): bool =
  toBool(gst_audio_info_is_equal(cast[ptr AudioInfo00](self.impl), cast[ptr AudioInfo00](other.impl)))

proc gst_audio_info_to_caps(self: ptr AudioInfo00): ptr gst.Caps00 {.
    importc, libprag.}

proc toCaps*(self: AudioInfo): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_audio_info_to_caps(cast[ptr AudioInfo00](self.impl))

proc gst_audio_buffer_map(self: ptr AudioBuffer00; info: ptr AudioInfo00;
    gstbuffer: ptr gst.Buffer00; flags: gst.MapFlags): gboolean {.
    importc, libprag.}

proc map*(self: AudioBuffer; info: AudioInfo; gstbuffer: gst.Buffer;
    flags: gst.MapFlags): bool =
  toBool(gst_audio_buffer_map(cast[ptr AudioBuffer00](self.impl), cast[ptr AudioInfo00](info.impl), cast[ptr gst.Buffer00](gstbuffer.impl), flags))

type
  AudioFormat* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    encoded = 1
    s8 = 2
    u8 = 3
    s16 = 4
    s16be = 5
    u16 = 6
    u16be = 7
    s24_32 = 8
    s24_32be = 9
    u24_32 = 10
    u24_32be = 11
    s32 = 12
    s32be = 13
    u32 = 14
    u32be = 15
    s24 = 16
    s24be = 17
    u24 = 18
    u24be = 19
    s20 = 20
    s20be = 21
    u20 = 22
    u20be = 23
    s18 = 24
    s18be = 25
    u18 = 26
    u18be = 27
    f32 = 28
    f32be = 29
    f64 = 30
    f64be = 31

const
  AudioFormatS24_32le* = AudioFormat.s24_32
  AudioFormatU16le* = AudioFormat.u16
  AudioFormatU24_32le* = AudioFormat.u24_32
  AudioFormatS18le* = AudioFormat.s18
  AudioFormatS24le* = AudioFormat.s24
  AudioFormatU24le* = AudioFormat.u24
  AudioFormatU20le* = AudioFormat.u20
  AudioFormatU32le* = AudioFormat.u32
  AudioFormatU18le* = AudioFormat.u18
  AudioFormatF32le* = AudioFormat.f32
  AudioFormatF64le* = AudioFormat.f64
  AudioFormatS32le* = AudioFormat.s32
  AudioFormatS20le* = AudioFormat.s20
  AudioFormatS16le* = AudioFormat.s16

proc gst_audio_format_build_integer(sign: gboolean; endianness: int32; width: int32;
    depth: int32): AudioFormat {.
    importc, libprag.}

proc buildInteger*(sign: bool; endianness: int; width: int;
    depth: int): AudioFormat =
  gst_audio_format_build_integer(gboolean(sign), int32(endianness), int32(width), int32(depth))

proc fromStringAudioFormat*(format: cstring): AudioFormat {.
    importc: "gst_audio_format_from_string", libprag.}

proc gst_audio_format_to_string(format: AudioFormat): cstring {.
    importc, libprag.}

proc toString*(format: AudioFormat): string =
  result = $gst_audio_format_to_string(format)

proc gst_audio_buffer_reorder_channels(buffer: ptr gst.Buffer00; format: AudioFormat;
    channels: int32; `from`: ptr AudioChannelPosition; to: ptr AudioChannelPosition): gboolean {.
    importc, libprag.}

proc reorderChannels*(buffer: gst.Buffer; format: AudioFormat;
    channels: int; `from`: ptr AudioChannelPosition; to: ptr AudioChannelPosition): bool =
  toBool(gst_audio_buffer_reorder_channels(cast[ptr gst.Buffer00](buffer.impl), format, int32(channels), `from`, to))

proc gst_audio_info_set_format(self: ptr AudioInfo00; format: AudioFormat;
    rate: int32; channels: int32; position: ptr array[64, AudioChannelPosition]) {.
    importc, libprag.}

proc setFormat*(self: AudioInfo; format: AudioFormat; rate: int;
    channels: int; position: ptr array[64, AudioChannelPosition]) =
  gst_audio_info_set_format(cast[ptr AudioInfo00](self.impl), format, int32(rate), int32(channels), position)

type
  AudioFormatInfo00* {.pure.} = object
  AudioFormatInfo* = ref object
    impl*: ptr AudioFormatInfo00
    ignoreFinalizer*: bool

proc gst_audio_format_fill_silence(info: ptr AudioFormatInfo00; dest: ptr uint8;
    length: uint64) {.
    importc, libprag.}

proc fillSilence*(info: AudioFormatInfo; dest: seq[uint8] | string) =
  let length = uint64(dest.len)
  gst_audio_format_fill_silence(cast[ptr AudioFormatInfo00](info.impl), cast[ptr uint8](unsafeaddr(dest[0])), length)

proc gst_audio_format_get_info(format: AudioFormat): ptr AudioFormatInfo00 {.
    importc, libprag.}

proc getInfoAudioFormat*(format: AudioFormat): AudioFormatInfo =
  new(result)
  result.impl = gst_audio_format_get_info(format)
  result.ignoreFinalizer = true

proc infoAudioFormat*(format: AudioFormat): AudioFormatInfo =
  new(result)
  result.impl = gst_audio_format_get_info(format)
  result.ignoreFinalizer = true

type
  AudioCdSrc* = ref object of gstbase.PushSrc
  AudioCdSrc00* = object of gstbase.PushSrc00

proc gst_audio_cd_src_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioCdSrc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AudioCdSrcTrack00* {.pure.} = object
  AudioCdSrcTrack* = ref object
    impl*: ptr AudioCdSrcTrack00
    ignoreFinalizer*: bool

proc gst_audio_cd_src_add_track(self: ptr AudioCdSrc00; track: ptr AudioCdSrcTrack00): gboolean {.
    importc, libprag.}

proc addTrack*(self: AudioCdSrc; track: AudioCdSrcTrack): bool =
  toBool(gst_audio_cd_src_add_track(cast[ptr AudioCdSrc00](self.impl), cast[ptr AudioCdSrcTrack00](track.impl)))

type
  AudioCdSrcMode* {.size: sizeof(cint), pure.} = enum
    normal = 0
    continuous = 1

type
  AudioChannelMixer00* {.pure.} = object
  AudioChannelMixer* = ref object
    impl*: ptr AudioChannelMixer00
    ignoreFinalizer*: bool

proc gst_audio_channel_mixer_free(self: ptr AudioChannelMixer00) {.
    importc, libprag.}

proc free*(self: AudioChannelMixer) =
  gst_audio_channel_mixer_free(cast[ptr AudioChannelMixer00](self.impl))

proc finalizerfree*(self: AudioChannelMixer) =
  if not self.ignoreFinalizer:
    gst_audio_channel_mixer_free(cast[ptr AudioChannelMixer00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioChannelMixer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_audio_channel_mixer_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var AudioChannelMixer) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_audio_channel_mixer_is_passthrough(self: ptr AudioChannelMixer00): gboolean {.
    importc, libprag.}

proc isPassthrough*(self: AudioChannelMixer): bool =
  toBool(gst_audio_channel_mixer_is_passthrough(cast[ptr AudioChannelMixer00](self.impl)))

proc gst_audio_channel_mixer_samples(self: ptr AudioChannelMixer00; `in`: pointer;
    `out`: pointer; samples: int32) {.
    importc, libprag.}

proc samples*(self: AudioChannelMixer; `in`: pointer;
    `out`: pointer; samples: int) =
  gst_audio_channel_mixer_samples(cast[ptr AudioChannelMixer00](self.impl), `in`, `out`, int32(samples))

type
  AudioChannelMixerFlag* {.size: sizeof(cint), pure.} = enum
    nonInterleavedIn = 0
    nonInterleavedOut = 1
    unpositionedIn = 2
    unpositionedOut = 3

  AudioChannelMixerFlags* {.size: sizeof(cint).} = set[AudioChannelMixerFlag]

const
  AudioChannelMixerFlagsNone* = AudioChannelMixerFlags({})
proc none*(t: typedesc[AudioChannelMixerFlags]): AudioChannelMixerFlags = AudioChannelMixerFlags({})

type
  AudioClippingMeta00* {.pure.} = object
  AudioClippingMeta* = ref object
    impl*: ptr AudioClippingMeta00
    ignoreFinalizer*: bool

proc gst_audio_clipping_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoAudioClippingMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_audio_clipping_meta_get_info()
  result.ignoreFinalizer = true

type
  AudioClock* = ref object of gst.SystemClock
  AudioClock00* = object of gst.SystemClock00

proc gst_audio_clock_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioClock()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_audio_clock_adjust(self: ptr AudioClock00; time: uint64): uint64 {.
    importc, libprag.}

proc adjust*(self: AudioClock; time: uint64): uint64 =
  gst_audio_clock_adjust(cast[ptr AudioClock00](self.impl), time)

proc gst_audio_clock_get_time(self: ptr AudioClock00): uint64 {.
    importc, libprag.}

proc getTime*(self: AudioClock): uint64 =
  gst_audio_clock_get_time(cast[ptr AudioClock00](self.impl))

proc time*(self: AudioClock): uint64 =
  gst_audio_clock_get_time(cast[ptr AudioClock00](self.impl))

proc gst_audio_clock_invalidate(self: ptr AudioClock00) {.
    importc, libprag.}

proc invalidate*(self: AudioClock) =
  gst_audio_clock_invalidate(cast[ptr AudioClock00](self.impl))

proc gst_audio_clock_reset(self: ptr AudioClock00; time: uint64) {.
    importc, libprag.}

proc reset*(self: AudioClock; time: uint64) =
  gst_audio_clock_reset(cast[ptr AudioClock00](self.impl), time)

type
  AudioClockGetTimeFunc* = proc (clock: ptr gst.Clock00; userData: pointer): uint64 {.cdecl.}

proc gst_audio_clock_new(name: cstring; `func`: AudioClockGetTimeFunc; userData: pointer;
    destroyNotify: DestroyNotify): ptr AudioClock00 {.
    importc, libprag.}

proc newAudioClock*(name: cstring; `func`: AudioClockGetTimeFunc; userData: pointer;
    destroyNotify: DestroyNotify): AudioClock =
  let gobj = gst_audio_clock_new(name, `func`, userData, destroyNotify)
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

proc newAudioClock*(tdesc: typedesc; name: cstring; `func`: AudioClockGetTimeFunc; userData: pointer;
    destroyNotify: DestroyNotify): tdesc =
  assert(result is AudioClock)
  let gobj = gst_audio_clock_new(name, `func`, userData, destroyNotify)
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

proc initAudioClock*[T](result: var T; name: cstring; `func`: AudioClockGetTimeFunc; userData: pointer;
    destroyNotify: DestroyNotify) {.deprecated.} =
  assert(result is AudioClock)
  let gobj = gst_audio_clock_new(name, `func`, userData, destroyNotify)
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
  AudioConverter00* {.pure.} = object
  AudioConverter* = ref object
    impl*: ptr AudioConverter00
    ignoreFinalizer*: bool

proc gst_audio_converter_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstAudioConverter*(self: AudioConverter) =
  if not self.ignoreFinalizer:
    boxedFree(gst_audio_converter_get_type(), cast[ptr AudioConverter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioConverter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_audio_converter_get_type(), cast[ptr AudioConverter00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AudioConverter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstAudioConverter)

proc gst_audio_converter_free(self: ptr AudioConverter00) {.
    importc, libprag.}

proc free*(self: AudioConverter) =
  gst_audio_converter_free(cast[ptr AudioConverter00](self.impl))

proc finalizerfree*(self: AudioConverter) =
  if not self.ignoreFinalizer:
    gst_audio_converter_free(cast[ptr AudioConverter00](self.impl))

proc gst_audio_converter_get_config(self: ptr AudioConverter00; inRate: var int32;
    outRate: var int32): ptr gst.Structure00 {.
    importc, libprag.}

proc getConfig*(self: AudioConverter; inRate: var int = cast[var int](nil);
    outRate: var int = cast[var int](nil)): gst.Structure =
  var outRate_00: int32
  var inRate_00: int32
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_audio_converter_get_config(cast[ptr AudioConverter00](self.impl), inRate_00, outRate_00)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))
  if outRate.addr != nil:
    outRate = int(outRate_00)
  if inRate.addr != nil:
    inRate = int(inRate_00)

proc gst_audio_converter_get_in_frames(self: ptr AudioConverter00; outFrames: uint64): uint64 {.
    importc, libprag.}

proc getInFrames*(self: AudioConverter; outFrames: uint64): uint64 =
  gst_audio_converter_get_in_frames(cast[ptr AudioConverter00](self.impl), outFrames)

proc gst_audio_converter_get_max_latency(self: ptr AudioConverter00): uint64 {.
    importc, libprag.}

proc getMaxLatency*(self: AudioConverter): uint64 =
  gst_audio_converter_get_max_latency(cast[ptr AudioConverter00](self.impl))

proc maxLatency*(self: AudioConverter): uint64 =
  gst_audio_converter_get_max_latency(cast[ptr AudioConverter00](self.impl))

proc gst_audio_converter_get_out_frames(self: ptr AudioConverter00; inFrames: uint64): uint64 {.
    importc, libprag.}

proc getOutFrames*(self: AudioConverter; inFrames: uint64): uint64 =
  gst_audio_converter_get_out_frames(cast[ptr AudioConverter00](self.impl), inFrames)

proc gst_audio_converter_is_passthrough(self: ptr AudioConverter00): gboolean {.
    importc, libprag.}

proc isPassthrough*(self: AudioConverter): bool =
  toBool(gst_audio_converter_is_passthrough(cast[ptr AudioConverter00](self.impl)))

proc gst_audio_converter_reset(self: ptr AudioConverter00) {.
    importc, libprag.}

proc reset*(self: AudioConverter) =
  gst_audio_converter_reset(cast[ptr AudioConverter00](self.impl))

proc gst_audio_converter_supports_inplace(self: ptr AudioConverter00): gboolean {.
    importc, libprag.}

proc supportsInplace*(self: AudioConverter): bool =
  toBool(gst_audio_converter_supports_inplace(cast[ptr AudioConverter00](self.impl)))

proc gst_audio_converter_update_config(self: ptr AudioConverter00; inRate: int32;
    outRate: int32; config: ptr gst.Structure00): gboolean {.
    importc, libprag.}

proc updateConfig*(self: AudioConverter; inRate: int;
    outRate: int; config: gst.Structure = nil): bool =
  toBool(gst_audio_converter_update_config(cast[ptr AudioConverter00](self.impl), int32(inRate), int32(outRate), if config.isNil: nil else: cast[ptr gst.Structure00](g_boxed_copy(gst_structure_get_type(), config.impl))))

type
  AudioConverterFlag* {.size: sizeof(cint), pure.} = enum
    inWritable = 0
    variableRate = 1

  AudioConverterFlags* {.size: sizeof(cint).} = set[AudioConverterFlag]

const
  AudioConverterFlagsNone* = AudioConverterFlags({})
proc none*(t: typedesc[AudioConverterFlags]): AudioConverterFlags = AudioConverterFlags({})

proc gst_audio_converter_convert(self: ptr AudioConverter00; flags: AudioConverterFlags;
    `in`: ptr uint8; inSize: uint64; `out`: var ptr uint8; outSize: var uint64): gboolean {.
    importc, libprag.}

proc convert*(self: AudioConverter; flags: AudioConverterFlags;
    `in`: seq[uint8] | string; inSize: uint64; `out`: var (seq[uint8] | string);
    outSize: var uint64): bool =
  var out_00: ptr uint8
  result = toBool(gst_audio_converter_convert(cast[ptr AudioConverter00](self.impl), flags, cast[ptr uint8](unsafeaddr(`in`[0])), inSize, out_00, outSize))
  `out`.setLen(outSize)
  copyMem(unsafeaddr out[0], out_00, outSize.int * sizeof(out[0]))
  cogfree(out_00)

proc gst_audio_converter_new(flags: AudioConverterFlags; inInfo: ptr AudioInfo00;
    outInfo: ptr AudioInfo00; config: ptr gst.Structure00): ptr AudioConverter00 {.
    importc, libprag.}

proc newAudioConverter*(flags: AudioConverterFlags; inInfo: AudioInfo;
    outInfo: AudioInfo; config: gst.Structure = nil): AudioConverter =
  fnew(result, gBoxedFreeGstAudioConverter)
  result.impl = gst_audio_converter_new(flags, cast[ptr AudioInfo00](inInfo.impl), cast[ptr AudioInfo00](outInfo.impl), if config.isNil: nil else: cast[ptr gst.Structure00](g_boxed_copy(gst_structure_get_type(), config.impl)))

proc newAudioConverter*(tdesc: typedesc; flags: AudioConverterFlags; inInfo: AudioInfo;
    outInfo: AudioInfo; config: gst.Structure = nil): tdesc =
  assert(result is AudioConverter)
  fnew(result, gBoxedFreeGstAudioConverter)
  result.impl = gst_audio_converter_new(flags, cast[ptr AudioInfo00](inInfo.impl), cast[ptr AudioInfo00](outInfo.impl), if config.isNil: nil else: cast[ptr gst.Structure00](g_boxed_copy(gst_structure_get_type(), config.impl)))

proc initAudioConverter*[T](result: var T; flags: AudioConverterFlags; inInfo: AudioInfo;
    outInfo: AudioInfo; config: gst.Structure = nil) {.deprecated.} =
  assert(result is AudioConverter)
  fnew(result, gBoxedFreeGstAudioConverter)
  result.impl = gst_audio_converter_new(flags, cast[ptr AudioInfo00](inInfo.impl), cast[ptr AudioInfo00](outInfo.impl), if config.isNil: nil else: cast[ptr gst.Structure00](g_boxed_copy(gst_structure_get_type(), config.impl)))

proc gst_audio_converter_samples(self: ptr AudioConverter00; flags: AudioConverterFlags;
    `in`: pointer; inFrames: uint64; `out`: pointer; outFrames: uint64): gboolean {.
    importc, libprag.}

proc samples*(self: AudioConverter; flags: AudioConverterFlags;
    `in`: pointer; inFrames: uint64; `out`: pointer; outFrames: uint64): bool =
  toBool(gst_audio_converter_samples(cast[ptr AudioConverter00](self.impl), flags, `in`, inFrames, `out`, outFrames))

type
  AudioDecoder* = ref object of gst.Element
  AudioDecoder00* = object of gst.Element00

proc gst_audio_decoder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioDecoder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_audio_decoder_allocate_output_buffer(self: ptr AudioDecoder00; size: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc allocateOutputBuffer*(self: AudioDecoder; size: uint64): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_audio_decoder_allocate_output_buffer(cast[ptr AudioDecoder00](self.impl), size)

proc gst_audio_decoder_finish_frame(self: ptr AudioDecoder00; buf: ptr gst.Buffer00;
    frames: int32): gst.FlowReturn {.
    importc, libprag.}

proc finishFrame*(self: AudioDecoder; buf: gst.Buffer = nil;
    frames: int): gst.FlowReturn =
  gst_audio_decoder_finish_frame(cast[ptr AudioDecoder00](self.impl), if buf.isNil: nil else: cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buf.impl)), int32(frames))

proc gst_audio_decoder_finish_subframe(self: ptr AudioDecoder00; buf: ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc finishSubframe*(self: AudioDecoder; buf: gst.Buffer = nil): gst.FlowReturn =
  gst_audio_decoder_finish_subframe(cast[ptr AudioDecoder00](self.impl), if buf.isNil: nil else: cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buf.impl)))

proc gst_audio_decoder_get_allocator(self: ptr AudioDecoder00; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: AudioDecoder; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_audio_decoder_get_allocator(cast[ptr AudioDecoder00](self.impl), cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstaudio.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_audio_decoder_get_audio_info(self: ptr AudioDecoder00): ptr AudioInfo00 {.
    importc, libprag.}

proc getAudioInfo*(self: AudioDecoder): AudioInfo =
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_decoder_get_audio_info(cast[ptr AudioDecoder00](self.impl))

proc audioInfo*(self: AudioDecoder): AudioInfo =
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_decoder_get_audio_info(cast[ptr AudioDecoder00](self.impl))

proc gst_audio_decoder_get_delay(self: ptr AudioDecoder00): int32 {.
    importc, libprag.}

proc getDelay*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_delay(cast[ptr AudioDecoder00](self.impl)))

proc delay*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_delay(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_get_drainable(self: ptr AudioDecoder00): gboolean {.
    importc, libprag.}

proc getDrainable*(self: AudioDecoder): bool =
  toBool(gst_audio_decoder_get_drainable(cast[ptr AudioDecoder00](self.impl)))

proc drainable*(self: AudioDecoder): bool =
  toBool(gst_audio_decoder_get_drainable(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_get_estimate_rate(self: ptr AudioDecoder00): int32 {.
    importc, libprag.}

proc getEstimateRate*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_estimate_rate(cast[ptr AudioDecoder00](self.impl)))

proc estimateRate*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_estimate_rate(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_get_latency(self: ptr AudioDecoder00; min: var uint64;
    max: var uint64) {.
    importc, libprag.}

proc getLatency*(self: AudioDecoder; min: var uint64 = cast[var uint64](nil);
    max: var uint64 = cast[var uint64](nil)) =
  gst_audio_decoder_get_latency(cast[ptr AudioDecoder00](self.impl), min, max)

proc gst_audio_decoder_get_max_errors(self: ptr AudioDecoder00): int32 {.
    importc, libprag.}

proc getMaxErrors*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_max_errors(cast[ptr AudioDecoder00](self.impl)))

proc maxErrors*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_max_errors(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_get_min_latency(self: ptr AudioDecoder00): uint64 {.
    importc, libprag.}

proc getMinLatency*(self: AudioDecoder): uint64 =
  gst_audio_decoder_get_min_latency(cast[ptr AudioDecoder00](self.impl))

proc minLatency*(self: AudioDecoder): uint64 =
  gst_audio_decoder_get_min_latency(cast[ptr AudioDecoder00](self.impl))

proc gst_audio_decoder_get_needs_format(self: ptr AudioDecoder00): gboolean {.
    importc, libprag.}

proc getNeedsFormat*(self: AudioDecoder): bool =
  toBool(gst_audio_decoder_get_needs_format(cast[ptr AudioDecoder00](self.impl)))

proc needsFormat*(self: AudioDecoder): bool =
  toBool(gst_audio_decoder_get_needs_format(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_get_parse_state(self: ptr AudioDecoder00; sync: var gboolean;
    eos: var gboolean) {.
    importc, libprag.}

proc getParseState*(self: AudioDecoder; sync: var bool = cast[var bool](nil);
    eos: var bool = cast[var bool](nil)) =
  var eos_00: gboolean
  var sync_00: gboolean
  gst_audio_decoder_get_parse_state(cast[ptr AudioDecoder00](self.impl), sync_00, eos_00)
  if eos.addr != nil:
    eos = toBool(eos_00)
  if sync.addr != nil:
    sync = toBool(sync_00)

proc gst_audio_decoder_get_plc(self: ptr AudioDecoder00): gboolean {.
    importc, libprag.}

proc getPlc*(self: AudioDecoder): bool =
  toBool(gst_audio_decoder_get_plc(cast[ptr AudioDecoder00](self.impl)))

proc plc*(self: AudioDecoder): bool =
  toBool(gst_audio_decoder_get_plc(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_get_plc_aware(self: ptr AudioDecoder00): int32 {.
    importc, libprag.}

proc getPlcAware*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_plc_aware(cast[ptr AudioDecoder00](self.impl)))

proc plcAware*(self: AudioDecoder): int =
  int(gst_audio_decoder_get_plc_aware(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_get_tolerance(self: ptr AudioDecoder00): uint64 {.
    importc, libprag.}

proc getTolerance*(self: AudioDecoder): uint64 =
  gst_audio_decoder_get_tolerance(cast[ptr AudioDecoder00](self.impl))

proc tolerance*(self: AudioDecoder): uint64 =
  gst_audio_decoder_get_tolerance(cast[ptr AudioDecoder00](self.impl))

proc gst_audio_decoder_merge_tags(self: ptr AudioDecoder00; tags: ptr gst.TagList00;
    mode: gst.TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: AudioDecoder; tags: gst.TagList = nil;
    mode: gst.TagMergeMode) =
  gst_audio_decoder_merge_tags(cast[ptr AudioDecoder00](self.impl), if tags.isNil: nil else: cast[ptr gst.TagList00](tags.impl), mode)

proc gst_audio_decoder_negotiate(self: ptr AudioDecoder00): gboolean {.
    importc, libprag.}

proc negotiate*(self: AudioDecoder): bool =
  toBool(gst_audio_decoder_negotiate(cast[ptr AudioDecoder00](self.impl)))

proc gst_audio_decoder_proxy_getcaps(self: ptr AudioDecoder00; caps: ptr gst.Caps00;
    filter: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc proxyGetcaps*(self: AudioDecoder; caps: gst.Caps = nil;
    filter: gst.Caps = nil): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_audio_decoder_proxy_getcaps(cast[ptr AudioDecoder00](self.impl), if caps.isNil: nil else: cast[ptr gst.Caps00](caps.impl), if filter.isNil: nil else: cast[ptr gst.Caps00](filter.impl))

proc gst_audio_decoder_set_allocation_caps(self: ptr AudioDecoder00; allocationCaps: ptr gst.Caps00) {.
    importc, libprag.}

proc setAllocationCaps*(self: AudioDecoder; allocationCaps: gst.Caps = nil) =
  gst_audio_decoder_set_allocation_caps(cast[ptr AudioDecoder00](self.impl), if allocationCaps.isNil: nil else: cast[ptr gst.Caps00](allocationCaps.impl))

proc `allocationCaps=`*(self: AudioDecoder; allocationCaps: gst.Caps = nil) =
  gst_audio_decoder_set_allocation_caps(cast[ptr AudioDecoder00](self.impl), if allocationCaps.isNil: nil else: cast[ptr gst.Caps00](allocationCaps.impl))

proc gst_audio_decoder_set_drainable(self: ptr AudioDecoder00; enabled: gboolean) {.
    importc, libprag.}

proc setDrainable*(self: AudioDecoder; enabled: bool = true) =
  gst_audio_decoder_set_drainable(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc `drainable=`*(self: AudioDecoder; enabled: bool) =
  gst_audio_decoder_set_drainable(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc gst_audio_decoder_set_estimate_rate(self: ptr AudioDecoder00; enabled: gboolean) {.
    importc, libprag.}

proc setEstimateRate*(self: AudioDecoder; enabled: bool = true) =
  gst_audio_decoder_set_estimate_rate(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc `estimateRate=`*(self: AudioDecoder; enabled: bool) =
  gst_audio_decoder_set_estimate_rate(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc gst_audio_decoder_set_latency(self: ptr AudioDecoder00; min: uint64;
    max: uint64) {.
    importc, libprag.}

proc setLatency*(self: AudioDecoder; min: uint64; max: uint64) =
  gst_audio_decoder_set_latency(cast[ptr AudioDecoder00](self.impl), min, max)

proc gst_audio_decoder_set_max_errors(self: ptr AudioDecoder00; num: int32) {.
    importc, libprag.}

proc setMaxErrors*(self: AudioDecoder; num: int) =
  gst_audio_decoder_set_max_errors(cast[ptr AudioDecoder00](self.impl), int32(num))

proc `maxErrors=`*(self: AudioDecoder; num: int) =
  gst_audio_decoder_set_max_errors(cast[ptr AudioDecoder00](self.impl), int32(num))

proc gst_audio_decoder_set_min_latency(self: ptr AudioDecoder00; num: uint64) {.
    importc, libprag.}

proc setMinLatency*(self: AudioDecoder; num: uint64) =
  gst_audio_decoder_set_min_latency(cast[ptr AudioDecoder00](self.impl), num)

proc `minLatency=`*(self: AudioDecoder; num: uint64) =
  gst_audio_decoder_set_min_latency(cast[ptr AudioDecoder00](self.impl), num)

proc gst_audio_decoder_set_needs_format(self: ptr AudioDecoder00; enabled: gboolean) {.
    importc, libprag.}

proc setNeedsFormat*(self: AudioDecoder; enabled: bool = true) =
  gst_audio_decoder_set_needs_format(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc `needsFormat=`*(self: AudioDecoder; enabled: bool) =
  gst_audio_decoder_set_needs_format(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc gst_audio_decoder_set_output_caps(self: ptr AudioDecoder00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc setOutputCaps*(self: AudioDecoder; caps: gst.Caps): bool =
  toBool(gst_audio_decoder_set_output_caps(cast[ptr AudioDecoder00](self.impl), cast[ptr gst.Caps00](caps.impl)))

proc gst_audio_decoder_set_output_format(self: ptr AudioDecoder00; info: ptr AudioInfo00): gboolean {.
    importc, libprag.}

proc setOutputFormat*(self: AudioDecoder; info: AudioInfo): bool =
  toBool(gst_audio_decoder_set_output_format(cast[ptr AudioDecoder00](self.impl), cast[ptr AudioInfo00](info.impl)))

proc gst_audio_decoder_set_plc(self: ptr AudioDecoder00; enabled: gboolean) {.
    importc, libprag.}

proc setPlc*(self: AudioDecoder; enabled: bool = true) =
  gst_audio_decoder_set_plc(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc `plc=`*(self: AudioDecoder; enabled: bool) =
  gst_audio_decoder_set_plc(cast[ptr AudioDecoder00](self.impl), gboolean(enabled))

proc gst_audio_decoder_set_plc_aware(self: ptr AudioDecoder00; plc: gboolean) {.
    importc, libprag.}

proc setPlcAware*(self: AudioDecoder; plc: bool = true) =
  gst_audio_decoder_set_plc_aware(cast[ptr AudioDecoder00](self.impl), gboolean(plc))

proc `plcAware=`*(self: AudioDecoder; plc: bool) =
  gst_audio_decoder_set_plc_aware(cast[ptr AudioDecoder00](self.impl), gboolean(plc))

proc gst_audio_decoder_set_tolerance(self: ptr AudioDecoder00; tolerance: uint64) {.
    importc, libprag.}

proc setTolerance*(self: AudioDecoder; tolerance: uint64) =
  gst_audio_decoder_set_tolerance(cast[ptr AudioDecoder00](self.impl), tolerance)

proc `tolerance=`*(self: AudioDecoder; tolerance: uint64) =
  gst_audio_decoder_set_tolerance(cast[ptr AudioDecoder00](self.impl), tolerance)

proc gst_audio_decoder_set_use_default_pad_acceptcaps(self: ptr AudioDecoder00;
    use: gboolean) {.
    importc, libprag.}

proc setUseDefaultPadAcceptcaps*(self: AudioDecoder;
    use: bool = true) =
  gst_audio_decoder_set_use_default_pad_acceptcaps(cast[ptr AudioDecoder00](self.impl), gboolean(use))

proc `useDefaultPadAcceptcaps=`*(self: AudioDecoder;
    use: bool) =
  gst_audio_decoder_set_use_default_pad_acceptcaps(cast[ptr AudioDecoder00](self.impl), gboolean(use))

type
  AudioDitherMethod* {.size: sizeof(cint), pure.} = enum
    none = 0
    rpdf = 1
    tpdf = 2
    tpdfHf = 3

type
  AudioDownmixMeta00* {.pure.} = object
  AudioDownmixMeta* = ref object
    impl*: ptr AudioDownmixMeta00
    ignoreFinalizer*: bool

proc gst_audio_downmix_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoAudioDownmixMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_audio_downmix_meta_get_info()
  result.ignoreFinalizer = true

type
  AudioEncoder* = ref object of gst.Element
  AudioEncoder00* = object of gst.Element00

proc gst_audio_encoder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioEncoder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_audio_encoder_allocate_output_buffer(self: ptr AudioEncoder00; size: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc allocateOutputBuffer*(self: AudioEncoder; size: uint64): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_audio_encoder_allocate_output_buffer(cast[ptr AudioEncoder00](self.impl), size)

proc gst_audio_encoder_finish_frame(self: ptr AudioEncoder00; buffer: ptr gst.Buffer00;
    samples: int32): gst.FlowReturn {.
    importc, libprag.}

proc finishFrame*(self: AudioEncoder; buffer: gst.Buffer = nil;
    samples: int): gst.FlowReturn =
  gst_audio_encoder_finish_frame(cast[ptr AudioEncoder00](self.impl), if buffer.isNil: nil else: cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), buffer.impl)), int32(samples))

proc gst_audio_encoder_get_allocator(self: ptr AudioEncoder00; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: AudioEncoder; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_audio_encoder_get_allocator(cast[ptr AudioEncoder00](self.impl), cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstaudio.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_audio_encoder_get_audio_info(self: ptr AudioEncoder00): ptr AudioInfo00 {.
    importc, libprag.}

proc getAudioInfo*(self: AudioEncoder): AudioInfo =
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_encoder_get_audio_info(cast[ptr AudioEncoder00](self.impl))

proc audioInfo*(self: AudioEncoder): AudioInfo =
  fnew(result, gBoxedFreeGstAudioInfo)
  result.impl = gst_audio_encoder_get_audio_info(cast[ptr AudioEncoder00](self.impl))

proc gst_audio_encoder_get_drainable(self: ptr AudioEncoder00): gboolean {.
    importc, libprag.}

proc getDrainable*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_drainable(cast[ptr AudioEncoder00](self.impl)))

proc drainable*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_drainable(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_frame_max(self: ptr AudioEncoder00): int32 {.
    importc, libprag.}

proc getFrameMax*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_frame_max(cast[ptr AudioEncoder00](self.impl)))

proc frameMax*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_frame_max(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_frame_samples_max(self: ptr AudioEncoder00): int32 {.
    importc, libprag.}

proc getFrameSamplesMax*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_frame_samples_max(cast[ptr AudioEncoder00](self.impl)))

proc frameSamplesMax*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_frame_samples_max(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_frame_samples_min(self: ptr AudioEncoder00): int32 {.
    importc, libprag.}

proc getFrameSamplesMin*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_frame_samples_min(cast[ptr AudioEncoder00](self.impl)))

proc frameSamplesMin*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_frame_samples_min(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_hard_min(self: ptr AudioEncoder00): gboolean {.
    importc, libprag.}

proc getHardMin*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_hard_min(cast[ptr AudioEncoder00](self.impl)))

proc hardMin*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_hard_min(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_hard_resync(self: ptr AudioEncoder00): gboolean {.
    importc, libprag.}

proc getHardResync*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_hard_resync(cast[ptr AudioEncoder00](self.impl)))

proc hardResync*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_hard_resync(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_latency(self: ptr AudioEncoder00; min: var uint64;
    max: var uint64) {.
    importc, libprag.}

proc getLatency*(self: AudioEncoder; min: var uint64 = cast[var uint64](nil);
    max: var uint64 = cast[var uint64](nil)) =
  gst_audio_encoder_get_latency(cast[ptr AudioEncoder00](self.impl), min, max)

proc gst_audio_encoder_get_lookahead(self: ptr AudioEncoder00): int32 {.
    importc, libprag.}

proc getLookahead*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_lookahead(cast[ptr AudioEncoder00](self.impl)))

proc lookahead*(self: AudioEncoder): int =
  int(gst_audio_encoder_get_lookahead(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_mark_granule(self: ptr AudioEncoder00): gboolean {.
    importc, libprag.}

proc getMarkGranule*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_mark_granule(cast[ptr AudioEncoder00](self.impl)))

proc markGranule*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_mark_granule(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_perfect_timestamp(self: ptr AudioEncoder00): gboolean {.
    importc, libprag.}

proc getPerfectTimestamp*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_perfect_timestamp(cast[ptr AudioEncoder00](self.impl)))

proc perfectTimestamp*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_get_perfect_timestamp(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_get_tolerance(self: ptr AudioEncoder00): uint64 {.
    importc, libprag.}

proc getTolerance*(self: AudioEncoder): uint64 =
  gst_audio_encoder_get_tolerance(cast[ptr AudioEncoder00](self.impl))

proc tolerance*(self: AudioEncoder): uint64 =
  gst_audio_encoder_get_tolerance(cast[ptr AudioEncoder00](self.impl))

proc gst_audio_encoder_merge_tags(self: ptr AudioEncoder00; tags: ptr gst.TagList00;
    mode: gst.TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: AudioEncoder; tags: gst.TagList = nil;
    mode: gst.TagMergeMode) =
  gst_audio_encoder_merge_tags(cast[ptr AudioEncoder00](self.impl), if tags.isNil: nil else: cast[ptr gst.TagList00](tags.impl), mode)

proc gst_audio_encoder_negotiate(self: ptr AudioEncoder00): gboolean {.
    importc, libprag.}

proc negotiate*(self: AudioEncoder): bool =
  toBool(gst_audio_encoder_negotiate(cast[ptr AudioEncoder00](self.impl)))

proc gst_audio_encoder_proxy_getcaps(self: ptr AudioEncoder00; caps: ptr gst.Caps00;
    filter: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc proxyGetcaps*(self: AudioEncoder; caps: gst.Caps = nil;
    filter: gst.Caps = nil): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_audio_encoder_proxy_getcaps(cast[ptr AudioEncoder00](self.impl), if caps.isNil: nil else: cast[ptr gst.Caps00](caps.impl), if filter.isNil: nil else: cast[ptr gst.Caps00](filter.impl))

proc gst_audio_encoder_set_allocation_caps(self: ptr AudioEncoder00; allocationCaps: ptr gst.Caps00) {.
    importc, libprag.}

proc setAllocationCaps*(self: AudioEncoder; allocationCaps: gst.Caps = nil) =
  gst_audio_encoder_set_allocation_caps(cast[ptr AudioEncoder00](self.impl), if allocationCaps.isNil: nil else: cast[ptr gst.Caps00](allocationCaps.impl))

proc `allocationCaps=`*(self: AudioEncoder; allocationCaps: gst.Caps = nil) =
  gst_audio_encoder_set_allocation_caps(cast[ptr AudioEncoder00](self.impl), if allocationCaps.isNil: nil else: cast[ptr gst.Caps00](allocationCaps.impl))

proc gst_audio_encoder_set_drainable(self: ptr AudioEncoder00; enabled: gboolean) {.
    importc, libprag.}

proc setDrainable*(self: AudioEncoder; enabled: bool = true) =
  gst_audio_encoder_set_drainable(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc `drainable=`*(self: AudioEncoder; enabled: bool) =
  gst_audio_encoder_set_drainable(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc gst_audio_encoder_set_frame_max(self: ptr AudioEncoder00; num: int32) {.
    importc, libprag.}

proc setFrameMax*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_frame_max(cast[ptr AudioEncoder00](self.impl), int32(num))

proc `frameMax=`*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_frame_max(cast[ptr AudioEncoder00](self.impl), int32(num))

proc gst_audio_encoder_set_frame_samples_max(self: ptr AudioEncoder00; num: int32) {.
    importc, libprag.}

proc setFrameSamplesMax*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_frame_samples_max(cast[ptr AudioEncoder00](self.impl), int32(num))

proc `frameSamplesMax=`*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_frame_samples_max(cast[ptr AudioEncoder00](self.impl), int32(num))

proc gst_audio_encoder_set_frame_samples_min(self: ptr AudioEncoder00; num: int32) {.
    importc, libprag.}

proc setFrameSamplesMin*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_frame_samples_min(cast[ptr AudioEncoder00](self.impl), int32(num))

proc `frameSamplesMin=`*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_frame_samples_min(cast[ptr AudioEncoder00](self.impl), int32(num))

proc gst_audio_encoder_set_hard_min(self: ptr AudioEncoder00; enabled: gboolean) {.
    importc, libprag.}

proc setHardMin*(self: AudioEncoder; enabled: bool = true) =
  gst_audio_encoder_set_hard_min(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc `hardMin=`*(self: AudioEncoder; enabled: bool) =
  gst_audio_encoder_set_hard_min(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc gst_audio_encoder_set_hard_resync(self: ptr AudioEncoder00; enabled: gboolean) {.
    importc, libprag.}

proc setHardResync*(self: AudioEncoder; enabled: bool = true) =
  gst_audio_encoder_set_hard_resync(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc `hardResync=`*(self: AudioEncoder; enabled: bool) =
  gst_audio_encoder_set_hard_resync(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc gst_audio_encoder_set_headers(self: ptr AudioEncoder00; headers: ptr glib.List) {.
    importc, libprag.}

proc setHeaders*(self: AudioEncoder; headers: seq[gst.Buffer]) =
  var tempResGL = seq2GList(headers)
  gst_audio_encoder_set_headers(cast[ptr AudioEncoder00](self.impl), tempResGL)

proc `headers=`*(self: AudioEncoder; headers: seq[gst.Buffer]) =
  var tempResGL = seq2GList(headers)
  gst_audio_encoder_set_headers(cast[ptr AudioEncoder00](self.impl), tempResGL)

proc gst_audio_encoder_set_latency(self: ptr AudioEncoder00; min: uint64;
    max: uint64) {.
    importc, libprag.}

proc setLatency*(self: AudioEncoder; min: uint64; max: uint64) =
  gst_audio_encoder_set_latency(cast[ptr AudioEncoder00](self.impl), min, max)

proc gst_audio_encoder_set_lookahead(self: ptr AudioEncoder00; num: int32) {.
    importc, libprag.}

proc setLookahead*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_lookahead(cast[ptr AudioEncoder00](self.impl), int32(num))

proc `lookahead=`*(self: AudioEncoder; num: int) =
  gst_audio_encoder_set_lookahead(cast[ptr AudioEncoder00](self.impl), int32(num))

proc gst_audio_encoder_set_mark_granule(self: ptr AudioEncoder00; enabled: gboolean) {.
    importc, libprag.}

proc setMarkGranule*(self: AudioEncoder; enabled: bool = true) =
  gst_audio_encoder_set_mark_granule(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc `markGranule=`*(self: AudioEncoder; enabled: bool) =
  gst_audio_encoder_set_mark_granule(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc gst_audio_encoder_set_output_format(self: ptr AudioEncoder00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc setOutputFormat*(self: AudioEncoder; caps: gst.Caps): bool =
  toBool(gst_audio_encoder_set_output_format(cast[ptr AudioEncoder00](self.impl), cast[ptr gst.Caps00](caps.impl)))

proc gst_audio_encoder_set_perfect_timestamp(self: ptr AudioEncoder00; enabled: gboolean) {.
    importc, libprag.}

proc setPerfectTimestamp*(self: AudioEncoder; enabled: bool = true) =
  gst_audio_encoder_set_perfect_timestamp(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc `perfectTimestamp=`*(self: AudioEncoder; enabled: bool) =
  gst_audio_encoder_set_perfect_timestamp(cast[ptr AudioEncoder00](self.impl), gboolean(enabled))

proc gst_audio_encoder_set_tolerance(self: ptr AudioEncoder00; tolerance: uint64) {.
    importc, libprag.}

proc setTolerance*(self: AudioEncoder; tolerance: uint64) =
  gst_audio_encoder_set_tolerance(cast[ptr AudioEncoder00](self.impl), tolerance)

proc `tolerance=`*(self: AudioEncoder; tolerance: uint64) =
  gst_audio_encoder_set_tolerance(cast[ptr AudioEncoder00](self.impl), tolerance)

type
  AudioFilter* = ref object of gstbase.BaseTransform
  AudioFilter00* = object of gstbase.BaseTransform00

proc gst_audio_filter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioFilter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AudioFlag* {.size: sizeof(cint), pure.} = enum
    unpositioned = 0

  AudioFlags* {.size: sizeof(cint).} = set[AudioFlag]

const
  AudioFlagsNone* = AudioFlags({})
proc none*(t: typedesc[AudioFlags]): AudioFlags = AudioFlags({})

type
  AudioFormatFlag* {.size: sizeof(cint), pure.} = enum
    integer = 0
    float = 1
    signed = 2
    complex = 4
    unpack = 5

  AudioFormatFlags* {.size: sizeof(cint).} = set[AudioFormatFlag]

type
  AudioPackFlag* {.size: sizeof(cint), pure.} = enum
    truncateRange = 0

  AudioPackFlags* {.size: sizeof(cint).} = set[AudioPackFlag]

const
  AudioPackFlagsNone* = AudioPackFlags({})
proc none*(t: typedesc[AudioPackFlags]): AudioPackFlags = AudioPackFlags({})

type
  AudioFormatPack* = proc (info: ptr AudioFormatInfo00; flags: AudioPackFlags; src: ptr uint8;
    data: ptr uint8; length: int32) {.cdecl.}

type
  AudioFormatUnpack* = proc (info: ptr AudioFormatInfo00; flags: AudioPackFlags; dest: ptr uint8;
    data: ptr uint8; length: int32) {.cdecl.}

type
  AudioLayout* {.size: sizeof(cint), pure.} = enum
    interleaved = 0
    nonInterleaved = 1

type
  AudioMeta00* {.pure.} = object
  AudioMeta* = ref object
    impl*: ptr AudioMeta00
    ignoreFinalizer*: bool

proc gst_audio_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoAudioMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_audio_meta_get_info()
  result.ignoreFinalizer = true

type
  AudioNoiseShapingMethod* {.size: sizeof(cint), pure.} = enum
    none = 0
    errorFeedback = 1
    simple = 2
    medium = 3
    high = 4

type
  AudioQuantize00* {.pure.} = object
  AudioQuantize* = ref object
    impl*: ptr AudioQuantize00
    ignoreFinalizer*: bool

proc gst_audio_quantize_free(self: ptr AudioQuantize00) {.
    importc, libprag.}

proc free*(self: AudioQuantize) =
  gst_audio_quantize_free(cast[ptr AudioQuantize00](self.impl))

proc finalizerfree*(self: AudioQuantize) =
  if not self.ignoreFinalizer:
    gst_audio_quantize_free(cast[ptr AudioQuantize00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioQuantize()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_audio_quantize_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var AudioQuantize) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_audio_quantize_reset(self: ptr AudioQuantize00) {.
    importc, libprag.}

proc reset*(self: AudioQuantize) =
  gst_audio_quantize_reset(cast[ptr AudioQuantize00](self.impl))

proc gst_audio_quantize_samples(self: ptr AudioQuantize00; `in`: pointer;
    `out`: pointer; samples: uint32) {.
    importc, libprag.}

proc samples*(self: AudioQuantize; `in`: pointer; `out`: pointer;
    samples: int) =
  gst_audio_quantize_samples(cast[ptr AudioQuantize00](self.impl), `in`, `out`, uint32(samples))

type
  AudioQuantizeFlag* {.size: sizeof(cint), pure.} = enum
    nonInterleaved = 0

  AudioQuantizeFlags* {.size: sizeof(cint).} = set[AudioQuantizeFlag]

const
  AudioQuantizeFlagsNone* = AudioQuantizeFlags({})
proc none*(t: typedesc[AudioQuantizeFlags]): AudioQuantizeFlags = AudioQuantizeFlags({})

type
  AudioResampler00* {.pure.} = object
  AudioResampler* = ref object
    impl*: ptr AudioResampler00
    ignoreFinalizer*: bool

proc gst_audio_resampler_free(self: ptr AudioResampler00) {.
    importc, libprag.}

proc free*(self: AudioResampler) =
  gst_audio_resampler_free(cast[ptr AudioResampler00](self.impl))

proc finalizerfree*(self: AudioResampler) =
  if not self.ignoreFinalizer:
    gst_audio_resampler_free(cast[ptr AudioResampler00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioResampler()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_audio_resampler_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var AudioResampler) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_audio_resampler_get_in_frames(self: ptr AudioResampler00; outFrames: uint64): uint64 {.
    importc, libprag.}

proc getInFrames*(self: AudioResampler; outFrames: uint64): uint64 =
  gst_audio_resampler_get_in_frames(cast[ptr AudioResampler00](self.impl), outFrames)

proc gst_audio_resampler_get_max_latency(self: ptr AudioResampler00): uint64 {.
    importc, libprag.}

proc getMaxLatency*(self: AudioResampler): uint64 =
  gst_audio_resampler_get_max_latency(cast[ptr AudioResampler00](self.impl))

proc maxLatency*(self: AudioResampler): uint64 =
  gst_audio_resampler_get_max_latency(cast[ptr AudioResampler00](self.impl))

proc gst_audio_resampler_get_out_frames(self: ptr AudioResampler00; inFrames: uint64): uint64 {.
    importc, libprag.}

proc getOutFrames*(self: AudioResampler; inFrames: uint64): uint64 =
  gst_audio_resampler_get_out_frames(cast[ptr AudioResampler00](self.impl), inFrames)

proc gst_audio_resampler_resample(self: ptr AudioResampler00; `in`: pointer;
    inFrames: uint64; `out`: pointer; outFrames: uint64) {.
    importc, libprag.}

proc resample*(self: AudioResampler; `in`: pointer; inFrames: uint64;
    `out`: pointer; outFrames: uint64) =
  gst_audio_resampler_resample(cast[ptr AudioResampler00](self.impl), `in`, inFrames, `out`, outFrames)

proc gst_audio_resampler_reset(self: ptr AudioResampler00) {.
    importc, libprag.}

proc reset*(self: AudioResampler) =
  gst_audio_resampler_reset(cast[ptr AudioResampler00](self.impl))

proc gst_audio_resampler_update(self: ptr AudioResampler00; inRate: int32;
    outRate: int32; options: ptr gst.Structure00): gboolean {.
    importc, libprag.}

proc update*(self: AudioResampler; inRate: int; outRate: int;
    options: gst.Structure): bool =
  toBool(gst_audio_resampler_update(cast[ptr AudioResampler00](self.impl), int32(inRate), int32(outRate), cast[ptr gst.Structure00](options.impl)))

type
  AudioResamplerMethod* {.size: sizeof(cint), pure.} = enum
    nearest = 0
    linear = 1
    cubic = 2
    blackmanNuttall = 3
    kaiser = 4

proc gst_audio_resampler_options_set_quality(`method`: AudioResamplerMethod;
    quality: uint32; inRate: int32; outRate: int32; options: ptr gst.Structure00) {.
    importc, libprag.}

proc optionsSetQuality*(`method`: AudioResamplerMethod;
    quality: int; inRate: int; outRate: int; options: gst.Structure) =
  gst_audio_resampler_options_set_quality(`method`, uint32(quality), int32(inRate), int32(outRate), cast[ptr gst.Structure00](options.impl))

type
  AudioResamplerFlag* {.size: sizeof(cint), pure.} = enum
    nonInterleavedIn = 0
    nonInterleavedOut = 1
    variableRate = 2

  AudioResamplerFlags* {.size: sizeof(cint).} = set[AudioResamplerFlag]

const
  AudioResamplerFlagsNone* = AudioResamplerFlags({})
proc none*(t: typedesc[AudioResamplerFlags]): AudioResamplerFlags = AudioResamplerFlags({})

proc gst_audio_resampler_new(`method`: AudioResamplerMethod; flags: AudioResamplerFlags;
    format: AudioFormat; channels: int32; inRate: int32; outRate: int32; options: ptr gst.Structure00): ptr AudioResampler00 {.
    importc, libprag.}

proc newAudioResampler*(`method`: AudioResamplerMethod; flags: AudioResamplerFlags;
    format: AudioFormat; channels: int; inRate: int; outRate: int; options: gst.Structure): AudioResampler =
  fnew(result, finalizerfree)
  result.impl = gst_audio_resampler_new(`method`, flags, format, int32(channels), int32(inRate), int32(outRate), cast[ptr gst.Structure00](options.impl))

type
  AudioResamplerFilterInterpolation* {.size: sizeof(cint), pure.} = enum
    none = 0
    linear = 1
    cubic = 2

type
  AudioResamplerFilterMode* {.size: sizeof(cint), pure.} = enum
    interpolated = 0
    full = 1
    auto = 2

type
  AudioRingBufferCallback* = proc (rbuf: ptr AudioRingBuffer00; data: ptr uint8; len: uint32; userData: pointer) {.cdecl.}

proc gst_audio_ring_buffer_set_callback_full(self: ptr AudioRingBuffer00;
    cb: AudioRingBufferCallback; userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc setCallback*(self: AudioRingBuffer; cb: AudioRingBufferCallback;
    userData: pointer; notify: DestroyNotify) =
  gst_audio_ring_buffer_set_callback_full(cast[ptr AudioRingBuffer00](self.impl), cb, userData, notify)

type
  AudioRingBufferFormatType* {.size: sizeof(cint), pure.} = enum
    raw = 0
    muLaw = 1
    aLaw = 2
    imaAdpcm = 3
    mpeg = 4
    gsm = 5
    iec958 = 6
    ac3 = 7
    eac3 = 8
    dts = 9
    mpeg2Aac = 10
    mpeg4Aac = 11
    mpeg2AacRaw = 12
    mpeg4AacRaw = 13
    flac = 14

type
  AudioRingBufferState* {.size: sizeof(cint), pure.} = enum
    stopped = 0
    paused = 1
    started = 2
    error = 3

type
  AudioSink* = ref object of AudioBaseSink
  AudioSink00* = object of AudioBaseSink00

proc gst_audio_sink_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioSink()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AudioSinkClassExtension00* {.pure.} = object
  AudioSinkClassExtension* = ref object
    impl*: ptr AudioSinkClassExtension00
    ignoreFinalizer*: bool

type
  AudioSrc* = ref object of AudioBaseSrc
  AudioSrc00* = object of AudioBaseSrc00

proc gst_audio_src_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioSrc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AudioStreamAlign00* {.pure.} = object
  AudioStreamAlign* = ref object
    impl*: ptr AudioStreamAlign00
    ignoreFinalizer*: bool

proc gst_audio_stream_align_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstAudioStreamAlign*(self: AudioStreamAlign) =
  if not self.ignoreFinalizer:
    boxedFree(gst_audio_stream_align_get_type(), cast[ptr AudioStreamAlign00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioStreamAlign()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_audio_stream_align_get_type(), cast[ptr AudioStreamAlign00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var AudioStreamAlign) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstAudioStreamAlign)

proc gst_audio_stream_align_free(self: ptr AudioStreamAlign00) {.
    importc, libprag.}

proc free*(self: AudioStreamAlign) =
  gst_audio_stream_align_free(cast[ptr AudioStreamAlign00](self.impl))

proc finalizerfree*(self: AudioStreamAlign) =
  if not self.ignoreFinalizer:
    gst_audio_stream_align_free(cast[ptr AudioStreamAlign00](self.impl))

proc gst_audio_stream_align_copy(self: ptr AudioStreamAlign00): ptr AudioStreamAlign00 {.
    importc, libprag.}

proc copy*(self: AudioStreamAlign): AudioStreamAlign =
  fnew(result, gBoxedFreeGstAudioStreamAlign)
  result.impl = gst_audio_stream_align_copy(cast[ptr AudioStreamAlign00](self.impl))

proc gst_audio_stream_align_new(rate: int32; alignmentThreshold: uint64;
    discontWait: uint64): ptr AudioStreamAlign00 {.
    importc, libprag.}

proc newAudioStreamAlign*(rate: int; alignmentThreshold: uint64; discontWait: uint64): AudioStreamAlign =
  fnew(result, gBoxedFreeGstAudioStreamAlign)
  result.impl = gst_audio_stream_align_new(int32(rate), alignmentThreshold, discontWait)

proc newAudioStreamAlign*(tdesc: typedesc; rate: int; alignmentThreshold: uint64; discontWait: uint64): tdesc =
  assert(result is AudioStreamAlign)
  fnew(result, gBoxedFreeGstAudioStreamAlign)
  result.impl = gst_audio_stream_align_new(int32(rate), alignmentThreshold, discontWait)

proc initAudioStreamAlign*[T](result: var T; rate: int; alignmentThreshold: uint64; discontWait: uint64) {.deprecated.} =
  assert(result is AudioStreamAlign)
  fnew(result, gBoxedFreeGstAudioStreamAlign)
  result.impl = gst_audio_stream_align_new(int32(rate), alignmentThreshold, discontWait)

proc gst_audio_stream_align_get_alignment_threshold(self: ptr AudioStreamAlign00): uint64 {.
    importc, libprag.}

proc getAlignmentThreshold*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_alignment_threshold(cast[ptr AudioStreamAlign00](self.impl))

proc alignmentThreshold*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_alignment_threshold(cast[ptr AudioStreamAlign00](self.impl))

proc gst_audio_stream_align_get_discont_wait(self: ptr AudioStreamAlign00): uint64 {.
    importc, libprag.}

proc getDiscontWait*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_discont_wait(cast[ptr AudioStreamAlign00](self.impl))

proc discontWait*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_discont_wait(cast[ptr AudioStreamAlign00](self.impl))

proc gst_audio_stream_align_get_rate(self: ptr AudioStreamAlign00): int32 {.
    importc, libprag.}

proc getRate*(self: AudioStreamAlign): int =
  int(gst_audio_stream_align_get_rate(cast[ptr AudioStreamAlign00](self.impl)))

proc rate*(self: AudioStreamAlign): int =
  int(gst_audio_stream_align_get_rate(cast[ptr AudioStreamAlign00](self.impl)))

proc gst_audio_stream_align_get_samples_since_discont(self: ptr AudioStreamAlign00): uint64 {.
    importc, libprag.}

proc getSamplesSinceDiscont*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_samples_since_discont(cast[ptr AudioStreamAlign00](self.impl))

proc samplesSinceDiscont*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_samples_since_discont(cast[ptr AudioStreamAlign00](self.impl))

proc gst_audio_stream_align_get_timestamp_at_discont(self: ptr AudioStreamAlign00): uint64 {.
    importc, libprag.}

proc getTimestampAtDiscont*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_timestamp_at_discont(cast[ptr AudioStreamAlign00](self.impl))

proc timestampAtDiscont*(self: AudioStreamAlign): uint64 =
  gst_audio_stream_align_get_timestamp_at_discont(cast[ptr AudioStreamAlign00](self.impl))

proc gst_audio_stream_align_mark_discont(self: ptr AudioStreamAlign00) {.
    importc, libprag.}

proc markDiscont*(self: AudioStreamAlign) =
  gst_audio_stream_align_mark_discont(cast[ptr AudioStreamAlign00](self.impl))

proc gst_audio_stream_align_process(self: ptr AudioStreamAlign00; discont: gboolean;
    timestamp: uint64; nSamples: uint32; outTimestamp: var uint64; outDuration: var uint64;
    outSamplePosition: var uint64): gboolean {.
    importc, libprag.}

proc process*(self: AudioStreamAlign; discont: bool;
    timestamp: uint64; nSamples: int; outTimestamp: var uint64; outDuration: var uint64;
    outSamplePosition: var uint64): bool =
  toBool(gst_audio_stream_align_process(cast[ptr AudioStreamAlign00](self.impl), gboolean(discont), timestamp, uint32(nSamples), outTimestamp, outDuration, outSamplePosition))

proc gst_audio_stream_align_set_alignment_threshold(self: ptr AudioStreamAlign00;
    alignmentThreshold: uint64) {.
    importc, libprag.}

proc setAlignmentThreshold*(self: AudioStreamAlign;
    alignmentThreshold: uint64) =
  gst_audio_stream_align_set_alignment_threshold(cast[ptr AudioStreamAlign00](self.impl), alignmentThreshold)

proc `alignmentThreshold=`*(self: AudioStreamAlign;
    alignmentThreshold: uint64) =
  gst_audio_stream_align_set_alignment_threshold(cast[ptr AudioStreamAlign00](self.impl), alignmentThreshold)

proc gst_audio_stream_align_set_discont_wait(self: ptr AudioStreamAlign00;
    discontWait: uint64) {.
    importc, libprag.}

proc setDiscontWait*(self: AudioStreamAlign; discontWait: uint64) =
  gst_audio_stream_align_set_discont_wait(cast[ptr AudioStreamAlign00](self.impl), discontWait)

proc `discontWait=`*(self: AudioStreamAlign; discontWait: uint64) =
  gst_audio_stream_align_set_discont_wait(cast[ptr AudioStreamAlign00](self.impl), discontWait)

proc gst_audio_stream_align_set_rate(self: ptr AudioStreamAlign00; rate: int32) {.
    importc, libprag.}

proc setRate*(self: AudioStreamAlign; rate: int) =
  gst_audio_stream_align_set_rate(cast[ptr AudioStreamAlign00](self.impl), int32(rate))

proc `rate=`*(self: AudioStreamAlign; rate: int) =
  gst_audio_stream_align_set_rate(cast[ptr AudioStreamAlign00](self.impl), int32(rate))

const META_TAG_AUDIO_CHANNELS_STR* = "channels"

const META_TAG_AUDIO_RATE_STR* = "rate"

const META_TAG_AUDIO_STR* = "audio"

type
  StreamVolume00* = object of gobject.Object00
  StreamVolume* = ref object of gobject.Object

proc gst_stream_volume_get_mute(self: ptr StreamVolume00): gboolean {.
    importc, libprag.}

proc getMute*(self: StreamVolume): bool =
  toBool(gst_stream_volume_get_mute(cast[ptr StreamVolume00](self.impl)))

proc mute*(self: StreamVolume): bool =
  toBool(gst_stream_volume_get_mute(cast[ptr StreamVolume00](self.impl)))

proc gst_stream_volume_set_mute(self: ptr StreamVolume00; mute: gboolean) {.
    importc, libprag.}

proc setMute*(self: StreamVolume; mute: bool = true) =
  gst_stream_volume_set_mute(cast[ptr StreamVolume00](self.impl), gboolean(mute))

proc `mute=`*(self: StreamVolume; mute: bool) =
  gst_stream_volume_set_mute(cast[ptr StreamVolume00](self.impl), gboolean(mute))

type
  StreamVolumeFormat* {.size: sizeof(cint), pure.} = enum
    linear = 0
    cubic = 1
    db = 2

proc convertVolume*(`from`: StreamVolumeFormat; to: StreamVolumeFormat;
    val: cdouble): cdouble {.
    importc: "gst_stream_volume_convert_volume", libprag.}

proc gst_stream_volume_get_volume(self: ptr StreamVolume00; format: StreamVolumeFormat): cdouble {.
    importc, libprag.}

proc getVolume*(self: StreamVolume; format: StreamVolumeFormat): cdouble =
  gst_stream_volume_get_volume(cast[ptr StreamVolume00](self.impl), format)

proc gst_stream_volume_set_volume(self: ptr StreamVolume00; format: StreamVolumeFormat;
    val: cdouble) {.
    importc, libprag.}

proc setVolume*(self: StreamVolume; format: StreamVolumeFormat;
    val: cdouble) =
  gst_stream_volume_set_volume(cast[ptr StreamVolume00](self.impl), format, val)

proc gst_audio_channel_get_fallback_mask(channels: int32): uint64 {.
    importc, libprag.}

proc audioChannelGetFallbackMask*(channels: int): uint64 =
  gst_audio_channel_get_fallback_mask(int32(channels))

proc gst_audio_channel_positions_from_mask(channels: int32; channelMask: uint64;
    position: ptr AudioChannelPosition): gboolean {.
    importc, libprag.}

proc audioChannelPositionsFromMask*(channels: int; channelMask: uint64;
    position: ptr AudioChannelPosition): bool =
  toBool(gst_audio_channel_positions_from_mask(int32(channels), channelMask, position))

proc gst_audio_channel_positions_to_mask(position: ptr AudioChannelPosition;
    channels: int32; forceOrder: gboolean; channelMask: var uint64): gboolean {.
    importc, libprag.}

proc audioChannelPositionsToMask*(position: ptr AudioChannelPosition;
    channels: int; forceOrder: bool; channelMask: var uint64): bool =
  toBool(gst_audio_channel_positions_to_mask(position, int32(channels), gboolean(forceOrder), channelMask))

proc gst_audio_channel_positions_to_string(position: ptr AudioChannelPosition;
    channels: int32): cstring {.
    importc, libprag.}

proc audioChannelPositionsToString*(position: ptr AudioChannelPosition;
    channels: int): string =
  let resul0 = gst_audio_channel_positions_to_string(position, int32(channels))
  result = $resul0
  cogfree(resul0)

proc gst_audio_channel_positions_to_valid_order(position: ptr AudioChannelPosition;
    channels: int32): gboolean {.
    importc, libprag.}

proc audioChannelPositionsToValidOrder*(position: ptr AudioChannelPosition;
    channels: int): bool =
  toBool(gst_audio_channel_positions_to_valid_order(position, int32(channels)))

proc gst_audio_check_valid_channel_positions(position: ptr AudioChannelPosition;
    channels: int32; forceOrder: gboolean): gboolean {.
    importc, libprag.}

proc audioCheckValidChannelPositions*(position: ptr AudioChannelPosition;
    channels: int; forceOrder: bool): bool =
  toBool(gst_audio_check_valid_channel_positions(position, int32(channels), gboolean(forceOrder)))

proc audioClippingMetaApiGetType*(): GType {.
    importc: "gst_audio_clipping_meta_api_get_type", libprag.}

proc audioDownmixMetaApiGetType*(): GType {.
    importc: "gst_audio_downmix_meta_api_get_type", libprag.}

proc audioFormatInfoGetType*(): GType {.
    importc: "gst_audio_format_info_get_type", libprag.}

proc gst_audio_formats_raw(len: var uint32): ptr AudioFormat {.
    importc, libprag.}

proc audioFormatsRaw*(len: var int): ptr AudioFormat =
  var len_00: uint32
  result = gst_audio_formats_raw(len_00)
  if len.addr != nil:
    len = int(len_00)

proc gst_audio_get_channel_reorder_map(channels: int32; `from`: ptr AudioChannelPosition;
    to: ptr AudioChannelPosition; reorderMap: ptr int32): gboolean {.
    importc, libprag.}

proc audioGetChannelReorderMap*(`from`: ptr AudioChannelPosition;
    to: ptr AudioChannelPosition; reorderMap: seq[int32]): bool =
  let channels = int(reorderMap.len)
  toBool(gst_audio_get_channel_reorder_map(int32(channels), `from`, to, cast[ptr int32](unsafeaddr(reorderMap[0]))))

proc gst_audio_iec61937_frame_size(spec: ptr AudioRingBufferSpec00): uint32 {.
    importc, libprag.}

proc audioIec61937FrameSize*(spec: AudioRingBufferSpec): int =
  int(gst_audio_iec61937_frame_size(cast[ptr AudioRingBufferSpec00](spec.impl)))

proc gst_audio_iec61937_payload(src: ptr uint8; srcN: uint32; dst: ptr uint8;
    dstN: uint32; spec: ptr AudioRingBufferSpec00; endianness: int32): gboolean {.
    importc, libprag.}

proc audioIec61937Payload*(src: seq[uint8] | string; srcN: int; dst: seq[uint8] | string;
    spec: AudioRingBufferSpec; endianness: int): bool =
  let dstN = int(dst.len)
  toBool(gst_audio_iec61937_payload(cast[ptr uint8](unsafeaddr(src[0])), uint32(srcN), cast[ptr uint8](unsafeaddr(dst[0])), uint32(dstN), cast[ptr AudioRingBufferSpec00](spec.impl), int32(endianness)))

proc gst_audio_make_raw_caps(formats: ptr AudioFormat; len: uint32; layout: AudioLayout): ptr gst.Caps00 {.
    importc, libprag.}

proc audioMakeRawCaps*(formats: ptr AudioFormat; len: int; layout: AudioLayout): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_audio_make_raw_caps(formats, uint32(len), layout)

proc audioMetaApiGetType*(): GType {.
    importc: "gst_audio_meta_api_get_type", libprag.}

proc gst_audio_reorder_channels(data: ptr uint8; size: uint64; format: AudioFormat;
    channels: int32; `from`: ptr AudioChannelPosition; to: ptr AudioChannelPosition): gboolean {.
    importc, libprag.}

proc audioReorderChannels*(data: seq[uint8] | string; format: AudioFormat;
    channels: int; `from`: ptr AudioChannelPosition; to: ptr AudioChannelPosition): bool =
  let size = uint64(data.len)
  toBool(gst_audio_reorder_channels(cast[ptr uint8](unsafeaddr(data[0])), size, format, int32(channels), `from`, to))

proc gst_buffer_add_audio_clipping_meta(buffer: ptr gst.Buffer00; format: gst.Format;
    start: uint64; `end`: uint64): ptr AudioClippingMeta00 {.
    importc, libprag.}

proc bufferAddAudioClippingMeta*(buffer: gst.Buffer; format: gst.Format;
    start: uint64; `end`: uint64): AudioClippingMeta =
  new(result)
  result.impl = gst_buffer_add_audio_clipping_meta(cast[ptr gst.Buffer00](buffer.impl), format, start, `end`)
  result.ignoreFinalizer = true

proc gst_buffer_add_audio_downmix_meta(buffer: ptr gst.Buffer00; fromPosition: ptr AudioChannelPosition;
    fromChannels: int32; toPosition: ptr AudioChannelPosition; toChannels: int32;
    matrix: ptr cfloat): ptr AudioDownmixMeta00 {.
    importc, libprag.}

proc bufferAddAudioDownmixMeta*(buffer: gst.Buffer; fromPosition: ptr AudioChannelPosition;
    fromChannels: int; toPosition: ptr AudioChannelPosition; toChannels: int;
    matrix: ptr cfloat): AudioDownmixMeta =
  new(result)
  result.impl = gst_buffer_add_audio_downmix_meta(cast[ptr gst.Buffer00](buffer.impl), fromPosition, int32(fromChannels), toPosition, int32(toChannels), matrix)
  result.ignoreFinalizer = true

proc gst_buffer_add_audio_meta(buffer: ptr gst.Buffer00; info: ptr AudioInfo00;
    samples: uint64; offsets: ptr uint64): ptr AudioMeta00 {.
    importc, libprag.}

proc bufferAddAudioMeta*(buffer: gst.Buffer; info: AudioInfo; samples: uint64;
    offsets: ptr uint64): AudioMeta =
  new(result)
  result.impl = gst_buffer_add_audio_meta(cast[ptr gst.Buffer00](buffer.impl), cast[ptr AudioInfo00](info.impl), samples, offsets)
  result.ignoreFinalizer = true

proc gst_buffer_get_audio_downmix_meta_for_channels(buffer: ptr gst.Buffer00;
    toPosition: ptr AudioChannelPosition; toChannels: int32): ptr AudioDownmixMeta00 {.
    importc, libprag.}

proc bufferGetAudioDownmixMetaForChannels*(buffer: gst.Buffer; toPosition: ptr AudioChannelPosition;
    toChannels: int): AudioDownmixMeta =
  new(result)
  result.impl = gst_buffer_get_audio_downmix_meta_for_channels(cast[ptr gst.Buffer00](buffer.impl), toPosition, int32(toChannels))
  result.ignoreFinalizer = true
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc uRIHandler*(x: gstaudio.AudioCdSrc): gst.URIHandler = cast[gst.URIHandler](x)

proc preset*(x: gstaudio.AudioEncoder): gst.Preset = cast[gst.Preset](x)
