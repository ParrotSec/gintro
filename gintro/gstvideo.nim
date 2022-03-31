# dependencies:
# GObject-2.0
# GstBase-1.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# GstBase-1.0
# Gst-1.0
# libraries:
# libgstvideo-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gst, glib, gmodule
const Lib = "libgstvideo-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const BUFFER_POOL_OPTION_VIDEO_AFFINE_TRANSFORMATION_META* = "GstBufferPoolOptionVideoAffineTransformation"

const BUFFER_POOL_OPTION_VIDEO_ALIGNMENT* = "GstBufferPoolOptionVideoAlignment"

const BUFFER_POOL_OPTION_VIDEO_GL_TEXTURE_UPLOAD_META* = "GstBufferPoolOptionVideoGLTextureUploadMeta"

const BUFFER_POOL_OPTION_VIDEO_META* = "GstBufferPoolOptionVideoMeta"

const CAPS_FEATURE_FORMAT_INTERLACED* = "format:Interlaced"

const CAPS_FEATURE_META_GST_VIDEO_AFFINE_TRANSFORMATION_META* = "meta:GstVideoAffineTransformation"

const CAPS_FEATURE_META_GST_VIDEO_GL_TEXTURE_UPLOAD_META* = "meta:GstVideoGLTextureUploadMeta"

const CAPS_FEATURE_META_GST_VIDEO_META* = "meta:GstVideoMeta"

const CAPS_FEATURE_META_GST_VIDEO_OVERLAY_COMPOSITION* = "meta:GstVideoOverlayComposition"

type
  ColorBalanceChannel* = ref object of gobject.Object
  ColorBalanceChannel00* = object of gobject.Object00

proc gst_color_balance_channel_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ColorBalanceChannel()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scValueChanged*(self: ColorBalanceChannel;  p: proc (self: ptr ColorBalanceChannel00; value: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "value-changed", cast[GCallback](p), xdata, nil, cf)

type
  ColorBalance00* = object of gobject.Object00
  ColorBalance* = ref object of gobject.Object

proc scValueChanged*(self: ColorBalance;  p: proc (self: ptr ColorBalance00; channel: ptr ColorBalanceChannel00; value: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "value-changed", cast[GCallback](p), xdata, nil, cf)

proc gst_color_balance_get_value(self: ptr ColorBalance00; channel: ptr ColorBalanceChannel00): int32 {.
    importc, libprag.}

proc getValue*(self: ColorBalance; channel: ColorBalanceChannel): int =
  int(gst_color_balance_get_value(cast[ptr ColorBalance00](self.impl), cast[ptr ColorBalanceChannel00](channel.impl)))

proc gst_color_balance_list_channels(self: ptr ColorBalance00): ptr glib.List {.
    importc, libprag.}

proc listChannels*(self: ColorBalance): seq[ColorBalanceChannel] =
  result = glistObjects2seq(ColorBalanceChannel, gst_color_balance_list_channels(cast[ptr ColorBalance00](self.impl)), false)

proc gst_color_balance_set_value(self: ptr ColorBalance00; channel: ptr ColorBalanceChannel00;
    value: int32) {.
    importc, libprag.}

proc setValue*(self: ColorBalance; channel: ColorBalanceChannel;
    value: int) =
  gst_color_balance_set_value(cast[ptr ColorBalance00](self.impl), cast[ptr ColorBalanceChannel00](channel.impl), int32(value))

proc gst_color_balance_value_changed(self: ptr ColorBalance00; channel: ptr ColorBalanceChannel00;
    value: int32) {.
    importc, libprag.}

proc valueChanged*(self: ColorBalance; channel: ColorBalanceChannel;
    value: int) =
  gst_color_balance_value_changed(cast[ptr ColorBalance00](self.impl), cast[ptr ColorBalanceChannel00](channel.impl), int32(value))

type
  ColorBalanceType* {.size: sizeof(cint), pure.} = enum
    hardware = 0
    software = 1

proc gst_color_balance_get_balance_type(self: ptr ColorBalance00): ColorBalanceType {.
    importc, libprag.}

proc getBalanceType*(self: ColorBalance): ColorBalanceType =
  gst_color_balance_get_balance_type(cast[ptr ColorBalance00](self.impl))

proc balanceType*(self: ColorBalance): ColorBalanceType =
  gst_color_balance_get_balance_type(cast[ptr ColorBalance00](self.impl))

const META_TAG_VIDEO_COLORSPACE_STR* = "colorspace"

const META_TAG_VIDEO_ORIENTATION_STR* = "orientation"

const META_TAG_VIDEO_SIZE_STR* = "size"

const META_TAG_VIDEO_STR* = "video"

type
  Navigation00* = object of gobject.Object00
  Navigation* = ref object of gobject.Object

proc gst_navigation_event_parse_key_event(event: ptr gst.Event00; key: var cstring): gboolean {.
    importc, libprag.}

proc eventParseKeyEvent*(event: gst.Event; key: var string = cast[var string](nil)): bool =
  var key_00: cstring
  result = toBool(gst_navigation_event_parse_key_event(cast[ptr gst.Event00](event.impl), key_00))
  if key.addr != nil:
    key = $(key_00)

proc gst_navigation_event_parse_mouse_button_event(event: ptr gst.Event00;
    button: var int32; x: var cdouble; y: var cdouble): gboolean {.
    importc, libprag.}

proc eventParseMouseButtonEvent*(event: gst.Event; button: var int = cast[var int](nil);
    x: var cdouble = cast[var cdouble](nil); y: var cdouble = cast[var cdouble](nil)): bool =
  var button_00: int32
  result = toBool(gst_navigation_event_parse_mouse_button_event(cast[ptr gst.Event00](event.impl), button_00, x, y))
  if button.addr != nil:
    button = int(button_00)

proc gst_navigation_event_parse_mouse_move_event(event: ptr gst.Event00;
    x: var cdouble; y: var cdouble): gboolean {.
    importc, libprag.}

proc eventParseMouseMoveEvent*(event: gst.Event; x: var cdouble = cast[var cdouble](nil);
    y: var cdouble = cast[var cdouble](nil)): bool =
  toBool(gst_navigation_event_parse_mouse_move_event(cast[ptr gst.Event00](event.impl), x, y))

proc gst_navigation_event_parse_mouse_scroll_event(event: ptr gst.Event00;
    x: var cdouble; y: var cdouble; deltaX: var cdouble; deltaY: var cdouble): gboolean {.
    importc, libprag.}

proc eventParseMouseScrollEvent*(event: gst.Event; x: var cdouble = cast[var cdouble](nil);
    y: var cdouble = cast[var cdouble](nil); deltaX: var cdouble = cast[var cdouble](nil);
    deltaY: var cdouble = cast[var cdouble](nil)): bool =
  toBool(gst_navigation_event_parse_mouse_scroll_event(cast[ptr gst.Event00](event.impl), x, y, deltaX, deltaY))

proc gst_navigation_message_new_angles_changed(src: ptr gst.Object00; curAngle: uint32;
    nAngles: uint32): ptr gst.Message00 {.
    importc, libprag.}

proc messageNewAnglesChanged*(src: gst.Object; curAngle: int;
    nAngles: int): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_navigation_message_new_angles_changed(cast[ptr gst.Object00](src.impl), uint32(curAngle), uint32(nAngles))

proc gst_navigation_message_new_commands_changed(src: ptr gst.Object00): ptr gst.Message00 {.
    importc, libprag.}

proc messageNewCommandsChanged*(src: gst.Object): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_navigation_message_new_commands_changed(cast[ptr gst.Object00](src.impl))

proc gst_navigation_message_new_event(src: ptr gst.Object00; event: ptr gst.Event00): ptr gst.Message00 {.
    importc, libprag.}

proc messageNewEvent*(src: gst.Object; event: gst.Event): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_navigation_message_new_event(cast[ptr gst.Object00](src.impl), cast[ptr gst.Event00](event.impl))

proc gst_navigation_message_new_mouse_over(src: ptr gst.Object00; active: gboolean): ptr gst.Message00 {.
    importc, libprag.}

proc messageNewMouseOver*(src: gst.Object; active: bool): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_navigation_message_new_mouse_over(cast[ptr gst.Object00](src.impl), gboolean(active))

proc gst_navigation_message_parse_angles_changed(message: ptr gst.Message00;
    curAngle: var uint32; nAngles: var uint32): gboolean {.
    importc, libprag.}

proc messageParseAnglesChanged*(message: gst.Message; curAngle: var int = cast[var int](nil);
    nAngles: var int = cast[var int](nil)): bool =
  var curAngle_00: uint32
  var nAngles_00: uint32
  result = toBool(gst_navigation_message_parse_angles_changed(cast[ptr gst.Message00](message.impl), curAngle_00, nAngles_00))
  if curAngle.addr != nil:
    curAngle = int(curAngle_00)
  if nAngles.addr != nil:
    nAngles = int(nAngles_00)

proc gst_navigation_message_parse_event(message: ptr gst.Message00; event: var ptr gst.Event00): gboolean {.
    importc, libprag.}

proc messageParseEvent*(message: gst.Message; event: var gst.Event = cast[var gst.Event](nil)): bool =
  if addr(event) != nil:
    fnew(event, gBoxedFreeGstEvent)
  toBool(gst_navigation_message_parse_event(cast[ptr gst.Message00](message.impl), cast[var ptr gst.Event00](if addr(event) == nil: nil else: addr event.impl)))

proc gst_navigation_message_parse_mouse_over(message: ptr gst.Message00;
    active: var gboolean): gboolean {.
    importc, libprag.}

proc messageParseMouseOver*(message: gst.Message; active: var bool = cast[var bool](nil)): bool =
  var active_00: gboolean
  result = toBool(gst_navigation_message_parse_mouse_over(cast[ptr gst.Message00](message.impl), active_00))
  if active.addr != nil:
    active = toBool(active_00)

proc gst_navigation_query_new_angles(): ptr gst.Query00 {.
    importc, libprag.}

proc queryNewAngles*(): gst.Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_navigation_query_new_angles()

proc gst_navigation_query_new_commands(): ptr gst.Query00 {.
    importc, libprag.}

proc queryNewCommands*(): gst.Query =
  fnew(result, gBoxedFreeGstQuery)
  result.impl = gst_navigation_query_new_commands()

proc gst_navigation_query_parse_angles(query: ptr gst.Query00; curAngle: var uint32;
    nAngles: var uint32): gboolean {.
    importc, libprag.}

proc queryParseAngles*(query: gst.Query; curAngle: var int = cast[var int](nil);
    nAngles: var int = cast[var int](nil)): bool =
  var curAngle_00: uint32
  var nAngles_00: uint32
  result = toBool(gst_navigation_query_parse_angles(cast[ptr gst.Query00](query.impl), curAngle_00, nAngles_00))
  if curAngle.addr != nil:
    curAngle = int(curAngle_00)
  if nAngles.addr != nil:
    nAngles = int(nAngles_00)

proc gst_navigation_query_parse_commands_length(query: ptr gst.Query00; nCmds: var uint32): gboolean {.
    importc, libprag.}

proc queryParseCommandsLength*(query: gst.Query; nCmds: var int = cast[var int](nil)): bool =
  var nCmds_00: uint32
  result = toBool(gst_navigation_query_parse_commands_length(cast[ptr gst.Query00](query.impl), nCmds_00))
  if nCmds.addr != nil:
    nCmds = int(nCmds_00)

proc gst_navigation_query_set_angles(query: ptr gst.Query00; curAngle: uint32;
    nAngles: uint32) {.
    importc, libprag.}

proc querySetAngles*(query: gst.Query; curAngle: int; nAngles: int) =
  gst_navigation_query_set_angles(cast[ptr gst.Query00](query.impl), uint32(curAngle), uint32(nAngles))

proc gst_navigation_send_event(self: ptr Navigation00; structure: ptr gst.Structure00) {.
    importc, libprag.}

proc sendEvent*(self: Navigation; structure: gst.Structure) =
  gst_navigation_send_event(cast[ptr Navigation00](self.impl), cast[ptr gst.Structure00](structure.impl))

proc gst_navigation_send_key_event(self: ptr Navigation00; event: cstring;
    key: cstring) {.
    importc, libprag.}

proc sendKeyEvent*(self: Navigation; event: cstring; key: cstring) =
  gst_navigation_send_key_event(cast[ptr Navigation00](self.impl), event, key)

proc gst_navigation_send_mouse_event(self: ptr Navigation00; event: cstring;
    button: int32; x: cdouble; y: cdouble) {.
    importc, libprag.}

proc sendMouseEvent*(self: Navigation; event: cstring; button: int;
    x: cdouble; y: cdouble) =
  gst_navigation_send_mouse_event(cast[ptr Navigation00](self.impl), event, int32(button), x, y)

proc gst_navigation_send_mouse_scroll_event(self: ptr Navigation00; x: cdouble;
    y: cdouble; deltaX: cdouble; deltaY: cdouble) {.
    importc, libprag.}

proc sendMouseScrollEvent*(self: Navigation; x: cdouble;
    y: cdouble; deltaX: cdouble; deltaY: cdouble) =
  gst_navigation_send_mouse_scroll_event(cast[ptr Navigation00](self.impl), x, y, deltaX, deltaY)

type
  NavigationEventType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    keyPress = 1
    keyRelease = 2
    mouseButtonPress = 3
    mouseButtonRelease = 4
    mouseMove = 5
    command = 6
    mouseScroll = 7

proc gst_navigation_event_get_type(event: ptr gst.Event00): NavigationEventType {.
    importc, libprag.}

proc eventGetType*(event: gst.Event): NavigationEventType =
  gst_navigation_event_get_type(cast[ptr gst.Event00](event.impl))

type
  NavigationMessageType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    mouseOver = 1
    commandsChanged = 2
    anglesChanged = 3
    event = 4

proc gst_navigation_message_get_type(message: ptr gst.Message00): NavigationMessageType {.
    importc, libprag.}

proc messageGetType*(message: gst.Message): NavigationMessageType =
  gst_navigation_message_get_type(cast[ptr gst.Message00](message.impl))

type
  NavigationQueryType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    commands = 1
    angles = 2

proc gst_navigation_query_get_type(query: ptr gst.Query00): NavigationQueryType {.
    importc, libprag.}

proc queryGetType*(query: gst.Query): NavigationQueryType =
  gst_navigation_query_get_type(cast[ptr gst.Query00](query.impl))

type
  NavigationCommand* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    menu1 = 1
    menu2 = 2
    menu3 = 3
    menu4 = 4
    menu5 = 5
    menu6 = 6
    menu7 = 7
    left = 20
    right = 21
    up = 22
    down = 23
    activate = 24
    prevAngle = 30
    nextAngle = 31

proc gst_navigation_event_parse_command(event: ptr gst.Event00; command: var NavigationCommand): gboolean {.
    importc, libprag.}

proc eventParseCommand*(event: gst.Event; command: var NavigationCommand = cast[var NavigationCommand](nil)): bool =
  toBool(gst_navigation_event_parse_command(cast[ptr gst.Event00](event.impl), command))

proc gst_navigation_query_parse_commands_nth(query: ptr gst.Query00; nth: uint32;
    cmd: var NavigationCommand): gboolean {.
    importc, libprag.}

proc queryParseCommandsNth*(query: gst.Query; nth: int;
    cmd: var NavigationCommand = cast[var NavigationCommand](nil)): bool =
  toBool(gst_navigation_query_parse_commands_nth(cast[ptr gst.Query00](query.impl), uint32(nth), cmd))

proc gst_navigation_query_set_commandsv(query: ptr gst.Query00; nCmds: int32;
    cmds: ptr NavigationCommand) {.
    importc, libprag.}

proc querySetCommandsv*(query: gst.Query; nCmds: int; cmds: ptr NavigationCommand) =
  gst_navigation_query_set_commandsv(cast[ptr gst.Query00](query.impl), int32(nCmds), cmds)

proc gst_navigation_send_command(self: ptr Navigation00; command: NavigationCommand) {.
    importc, libprag.}

proc sendCommand*(self: Navigation; command: NavigationCommand) =
  gst_navigation_send_command(cast[ptr Navigation00](self.impl), command)

const VIDEO_COLORIMETRY_BT2020* = "bt2020"

const VIDEO_COLORIMETRY_BT2020_10* = "bt2020-10"

const VIDEO_COLORIMETRY_BT2100_HLG* = "bt2100-hlg"

const VIDEO_COLORIMETRY_BT2100_PQ* = "bt2100-pq"

const VIDEO_COLORIMETRY_BT601* = "bt601"

const VIDEO_COLORIMETRY_BT709* = "bt709"

const VIDEO_COLORIMETRY_SMPTE240M* = "smpte240m"

const VIDEO_COLORIMETRY_SRGB* = "sRGB"

const VIDEO_COMP_A* = 3'i32

const VIDEO_COMP_B* = 2'i32

const VIDEO_COMP_G* = 1'i32

const VIDEO_COMP_INDEX* = 0'i32

const VIDEO_COMP_PALETTE* = 1'i32

const VIDEO_COMP_R* = 0'i32

const VIDEO_COMP_U* = 1'i32

const VIDEO_COMP_V* = 2'i32

const VIDEO_COMP_Y* = 0'i32

const VIDEO_CONVERTER_OPT_ALPHA_MODE* = "GstVideoConverter.alpha-mode"

const VIDEO_CONVERTER_OPT_ALPHA_VALUE* = "GstVideoConverter.alpha-value"

const VIDEO_CONVERTER_OPT_BORDER_ARGB* = "GstVideoConverter.border-argb"

const VIDEO_CONVERTER_OPT_CHROMA_MODE* = "GstVideoConverter.chroma-mode"

const VIDEO_CONVERTER_OPT_CHROMA_RESAMPLER_METHOD* = "GstVideoConverter.chroma-resampler-method"

const VIDEO_CONVERTER_OPT_DEST_HEIGHT* = "GstVideoConverter.dest-height"

const VIDEO_CONVERTER_OPT_DEST_WIDTH* = "GstVideoConverter.dest-width"

const VIDEO_CONVERTER_OPT_DEST_X* = "GstVideoConverter.dest-x"

const VIDEO_CONVERTER_OPT_DEST_Y* = "GstVideoConverter.dest-y"

const VIDEO_CONVERTER_OPT_DITHER_METHOD* = "GstVideoConverter.dither-method"

const VIDEO_CONVERTER_OPT_DITHER_QUANTIZATION* = "GstVideoConverter.dither-quantization"

const VIDEO_CONVERTER_OPT_FILL_BORDER* = "GstVideoConverter.fill-border"

const VIDEO_CONVERTER_OPT_GAMMA_MODE* = "GstVideoConverter.gamma-mode"

const VIDEO_CONVERTER_OPT_MATRIX_MODE* = "GstVideoConverter.matrix-mode"

const VIDEO_CONVERTER_OPT_PRIMARIES_MODE* = "GstVideoConverter.primaries-mode"

const VIDEO_CONVERTER_OPT_RESAMPLER_METHOD* = "GstVideoConverter.resampler-method"

const VIDEO_CONVERTER_OPT_RESAMPLER_TAPS* = "GstVideoConverter.resampler-taps"

const VIDEO_CONVERTER_OPT_SRC_HEIGHT* = "GstVideoConverter.src-height"

const VIDEO_CONVERTER_OPT_SRC_WIDTH* = "GstVideoConverter.src-width"

const VIDEO_CONVERTER_OPT_SRC_X* = "GstVideoConverter.src-x"

const VIDEO_CONVERTER_OPT_SRC_Y* = "GstVideoConverter.src-y"

const VIDEO_CONVERTER_OPT_THREADS* = "GstVideoConverter.threads"

const VIDEO_DECODER_MAX_ERRORS* = 10'i32

const VIDEO_DECODER_SINK_NAME* = "sink"

const VIDEO_DECODER_SRC_NAME* = "src"

const VIDEO_ENCODER_SINK_NAME* = "sink"

const VIDEO_ENCODER_SRC_NAME* = "src"

const VIDEO_FORMATS_ALL* = "{ AYUV64, ARGB64, GBRA_12BE, GBRA_12LE, Y412_BE, Y412_LE, A444_10BE, GBRA_10BE, A444_10LE, GBRA_10LE, A422_10BE, A422_10LE, A420_10BE, A420_10LE, Y410, RGB10A2_LE, BGR10A2_LE, GBRA, ABGR, VUYA, BGRA, AYUV, ARGB, RGBA, A420, Y444_16BE, Y444_16LE, v216, P016_BE, P016_LE, Y444_12BE, GBR_12BE, Y444_12LE, GBR_12LE, I422_12BE, I422_12LE, Y212_BE, Y212_LE, I420_12BE, I420_12LE, P012_BE, P012_LE, Y444_10BE, GBR_10BE, Y444_10LE, GBR_10LE, r210, I422_10BE, I422_10LE, NV16_10LE32, Y210, v210, UYVP, I420_10BE, I420_10LE, P010_10BE, P010_10LE, NV12_10LE32, NV12_10LE40, Y444, GBR, NV24, xBGR, BGRx, xRGB, RGBx, BGR, IYU2, v308, RGB, Y42B, NV61, NV16, VYUY, UYVY, YVYU, YUY2, I420, YV12, NV21, NV12, NV12_64Z32, NV12_4L4, NV12_32L32, Y41B, IYU1, YVU9, YUV9, RGB16, BGR16, RGB15, BGR15, RGB8P, GRAY16_BE, GRAY16_LE, GRAY10_LE32, GRAY8 }"

const VIDEO_FPS_RANGE* = "(fraction) [ 0, max ]"

const VIDEO_MAX_COMPONENTS* = 4'i32

const VIDEO_MAX_PLANES* = 4'i32

const VIDEO_RESAMPLER_OPT_CUBIC_B* = "GstVideoResampler.cubic-b"

const VIDEO_RESAMPLER_OPT_CUBIC_C* = "GstVideoResampler.cubic-c"

const VIDEO_RESAMPLER_OPT_ENVELOPE* = "GstVideoResampler.envelope"

const VIDEO_RESAMPLER_OPT_MAX_TAPS* = "GstVideoResampler.max-taps"

const VIDEO_RESAMPLER_OPT_SHARPEN* = "GstVideoResampler.sharpen"

const VIDEO_RESAMPLER_OPT_SHARPNESS* = "GstVideoResampler.sharpness"

const VIDEO_SCALER_OPT_DITHER_METHOD* = "GstVideoScaler.dither-method"

const VIDEO_SIZE_RANGE* = "(int) [ 1, max ]"

const VIDEO_TILE_TYPE_MASK* = 65535'i32

const VIDEO_TILE_TYPE_SHIFT* = 16'i32

const VIDEO_TILE_X_TILES_MASK* = 65535'i32

const VIDEO_TILE_Y_TILES_SHIFT* = 16'i32

type
  VideoAFDMeta00* {.pure.} = object
  VideoAFDMeta* = ref object
    impl*: ptr VideoAFDMeta00
    ignoreFinalizer*: bool

proc gst_video_afd_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoAFDMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_afd_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoAFDSpec* {.size: sizeof(cint), pure.} = enum
    dvbEtsi = 0
    atscA53 = 1
    smpteSt2016_1 = 2

type
  VideoAFDValue* {.size: sizeof(cint), pure.} = enum
    unavailable = 0
    enum16_9TopAligned = 2
    enum14_9TopAligned = 3
    greaterThan_16_9 = 4
    enum4_3Full_16_9Full = 8
    enum4_3Full_4_3Pillar = 9
    enum16_9Letter_16_9Full = 10
    enum14_9Letter_14_9Pillar = 11
    enum4_3Full_14_9Center = 13
    enum16_9Letter_14_9Center = 14
    enum16_9Letter_4_3Center = 15

type
  VideoAffineTransformationMeta00* {.pure.} = object
  VideoAffineTransformationMeta* = ref object
    impl*: ptr VideoAffineTransformationMeta00
    ignoreFinalizer*: bool

proc gst_video_affine_transformation_meta_apply_matrix(self: ptr VideoAffineTransformationMeta00;
    matrix: ptr array[16, cfloat]) {.
    importc, libprag.}

proc applyMatrix*(self: VideoAffineTransformationMeta;
    matrix: ptr array[16, cfloat]) =
  gst_video_affine_transformation_meta_apply_matrix(cast[ptr VideoAffineTransformationMeta00](self.impl), matrix)

proc gst_video_affine_transformation_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoAffineTransformationMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_affine_transformation_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoAffineTransformationGetMatrix* = proc (meta: ptr VideoAffineTransformationMeta00; matrix: ptr cfloat): gboolean {.cdecl.}

type
  VideoAggregator* = ref object of gstbase.Aggregator
  VideoAggregator00* = object of gstbase.Aggregator00

proc gst_video_aggregator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoAggregator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  VideoAggregatorPad* = ref object of gstbase.AggregatorPad
  VideoAggregatorPad00* = object of gstbase.AggregatorPad00

proc gst_video_aggregator_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoAggregatorPad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_video_aggregator_pad_get_current_buffer(self: ptr VideoAggregatorPad00): ptr gst.Buffer00 {.
    importc, libprag.}

proc getCurrentBuffer*(self: VideoAggregatorPad): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_aggregator_pad_get_current_buffer(cast[ptr VideoAggregatorPad00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

proc currentBuffer*(self: VideoAggregatorPad): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_aggregator_pad_get_current_buffer(cast[ptr VideoAggregatorPad00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

proc gst_video_aggregator_pad_has_current_buffer(self: ptr VideoAggregatorPad00): gboolean {.
    importc, libprag.}

proc hasCurrentBuffer*(self: VideoAggregatorPad): bool =
  toBool(gst_video_aggregator_pad_has_current_buffer(cast[ptr VideoAggregatorPad00](self.impl)))

proc gst_video_aggregator_pad_set_needs_alpha(self: ptr VideoAggregatorPad00;
    needsAlpha: gboolean) {.
    importc, libprag.}

proc setNeedsAlpha*(self: VideoAggregatorPad; needsAlpha: bool = true) =
  gst_video_aggregator_pad_set_needs_alpha(cast[ptr VideoAggregatorPad00](self.impl), gboolean(needsAlpha))

proc `needsAlpha=`*(self: VideoAggregatorPad; needsAlpha: bool) =
  gst_video_aggregator_pad_set_needs_alpha(cast[ptr VideoAggregatorPad00](self.impl), gboolean(needsAlpha))

type
  VideoAggregatorConvertPad* = ref object of VideoAggregatorPad
  VideoAggregatorConvertPad00* = object of VideoAggregatorPad00

proc gst_video_aggregator_convert_pad_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoAggregatorConvertPad()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_video_aggregator_convert_pad_update_conversion_info(self: ptr VideoAggregatorConvertPad00) {.
    importc, libprag.}

proc updateConversionInfo*(self: VideoAggregatorConvertPad) =
  gst_video_aggregator_convert_pad_update_conversion_info(cast[ptr VideoAggregatorConvertPad00](self.impl))

type
  VideoInfo00* {.pure.} = object
  VideoInfo* = ref object
    impl*: ptr VideoInfo00
    ignoreFinalizer*: bool

proc gst_video_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoInfo*(self: VideoInfo) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_info_get_type(), cast[ptr VideoInfo00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_info_get_type(), cast[ptr VideoInfo00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoInfo) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoInfo)

proc gst_video_info_free(self: ptr VideoInfo00) {.
    importc, libprag.}

proc free*(self: VideoInfo) =
  gst_video_info_free(cast[ptr VideoInfo00](self.impl))

proc finalizerfree*(self: VideoInfo) =
  if not self.ignoreFinalizer:
    gst_video_info_free(cast[ptr VideoInfo00](self.impl))

proc gst_video_info_convert(self: ptr VideoInfo00; srcFormat: gst.Format;
    srcValue: int64; destFormat: gst.Format; destValue: var int64): gboolean {.
    importc, libprag.}

proc convert*(self: VideoInfo; srcFormat: gst.Format; srcValue: int64;
    destFormat: gst.Format; destValue: var int64): bool =
  toBool(gst_video_info_convert(cast[ptr VideoInfo00](self.impl), srcFormat, srcValue, destFormat, destValue))

proc gst_video_info_copy(self: ptr VideoInfo00): ptr VideoInfo00 {.
    importc, libprag.}

proc copy*(self: VideoInfo): VideoInfo =
  fnew(result, gBoxedFreeGstVideoInfo)
  result.impl = gst_video_info_copy(cast[ptr VideoInfo00](self.impl))

proc gst_video_info_new(): ptr VideoInfo00 {.
    importc, libprag.}

proc newVideoInfo*(): VideoInfo =
  fnew(result, gBoxedFreeGstVideoInfo)
  result.impl = gst_video_info_new()

proc newVideoInfo*(tdesc: typedesc): tdesc =
  assert(result is VideoInfo)
  fnew(result, gBoxedFreeGstVideoInfo)
  result.impl = gst_video_info_new()

proc initVideoInfo*[T](result: var T) {.deprecated.} =
  assert(result is VideoInfo)
  fnew(result, gBoxedFreeGstVideoInfo)
  result.impl = gst_video_info_new()

proc gst_video_info_from_caps(self: ptr VideoInfo00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc fromCaps*(self: VideoInfo; caps: gst.Caps): bool =
  toBool(gst_video_info_from_caps(cast[ptr VideoInfo00](self.impl), cast[ptr gst.Caps00](caps.impl)))

proc gst_video_info_init(self: ptr VideoInfo00) {.
    importc, libprag.}

proc init*(self: VideoInfo) =
  gst_video_info_init(cast[ptr VideoInfo00](self.impl))

proc gst_video_info_is_equal(self: ptr VideoInfo00; other: ptr VideoInfo00): gboolean {.
    importc, libprag.}

proc isEqual*(self: VideoInfo; other: VideoInfo): bool =
  toBool(gst_video_info_is_equal(cast[ptr VideoInfo00](self.impl), cast[ptr VideoInfo00](other.impl)))

proc gst_video_info_to_caps(self: ptr VideoInfo00): ptr gst.Caps00 {.
    importc, libprag.}

proc toCaps*(self: VideoInfo): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_video_info_to_caps(cast[ptr VideoInfo00](self.impl))

type
  VideoFrameFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    interlaced = 1
    tff = 2
    rff = 4
    bottomField = 8
    topField = 10
    multipleView = 16
    firstInBundle = 32

const
  VideoFrameFlagsOnefield* = VideoFrameFlags.bottomField

type
  VideoFrame* {.pure, byRef.} = object
    info*: VideoInfo00
    flags*: VideoFrameFlags
    buffer*: ptr gst.Buffer00
    meta*: pointer
    id*: int32
    data*: array[4, pointer]
    map*: array[4, gst.MapInfo]
    gstReserved*: array[4, pointer]

proc gst_video_frame_copy(self: VideoFrame; src: VideoFrame): gboolean {.
    importc, libprag.}

proc copy*(self: VideoFrame; src: VideoFrame): bool =
  toBool(gst_video_frame_copy(self, src))

proc gst_video_frame_copy_plane(self: VideoFrame; src: VideoFrame; plane: uint32): gboolean {.
    importc, libprag.}

proc copyPlane*(self: VideoFrame; src: VideoFrame; plane: int): bool =
  toBool(gst_video_frame_copy_plane(self, src, uint32(plane)))

proc gst_video_frame_map(self: VideoFrame; info: ptr VideoInfo00; buffer: ptr gst.Buffer00;
    flags: gst.MapFlags): gboolean {.
    importc, libprag.}

proc map*(self: VideoFrame; info: VideoInfo; buffer: gst.Buffer;
    flags: gst.MapFlags): bool =
  toBool(gst_video_frame_map(self, cast[ptr VideoInfo00](info.impl), cast[ptr gst.Buffer00](buffer.impl), flags))

proc gst_video_frame_map_id(self: VideoFrame; info: ptr VideoInfo00; buffer: ptr gst.Buffer00;
    id: int32; flags: gst.MapFlags): gboolean {.
    importc, libprag.}

proc mapId*(self: VideoFrame; info: VideoInfo; buffer: gst.Buffer;
    id: int; flags: gst.MapFlags): bool =
  toBool(gst_video_frame_map_id(self, cast[ptr VideoInfo00](info.impl), cast[ptr gst.Buffer00](buffer.impl), int32(id), flags))

proc gst_video_frame_unmap(self: VideoFrame) {.
    importc, libprag.}

proc unmap*(self: VideoFrame) =
  gst_video_frame_unmap(self)

proc gst_video_aggregator_pad_get_prepared_frame(self: ptr VideoAggregatorPad00): ptr VideoFrame {.
    importc, libprag.}

proc getPreparedFrame*(self: VideoAggregatorPad): ptr VideoFrame =
  gst_video_aggregator_pad_get_prepared_frame(cast[ptr VideoAggregatorPad00](self.impl))

proc preparedFrame*(self: VideoAggregatorPad): ptr VideoFrame =
  gst_video_aggregator_pad_get_prepared_frame(cast[ptr VideoAggregatorPad00](self.impl))

type
  VideoAlignment* {.pure, byRef.} = object
    paddingTop*: uint32
    paddingBottom*: uint32
    paddingLeft*: uint32
    paddingRight*: uint32
    strideAlign*: array[4, uint32]

proc gst_video_alignment_reset(self: VideoAlignment) {.
    importc, libprag.}

proc reset*(self: VideoAlignment) =
  gst_video_alignment_reset(self)

proc gst_video_info_align(self: ptr VideoInfo00; align: VideoAlignment): gboolean {.
    importc, libprag.}

proc align*(self: VideoInfo; align: VideoAlignment): bool =
  toBool(gst_video_info_align(cast[ptr VideoInfo00](self.impl), align))

proc gst_video_info_align_full(self: ptr VideoInfo00; align: VideoAlignment;
    planeSize: var uint64): gboolean {.
    importc, libprag.}

proc alignFull*(self: VideoInfo; align: VideoAlignment; planeSize: var uint64 = cast[var uint64](nil)): bool =
  toBool(gst_video_info_align_full(cast[ptr VideoInfo00](self.impl), align, planeSize))

type
  VideoFormat* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    encoded = 1
    i420 = 2
    yv12 = 3
    yuy2 = 4
    uyvy = 5
    ayuv = 6
    rgbx = 7
    bgrx = 8
    xrgb = 9
    xbgr = 10
    rgba = 11
    bgra = 12
    argb = 13
    abgr = 14
    rgb = 15
    bgr = 16
    y41b = 17
    y42b = 18
    yvyu = 19
    y444 = 20
    v210 = 21
    v216 = 22
    nv12 = 23
    nv21 = 24
    gray8 = 25
    gray16Be = 26
    gray16Le = 27
    v308 = 28
    rgb16 = 29
    bgr16 = 30
    rgb15 = 31
    bgr15 = 32
    uyvp = 33
    a420 = 34
    rgb8p = 35
    yuv9 = 36
    yvu9 = 37
    iyu1 = 38
    argb64 = 39
    ayuv64 = 40
    r210 = 41
    i420_10be = 42
    i420_10le = 43
    i422_10be = 44
    i422_10le = 45
    y444_10be = 46
    y444_10le = 47
    gbr = 48
    gbr_10be = 49
    gbr_10le = 50
    nv16 = 51
    nv24 = 52
    nv12_64z32 = 53
    a420_10be = 54
    a420_10le = 55
    a422_10be = 56
    a422_10le = 57
    a444_10be = 58
    a444_10le = 59
    nv61 = 60
    p010_10be = 61
    p010_10le = 62
    iyu2 = 63
    vyuy = 64
    gbra = 65
    gbra_10be = 66
    gbra_10le = 67
    gbr_12be = 68
    gbr_12le = 69
    gbra_12be = 70
    gbra_12le = 71
    i420_12be = 72
    i420_12le = 73
    i422_12be = 74
    i422_12le = 75
    y444_12be = 76
    y444_12le = 77
    gray10Le32 = 78
    nv12_10le32 = 79
    nv16_10le32 = 80
    nv12_10le40 = 81
    y210 = 82
    y410 = 83
    vuya = 84
    bgr10a2Le = 85
    rgb10a2Le = 86
    y444_16be = 87
    y444_16le = 88
    p016Be = 89
    p016Le = 90
    p012Be = 91
    p012Le = 92
    y212Be = 93
    y212Le = 94
    y412Be = 95
    y412Le = 96
    nv12_4l4 = 97
    nv12_32l32 = 98

proc gst_video_format_from_fourcc(fourcc: uint32): VideoFormat {.
    importc, libprag.}

proc fromFourcc*(fourcc: int): VideoFormat =
  gst_video_format_from_fourcc(uint32(fourcc))

proc gst_video_format_from_masks(depth: int32; bpp: int32; endianness: int32;
    redMask: uint32; greenMask: uint32; blueMask: uint32; alphaMask: uint32): VideoFormat {.
    importc, libprag.}

proc fromMasks*(depth: int; bpp: int; endianness: int; redMask: int;
    greenMask: int; blueMask: int; alphaMask: int): VideoFormat =
  gst_video_format_from_masks(int32(depth), int32(bpp), int32(endianness), uint32(redMask), uint32(greenMask), uint32(blueMask), uint32(alphaMask))

proc fromStringVideoFormat*(format: cstring): VideoFormat {.
    importc: "gst_video_format_from_string", libprag.}

proc getPalette*(format: VideoFormat; size: var uint64): pointer {.
    importc: "gst_video_format_get_palette", libprag.}

proc getPalette*(format: VideoFormat): pointer {.
    importc: "gst_video_format_get_palette", libprag.}

proc gst_video_format_to_fourcc(format: VideoFormat): uint32 {.
    importc, libprag.}

proc toFourcc*(format: VideoFormat): int =
  int(gst_video_format_to_fourcc(format))

proc gst_video_format_to_string(format: VideoFormat): cstring {.
    importc, libprag.}

proc toString*(format: VideoFormat): string =
  result = $gst_video_format_to_string(format)

proc gst_video_info_set_format(self: ptr VideoInfo00; format: VideoFormat;
    width: uint32; height: uint32): gboolean {.
    importc, libprag.}

proc setFormat*(self: VideoInfo; format: VideoFormat; width: int;
    height: int): bool =
  toBool(gst_video_info_set_format(cast[ptr VideoInfo00](self.impl), format, uint32(width), uint32(height)))

type
  VideoInterlaceMode* {.size: sizeof(cint), pure.} = enum
    progressive = 0
    interleaved = 1
    mixed = 2
    fields = 3
    alternate = 4

proc fromStringVideoInterlaceMode*(mode: cstring): VideoInterlaceMode {.
    importc: "gst_video_interlace_mode_from_string", libprag.}

proc gst_video_interlace_mode_to_string(mode: VideoInterlaceMode): cstring {.
    importc, libprag.}

proc toString*(mode: VideoInterlaceMode): string =
  result = $gst_video_interlace_mode_to_string(mode)

proc gst_video_info_set_interlaced_format(self: ptr VideoInfo00; format: VideoFormat;
    mode: VideoInterlaceMode; width: uint32; height: uint32): gboolean {.
    importc, libprag.}

proc setInterlacedFormat*(self: VideoInfo; format: VideoFormat;
    mode: VideoInterlaceMode; width: int; height: int): bool =
  toBool(gst_video_info_set_interlaced_format(cast[ptr VideoInfo00](self.impl), format, mode, uint32(width), uint32(height)))

type
  VideoFormatFlag* {.size: sizeof(cint), pure.} = enum
    yuv = 0
    rgb = 1
    gray = 2
    alpha = 3
    le = 4
    palette = 5
    complex = 6
    unpack = 7
    tiled = 8

  VideoFormatFlags* {.size: sizeof(cint).} = set[VideoFormatFlag]

type
  VideoAlphaMode* {.size: sizeof(cint), pure.} = enum
    copy = 0
    set = 1
    mult = 2

type
  VideoAncillary* {.pure, byRef.} = object
    DID*: uint8
    SDID_blockNumber*: uint8
    dataCount*: uint8
    data*: ptr uint8
    gstReserved*: array[4, pointer]

type
  VideoAncillaryDID* {.size: sizeof(cint), pure.} = enum
    undefined = 0
    deletion = 128
    hanc_3gAudioDataFirst = 160
    hanc_3gAudioDataLast = 167
    hancHdtvAudioDataFirst = 224
    hancHdtvAudioDataLast = 231
    hancSdtvAudioData_1First = 236
    hancSdtvAudioData_1Last = 239
    cameraPosition = 240
    hancErrorDetection = 244
    hancSdtvAudioData_2First = 248
    hancSdtvAudioData_2Last = 255

type
  VideoAncillaryDID16* {.size: sizeof(cint), pure.} = enum
    s2016_3AfdBar = 16645
    s334Eia_708 = 24833
    s334Eia_608 = 24834

type
  VideoBarMeta00* {.pure.} = object
  VideoBarMeta* = ref object
    impl*: ptr VideoBarMeta00
    ignoreFinalizer*: bool

proc gst_video_bar_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoBarMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_bar_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoBufferFlags* {.size: sizeof(cint), pure.} = enum
    marker = 512
    interlaced = 1048576
    tff = 2097152
    rff = 4194304
    bottomField = 8388608
    topField = 10485760
    multipleView = 16777216
    firstInBundle = 33554432
    last = 268435456

const
  VideoBufferFlagsOnefield* = VideoBufferFlags.bottomField

type
  VideoBufferPool* = ref object of gst.BufferPool
  VideoBufferPool00* = object of gst.BufferPool00

proc gst_video_buffer_pool_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoBufferPool()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_video_buffer_pool_new(): ptr VideoBufferPool00 {.
    importc, libprag.}

proc newVideoBufferPool*(): VideoBufferPool =
  let gobj = gst_video_buffer_pool_new()
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

proc newVideoBufferPool*(tdesc: typedesc): tdesc =
  assert(result is VideoBufferPool)
  let gobj = gst_video_buffer_pool_new()
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

proc initVideoBufferPool*[T](result: var T) {.deprecated.} =
  assert(result is VideoBufferPool)
  let gobj = gst_video_buffer_pool_new()
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
  VideoCaptionType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    cea608Raw = 1
    cea608S334_1a = 2
    cea708Raw = 3
    cea708Cdp = 4

proc gst_video_caption_type_from_caps(caps: ptr gst.Caps00): VideoCaptionType {.
    importc, libprag.}

proc fromCaps*(caps: gst.Caps): VideoCaptionType =
  gst_video_caption_type_from_caps(cast[ptr gst.Caps00](caps.impl))

proc gst_video_caption_type_to_caps(`type`: VideoCaptionType): ptr gst.Caps00 {.
    importc, libprag.}

proc toCaps*(`type`: VideoCaptionType): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_video_caption_type_to_caps(`type`)

type
  VideoCaptionMeta* {.pure, byRef.} = object
    meta*: gst.Meta00
    captionType*: VideoCaptionType
    data*: ptr uint8
    size*: uint64

proc gst_video_caption_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoCaptionMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_caption_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoChromaFlag* {.size: sizeof(cint), pure.} = enum
    interlaced = 0

  VideoChromaFlags* {.size: sizeof(cint).} = set[VideoChromaFlag]

const
  VideoChromaFlagsNone* = VideoChromaFlags({})
proc none*(t: typedesc[VideoChromaFlags]): VideoChromaFlags = VideoChromaFlags({})

type
  VideoChromaMethod* {.size: sizeof(cint), pure.} = enum
    nearest = 0
    linear = 1

type
  VideoChromaMode* {.size: sizeof(cint), pure.} = enum
    full = 0
    upsampleOnly = 1
    downsampleOnly = 2
    none = 3

type
  VideoChromaResample00* {.pure.} = object
  VideoChromaResample* = ref object
    impl*: ptr VideoChromaResample00
    ignoreFinalizer*: bool

proc gst_video_chroma_resample_free(self: ptr VideoChromaResample00) {.
    importc, libprag.}

proc free*(self: VideoChromaResample) =
  gst_video_chroma_resample_free(cast[ptr VideoChromaResample00](self.impl))

proc finalizerfree*(self: VideoChromaResample) =
  if not self.ignoreFinalizer:
    gst_video_chroma_resample_free(cast[ptr VideoChromaResample00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoChromaResample()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_video_chroma_resample_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var VideoChromaResample) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_video_chroma_resample_get_info(self: ptr VideoChromaResample00;
    nLines: ptr uint32; offset: ptr int32) {.
    importc, libprag.}

proc getInfoVideoChromaResample*(self: VideoChromaResample; nLines: ptr uint32;
    offset: ptr int32) =
  gst_video_chroma_resample_get_info(cast[ptr VideoChromaResample00](self.impl), nLines, offset)

type
  VideoChromaSite* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    jpeg = 1
    hCosited = 2
    vCosited = 4
    cosited = 6
    altLine = 8
    dv = 14

const
  VideoChromaSiteNone* = VideoChromaSite.jpeg
  VideoChromaSiteMpeg2* = VideoChromaSite.hCosited

type
  VideoCodecFrame00* {.pure.} = object
  VideoCodecFrame* = ref object
    impl*: ptr VideoCodecFrame00
    ignoreFinalizer*: bool

proc gst_video_codec_frame_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoCodecFrame*(self: VideoCodecFrame) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_codec_frame_get_type(), cast[ptr VideoCodecFrame00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoCodecFrame()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_codec_frame_get_type(), cast[ptr VideoCodecFrame00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoCodecFrame) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoCodecFrame)

proc gst_video_codec_frame_unref(self: ptr VideoCodecFrame00) {.
    importc, libprag.}

proc unref*(self: VideoCodecFrame) =
  gst_video_codec_frame_unref(cast[ptr VideoCodecFrame00](self.impl))

proc finalizerunref*(self: VideoCodecFrame) =
  if not self.ignoreFinalizer:
    gst_video_codec_frame_unref(cast[ptr VideoCodecFrame00](self.impl))

proc gst_video_codec_frame_ref(self: ptr VideoCodecFrame00): ptr VideoCodecFrame00 {.
    importc, libprag.}

proc `ref`*(self: VideoCodecFrame): VideoCodecFrame =
  fnew(result, gBoxedFreeGstVideoCodecFrame)
  result.impl = gst_video_codec_frame_ref(cast[ptr VideoCodecFrame00](self.impl))

proc gst_video_codec_frame_set_user_data(self: ptr VideoCodecFrame00; userData: pointer;
    notify: DestroyNotify) {.
    importc, libprag.}

proc setUserData*(self: VideoCodecFrame; userData: pointer;
    notify: DestroyNotify) =
  gst_video_codec_frame_set_user_data(cast[ptr VideoCodecFrame00](self.impl), userData, notify)

proc gst_video_codec_frame_get_user_data(self: ptr VideoCodecFrame00): pointer {.
    importc, libprag.}

proc getUserData*(self: VideoCodecFrame): pointer =
  gst_video_codec_frame_get_user_data(cast[ptr VideoCodecFrame00](self.impl))

type
  VideoCodecFrameFlag* {.size: sizeof(cint), pure.} = enum
    decodeOnly = 0
    syncPoint = 1
    forceKeyframe = 2
    forceKeyframeHeaders = 3

  VideoCodecFrameFlags* {.size: sizeof(cint).} = set[VideoCodecFrameFlag]

type
  VideoCodecState00* {.pure.} = object
  VideoCodecState* = ref object
    impl*: ptr VideoCodecState00
    ignoreFinalizer*: bool

proc gst_video_codec_state_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoCodecState*(self: VideoCodecState) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_codec_state_get_type(), cast[ptr VideoCodecState00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoCodecState()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_codec_state_get_type(), cast[ptr VideoCodecState00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoCodecState) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoCodecState)

proc gst_video_codec_state_unref(self: ptr VideoCodecState00) {.
    importc, libprag.}

proc unref*(self: VideoCodecState) =
  gst_video_codec_state_unref(cast[ptr VideoCodecState00](self.impl))

proc finalizerunref*(self: VideoCodecState) =
  if not self.ignoreFinalizer:
    gst_video_codec_state_unref(cast[ptr VideoCodecState00](self.impl))

proc gst_video_codec_state_ref(self: ptr VideoCodecState00): ptr VideoCodecState00 {.
    importc, libprag.}

proc `ref`*(self: VideoCodecState): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_codec_state_ref(cast[ptr VideoCodecState00](self.impl))

type
  VideoColorMatrix* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    rgb = 1
    fcc = 2
    bt709 = 3
    bt601 = 4
    smpte240m = 5
    bt2020 = 6

proc gst_video_color_matrix_from_iso(value: uint32): VideoColorMatrix {.
    importc, libprag.}

proc colorMatrixFromIso*(value: int): VideoColorMatrix =
  gst_video_color_matrix_from_iso(uint32(value))

proc gst_video_color_matrix_get_Kr_Kb(matrix: VideoColorMatrix; Kr: var cdouble;
    Kb: var cdouble): gboolean {.
    importc, libprag.}

proc get_Kr_Kb*(matrix: VideoColorMatrix; Kr: var cdouble;
    Kb: var cdouble): bool =
  toBool(gst_video_color_matrix_get_Kr_Kb(matrix, Kr, Kb))

proc gst_video_color_matrix_to_iso(matrix: VideoColorMatrix): uint32 {.
    importc, libprag.}

proc toIso*(matrix: VideoColorMatrix): int =
  int(gst_video_color_matrix_to_iso(matrix))

type
  VideoColorPrimaries* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    bt709 = 1
    bt470m = 2
    bt470bg = 3
    smpte170m = 4
    smpte240m = 5
    film = 6
    bt2020 = 7
    adobergb = 8
    smptest428 = 9
    smpterp431 = 10
    smpteeg432 = 11
    ebu3213 = 12

proc gst_video_color_primaries_from_iso(value: uint32): VideoColorPrimaries {.
    importc, libprag.}

proc colorPrimariesFromIso*(value: int): VideoColorPrimaries =
  gst_video_color_primaries_from_iso(uint32(value))

proc gst_video_color_primaries_to_iso(primaries: VideoColorPrimaries): uint32 {.
    importc, libprag.}

proc toIso*(primaries: VideoColorPrimaries): int =
  int(gst_video_color_primaries_to_iso(primaries))

type
  VideoColorPrimariesInfo00* {.pure.} = object
  VideoColorPrimariesInfo* = ref object
    impl*: ptr VideoColorPrimariesInfo00
    ignoreFinalizer*: bool

proc gst_video_color_primaries_get_info(primaries: VideoColorPrimaries): ptr VideoColorPrimariesInfo00 {.
    importc, libprag.}

proc getInfoVideoColorPrimaries*(primaries: VideoColorPrimaries): VideoColorPrimariesInfo =
  new(result)
  result.impl = gst_video_color_primaries_get_info(primaries)
  result.ignoreFinalizer = true

proc infoVideoColorPrimaries*(primaries: VideoColorPrimaries): VideoColorPrimariesInfo =
  new(result)
  result.impl = gst_video_color_primaries_get_info(primaries)
  result.ignoreFinalizer = true

type
  VideoColorRange* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    enum0_255 = 1
    enum16_235 = 2

type
  VideoTransferFunction* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    gamma10 = 1
    gamma18 = 2
    gamma20 = 3
    gamma22 = 4
    bt709 = 5
    smpte240m = 6
    srgb = 7
    gamma28 = 8
    log100 = 9
    log316 = 10
    bt2020_12 = 11
    adobergb = 12
    bt2020_10 = 13
    smpte2084 = 14
    aribStdB67 = 15
    bt601 = 16

proc gst_video_transfer_function_from_iso(value: uint32): VideoTransferFunction {.
    importc, libprag.}

proc transferFunctionFromIso*(value: int): VideoTransferFunction =
  gst_video_transfer_function_from_iso(uint32(value))

proc gst_video_transfer_function_is_equivalent(fromFunc: VideoTransferFunction;
    fromBpp: uint32; toFunc: VideoTransferFunction; toBpp: uint32): gboolean {.
    importc, libprag.}

proc isEquivalent*(fromFunc: VideoTransferFunction;
    fromBpp: int; toFunc: VideoTransferFunction; toBpp: int): bool =
  toBool(gst_video_transfer_function_is_equivalent(fromFunc, uint32(fromBpp), toFunc, uint32(toBpp)))

proc gst_video_transfer_function_to_iso(`func`: VideoTransferFunction): uint32 {.
    importc, libprag.}

proc toIso*(`func`: VideoTransferFunction): int =
  int(gst_video_transfer_function_to_iso(`func`))

type
  VideoColorimetry* {.pure, byRef.} = object
    range*: VideoColorRange
    matrix*: VideoColorMatrix
    transfer*: VideoTransferFunction
    primaries*: VideoColorPrimaries

proc gst_video_colorimetry_from_string(self: VideoColorimetry; color: cstring): gboolean {.
    importc, libprag.}

proc fromStringVideoColorimetry*(self: VideoColorimetry; color: cstring): bool =
  toBool(gst_video_colorimetry_from_string(self, color))

proc gst_video_colorimetry_is_equal(self: VideoColorimetry; other: VideoColorimetry): gboolean {.
    importc, libprag.}

proc isEqual*(self: VideoColorimetry; other: VideoColorimetry): bool =
  toBool(gst_video_colorimetry_is_equal(self, other))

proc gst_video_colorimetry_matches(self: VideoColorimetry; color: cstring): gboolean {.
    importc, libprag.}

proc matches*(self: VideoColorimetry; color: cstring): bool =
  toBool(gst_video_colorimetry_matches(self, color))

proc gst_video_colorimetry_to_string(self: VideoColorimetry): cstring {.
    importc, libprag.}

proc toString*(self: VideoColorimetry): string =
  let resul0 = gst_video_colorimetry_to_string(self)
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

type
  VideoContentLightLevel* {.pure, byRef.} = object
    maxContentLightLevel*: uint16
    maxFrameAverageLightLevel*: uint16
    gstReserved*: array[4, pointer]

proc gst_video_content_light_level_add_to_caps(self: VideoContentLightLevel;
    caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc addToCaps*(self: VideoContentLightLevel;
    caps: gst.Caps): bool =
  toBool(gst_video_content_light_level_add_to_caps(self, cast[ptr gst.Caps00](caps.impl)))

proc gst_video_content_light_level_from_caps(self: VideoContentLightLevel;
    caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc fromCaps*(self: VideoContentLightLevel;
    caps: gst.Caps): bool =
  toBool(gst_video_content_light_level_from_caps(self, cast[ptr gst.Caps00](caps.impl)))

proc gst_video_content_light_level_from_string(self: VideoContentLightLevel;
    level: cstring): gboolean {.
    importc, libprag.}

proc fromStringVideoContentLightLevel*(self: VideoContentLightLevel;
    level: cstring): bool =
  toBool(gst_video_content_light_level_from_string(self, level))

proc gst_video_content_light_level_init(self: VideoContentLightLevel) {.
    importc, libprag.}

proc init*(self: VideoContentLightLevel) =
  gst_video_content_light_level_init(self)

proc gst_video_content_light_level_to_string(self: VideoContentLightLevel): cstring {.
    importc, libprag.}

proc toString*(self: VideoContentLightLevel): string =
  let resul0 = gst_video_content_light_level_to_string(self)
  result = $resul0
  cogfree(resul0)

type
  VideoConvertSampleCallback* = proc (sample: ptr gst.Sample00; error: ptr glib.Error; userData: pointer) {.cdecl.}

type
  VideoConverter00* {.pure.} = object
  VideoConverter* = ref object
    impl*: ptr VideoConverter00
    ignoreFinalizer*: bool

proc gst_video_converter_free(self: ptr VideoConverter00) {.
    importc, libprag.}

proc free*(self: VideoConverter) =
  gst_video_converter_free(cast[ptr VideoConverter00](self.impl))

proc finalizerfree*(self: VideoConverter) =
  if not self.ignoreFinalizer:
    gst_video_converter_free(cast[ptr VideoConverter00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoConverter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_video_converter_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var VideoConverter) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_video_converter_frame(self: ptr VideoConverter00; src: VideoFrame;
    dest: VideoFrame) {.
    importc, libprag.}

proc frame*(self: VideoConverter; src: VideoFrame; dest: VideoFrame) =
  gst_video_converter_frame(cast[ptr VideoConverter00](self.impl), src, dest)

proc gst_video_converter_get_config(self: ptr VideoConverter00): ptr gst.Structure00 {.
    importc, libprag.}

proc getConfig*(self: VideoConverter): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_video_converter_get_config(cast[ptr VideoConverter00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc config*(self: VideoConverter): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_video_converter_get_config(cast[ptr VideoConverter00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_video_converter_set_config(self: ptr VideoConverter00; config: ptr gst.Structure00): gboolean {.
    importc, libprag.}

proc setConfig*(self: VideoConverter; config: gst.Structure): bool =
  toBool(gst_video_converter_set_config(cast[ptr VideoConverter00](self.impl), cast[ptr gst.Structure00](g_boxed_copy(gst_structure_get_type(), config.impl))))

type
  VideoCropMeta* {.pure, byRef.} = object
    meta*: gst.Meta00
    x*: uint32
    y*: uint32
    width*: uint32
    height*: uint32

proc gst_video_crop_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoCropMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_crop_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoDecoder* = ref object of gst.Element
  VideoDecoder00* = object of gst.Element00

proc gst_video_decoder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoDecoder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_video_decoder_add_to_frame(self: ptr VideoDecoder00; nBytes: int32) {.
    importc, libprag.}

proc addToFrame*(self: VideoDecoder; nBytes: int) =
  gst_video_decoder_add_to_frame(cast[ptr VideoDecoder00](self.impl), int32(nBytes))

proc gst_video_decoder_allocate_output_buffer(self: ptr VideoDecoder00): ptr gst.Buffer00 {.
    importc, libprag.}

proc allocateOutputBuffer*(self: VideoDecoder): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_decoder_allocate_output_buffer(cast[ptr VideoDecoder00](self.impl))

proc gst_video_decoder_allocate_output_frame(self: ptr VideoDecoder00; frame: ptr VideoCodecFrame00): gst.FlowReturn {.
    importc, libprag.}

proc allocateOutputFrame*(self: VideoDecoder; frame: VideoCodecFrame): gst.FlowReturn =
  gst_video_decoder_allocate_output_frame(cast[ptr VideoDecoder00](self.impl), cast[ptr VideoCodecFrame00](frame.impl))

proc gst_video_decoder_allocate_output_frame_with_params(self: ptr VideoDecoder00;
    frame: ptr VideoCodecFrame00; params: ptr gst.BufferPoolAcquireParams00): gst.FlowReturn {.
    importc, libprag.}

proc allocateOutputFrameWithParams*(self: VideoDecoder;
    frame: VideoCodecFrame; params: gst.BufferPoolAcquireParams): gst.FlowReturn =
  gst_video_decoder_allocate_output_frame_with_params(cast[ptr VideoDecoder00](self.impl), cast[ptr VideoCodecFrame00](frame.impl), cast[ptr gst.BufferPoolAcquireParams00](params.impl))

proc gst_video_decoder_drop_frame(self: ptr VideoDecoder00; frame: ptr VideoCodecFrame00): gst.FlowReturn {.
    importc, libprag.}

proc dropFrame*(self: VideoDecoder; frame: VideoCodecFrame): gst.FlowReturn =
  gst_video_decoder_drop_frame(cast[ptr VideoDecoder00](self.impl), cast[ptr VideoCodecFrame00](g_boxed_copy(gst_video_codec_frame_get_type(), frame.impl)))

proc gst_video_decoder_finish_frame(self: ptr VideoDecoder00; frame: ptr VideoCodecFrame00): gst.FlowReturn {.
    importc, libprag.}

proc finishFrame*(self: VideoDecoder; frame: VideoCodecFrame): gst.FlowReturn =
  gst_video_decoder_finish_frame(cast[ptr VideoDecoder00](self.impl), cast[ptr VideoCodecFrame00](g_boxed_copy(gst_video_codec_frame_get_type(), frame.impl)))

proc gst_video_decoder_get_allocator(self: ptr VideoDecoder00; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: VideoDecoder; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_video_decoder_get_allocator(cast[ptr VideoDecoder00](self.impl), cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstvideo.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_video_decoder_get_buffer_pool(self: ptr VideoDecoder00): ptr gst.BufferPool00 {.
    importc, libprag.}

proc getBufferPool*(self: VideoDecoder): gst.BufferPool =
  let gobj = gst_video_decoder_get_buffer_pool(cast[ptr VideoDecoder00](self.impl))
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

proc bufferPool*(self: VideoDecoder): gst.BufferPool =
  let gobj = gst_video_decoder_get_buffer_pool(cast[ptr VideoDecoder00](self.impl))
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

proc gst_video_decoder_get_estimate_rate(self: ptr VideoDecoder00): int32 {.
    importc, libprag.}

proc getEstimateRate*(self: VideoDecoder): int =
  int(gst_video_decoder_get_estimate_rate(cast[ptr VideoDecoder00](self.impl)))

proc estimateRate*(self: VideoDecoder): int =
  int(gst_video_decoder_get_estimate_rate(cast[ptr VideoDecoder00](self.impl)))

proc gst_video_decoder_get_frame(self: ptr VideoDecoder00; frameNumber: int32): ptr VideoCodecFrame00 {.
    importc, libprag.}

proc getFrame*(self: VideoDecoder; frameNumber: int): VideoCodecFrame =
  fnew(result, gBoxedFreeGstVideoCodecFrame)
  result.impl = gst_video_decoder_get_frame(cast[ptr VideoDecoder00](self.impl), int32(frameNumber))

proc gst_video_decoder_get_frames(self: ptr VideoDecoder00): ptr glib.List {.
    importc, libprag.}

proc getFrames*(self: VideoDecoder): seq[VideoCodecFrame] =
  let resul0 = gst_video_decoder_get_frames(cast[ptr VideoDecoder00](self.impl))
  result = glistStructs2seq[VideoCodecFrame](resul0, false)
  g_list_free(resul0)

proc frames*(self: VideoDecoder): seq[VideoCodecFrame] =
  let resul0 = gst_video_decoder_get_frames(cast[ptr VideoDecoder00](self.impl))
  result = glistStructs2seq[VideoCodecFrame](resul0, false)
  g_list_free(resul0)

proc gst_video_decoder_get_latency(self: ptr VideoDecoder00; minLatency: var uint64;
    maxLatency: var uint64) {.
    importc, libprag.}

proc getLatency*(self: VideoDecoder; minLatency: var uint64 = cast[var uint64](nil);
    maxLatency: var uint64 = cast[var uint64](nil)) =
  gst_video_decoder_get_latency(cast[ptr VideoDecoder00](self.impl), minLatency, maxLatency)

proc gst_video_decoder_get_max_decode_time(self: ptr VideoDecoder00; frame: ptr VideoCodecFrame00): int64 {.
    importc, libprag.}

proc getMaxDecodeTime*(self: VideoDecoder; frame: VideoCodecFrame): int64 =
  gst_video_decoder_get_max_decode_time(cast[ptr VideoDecoder00](self.impl), cast[ptr VideoCodecFrame00](frame.impl))

proc gst_video_decoder_get_max_errors(self: ptr VideoDecoder00): int32 {.
    importc, libprag.}

proc getMaxErrors*(self: VideoDecoder): int =
  int(gst_video_decoder_get_max_errors(cast[ptr VideoDecoder00](self.impl)))

proc maxErrors*(self: VideoDecoder): int =
  int(gst_video_decoder_get_max_errors(cast[ptr VideoDecoder00](self.impl)))

proc gst_video_decoder_get_needs_format(self: ptr VideoDecoder00): gboolean {.
    importc, libprag.}

proc getNeedsFormat*(self: VideoDecoder): bool =
  toBool(gst_video_decoder_get_needs_format(cast[ptr VideoDecoder00](self.impl)))

proc needsFormat*(self: VideoDecoder): bool =
  toBool(gst_video_decoder_get_needs_format(cast[ptr VideoDecoder00](self.impl)))

proc gst_video_decoder_get_oldest_frame(self: ptr VideoDecoder00): ptr VideoCodecFrame00 {.
    importc, libprag.}

proc getOldestFrame*(self: VideoDecoder): VideoCodecFrame =
  fnew(result, gBoxedFreeGstVideoCodecFrame)
  result.impl = gst_video_decoder_get_oldest_frame(cast[ptr VideoDecoder00](self.impl))

proc oldestFrame*(self: VideoDecoder): VideoCodecFrame =
  fnew(result, gBoxedFreeGstVideoCodecFrame)
  result.impl = gst_video_decoder_get_oldest_frame(cast[ptr VideoDecoder00](self.impl))

proc gst_video_decoder_get_output_state(self: ptr VideoDecoder00): ptr VideoCodecState00 {.
    importc, libprag.}

proc getOutputState*(self: VideoDecoder): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_decoder_get_output_state(cast[ptr VideoDecoder00](self.impl))

proc outputState*(self: VideoDecoder): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_decoder_get_output_state(cast[ptr VideoDecoder00](self.impl))

proc gst_video_decoder_get_packetized(self: ptr VideoDecoder00): gboolean {.
    importc, libprag.}

proc getPacketized*(self: VideoDecoder): bool =
  toBool(gst_video_decoder_get_packetized(cast[ptr VideoDecoder00](self.impl)))

proc packetized*(self: VideoDecoder): bool =
  toBool(gst_video_decoder_get_packetized(cast[ptr VideoDecoder00](self.impl)))

proc gst_video_decoder_get_pending_frame_size(self: ptr VideoDecoder00): uint64 {.
    importc, libprag.}

proc getPendingFrameSize*(self: VideoDecoder): uint64 =
  gst_video_decoder_get_pending_frame_size(cast[ptr VideoDecoder00](self.impl))

proc pendingFrameSize*(self: VideoDecoder): uint64 =
  gst_video_decoder_get_pending_frame_size(cast[ptr VideoDecoder00](self.impl))

proc gst_video_decoder_get_qos_proportion(self: ptr VideoDecoder00): cdouble {.
    importc, libprag.}

proc getQosProportion*(self: VideoDecoder): cdouble =
  gst_video_decoder_get_qos_proportion(cast[ptr VideoDecoder00](self.impl))

proc qosProportion*(self: VideoDecoder): cdouble =
  gst_video_decoder_get_qos_proportion(cast[ptr VideoDecoder00](self.impl))

proc gst_video_decoder_have_frame(self: ptr VideoDecoder00): gst.FlowReturn {.
    importc, libprag.}

proc haveFrame*(self: VideoDecoder): gst.FlowReturn =
  gst_video_decoder_have_frame(cast[ptr VideoDecoder00](self.impl))

proc gst_video_decoder_merge_tags(self: ptr VideoDecoder00; tags: ptr gst.TagList00;
    mode: gst.TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: VideoDecoder; tags: gst.TagList = nil;
    mode: gst.TagMergeMode) =
  gst_video_decoder_merge_tags(cast[ptr VideoDecoder00](self.impl), if tags.isNil: nil else: cast[ptr gst.TagList00](tags.impl), mode)

proc gst_video_decoder_negotiate(self: ptr VideoDecoder00): gboolean {.
    importc, libprag.}

proc negotiate*(self: VideoDecoder): bool =
  toBool(gst_video_decoder_negotiate(cast[ptr VideoDecoder00](self.impl)))

proc gst_video_decoder_proxy_getcaps(self: ptr VideoDecoder00; caps: ptr gst.Caps00;
    filter: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc proxyGetcaps*(self: VideoDecoder; caps: gst.Caps = nil;
    filter: gst.Caps = nil): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_video_decoder_proxy_getcaps(cast[ptr VideoDecoder00](self.impl), if caps.isNil: nil else: cast[ptr gst.Caps00](caps.impl), if filter.isNil: nil else: cast[ptr gst.Caps00](filter.impl))

proc gst_video_decoder_release_frame(self: ptr VideoDecoder00; frame: ptr VideoCodecFrame00) {.
    importc, libprag.}

proc releaseFrame*(self: VideoDecoder; frame: VideoCodecFrame) =
  gst_video_decoder_release_frame(cast[ptr VideoDecoder00](self.impl), cast[ptr VideoCodecFrame00](g_boxed_copy(gst_video_codec_frame_get_type(), frame.impl)))

proc gst_video_decoder_set_estimate_rate(self: ptr VideoDecoder00; enabled: gboolean) {.
    importc, libprag.}

proc setEstimateRate*(self: VideoDecoder; enabled: bool = true) =
  gst_video_decoder_set_estimate_rate(cast[ptr VideoDecoder00](self.impl), gboolean(enabled))

proc `estimateRate=`*(self: VideoDecoder; enabled: bool) =
  gst_video_decoder_set_estimate_rate(cast[ptr VideoDecoder00](self.impl), gboolean(enabled))

proc gst_video_decoder_set_interlaced_output_state(self: ptr VideoDecoder00;
    fmt: VideoFormat; interlaceMode: VideoInterlaceMode; width: uint32; height: uint32;
    reference: ptr VideoCodecState00): ptr VideoCodecState00 {.
    importc, libprag.}

proc setInterlacedOutputState*(self: VideoDecoder; fmt: VideoFormat;
    interlaceMode: VideoInterlaceMode; width: int; height: int; reference: VideoCodecState = nil): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_decoder_set_interlaced_output_state(cast[ptr VideoDecoder00](self.impl), fmt, interlaceMode, uint32(width), uint32(height), if reference.isNil: nil else: cast[ptr VideoCodecState00](reference.impl))

proc gst_video_decoder_set_latency(self: ptr VideoDecoder00; minLatency: uint64;
    maxLatency: uint64) {.
    importc, libprag.}

proc setLatency*(self: VideoDecoder; minLatency: uint64;
    maxLatency: uint64) =
  gst_video_decoder_set_latency(cast[ptr VideoDecoder00](self.impl), minLatency, maxLatency)

proc gst_video_decoder_set_max_errors(self: ptr VideoDecoder00; num: int32) {.
    importc, libprag.}

proc setMaxErrors*(self: VideoDecoder; num: int) =
  gst_video_decoder_set_max_errors(cast[ptr VideoDecoder00](self.impl), int32(num))

proc `maxErrors=`*(self: VideoDecoder; num: int) =
  gst_video_decoder_set_max_errors(cast[ptr VideoDecoder00](self.impl), int32(num))

proc gst_video_decoder_set_needs_format(self: ptr VideoDecoder00; enabled: gboolean) {.
    importc, libprag.}

proc setNeedsFormat*(self: VideoDecoder; enabled: bool = true) =
  gst_video_decoder_set_needs_format(cast[ptr VideoDecoder00](self.impl), gboolean(enabled))

proc `needsFormat=`*(self: VideoDecoder; enabled: bool) =
  gst_video_decoder_set_needs_format(cast[ptr VideoDecoder00](self.impl), gboolean(enabled))

proc gst_video_decoder_set_output_state(self: ptr VideoDecoder00; fmt: VideoFormat;
    width: uint32; height: uint32; reference: ptr VideoCodecState00): ptr VideoCodecState00 {.
    importc, libprag.}

proc setOutputState*(self: VideoDecoder; fmt: VideoFormat;
    width: int; height: int; reference: VideoCodecState = nil): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_decoder_set_output_state(cast[ptr VideoDecoder00](self.impl), fmt, uint32(width), uint32(height), if reference.isNil: nil else: cast[ptr VideoCodecState00](reference.impl))

proc gst_video_decoder_set_packetized(self: ptr VideoDecoder00; packetized: gboolean) {.
    importc, libprag.}

proc setPacketized*(self: VideoDecoder; packetized: bool = true) =
  gst_video_decoder_set_packetized(cast[ptr VideoDecoder00](self.impl), gboolean(packetized))

proc `packetized=`*(self: VideoDecoder; packetized: bool) =
  gst_video_decoder_set_packetized(cast[ptr VideoDecoder00](self.impl), gboolean(packetized))

proc gst_video_decoder_set_use_default_pad_acceptcaps(self: ptr VideoDecoder00;
    use: gboolean) {.
    importc, libprag.}

proc setUseDefaultPadAcceptcaps*(self: VideoDecoder;
    use: bool = true) =
  gst_video_decoder_set_use_default_pad_acceptcaps(cast[ptr VideoDecoder00](self.impl), gboolean(use))

proc `useDefaultPadAcceptcaps=`*(self: VideoDecoder;
    use: bool) =
  gst_video_decoder_set_use_default_pad_acceptcaps(cast[ptr VideoDecoder00](self.impl), gboolean(use))

type
  VideoDirection00* = object of gobject.Object00
  VideoDirection* = ref object of gobject.Object

type
  VideoDither00* {.pure.} = object
  VideoDither* = ref object
    impl*: ptr VideoDither00
    ignoreFinalizer*: bool

proc gst_video_dither_free(self: ptr VideoDither00) {.
    importc, libprag.}

proc free*(self: VideoDither) =
  gst_video_dither_free(cast[ptr VideoDither00](self.impl))

proc finalizerfree*(self: VideoDither) =
  if not self.ignoreFinalizer:
    gst_video_dither_free(cast[ptr VideoDither00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoDither()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_video_dither_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var VideoDither) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_video_dither_line(self: ptr VideoDither00; line: pointer; x: uint32;
    y: uint32; width: uint32) {.
    importc, libprag.}

proc line*(self: VideoDither; line: pointer; x: int; y: int;
    width: int) =
  gst_video_dither_line(cast[ptr VideoDither00](self.impl), line, uint32(x), uint32(y), uint32(width))

type
  VideoDitherFlag* {.size: sizeof(cint), pure.} = enum
    interlaced = 0
    quantize = 1

  VideoDitherFlags* {.size: sizeof(cint).} = set[VideoDitherFlag]

const
  VideoDitherFlagsNone* = VideoDitherFlags({})
proc none*(t: typedesc[VideoDitherFlags]): VideoDitherFlags = VideoDitherFlags({})

type
  VideoDitherMethod* {.size: sizeof(cint), pure.} = enum
    none = 0
    verterr = 1
    floydSteinberg = 2
    sierraLite = 3
    bayer = 4

type
  VideoEncoder* = ref object of gst.Element
  VideoEncoder00* = object of gst.Element00

proc gst_video_encoder_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoEncoder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_video_encoder_allocate_output_buffer(self: ptr VideoEncoder00; size: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc allocateOutputBuffer*(self: VideoEncoder; size: uint64): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_encoder_allocate_output_buffer(cast[ptr VideoEncoder00](self.impl), size)

proc gst_video_encoder_allocate_output_frame(self: ptr VideoEncoder00; frame: ptr VideoCodecFrame00;
    size: uint64): gst.FlowReturn {.
    importc, libprag.}

proc allocateOutputFrame*(self: VideoEncoder; frame: VideoCodecFrame;
    size: uint64): gst.FlowReturn =
  gst_video_encoder_allocate_output_frame(cast[ptr VideoEncoder00](self.impl), cast[ptr VideoCodecFrame00](frame.impl), size)

proc gst_video_encoder_finish_frame(self: ptr VideoEncoder00; frame: ptr VideoCodecFrame00): gst.FlowReturn {.
    importc, libprag.}

proc finishFrame*(self: VideoEncoder; frame: VideoCodecFrame): gst.FlowReturn =
  gst_video_encoder_finish_frame(cast[ptr VideoEncoder00](self.impl), cast[ptr VideoCodecFrame00](g_boxed_copy(gst_video_codec_frame_get_type(), frame.impl)))

proc gst_video_encoder_finish_subframe(self: ptr VideoEncoder00; frame: ptr VideoCodecFrame00): gst.FlowReturn {.
    importc, libprag.}

proc finishSubframe*(self: VideoEncoder; frame: VideoCodecFrame): gst.FlowReturn =
  gst_video_encoder_finish_subframe(cast[ptr VideoEncoder00](self.impl), cast[ptr VideoCodecFrame00](frame.impl))

proc gst_video_encoder_get_allocator(self: ptr VideoEncoder00; allocator: var ptr gst.Allocator00;
    params: var gst.AllocationParams00) {.
    importc, libprag.}

proc getAllocator*(self: VideoEncoder; allocator: var gst.Allocator = cast[var gst.Allocator](nil);
    params: var gst.AllocationParams00 = cast[var gst.AllocationParams00](nil)) =
  var tmpoutgobjectarg: ptr gst.Allocator00
  gst_video_encoder_get_allocator(cast[ptr VideoEncoder00](self.impl), cast[var ptr gst.Allocator00](if addr(allocator) == nil: nil else: addr tmpoutgobjectarg), params)
#  dothemagic(allocator
  if addr(allocator) != nil:
    allocator = nil

  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      allocator = cast[type(allocator)](argqdata)
      assert(allocator.impl == tmpoutgobjectarg)
    else:
      fnew(allocator, gstvideo.finalizeGObject)
      allocator.impl = tmpoutgobjectarg
      GC_ref(allocator)
      if g_object_is_floating(allocator.impl).int != 0:
        discard g_object_ref_sink(allocator.impl)
      g_object_add_toggle_ref(allocator.impl, toggleNotify, addr(allocator[]))
      g_object_unref(allocator.impl)
      assert(g_object_get_qdata(allocator.impl, Quark) == nil)
      g_object_set_qdata(allocator.impl, Quark, addr(allocator[]))


proc gst_video_encoder_get_frame(self: ptr VideoEncoder00; frameNumber: int32): ptr VideoCodecFrame00 {.
    importc, libprag.}

proc getFrame*(self: VideoEncoder; frameNumber: int): VideoCodecFrame =
  fnew(result, gBoxedFreeGstVideoCodecFrame)
  result.impl = gst_video_encoder_get_frame(cast[ptr VideoEncoder00](self.impl), int32(frameNumber))

proc gst_video_encoder_get_frames(self: ptr VideoEncoder00): ptr glib.List {.
    importc, libprag.}

proc getFrames*(self: VideoEncoder): seq[VideoCodecFrame] =
  let resul0 = gst_video_encoder_get_frames(cast[ptr VideoEncoder00](self.impl))
  result = glistStructs2seq[VideoCodecFrame](resul0, false)
  g_list_free(resul0)

proc frames*(self: VideoEncoder): seq[VideoCodecFrame] =
  let resul0 = gst_video_encoder_get_frames(cast[ptr VideoEncoder00](self.impl))
  result = glistStructs2seq[VideoCodecFrame](resul0, false)
  g_list_free(resul0)

proc gst_video_encoder_get_latency(self: ptr VideoEncoder00; minLatency: var uint64;
    maxLatency: var uint64) {.
    importc, libprag.}

proc getLatency*(self: VideoEncoder; minLatency: var uint64 = cast[var uint64](nil);
    maxLatency: var uint64 = cast[var uint64](nil)) =
  gst_video_encoder_get_latency(cast[ptr VideoEncoder00](self.impl), minLatency, maxLatency)

proc gst_video_encoder_get_max_encode_time(self: ptr VideoEncoder00; frame: ptr VideoCodecFrame00): int64 {.
    importc, libprag.}

proc getMaxEncodeTime*(self: VideoEncoder; frame: VideoCodecFrame): int64 =
  gst_video_encoder_get_max_encode_time(cast[ptr VideoEncoder00](self.impl), cast[ptr VideoCodecFrame00](frame.impl))

proc gst_video_encoder_get_min_force_key_unit_interval(self: ptr VideoEncoder00): uint64 {.
    importc, libprag.}

proc getMinForceKeyUnitInterval*(self: VideoEncoder): uint64 =
  gst_video_encoder_get_min_force_key_unit_interval(cast[ptr VideoEncoder00](self.impl))

proc minForceKeyUnitInterval*(self: VideoEncoder): uint64 =
  gst_video_encoder_get_min_force_key_unit_interval(cast[ptr VideoEncoder00](self.impl))

proc gst_video_encoder_get_oldest_frame(self: ptr VideoEncoder00): ptr VideoCodecFrame00 {.
    importc, libprag.}

proc getOldestFrame*(self: VideoEncoder): VideoCodecFrame =
  fnew(result, gBoxedFreeGstVideoCodecFrame)
  result.impl = gst_video_encoder_get_oldest_frame(cast[ptr VideoEncoder00](self.impl))

proc oldestFrame*(self: VideoEncoder): VideoCodecFrame =
  fnew(result, gBoxedFreeGstVideoCodecFrame)
  result.impl = gst_video_encoder_get_oldest_frame(cast[ptr VideoEncoder00](self.impl))

proc gst_video_encoder_get_output_state(self: ptr VideoEncoder00): ptr VideoCodecState00 {.
    importc, libprag.}

proc getOutputState*(self: VideoEncoder): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_encoder_get_output_state(cast[ptr VideoEncoder00](self.impl))

proc outputState*(self: VideoEncoder): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_encoder_get_output_state(cast[ptr VideoEncoder00](self.impl))

proc gst_video_encoder_is_qos_enabled(self: ptr VideoEncoder00): gboolean {.
    importc, libprag.}

proc isQosEnabled*(self: VideoEncoder): bool =
  toBool(gst_video_encoder_is_qos_enabled(cast[ptr VideoEncoder00](self.impl)))

proc gst_video_encoder_merge_tags(self: ptr VideoEncoder00; tags: ptr gst.TagList00;
    mode: gst.TagMergeMode) {.
    importc, libprag.}

proc mergeTags*(self: VideoEncoder; tags: gst.TagList = nil;
    mode: gst.TagMergeMode) =
  gst_video_encoder_merge_tags(cast[ptr VideoEncoder00](self.impl), if tags.isNil: nil else: cast[ptr gst.TagList00](tags.impl), mode)

proc gst_video_encoder_negotiate(self: ptr VideoEncoder00): gboolean {.
    importc, libprag.}

proc negotiate*(self: VideoEncoder): bool =
  toBool(gst_video_encoder_negotiate(cast[ptr VideoEncoder00](self.impl)))

proc gst_video_encoder_proxy_getcaps(self: ptr VideoEncoder00; caps: ptr gst.Caps00;
    filter: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc proxyGetcaps*(self: VideoEncoder; caps: gst.Caps = nil;
    filter: gst.Caps = nil): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_video_encoder_proxy_getcaps(cast[ptr VideoEncoder00](self.impl), if caps.isNil: nil else: cast[ptr gst.Caps00](caps.impl), if filter.isNil: nil else: cast[ptr gst.Caps00](filter.impl))

proc gst_video_encoder_set_headers(self: ptr VideoEncoder00; headers: ptr glib.List) {.
    importc, libprag.}

proc setHeaders*(self: VideoEncoder; headers: seq[gst.Buffer]) =
  var tempResGL = seq2GList(headers)
  gst_video_encoder_set_headers(cast[ptr VideoEncoder00](self.impl), tempResGL)

proc `headers=`*(self: VideoEncoder; headers: seq[gst.Buffer]) =
  var tempResGL = seq2GList(headers)
  gst_video_encoder_set_headers(cast[ptr VideoEncoder00](self.impl), tempResGL)

proc gst_video_encoder_set_latency(self: ptr VideoEncoder00; minLatency: uint64;
    maxLatency: uint64) {.
    importc, libprag.}

proc setLatency*(self: VideoEncoder; minLatency: uint64;
    maxLatency: uint64) =
  gst_video_encoder_set_latency(cast[ptr VideoEncoder00](self.impl), minLatency, maxLatency)

proc gst_video_encoder_set_min_force_key_unit_interval(self: ptr VideoEncoder00;
    interval: uint64) {.
    importc, libprag.}

proc setMinForceKeyUnitInterval*(self: VideoEncoder;
    interval: uint64) =
  gst_video_encoder_set_min_force_key_unit_interval(cast[ptr VideoEncoder00](self.impl), interval)

proc `minForceKeyUnitInterval=`*(self: VideoEncoder;
    interval: uint64) =
  gst_video_encoder_set_min_force_key_unit_interval(cast[ptr VideoEncoder00](self.impl), interval)

proc gst_video_encoder_set_min_pts(self: ptr VideoEncoder00; minPts: uint64) {.
    importc, libprag.}

proc setMinPts*(self: VideoEncoder; minPts: uint64) =
  gst_video_encoder_set_min_pts(cast[ptr VideoEncoder00](self.impl), minPts)

proc `minPts=`*(self: VideoEncoder; minPts: uint64) =
  gst_video_encoder_set_min_pts(cast[ptr VideoEncoder00](self.impl), minPts)

proc gst_video_encoder_set_output_state(self: ptr VideoEncoder00; caps: ptr gst.Caps00;
    reference: ptr VideoCodecState00): ptr VideoCodecState00 {.
    importc, libprag.}

proc setOutputState*(self: VideoEncoder; caps: gst.Caps;
    reference: VideoCodecState = nil): VideoCodecState =
  fnew(result, gBoxedFreeGstVideoCodecState)
  result.impl = gst_video_encoder_set_output_state(cast[ptr VideoEncoder00](self.impl), cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), caps.impl)), if reference.isNil: nil else: cast[ptr VideoCodecState00](reference.impl))

proc gst_video_encoder_set_qos_enabled(self: ptr VideoEncoder00; enabled: gboolean) {.
    importc, libprag.}

proc setQosEnabled*(self: VideoEncoder; enabled: bool = true) =
  gst_video_encoder_set_qos_enabled(cast[ptr VideoEncoder00](self.impl), gboolean(enabled))

proc `qosEnabled=`*(self: VideoEncoder; enabled: bool) =
  gst_video_encoder_set_qos_enabled(cast[ptr VideoEncoder00](self.impl), gboolean(enabled))

type
  VideoFieldOrder* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    topFieldFirst = 1
    bottomFieldFirst = 2

proc fromStringVideoFieldOrder*(order: cstring): VideoFieldOrder {.
    importc: "gst_video_field_order_from_string", libprag.}

proc gst_video_field_order_to_string(order: VideoFieldOrder): cstring {.
    importc, libprag.}

proc toString*(order: VideoFieldOrder): string =
  result = $gst_video_field_order_to_string(order)

type
  VideoFilter* = ref object of gstbase.BaseTransform
  VideoFilter00* = object of gstbase.BaseTransform00

proc gst_video_filter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoFilter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  VideoFlag* {.size: sizeof(cint), pure.} = enum
    variableFps = 0
    premultipliedAlpha = 1

  VideoFlags* {.size: sizeof(cint).} = set[VideoFlag]

const
  VideoFlagsNone* = VideoFlags({})
proc none*(t: typedesc[VideoFlags]): VideoFlags = VideoFlags({})

type
  VideoPackFlag* {.size: sizeof(cint), pure.} = enum
    truncateRange = 0
    interlaced = 1

  VideoPackFlags* {.size: sizeof(cint).} = set[VideoPackFlag]

const
  VideoPackFlagsNone* = VideoPackFlags({})
proc none*(t: typedesc[VideoPackFlags]): VideoPackFlags = VideoPackFlags({})

type
  VideoTileMode* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    zflipz_2x2 = 65536
    linear = 131072
type

  VideoFormatUnpack* = proc (info: VideoFormatInfo; flags: VideoPackFlags; dest: pointer; data: pointer;
    stride: ptr int32; x: int32; y: int32; width: int32) {.cdecl.}

  VideoFormatPack* = proc (info: VideoFormatInfo; flags: VideoPackFlags; src: pointer; sstride: int32;
    data: pointer; stride: ptr int32; chromaSite: VideoChromaSite; y: int32;
    width: int32) {.cdecl.}

  VideoFormatInfo* {.pure, byRef.} = object
    format*: VideoFormat
    name*: cstring
    description*: cstring
    flags*: VideoFormatFlags
    bits*: uint32
    nComponents*: uint32
    shift*: array[4, uint32]
    depth*: array[4, uint32]
    pixelStride*: array[4, int32]
    nPlanes*: uint32
    plane*: array[4, uint32]
    poffset*: array[4, uint32]
    wSub*: array[4, uint32]
    hSub*: array[4, uint32]
    unpackFormat*: VideoFormat
    unpackFunc*: VideoFormatUnpack
    packLines*: int32
    packFunc*: VideoFormatPack
    tileMode*: VideoTileMode
    tileWs*: uint32
    tileHs*: uint32
    gstReserved*: array[4, pointer]

proc gst_video_format_info_component(self: VideoFormatInfo; plane: uint32;
    components: var int32) {.
    importc, libprag.}

proc component*(self: VideoFormatInfo; plane: int; components: var int) =
  var components_00: int32
  gst_video_format_info_component(self, uint32(plane), components_00)
  if components.addr != nil:
    components = int(components_00)

proc getInfoVideoFormat*(format: VideoFormat): ptr VideoFormatInfo {.
    importc: "gst_video_format_get_info", libprag.}

proc infoVideoFormat*(format: VideoFormat): ptr VideoFormatInfo {.
    importc: "gst_video_format_get_info", libprag.}

proc offsets*(range: VideoColorRange; info: VideoFormatInfo;
    offset: var ptr array[4, int32]; scale: var ptr array[4, int32]) {.
    importc: "gst_video_color_range_offsets", libprag.}

type
  VideoFrameMapFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    noRef = 16
    last = 24

  VideoFrameMapFlags* {.size: sizeof(cint).} = set[VideoFrameMapFlag]

type
  VideoGLTextureOrientation* {.size: sizeof(cint), pure.} = enum
    normalYNormal = 0
    normalYFlip = 1
    flipYNormal = 2
    flipYFlip = 3

type
  VideoGLTextureType* {.size: sizeof(cint), pure.} = enum
    luminance = 0
    luminanceAlpha = 1
    rgb16 = 2
    rgb = 3
    rgba = 4
    r = 5
    rg = 6

type
  VideoGLTextureUploadMeta00* {.pure.} = object
  VideoGLTextureUploadMeta* = ref object
    impl*: ptr VideoGLTextureUploadMeta00
    ignoreFinalizer*: bool

proc gst_video_gl_texture_upload_meta_upload(self: ptr VideoGLTextureUploadMeta00;
    textureId: ptr uint32): gboolean {.
    importc, libprag.}

proc upload*(self: VideoGLTextureUploadMeta;
    textureId: ptr uint32): bool =
  toBool(gst_video_gl_texture_upload_meta_upload(cast[ptr VideoGLTextureUploadMeta00](self.impl), textureId))

proc gst_video_gl_texture_upload_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoGLTextureUploadMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_gl_texture_upload_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoGLTextureUpload* = proc (meta: ptr VideoGLTextureUploadMeta00; textureId: ptr uint32): gboolean {.cdecl.}

type
  VideoGammaMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    remap = 1

type
  VideoMasteringDisplayInfoCoordinates00* {.pure.} = object
  VideoMasteringDisplayInfoCoordinates* = ref object
    impl*: ptr VideoMasteringDisplayInfoCoordinates00
    ignoreFinalizer*: bool

type
  VideoMasteringDisplayInfo* {.pure, byRef.} = object
    displayPrimaries*: array[3, VideoMasteringDisplayInfoCoordinates00]
    whitePoint*: VideoMasteringDisplayInfoCoordinates00
    maxDisplayMasteringLuminance*: uint32
    minDisplayMasteringLuminance*: uint32
    gstReserved*: array[4, pointer]

proc gst_video_mastering_display_info_add_to_caps(self: VideoMasteringDisplayInfo;
    caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc addToCaps*(self: VideoMasteringDisplayInfo;
    caps: gst.Caps): bool =
  toBool(gst_video_mastering_display_info_add_to_caps(self, cast[ptr gst.Caps00](caps.impl)))

proc gst_video_mastering_display_info_from_caps(self: VideoMasteringDisplayInfo;
    caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc fromCaps*(self: VideoMasteringDisplayInfo;
    caps: gst.Caps): bool =
  toBool(gst_video_mastering_display_info_from_caps(self, cast[ptr gst.Caps00](caps.impl)))

proc gst_video_mastering_display_info_init(self: VideoMasteringDisplayInfo) {.
    importc, libprag.}

proc init*(self: VideoMasteringDisplayInfo) =
  gst_video_mastering_display_info_init(self)

proc gst_video_mastering_display_info_is_equal(self: VideoMasteringDisplayInfo;
    other: VideoMasteringDisplayInfo): gboolean {.
    importc, libprag.}

proc isEqual*(self: VideoMasteringDisplayInfo;
    other: VideoMasteringDisplayInfo): bool =
  toBool(gst_video_mastering_display_info_is_equal(self, other))

proc gst_video_mastering_display_info_to_string(self: VideoMasteringDisplayInfo): cstring {.
    importc, libprag.}

proc toString*(self: VideoMasteringDisplayInfo): string =
  let resul0 = gst_video_mastering_display_info_to_string(self)
  result = $resul0
  cogfree(resul0)

proc gst_video_mastering_display_info_from_string(minfo: var VideoMasteringDisplayInfo;
    mastering: cstring): gboolean {.
    importc, libprag.}

proc fromStringVideoMasteringDisplayInfo*(minfo: var VideoMasteringDisplayInfo;
    mastering: cstring): bool =
  toBool(gst_video_mastering_display_info_from_string(minfo, mastering))

type
  VideoMatrixMode* {.size: sizeof(cint), pure.} = enum
    full = 0
    inputOnly = 1
    outputOnly = 2
    none = 3

type
  VideoMeta* {.pure, byRef.} = object
    meta*: gst.Meta00
    buffer*: ptr gst.Buffer00
    flags*: VideoFrameFlags
    format*: VideoFormat
    id*: int32
    width*: uint32
    height*: uint32
    nPlanes*: uint32
    offset*: array[4, uint64]
    stride*: array[4, int32]
    map*: proc(meta: VideoMeta; plane: uint32; info: gst.MapInfo; data: pointer; stride: ptr int32;
    flags: gst.MapFlags): gboolean {.cdecl.}
    unmap*: proc(meta: VideoMeta; plane: uint32; info: gst.MapInfo): gboolean {.cdecl.}
    alignment*: VideoAlignment

proc gst_video_meta_get_plane_height(self: VideoMeta; planeHeight: var ptr array[4, uint32]): gboolean {.
    importc, libprag.}

proc getPlaneHeight*(self: VideoMeta; planeHeight: var ptr array[4, uint32]): bool =
  toBool(gst_video_meta_get_plane_height(self, planeHeight))

proc gst_video_meta_get_plane_size(self: VideoMeta; planeSize: var ptr array[4, uint64]): gboolean {.
    importc, libprag.}

proc getPlaneSize*(self: VideoMeta; planeSize: var ptr array[4, uint64]): bool =
  toBool(gst_video_meta_get_plane_size(self, planeSize))

proc gst_video_meta_map(self: VideoMeta; plane: uint32; info: gst.MapInfo;
    data: var pointer; stride: var int32; flags: gst.MapFlags): gboolean {.
    importc, libprag.}

proc map*(self: VideoMeta; plane: int; info: gst.MapInfo; data: var pointer;
    stride: var int; flags: gst.MapFlags): bool =
  var stride_00: int32
  result = toBool(gst_video_meta_map(self, uint32(plane), info, data, stride_00, flags))
  if stride.addr != nil:
    stride = int(stride_00)

proc gst_video_meta_set_alignment(self: VideoMeta; alignment: VideoAlignment): gboolean {.
    importc, libprag.}

proc setAlignment*(self: VideoMeta; alignment: VideoAlignment): bool =
  toBool(gst_video_meta_set_alignment(self, alignment))

proc gst_video_meta_unmap(self: VideoMeta; plane: uint32; info: gst.MapInfo): gboolean {.
    importc, libprag.}

proc unmap*(self: VideoMeta; plane: int; info: gst.MapInfo): bool =
  toBool(gst_video_meta_unmap(self, uint32(plane), info))

proc gst_video_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoMetaTransform* {.pure, byRef.} = object
    inInfo*: ptr VideoInfo00
    outInfo*: ptr VideoInfo00

proc gst_video_meta_transform_scale_get_quark(): uint32 {.
    importc, libprag.}

proc scaleGetQuark*(): int =
  int(gst_video_meta_transform_scale_get_quark())

type
  VideoMultiviewFlag* {.size: sizeof(cint), pure.} = enum
    rightViewFirst = 0
    leftFlipped = 1
    leftFlopped = 2
    rightFlipped = 3
    rightFlopped = 4
    halfAspect = 14
    mixedMono = 15

  VideoMultiviewFlags* {.size: sizeof(cint).} = set[VideoMultiviewFlag]

const
  VideoMultiviewFlagsNone* = VideoMultiviewFlags({})
proc none*(t: typedesc[VideoMultiviewFlags]): VideoMultiviewFlags = VideoMultiviewFlags({})

type
  VideoMultiviewFlagsSet* = ref object of gst.FlagSet
  VideoMultiviewFlagsSet00* = object of gst.FlagSet00

proc gst_video_multiview_flagset_get_type*(): GType {.importc, libprag.}

type
  VideoMultiviewFramePacking* {.size: sizeof(cint), pure.} = enum
    none = -1
    mono = 0
    left = 1
    right = 2
    sideBySide = 3
    sideBySideQuincunx = 4
    columnInterleaved = 5
    rowInterleaved = 6
    topBottom = 7
    checkerboard = 8

type
  VideoMultiviewMode* {.size: sizeof(cint), pure.} = enum
    none = -1
    mono = 0
    left = 1
    right = 2
    sideBySide = 3
    sideBySideQuincunx = 4
    columnInterleaved = 5
    rowInterleaved = 6
    topBottom = 7
    checkerboard = 8
    frameByFrame = 32
    multiviewFrameByFrame = 33
    separated = 34

proc fromCapsString*(capsMviewMode: cstring): VideoMultiviewMode {.
    importc: "gst_video_multiview_mode_from_caps_string", libprag.}

proc gst_video_multiview_mode_to_caps_string(mviewMode: VideoMultiviewMode): cstring {.
    importc, libprag.}

proc toCapsString*(mviewMode: VideoMultiviewMode): string =
  result = $gst_video_multiview_mode_to_caps_string(mviewMode)

type
  VideoOrientation00* = object of gobject.Object00
  VideoOrientation* = ref object of gobject.Object

proc gst_video_orientation_get_hcenter(self: ptr VideoOrientation00; center: var int32): gboolean {.
    importc, libprag.}

proc getHcenter*(self: VideoOrientation; center: var int): bool =
  var center_00: int32
  result = toBool(gst_video_orientation_get_hcenter(cast[ptr VideoOrientation00](self.impl), center_00))
  if center.addr != nil:
    center = int(center_00)

proc gst_video_orientation_get_hflip(self: ptr VideoOrientation00; flip: var gboolean): gboolean {.
    importc, libprag.}

proc getHflip*(self: VideoOrientation; flip: var bool): bool =
  var flip_00: gboolean
  result = toBool(gst_video_orientation_get_hflip(cast[ptr VideoOrientation00](self.impl), flip_00))
  if flip.addr != nil:
    flip = toBool(flip_00)

proc gst_video_orientation_get_vcenter(self: ptr VideoOrientation00; center: var int32): gboolean {.
    importc, libprag.}

proc getVcenter*(self: VideoOrientation; center: var int): bool =
  var center_00: int32
  result = toBool(gst_video_orientation_get_vcenter(cast[ptr VideoOrientation00](self.impl), center_00))
  if center.addr != nil:
    center = int(center_00)

proc gst_video_orientation_get_vflip(self: ptr VideoOrientation00; flip: var gboolean): gboolean {.
    importc, libprag.}

proc getVflip*(self: VideoOrientation; flip: var bool): bool =
  var flip_00: gboolean
  result = toBool(gst_video_orientation_get_vflip(cast[ptr VideoOrientation00](self.impl), flip_00))
  if flip.addr != nil:
    flip = toBool(flip_00)

proc gst_video_orientation_set_hcenter(self: ptr VideoOrientation00; center: int32): gboolean {.
    importc, libprag.}

proc setHcenter*(self: VideoOrientation; center: int): bool =
  toBool(gst_video_orientation_set_hcenter(cast[ptr VideoOrientation00](self.impl), int32(center)))

proc gst_video_orientation_set_hflip(self: ptr VideoOrientation00; flip: gboolean): gboolean {.
    importc, libprag.}

proc setHflip*(self: VideoOrientation; flip: bool = true): bool =
  toBool(gst_video_orientation_set_hflip(cast[ptr VideoOrientation00](self.impl), gboolean(flip)))

proc gst_video_orientation_set_vcenter(self: ptr VideoOrientation00; center: int32): gboolean {.
    importc, libprag.}

proc setVcenter*(self: VideoOrientation; center: int): bool =
  toBool(gst_video_orientation_set_vcenter(cast[ptr VideoOrientation00](self.impl), int32(center)))

proc gst_video_orientation_set_vflip(self: ptr VideoOrientation00; flip: gboolean): gboolean {.
    importc, libprag.}

proc setVflip*(self: VideoOrientation; flip: bool = true): bool =
  toBool(gst_video_orientation_set_vflip(cast[ptr VideoOrientation00](self.impl), gboolean(flip)))

type
  VideoOrientationMethod* {.size: sizeof(cint), pure.} = enum
    identity = 0
    enum90r = 1
    enum180 = 2
    enum90l = 3
    horiz = 4
    vert = 5
    ulLr = 6
    urLl = 7
    auto = 8
    custom = 9

type
  VideoOverlay00* = object of gobject.Object00
  VideoOverlay* = ref object of gobject.Object

proc gst_video_overlay_install_properties(oclass: ptr gobject.ObjectClass00;
    lastPropId: int32) {.
    importc, libprag.}

proc installProperties*(oclass: gobject.ObjectClass; lastPropId: int) =
  gst_video_overlay_install_properties(cast[ptr gobject.ObjectClass00](oclass.impl), int32(lastPropId))

proc gst_video_overlay_set_property(`object`: ptr gobject.Object00; lastPropId: int32;
    propertyId: uint32; value: gobject.Value): gboolean {.
    importc, libprag.}

proc setProperty*(`object`: gobject.Object; lastPropId: int;
    propertyId: int; value: gobject.Value): bool =
  toBool(gst_video_overlay_set_property(cast[ptr gobject.Object00](`object`.impl), int32(lastPropId), uint32(propertyId), value))

proc gst_video_overlay_expose(self: ptr VideoOverlay00) {.
    importc, libprag.}

proc expose*(self: VideoOverlay) =
  gst_video_overlay_expose(cast[ptr VideoOverlay00](self.impl))

proc gst_video_overlay_got_window_handle(self: ptr VideoOverlay00; handle: uint64) {.
    importc, libprag.}

proc gotWindowHandle*(self: VideoOverlay; handle: uint64) =
  gst_video_overlay_got_window_handle(cast[ptr VideoOverlay00](self.impl), handle)

proc gst_video_overlay_handle_events(self: ptr VideoOverlay00; handleEvents: gboolean) {.
    importc, libprag.}

proc handleEvents*(self: VideoOverlay; handleEvents: bool) =
  gst_video_overlay_handle_events(cast[ptr VideoOverlay00](self.impl), gboolean(handleEvents))

proc gst_video_overlay_prepare_window_handle(self: ptr VideoOverlay00) {.
    importc, libprag.}

proc prepareWindowHandle*(self: VideoOverlay) =
  gst_video_overlay_prepare_window_handle(cast[ptr VideoOverlay00](self.impl))

proc gst_video_overlay_set_render_rectangle(self: ptr VideoOverlay00; x: int32;
    y: int32; width: int32; height: int32): gboolean {.
    importc, libprag.}

proc setRenderRectangle*(self: VideoOverlay; x: int; y: int;
    width: int; height: int): bool =
  toBool(gst_video_overlay_set_render_rectangle(cast[ptr VideoOverlay00](self.impl), int32(x), int32(y), int32(width), int32(height)))

proc gst_video_overlay_set_window_handle(self: ptr VideoOverlay00; handle: uint64) {.
    importc, libprag.}

proc setWindowHandle*(self: VideoOverlay; handle: uint64) =
  gst_video_overlay_set_window_handle(cast[ptr VideoOverlay00](self.impl), handle)

proc `windowHandle=`*(self: VideoOverlay; handle: uint64) =
  gst_video_overlay_set_window_handle(cast[ptr VideoOverlay00](self.impl), handle)

type
  VideoOverlayComposition00* {.pure.} = object
  VideoOverlayComposition* = ref object
    impl*: ptr VideoOverlayComposition00
    ignoreFinalizer*: bool

proc gst_video_overlay_composition_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoOverlayComposition*(self: VideoOverlayComposition) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_overlay_composition_get_type(), cast[ptr VideoOverlayComposition00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoOverlayComposition()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_overlay_composition_get_type(), cast[ptr VideoOverlayComposition00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoOverlayComposition) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoOverlayComposition)

proc gst_video_overlay_composition_blend(self: ptr VideoOverlayComposition00;
    videoBuf: VideoFrame): gboolean {.
    importc, libprag.}

proc blend*(self: VideoOverlayComposition; videoBuf: VideoFrame): bool =
  toBool(gst_video_overlay_composition_blend(cast[ptr VideoOverlayComposition00](self.impl), videoBuf))

proc gst_video_overlay_composition_copy(self: ptr VideoOverlayComposition00): ptr VideoOverlayComposition00 {.
    importc, libprag.}

proc copy*(self: VideoOverlayComposition): VideoOverlayComposition =
  fnew(result, gBoxedFreeGstVideoOverlayComposition)
  result.impl = gst_video_overlay_composition_copy(cast[ptr VideoOverlayComposition00](self.impl))

proc gst_video_overlay_composition_get_seqnum(self: ptr VideoOverlayComposition00): uint32 {.
    importc, libprag.}

proc getSeqnum*(self: VideoOverlayComposition): int =
  int(gst_video_overlay_composition_get_seqnum(cast[ptr VideoOverlayComposition00](self.impl)))

proc seqnum*(self: VideoOverlayComposition): int =
  int(gst_video_overlay_composition_get_seqnum(cast[ptr VideoOverlayComposition00](self.impl)))

proc gst_video_overlay_composition_make_writable(self: ptr VideoOverlayComposition00): ptr VideoOverlayComposition00 {.
    importc, libprag.}

proc makeWritable*(self: VideoOverlayComposition): VideoOverlayComposition =
  fnew(result, gBoxedFreeGstVideoOverlayComposition)
  result.impl = gst_video_overlay_composition_make_writable(cast[ptr VideoOverlayComposition00](g_boxed_copy(gst_video_overlay_composition_get_type(), self.impl)))

proc gst_video_overlay_composition_n_rectangles(self: ptr VideoOverlayComposition00): uint32 {.
    importc, libprag.}

proc nRectangles*(self: VideoOverlayComposition): int =
  int(gst_video_overlay_composition_n_rectangles(cast[ptr VideoOverlayComposition00](self.impl)))

type
  VideoOverlayRectangle00* {.pure.} = object
  VideoOverlayRectangle* = ref object
    impl*: ptr VideoOverlayRectangle00
    ignoreFinalizer*: bool

proc gst_video_overlay_rectangle_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoOverlayRectangle*(self: VideoOverlayRectangle) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_overlay_rectangle_get_type(), cast[ptr VideoOverlayRectangle00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoOverlayRectangle()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_overlay_rectangle_get_type(), cast[ptr VideoOverlayRectangle00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoOverlayRectangle) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoOverlayRectangle)

proc gst_video_overlay_rectangle_copy(self: ptr VideoOverlayRectangle00): ptr VideoOverlayRectangle00 {.
    importc, libprag.}

proc copy*(self: VideoOverlayRectangle): VideoOverlayRectangle =
  fnew(result, gBoxedFreeGstVideoOverlayRectangle)
  result.impl = gst_video_overlay_rectangle_copy(cast[ptr VideoOverlayRectangle00](self.impl))

proc gst_video_overlay_rectangle_get_global_alpha(self: ptr VideoOverlayRectangle00): cfloat {.
    importc, libprag.}

proc getGlobalAlpha*(self: VideoOverlayRectangle): cfloat =
  gst_video_overlay_rectangle_get_global_alpha(cast[ptr VideoOverlayRectangle00](self.impl))

proc globalAlpha*(self: VideoOverlayRectangle): cfloat =
  gst_video_overlay_rectangle_get_global_alpha(cast[ptr VideoOverlayRectangle00](self.impl))

proc gst_video_overlay_rectangle_get_render_rectangle(self: ptr VideoOverlayRectangle00;
    renderX: var int32; renderY: var int32; renderWidth: var uint32; renderHeight: var uint32): gboolean {.
    importc, libprag.}

proc getRenderRectangle*(self: VideoOverlayRectangle;
    renderX: var int = cast[var int](nil); renderY: var int = cast[var int](nil);
    renderWidth: var int = cast[var int](nil); renderHeight: var int = cast[var int](nil)): bool =
  var renderHeight_00: uint32
  var renderY_00: int32
  var renderWidth_00: uint32
  var renderX_00: int32
  result = toBool(gst_video_overlay_rectangle_get_render_rectangle(cast[ptr VideoOverlayRectangle00](self.impl), renderX_00, renderY_00, renderWidth_00, renderHeight_00))
  if renderHeight.addr != nil:
    renderHeight = int(renderHeight_00)
  if renderY.addr != nil:
    renderY = int(renderY_00)
  if renderWidth.addr != nil:
    renderWidth = int(renderWidth_00)
  if renderX.addr != nil:
    renderX = int(renderX_00)

proc gst_video_overlay_rectangle_get_seqnum(self: ptr VideoOverlayRectangle00): uint32 {.
    importc, libprag.}

proc getSeqnum*(self: VideoOverlayRectangle): int =
  int(gst_video_overlay_rectangle_get_seqnum(cast[ptr VideoOverlayRectangle00](self.impl)))

proc seqnum*(self: VideoOverlayRectangle): int =
  int(gst_video_overlay_rectangle_get_seqnum(cast[ptr VideoOverlayRectangle00](self.impl)))

proc gst_video_overlay_rectangle_set_global_alpha(self: ptr VideoOverlayRectangle00;
    globalAlpha: cfloat) {.
    importc, libprag.}

proc setGlobalAlpha*(self: VideoOverlayRectangle;
    globalAlpha: cfloat) =
  gst_video_overlay_rectangle_set_global_alpha(cast[ptr VideoOverlayRectangle00](self.impl), globalAlpha)

proc `globalAlpha=`*(self: VideoOverlayRectangle;
    globalAlpha: cfloat) =
  gst_video_overlay_rectangle_set_global_alpha(cast[ptr VideoOverlayRectangle00](self.impl), globalAlpha)

proc gst_video_overlay_rectangle_set_render_rectangle(self: ptr VideoOverlayRectangle00;
    renderX: int32; renderY: int32; renderWidth: uint32; renderHeight: uint32) {.
    importc, libprag.}

proc setRenderRectangle*(self: VideoOverlayRectangle;
    renderX: int; renderY: int; renderWidth: int; renderHeight: int) =
  gst_video_overlay_rectangle_set_render_rectangle(cast[ptr VideoOverlayRectangle00](self.impl), int32(renderX), int32(renderY), uint32(renderWidth), uint32(renderHeight))

proc gst_video_overlay_composition_new(rectangle: ptr VideoOverlayRectangle00): ptr VideoOverlayComposition00 {.
    importc, libprag.}

proc newVideoOverlayComposition*(rectangle: VideoOverlayRectangle): VideoOverlayComposition =
  fnew(result, gBoxedFreeGstVideoOverlayComposition)
  result.impl = gst_video_overlay_composition_new(cast[ptr VideoOverlayRectangle00](rectangle.impl))

proc newVideoOverlayComposition*(tdesc: typedesc; rectangle: VideoOverlayRectangle): tdesc =
  assert(result is VideoOverlayComposition)
  fnew(result, gBoxedFreeGstVideoOverlayComposition)
  result.impl = gst_video_overlay_composition_new(cast[ptr VideoOverlayRectangle00](rectangle.impl))

proc initVideoOverlayComposition*[T](result: var T; rectangle: VideoOverlayRectangle) {.deprecated.} =
  assert(result is VideoOverlayComposition)
  fnew(result, gBoxedFreeGstVideoOverlayComposition)
  result.impl = gst_video_overlay_composition_new(cast[ptr VideoOverlayRectangle00](rectangle.impl))

proc gst_video_overlay_composition_add_rectangle(self: ptr VideoOverlayComposition00;
    rectangle: ptr VideoOverlayRectangle00) {.
    importc, libprag.}

proc addRectangle*(self: VideoOverlayComposition;
    rectangle: VideoOverlayRectangle) =
  gst_video_overlay_composition_add_rectangle(cast[ptr VideoOverlayComposition00](self.impl), cast[ptr VideoOverlayRectangle00](rectangle.impl))

proc gst_video_overlay_composition_get_rectangle(self: ptr VideoOverlayComposition00;
    n: uint32): ptr VideoOverlayRectangle00 {.
    importc, libprag.}

proc getRectangle*(self: VideoOverlayComposition;
    n: int): VideoOverlayRectangle =
  fnew(result, gBoxedFreeGstVideoOverlayRectangle)
  result.impl = gst_video_overlay_composition_get_rectangle(cast[ptr VideoOverlayComposition00](self.impl), uint32(n))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_video_overlay_rectangle_get_type(), result.impl))

type
  VideoOverlayFormatFlag* {.size: sizeof(cint), pure.} = enum
    premultipliedAlpha = 0
    globalAlpha = 1

  VideoOverlayFormatFlags* {.size: sizeof(cint).} = set[VideoOverlayFormatFlag]

const
  VideoOverlayFormatFlagsNone* = VideoOverlayFormatFlags({})
proc none*(t: typedesc[VideoOverlayFormatFlags]): VideoOverlayFormatFlags = VideoOverlayFormatFlags({})

proc gst_video_overlay_rectangle_new_raw(pixels: ptr gst.Buffer00; renderX: int32;
    renderY: int32; renderWidth: uint32; renderHeight: uint32; flags: VideoOverlayFormatFlags): ptr VideoOverlayRectangle00 {.
    importc, libprag.}

proc newVideoOverlayRectangleRaw*(pixels: gst.Buffer; renderX: int;
    renderY: int; renderWidth: int; renderHeight: int; flags: VideoOverlayFormatFlags): VideoOverlayRectangle =
  fnew(result, gBoxedFreeGstVideoOverlayRectangle)
  result.impl = gst_video_overlay_rectangle_new_raw(cast[ptr gst.Buffer00](pixels.impl), int32(renderX), int32(renderY), uint32(renderWidth), uint32(renderHeight), flags)

proc newVideoOverlayRectangleRaw*(tdesc: typedesc; pixels: gst.Buffer; renderX: int;
    renderY: int; renderWidth: int; renderHeight: int; flags: VideoOverlayFormatFlags): tdesc =
  assert(result is VideoOverlayRectangle)
  fnew(result, gBoxedFreeGstVideoOverlayRectangle)
  result.impl = gst_video_overlay_rectangle_new_raw(cast[ptr gst.Buffer00](pixels.impl), int32(renderX), int32(renderY), uint32(renderWidth), uint32(renderHeight), flags)

proc initVideoOverlayRectangleRaw*[T](result: var T; pixels: gst.Buffer; renderX: int;
    renderY: int; renderWidth: int; renderHeight: int; flags: VideoOverlayFormatFlags) {.deprecated.} =
  assert(result is VideoOverlayRectangle)
  fnew(result, gBoxedFreeGstVideoOverlayRectangle)
  result.impl = gst_video_overlay_rectangle_new_raw(cast[ptr gst.Buffer00](pixels.impl), int32(renderX), int32(renderY), uint32(renderWidth), uint32(renderHeight), flags)

proc gst_video_overlay_rectangle_get_flags(self: ptr VideoOverlayRectangle00): VideoOverlayFormatFlags {.
    importc, libprag.}

proc getFlags*(self: VideoOverlayRectangle): VideoOverlayFormatFlags =
  gst_video_overlay_rectangle_get_flags(cast[ptr VideoOverlayRectangle00](self.impl))

proc flags*(self: VideoOverlayRectangle): VideoOverlayFormatFlags =
  gst_video_overlay_rectangle_get_flags(cast[ptr VideoOverlayRectangle00](self.impl))

proc gst_video_overlay_rectangle_get_pixels_argb(self: ptr VideoOverlayRectangle00;
    flags: VideoOverlayFormatFlags): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPixelsArgb*(self: VideoOverlayRectangle;
    flags: VideoOverlayFormatFlags): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_overlay_rectangle_get_pixels_argb(cast[ptr VideoOverlayRectangle00](self.impl), flags)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

proc gst_video_overlay_rectangle_get_pixels_ayuv(self: ptr VideoOverlayRectangle00;
    flags: VideoOverlayFormatFlags): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPixelsAyuv*(self: VideoOverlayRectangle;
    flags: VideoOverlayFormatFlags): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_overlay_rectangle_get_pixels_ayuv(cast[ptr VideoOverlayRectangle00](self.impl), flags)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

proc gst_video_overlay_rectangle_get_pixels_raw(self: ptr VideoOverlayRectangle00;
    flags: VideoOverlayFormatFlags): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPixelsRaw*(self: VideoOverlayRectangle;
    flags: VideoOverlayFormatFlags): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_overlay_rectangle_get_pixels_raw(cast[ptr VideoOverlayRectangle00](self.impl), flags)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

proc gst_video_overlay_rectangle_get_pixels_unscaled_argb(self: ptr VideoOverlayRectangle00;
    flags: VideoOverlayFormatFlags): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPixelsUnscaledArgb*(self: VideoOverlayRectangle;
    flags: VideoOverlayFormatFlags): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_overlay_rectangle_get_pixels_unscaled_argb(cast[ptr VideoOverlayRectangle00](self.impl), flags)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

proc gst_video_overlay_rectangle_get_pixels_unscaled_ayuv(self: ptr VideoOverlayRectangle00;
    flags: VideoOverlayFormatFlags): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPixelsUnscaledAyuv*(self: VideoOverlayRectangle;
    flags: VideoOverlayFormatFlags): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_overlay_rectangle_get_pixels_unscaled_ayuv(cast[ptr VideoOverlayRectangle00](self.impl), flags)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

proc gst_video_overlay_rectangle_get_pixels_unscaled_raw(self: ptr VideoOverlayRectangle00;
    flags: VideoOverlayFormatFlags): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPixelsUnscaledRaw*(self: VideoOverlayRectangle;
    flags: VideoOverlayFormatFlags): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_video_overlay_rectangle_get_pixels_unscaled_raw(cast[ptr VideoOverlayRectangle00](self.impl), flags)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_buffer_get_type(), result.impl))

type
  VideoOverlayCompositionMeta00* {.pure.} = object
  VideoOverlayCompositionMeta* = ref object
    impl*: ptr VideoOverlayCompositionMeta00
    ignoreFinalizer*: bool

proc gst_video_overlay_composition_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoOverlayCompositionMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_overlay_composition_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoPrimariesMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    mergeOnly = 1
    fast = 2

type
  VideoRectangle* {.pure, byRef.} = object
    x*: int32
    y*: int32
    w*: int32
    h*: int32

type
  VideoRegionOfInterestMeta00* {.pure.} = object
  VideoRegionOfInterestMeta* = ref object
    impl*: ptr VideoRegionOfInterestMeta00
    ignoreFinalizer*: bool

proc gst_video_region_of_interest_meta_add_param(self: ptr VideoRegionOfInterestMeta00;
    s: ptr gst.Structure00) {.
    importc, libprag.}

proc addParam*(self: VideoRegionOfInterestMeta;
    s: gst.Structure) =
  gst_video_region_of_interest_meta_add_param(cast[ptr VideoRegionOfInterestMeta00](self.impl), cast[ptr gst.Structure00](g_boxed_copy(gst_structure_get_type(), s.impl)))

proc gst_video_region_of_interest_meta_get_param(self: ptr VideoRegionOfInterestMeta00;
    name: cstring): ptr gst.Structure00 {.
    importc, libprag.}

proc getParam*(self: VideoRegionOfInterestMeta;
    name: cstring): gst.Structure =
  let impl0 = gst_video_region_of_interest_meta_get_param(cast[ptr VideoRegionOfInterestMeta00](self.impl), name)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), impl0))

proc gst_video_region_of_interest_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoRegionOfInterestMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_region_of_interest_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoResampler* {.pure, byRef.} = object
    inSize*: int32
    outSize*: int32
    maxTaps*: uint32
    nPhases*: uint32
    offset*: ptr uint32
    phase*: ptr uint32
    nTaps*: ptr uint32
    taps*: ptr cdouble
    gstReserved*: array[4, pointer]

proc gst_video_resampler_clear(self: VideoResampler) {.
    importc, libprag.}

proc clear*(self: VideoResampler) =
  gst_video_resampler_clear(self)

type
  VideoResamplerMethod* {.size: sizeof(cint), pure.} = enum
    nearest = 0
    linear = 1
    cubic = 2
    sinc = 3
    lanczos = 4

type
  VideoResamplerFlag* {.size: sizeof(cint), pure.} = enum
    halfTaps = 0

  VideoResamplerFlags* {.size: sizeof(cint).} = set[VideoResamplerFlag]

const
  VideoResamplerFlagsNone* = VideoResamplerFlags({})
proc none*(t: typedesc[VideoResamplerFlags]): VideoResamplerFlags = VideoResamplerFlags({})

proc gst_video_resampler_init(self: VideoResampler; `method`: VideoResamplerMethod;
    flags: VideoResamplerFlags; nPhases: uint32; nTaps: uint32; shift: cdouble;
    inSize: uint32; outSize: uint32; options: ptr gst.Structure00): gboolean {.
    importc, libprag.}

proc init*(self: VideoResampler; `method`: VideoResamplerMethod;
    flags: VideoResamplerFlags; nPhases: int; nTaps: int; shift: cdouble; inSize: int;
    outSize: int; options: gst.Structure): bool =
  toBool(gst_video_resampler_init(self, `method`, flags, uint32(nPhases), uint32(nTaps), shift, uint32(inSize), uint32(outSize), cast[ptr gst.Structure00](options.impl)))

type
  VideoScaler00* {.pure.} = object
  VideoScaler* = ref object
    impl*: ptr VideoScaler00
    ignoreFinalizer*: bool

proc gst_video_scaler_free(self: ptr VideoScaler00) {.
    importc, libprag.}

proc free*(self: VideoScaler) =
  gst_video_scaler_free(cast[ptr VideoScaler00](self.impl))

proc finalizerfree*(self: VideoScaler) =
  if not self.ignoreFinalizer:
    gst_video_scaler_free(cast[ptr VideoScaler00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoScaler()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_video_scaler_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var VideoScaler) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_video_scaler_2d(self: ptr VideoScaler00; vscale: ptr VideoScaler00;
    format: VideoFormat; src: pointer; srcStride: int32; dest: pointer; destStride: int32;
    x: uint32; y: uint32; width: uint32; height: uint32) {.
    importc, libprag.}

proc d2*(self: VideoScaler; vscale: VideoScaler; format: VideoFormat;
    src: pointer; srcStride: int; dest: pointer; destStride: int; x: int; y: int;
    width: int; height: int) =
  gst_video_scaler_2d(cast[ptr VideoScaler00](self.impl), cast[ptr VideoScaler00](vscale.impl), format, src, int32(srcStride), dest, int32(destStride), uint32(x), uint32(y), uint32(width), uint32(height))

proc gst_video_scaler_get_coeff(self: ptr VideoScaler00; outOffset: uint32;
    inOffset: ptr uint32; nTaps: ptr uint32): ptr cdouble {.
    importc, libprag.}

proc getCoeff*(self: VideoScaler; outOffset: int; inOffset: ptr uint32;
    nTaps: ptr uint32): ptr cdouble =
  gst_video_scaler_get_coeff(cast[ptr VideoScaler00](self.impl), uint32(outOffset), inOffset, nTaps)

proc gst_video_scaler_get_max_taps(self: ptr VideoScaler00): uint32 {.
    importc, libprag.}

proc getMaxTaps*(self: VideoScaler): int =
  int(gst_video_scaler_get_max_taps(cast[ptr VideoScaler00](self.impl)))

proc maxTaps*(self: VideoScaler): int =
  int(gst_video_scaler_get_max_taps(cast[ptr VideoScaler00](self.impl)))

proc gst_video_scaler_horizontal(self: ptr VideoScaler00; format: VideoFormat;
    src: pointer; dest: pointer; destOffset: uint32; width: uint32) {.
    importc, libprag.}

proc horizontal*(self: VideoScaler; format: VideoFormat;
    src: pointer; dest: pointer; destOffset: int; width: int) =
  gst_video_scaler_horizontal(cast[ptr VideoScaler00](self.impl), format, src, dest, uint32(destOffset), uint32(width))

proc gst_video_scaler_vertical(self: ptr VideoScaler00; format: VideoFormat;
    srcLines: pointer; dest: pointer; destOffset: uint32; width: uint32) {.
    importc, libprag.}

proc vertical*(self: VideoScaler; format: VideoFormat; srcLines: pointer;
    dest: pointer; destOffset: int; width: int) =
  gst_video_scaler_vertical(cast[ptr VideoScaler00](self.impl), format, srcLines, dest, uint32(destOffset), uint32(width))

type
  VideoScalerFlag* {.size: sizeof(cint), pure.} = enum
    interlaced = 0

  VideoScalerFlags* {.size: sizeof(cint).} = set[VideoScalerFlag]

const
  VideoScalerFlagsNone* = VideoScalerFlags({})
proc none*(t: typedesc[VideoScalerFlags]): VideoScalerFlags = VideoScalerFlags({})

type
  VideoSink* = ref object of gstbase.BaseSink
  VideoSink00* = object of gstbase.BaseSink00

proc gst_video_sink_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoSink()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_video_sink_center_rect(src: VideoRectangle; dst: VideoRectangle;
    resu: VideoRectangle; scaling: gboolean) {.
    importc, libprag.}

proc centerRect*(src: VideoRectangle; dst: VideoRectangle;
    resu: VideoRectangle; scaling: bool) =
  gst_video_sink_center_rect(src, dst, resu, gboolean(scaling))

type
  VideoTileType* {.size: sizeof(cint), pure.} = enum
    indexed = 0

type
  VideoTimeCode00* {.pure.} = object
  VideoTimeCode* = ref object
    impl*: ptr VideoTimeCode00
    ignoreFinalizer*: bool

proc gst_video_time_code_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoTimeCode*(self: VideoTimeCode) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_time_code_get_type(), cast[ptr VideoTimeCode00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoTimeCode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_time_code_get_type(), cast[ptr VideoTimeCode00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoTimeCode) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoTimeCode)

proc gst_video_time_code_free(self: ptr VideoTimeCode00) {.
    importc, libprag.}

proc free*(self: VideoTimeCode) =
  gst_video_time_code_free(cast[ptr VideoTimeCode00](self.impl))

proc finalizerfree*(self: VideoTimeCode) =
  if not self.ignoreFinalizer:
    gst_video_time_code_free(cast[ptr VideoTimeCode00](self.impl))

proc gst_video_time_code_new_empty(): ptr VideoTimeCode00 {.
    importc, libprag.}

proc newVideoTimeCodeEmpty*(): VideoTimeCode =
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_empty()

proc newVideoTimeCodeEmpty*(tdesc: typedesc): tdesc =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_empty()

proc initVideoTimeCodeEmpty*[T](result: var T) {.deprecated.} =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_empty()

proc gst_video_time_code_new_from_string(tcStr: cstring): ptr VideoTimeCode00 {.
    importc, libprag.}

proc newVideoTimeCodeFromString*(tcStr: cstring): VideoTimeCode =
  let impl0 = gst_video_time_code_new_from_string(tcStr)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = impl0

proc newVideoTimeCodeFromString*(tdesc: typedesc; tcStr: cstring): tdesc =
  assert(result is VideoTimeCode)
  let impl0 = gst_video_time_code_new_from_string(tcStr)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = impl0

proc initVideoTimeCodeFromString*[T](result: var T; tcStr: cstring) {.deprecated.} =
  assert(result is VideoTimeCode)
  let impl0 = gst_video_time_code_new_from_string(tcStr)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = impl0

proc gst_video_time_code_add_frames(self: ptr VideoTimeCode00; frames: int64) {.
    importc, libprag.}

proc addFrames*(self: VideoTimeCode; frames: int64) =
  gst_video_time_code_add_frames(cast[ptr VideoTimeCode00](self.impl), frames)

proc gst_video_time_code_clear(self: ptr VideoTimeCode00) {.
    importc, libprag.}

proc clear*(self: VideoTimeCode) =
  gst_video_time_code_clear(cast[ptr VideoTimeCode00](self.impl))

proc gst_video_time_code_compare(self: ptr VideoTimeCode00; tc2: ptr VideoTimeCode00): int32 {.
    importc, libprag.}

proc compare*(self: VideoTimeCode; tc2: VideoTimeCode): int =
  int(gst_video_time_code_compare(cast[ptr VideoTimeCode00](self.impl), cast[ptr VideoTimeCode00](tc2.impl)))

proc gst_video_time_code_copy(self: ptr VideoTimeCode00): ptr VideoTimeCode00 {.
    importc, libprag.}

proc copy*(self: VideoTimeCode): VideoTimeCode =
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_copy(cast[ptr VideoTimeCode00](self.impl))

proc gst_video_time_code_frames_since_daily_jam(self: ptr VideoTimeCode00): uint64 {.
    importc, libprag.}

proc framesSinceDailyJam*(self: VideoTimeCode): uint64 =
  gst_video_time_code_frames_since_daily_jam(cast[ptr VideoTimeCode00](self.impl))

proc gst_video_time_code_increment_frame(self: ptr VideoTimeCode00) {.
    importc, libprag.}

proc incrementFrame*(self: VideoTimeCode) =
  gst_video_time_code_increment_frame(cast[ptr VideoTimeCode00](self.impl))

proc gst_video_time_code_is_valid(self: ptr VideoTimeCode00): gboolean {.
    importc, libprag.}

proc isValid*(self: VideoTimeCode): bool =
  toBool(gst_video_time_code_is_valid(cast[ptr VideoTimeCode00](self.impl)))

proc gst_video_time_code_nsec_since_daily_jam(self: ptr VideoTimeCode00): uint64 {.
    importc, libprag.}

proc nsecSinceDailyJam*(self: VideoTimeCode): uint64 =
  gst_video_time_code_nsec_since_daily_jam(cast[ptr VideoTimeCode00](self.impl))

proc gst_video_time_code_to_date_time(self: ptr VideoTimeCode00): ptr glib.DateTime00 {.
    importc, libprag.}

proc toDateTime*(self: VideoTimeCode): glib.DateTime =
  let impl0 = gst_video_time_code_to_date_time(cast[ptr VideoTimeCode00](self.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGDateTime)
  result.impl = impl0

proc gst_video_time_code_to_string(self: ptr VideoTimeCode00): cstring {.
    importc, libprag.}

proc toString*(self: VideoTimeCode): string =
  let resul0 = gst_video_time_code_to_string(cast[ptr VideoTimeCode00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  VideoTimeCodeInterval00* {.pure.} = object
  VideoTimeCodeInterval* = ref object
    impl*: ptr VideoTimeCodeInterval00
    ignoreFinalizer*: bool

proc gst_video_time_code_interval_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoTimeCodeInterval*(self: VideoTimeCodeInterval) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_time_code_interval_get_type(), cast[ptr VideoTimeCodeInterval00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoTimeCodeInterval()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_time_code_interval_get_type(), cast[ptr VideoTimeCodeInterval00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoTimeCodeInterval) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoTimeCodeInterval)

proc gst_video_time_code_interval_free(self: ptr VideoTimeCodeInterval00) {.
    importc, libprag.}

proc free*(self: VideoTimeCodeInterval) =
  gst_video_time_code_interval_free(cast[ptr VideoTimeCodeInterval00](self.impl))

proc finalizerfree*(self: VideoTimeCodeInterval) =
  if not self.ignoreFinalizer:
    gst_video_time_code_interval_free(cast[ptr VideoTimeCodeInterval00](self.impl))

proc gst_video_time_code_interval_new_from_string(tcInterStr: cstring): ptr VideoTimeCodeInterval00 {.
    importc, libprag.}

proc newVideoTimeCodeIntervalFromString*(tcInterStr: cstring): VideoTimeCodeInterval =
  let impl0 = gst_video_time_code_interval_new_from_string(tcInterStr)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstVideoTimeCodeInterval)
  result.impl = impl0

proc newVideoTimeCodeIntervalFromString*(tdesc: typedesc; tcInterStr: cstring): tdesc =
  assert(result is VideoTimeCodeInterval)
  let impl0 = gst_video_time_code_interval_new_from_string(tcInterStr)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstVideoTimeCodeInterval)
  result.impl = impl0

proc initVideoTimeCodeIntervalFromString*[T](result: var T; tcInterStr: cstring) {.deprecated.} =
  assert(result is VideoTimeCodeInterval)
  let impl0 = gst_video_time_code_interval_new_from_string(tcInterStr)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstVideoTimeCodeInterval)
  result.impl = impl0

proc gst_video_time_code_interval_clear(self: ptr VideoTimeCodeInterval00) {.
    importc, libprag.}

proc clear*(self: VideoTimeCodeInterval) =
  gst_video_time_code_interval_clear(cast[ptr VideoTimeCodeInterval00](self.impl))

proc gst_video_time_code_interval_copy(self: ptr VideoTimeCodeInterval00): ptr VideoTimeCodeInterval00 {.
    importc, libprag.}

proc copy*(self: VideoTimeCodeInterval): VideoTimeCodeInterval =
  fnew(result, gBoxedFreeGstVideoTimeCodeInterval)
  result.impl = gst_video_time_code_interval_copy(cast[ptr VideoTimeCodeInterval00](self.impl))

proc gst_video_time_code_interval_new(hours: uint32; minutes: uint32; seconds: uint32;
    frames: uint32): ptr VideoTimeCodeInterval00 {.
    importc, libprag.}

proc newVideoTimeCodeInterval*(hours: int; minutes: int; seconds: int;
    frames: int): VideoTimeCodeInterval =
  fnew(result, gBoxedFreeGstVideoTimeCodeInterval)
  result.impl = gst_video_time_code_interval_new(uint32(hours), uint32(minutes), uint32(seconds), uint32(frames))

proc newVideoTimeCodeInterval*(tdesc: typedesc; hours: int; minutes: int; seconds: int;
    frames: int): tdesc =
  assert(result is VideoTimeCodeInterval)
  fnew(result, gBoxedFreeGstVideoTimeCodeInterval)
  result.impl = gst_video_time_code_interval_new(uint32(hours), uint32(minutes), uint32(seconds), uint32(frames))

proc initVideoTimeCodeInterval*[T](result: var T; hours: int; minutes: int; seconds: int;
    frames: int) {.deprecated.} =
  assert(result is VideoTimeCodeInterval)
  fnew(result, gBoxedFreeGstVideoTimeCodeInterval)
  result.impl = gst_video_time_code_interval_new(uint32(hours), uint32(minutes), uint32(seconds), uint32(frames))

proc gst_video_time_code_interval_init(self: ptr VideoTimeCodeInterval00;
    hours: uint32; minutes: uint32; seconds: uint32; frames: uint32) {.
    importc, libprag.}

proc init*(self: VideoTimeCodeInterval; hours: int;
    minutes: int; seconds: int; frames: int) =
  gst_video_time_code_interval_init(cast[ptr VideoTimeCodeInterval00](self.impl), uint32(hours), uint32(minutes), uint32(seconds), uint32(frames))

proc gst_video_time_code_add_interval(self: ptr VideoTimeCode00; tcInter: ptr VideoTimeCodeInterval00): ptr VideoTimeCode00 {.
    importc, libprag.}

proc addInterval*(self: VideoTimeCode; tcInter: VideoTimeCodeInterval): VideoTimeCode =
  let impl0 = gst_video_time_code_add_interval(cast[ptr VideoTimeCode00](self.impl), cast[ptr VideoTimeCodeInterval00](tcInter.impl))
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = impl0

type
  VideoTimeCodeFlag* {.size: sizeof(cint), pure.} = enum
    dropFrame = 0
    interlaced = 1

  VideoTimeCodeFlags* {.size: sizeof(cint).} = set[VideoTimeCodeFlag]

const
  VideoTimeCodeFlagsNone* = VideoTimeCodeFlags({})
proc none*(t: typedesc[VideoTimeCodeFlags]): VideoTimeCodeFlags = VideoTimeCodeFlags({})

proc gst_video_time_code_new_from_date_time(fpsN: uint32; fpsD: uint32; dt: ptr glib.DateTime00;
    flags: VideoTimeCodeFlags; fieldCount: uint32): ptr VideoTimeCode00 {.
    importc, libprag.}

proc newVideoTimeCodeFromDateTime*(fpsN: int; fpsD: int; dt: glib.DateTime;
    flags: VideoTimeCodeFlags; fieldCount: int): VideoTimeCode =
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_from_date_time(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount))

proc newVideoTimeCodeFromDateTime*(tdesc: typedesc; fpsN: int; fpsD: int; dt: glib.DateTime;
    flags: VideoTimeCodeFlags; fieldCount: int): tdesc =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_from_date_time(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount))

proc initVideoTimeCodeFromDateTime*[T](result: var T; fpsN: int; fpsD: int; dt: glib.DateTime;
    flags: VideoTimeCodeFlags; fieldCount: int) {.deprecated.} =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_from_date_time(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount))

proc gst_video_time_code_new_from_date_time_full(fpsN: uint32; fpsD: uint32;
    dt: ptr glib.DateTime00; flags: VideoTimeCodeFlags; fieldCount: uint32): ptr VideoTimeCode00 {.
    importc, libprag.}

proc newVideoTimeCodeFromDateTimeFull*(fpsN: int; fpsD: int; dt: glib.DateTime;
    flags: VideoTimeCodeFlags; fieldCount: int): VideoTimeCode =
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_from_date_time_full(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount))

proc newVideoTimeCodeFromDateTimeFull*(tdesc: typedesc; fpsN: int; fpsD: int; dt: glib.DateTime;
    flags: VideoTimeCodeFlags; fieldCount: int): tdesc =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_from_date_time_full(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount))

proc initVideoTimeCodeFromDateTimeFull*[T](result: var T; fpsN: int; fpsD: int; dt: glib.DateTime;
    flags: VideoTimeCodeFlags; fieldCount: int) {.deprecated.} =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new_from_date_time_full(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount))

proc gst_video_time_code_new(fpsN: uint32; fpsD: uint32; latestDailyJam: ptr glib.DateTime00;
    flags: VideoTimeCodeFlags; hours: uint32; minutes: uint32; seconds: uint32;
    frames: uint32; fieldCount: uint32): ptr VideoTimeCode00 {.
    importc, libprag.}

proc newVideoTimeCode*(fpsN: int; fpsD: int; latestDailyJam: glib.DateTime;
    flags: VideoTimeCodeFlags; hours: int; minutes: int; seconds: int; frames: int;
    fieldCount: int): VideoTimeCode =
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](latestDailyJam.impl), flags, uint32(hours), uint32(minutes), uint32(seconds), uint32(frames), uint32(fieldCount))

proc newVideoTimeCode*(tdesc: typedesc; fpsN: int; fpsD: int; latestDailyJam: glib.DateTime;
    flags: VideoTimeCodeFlags; hours: int; minutes: int; seconds: int; frames: int;
    fieldCount: int): tdesc =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](latestDailyJam.impl), flags, uint32(hours), uint32(minutes), uint32(seconds), uint32(frames), uint32(fieldCount))

proc initVideoTimeCode*[T](result: var T; fpsN: int; fpsD: int; latestDailyJam: glib.DateTime;
    flags: VideoTimeCodeFlags; hours: int; minutes: int; seconds: int; frames: int;
    fieldCount: int) {.deprecated.} =
  assert(result is VideoTimeCode)
  fnew(result, gBoxedFreeGstVideoTimeCode)
  result.impl = gst_video_time_code_new(uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](latestDailyJam.impl), flags, uint32(hours), uint32(minutes), uint32(seconds), uint32(frames), uint32(fieldCount))

proc gst_video_time_code_init(self: ptr VideoTimeCode00; fpsN: uint32; fpsD: uint32;
    latestDailyJam: ptr glib.DateTime00; flags: VideoTimeCodeFlags; hours: uint32;
    minutes: uint32; seconds: uint32; frames: uint32; fieldCount: uint32) {.
    importc, libprag.}

proc init*(self: VideoTimeCode; fpsN: int; fpsD: int;
    latestDailyJam: glib.DateTime = nil; flags: VideoTimeCodeFlags; hours: int;
    minutes: int; seconds: int; frames: int; fieldCount: int) =
  gst_video_time_code_init(cast[ptr VideoTimeCode00](self.impl), uint32(fpsN), uint32(fpsD), if latestDailyJam.isNil: nil else: cast[ptr glib.DateTime00](latestDailyJam.impl), flags, uint32(hours), uint32(minutes), uint32(seconds), uint32(frames), uint32(fieldCount))

proc gst_video_time_code_init_from_date_time(self: ptr VideoTimeCode00; fpsN: uint32;
    fpsD: uint32; dt: ptr glib.DateTime00; flags: VideoTimeCodeFlags; fieldCount: uint32) {.
    importc, libprag.}

proc initFromDateTime*(self: VideoTimeCode; fpsN: int;
    fpsD: int; dt: glib.DateTime; flags: VideoTimeCodeFlags; fieldCount: int) =
  gst_video_time_code_init_from_date_time(cast[ptr VideoTimeCode00](self.impl), uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount))

proc gst_video_time_code_init_from_date_time_full(self: ptr VideoTimeCode00;
    fpsN: uint32; fpsD: uint32; dt: ptr glib.DateTime00; flags: VideoTimeCodeFlags;
    fieldCount: uint32): gboolean {.
    importc, libprag.}

proc initFromDateTimeFull*(self: VideoTimeCode; fpsN: int;
    fpsD: int; dt: glib.DateTime; flags: VideoTimeCodeFlags; fieldCount: int): bool =
  toBool(gst_video_time_code_init_from_date_time_full(cast[ptr VideoTimeCode00](self.impl), uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](dt.impl), flags, uint32(fieldCount)))

type
  VideoTimeCodeConfig* {.pure, byRef.} = object
    fpsN*: uint32
    fpsD*: uint32
    flags*: VideoTimeCodeFlags
    latestDailyJam*: ptr glib.DateTime00

type
  VideoTimeCodeMeta00* {.pure.} = object
  VideoTimeCodeMeta* = ref object
    impl*: ptr VideoTimeCodeMeta00
    ignoreFinalizer*: bool

proc gst_video_time_code_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoVideoTimeCodeMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_video_time_code_meta_get_info()
  result.ignoreFinalizer = true

type
  VideoVBIEncoder00* {.pure.} = object
  VideoVBIEncoder* = ref object
    impl*: ptr VideoVBIEncoder00
    ignoreFinalizer*: bool

proc gst_video_vbi_encoder_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoVBIEncoder*(self: VideoVBIEncoder) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_vbi_encoder_get_type(), cast[ptr VideoVBIEncoder00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoVBIEncoder()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_vbi_encoder_get_type(), cast[ptr VideoVBIEncoder00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoVBIEncoder) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoVBIEncoder)

proc gst_video_vbi_encoder_free(self: ptr VideoVBIEncoder00) {.
    importc, libprag.}

proc free*(self: VideoVBIEncoder) =
  gst_video_vbi_encoder_free(cast[ptr VideoVBIEncoder00](self.impl))

proc finalizerfree*(self: VideoVBIEncoder) =
  if not self.ignoreFinalizer:
    gst_video_vbi_encoder_free(cast[ptr VideoVBIEncoder00](self.impl))

proc gst_video_vbi_encoder_add_ancillary(self: ptr VideoVBIEncoder00; composite: gboolean;
    DID: uint8; SDID_blockNumber: uint8; data: ptr uint8; dataCount: uint32): gboolean {.
    importc, libprag.}

proc addAncillary*(self: VideoVBIEncoder; composite: bool;
    DID: uint8; SDID_blockNumber: uint8; data: seq[uint8] | string): bool =
  let dataCount = int(data.len)
  toBool(gst_video_vbi_encoder_add_ancillary(cast[ptr VideoVBIEncoder00](self.impl), gboolean(composite), DID, SDID_blockNumber, cast[ptr uint8](unsafeaddr(data[0])), uint32(dataCount)))

proc gst_video_vbi_encoder_copy(self: ptr VideoVBIEncoder00): ptr VideoVBIEncoder00 {.
    importc, libprag.}

proc copy*(self: VideoVBIEncoder): VideoVBIEncoder =
  fnew(result, gBoxedFreeGstVideoVBIEncoder)
  result.impl = gst_video_vbi_encoder_copy(cast[ptr VideoVBIEncoder00](self.impl))

proc gst_video_vbi_encoder_new(format: VideoFormat; pixelWidth: uint32): ptr VideoVBIEncoder00 {.
    importc, libprag.}

proc newVideoVBIEncoder*(format: VideoFormat; pixelWidth: int): VideoVBIEncoder =
  fnew(result, gBoxedFreeGstVideoVBIEncoder)
  result.impl = gst_video_vbi_encoder_new(format, uint32(pixelWidth))

proc newVideoVBIEncoder*(tdesc: typedesc; format: VideoFormat; pixelWidth: int): tdesc =
  assert(result is VideoVBIEncoder)
  fnew(result, gBoxedFreeGstVideoVBIEncoder)
  result.impl = gst_video_vbi_encoder_new(format, uint32(pixelWidth))

proc initVideoVBIEncoder*[T](result: var T; format: VideoFormat; pixelWidth: int) {.deprecated.} =
  assert(result is VideoVBIEncoder)
  fnew(result, gBoxedFreeGstVideoVBIEncoder)
  result.impl = gst_video_vbi_encoder_new(format, uint32(pixelWidth))

proc gst_video_vbi_encoder_write_line(self: ptr VideoVBIEncoder00; data: ptr uint8) {.
    importc, libprag.}

proc writeLine*(self: VideoVBIEncoder; data: ptr uint8) =
  gst_video_vbi_encoder_write_line(cast[ptr VideoVBIEncoder00](self.impl), data)

type
  VideoVBIParser00* {.pure.} = object
  VideoVBIParser* = ref object
    impl*: ptr VideoVBIParser00
    ignoreFinalizer*: bool

proc gst_video_vbi_parser_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstVideoVBIParser*(self: VideoVBIParser) =
  if not self.ignoreFinalizer:
    boxedFree(gst_video_vbi_parser_get_type(), cast[ptr VideoVBIParser00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(VideoVBIParser()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_video_vbi_parser_get_type(), cast[ptr VideoVBIParser00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var VideoVBIParser) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstVideoVBIParser)

proc gst_video_vbi_parser_free(self: ptr VideoVBIParser00) {.
    importc, libprag.}

proc free*(self: VideoVBIParser) =
  gst_video_vbi_parser_free(cast[ptr VideoVBIParser00](self.impl))

proc finalizerfree*(self: VideoVBIParser) =
  if not self.ignoreFinalizer:
    gst_video_vbi_parser_free(cast[ptr VideoVBIParser00](self.impl))

proc gst_video_vbi_parser_add_line(self: ptr VideoVBIParser00; data: ptr uint8) {.
    importc, libprag.}

proc addLine*(self: VideoVBIParser; data: seq[uint8] | string) =
  gst_video_vbi_parser_add_line(cast[ptr VideoVBIParser00](self.impl), cast[ptr uint8](unsafeaddr(data[0])))

proc gst_video_vbi_parser_copy(self: ptr VideoVBIParser00): ptr VideoVBIParser00 {.
    importc, libprag.}

proc copy*(self: VideoVBIParser): VideoVBIParser =
  fnew(result, gBoxedFreeGstVideoVBIParser)
  result.impl = gst_video_vbi_parser_copy(cast[ptr VideoVBIParser00](self.impl))

proc gst_video_vbi_parser_new(format: VideoFormat; pixelWidth: uint32): ptr VideoVBIParser00 {.
    importc, libprag.}

proc newVideoVBIParser*(format: VideoFormat; pixelWidth: int): VideoVBIParser =
  fnew(result, gBoxedFreeGstVideoVBIParser)
  result.impl = gst_video_vbi_parser_new(format, uint32(pixelWidth))

proc newVideoVBIParser*(tdesc: typedesc; format: VideoFormat; pixelWidth: int): tdesc =
  assert(result is VideoVBIParser)
  fnew(result, gBoxedFreeGstVideoVBIParser)
  result.impl = gst_video_vbi_parser_new(format, uint32(pixelWidth))

proc initVideoVBIParser*[T](result: var T; format: VideoFormat; pixelWidth: int) {.deprecated.} =
  assert(result is VideoVBIParser)
  fnew(result, gBoxedFreeGstVideoVBIParser)
  result.impl = gst_video_vbi_parser_new(format, uint32(pixelWidth))

type
  VideoVBIParserResult* {.size: sizeof(cint), pure.} = enum
    done = 0
    ok = 1
    error = 2

proc gst_video_vbi_parser_get_ancillary(self: ptr VideoVBIParser00; anc: var VideoAncillary): VideoVBIParserResult {.
    importc, libprag.}

proc getAncillary*(self: VideoVBIParser; anc: var VideoAncillary): VideoVBIParserResult =
  gst_video_vbi_parser_get_ancillary(cast[ptr VideoVBIParser00](self.impl), anc)

proc gst_buffer_add_video_afd_meta(buffer: ptr gst.Buffer00; field: uint8;
    spec: VideoAFDSpec; afd: VideoAFDValue): ptr VideoAFDMeta00 {.
    importc, libprag.}

proc bufferAddVideoAfdMeta*(buffer: gst.Buffer; field: uint8; spec: VideoAFDSpec;
    afd: VideoAFDValue): VideoAFDMeta =
  new(result)
  result.impl = gst_buffer_add_video_afd_meta(cast[ptr gst.Buffer00](buffer.impl), field, spec, afd)
  result.ignoreFinalizer = true

proc gst_buffer_add_video_affine_transformation_meta(buffer: ptr gst.Buffer00): ptr VideoAffineTransformationMeta00 {.
    importc, libprag.}

proc bufferAddVideoAffineTransformationMeta*(buffer: gst.Buffer): VideoAffineTransformationMeta =
  new(result)
  result.impl = gst_buffer_add_video_affine_transformation_meta(cast[ptr gst.Buffer00](buffer.impl))
  result.ignoreFinalizer = true

proc gst_buffer_add_video_bar_meta(buffer: ptr gst.Buffer00; field: uint8;
    isLetterbox: gboolean; barData1: uint32; barData2: uint32): ptr VideoBarMeta00 {.
    importc, libprag.}

proc bufferAddVideoBarMeta*(buffer: gst.Buffer; field: uint8; isLetterbox: bool;
    barData1: int; barData2: int): VideoBarMeta =
  new(result)
  result.impl = gst_buffer_add_video_bar_meta(cast[ptr gst.Buffer00](buffer.impl), field, gboolean(isLetterbox), uint32(barData1), uint32(barData2))
  result.ignoreFinalizer = true

proc gst_buffer_add_video_caption_meta(buffer: ptr gst.Buffer00; captionType: VideoCaptionType;
    data: ptr uint8; size: uint64): ptr VideoCaptionMeta {.
    importc, libprag.}

proc bufferAddVideoCaptionMeta*(buffer: gst.Buffer; captionType: VideoCaptionType;
    data: seq[uint8] | string): ptr VideoCaptionMeta =
  let size = uint64(data.len)
  gst_buffer_add_video_caption_meta(cast[ptr gst.Buffer00](buffer.impl), captionType, cast[ptr uint8](unsafeaddr(data[0])), size)

proc gst_buffer_add_video_gl_texture_upload_meta(buffer: ptr gst.Buffer00;
    textureOrientation: VideoGLTextureOrientation; nTextures: uint32; textureType: ptr VideoGLTextureType;
    upload: VideoGLTextureUpload; userData: pointer; userDataCopy: BoxedCopyFunc;
    userDataFree: BoxedFreeFunc): ptr VideoGLTextureUploadMeta00 {.
    importc, libprag.}

proc bufferAddVideoGlTextureUploadMeta*(buffer: gst.Buffer; textureOrientation: VideoGLTextureOrientation;
    nTextures: int; textureType: ptr VideoGLTextureType; upload: VideoGLTextureUpload;
    userData: pointer; userDataCopy: BoxedCopyFunc; userDataFree: BoxedFreeFunc): VideoGLTextureUploadMeta =
  new(result)
  result.impl = gst_buffer_add_video_gl_texture_upload_meta(cast[ptr gst.Buffer00](buffer.impl), textureOrientation, uint32(nTextures), textureType, upload, userData, userDataCopy, userDataFree)
  result.ignoreFinalizer = true

proc gst_buffer_add_video_meta(buffer: ptr gst.Buffer00; flags: VideoFrameFlags;
    format: VideoFormat; width: uint32; height: uint32): ptr VideoMeta {.
    importc, libprag.}

proc bufferAddVideoMeta*(buffer: gst.Buffer; flags: VideoFrameFlags;
    format: VideoFormat; width: int; height: int): ptr VideoMeta =
  gst_buffer_add_video_meta(cast[ptr gst.Buffer00](buffer.impl), flags, format, uint32(width), uint32(height))

proc gst_buffer_add_video_meta_full(buffer: ptr gst.Buffer00; flags: VideoFrameFlags;
    format: VideoFormat; width: uint32; height: uint32; nPlanes: uint32; offset: ptr array[4, uint64];
    stride: ptr array[4, int32]): ptr VideoMeta {.
    importc, libprag.}

proc bufferAddVideoMetaFull*(buffer: gst.Buffer; flags: VideoFrameFlags;
    format: VideoFormat; width: int; height: int; nPlanes: int; offset: ptr array[4, uint64];
    stride: ptr array[4, int32]): ptr VideoMeta =
  gst_buffer_add_video_meta_full(cast[ptr gst.Buffer00](buffer.impl), flags, format, uint32(width), uint32(height), uint32(nPlanes), offset, stride)

proc gst_buffer_add_video_overlay_composition_meta(buf: ptr gst.Buffer00;
    comp: ptr VideoOverlayComposition00): ptr VideoOverlayCompositionMeta00 {.
    importc, libprag.}

proc bufferAddVideoOverlayCompositionMeta*(buf: gst.Buffer; comp: VideoOverlayComposition = nil): VideoOverlayCompositionMeta =
  new(result)
  result.impl = gst_buffer_add_video_overlay_composition_meta(cast[ptr gst.Buffer00](buf.impl), if comp.isNil: nil else: cast[ptr VideoOverlayComposition00](comp.impl))
  result.ignoreFinalizer = true

proc gst_buffer_add_video_region_of_interest_meta(buffer: ptr gst.Buffer00;
    roiType: cstring; x: uint32; y: uint32; w: uint32; h: uint32): ptr VideoRegionOfInterestMeta00 {.
    importc, libprag.}

proc bufferAddVideoRegionOfInterestMeta*(buffer: gst.Buffer; roiType: cstring;
    x: int; y: int; w: int; h: int): VideoRegionOfInterestMeta =
  new(result)
  result.impl = gst_buffer_add_video_region_of_interest_meta(cast[ptr gst.Buffer00](buffer.impl), roiType, uint32(x), uint32(y), uint32(w), uint32(h))
  result.ignoreFinalizer = true

proc gst_buffer_add_video_region_of_interest_meta_id(buffer: ptr gst.Buffer00;
    roiType: uint32; x: uint32; y: uint32; w: uint32; h: uint32): ptr VideoRegionOfInterestMeta00 {.
    importc, libprag.}

proc bufferAddVideoRegionOfInterestMetaId*(buffer: gst.Buffer;
    roiType: int; x: int; y: int; w: int; h: int): VideoRegionOfInterestMeta =
  new(result)
  result.impl = gst_buffer_add_video_region_of_interest_meta_id(cast[ptr gst.Buffer00](buffer.impl), uint32(roiType), uint32(x), uint32(y), uint32(w), uint32(h))
  result.ignoreFinalizer = true

proc gst_buffer_add_video_time_code_meta(buffer: ptr gst.Buffer00; tc: ptr VideoTimeCode00): ptr VideoTimeCodeMeta00 {.
    importc, libprag.}

proc bufferAddVideoTimeCodeMeta*(buffer: gst.Buffer; tc: VideoTimeCode): VideoTimeCodeMeta =
  let impl0 = gst_buffer_add_video_time_code_meta(cast[ptr gst.Buffer00](buffer.impl), cast[ptr VideoTimeCode00](tc.impl))
  if impl0.isNil:
    return nil
  new(result)
  result.impl = impl0
  result.ignoreFinalizer = true

proc gst_buffer_add_video_time_code_meta_full(buffer: ptr gst.Buffer00; fpsN: uint32;
    fpsD: uint32; latestDailyJam: ptr glib.DateTime00; flags: VideoTimeCodeFlags;
    hours: uint32; minutes: uint32; seconds: uint32; frames: uint32; fieldCount: uint32): ptr VideoTimeCodeMeta00 {.
    importc, libprag.}

proc bufferAddVideoTimeCodeMetaFull*(buffer: gst.Buffer; fpsN: int;
    fpsD: int; latestDailyJam: glib.DateTime; flags: VideoTimeCodeFlags; hours: int;
    minutes: int; seconds: int; frames: int; fieldCount: int): VideoTimeCodeMeta =
  new(result)
  result.impl = gst_buffer_add_video_time_code_meta_full(cast[ptr gst.Buffer00](buffer.impl), uint32(fpsN), uint32(fpsD), cast[ptr glib.DateTime00](latestDailyJam.impl), flags, uint32(hours), uint32(minutes), uint32(seconds), uint32(frames), uint32(fieldCount))
  result.ignoreFinalizer = true

proc gst_buffer_get_video_meta(buffer: ptr gst.Buffer00): ptr VideoMeta {.
    importc, libprag.}

proc bufferGetVideoMeta*(buffer: gst.Buffer): ptr VideoMeta =
  gst_buffer_get_video_meta(cast[ptr gst.Buffer00](buffer.impl))

proc gst_buffer_get_video_meta_id(buffer: ptr gst.Buffer00; id: int32): ptr VideoMeta {.
    importc, libprag.}

proc bufferGetVideoMetaId*(buffer: gst.Buffer; id: int): ptr VideoMeta =
  gst_buffer_get_video_meta_id(cast[ptr gst.Buffer00](buffer.impl), int32(id))

proc gst_buffer_get_video_region_of_interest_meta_id(buffer: ptr gst.Buffer00;
    id: int32): ptr VideoRegionOfInterestMeta00 {.
    importc, libprag.}

proc bufferGetVideoRegionOfInterestMetaId*(buffer: gst.Buffer;
    id: int): VideoRegionOfInterestMeta =
  new(result)
  result.impl = gst_buffer_get_video_region_of_interest_meta_id(cast[ptr gst.Buffer00](buffer.impl), int32(id))
  result.ignoreFinalizer = true

proc gst_buffer_pool_config_get_video_alignment(config: ptr gst.Structure00;
    align: VideoAlignment): gboolean {.
    importc, libprag.}

proc bufferPoolConfigGetVideoAlignment*(config: gst.Structure; align: VideoAlignment): bool =
  toBool(gst_buffer_pool_config_get_video_alignment(cast[ptr gst.Structure00](config.impl), align))

proc gst_buffer_pool_config_set_video_alignment(config: ptr gst.Structure00;
    align: VideoAlignment) {.
    importc, libprag.}

proc bufferPoolConfigSetVideoAlignment*(config: gst.Structure; align: VideoAlignment) =
  gst_buffer_pool_config_set_video_alignment(cast[ptr gst.Structure00](config.impl), align)

proc gst_is_video_overlay_prepare_window_handle_message(msg: ptr gst.Message00): gboolean {.
    importc, libprag.}

proc isVideoOverlayPrepareWindowHandleMessage*(msg: gst.Message): bool =
  toBool(gst_is_video_overlay_prepare_window_handle_message(cast[ptr gst.Message00](msg.impl)))

proc videoAfdMetaApiGetType*(): GType {.
    importc: "gst_video_afd_meta_api_get_type", libprag.}

proc videoAffineTransformationMetaApiGetType*(): GType {.
    importc: "gst_video_affine_transformation_meta_api_get_type", libprag.}

proc videoBarMetaApiGetType*(): GType {.
    importc: "gst_video_bar_meta_api_get_type", libprag.}

proc gst_video_blend(dest: VideoFrame; src: VideoFrame; x: int32; y: int32;
    globalAlpha: cfloat): gboolean {.
    importc, libprag.}

proc videoBlend*(dest: VideoFrame; src: VideoFrame; x: int; y: int; globalAlpha: cfloat): bool =
  toBool(gst_video_blend(dest, src, int32(x), int32(y), globalAlpha))

proc gst_video_blend_scale_linear_RGBA(src: ptr VideoInfo00; srcBuffer: ptr gst.Buffer00;
    destHeight: int32; destWidth: int32; dest: var VideoInfo00; destBuffer: var ptr gst.Buffer00) {.
    importc, libprag.}

proc videoBlendScaleLinear_RGBA*(src: VideoInfo; srcBuffer: gst.Buffer;
    destHeight: int; destWidth: int; dest: var VideoInfo00; destBuffer: var gst.Buffer) =
  fnew(destBuffer, gBoxedFreeGstBuffer)
  gst_video_blend_scale_linear_RGBA(cast[ptr VideoInfo00](src.impl), cast[ptr gst.Buffer00](srcBuffer.impl), int32(destHeight), int32(destWidth), dest, cast[var ptr gst.Buffer00](addr destBuffer.impl))

proc gst_video_calculate_display_ratio(darN: var uint32; darD: var uint32;
    videoWidth: uint32; videoHeight: uint32; videoParN: uint32; videoParD: uint32;
    displayParN: uint32; displayParD: uint32): gboolean {.
    importc, libprag.}

proc videoCalculateDisplayRatio*(darN: var int; darD: var int; videoWidth: int;
    videoHeight: int; videoParN: int; videoParD: int; displayParN: int; displayParD: int): bool =
  var darD_00: uint32
  var darN_00: uint32
  result = toBool(gst_video_calculate_display_ratio(darN_00, darD_00, uint32(videoWidth), uint32(videoHeight), uint32(videoParN), uint32(videoParD), uint32(displayParN), uint32(displayParD)))
  if darD.addr != nil:
    darD = int(darD_00)
  if darN.addr != nil:
    darN = int(darN_00)

proc videoCaptionMetaApiGetType*(): GType {.
    importc: "gst_video_caption_meta_api_get_type", libprag.}

proc videoChromaFromString*(s: cstring): VideoChromaSite {.
    importc: "gst_video_chroma_from_string", libprag.}

proc gst_video_chroma_resample(resample: ptr VideoChromaResample00; lines: pointer;
    width: int32) {.
    importc, libprag.}

proc videoChromaResample*(resample: VideoChromaResample; lines: pointer;
    width: int) =
  gst_video_chroma_resample(cast[ptr VideoChromaResample00](resample.impl), lines, int32(width))

proc gst_video_chroma_to_string(site: VideoChromaSite): cstring {.
    importc, libprag.}

proc videoChromaToString*(site: VideoChromaSite): string =
  result = $gst_video_chroma_to_string(site)

proc videoColorTransferDecode*(`func`: VideoTransferFunction; val: cdouble): cdouble {.
    importc: "gst_video_color_transfer_decode", libprag.}

proc videoColorTransferEncode*(`func`: VideoTransferFunction; val: cdouble): cdouble {.
    importc: "gst_video_color_transfer_encode", libprag.}

proc gst_video_convert_sample(sample: ptr gst.Sample00; toCaps: ptr gst.Caps00;
    timeout: uint64; error: ptr ptr glib.Error = nil): ptr gst.Sample00 {.
    importc, libprag.}

proc videoConvertSample*(sample: gst.Sample; toCaps: gst.Caps; timeout: uint64): gst.Sample =
  var gerror: ptr glib.Error
  let impl0 = gst_video_convert_sample(cast[ptr gst.Sample00](sample.impl), cast[ptr gst.Caps00](toCaps.impl), timeout, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstSample)
  result.impl = impl0

proc gst_video_convert_sample_async(sample: ptr gst.Sample00; toCaps: ptr gst.Caps00;
    timeout: uint64; callback: VideoConvertSampleCallback; userData: pointer;
    destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc videoConvertSampleAsync*(sample: gst.Sample; toCaps: gst.Caps;
    timeout: uint64; callback: VideoConvertSampleCallback; userData: pointer;
    destroyNotify: DestroyNotify) =
  gst_video_convert_sample_async(cast[ptr gst.Sample00](sample.impl), cast[ptr gst.Caps00](toCaps.impl), timeout, callback, userData, destroyNotify)

proc videoCropMetaApiGetType*(): GType {.
    importc: "gst_video_crop_meta_api_get_type", libprag.}

proc gst_video_event_is_force_key_unit(event: ptr gst.Event00): gboolean {.
    importc, libprag.}

proc videoEventIsForceKeyUnit*(event: gst.Event): bool =
  toBool(gst_video_event_is_force_key_unit(cast[ptr gst.Event00](event.impl)))

proc gst_video_event_new_downstream_force_key_unit(timestamp: uint64; streamTime: uint64;
    runningTime: uint64; allHeaders: gboolean; count: uint32): ptr gst.Event00 {.
    importc, libprag.}

proc videoEventNewDownstreamForceKeyUnit*(timestamp: uint64; streamTime: uint64;
    runningTime: uint64; allHeaders: bool; count: int): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_video_event_new_downstream_force_key_unit(timestamp, streamTime, runningTime, gboolean(allHeaders), uint32(count))

proc gst_video_event_new_still_frame(inStill: gboolean): ptr gst.Event00 {.
    importc, libprag.}

proc videoEventNewStillFrame*(inStill: bool): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_video_event_new_still_frame(gboolean(inStill))

proc gst_video_event_new_upstream_force_key_unit(runningTime: uint64; allHeaders: gboolean;
    count: uint32): ptr gst.Event00 {.
    importc, libprag.}

proc videoEventNewUpstreamForceKeyUnit*(runningTime: uint64; allHeaders: bool;
    count: int): gst.Event =
  fnew(result, gBoxedFreeGstEvent)
  result.impl = gst_video_event_new_upstream_force_key_unit(runningTime, gboolean(allHeaders), uint32(count))

proc gst_video_event_parse_downstream_force_key_unit(event: ptr gst.Event00;
    timestamp: var uint64; streamTime: var uint64; runningTime: var uint64;
    allHeaders: var gboolean; count: var uint32): gboolean {.
    importc, libprag.}

proc videoEventParseDownstreamForceKeyUnit*(event: gst.Event; timestamp: var uint64;
    streamTime: var uint64; runningTime: var uint64; allHeaders: var bool;
    count: var int): bool =
  var allHeaders_00: gboolean
  var count_00: uint32
  result = toBool(gst_video_event_parse_downstream_force_key_unit(cast[ptr gst.Event00](event.impl), timestamp, streamTime, runningTime, allHeaders_00, count_00))
  if allHeaders.addr != nil:
    allHeaders = toBool(allHeaders_00)
  if count.addr != nil:
    count = int(count_00)

proc gst_video_event_parse_still_frame(event: ptr gst.Event00; inStill: var gboolean): gboolean {.
    importc, libprag.}

proc videoEventParseStillFrame*(event: gst.Event; inStill: var bool): bool =
  var inStill_00: gboolean
  result = toBool(gst_video_event_parse_still_frame(cast[ptr gst.Event00](event.impl), inStill_00))
  if inStill.addr != nil:
    inStill = toBool(inStill_00)

proc gst_video_event_parse_upstream_force_key_unit(event: ptr gst.Event00;
    runningTime: var uint64; allHeaders: var gboolean; count: var uint32): gboolean {.
    importc, libprag.}

proc videoEventParseUpstreamForceKeyUnit*(event: gst.Event; runningTime: var uint64;
    allHeaders: var bool; count: var int): bool =
  var allHeaders_00: gboolean
  var count_00: uint32
  result = toBool(gst_video_event_parse_upstream_force_key_unit(cast[ptr gst.Event00](event.impl), runningTime, allHeaders_00, count_00))
  if allHeaders.addr != nil:
    allHeaders = toBool(allHeaders_00)
  if count.addr != nil:
    count = int(count_00)

proc gst_video_formats_raw(len: var uint32): ptr VideoFormat {.
    importc, libprag.}

proc videoFormatsRaw*(len: var int): ptr VideoFormat =
  var len_00: uint32
  result = gst_video_formats_raw(len_00)
  if len.addr != nil:
    len = int(len_00)

proc videoGlTextureUploadMetaApiGetType*(): GType {.
    importc: "gst_video_gl_texture_upload_meta_api_get_type", libprag.}

proc gst_video_guess_framerate(duration: uint64; destN: var int32; destD: var int32): gboolean {.
    importc, libprag.}

proc videoGuessFramerate*(duration: uint64; destN: var int = cast[var int](nil);
    destD: var int = cast[var int](nil)): bool =
  var destD_00: int32
  var destN_00: int32
  result = toBool(gst_video_guess_framerate(duration, destN_00, destD_00))
  if destD.addr != nil:
    destD = int(destD_00)
  if destN.addr != nil:
    destN = int(destN_00)

proc gst_video_make_raw_caps(formats: ptr VideoFormat; len: uint32): ptr gst.Caps00 {.
    importc, libprag.}

proc videoMakeRawCaps*(formats: ptr VideoFormat; len: int): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_video_make_raw_caps(formats, uint32(len))

proc gst_video_make_raw_caps_with_features(formats: ptr VideoFormat; len: uint32;
    features: ptr gst.CapsFeatures00): ptr gst.Caps00 {.
    importc, libprag.}

proc videoMakeRawCapsWithFeatures*(formats: ptr VideoFormat; len: int;
    features: gst.CapsFeatures = nil): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_video_make_raw_caps_with_features(formats, uint32(len), if features.isNil: nil else: cast[ptr gst.CapsFeatures00](g_boxed_copy(gst_caps_features_get_type(), features.impl)))

proc videoMetaApiGetType*(): GType {.
    importc: "gst_video_meta_api_get_type", libprag.}

proc videoMultiviewGetDoubledHeightModes*(): ptr gobject.Value {.
    importc: "gst_video_multiview_get_doubled_height_modes", libprag.}

proc videoMultiviewGetDoubledSizeModes*(): ptr gobject.Value {.
    importc: "gst_video_multiview_get_doubled_size_modes", libprag.}

proc videoMultiviewGetDoubledWidthModes*(): ptr gobject.Value {.
    importc: "gst_video_multiview_get_doubled_width_modes", libprag.}

proc videoMultiviewGetMonoModes*(): ptr gobject.Value {.
    importc: "gst_video_multiview_get_mono_modes", libprag.}

proc videoMultiviewGetUnpackedModes*(): ptr gobject.Value {.
    importc: "gst_video_multiview_get_unpacked_modes", libprag.}

proc gst_video_multiview_guess_half_aspect(mvMode: VideoMultiviewMode; width: uint32;
    height: uint32; parN: uint32; parD: uint32): gboolean {.
    importc, libprag.}

proc videoMultiviewGuessHalfAspect*(mvMode: VideoMultiviewMode; width: int;
    height: int; parN: int; parD: int): bool =
  toBool(gst_video_multiview_guess_half_aspect(mvMode, uint32(width), uint32(height), uint32(parN), uint32(parD)))

proc gst_video_multiview_video_info_change_mode(info: ptr VideoInfo00; outMviewMode: VideoMultiviewMode;
    outMviewFlags: VideoMultiviewFlags) {.
    importc, libprag.}

proc videoMultiviewVideoInfoChangeMode*(info: VideoInfo; outMviewMode: VideoMultiviewMode;
    outMviewFlags: VideoMultiviewFlags) =
  gst_video_multiview_video_info_change_mode(cast[ptr VideoInfo00](info.impl), outMviewMode, outMviewFlags)

proc videoOverlayCompositionMetaApiGetType*(): GType {.
    importc: "gst_video_overlay_composition_meta_api_get_type", libprag.}

proc videoRegionOfInterestMetaApiGetType*(): GType {.
    importc: "gst_video_region_of_interest_meta_api_get_type", libprag.}

proc gst_video_tile_get_index(mode: VideoTileMode; x: int32; y: int32; xTiles: int32;
    yTiles: int32): uint32 {.
    importc, libprag.}

proc videoTileGetIndex*(mode: VideoTileMode; x: int; y: int; xTiles: int;
    yTiles: int): int =
  int(gst_video_tile_get_index(mode, int32(x), int32(y), int32(xTiles), int32(yTiles)))

proc videoTimeCodeMetaApiGetType*(): GType {.
    importc: "gst_video_time_code_meta_api_get_type", libprag.}
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc preset*(x: gstvideo.VideoEncoder): gst.Preset = cast[gst.Preset](x)
