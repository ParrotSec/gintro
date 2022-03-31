# dependencies:
# GObject-2.0
# GstBase-1.0
# GstAudio-1.0
# GstVideo-1.0
# Gst-1.0
# GModule-2.0
# GLib-2.0
# immediate dependencies:
# GstVideo-1.0
# GstBase-1.0
# GstAudio-1.0
# Gst-1.0
# libraries:
# libgstpbutils-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gstaudio, gstvideo, gst, gmodule, glib
const Lib = "libgstpbutils-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  AudioVisualizer* = ref object of gst.Element
  AudioVisualizer00* = object of gst.Element00

proc gst_audio_visualizer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AudioVisualizer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  AudioVisualizerShader* {.size: sizeof(cint), pure.} = enum
    none = 0
    fade = 1
    fadeAndMoveUp = 2
    fadeAndMoveDown = 3
    fadeAndMoveLeft = 4
    fadeAndMoveRight = 5
    fadeAndMoveHorizOut = 6
    fadeAndMoveHorizIn = 7
    fadeAndMoveVertOut = 8
    fadeAndMoveVertIn = 9

type
  AudioVisualizerShaderFunc* = proc (scope: ptr AudioVisualizer00; s: gstvideo.VideoFrame; d: gstvideo.VideoFrame) {.cdecl.}

type
  DiscovererInfo* = ref object of gobject.Object
  DiscovererInfo00* = object of gobject.Object00

proc gst_discoverer_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DiscovererInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_discoverer_info_from_variant(variant: ptr glib.Variant00): ptr DiscovererInfo00 {.
    importc, libprag.}

proc fromVariant*(variant: glib.Variant): DiscovererInfo =
  let gobj = gst_discoverer_info_from_variant(cast[ptr glib.Variant00](variant.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_discoverer_info_copy(self: ptr DiscovererInfo00): ptr DiscovererInfo00 {.
    importc, libprag.}

proc copy*(self: DiscovererInfo): DiscovererInfo =
  let gobj = gst_discoverer_info_copy(cast[ptr DiscovererInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_discoverer_info_get_duration(self: ptr DiscovererInfo00): uint64 {.
    importc, libprag.}

proc getDuration*(self: DiscovererInfo): uint64 =
  gst_discoverer_info_get_duration(cast[ptr DiscovererInfo00](self.impl))

proc duration*(self: DiscovererInfo): uint64 =
  gst_discoverer_info_get_duration(cast[ptr DiscovererInfo00](self.impl))

proc gst_discoverer_info_get_live(self: ptr DiscovererInfo00): gboolean {.
    importc, libprag.}

proc getLive*(self: DiscovererInfo): bool =
  toBool(gst_discoverer_info_get_live(cast[ptr DiscovererInfo00](self.impl)))

proc live*(self: DiscovererInfo): bool =
  toBool(gst_discoverer_info_get_live(cast[ptr DiscovererInfo00](self.impl)))

proc gst_discoverer_info_get_misc(self: ptr DiscovererInfo00): ptr gst.Structure00 {.
    importc, libprag.}

proc getMisc*(self: DiscovererInfo): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_discoverer_info_get_misc(cast[ptr DiscovererInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc misc*(self: DiscovererInfo): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_discoverer_info_get_misc(cast[ptr DiscovererInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_discoverer_info_get_missing_elements_installer_details(self: ptr DiscovererInfo00): ptr cstring {.
    importc, libprag.}

proc getMissingElementsInstallerDetails*(self: DiscovererInfo): seq[string] =
  cstringArrayToSeq(gst_discoverer_info_get_missing_elements_installer_details(cast[ptr DiscovererInfo00](self.impl)))

proc missingElementsInstallerDetails*(self: DiscovererInfo): seq[string] =
  cstringArrayToSeq(gst_discoverer_info_get_missing_elements_installer_details(cast[ptr DiscovererInfo00](self.impl)))

proc gst_discoverer_info_get_seekable(self: ptr DiscovererInfo00): gboolean {.
    importc, libprag.}

proc getSeekable*(self: DiscovererInfo): bool =
  toBool(gst_discoverer_info_get_seekable(cast[ptr DiscovererInfo00](self.impl)))

proc seekable*(self: DiscovererInfo): bool =
  toBool(gst_discoverer_info_get_seekable(cast[ptr DiscovererInfo00](self.impl)))

proc gst_discoverer_info_get_tags(self: ptr DiscovererInfo00): ptr gst.TagList00 {.
    importc, libprag.}

proc getTags*(self: DiscovererInfo): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_discoverer_info_get_tags(cast[ptr DiscovererInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc tags*(self: DiscovererInfo): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_discoverer_info_get_tags(cast[ptr DiscovererInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc gst_discoverer_info_get_toc(self: ptr DiscovererInfo00): ptr gst.Toc00 {.
    importc, libprag.}

proc getToc*(self: DiscovererInfo): gst.Toc =
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_discoverer_info_get_toc(cast[ptr DiscovererInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_get_type(), result.impl))

proc toc*(self: DiscovererInfo): gst.Toc =
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_discoverer_info_get_toc(cast[ptr DiscovererInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_get_type(), result.impl))

proc gst_discoverer_info_get_uri(self: ptr DiscovererInfo00): cstring {.
    importc, libprag.}

proc getUri*(self: DiscovererInfo): string =
  result = $gst_discoverer_info_get_uri(cast[ptr DiscovererInfo00](self.impl))

proc uri*(self: DiscovererInfo): string =
  result = $gst_discoverer_info_get_uri(cast[ptr DiscovererInfo00](self.impl))

type
  Discoverer* = ref object of gobject.Object
  Discoverer00* = object of gobject.Object00

proc gst_discoverer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Discoverer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scDiscovered*(self: Discoverer;  p: proc (self: ptr Discoverer00; info: ptr DiscovererInfo00; error: ptr glib.Error; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "discovered", cast[GCallback](p), xdata, nil, cf)

proc scFinished*(self: Discoverer;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "finished", cast[GCallback](p), xdata, nil, cf)

proc scSourceSetup*(self: Discoverer;  p: proc (self: ptr Discoverer00; source: ptr gst.Element00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "source-setup", cast[GCallback](p), xdata, nil, cf)

proc scStarting*(self: Discoverer;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "starting", cast[GCallback](p), xdata, nil, cf)

proc gst_discoverer_new(timeout: uint64; error: ptr ptr glib.Error = nil): ptr Discoverer00 {.
    importc, libprag.}

proc newDiscoverer*(timeout: uint64): Discoverer =
  var gerror: ptr glib.Error
  let gobj = gst_discoverer_new(timeout, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newDiscoverer*(tdesc: typedesc; timeout: uint64): tdesc =
  var gerror: ptr glib.Error
  assert(result is Discoverer)
  let gobj = gst_discoverer_new(timeout, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDiscoverer*[T](result: var T; timeout: uint64) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is Discoverer)
  let gobj = gst_discoverer_new(timeout, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_discoverer_discover_uri(self: ptr Discoverer00; uri: cstring; error: ptr ptr glib.Error = nil): ptr DiscovererInfo00 {.
    importc, libprag.}

proc discoverUri*(self: Discoverer; uri: cstring): DiscovererInfo =
  var gerror: ptr glib.Error
  let gobj = gst_discoverer_discover_uri(cast[ptr Discoverer00](self.impl), uri, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_discoverer_discover_uri_async(self: ptr Discoverer00; uri: cstring): gboolean {.
    importc, libprag.}

proc discoverUriAsync*(self: Discoverer; uri: cstring): bool =
  toBool(gst_discoverer_discover_uri_async(cast[ptr Discoverer00](self.impl), uri))

proc gst_discoverer_start(self: ptr Discoverer00) {.
    importc, libprag.}

proc start*(self: Discoverer) =
  gst_discoverer_start(cast[ptr Discoverer00](self.impl))

proc gst_discoverer_stop(self: ptr Discoverer00) {.
    importc, libprag.}

proc stop*(self: Discoverer) =
  gst_discoverer_stop(cast[ptr Discoverer00](self.impl))

type
  DiscovererResult* {.size: sizeof(cint), pure.} = enum
    ok = 0
    uriInvalid = 1
    error = 2
    timeout = 3
    busy = 4
    missingPlugins = 5

proc gst_discoverer_info_get_result(self: ptr DiscovererInfo00): DiscovererResult {.
    importc, libprag.}

proc getResult*(self: DiscovererInfo): DiscovererResult =
  gst_discoverer_info_get_result(cast[ptr DiscovererInfo00](self.impl))

proc result*(self: DiscovererInfo): DiscovererResult =
  gst_discoverer_info_get_result(cast[ptr DiscovererInfo00](self.impl))

type
  DiscovererStreamInfo* = ref object of gobject.Object
  DiscovererStreamInfo00* = object of gobject.Object00

proc gst_discoverer_stream_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DiscovererStreamInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc listFreeDiscovererStreamInfo*(infos: ptr glib.List) {.
    importc: "gst_discoverer_stream_info_list_free", libprag.}

proc gst_discoverer_stream_info_get_caps(self: ptr DiscovererStreamInfo00): ptr gst.Caps00 {.
    importc, libprag.}

proc getCaps*(self: DiscovererStreamInfo): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_discoverer_stream_info_get_caps(cast[ptr DiscovererStreamInfo00](self.impl))

proc caps*(self: DiscovererStreamInfo): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_discoverer_stream_info_get_caps(cast[ptr DiscovererStreamInfo00](self.impl))

proc gst_discoverer_stream_info_get_misc(self: ptr DiscovererStreamInfo00): ptr gst.Structure00 {.
    importc, libprag.}

proc getMisc*(self: DiscovererStreamInfo): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_discoverer_stream_info_get_misc(cast[ptr DiscovererStreamInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc misc*(self: DiscovererStreamInfo): gst.Structure =
  fnew(result, gBoxedFreeGstStructure)
  result.impl = gst_discoverer_stream_info_get_misc(cast[ptr DiscovererStreamInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_structure_get_type(), result.impl))

proc gst_discoverer_stream_info_get_next(self: ptr DiscovererStreamInfo00): ptr DiscovererStreamInfo00 {.
    importc, libprag.}

proc getNext*(self: DiscovererStreamInfo): DiscovererStreamInfo =
  let gobj = gst_discoverer_stream_info_get_next(cast[ptr DiscovererStreamInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc next*(self: DiscovererStreamInfo): DiscovererStreamInfo =
  let gobj = gst_discoverer_stream_info_get_next(cast[ptr DiscovererStreamInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_discoverer_stream_info_get_previous(self: ptr DiscovererStreamInfo00): ptr DiscovererStreamInfo00 {.
    importc, libprag.}

proc getPrevious*(self: DiscovererStreamInfo): DiscovererStreamInfo =
  let gobj = gst_discoverer_stream_info_get_previous(cast[ptr DiscovererStreamInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc previous*(self: DiscovererStreamInfo): DiscovererStreamInfo =
  let gobj = gst_discoverer_stream_info_get_previous(cast[ptr DiscovererStreamInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_discoverer_stream_info_get_stream_id(self: ptr DiscovererStreamInfo00): cstring {.
    importc, libprag.}

proc getStreamId*(self: DiscovererStreamInfo): string =
  result = $gst_discoverer_stream_info_get_stream_id(cast[ptr DiscovererStreamInfo00](self.impl))

proc streamId*(self: DiscovererStreamInfo): string =
  result = $gst_discoverer_stream_info_get_stream_id(cast[ptr DiscovererStreamInfo00](self.impl))

proc gst_discoverer_stream_info_get_stream_type_nick(self: ptr DiscovererStreamInfo00): cstring {.
    importc, libprag.}

proc getStreamTypeNick*(self: DiscovererStreamInfo): string =
  result = $gst_discoverer_stream_info_get_stream_type_nick(cast[ptr DiscovererStreamInfo00](self.impl))

proc streamTypeNick*(self: DiscovererStreamInfo): string =
  result = $gst_discoverer_stream_info_get_stream_type_nick(cast[ptr DiscovererStreamInfo00](self.impl))

proc gst_discoverer_stream_info_get_tags(self: ptr DiscovererStreamInfo00): ptr gst.TagList00 {.
    importc, libprag.}

proc getTags*(self: DiscovererStreamInfo): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_discoverer_stream_info_get_tags(cast[ptr DiscovererStreamInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc tags*(self: DiscovererStreamInfo): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_discoverer_stream_info_get_tags(cast[ptr DiscovererStreamInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_tag_list_get_type(), result.impl))

proc gst_discoverer_stream_info_get_toc(self: ptr DiscovererStreamInfo00): ptr gst.Toc00 {.
    importc, libprag.}

proc getToc*(self: DiscovererStreamInfo): gst.Toc =
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_discoverer_stream_info_get_toc(cast[ptr DiscovererStreamInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_get_type(), result.impl))

proc toc*(self: DiscovererStreamInfo): gst.Toc =
  fnew(result, gBoxedFreeGstToc)
  result.impl = gst_discoverer_stream_info_get_toc(cast[ptr DiscovererStreamInfo00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_toc_get_type(), result.impl))

proc gst_discoverer_info_get_audio_streams(self: ptr DiscovererInfo00): ptr glib.List {.
    importc, libprag.}

proc getAudioStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_audio_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc audioStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_audio_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc gst_discoverer_info_get_container_streams(self: ptr DiscovererInfo00): ptr glib.List {.
    importc, libprag.}

proc getContainerStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_container_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc containerStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_container_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc gst_discoverer_info_get_stream_info(self: ptr DiscovererInfo00): ptr DiscovererStreamInfo00 {.
    importc, libprag.}

proc getStreamInfo*(self: DiscovererInfo): DiscovererStreamInfo =
  let gobj = gst_discoverer_info_get_stream_info(cast[ptr DiscovererInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc streamInfo*(self: DiscovererInfo): DiscovererStreamInfo =
  let gobj = gst_discoverer_info_get_stream_info(cast[ptr DiscovererInfo00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_discoverer_info_get_stream_list(self: ptr DiscovererInfo00): ptr glib.List {.
    importc, libprag.}

proc getStreamList*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_stream_list(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc streamList*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_stream_list(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc gst_discoverer_info_get_streams(self: ptr DiscovererInfo00; streamtype: GType): ptr glib.List {.
    importc, libprag.}

proc getStreams*(self: DiscovererInfo; streamtype: GType): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_streams(cast[ptr DiscovererInfo00](self.impl), streamtype)
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc gst_discoverer_info_get_subtitle_streams(self: ptr DiscovererInfo00): ptr glib.List {.
    importc, libprag.}

proc getSubtitleStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_subtitle_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc subtitleStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_subtitle_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc gst_discoverer_info_get_video_streams(self: ptr DiscovererInfo00): ptr glib.List {.
    importc, libprag.}

proc getVideoStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_video_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc videoStreams*(self: DiscovererInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_info_get_video_streams(cast[ptr DiscovererInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

type
  DiscovererSerializeFlags* {.size: sizeof(cint), pure.} = enum
    basic = 0
    caps = 1
    tags = 2
    misc = 4
    all = 7

proc gst_discoverer_info_to_variant(self: ptr DiscovererInfo00; flags: DiscovererSerializeFlags): ptr glib.Variant00 {.
    importc, libprag.}

proc toVariant*(self: DiscovererInfo; flags: DiscovererSerializeFlags): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = gst_discoverer_info_to_variant(cast[ptr DiscovererInfo00](self.impl), flags)

type
  DiscovererAudioInfo* = ref object of DiscovererStreamInfo
  DiscovererAudioInfo00* = object of DiscovererStreamInfo00

proc gst_discoverer_audio_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DiscovererAudioInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_discoverer_audio_info_get_bitrate(self: ptr DiscovererAudioInfo00): uint32 {.
    importc, libprag.}

proc getBitrate*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_bitrate(cast[ptr DiscovererAudioInfo00](self.impl)))

proc bitrate*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_bitrate(cast[ptr DiscovererAudioInfo00](self.impl)))

proc gst_discoverer_audio_info_get_channel_mask(self: ptr DiscovererAudioInfo00): uint64 {.
    importc, libprag.}

proc getChannelMask*(self: DiscovererAudioInfo): uint64 =
  gst_discoverer_audio_info_get_channel_mask(cast[ptr DiscovererAudioInfo00](self.impl))

proc channelMask*(self: DiscovererAudioInfo): uint64 =
  gst_discoverer_audio_info_get_channel_mask(cast[ptr DiscovererAudioInfo00](self.impl))

proc gst_discoverer_audio_info_get_channels(self: ptr DiscovererAudioInfo00): uint32 {.
    importc, libprag.}

proc getChannels*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_channels(cast[ptr DiscovererAudioInfo00](self.impl)))

proc channels*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_channels(cast[ptr DiscovererAudioInfo00](self.impl)))

proc gst_discoverer_audio_info_get_depth(self: ptr DiscovererAudioInfo00): uint32 {.
    importc, libprag.}

proc getDepth*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_depth(cast[ptr DiscovererAudioInfo00](self.impl)))

proc depth*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_depth(cast[ptr DiscovererAudioInfo00](self.impl)))

proc gst_discoverer_audio_info_get_language(self: ptr DiscovererAudioInfo00): cstring {.
    importc, libprag.}

proc getLanguage*(self: DiscovererAudioInfo): string =
  result = $gst_discoverer_audio_info_get_language(cast[ptr DiscovererAudioInfo00](self.impl))

proc language*(self: DiscovererAudioInfo): string =
  result = $gst_discoverer_audio_info_get_language(cast[ptr DiscovererAudioInfo00](self.impl))

proc gst_discoverer_audio_info_get_max_bitrate(self: ptr DiscovererAudioInfo00): uint32 {.
    importc, libprag.}

proc getMaxBitrate*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_max_bitrate(cast[ptr DiscovererAudioInfo00](self.impl)))

proc maxBitrate*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_max_bitrate(cast[ptr DiscovererAudioInfo00](self.impl)))

proc gst_discoverer_audio_info_get_sample_rate(self: ptr DiscovererAudioInfo00): uint32 {.
    importc, libprag.}

proc getSampleRate*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_sample_rate(cast[ptr DiscovererAudioInfo00](self.impl)))

proc sampleRate*(self: DiscovererAudioInfo): int =
  int(gst_discoverer_audio_info_get_sample_rate(cast[ptr DiscovererAudioInfo00](self.impl)))

type
  DiscovererContainerInfo* = ref object of DiscovererStreamInfo
  DiscovererContainerInfo00* = object of DiscovererStreamInfo00

proc gst_discoverer_container_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DiscovererContainerInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_discoverer_container_info_get_streams(self: ptr DiscovererContainerInfo00): ptr glib.List {.
    importc, libprag.}

proc getStreams*(self: DiscovererContainerInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_container_info_get_streams(cast[ptr DiscovererContainerInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

proc streams*(self: DiscovererContainerInfo): seq[DiscovererStreamInfo] =
  let resul0 = gst_discoverer_container_info_get_streams(cast[ptr DiscovererContainerInfo00](self.impl))
  result = glistObjects2seq(DiscovererStreamInfo, resul0, true)
  g_list_free(resul0)

type
  DiscovererSubtitleInfo* = ref object of DiscovererStreamInfo
  DiscovererSubtitleInfo00* = object of DiscovererStreamInfo00

proc gst_discoverer_subtitle_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DiscovererSubtitleInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_discoverer_subtitle_info_get_language(self: ptr DiscovererSubtitleInfo00): cstring {.
    importc, libprag.}

proc getLanguage*(self: DiscovererSubtitleInfo): string =
  result = $gst_discoverer_subtitle_info_get_language(cast[ptr DiscovererSubtitleInfo00](self.impl))

proc language*(self: DiscovererSubtitleInfo): string =
  result = $gst_discoverer_subtitle_info_get_language(cast[ptr DiscovererSubtitleInfo00](self.impl))

type
  DiscovererVideoInfo* = ref object of DiscovererStreamInfo
  DiscovererVideoInfo00* = object of DiscovererStreamInfo00

proc gst_discoverer_video_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DiscovererVideoInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_discoverer_video_info_get_bitrate(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getBitrate*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_bitrate(cast[ptr DiscovererVideoInfo00](self.impl)))

proc bitrate*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_bitrate(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_depth(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getDepth*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_depth(cast[ptr DiscovererVideoInfo00](self.impl)))

proc depth*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_depth(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_framerate_denom(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getFramerateDenom*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_framerate_denom(cast[ptr DiscovererVideoInfo00](self.impl)))

proc framerateDenom*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_framerate_denom(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_framerate_num(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getFramerateNum*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_framerate_num(cast[ptr DiscovererVideoInfo00](self.impl)))

proc framerateNum*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_framerate_num(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_height(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getHeight*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_height(cast[ptr DiscovererVideoInfo00](self.impl)))

proc height*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_height(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_max_bitrate(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getMaxBitrate*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_max_bitrate(cast[ptr DiscovererVideoInfo00](self.impl)))

proc maxBitrate*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_max_bitrate(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_par_denom(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getParDenom*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_par_denom(cast[ptr DiscovererVideoInfo00](self.impl)))

proc parDenom*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_par_denom(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_par_num(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getParNum*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_par_num(cast[ptr DiscovererVideoInfo00](self.impl)))

proc parNum*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_par_num(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_get_width(self: ptr DiscovererVideoInfo00): uint32 {.
    importc, libprag.}

proc getWidth*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_width(cast[ptr DiscovererVideoInfo00](self.impl)))

proc width*(self: DiscovererVideoInfo): int =
  int(gst_discoverer_video_info_get_width(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_is_image(self: ptr DiscovererVideoInfo00): gboolean {.
    importc, libprag.}

proc isImage*(self: DiscovererVideoInfo): bool =
  toBool(gst_discoverer_video_info_is_image(cast[ptr DiscovererVideoInfo00](self.impl)))

proc gst_discoverer_video_info_is_interlaced(self: ptr DiscovererVideoInfo00): gboolean {.
    importc, libprag.}

proc isInterlaced*(self: DiscovererVideoInfo): bool =
  toBool(gst_discoverer_video_info_is_interlaced(cast[ptr DiscovererVideoInfo00](self.impl)))

const ENCODING_CATEGORY_CAPTURE* = "capture"

const ENCODING_CATEGORY_DEVICE* = "device"

const ENCODING_CATEGORY_FILE_EXTENSION* = "file-extension"

const ENCODING_CATEGORY_ONLINE_SERVICE* = "online-service"

const ENCODING_CATEGORY_STORAGE_EDITING* = "storage-editing"

type
  EncodingProfile* = ref object of gobject.Object
  EncodingProfile00* = object of gobject.Object00

proc gst_encoding_profile_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EncodingProfile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_encoding_profile_find(targetname: cstring; profilename: cstring;
    category: cstring): ptr EncodingProfile00 {.
    importc, libprag.}

proc findEncodingProfile*(targetname: cstring; profilename: cstring = nil;
    category: cstring = nil): EncodingProfile =
  let gobj = gst_encoding_profile_find(targetname, profilename, category)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_profile_from_discoverer(info: ptr DiscovererInfo00): ptr EncodingProfile00 {.
    importc, libprag.}

proc fromDiscoverer*(info: DiscovererInfo): EncodingProfile =
  let gobj = gst_encoding_profile_from_discoverer(cast[ptr DiscovererInfo00](info.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_profile_copy(self: ptr EncodingProfile00): ptr EncodingProfile00 {.
    importc, libprag.}

proc copy*(self: EncodingProfile): EncodingProfile =
  let gobj = gst_encoding_profile_copy(cast[ptr EncodingProfile00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_profile_get_allow_dynamic_output(self: ptr EncodingProfile00): gboolean {.
    importc, libprag.}

proc getAllowDynamicOutput*(self: EncodingProfile): bool =
  toBool(gst_encoding_profile_get_allow_dynamic_output(cast[ptr EncodingProfile00](self.impl)))

proc allowDynamicOutput*(self: EncodingProfile): bool =
  toBool(gst_encoding_profile_get_allow_dynamic_output(cast[ptr EncodingProfile00](self.impl)))

proc gst_encoding_profile_get_description(self: ptr EncodingProfile00): cstring {.
    importc, libprag.}

proc getDescription*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_description(cast[ptr EncodingProfile00](self.impl))

proc description*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_description(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_file_extension(self: ptr EncodingProfile00): cstring {.
    importc, libprag.}

proc getFileExtension*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_file_extension(cast[ptr EncodingProfile00](self.impl))

proc fileExtension*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_file_extension(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_format(self: ptr EncodingProfile00): ptr gst.Caps00 {.
    importc, libprag.}

proc getFormat*(self: EncodingProfile): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_encoding_profile_get_format(cast[ptr EncodingProfile00](self.impl))

proc format*(self: EncodingProfile): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_encoding_profile_get_format(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_input_caps(self: ptr EncodingProfile00): ptr gst.Caps00 {.
    importc, libprag.}

proc getInputCaps*(self: EncodingProfile): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_encoding_profile_get_input_caps(cast[ptr EncodingProfile00](self.impl))

proc inputCaps*(self: EncodingProfile): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_encoding_profile_get_input_caps(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_name(self: ptr EncodingProfile00): cstring {.
    importc, libprag.}

proc getName*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_name(cast[ptr EncodingProfile00](self.impl))

proc name*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_name(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_presence(self: ptr EncodingProfile00): uint32 {.
    importc, libprag.}

proc getPresence*(self: EncodingProfile): int =
  int(gst_encoding_profile_get_presence(cast[ptr EncodingProfile00](self.impl)))

proc presence*(self: EncodingProfile): int =
  int(gst_encoding_profile_get_presence(cast[ptr EncodingProfile00](self.impl)))

proc gst_encoding_profile_get_preset(self: ptr EncodingProfile00): cstring {.
    importc, libprag.}

proc getPreset*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_preset(cast[ptr EncodingProfile00](self.impl))

proc preset*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_preset(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_preset_name(self: ptr EncodingProfile00): cstring {.
    importc, libprag.}

proc getPresetName*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_preset_name(cast[ptr EncodingProfile00](self.impl))

proc presetName*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_preset_name(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_restriction(self: ptr EncodingProfile00): ptr gst.Caps00 {.
    importc, libprag.}

proc getRestriction*(self: EncodingProfile): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_encoding_profile_get_restriction(cast[ptr EncodingProfile00](self.impl))

proc restriction*(self: EncodingProfile): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_encoding_profile_get_restriction(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_get_single_segment(self: ptr EncodingProfile00): gboolean {.
    importc, libprag.}

proc getSingleSegment*(self: EncodingProfile): bool =
  toBool(gst_encoding_profile_get_single_segment(cast[ptr EncodingProfile00](self.impl)))

proc singleSegment*(self: EncodingProfile): bool =
  toBool(gst_encoding_profile_get_single_segment(cast[ptr EncodingProfile00](self.impl)))

proc gst_encoding_profile_get_type_nick(self: ptr EncodingProfile00): cstring {.
    importc, libprag.}

proc getTypeNick*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_type_nick(cast[ptr EncodingProfile00](self.impl))

proc typeNick*(self: EncodingProfile): string =
  result = $gst_encoding_profile_get_type_nick(cast[ptr EncodingProfile00](self.impl))

proc gst_encoding_profile_is_enabled(self: ptr EncodingProfile00): gboolean {.
    importc, libprag.}

proc isEnabled*(self: EncodingProfile): bool =
  toBool(gst_encoding_profile_is_enabled(cast[ptr EncodingProfile00](self.impl)))

proc gst_encoding_profile_is_equal(self: ptr EncodingProfile00; b: ptr EncodingProfile00): gboolean {.
    importc, libprag.}

proc isEqual*(self: EncodingProfile; b: EncodingProfile): bool =
  toBool(gst_encoding_profile_is_equal(cast[ptr EncodingProfile00](self.impl), cast[ptr EncodingProfile00](b.impl)))

proc gst_encoding_profile_set_allow_dynamic_output(self: ptr EncodingProfile00;
    allowDynamicOutput: gboolean) {.
    importc, libprag.}

proc setAllowDynamicOutput*(self: EncodingProfile;
    allowDynamicOutput: bool = true) =
  gst_encoding_profile_set_allow_dynamic_output(cast[ptr EncodingProfile00](self.impl), gboolean(allowDynamicOutput))

proc `allowDynamicOutput=`*(self: EncodingProfile;
    allowDynamicOutput: bool) =
  gst_encoding_profile_set_allow_dynamic_output(cast[ptr EncodingProfile00](self.impl), gboolean(allowDynamicOutput))

proc gst_encoding_profile_set_description(self: ptr EncodingProfile00; description: cstring) {.
    importc, libprag.}

proc setDescription*(self: EncodingProfile; description: cstring = nil) =
  gst_encoding_profile_set_description(cast[ptr EncodingProfile00](self.impl), description)

proc `description=`*(self: EncodingProfile; description: cstring = nil) =
  gst_encoding_profile_set_description(cast[ptr EncodingProfile00](self.impl), description)

proc gst_encoding_profile_set_enabled(self: ptr EncodingProfile00; enabled: gboolean) {.
    importc, libprag.}

proc setEnabled*(self: EncodingProfile; enabled: bool = true) =
  gst_encoding_profile_set_enabled(cast[ptr EncodingProfile00](self.impl), gboolean(enabled))

proc `enabled=`*(self: EncodingProfile; enabled: bool) =
  gst_encoding_profile_set_enabled(cast[ptr EncodingProfile00](self.impl), gboolean(enabled))

proc gst_encoding_profile_set_format(self: ptr EncodingProfile00; format: ptr gst.Caps00) {.
    importc, libprag.}

proc setFormat*(self: EncodingProfile; format: gst.Caps) =
  gst_encoding_profile_set_format(cast[ptr EncodingProfile00](self.impl), cast[ptr gst.Caps00](format.impl))

proc `format=`*(self: EncodingProfile; format: gst.Caps) =
  gst_encoding_profile_set_format(cast[ptr EncodingProfile00](self.impl), cast[ptr gst.Caps00](format.impl))

proc gst_encoding_profile_set_name(self: ptr EncodingProfile00; name: cstring) {.
    importc, libprag.}

proc setName*(self: EncodingProfile; name: cstring = nil) =
  gst_encoding_profile_set_name(cast[ptr EncodingProfile00](self.impl), name)

proc `name=`*(self: EncodingProfile; name: cstring = nil) =
  gst_encoding_profile_set_name(cast[ptr EncodingProfile00](self.impl), name)

proc gst_encoding_profile_set_presence(self: ptr EncodingProfile00; presence: uint32) {.
    importc, libprag.}

proc setPresence*(self: EncodingProfile; presence: int) =
  gst_encoding_profile_set_presence(cast[ptr EncodingProfile00](self.impl), uint32(presence))

proc `presence=`*(self: EncodingProfile; presence: int) =
  gst_encoding_profile_set_presence(cast[ptr EncodingProfile00](self.impl), uint32(presence))

proc gst_encoding_profile_set_preset(self: ptr EncodingProfile00; preset: cstring) {.
    importc, libprag.}

proc setPreset*(self: EncodingProfile; preset: cstring = nil) =
  gst_encoding_profile_set_preset(cast[ptr EncodingProfile00](self.impl), preset)

proc `preset=`*(self: EncodingProfile; preset: cstring = nil) =
  gst_encoding_profile_set_preset(cast[ptr EncodingProfile00](self.impl), preset)

proc gst_encoding_profile_set_preset_name(self: ptr EncodingProfile00; presetName: cstring) {.
    importc, libprag.}

proc setPresetName*(self: EncodingProfile; presetName: cstring = nil) =
  gst_encoding_profile_set_preset_name(cast[ptr EncodingProfile00](self.impl), presetName)

proc `presetName=`*(self: EncodingProfile; presetName: cstring = nil) =
  gst_encoding_profile_set_preset_name(cast[ptr EncodingProfile00](self.impl), presetName)

proc gst_encoding_profile_set_restriction(self: ptr EncodingProfile00; restriction: ptr gst.Caps00) {.
    importc, libprag.}

proc setRestriction*(self: EncodingProfile; restriction: gst.Caps = nil) =
  gst_encoding_profile_set_restriction(cast[ptr EncodingProfile00](self.impl), if restriction.isNil: nil else: cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), restriction.impl)))

proc `restriction=`*(self: EncodingProfile; restriction: gst.Caps = nil) =
  gst_encoding_profile_set_restriction(cast[ptr EncodingProfile00](self.impl), if restriction.isNil: nil else: cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), restriction.impl)))

proc gst_encoding_profile_set_single_segment(self: ptr EncodingProfile00;
    singleSegment: gboolean) {.
    importc, libprag.}

proc setSingleSegment*(self: EncodingProfile; singleSegment: bool = true) =
  gst_encoding_profile_set_single_segment(cast[ptr EncodingProfile00](self.impl), gboolean(singleSegment))

proc `singleSegment=`*(self: EncodingProfile; singleSegment: bool) =
  gst_encoding_profile_set_single_segment(cast[ptr EncodingProfile00](self.impl), gboolean(singleSegment))

type
  EncodingAudioProfile* = ref object of EncodingProfile
  EncodingAudioProfile00* = object of EncodingProfile00

proc gst_encoding_audio_profile_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EncodingAudioProfile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_encoding_audio_profile_new(format: ptr gst.Caps00; preset: cstring;
    restriction: ptr gst.Caps00; presence: uint32): ptr EncodingAudioProfile00 {.
    importc, libprag.}

proc newEncodingAudioProfile*(format: gst.Caps; preset: cstring = nil;
    restriction: gst.Caps = nil; presence: int): EncodingAudioProfile =
  let gobj = gst_encoding_audio_profile_new(cast[ptr gst.Caps00](format.impl), preset, if restriction.isNil: nil else: cast[ptr gst.Caps00](restriction.impl), uint32(presence))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newEncodingAudioProfile*(tdesc: typedesc; format: gst.Caps; preset: cstring = nil;
    restriction: gst.Caps = nil; presence: int): tdesc =
  assert(result is EncodingAudioProfile)
  let gobj = gst_encoding_audio_profile_new(cast[ptr gst.Caps00](format.impl), preset, if restriction.isNil: nil else: cast[ptr gst.Caps00](restriction.impl), uint32(presence))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEncodingAudioProfile*[T](result: var T; format: gst.Caps; preset: cstring = nil;
    restriction: gst.Caps = nil; presence: int) {.deprecated.} =
  assert(result is EncodingAudioProfile)
  let gobj = gst_encoding_audio_profile_new(cast[ptr gst.Caps00](format.impl), preset, if restriction.isNil: nil else: cast[ptr gst.Caps00](restriction.impl), uint32(presence))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  EncodingContainerProfile* = ref object of EncodingProfile
  EncodingContainerProfile00* = object of EncodingProfile00

proc gst_encoding_container_profile_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EncodingContainerProfile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_encoding_container_profile_new(name: cstring; description: cstring;
    format: ptr gst.Caps00; preset: cstring): ptr EncodingContainerProfile00 {.
    importc, libprag.}

proc newEncodingContainerProfile*(name: cstring = nil; description: cstring = nil;
    format: gst.Caps; preset: cstring = nil): EncodingContainerProfile =
  let gobj = gst_encoding_container_profile_new(name, description, cast[ptr gst.Caps00](format.impl), preset)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newEncodingContainerProfile*(tdesc: typedesc; name: cstring = nil; description: cstring = nil;
    format: gst.Caps; preset: cstring = nil): tdesc =
  assert(result is EncodingContainerProfile)
  let gobj = gst_encoding_container_profile_new(name, description, cast[ptr gst.Caps00](format.impl), preset)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEncodingContainerProfile*[T](result: var T; name: cstring = nil; description: cstring = nil;
    format: gst.Caps; preset: cstring = nil) {.deprecated.} =
  assert(result is EncodingContainerProfile)
  let gobj = gst_encoding_container_profile_new(name, description, cast[ptr gst.Caps00](format.impl), preset)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_container_profile_add_profile(self: ptr EncodingContainerProfile00;
    profile: ptr EncodingProfile00): gboolean {.
    importc, libprag.}

proc addProfile*(self: EncodingContainerProfile;
    profile: EncodingProfile): bool =
  toBool(gst_encoding_container_profile_add_profile(cast[ptr EncodingContainerProfile00](self.impl), cast[ptr EncodingProfile00](g_object_ref(profile.impl))))

proc gst_encoding_container_profile_contains_profile(self: ptr EncodingContainerProfile00;
    profile: ptr EncodingProfile00): gboolean {.
    importc, libprag.}

proc containsProfile*(self: EncodingContainerProfile;
    profile: EncodingProfile): bool =
  toBool(gst_encoding_container_profile_contains_profile(cast[ptr EncodingContainerProfile00](self.impl), cast[ptr EncodingProfile00](profile.impl)))

proc gst_encoding_container_profile_get_profiles(self: ptr EncodingContainerProfile00): ptr glib.List {.
    importc, libprag.}

proc getProfiles*(self: EncodingContainerProfile): seq[EncodingProfile] =
  result = glistObjects2seq(EncodingProfile, gst_encoding_container_profile_get_profiles(cast[ptr EncodingContainerProfile00](self.impl)), false)

proc profiles*(self: EncodingContainerProfile): seq[EncodingProfile] =
  result = glistObjects2seq(EncodingProfile, gst_encoding_container_profile_get_profiles(cast[ptr EncodingContainerProfile00](self.impl)), false)

type
  EncodingTarget* = ref object of gobject.Object
  EncodingTarget00* = object of gobject.Object00

proc gst_encoding_target_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EncodingTarget()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_encoding_target_new(name: cstring; category: cstring; description: cstring;
    profiles: ptr glib.List): ptr EncodingTarget00 {.
    importc, libprag.}

proc newEncodingTarget*(name: cstring; category: cstring; description: cstring;
    profiles: seq[EncodingProfile]): EncodingTarget =
  var tempResGL = seq2GList(profiles)
  let gobj = gst_encoding_target_new(name, category, description, tempResGL)
  g_list_free(tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newEncodingTarget*(tdesc: typedesc; name: cstring; category: cstring; description: cstring;
    profiles: seq[EncodingProfile]): tdesc =
  assert(result is EncodingTarget)
  var tempResGL = seq2GList(profiles)
  let gobj = gst_encoding_target_new(name, category, description, tempResGL)
  g_list_free(tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEncodingTarget*[T](result: var T; name: cstring; category: cstring; description: cstring;
    profiles: seq[EncodingProfile]) {.deprecated.} =
  assert(result is EncodingTarget)
  var tempResGL = seq2GList(profiles)
  let gobj = gst_encoding_target_new(name, category, description, tempResGL)
  g_list_free(tempResGL)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_target_load(name: cstring; category: cstring; error: ptr ptr glib.Error = nil): ptr EncodingTarget00 {.
    importc, libprag.}

proc load*(name: cstring; category: cstring = nil): EncodingTarget =
  var gerror: ptr glib.Error
  let gobj = gst_encoding_target_load(name, category, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_target_load_from_file(filepath: cstring; error: ptr ptr glib.Error = nil): ptr EncodingTarget00 {.
    importc, libprag.}

proc loadFromFile*(filepath: cstring): EncodingTarget =
  var gerror: ptr glib.Error
  let gobj = gst_encoding_target_load_from_file(filepath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_target_add_profile(self: ptr EncodingTarget00; profile: ptr EncodingProfile00): gboolean {.
    importc, libprag.}

proc addProfile*(self: EncodingTarget; profile: EncodingProfile): bool =
  toBool(gst_encoding_target_add_profile(cast[ptr EncodingTarget00](self.impl), cast[ptr EncodingProfile00](g_object_ref(profile.impl))))

proc gst_encoding_target_get_category(self: ptr EncodingTarget00): cstring {.
    importc, libprag.}

proc getCategory*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_category(cast[ptr EncodingTarget00](self.impl))

proc category*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_category(cast[ptr EncodingTarget00](self.impl))

proc gst_encoding_target_get_description(self: ptr EncodingTarget00): cstring {.
    importc, libprag.}

proc getDescription*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_description(cast[ptr EncodingTarget00](self.impl))

proc description*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_description(cast[ptr EncodingTarget00](self.impl))

proc gst_encoding_target_get_name(self: ptr EncodingTarget00): cstring {.
    importc, libprag.}

proc getName*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_name(cast[ptr EncodingTarget00](self.impl))

proc name*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_name(cast[ptr EncodingTarget00](self.impl))

proc gst_encoding_target_get_path(self: ptr EncodingTarget00): cstring {.
    importc, libprag.}

proc getPath*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_path(cast[ptr EncodingTarget00](self.impl))

proc path*(self: EncodingTarget): string =
  result = $gst_encoding_target_get_path(cast[ptr EncodingTarget00](self.impl))

proc gst_encoding_target_get_profile(self: ptr EncodingTarget00; name: cstring): ptr EncodingProfile00 {.
    importc, libprag.}

proc getProfile*(self: EncodingTarget; name: cstring): EncodingProfile =
  let gobj = gst_encoding_target_get_profile(cast[ptr EncodingTarget00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_target_get_profiles(self: ptr EncodingTarget00): ptr glib.List {.
    importc, libprag.}

proc getProfiles*(self: EncodingTarget): seq[EncodingProfile] =
  result = glistObjects2seq(EncodingProfile, gst_encoding_target_get_profiles(cast[ptr EncodingTarget00](self.impl)), false)

proc profiles*(self: EncodingTarget): seq[EncodingProfile] =
  result = glistObjects2seq(EncodingProfile, gst_encoding_target_get_profiles(cast[ptr EncodingTarget00](self.impl)), false)

proc gst_encoding_target_save(self: ptr EncodingTarget00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc save*(self: EncodingTarget): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_encoding_target_save(cast[ptr EncodingTarget00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_encoding_target_save_to_file(self: ptr EncodingTarget00; filepath: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveToFile*(self: EncodingTarget; filepath: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_encoding_target_save_to_file(cast[ptr EncodingTarget00](self.impl), filepath, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

type
  EncodingVideoProfile* = ref object of EncodingProfile
  EncodingVideoProfile00* = object of EncodingProfile00

proc gst_encoding_video_profile_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(EncodingVideoProfile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_encoding_video_profile_new(format: ptr gst.Caps00; preset: cstring;
    restriction: ptr gst.Caps00; presence: uint32): ptr EncodingVideoProfile00 {.
    importc, libprag.}

proc newEncodingVideoProfile*(format: gst.Caps; preset: cstring = nil;
    restriction: gst.Caps = nil; presence: int): EncodingVideoProfile =
  let gobj = gst_encoding_video_profile_new(cast[ptr gst.Caps00](format.impl), preset, if restriction.isNil: nil else: cast[ptr gst.Caps00](restriction.impl), uint32(presence))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newEncodingVideoProfile*(tdesc: typedesc; format: gst.Caps; preset: cstring = nil;
    restriction: gst.Caps = nil; presence: int): tdesc =
  assert(result is EncodingVideoProfile)
  let gobj = gst_encoding_video_profile_new(cast[ptr gst.Caps00](format.impl), preset, if restriction.isNil: nil else: cast[ptr gst.Caps00](restriction.impl), uint32(presence))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEncodingVideoProfile*[T](result: var T; format: gst.Caps; preset: cstring = nil;
    restriction: gst.Caps = nil; presence: int) {.deprecated.} =
  assert(result is EncodingVideoProfile)
  let gobj = gst_encoding_video_profile_new(cast[ptr gst.Caps00](format.impl), preset, if restriction.isNil: nil else: cast[ptr gst.Caps00](restriction.impl), uint32(presence))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstpbutils.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_encoding_video_profile_get_pass(self: ptr EncodingVideoProfile00): uint32 {.
    importc, libprag.}

proc getPass*(self: EncodingVideoProfile): int =
  int(gst_encoding_video_profile_get_pass(cast[ptr EncodingVideoProfile00](self.impl)))

proc pass*(self: EncodingVideoProfile): int =
  int(gst_encoding_video_profile_get_pass(cast[ptr EncodingVideoProfile00](self.impl)))

proc gst_encoding_video_profile_get_variableframerate(self: ptr EncodingVideoProfile00): gboolean {.
    importc, libprag.}

proc getVariableframerate*(self: EncodingVideoProfile): bool =
  toBool(gst_encoding_video_profile_get_variableframerate(cast[ptr EncodingVideoProfile00](self.impl)))

proc variableframerate*(self: EncodingVideoProfile): bool =
  toBool(gst_encoding_video_profile_get_variableframerate(cast[ptr EncodingVideoProfile00](self.impl)))

proc gst_encoding_video_profile_set_pass(self: ptr EncodingVideoProfile00;
    pass: uint32) {.
    importc, libprag.}

proc setPass*(self: EncodingVideoProfile; pass: int) =
  gst_encoding_video_profile_set_pass(cast[ptr EncodingVideoProfile00](self.impl), uint32(pass))

proc `pass=`*(self: EncodingVideoProfile; pass: int) =
  gst_encoding_video_profile_set_pass(cast[ptr EncodingVideoProfile00](self.impl), uint32(pass))

proc gst_encoding_video_profile_set_variableframerate(self: ptr EncodingVideoProfile00;
    variableframerate: gboolean) {.
    importc, libprag.}

proc setVariableframerate*(self: EncodingVideoProfile;
    variableframerate: bool = true) =
  gst_encoding_video_profile_set_variableframerate(cast[ptr EncodingVideoProfile00](self.impl), gboolean(variableframerate))

proc `variableframerate=`*(self: EncodingVideoProfile;
    variableframerate: bool) =
  gst_encoding_video_profile_set_variableframerate(cast[ptr EncodingVideoProfile00](self.impl), gboolean(variableframerate))

type
  InstallPluginsContext00* {.pure.} = object
  InstallPluginsContext* = ref object
    impl*: ptr InstallPluginsContext00
    ignoreFinalizer*: bool

proc gst_install_plugins_context_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstInstallPluginsContext*(self: InstallPluginsContext) =
  if not self.ignoreFinalizer:
    boxedFree(gst_install_plugins_context_get_type(), cast[ptr InstallPluginsContext00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(InstallPluginsContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_install_plugins_context_get_type(), cast[ptr InstallPluginsContext00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var InstallPluginsContext) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstInstallPluginsContext)

proc gst_install_plugins_context_free(self: ptr InstallPluginsContext00) {.
    importc, libprag.}

proc free*(self: InstallPluginsContext) =
  gst_install_plugins_context_free(cast[ptr InstallPluginsContext00](self.impl))

proc finalizerfree*(self: InstallPluginsContext) =
  if not self.ignoreFinalizer:
    gst_install_plugins_context_free(cast[ptr InstallPluginsContext00](self.impl))

proc gst_install_plugins_context_copy(self: ptr InstallPluginsContext00): ptr InstallPluginsContext00 {.
    importc, libprag.}

proc copy*(self: InstallPluginsContext): InstallPluginsContext =
  fnew(result, gBoxedFreeGstInstallPluginsContext)
  result.impl = gst_install_plugins_context_copy(cast[ptr InstallPluginsContext00](self.impl))

proc gst_install_plugins_context_new(): ptr InstallPluginsContext00 {.
    importc, libprag.}

proc newInstallPluginsContext*(): InstallPluginsContext =
  fnew(result, gBoxedFreeGstInstallPluginsContext)
  result.impl = gst_install_plugins_context_new()

proc newInstallPluginsContext*(tdesc: typedesc): tdesc =
  assert(result is InstallPluginsContext)
  fnew(result, gBoxedFreeGstInstallPluginsContext)
  result.impl = gst_install_plugins_context_new()

proc initInstallPluginsContext*[T](result: var T) {.deprecated.} =
  assert(result is InstallPluginsContext)
  fnew(result, gBoxedFreeGstInstallPluginsContext)
  result.impl = gst_install_plugins_context_new()

proc gst_install_plugins_context_set_confirm_search(self: ptr InstallPluginsContext00;
    confirmSearch: gboolean) {.
    importc, libprag.}

proc setConfirmSearch*(self: InstallPluginsContext;
    confirmSearch: bool = true) =
  gst_install_plugins_context_set_confirm_search(cast[ptr InstallPluginsContext00](self.impl), gboolean(confirmSearch))

proc `confirmSearch=`*(self: InstallPluginsContext;
    confirmSearch: bool) =
  gst_install_plugins_context_set_confirm_search(cast[ptr InstallPluginsContext00](self.impl), gboolean(confirmSearch))

proc gst_install_plugins_context_set_desktop_id(self: ptr InstallPluginsContext00;
    desktopId: cstring) {.
    importc, libprag.}

proc setDesktopId*(self: InstallPluginsContext;
    desktopId: cstring) =
  gst_install_plugins_context_set_desktop_id(cast[ptr InstallPluginsContext00](self.impl), desktopId)

proc `desktopId=`*(self: InstallPluginsContext;
    desktopId: cstring) =
  gst_install_plugins_context_set_desktop_id(cast[ptr InstallPluginsContext00](self.impl), desktopId)

proc gst_install_plugins_context_set_startup_notification_id(self: ptr InstallPluginsContext00;
    startupId: cstring) {.
    importc, libprag.}

proc setStartupNotificationId*(self: InstallPluginsContext;
    startupId: cstring) =
  gst_install_plugins_context_set_startup_notification_id(cast[ptr InstallPluginsContext00](self.impl), startupId)

proc `startupNotificationId=`*(self: InstallPluginsContext;
    startupId: cstring) =
  gst_install_plugins_context_set_startup_notification_id(cast[ptr InstallPluginsContext00](self.impl), startupId)

proc gst_install_plugins_context_set_xid(self: ptr InstallPluginsContext00;
    xid: uint32) {.
    importc, libprag.}

proc setXid*(self: InstallPluginsContext; xid: int) =
  gst_install_plugins_context_set_xid(cast[ptr InstallPluginsContext00](self.impl), uint32(xid))

proc `xid=`*(self: InstallPluginsContext; xid: int) =
  gst_install_plugins_context_set_xid(cast[ptr InstallPluginsContext00](self.impl), uint32(xid))

type
  InstallPluginsReturn* {.size: sizeof(cint), pure.} = enum
    success = 0
    notFound = 1
    error = 2
    partialSuccess = 3
    userAbort = 4
    crashed = 100
    invalid = 101
    startedOk = 200
    internalFailure = 201
    helperMissing = 202
    installInProgress = 203

proc gst_install_plugins_return_get_name(ret: InstallPluginsReturn): cstring {.
    importc, libprag.}

proc getName*(ret: InstallPluginsReturn): string =
  result = $gst_install_plugins_return_get_name(ret)

proc name*(ret: InstallPluginsReturn): string =
  result = $gst_install_plugins_return_get_name(ret)

type
  InstallPluginsResultFunc* = proc (resu: InstallPluginsReturn; userData: pointer) {.cdecl.}

const PLUGINS_BASE_VERSION_MAJOR* = 1'i32

const PLUGINS_BASE_VERSION_MICRO* = 4'i32

const PLUGINS_BASE_VERSION_MINOR* = 18'i32

const PLUGINS_BASE_VERSION_NANO* = 0'i32

proc gst_codec_utils_aac_caps_set_level_and_profile(caps: ptr gst.Caps00;
    audioConfig: ptr uint8; len: uint32): gboolean {.
    importc, libprag.}

proc codecUtilsAacCapsSetLevelAndProfile*(caps: gst.Caps; audioConfig: seq[uint8] | string): bool =
  let len = int(audioConfig.len)
  toBool(gst_codec_utils_aac_caps_set_level_and_profile(cast[ptr gst.Caps00](caps.impl), cast[ptr uint8](unsafeaddr(audioConfig[0])), uint32(len)))

proc gst_codec_utils_aac_get_channels(audioConfig: ptr uint8; len: uint32): uint32 {.
    importc, libprag.}

proc codecUtilsAacGetChannels*(audioConfig: seq[uint8] | string): int =
  let len = int(audioConfig.len)
  int(gst_codec_utils_aac_get_channels(cast[ptr uint8](unsafeaddr(audioConfig[0])), uint32(len)))

proc gst_codec_utils_aac_get_index_from_sample_rate(rate: uint32): int32 {.
    importc, libprag.}

proc codecUtilsAacGetIndexFromSampleRate*(rate: int): int =
  int(gst_codec_utils_aac_get_index_from_sample_rate(uint32(rate)))

proc gst_codec_utils_aac_get_level(audioConfig: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsAacGetLevel*(audioConfig: seq[uint8] | string): string =
  let len = int(audioConfig.len)
  result = $gst_codec_utils_aac_get_level(cast[ptr uint8](unsafeaddr(audioConfig[0])), uint32(len))

proc gst_codec_utils_aac_get_profile(audioConfig: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsAacGetProfile*(audioConfig: seq[uint8] | string): string =
  let len = int(audioConfig.len)
  result = $gst_codec_utils_aac_get_profile(cast[ptr uint8](unsafeaddr(audioConfig[0])), uint32(len))

proc gst_codec_utils_aac_get_sample_rate(audioConfig: ptr uint8; len: uint32): uint32 {.
    importc, libprag.}

proc codecUtilsAacGetSampleRate*(audioConfig: seq[uint8] | string): int =
  let len = int(audioConfig.len)
  int(gst_codec_utils_aac_get_sample_rate(cast[ptr uint8](unsafeaddr(audioConfig[0])), uint32(len)))

proc gst_codec_utils_aac_get_sample_rate_from_index(srIdx: uint32): uint32 {.
    importc, libprag.}

proc codecUtilsAacGetSampleRateFromIndex*(srIdx: int): int =
  int(gst_codec_utils_aac_get_sample_rate_from_index(uint32(srIdx)))

proc gst_codec_utils_h264_caps_set_level_and_profile(caps: ptr gst.Caps00;
    sps: ptr uint8; len: uint32): gboolean {.
    importc, libprag.}

proc codecUtilsH264CapsSetLevelAndProfile*(caps: gst.Caps; sps: seq[uint8] | string): bool =
  let len = int(sps.len)
  toBool(gst_codec_utils_h264_caps_set_level_and_profile(cast[ptr gst.Caps00](caps.impl), cast[ptr uint8](unsafeaddr(sps[0])), uint32(len)))

proc gst_codec_utils_h264_get_level(sps: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsH264GetLevel*(sps: seq[uint8] | string): string =
  let len = int(sps.len)
  result = $gst_codec_utils_h264_get_level(cast[ptr uint8](unsafeaddr(sps[0])), uint32(len))

proc codecUtilsH264GetLevelIdc*(level: cstring): uint8 {.
    importc: "gst_codec_utils_h264_get_level_idc", libprag.}

proc gst_codec_utils_h264_get_profile(sps: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsH264GetProfile*(sps: seq[uint8] | string): string =
  let len = int(sps.len)
  result = $gst_codec_utils_h264_get_profile(cast[ptr uint8](unsafeaddr(sps[0])), uint32(len))

proc gst_codec_utils_h265_caps_set_level_tier_and_profile(caps: ptr gst.Caps00;
    profileTierLevel: ptr uint8; len: uint32): gboolean {.
    importc, libprag.}

proc codecUtilsH265CapsSetLevelTierAndProfile*(caps: gst.Caps;
    profileTierLevel: seq[uint8] | string): bool =
  let len = int(profileTierLevel.len)
  toBool(gst_codec_utils_h265_caps_set_level_tier_and_profile(cast[ptr gst.Caps00](caps.impl), cast[ptr uint8](unsafeaddr(profileTierLevel[0])), uint32(len)))

proc gst_codec_utils_h265_get_level(profileTierLevel: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsH265GetLevel*(profileTierLevel: seq[uint8] | string): string =
  let len = int(profileTierLevel.len)
  result = $gst_codec_utils_h265_get_level(cast[ptr uint8](unsafeaddr(profileTierLevel[0])), uint32(len))

proc codecUtilsH265GetLevelIdc*(level: cstring): uint8 {.
    importc: "gst_codec_utils_h265_get_level_idc", libprag.}

proc gst_codec_utils_h265_get_profile(profileTierLevel: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsH265GetProfile*(profileTierLevel: seq[uint8] | string): string =
  let len = int(profileTierLevel.len)
  result = $gst_codec_utils_h265_get_profile(cast[ptr uint8](unsafeaddr(profileTierLevel[0])), uint32(len))

proc gst_codec_utils_h265_get_tier(profileTierLevel: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsH265GetTier*(profileTierLevel: seq[uint8] | string): string =
  let len = int(profileTierLevel.len)
  result = $gst_codec_utils_h265_get_tier(cast[ptr uint8](unsafeaddr(profileTierLevel[0])), uint32(len))

proc gst_codec_utils_mpeg4video_caps_set_level_and_profile(caps: ptr gst.Caps00;
    visObjSeq: ptr uint8; len: uint32): gboolean {.
    importc, libprag.}

proc codecUtilsMpeg4videoCapsSetLevelAndProfile*(caps: gst.Caps;
    visObjSeq: seq[uint8] | string): bool =
  let len = int(visObjSeq.len)
  toBool(gst_codec_utils_mpeg4video_caps_set_level_and_profile(cast[ptr gst.Caps00](caps.impl), cast[ptr uint8](unsafeaddr(visObjSeq[0])), uint32(len)))

proc gst_codec_utils_mpeg4video_get_level(visObjSeq: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsMpeg4videoGetLevel*(visObjSeq: seq[uint8] | string): string =
  let len = int(visObjSeq.len)
  result = $gst_codec_utils_mpeg4video_get_level(cast[ptr uint8](unsafeaddr(visObjSeq[0])), uint32(len))

proc gst_codec_utils_mpeg4video_get_profile(visObjSeq: ptr uint8; len: uint32): cstring {.
    importc, libprag.}

proc codecUtilsMpeg4videoGetProfile*(visObjSeq: seq[uint8] | string): string =
  let len = int(visObjSeq.len)
  result = $gst_codec_utils_mpeg4video_get_profile(cast[ptr uint8](unsafeaddr(visObjSeq[0])), uint32(len))

proc gst_codec_utils_opus_create_caps(rate: uint32; channels: uint8; channelMappingFamily: uint8;
    streamCount: uint8; coupledCount: uint8; channelMapping: ptr uint8): ptr gst.Caps00 {.
    importc, libprag.}

proc codecUtilsOpusCreateCaps*(rate: int; channels: uint8; channelMappingFamily: uint8;
    streamCount: uint8; coupledCount: uint8; channelMapping: seq[uint8] | string): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_codec_utils_opus_create_caps(uint32(rate), channels, channelMappingFamily, streamCount, coupledCount, cast[ptr uint8](unsafeaddr(channelMapping[0])))

proc gst_codec_utils_opus_create_caps_from_header(header: ptr gst.Buffer00;
    comments: ptr gst.Buffer00): ptr gst.Caps00 {.
    importc, libprag.}

proc codecUtilsOpusCreateCapsFromHeader*(header: gst.Buffer; comments: gst.Buffer = nil): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_codec_utils_opus_create_caps_from_header(cast[ptr gst.Buffer00](header.impl), if comments.isNil: nil else: cast[ptr gst.Buffer00](comments.impl))

proc gst_codec_utils_opus_create_header(rate: uint32; channels: uint8; channelMappingFamily: uint8;
    streamCount: uint8; coupledCount: uint8; channelMapping: ptr uint8; preSkip: uint16;
    outputGain: int16): ptr gst.Buffer00 {.
    importc, libprag.}

proc codecUtilsOpusCreateHeader*(rate: int; channels: uint8; channelMappingFamily: uint8;
    streamCount: uint8; coupledCount: uint8; channelMapping: seq[uint8] | string;
    preSkip: uint16; outputGain: int16): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_codec_utils_opus_create_header(uint32(rate), channels, channelMappingFamily, streamCount, coupledCount, cast[ptr uint8](unsafeaddr(channelMapping[0])), preSkip, outputGain)

proc gst_codec_utils_opus_parse_caps(caps: ptr gst.Caps00; rate: var uint32;
    channels: var uint8; channelMappingFamily: var uint8; streamCount: var uint8;
    coupledCount: var uint8; channelMapping: var ptr array[256, uint8]): gboolean {.
    importc, libprag.}

proc codecUtilsOpusParseCaps*(caps: gst.Caps; rate: var int; channels: var uint8;
    channelMappingFamily: var uint8; streamCount: var uint8; coupledCount: var uint8;
    channelMapping: var ptr array[256, uint8]): bool =
  var rate_00: uint32
  result = toBool(gst_codec_utils_opus_parse_caps(cast[ptr gst.Caps00](caps.impl), rate_00, channels, channelMappingFamily, streamCount, coupledCount, channelMapping))
  if rate.addr != nil:
    rate = int(rate_00)

proc gst_codec_utils_opus_parse_header(header: ptr gst.Buffer00; rate: var uint32;
    channels: var uint8; channelMappingFamily: var uint8; streamCount: var uint8;
    coupledCount: var uint8; channelMapping: var ptr array[256, uint8]; preSkip: var uint16;
    outputGain: var int16): gboolean {.
    importc, libprag.}

proc codecUtilsOpusParseHeader*(header: gst.Buffer; rate: var int;
    channels: var uint8; channelMappingFamily: var uint8; streamCount: var uint8;
    coupledCount: var uint8; channelMapping: var ptr array[256, uint8]; preSkip: var uint16;
    outputGain: var int16): bool =
  var rate_00: uint32
  result = toBool(gst_codec_utils_opus_parse_header(cast[ptr gst.Buffer00](header.impl), rate_00, channels, channelMappingFamily, streamCount, coupledCount, channelMapping, preSkip, outputGain))
  if rate.addr != nil:
    rate = int(rate_00)

proc gst_encoding_list_all_targets(categoryname: cstring): ptr glib.List {.
    importc, libprag.}

proc encodingListAllTargets*(categoryname: cstring = nil): seq[EncodingTarget] =
  let resul0 = gst_encoding_list_all_targets(categoryname)
  result = glistObjects2seq(EncodingTarget, resul0, true)
  g_list_free(resul0)

proc gst_encoding_list_available_categories(): ptr glib.List {.
    importc, libprag.}

proc encodingListAvailableCategories*(): seq[cstring] =
  let resul0 = gst_encoding_list_available_categories()
  g_list_free(resul0)

proc gst_install_plugins_async(details: ptr cstring; ctx: ptr InstallPluginsContext00;
    `func`: InstallPluginsResultFunc; userData: pointer): InstallPluginsReturn {.
    importc, libprag.}

proc installPluginsAsync*(details: openArray[string]; ctx: InstallPluginsContext = nil;
    `func`: InstallPluginsResultFunc; userData: pointer): InstallPluginsReturn =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gst_install_plugins_async(seq2CstringArray(details, fs469n23), if ctx.isNil: nil else: cast[ptr InstallPluginsContext00](ctx.impl), `func`, userData)

proc gst_install_plugins_installation_in_progress(): gboolean {.
    importc, libprag.}

proc installPluginsInstallationInProgress*(): bool =
  toBool(gst_install_plugins_installation_in_progress())

proc gst_install_plugins_supported(): gboolean {.
    importc, libprag.}

proc installPluginsSupported*(): bool =
  toBool(gst_install_plugins_supported())

proc gst_install_plugins_sync(details: ptr cstring; ctx: ptr InstallPluginsContext00): InstallPluginsReturn {.
    importc, libprag.}

proc installPluginsSync*(details: openArray[string]; ctx: InstallPluginsContext = nil): InstallPluginsReturn =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gst_install_plugins_sync(seq2CstringArray(details, fs469n23), if ctx.isNil: nil else: cast[ptr InstallPluginsContext00](ctx.impl))

proc gst_is_missing_plugin_message(msg: ptr gst.Message00): gboolean {.
    importc, libprag.}

proc isMissingPluginMessage*(msg: gst.Message): bool =
  toBool(gst_is_missing_plugin_message(cast[ptr gst.Message00](msg.impl)))

proc gst_missing_decoder_installer_detail_new(decodeCaps: ptr gst.Caps00): cstring {.
    importc, libprag.}

proc missingDecoderInstallerDetailNew*(decodeCaps: gst.Caps): string =
  let resul0 = gst_missing_decoder_installer_detail_new(cast[ptr gst.Caps00](decodeCaps.impl))
  result = $resul0
  cogfree(resul0)

proc gst_missing_decoder_message_new(element: ptr gst.Element00; decodeCaps: ptr gst.Caps00): ptr gst.Message00 {.
    importc, libprag.}

proc newMissingDecoderMessage*(element: gst.Element; decodeCaps: gst.Caps): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_missing_decoder_message_new(cast[ptr gst.Element00](element.impl), cast[ptr gst.Caps00](decodeCaps.impl))

proc gst_missing_element_installer_detail_new(factoryName: cstring): cstring {.
    importc, libprag.}

proc missingElementInstallerDetailNew*(factoryName: cstring): string =
  let resul0 = gst_missing_element_installer_detail_new(factoryName)
  result = $resul0
  cogfree(resul0)

proc gst_missing_element_message_new(element: ptr gst.Element00; factoryName: cstring): ptr gst.Message00 {.
    importc, libprag.}

proc newMissingElementMessage*(element: gst.Element; factoryName: cstring): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_missing_element_message_new(cast[ptr gst.Element00](element.impl), factoryName)

proc gst_missing_encoder_installer_detail_new(encodeCaps: ptr gst.Caps00): cstring {.
    importc, libprag.}

proc missingEncoderInstallerDetailNew*(encodeCaps: gst.Caps): string =
  let resul0 = gst_missing_encoder_installer_detail_new(cast[ptr gst.Caps00](encodeCaps.impl))
  result = $resul0
  cogfree(resul0)

proc gst_missing_encoder_message_new(element: ptr gst.Element00; encodeCaps: ptr gst.Caps00): ptr gst.Message00 {.
    importc, libprag.}

proc newMissingEncoderMessage*(element: gst.Element; encodeCaps: gst.Caps): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_missing_encoder_message_new(cast[ptr gst.Element00](element.impl), cast[ptr gst.Caps00](encodeCaps.impl))

proc gst_missing_plugin_message_get_description(msg: ptr gst.Message00): cstring {.
    importc, libprag.}

proc missingPluginMessageGetDescription*(msg: gst.Message): string =
  let resul0 = gst_missing_plugin_message_get_description(cast[ptr gst.Message00](msg.impl))
  result = $resul0
  cogfree(resul0)

proc gst_missing_plugin_message_get_installer_detail(msg: ptr gst.Message00): cstring {.
    importc, libprag.}

proc missingPluginMessageGetInstallerDetail*(msg: gst.Message): string =
  let resul0 = gst_missing_plugin_message_get_installer_detail(cast[ptr gst.Message00](msg.impl))
  result = $resul0
  cogfree(resul0)

proc gst_missing_uri_sink_installer_detail_new(protocol: cstring): cstring {.
    importc, libprag.}

proc missingUriSinkInstallerDetailNew*(protocol: cstring): string =
  let resul0 = gst_missing_uri_sink_installer_detail_new(protocol)
  result = $resul0
  cogfree(resul0)

proc gst_missing_uri_sink_message_new(element: ptr gst.Element00; protocol: cstring): ptr gst.Message00 {.
    importc, libprag.}

proc newMissingUriSinkMessage*(element: gst.Element; protocol: cstring): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_missing_uri_sink_message_new(cast[ptr gst.Element00](element.impl), protocol)

proc gst_missing_uri_source_installer_detail_new(protocol: cstring): cstring {.
    importc, libprag.}

proc missingUriSourceInstallerDetailNew*(protocol: cstring): string =
  let resul0 = gst_missing_uri_source_installer_detail_new(protocol)
  result = $resul0
  cogfree(resul0)

proc gst_missing_uri_source_message_new(element: ptr gst.Element00; protocol: cstring): ptr gst.Message00 {.
    importc, libprag.}

proc newMissingUriSourceMessage*(element: gst.Element; protocol: cstring): gst.Message =
  fnew(result, gBoxedFreeGstMessage)
  result.impl = gst_missing_uri_source_message_new(cast[ptr gst.Element00](element.impl), protocol)

proc gst_pb_utils_add_codec_description_to_tag_list(taglist: ptr gst.TagList00;
    codecTag: cstring; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc pbUtilsAddCodecDescriptionToTagList*(taglist: gst.TagList;
    codecTag: cstring = nil; caps: gst.Caps): bool =
  toBool(gst_pb_utils_add_codec_description_to_tag_list(cast[ptr gst.TagList00](taglist.impl), codecTag, cast[ptr gst.Caps00](caps.impl)))

proc gst_pb_utils_get_codec_description(caps: ptr gst.Caps00): cstring {.
    importc, libprag.}

proc pbUtilsGetCodecDescription*(caps: gst.Caps): string =
  let resul0 = gst_pb_utils_get_codec_description(cast[ptr gst.Caps00](caps.impl))
  result = $resul0
  cogfree(resul0)

proc gst_pb_utils_get_decoder_description(caps: ptr gst.Caps00): cstring {.
    importc, libprag.}

proc pbUtilsGetDecoderDescription*(caps: gst.Caps): string =
  let resul0 = gst_pb_utils_get_decoder_description(cast[ptr gst.Caps00](caps.impl))
  result = $resul0
  cogfree(resul0)

proc gst_pb_utils_get_element_description(factoryName: cstring): cstring {.
    importc, libprag.}

proc pbUtilsGetElementDescription*(factoryName: cstring): string =
  let resul0 = gst_pb_utils_get_element_description(factoryName)
  result = $resul0
  cogfree(resul0)

proc gst_pb_utils_get_encoder_description(caps: ptr gst.Caps00): cstring {.
    importc, libprag.}

proc pbUtilsGetEncoderDescription*(caps: gst.Caps): string =
  let resul0 = gst_pb_utils_get_encoder_description(cast[ptr gst.Caps00](caps.impl))
  result = $resul0
  cogfree(resul0)

proc gst_pb_utils_get_sink_description(protocol: cstring): cstring {.
    importc, libprag.}

proc pbUtilsGetSinkDescription*(protocol: cstring): string =
  let resul0 = gst_pb_utils_get_sink_description(protocol)
  result = $resul0
  cogfree(resul0)

proc gst_pb_utils_get_source_description(protocol: cstring): cstring {.
    importc, libprag.}

proc pbUtilsGetSourceDescription*(protocol: cstring): string =
  let resul0 = gst_pb_utils_get_source_description(protocol)
  result = $resul0
  cogfree(resul0)

proc pbUtilsInit*() {.
    importc: "gst_pb_utils_init", libprag.}

proc gst_plugins_base_version(major: var uint32; minor: var uint32; micro: var uint32;
    nano: var uint32) {.
    importc, libprag.}

proc pluginsBaseVersion*(major: var int; minor: var int; micro: var int;
    nano: var int) =
  var nano_00: uint32
  var major_00: uint32
  var minor_00: uint32
  var micro_00: uint32
  gst_plugins_base_version(major_00, minor_00, micro_00, nano_00)
  if nano.addr != nil:
    nano = int(nano_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)
  if micro.addr != nil:
    micro = int(micro_00)

proc gst_plugins_base_version_string(): cstring {.
    importc, libprag.}

proc pluginsBaseVersionString*(): string =
  let resul0 = gst_plugins_base_version_string()
  result = $resul0
  cogfree(resul0)
# === remaining symbols:
