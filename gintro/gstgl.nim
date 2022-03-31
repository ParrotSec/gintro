# dependencies:
# GObject-2.0
# GstBase-1.0
# GstVideo-1.0
# Gst-1.0
# GModule-2.0
# GLib-2.0
# immediate dependencies:
# GstVideo-1.0
# GstBase-1.0
# Gst-1.0
# libraries:
# libgstgl-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gstvideo, gst, gmodule, glib
const Lib = "libgstgl-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const BUFFER_POOL_OPTION_GL_SYNC_META* = "GstBufferPoolOptionGLSyncMeta"

const BUFFER_POOL_OPTION_GL_TEXTURE_TARGET_2D* = "GstBufferPoolOptionGLTextureTarget2D"

const BUFFER_POOL_OPTION_GL_TEXTURE_TARGET_EXTERNAL_OES* = "GstBufferPoolOptionGLTextureTargetExternalOES"

const BUFFER_POOL_OPTION_GL_TEXTURE_TARGET_RECTANGLE* = "GstBufferPoolOptionGLTextureTargetRectangle"

const CAPS_FEATURE_MEMORY_GL_BUFFER* = "memory:GLBuffer"

const CAPS_FEATURE_MEMORY_GL_MEMORY* = "memory:GLMemory"

type
  GLAPI* {.size: sizeof(cint), pure.} = enum
    none = 0
    opengl = 1
    opengl3 = 2
    gles1 = 32768
    gles2 = 65536
    any = 4294967295

proc fromStringGLAPI*(apiS: cstring): GLAPI {.
    importc: "gst_gl_api_from_string", libprag.}

proc gst_gl_api_to_string(api: GLAPI): cstring {.
    importc, libprag.}

proc toString*(api: GLAPI): string =
  let resul0 = gst_gl_api_to_string(api)
  result = $resul0
  cogfree(resul0)

type
  GLAllocationParams00* {.pure.} = object
  GLAllocationParams* = ref object
    impl*: ptr GLAllocationParams00
    ignoreFinalizer*: bool

proc gst_gl_allocation_params_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstGLAllocationParams*(self: GLAllocationParams) =
  if not self.ignoreFinalizer:
    boxedFree(gst_gl_allocation_params_get_type(), cast[ptr GLAllocationParams00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLAllocationParams()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_gl_allocation_params_get_type(), cast[ptr GLAllocationParams00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GLAllocationParams) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstGLAllocationParams)

proc gst_gl_allocation_params_free(self: ptr GLAllocationParams00) {.
    importc, libprag.}

proc free*(self: GLAllocationParams) =
  gst_gl_allocation_params_free(cast[ptr GLAllocationParams00](self.impl))

proc finalizerfree*(self: GLAllocationParams) =
  if not self.ignoreFinalizer:
    gst_gl_allocation_params_free(cast[ptr GLAllocationParams00](self.impl))

proc gst_gl_allocation_params_copy_data(self: ptr GLAllocationParams00; dest: ptr GLAllocationParams00) {.
    importc, libprag.}

proc copyData*(self: GLAllocationParams; dest: GLAllocationParams) =
  gst_gl_allocation_params_copy_data(cast[ptr GLAllocationParams00](self.impl), cast[ptr GLAllocationParams00](dest.impl))

proc gst_gl_allocation_params_copy(self: ptr GLAllocationParams00): ptr GLAllocationParams00 {.
    importc, libprag.}

proc copy*(self: GLAllocationParams): GLAllocationParams =
  fnew(result, gBoxedFreeGstGLAllocationParams)
  result.impl = gst_gl_allocation_params_copy(cast[ptr GLAllocationParams00](self.impl))

proc gst_gl_allocation_params_free_data(self: ptr GLAllocationParams00) {.
    importc, libprag.}

proc freeData*(self: GLAllocationParams) =
  gst_gl_allocation_params_free_data(cast[ptr GLAllocationParams00](self.impl))

type
  GLAllocationParamsCopyFunc* = proc (src: ptr GLAllocationParams00; dest: ptr GLAllocationParams00) {.cdecl.}

type
  GLAllocationParamsFreeFunc* = proc (params: pointer) {.cdecl.}

type
  GLAsyncDebug00* {.pure.} = object
  GLAsyncDebug* = ref object
    impl*: ptr GLAsyncDebug00
    ignoreFinalizer*: bool

proc gst_gl_async_debug_free(self: ptr GLAsyncDebug00) {.
    importc, libprag.}

proc free*(self: GLAsyncDebug) =
  gst_gl_async_debug_free(cast[ptr GLAsyncDebug00](self.impl))

proc finalizerfree*(self: GLAsyncDebug) =
  if not self.ignoreFinalizer:
    gst_gl_async_debug_free(cast[ptr GLAsyncDebug00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLAsyncDebug()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_gl_async_debug_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var GLAsyncDebug) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_gl_async_debug_freeze(self: ptr GLAsyncDebug00) {.
    importc, libprag.}

proc freeze*(self: GLAsyncDebug) =
  gst_gl_async_debug_freeze(cast[ptr GLAsyncDebug00](self.impl))

proc gst_gl_async_debug_init(self: ptr GLAsyncDebug00) {.
    importc, libprag.}

proc init*(self: GLAsyncDebug) =
  gst_gl_async_debug_init(cast[ptr GLAsyncDebug00](self.impl))

proc gst_gl_async_debug_output_log_msg(self: ptr GLAsyncDebug00) {.
    importc, libprag.}

proc outputLogMsg*(self: GLAsyncDebug) =
  gst_gl_async_debug_output_log_msg(cast[ptr GLAsyncDebug00](self.impl))

proc gst_gl_async_debug_thaw(self: ptr GLAsyncDebug00) {.
    importc, libprag.}

proc thaw*(self: GLAsyncDebug) =
  gst_gl_async_debug_thaw(cast[ptr GLAsyncDebug00](self.impl))

proc gst_gl_async_debug_unset(self: ptr GLAsyncDebug00) {.
    importc, libprag.}

proc unset*(self: GLAsyncDebug) =
  gst_gl_async_debug_unset(cast[ptr GLAsyncDebug00](self.impl))

type
  GLAsyncDebugLogGetMessage* = proc (userData: pointer): cstring {.cdecl.}

type
  GLBaseFilter* = ref object of gstbase.BaseTransform
  GLBaseFilter00* = object of gstbase.BaseTransform00

proc gst_gl_base_filter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLBaseFilter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_base_filter_find_gl_context(self: ptr GLBaseFilter00): gboolean {.
    importc, libprag.}

proc findGlContext*(self: GLBaseFilter): bool =
  toBool(gst_gl_base_filter_find_gl_context(cast[ptr GLBaseFilter00](self.impl)))

type
  GLContext* = ref object of gst.Object
  GLContext00* = object of gst.Object00

proc gst_gl_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc defaultGetProcAddress*(glApi: GLAPI; name: cstring): pointer {.
    importc: "gst_gl_context_default_get_proc_address", libprag.}

proc gst_gl_context_get_current(): ptr GLContext00 {.
    importc, libprag.}

proc getCurrent*(): GLContext =
  let gobj = gst_gl_context_get_current()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_context_activate(self: ptr GLContext00; activate: gboolean): gboolean {.
    importc, libprag.}

proc activate*(self: GLContext; activate: bool): bool =
  toBool(gst_gl_context_activate(cast[ptr GLContext00](self.impl), gboolean(activate)))

proc gst_gl_context_can_share(self: ptr GLContext00; otherContext: ptr GLContext00): gboolean {.
    importc, libprag.}

proc canShare*(self: GLContext; otherContext: GLContext): bool =
  toBool(gst_gl_context_can_share(cast[ptr GLContext00](self.impl), cast[ptr GLContext00](otherContext.impl)))

proc gst_gl_context_check_feature(self: ptr GLContext00; feature: cstring): gboolean {.
    importc, libprag.}

proc checkFeature*(self: GLContext; feature: cstring): bool =
  toBool(gst_gl_context_check_feature(cast[ptr GLContext00](self.impl), feature))

proc gst_gl_context_check_framebuffer_status(self: ptr GLContext00; fboTarget: uint32): gboolean {.
    importc, libprag.}

proc checkFramebufferStatus*(self: GLContext; fboTarget: int): bool =
  toBool(gst_gl_context_check_framebuffer_status(cast[ptr GLContext00](self.impl), uint32(fboTarget)))

proc gst_gl_context_check_gl_version(self: ptr GLContext00; api: GLAPI; maj: int32;
    min: int32): gboolean {.
    importc, libprag.}

proc checkGlVersion*(self: GLContext; api: GLAPI; maj: int;
    min: int): bool =
  toBool(gst_gl_context_check_gl_version(cast[ptr GLContext00](self.impl), api, int32(maj), int32(min)))

proc gst_gl_context_clear_framebuffer(self: ptr GLContext00) {.
    importc, libprag.}

proc clearFramebuffer*(self: GLContext) =
  gst_gl_context_clear_framebuffer(cast[ptr GLContext00](self.impl))

proc gst_gl_context_clear_shader(self: ptr GLContext00) {.
    importc, libprag.}

proc clearShader*(self: GLContext) =
  gst_gl_context_clear_shader(cast[ptr GLContext00](self.impl))

proc gst_gl_context_create(self: ptr GLContext00; otherContext: ptr GLContext00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc create*(self: GLContext; otherContext: GLContext = nil): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_gl_context_create(cast[ptr GLContext00](self.impl), if otherContext.isNil: nil else: cast[ptr GLContext00](otherContext.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_gl_context_destroy(self: ptr GLContext00) {.
    importc, libprag.}

proc destroy*(self: GLContext) =
  gst_gl_context_destroy(cast[ptr GLContext00](self.impl))

proc gst_gl_context_fill_info(self: ptr GLContext00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc fillInfo*(self: GLContext): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_gl_context_fill_info(cast[ptr GLContext00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_gl_context_get_gl_api(self: ptr GLContext00): GLAPI {.
    importc, libprag.}

proc getGlApi*(self: GLContext): GLAPI =
  gst_gl_context_get_gl_api(cast[ptr GLContext00](self.impl))

proc glApi*(self: GLContext): GLAPI =
  gst_gl_context_get_gl_api(cast[ptr GLContext00](self.impl))

proc gst_gl_context_get_gl_context(self: ptr GLContext00): uint64 {.
    importc, libprag.}

proc getGlContext*(self: GLContext): uint64 =
  gst_gl_context_get_gl_context(cast[ptr GLContext00](self.impl))

proc glContext*(self: GLContext): uint64 =
  gst_gl_context_get_gl_context(cast[ptr GLContext00](self.impl))

proc gst_gl_context_get_gl_platform_version(self: ptr GLContext00; major: var int32;
    minor: var int32) {.
    importc, libprag.}

proc getGlPlatformVersion*(self: GLContext; major: var int;
    minor: var int) =
  var major_00: int32
  var minor_00: int32
  gst_gl_context_get_gl_platform_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc gst_gl_context_get_gl_version(self: ptr GLContext00; maj: var int32;
    min: var int32) {.
    importc, libprag.}

proc getGlVersion*(self: GLContext; maj: var int; min: var int) =
  var maj_00: int32
  var min_00: int32
  gst_gl_context_get_gl_version(cast[ptr GLContext00](self.impl), maj_00, min_00)
  if maj.addr != nil:
    maj = int(maj_00)
  if min.addr != nil:
    min = int(min_00)

proc gst_gl_context_get_proc_address(self: ptr GLContext00; name: cstring): pointer {.
    importc, libprag.}

proc getProcAddress*(self: GLContext; name: cstring): pointer =
  gst_gl_context_get_proc_address(cast[ptr GLContext00](self.impl), name)

proc gst_gl_context_get_thread(self: ptr GLContext00): ptr glib.Thread00 {.
    importc, libprag.}

proc getThread*(self: GLContext): glib.Thread =
  fnew(result, gBoxedFreeGThread)
  result.impl = gst_gl_context_get_thread(cast[ptr GLContext00](self.impl))

proc thread*(self: GLContext): glib.Thread =
  fnew(result, gBoxedFreeGThread)
  result.impl = gst_gl_context_get_thread(cast[ptr GLContext00](self.impl))

proc gst_gl_context_is_shared(self: ptr GLContext00): gboolean {.
    importc, libprag.}

proc isShared*(self: GLContext): bool =
  toBool(gst_gl_context_is_shared(cast[ptr GLContext00](self.impl)))

proc gst_gl_context_set_shared_with(self: ptr GLContext00; share: ptr GLContext00) {.
    importc, libprag.}

proc setSharedWith*(self: GLContext; share: GLContext) =
  gst_gl_context_set_shared_with(cast[ptr GLContext00](self.impl), cast[ptr GLContext00](share.impl))

proc `sharedWith=`*(self: GLContext; share: GLContext) =
  gst_gl_context_set_shared_with(cast[ptr GLContext00](self.impl), cast[ptr GLContext00](share.impl))

proc gst_gl_context_swap_buffers(self: ptr GLContext00) {.
    importc, libprag.}

proc swapBuffers*(self: GLContext) =
  gst_gl_context_swap_buffers(cast[ptr GLContext00](self.impl))

proc gst_gl_base_filter_get_gl_context(self: ptr GLBaseFilter00): ptr GLContext00 {.
    importc, libprag.}

proc getGlContext*(self: GLBaseFilter): GLContext =
  let gobj = gst_gl_base_filter_get_gl_context(cast[ptr GLBaseFilter00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc glContext*(self: GLBaseFilter): GLContext =
  let gobj = gst_gl_base_filter_get_gl_context(cast[ptr GLBaseFilter00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GLDisplay* = ref object of gst.Object
  GLDisplay00* = object of gst.Object00

proc gst_gl_display_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLDisplay()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCreateContext*(self: GLDisplay;  p: proc (self: ptr GLDisplay00; context: ptr GLContext00; xdata: pointer): GLContext00 {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "create-context", cast[GCallback](p), xdata, nil, cf)

proc gst_gl_display_new(): ptr GLDisplay00 {.
    importc, libprag.}

proc newGLDisplay*(): GLDisplay =
  let gobj = gst_gl_display_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLDisplay*(tdesc: typedesc): tdesc =
  assert(result is GLDisplay)
  let gobj = gst_gl_display_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLDisplay*[T](result: var T) {.deprecated.} =
  assert(result is GLDisplay)
  let gobj = gst_gl_display_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_display_add_context(self: ptr GLDisplay00; context: ptr GLContext00): gboolean {.
    importc, libprag.}

proc addContext*(self: GLDisplay; context: GLContext): bool =
  toBool(gst_gl_display_add_context(cast[ptr GLDisplay00](self.impl), cast[ptr GLContext00](context.impl)))

proc gst_gl_display_create_context(self: ptr GLDisplay00; otherContext: ptr GLContext00;
    pContext: var ptr GLContext00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc createContext*(self: GLDisplay; otherContext: GLContext;
    pContext: var GLContext): bool =
  var tmpoutgobjectarg: ptr GLContext00
  var gerror: ptr glib.Error
  let resul0 = gst_gl_display_create_context(cast[ptr GLDisplay00](self.impl), cast[ptr GLContext00](otherContext.impl), tmpoutgobjectarg, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
#  dothemagic(pContext
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    pContext = cast[type(pContext)](argqdata)
    assert(pContext.impl == tmpoutgobjectarg)
  else:
    fnew(pContext, gstgl.finalizeGObject)
    pContext.impl = tmpoutgobjectarg
    GC_ref(pContext)
    if g_object_is_floating(pContext.impl).int != 0:
      discard g_object_ref_sink(pContext.impl)
    g_object_add_toggle_ref(pContext.impl, toggleNotify, addr(pContext[]))
    g_object_unref(pContext.impl)
    assert(g_object_get_qdata(pContext.impl, Quark) == nil)
    g_object_set_qdata(pContext.impl, Quark, addr(pContext[]))


proc gst_gl_display_filter_gl_api(self: ptr GLDisplay00; glApi: GLAPI) {.
    importc, libprag.}

proc filterGlApi*(self: GLDisplay; glApi: GLAPI) =
  gst_gl_display_filter_gl_api(cast[ptr GLDisplay00](self.impl), glApi)

proc gst_gl_display_get_gl_api(self: ptr GLDisplay00): GLAPI {.
    importc, libprag.}

proc getGlApi*(self: GLDisplay): GLAPI =
  gst_gl_display_get_gl_api(cast[ptr GLDisplay00](self.impl))

proc glApi*(self: GLDisplay): GLAPI =
  gst_gl_display_get_gl_api(cast[ptr GLDisplay00](self.impl))

proc gst_gl_display_get_gl_api_unlocked(self: ptr GLDisplay00): GLAPI {.
    importc, libprag.}

proc getGlApiUnlocked*(self: GLDisplay): GLAPI =
  gst_gl_display_get_gl_api_unlocked(cast[ptr GLDisplay00](self.impl))

proc glApiUnlocked*(self: GLDisplay): GLAPI =
  gst_gl_display_get_gl_api_unlocked(cast[ptr GLDisplay00](self.impl))

proc gst_gl_display_get_gl_context_for_thread(self: ptr GLDisplay00; thread: ptr glib.Thread00): ptr GLContext00 {.
    importc, libprag.}

proc getGlContextForThread*(self: GLDisplay; thread: glib.Thread): GLContext =
  let gobj = gst_gl_display_get_gl_context_for_thread(cast[ptr GLDisplay00](self.impl), cast[ptr glib.Thread00](thread.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_display_get_handle(self: ptr GLDisplay00): uint64 {.
    importc, libprag.}

proc getHandle*(self: GLDisplay): uint64 =
  gst_gl_display_get_handle(cast[ptr GLDisplay00](self.impl))

proc handle*(self: GLDisplay): uint64 =
  gst_gl_display_get_handle(cast[ptr GLDisplay00](self.impl))

proc gst_gl_display_remove_context(self: ptr GLDisplay00; context: ptr GLContext00) {.
    importc, libprag.}

proc removeContext*(self: GLDisplay; context: GLContext) =
  gst_gl_display_remove_context(cast[ptr GLDisplay00](self.impl), cast[ptr GLContext00](context.impl))

proc gst_gl_context_new(display: ptr GLDisplay00): ptr GLContext00 {.
    importc, libprag.}

proc newGLContext*(display: GLDisplay): GLContext =
  let gobj = gst_gl_context_new(cast[ptr GLDisplay00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLContext*(tdesc: typedesc; display: GLDisplay): tdesc =
  assert(result is GLContext)
  let gobj = gst_gl_context_new(cast[ptr GLDisplay00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLContext*[T](result: var T; display: GLDisplay) {.deprecated.} =
  assert(result is GLContext)
  let gobj = gst_gl_context_new(cast[ptr GLDisplay00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_context_get_display(self: ptr GLContext00): ptr GLDisplay00 {.
    importc, libprag.}

proc getDisplay*(self: GLContext): GLDisplay =
  let gobj = gst_gl_context_get_display(cast[ptr GLContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc display*(self: GLContext): GLDisplay =
  let gobj = gst_gl_context_get_display(cast[ptr GLContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GLDisplayType* {.size: sizeof(cint), pure.} = enum
    none = 0
    x11 = 1
    wayland = 2
    cocoa = 4
    win32 = 8
    dispmanx = 16
    egl = 32
    vivFb = 64
    gbm = 128
    eglDevice = 256
    any = 4294967295

proc gst_gl_display_get_handle_type(self: ptr GLDisplay00): GLDisplayType {.
    importc, libprag.}

proc getHandleType*(self: GLDisplay): GLDisplayType =
  gst_gl_display_get_handle_type(cast[ptr GLDisplay00](self.impl))

proc handleType*(self: GLDisplay): GLDisplayType =
  gst_gl_display_get_handle_type(cast[ptr GLDisplay00](self.impl))

type
  GLPlatform* {.size: sizeof(cint), pure.} = enum
    none = 0
    egl = 1
    glx = 2
    wgl = 4
    cgl = 8
    eagl = 16
    any = 4294967295

proc fromStringGLPlatform*(platformS: cstring): GLPlatform {.
    importc: "gst_gl_platform_from_string", libprag.}

proc gst_gl_platform_to_string(platform: GLPlatform): cstring {.
    importc, libprag.}

proc toString*(platform: GLPlatform): string =
  let resul0 = gst_gl_platform_to_string(platform)
  result = $resul0
  cogfree(resul0)

proc gst_gl_context_new_wrapped(display: ptr GLDisplay00; handle: uint64;
    contextType: GLPlatform; availableApis: GLAPI): ptr GLContext00 {.
    importc, libprag.}

proc newGLContextWrapped*(display: GLDisplay; handle: uint64; contextType: GLPlatform;
    availableApis: GLAPI): GLContext =
  let gobj = gst_gl_context_new_wrapped(cast[ptr GLDisplay00](display.impl), handle, contextType, availableApis)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLContextWrapped*(tdesc: typedesc; display: GLDisplay; handle: uint64; contextType: GLPlatform;
    availableApis: GLAPI): tdesc =
  assert(result is GLContext)
  let gobj = gst_gl_context_new_wrapped(cast[ptr GLDisplay00](display.impl), handle, contextType, availableApis)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLContextWrapped*[T](result: var T; display: GLDisplay; handle: uint64; contextType: GLPlatform;
    availableApis: GLAPI) {.deprecated.} =
  assert(result is GLContext)
  let gobj = gst_gl_context_new_wrapped(cast[ptr GLDisplay00](display.impl), handle, contextType, availableApis)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_context_get_current_gl_api(platform: GLPlatform; major: var uint32;
    minor: var uint32): GLAPI {.
    importc, libprag.}

proc getCurrentGlApi*(platform: GLPlatform; major: var int = cast[var int](nil);
    minor: var int = cast[var int](nil)): GLAPI =
  var major_00: uint32
  var minor_00: uint32
  result = gst_gl_context_get_current_gl_api(platform, major_00, minor_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)

proc getCurrentGlContext*(contextType: GLPlatform): uint64 {.
    importc: "gst_gl_context_get_current_gl_context", libprag.}

proc currentGlContext*(contextType: GLPlatform): uint64 {.
    importc: "gst_gl_context_get_current_gl_context", libprag.}

proc getProcAddressWithPlatform*(contextType: GLPlatform;
    glApi: GLAPI; name: cstring): pointer {.
    importc: "gst_gl_context_get_proc_address_with_platform", libprag.}

proc gst_gl_context_get_gl_platform(self: ptr GLContext00): GLPlatform {.
    importc, libprag.}

proc getGlPlatform*(self: GLContext): GLPlatform =
  gst_gl_context_get_gl_platform(cast[ptr GLContext00](self.impl))

proc glPlatform*(self: GLContext): GLPlatform =
  gst_gl_context_get_gl_platform(cast[ptr GLContext00](self.impl))

type
  GLWindow* = ref object of gst.Object
  GLWindow00* = object of gst.Object00

proc gst_gl_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLWindow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scKeyEvent*(self: GLWindow;  p: proc (self: ptr GLWindow00; id: cstring; key: cstring; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "key-event", cast[GCallback](p), xdata, nil, cf)

proc scMouseEvent*(self: GLWindow;  p: proc (self: ptr GLWindow00; id: cstring; button: int32; x: cdouble; y: cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "mouse-event", cast[GCallback](p), xdata, nil, cf)

proc scScrollEvent*(self: GLWindow;  p: proc (self: ptr GLWindow00; x: cdouble; y: cdouble; deltaX: cdouble; deltaY: cdouble; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "scroll-event", cast[GCallback](p), xdata, nil, cf)

proc gst_gl_window_new(display: ptr GLDisplay00): ptr GLWindow00 {.
    importc, libprag.}

proc newGLWindow*(display: GLDisplay): GLWindow =
  let gobj = gst_gl_window_new(cast[ptr GLDisplay00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLWindow*(tdesc: typedesc; display: GLDisplay): tdesc =
  assert(result is GLWindow)
  let gobj = gst_gl_window_new(cast[ptr GLDisplay00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLWindow*[T](result: var T; display: GLDisplay) {.deprecated.} =
  assert(result is GLWindow)
  let gobj = gst_gl_window_new(cast[ptr GLDisplay00](display.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_window_controls_viewport(self: ptr GLWindow00): gboolean {.
    importc, libprag.}

proc controlsViewport*(self: GLWindow): bool =
  toBool(gst_gl_window_controls_viewport(cast[ptr GLWindow00](self.impl)))

proc gst_gl_window_draw(self: ptr GLWindow00) {.
    importc, libprag.}

proc draw*(self: GLWindow) =
  gst_gl_window_draw(cast[ptr GLWindow00](self.impl))

proc gst_gl_window_get_context(self: ptr GLWindow00): ptr GLContext00 {.
    importc, libprag.}

proc getContext*(self: GLWindow): GLContext =
  let gobj = gst_gl_window_get_context(cast[ptr GLWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc context*(self: GLWindow): GLContext =
  let gobj = gst_gl_window_get_context(cast[ptr GLWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_window_get_display(self: ptr GLWindow00): uint64 {.
    importc, libprag.}

proc getDisplay*(self: GLWindow): uint64 =
  gst_gl_window_get_display(cast[ptr GLWindow00](self.impl))

proc display*(self: GLWindow): uint64 =
  gst_gl_window_get_display(cast[ptr GLWindow00](self.impl))

proc gst_gl_window_get_surface_dimensions(self: ptr GLWindow00; width: var uint32;
    height: var uint32) {.
    importc, libprag.}

proc getSurfaceDimensions*(self: GLWindow; width: var int;
    height: var int) =
  var width_00: uint32
  var height_00: uint32
  gst_gl_window_get_surface_dimensions(cast[ptr GLWindow00](self.impl), width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc gst_gl_window_get_window_handle(self: ptr GLWindow00): uint64 {.
    importc, libprag.}

proc getWindowHandle*(self: GLWindow): uint64 =
  gst_gl_window_get_window_handle(cast[ptr GLWindow00](self.impl))

proc windowHandle*(self: GLWindow): uint64 =
  gst_gl_window_get_window_handle(cast[ptr GLWindow00](self.impl))

proc gst_gl_window_handle_events(self: ptr GLWindow00; handleEvents: gboolean) {.
    importc, libprag.}

proc handleEvents*(self: GLWindow; handleEvents: bool) =
  gst_gl_window_handle_events(cast[ptr GLWindow00](self.impl), gboolean(handleEvents))

proc gst_gl_window_has_output_surface(self: ptr GLWindow00): gboolean {.
    importc, libprag.}

proc hasOutputSurface*(self: GLWindow): bool =
  toBool(gst_gl_window_has_output_surface(cast[ptr GLWindow00](self.impl)))

proc gst_gl_window_queue_resize(self: ptr GLWindow00) {.
    importc, libprag.}

proc queueResize*(self: GLWindow) =
  gst_gl_window_queue_resize(cast[ptr GLWindow00](self.impl))

proc gst_gl_window_quit(self: ptr GLWindow00) {.
    importc, libprag.}

proc quit*(self: GLWindow) =
  gst_gl_window_quit(cast[ptr GLWindow00](self.impl))

proc gst_gl_window_resize(self: ptr GLWindow00; width: uint32; height: uint32) {.
    importc, libprag.}

proc resize*(self: GLWindow; width: int; height: int) =
  gst_gl_window_resize(cast[ptr GLWindow00](self.impl), uint32(width), uint32(height))

proc gst_gl_window_run(self: ptr GLWindow00) {.
    importc, libprag.}

proc run*(self: GLWindow) =
  gst_gl_window_run(cast[ptr GLWindow00](self.impl))

proc gst_gl_window_send_key_event(self: ptr GLWindow00; eventType: cstring;
    keyStr: cstring) {.
    importc, libprag.}

proc sendKeyEvent*(self: GLWindow; eventType: cstring; keyStr: cstring) =
  gst_gl_window_send_key_event(cast[ptr GLWindow00](self.impl), eventType, keyStr)

proc gst_gl_window_send_mouse_event(self: ptr GLWindow00; eventType: cstring;
    button: int32; posx: cdouble; posy: cdouble) {.
    importc, libprag.}

proc sendMouseEvent*(self: GLWindow; eventType: cstring; button: int;
    posx: cdouble; posy: cdouble) =
  gst_gl_window_send_mouse_event(cast[ptr GLWindow00](self.impl), eventType, int32(button), posx, posy)

proc gst_gl_window_send_scroll_event(self: ptr GLWindow00; posx: cdouble;
    posy: cdouble; deltaX: cdouble; deltaY: cdouble) {.
    importc, libprag.}

proc sendScrollEvent*(self: GLWindow; posx: cdouble; posy: cdouble;
    deltaX: cdouble; deltaY: cdouble) =
  gst_gl_window_send_scroll_event(cast[ptr GLWindow00](self.impl), posx, posy, deltaX, deltaY)

proc gst_gl_window_set_preferred_size(self: ptr GLWindow00; width: int32;
    height: int32) {.
    importc, libprag.}

proc setPreferredSize*(self: GLWindow; width: int; height: int) =
  gst_gl_window_set_preferred_size(cast[ptr GLWindow00](self.impl), int32(width), int32(height))

proc gst_gl_window_set_render_rectangle(self: ptr GLWindow00; x: int32; y: int32;
    width: int32; height: int32): gboolean {.
    importc, libprag.}

proc setRenderRectangle*(self: GLWindow; x: int; y: int; width: int;
    height: int): bool =
  toBool(gst_gl_window_set_render_rectangle(cast[ptr GLWindow00](self.impl), int32(x), int32(y), int32(width), int32(height)))

proc gst_gl_window_set_window_handle(self: ptr GLWindow00; handle: uint64) {.
    importc, libprag.}

proc setWindowHandle*(self: GLWindow; handle: uint64) =
  gst_gl_window_set_window_handle(cast[ptr GLWindow00](self.impl), handle)

proc `windowHandle=`*(self: GLWindow; handle: uint64) =
  gst_gl_window_set_window_handle(cast[ptr GLWindow00](self.impl), handle)

proc gst_gl_window_show(self: ptr GLWindow00) {.
    importc, libprag.}

proc show*(self: GLWindow) =
  gst_gl_window_show(cast[ptr GLWindow00](self.impl))

proc gst_gl_context_get_window(self: ptr GLContext00): ptr GLWindow00 {.
    importc, libprag.}

proc getWindow*(self: GLContext): GLWindow =
  let gobj = gst_gl_context_get_window(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc window*(self: GLContext): GLWindow =
  let gobj = gst_gl_context_get_window(cast[ptr GLContext00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_context_set_window(self: ptr GLContext00; window: ptr GLWindow00): gboolean {.
    importc, libprag.}

proc setWindow*(self: GLContext; window: GLWindow): bool =
  toBool(gst_gl_context_set_window(cast[ptr GLContext00](self.impl), cast[ptr GLWindow00](g_object_ref(window.impl))))

proc gst_gl_display_create_window(self: ptr GLDisplay00): ptr GLWindow00 {.
    importc, libprag.}

proc createWindow*(self: GLDisplay): GLWindow =
  let gobj = gst_gl_display_create_window(cast[ptr GLDisplay00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_display_find_window(self: ptr GLDisplay00; data: pointer; compareFunc: CompareFunc): ptr GLWindow00 {.
    importc, libprag.}

proc findWindow*(self: GLDisplay; data: pointer; compareFunc: CompareFunc): GLWindow =
  let gobj = gst_gl_display_find_window(cast[ptr GLDisplay00](self.impl), data, compareFunc)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_display_remove_window(self: ptr GLDisplay00; window: ptr GLWindow00): gboolean {.
    importc, libprag.}

proc removeWindow*(self: GLDisplay; window: GLWindow): bool =
  toBool(gst_gl_display_remove_window(cast[ptr GLDisplay00](self.impl), cast[ptr GLWindow00](window.impl)))

proc gst_gl_display_retrieve_window(self: ptr GLDisplay00; data: pointer;
    compareFunc: CompareFunc): ptr GLWindow00 {.
    importc, libprag.}

proc retrieveWindow*(self: GLDisplay; data: pointer; compareFunc: CompareFunc): GLWindow =
  let gobj = gst_gl_display_retrieve_window(cast[ptr GLDisplay00](self.impl), data, compareFunc)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GLSLVersion* {.size: sizeof(cint), pure.} = enum
    none = 0
    enum100 = 100
    enum110 = 110
    enum120 = 120
    enum130 = 130
    enum140 = 140
    enum150 = 150
    enum300 = 300
    enum310 = 310
    enum320 = 320
    enum330 = 330
    enum400 = 400
    enum410 = 410
    enum420 = 420
    enum430 = 430
    enum440 = 440
    enum450 = 450

proc fromStringGLSLVersion*(string: cstring): GLSLVersion {.
    importc: "gst_glsl_version_from_string", libprag.}

proc gst_glsl_version_to_string(version: GLSLVersion): cstring {.
    importc, libprag.}

proc toString*(version: GLSLVersion): string =
  let resul0 = gst_glsl_version_to_string(version)
  if resul0.isNil:
    return
  result = $resul0

type
  GLSLProfile* {.size: sizeof(cint), pure.} = enum
    none = 0
    es = 1
    core = 2
    compatibility = 4
    any = 4294967295

proc fromStringGLSLProfile*(string: cstring): GLSLProfile {.
    importc: "gst_glsl_profile_from_string", libprag.}

proc gst_glsl_profile_to_string(profile: GLSLProfile): cstring {.
    importc, libprag.}

proc toString*(profile: GLSLProfile): string =
  let resul0 = gst_glsl_profile_to_string(profile)
  if resul0.isNil:
    return
  result = $resul0

proc gst_gl_context_supports_glsl_profile_version(self: ptr GLContext00;
    version: GLSLVersion; profile: GLSLProfile): gboolean {.
    importc, libprag.}

proc supportsGlslProfileVersion*(self: GLContext; version: GLSLVersion;
    profile: GLSLProfile): bool =
  toBool(gst_gl_context_supports_glsl_profile_version(cast[ptr GLContext00](self.impl), version, profile))

proc gst_gl_context_supports_precision(self: ptr GLContext00; version: GLSLVersion;
    profile: GLSLProfile): gboolean {.
    importc, libprag.}

proc supportsPrecision*(self: GLContext; version: GLSLVersion;
    profile: GLSLProfile): bool =
  toBool(gst_gl_context_supports_precision(cast[ptr GLContext00](self.impl), version, profile))

proc gst_gl_context_supports_precision_highp(self: ptr GLContext00; version: GLSLVersion;
    profile: GLSLProfile): gboolean {.
    importc, libprag.}

proc supportsPrecisionHighp*(self: GLContext; version: GLSLVersion;
    profile: GLSLProfile): bool =
  toBool(gst_gl_context_supports_precision_highp(cast[ptr GLContext00](self.impl), version, profile))

proc gst_glsl_version_profile_from_string(string: cstring; versionRet: var GLSLVersion;
    profileRet: var GLSLProfile): gboolean {.
    importc, libprag.}

proc profileFromString*(string: cstring; versionRet: var GLSLVersion;
    profileRet: var GLSLProfile): bool =
  toBool(gst_glsl_version_profile_from_string(string, versionRet, profileRet))

proc gst_glsl_version_profile_to_string(version: GLSLVersion; profile: GLSLProfile): cstring {.
    importc, libprag.}

proc profileToString*(version: GLSLVersion; profile: GLSLProfile): string =
  let resul0 = gst_glsl_version_profile_to_string(version, profile)
  result = $resul0
  cogfree(resul0)

type
  GLBaseMemory00* {.pure.} = object
  GLBaseMemory* = ref object
    impl*: ptr GLBaseMemory00
    ignoreFinalizer*: bool

proc gst_gl_base_memory_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstGLBaseMemory*(self: GLBaseMemory) =
  if not self.ignoreFinalizer:
    boxedFree(gst_gl_base_memory_get_type(), cast[ptr GLBaseMemory00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLBaseMemory()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_gl_base_memory_get_type(), cast[ptr GLBaseMemory00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GLBaseMemory) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstGLBaseMemory)

proc gst_gl_base_memory_alloc_data(self: ptr GLBaseMemory00): gboolean {.
    importc, libprag.}

proc allocData*(self: GLBaseMemory): bool =
  toBool(gst_gl_base_memory_alloc_data(cast[ptr GLBaseMemory00](self.impl)))

proc gst_gl_base_memory_init(self: ptr GLBaseMemory00; allocator: ptr gst.Allocator00;
    parent: ptr gst.Memory00; context: ptr GLContext00; params: ptr gst.AllocationParams00;
    size: uint64; userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc init*(self: GLBaseMemory; allocator: gst.Allocator;
    parent: gst.Memory = nil; context: GLContext; params: gst.AllocationParams = nil;
    size: uint64; userData: pointer; notify: DestroyNotify) =
  gst_gl_base_memory_init(cast[ptr GLBaseMemory00](self.impl), cast[ptr gst.Allocator00](allocator.impl), if parent.isNil: nil else: cast[ptr gst.Memory00](parent.impl), cast[ptr GLContext00](context.impl), if params.isNil: nil else: cast[ptr gst.AllocationParams00](params.impl), size, userData, notify)

proc gst_gl_base_memory_memcpy(self: ptr GLBaseMemory00; dest: ptr GLBaseMemory00;
    offset: int64; size: int64): gboolean {.
    importc, libprag.}

proc memcpy*(self: GLBaseMemory; dest: GLBaseMemory; offset: int64;
    size: int64): bool =
  toBool(gst_gl_base_memory_memcpy(cast[ptr GLBaseMemory00](self.impl), cast[ptr GLBaseMemory00](dest.impl), offset, size))

proc baseMemoryInitOnce*() {.
    importc: "gst_gl_base_memory_init_once", libprag.}

type
  GLBaseMemoryAllocator* = ref object of gst.Allocator
  GLBaseMemoryAllocator00* = object of gst.Allocator00

proc gst_gl_base_memory_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLBaseMemoryAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_base_memory_alloc(allocator: ptr GLBaseMemoryAllocator00; params: ptr GLAllocationParams00): ptr GLBaseMemory00 {.
    importc, libprag.}

proc alloc*(allocator: GLBaseMemoryAllocator; params: GLAllocationParams): GLBaseMemory =
  fnew(result, gBoxedFreeGstGLBaseMemory)
  result.impl = gst_gl_base_memory_alloc(cast[ptr GLBaseMemoryAllocator00](allocator.impl), cast[ptr GLAllocationParams00](params.impl))

type
  GLBaseMemoryAllocatorAllocFunction* = proc (allocator: ptr GLBaseMemoryAllocator00; params: ptr GLAllocationParams00): ptr GLBaseMemory00 {.cdecl.}

type
  GLBaseMemoryAllocatorCopyFunction* = proc (mem: ptr GLBaseMemory00; offset: int64; size: int64): ptr GLBaseMemory00 {.cdecl.}

type
  GLBaseMemoryAllocatorCreateFunction* = proc (mem: ptr GLBaseMemory00; error: ptr ptr glib.Error = nil): gboolean {.cdecl.}

type
  GLBaseMemoryAllocatorDestroyFunction* = proc (mem: ptr GLBaseMemory00) {.cdecl.}

type
  GLBaseMemoryAllocatorMapFunction* = proc (mem: ptr GLBaseMemory00; info: gst.MapInfo; maxsize: uint64): pointer {.cdecl.}

type
  GLBaseMemoryAllocatorUnmapFunction* = proc (mem: ptr GLBaseMemory00; info: gst.MapInfo) {.cdecl.}

type
  GLBaseMemoryError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    oldLibs = 1
    resourceUnavailable = 2

type
  GLBaseMemoryTransfer* {.size: sizeof(cint), pure.} = enum
    download = 1048576
    upload = 2097152

type
  GLBaseSrc* = ref object of gstbase.PushSrc
  GLBaseSrc00* = object of gstbase.PushSrc00

proc gst_gl_base_src_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLBaseSrc()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  GLBuffer00* {.pure.} = object
  GLBuffer* = ref object
    impl*: ptr GLBuffer00
    ignoreFinalizer*: bool

proc bufferInitOnce*() {.
    importc: "gst_gl_buffer_init_once", libprag.}

type
  GLBufferAllocationParams00* {.pure.} = object
  GLBufferAllocationParams* = ref object
    impl*: ptr GLBufferAllocationParams00
    ignoreFinalizer*: bool

proc gst_gl_buffer_allocation_params_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstGLBufferAllocationParams*(self: GLBufferAllocationParams) =
  if not self.ignoreFinalizer:
    boxedFree(gst_gl_buffer_allocation_params_get_type(), cast[ptr GLBufferAllocationParams00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLBufferAllocationParams()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_gl_buffer_allocation_params_get_type(), cast[ptr GLBufferAllocationParams00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GLBufferAllocationParams) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstGLBufferAllocationParams)

proc gst_gl_buffer_allocation_params_new(context: ptr GLContext00; allocSize: uint64;
    allocParams: ptr gst.AllocationParams00; glTarget: uint32; glUsage: uint32): ptr GLBufferAllocationParams00 {.
    importc, libprag.}

proc newGLBufferAllocationParams*(context: GLContext; allocSize: uint64;
    allocParams: gst.AllocationParams = nil; glTarget: int; glUsage: int): GLBufferAllocationParams =
  fnew(result, gBoxedFreeGstGLBufferAllocationParams)
  result.impl = gst_gl_buffer_allocation_params_new(cast[ptr GLContext00](context.impl), allocSize, if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), uint32(glTarget), uint32(glUsage))

proc newGLBufferAllocationParams*(tdesc: typedesc; context: GLContext; allocSize: uint64;
    allocParams: gst.AllocationParams = nil; glTarget: int; glUsage: int): tdesc =
  assert(result is GLBufferAllocationParams)
  fnew(result, gBoxedFreeGstGLBufferAllocationParams)
  result.impl = gst_gl_buffer_allocation_params_new(cast[ptr GLContext00](context.impl), allocSize, if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), uint32(glTarget), uint32(glUsage))

proc initGLBufferAllocationParams*[T](result: var T; context: GLContext; allocSize: uint64;
    allocParams: gst.AllocationParams = nil; glTarget: int; glUsage: int) {.deprecated.} =
  assert(result is GLBufferAllocationParams)
  fnew(result, gBoxedFreeGstGLBufferAllocationParams)
  result.impl = gst_gl_buffer_allocation_params_new(cast[ptr GLContext00](context.impl), allocSize, if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), uint32(glTarget), uint32(glUsage))

type
  GLBufferAllocator* = ref object of GLBaseMemoryAllocator
  GLBufferAllocator00* = object of GLBaseMemoryAllocator00

proc gst_gl_buffer_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLBufferAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  GLBufferPool* = ref object of gst.BufferPool
  GLBufferPool00* = object of gst.BufferPool00

proc gst_gl_buffer_pool_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLBufferPool()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_buffer_pool_new(context: ptr GLContext00): ptr GLBufferPool00 {.
    importc, libprag.}

proc newGLBufferPool*(context: GLContext): GLBufferPool =
  let gobj = gst_gl_buffer_pool_new(cast[ptr GLContext00](context.impl))
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

proc newGLBufferPool*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLBufferPool)
  let gobj = gst_gl_buffer_pool_new(cast[ptr GLContext00](context.impl))
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

proc initGLBufferPool*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLBufferPool)
  let gobj = gst_gl_buffer_pool_new(cast[ptr GLContext00](context.impl))
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
  GLColorConvert* = ref object of gst.Object
  GLColorConvert00* = object of gst.Object00

proc gst_gl_color_convert_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLColorConvert()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_color_convert_new(context: ptr GLContext00): ptr GLColorConvert00 {.
    importc, libprag.}

proc newGLColorConvert*(context: GLContext): GLColorConvert =
  let gobj = gst_gl_color_convert_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLColorConvert*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLColorConvert)
  let gobj = gst_gl_color_convert_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLColorConvert*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLColorConvert)
  let gobj = gst_gl_color_convert_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_color_convert_fixate_caps(context: ptr GLContext00; direction: gst.PadDirection;
    caps: ptr gst.Caps00; other: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc fixateCaps*(context: GLContext; direction: gst.PadDirection;
    caps: gst.Caps; other: gst.Caps): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_gl_color_convert_fixate_caps(cast[ptr GLContext00](context.impl), direction, cast[ptr gst.Caps00](caps.impl), cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), other.impl)))

proc gst_gl_color_convert_transform_caps(context: ptr GLContext00; direction: gst.PadDirection;
    caps: ptr gst.Caps00; filter: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc transformCaps*(context: GLContext; direction: gst.PadDirection;
    caps: gst.Caps; filter: gst.Caps): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_gl_color_convert_transform_caps(cast[ptr GLContext00](context.impl), direction, cast[ptr gst.Caps00](caps.impl), cast[ptr gst.Caps00](filter.impl))

proc gst_gl_color_convert_decide_allocation(self: ptr GLColorConvert00; query: ptr gst.Query00): gboolean {.
    importc, libprag.}

proc decideAllocation*(self: GLColorConvert; query: gst.Query): bool =
  toBool(gst_gl_color_convert_decide_allocation(cast[ptr GLColorConvert00](self.impl), cast[ptr gst.Query00](query.impl)))

proc gst_gl_color_convert_perform(self: ptr GLColorConvert00; inbuf: ptr gst.Buffer00): ptr gst.Buffer00 {.
    importc, libprag.}

proc perform*(self: GLColorConvert; inbuf: gst.Buffer): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_gl_color_convert_perform(cast[ptr GLColorConvert00](self.impl), cast[ptr gst.Buffer00](inbuf.impl))

proc gst_gl_color_convert_set_caps(self: ptr GLColorConvert00; inCaps: ptr gst.Caps00;
    outCaps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc setCaps*(self: GLColorConvert; inCaps: gst.Caps;
    outCaps: gst.Caps): bool =
  toBool(gst_gl_color_convert_set_caps(cast[ptr GLColorConvert00](self.impl), cast[ptr gst.Caps00](inCaps.impl), cast[ptr gst.Caps00](outCaps.impl)))

type
  GLContextError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    wrongConfig = 1
    wrongApi = 2
    oldLibs = 3
    createContext = 4
    resourceUnavailable = 5

type
  GLContextThreadFunc* = proc (context: ptr GLContext00; data: pointer) {.cdecl.}

proc gst_gl_context_thread_add(self: ptr GLContext00; `func`: GLContextThreadFunc;
    data: pointer) {.
    importc, libprag.}

proc threadAdd*(self: GLContext; `func`: GLContextThreadFunc;
    data: pointer) =
  gst_gl_context_thread_add(cast[ptr GLContext00](self.impl), `func`, data)

type
  GLFilter* = ref object of GLBaseFilter
  GLFilter00* = object of GLBaseFilter00

proc gst_gl_filter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLFilter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_filter_draw_fullscreen_quad(self: ptr GLFilter00) {.
    importc, libprag.}

proc drawFullscreenQuad*(self: GLFilter) =
  gst_gl_filter_draw_fullscreen_quad(cast[ptr GLFilter00](self.impl))

proc gst_gl_filter_filter_texture(self: ptr GLFilter00; input: ptr gst.Buffer00;
    output: ptr gst.Buffer00): gboolean {.
    importc, libprag.}

proc filterTexture*(self: GLFilter; input: gst.Buffer; output: gst.Buffer): bool =
  toBool(gst_gl_filter_filter_texture(cast[ptr GLFilter00](self.impl), cast[ptr gst.Buffer00](input.impl), cast[ptr gst.Buffer00](output.impl)))

type
  GLMemory00* {.pure.} = object
  GLMemory* = ref object
    impl*: ptr GLMemory00
    ignoreFinalizer*: bool

proc gst_gl_memory_get_texture_height(self: ptr GLMemory00): int32 {.
    importc, libprag.}

proc getTextureHeight*(self: GLMemory): int =
  int(gst_gl_memory_get_texture_height(cast[ptr GLMemory00](self.impl)))

proc textureHeight*(self: GLMemory): int =
  int(gst_gl_memory_get_texture_height(cast[ptr GLMemory00](self.impl)))

proc gst_gl_memory_get_texture_id(self: ptr GLMemory00): uint32 {.
    importc, libprag.}

proc getTextureId*(self: GLMemory): int =
  int(gst_gl_memory_get_texture_id(cast[ptr GLMemory00](self.impl)))

proc textureId*(self: GLMemory): int =
  int(gst_gl_memory_get_texture_id(cast[ptr GLMemory00](self.impl)))

proc gst_gl_memory_get_texture_width(self: ptr GLMemory00): int32 {.
    importc, libprag.}

proc getTextureWidth*(self: GLMemory): int =
  int(gst_gl_memory_get_texture_width(cast[ptr GLMemory00](self.impl)))

proc textureWidth*(self: GLMemory): int =
  int(gst_gl_memory_get_texture_width(cast[ptr GLMemory00](self.impl)))

proc gst_gl_memory_read_pixels(self: ptr GLMemory00; writePointer: pointer): gboolean {.
    importc, libprag.}

proc readPixels*(self: GLMemory; writePointer: pointer): bool =
  toBool(gst_gl_memory_read_pixels(cast[ptr GLMemory00](self.impl), writePointer))

proc gst_gl_memory_texsubimage(self: ptr GLMemory00; readPointer: pointer) {.
    importc, libprag.}

proc texsubimage*(self: GLMemory; readPointer: pointer) =
  gst_gl_memory_texsubimage(cast[ptr GLMemory00](self.impl), readPointer)

proc memoryInitOnce*() {.
    importc: "gst_gl_memory_init_once", libprag.}

type
  GLShader* = ref object of gst.Object
  GLShader00* = object of gst.Object00

proc gst_gl_shader_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLShader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_shader_new(context: ptr GLContext00): ptr GLShader00 {.
    importc, libprag.}

proc newGLShader*(context: GLContext): GLShader =
  let gobj = gst_gl_shader_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLShader*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLShader)
  let gobj = gst_gl_shader_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLShader*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLShader)
  let gobj = gst_gl_shader_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_shader_new_default(context: ptr GLContext00; error: ptr ptr glib.Error = nil): ptr GLShader00 {.
    importc, libprag.}

proc newGLShaderDefault*(context: GLContext): GLShader =
  var gerror: ptr glib.Error
  let gobj = gst_gl_shader_new_default(cast[ptr GLContext00](context.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLShaderDefault*(tdesc: typedesc; context: GLContext): tdesc =
  var gerror: ptr glib.Error
  assert(result is GLShader)
  let gobj = gst_gl_shader_new_default(cast[ptr GLContext00](context.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLShaderDefault*[T](result: var T; context: GLContext) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is GLShader)
  let gobj = gst_gl_shader_new_default(cast[ptr GLContext00](context.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_shader_string_fragment_external_oes_get_default(context: ptr GLContext00;
    version: GLSLVersion; profile: GLSLProfile): cstring {.
    importc, libprag.}

proc stringFragmentExternalOesGetDefault*(context: GLContext;
    version: GLSLVersion; profile: GLSLProfile): string =
  let resul0 = gst_gl_shader_string_fragment_external_oes_get_default(cast[ptr GLContext00](context.impl), version, profile)
  result = $resul0
  cogfree(resul0)

proc gst_gl_shader_string_fragment_get_default(context: ptr GLContext00;
    version: GLSLVersion; profile: GLSLProfile): cstring {.
    importc, libprag.}

proc stringFragmentGetDefault*(context: GLContext; version: GLSLVersion;
    profile: GLSLProfile): string =
  let resul0 = gst_gl_shader_string_fragment_get_default(cast[ptr GLContext00](context.impl), version, profile)
  result = $resul0
  cogfree(resul0)

proc gst_gl_shader_string_get_highest_precision(context: ptr GLContext00;
    version: GLSLVersion; profile: GLSLProfile): cstring {.
    importc, libprag.}

proc stringGetHighestPrecision*(context: GLContext; version: GLSLVersion;
    profile: GLSLProfile): string =
  result = $gst_gl_shader_string_get_highest_precision(cast[ptr GLContext00](context.impl), version, profile)

proc gst_gl_shader_bind_attribute_location(self: ptr GLShader00; index: uint32;
    name: cstring) {.
    importc, libprag.}

proc bindAttributeLocation*(self: GLShader; index: int; name: cstring) =
  gst_gl_shader_bind_attribute_location(cast[ptr GLShader00](self.impl), uint32(index), name)

proc gst_gl_shader_bind_frag_data_location(self: ptr GLShader00; index: uint32;
    name: cstring) {.
    importc, libprag.}

proc bindFragDataLocation*(self: GLShader; index: int; name: cstring) =
  gst_gl_shader_bind_frag_data_location(cast[ptr GLShader00](self.impl), uint32(index), name)

proc gst_gl_shader_get_attribute_location(self: ptr GLShader00; name: cstring): int32 {.
    importc, libprag.}

proc getAttributeLocation*(self: GLShader; name: cstring): int =
  int(gst_gl_shader_get_attribute_location(cast[ptr GLShader00](self.impl), name))

proc gst_gl_shader_get_program_handle(self: ptr GLShader00): int32 {.
    importc, libprag.}

proc getProgramHandle*(self: GLShader): int =
  int(gst_gl_shader_get_program_handle(cast[ptr GLShader00](self.impl)))

proc programHandle*(self: GLShader): int =
  int(gst_gl_shader_get_program_handle(cast[ptr GLShader00](self.impl)))

proc gst_gl_shader_is_linked(self: ptr GLShader00): gboolean {.
    importc, libprag.}

proc isLinked*(self: GLShader): bool =
  toBool(gst_gl_shader_is_linked(cast[ptr GLShader00](self.impl)))

proc gst_gl_shader_link(self: ptr GLShader00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc link*(self: GLShader): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_gl_shader_link(cast[ptr GLShader00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_gl_shader_release(self: ptr GLShader00) {.
    importc, libprag.}

proc release*(self: GLShader) =
  gst_gl_shader_release(cast[ptr GLShader00](self.impl))

proc gst_gl_shader_release_unlocked(self: ptr GLShader00) {.
    importc, libprag.}

proc releaseUnlocked*(self: GLShader) =
  gst_gl_shader_release_unlocked(cast[ptr GLShader00](self.impl))

proc gst_gl_shader_set_uniform_1f(self: ptr GLShader00; name: cstring; value: cfloat) {.
    importc, libprag.}

proc setUniform_1f*(self: GLShader; name: cstring; value: cfloat) =
  gst_gl_shader_set_uniform_1f(cast[ptr GLShader00](self.impl), name, value)

proc gst_gl_shader_set_uniform_1fv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr cfloat) {.
    importc, libprag.}

proc setUniform_1fv*(self: GLShader; name: cstring; count: int;
    value: ptr cfloat) =
  gst_gl_shader_set_uniform_1fv(cast[ptr GLShader00](self.impl), name, uint32(count), value)

proc gst_gl_shader_set_uniform_1i(self: ptr GLShader00; name: cstring; value: int32) {.
    importc, libprag.}

proc setUniform_1i*(self: GLShader; name: cstring; value: int) =
  gst_gl_shader_set_uniform_1i(cast[ptr GLShader00](self.impl), name, int32(value))

proc gst_gl_shader_set_uniform_1iv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr int32) {.
    importc, libprag.}

proc setUniform_1iv*(self: GLShader; name: cstring; value: seq[int32]) =
  let count = int(value.len)
  gst_gl_shader_set_uniform_1iv(cast[ptr GLShader00](self.impl), name, uint32(count), cast[ptr int32](unsafeaddr(value[0])))

proc gst_gl_shader_set_uniform_2f(self: ptr GLShader00; name: cstring; v0: cfloat;
    v1: cfloat) {.
    importc, libprag.}

proc setUniform_2f*(self: GLShader; name: cstring; v0: cfloat;
    v1: cfloat) =
  gst_gl_shader_set_uniform_2f(cast[ptr GLShader00](self.impl), name, v0, v1)

proc gst_gl_shader_set_uniform_2fv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr cfloat) {.
    importc, libprag.}

proc setUniform_2fv*(self: GLShader; name: cstring; count: int;
    value: ptr cfloat) =
  gst_gl_shader_set_uniform_2fv(cast[ptr GLShader00](self.impl), name, uint32(count), value)

proc gst_gl_shader_set_uniform_2i(self: ptr GLShader00; name: cstring; v0: int32;
    v1: int32) {.
    importc, libprag.}

proc setUniform_2i*(self: GLShader; name: cstring; v0: int;
    v1: int) =
  gst_gl_shader_set_uniform_2i(cast[ptr GLShader00](self.impl), name, int32(v0), int32(v1))

proc gst_gl_shader_set_uniform_2iv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr int32) {.
    importc, libprag.}

proc setUniform_2iv*(self: GLShader; name: cstring; value: seq[int32]) =
  let count = int(value.len)
  gst_gl_shader_set_uniform_2iv(cast[ptr GLShader00](self.impl), name, uint32(count), cast[ptr int32](unsafeaddr(value[0])))

proc gst_gl_shader_set_uniform_3f(self: ptr GLShader00; name: cstring; v0: cfloat;
    v1: cfloat; v2: cfloat) {.
    importc, libprag.}

proc setUniform_3f*(self: GLShader; name: cstring; v0: cfloat;
    v1: cfloat; v2: cfloat) =
  gst_gl_shader_set_uniform_3f(cast[ptr GLShader00](self.impl), name, v0, v1, v2)

proc gst_gl_shader_set_uniform_3fv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr cfloat) {.
    importc, libprag.}

proc setUniform_3fv*(self: GLShader; name: cstring; count: int;
    value: ptr cfloat) =
  gst_gl_shader_set_uniform_3fv(cast[ptr GLShader00](self.impl), name, uint32(count), value)

proc gst_gl_shader_set_uniform_3i(self: ptr GLShader00; name: cstring; v0: int32;
    v1: int32; v2: int32) {.
    importc, libprag.}

proc setUniform_3i*(self: GLShader; name: cstring; v0: int;
    v1: int; v2: int) =
  gst_gl_shader_set_uniform_3i(cast[ptr GLShader00](self.impl), name, int32(v0), int32(v1), int32(v2))

proc gst_gl_shader_set_uniform_3iv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr int32) {.
    importc, libprag.}

proc setUniform_3iv*(self: GLShader; name: cstring; value: seq[int32]) =
  let count = int(value.len)
  gst_gl_shader_set_uniform_3iv(cast[ptr GLShader00](self.impl), name, uint32(count), cast[ptr int32](unsafeaddr(value[0])))

proc gst_gl_shader_set_uniform_4f(self: ptr GLShader00; name: cstring; v0: cfloat;
    v1: cfloat; v2: cfloat; v3: cfloat) {.
    importc, libprag.}

proc setUniform_4f*(self: GLShader; name: cstring; v0: cfloat;
    v1: cfloat; v2: cfloat; v3: cfloat) =
  gst_gl_shader_set_uniform_4f(cast[ptr GLShader00](self.impl), name, v0, v1, v2, v3)

proc gst_gl_shader_set_uniform_4fv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr cfloat) {.
    importc, libprag.}

proc setUniform_4fv*(self: GLShader; name: cstring; count: int;
    value: ptr cfloat) =
  gst_gl_shader_set_uniform_4fv(cast[ptr GLShader00](self.impl), name, uint32(count), value)

proc gst_gl_shader_set_uniform_4i(self: ptr GLShader00; name: cstring; v0: int32;
    v1: int32; v2: int32; v3: int32) {.
    importc, libprag.}

proc setUniform_4i*(self: GLShader; name: cstring; v0: int;
    v1: int; v2: int; v3: int) =
  gst_gl_shader_set_uniform_4i(cast[ptr GLShader00](self.impl), name, int32(v0), int32(v1), int32(v2), int32(v3))

proc gst_gl_shader_set_uniform_4iv(self: ptr GLShader00; name: cstring; count: uint32;
    value: ptr int32) {.
    importc, libprag.}

proc setUniform_4iv*(self: GLShader; name: cstring; value: seq[int32]) =
  let count = int(value.len)
  gst_gl_shader_set_uniform_4iv(cast[ptr GLShader00](self.impl), name, uint32(count), cast[ptr int32](unsafeaddr(value[0])))

proc gst_gl_shader_set_uniform_matrix_2fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_2fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_2fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_2x3fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_2x3fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_2x3fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_2x4fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_2x4fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_2x4fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_3fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_3fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_3fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_3x2fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_3x2fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_3x2fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_3x4fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_3x4fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_3x4fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_4fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_4fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_4fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_4x2fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_4x2fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_4x2fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_set_uniform_matrix_4x3fv(self: ptr GLShader00; name: cstring;
    count: int32; transpose: gboolean; value: ptr cfloat) {.
    importc, libprag.}

proc setUniformMatrix_4x3fv*(self: GLShader; name: cstring;
    count: int; transpose: bool; value: ptr cfloat) =
  gst_gl_shader_set_uniform_matrix_4x3fv(cast[ptr GLShader00](self.impl), name, int32(count), gboolean(transpose), value)

proc gst_gl_shader_use(self: ptr GLShader00) {.
    importc, libprag.}

proc use*(self: GLShader) =
  gst_gl_shader_use(cast[ptr GLShader00](self.impl))

proc gst_gl_filter_render_to_target_with_shader(self: ptr GLFilter00; input: ptr GLMemory00;
    output: ptr GLMemory00; shader: ptr GLShader00) {.
    importc, libprag.}

proc renderToTargetWithShader*(self: GLFilter; input: GLMemory;
    output: GLMemory; shader: GLShader) =
  gst_gl_filter_render_to_target_with_shader(cast[ptr GLFilter00](self.impl), cast[ptr GLMemory00](input.impl), cast[ptr GLMemory00](output.impl), cast[ptr GLShader00](shader.impl))

type
  GLSLStage* = ref object of gst.Object
  GLSLStage00* = object of gst.Object00

proc gst_glsl_stage_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLSLStage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_glsl_stage_new(context: ptr GLContext00; `type`: uint32): ptr GLSLStage00 {.
    importc, libprag.}

proc newGLSLStage*(context: GLContext; `type`: int): GLSLStage =
  let gobj = gst_glsl_stage_new(cast[ptr GLContext00](context.impl), uint32(`type`))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLSLStage*(tdesc: typedesc; context: GLContext; `type`: int): tdesc =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new(cast[ptr GLContext00](context.impl), uint32(`type`))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLSLStage*[T](result: var T; context: GLContext; `type`: int) {.deprecated.} =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new(cast[ptr GLContext00](context.impl), uint32(`type`))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_glsl_stage_new_default_fragment(context: ptr GLContext00): ptr GLSLStage00 {.
    importc, libprag.}

proc newGLSLStageDefaultFragment*(context: GLContext): GLSLStage =
  let gobj = gst_glsl_stage_new_default_fragment(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLSLStageDefaultFragment*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_default_fragment(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLSLStageDefaultFragment*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_default_fragment(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_glsl_stage_new_default_vertex(context: ptr GLContext00): ptr GLSLStage00 {.
    importc, libprag.}

proc newGLSLStageDefaultVertex*(context: GLContext): GLSLStage =
  let gobj = gst_glsl_stage_new_default_vertex(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLSLStageDefaultVertex*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_default_vertex(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLSLStageDefaultVertex*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_default_vertex(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_glsl_stage_new_with_string(context: ptr GLContext00; `type`: uint32;
    version: GLSLVersion; profile: GLSLProfile; str: cstring): ptr GLSLStage00 {.
    importc, libprag.}

proc newGLSLStageWithString*(context: GLContext; `type`: int; version: GLSLVersion;
    profile: GLSLProfile; str: cstring): GLSLStage =
  let gobj = gst_glsl_stage_new_with_string(cast[ptr GLContext00](context.impl), uint32(`type`), version, profile, str)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLSLStageWithString*(tdesc: typedesc; context: GLContext; `type`: int; version: GLSLVersion;
    profile: GLSLProfile; str: cstring): tdesc =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_with_string(cast[ptr GLContext00](context.impl), uint32(`type`), version, profile, str)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLSLStageWithString*[T](result: var T; context: GLContext; `type`: int; version: GLSLVersion;
    profile: GLSLProfile; str: cstring) {.deprecated.} =
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_with_string(cast[ptr GLContext00](context.impl), uint32(`type`), version, profile, str)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_glsl_stage_new_with_strings(context: ptr GLContext00; `type`: uint32;
    version: GLSLVersion; profile: GLSLProfile; nStrings: int32; str: ptr cstring): ptr GLSLStage00 {.
    importc, libprag.}

proc newGLSLStageWithStrings*(context: GLContext; `type`: int; version: GLSLVersion;
    profile: GLSLProfile; nStrings: int; str: varargs[string, `$`]): GLSLStage =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let gobj = gst_glsl_stage_new_with_strings(cast[ptr GLContext00](context.impl), uint32(`type`), version, profile, int32(nStrings), seq2CstringArray(str, fs469n23))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLSLStageWithStrings*(tdesc: typedesc; context: GLContext; `type`: int; version: GLSLVersion;
    profile: GLSLProfile; nStrings: int; str: varargs[string, `$`]): tdesc =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_with_strings(cast[ptr GLContext00](context.impl), uint32(`type`), version, profile, int32(nStrings), seq2CstringArray(str, fs469n23))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLSLStageWithStrings*[T](result: var T; context: GLContext; `type`: int; version: GLSLVersion;
    profile: GLSLProfile; nStrings: int; str: varargs[string, `$`]) {.deprecated.} =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  assert(result is GLSLStage)
  let gobj = gst_glsl_stage_new_with_strings(cast[ptr GLContext00](context.impl), uint32(`type`), version, profile, int32(nStrings), seq2CstringArray(str, fs469n23))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_glsl_stage_compile(self: ptr GLSLStage00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc compile*(self: GLSLStage): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_glsl_stage_compile(cast[ptr GLSLStage00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_glsl_stage_get_handle(self: ptr GLSLStage00): uint32 {.
    importc, libprag.}

proc getHandle*(self: GLSLStage): int =
  int(gst_glsl_stage_get_handle(cast[ptr GLSLStage00](self.impl)))

proc handle*(self: GLSLStage): int =
  int(gst_glsl_stage_get_handle(cast[ptr GLSLStage00](self.impl)))

proc gst_glsl_stage_get_profile(self: ptr GLSLStage00): GLSLProfile {.
    importc, libprag.}

proc getProfile*(self: GLSLStage): GLSLProfile =
  gst_glsl_stage_get_profile(cast[ptr GLSLStage00](self.impl))

proc profile*(self: GLSLStage): GLSLProfile =
  gst_glsl_stage_get_profile(cast[ptr GLSLStage00](self.impl))

proc gst_glsl_stage_get_shader_type(self: ptr GLSLStage00): uint32 {.
    importc, libprag.}

proc getShaderType*(self: GLSLStage): int =
  int(gst_glsl_stage_get_shader_type(cast[ptr GLSLStage00](self.impl)))

proc shaderType*(self: GLSLStage): int =
  int(gst_glsl_stage_get_shader_type(cast[ptr GLSLStage00](self.impl)))

proc gst_glsl_stage_get_version(self: ptr GLSLStage00): GLSLVersion {.
    importc, libprag.}

proc getVersion*(self: GLSLStage): GLSLVersion =
  gst_glsl_stage_get_version(cast[ptr GLSLStage00](self.impl))

proc version*(self: GLSLStage): GLSLVersion =
  gst_glsl_stage_get_version(cast[ptr GLSLStage00](self.impl))

proc gst_glsl_stage_set_strings(self: ptr GLSLStage00; version: GLSLVersion;
    profile: GLSLProfile; nStrings: int32; str: ptr cstring): gboolean {.
    importc, libprag.}

proc setStrings*(self: GLSLStage; version: GLSLVersion; profile: GLSLProfile;
    nStrings: int; str: varargs[string, `$`]): bool =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  toBool(gst_glsl_stage_set_strings(cast[ptr GLSLStage00](self.impl), version, profile, int32(nStrings), seq2CstringArray(str, fs469n23)))

proc gst_gl_shader_attach(self: ptr GLShader00; stage: ptr GLSLStage00): gboolean {.
    importc, libprag.}

proc attach*(self: GLShader; stage: GLSLStage): bool =
  toBool(gst_gl_shader_attach(cast[ptr GLShader00](self.impl), cast[ptr GLSLStage00](stage.impl)))

proc gst_gl_shader_attach_unlocked(self: ptr GLShader00; stage: ptr GLSLStage00): gboolean {.
    importc, libprag.}

proc attachUnlocked*(self: GLShader; stage: GLSLStage): bool =
  toBool(gst_gl_shader_attach_unlocked(cast[ptr GLShader00](self.impl), cast[ptr GLSLStage00](stage.impl)))

proc gst_gl_shader_compile_attach_stage(self: ptr GLShader00; stage: ptr GLSLStage00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc compileAttachStage*(self: GLShader; stage: GLSLStage): bool =
  var gerror: ptr glib.Error
  let resul0 = gst_gl_shader_compile_attach_stage(cast[ptr GLShader00](self.impl), cast[ptr GLSLStage00](stage.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gst_gl_shader_detach(self: ptr GLShader00; stage: ptr GLSLStage00) {.
    importc, libprag.}

proc detach*(self: GLShader; stage: GLSLStage) =
  gst_gl_shader_detach(cast[ptr GLShader00](self.impl), cast[ptr GLSLStage00](stage.impl))

proc gst_gl_shader_detach_unlocked(self: ptr GLShader00; stage: ptr GLSLStage00) {.
    importc, libprag.}

proc detachUnlocked*(self: GLShader; stage: GLSLStage) =
  gst_gl_shader_detach_unlocked(cast[ptr GLShader00](self.impl), cast[ptr GLSLStage00](stage.impl))

type
  GLFormat* {.size: sizeof(cint), pure.} = enum
    red = 6403
    alpha = 6406
    rgb = 6407
    rgba = 6408
    luminance = 6409
    luminanceAlpha = 6410
    rgb8 = 32849
    rgb16 = 32852
    rgba8 = 32856
    rgb10A2 = 32857
    rgba16 = 32859
    depthComponent16 = 33189
    rg = 33319
    r8 = 33321
    r16 = 33322
    rg8 = 33323
    rg16 = 33324
    depth24Stencil8 = 35056
    rgb565 = 36194

proc gst_gl_format_from_video_info(context: ptr GLContext00; vinfo: ptr gstvideo.VideoInfo00;
    plane: uint32): GLFormat {.
    importc, libprag.}

proc fromVideoInfo*(context: GLContext; vinfo: gstvideo.VideoInfo;
    plane: int): GLFormat =
  gst_gl_format_from_video_info(cast[ptr GLContext00](context.impl), cast[ptr gstvideo.VideoInfo00](vinfo.impl), uint32(plane))

proc gst_gl_format_is_supported(context: ptr GLContext00; format: GLFormat): gboolean {.
    importc, libprag.}

proc isSupported*(context: GLContext; format: GLFormat): bool =
  toBool(gst_gl_format_is_supported(cast[ptr GLContext00](context.impl), format))

proc gst_gl_format_type_from_sized_gl_format(format: GLFormat; unsizedFormat: var GLFormat;
    glType: var uint32) {.
    importc, libprag.}

proc typeFromSizedGlFormat*(format: GLFormat; unsizedFormat: var GLFormat;
    glType: var int) =
  var glType_00: uint32
  gst_gl_format_type_from_sized_gl_format(format, unsizedFormat, glType_00)
  if glType.addr != nil:
    glType = int(glType_00)

proc gst_gl_format_type_n_bytes(format: uint32; `type`: uint32): uint32 {.
    importc, libprag.}

proc typeNBytes*(format: int; `type`: int): int =
  int(gst_gl_format_type_n_bytes(uint32(format), uint32(`type`)))

proc gst_gl_memory_get_texture_format(self: ptr GLMemory00): GLFormat {.
    importc, libprag.}

proc getTextureFormat*(self: GLMemory): GLFormat =
  gst_gl_memory_get_texture_format(cast[ptr GLMemory00](self.impl))

proc textureFormat*(self: GLMemory): GLFormat =
  gst_gl_memory_get_texture_format(cast[ptr GLMemory00](self.impl))

type
  GLTextureTarget* {.size: sizeof(cint), pure.} = enum
    none = 0
    d2 = 1
    rectangle = 2
    externalOes = 3

proc gst_gl_texture_target_from_gl(target: uint32): GLTextureTarget {.
    importc, libprag.}

proc fromGl*(target: int): GLTextureTarget =
  gst_gl_texture_target_from_gl(uint32(target))

proc fromStringGLTextureTarget*(str: cstring): GLTextureTarget {.
    importc: "gst_gl_texture_target_from_string", libprag.}

proc gst_gl_texture_target_to_buffer_pool_option(target: GLTextureTarget): cstring {.
    importc, libprag.}

proc toBufferPoolOption*(target: GLTextureTarget): string =
  result = $gst_gl_texture_target_to_buffer_pool_option(target)

proc gst_gl_texture_target_to_gl(target: GLTextureTarget): uint32 {.
    importc, libprag.}

proc toGl*(target: GLTextureTarget): int =
  int(gst_gl_texture_target_to_gl(target))

proc gst_gl_texture_target_to_string(target: GLTextureTarget): cstring {.
    importc, libprag.}

proc toString*(target: GLTextureTarget): string =
  result = $gst_gl_texture_target_to_string(target)

proc gst_gl_memory_copy_into(self: ptr GLMemory00; texId: uint32; target: GLTextureTarget;
    texFormat: GLFormat; width: int32; height: int32): gboolean {.
    importc, libprag.}

proc copyInto*(self: GLMemory; texId: int; target: GLTextureTarget;
    texFormat: GLFormat; width: int; height: int): bool =
  toBool(gst_gl_memory_copy_into(cast[ptr GLMemory00](self.impl), uint32(texId), target, texFormat, int32(width), int32(height)))

proc gst_gl_memory_copy_teximage(self: ptr GLMemory00; texId: uint32; outTarget: GLTextureTarget;
    outTexFormat: GLFormat; outWidth: int32; outHeight: int32): gboolean {.
    importc, libprag.}

proc copyTeximage*(self: GLMemory; texId: int; outTarget: GLTextureTarget;
    outTexFormat: GLFormat; outWidth: int; outHeight: int): bool =
  toBool(gst_gl_memory_copy_teximage(cast[ptr GLMemory00](self.impl), uint32(texId), outTarget, outTexFormat, int32(outWidth), int32(outHeight)))

proc gst_gl_memory_get_texture_target(self: ptr GLMemory00): GLTextureTarget {.
    importc, libprag.}

proc getTextureTarget*(self: GLMemory): GLTextureTarget =
  gst_gl_memory_get_texture_target(cast[ptr GLMemory00](self.impl))

proc textureTarget*(self: GLMemory): GLTextureTarget =
  gst_gl_memory_get_texture_target(cast[ptr GLMemory00](self.impl))

proc gst_gl_memory_init(self: ptr GLMemory00; allocator: ptr gst.Allocator00;
    parent: ptr gst.Memory00; context: ptr GLContext00; target: GLTextureTarget;
    texFormat: GLFormat; params: ptr gst.AllocationParams00; info: ptr gstvideo.VideoInfo00;
    plane: uint32; valign: gstvideo.VideoAlignment; userData: pointer; notify: DestroyNotify) {.
    importc, libprag.}

proc init*(self: GLMemory; allocator: gst.Allocator; parent: gst.Memory = nil;
    context: GLContext; target: GLTextureTarget; texFormat: GLFormat; params: gst.AllocationParams = nil;
    info: gstvideo.VideoInfo; plane: int; valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    userData: pointer; notify: DestroyNotify) =
  gst_gl_memory_init(cast[ptr GLMemory00](self.impl), cast[ptr gst.Allocator00](allocator.impl), if parent.isNil: nil else: cast[ptr gst.Memory00](parent.impl), cast[ptr GLContext00](context.impl), target, texFormat, if params.isNil: nil else: cast[ptr gst.AllocationParams00](params.impl), cast[ptr gstvideo.VideoInfo00](info.impl), uint32(plane), valign, userData, notify)

type
  GLFilterRenderFunc* = proc (filter: ptr GLFilter00; inTex: ptr GLMemory00; userData: pointer): gboolean {.cdecl.}

proc gst_gl_filter_render_to_target(self: ptr GLFilter00; input: ptr GLMemory00;
    output: ptr GLMemory00; `func`: GLFilterRenderFunc; data: pointer): gboolean {.
    importc, libprag.}

proc renderToTarget*(self: GLFilter; input: GLMemory; output: GLMemory;
    `func`: GLFilterRenderFunc; data: pointer): bool =
  toBool(gst_gl_filter_render_to_target(cast[ptr GLFilter00](self.impl), cast[ptr GLMemory00](input.impl), cast[ptr GLMemory00](output.impl), `func`, data))

type
  GLFramebuffer* = ref object of gst.Object
  GLFramebuffer00* = object of gst.Object00

proc gst_gl_framebuffer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLFramebuffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_framebuffer_new(context: ptr GLContext00): ptr GLFramebuffer00 {.
    importc, libprag.}

proc newGLFramebuffer*(context: GLContext): GLFramebuffer =
  let gobj = gst_gl_framebuffer_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLFramebuffer*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLFramebuffer)
  let gobj = gst_gl_framebuffer_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLFramebuffer*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLFramebuffer)
  let gobj = gst_gl_framebuffer_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_framebuffer_new_with_default_depth(context: ptr GLContext00;
    width: uint32; height: uint32): ptr GLFramebuffer00 {.
    importc, libprag.}

proc newGLFramebufferWithDefaultDepth*(context: GLContext; width: int;
    height: int): GLFramebuffer =
  let gobj = gst_gl_framebuffer_new_with_default_depth(cast[ptr GLContext00](context.impl), uint32(width), uint32(height))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLFramebufferWithDefaultDepth*(tdesc: typedesc; context: GLContext; width: int;
    height: int): tdesc =
  assert(result is GLFramebuffer)
  let gobj = gst_gl_framebuffer_new_with_default_depth(cast[ptr GLContext00](context.impl), uint32(width), uint32(height))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLFramebufferWithDefaultDepth*[T](result: var T; context: GLContext; width: int;
    height: int) {.deprecated.} =
  assert(result is GLFramebuffer)
  let gobj = gst_gl_framebuffer_new_with_default_depth(cast[ptr GLContext00](context.impl), uint32(width), uint32(height))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_framebuffer_attach(self: ptr GLFramebuffer00; attachmentPoint: uint32;
    mem: ptr GLBaseMemory00) {.
    importc, libprag.}

proc attach*(self: GLFramebuffer; attachmentPoint: int;
    mem: GLBaseMemory) =
  gst_gl_framebuffer_attach(cast[ptr GLFramebuffer00](self.impl), uint32(attachmentPoint), cast[ptr GLBaseMemory00](mem.impl))

proc gst_gl_framebuffer_bind(self: ptr GLFramebuffer00) {.
    importc, libprag.}

proc `bind`*(self: GLFramebuffer) =
  gst_gl_framebuffer_bind(cast[ptr GLFramebuffer00](self.impl))

proc gst_gl_framebuffer_get_effective_dimensions(self: ptr GLFramebuffer00;
    width: var uint32; height: var uint32) {.
    importc, libprag.}

proc getEffectiveDimensions*(self: GLFramebuffer; width: var int = cast[var int](nil);
    height: var int = cast[var int](nil)) =
  var width_00: uint32
  var height_00: uint32
  gst_gl_framebuffer_get_effective_dimensions(cast[ptr GLFramebuffer00](self.impl), width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc gst_gl_framebuffer_get_id(self: ptr GLFramebuffer00): uint32 {.
    importc, libprag.}

proc getId*(self: GLFramebuffer): int =
  int(gst_gl_framebuffer_get_id(cast[ptr GLFramebuffer00](self.impl)))

proc id*(self: GLFramebuffer): int =
  int(gst_gl_framebuffer_get_id(cast[ptr GLFramebuffer00](self.impl)))

type
  GLFramebufferFunc* = proc (stuff: pointer): gboolean {.cdecl.}

proc gst_gl_framebuffer_draw_to_texture(self: ptr GLFramebuffer00; mem: ptr GLMemory00;
    `func`: GLFramebufferFunc; userData: pointer): gboolean {.
    importc, libprag.}

proc drawToTexture*(self: GLFramebuffer; mem: GLMemory;
    `func`: GLFramebufferFunc; userData: pointer): bool =
  toBool(gst_gl_framebuffer_draw_to_texture(cast[ptr GLFramebuffer00](self.impl), cast[ptr GLMemory00](mem.impl), `func`, userData))

type
  GLFuncs00* {.pure.} = object
  GLFuncs* = ref object
    impl*: ptr GLFuncs00
    ignoreFinalizer*: bool

type
  GLMemoryAllocator* = ref object of GLBaseMemoryAllocator
  GLMemoryAllocator00* = object of GLBaseMemoryAllocator00

proc gst_gl_memory_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLMemoryAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_memory_allocator_get_default(context: ptr GLContext00): ptr GLMemoryAllocator00 {.
    importc, libprag.}

proc getDefaultGLMemoryAllocator*(context: GLContext): GLMemoryAllocator =
  let gobj = gst_gl_memory_allocator_get_default(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultGLMemoryAllocator*(context: GLContext): GLMemoryAllocator =
  let gobj = gst_gl_memory_allocator_get_default(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GLMemoryPBO00* {.pure.} = object
  GLMemoryPBO* = ref object
    impl*: ptr GLMemoryPBO00
    ignoreFinalizer*: bool

proc gst_gl_memory_pbo_copy_into_texture(self: ptr GLMemoryPBO00; texId: uint32;
    target: GLTextureTarget; texFormat: GLFormat; width: int32; height: int32;
    stride: int32; respecify: gboolean): gboolean {.
    importc, libprag.}

proc copyIntoTexture*(self: GLMemoryPBO; texId: int; target: GLTextureTarget;
    texFormat: GLFormat; width: int; height: int; stride: int; respecify: bool): bool =
  toBool(gst_gl_memory_pbo_copy_into_texture(cast[ptr GLMemoryPBO00](self.impl), uint32(texId), target, texFormat, int32(width), int32(height), int32(stride), gboolean(respecify)))

proc gst_gl_memory_pbo_download_transfer(self: ptr GLMemoryPBO00) {.
    importc, libprag.}

proc downloadTransfer*(self: GLMemoryPBO) =
  gst_gl_memory_pbo_download_transfer(cast[ptr GLMemoryPBO00](self.impl))

proc gst_gl_memory_pbo_upload_transfer(self: ptr GLMemoryPBO00) {.
    importc, libprag.}

proc uploadTransfer*(self: GLMemoryPBO) =
  gst_gl_memory_pbo_upload_transfer(cast[ptr GLMemoryPBO00](self.impl))

proc memoryPboInitOnce*() {.
    importc: "gst_gl_memory_pbo_init_once", libprag.}

type
  GLMemoryPBOAllocator* = ref object of GLMemoryAllocator
  GLMemoryPBOAllocator00* = object of GLMemoryAllocator00

proc gst_gl_memory_pbo_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLMemoryPBOAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  GLOverlayCompositor* = ref object of gst.Object
  GLOverlayCompositor00* = object of gst.Object00

proc gst_gl_overlay_compositor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLOverlayCompositor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_overlay_compositor_new(context: ptr GLContext00): ptr GLOverlayCompositor00 {.
    importc, libprag.}

proc newGLOverlayCompositor*(context: GLContext): GLOverlayCompositor =
  let gobj = gst_gl_overlay_compositor_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLOverlayCompositor*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLOverlayCompositor)
  let gobj = gst_gl_overlay_compositor_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLOverlayCompositor*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLOverlayCompositor)
  let gobj = gst_gl_overlay_compositor_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_overlay_compositor_add_caps(caps: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc addCaps*(caps: gst.Caps): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_gl_overlay_compositor_add_caps(cast[ptr gst.Caps00](caps.impl))

proc gst_gl_overlay_compositor_draw_overlays(self: ptr GLOverlayCompositor00) {.
    importc, libprag.}

proc drawOverlays*(self: GLOverlayCompositor) =
  gst_gl_overlay_compositor_draw_overlays(cast[ptr GLOverlayCompositor00](self.impl))

proc gst_gl_overlay_compositor_free_overlays(self: ptr GLOverlayCompositor00) {.
    importc, libprag.}

proc freeOverlays*(self: GLOverlayCompositor) =
  gst_gl_overlay_compositor_free_overlays(cast[ptr GLOverlayCompositor00](self.impl))

proc gst_gl_overlay_compositor_upload_overlays(self: ptr GLOverlayCompositor00;
    buf: ptr gst.Buffer00) {.
    importc, libprag.}

proc uploadOverlays*(self: GLOverlayCompositor;
    buf: gst.Buffer) =
  gst_gl_overlay_compositor_upload_overlays(cast[ptr GLOverlayCompositor00](self.impl), cast[ptr gst.Buffer00](buf.impl))

type
  GLQuery00* {.pure.} = object
  GLQuery* = ref object
    impl*: ptr GLQuery00
    ignoreFinalizer*: bool

proc gst_gl_query_free(self: ptr GLQuery00) {.
    importc, libprag.}

proc free*(self: GLQuery) =
  gst_gl_query_free(cast[ptr GLQuery00](self.impl))

proc finalizerfree*(self: GLQuery) =
  if not self.ignoreFinalizer:
    gst_gl_query_free(cast[ptr GLQuery00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLQuery()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      gst_gl_query_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var GLQuery) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_gl_query_end(self: ptr GLQuery00) {.
    importc, libprag.}

proc `end`*(self: GLQuery) =
  gst_gl_query_end(cast[ptr GLQuery00](self.impl))

proc gst_gl_query_counter(self: ptr GLQuery00) {.
    importc, libprag.}

proc counter*(self: GLQuery) =
  gst_gl_query_counter(cast[ptr GLQuery00](self.impl))

proc gst_gl_query_result(self: ptr GLQuery00): uint64 {.
    importc, libprag.}

proc resu*(self: GLQuery): uint64 =
  gst_gl_query_result(cast[ptr GLQuery00](self.impl))

proc gst_gl_query_start(self: ptr GLQuery00) {.
    importc, libprag.}

proc start*(self: GLQuery) =
  gst_gl_query_start(cast[ptr GLQuery00](self.impl))

proc gst_gl_query_unset(self: ptr GLQuery00) {.
    importc, libprag.}

proc unset*(self: GLQuery) =
  gst_gl_query_unset(cast[ptr GLQuery00](self.impl))

proc gst_gl_query_local_gl_context(element: ptr gst.Element00; direction: gst.PadDirection;
    contextPtr: var ptr GLContext00): gboolean {.
    importc, libprag.}

proc localGlContext*(element: gst.Element; direction: gst.PadDirection;
    contextPtr: var GLContext): bool =
  toBool(gst_gl_query_local_gl_context(cast[ptr gst.Element00](element.impl), direction, cast[var ptr GLContext00](addr contextPtr.impl)))

type
  GLQueryType* {.size: sizeof(cint), pure.} = enum
    none = 0
    timeElapsed = 1
    timestamp = 2

proc gst_gl_query_init(self: ptr GLQuery00; context: ptr GLContext00; queryType: GLQueryType) {.
    importc, libprag.}

proc init*(self: GLQuery; context: GLContext; queryType: GLQueryType) =
  gst_gl_query_init(cast[ptr GLQuery00](self.impl), cast[ptr GLContext00](context.impl), queryType)

type
  GLRenderbuffer00* {.pure.} = object
  GLRenderbuffer* = ref object
    impl*: ptr GLRenderbuffer00
    ignoreFinalizer*: bool

proc gst_gl_renderbuffer_get_format(self: ptr GLRenderbuffer00): GLFormat {.
    importc, libprag.}

proc getFormat*(self: GLRenderbuffer): GLFormat =
  gst_gl_renderbuffer_get_format(cast[ptr GLRenderbuffer00](self.impl))

proc format*(self: GLRenderbuffer): GLFormat =
  gst_gl_renderbuffer_get_format(cast[ptr GLRenderbuffer00](self.impl))

proc gst_gl_renderbuffer_get_height(self: ptr GLRenderbuffer00): int32 {.
    importc, libprag.}

proc getHeight*(self: GLRenderbuffer): int =
  int(gst_gl_renderbuffer_get_height(cast[ptr GLRenderbuffer00](self.impl)))

proc height*(self: GLRenderbuffer): int =
  int(gst_gl_renderbuffer_get_height(cast[ptr GLRenderbuffer00](self.impl)))

proc gst_gl_renderbuffer_get_id(self: ptr GLRenderbuffer00): uint32 {.
    importc, libprag.}

proc getId*(self: GLRenderbuffer): int =
  int(gst_gl_renderbuffer_get_id(cast[ptr GLRenderbuffer00](self.impl)))

proc id*(self: GLRenderbuffer): int =
  int(gst_gl_renderbuffer_get_id(cast[ptr GLRenderbuffer00](self.impl)))

proc gst_gl_renderbuffer_get_width(self: ptr GLRenderbuffer00): int32 {.
    importc, libprag.}

proc getWidth*(self: GLRenderbuffer): int =
  int(gst_gl_renderbuffer_get_width(cast[ptr GLRenderbuffer00](self.impl)))

proc width*(self: GLRenderbuffer): int =
  int(gst_gl_renderbuffer_get_width(cast[ptr GLRenderbuffer00](self.impl)))

proc renderbufferInitOnce*() {.
    importc: "gst_gl_renderbuffer_init_once", libprag.}

type
  GLRenderbufferAllocationParams00* {.pure.} = object
  GLRenderbufferAllocationParams* = ref object
    impl*: ptr GLRenderbufferAllocationParams00
    ignoreFinalizer*: bool

proc gst_gl_renderbuffer_allocation_params_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstGLRenderbufferAllocationParams*(self: GLRenderbufferAllocationParams) =
  if not self.ignoreFinalizer:
    boxedFree(gst_gl_renderbuffer_allocation_params_get_type(), cast[ptr GLRenderbufferAllocationParams00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLRenderbufferAllocationParams()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_gl_renderbuffer_allocation_params_get_type(), cast[ptr GLRenderbufferAllocationParams00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GLRenderbufferAllocationParams) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstGLRenderbufferAllocationParams)

proc gst_gl_renderbuffer_allocation_params_new(context: ptr GLContext00;
    allocParams: ptr gst.AllocationParams00; renderbufferFormat: GLFormat;
    width: uint32; height: uint32): ptr GLRenderbufferAllocationParams00 {.
    importc, libprag.}

proc newGLRenderbufferAllocationParams*(context: GLContext; allocParams: gst.AllocationParams = nil;
    renderbufferFormat: GLFormat; width: int; height: int): GLRenderbufferAllocationParams =
  fnew(result, gBoxedFreeGstGLRenderbufferAllocationParams)
  result.impl = gst_gl_renderbuffer_allocation_params_new(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), renderbufferFormat, uint32(width), uint32(height))

proc newGLRenderbufferAllocationParams*(tdesc: typedesc; context: GLContext; allocParams: gst.AllocationParams = nil;
    renderbufferFormat: GLFormat; width: int; height: int): tdesc =
  assert(result is GLRenderbufferAllocationParams)
  fnew(result, gBoxedFreeGstGLRenderbufferAllocationParams)
  result.impl = gst_gl_renderbuffer_allocation_params_new(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), renderbufferFormat, uint32(width), uint32(height))

proc initGLRenderbufferAllocationParams*[T](result: var T; context: GLContext; allocParams: gst.AllocationParams = nil;
    renderbufferFormat: GLFormat; width: int; height: int) {.deprecated.} =
  assert(result is GLRenderbufferAllocationParams)
  fnew(result, gBoxedFreeGstGLRenderbufferAllocationParams)
  result.impl = gst_gl_renderbuffer_allocation_params_new(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), renderbufferFormat, uint32(width), uint32(height))

proc gst_gl_renderbuffer_allocation_params_new_wrapped(context: ptr GLContext00;
    allocParams: ptr gst.AllocationParams00; renderbufferFormat: GLFormat;
    width: uint32; height: uint32; glHandle: pointer; userData: pointer; notify: DestroyNotify): ptr GLRenderbufferAllocationParams00 {.
    importc, libprag.}

proc newGLRenderbufferAllocationParamsWrapped*(context: GLContext;
    allocParams: gst.AllocationParams = nil; renderbufferFormat: GLFormat;
    width: int; height: int; glHandle: pointer; userData: pointer; notify: DestroyNotify): GLRenderbufferAllocationParams =
  fnew(result, gBoxedFreeGstGLRenderbufferAllocationParams)
  result.impl = gst_gl_renderbuffer_allocation_params_new_wrapped(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), renderbufferFormat, uint32(width), uint32(height), glHandle, userData, notify)

proc newGLRenderbufferAllocationParamsWrapped*(tdesc: typedesc; context: GLContext;
    allocParams: gst.AllocationParams = nil; renderbufferFormat: GLFormat;
    width: int; height: int; glHandle: pointer; userData: pointer; notify: DestroyNotify): tdesc =
  assert(result is GLRenderbufferAllocationParams)
  fnew(result, gBoxedFreeGstGLRenderbufferAllocationParams)
  result.impl = gst_gl_renderbuffer_allocation_params_new_wrapped(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), renderbufferFormat, uint32(width), uint32(height), glHandle, userData, notify)

proc initGLRenderbufferAllocationParamsWrapped*[T](result: var T; context: GLContext;
    allocParams: gst.AllocationParams = nil; renderbufferFormat: GLFormat;
    width: int; height: int; glHandle: pointer; userData: pointer; notify: DestroyNotify) {.deprecated.} =
  assert(result is GLRenderbufferAllocationParams)
  fnew(result, gBoxedFreeGstGLRenderbufferAllocationParams)
  result.impl = gst_gl_renderbuffer_allocation_params_new_wrapped(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), renderbufferFormat, uint32(width), uint32(height), glHandle, userData, notify)

type
  GLRenderbufferAllocator* = ref object of GLBaseMemoryAllocator
  GLRenderbufferAllocator00* = object of GLBaseMemoryAllocator00

proc gst_gl_renderbuffer_allocator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLRenderbufferAllocator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  GLSLError* {.size: sizeof(cint), pure.} = enum
    compile = 0
    link = 1
    program = 2

type
  GLStereoDownmix* {.size: sizeof(cint), pure.} = enum
    greenMagentaDubois = 0
    redCyanDubois = 1
    amberBlueDubois = 2

type
  GLSyncMeta00* {.pure.} = object
  GLSyncMeta* = ref object
    impl*: ptr GLSyncMeta00
    ignoreFinalizer*: bool

proc gst_gl_sync_meta_set_sync_point(self: ptr GLSyncMeta00; context: ptr GLContext00) {.
    importc, libprag.}

proc setSyncPoint*(self: GLSyncMeta; context: GLContext) =
  gst_gl_sync_meta_set_sync_point(cast[ptr GLSyncMeta00](self.impl), cast[ptr GLContext00](context.impl))

proc `syncPoint=`*(self: GLSyncMeta; context: GLContext) =
  gst_gl_sync_meta_set_sync_point(cast[ptr GLSyncMeta00](self.impl), cast[ptr GLContext00](context.impl))

proc gst_gl_sync_meta_wait(self: ptr GLSyncMeta00; context: ptr GLContext00) {.
    importc, libprag.}

proc wait*(self: GLSyncMeta; context: GLContext) =
  gst_gl_sync_meta_wait(cast[ptr GLSyncMeta00](self.impl), cast[ptr GLContext00](context.impl))

proc gst_gl_sync_meta_wait_cpu(self: ptr GLSyncMeta00; context: ptr GLContext00) {.
    importc, libprag.}

proc waitCpu*(self: GLSyncMeta; context: GLContext) =
  gst_gl_sync_meta_wait_cpu(cast[ptr GLSyncMeta00](self.impl), cast[ptr GLContext00](context.impl))

proc gst_gl_sync_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoGLSyncMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_gl_sync_meta_get_info()
  result.ignoreFinalizer = true

type
  GLUpload* = ref object of gst.Object
  GLUpload00* = object of gst.Object00

proc gst_gl_upload_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLUpload()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_upload_new(context: ptr GLContext00): ptr GLUpload00 {.
    importc, libprag.}

proc newGLUpload*(context: GLContext): GLUpload =
  let gobj = gst_gl_upload_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLUpload*(tdesc: typedesc; context: GLContext): tdesc =
  assert(result is GLUpload)
  let gobj = gst_gl_upload_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLUpload*[T](result: var T; context: GLContext) {.deprecated.} =
  assert(result is GLUpload)
  let gobj = gst_gl_upload_new(cast[ptr GLContext00](context.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_upload_get_input_template_caps(): ptr gst.Caps00 {.
    importc, libprag.}

proc getInputTemplateCaps*(): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_gl_upload_get_input_template_caps()

proc gst_gl_upload_get_caps(self: ptr GLUpload00; inCaps: var ptr gst.Caps00;
    outCaps: var ptr gst.Caps00) {.
    importc, libprag.}

proc getCaps*(self: GLUpload; inCaps: var gst.Caps = cast[var gst.Caps](nil);
    outCaps: var gst.Caps = cast[var gst.Caps](nil)) =
  if addr(inCaps) != nil:
    fnew(inCaps, gBoxedFreeGstCaps)
  if addr(outCaps) != nil:
    fnew(outCaps, gBoxedFreeGstCaps)
  gst_gl_upload_get_caps(cast[ptr GLUpload00](self.impl), cast[var ptr gst.Caps00](if addr(inCaps) == nil: nil else: addr inCaps.impl), cast[var ptr gst.Caps00](if addr(outCaps) == nil: nil else: addr outCaps.impl))

proc gst_gl_upload_propose_allocation(self: ptr GLUpload00; decideQuery: ptr gst.Query00;
    query: ptr gst.Query00) {.
    importc, libprag.}

proc proposeAllocation*(self: GLUpload; decideQuery: gst.Query = nil;
    query: gst.Query) =
  gst_gl_upload_propose_allocation(cast[ptr GLUpload00](self.impl), if decideQuery.isNil: nil else: cast[ptr gst.Query00](decideQuery.impl), cast[ptr gst.Query00](query.impl))

proc gst_gl_upload_set_caps(self: ptr GLUpload00; inCaps: ptr gst.Caps00;
    outCaps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc setCaps*(self: GLUpload; inCaps: gst.Caps; outCaps: gst.Caps): bool =
  toBool(gst_gl_upload_set_caps(cast[ptr GLUpload00](self.impl), cast[ptr gst.Caps00](inCaps.impl), cast[ptr gst.Caps00](outCaps.impl)))

proc gst_gl_upload_set_context(self: ptr GLUpload00; context: ptr GLContext00) {.
    importc, libprag.}

proc setContext*(self: GLUpload; context: GLContext) =
  gst_gl_upload_set_context(cast[ptr GLUpload00](self.impl), cast[ptr GLContext00](context.impl))

proc `context=`*(self: GLUpload; context: GLContext) =
  gst_gl_upload_set_context(cast[ptr GLUpload00](self.impl), cast[ptr GLContext00](context.impl))

proc gst_gl_upload_transform_caps(self: ptr GLUpload00; context: ptr GLContext00;
    direction: gst.PadDirection; caps: ptr gst.Caps00; filter: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc transformCaps*(self: GLUpload; context: GLContext; direction: gst.PadDirection;
    caps: gst.Caps; filter: gst.Caps): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_gl_upload_transform_caps(cast[ptr GLUpload00](self.impl), cast[ptr GLContext00](context.impl), direction, cast[ptr gst.Caps00](caps.impl), cast[ptr gst.Caps00](filter.impl))

type
  GLUploadReturn* {.size: sizeof(cint), pure.} = enum
    unsharedGlContext = -100
    reconfigure = -3
    unsupported = -2
    error = -1
    done = 1

proc gst_gl_upload_perform_with_buffer(self: ptr GLUpload00; buffer: ptr gst.Buffer00;
    outbufPtr: var ptr gst.Buffer00): GLUploadReturn {.
    importc, libprag.}

proc performWithBuffer*(self: GLUpload; buffer: gst.Buffer;
    outbufPtr: var gst.Buffer): GLUploadReturn =
  fnew(outbufPtr, gBoxedFreeGstBuffer)
  gst_gl_upload_perform_with_buffer(cast[ptr GLUpload00](self.impl), cast[ptr gst.Buffer00](buffer.impl), cast[var ptr gst.Buffer00](addr outbufPtr.impl))

type
  GLVideoAllocationParams00* {.pure.} = object
  GLVideoAllocationParams* = ref object
    impl*: ptr GLVideoAllocationParams00
    ignoreFinalizer*: bool

proc gst_gl_video_allocation_params_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstGLVideoAllocationParams*(self: GLVideoAllocationParams) =
  if not self.ignoreFinalizer:
    boxedFree(gst_gl_video_allocation_params_get_type(), cast[ptr GLVideoAllocationParams00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLVideoAllocationParams()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_gl_video_allocation_params_get_type(), cast[ptr GLVideoAllocationParams00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var GLVideoAllocationParams) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstGLVideoAllocationParams)

proc gst_gl_video_allocation_params_new(context: ptr GLContext00; allocParams: ptr gst.AllocationParams00;
    vInfo: ptr gstvideo.VideoInfo00; plane: uint32; valign: gstvideo.VideoAlignment;
    target: GLTextureTarget; texFormat: GLFormat): ptr GLVideoAllocationParams00 {.
    importc, libprag.}

proc newGLVideoAllocationParams*(context: GLContext; allocParams: gst.AllocationParams = nil;
    vInfo: gstvideo.VideoInfo; plane: int; valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat): GLVideoAllocationParams =
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat)

proc newGLVideoAllocationParams*(tdesc: typedesc; context: GLContext; allocParams: gst.AllocationParams = nil;
    vInfo: gstvideo.VideoInfo; plane: int; valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat): tdesc =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat)

proc initGLVideoAllocationParams*[T](result: var T; context: GLContext; allocParams: gst.AllocationParams = nil;
    vInfo: gstvideo.VideoInfo; plane: int; valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat) {.deprecated.} =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat)

proc gst_gl_video_allocation_params_new_wrapped_data(context: ptr GLContext00;
    allocParams: ptr gst.AllocationParams00; vInfo: ptr gstvideo.VideoInfo00;
    plane: uint32; valign: gstvideo.VideoAlignment; target: GLTextureTarget;
    texFormat: GLFormat; wrappedData: pointer; userData: pointer; notify: DestroyNotify): ptr GLVideoAllocationParams00 {.
    importc, libprag.}

proc newGLVideoAllocationParamsWrappedData*(context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; wrappedData: pointer; userData: pointer;
    notify: DestroyNotify): GLVideoAllocationParams =
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_data(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, wrappedData, userData, notify)

proc newGLVideoAllocationParamsWrappedData*(tdesc: typedesc; context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; wrappedData: pointer; userData: pointer;
    notify: DestroyNotify): tdesc =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_data(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, wrappedData, userData, notify)

proc initGLVideoAllocationParamsWrappedData*[T](result: var T; context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; wrappedData: pointer; userData: pointer;
    notify: DestroyNotify) {.deprecated.} =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_data(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, wrappedData, userData, notify)

proc gst_gl_video_allocation_params_new_wrapped_gl_handle(context: ptr GLContext00;
    allocParams: ptr gst.AllocationParams00; vInfo: ptr gstvideo.VideoInfo00;
    plane: uint32; valign: gstvideo.VideoAlignment; target: GLTextureTarget;
    texFormat: GLFormat; glHandle: pointer; userData: pointer; notify: DestroyNotify): ptr GLVideoAllocationParams00 {.
    importc, libprag.}

proc newGLVideoAllocationParamsWrappedGlHandle*(context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; glHandle: pointer; userData: pointer;
    notify: DestroyNotify): GLVideoAllocationParams =
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_gl_handle(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, glHandle, userData, notify)

proc newGLVideoAllocationParamsWrappedGlHandle*(tdesc: typedesc; context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; glHandle: pointer; userData: pointer;
    notify: DestroyNotify): tdesc =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_gl_handle(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, glHandle, userData, notify)

proc initGLVideoAllocationParamsWrappedGlHandle*[T](result: var T; context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; glHandle: pointer; userData: pointer;
    notify: DestroyNotify) {.deprecated.} =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_gl_handle(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, glHandle, userData, notify)

proc gst_gl_video_allocation_params_new_wrapped_texture(context: ptr GLContext00;
    allocParams: ptr gst.AllocationParams00; vInfo: ptr gstvideo.VideoInfo00;
    plane: uint32; valign: gstvideo.VideoAlignment; target: GLTextureTarget;
    texFormat: GLFormat; texId: uint32; userData: pointer; notify: DestroyNotify): ptr GLVideoAllocationParams00 {.
    importc, libprag.}

proc newGLVideoAllocationParamsWrappedTexture*(context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; texId: int; userData: pointer;
    notify: DestroyNotify): GLVideoAllocationParams =
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_texture(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, uint32(texId), userData, notify)

proc newGLVideoAllocationParamsWrappedTexture*(tdesc: typedesc; context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; texId: int; userData: pointer;
    notify: DestroyNotify): tdesc =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_texture(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, uint32(texId), userData, notify)

proc initGLVideoAllocationParamsWrappedTexture*[T](result: var T; context: GLContext;
    allocParams: gst.AllocationParams = nil; vInfo: gstvideo.VideoInfo; plane: int;
    valign: gstvideo.VideoAlignment = cast[var gstvideo.VideoAlignment](nil);
    target: GLTextureTarget; texFormat: GLFormat; texId: int; userData: pointer;
    notify: DestroyNotify) {.deprecated.} =
  assert(result is GLVideoAllocationParams)
  fnew(result, gBoxedFreeGstGLVideoAllocationParams)
  result.impl = gst_gl_video_allocation_params_new_wrapped_texture(cast[ptr GLContext00](context.impl), if allocParams.isNil: nil else: cast[ptr gst.AllocationParams00](allocParams.impl), cast[ptr gstvideo.VideoInfo00](vInfo.impl), uint32(plane), valign, target, texFormat, uint32(texId), userData, notify)

proc gst_gl_video_allocation_params_copy_data(self: ptr GLVideoAllocationParams00;
    destVid: ptr GLVideoAllocationParams00) {.
    importc, libprag.}

proc copyData*(self: GLVideoAllocationParams;
    destVid: GLVideoAllocationParams) =
  gst_gl_video_allocation_params_copy_data(cast[ptr GLVideoAllocationParams00](self.impl), cast[ptr GLVideoAllocationParams00](destVid.impl))

proc gst_gl_video_allocation_params_free_data(self: ptr GLVideoAllocationParams00) {.
    importc, libprag.}

proc freeData*(self: GLVideoAllocationParams) =
  gst_gl_video_allocation_params_free_data(cast[ptr GLVideoAllocationParams00](self.impl))

type
  GLViewConvert* = ref object of gst.Object
  GLViewConvert00* = object of gst.Object00

proc gst_gl_view_convert_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GLViewConvert()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_gl_view_convert_new(): ptr GLViewConvert00 {.
    importc, libprag.}

proc newGLViewConvert*(): GLViewConvert =
  let gobj = gst_gl_view_convert_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGLViewConvert*(tdesc: typedesc): tdesc =
  assert(result is GLViewConvert)
  let gobj = gst_gl_view_convert_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGLViewConvert*[T](result: var T) {.deprecated.} =
  assert(result is GLViewConvert)
  let gobj = gst_gl_view_convert_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gstgl.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gst_gl_view_convert_fixate_caps(self: ptr GLViewConvert00; direction: gst.PadDirection;
    caps: ptr gst.Caps00; othercaps: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc fixateCaps*(self: GLViewConvert; direction: gst.PadDirection;
    caps: gst.Caps; othercaps: gst.Caps): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_gl_view_convert_fixate_caps(cast[ptr GLViewConvert00](self.impl), direction, cast[ptr gst.Caps00](caps.impl), cast[ptr gst.Caps00](g_boxed_copy(gst_caps_get_type(), othercaps.impl)))

proc gst_gl_view_convert_get_output(self: ptr GLViewConvert00; outbufPtr: var ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc getOutput*(self: GLViewConvert; outbufPtr: var gst.Buffer): gst.FlowReturn =
  fnew(outbufPtr, gBoxedFreeGstBuffer)
  gst_gl_view_convert_get_output(cast[ptr GLViewConvert00](self.impl), cast[var ptr gst.Buffer00](addr outbufPtr.impl))

proc gst_gl_view_convert_perform(self: ptr GLViewConvert00; inbuf: ptr gst.Buffer00): ptr gst.Buffer00 {.
    importc, libprag.}

proc perform*(self: GLViewConvert; inbuf: gst.Buffer): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_gl_view_convert_perform(cast[ptr GLViewConvert00](self.impl), cast[ptr gst.Buffer00](inbuf.impl))

proc gst_gl_view_convert_reset(self: ptr GLViewConvert00) {.
    importc, libprag.}

proc reset*(self: GLViewConvert) =
  gst_gl_view_convert_reset(cast[ptr GLViewConvert00](self.impl))

proc gst_gl_view_convert_set_caps(self: ptr GLViewConvert00; inCaps: ptr gst.Caps00;
    outCaps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc setCaps*(self: GLViewConvert; inCaps: gst.Caps;
    outCaps: gst.Caps): bool =
  toBool(gst_gl_view_convert_set_caps(cast[ptr GLViewConvert00](self.impl), cast[ptr gst.Caps00](inCaps.impl), cast[ptr gst.Caps00](outCaps.impl)))

proc gst_gl_view_convert_set_context(self: ptr GLViewConvert00; context: ptr GLContext00) {.
    importc, libprag.}

proc setContext*(self: GLViewConvert; context: GLContext) =
  gst_gl_view_convert_set_context(cast[ptr GLViewConvert00](self.impl), cast[ptr GLContext00](context.impl))

proc `context=`*(self: GLViewConvert; context: GLContext) =
  gst_gl_view_convert_set_context(cast[ptr GLViewConvert00](self.impl), cast[ptr GLContext00](context.impl))

proc gst_gl_view_convert_submit_input_buffer(self: ptr GLViewConvert00; isDiscont: gboolean;
    input: ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc submitInputBuffer*(self: GLViewConvert; isDiscont: bool;
    input: gst.Buffer): gst.FlowReturn =
  gst_gl_view_convert_submit_input_buffer(cast[ptr GLViewConvert00](self.impl), gboolean(isDiscont), cast[ptr gst.Buffer00](g_boxed_copy(gst_buffer_get_type(), input.impl)))

proc gst_gl_view_convert_transform_caps(self: ptr GLViewConvert00; direction: gst.PadDirection;
    caps: ptr gst.Caps00; filter: ptr gst.Caps00): ptr gst.Caps00 {.
    importc, libprag.}

proc transformCaps*(self: GLViewConvert; direction: gst.PadDirection;
    caps: gst.Caps; filter: gst.Caps): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_gl_view_convert_transform_caps(cast[ptr GLViewConvert00](self.impl), direction, cast[ptr gst.Caps00](caps.impl), cast[ptr gst.Caps00](filter.impl))

type
  GLWindowCB* = proc (data: pointer) {.cdecl.}

proc gst_gl_window_send_message(self: ptr GLWindow00; callback: GLWindowCB;
    data: pointer) {.
    importc, libprag.}

proc sendMessage*(self: GLWindow; callback: GLWindowCB; data: pointer) =
  gst_gl_window_send_message(cast[ptr GLWindow00](self.impl), callback, data)

proc gst_gl_window_send_message_async(self: ptr GLWindow00; callback: GLWindowCB;
    data: pointer; destroy: DestroyNotify) {.
    importc, libprag.}

proc sendMessageAsync*(self: GLWindow; callback: GLWindowCB;
    data: pointer; destroy: DestroyNotify) =
  gst_gl_window_send_message_async(cast[ptr GLWindow00](self.impl), callback, data, destroy)

proc gst_gl_window_set_close_callback(self: ptr GLWindow00; callback: GLWindowCB;
    data: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc setCloseCallback*(self: GLWindow; callback: GLWindowCB;
    data: pointer; destroyNotify: DestroyNotify) =
  gst_gl_window_set_close_callback(cast[ptr GLWindow00](self.impl), callback, data, destroyNotify)

proc gst_gl_window_set_draw_callback(self: ptr GLWindow00; callback: GLWindowCB;
    data: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc setDrawCallback*(self: GLWindow; callback: GLWindowCB;
    data: pointer; destroyNotify: DestroyNotify) =
  gst_gl_window_set_draw_callback(cast[ptr GLWindow00](self.impl), callback, data, destroyNotify)

type
  GLWindowError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    oldLibs = 1
    resourceUnavailable = 2

type
  GLWindowResizeCB* = proc (data: pointer; width: uint32; height: uint32) {.cdecl.}

proc gst_gl_window_set_resize_callback(self: ptr GLWindow00; callback: GLWindowResizeCB;
    data: pointer; destroyNotify: DestroyNotify) {.
    importc, libprag.}

proc setResizeCallback*(self: GLWindow; callback: GLWindowResizeCB;
    data: pointer; destroyNotify: DestroyNotify) =
  gst_gl_window_set_resize_callback(cast[ptr GLWindow00](self.impl), callback, data, destroyNotify)

const GL_ALLOCATION_PARAMS_ALLOC_FLAG_ALLOC* = 1'i32

const GL_ALLOCATION_PARAMS_ALLOC_FLAG_BUFFER* = 16'i32

const GL_ALLOCATION_PARAMS_ALLOC_FLAG_USER* = 65536'i32

const GL_ALLOCATION_PARAMS_ALLOC_FLAG_VIDEO* = 8'i32

const GL_ALLOCATION_PARAMS_ALLOC_FLAG_WRAP_GPU_HANDLE* = 4'i32

const GL_ALLOCATION_PARAMS_ALLOC_FLAG_WRAP_SYSMEM* = 2'i32

const GL_API_GLES1_NAME* = "gles1"

const GL_API_GLES2_NAME* = "gles2"

const GL_API_OPENGL3_NAME* = "opengl3"

const GL_API_OPENGL_NAME* = "opengl"

const GL_BASE_MEMORY_ALLOCATOR_NAME* = "GLBaseMemory"

const GL_BUFFER_ALLOCATOR_NAME* = "GLBuffer"

const GL_COLOR_CONVERT_FORMATS* = "{ RGBA, RGB, RGBx, BGR, BGRx, BGRA, xRGB, xBGR, ARGB, ABGR, Y444, I420, YV12, Y42B, Y41B, NV12, NV21, NV16, NV61, YUY2, UYVY, Y210, AYUV, VUYA, Y410, GRAY8, GRAY16_LE, GRAY16_BE, RGB16, BGR16, ARGB64 "

const GL_COLOR_CONVERT_VIDEO_CAPS* = "video/x-raw("

const GL_CONTEXT_TYPE_CGL* = "gst.gl.context.CGL"

const GL_CONTEXT_TYPE_EAGL* = "gst.gl.context.EAGL"

const GL_CONTEXT_TYPE_EGL* = "gst.gl.context.EGL"

const GL_CONTEXT_TYPE_GLX* = "gst.gl.context.GLX"

const GL_CONTEXT_TYPE_WGL* = "gst.gl.context.WGL"

const GL_DISPLAY_CONTEXT_TYPE* = "gst.gl.GLDisplay"

const GL_MEMORY_ALLOCATOR_NAME* = "GLMemory"

const GL_MEMORY_PBO_ALLOCATOR_NAME* = "GLMemoryPBO"

const GL_MEMORY_VIDEO_FORMATS_STR* = "{ RGBA, BGRA, RGBx, BGRx, ARGB, ABGR, xRGB, xBGR, RGB, BGR, RGB16, BGR16, AYUV, VUYA, Y410, I420, YV12, NV12, NV21, NV16, NV61, YUY2, UYVY, Y210, Y41B, Y42B, Y444, GRAY8, GRAY16_LE, GRAY16_BE, ARGB64"

const GL_RENDERBUFFER_ALLOCATOR_NAME* = "GLRenderbuffer"

const GL_TEXTURE_TARGET_2D_STR* = "2D"

const GL_TEXTURE_TARGET_EXTERNAL_OES_STR* = "external-oes"

const GL_TEXTURE_TARGET_RECTANGLE_STR* = "rectangle"

const MAP_GL* = 131072'i32

proc gst_buffer_add_gl_sync_meta(context: ptr GLContext00; buffer: ptr gst.Buffer00): ptr GLSyncMeta00 {.
    importc, libprag.}

proc bufferAddGlSyncMeta*(context: GLContext; buffer: gst.Buffer): GLSyncMeta =
  new(result)
  result.impl = gst_buffer_add_gl_sync_meta(cast[ptr GLContext00](context.impl), cast[ptr gst.Buffer00](buffer.impl))
  result.ignoreFinalizer = true

proc gst_buffer_add_gl_sync_meta_full(context: ptr GLContext00; buffer: ptr gst.Buffer00;
    data: pointer): ptr GLSyncMeta00 {.
    importc, libprag.}

proc bufferAddGlSyncMetaFull*(context: GLContext; buffer: gst.Buffer;
    data: pointer): GLSyncMeta =
  new(result)
  result.impl = gst_buffer_add_gl_sync_meta_full(cast[ptr GLContext00](context.impl), cast[ptr gst.Buffer00](buffer.impl), data)
  result.ignoreFinalizer = true

proc gst_buffer_pool_config_get_gl_allocation_params(config: ptr gst.Structure00): ptr GLAllocationParams00 {.
    importc, libprag.}

proc bufferPoolConfigGetGlAllocationParams*(config: gst.Structure): GLAllocationParams =
  fnew(result, gBoxedFreeGstGLAllocationParams)
  result.impl = gst_buffer_pool_config_get_gl_allocation_params(cast[ptr gst.Structure00](config.impl))

proc gst_buffer_pool_config_set_gl_allocation_params(config: ptr gst.Structure00;
    params: ptr GLAllocationParams00) {.
    importc, libprag.}

proc bufferPoolConfigSetGlAllocationParams*(config: gst.Structure;
    params: GLAllocationParams) =
  gst_buffer_pool_config_set_gl_allocation_params(cast[ptr gst.Structure00](config.impl), cast[ptr GLAllocationParams00](params.impl))

proc gst_context_get_gl_display(context: ptr gst.Context00; display: var ptr GLDisplay00): gboolean {.
    importc, libprag.}

proc contextGetGlDisplay*(context: gst.Context; display: var GLDisplay): bool =
  var tmpoutgobjectarg: ptr GLDisplay00
  result = toBool(gst_context_get_gl_display(cast[ptr gst.Context00](context.impl), tmpoutgobjectarg))
#  dothemagic(display
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    display = cast[type(display)](argqdata)
    assert(display.impl == tmpoutgobjectarg)
  else:
    fnew(display, gstgl.finalizeGObject)
    display.impl = tmpoutgobjectarg
    GC_ref(display)
    if g_object_is_floating(display.impl).int != 0:
      discard g_object_ref_sink(display.impl)
    g_object_add_toggle_ref(display.impl, toggleNotify, addr(display[]))
    g_object_unref(display.impl)
    assert(g_object_get_qdata(display.impl, Quark) == nil)
    g_object_set_qdata(display.impl, Quark, addr(display[]))


proc gst_context_set_gl_display(context: ptr gst.Context00; display: ptr GLDisplay00) {.
    importc, libprag.}

proc contextSetGlDisplay*(context: gst.Context; display: GLDisplay) =
  gst_context_set_gl_display(cast[ptr gst.Context00](context.impl), cast[ptr GLDisplay00](display.impl))

proc gst_gl_check_extension(name: cstring; ext: cstring): gboolean {.
    importc, libprag.}

proc glCheckExtension*(name: cstring; ext: cstring): bool =
  toBool(gst_gl_check_extension(name, ext))

proc gst_gl_element_propagate_display_context(element: ptr gst.Element00;
    display: ptr GLDisplay00) {.
    importc, libprag.}

proc glElementPropagateDisplayContext*(element: gst.Element; display: GLDisplay) =
  gst_gl_element_propagate_display_context(cast[ptr gst.Element00](element.impl), cast[ptr GLDisplay00](display.impl))

proc gst_gl_ensure_element_data(element: pointer; displayPtr: var ptr GLDisplay00;
    otherContextPtr: var ptr GLContext00): gboolean {.
    importc, libprag.}

proc glEnsureElementData*(element: pointer; displayPtr: var GLDisplay;
    otherContextPtr: var GLContext): bool =
  toBool(gst_gl_ensure_element_data(element, cast[var ptr GLDisplay00](addr displayPtr.impl), cast[var ptr GLContext00](addr otherContextPtr.impl)))

proc gst_gl_get_plane_data_size(info: ptr gstvideo.VideoInfo00; align: gstvideo.VideoAlignment;
    plane: uint32): uint64 {.
    importc, libprag.}

proc glGetPlaneDataSize*(info: gstvideo.VideoInfo; align: gstvideo.VideoAlignment;
    plane: int): uint64 =
  gst_gl_get_plane_data_size(cast[ptr gstvideo.VideoInfo00](info.impl), align, uint32(plane))

proc gst_gl_get_plane_start(info: ptr gstvideo.VideoInfo00; valign: gstvideo.VideoAlignment;
    plane: uint32): uint64 {.
    importc, libprag.}

proc glGetPlaneStart*(info: gstvideo.VideoInfo; valign: gstvideo.VideoAlignment;
    plane: int): uint64 =
  gst_gl_get_plane_start(cast[ptr gstvideo.VideoInfo00](info.impl), valign, uint32(plane))

proc gst_gl_handle_context_query(element: ptr gst.Element00; query: ptr gst.Query00;
    display: ptr GLDisplay00; context: ptr GLContext00; otherContext: ptr GLContext00): gboolean {.
    importc, libprag.}

proc glHandleContextQuery*(element: gst.Element; query: gst.Query;
    display: GLDisplay = nil; context: GLContext = nil; otherContext: GLContext = nil): bool =
  toBool(gst_gl_handle_context_query(cast[ptr gst.Element00](element.impl), cast[ptr gst.Query00](query.impl), if display.isNil: nil else: cast[ptr GLDisplay00](display.impl), if context.isNil: nil else: cast[ptr GLContext00](context.impl), if otherContext.isNil: nil else: cast[ptr GLContext00](otherContext.impl)))

proc gst_gl_handle_set_context(element: ptr gst.Element00; context: ptr gst.Context00;
    display: var ptr GLDisplay00; otherContext: var ptr GLContext00): gboolean {.
    importc, libprag.}

proc glHandleSetContext*(element: gst.Element; context: gst.Context;
    display: var GLDisplay; otherContext: var GLContext): bool =
  toBool(gst_gl_handle_set_context(cast[ptr gst.Element00](element.impl), cast[ptr gst.Context00](context.impl), cast[var ptr GLDisplay00](addr display.impl), cast[var ptr GLContext00](addr otherContext.impl)))

proc gst_gl_sized_gl_format_from_gl_format_type(context: ptr GLContext00;
    format: uint32; `type`: uint32): uint32 {.
    importc, libprag.}

proc glSizedGlFormatFromGlFormatType*(context: GLContext; format: int;
    `type`: int): int =
  int(gst_gl_sized_gl_format_from_gl_format_type(cast[ptr GLContext00](context.impl), uint32(format), uint32(`type`)))

proc glStereoDownmixModeGetType*(): GType {.
    importc: "gst_gl_stereo_downmix_mode_get_type", libprag.}

proc glSyncMetaApiGetType*(): GType {.
    importc: "gst_gl_sync_meta_api_get_type", libprag.}

proc glValueGetTextureTargetMask*(value: gobject.Value): GLTextureTarget {.
    importc: "gst_gl_value_get_texture_target_mask", libprag.}

proc gst_gl_value_set_texture_target(value: gobject.Value; target: GLTextureTarget): gboolean {.
    importc, libprag.}

proc glValueSetTextureTarget*(value: gobject.Value; target: GLTextureTarget): bool =
  toBool(gst_gl_value_set_texture_target(value, target))

proc gst_gl_value_set_texture_target_from_mask(value: gobject.Value; targetMask: GLTextureTarget): gboolean {.
    importc, libprag.}

proc glValueSetTextureTargetFromMask*(value: gobject.Value; targetMask: GLTextureTarget): bool =
  toBool(gst_gl_value_set_texture_target_from_mask(value, targetMask))

proc gst_gl_version_to_glsl_version(glApi: GLAPI; maj: int32; min: int32): GLSLVersion {.
    importc, libprag.}

proc glVersionToGlslVersion*(glApi: GLAPI; maj: int; min: int): GLSLVersion =
  gst_gl_version_to_glsl_version(glApi, int32(maj), int32(min))

proc gst_glsl_string_get_version_profile(s: cstring; version: var GLSLVersion;
    profile: var GLSLProfile): gboolean {.
    importc, libprag.}

proc glslStringGetVersionProfile*(s: cstring; version: var GLSLVersion;
    profile: var GLSLProfile): bool =
  toBool(gst_glsl_string_get_version_profile(s, version, profile))

proc gst_is_gl_base_memory(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isGlBaseMemory*(mem: gst.Memory): bool =
  toBool(gst_is_gl_base_memory(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_gl_buffer(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isGlBuffer*(mem: gst.Memory): bool =
  toBool(gst_is_gl_buffer(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_gl_memory(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isGlMemory*(mem: gst.Memory): bool =
  toBool(gst_is_gl_memory(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_gl_memory_pbo(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isGlMemoryPbo*(mem: gst.Memory): bool =
  toBool(gst_is_gl_memory_pbo(cast[ptr gst.Memory00](mem.impl)))

proc gst_is_gl_renderbuffer(mem: ptr gst.Memory00): gboolean {.
    importc, libprag.}

proc isGlRenderbuffer*(mem: gst.Memory): bool =
  toBool(gst_is_gl_renderbuffer(cast[ptr gst.Memory00](mem.impl)))
# === remaining symbols:
