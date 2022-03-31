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
# libgstapp-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gst, glib, gmodule
const Lib = "libgstapp-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  AppSink* = ref object of gstbase.BaseSink
  AppSink00* = object of gstbase.BaseSink00

proc gst_app_sink_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AppSink()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scEos*(self: AppSink;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "eos", cast[GCallback](p), xdata, nil, cf)

proc scNewPreroll*(self: AppSink;  p: proc (self: ptr AppSink00; xdata: pointer): gst.FlowReturn {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-preroll", cast[GCallback](p), xdata, nil, cf)

proc scNewSample*(self: AppSink;  p: proc (self: ptr AppSink00; xdata: pointer): gst.FlowReturn {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "new-sample", cast[GCallback](p), xdata, nil, cf)

proc scPullPreroll*(self: AppSink;  p: proc (self: ptr AppSink00; xdata: pointer): gst.Sample00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pull-preroll", cast[GCallback](p), xdata, nil, cf)

proc scPullSample*(self: AppSink;  p: proc (self: ptr AppSink00; xdata: pointer): gst.Sample00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "pull-sample", cast[GCallback](p), xdata, nil, cf)

proc scTryPullPreroll*(self: AppSink;  p: proc (self: ptr AppSink00; timeout: uint64; xdata: pointer): gst.Sample00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "try-pull-preroll", cast[GCallback](p), xdata, nil, cf)

proc scTryPullSample*(self: AppSink;  p: proc (self: ptr AppSink00; timeout: uint64; xdata: pointer): gst.Sample00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "try-pull-sample", cast[GCallback](p), xdata, nil, cf)

type
  AppSrc* = ref object of gstbase.BaseSrc
  AppSrc00* = object of gstbase.BaseSrc00

proc gst_app_src_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(AppSrc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scEndOfStream*(self: AppSrc;  p: proc (self: ptr AppSrc00; xdata: pointer): gst.FlowReturn {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "end-of-stream", cast[GCallback](p), xdata, nil, cf)

proc scEnoughData*(self: AppSrc;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "enough-data", cast[GCallback](p), xdata, nil, cf)

proc scNeedData*(self: AppSrc;  p: proc (self: ptr AppSrc00; length: uint32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "need-data", cast[GCallback](p), xdata, nil, cf)

proc scPushBuffer*(self: AppSrc;  p: proc (self: ptr AppSrc00; buffer: ptr gst.Buffer00; xdata: pointer): gst.FlowReturn {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "push-buffer", cast[GCallback](p), xdata, nil, cf)

proc scPushBufferList*(self: AppSrc;  p: proc (self: ptr AppSrc00; bufferList: ptr gst.BufferList00; xdata: pointer): gst.FlowReturn {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "push-buffer-list", cast[GCallback](p), xdata, nil, cf)

proc scPushSample*(self: AppSrc;  p: proc (self: ptr AppSrc00; sample: ptr gst.Sample00; xdata: pointer): gst.FlowReturn {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "push-sample", cast[GCallback](p), xdata, nil, cf)

proc scSeekData*(self: AppSrc;  p: proc (self: ptr AppSrc00; offset: uint64; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "seek-data", cast[GCallback](p), xdata, nil, cf)

type
  AppStreamType* {.size: sizeof(cint), pure.} = enum
    stream = 0
    seekable = 1
    randomAccess = 2
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc uRIHandler*(x: gstapp.AppSink): gst.URIHandler = cast[gst.URIHandler](x)

proc uRIHandler*(x: gstapp.AppSrc): gst.URIHandler = cast[gst.URIHandler](x)
