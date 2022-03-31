# dependencies:
# xlib-2.0
# GdkPixbuf-2.0
# GLib-2.0
# Soup-2.4
# JavaScriptCore-4.0
# HarfBuzz-0.0
# Gtk-3.0
# cairo-1.0
# GObject-2.0
# Gdk-3.0
# Gio-2.0
# GModule-2.0
# Pango-1.0
# Atk-1.0
# immediate dependencies:
# Soup-2.4
# JavaScriptCore-4.0
# Gtk-3.0
# GObject-2.0
# libraries:
# libwebkit2gtk-4.0.so.37,libjavascriptcoregtk-4.0.so.18
{.warning[UnusedImport]: off.}
import xlib, gdkpixbuf, glib, soup, javascriptcore, harfbuzz, gtk, cairo, gobject, gdk, gio, gmodule, pango, atk
const Lib = "libwebkit2gtk-4.0.so.37"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  ConsoleMessage00* {.pure.} = object
  ConsoleMessage* = ref object
    impl*: ptr ConsoleMessage00
    ignoreFinalizer*: bool

proc webkit_console_message_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeWebKitConsoleMessage*(self: ConsoleMessage) =
  if not self.ignoreFinalizer:
    boxedFree(webkit_console_message_get_type(), cast[ptr ConsoleMessage00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ConsoleMessage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(webkit_console_message_get_type(), cast[ptr ConsoleMessage00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var ConsoleMessage) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeWebKitConsoleMessage)

proc webkit_console_message_free(self: ptr ConsoleMessage00) {.
    importc, libprag.}

proc free*(self: ConsoleMessage) =
  webkit_console_message_free(cast[ptr ConsoleMessage00](self.impl))

proc finalizerfree*(self: ConsoleMessage) =
  if not self.ignoreFinalizer:
    webkit_console_message_free(cast[ptr ConsoleMessage00](self.impl))

proc webkit_console_message_copy(self: ptr ConsoleMessage00): ptr ConsoleMessage00 {.
    importc, libprag.}

proc copy*(self: ConsoleMessage): ConsoleMessage =
  fnew(result, gBoxedFreeWebKitConsoleMessage)
  result.impl = webkit_console_message_copy(cast[ptr ConsoleMessage00](self.impl))

proc webkit_console_message_get_line(self: ptr ConsoleMessage00): uint32 {.
    importc, libprag.}

proc getLine*(self: ConsoleMessage): int =
  int(webkit_console_message_get_line(cast[ptr ConsoleMessage00](self.impl)))

proc line*(self: ConsoleMessage): int =
  int(webkit_console_message_get_line(cast[ptr ConsoleMessage00](self.impl)))

proc webkit_console_message_get_source_id(self: ptr ConsoleMessage00): cstring {.
    importc, libprag.}

proc getSourceId*(self: ConsoleMessage): string =
  result = $webkit_console_message_get_source_id(cast[ptr ConsoleMessage00](self.impl))

proc sourceId*(self: ConsoleMessage): string =
  result = $webkit_console_message_get_source_id(cast[ptr ConsoleMessage00](self.impl))

proc webkit_console_message_get_text(self: ptr ConsoleMessage00): cstring {.
    importc, libprag.}

proc getText*(self: ConsoleMessage): string =
  result = $webkit_console_message_get_text(cast[ptr ConsoleMessage00](self.impl))

proc text*(self: ConsoleMessage): string =
  result = $webkit_console_message_get_text(cast[ptr ConsoleMessage00](self.impl))

type
  ConsoleMessageLevel* {.size: sizeof(cint), pure.} = enum
    info = 0
    log = 1
    warning = 2
    error = 3
    debug = 4

proc webkit_console_message_get_level(self: ptr ConsoleMessage00): ConsoleMessageLevel {.
    importc, libprag.}

proc getLevel*(self: ConsoleMessage): ConsoleMessageLevel =
  webkit_console_message_get_level(cast[ptr ConsoleMessage00](self.impl))

proc level*(self: ConsoleMessage): ConsoleMessageLevel =
  webkit_console_message_get_level(cast[ptr ConsoleMessage00](self.impl))

type
  ConsoleMessageSource* {.size: sizeof(cint), pure.} = enum
    javascript = 0
    network = 1
    consoleApi = 2
    security = 3
    other = 4

proc webkit_console_message_get_source(self: ptr ConsoleMessage00): ConsoleMessageSource {.
    importc, libprag.}

proc getSource*(self: ConsoleMessage): ConsoleMessageSource =
  webkit_console_message_get_source(cast[ptr ConsoleMessage00](self.impl))

proc source*(self: ConsoleMessage): ConsoleMessageSource =
  webkit_console_message_get_source(cast[ptr ConsoleMessage00](self.impl))

type
  ContextMenu* = ref object of gobject.Object
  ContextMenu00* = object of gobject.Object00

proc webkit_context_menu_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContextMenu()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  ContextMenuAction* {.size: sizeof(cint), pure.} = enum
    noAction = 0
    openLink = 1
    openLinkInNewWindow = 2
    downloadLinkToDisk = 3
    copyLinkToClipboard = 4
    openImageInNewWindow = 5
    downloadImageToDisk = 6
    copyImageToClipboard = 7
    copyImageUrlToClipboard = 8
    openFrameInNewWindow = 9
    goBack = 10
    goForward = 11
    stop = 12
    reload = 13
    copy = 14
    cut = 15
    paste = 16
    delete = 17
    selectAll = 18
    inputMethods = 19
    unicode = 20
    spellingGuess = 21
    noGuessesFound = 22
    ignoreSpelling = 23
    learnSpelling = 24
    ignoreGrammar = 25
    fontMenu = 26
    bold = 27
    italic = 28
    underline = 29
    outline = 30
    inspectElement = 31
    openVideoInNewWindow = 32
    openAudioInNewWindow = 33
    copyVideoLinkToClipboard = 34
    copyAudioLinkToClipboard = 35
    toggleMediaControls = 36
    toggleMediaLoop = 37
    enterVideoFullscreen = 38
    mediaPlay = 39
    mediaPause = 40
    mediaMute = 41
    downloadVideoToDisk = 42
    downloadAudioToDisk = 43
    insertEmoji = 44
    pasteAsPlainText = 45
    custom = 10000

type
  ContextMenuItem* = ref object of gobject.InitiallyUnowned
  ContextMenuItem00* = object of gobject.InitiallyUnowned00

proc webkit_context_menu_item_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ContextMenuItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  DOMObject* = ref object of gobject.Object
  DOMObject00* = object of gobject.Object00

proc webkit_dom_object_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMObject()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  DOMNode* = ref object of DOMObject
  DOMNode00* = object of DOMObject00

proc webkit_dom_node_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMNode()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_node_for_js_value(value: ptr javascriptcore.Value00): ptr DOMNode00 {.
    importc, libprag.}

proc forJsValue*(value: javascriptcore.Value): DOMNode =
  let gobj = webkit_dom_node_for_js_value(cast[ptr javascriptcore.Value00](value.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_append_child(self: ptr DOMNode00; newChild: ptr DOMNode00;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc appendChild*(self: DOMNode; newChild: DOMNode): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_append_child(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](newChild.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_clone_node(self: ptr DOMNode00; deep: gboolean; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc cloneNode*(self: DOMNode; deep: bool): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_clone_node(cast[ptr DOMNode00](self.impl), gboolean(deep), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_clone_node_with_error(self: ptr DOMNode00; deep: gboolean;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc cloneNodeWithError*(self: DOMNode; deep: bool): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_clone_node_with_error(cast[ptr DOMNode00](self.impl), gboolean(deep), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_compare_document_position(self: ptr DOMNode00; other: ptr DOMNode00): uint16 {.
    importc, libprag.}

proc compareDocumentPosition*(self: DOMNode; other: DOMNode): uint16 =
  webkit_dom_node_compare_document_position(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](other.impl))

proc webkit_dom_node_contains(self: ptr DOMNode00; other: ptr DOMNode00): gboolean {.
    importc, libprag.}

proc contains*(self: DOMNode; other: DOMNode): bool =
  toBool(webkit_dom_node_contains(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](other.impl)))

proc webkit_dom_node_get_base_uri(self: ptr DOMNode00): cstring {.
    importc, libprag.}

proc getBaseUri*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_base_uri(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc baseUri*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_base_uri(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_get_first_child(self: ptr DOMNode00): ptr DOMNode00 {.
    importc, libprag.}

proc getFirstChild*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_first_child(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc firstChild*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_first_child(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_get_last_child(self: ptr DOMNode00): ptr DOMNode00 {.
    importc, libprag.}

proc getLastChild*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_last_child(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc lastChild*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_last_child(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_get_local_name(self: ptr DOMNode00): cstring {.
    importc, libprag.}

proc getLocalName*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_local_name(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc localName*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_local_name(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_get_namespace_uri(self: ptr DOMNode00): cstring {.
    importc, libprag.}

proc getNamespaceUri*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_namespace_uri(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc namespaceUri*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_namespace_uri(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_get_next_sibling(self: ptr DOMNode00): ptr DOMNode00 {.
    importc, libprag.}

proc getNextSibling*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_next_sibling(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc nextSibling*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_next_sibling(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_get_node_name(self: ptr DOMNode00): cstring {.
    importc, libprag.}

proc getNodeName*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_node_name(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc nodeName*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_node_name(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_get_node_type(self: ptr DOMNode00): uint16 {.
    importc, libprag.}

proc getNodeType*(self: DOMNode): uint16 =
  webkit_dom_node_get_node_type(cast[ptr DOMNode00](self.impl))

proc nodeType*(self: DOMNode): uint16 =
  webkit_dom_node_get_node_type(cast[ptr DOMNode00](self.impl))

proc webkit_dom_node_get_node_value(self: ptr DOMNode00): cstring {.
    importc, libprag.}

proc getNodeValue*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_node_value(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc nodeValue*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_node_value(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_get_parent_node(self: ptr DOMNode00): ptr DOMNode00 {.
    importc, libprag.}

proc getParentNode*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_parent_node(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parentNode*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_parent_node(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_get_prefix(self: ptr DOMNode00): cstring {.
    importc, libprag.}

proc getPrefix*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_prefix(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc prefix*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_prefix(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_get_previous_sibling(self: ptr DOMNode00): ptr DOMNode00 {.
    importc, libprag.}

proc getPreviousSibling*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_previous_sibling(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc previousSibling*(self: DOMNode): DOMNode =
  let gobj = webkit_dom_node_get_previous_sibling(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_get_text_content(self: ptr DOMNode00): cstring {.
    importc, libprag.}

proc getTextContent*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_text_content(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc textContent*(self: DOMNode): string =
  let resul0 = webkit_dom_node_get_text_content(cast[ptr DOMNode00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_has_child_nodes(self: ptr DOMNode00): gboolean {.
    importc, libprag.}

proc hasChildNodes*(self: DOMNode): bool =
  toBool(webkit_dom_node_has_child_nodes(cast[ptr DOMNode00](self.impl)))

proc webkit_dom_node_insert_before(self: ptr DOMNode00; newChild: ptr DOMNode00;
    refChild: ptr DOMNode00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc insertBefore*(self: DOMNode; newChild: DOMNode; refChild: DOMNode = nil): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_insert_before(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](newChild.impl), if refChild.isNil: nil else: cast[ptr DOMNode00](refChild.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_is_default_namespace(self: ptr DOMNode00; namespaceURI: cstring): gboolean {.
    importc, libprag.}

proc isDefaultNamespace*(self: DOMNode; namespaceURI: cstring): bool =
  toBool(webkit_dom_node_is_default_namespace(cast[ptr DOMNode00](self.impl), namespaceURI))

proc webkit_dom_node_is_equal_node(self: ptr DOMNode00; other: ptr DOMNode00): gboolean {.
    importc, libprag.}

proc isEqualNode*(self: DOMNode; other: DOMNode): bool =
  toBool(webkit_dom_node_is_equal_node(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](other.impl)))

proc webkit_dom_node_is_same_node(self: ptr DOMNode00; other: ptr DOMNode00): gboolean {.
    importc, libprag.}

proc isSameNode*(self: DOMNode; other: DOMNode): bool =
  toBool(webkit_dom_node_is_same_node(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](other.impl)))

proc webkit_dom_node_is_supported(self: ptr DOMNode00; feature: cstring;
    version: cstring): gboolean {.
    importc, libprag.}

proc isSupported*(self: DOMNode; feature: cstring; version: cstring): bool =
  toBool(webkit_dom_node_is_supported(cast[ptr DOMNode00](self.impl), feature, version))

proc webkit_dom_node_lookup_namespace_uri(self: ptr DOMNode00; prefix: cstring): cstring {.
    importc, libprag.}

proc lookupNamespaceUri*(self: DOMNode; prefix: cstring): string =
  let resul0 = webkit_dom_node_lookup_namespace_uri(cast[ptr DOMNode00](self.impl), prefix)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_lookup_prefix(self: ptr DOMNode00; namespaceURI: cstring): cstring {.
    importc, libprag.}

proc lookupPrefix*(self: DOMNode; namespaceURI: cstring): string =
  let resul0 = webkit_dom_node_lookup_prefix(cast[ptr DOMNode00](self.impl), namespaceURI)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_node_normalize(self: ptr DOMNode00) {.
    importc, libprag.}

proc normalize*(self: DOMNode) =
  webkit_dom_node_normalize(cast[ptr DOMNode00](self.impl))

proc webkit_dom_node_remove_child(self: ptr DOMNode00; oldChild: ptr DOMNode00;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc removeChild*(self: DOMNode; oldChild: DOMNode): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_remove_child(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](oldChild.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_replace_child(self: ptr DOMNode00; newChild: ptr DOMNode00;
    oldChild: ptr DOMNode00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc replaceChild*(self: DOMNode; newChild: DOMNode; oldChild: DOMNode): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_replace_child(cast[ptr DOMNode00](self.impl), cast[ptr DOMNode00](newChild.impl), cast[ptr DOMNode00](oldChild.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_set_node_value(self: ptr DOMNode00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setNodeValue*(self: DOMNode; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_node_set_node_value(cast[ptr DOMNode00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `nodeValue=`*(self: DOMNode; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_node_set_node_value(cast[ptr DOMNode00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_node_set_prefix(self: ptr DOMNode00; value: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setPrefix*(self: DOMNode; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_node_set_prefix(cast[ptr DOMNode00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `prefix=`*(self: DOMNode; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_node_set_prefix(cast[ptr DOMNode00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_node_set_text_content(self: ptr DOMNode00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setTextContent*(self: DOMNode; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_node_set_text_content(cast[ptr DOMNode00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `textContent=`*(self: DOMNode; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_node_set_text_content(cast[ptr DOMNode00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

type
  DOMAttr* = ref object of DOMNode
  DOMAttr00* = object of DOMNode00

proc webkit_dom_attr_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMAttr()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_attr_get_local_name(self: ptr DOMAttr00): cstring {.
    importc, libprag.}

proc getLocalName*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_local_name(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc localName*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_local_name(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_attr_get_name(self: ptr DOMAttr00): cstring {.
    importc, libprag.}

proc getName*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_name(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_name(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_attr_get_namespace_uri(self: ptr DOMAttr00): cstring {.
    importc, libprag.}

proc getNamespaceUri*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_namespace_uri(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc namespaceUri*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_namespace_uri(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_attr_get_prefix(self: ptr DOMAttr00): cstring {.
    importc, libprag.}

proc getPrefix*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_prefix(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc prefix*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_prefix(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_attr_get_specified(self: ptr DOMAttr00): gboolean {.
    importc, libprag.}

proc getSpecified*(self: DOMAttr): bool =
  toBool(webkit_dom_attr_get_specified(cast[ptr DOMAttr00](self.impl)))

proc specified*(self: DOMAttr): bool =
  toBool(webkit_dom_attr_get_specified(cast[ptr DOMAttr00](self.impl)))

proc webkit_dom_attr_get_value(self: ptr DOMAttr00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_value(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMAttr): string =
  let resul0 = webkit_dom_attr_get_value(cast[ptr DOMAttr00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_attr_set_value(self: ptr DOMAttr00; value: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setValue*(self: DOMAttr; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_attr_set_value(cast[ptr DOMAttr00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `value=`*(self: DOMAttr; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_attr_set_value(cast[ptr DOMAttr00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

type
  DOMNodeList* = ref object of DOMObject
  DOMNodeList00* = object of DOMObject00

proc webkit_dom_node_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMNodeList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_node_list_get_length(self: ptr DOMNodeList00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMNodeList): uint64 =
  webkit_dom_node_list_get_length(cast[ptr DOMNodeList00](self.impl))

proc length*(self: DOMNodeList): uint64 =
  webkit_dom_node_list_get_length(cast[ptr DOMNodeList00](self.impl))

proc webkit_dom_node_list_item(self: ptr DOMNodeList00; index: uint64): ptr DOMNode00 {.
    importc, libprag.}

proc item*(self: DOMNodeList; index: uint64): DOMNode =
  let gobj = webkit_dom_node_list_item(cast[ptr DOMNodeList00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_get_child_nodes(self: ptr DOMNode00): ptr DOMNodeList00 {.
    importc, libprag.}

proc getChildNodes*(self: DOMNode): DOMNodeList =
  let gobj = webkit_dom_node_get_child_nodes(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc childNodes*(self: DOMNode): DOMNodeList =
  let gobj = webkit_dom_node_get_child_nodes(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMDocument* = ref object of DOMNode
  DOMDocument00* = object of DOMNode00

proc webkit_dom_document_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMDocument()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_document_adopt_node(self: ptr DOMDocument00; source: ptr DOMNode00;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc adoptNode*(self: DOMDocument; source: DOMNode): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_adopt_node(cast[ptr DOMDocument00](self.impl), cast[ptr DOMNode00](source.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_attribute(self: ptr DOMDocument00; name: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMAttr00 {.
    importc, libprag.}

proc createAttribute*(self: DOMDocument; name: cstring): DOMAttr =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_attribute(cast[ptr DOMDocument00](self.impl), name, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_attribute_ns(self: ptr DOMDocument00; namespaceURI: cstring;
    qualifiedName: cstring; error: ptr ptr glib.Error = nil): ptr DOMAttr00 {.
    importc, libprag.}

proc createAttributeNs*(self: DOMDocument; namespaceURI: cstring = nil;
    qualifiedName: cstring): DOMAttr =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_attribute_ns(cast[ptr DOMDocument00](self.impl), namespaceURI, qualifiedName, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_exec_command(self: ptr DOMDocument00; command: cstring;
    userInterface: gboolean; value: cstring): gboolean {.
    importc, libprag.}

proc execCommand*(self: DOMDocument; command: cstring;
    userInterface: bool; value: cstring): bool =
  toBool(webkit_dom_document_exec_command(cast[ptr DOMDocument00](self.impl), command, gboolean(userInterface), value))

proc webkit_dom_document_exit_pointer_lock(self: ptr DOMDocument00) {.
    importc, libprag.}

proc exitPointerLock*(self: DOMDocument) =
  webkit_dom_document_exit_pointer_lock(cast[ptr DOMDocument00](self.impl))

proc webkit_dom_document_get_character_set(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getCharacterSet*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_character_set(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc characterSet*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_character_set(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_charset(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getCharset*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_charset(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc charset*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_charset(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_child_element_count(self: ptr DOMDocument00): uint64 {.
    importc, libprag.}

proc getChildElementCount*(self: DOMDocument): uint64 =
  webkit_dom_document_get_child_element_count(cast[ptr DOMDocument00](self.impl))

proc childElementCount*(self: DOMDocument): uint64 =
  webkit_dom_document_get_child_element_count(cast[ptr DOMDocument00](self.impl))

proc webkit_dom_document_get_compat_mode(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getCompatMode*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_compat_mode(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc compatMode*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_compat_mode(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_content_type(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getContentType*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_content_type(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc contentType*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_content_type(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_cookie(self: ptr DOMDocument00; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getCookie*(self: DOMDocument): string =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_document_get_cookie(cast[ptr DOMDocument00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc cookie*(self: DOMDocument): string =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_document_get_cookie(cast[ptr DOMDocument00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_default_charset(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getDefaultCharset*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_default_charset(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc defaultCharset*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_default_charset(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_design_mode(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getDesignMode*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_design_mode(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc designMode*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_design_mode(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_dir(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getDir*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_dir(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc dir*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_dir(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_document_uri(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getDocumentUri*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_document_uri(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc documentUri*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_document_uri(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_domain(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getDomain*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_domain(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc domain*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_domain(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_elements_by_class_name(self: ptr DOMDocument00;
    className: cstring): ptr DOMNodeList00 {.
    importc, libprag.}

proc getElementsByClassName*(self: DOMDocument; className: cstring): DOMNodeList =
  let gobj = webkit_dom_document_get_elements_by_class_name(cast[ptr DOMDocument00](self.impl), className)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_elements_by_name(self: ptr DOMDocument00; elementName: cstring): ptr DOMNodeList00 {.
    importc, libprag.}

proc getElementsByName*(self: DOMDocument; elementName: cstring): DOMNodeList =
  let gobj = webkit_dom_document_get_elements_by_name(cast[ptr DOMDocument00](self.impl), elementName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_elements_by_tag_name(self: ptr DOMDocument00;
    tagName: cstring): ptr DOMNodeList00 {.
    importc, libprag.}

proc getElementsByTagName*(self: DOMDocument; tagName: cstring): DOMNodeList =
  let gobj = webkit_dom_document_get_elements_by_tag_name(cast[ptr DOMDocument00](self.impl), tagName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_elements_by_tag_name_ns(self: ptr DOMDocument00;
    namespaceUri: cstring; tagName: cstring): ptr DOMNodeList00 {.
    importc, libprag.}

proc getElementsByTagNameNs*(self: DOMDocument; namespaceUri: cstring;
    tagName: cstring): DOMNodeList =
  let gobj = webkit_dom_document_get_elements_by_tag_name_ns(cast[ptr DOMDocument00](self.impl), namespaceUri, tagName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_hidden(self: ptr DOMDocument00): gboolean {.
    importc, libprag.}

proc getHidden*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_hidden(cast[ptr DOMDocument00](self.impl)))

proc hidden*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_hidden(cast[ptr DOMDocument00](self.impl)))

proc webkit_dom_document_get_input_encoding(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getInputEncoding*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_input_encoding(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc inputEncoding*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_input_encoding(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_last_modified(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getLastModified*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_last_modified(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc lastModified*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_last_modified(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_origin(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getOrigin*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_origin(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc origin*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_origin(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_preferred_stylesheet_set(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getPreferredStylesheetSet*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_preferred_stylesheet_set(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc preferredStylesheetSet*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_preferred_stylesheet_set(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_ready_state(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getReadyState*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_ready_state(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc readyState*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_ready_state(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_referrer(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getReferrer*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_referrer(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc referrer*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_referrer(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_selected_stylesheet_set(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getSelectedStylesheetSet*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_selected_stylesheet_set(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc selectedStylesheetSet*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_selected_stylesheet_set(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_title(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getTitle*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_title(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc title*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_title(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_url(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getUrl*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_url(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc url*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_url(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_visibility_state(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getVisibilityState*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_visibility_state(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc visibilityState*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_visibility_state(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_webkit_fullscreen_enabled(self: ptr DOMDocument00): gboolean {.
    importc, libprag.}

proc getWebkitFullscreenEnabled*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_webkit_fullscreen_enabled(cast[ptr DOMDocument00](self.impl)))

proc webkitFullscreenEnabled*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_webkit_fullscreen_enabled(cast[ptr DOMDocument00](self.impl)))

proc webkit_dom_document_get_webkit_fullscreen_keyboard_input_allowed(self: ptr DOMDocument00): gboolean {.
    importc, libprag.}

proc getWebkitFullscreenKeyboardInputAllowed*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_webkit_fullscreen_keyboard_input_allowed(cast[ptr DOMDocument00](self.impl)))

proc webkitFullscreenKeyboardInputAllowed*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_webkit_fullscreen_keyboard_input_allowed(cast[ptr DOMDocument00](self.impl)))

proc webkit_dom_document_get_webkit_is_fullscreen(self: ptr DOMDocument00): gboolean {.
    importc, libprag.}

proc getWebkitIsFullscreen*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_webkit_is_fullscreen(cast[ptr DOMDocument00](self.impl)))

proc webkitIsFullscreen*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_webkit_is_fullscreen(cast[ptr DOMDocument00](self.impl)))

proc webkit_dom_document_get_xml_encoding(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getXmlEncoding*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_xml_encoding(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc xmlEncoding*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_xml_encoding(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_xml_standalone(self: ptr DOMDocument00): gboolean {.
    importc, libprag.}

proc getXmlStandalone*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_xml_standalone(cast[ptr DOMDocument00](self.impl)))

proc xmlStandalone*(self: DOMDocument): bool =
  toBool(webkit_dom_document_get_xml_standalone(cast[ptr DOMDocument00](self.impl)))

proc webkit_dom_document_get_xml_version(self: ptr DOMDocument00): cstring {.
    importc, libprag.}

proc getXmlVersion*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_xml_version(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc xmlVersion*(self: DOMDocument): string =
  let resul0 = webkit_dom_document_get_xml_version(cast[ptr DOMDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_has_focus(self: ptr DOMDocument00): gboolean {.
    importc, libprag.}

proc hasFocus*(self: DOMDocument): bool =
  toBool(webkit_dom_document_has_focus(cast[ptr DOMDocument00](self.impl)))

proc webkit_dom_document_import_node(self: ptr DOMDocument00; importedNode: ptr DOMNode00;
    deep: gboolean; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc importNode*(self: DOMDocument; importedNode: DOMNode;
    deep: bool): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_import_node(cast[ptr DOMDocument00](self.impl), cast[ptr DOMNode00](importedNode.impl), gboolean(deep), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_query_command_enabled(self: ptr DOMDocument00; command: cstring): gboolean {.
    importc, libprag.}

proc queryCommandEnabled*(self: DOMDocument; command: cstring): bool =
  toBool(webkit_dom_document_query_command_enabled(cast[ptr DOMDocument00](self.impl), command))

proc webkit_dom_document_query_command_indeterm(self: ptr DOMDocument00;
    command: cstring): gboolean {.
    importc, libprag.}

proc queryCommandIndeterm*(self: DOMDocument; command: cstring): bool =
  toBool(webkit_dom_document_query_command_indeterm(cast[ptr DOMDocument00](self.impl), command))

proc webkit_dom_document_query_command_state(self: ptr DOMDocument00; command: cstring): gboolean {.
    importc, libprag.}

proc queryCommandState*(self: DOMDocument; command: cstring): bool =
  toBool(webkit_dom_document_query_command_state(cast[ptr DOMDocument00](self.impl), command))

proc webkit_dom_document_query_command_supported(self: ptr DOMDocument00;
    command: cstring): gboolean {.
    importc, libprag.}

proc queryCommandSupported*(self: DOMDocument; command: cstring): bool =
  toBool(webkit_dom_document_query_command_supported(cast[ptr DOMDocument00](self.impl), command))

proc webkit_dom_document_query_command_value(self: ptr DOMDocument00; command: cstring): cstring {.
    importc, libprag.}

proc queryCommandValue*(self: DOMDocument; command: cstring): string =
  let resul0 = webkit_dom_document_query_command_value(cast[ptr DOMDocument00](self.impl), command)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_query_selector_all(self: ptr DOMDocument00; selectors: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMNodeList00 {.
    importc, libprag.}

proc querySelectorAll*(self: DOMDocument; selectors: cstring): DOMNodeList =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_query_selector_all(cast[ptr DOMDocument00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_set_charset(self: ptr DOMDocument00; value: cstring) {.
    importc, libprag.}

proc setCharset*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_charset(cast[ptr DOMDocument00](self.impl), value)

proc `charset=`*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_charset(cast[ptr DOMDocument00](self.impl), value)

proc webkit_dom_document_set_cookie(self: ptr DOMDocument00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setCookie*(self: DOMDocument; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_cookie(cast[ptr DOMDocument00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `cookie=`*(self: DOMDocument; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_cookie(cast[ptr DOMDocument00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_document_set_design_mode(self: ptr DOMDocument00; value: cstring) {.
    importc, libprag.}

proc setDesignMode*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_design_mode(cast[ptr DOMDocument00](self.impl), value)

proc `designMode=`*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_design_mode(cast[ptr DOMDocument00](self.impl), value)

proc webkit_dom_document_set_dir(self: ptr DOMDocument00; value: cstring) {.
    importc, libprag.}

proc setDir*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_dir(cast[ptr DOMDocument00](self.impl), value)

proc `dir=`*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_dir(cast[ptr DOMDocument00](self.impl), value)

proc webkit_dom_document_set_document_uri(self: ptr DOMDocument00; value: cstring) {.
    importc, libprag.}

proc setDocumentUri*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_document_uri(cast[ptr DOMDocument00](self.impl), value)

proc `documentUri=`*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_document_uri(cast[ptr DOMDocument00](self.impl), value)

proc webkit_dom_document_set_selected_stylesheet_set(self: ptr DOMDocument00;
    value: cstring) {.
    importc, libprag.}

proc setSelectedStylesheetSet*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_selected_stylesheet_set(cast[ptr DOMDocument00](self.impl), value)

proc `selectedStylesheetSet=`*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_selected_stylesheet_set(cast[ptr DOMDocument00](self.impl), value)

proc webkit_dom_document_set_title(self: ptr DOMDocument00; value: cstring) {.
    importc, libprag.}

proc setTitle*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_title(cast[ptr DOMDocument00](self.impl), value)

proc `title=`*(self: DOMDocument; value: cstring) =
  webkit_dom_document_set_title(cast[ptr DOMDocument00](self.impl), value)

proc webkit_dom_document_set_xml_standalone(self: ptr DOMDocument00; value: gboolean;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setXmlStandalone*(self: DOMDocument; value: bool = true) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_xml_standalone(cast[ptr DOMDocument00](self.impl), gboolean(value), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `xmlStandalone=`*(self: DOMDocument; value: bool) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_xml_standalone(cast[ptr DOMDocument00](self.impl), gboolean(value), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_document_set_xml_version(self: ptr DOMDocument00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setXmlVersion*(self: DOMDocument; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_xml_version(cast[ptr DOMDocument00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `xmlVersion=`*(self: DOMDocument; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_xml_version(cast[ptr DOMDocument00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_document_webkit_cancel_fullscreen(self: ptr DOMDocument00) {.
    importc, libprag.}

proc webkitCancelFullscreen*(self: DOMDocument) =
  webkit_dom_document_webkit_cancel_fullscreen(cast[ptr DOMDocument00](self.impl))

proc webkit_dom_document_webkit_exit_fullscreen(self: ptr DOMDocument00) {.
    importc, libprag.}

proc webkitExitFullscreen*(self: DOMDocument) =
  webkit_dom_document_webkit_exit_fullscreen(cast[ptr DOMDocument00](self.impl))

proc webkit_dom_node_get_owner_document(self: ptr DOMNode00): ptr DOMDocument00 {.
    importc, libprag.}

proc getOwnerDocument*(self: DOMNode): DOMDocument =
  let gobj = webkit_dom_node_get_owner_document(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc ownerDocument*(self: DOMNode): DOMDocument =
  let gobj = webkit_dom_node_get_owner_document(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMCharacterData* = ref object of DOMNode
  DOMCharacterData00* = object of DOMNode00

proc webkit_dom_character_data_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMCharacterData()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_character_data_append_data(self: ptr DOMCharacterData00;
    data: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc appendData*(self: DOMCharacterData; data: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_character_data_append_data(cast[ptr DOMCharacterData00](self.impl), data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_character_data_delete_data(self: ptr DOMCharacterData00;
    offset: uint64; length: uint64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc deleteData*(self: DOMCharacterData; offset: uint64;
    length: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_character_data_delete_data(cast[ptr DOMCharacterData00](self.impl), offset, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_character_data_get_data(self: ptr DOMCharacterData00): cstring {.
    importc, libprag.}

proc getData*(self: DOMCharacterData): string =
  let resul0 = webkit_dom_character_data_get_data(cast[ptr DOMCharacterData00](self.impl))
  result = $resul0
  cogfree(resul0)

proc data*(self: DOMCharacterData): string =
  let resul0 = webkit_dom_character_data_get_data(cast[ptr DOMCharacterData00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_character_data_get_length(self: ptr DOMCharacterData00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMCharacterData): uint64 =
  webkit_dom_character_data_get_length(cast[ptr DOMCharacterData00](self.impl))

proc length*(self: DOMCharacterData): uint64 =
  webkit_dom_character_data_get_length(cast[ptr DOMCharacterData00](self.impl))

proc webkit_dom_character_data_insert_data(self: ptr DOMCharacterData00;
    offset: uint64; data: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc insertData*(self: DOMCharacterData; offset: uint64;
    data: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_character_data_insert_data(cast[ptr DOMCharacterData00](self.impl), offset, data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_character_data_replace_data(self: ptr DOMCharacterData00;
    offset: uint64; length: uint64; data: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc replaceData*(self: DOMCharacterData; offset: uint64;
    length: uint64; data: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_character_data_replace_data(cast[ptr DOMCharacterData00](self.impl), offset, length, data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_character_data_set_data(self: ptr DOMCharacterData00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setData*(self: DOMCharacterData; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_character_data_set_data(cast[ptr DOMCharacterData00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `data=`*(self: DOMCharacterData; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_character_data_set_data(cast[ptr DOMCharacterData00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_character_data_substring_data(self: ptr DOMCharacterData00;
    offset: uint64; length: uint64; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc substringData*(self: DOMCharacterData; offset: uint64;
    length: uint64): string =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_character_data_substring_data(cast[ptr DOMCharacterData00](self.impl), offset, length, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

type
  DOMComment* = ref object of DOMCharacterData
  DOMComment00* = object of DOMCharacterData00

proc webkit_dom_comment_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMComment()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_document_create_comment(self: ptr DOMDocument00; data: cstring): ptr DOMComment00 {.
    importc, libprag.}

proc createComment*(self: DOMDocument; data: cstring): DOMComment =
  let gobj = webkit_dom_document_create_comment(cast[ptr DOMDocument00](self.impl), data)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMCSSStyleDeclaration* = ref object of DOMObject
  DOMCSSStyleDeclaration00* = object of DOMObject00

proc webkit_dom_css_style_declaration_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMCSSStyleDeclaration()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_css_style_declaration_get_css_text(self: ptr DOMCSSStyleDeclaration00): cstring {.
    importc, libprag.}

proc getCssText*(self: DOMCSSStyleDeclaration): string =
  let resul0 = webkit_dom_css_style_declaration_get_css_text(cast[ptr DOMCSSStyleDeclaration00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cssText*(self: DOMCSSStyleDeclaration): string =
  let resul0 = webkit_dom_css_style_declaration_get_css_text(cast[ptr DOMCSSStyleDeclaration00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_style_declaration_get_length(self: ptr DOMCSSStyleDeclaration00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMCSSStyleDeclaration): uint64 =
  webkit_dom_css_style_declaration_get_length(cast[ptr DOMCSSStyleDeclaration00](self.impl))

proc length*(self: DOMCSSStyleDeclaration): uint64 =
  webkit_dom_css_style_declaration_get_length(cast[ptr DOMCSSStyleDeclaration00](self.impl))

proc webkit_dom_css_style_declaration_get_property_priority(self: ptr DOMCSSStyleDeclaration00;
    propertyName: cstring): cstring {.
    importc, libprag.}

proc getPropertyPriority*(self: DOMCSSStyleDeclaration;
    propertyName: cstring): string =
  let resul0 = webkit_dom_css_style_declaration_get_property_priority(cast[ptr DOMCSSStyleDeclaration00](self.impl), propertyName)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_style_declaration_get_property_shorthand(self: ptr DOMCSSStyleDeclaration00;
    propertyName: cstring): cstring {.
    importc, libprag.}

proc getPropertyShorthand*(self: DOMCSSStyleDeclaration;
    propertyName: cstring): string =
  let resul0 = webkit_dom_css_style_declaration_get_property_shorthand(cast[ptr DOMCSSStyleDeclaration00](self.impl), propertyName)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_style_declaration_get_property_value(self: ptr DOMCSSStyleDeclaration00;
    propertyName: cstring): cstring {.
    importc, libprag.}

proc getPropertyValue*(self: DOMCSSStyleDeclaration;
    propertyName: cstring): string =
  let resul0 = webkit_dom_css_style_declaration_get_property_value(cast[ptr DOMCSSStyleDeclaration00](self.impl), propertyName)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_style_declaration_is_property_implicit(self: ptr DOMCSSStyleDeclaration00;
    propertyName: cstring): gboolean {.
    importc, libprag.}

proc isPropertyImplicit*(self: DOMCSSStyleDeclaration;
    propertyName: cstring): bool =
  toBool(webkit_dom_css_style_declaration_is_property_implicit(cast[ptr DOMCSSStyleDeclaration00](self.impl), propertyName))

proc webkit_dom_css_style_declaration_item(self: ptr DOMCSSStyleDeclaration00;
    index: uint64): cstring {.
    importc, libprag.}

proc item*(self: DOMCSSStyleDeclaration;
    index: uint64): string =
  let resul0 = webkit_dom_css_style_declaration_item(cast[ptr DOMCSSStyleDeclaration00](self.impl), index)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_style_declaration_remove_property(self: ptr DOMCSSStyleDeclaration00;
    propertyName: cstring; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc removeProperty*(self: DOMCSSStyleDeclaration;
    propertyName: cstring): string =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_css_style_declaration_remove_property(cast[ptr DOMCSSStyleDeclaration00](self.impl), propertyName, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_style_declaration_set_css_text(self: ptr DOMCSSStyleDeclaration00;
    value: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setCssText*(self: DOMCSSStyleDeclaration;
    value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_css_style_declaration_set_css_text(cast[ptr DOMCSSStyleDeclaration00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `cssText=`*(self: DOMCSSStyleDeclaration;
    value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_css_style_declaration_set_css_text(cast[ptr DOMCSSStyleDeclaration00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_css_style_declaration_set_property(self: ptr DOMCSSStyleDeclaration00;
    propertyName: cstring; value: cstring; priority: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setProperty*(self: DOMCSSStyleDeclaration;
    propertyName: cstring; value: cstring; priority: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_css_style_declaration_set_property(cast[ptr DOMCSSStyleDeclaration00](self.impl), propertyName, value, priority, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_document_create_css_style_declaration(self: ptr DOMDocument00): ptr DOMCSSStyleDeclaration00 {.
    importc, libprag.}

proc createCssStyleDeclaration*(self: DOMDocument): DOMCSSStyleDeclaration =
  let gobj = webkit_dom_document_create_css_style_declaration(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMCSSRule* = ref object of DOMObject
  DOMCSSRule00* = object of DOMObject00

proc webkit_dom_css_rule_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMCSSRule()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_css_rule_get_css_text(self: ptr DOMCSSRule00): cstring {.
    importc, libprag.}

proc getCssText*(self: DOMCSSRule): string =
  let resul0 = webkit_dom_css_rule_get_css_text(cast[ptr DOMCSSRule00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cssText*(self: DOMCSSRule): string =
  let resul0 = webkit_dom_css_rule_get_css_text(cast[ptr DOMCSSRule00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_rule_get_parent_rule(self: ptr DOMCSSRule00): ptr DOMCSSRule00 {.
    importc, libprag.}

proc getParentRule*(self: DOMCSSRule): DOMCSSRule =
  let gobj = webkit_dom_css_rule_get_parent_rule(cast[ptr DOMCSSRule00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parentRule*(self: DOMCSSRule): DOMCSSRule =
  let gobj = webkit_dom_css_rule_get_parent_rule(cast[ptr DOMCSSRule00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_css_rule_get_rule_type(self: ptr DOMCSSRule00): uint16 {.
    importc, libprag.}

proc getRuleType*(self: DOMCSSRule): uint16 =
  webkit_dom_css_rule_get_rule_type(cast[ptr DOMCSSRule00](self.impl))

proc ruleType*(self: DOMCSSRule): uint16 =
  webkit_dom_css_rule_get_rule_type(cast[ptr DOMCSSRule00](self.impl))

proc webkit_dom_css_rule_set_css_text(self: ptr DOMCSSRule00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setCssText*(self: DOMCSSRule; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_css_rule_set_css_text(cast[ptr DOMCSSRule00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `cssText=`*(self: DOMCSSRule; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_css_rule_set_css_text(cast[ptr DOMCSSRule00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_css_style_declaration_get_parent_rule(self: ptr DOMCSSStyleDeclaration00): ptr DOMCSSRule00 {.
    importc, libprag.}

proc getParentRule*(self: DOMCSSStyleDeclaration): DOMCSSRule =
  let gobj = webkit_dom_css_style_declaration_get_parent_rule(cast[ptr DOMCSSStyleDeclaration00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parentRule*(self: DOMCSSStyleDeclaration): DOMCSSRule =
  let gobj = webkit_dom_css_style_declaration_get_parent_rule(cast[ptr DOMCSSStyleDeclaration00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMStyleSheet* = ref object of DOMObject
  DOMStyleSheet00* = object of DOMObject00

proc webkit_dom_style_sheet_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMStyleSheet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_style_sheet_get_content_type(self: ptr DOMStyleSheet00): cstring {.
    importc, libprag.}

proc getContentType*(self: DOMStyleSheet): string =
  let resul0 = webkit_dom_style_sheet_get_content_type(cast[ptr DOMStyleSheet00](self.impl))
  result = $resul0
  cogfree(resul0)

proc contentType*(self: DOMStyleSheet): string =
  let resul0 = webkit_dom_style_sheet_get_content_type(cast[ptr DOMStyleSheet00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_style_sheet_get_disabled(self: ptr DOMStyleSheet00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMStyleSheet): bool =
  toBool(webkit_dom_style_sheet_get_disabled(cast[ptr DOMStyleSheet00](self.impl)))

proc disabled*(self: DOMStyleSheet): bool =
  toBool(webkit_dom_style_sheet_get_disabled(cast[ptr DOMStyleSheet00](self.impl)))

proc webkit_dom_style_sheet_get_href(self: ptr DOMStyleSheet00): cstring {.
    importc, libprag.}

proc getHref*(self: DOMStyleSheet): string =
  let resul0 = webkit_dom_style_sheet_get_href(cast[ptr DOMStyleSheet00](self.impl))
  result = $resul0
  cogfree(resul0)

proc href*(self: DOMStyleSheet): string =
  let resul0 = webkit_dom_style_sheet_get_href(cast[ptr DOMStyleSheet00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_style_sheet_get_owner_node(self: ptr DOMStyleSheet00): ptr DOMNode00 {.
    importc, libprag.}

proc getOwnerNode*(self: DOMStyleSheet): DOMNode =
  let gobj = webkit_dom_style_sheet_get_owner_node(cast[ptr DOMStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc ownerNode*(self: DOMStyleSheet): DOMNode =
  let gobj = webkit_dom_style_sheet_get_owner_node(cast[ptr DOMStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_style_sheet_get_parent_style_sheet(self: ptr DOMStyleSheet00): ptr DOMStyleSheet00 {.
    importc, libprag.}

proc getParentStyleSheet*(self: DOMStyleSheet): DOMStyleSheet =
  let gobj = webkit_dom_style_sheet_get_parent_style_sheet(cast[ptr DOMStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parentStyleSheet*(self: DOMStyleSheet): DOMStyleSheet =
  let gobj = webkit_dom_style_sheet_get_parent_style_sheet(cast[ptr DOMStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_style_sheet_get_title(self: ptr DOMStyleSheet00): cstring {.
    importc, libprag.}

proc getTitle*(self: DOMStyleSheet): string =
  let resul0 = webkit_dom_style_sheet_get_title(cast[ptr DOMStyleSheet00](self.impl))
  result = $resul0
  cogfree(resul0)

proc title*(self: DOMStyleSheet): string =
  let resul0 = webkit_dom_style_sheet_get_title(cast[ptr DOMStyleSheet00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_style_sheet_set_disabled(self: ptr DOMStyleSheet00; value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMStyleSheet; value: bool = true) =
  webkit_dom_style_sheet_set_disabled(cast[ptr DOMStyleSheet00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMStyleSheet; value: bool) =
  webkit_dom_style_sheet_set_disabled(cast[ptr DOMStyleSheet00](self.impl), gboolean(value))

type
  DOMCSSStyleSheet* = ref object of DOMStyleSheet
  DOMCSSStyleSheet00* = object of DOMStyleSheet00

proc webkit_dom_css_style_sheet_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMCSSStyleSheet()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_css_style_sheet_add_rule(self: ptr DOMCSSStyleSheet00; selector: cstring;
    style: cstring; index: uint64; error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc addRule*(self: DOMCSSStyleSheet; selector: cstring;
    style: cstring; index: uint64): int64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_css_style_sheet_add_rule(cast[ptr DOMCSSStyleSheet00](self.impl), selector, style, index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_css_style_sheet_delete_rule(self: ptr DOMCSSStyleSheet00;
    index: uint64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc deleteRule*(self: DOMCSSStyleSheet; index: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_css_style_sheet_delete_rule(cast[ptr DOMCSSStyleSheet00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_css_style_sheet_get_owner_rule(self: ptr DOMCSSStyleSheet00): ptr DOMCSSRule00 {.
    importc, libprag.}

proc getOwnerRule*(self: DOMCSSStyleSheet): DOMCSSRule =
  let gobj = webkit_dom_css_style_sheet_get_owner_rule(cast[ptr DOMCSSStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc ownerRule*(self: DOMCSSStyleSheet): DOMCSSRule =
  let gobj = webkit_dom_css_style_sheet_get_owner_rule(cast[ptr DOMCSSStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_css_style_sheet_insert_rule(self: ptr DOMCSSStyleSheet00;
    rule: cstring; index: uint64; error: ptr ptr glib.Error = nil): uint64 {.
    importc, libprag.}

proc insertRule*(self: DOMCSSStyleSheet; rule: cstring;
    index: uint64): uint64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_css_style_sheet_insert_rule(cast[ptr DOMCSSStyleSheet00](self.impl), rule, index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_css_style_sheet_remove_rule(self: ptr DOMCSSStyleSheet00;
    index: uint64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc removeRule*(self: DOMCSSStyleSheet; index: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_css_style_sheet_remove_rule(cast[ptr DOMCSSStyleSheet00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_css_rule_get_parent_style_sheet(self: ptr DOMCSSRule00): ptr DOMCSSStyleSheet00 {.
    importc, libprag.}

proc getParentStyleSheet*(self: DOMCSSRule): DOMCSSStyleSheet =
  let gobj = webkit_dom_css_rule_get_parent_style_sheet(cast[ptr DOMCSSRule00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parentStyleSheet*(self: DOMCSSRule): DOMCSSStyleSheet =
  let gobj = webkit_dom_css_rule_get_parent_style_sheet(cast[ptr DOMCSSRule00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMMediaList* = ref object of DOMObject
  DOMMediaList00* = object of DOMObject00

proc webkit_dom_media_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMMediaList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_media_list_append_medium(self: ptr DOMMediaList00; newMedium: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc appendMedium*(self: DOMMediaList; newMedium: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_media_list_append_medium(cast[ptr DOMMediaList00](self.impl), newMedium, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_media_list_delete_medium(self: ptr DOMMediaList00; oldMedium: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc deleteMedium*(self: DOMMediaList; oldMedium: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_media_list_delete_medium(cast[ptr DOMMediaList00](self.impl), oldMedium, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_media_list_get_length(self: ptr DOMMediaList00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMMediaList): uint64 =
  webkit_dom_media_list_get_length(cast[ptr DOMMediaList00](self.impl))

proc length*(self: DOMMediaList): uint64 =
  webkit_dom_media_list_get_length(cast[ptr DOMMediaList00](self.impl))

proc webkit_dom_media_list_get_media_text(self: ptr DOMMediaList00): cstring {.
    importc, libprag.}

proc getMediaText*(self: DOMMediaList): string =
  let resul0 = webkit_dom_media_list_get_media_text(cast[ptr DOMMediaList00](self.impl))
  result = $resul0
  cogfree(resul0)

proc mediaText*(self: DOMMediaList): string =
  let resul0 = webkit_dom_media_list_get_media_text(cast[ptr DOMMediaList00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_media_list_item(self: ptr DOMMediaList00; index: uint64): cstring {.
    importc, libprag.}

proc item*(self: DOMMediaList; index: uint64): string =
  let resul0 = webkit_dom_media_list_item(cast[ptr DOMMediaList00](self.impl), index)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_media_list_set_media_text(self: ptr DOMMediaList00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setMediaText*(self: DOMMediaList; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_media_list_set_media_text(cast[ptr DOMMediaList00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `mediaText=`*(self: DOMMediaList; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_media_list_set_media_text(cast[ptr DOMMediaList00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_style_sheet_get_media(self: ptr DOMStyleSheet00): ptr DOMMediaList00 {.
    importc, libprag.}

proc getMedia*(self: DOMStyleSheet): DOMMediaList =
  let gobj = webkit_dom_style_sheet_get_media(cast[ptr DOMStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc media*(self: DOMStyleSheet): DOMMediaList =
  let gobj = webkit_dom_style_sheet_get_media(cast[ptr DOMStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMCSSRuleList* = ref object of DOMObject
  DOMCSSRuleList00* = object of DOMObject00

proc webkit_dom_css_rule_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMCSSRuleList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_css_rule_list_get_length(self: ptr DOMCSSRuleList00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMCSSRuleList): uint64 =
  webkit_dom_css_rule_list_get_length(cast[ptr DOMCSSRuleList00](self.impl))

proc length*(self: DOMCSSRuleList): uint64 =
  webkit_dom_css_rule_list_get_length(cast[ptr DOMCSSRuleList00](self.impl))

proc webkit_dom_css_rule_list_item(self: ptr DOMCSSRuleList00; index: uint64): ptr DOMCSSRule00 {.
    importc, libprag.}

proc item*(self: DOMCSSRuleList; index: uint64): DOMCSSRule =
  let gobj = webkit_dom_css_rule_list_item(cast[ptr DOMCSSRuleList00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_css_style_sheet_get_css_rules(self: ptr DOMCSSStyleSheet00): ptr DOMCSSRuleList00 {.
    importc, libprag.}

proc getCssRules*(self: DOMCSSStyleSheet): DOMCSSRuleList =
  let gobj = webkit_dom_css_style_sheet_get_css_rules(cast[ptr DOMCSSStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc cssRules*(self: DOMCSSStyleSheet): DOMCSSRuleList =
  let gobj = webkit_dom_css_style_sheet_get_css_rules(cast[ptr DOMCSSStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_css_style_sheet_get_rules(self: ptr DOMCSSStyleSheet00): ptr DOMCSSRuleList00 {.
    importc, libprag.}

proc getRules*(self: DOMCSSStyleSheet): DOMCSSRuleList =
  let gobj = webkit_dom_css_style_sheet_get_rules(cast[ptr DOMCSSStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rules*(self: DOMCSSStyleSheet): DOMCSSRuleList =
  let gobj = webkit_dom_css_style_sheet_get_rules(cast[ptr DOMCSSStyleSheet00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMDocumentFragment* = ref object of DOMNode
  DOMDocumentFragment00* = object of DOMNode00

proc webkit_dom_document_fragment_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMDocumentFragment()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_document_fragment_get_child_element_count(self: ptr DOMDocumentFragment00): uint64 {.
    importc, libprag.}

proc getChildElementCount*(self: DOMDocumentFragment): uint64 =
  webkit_dom_document_fragment_get_child_element_count(cast[ptr DOMDocumentFragment00](self.impl))

proc childElementCount*(self: DOMDocumentFragment): uint64 =
  webkit_dom_document_fragment_get_child_element_count(cast[ptr DOMDocumentFragment00](self.impl))

proc webkit_dom_document_fragment_query_selector_all(self: ptr DOMDocumentFragment00;
    selectors: cstring; error: ptr ptr glib.Error = nil): ptr DOMNodeList00 {.
    importc, libprag.}

proc querySelectorAll*(self: DOMDocumentFragment;
    selectors: cstring): DOMNodeList =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_fragment_query_selector_all(cast[ptr DOMDocumentFragment00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_document_fragment(self: ptr DOMDocument00): ptr DOMDocumentFragment00 {.
    importc, libprag.}

proc createDocumentFragment*(self: DOMDocument): DOMDocumentFragment =
  let gobj = webkit_dom_document_create_document_fragment(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMEntityReference* = ref object of DOMNode
  DOMEntityReference00* = object of DOMNode00

proc webkit_dom_entity_reference_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMEntityReference()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_document_create_entity_reference(self: ptr DOMDocument00;
    name: cstring; error: ptr ptr glib.Error = nil): ptr DOMEntityReference00 {.
    importc, libprag.}

proc createEntityReference*(self: DOMDocument; name: cstring = nil): DOMEntityReference =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_entity_reference(cast[ptr DOMDocument00](self.impl), name, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMEvent* = ref object of DOMObject
  DOMEvent00* = object of DOMObject00

proc webkit_dom_event_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_event_get_bubbles(self: ptr DOMEvent00): gboolean {.
    importc, libprag.}

proc getBubbles*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_bubbles(cast[ptr DOMEvent00](self.impl)))

proc bubbles*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_bubbles(cast[ptr DOMEvent00](self.impl)))

proc webkit_dom_event_get_cancel_bubble(self: ptr DOMEvent00): gboolean {.
    importc, libprag.}

proc getCancelBubble*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_cancel_bubble(cast[ptr DOMEvent00](self.impl)))

proc cancelBubble*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_cancel_bubble(cast[ptr DOMEvent00](self.impl)))

proc webkit_dom_event_get_cancelable(self: ptr DOMEvent00): gboolean {.
    importc, libprag.}

proc getCancelable*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_cancelable(cast[ptr DOMEvent00](self.impl)))

proc cancelable*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_cancelable(cast[ptr DOMEvent00](self.impl)))

proc webkit_dom_event_get_event_phase(self: ptr DOMEvent00): uint16 {.
    importc, libprag.}

proc getEventPhase*(self: DOMEvent): uint16 =
  webkit_dom_event_get_event_phase(cast[ptr DOMEvent00](self.impl))

proc eventPhase*(self: DOMEvent): uint16 =
  webkit_dom_event_get_event_phase(cast[ptr DOMEvent00](self.impl))

proc webkit_dom_event_get_event_type(self: ptr DOMEvent00): cstring {.
    importc, libprag.}

proc getEventType*(self: DOMEvent): string =
  let resul0 = webkit_dom_event_get_event_type(cast[ptr DOMEvent00](self.impl))
  result = $resul0
  cogfree(resul0)

proc eventType*(self: DOMEvent): string =
  let resul0 = webkit_dom_event_get_event_type(cast[ptr DOMEvent00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_event_get_return_value(self: ptr DOMEvent00): gboolean {.
    importc, libprag.}

proc getReturnValue*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_return_value(cast[ptr DOMEvent00](self.impl)))

proc returnValue*(self: DOMEvent): bool =
  toBool(webkit_dom_event_get_return_value(cast[ptr DOMEvent00](self.impl)))

proc webkit_dom_event_get_time_stamp(self: ptr DOMEvent00): uint32 {.
    importc, libprag.}

proc getTimeStamp*(self: DOMEvent): int =
  int(webkit_dom_event_get_time_stamp(cast[ptr DOMEvent00](self.impl)))

proc timeStamp*(self: DOMEvent): int =
  int(webkit_dom_event_get_time_stamp(cast[ptr DOMEvent00](self.impl)))

proc webkit_dom_event_init_event(self: ptr DOMEvent00; eventTypeArg: cstring;
    canBubbleArg: gboolean; cancelableArg: gboolean) {.
    importc, libprag.}

proc initEvent*(self: DOMEvent; eventTypeArg: cstring; canBubbleArg: bool;
    cancelableArg: bool) =
  webkit_dom_event_init_event(cast[ptr DOMEvent00](self.impl), eventTypeArg, gboolean(canBubbleArg), gboolean(cancelableArg))

proc webkit_dom_event_prevent_default(self: ptr DOMEvent00) {.
    importc, libprag.}

proc preventDefault*(self: DOMEvent) =
  webkit_dom_event_prevent_default(cast[ptr DOMEvent00](self.impl))

proc webkit_dom_event_set_cancel_bubble(self: ptr DOMEvent00; value: gboolean) {.
    importc, libprag.}

proc setCancelBubble*(self: DOMEvent; value: bool = true) =
  webkit_dom_event_set_cancel_bubble(cast[ptr DOMEvent00](self.impl), gboolean(value))

proc `cancelBubble=`*(self: DOMEvent; value: bool) =
  webkit_dom_event_set_cancel_bubble(cast[ptr DOMEvent00](self.impl), gboolean(value))

proc webkit_dom_event_set_return_value(self: ptr DOMEvent00; value: gboolean) {.
    importc, libprag.}

proc setReturnValue*(self: DOMEvent; value: bool = true) =
  webkit_dom_event_set_return_value(cast[ptr DOMEvent00](self.impl), gboolean(value))

proc `returnValue=`*(self: DOMEvent; value: bool) =
  webkit_dom_event_set_return_value(cast[ptr DOMEvent00](self.impl), gboolean(value))

proc webkit_dom_event_stop_propagation(self: ptr DOMEvent00) {.
    importc, libprag.}

proc stopPropagation*(self: DOMEvent) =
  webkit_dom_event_stop_propagation(cast[ptr DOMEvent00](self.impl))

proc webkit_dom_document_create_event(self: ptr DOMDocument00; eventType: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMEvent00 {.
    importc, libprag.}

proc createEvent*(self: DOMDocument; eventType: cstring): DOMEvent =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_event(cast[ptr DOMDocument00](self.impl), eventType, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMEventTarget00* = object of gobject.Object00
  DOMEventTarget* = ref object of gobject.Object

proc webkit_dom_event_get_current_target(self: ptr DOMEvent00): ptr DOMEventTarget00 {.
    importc, libprag.}

proc getCurrentTarget*(self: DOMEvent): DOMEventTarget =
  let gobj = webkit_dom_event_get_current_target(cast[ptr DOMEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentTarget*(self: DOMEvent): DOMEventTarget =
  let gobj = webkit_dom_event_get_current_target(cast[ptr DOMEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_event_get_src_element(self: ptr DOMEvent00): ptr DOMEventTarget00 {.
    importc, libprag.}

proc getSrcElement*(self: DOMEvent): DOMEventTarget =
  let gobj = webkit_dom_event_get_src_element(cast[ptr DOMEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc srcElement*(self: DOMEvent): DOMEventTarget =
  let gobj = webkit_dom_event_get_src_element(cast[ptr DOMEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_event_get_target(self: ptr DOMEvent00): ptr DOMEventTarget00 {.
    importc, libprag.}

proc getTarget*(self: DOMEvent): DOMEventTarget =
  let gobj = webkit_dom_event_get_target(cast[ptr DOMEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc target*(self: DOMEvent): DOMEventTarget =
  let gobj = webkit_dom_event_get_target(cast[ptr DOMEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMProcessingInstruction* = ref object of DOMCharacterData
  DOMProcessingInstruction00* = object of DOMCharacterData00

proc webkit_dom_processing_instruction_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMProcessingInstruction()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_processing_instruction_get_sheet(self: ptr DOMProcessingInstruction00): ptr DOMStyleSheet00 {.
    importc, libprag.}

proc getSheet*(self: DOMProcessingInstruction): DOMStyleSheet =
  let gobj = webkit_dom_processing_instruction_get_sheet(cast[ptr DOMProcessingInstruction00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sheet*(self: DOMProcessingInstruction): DOMStyleSheet =
  let gobj = webkit_dom_processing_instruction_get_sheet(cast[ptr DOMProcessingInstruction00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_processing_instruction_get_target(self: ptr DOMProcessingInstruction00): cstring {.
    importc, libprag.}

proc getTarget*(self: DOMProcessingInstruction): string =
  let resul0 = webkit_dom_processing_instruction_get_target(cast[ptr DOMProcessingInstruction00](self.impl))
  result = $resul0
  cogfree(resul0)

proc target*(self: DOMProcessingInstruction): string =
  let resul0 = webkit_dom_processing_instruction_get_target(cast[ptr DOMProcessingInstruction00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_create_processing_instruction(self: ptr DOMDocument00;
    target: cstring; data: cstring; error: ptr ptr glib.Error = nil): ptr DOMProcessingInstruction00 {.
    importc, libprag.}

proc createProcessingInstruction*(self: DOMDocument;
    target: cstring; data: cstring): DOMProcessingInstruction =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_processing_instruction(cast[ptr DOMDocument00](self.impl), target, data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMRange* = ref object of DOMObject
  DOMRange00* = object of DOMObject00

proc webkit_dom_range_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMRange()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_range_clone_contents(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): ptr DOMDocumentFragment00 {.
    importc, libprag.}

proc cloneContents*(self: DOMRange): DOMDocumentFragment =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_clone_contents(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_range_clone_range(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): ptr DOMRange00 {.
    importc, libprag.}

proc cloneRange*(self: DOMRange): DOMRange =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_clone_range(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_range_collapse(self: ptr DOMRange00; toStart: gboolean; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc collapse*(self: DOMRange; toStart: bool) =
  var gerror: ptr glib.Error
  webkit_dom_range_collapse(cast[ptr DOMRange00](self.impl), gboolean(toStart), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_compare_boundary_points(self: ptr DOMRange00; how: uint16;
    sourceRange: ptr DOMRange00; error: ptr ptr glib.Error = nil): int16 {.
    importc, libprag.}

proc compareBoundaryPoints*(self: DOMRange; how: uint16;
    sourceRange: DOMRange): int16 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_compare_boundary_points(cast[ptr DOMRange00](self.impl), how, cast[ptr DOMRange00](sourceRange.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_range_compare_node(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil): int16 {.
    importc, libprag.}

proc compareNode*(self: DOMRange; refNode: DOMNode): int16 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_compare_node(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_range_compare_point(self: ptr DOMRange00; refNode: ptr DOMNode00;
    offset: int64; error: ptr ptr glib.Error = nil): int16 {.
    importc, libprag.}

proc comparePoint*(self: DOMRange; refNode: DOMNode; offset: int64): int16 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_compare_point(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), offset, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_range_create_contextual_fragment(self: ptr DOMRange00; html: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMDocumentFragment00 {.
    importc, libprag.}

proc createContextualFragment*(self: DOMRange; html: cstring): DOMDocumentFragment =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_create_contextual_fragment(cast[ptr DOMRange00](self.impl), html, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_range_delete_contents(self: ptr DOMRange00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc deleteContents*(self: DOMRange) =
  var gerror: ptr glib.Error
  webkit_dom_range_delete_contents(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_detach(self: ptr DOMRange00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc detach*(self: DOMRange) =
  var gerror: ptr glib.Error
  webkit_dom_range_detach(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_expand(self: ptr DOMRange00; unit: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc expand*(self: DOMRange; unit: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_range_expand(cast[ptr DOMRange00](self.impl), unit, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_extract_contents(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): ptr DOMDocumentFragment00 {.
    importc, libprag.}

proc extractContents*(self: DOMRange): DOMDocumentFragment =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_extract_contents(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_range_get_collapsed(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getCollapsed*(self: DOMRange): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_get_collapsed(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc collapsed*(self: DOMRange): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_get_collapsed(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_range_get_common_ancestor_container(self: ptr DOMRange00;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc getCommonAncestorContainer*(self: DOMRange): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_get_common_ancestor_container(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc commonAncestorContainer*(self: DOMRange): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_get_common_ancestor_container(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_range_get_end_container(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc getEndContainer*(self: DOMRange): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_get_end_container(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc endContainer*(self: DOMRange): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_get_end_container(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_range_get_end_offset(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc getEndOffset*(self: DOMRange): int64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_get_end_offset(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc endOffset*(self: DOMRange): int64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_get_end_offset(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_range_get_start_container(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc getStartContainer*(self: DOMRange): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_get_start_container(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc startContainer*(self: DOMRange): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_range_get_start_container(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_range_get_start_offset(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): int64 {.
    importc, libprag.}

proc getStartOffset*(self: DOMRange): int64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_get_start_offset(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc startOffset*(self: DOMRange): int64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_get_start_offset(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_range_get_text(self: ptr DOMRange00): cstring {.
    importc, libprag.}

proc getText*(self: DOMRange): string =
  let resul0 = webkit_dom_range_get_text(cast[ptr DOMRange00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: DOMRange): string =
  let resul0 = webkit_dom_range_get_text(cast[ptr DOMRange00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_range_insert_node(self: ptr DOMRange00; newNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc insertNode*(self: DOMRange; newNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_insert_node(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](newNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_intersects_node(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc intersectsNode*(self: DOMRange; refNode: DOMNode): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_intersects_node(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_range_is_point_in_range(self: ptr DOMRange00; refNode: ptr DOMNode00;
    offset: int64; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc isPointInRange*(self: DOMRange; refNode: DOMNode;
    offset: int64): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_is_point_in_range(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), offset, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_range_select_node(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc selectNode*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_select_node(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_select_node_contents(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc selectNodeContents*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_select_node_contents(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_set_end(self: ptr DOMRange00; refNode: ptr DOMNode00;
    offset: int64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setEnd*(self: DOMRange; refNode: DOMNode; offset: int64) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_end(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), offset, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_set_end_after(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setEndAfter*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_end_after(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `endAfter=`*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_end_after(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_set_end_before(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setEndBefore*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_end_before(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `endBefore=`*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_end_before(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_set_start(self: ptr DOMRange00; refNode: ptr DOMNode00;
    offset: int64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setStart*(self: DOMRange; refNode: DOMNode; offset: int64) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_start(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), offset, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_set_start_after(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setStartAfter*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_start_after(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `startAfter=`*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_start_after(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_set_start_before(self: ptr DOMRange00; refNode: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setStartBefore*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_start_before(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `startBefore=`*(self: DOMRange; refNode: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_set_start_before(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](refNode.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_surround_contents(self: ptr DOMRange00; newParent: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc surroundContents*(self: DOMRange; newParent: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_range_surround_contents(cast[ptr DOMRange00](self.impl), cast[ptr DOMNode00](newParent.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_range_to_string(self: ptr DOMRange00; error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc toString*(self: DOMRange): string =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_range_to_string(cast[ptr DOMRange00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_caret_range_from_point(self: ptr DOMDocument00;
    x: int64; y: int64): ptr DOMRange00 {.
    importc, libprag.}

proc caretRangeFromPoint*(self: DOMDocument; x: int64;
    y: int64): DOMRange =
  let gobj = webkit_dom_document_caret_range_from_point(cast[ptr DOMDocument00](self.impl), x, y)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_range(self: ptr DOMDocument00): ptr DOMRange00 {.
    importc, libprag.}

proc createRange*(self: DOMDocument): DOMRange =
  let gobj = webkit_dom_document_create_range(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMText* = ref object of DOMCharacterData
  DOMText00* = object of DOMCharacterData00

proc webkit_dom_text_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMText()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_text_get_whole_text(self: ptr DOMText00): cstring {.
    importc, libprag.}

proc getWholeText*(self: DOMText): string =
  let resul0 = webkit_dom_text_get_whole_text(cast[ptr DOMText00](self.impl))
  result = $resul0
  cogfree(resul0)

proc wholeText*(self: DOMText): string =
  let resul0 = webkit_dom_text_get_whole_text(cast[ptr DOMText00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_text_replace_whole_text(self: ptr DOMText00; content: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMText00 {.
    importc, libprag.}

proc replaceWholeText*(self: DOMText; content: cstring): DOMText =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_text_replace_whole_text(cast[ptr DOMText00](self.impl), content, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_text_split_text(self: ptr DOMText00; offset: uint64; error: ptr ptr glib.Error = nil): ptr DOMText00 {.
    importc, libprag.}

proc splitText*(self: DOMText; offset: uint64): DOMText =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_text_split_text(cast[ptr DOMText00](self.impl), offset, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMCDATASection* = ref object of DOMText
  DOMCDATASection00* = object of DOMText00

proc webkit_dom_cdata_section_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMCDATASection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_document_create_cdata_section(self: ptr DOMDocument00; data: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMCDATASection00 {.
    importc, libprag.}

proc createCdataSection*(self: DOMDocument; data: cstring): DOMCDATASection =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_cdata_section(cast[ptr DOMDocument00](self.impl), data, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_text_node(self: ptr DOMDocument00; data: cstring): ptr DOMText00 {.
    importc, libprag.}

proc createTextNode*(self: DOMDocument; data: cstring): DOMText =
  let gobj = webkit_dom_document_create_text_node(cast[ptr DOMDocument00](self.impl), data)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMNodeFilter00* = object of gobject.Object00
  DOMNodeFilter* = ref object of gobject.Object

proc webkit_dom_node_filter_accept_node(self: ptr DOMNodeFilter00; node: ptr DOMNode00): int16 {.
    importc, libprag.}

proc acceptNode*(self: DOMNodeFilter; node: DOMNode): int16 =
  webkit_dom_node_filter_accept_node(cast[ptr DOMNodeFilter00](self.impl), cast[ptr DOMNode00](node.impl))

type
  DOMNodeIterator* = ref object of DOMObject
  DOMNodeIterator00* = object of DOMObject00

proc webkit_dom_node_iterator_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMNodeIterator()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_node_iterator_detach(self: ptr DOMNodeIterator00) {.
    importc, libprag.}

proc detach*(self: DOMNodeIterator) =
  webkit_dom_node_iterator_detach(cast[ptr DOMNodeIterator00](self.impl))

proc webkit_dom_node_iterator_get_expand_entity_references(self: ptr DOMNodeIterator00): gboolean {.
    importc, libprag.}

proc getExpandEntityReferences*(self: DOMNodeIterator): bool =
  toBool(webkit_dom_node_iterator_get_expand_entity_references(cast[ptr DOMNodeIterator00](self.impl)))

proc expandEntityReferences*(self: DOMNodeIterator): bool =
  toBool(webkit_dom_node_iterator_get_expand_entity_references(cast[ptr DOMNodeIterator00](self.impl)))

proc webkit_dom_node_iterator_get_filter(self: ptr DOMNodeIterator00): ptr DOMNodeFilter00 {.
    importc, libprag.}

proc getFilter*(self: DOMNodeIterator): DOMNodeFilter =
  let gobj = webkit_dom_node_iterator_get_filter(cast[ptr DOMNodeIterator00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc filter*(self: DOMNodeIterator): DOMNodeFilter =
  let gobj = webkit_dom_node_iterator_get_filter(cast[ptr DOMNodeIterator00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_iterator_get_pointer_before_reference_node(self: ptr DOMNodeIterator00): gboolean {.
    importc, libprag.}

proc getPointerBeforeReferenceNode*(self: DOMNodeIterator): bool =
  toBool(webkit_dom_node_iterator_get_pointer_before_reference_node(cast[ptr DOMNodeIterator00](self.impl)))

proc pointerBeforeReferenceNode*(self: DOMNodeIterator): bool =
  toBool(webkit_dom_node_iterator_get_pointer_before_reference_node(cast[ptr DOMNodeIterator00](self.impl)))

proc webkit_dom_node_iterator_get_reference_node(self: ptr DOMNodeIterator00): ptr DOMNode00 {.
    importc, libprag.}

proc getReferenceNode*(self: DOMNodeIterator): DOMNode =
  let gobj = webkit_dom_node_iterator_get_reference_node(cast[ptr DOMNodeIterator00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc referenceNode*(self: DOMNodeIterator): DOMNode =
  let gobj = webkit_dom_node_iterator_get_reference_node(cast[ptr DOMNodeIterator00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_iterator_get_root(self: ptr DOMNodeIterator00): ptr DOMNode00 {.
    importc, libprag.}

proc getRoot*(self: DOMNodeIterator): DOMNode =
  let gobj = webkit_dom_node_iterator_get_root(cast[ptr DOMNodeIterator00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc root*(self: DOMNodeIterator): DOMNode =
  let gobj = webkit_dom_node_iterator_get_root(cast[ptr DOMNodeIterator00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_iterator_get_what_to_show(self: ptr DOMNodeIterator00): uint64 {.
    importc, libprag.}

proc getWhatToShow*(self: DOMNodeIterator): uint64 =
  webkit_dom_node_iterator_get_what_to_show(cast[ptr DOMNodeIterator00](self.impl))

proc whatToShow*(self: DOMNodeIterator): uint64 =
  webkit_dom_node_iterator_get_what_to_show(cast[ptr DOMNodeIterator00](self.impl))

proc webkit_dom_node_iterator_next_node(self: ptr DOMNodeIterator00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc nextNode*(self: DOMNodeIterator): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_iterator_next_node(cast[ptr DOMNodeIterator00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_node_iterator_previous_node(self: ptr DOMNodeIterator00;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc previousNode*(self: DOMNodeIterator): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_node_iterator_previous_node(cast[ptr DOMNodeIterator00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_node_iterator(self: ptr DOMDocument00; root: ptr DOMNode00;
    whatToShow: uint64; filter: ptr DOMNodeFilter00; expandEntityReferences: gboolean;
    error: ptr ptr glib.Error = nil): ptr DOMNodeIterator00 {.
    importc, libprag.}

proc createNodeIterator*(self: DOMDocument; root: DOMNode;
    whatToShow: uint64; filter: DOMNodeFilter = nil; expandEntityReferences: bool): DOMNodeIterator =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_node_iterator(cast[ptr DOMDocument00](self.impl), cast[ptr DOMNode00](root.impl), whatToShow, if filter.isNil: nil else: cast[ptr DOMNodeFilter00](filter.impl), gboolean(expandEntityReferences), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMTreeWalker* = ref object of DOMObject
  DOMTreeWalker00* = object of DOMObject00

proc webkit_dom_tree_walker_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMTreeWalker()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_tree_walker_first_child(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc firstChild*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_first_child(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_get_current_node(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc getCurrentNode*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_get_current_node(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentNode*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_get_current_node(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_get_expand_entity_references(self: ptr DOMTreeWalker00): gboolean {.
    importc, libprag.}

proc getExpandEntityReferences*(self: DOMTreeWalker): bool =
  toBool(webkit_dom_tree_walker_get_expand_entity_references(cast[ptr DOMTreeWalker00](self.impl)))

proc expandEntityReferences*(self: DOMTreeWalker): bool =
  toBool(webkit_dom_tree_walker_get_expand_entity_references(cast[ptr DOMTreeWalker00](self.impl)))

proc webkit_dom_tree_walker_get_filter(self: ptr DOMTreeWalker00): ptr DOMNodeFilter00 {.
    importc, libprag.}

proc getFilter*(self: DOMTreeWalker): DOMNodeFilter =
  let gobj = webkit_dom_tree_walker_get_filter(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc filter*(self: DOMTreeWalker): DOMNodeFilter =
  let gobj = webkit_dom_tree_walker_get_filter(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_get_root(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc getRoot*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_get_root(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc root*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_get_root(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_get_what_to_show(self: ptr DOMTreeWalker00): uint64 {.
    importc, libprag.}

proc getWhatToShow*(self: DOMTreeWalker): uint64 =
  webkit_dom_tree_walker_get_what_to_show(cast[ptr DOMTreeWalker00](self.impl))

proc whatToShow*(self: DOMTreeWalker): uint64 =
  webkit_dom_tree_walker_get_what_to_show(cast[ptr DOMTreeWalker00](self.impl))

proc webkit_dom_tree_walker_last_child(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc lastChild*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_last_child(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_next_node(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc nextNode*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_next_node(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_next_sibling(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc nextSibling*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_next_sibling(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_parent_node(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc parentNode*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_parent_node(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_previous_node(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc previousNode*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_previous_node(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_previous_sibling(self: ptr DOMTreeWalker00): ptr DOMNode00 {.
    importc, libprag.}

proc previousSibling*(self: DOMTreeWalker): DOMNode =
  let gobj = webkit_dom_tree_walker_previous_sibling(cast[ptr DOMTreeWalker00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_tree_walker_set_current_node(self: ptr DOMTreeWalker00; value: ptr DOMNode00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setCurrentNode*(self: DOMTreeWalker; value: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_tree_walker_set_current_node(cast[ptr DOMTreeWalker00](self.impl), cast[ptr DOMNode00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `currentNode=`*(self: DOMTreeWalker; value: DOMNode) =
  var gerror: ptr glib.Error
  webkit_dom_tree_walker_set_current_node(cast[ptr DOMTreeWalker00](self.impl), cast[ptr DOMNode00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_document_create_tree_walker(self: ptr DOMDocument00; root: ptr DOMNode00;
    whatToShow: uint64; filter: ptr DOMNodeFilter00; expandEntityReferences: gboolean;
    error: ptr ptr glib.Error = nil): ptr DOMTreeWalker00 {.
    importc, libprag.}

proc createTreeWalker*(self: DOMDocument; root: DOMNode;
    whatToShow: uint64; filter: DOMNodeFilter = nil; expandEntityReferences: bool): DOMTreeWalker =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_tree_walker(cast[ptr DOMDocument00](self.impl), cast[ptr DOMNode00](root.impl), whatToShow, if filter.isNil: nil else: cast[ptr DOMNodeFilter00](filter.impl), gboolean(expandEntityReferences), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMXPathNSResolver00* = object of gobject.Object00
  DOMXPathNSResolver* = ref object of gobject.Object

proc webkit_dom_xpath_ns_resolver_lookup_namespace_uri(self: ptr DOMXPathNSResolver00;
    prefix: cstring): cstring {.
    importc, libprag.}

proc lookupNamespaceUri*(self: DOMXPathNSResolver;
    prefix: cstring): string =
  let resul0 = webkit_dom_xpath_ns_resolver_lookup_namespace_uri(cast[ptr DOMXPathNSResolver00](self.impl), prefix)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_create_ns_resolver(self: ptr DOMDocument00; nodeResolver: ptr DOMNode00): ptr DOMXPathNSResolver00 {.
    importc, libprag.}

proc createNsResolver*(self: DOMDocument; nodeResolver: DOMNode): DOMXPathNSResolver =
  let gobj = webkit_dom_document_create_ns_resolver(cast[ptr DOMDocument00](self.impl), cast[ptr DOMNode00](nodeResolver.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMXPathExpression* = ref object of DOMObject
  DOMXPathExpression00* = object of DOMObject00

proc webkit_dom_xpath_expression_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMXPathExpression()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_document_create_expression(self: ptr DOMDocument00; expression: cstring;
    resolver: ptr DOMXPathNSResolver00; error: ptr ptr glib.Error = nil): ptr DOMXPathExpression00 {.
    importc, libprag.}

proc createExpression*(self: DOMDocument; expression: cstring;
    resolver: DOMXPathNSResolver): DOMXPathExpression =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_expression(cast[ptr DOMDocument00](self.impl), expression, cast[ptr DOMXPathNSResolver00](resolver.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMXPathResult* = ref object of DOMObject
  DOMXPathResult00* = object of DOMObject00

proc webkit_dom_xpath_result_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMXPathResult()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_xpath_result_get_boolean_value(self: ptr DOMXPathResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc getBooleanValue*(self: DOMXPathResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_boolean_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc booleanValue*(self: DOMXPathResult): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_boolean_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_xpath_result_get_invalid_iterator_state(self: ptr DOMXPathResult00): gboolean {.
    importc, libprag.}

proc getInvalidIteratorState*(self: DOMXPathResult): bool =
  toBool(webkit_dom_xpath_result_get_invalid_iterator_state(cast[ptr DOMXPathResult00](self.impl)))

proc invalidIteratorState*(self: DOMXPathResult): bool =
  toBool(webkit_dom_xpath_result_get_invalid_iterator_state(cast[ptr DOMXPathResult00](self.impl)))

proc webkit_dom_xpath_result_get_number_value(self: ptr DOMXPathResult00;
    error: ptr ptr glib.Error = nil): cdouble {.
    importc, libprag.}

proc getNumberValue*(self: DOMXPathResult): cdouble =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_number_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc numberValue*(self: DOMXPathResult): cdouble =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_number_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_xpath_result_get_result_type(self: ptr DOMXPathResult00): uint16 {.
    importc, libprag.}

proc getResultType*(self: DOMXPathResult): uint16 =
  webkit_dom_xpath_result_get_result_type(cast[ptr DOMXPathResult00](self.impl))

proc resultType*(self: DOMXPathResult): uint16 =
  webkit_dom_xpath_result_get_result_type(cast[ptr DOMXPathResult00](self.impl))

proc webkit_dom_xpath_result_get_single_node_value(self: ptr DOMXPathResult00;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc getSingleNodeValue*(self: DOMXPathResult): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_xpath_result_get_single_node_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc singleNodeValue*(self: DOMXPathResult): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_xpath_result_get_single_node_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_xpath_result_get_snapshot_length(self: ptr DOMXPathResult00;
    error: ptr ptr glib.Error = nil): uint64 {.
    importc, libprag.}

proc getSnapshotLength*(self: DOMXPathResult): uint64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_snapshot_length(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc snapshotLength*(self: DOMXPathResult): uint64 =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_snapshot_length(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = resul0

proc webkit_dom_xpath_result_get_string_value(self: ptr DOMXPathResult00;
    error: ptr ptr glib.Error = nil): cstring {.
    importc, libprag.}

proc getStringValue*(self: DOMXPathResult): string =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_string_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc stringValue*(self: DOMXPathResult): string =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_xpath_result_get_string_value(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_xpath_result_iterate_next(self: ptr DOMXPathResult00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc iterateNext*(self: DOMXPathResult): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_xpath_result_iterate_next(cast[ptr DOMXPathResult00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_xpath_result_snapshot_item(self: ptr DOMXPathResult00; index: uint64;
    error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc snapshotItem*(self: DOMXPathResult; index: uint64): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_xpath_result_snapshot_item(cast[ptr DOMXPathResult00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_evaluate(self: ptr DOMDocument00; expression: cstring;
    contextNode: ptr DOMNode00; resolver: ptr DOMXPathNSResolver00; `type`: uint16;
    inResult: ptr DOMXPathResult00; error: ptr ptr glib.Error = nil): ptr DOMXPathResult00 {.
    importc, libprag.}

proc evaluate*(self: DOMDocument; expression: cstring;
    contextNode: DOMNode; resolver: DOMXPathNSResolver = nil; `type`: uint16;
    inResult: DOMXPathResult = nil): DOMXPathResult =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_evaluate(cast[ptr DOMDocument00](self.impl), expression, cast[ptr DOMNode00](contextNode.impl), if resolver.isNil: nil else: cast[ptr DOMXPathNSResolver00](resolver.impl), `type`, if inResult.isNil: nil else: cast[ptr DOMXPathResult00](inResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_xpath_expression_evaluate(self: ptr DOMXPathExpression00;
    contextNode: ptr DOMNode00; `type`: uint16; inResult: ptr DOMXPathResult00;
    error: ptr ptr glib.Error = nil): ptr DOMXPathResult00 {.
    importc, libprag.}

proc evaluate*(self: DOMXPathExpression; contextNode: DOMNode;
    `type`: uint16; inResult: DOMXPathResult): DOMXPathResult =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_xpath_expression_evaluate(cast[ptr DOMXPathExpression00](self.impl), cast[ptr DOMNode00](contextNode.impl), `type`, cast[ptr DOMXPathResult00](inResult.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMDOMWindow* = ref object of DOMObject
  DOMDOMWindow00* = object of DOMObject00

proc webkit_dom_dom_window_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMDOMWindow()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_dom_window_alert(self: ptr DOMDOMWindow00; message: cstring) {.
    importc, libprag.}

proc alert*(self: DOMDOMWindow; message: cstring) =
  webkit_dom_dom_window_alert(cast[ptr DOMDOMWindow00](self.impl), message)

proc webkit_dom_dom_window_blur(self: ptr DOMDOMWindow00) {.
    importc, libprag.}

proc blur*(self: DOMDOMWindow) =
  webkit_dom_dom_window_blur(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_capture_events(self: ptr DOMDOMWindow00) {.
    importc, libprag.}

proc captureEvents*(self: DOMDOMWindow) =
  webkit_dom_dom_window_capture_events(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_close(self: ptr DOMDOMWindow00) {.
    importc, libprag.}

proc close*(self: DOMDOMWindow) =
  webkit_dom_dom_window_close(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_confirm(self: ptr DOMDOMWindow00; message: cstring): gboolean {.
    importc, libprag.}

proc confirm*(self: DOMDOMWindow; message: cstring): bool =
  toBool(webkit_dom_dom_window_confirm(cast[ptr DOMDOMWindow00](self.impl), message))

proc webkit_dom_dom_window_find(self: ptr DOMDOMWindow00; string: cstring;
    caseSensitive: gboolean; backwards: gboolean; wrap: gboolean; wholeWord: gboolean;
    searchInFrames: gboolean; showDialog: gboolean): gboolean {.
    importc, libprag.}

proc findDOMDOMWindow*(self: DOMDOMWindow; string: cstring; caseSensitive: bool;
    backwards: bool; wrap: bool; wholeWord: bool; searchInFrames: bool; showDialog: bool): bool =
  toBool(webkit_dom_dom_window_find(cast[ptr DOMDOMWindow00](self.impl), string, gboolean(caseSensitive), gboolean(backwards), gboolean(wrap), gboolean(wholeWord), gboolean(searchInFrames), gboolean(showDialog)))

proc webkit_dom_dom_window_focus(self: ptr DOMDOMWindow00) {.
    importc, libprag.}

proc focus*(self: DOMDOMWindow) =
  webkit_dom_dom_window_focus(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_closed(self: ptr DOMDOMWindow00): gboolean {.
    importc, libprag.}

proc getClosed*(self: DOMDOMWindow): bool =
  toBool(webkit_dom_dom_window_get_closed(cast[ptr DOMDOMWindow00](self.impl)))

proc closed*(self: DOMDOMWindow): bool =
  toBool(webkit_dom_dom_window_get_closed(cast[ptr DOMDOMWindow00](self.impl)))

proc webkit_dom_dom_window_get_default_status(self: ptr DOMDOMWindow00): cstring {.
    importc, libprag.}

proc getDefaultStatus*(self: DOMDOMWindow): string =
  let resul0 = webkit_dom_dom_window_get_default_status(cast[ptr DOMDOMWindow00](self.impl))
  result = $resul0
  cogfree(resul0)

proc defaultStatus*(self: DOMDOMWindow): string =
  let resul0 = webkit_dom_dom_window_get_default_status(cast[ptr DOMDOMWindow00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_dom_window_get_device_pixel_ratio(self: ptr DOMDOMWindow00): cdouble {.
    importc, libprag.}

proc getDevicePixelRatio*(self: DOMDOMWindow): cdouble =
  webkit_dom_dom_window_get_device_pixel_ratio(cast[ptr DOMDOMWindow00](self.impl))

proc devicePixelRatio*(self: DOMDOMWindow): cdouble =
  webkit_dom_dom_window_get_device_pixel_ratio(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_document(self: ptr DOMDOMWindow00): ptr DOMDocument00 {.
    importc, libprag.}

proc getDocument*(self: DOMDOMWindow): DOMDocument =
  let gobj = webkit_dom_dom_window_get_document(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc document*(self: DOMDOMWindow): DOMDocument =
  let gobj = webkit_dom_dom_window_get_document(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_frames(self: ptr DOMDOMWindow00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getFrames*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_frames(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc frames*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_frames(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_inner_height(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getInnerHeight*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_inner_height(cast[ptr DOMDOMWindow00](self.impl))

proc innerHeight*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_inner_height(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_inner_width(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getInnerWidth*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_inner_width(cast[ptr DOMDOMWindow00](self.impl))

proc innerWidth*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_inner_width(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_length(self: ptr DOMDOMWindow00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMDOMWindow): uint64 =
  webkit_dom_dom_window_get_length(cast[ptr DOMDOMWindow00](self.impl))

proc length*(self: DOMDOMWindow): uint64 =
  webkit_dom_dom_window_get_length(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_name(self: ptr DOMDOMWindow00): cstring {.
    importc, libprag.}

proc getName*(self: DOMDOMWindow): string =
  let resul0 = webkit_dom_dom_window_get_name(cast[ptr DOMDOMWindow00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMDOMWindow): string =
  let resul0 = webkit_dom_dom_window_get_name(cast[ptr DOMDOMWindow00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_dom_window_get_offscreen_buffering(self: ptr DOMDOMWindow00): gboolean {.
    importc, libprag.}

proc getOffscreenBuffering*(self: DOMDOMWindow): bool =
  toBool(webkit_dom_dom_window_get_offscreen_buffering(cast[ptr DOMDOMWindow00](self.impl)))

proc offscreenBuffering*(self: DOMDOMWindow): bool =
  toBool(webkit_dom_dom_window_get_offscreen_buffering(cast[ptr DOMDOMWindow00](self.impl)))

proc webkit_dom_dom_window_get_opener(self: ptr DOMDOMWindow00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getOpener*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_opener(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc opener*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_opener(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_orientation(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getOrientation*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_orientation(cast[ptr DOMDOMWindow00](self.impl))

proc orientation*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_orientation(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_outer_height(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getOuterHeight*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_outer_height(cast[ptr DOMDOMWindow00](self.impl))

proc outerHeight*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_outer_height(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_outer_width(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getOuterWidth*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_outer_width(cast[ptr DOMDOMWindow00](self.impl))

proc outerWidth*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_outer_width(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_page_x_offset(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getPageXOffset*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_page_x_offset(cast[ptr DOMDOMWindow00](self.impl))

proc pageXOffset*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_page_x_offset(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_page_y_offset(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getPageYOffset*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_page_y_offset(cast[ptr DOMDOMWindow00](self.impl))

proc pageYOffset*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_page_y_offset(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_parent(self: ptr DOMDOMWindow00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getParent*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_parent(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parent*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_parent(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_screen_left(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getScreenLeft*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_left(cast[ptr DOMDOMWindow00](self.impl))

proc screenLeft*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_left(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_screen_top(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getScreenTop*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_top(cast[ptr DOMDOMWindow00](self.impl))

proc screenTop*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_top(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_screen_x(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getScreenX*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_x(cast[ptr DOMDOMWindow00](self.impl))

proc screenX*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_x(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_screen_y(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getScreenY*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_y(cast[ptr DOMDOMWindow00](self.impl))

proc screenY*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_screen_y(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_scroll_x(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getScrollX*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_scroll_x(cast[ptr DOMDOMWindow00](self.impl))

proc scrollX*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_scroll_x(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_scroll_y(self: ptr DOMDOMWindow00): int64 {.
    importc, libprag.}

proc getScrollY*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_scroll_y(cast[ptr DOMDOMWindow00](self.impl))

proc scrollY*(self: DOMDOMWindow): int64 =
  webkit_dom_dom_window_get_scroll_y(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_get_self(self: ptr DOMDOMWindow00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getSelf*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_self(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc self*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_self(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_status(self: ptr DOMDOMWindow00): cstring {.
    importc, libprag.}

proc getStatus*(self: DOMDOMWindow): string =
  let resul0 = webkit_dom_dom_window_get_status(cast[ptr DOMDOMWindow00](self.impl))
  result = $resul0
  cogfree(resul0)

proc status*(self: DOMDOMWindow): string =
  let resul0 = webkit_dom_dom_window_get_status(cast[ptr DOMDOMWindow00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_dom_window_get_top(self: ptr DOMDOMWindow00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getTop*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_top(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc top*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_top(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_window(self: ptr DOMDOMWindow00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getWindow*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_window(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc window*(self: DOMDOMWindow): DOMDOMWindow =
  let gobj = webkit_dom_dom_window_get_window(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_move_by(self: ptr DOMDOMWindow00; x: cfloat; y: cfloat) {.
    importc, libprag.}

proc moveBy*(self: DOMDOMWindow; x: cfloat; y: cfloat) =
  webkit_dom_dom_window_move_by(cast[ptr DOMDOMWindow00](self.impl), x, y)

proc webkit_dom_dom_window_move_to(self: ptr DOMDOMWindow00; x: cfloat; y: cfloat) {.
    importc, libprag.}

proc moveTo*(self: DOMDOMWindow; x: cfloat; y: cfloat) =
  webkit_dom_dom_window_move_to(cast[ptr DOMDOMWindow00](self.impl), x, y)

proc webkit_dom_dom_window_print(self: ptr DOMDOMWindow00) {.
    importc, libprag.}

proc print*(self: DOMDOMWindow) =
  webkit_dom_dom_window_print(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_prompt(self: ptr DOMDOMWindow00; message: cstring;
    defaultValue: cstring): cstring {.
    importc, libprag.}

proc prompt*(self: DOMDOMWindow; message: cstring; defaultValue: cstring): string =
  let resul0 = webkit_dom_dom_window_prompt(cast[ptr DOMDOMWindow00](self.impl), message, defaultValue)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_dom_window_release_events(self: ptr DOMDOMWindow00) {.
    importc, libprag.}

proc releaseEvents*(self: DOMDOMWindow) =
  webkit_dom_dom_window_release_events(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_resize_by(self: ptr DOMDOMWindow00; x: cfloat;
    y: cfloat) {.
    importc, libprag.}

proc resizeBy*(self: DOMDOMWindow; x: cfloat; y: cfloat) =
  webkit_dom_dom_window_resize_by(cast[ptr DOMDOMWindow00](self.impl), x, y)

proc webkit_dom_dom_window_resize_to(self: ptr DOMDOMWindow00; width: cfloat;
    height: cfloat) {.
    importc, libprag.}

proc resizeTo*(self: DOMDOMWindow; width: cfloat; height: cfloat) =
  webkit_dom_dom_window_resize_to(cast[ptr DOMDOMWindow00](self.impl), width, height)

proc webkit_dom_dom_window_scroll_by(self: ptr DOMDOMWindow00; x: cdouble;
    y: cdouble) {.
    importc, libprag.}

proc scrollBy*(self: DOMDOMWindow; x: cdouble; y: cdouble) =
  webkit_dom_dom_window_scroll_by(cast[ptr DOMDOMWindow00](self.impl), x, y)

proc webkit_dom_dom_window_scroll_to(self: ptr DOMDOMWindow00; x: cdouble;
    y: cdouble) {.
    importc, libprag.}

proc scrollTo*(self: DOMDOMWindow; x: cdouble; y: cdouble) =
  webkit_dom_dom_window_scroll_to(cast[ptr DOMDOMWindow00](self.impl), x, y)

proc webkit_dom_dom_window_set_default_status(self: ptr DOMDOMWindow00; value: cstring) {.
    importc, libprag.}

proc setDefaultStatus*(self: DOMDOMWindow; value: cstring) =
  webkit_dom_dom_window_set_default_status(cast[ptr DOMDOMWindow00](self.impl), value)

proc `defaultStatus=`*(self: DOMDOMWindow; value: cstring) =
  webkit_dom_dom_window_set_default_status(cast[ptr DOMDOMWindow00](self.impl), value)

proc webkit_dom_dom_window_set_name(self: ptr DOMDOMWindow00; value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMDOMWindow; value: cstring) =
  webkit_dom_dom_window_set_name(cast[ptr DOMDOMWindow00](self.impl), value)

proc `name=`*(self: DOMDOMWindow; value: cstring) =
  webkit_dom_dom_window_set_name(cast[ptr DOMDOMWindow00](self.impl), value)

proc webkit_dom_dom_window_set_status(self: ptr DOMDOMWindow00; value: cstring) {.
    importc, libprag.}

proc setStatus*(self: DOMDOMWindow; value: cstring) =
  webkit_dom_dom_window_set_status(cast[ptr DOMDOMWindow00](self.impl), value)

proc `status=`*(self: DOMDOMWindow; value: cstring) =
  webkit_dom_dom_window_set_status(cast[ptr DOMDOMWindow00](self.impl), value)

proc webkit_dom_dom_window_stop(self: ptr DOMDOMWindow00) {.
    importc, libprag.}

proc stop*(self: DOMDOMWindow) =
  webkit_dom_dom_window_stop(cast[ptr DOMDOMWindow00](self.impl))

proc webkit_dom_dom_window_webkit_message_handlers_post_message(self: ptr DOMDOMWindow00;
    handler: cstring; message: cstring): gboolean {.
    importc, libprag.}

proc webkitMessageHandlersPostMessage*(self: DOMDOMWindow;
    handler: cstring; message: cstring): bool =
  toBool(webkit_dom_dom_window_webkit_message_handlers_post_message(cast[ptr DOMDOMWindow00](self.impl), handler, message))

proc webkit_dom_document_get_default_view(self: ptr DOMDocument00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getDefaultView*(self: DOMDocument): DOMDOMWindow =
  let gobj = webkit_dom_document_get_default_view(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc defaultView*(self: DOMDocument): DOMDOMWindow =
  let gobj = webkit_dom_document_get_default_view(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMDOMSelection* = ref object of DOMObject
  DOMDOMSelection00* = object of DOMObject00

proc webkit_dom_dom_selection_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMDOMSelection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_dom_selection_add_range(self: ptr DOMDOMSelection00; range: ptr DOMRange00) {.
    importc, libprag.}

proc addRange*(self: DOMDOMSelection; range: DOMRange) =
  webkit_dom_dom_selection_add_range(cast[ptr DOMDOMSelection00](self.impl), cast[ptr DOMRange00](range.impl))

proc webkit_dom_dom_selection_collapse(self: ptr DOMDOMSelection00; node: ptr DOMNode00;
    offset: uint64) {.
    importc, libprag.}

proc collapse*(self: DOMDOMSelection; node: DOMNode;
    offset: uint64) =
  webkit_dom_dom_selection_collapse(cast[ptr DOMDOMSelection00](self.impl), cast[ptr DOMNode00](node.impl), offset)

proc webkit_dom_dom_selection_collapse_to_end(self: ptr DOMDOMSelection00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc collapseToEnd*(self: DOMDOMSelection) =
  var gerror: ptr glib.Error
  webkit_dom_dom_selection_collapse_to_end(cast[ptr DOMDOMSelection00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_dom_selection_collapse_to_start(self: ptr DOMDOMSelection00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc collapseToStart*(self: DOMDOMSelection) =
  var gerror: ptr glib.Error
  webkit_dom_dom_selection_collapse_to_start(cast[ptr DOMDOMSelection00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_dom_selection_contains_node(self: ptr DOMDOMSelection00;
    node: ptr DOMNode00; allowPartial: gboolean): gboolean {.
    importc, libprag.}

proc containsNode*(self: DOMDOMSelection; node: DOMNode;
    allowPartial: bool): bool =
  toBool(webkit_dom_dom_selection_contains_node(cast[ptr DOMDOMSelection00](self.impl), cast[ptr DOMNode00](node.impl), gboolean(allowPartial)))

proc webkit_dom_dom_selection_delete_from_document(self: ptr DOMDOMSelection00) {.
    importc, libprag.}

proc deleteFromDocument*(self: DOMDOMSelection) =
  webkit_dom_dom_selection_delete_from_document(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_empty(self: ptr DOMDOMSelection00) {.
    importc, libprag.}

proc empty*(self: DOMDOMSelection) =
  webkit_dom_dom_selection_empty(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_extend(self: ptr DOMDOMSelection00; node: ptr DOMNode00;
    offset: uint64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc extend*(self: DOMDOMSelection; node: DOMNode;
    offset: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_dom_selection_extend(cast[ptr DOMDOMSelection00](self.impl), cast[ptr DOMNode00](node.impl), offset, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_dom_selection_get_anchor_node(self: ptr DOMDOMSelection00): ptr DOMNode00 {.
    importc, libprag.}

proc getAnchorNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_anchor_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc anchorNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_anchor_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_selection_get_anchor_offset(self: ptr DOMDOMSelection00): uint64 {.
    importc, libprag.}

proc getAnchorOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_anchor_offset(cast[ptr DOMDOMSelection00](self.impl))

proc anchorOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_anchor_offset(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_get_base_node(self: ptr DOMDOMSelection00): ptr DOMNode00 {.
    importc, libprag.}

proc getBaseNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_base_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc baseNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_base_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_selection_get_base_offset(self: ptr DOMDOMSelection00): uint64 {.
    importc, libprag.}

proc getBaseOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_base_offset(cast[ptr DOMDOMSelection00](self.impl))

proc baseOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_base_offset(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_get_extent_node(self: ptr DOMDOMSelection00): ptr DOMNode00 {.
    importc, libprag.}

proc getExtentNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_extent_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc extentNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_extent_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_selection_get_extent_offset(self: ptr DOMDOMSelection00): uint64 {.
    importc, libprag.}

proc getExtentOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_extent_offset(cast[ptr DOMDOMSelection00](self.impl))

proc extentOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_extent_offset(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_get_focus_node(self: ptr DOMDOMSelection00): ptr DOMNode00 {.
    importc, libprag.}

proc getFocusNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_focus_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc focusNode*(self: DOMDOMSelection): DOMNode =
  let gobj = webkit_dom_dom_selection_get_focus_node(cast[ptr DOMDOMSelection00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_selection_get_focus_offset(self: ptr DOMDOMSelection00): uint64 {.
    importc, libprag.}

proc getFocusOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_focus_offset(cast[ptr DOMDOMSelection00](self.impl))

proc focusOffset*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_focus_offset(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_get_is_collapsed(self: ptr DOMDOMSelection00): gboolean {.
    importc, libprag.}

proc getIsCollapsed*(self: DOMDOMSelection): bool =
  toBool(webkit_dom_dom_selection_get_is_collapsed(cast[ptr DOMDOMSelection00](self.impl)))

proc isCollapsed*(self: DOMDOMSelection): bool =
  toBool(webkit_dom_dom_selection_get_is_collapsed(cast[ptr DOMDOMSelection00](self.impl)))

proc webkit_dom_dom_selection_get_range_at(self: ptr DOMDOMSelection00; index: uint64;
    error: ptr ptr glib.Error = nil): ptr DOMRange00 {.
    importc, libprag.}

proc getRangeAt*(self: DOMDOMSelection; index: uint64): DOMRange =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_dom_selection_get_range_at(cast[ptr DOMDOMSelection00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_selection_get_range_count(self: ptr DOMDOMSelection00): uint64 {.
    importc, libprag.}

proc getRangeCount*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_range_count(cast[ptr DOMDOMSelection00](self.impl))

proc rangeCount*(self: DOMDOMSelection): uint64 =
  webkit_dom_dom_selection_get_range_count(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_get_selection_type(self: ptr DOMDOMSelection00): cstring {.
    importc, libprag.}

proc getSelectionType*(self: DOMDOMSelection): string =
  let resul0 = webkit_dom_dom_selection_get_selection_type(cast[ptr DOMDOMSelection00](self.impl))
  result = $resul0
  cogfree(resul0)

proc selectionType*(self: DOMDOMSelection): string =
  let resul0 = webkit_dom_dom_selection_get_selection_type(cast[ptr DOMDOMSelection00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_dom_selection_modify(self: ptr DOMDOMSelection00; alter: cstring;
    direction: cstring; granularity: cstring) {.
    importc, libprag.}

proc modify*(self: DOMDOMSelection; alter: cstring;
    direction: cstring; granularity: cstring) =
  webkit_dom_dom_selection_modify(cast[ptr DOMDOMSelection00](self.impl), alter, direction, granularity)

proc webkit_dom_dom_selection_remove_all_ranges(self: ptr DOMDOMSelection00) {.
    importc, libprag.}

proc removeAllRanges*(self: DOMDOMSelection) =
  webkit_dom_dom_selection_remove_all_ranges(cast[ptr DOMDOMSelection00](self.impl))

proc webkit_dom_dom_selection_select_all_children(self: ptr DOMDOMSelection00;
    node: ptr DOMNode00) {.
    importc, libprag.}

proc selectAllChildren*(self: DOMDOMSelection;
    node: DOMNode) =
  webkit_dom_dom_selection_select_all_children(cast[ptr DOMDOMSelection00](self.impl), cast[ptr DOMNode00](node.impl))

proc webkit_dom_dom_selection_set_base_and_extent(self: ptr DOMDOMSelection00;
    baseNode: ptr DOMNode00; baseOffset: uint64; extentNode: ptr DOMNode00;
    extentOffset: uint64) {.
    importc, libprag.}

proc setBaseAndExtent*(self: DOMDOMSelection;
    baseNode: DOMNode; baseOffset: uint64; extentNode: DOMNode; extentOffset: uint64) =
  webkit_dom_dom_selection_set_base_and_extent(cast[ptr DOMDOMSelection00](self.impl), cast[ptr DOMNode00](baseNode.impl), baseOffset, cast[ptr DOMNode00](extentNode.impl), extentOffset)

proc webkit_dom_dom_selection_set_position(self: ptr DOMDOMSelection00; node: ptr DOMNode00;
    offset: uint64) {.
    importc, libprag.}

proc setPosition*(self: DOMDOMSelection; node: DOMNode;
    offset: uint64) =
  webkit_dom_dom_selection_set_position(cast[ptr DOMDOMSelection00](self.impl), cast[ptr DOMNode00](node.impl), offset)

proc webkit_dom_dom_window_get_selection(self: ptr DOMDOMWindow00): ptr DOMDOMSelection00 {.
    importc, libprag.}

proc getSelection*(self: DOMDOMWindow): DOMDOMSelection =
  let gobj = webkit_dom_dom_window_get_selection(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc selection*(self: DOMDOMWindow): DOMDOMSelection =
  let gobj = webkit_dom_dom_window_get_selection(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMDocumentType* = ref object of DOMNode
  DOMDocumentType00* = object of DOMNode00

proc webkit_dom_document_type_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMDocumentType()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_document_type_get_internal_subset(self: ptr DOMDocumentType00): cstring {.
    importc, libprag.}

proc getInternalSubset*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_internal_subset(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc internalSubset*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_internal_subset(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_type_get_name(self: ptr DOMDocumentType00): cstring {.
    importc, libprag.}

proc getName*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_name(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_name(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_type_get_public_id(self: ptr DOMDocumentType00): cstring {.
    importc, libprag.}

proc getPublicId*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_public_id(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc publicId*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_public_id(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_type_get_system_id(self: ptr DOMDocumentType00): cstring {.
    importc, libprag.}

proc getSystemId*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_system_id(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc systemId*(self: DOMDocumentType): string =
  let resul0 = webkit_dom_document_type_get_system_id(cast[ptr DOMDocumentType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_document_get_doctype(self: ptr DOMDocument00): ptr DOMDocumentType00 {.
    importc, libprag.}

proc getDoctype*(self: DOMDocument): DOMDocumentType =
  let gobj = webkit_dom_document_get_doctype(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc doctype*(self: DOMDocument): DOMDocumentType =
  let gobj = webkit_dom_document_get_doctype(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMNamedNodeMap* = ref object of DOMObject
  DOMNamedNodeMap00* = object of DOMObject00

proc webkit_dom_named_node_map_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMNamedNodeMap()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_named_node_map_get_length(self: ptr DOMNamedNodeMap00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMNamedNodeMap): uint64 =
  webkit_dom_named_node_map_get_length(cast[ptr DOMNamedNodeMap00](self.impl))

proc length*(self: DOMNamedNodeMap): uint64 =
  webkit_dom_named_node_map_get_length(cast[ptr DOMNamedNodeMap00](self.impl))

proc webkit_dom_named_node_map_get_named_item(self: ptr DOMNamedNodeMap00;
    name: cstring): ptr DOMNode00 {.
    importc, libprag.}

proc getNamedItem*(self: DOMNamedNodeMap; name: cstring): DOMNode =
  let gobj = webkit_dom_named_node_map_get_named_item(cast[ptr DOMNamedNodeMap00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_named_node_map_get_named_item_ns(self: ptr DOMNamedNodeMap00;
    namespaceURI: cstring; localName: cstring): ptr DOMNode00 {.
    importc, libprag.}

proc getNamedItemNs*(self: DOMNamedNodeMap; namespaceURI: cstring;
    localName: cstring): DOMNode =
  let gobj = webkit_dom_named_node_map_get_named_item_ns(cast[ptr DOMNamedNodeMap00](self.impl), namespaceURI, localName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_named_node_map_item(self: ptr DOMNamedNodeMap00; index: uint64): ptr DOMNode00 {.
    importc, libprag.}

proc item*(self: DOMNamedNodeMap; index: uint64): DOMNode =
  let gobj = webkit_dom_named_node_map_item(cast[ptr DOMNamedNodeMap00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_named_node_map_remove_named_item(self: ptr DOMNamedNodeMap00;
    name: cstring; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc removeNamedItem*(self: DOMNamedNodeMap; name: cstring): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_named_node_map_remove_named_item(cast[ptr DOMNamedNodeMap00](self.impl), name, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_named_node_map_remove_named_item_ns(self: ptr DOMNamedNodeMap00;
    namespaceURI: cstring; localName: cstring; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc removeNamedItemNs*(self: DOMNamedNodeMap;
    namespaceURI: cstring; localName: cstring): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_named_node_map_remove_named_item_ns(cast[ptr DOMNamedNodeMap00](self.impl), namespaceURI, localName, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_named_node_map_set_named_item(self: ptr DOMNamedNodeMap00;
    node: ptr DOMNode00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc setNamedItem*(self: DOMNamedNodeMap; node: DOMNode): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_named_node_map_set_named_item(cast[ptr DOMNamedNodeMap00](self.impl), cast[ptr DOMNode00](node.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_named_node_map_set_named_item_ns(self: ptr DOMNamedNodeMap00;
    node: ptr DOMNode00; error: ptr ptr glib.Error = nil): ptr DOMNode00 {.
    importc, libprag.}

proc setNamedItemNs*(self: DOMNamedNodeMap; node: DOMNode): DOMNode =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_named_node_map_set_named_item_ns(cast[ptr DOMNamedNodeMap00](self.impl), cast[ptr DOMNode00](node.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_type_get_entities(self: ptr DOMDocumentType00): ptr DOMNamedNodeMap00 {.
    importc, libprag.}

proc getEntities*(self: DOMDocumentType): DOMNamedNodeMap =
  let gobj = webkit_dom_document_type_get_entities(cast[ptr DOMDocumentType00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc entities*(self: DOMDocumentType): DOMNamedNodeMap =
  let gobj = webkit_dom_document_type_get_entities(cast[ptr DOMDocumentType00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_type_get_notations(self: ptr DOMDocumentType00): ptr DOMNamedNodeMap00 {.
    importc, libprag.}

proc getNotations*(self: DOMDocumentType): DOMNamedNodeMap =
  let gobj = webkit_dom_document_type_get_notations(cast[ptr DOMDocumentType00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc notations*(self: DOMDocumentType): DOMNamedNodeMap =
  let gobj = webkit_dom_document_type_get_notations(cast[ptr DOMDocumentType00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMDOMImplementation* = ref object of DOMObject
  DOMDOMImplementation00* = object of DOMObject00

proc webkit_dom_dom_implementation_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMDOMImplementation()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_dom_implementation_create_css_style_sheet(self: ptr DOMDOMImplementation00;
    title: cstring; media: cstring; error: ptr ptr glib.Error = nil): ptr DOMCSSStyleSheet00 {.
    importc, libprag.}

proc createCssStyleSheet*(self: DOMDOMImplementation;
    title: cstring; media: cstring): DOMCSSStyleSheet =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_dom_implementation_create_css_style_sheet(cast[ptr DOMDOMImplementation00](self.impl), title, media, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_implementation_create_document(self: ptr DOMDOMImplementation00;
    namespaceURI: cstring; qualifiedName: cstring; doctype: ptr DOMDocumentType00;
    error: ptr ptr glib.Error = nil): ptr DOMDocument00 {.
    importc, libprag.}

proc createDocument*(self: DOMDOMImplementation;
    namespaceURI: cstring = nil; qualifiedName: cstring; doctype: DOMDocumentType = nil): DOMDocument =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_dom_implementation_create_document(cast[ptr DOMDOMImplementation00](self.impl), namespaceURI, qualifiedName, if doctype.isNil: nil else: cast[ptr DOMDocumentType00](doctype.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_implementation_create_document_type(self: ptr DOMDOMImplementation00;
    qualifiedName: cstring; publicId: cstring; systemId: cstring; error: ptr ptr glib.Error = nil): ptr DOMDocumentType00 {.
    importc, libprag.}

proc createDocumentType*(self: DOMDOMImplementation;
    qualifiedName: cstring; publicId: cstring; systemId: cstring): DOMDocumentType =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_dom_implementation_create_document_type(cast[ptr DOMDOMImplementation00](self.impl), qualifiedName, publicId, systemId, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_implementation_has_feature(self: ptr DOMDOMImplementation00;
    feature: cstring; version: cstring): gboolean {.
    importc, libprag.}

proc hasFeature*(self: DOMDOMImplementation;
    feature: cstring; version: cstring): bool =
  toBool(webkit_dom_dom_implementation_has_feature(cast[ptr DOMDOMImplementation00](self.impl), feature, version))

proc webkit_dom_document_get_implementation(self: ptr DOMDocument00): ptr DOMDOMImplementation00 {.
    importc, libprag.}

proc getImplementation*(self: DOMDocument): DOMDOMImplementation =
  let gobj = webkit_dom_document_get_implementation(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc implementation*(self: DOMDocument): DOMDOMImplementation =
  let gobj = webkit_dom_document_get_implementation(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMHTMLDocument* = ref object of DOMDocument
  DOMHTMLDocument00* = object of DOMDocument00

proc webkit_dom_html_document_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLDocument()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_document_capture_events(self: ptr DOMHTMLDocument00) {.
    importc, libprag.}

proc captureEvents*(self: DOMHTMLDocument) =
  webkit_dom_html_document_capture_events(cast[ptr DOMHTMLDocument00](self.impl))

proc webkit_dom_html_document_clear(self: ptr DOMHTMLDocument00) {.
    importc, libprag.}

proc clear*(self: DOMHTMLDocument) =
  webkit_dom_html_document_clear(cast[ptr DOMHTMLDocument00](self.impl))

proc webkit_dom_html_document_close(self: ptr DOMHTMLDocument00) {.
    importc, libprag.}

proc close*(self: DOMHTMLDocument) =
  webkit_dom_html_document_close(cast[ptr DOMHTMLDocument00](self.impl))

proc webkit_dom_html_document_get_alink_color(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getAlinkColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_alink_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc alinkColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_alink_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_bg_color(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getBgColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_bg_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc bgColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_bg_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_compat_mode(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getCompatMode*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_compat_mode(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc compatMode*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_compat_mode(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_design_mode(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getDesignMode*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_design_mode(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc designMode*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_design_mode(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_dir(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getDir*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_dir(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc dir*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_dir(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_fg_color(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getFgColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_fg_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc fgColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_fg_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_height(self: ptr DOMHTMLDocument00): int64 {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLDocument): int64 =
  webkit_dom_html_document_get_height(cast[ptr DOMHTMLDocument00](self.impl))

proc height*(self: DOMHTMLDocument): int64 =
  webkit_dom_html_document_get_height(cast[ptr DOMHTMLDocument00](self.impl))

proc webkit_dom_html_document_get_link_color(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getLinkColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_link_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc linkColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_link_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_vlink_color(self: ptr DOMHTMLDocument00): cstring {.
    importc, libprag.}

proc getVlinkColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_vlink_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc vlinkColor*(self: DOMHTMLDocument): string =
  let resul0 = webkit_dom_html_document_get_vlink_color(cast[ptr DOMHTMLDocument00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_document_get_width(self: ptr DOMHTMLDocument00): int64 {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLDocument): int64 =
  webkit_dom_html_document_get_width(cast[ptr DOMHTMLDocument00](self.impl))

proc width*(self: DOMHTMLDocument): int64 =
  webkit_dom_html_document_get_width(cast[ptr DOMHTMLDocument00](self.impl))

proc webkit_dom_html_document_release_events(self: ptr DOMHTMLDocument00) {.
    importc, libprag.}

proc releaseEvents*(self: DOMHTMLDocument) =
  webkit_dom_html_document_release_events(cast[ptr DOMHTMLDocument00](self.impl))

proc webkit_dom_html_document_set_alink_color(self: ptr DOMHTMLDocument00;
    value: cstring) {.
    importc, libprag.}

proc setAlinkColor*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_alink_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc `alinkColor=`*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_alink_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc webkit_dom_html_document_set_bg_color(self: ptr DOMHTMLDocument00; value: cstring) {.
    importc, libprag.}

proc setBgColor*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_bg_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc `bgColor=`*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_bg_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc webkit_dom_html_document_set_design_mode(self: ptr DOMHTMLDocument00;
    value: cstring) {.
    importc, libprag.}

proc setDesignMode*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_design_mode(cast[ptr DOMHTMLDocument00](self.impl), value)

proc `designMode=`*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_design_mode(cast[ptr DOMHTMLDocument00](self.impl), value)

proc webkit_dom_html_document_set_dir(self: ptr DOMHTMLDocument00; value: cstring) {.
    importc, libprag.}

proc setDir*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_dir(cast[ptr DOMHTMLDocument00](self.impl), value)

proc `dir=`*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_dir(cast[ptr DOMHTMLDocument00](self.impl), value)

proc webkit_dom_html_document_set_fg_color(self: ptr DOMHTMLDocument00; value: cstring) {.
    importc, libprag.}

proc setFgColor*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_fg_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc `fgColor=`*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_fg_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc webkit_dom_html_document_set_link_color(self: ptr DOMHTMLDocument00;
    value: cstring) {.
    importc, libprag.}

proc setLinkColor*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_link_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc `linkColor=`*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_link_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc webkit_dom_html_document_set_vlink_color(self: ptr DOMHTMLDocument00;
    value: cstring) {.
    importc, libprag.}

proc setVlinkColor*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_vlink_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc `vlinkColor=`*(self: DOMHTMLDocument; value: cstring) =
  webkit_dom_html_document_set_vlink_color(cast[ptr DOMHTMLDocument00](self.impl), value)

proc webkit_dom_dom_implementation_create_html_document(self: ptr DOMDOMImplementation00;
    title: cstring): ptr DOMHTMLDocument00 {.
    importc, libprag.}

proc createHtmlDocument*(self: DOMDOMImplementation;
    title: cstring): DOMHTMLDocument =
  let gobj = webkit_dom_dom_implementation_create_html_document(cast[ptr DOMDOMImplementation00](self.impl), title)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMHTMLCollection* = ref object of DOMObject
  DOMHTMLCollection00* = object of DOMObject00

proc webkit_dom_html_collection_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLCollection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_collection_get_length(self: ptr DOMHTMLCollection00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMHTMLCollection): uint64 =
  webkit_dom_html_collection_get_length(cast[ptr DOMHTMLCollection00](self.impl))

proc length*(self: DOMHTMLCollection): uint64 =
  webkit_dom_html_collection_get_length(cast[ptr DOMHTMLCollection00](self.impl))

proc webkit_dom_html_collection_item(self: ptr DOMHTMLCollection00; index: uint64): ptr DOMNode00 {.
    importc, libprag.}

proc item*(self: DOMHTMLCollection; index: uint64): DOMNode =
  let gobj = webkit_dom_html_collection_item(cast[ptr DOMHTMLCollection00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_collection_named_item(self: ptr DOMHTMLCollection00;
    name: cstring): ptr DOMNode00 {.
    importc, libprag.}

proc namedItem*(self: DOMHTMLCollection; name: cstring): DOMNode =
  let gobj = webkit_dom_html_collection_named_item(cast[ptr DOMHTMLCollection00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_anchors(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getAnchors*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_anchors(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc anchors*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_anchors(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_applets(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getApplets*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_applets(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc applets*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_applets(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_children(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getChildren*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_children(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc children*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_children(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_elements_by_class_name_as_html_collection(self: ptr DOMDocument00;
    classNames: cstring): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getElementsByClassNameAsHtmlCollection*(self: DOMDocument;
    classNames: cstring): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_elements_by_class_name_as_html_collection(cast[ptr DOMDocument00](self.impl), classNames)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_elements_by_tag_name_as_html_collection(self: ptr DOMDocument00;
    tagname: cstring): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getElementsByTagNameAsHtmlCollection*(self: DOMDocument;
    tagname: cstring): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_elements_by_tag_name_as_html_collection(cast[ptr DOMDocument00](self.impl), tagname)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_elements_by_tag_name_ns_as_html_collection(self: ptr DOMDocument00;
    namespaceURI: cstring; localName: cstring): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getElementsByTagNameNsAsHtmlCollection*(self: DOMDocument;
    namespaceURI: cstring; localName: cstring): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_elements_by_tag_name_ns_as_html_collection(cast[ptr DOMDocument00](self.impl), namespaceURI, localName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_embeds(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getEmbeds*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_embeds(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc embeds*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_embeds(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_forms(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getForms*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_forms(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc forms*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_forms(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_images(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getImages*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_images(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc images*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_images(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_links(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getLinks*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_links(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc links*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_links(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_plugins(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getPlugins*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_plugins(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc plugins*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_plugins(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_scripts(self: ptr DOMDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getScripts*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_scripts(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc scripts*(self: DOMDocument): DOMHTMLCollection =
  let gobj = webkit_dom_document_get_scripts(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_fragment_get_children(self: ptr DOMDocumentFragment00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getChildren*(self: DOMDocumentFragment): DOMHTMLCollection =
  let gobj = webkit_dom_document_fragment_get_children(cast[ptr DOMDocumentFragment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc children*(self: DOMDocumentFragment): DOMHTMLCollection =
  let gobj = webkit_dom_document_fragment_get_children(cast[ptr DOMDocumentFragment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_document_get_embeds(self: ptr DOMHTMLDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getEmbeds*(self: DOMHTMLDocument): DOMHTMLCollection =
  let gobj = webkit_dom_html_document_get_embeds(cast[ptr DOMHTMLDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc embeds*(self: DOMHTMLDocument): DOMHTMLCollection =
  let gobj = webkit_dom_html_document_get_embeds(cast[ptr DOMHTMLDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_document_get_plugins(self: ptr DOMHTMLDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getPlugins*(self: DOMHTMLDocument): DOMHTMLCollection =
  let gobj = webkit_dom_html_document_get_plugins(cast[ptr DOMHTMLDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc plugins*(self: DOMHTMLDocument): DOMHTMLCollection =
  let gobj = webkit_dom_html_document_get_plugins(cast[ptr DOMHTMLDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_document_get_scripts(self: ptr DOMHTMLDocument00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getScripts*(self: DOMHTMLDocument): DOMHTMLCollection =
  let gobj = webkit_dom_html_document_get_scripts(cast[ptr DOMHTMLDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc scripts*(self: DOMHTMLDocument): DOMHTMLCollection =
  let gobj = webkit_dom_html_document_get_scripts(cast[ptr DOMHTMLDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMStyleSheetList* = ref object of DOMObject
  DOMStyleSheetList00* = object of DOMObject00

proc webkit_dom_style_sheet_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMStyleSheetList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_style_sheet_list_get_length(self: ptr DOMStyleSheetList00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMStyleSheetList): uint64 =
  webkit_dom_style_sheet_list_get_length(cast[ptr DOMStyleSheetList00](self.impl))

proc length*(self: DOMStyleSheetList): uint64 =
  webkit_dom_style_sheet_list_get_length(cast[ptr DOMStyleSheetList00](self.impl))

proc webkit_dom_style_sheet_list_item(self: ptr DOMStyleSheetList00; index: uint64): ptr DOMStyleSheet00 {.
    importc, libprag.}

proc item*(self: DOMStyleSheetList; index: uint64): DOMStyleSheet =
  let gobj = webkit_dom_style_sheet_list_item(cast[ptr DOMStyleSheetList00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_style_sheets(self: ptr DOMDocument00): ptr DOMStyleSheetList00 {.
    importc, libprag.}

proc getStyleSheets*(self: DOMDocument): DOMStyleSheetList =
  let gobj = webkit_dom_document_get_style_sheets(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc styleSheets*(self: DOMDocument): DOMStyleSheetList =
  let gobj = webkit_dom_document_get_style_sheets(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMElement* = ref object of DOMNode
  DOMElement00* = object of DOMNode00

proc webkit_dom_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_element_blur(self: ptr DOMElement00) {.
    importc, libprag.}

proc blur*(self: DOMElement) =
  webkit_dom_element_blur(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_closest(self: ptr DOMElement00; selectors: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMElement00 {.
    importc, libprag.}

proc closest*(self: DOMElement; selectors: cstring): DOMElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_element_closest(cast[ptr DOMElement00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_focus(self: ptr DOMElement00) {.
    importc, libprag.}

proc focus*(self: DOMElement) =
  webkit_dom_element_focus(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_attribute(self: ptr DOMElement00; name: cstring): cstring {.
    importc, libprag.}

proc getAttribute*(self: DOMElement; name: cstring): string =
  let resul0 = webkit_dom_element_get_attribute(cast[ptr DOMElement00](self.impl), name)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_attribute_node(self: ptr DOMElement00; name: cstring): ptr DOMAttr00 {.
    importc, libprag.}

proc getAttributeNode*(self: DOMElement; name: cstring): DOMAttr =
  let gobj = webkit_dom_element_get_attribute_node(cast[ptr DOMElement00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_attribute_node_ns(self: ptr DOMElement00; namespaceURI: cstring;
    localName: cstring): ptr DOMAttr00 {.
    importc, libprag.}

proc getAttributeNodeNs*(self: DOMElement; namespaceURI: cstring;
    localName: cstring): DOMAttr =
  let gobj = webkit_dom_element_get_attribute_node_ns(cast[ptr DOMElement00](self.impl), namespaceURI, localName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_attribute_ns(self: ptr DOMElement00; namespaceURI: cstring;
    localName: cstring): cstring {.
    importc, libprag.}

proc getAttributeNs*(self: DOMElement; namespaceURI: cstring;
    localName: cstring): string =
  let resul0 = webkit_dom_element_get_attribute_ns(cast[ptr DOMElement00](self.impl), namespaceURI, localName)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_attributes(self: ptr DOMElement00): ptr DOMNamedNodeMap00 {.
    importc, libprag.}

proc getAttributes*(self: DOMElement): DOMNamedNodeMap =
  let gobj = webkit_dom_element_get_attributes(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc attributes*(self: DOMElement): DOMNamedNodeMap =
  let gobj = webkit_dom_element_get_attributes(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_child_element_count(self: ptr DOMElement00): uint64 {.
    importc, libprag.}

proc getChildElementCount*(self: DOMElement): uint64 =
  webkit_dom_element_get_child_element_count(cast[ptr DOMElement00](self.impl))

proc childElementCount*(self: DOMElement): uint64 =
  webkit_dom_element_get_child_element_count(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_children(self: ptr DOMElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getChildren*(self: DOMElement): DOMHTMLCollection =
  let gobj = webkit_dom_element_get_children(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc children*(self: DOMElement): DOMHTMLCollection =
  let gobj = webkit_dom_element_get_children(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_class_name(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getClassName*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_class_name(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc className*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_class_name(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_client_height(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getClientHeight*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_height(cast[ptr DOMElement00](self.impl))

proc clientHeight*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_height(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_client_left(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getClientLeft*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_left(cast[ptr DOMElement00](self.impl))

proc clientLeft*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_left(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_client_top(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getClientTop*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_top(cast[ptr DOMElement00](self.impl))

proc clientTop*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_top(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_client_width(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getClientWidth*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_width(cast[ptr DOMElement00](self.impl))

proc clientWidth*(self: DOMElement): cdouble =
  webkit_dom_element_get_client_width(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_elements_by_class_name(self: ptr DOMElement00;
    className: cstring): ptr DOMNodeList00 {.
    importc, libprag.}

proc getElementsByClassName*(self: DOMElement; className: cstring): DOMNodeList =
  let gobj = webkit_dom_element_get_elements_by_class_name(cast[ptr DOMElement00](self.impl), className)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_elements_by_class_name_as_html_collection(self: ptr DOMElement00;
    name: cstring): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getElementsByClassNameAsHtmlCollection*(self: DOMElement;
    name: cstring): DOMHTMLCollection =
  let gobj = webkit_dom_element_get_elements_by_class_name_as_html_collection(cast[ptr DOMElement00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_elements_by_tag_name(self: ptr DOMElement00;
    tagName: cstring): ptr DOMNodeList00 {.
    importc, libprag.}

proc getElementsByTagName*(self: DOMElement; tagName: cstring): DOMNodeList =
  let gobj = webkit_dom_element_get_elements_by_tag_name(cast[ptr DOMElement00](self.impl), tagName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_elements_by_tag_name_as_html_collection(self: ptr DOMElement00;
    name: cstring): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getElementsByTagNameAsHtmlCollection*(self: DOMElement;
    name: cstring): DOMHTMLCollection =
  let gobj = webkit_dom_element_get_elements_by_tag_name_as_html_collection(cast[ptr DOMElement00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_elements_by_tag_name_ns(self: ptr DOMElement00;
    namespaceUri: cstring; tagName: cstring): ptr DOMNodeList00 {.
    importc, libprag.}

proc getElementsByTagNameNs*(self: DOMElement; namespaceUri: cstring;
    tagName: cstring): DOMNodeList =
  let gobj = webkit_dom_element_get_elements_by_tag_name_ns(cast[ptr DOMElement00](self.impl), namespaceUri, tagName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_elements_by_tag_name_ns_as_html_collection(self: ptr DOMElement00;
    namespaceURI: cstring; localName: cstring): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getElementsByTagNameNsAsHtmlCollection*(self: DOMElement;
    namespaceURI: cstring; localName: cstring): DOMHTMLCollection =
  let gobj = webkit_dom_element_get_elements_by_tag_name_ns_as_html_collection(cast[ptr DOMElement00](self.impl), namespaceURI, localName)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_first_element_child(self: ptr DOMElement00): ptr DOMElement00 {.
    importc, libprag.}

proc getFirstElementChild*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_first_element_child(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc firstElementChild*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_first_element_child(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_id(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getId*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_id(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc id*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_id(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_inner_html(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getInnerHtml*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_inner_html(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc innerHtml*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_inner_html(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_last_element_child(self: ptr DOMElement00): ptr DOMElement00 {.
    importc, libprag.}

proc getLastElementChild*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_last_element_child(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc lastElementChild*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_last_element_child(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_local_name(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getLocalName*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_local_name(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc localName*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_local_name(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_namespace_uri(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getNamespaceUri*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_namespace_uri(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc namespaceUri*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_namespace_uri(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_next_element_sibling(self: ptr DOMElement00): ptr DOMElement00 {.
    importc, libprag.}

proc getNextElementSibling*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_next_element_sibling(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc nextElementSibling*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_next_element_sibling(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_offset_height(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getOffsetHeight*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_height(cast[ptr DOMElement00](self.impl))

proc offsetHeight*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_height(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_offset_left(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getOffsetLeft*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_left(cast[ptr DOMElement00](self.impl))

proc offsetLeft*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_left(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_offset_parent(self: ptr DOMElement00): ptr DOMElement00 {.
    importc, libprag.}

proc getOffsetParent*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_offset_parent(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc offsetParent*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_offset_parent(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_offset_top(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getOffsetTop*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_top(cast[ptr DOMElement00](self.impl))

proc offsetTop*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_top(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_offset_width(self: ptr DOMElement00): cdouble {.
    importc, libprag.}

proc getOffsetWidth*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_width(cast[ptr DOMElement00](self.impl))

proc offsetWidth*(self: DOMElement): cdouble =
  webkit_dom_element_get_offset_width(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_outer_html(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getOuterHtml*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_outer_html(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc outerHtml*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_outer_html(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_prefix(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getPrefix*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_prefix(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc prefix*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_prefix(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_previous_element_sibling(self: ptr DOMElement00): ptr DOMElement00 {.
    importc, libprag.}

proc getPreviousElementSibling*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_previous_element_sibling(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc previousElementSibling*(self: DOMElement): DOMElement =
  let gobj = webkit_dom_element_get_previous_element_sibling(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_scroll_height(self: ptr DOMElement00): int64 {.
    importc, libprag.}

proc getScrollHeight*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_height(cast[ptr DOMElement00](self.impl))

proc scrollHeight*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_height(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_scroll_left(self: ptr DOMElement00): int64 {.
    importc, libprag.}

proc getScrollLeft*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_left(cast[ptr DOMElement00](self.impl))

proc scrollLeft*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_left(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_scroll_top(self: ptr DOMElement00): int64 {.
    importc, libprag.}

proc getScrollTop*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_top(cast[ptr DOMElement00](self.impl))

proc scrollTop*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_top(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_scroll_width(self: ptr DOMElement00): int64 {.
    importc, libprag.}

proc getScrollWidth*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_width(cast[ptr DOMElement00](self.impl))

proc scrollWidth*(self: DOMElement): int64 =
  webkit_dom_element_get_scroll_width(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_get_style(self: ptr DOMElement00): ptr DOMCSSStyleDeclaration00 {.
    importc, libprag.}

proc getStyle*(self: DOMElement): DOMCSSStyleDeclaration =
  let gobj = webkit_dom_element_get_style(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc style*(self: DOMElement): DOMCSSStyleDeclaration =
  let gobj = webkit_dom_element_get_style(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_tag_name(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getTagName*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_tag_name(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc tagName*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_tag_name(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_get_webkit_region_overset(self: ptr DOMElement00): cstring {.
    importc, libprag.}

proc getWebkitRegionOverset*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_webkit_region_overset(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkitRegionOverset*(self: DOMElement): string =
  let resul0 = webkit_dom_element_get_webkit_region_overset(cast[ptr DOMElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_element_has_attribute(self: ptr DOMElement00; name: cstring): gboolean {.
    importc, libprag.}

proc hasAttribute*(self: DOMElement; name: cstring): bool =
  toBool(webkit_dom_element_has_attribute(cast[ptr DOMElement00](self.impl), name))

proc webkit_dom_element_has_attribute_ns(self: ptr DOMElement00; namespaceURI: cstring;
    localName: cstring): gboolean {.
    importc, libprag.}

proc hasAttributeNs*(self: DOMElement; namespaceURI: cstring;
    localName: cstring): bool =
  toBool(webkit_dom_element_has_attribute_ns(cast[ptr DOMElement00](self.impl), namespaceURI, localName))

proc webkit_dom_element_has_attributes(self: ptr DOMElement00): gboolean {.
    importc, libprag.}

proc hasAttributes*(self: DOMElement): bool =
  toBool(webkit_dom_element_has_attributes(cast[ptr DOMElement00](self.impl)))

proc webkit_dom_element_html_input_element_get_auto_filled(self: ptr DOMElement00): gboolean {.
    importc, libprag.}

proc htmlInputElementGetAutoFilled*(self: DOMElement): bool =
  toBool(webkit_dom_element_html_input_element_get_auto_filled(cast[ptr DOMElement00](self.impl)))

proc webkit_dom_element_html_input_element_is_user_edited(self: ptr DOMElement00): gboolean {.
    importc, libprag.}

proc htmlInputElementIsUserEdited*(self: DOMElement): bool =
  toBool(webkit_dom_element_html_input_element_is_user_edited(cast[ptr DOMElement00](self.impl)))

proc webkit_dom_element_html_input_element_set_auto_filled(self: ptr DOMElement00;
    autoFilled: gboolean) {.
    importc, libprag.}

proc htmlInputElementSetAutoFilled*(self: DOMElement;
    autoFilled: bool = true) =
  webkit_dom_element_html_input_element_set_auto_filled(cast[ptr DOMElement00](self.impl), gboolean(autoFilled))

proc webkit_dom_element_html_input_element_set_editing_value(self: ptr DOMElement00;
    value: cstring) {.
    importc, libprag.}

proc htmlInputElementSetEditingValue*(self: DOMElement;
    value: cstring) =
  webkit_dom_element_html_input_element_set_editing_value(cast[ptr DOMElement00](self.impl), value)

proc webkit_dom_element_insert_adjacent_element(self: ptr DOMElement00; where: cstring;
    element: ptr DOMElement00; error: ptr ptr glib.Error = nil): ptr DOMElement00 {.
    importc, libprag.}

proc insertAdjacentElement*(self: DOMElement; where: cstring;
    element: DOMElement): DOMElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_element_insert_adjacent_element(cast[ptr DOMElement00](self.impl), where, cast[ptr DOMElement00](element.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_insert_adjacent_html(self: ptr DOMElement00; where: cstring;
    html: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc insertAdjacentHtml*(self: DOMElement; where: cstring;
    html: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_insert_adjacent_html(cast[ptr DOMElement00](self.impl), where, html, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_element_insert_adjacent_text(self: ptr DOMElement00; where: cstring;
    text: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc insertAdjacentText*(self: DOMElement; where: cstring;
    text: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_insert_adjacent_text(cast[ptr DOMElement00](self.impl), where, text, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_element_matches(self: ptr DOMElement00; selectors: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc matches*(self: DOMElement; selectors: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_element_matches(cast[ptr DOMElement00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_element_query_selector(self: ptr DOMElement00; selectors: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMElement00 {.
    importc, libprag.}

proc querySelector*(self: DOMElement; selectors: cstring): DOMElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_element_query_selector(cast[ptr DOMElement00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_query_selector_all(self: ptr DOMElement00; selectors: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMNodeList00 {.
    importc, libprag.}

proc querySelectorAll*(self: DOMElement; selectors: cstring): DOMNodeList =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_element_query_selector_all(cast[ptr DOMElement00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_remove(self: ptr DOMElement00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc remove*(self: DOMElement) =
  var gerror: ptr glib.Error
  webkit_dom_element_remove(cast[ptr DOMElement00](self.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_element_remove_attribute(self: ptr DOMElement00; name: cstring) {.
    importc, libprag.}

proc removeAttribute*(self: DOMElement; name: cstring) =
  webkit_dom_element_remove_attribute(cast[ptr DOMElement00](self.impl), name)

proc webkit_dom_element_remove_attribute_node(self: ptr DOMElement00; oldAttr: ptr DOMAttr00;
    error: ptr ptr glib.Error = nil): ptr DOMAttr00 {.
    importc, libprag.}

proc removeAttributeNode*(self: DOMElement; oldAttr: DOMAttr): DOMAttr =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_element_remove_attribute_node(cast[ptr DOMElement00](self.impl), cast[ptr DOMAttr00](oldAttr.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_remove_attribute_ns(self: ptr DOMElement00; namespaceURI: cstring;
    localName: cstring) {.
    importc, libprag.}

proc removeAttributeNs*(self: DOMElement; namespaceURI: cstring;
    localName: cstring) =
  webkit_dom_element_remove_attribute_ns(cast[ptr DOMElement00](self.impl), namespaceURI, localName)

proc webkit_dom_element_request_pointer_lock(self: ptr DOMElement00) {.
    importc, libprag.}

proc requestPointerLock*(self: DOMElement) =
  webkit_dom_element_request_pointer_lock(cast[ptr DOMElement00](self.impl))

proc webkit_dom_element_scroll_by_lines(self: ptr DOMElement00; lines: int64) {.
    importc, libprag.}

proc scrollByLines*(self: DOMElement; lines: int64) =
  webkit_dom_element_scroll_by_lines(cast[ptr DOMElement00](self.impl), lines)

proc webkit_dom_element_scroll_by_pages(self: ptr DOMElement00; pages: int64) {.
    importc, libprag.}

proc scrollByPages*(self: DOMElement; pages: int64) =
  webkit_dom_element_scroll_by_pages(cast[ptr DOMElement00](self.impl), pages)

proc webkit_dom_element_scroll_into_view(self: ptr DOMElement00; alignWithTop: gboolean) {.
    importc, libprag.}

proc scrollIntoView*(self: DOMElement; alignWithTop: bool) =
  webkit_dom_element_scroll_into_view(cast[ptr DOMElement00](self.impl), gboolean(alignWithTop))

proc webkit_dom_element_scroll_into_view_if_needed(self: ptr DOMElement00;
    centerIfNeeded: gboolean) {.
    importc, libprag.}

proc scrollIntoViewIfNeeded*(self: DOMElement; centerIfNeeded: bool) =
  webkit_dom_element_scroll_into_view_if_needed(cast[ptr DOMElement00](self.impl), gboolean(centerIfNeeded))

proc webkit_dom_element_set_attribute(self: ptr DOMElement00; name: cstring;
    value: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setAttribute*(self: DOMElement; name: cstring; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_set_attribute(cast[ptr DOMElement00](self.impl), name, value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_element_set_attribute_node(self: ptr DOMElement00; newAttr: ptr DOMAttr00;
    error: ptr ptr glib.Error = nil): ptr DOMAttr00 {.
    importc, libprag.}

proc setAttributeNode*(self: DOMElement; newAttr: DOMAttr): DOMAttr =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_element_set_attribute_node(cast[ptr DOMElement00](self.impl), cast[ptr DOMAttr00](newAttr.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_set_attribute_node_ns(self: ptr DOMElement00; newAttr: ptr DOMAttr00;
    error: ptr ptr glib.Error = nil): ptr DOMAttr00 {.
    importc, libprag.}

proc setAttributeNodeNs*(self: DOMElement; newAttr: DOMAttr): DOMAttr =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_element_set_attribute_node_ns(cast[ptr DOMElement00](self.impl), cast[ptr DOMAttr00](newAttr.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_set_attribute_ns(self: ptr DOMElement00; namespaceURI: cstring;
    qualifiedName: cstring; value: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setAttributeNs*(self: DOMElement; namespaceURI: cstring = nil;
    qualifiedName: cstring; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_set_attribute_ns(cast[ptr DOMElement00](self.impl), namespaceURI, qualifiedName, value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_element_set_class_name(self: ptr DOMElement00; value: cstring) {.
    importc, libprag.}

proc setClassName*(self: DOMElement; value: cstring) =
  webkit_dom_element_set_class_name(cast[ptr DOMElement00](self.impl), value)

proc `className=`*(self: DOMElement; value: cstring) =
  webkit_dom_element_set_class_name(cast[ptr DOMElement00](self.impl), value)

proc webkit_dom_element_set_id(self: ptr DOMElement00; value: cstring) {.
    importc, libprag.}

proc setId*(self: DOMElement; value: cstring) =
  webkit_dom_element_set_id(cast[ptr DOMElement00](self.impl), value)

proc `id=`*(self: DOMElement; value: cstring) =
  webkit_dom_element_set_id(cast[ptr DOMElement00](self.impl), value)

proc webkit_dom_element_set_inner_html(self: ptr DOMElement00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setInnerHtml*(self: DOMElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_set_inner_html(cast[ptr DOMElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `innerHtml=`*(self: DOMElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_set_inner_html(cast[ptr DOMElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_element_set_outer_html(self: ptr DOMElement00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setOuterHtml*(self: DOMElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_set_outer_html(cast[ptr DOMElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `outerHtml=`*(self: DOMElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_element_set_outer_html(cast[ptr DOMElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_element_set_scroll_left(self: ptr DOMElement00; value: int64) {.
    importc, libprag.}

proc setScrollLeft*(self: DOMElement; value: int64) =
  webkit_dom_element_set_scroll_left(cast[ptr DOMElement00](self.impl), value)

proc `scrollLeft=`*(self: DOMElement; value: int64) =
  webkit_dom_element_set_scroll_left(cast[ptr DOMElement00](self.impl), value)

proc webkit_dom_element_set_scroll_top(self: ptr DOMElement00; value: int64) {.
    importc, libprag.}

proc setScrollTop*(self: DOMElement; value: int64) =
  webkit_dom_element_set_scroll_top(cast[ptr DOMElement00](self.impl), value)

proc `scrollTop=`*(self: DOMElement; value: int64) =
  webkit_dom_element_set_scroll_top(cast[ptr DOMElement00](self.impl), value)

proc webkit_dom_element_webkit_matches_selector(self: ptr DOMElement00; selectors: cstring;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc webkitMatchesSelector*(self: DOMElement; selectors: cstring): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_element_webkit_matches_selector(cast[ptr DOMElement00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_element_webkit_request_fullscreen(self: ptr DOMElement00) {.
    importc, libprag.}

proc webkitRequestFullscreen*(self: DOMElement) =
  webkit_dom_element_webkit_request_fullscreen(cast[ptr DOMElement00](self.impl))

type
  DOMHTMLElement* = ref object of DOMElement
  DOMHTMLElement00* = object of DOMElement00

proc webkit_dom_html_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_element_click(self: ptr DOMHTMLElement00) {.
    importc, libprag.}

proc click*(self: DOMHTMLElement) =
  webkit_dom_html_element_click(cast[ptr DOMHTMLElement00](self.impl))

proc webkit_dom_html_element_get_access_key(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getAccessKey*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_access_key(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc accessKey*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_access_key(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_children(self: ptr DOMHTMLElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getChildren*(self: DOMHTMLElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_element_get_children(cast[ptr DOMHTMLElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc children*(self: DOMHTMLElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_element_get_children(cast[ptr DOMHTMLElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_element_get_content_editable(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getContentEditable*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_content_editable(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc contentEditable*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_content_editable(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_dir(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getDir*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_dir(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc dir*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_dir(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_draggable(self: ptr DOMHTMLElement00): gboolean {.
    importc, libprag.}

proc getDraggable*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_draggable(cast[ptr DOMHTMLElement00](self.impl)))

proc draggable*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_draggable(cast[ptr DOMHTMLElement00](self.impl)))

proc webkit_dom_html_element_get_hidden(self: ptr DOMHTMLElement00): gboolean {.
    importc, libprag.}

proc getHidden*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_hidden(cast[ptr DOMHTMLElement00](self.impl)))

proc hidden*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_hidden(cast[ptr DOMHTMLElement00](self.impl)))

proc webkit_dom_html_element_get_inner_html(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getInnerHtml*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_inner_html(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc innerHtml*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_inner_html(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_inner_text(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getInnerText*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_inner_text(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc innerText*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_inner_text(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_is_content_editable(self: ptr DOMHTMLElement00): gboolean {.
    importc, libprag.}

proc getIsContentEditable*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_is_content_editable(cast[ptr DOMHTMLElement00](self.impl)))

proc isContentEditable*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_is_content_editable(cast[ptr DOMHTMLElement00](self.impl)))

proc webkit_dom_html_element_get_lang(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getLang*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_lang(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc lang*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_lang(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_outer_html(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getOuterHtml*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_outer_html(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc outerHtml*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_outer_html(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_outer_text(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getOuterText*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_outer_text(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc outerText*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_outer_text(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_spellcheck(self: ptr DOMHTMLElement00): gboolean {.
    importc, libprag.}

proc getSpellcheck*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_spellcheck(cast[ptr DOMHTMLElement00](self.impl)))

proc spellcheck*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_spellcheck(cast[ptr DOMHTMLElement00](self.impl)))

proc webkit_dom_html_element_get_tab_index(self: ptr DOMHTMLElement00): int64 {.
    importc, libprag.}

proc getTabIndex*(self: DOMHTMLElement): int64 =
  webkit_dom_html_element_get_tab_index(cast[ptr DOMHTMLElement00](self.impl))

proc tabIndex*(self: DOMHTMLElement): int64 =
  webkit_dom_html_element_get_tab_index(cast[ptr DOMHTMLElement00](self.impl))

proc webkit_dom_html_element_get_title(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getTitle*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_title(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc title*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_title(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_get_translate(self: ptr DOMHTMLElement00): gboolean {.
    importc, libprag.}

proc getTranslate*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_translate(cast[ptr DOMHTMLElement00](self.impl)))

proc translate*(self: DOMHTMLElement): bool =
  toBool(webkit_dom_html_element_get_translate(cast[ptr DOMHTMLElement00](self.impl)))

proc webkit_dom_html_element_get_webkitdropzone(self: ptr DOMHTMLElement00): cstring {.
    importc, libprag.}

proc getWebkitdropzone*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_webkitdropzone(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkitdropzone*(self: DOMHTMLElement): string =
  let resul0 = webkit_dom_html_element_get_webkitdropzone(cast[ptr DOMHTMLElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_element_set_access_key(self: ptr DOMHTMLElement00; value: cstring) {.
    importc, libprag.}

proc setAccessKey*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_access_key(cast[ptr DOMHTMLElement00](self.impl), value)

proc `accessKey=`*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_access_key(cast[ptr DOMHTMLElement00](self.impl), value)

proc webkit_dom_html_element_set_content_editable(self: ptr DOMHTMLElement00;
    value: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setContentEditable*(self: DOMHTMLElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_content_editable(cast[ptr DOMHTMLElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `contentEditable=`*(self: DOMHTMLElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_content_editable(cast[ptr DOMHTMLElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_element_set_dir(self: ptr DOMHTMLElement00; value: cstring) {.
    importc, libprag.}

proc setDir*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_dir(cast[ptr DOMHTMLElement00](self.impl), value)

proc `dir=`*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_dir(cast[ptr DOMHTMLElement00](self.impl), value)

proc webkit_dom_html_element_set_draggable(self: ptr DOMHTMLElement00; value: gboolean) {.
    importc, libprag.}

proc setDraggable*(self: DOMHTMLElement; value: bool = true) =
  webkit_dom_html_element_set_draggable(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc `draggable=`*(self: DOMHTMLElement; value: bool) =
  webkit_dom_html_element_set_draggable(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc webkit_dom_html_element_set_hidden(self: ptr DOMHTMLElement00; value: gboolean) {.
    importc, libprag.}

proc setHidden*(self: DOMHTMLElement; value: bool = true) =
  webkit_dom_html_element_set_hidden(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc `hidden=`*(self: DOMHTMLElement; value: bool) =
  webkit_dom_html_element_set_hidden(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc webkit_dom_html_element_set_inner_html(self: ptr DOMHTMLElement00; contents: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setInnerHtml*(self: DOMHTMLElement; contents: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_inner_html(cast[ptr DOMHTMLElement00](self.impl), contents, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `innerHtml=`*(self: DOMHTMLElement; contents: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_inner_html(cast[ptr DOMHTMLElement00](self.impl), contents, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_element_set_inner_text(self: ptr DOMHTMLElement00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setInnerText*(self: DOMHTMLElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_inner_text(cast[ptr DOMHTMLElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `innerText=`*(self: DOMHTMLElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_inner_text(cast[ptr DOMHTMLElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_element_set_lang(self: ptr DOMHTMLElement00; value: cstring) {.
    importc, libprag.}

proc setLang*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_lang(cast[ptr DOMHTMLElement00](self.impl), value)

proc `lang=`*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_lang(cast[ptr DOMHTMLElement00](self.impl), value)

proc webkit_dom_html_element_set_outer_html(self: ptr DOMHTMLElement00; contents: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setOuterHtml*(self: DOMHTMLElement; contents: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_outer_html(cast[ptr DOMHTMLElement00](self.impl), contents, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `outerHtml=`*(self: DOMHTMLElement; contents: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_outer_html(cast[ptr DOMHTMLElement00](self.impl), contents, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_element_set_outer_text(self: ptr DOMHTMLElement00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setOuterText*(self: DOMHTMLElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_outer_text(cast[ptr DOMHTMLElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `outerText=`*(self: DOMHTMLElement; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_html_element_set_outer_text(cast[ptr DOMHTMLElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_element_set_spellcheck(self: ptr DOMHTMLElement00; value: gboolean) {.
    importc, libprag.}

proc setSpellcheck*(self: DOMHTMLElement; value: bool = true) =
  webkit_dom_html_element_set_spellcheck(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc `spellcheck=`*(self: DOMHTMLElement; value: bool) =
  webkit_dom_html_element_set_spellcheck(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc webkit_dom_html_element_set_tab_index(self: ptr DOMHTMLElement00; value: int64) {.
    importc, libprag.}

proc setTabIndex*(self: DOMHTMLElement; value: int64) =
  webkit_dom_html_element_set_tab_index(cast[ptr DOMHTMLElement00](self.impl), value)

proc `tabIndex=`*(self: DOMHTMLElement; value: int64) =
  webkit_dom_html_element_set_tab_index(cast[ptr DOMHTMLElement00](self.impl), value)

proc webkit_dom_html_element_set_title(self: ptr DOMHTMLElement00; value: cstring) {.
    importc, libprag.}

proc setTitle*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_title(cast[ptr DOMHTMLElement00](self.impl), value)

proc `title=`*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_title(cast[ptr DOMHTMLElement00](self.impl), value)

proc webkit_dom_html_element_set_translate(self: ptr DOMHTMLElement00; value: gboolean) {.
    importc, libprag.}

proc setTranslate*(self: DOMHTMLElement; value: bool = true) =
  webkit_dom_html_element_set_translate(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc `translate=`*(self: DOMHTMLElement; value: bool) =
  webkit_dom_html_element_set_translate(cast[ptr DOMHTMLElement00](self.impl), gboolean(value))

proc webkit_dom_html_element_set_webkitdropzone(self: ptr DOMHTMLElement00;
    value: cstring) {.
    importc, libprag.}

proc setWebkitdropzone*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_webkitdropzone(cast[ptr DOMHTMLElement00](self.impl), value)

proc `webkitdropzone=`*(self: DOMHTMLElement; value: cstring) =
  webkit_dom_html_element_set_webkitdropzone(cast[ptr DOMHTMLElement00](self.impl), value)

type
  DOMHTMLHeadElement* = ref object of DOMHTMLElement
  DOMHTMLHeadElement00* = object of DOMHTMLElement00

proc webkit_dom_html_head_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLHeadElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_head_element_get_profile(self: ptr DOMHTMLHeadElement00): cstring {.
    importc, libprag.}

proc getProfile*(self: DOMHTMLHeadElement): string =
  let resul0 = webkit_dom_html_head_element_get_profile(cast[ptr DOMHTMLHeadElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc profile*(self: DOMHTMLHeadElement): string =
  let resul0 = webkit_dom_html_head_element_get_profile(cast[ptr DOMHTMLHeadElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_head_element_set_profile(self: ptr DOMHTMLHeadElement00;
    value: cstring) {.
    importc, libprag.}

proc setProfile*(self: DOMHTMLHeadElement; value: cstring) =
  webkit_dom_html_head_element_set_profile(cast[ptr DOMHTMLHeadElement00](self.impl), value)

proc `profile=`*(self: DOMHTMLHeadElement; value: cstring) =
  webkit_dom_html_head_element_set_profile(cast[ptr DOMHTMLHeadElement00](self.impl), value)

type
  DOMHTMLScriptElement* = ref object of DOMHTMLElement
  DOMHTMLScriptElement00* = object of DOMHTMLElement00

proc webkit_dom_html_script_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLScriptElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_script_element_get_charset(self: ptr DOMHTMLScriptElement00): cstring {.
    importc, libprag.}

proc getCharset*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_charset(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc charset*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_charset(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_script_element_get_defer(self: ptr DOMHTMLScriptElement00): gboolean {.
    importc, libprag.}

proc getDefer*(self: DOMHTMLScriptElement): bool =
  toBool(webkit_dom_html_script_element_get_defer(cast[ptr DOMHTMLScriptElement00](self.impl)))

proc webkit_dom_html_script_element_get_event(self: ptr DOMHTMLScriptElement00): cstring {.
    importc, libprag.}

proc getEvent*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_event(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc event*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_event(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_script_element_get_html_for(self: ptr DOMHTMLScriptElement00): cstring {.
    importc, libprag.}

proc getHtmlFor*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_html_for(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc htmlFor*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_html_for(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_script_element_get_src(self: ptr DOMHTMLScriptElement00): cstring {.
    importc, libprag.}

proc getSrc*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_src(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc src*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_src(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_script_element_get_text(self: ptr DOMHTMLScriptElement00): cstring {.
    importc, libprag.}

proc getText*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_text(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_text(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_script_element_get_type_attr(self: ptr DOMHTMLScriptElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_type_attr(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLScriptElement): string =
  let resul0 = webkit_dom_html_script_element_get_type_attr(cast[ptr DOMHTMLScriptElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_script_element_set_charset(self: ptr DOMHTMLScriptElement00;
    value: cstring) {.
    importc, libprag.}

proc setCharset*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_charset(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc `charset=`*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_charset(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc webkit_dom_html_script_element_set_defer(self: ptr DOMHTMLScriptElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDefer*(self: DOMHTMLScriptElement;
    value: bool = true) =
  webkit_dom_html_script_element_set_defer(cast[ptr DOMHTMLScriptElement00](self.impl), gboolean(value))

proc `defer=`*(self: DOMHTMLScriptElement;
    value: bool) =
  webkit_dom_html_script_element_set_defer(cast[ptr DOMHTMLScriptElement00](self.impl), gboolean(value))

proc webkit_dom_html_script_element_set_event(self: ptr DOMHTMLScriptElement00;
    value: cstring) {.
    importc, libprag.}

proc setEvent*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_event(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc `event=`*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_event(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc webkit_dom_html_script_element_set_html_for(self: ptr DOMHTMLScriptElement00;
    value: cstring) {.
    importc, libprag.}

proc setHtmlFor*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_html_for(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc `htmlFor=`*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_html_for(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc webkit_dom_html_script_element_set_src(self: ptr DOMHTMLScriptElement00;
    value: cstring) {.
    importc, libprag.}

proc setSrc*(self: DOMHTMLScriptElement; value: cstring) =
  webkit_dom_html_script_element_set_src(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc `src=`*(self: DOMHTMLScriptElement; value: cstring) =
  webkit_dom_html_script_element_set_src(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc webkit_dom_html_script_element_set_text(self: ptr DOMHTMLScriptElement00;
    value: cstring) {.
    importc, libprag.}

proc setText*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_text(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc `text=`*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_text(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc webkit_dom_html_script_element_set_type_attr(self: ptr DOMHTMLScriptElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_type_attr(cast[ptr DOMHTMLScriptElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLScriptElement;
    value: cstring) =
  webkit_dom_html_script_element_set_type_attr(cast[ptr DOMHTMLScriptElement00](self.impl), value)

type
  DOMHTMLFrameSetElement* = ref object of DOMHTMLElement
  DOMHTMLFrameSetElement00* = object of DOMHTMLElement00

proc webkit_dom_html_frame_set_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLFrameSetElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_frame_set_element_get_cols(self: ptr DOMHTMLFrameSetElement00): cstring {.
    importc, libprag.}

proc getCols*(self: DOMHTMLFrameSetElement): string =
  let resul0 = webkit_dom_html_frame_set_element_get_cols(cast[ptr DOMHTMLFrameSetElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cols*(self: DOMHTMLFrameSetElement): string =
  let resul0 = webkit_dom_html_frame_set_element_get_cols(cast[ptr DOMHTMLFrameSetElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_set_element_get_rows(self: ptr DOMHTMLFrameSetElement00): cstring {.
    importc, libprag.}

proc getRows*(self: DOMHTMLFrameSetElement): string =
  let resul0 = webkit_dom_html_frame_set_element_get_rows(cast[ptr DOMHTMLFrameSetElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc rows*(self: DOMHTMLFrameSetElement): string =
  let resul0 = webkit_dom_html_frame_set_element_get_rows(cast[ptr DOMHTMLFrameSetElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_set_element_set_cols(self: ptr DOMHTMLFrameSetElement00;
    value: cstring) {.
    importc, libprag.}

proc setCols*(self: DOMHTMLFrameSetElement;
    value: cstring) =
  webkit_dom_html_frame_set_element_set_cols(cast[ptr DOMHTMLFrameSetElement00](self.impl), value)

proc `cols=`*(self: DOMHTMLFrameSetElement;
    value: cstring) =
  webkit_dom_html_frame_set_element_set_cols(cast[ptr DOMHTMLFrameSetElement00](self.impl), value)

proc webkit_dom_html_frame_set_element_set_rows(self: ptr DOMHTMLFrameSetElement00;
    value: cstring) {.
    importc, libprag.}

proc setRows*(self: DOMHTMLFrameSetElement;
    value: cstring) =
  webkit_dom_html_frame_set_element_set_rows(cast[ptr DOMHTMLFrameSetElement00](self.impl), value)

proc `rows=`*(self: DOMHTMLFrameSetElement;
    value: cstring) =
  webkit_dom_html_frame_set_element_set_rows(cast[ptr DOMHTMLFrameSetElement00](self.impl), value)

proc webkit_dom_node_get_parent_element(self: ptr DOMNode00): ptr DOMElement00 {.
    importc, libprag.}

proc getParentElement*(self: DOMNode): DOMElement =
  let gobj = webkit_dom_node_get_parent_element(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc parentElement*(self: DOMNode): DOMElement =
  let gobj = webkit_dom_node_get_parent_element(cast[ptr DOMNode00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_attr_get_owner_element(self: ptr DOMAttr00): ptr DOMElement00 {.
    importc, libprag.}

proc getOwnerElement*(self: DOMAttr): DOMElement =
  let gobj = webkit_dom_attr_get_owner_element(cast[ptr DOMAttr00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc ownerElement*(self: DOMAttr): DOMElement =
  let gobj = webkit_dom_attr_get_owner_element(cast[ptr DOMAttr00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_element(self: ptr DOMDocument00; tagName: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMElement00 {.
    importc, libprag.}

proc createElement*(self: DOMDocument; tagName: cstring): DOMElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_element(cast[ptr DOMDocument00](self.impl), tagName, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_create_element_ns(self: ptr DOMDocument00; namespaceURI: cstring;
    qualifiedName: cstring; error: ptr ptr glib.Error = nil): ptr DOMElement00 {.
    importc, libprag.}

proc createElementNs*(self: DOMDocument; namespaceURI: cstring = nil;
    qualifiedName: cstring): DOMElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_create_element_ns(cast[ptr DOMDocument00](self.impl), namespaceURI, qualifiedName, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_element_from_point(self: ptr DOMDocument00; x: int64;
    y: int64): ptr DOMElement00 {.
    importc, libprag.}

proc elementFromPoint*(self: DOMDocument; x: int64;
    y: int64): DOMElement =
  let gobj = webkit_dom_document_element_from_point(cast[ptr DOMDocument00](self.impl), x, y)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_active_element(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getActiveElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_active_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc activeElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_active_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_body(self: ptr DOMDocument00): ptr DOMHTMLElement00 {.
    importc, libprag.}

proc getBody*(self: DOMDocument): DOMHTMLElement =
  let gobj = webkit_dom_document_get_body(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc body*(self: DOMDocument): DOMHTMLElement =
  let gobj = webkit_dom_document_get_body(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_current_script(self: ptr DOMDocument00): ptr DOMHTMLScriptElement00 {.
    importc, libprag.}

proc getCurrentScript*(self: DOMDocument): DOMHTMLScriptElement =
  let gobj = webkit_dom_document_get_current_script(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc currentScript*(self: DOMDocument): DOMHTMLScriptElement =
  let gobj = webkit_dom_document_get_current_script(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_document_element(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getDocumentElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_document_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc documentElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_document_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_element_by_id(self: ptr DOMDocument00; elementId: cstring): ptr DOMElement00 {.
    importc, libprag.}

proc getElementById*(self: DOMDocument; elementId: cstring): DOMElement =
  let gobj = webkit_dom_document_get_element_by_id(cast[ptr DOMDocument00](self.impl), elementId)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_first_element_child(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getFirstElementChild*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_first_element_child(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc firstElementChild*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_first_element_child(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_head(self: ptr DOMDocument00): ptr DOMHTMLHeadElement00 {.
    importc, libprag.}

proc getHead*(self: DOMDocument): DOMHTMLHeadElement =
  let gobj = webkit_dom_document_get_head(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc head*(self: DOMDocument): DOMHTMLHeadElement =
  let gobj = webkit_dom_document_get_head(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_last_element_child(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getLastElementChild*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_last_element_child(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc lastElementChild*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_last_element_child(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_override_style(self: ptr DOMDocument00; element: ptr DOMElement00;
    pseudoElement: cstring): ptr DOMCSSStyleDeclaration00 {.
    importc, libprag.}

proc getOverrideStyle*(self: DOMDocument; element: DOMElement;
    pseudoElement: cstring = nil): DOMCSSStyleDeclaration =
  let gobj = webkit_dom_document_get_override_style(cast[ptr DOMDocument00](self.impl), cast[ptr DOMElement00](element.impl), pseudoElement)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_pointer_lock_element(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getPointerLockElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_pointer_lock_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pointerLockElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_pointer_lock_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_scrolling_element(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getScrollingElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_scrolling_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc scrollingElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_scrolling_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_webkit_current_fullscreen_element(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getWebkitCurrentFullscreenElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_webkit_current_fullscreen_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkitCurrentFullscreenElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_webkit_current_fullscreen_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_get_webkit_fullscreen_element(self: ptr DOMDocument00): ptr DOMElement00 {.
    importc, libprag.}

proc getWebkitFullscreenElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_webkit_fullscreen_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkitFullscreenElement*(self: DOMDocument): DOMElement =
  let gobj = webkit_dom_document_get_webkit_fullscreen_element(cast[ptr DOMDocument00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_query_selector(self: ptr DOMDocument00; selectors: cstring;
    error: ptr ptr glib.Error = nil): ptr DOMElement00 {.
    importc, libprag.}

proc querySelector*(self: DOMDocument; selectors: cstring): DOMElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_query_selector(cast[ptr DOMDocument00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_set_body(self: ptr DOMDocument00; value: ptr DOMHTMLElement00;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setBody*(self: DOMDocument; value: DOMHTMLElement) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_body(cast[ptr DOMDocument00](self.impl), cast[ptr DOMHTMLElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `body=`*(self: DOMDocument; value: DOMHTMLElement) =
  var gerror: ptr glib.Error
  webkit_dom_document_set_body(cast[ptr DOMDocument00](self.impl), cast[ptr DOMHTMLElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_document_fragment_get_element_by_id(self: ptr DOMDocumentFragment00;
    elementId: cstring): ptr DOMElement00 {.
    importc, libprag.}

proc getElementById*(self: DOMDocumentFragment;
    elementId: cstring): DOMElement =
  let gobj = webkit_dom_document_fragment_get_element_by_id(cast[ptr DOMDocumentFragment00](self.impl), elementId)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_fragment_get_first_element_child(self: ptr DOMDocumentFragment00): ptr DOMElement00 {.
    importc, libprag.}

proc getFirstElementChild*(self: DOMDocumentFragment): DOMElement =
  let gobj = webkit_dom_document_fragment_get_first_element_child(cast[ptr DOMDocumentFragment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc firstElementChild*(self: DOMDocumentFragment): DOMElement =
  let gobj = webkit_dom_document_fragment_get_first_element_child(cast[ptr DOMDocumentFragment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_fragment_get_last_element_child(self: ptr DOMDocumentFragment00): ptr DOMElement00 {.
    importc, libprag.}

proc getLastElementChild*(self: DOMDocumentFragment): DOMElement =
  let gobj = webkit_dom_document_fragment_get_last_element_child(cast[ptr DOMDocumentFragment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc lastElementChild*(self: DOMDocumentFragment): DOMElement =
  let gobj = webkit_dom_document_fragment_get_last_element_child(cast[ptr DOMDocumentFragment00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_document_fragment_query_selector(self: ptr DOMDocumentFragment00;
    selectors: cstring; error: ptr ptr glib.Error = nil): ptr DOMElement00 {.
    importc, libprag.}

proc querySelector*(self: DOMDocumentFragment;
    selectors: cstring): DOMElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_document_fragment_query_selector(cast[ptr DOMDocumentFragment00](self.impl), selectors, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_computed_style(self: ptr DOMDOMWindow00; element: ptr DOMElement00;
    pseudoElement: cstring): ptr DOMCSSStyleDeclaration00 {.
    importc, libprag.}

proc getComputedStyle*(self: DOMDOMWindow; element: DOMElement;
    pseudoElement: cstring = nil): DOMCSSStyleDeclaration =
  let gobj = webkit_dom_dom_window_get_computed_style(cast[ptr DOMDOMWindow00](self.impl), cast[ptr DOMElement00](element.impl), pseudoElement)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_dom_window_get_frame_element(self: ptr DOMDOMWindow00): ptr DOMElement00 {.
    importc, libprag.}

proc getFrameElement*(self: DOMDOMWindow): DOMElement =
  let gobj = webkit_dom_dom_window_get_frame_element(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc frameElement*(self: DOMDOMWindow): DOMElement =
  let gobj = webkit_dom_dom_window_get_frame_element(cast[ptr DOMDOMWindow00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMHTMLParamElement* = ref object of DOMHTMLElement
  DOMHTMLParamElement00* = object of DOMHTMLElement00

proc webkit_dom_html_param_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLParamElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_param_element_get_name(self: ptr DOMHTMLParamElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_name(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_name(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_param_element_get_type_attr(self: ptr DOMHTMLParamElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_type_attr(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_type_attr(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_param_element_get_value(self: ptr DOMHTMLParamElement00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_value(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_value(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_param_element_get_value_type(self: ptr DOMHTMLParamElement00): cstring {.
    importc, libprag.}

proc getValueType*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_value_type(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc valueType*(self: DOMHTMLParamElement): string =
  let resul0 = webkit_dom_html_param_element_get_value_type(cast[ptr DOMHTMLParamElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_param_element_set_name(self: ptr DOMHTMLParamElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLParamElement; value: cstring) =
  webkit_dom_html_param_element_set_name(cast[ptr DOMHTMLParamElement00](self.impl), value)

proc `name=`*(self: DOMHTMLParamElement; value: cstring) =
  webkit_dom_html_param_element_set_name(cast[ptr DOMHTMLParamElement00](self.impl), value)

proc webkit_dom_html_param_element_set_type_attr(self: ptr DOMHTMLParamElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLParamElement;
    value: cstring) =
  webkit_dom_html_param_element_set_type_attr(cast[ptr DOMHTMLParamElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLParamElement;
    value: cstring) =
  webkit_dom_html_param_element_set_type_attr(cast[ptr DOMHTMLParamElement00](self.impl), value)

proc webkit_dom_html_param_element_set_value(self: ptr DOMHTMLParamElement00;
    value: cstring) {.
    importc, libprag.}

proc setValue*(self: DOMHTMLParamElement; value: cstring) =
  webkit_dom_html_param_element_set_value(cast[ptr DOMHTMLParamElement00](self.impl), value)

proc `value=`*(self: DOMHTMLParamElement; value: cstring) =
  webkit_dom_html_param_element_set_value(cast[ptr DOMHTMLParamElement00](self.impl), value)

proc webkit_dom_html_param_element_set_value_type(self: ptr DOMHTMLParamElement00;
    value: cstring) {.
    importc, libprag.}

proc setValueType*(self: DOMHTMLParamElement;
    value: cstring) =
  webkit_dom_html_param_element_set_value_type(cast[ptr DOMHTMLParamElement00](self.impl), value)

proc `valueType=`*(self: DOMHTMLParamElement;
    value: cstring) =
  webkit_dom_html_param_element_set_value_type(cast[ptr DOMHTMLParamElement00](self.impl), value)

type
  DOMHTMLMenuElement* = ref object of DOMHTMLElement
  DOMHTMLMenuElement00* = object of DOMHTMLElement00

proc webkit_dom_html_menu_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLMenuElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_menu_element_get_compact(self: ptr DOMHTMLMenuElement00): gboolean {.
    importc, libprag.}

proc getCompact*(self: DOMHTMLMenuElement): bool =
  toBool(webkit_dom_html_menu_element_get_compact(cast[ptr DOMHTMLMenuElement00](self.impl)))

proc compact*(self: DOMHTMLMenuElement): bool =
  toBool(webkit_dom_html_menu_element_get_compact(cast[ptr DOMHTMLMenuElement00](self.impl)))

proc webkit_dom_html_menu_element_set_compact(self: ptr DOMHTMLMenuElement00;
    value: gboolean) {.
    importc, libprag.}

proc setCompact*(self: DOMHTMLMenuElement; value: bool = true) =
  webkit_dom_html_menu_element_set_compact(cast[ptr DOMHTMLMenuElement00](self.impl), gboolean(value))

proc `compact=`*(self: DOMHTMLMenuElement; value: bool) =
  webkit_dom_html_menu_element_set_compact(cast[ptr DOMHTMLMenuElement00](self.impl), gboolean(value))

type
  DOMHTMLObjectElement* = ref object of DOMHTMLElement
  DOMHTMLObjectElement00* = object of DOMHTMLElement00

proc webkit_dom_html_object_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLObjectElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_object_element_get_align(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_align(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_align(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_archive(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getArchive*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_archive(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc archive*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_archive(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_border(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getBorder*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_border(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc border*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_border(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_code(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getCode*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_code(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc code*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_code(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_code_base(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getCodeBase*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_code_base(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc codeBase*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_code_base(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_code_type(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getCodeType*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_code_type(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc codeType*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_code_type(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_content_document(self: ptr DOMHTMLObjectElement00): ptr DOMDocument00 {.
    importc, libprag.}

proc getContentDocument*(self: DOMHTMLObjectElement): DOMDocument =
  let gobj = webkit_dom_html_object_element_get_content_document(cast[ptr DOMHTMLObjectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc contentDocument*(self: DOMHTMLObjectElement): DOMDocument =
  let gobj = webkit_dom_html_object_element_get_content_document(cast[ptr DOMHTMLObjectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_object_element_get_data(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getData*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_data(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc data*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_data(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_declare(self: ptr DOMHTMLObjectElement00): gboolean {.
    importc, libprag.}

proc getDeclare*(self: DOMHTMLObjectElement): bool =
  toBool(webkit_dom_html_object_element_get_declare(cast[ptr DOMHTMLObjectElement00](self.impl)))

proc declare*(self: DOMHTMLObjectElement): bool =
  toBool(webkit_dom_html_object_element_get_declare(cast[ptr DOMHTMLObjectElement00](self.impl)))

proc webkit_dom_html_object_element_get_height(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_height(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc height*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_height(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_hspace(self: ptr DOMHTMLObjectElement00): int64 {.
    importc, libprag.}

proc getHspace*(self: DOMHTMLObjectElement): int64 =
  webkit_dom_html_object_element_get_hspace(cast[ptr DOMHTMLObjectElement00](self.impl))

proc hspace*(self: DOMHTMLObjectElement): int64 =
  webkit_dom_html_object_element_get_hspace(cast[ptr DOMHTMLObjectElement00](self.impl))

proc webkit_dom_html_object_element_get_name(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_name(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_name(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_standby(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getStandby*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_standby(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc standby*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_standby(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_type_attr(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_type_attr(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_type_attr(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_use_map(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getUseMap*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_use_map(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc useMap*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_use_map(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_get_vspace(self: ptr DOMHTMLObjectElement00): int64 {.
    importc, libprag.}

proc getVspace*(self: DOMHTMLObjectElement): int64 =
  webkit_dom_html_object_element_get_vspace(cast[ptr DOMHTMLObjectElement00](self.impl))

proc vspace*(self: DOMHTMLObjectElement): int64 =
  webkit_dom_html_object_element_get_vspace(cast[ptr DOMHTMLObjectElement00](self.impl))

proc webkit_dom_html_object_element_get_width(self: ptr DOMHTMLObjectElement00): cstring {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_width(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc width*(self: DOMHTMLObjectElement): string =
  let resul0 = webkit_dom_html_object_element_get_width(cast[ptr DOMHTMLObjectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_object_element_set_align(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_align(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `align=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_align(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_archive(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setArchive*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_archive(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `archive=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_archive(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_border(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setBorder*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_border(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `border=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_border(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_code(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setCode*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_code(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `code=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_code(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_code_base(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setCodeBase*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_code_base(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `codeBase=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_code_base(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_code_type(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setCodeType*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_code_type(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `codeType=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_code_type(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_data(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setData*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_data(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `data=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_data(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_declare(self: ptr DOMHTMLObjectElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDeclare*(self: DOMHTMLObjectElement;
    value: bool = true) =
  webkit_dom_html_object_element_set_declare(cast[ptr DOMHTMLObjectElement00](self.impl), gboolean(value))

proc `declare=`*(self: DOMHTMLObjectElement;
    value: bool) =
  webkit_dom_html_object_element_set_declare(cast[ptr DOMHTMLObjectElement00](self.impl), gboolean(value))

proc webkit_dom_html_object_element_set_height(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_height(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `height=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_height(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_hspace(self: ptr DOMHTMLObjectElement00;
    value: int64) {.
    importc, libprag.}

proc setHspace*(self: DOMHTMLObjectElement;
    value: int64) =
  webkit_dom_html_object_element_set_hspace(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `hspace=`*(self: DOMHTMLObjectElement;
    value: int64) =
  webkit_dom_html_object_element_set_hspace(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_name(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_name(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `name=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_name(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_standby(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setStandby*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_standby(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `standby=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_standby(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_type_attr(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_type_attr(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_type_attr(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_use_map(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setUseMap*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_use_map(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `useMap=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_use_map(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_vspace(self: ptr DOMHTMLObjectElement00;
    value: int64) {.
    importc, libprag.}

proc setVspace*(self: DOMHTMLObjectElement;
    value: int64) =
  webkit_dom_html_object_element_set_vspace(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `vspace=`*(self: DOMHTMLObjectElement;
    value: int64) =
  webkit_dom_html_object_element_set_vspace(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc webkit_dom_html_object_element_set_width(self: ptr DOMHTMLObjectElement00;
    value: cstring) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_width(cast[ptr DOMHTMLObjectElement00](self.impl), value)

proc `width=`*(self: DOMHTMLObjectElement;
    value: cstring) =
  webkit_dom_html_object_element_set_width(cast[ptr DOMHTMLObjectElement00](self.impl), value)

type
  DOMHTMLTableCaptionElement* = ref object of DOMHTMLElement
  DOMHTMLTableCaptionElement00* = object of DOMHTMLElement00

proc webkit_dom_html_table_caption_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTableCaptionElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_table_caption_element_get_align(self: ptr DOMHTMLTableCaptionElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLTableCaptionElement): string =
  let resul0 = webkit_dom_html_table_caption_element_get_align(cast[ptr DOMHTMLTableCaptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLTableCaptionElement): string =
  let resul0 = webkit_dom_html_table_caption_element_get_align(cast[ptr DOMHTMLTableCaptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_caption_element_set_align(self: ptr DOMHTMLTableCaptionElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLTableCaptionElement;
    value: cstring) =
  webkit_dom_html_table_caption_element_set_align(cast[ptr DOMHTMLTableCaptionElement00](self.impl), value)

proc `align=`*(self: DOMHTMLTableCaptionElement;
    value: cstring) =
  webkit_dom_html_table_caption_element_set_align(cast[ptr DOMHTMLTableCaptionElement00](self.impl), value)

type
  DOMHTMLBodyElement* = ref object of DOMHTMLElement
  DOMHTMLBodyElement00* = object of DOMHTMLElement00

proc webkit_dom_html_body_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLBodyElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_body_element_get_a_link(self: ptr DOMHTMLBodyElement00): cstring {.
    importc, libprag.}

proc getALink*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_a_link(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc aLink*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_a_link(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_body_element_get_background(self: ptr DOMHTMLBodyElement00): cstring {.
    importc, libprag.}

proc getBackground*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_background(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc background*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_background(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_body_element_get_bg_color(self: ptr DOMHTMLBodyElement00): cstring {.
    importc, libprag.}

proc getBgColor*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_bg_color(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc bgColor*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_bg_color(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_body_element_get_link(self: ptr DOMHTMLBodyElement00): cstring {.
    importc, libprag.}

proc getLink*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_link(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc link*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_link(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_body_element_get_text(self: ptr DOMHTMLBodyElement00): cstring {.
    importc, libprag.}

proc getText*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_text(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_text(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_body_element_get_v_link(self: ptr DOMHTMLBodyElement00): cstring {.
    importc, libprag.}

proc getVLink*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_v_link(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc vLink*(self: DOMHTMLBodyElement): string =
  let resul0 = webkit_dom_html_body_element_get_v_link(cast[ptr DOMHTMLBodyElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_body_element_set_a_link(self: ptr DOMHTMLBodyElement00;
    value: cstring) {.
    importc, libprag.}

proc setALink*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_a_link(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc `aLink=`*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_a_link(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc webkit_dom_html_body_element_set_background(self: ptr DOMHTMLBodyElement00;
    value: cstring) {.
    importc, libprag.}

proc setBackground*(self: DOMHTMLBodyElement;
    value: cstring) =
  webkit_dom_html_body_element_set_background(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc `background=`*(self: DOMHTMLBodyElement;
    value: cstring) =
  webkit_dom_html_body_element_set_background(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc webkit_dom_html_body_element_set_bg_color(self: ptr DOMHTMLBodyElement00;
    value: cstring) {.
    importc, libprag.}

proc setBgColor*(self: DOMHTMLBodyElement;
    value: cstring) =
  webkit_dom_html_body_element_set_bg_color(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc `bgColor=`*(self: DOMHTMLBodyElement;
    value: cstring) =
  webkit_dom_html_body_element_set_bg_color(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc webkit_dom_html_body_element_set_link(self: ptr DOMHTMLBodyElement00;
    value: cstring) {.
    importc, libprag.}

proc setLink*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_link(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc `link=`*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_link(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc webkit_dom_html_body_element_set_text(self: ptr DOMHTMLBodyElement00;
    value: cstring) {.
    importc, libprag.}

proc setText*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_text(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc `text=`*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_text(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc webkit_dom_html_body_element_set_v_link(self: ptr DOMHTMLBodyElement00;
    value: cstring) {.
    importc, libprag.}

proc setVLink*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_v_link(cast[ptr DOMHTMLBodyElement00](self.impl), value)

proc `vLink=`*(self: DOMHTMLBodyElement; value: cstring) =
  webkit_dom_html_body_element_set_v_link(cast[ptr DOMHTMLBodyElement00](self.impl), value)

type
  DOMHTMLEmbedElement* = ref object of DOMHTMLElement
  DOMHTMLEmbedElement00* = object of DOMHTMLElement00

proc webkit_dom_html_embed_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLEmbedElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_embed_element_get_align(self: ptr DOMHTMLEmbedElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_align(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_align(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_embed_element_get_height(self: ptr DOMHTMLEmbedElement00): int64 {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLEmbedElement): int64 =
  webkit_dom_html_embed_element_get_height(cast[ptr DOMHTMLEmbedElement00](self.impl))

proc height*(self: DOMHTMLEmbedElement): int64 =
  webkit_dom_html_embed_element_get_height(cast[ptr DOMHTMLEmbedElement00](self.impl))

proc webkit_dom_html_embed_element_get_name(self: ptr DOMHTMLEmbedElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_name(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_name(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_embed_element_get_src(self: ptr DOMHTMLEmbedElement00): cstring {.
    importc, libprag.}

proc getSrc*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_src(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc src*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_src(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_embed_element_get_type_attr(self: ptr DOMHTMLEmbedElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_type_attr(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLEmbedElement): string =
  let resul0 = webkit_dom_html_embed_element_get_type_attr(cast[ptr DOMHTMLEmbedElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_embed_element_get_width(self: ptr DOMHTMLEmbedElement00): int64 {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLEmbedElement): int64 =
  webkit_dom_html_embed_element_get_width(cast[ptr DOMHTMLEmbedElement00](self.impl))

proc width*(self: DOMHTMLEmbedElement): int64 =
  webkit_dom_html_embed_element_get_width(cast[ptr DOMHTMLEmbedElement00](self.impl))

proc webkit_dom_html_embed_element_set_align(self: ptr DOMHTMLEmbedElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLEmbedElement; value: cstring) =
  webkit_dom_html_embed_element_set_align(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc `align=`*(self: DOMHTMLEmbedElement; value: cstring) =
  webkit_dom_html_embed_element_set_align(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc webkit_dom_html_embed_element_set_height(self: ptr DOMHTMLEmbedElement00;
    value: int64) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLEmbedElement;
    value: int64) =
  webkit_dom_html_embed_element_set_height(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc `height=`*(self: DOMHTMLEmbedElement;
    value: int64) =
  webkit_dom_html_embed_element_set_height(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc webkit_dom_html_embed_element_set_name(self: ptr DOMHTMLEmbedElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLEmbedElement; value: cstring) =
  webkit_dom_html_embed_element_set_name(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc `name=`*(self: DOMHTMLEmbedElement; value: cstring) =
  webkit_dom_html_embed_element_set_name(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc webkit_dom_html_embed_element_set_src(self: ptr DOMHTMLEmbedElement00;
    value: cstring) {.
    importc, libprag.}

proc setSrc*(self: DOMHTMLEmbedElement; value: cstring) =
  webkit_dom_html_embed_element_set_src(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc `src=`*(self: DOMHTMLEmbedElement; value: cstring) =
  webkit_dom_html_embed_element_set_src(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc webkit_dom_html_embed_element_set_type_attr(self: ptr DOMHTMLEmbedElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLEmbedElement;
    value: cstring) =
  webkit_dom_html_embed_element_set_type_attr(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLEmbedElement;
    value: cstring) =
  webkit_dom_html_embed_element_set_type_attr(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc webkit_dom_html_embed_element_set_width(self: ptr DOMHTMLEmbedElement00;
    value: int64) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLEmbedElement; value: int64) =
  webkit_dom_html_embed_element_set_width(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

proc `width=`*(self: DOMHTMLEmbedElement; value: int64) =
  webkit_dom_html_embed_element_set_width(cast[ptr DOMHTMLEmbedElement00](self.impl), value)

type
  DOMHTMLHRElement* = ref object of DOMHTMLElement
  DOMHTMLHRElement00* = object of DOMHTMLElement00

proc webkit_dom_html_hr_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLHRElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_hr_element_get_align(self: ptr DOMHTMLHRElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLHRElement): string =
  let resul0 = webkit_dom_html_hr_element_get_align(cast[ptr DOMHTMLHRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLHRElement): string =
  let resul0 = webkit_dom_html_hr_element_get_align(cast[ptr DOMHTMLHRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_hr_element_get_no_shade(self: ptr DOMHTMLHRElement00): gboolean {.
    importc, libprag.}

proc getNoShade*(self: DOMHTMLHRElement): bool =
  toBool(webkit_dom_html_hr_element_get_no_shade(cast[ptr DOMHTMLHRElement00](self.impl)))

proc noShade*(self: DOMHTMLHRElement): bool =
  toBool(webkit_dom_html_hr_element_get_no_shade(cast[ptr DOMHTMLHRElement00](self.impl)))

proc webkit_dom_html_hr_element_get_size(self: ptr DOMHTMLHRElement00): cstring {.
    importc, libprag.}

proc getSize*(self: DOMHTMLHRElement): string =
  let resul0 = webkit_dom_html_hr_element_get_size(cast[ptr DOMHTMLHRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc size*(self: DOMHTMLHRElement): string =
  let resul0 = webkit_dom_html_hr_element_get_size(cast[ptr DOMHTMLHRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_hr_element_get_width(self: ptr DOMHTMLHRElement00): cstring {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLHRElement): string =
  let resul0 = webkit_dom_html_hr_element_get_width(cast[ptr DOMHTMLHRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc width*(self: DOMHTMLHRElement): string =
  let resul0 = webkit_dom_html_hr_element_get_width(cast[ptr DOMHTMLHRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_hr_element_set_align(self: ptr DOMHTMLHRElement00; value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLHRElement; value: cstring) =
  webkit_dom_html_hr_element_set_align(cast[ptr DOMHTMLHRElement00](self.impl), value)

proc `align=`*(self: DOMHTMLHRElement; value: cstring) =
  webkit_dom_html_hr_element_set_align(cast[ptr DOMHTMLHRElement00](self.impl), value)

proc webkit_dom_html_hr_element_set_no_shade(self: ptr DOMHTMLHRElement00;
    value: gboolean) {.
    importc, libprag.}

proc setNoShade*(self: DOMHTMLHRElement; value: bool = true) =
  webkit_dom_html_hr_element_set_no_shade(cast[ptr DOMHTMLHRElement00](self.impl), gboolean(value))

proc `noShade=`*(self: DOMHTMLHRElement; value: bool) =
  webkit_dom_html_hr_element_set_no_shade(cast[ptr DOMHTMLHRElement00](self.impl), gboolean(value))

proc webkit_dom_html_hr_element_set_size(self: ptr DOMHTMLHRElement00; value: cstring) {.
    importc, libprag.}

proc setSize*(self: DOMHTMLHRElement; value: cstring) =
  webkit_dom_html_hr_element_set_size(cast[ptr DOMHTMLHRElement00](self.impl), value)

proc `size=`*(self: DOMHTMLHRElement; value: cstring) =
  webkit_dom_html_hr_element_set_size(cast[ptr DOMHTMLHRElement00](self.impl), value)

proc webkit_dom_html_hr_element_set_width(self: ptr DOMHTMLHRElement00; value: cstring) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLHRElement; value: cstring) =
  webkit_dom_html_hr_element_set_width(cast[ptr DOMHTMLHRElement00](self.impl), value)

proc `width=`*(self: DOMHTMLHRElement; value: cstring) =
  webkit_dom_html_hr_element_set_width(cast[ptr DOMHTMLHRElement00](self.impl), value)

type
  DOMHTMLImageElement* = ref object of DOMHTMLElement
  DOMHTMLImageElement00* = object of DOMHTMLElement00

proc webkit_dom_html_image_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLImageElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_image_element_get_align(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_align(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_align(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_alt(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getAlt*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_alt(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc alt*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_alt(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_border(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getBorder*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_border(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc border*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_border(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_complete(self: ptr DOMHTMLImageElement00): gboolean {.
    importc, libprag.}

proc getComplete*(self: DOMHTMLImageElement): bool =
  toBool(webkit_dom_html_image_element_get_complete(cast[ptr DOMHTMLImageElement00](self.impl)))

proc complete*(self: DOMHTMLImageElement): bool =
  toBool(webkit_dom_html_image_element_get_complete(cast[ptr DOMHTMLImageElement00](self.impl)))

proc webkit_dom_html_image_element_get_height(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_height(cast[ptr DOMHTMLImageElement00](self.impl))

proc height*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_height(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_get_hspace(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getHspace*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_hspace(cast[ptr DOMHTMLImageElement00](self.impl))

proc hspace*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_hspace(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_get_is_map(self: ptr DOMHTMLImageElement00): gboolean {.
    importc, libprag.}

proc getIsMap*(self: DOMHTMLImageElement): bool =
  toBool(webkit_dom_html_image_element_get_is_map(cast[ptr DOMHTMLImageElement00](self.impl)))

proc isMap*(self: DOMHTMLImageElement): bool =
  toBool(webkit_dom_html_image_element_get_is_map(cast[ptr DOMHTMLImageElement00](self.impl)))

proc webkit_dom_html_image_element_get_long_desc(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getLongDesc*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_long_desc(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc longDesc*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_long_desc(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_lowsrc(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getLowsrc*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_lowsrc(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc lowsrc*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_lowsrc(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_name(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_name(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_name(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_natural_height(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getNaturalHeight*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_natural_height(cast[ptr DOMHTMLImageElement00](self.impl))

proc naturalHeight*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_natural_height(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_get_natural_width(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getNaturalWidth*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_natural_width(cast[ptr DOMHTMLImageElement00](self.impl))

proc naturalWidth*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_natural_width(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_get_src(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getSrc*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_src(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc src*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_src(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_use_map(self: ptr DOMHTMLImageElement00): cstring {.
    importc, libprag.}

proc getUseMap*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_use_map(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc useMap*(self: DOMHTMLImageElement): string =
  let resul0 = webkit_dom_html_image_element_get_use_map(cast[ptr DOMHTMLImageElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_image_element_get_vspace(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getVspace*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_vspace(cast[ptr DOMHTMLImageElement00](self.impl))

proc vspace*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_vspace(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_get_width(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_width(cast[ptr DOMHTMLImageElement00](self.impl))

proc width*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_width(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_get_x(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getX*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_x(cast[ptr DOMHTMLImageElement00](self.impl))

proc x*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_x(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_get_y(self: ptr DOMHTMLImageElement00): int64 {.
    importc, libprag.}

proc getY*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_y(cast[ptr DOMHTMLImageElement00](self.impl))

proc y*(self: DOMHTMLImageElement): int64 =
  webkit_dom_html_image_element_get_y(cast[ptr DOMHTMLImageElement00](self.impl))

proc webkit_dom_html_image_element_set_align(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_align(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `align=`*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_align(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_alt(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlt*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_alt(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `alt=`*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_alt(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_border(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setBorder*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_border(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `border=`*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_border(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_height(self: ptr DOMHTMLImageElement00;
    value: int64) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLImageElement;
    value: int64) =
  webkit_dom_html_image_element_set_height(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `height=`*(self: DOMHTMLImageElement;
    value: int64) =
  webkit_dom_html_image_element_set_height(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_hspace(self: ptr DOMHTMLImageElement00;
    value: int64) {.
    importc, libprag.}

proc setHspace*(self: DOMHTMLImageElement;
    value: int64) =
  webkit_dom_html_image_element_set_hspace(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `hspace=`*(self: DOMHTMLImageElement;
    value: int64) =
  webkit_dom_html_image_element_set_hspace(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_is_map(self: ptr DOMHTMLImageElement00;
    value: gboolean) {.
    importc, libprag.}

proc setIsMap*(self: DOMHTMLImageElement;
    value: bool = true) =
  webkit_dom_html_image_element_set_is_map(cast[ptr DOMHTMLImageElement00](self.impl), gboolean(value))

proc `isMap=`*(self: DOMHTMLImageElement;
    value: bool) =
  webkit_dom_html_image_element_set_is_map(cast[ptr DOMHTMLImageElement00](self.impl), gboolean(value))

proc webkit_dom_html_image_element_set_long_desc(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setLongDesc*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_long_desc(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `longDesc=`*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_long_desc(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_lowsrc(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setLowsrc*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_lowsrc(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `lowsrc=`*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_lowsrc(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_name(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_name(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `name=`*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_name(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_src(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setSrc*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_src(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `src=`*(self: DOMHTMLImageElement; value: cstring) =
  webkit_dom_html_image_element_set_src(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_use_map(self: ptr DOMHTMLImageElement00;
    value: cstring) {.
    importc, libprag.}

proc setUseMap*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_use_map(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `useMap=`*(self: DOMHTMLImageElement;
    value: cstring) =
  webkit_dom_html_image_element_set_use_map(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_vspace(self: ptr DOMHTMLImageElement00;
    value: int64) {.
    importc, libprag.}

proc setVspace*(self: DOMHTMLImageElement;
    value: int64) =
  webkit_dom_html_image_element_set_vspace(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `vspace=`*(self: DOMHTMLImageElement;
    value: int64) =
  webkit_dom_html_image_element_set_vspace(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc webkit_dom_html_image_element_set_width(self: ptr DOMHTMLImageElement00;
    value: int64) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLImageElement; value: int64) =
  webkit_dom_html_image_element_set_width(cast[ptr DOMHTMLImageElement00](self.impl), value)

proc `width=`*(self: DOMHTMLImageElement; value: int64) =
  webkit_dom_html_image_element_set_width(cast[ptr DOMHTMLImageElement00](self.impl), value)

type
  DOMHTMLModElement* = ref object of DOMHTMLElement
  DOMHTMLModElement00* = object of DOMHTMLElement00

proc webkit_dom_html_mod_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLModElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_mod_element_get_cite(self: ptr DOMHTMLModElement00): cstring {.
    importc, libprag.}

proc getCite*(self: DOMHTMLModElement): string =
  let resul0 = webkit_dom_html_mod_element_get_cite(cast[ptr DOMHTMLModElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cite*(self: DOMHTMLModElement): string =
  let resul0 = webkit_dom_html_mod_element_get_cite(cast[ptr DOMHTMLModElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_mod_element_get_date_time(self: ptr DOMHTMLModElement00): cstring {.
    importc, libprag.}

proc getDateTime*(self: DOMHTMLModElement): string =
  let resul0 = webkit_dom_html_mod_element_get_date_time(cast[ptr DOMHTMLModElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc dateTime*(self: DOMHTMLModElement): string =
  let resul0 = webkit_dom_html_mod_element_get_date_time(cast[ptr DOMHTMLModElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_mod_element_set_cite(self: ptr DOMHTMLModElement00;
    value: cstring) {.
    importc, libprag.}

proc setCite*(self: DOMHTMLModElement; value: cstring) =
  webkit_dom_html_mod_element_set_cite(cast[ptr DOMHTMLModElement00](self.impl), value)

proc `cite=`*(self: DOMHTMLModElement; value: cstring) =
  webkit_dom_html_mod_element_set_cite(cast[ptr DOMHTMLModElement00](self.impl), value)

proc webkit_dom_html_mod_element_set_date_time(self: ptr DOMHTMLModElement00;
    value: cstring) {.
    importc, libprag.}

proc setDateTime*(self: DOMHTMLModElement; value: cstring) =
  webkit_dom_html_mod_element_set_date_time(cast[ptr DOMHTMLModElement00](self.impl), value)

proc `dateTime=`*(self: DOMHTMLModElement; value: cstring) =
  webkit_dom_html_mod_element_set_date_time(cast[ptr DOMHTMLModElement00](self.impl), value)

type
  DOMHTMLLegendElement* = ref object of DOMHTMLElement
  DOMHTMLLegendElement00* = object of DOMHTMLElement00

proc webkit_dom_html_legend_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLLegendElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_legend_element_get_align(self: ptr DOMHTMLLegendElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLLegendElement): string =
  let resul0 = webkit_dom_html_legend_element_get_align(cast[ptr DOMHTMLLegendElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLLegendElement): string =
  let resul0 = webkit_dom_html_legend_element_get_align(cast[ptr DOMHTMLLegendElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_legend_element_set_align(self: ptr DOMHTMLLegendElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLLegendElement;
    value: cstring) =
  webkit_dom_html_legend_element_set_align(cast[ptr DOMHTMLLegendElement00](self.impl), value)

proc `align=`*(self: DOMHTMLLegendElement;
    value: cstring) =
  webkit_dom_html_legend_element_set_align(cast[ptr DOMHTMLLegendElement00](self.impl), value)

type
  DOMHTMLHeadingElement* = ref object of DOMHTMLElement
  DOMHTMLHeadingElement00* = object of DOMHTMLElement00

proc webkit_dom_html_heading_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLHeadingElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_heading_element_get_align(self: ptr DOMHTMLHeadingElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLHeadingElement): string =
  let resul0 = webkit_dom_html_heading_element_get_align(cast[ptr DOMHTMLHeadingElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLHeadingElement): string =
  let resul0 = webkit_dom_html_heading_element_get_align(cast[ptr DOMHTMLHeadingElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_heading_element_set_align(self: ptr DOMHTMLHeadingElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLHeadingElement;
    value: cstring) =
  webkit_dom_html_heading_element_set_align(cast[ptr DOMHTMLHeadingElement00](self.impl), value)

proc `align=`*(self: DOMHTMLHeadingElement;
    value: cstring) =
  webkit_dom_html_heading_element_set_align(cast[ptr DOMHTMLHeadingElement00](self.impl), value)

type
  DOMHTMLTableColElement* = ref object of DOMHTMLElement
  DOMHTMLTableColElement00* = object of DOMHTMLElement00

proc webkit_dom_html_table_col_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTableColElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_table_col_element_get_align(self: ptr DOMHTMLTableColElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_align(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_align(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_col_element_get_ch(self: ptr DOMHTMLTableColElement00): cstring {.
    importc, libprag.}

proc getCh*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_ch(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc ch*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_ch(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_col_element_get_ch_off(self: ptr DOMHTMLTableColElement00): cstring {.
    importc, libprag.}

proc getChOff*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_ch_off(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc chOff*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_ch_off(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_col_element_get_span(self: ptr DOMHTMLTableColElement00): int64 {.
    importc, libprag.}

proc getSpan*(self: DOMHTMLTableColElement): int64 =
  webkit_dom_html_table_col_element_get_span(cast[ptr DOMHTMLTableColElement00](self.impl))

proc span*(self: DOMHTMLTableColElement): int64 =
  webkit_dom_html_table_col_element_get_span(cast[ptr DOMHTMLTableColElement00](self.impl))

proc webkit_dom_html_table_col_element_get_v_align(self: ptr DOMHTMLTableColElement00): cstring {.
    importc, libprag.}

proc getVAlign*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_v_align(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc vAlign*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_v_align(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_col_element_get_width(self: ptr DOMHTMLTableColElement00): cstring {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_width(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc width*(self: DOMHTMLTableColElement): string =
  let resul0 = webkit_dom_html_table_col_element_get_width(cast[ptr DOMHTMLTableColElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_col_element_set_align(self: ptr DOMHTMLTableColElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_align(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc `align=`*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_align(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc webkit_dom_html_table_col_element_set_ch(self: ptr DOMHTMLTableColElement00;
    value: cstring) {.
    importc, libprag.}

proc setCh*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_ch(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc `ch=`*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_ch(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc webkit_dom_html_table_col_element_set_ch_off(self: ptr DOMHTMLTableColElement00;
    value: cstring) {.
    importc, libprag.}

proc setChOff*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_ch_off(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc `chOff=`*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_ch_off(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc webkit_dom_html_table_col_element_set_span(self: ptr DOMHTMLTableColElement00;
    value: int64) {.
    importc, libprag.}

proc setSpan*(self: DOMHTMLTableColElement;
    value: int64) =
  webkit_dom_html_table_col_element_set_span(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc `span=`*(self: DOMHTMLTableColElement;
    value: int64) =
  webkit_dom_html_table_col_element_set_span(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc webkit_dom_html_table_col_element_set_v_align(self: ptr DOMHTMLTableColElement00;
    value: cstring) {.
    importc, libprag.}

proc setVAlign*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_v_align(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc `vAlign=`*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_v_align(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc webkit_dom_html_table_col_element_set_width(self: ptr DOMHTMLTableColElement00;
    value: cstring) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_width(cast[ptr DOMHTMLTableColElement00](self.impl), value)

proc `width=`*(self: DOMHTMLTableColElement;
    value: cstring) =
  webkit_dom_html_table_col_element_set_width(cast[ptr DOMHTMLTableColElement00](self.impl), value)

type
  DOMHTMLAppletElement* = ref object of DOMHTMLElement
  DOMHTMLAppletElement00* = object of DOMHTMLElement00

proc webkit_dom_html_applet_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLAppletElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_applet_element_get_align(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_align(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_align(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_alt(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getAlt*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_alt(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc alt*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_alt(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_archive(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getArchive*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_archive(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc archive*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_archive(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_code(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getCode*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_code(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc code*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_code(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_code_base(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getCodeBase*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_code_base(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc codeBase*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_code_base(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_height(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_height(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc height*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_height(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_hspace(self: ptr DOMHTMLAppletElement00): int64 {.
    importc, libprag.}

proc getHspace*(self: DOMHTMLAppletElement): int64 =
  webkit_dom_html_applet_element_get_hspace(cast[ptr DOMHTMLAppletElement00](self.impl))

proc hspace*(self: DOMHTMLAppletElement): int64 =
  webkit_dom_html_applet_element_get_hspace(cast[ptr DOMHTMLAppletElement00](self.impl))

proc webkit_dom_html_applet_element_get_name(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_name(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_name(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_object(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getObject*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_object(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_get_vspace(self: ptr DOMHTMLAppletElement00): int64 {.
    importc, libprag.}

proc getVspace*(self: DOMHTMLAppletElement): int64 =
  webkit_dom_html_applet_element_get_vspace(cast[ptr DOMHTMLAppletElement00](self.impl))

proc vspace*(self: DOMHTMLAppletElement): int64 =
  webkit_dom_html_applet_element_get_vspace(cast[ptr DOMHTMLAppletElement00](self.impl))

proc webkit_dom_html_applet_element_get_width(self: ptr DOMHTMLAppletElement00): cstring {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_width(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc width*(self: DOMHTMLAppletElement): string =
  let resul0 = webkit_dom_html_applet_element_get_width(cast[ptr DOMHTMLAppletElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_applet_element_set_align(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_align(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `align=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_align(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_alt(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlt*(self: DOMHTMLAppletElement; value: cstring) =
  webkit_dom_html_applet_element_set_alt(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `alt=`*(self: DOMHTMLAppletElement; value: cstring) =
  webkit_dom_html_applet_element_set_alt(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_archive(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setArchive*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_archive(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `archive=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_archive(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_code(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setCode*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_code(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `code=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_code(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_code_base(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setCodeBase*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_code_base(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `codeBase=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_code_base(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_height(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_height(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `height=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_height(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_hspace(self: ptr DOMHTMLAppletElement00;
    value: int64) {.
    importc, libprag.}

proc setHspace*(self: DOMHTMLAppletElement;
    value: int64) =
  webkit_dom_html_applet_element_set_hspace(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `hspace=`*(self: DOMHTMLAppletElement;
    value: int64) =
  webkit_dom_html_applet_element_set_hspace(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_name(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_name(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `name=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_name(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_object(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setObject*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_object(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `object=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_object(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_vspace(self: ptr DOMHTMLAppletElement00;
    value: int64) {.
    importc, libprag.}

proc setVspace*(self: DOMHTMLAppletElement;
    value: int64) =
  webkit_dom_html_applet_element_set_vspace(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `vspace=`*(self: DOMHTMLAppletElement;
    value: int64) =
  webkit_dom_html_applet_element_set_vspace(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc webkit_dom_html_applet_element_set_width(self: ptr DOMHTMLAppletElement00;
    value: cstring) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_width(cast[ptr DOMHTMLAppletElement00](self.impl), value)

proc `width=`*(self: DOMHTMLAppletElement;
    value: cstring) =
  webkit_dom_html_applet_element_set_width(cast[ptr DOMHTMLAppletElement00](self.impl), value)

type
  DOMHTMLTitleElement* = ref object of DOMHTMLElement
  DOMHTMLTitleElement00* = object of DOMHTMLElement00

proc webkit_dom_html_title_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTitleElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_title_element_get_text(self: ptr DOMHTMLTitleElement00): cstring {.
    importc, libprag.}

proc getText*(self: DOMHTMLTitleElement): string =
  let resul0 = webkit_dom_html_title_element_get_text(cast[ptr DOMHTMLTitleElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: DOMHTMLTitleElement): string =
  let resul0 = webkit_dom_html_title_element_get_text(cast[ptr DOMHTMLTitleElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_title_element_set_text(self: ptr DOMHTMLTitleElement00;
    value: cstring) {.
    importc, libprag.}

proc setText*(self: DOMHTMLTitleElement; value: cstring) =
  webkit_dom_html_title_element_set_text(cast[ptr DOMHTMLTitleElement00](self.impl), value)

proc `text=`*(self: DOMHTMLTitleElement; value: cstring) =
  webkit_dom_html_title_element_set_text(cast[ptr DOMHTMLTitleElement00](self.impl), value)

type
  DOMHTMLFontElement* = ref object of DOMHTMLElement
  DOMHTMLFontElement00* = object of DOMHTMLElement00

proc webkit_dom_html_font_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLFontElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_font_element_get_color(self: ptr DOMHTMLFontElement00): cstring {.
    importc, libprag.}

proc getColor*(self: DOMHTMLFontElement): string =
  let resul0 = webkit_dom_html_font_element_get_color(cast[ptr DOMHTMLFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc color*(self: DOMHTMLFontElement): string =
  let resul0 = webkit_dom_html_font_element_get_color(cast[ptr DOMHTMLFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_font_element_get_face(self: ptr DOMHTMLFontElement00): cstring {.
    importc, libprag.}

proc getFace*(self: DOMHTMLFontElement): string =
  let resul0 = webkit_dom_html_font_element_get_face(cast[ptr DOMHTMLFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc face*(self: DOMHTMLFontElement): string =
  let resul0 = webkit_dom_html_font_element_get_face(cast[ptr DOMHTMLFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_font_element_get_size(self: ptr DOMHTMLFontElement00): cstring {.
    importc, libprag.}

proc getSize*(self: DOMHTMLFontElement): string =
  let resul0 = webkit_dom_html_font_element_get_size(cast[ptr DOMHTMLFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc size*(self: DOMHTMLFontElement): string =
  let resul0 = webkit_dom_html_font_element_get_size(cast[ptr DOMHTMLFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_font_element_set_color(self: ptr DOMHTMLFontElement00;
    value: cstring) {.
    importc, libprag.}

proc setColor*(self: DOMHTMLFontElement; value: cstring) =
  webkit_dom_html_font_element_set_color(cast[ptr DOMHTMLFontElement00](self.impl), value)

proc `color=`*(self: DOMHTMLFontElement; value: cstring) =
  webkit_dom_html_font_element_set_color(cast[ptr DOMHTMLFontElement00](self.impl), value)

proc webkit_dom_html_font_element_set_face(self: ptr DOMHTMLFontElement00;
    value: cstring) {.
    importc, libprag.}

proc setFace*(self: DOMHTMLFontElement; value: cstring) =
  webkit_dom_html_font_element_set_face(cast[ptr DOMHTMLFontElement00](self.impl), value)

proc `face=`*(self: DOMHTMLFontElement; value: cstring) =
  webkit_dom_html_font_element_set_face(cast[ptr DOMHTMLFontElement00](self.impl), value)

proc webkit_dom_html_font_element_set_size(self: ptr DOMHTMLFontElement00;
    value: cstring) {.
    importc, libprag.}

proc setSize*(self: DOMHTMLFontElement; value: cstring) =
  webkit_dom_html_font_element_set_size(cast[ptr DOMHTMLFontElement00](self.impl), value)

proc `size=`*(self: DOMHTMLFontElement; value: cstring) =
  webkit_dom_html_font_element_set_size(cast[ptr DOMHTMLFontElement00](self.impl), value)

type
  DOMHTMLButtonElement* = ref object of DOMHTMLElement
  DOMHTMLButtonElement00* = object of DOMHTMLElement00

proc webkit_dom_html_button_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLButtonElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_button_element_get_autofocus(self: ptr DOMHTMLButtonElement00): gboolean {.
    importc, libprag.}

proc getAutofocus*(self: DOMHTMLButtonElement): bool =
  toBool(webkit_dom_html_button_element_get_autofocus(cast[ptr DOMHTMLButtonElement00](self.impl)))

proc autofocus*(self: DOMHTMLButtonElement): bool =
  toBool(webkit_dom_html_button_element_get_autofocus(cast[ptr DOMHTMLButtonElement00](self.impl)))

proc webkit_dom_html_button_element_get_button_type(self: ptr DOMHTMLButtonElement00): cstring {.
    importc, libprag.}

proc getButtonType*(self: DOMHTMLButtonElement): string =
  let resul0 = webkit_dom_html_button_element_get_button_type(cast[ptr DOMHTMLButtonElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc buttonType*(self: DOMHTMLButtonElement): string =
  let resul0 = webkit_dom_html_button_element_get_button_type(cast[ptr DOMHTMLButtonElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_button_element_get_disabled(self: ptr DOMHTMLButtonElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLButtonElement): bool =
  toBool(webkit_dom_html_button_element_get_disabled(cast[ptr DOMHTMLButtonElement00](self.impl)))

proc disabled*(self: DOMHTMLButtonElement): bool =
  toBool(webkit_dom_html_button_element_get_disabled(cast[ptr DOMHTMLButtonElement00](self.impl)))

proc webkit_dom_html_button_element_get_name(self: ptr DOMHTMLButtonElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLButtonElement): string =
  let resul0 = webkit_dom_html_button_element_get_name(cast[ptr DOMHTMLButtonElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLButtonElement): string =
  let resul0 = webkit_dom_html_button_element_get_name(cast[ptr DOMHTMLButtonElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_button_element_get_value(self: ptr DOMHTMLButtonElement00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMHTMLButtonElement): string =
  let resul0 = webkit_dom_html_button_element_get_value(cast[ptr DOMHTMLButtonElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMHTMLButtonElement): string =
  let resul0 = webkit_dom_html_button_element_get_value(cast[ptr DOMHTMLButtonElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_button_element_get_will_validate(self: ptr DOMHTMLButtonElement00): gboolean {.
    importc, libprag.}

proc getWillValidate*(self: DOMHTMLButtonElement): bool =
  toBool(webkit_dom_html_button_element_get_will_validate(cast[ptr DOMHTMLButtonElement00](self.impl)))

proc willValidate*(self: DOMHTMLButtonElement): bool =
  toBool(webkit_dom_html_button_element_get_will_validate(cast[ptr DOMHTMLButtonElement00](self.impl)))

proc webkit_dom_html_button_element_set_autofocus(self: ptr DOMHTMLButtonElement00;
    value: gboolean) {.
    importc, libprag.}

proc setAutofocus*(self: DOMHTMLButtonElement;
    value: bool = true) =
  webkit_dom_html_button_element_set_autofocus(cast[ptr DOMHTMLButtonElement00](self.impl), gboolean(value))

proc `autofocus=`*(self: DOMHTMLButtonElement;
    value: bool) =
  webkit_dom_html_button_element_set_autofocus(cast[ptr DOMHTMLButtonElement00](self.impl), gboolean(value))

proc webkit_dom_html_button_element_set_button_type(self: ptr DOMHTMLButtonElement00;
    value: cstring) {.
    importc, libprag.}

proc setButtonType*(self: DOMHTMLButtonElement;
    value: cstring) =
  webkit_dom_html_button_element_set_button_type(cast[ptr DOMHTMLButtonElement00](self.impl), value)

proc `buttonType=`*(self: DOMHTMLButtonElement;
    value: cstring) =
  webkit_dom_html_button_element_set_button_type(cast[ptr DOMHTMLButtonElement00](self.impl), value)

proc webkit_dom_html_button_element_set_disabled(self: ptr DOMHTMLButtonElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLButtonElement;
    value: bool = true) =
  webkit_dom_html_button_element_set_disabled(cast[ptr DOMHTMLButtonElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLButtonElement;
    value: bool) =
  webkit_dom_html_button_element_set_disabled(cast[ptr DOMHTMLButtonElement00](self.impl), gboolean(value))

proc webkit_dom_html_button_element_set_name(self: ptr DOMHTMLButtonElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLButtonElement;
    value: cstring) =
  webkit_dom_html_button_element_set_name(cast[ptr DOMHTMLButtonElement00](self.impl), value)

proc `name=`*(self: DOMHTMLButtonElement;
    value: cstring) =
  webkit_dom_html_button_element_set_name(cast[ptr DOMHTMLButtonElement00](self.impl), value)

proc webkit_dom_html_button_element_set_value(self: ptr DOMHTMLButtonElement00;
    value: cstring) {.
    importc, libprag.}

proc setValue*(self: DOMHTMLButtonElement;
    value: cstring) =
  webkit_dom_html_button_element_set_value(cast[ptr DOMHTMLButtonElement00](self.impl), value)

proc `value=`*(self: DOMHTMLButtonElement;
    value: cstring) =
  webkit_dom_html_button_element_set_value(cast[ptr DOMHTMLButtonElement00](self.impl), value)

type
  DOMHTMLFrameElement* = ref object of DOMHTMLElement
  DOMHTMLFrameElement00* = object of DOMHTMLElement00

proc webkit_dom_html_frame_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLFrameElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_frame_element_get_content_document(self: ptr DOMHTMLFrameElement00): ptr DOMDocument00 {.
    importc, libprag.}

proc getContentDocument*(self: DOMHTMLFrameElement): DOMDocument =
  let gobj = webkit_dom_html_frame_element_get_content_document(cast[ptr DOMHTMLFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc contentDocument*(self: DOMHTMLFrameElement): DOMDocument =
  let gobj = webkit_dom_html_frame_element_get_content_document(cast[ptr DOMHTMLFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_frame_element_get_content_window(self: ptr DOMHTMLFrameElement00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getContentWindow*(self: DOMHTMLFrameElement): DOMDOMWindow =
  let gobj = webkit_dom_html_frame_element_get_content_window(cast[ptr DOMHTMLFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc contentWindow*(self: DOMHTMLFrameElement): DOMDOMWindow =
  let gobj = webkit_dom_html_frame_element_get_content_window(cast[ptr DOMHTMLFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_frame_element_get_frame_border(self: ptr DOMHTMLFrameElement00): cstring {.
    importc, libprag.}

proc getFrameBorder*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_frame_border(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc frameBorder*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_frame_border(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_element_get_height(self: ptr DOMHTMLFrameElement00): int64 {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLFrameElement): int64 =
  webkit_dom_html_frame_element_get_height(cast[ptr DOMHTMLFrameElement00](self.impl))

proc height*(self: DOMHTMLFrameElement): int64 =
  webkit_dom_html_frame_element_get_height(cast[ptr DOMHTMLFrameElement00](self.impl))

proc webkit_dom_html_frame_element_get_long_desc(self: ptr DOMHTMLFrameElement00): cstring {.
    importc, libprag.}

proc getLongDesc*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_long_desc(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc longDesc*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_long_desc(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_element_get_margin_height(self: ptr DOMHTMLFrameElement00): cstring {.
    importc, libprag.}

proc getMarginHeight*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_margin_height(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc marginHeight*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_margin_height(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_element_get_margin_width(self: ptr DOMHTMLFrameElement00): cstring {.
    importc, libprag.}

proc getMarginWidth*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_margin_width(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc marginWidth*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_margin_width(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_element_get_name(self: ptr DOMHTMLFrameElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_name(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_name(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_element_get_no_resize(self: ptr DOMHTMLFrameElement00): gboolean {.
    importc, libprag.}

proc getNoResize*(self: DOMHTMLFrameElement): bool =
  toBool(webkit_dom_html_frame_element_get_no_resize(cast[ptr DOMHTMLFrameElement00](self.impl)))

proc noResize*(self: DOMHTMLFrameElement): bool =
  toBool(webkit_dom_html_frame_element_get_no_resize(cast[ptr DOMHTMLFrameElement00](self.impl)))

proc webkit_dom_html_frame_element_get_scrolling(self: ptr DOMHTMLFrameElement00): cstring {.
    importc, libprag.}

proc getScrolling*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_scrolling(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc scrolling*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_scrolling(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_element_get_src(self: ptr DOMHTMLFrameElement00): cstring {.
    importc, libprag.}

proc getSrc*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_src(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc src*(self: DOMHTMLFrameElement): string =
  let resul0 = webkit_dom_html_frame_element_get_src(cast[ptr DOMHTMLFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_frame_element_get_width(self: ptr DOMHTMLFrameElement00): int64 {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLFrameElement): int64 =
  webkit_dom_html_frame_element_get_width(cast[ptr DOMHTMLFrameElement00](self.impl))

proc width*(self: DOMHTMLFrameElement): int64 =
  webkit_dom_html_frame_element_get_width(cast[ptr DOMHTMLFrameElement00](self.impl))

proc webkit_dom_html_frame_element_set_frame_border(self: ptr DOMHTMLFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setFrameBorder*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_frame_border(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc `frameBorder=`*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_frame_border(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc webkit_dom_html_frame_element_set_long_desc(self: ptr DOMHTMLFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setLongDesc*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_long_desc(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc `longDesc=`*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_long_desc(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc webkit_dom_html_frame_element_set_margin_height(self: ptr DOMHTMLFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setMarginHeight*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_margin_height(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc `marginHeight=`*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_margin_height(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc webkit_dom_html_frame_element_set_margin_width(self: ptr DOMHTMLFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setMarginWidth*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_margin_width(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc `marginWidth=`*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_margin_width(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc webkit_dom_html_frame_element_set_name(self: ptr DOMHTMLFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLFrameElement; value: cstring) =
  webkit_dom_html_frame_element_set_name(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc `name=`*(self: DOMHTMLFrameElement; value: cstring) =
  webkit_dom_html_frame_element_set_name(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc webkit_dom_html_frame_element_set_no_resize(self: ptr DOMHTMLFrameElement00;
    value: gboolean) {.
    importc, libprag.}

proc setNoResize*(self: DOMHTMLFrameElement;
    value: bool = true) =
  webkit_dom_html_frame_element_set_no_resize(cast[ptr DOMHTMLFrameElement00](self.impl), gboolean(value))

proc `noResize=`*(self: DOMHTMLFrameElement;
    value: bool) =
  webkit_dom_html_frame_element_set_no_resize(cast[ptr DOMHTMLFrameElement00](self.impl), gboolean(value))

proc webkit_dom_html_frame_element_set_scrolling(self: ptr DOMHTMLFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setScrolling*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_scrolling(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc `scrolling=`*(self: DOMHTMLFrameElement;
    value: cstring) =
  webkit_dom_html_frame_element_set_scrolling(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc webkit_dom_html_frame_element_set_src(self: ptr DOMHTMLFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setSrc*(self: DOMHTMLFrameElement; value: cstring) =
  webkit_dom_html_frame_element_set_src(cast[ptr DOMHTMLFrameElement00](self.impl), value)

proc `src=`*(self: DOMHTMLFrameElement; value: cstring) =
  webkit_dom_html_frame_element_set_src(cast[ptr DOMHTMLFrameElement00](self.impl), value)

type
  DOMHTMLSelectElement* = ref object of DOMHTMLElement
  DOMHTMLSelectElement00* = object of DOMHTMLElement00

proc webkit_dom_html_select_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLSelectElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_select_element_add(self: ptr DOMHTMLSelectElement00;
    element: ptr DOMHTMLElement00; before: ptr DOMHTMLElement00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc add*(self: DOMHTMLSelectElement; element: DOMHTMLElement;
    before: DOMHTMLElement) =
  var gerror: ptr glib.Error
  webkit_dom_html_select_element_add(cast[ptr DOMHTMLSelectElement00](self.impl), cast[ptr DOMHTMLElement00](element.impl), cast[ptr DOMHTMLElement00](before.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_select_element_get_autofocus(self: ptr DOMHTMLSelectElement00): gboolean {.
    importc, libprag.}

proc getAutofocus*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_autofocus(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc autofocus*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_autofocus(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc webkit_dom_html_select_element_get_disabled(self: ptr DOMHTMLSelectElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_disabled(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc disabled*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_disabled(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc webkit_dom_html_select_element_get_length(self: ptr DOMHTMLSelectElement00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMHTMLSelectElement): uint64 =
  webkit_dom_html_select_element_get_length(cast[ptr DOMHTMLSelectElement00](self.impl))

proc length*(self: DOMHTMLSelectElement): uint64 =
  webkit_dom_html_select_element_get_length(cast[ptr DOMHTMLSelectElement00](self.impl))

proc webkit_dom_html_select_element_get_multiple(self: ptr DOMHTMLSelectElement00): gboolean {.
    importc, libprag.}

proc getMultiple*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_multiple(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc multiple*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_multiple(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc webkit_dom_html_select_element_get_name(self: ptr DOMHTMLSelectElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLSelectElement): string =
  let resul0 = webkit_dom_html_select_element_get_name(cast[ptr DOMHTMLSelectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLSelectElement): string =
  let resul0 = webkit_dom_html_select_element_get_name(cast[ptr DOMHTMLSelectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_select_element_get_select_type(self: ptr DOMHTMLSelectElement00): cstring {.
    importc, libprag.}

proc getSelectType*(self: DOMHTMLSelectElement): string =
  let resul0 = webkit_dom_html_select_element_get_select_type(cast[ptr DOMHTMLSelectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc selectType*(self: DOMHTMLSelectElement): string =
  let resul0 = webkit_dom_html_select_element_get_select_type(cast[ptr DOMHTMLSelectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_select_element_get_selected_index(self: ptr DOMHTMLSelectElement00): int64 {.
    importc, libprag.}

proc getSelectedIndex*(self: DOMHTMLSelectElement): int64 =
  webkit_dom_html_select_element_get_selected_index(cast[ptr DOMHTMLSelectElement00](self.impl))

proc selectedIndex*(self: DOMHTMLSelectElement): int64 =
  webkit_dom_html_select_element_get_selected_index(cast[ptr DOMHTMLSelectElement00](self.impl))

proc webkit_dom_html_select_element_get_size(self: ptr DOMHTMLSelectElement00): int64 {.
    importc, libprag.}

proc getSize*(self: DOMHTMLSelectElement): int64 =
  webkit_dom_html_select_element_get_size(cast[ptr DOMHTMLSelectElement00](self.impl))

proc size*(self: DOMHTMLSelectElement): int64 =
  webkit_dom_html_select_element_get_size(cast[ptr DOMHTMLSelectElement00](self.impl))

proc webkit_dom_html_select_element_get_value(self: ptr DOMHTMLSelectElement00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMHTMLSelectElement): string =
  let resul0 = webkit_dom_html_select_element_get_value(cast[ptr DOMHTMLSelectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMHTMLSelectElement): string =
  let resul0 = webkit_dom_html_select_element_get_value(cast[ptr DOMHTMLSelectElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_select_element_get_will_validate(self: ptr DOMHTMLSelectElement00): gboolean {.
    importc, libprag.}

proc getWillValidate*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_will_validate(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc willValidate*(self: DOMHTMLSelectElement): bool =
  toBool(webkit_dom_html_select_element_get_will_validate(cast[ptr DOMHTMLSelectElement00](self.impl)))

proc webkit_dom_html_select_element_item(self: ptr DOMHTMLSelectElement00;
    index: uint64): ptr DOMNode00 {.
    importc, libprag.}

proc item*(self: DOMHTMLSelectElement; index: uint64): DOMNode =
  let gobj = webkit_dom_html_select_element_item(cast[ptr DOMHTMLSelectElement00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_select_element_named_item(self: ptr DOMHTMLSelectElement00;
    name: cstring): ptr DOMNode00 {.
    importc, libprag.}

proc namedItem*(self: DOMHTMLSelectElement;
    name: cstring): DOMNode =
  let gobj = webkit_dom_html_select_element_named_item(cast[ptr DOMHTMLSelectElement00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_select_element_remove(self: ptr DOMHTMLSelectElement00;
    index: int64) {.
    importc, libprag.}

proc remove*(self: DOMHTMLSelectElement; index: int64) =
  webkit_dom_html_select_element_remove(cast[ptr DOMHTMLSelectElement00](self.impl), index)

proc webkit_dom_html_select_element_set_autofocus(self: ptr DOMHTMLSelectElement00;
    value: gboolean) {.
    importc, libprag.}

proc setAutofocus*(self: DOMHTMLSelectElement;
    value: bool = true) =
  webkit_dom_html_select_element_set_autofocus(cast[ptr DOMHTMLSelectElement00](self.impl), gboolean(value))

proc `autofocus=`*(self: DOMHTMLSelectElement;
    value: bool) =
  webkit_dom_html_select_element_set_autofocus(cast[ptr DOMHTMLSelectElement00](self.impl), gboolean(value))

proc webkit_dom_html_select_element_set_disabled(self: ptr DOMHTMLSelectElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLSelectElement;
    value: bool = true) =
  webkit_dom_html_select_element_set_disabled(cast[ptr DOMHTMLSelectElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLSelectElement;
    value: bool) =
  webkit_dom_html_select_element_set_disabled(cast[ptr DOMHTMLSelectElement00](self.impl), gboolean(value))

proc webkit_dom_html_select_element_set_length(self: ptr DOMHTMLSelectElement00;
    value: uint64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setLength*(self: DOMHTMLSelectElement;
    value: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_html_select_element_set_length(cast[ptr DOMHTMLSelectElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `length=`*(self: DOMHTMLSelectElement;
    value: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_html_select_element_set_length(cast[ptr DOMHTMLSelectElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_select_element_set_multiple(self: ptr DOMHTMLSelectElement00;
    value: gboolean) {.
    importc, libprag.}

proc setMultiple*(self: DOMHTMLSelectElement;
    value: bool = true) =
  webkit_dom_html_select_element_set_multiple(cast[ptr DOMHTMLSelectElement00](self.impl), gboolean(value))

proc `multiple=`*(self: DOMHTMLSelectElement;
    value: bool) =
  webkit_dom_html_select_element_set_multiple(cast[ptr DOMHTMLSelectElement00](self.impl), gboolean(value))

proc webkit_dom_html_select_element_set_name(self: ptr DOMHTMLSelectElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLSelectElement;
    value: cstring) =
  webkit_dom_html_select_element_set_name(cast[ptr DOMHTMLSelectElement00](self.impl), value)

proc `name=`*(self: DOMHTMLSelectElement;
    value: cstring) =
  webkit_dom_html_select_element_set_name(cast[ptr DOMHTMLSelectElement00](self.impl), value)

proc webkit_dom_html_select_element_set_selected_index(self: ptr DOMHTMLSelectElement00;
    value: int64) {.
    importc, libprag.}

proc setSelectedIndex*(self: DOMHTMLSelectElement;
    value: int64) =
  webkit_dom_html_select_element_set_selected_index(cast[ptr DOMHTMLSelectElement00](self.impl), value)

proc `selectedIndex=`*(self: DOMHTMLSelectElement;
    value: int64) =
  webkit_dom_html_select_element_set_selected_index(cast[ptr DOMHTMLSelectElement00](self.impl), value)

proc webkit_dom_html_select_element_set_size(self: ptr DOMHTMLSelectElement00;
    value: int64) {.
    importc, libprag.}

proc setSize*(self: DOMHTMLSelectElement;
    value: int64) =
  webkit_dom_html_select_element_set_size(cast[ptr DOMHTMLSelectElement00](self.impl), value)

proc `size=`*(self: DOMHTMLSelectElement;
    value: int64) =
  webkit_dom_html_select_element_set_size(cast[ptr DOMHTMLSelectElement00](self.impl), value)

proc webkit_dom_html_select_element_set_value(self: ptr DOMHTMLSelectElement00;
    value: cstring) {.
    importc, libprag.}

proc setValue*(self: DOMHTMLSelectElement;
    value: cstring) =
  webkit_dom_html_select_element_set_value(cast[ptr DOMHTMLSelectElement00](self.impl), value)

proc `value=`*(self: DOMHTMLSelectElement;
    value: cstring) =
  webkit_dom_html_select_element_set_value(cast[ptr DOMHTMLSelectElement00](self.impl), value)

type
  DOMHTMLTableSectionElement* = ref object of DOMHTMLElement
  DOMHTMLTableSectionElement00* = object of DOMHTMLElement00

proc webkit_dom_html_table_section_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTableSectionElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_table_section_element_delete_row(self: ptr DOMHTMLTableSectionElement00;
    index: int64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc deleteRow*(self: DOMHTMLTableSectionElement;
    index: int64) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_section_element_delete_row(cast[ptr DOMHTMLTableSectionElement00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_table_section_element_get_align(self: ptr DOMHTMLTableSectionElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_align(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_align(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_section_element_get_ch(self: ptr DOMHTMLTableSectionElement00): cstring {.
    importc, libprag.}

proc getCh*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_ch(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc ch*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_ch(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_section_element_get_ch_off(self: ptr DOMHTMLTableSectionElement00): cstring {.
    importc, libprag.}

proc getChOff*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_ch_off(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc chOff*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_ch_off(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_section_element_get_rows(self: ptr DOMHTMLTableSectionElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getRows*(self: DOMHTMLTableSectionElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_section_element_get_rows(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rows*(self: DOMHTMLTableSectionElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_section_element_get_rows(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_section_element_get_v_align(self: ptr DOMHTMLTableSectionElement00): cstring {.
    importc, libprag.}

proc getVAlign*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_v_align(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc vAlign*(self: DOMHTMLTableSectionElement): string =
  let resul0 = webkit_dom_html_table_section_element_get_v_align(cast[ptr DOMHTMLTableSectionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_section_element_insert_row(self: ptr DOMHTMLTableSectionElement00;
    index: int64; error: ptr ptr glib.Error = nil): ptr DOMHTMLElement00 {.
    importc, libprag.}

proc insertRow*(self: DOMHTMLTableSectionElement;
    index: int64): DOMHTMLElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_html_table_section_element_insert_row(cast[ptr DOMHTMLTableSectionElement00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_section_element_set_align(self: ptr DOMHTMLTableSectionElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_align(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

proc `align=`*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_align(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

proc webkit_dom_html_table_section_element_set_ch(self: ptr DOMHTMLTableSectionElement00;
    value: cstring) {.
    importc, libprag.}

proc setCh*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_ch(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

proc `ch=`*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_ch(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

proc webkit_dom_html_table_section_element_set_ch_off(self: ptr DOMHTMLTableSectionElement00;
    value: cstring) {.
    importc, libprag.}

proc setChOff*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_ch_off(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

proc `chOff=`*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_ch_off(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

proc webkit_dom_html_table_section_element_set_v_align(self: ptr DOMHTMLTableSectionElement00;
    value: cstring) {.
    importc, libprag.}

proc setVAlign*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_v_align(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

proc `vAlign=`*(self: DOMHTMLTableSectionElement;
    value: cstring) =
  webkit_dom_html_table_section_element_set_v_align(cast[ptr DOMHTMLTableSectionElement00](self.impl), value)

type
  DOMHTMLTableRowElement* = ref object of DOMHTMLElement
  DOMHTMLTableRowElement00* = object of DOMHTMLElement00

proc webkit_dom_html_table_row_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTableRowElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_table_row_element_delete_cell(self: ptr DOMHTMLTableRowElement00;
    index: int64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc deleteCell*(self: DOMHTMLTableRowElement;
    index: int64) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_row_element_delete_cell(cast[ptr DOMHTMLTableRowElement00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_table_row_element_get_align(self: ptr DOMHTMLTableRowElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_align(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_align(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_row_element_get_bg_color(self: ptr DOMHTMLTableRowElement00): cstring {.
    importc, libprag.}

proc getBgColor*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_bg_color(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc bgColor*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_bg_color(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_row_element_get_cells(self: ptr DOMHTMLTableRowElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getCells*(self: DOMHTMLTableRowElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_row_element_get_cells(cast[ptr DOMHTMLTableRowElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc cells*(self: DOMHTMLTableRowElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_row_element_get_cells(cast[ptr DOMHTMLTableRowElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_row_element_get_ch(self: ptr DOMHTMLTableRowElement00): cstring {.
    importc, libprag.}

proc getCh*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_ch(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc ch*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_ch(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_row_element_get_ch_off(self: ptr DOMHTMLTableRowElement00): cstring {.
    importc, libprag.}

proc getChOff*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_ch_off(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc chOff*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_ch_off(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_row_element_get_row_index(self: ptr DOMHTMLTableRowElement00): int64 {.
    importc, libprag.}

proc getRowIndex*(self: DOMHTMLTableRowElement): int64 =
  webkit_dom_html_table_row_element_get_row_index(cast[ptr DOMHTMLTableRowElement00](self.impl))

proc rowIndex*(self: DOMHTMLTableRowElement): int64 =
  webkit_dom_html_table_row_element_get_row_index(cast[ptr DOMHTMLTableRowElement00](self.impl))

proc webkit_dom_html_table_row_element_get_section_row_index(self: ptr DOMHTMLTableRowElement00): int64 {.
    importc, libprag.}

proc getSectionRowIndex*(self: DOMHTMLTableRowElement): int64 =
  webkit_dom_html_table_row_element_get_section_row_index(cast[ptr DOMHTMLTableRowElement00](self.impl))

proc sectionRowIndex*(self: DOMHTMLTableRowElement): int64 =
  webkit_dom_html_table_row_element_get_section_row_index(cast[ptr DOMHTMLTableRowElement00](self.impl))

proc webkit_dom_html_table_row_element_get_v_align(self: ptr DOMHTMLTableRowElement00): cstring {.
    importc, libprag.}

proc getVAlign*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_v_align(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc vAlign*(self: DOMHTMLTableRowElement): string =
  let resul0 = webkit_dom_html_table_row_element_get_v_align(cast[ptr DOMHTMLTableRowElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_row_element_insert_cell(self: ptr DOMHTMLTableRowElement00;
    index: int64; error: ptr ptr glib.Error = nil): ptr DOMHTMLElement00 {.
    importc, libprag.}

proc insertCell*(self: DOMHTMLTableRowElement;
    index: int64): DOMHTMLElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_html_table_row_element_insert_cell(cast[ptr DOMHTMLTableRowElement00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_row_element_set_align(self: ptr DOMHTMLTableRowElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_align(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc `align=`*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_align(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc webkit_dom_html_table_row_element_set_bg_color(self: ptr DOMHTMLTableRowElement00;
    value: cstring) {.
    importc, libprag.}

proc setBgColor*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_bg_color(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc `bgColor=`*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_bg_color(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc webkit_dom_html_table_row_element_set_ch(self: ptr DOMHTMLTableRowElement00;
    value: cstring) {.
    importc, libprag.}

proc setCh*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_ch(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc `ch=`*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_ch(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc webkit_dom_html_table_row_element_set_ch_off(self: ptr DOMHTMLTableRowElement00;
    value: cstring) {.
    importc, libprag.}

proc setChOff*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_ch_off(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc `chOff=`*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_ch_off(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc webkit_dom_html_table_row_element_set_v_align(self: ptr DOMHTMLTableRowElement00;
    value: cstring) {.
    importc, libprag.}

proc setVAlign*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_v_align(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

proc `vAlign=`*(self: DOMHTMLTableRowElement;
    value: cstring) =
  webkit_dom_html_table_row_element_set_v_align(cast[ptr DOMHTMLTableRowElement00](self.impl), value)

type
  DOMHTMLTextAreaElement* = ref object of DOMHTMLElement
  DOMHTMLTextAreaElement00* = object of DOMHTMLElement00

proc webkit_dom_html_text_area_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTextAreaElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_text_area_element_get_area_type(self: ptr DOMHTMLTextAreaElement00): cstring {.
    importc, libprag.}

proc getAreaType*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_area_type(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc areaType*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_area_type(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_text_area_element_get_autofocus(self: ptr DOMHTMLTextAreaElement00): gboolean {.
    importc, libprag.}

proc getAutofocus*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_autofocus(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc autofocus*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_autofocus(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc webkit_dom_html_text_area_element_get_cols(self: ptr DOMHTMLTextAreaElement00): int64 {.
    importc, libprag.}

proc getCols*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_cols(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc cols*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_cols(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc webkit_dom_html_text_area_element_get_default_value(self: ptr DOMHTMLTextAreaElement00): cstring {.
    importc, libprag.}

proc getDefaultValue*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_default_value(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc defaultValue*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_default_value(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_text_area_element_get_disabled(self: ptr DOMHTMLTextAreaElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_disabled(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc disabled*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_disabled(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc webkit_dom_html_text_area_element_get_name(self: ptr DOMHTMLTextAreaElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_name(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_name(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_text_area_element_get_read_only(self: ptr DOMHTMLTextAreaElement00): gboolean {.
    importc, libprag.}

proc getReadOnly*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_read_only(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc readOnly*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_read_only(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc webkit_dom_html_text_area_element_get_rows(self: ptr DOMHTMLTextAreaElement00): int64 {.
    importc, libprag.}

proc getRows*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_rows(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc rows*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_rows(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc webkit_dom_html_text_area_element_get_selection_end(self: ptr DOMHTMLTextAreaElement00): int64 {.
    importc, libprag.}

proc getSelectionEnd*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_selection_end(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc selectionEnd*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_selection_end(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc webkit_dom_html_text_area_element_get_selection_start(self: ptr DOMHTMLTextAreaElement00): int64 {.
    importc, libprag.}

proc getSelectionStart*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_selection_start(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc selectionStart*(self: DOMHTMLTextAreaElement): int64 =
  webkit_dom_html_text_area_element_get_selection_start(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc webkit_dom_html_text_area_element_get_value(self: ptr DOMHTMLTextAreaElement00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_value(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMHTMLTextAreaElement): string =
  let resul0 = webkit_dom_html_text_area_element_get_value(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_text_area_element_get_will_validate(self: ptr DOMHTMLTextAreaElement00): gboolean {.
    importc, libprag.}

proc getWillValidate*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_will_validate(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc willValidate*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_get_will_validate(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc webkit_dom_html_text_area_element_is_edited(self: ptr DOMHTMLTextAreaElement00): gboolean {.
    importc, libprag.}

proc isEdited*(self: DOMHTMLTextAreaElement): bool =
  toBool(webkit_dom_html_text_area_element_is_edited(cast[ptr DOMHTMLTextAreaElement00](self.impl)))

proc webkit_dom_html_text_area_element_select(self: ptr DOMHTMLTextAreaElement00) {.
    importc, libprag.}

proc select*(self: DOMHTMLTextAreaElement) =
  webkit_dom_html_text_area_element_select(cast[ptr DOMHTMLTextAreaElement00](self.impl))

proc webkit_dom_html_text_area_element_set_autofocus(self: ptr DOMHTMLTextAreaElement00;
    value: gboolean) {.
    importc, libprag.}

proc setAutofocus*(self: DOMHTMLTextAreaElement;
    value: bool = true) =
  webkit_dom_html_text_area_element_set_autofocus(cast[ptr DOMHTMLTextAreaElement00](self.impl), gboolean(value))

proc `autofocus=`*(self: DOMHTMLTextAreaElement;
    value: bool) =
  webkit_dom_html_text_area_element_set_autofocus(cast[ptr DOMHTMLTextAreaElement00](self.impl), gboolean(value))

proc webkit_dom_html_text_area_element_set_cols(self: ptr DOMHTMLTextAreaElement00;
    value: int64) {.
    importc, libprag.}

proc setCols*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_cols(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc `cols=`*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_cols(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc webkit_dom_html_text_area_element_set_default_value(self: ptr DOMHTMLTextAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setDefaultValue*(self: DOMHTMLTextAreaElement;
    value: cstring) =
  webkit_dom_html_text_area_element_set_default_value(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc `defaultValue=`*(self: DOMHTMLTextAreaElement;
    value: cstring) =
  webkit_dom_html_text_area_element_set_default_value(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc webkit_dom_html_text_area_element_set_disabled(self: ptr DOMHTMLTextAreaElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLTextAreaElement;
    value: bool = true) =
  webkit_dom_html_text_area_element_set_disabled(cast[ptr DOMHTMLTextAreaElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLTextAreaElement;
    value: bool) =
  webkit_dom_html_text_area_element_set_disabled(cast[ptr DOMHTMLTextAreaElement00](self.impl), gboolean(value))

proc webkit_dom_html_text_area_element_set_name(self: ptr DOMHTMLTextAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLTextAreaElement;
    value: cstring) =
  webkit_dom_html_text_area_element_set_name(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc `name=`*(self: DOMHTMLTextAreaElement;
    value: cstring) =
  webkit_dom_html_text_area_element_set_name(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc webkit_dom_html_text_area_element_set_read_only(self: ptr DOMHTMLTextAreaElement00;
    value: gboolean) {.
    importc, libprag.}

proc setReadOnly*(self: DOMHTMLTextAreaElement;
    value: bool = true) =
  webkit_dom_html_text_area_element_set_read_only(cast[ptr DOMHTMLTextAreaElement00](self.impl), gboolean(value))

proc `readOnly=`*(self: DOMHTMLTextAreaElement;
    value: bool) =
  webkit_dom_html_text_area_element_set_read_only(cast[ptr DOMHTMLTextAreaElement00](self.impl), gboolean(value))

proc webkit_dom_html_text_area_element_set_rows(self: ptr DOMHTMLTextAreaElement00;
    value: int64) {.
    importc, libprag.}

proc setRows*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_rows(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc `rows=`*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_rows(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc webkit_dom_html_text_area_element_set_selection_end(self: ptr DOMHTMLTextAreaElement00;
    value: int64) {.
    importc, libprag.}

proc setSelectionEnd*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_selection_end(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc `selectionEnd=`*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_selection_end(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc webkit_dom_html_text_area_element_set_selection_range(self: ptr DOMHTMLTextAreaElement00;
    start: int64; `end`: int64; direction: cstring) {.
    importc, libprag.}

proc setSelectionRange*(self: DOMHTMLTextAreaElement;
    start: int64; `end`: int64; direction: cstring) =
  webkit_dom_html_text_area_element_set_selection_range(cast[ptr DOMHTMLTextAreaElement00](self.impl), start, `end`, direction)

proc webkit_dom_html_text_area_element_set_selection_start(self: ptr DOMHTMLTextAreaElement00;
    value: int64) {.
    importc, libprag.}

proc setSelectionStart*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_selection_start(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc `selectionStart=`*(self: DOMHTMLTextAreaElement;
    value: int64) =
  webkit_dom_html_text_area_element_set_selection_start(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc webkit_dom_html_text_area_element_set_value(self: ptr DOMHTMLTextAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setValue*(self: DOMHTMLTextAreaElement;
    value: cstring) =
  webkit_dom_html_text_area_element_set_value(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

proc `value=`*(self: DOMHTMLTextAreaElement;
    value: cstring) =
  webkit_dom_html_text_area_element_set_value(cast[ptr DOMHTMLTextAreaElement00](self.impl), value)

type
  DOMHTMLBRElement* = ref object of DOMHTMLElement
  DOMHTMLBRElement00* = object of DOMHTMLElement00

proc webkit_dom_html_br_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLBRElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_br_element_get_clear(self: ptr DOMHTMLBRElement00): cstring {.
    importc, libprag.}

proc getClear*(self: DOMHTMLBRElement): string =
  let resul0 = webkit_dom_html_br_element_get_clear(cast[ptr DOMHTMLBRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc clear*(self: DOMHTMLBRElement): string =
  let resul0 = webkit_dom_html_br_element_get_clear(cast[ptr DOMHTMLBRElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_br_element_set_clear(self: ptr DOMHTMLBRElement00; value: cstring) {.
    importc, libprag.}

proc setClear*(self: DOMHTMLBRElement; value: cstring) =
  webkit_dom_html_br_element_set_clear(cast[ptr DOMHTMLBRElement00](self.impl), value)

proc `clear=`*(self: DOMHTMLBRElement; value: cstring) =
  webkit_dom_html_br_element_set_clear(cast[ptr DOMHTMLBRElement00](self.impl), value)

type
  DOMHTMLOptionsCollection* = ref object of DOMHTMLCollection
  DOMHTMLOptionsCollection00* = object of DOMHTMLCollection00

proc webkit_dom_html_options_collection_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLOptionsCollection()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_options_collection_get_length(self: ptr DOMHTMLOptionsCollection00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMHTMLOptionsCollection): uint64 =
  webkit_dom_html_options_collection_get_length(cast[ptr DOMHTMLOptionsCollection00](self.impl))

proc length*(self: DOMHTMLOptionsCollection): uint64 =
  webkit_dom_html_options_collection_get_length(cast[ptr DOMHTMLOptionsCollection00](self.impl))

proc webkit_dom_html_options_collection_get_selected_index(self: ptr DOMHTMLOptionsCollection00): int64 {.
    importc, libprag.}

proc getSelectedIndex*(self: DOMHTMLOptionsCollection): int64 =
  webkit_dom_html_options_collection_get_selected_index(cast[ptr DOMHTMLOptionsCollection00](self.impl))

proc selectedIndex*(self: DOMHTMLOptionsCollection): int64 =
  webkit_dom_html_options_collection_get_selected_index(cast[ptr DOMHTMLOptionsCollection00](self.impl))

proc webkit_dom_html_options_collection_named_item(self: ptr DOMHTMLOptionsCollection00;
    name: cstring): ptr DOMNode00 {.
    importc, libprag.}

proc namedItem*(self: DOMHTMLOptionsCollection;
    name: cstring): DOMNode =
  let gobj = webkit_dom_html_options_collection_named_item(cast[ptr DOMHTMLOptionsCollection00](self.impl), name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_options_collection_set_selected_index(self: ptr DOMHTMLOptionsCollection00;
    value: int64) {.
    importc, libprag.}

proc setSelectedIndex*(self: DOMHTMLOptionsCollection;
    value: int64) =
  webkit_dom_html_options_collection_set_selected_index(cast[ptr DOMHTMLOptionsCollection00](self.impl), value)

proc `selectedIndex=`*(self: DOMHTMLOptionsCollection;
    value: int64) =
  webkit_dom_html_options_collection_set_selected_index(cast[ptr DOMHTMLOptionsCollection00](self.impl), value)

proc webkit_dom_html_select_element_get_options(self: ptr DOMHTMLSelectElement00): ptr DOMHTMLOptionsCollection00 {.
    importc, libprag.}

proc getOptions*(self: DOMHTMLSelectElement): DOMHTMLOptionsCollection =
  let gobj = webkit_dom_html_select_element_get_options(cast[ptr DOMHTMLSelectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc options*(self: DOMHTMLSelectElement): DOMHTMLOptionsCollection =
  let gobj = webkit_dom_html_select_element_get_options(cast[ptr DOMHTMLSelectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMHTMLFormElement* = ref object of DOMHTMLElement
  DOMHTMLFormElement00* = object of DOMHTMLElement00

proc webkit_dom_html_form_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLFormElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_form_element_get_accept_charset(self: ptr DOMHTMLFormElement00): cstring {.
    importc, libprag.}

proc getAcceptCharset*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_accept_charset(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc acceptCharset*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_accept_charset(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_form_element_get_action(self: ptr DOMHTMLFormElement00): cstring {.
    importc, libprag.}

proc getAction*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_action(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc action*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_action(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_form_element_get_elements(self: ptr DOMHTMLFormElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getElements*(self: DOMHTMLFormElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_form_element_get_elements(cast[ptr DOMHTMLFormElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc elements*(self: DOMHTMLFormElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_form_element_get_elements(cast[ptr DOMHTMLFormElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_form_element_get_encoding(self: ptr DOMHTMLFormElement00): cstring {.
    importc, libprag.}

proc getEncoding*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_encoding(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc encoding*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_encoding(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_form_element_get_enctype(self: ptr DOMHTMLFormElement00): cstring {.
    importc, libprag.}

proc getEnctype*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_enctype(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc enctype*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_enctype(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_form_element_get_length(self: ptr DOMHTMLFormElement00): int64 {.
    importc, libprag.}

proc getLength*(self: DOMHTMLFormElement): int64 =
  webkit_dom_html_form_element_get_length(cast[ptr DOMHTMLFormElement00](self.impl))

proc length*(self: DOMHTMLFormElement): int64 =
  webkit_dom_html_form_element_get_length(cast[ptr DOMHTMLFormElement00](self.impl))

proc webkit_dom_html_form_element_get_method(self: ptr DOMHTMLFormElement00): cstring {.
    importc, libprag.}

proc getMethod*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_method(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_form_element_get_name(self: ptr DOMHTMLFormElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_name(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_name(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_form_element_get_target(self: ptr DOMHTMLFormElement00): cstring {.
    importc, libprag.}

proc getTarget*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_target(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc target*(self: DOMHTMLFormElement): string =
  let resul0 = webkit_dom_html_form_element_get_target(cast[ptr DOMHTMLFormElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_form_element_reset(self: ptr DOMHTMLFormElement00) {.
    importc, libprag.}

proc reset*(self: DOMHTMLFormElement) =
  webkit_dom_html_form_element_reset(cast[ptr DOMHTMLFormElement00](self.impl))

proc webkit_dom_html_form_element_set_accept_charset(self: ptr DOMHTMLFormElement00;
    value: cstring) {.
    importc, libprag.}

proc setAcceptCharset*(self: DOMHTMLFormElement;
    value: cstring) =
  webkit_dom_html_form_element_set_accept_charset(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc `acceptCharset=`*(self: DOMHTMLFormElement;
    value: cstring) =
  webkit_dom_html_form_element_set_accept_charset(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc webkit_dom_html_form_element_set_action(self: ptr DOMHTMLFormElement00;
    value: cstring) {.
    importc, libprag.}

proc setAction*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_action(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc `action=`*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_action(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc webkit_dom_html_form_element_set_encoding(self: ptr DOMHTMLFormElement00;
    value: cstring) {.
    importc, libprag.}

proc setEncoding*(self: DOMHTMLFormElement;
    value: cstring) =
  webkit_dom_html_form_element_set_encoding(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc `encoding=`*(self: DOMHTMLFormElement;
    value: cstring) =
  webkit_dom_html_form_element_set_encoding(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc webkit_dom_html_form_element_set_enctype(self: ptr DOMHTMLFormElement00;
    value: cstring) {.
    importc, libprag.}

proc setEnctype*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_enctype(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc `enctype=`*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_enctype(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc webkit_dom_html_form_element_set_method(self: ptr DOMHTMLFormElement00;
    value: cstring) {.
    importc, libprag.}

proc setMethod*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_method(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc `method=`*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_method(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc webkit_dom_html_form_element_set_name(self: ptr DOMHTMLFormElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_name(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc `name=`*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_name(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc webkit_dom_html_form_element_set_target(self: ptr DOMHTMLFormElement00;
    value: cstring) {.
    importc, libprag.}

proc setTarget*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_target(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc `target=`*(self: DOMHTMLFormElement; value: cstring) =
  webkit_dom_html_form_element_set_target(cast[ptr DOMHTMLFormElement00](self.impl), value)

proc webkit_dom_html_form_element_submit(self: ptr DOMHTMLFormElement00) {.
    importc, libprag.}

proc submit*(self: DOMHTMLFormElement) =
  webkit_dom_html_form_element_submit(cast[ptr DOMHTMLFormElement00](self.impl))

proc webkit_dom_html_object_element_get_form(self: ptr DOMHTMLObjectElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLObjectElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_object_element_get_form(cast[ptr DOMHTMLObjectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLObjectElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_object_element_get_form(cast[ptr DOMHTMLObjectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_legend_element_get_form(self: ptr DOMHTMLLegendElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLLegendElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_legend_element_get_form(cast[ptr DOMHTMLLegendElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLLegendElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_legend_element_get_form(cast[ptr DOMHTMLLegendElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_button_element_get_form(self: ptr DOMHTMLButtonElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLButtonElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_button_element_get_form(cast[ptr DOMHTMLButtonElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLButtonElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_button_element_get_form(cast[ptr DOMHTMLButtonElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_select_element_get_form(self: ptr DOMHTMLSelectElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLSelectElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_select_element_get_form(cast[ptr DOMHTMLSelectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLSelectElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_select_element_get_form(cast[ptr DOMHTMLSelectElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_text_area_element_get_form(self: ptr DOMHTMLTextAreaElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLTextAreaElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_text_area_element_get_form(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLTextAreaElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_text_area_element_get_form(cast[ptr DOMHTMLTextAreaElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMHTMLAnchorElement* = ref object of DOMHTMLElement
  DOMHTMLAnchorElement00* = object of DOMHTMLElement00

proc webkit_dom_html_anchor_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLAnchorElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_anchor_element_get_charset(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getCharset*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_charset(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc charset*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_charset(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_coords(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getCoords*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_coords(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc coords*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_coords(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_hash(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getHash*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_hash(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc hash*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_hash(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_host(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getHost*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_host(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc host*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_host(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_hostname(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getHostname*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_hostname(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc hostname*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_hostname(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_href(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getHref*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_href(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc href*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_href(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_hreflang(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getHreflang*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_hreflang(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc hreflang*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_hreflang(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_name(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_name(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_name(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_pathname(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getPathname*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_pathname(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pathname*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_pathname(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_port(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getPort*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_port(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc port*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_port(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_protocol(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getProtocol*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_protocol(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc protocol*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_protocol(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_rel(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getRel*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_rel(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc rel*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_rel(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_rev(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getRev*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_rev(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc rev*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_rev(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_search(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getSearch*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_search(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc search*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_search(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_shape(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getShape*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_shape(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc shape*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_shape(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_target(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getTarget*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_target(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc target*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_target(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_text(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getText*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_text(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_text(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_get_type_attr(self: ptr DOMHTMLAnchorElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_type_attr(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLAnchorElement): string =
  let resul0 = webkit_dom_html_anchor_element_get_type_attr(cast[ptr DOMHTMLAnchorElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_anchor_element_set_charset(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setCharset*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_charset(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `charset=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_charset(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_coords(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setCoords*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_coords(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `coords=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_coords(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_hash(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setHash*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_hash(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `hash=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_hash(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_host(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setHost*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_host(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `host=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_host(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_hostname(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setHostname*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_hostname(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `hostname=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_hostname(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_href(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setHref*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_href(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `href=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_href(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_hreflang(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setHreflang*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_hreflang(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `hreflang=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_hreflang(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_name(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_name(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `name=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_name(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_pathname(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setPathname*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_pathname(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `pathname=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_pathname(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_port(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setPort*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_port(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `port=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_port(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_protocol(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setProtocol*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_protocol(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `protocol=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_protocol(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_rel(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setRel*(self: DOMHTMLAnchorElement; value: cstring) =
  webkit_dom_html_anchor_element_set_rel(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `rel=`*(self: DOMHTMLAnchorElement; value: cstring) =
  webkit_dom_html_anchor_element_set_rel(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_rev(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setRev*(self: DOMHTMLAnchorElement; value: cstring) =
  webkit_dom_html_anchor_element_set_rev(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `rev=`*(self: DOMHTMLAnchorElement; value: cstring) =
  webkit_dom_html_anchor_element_set_rev(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_search(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setSearch*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_search(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `search=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_search(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_shape(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setShape*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_shape(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `shape=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_shape(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_target(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setTarget*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_target(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `target=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_target(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_text(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setText*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_text(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `text=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_text(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc webkit_dom_html_anchor_element_set_type_attr(self: ptr DOMHTMLAnchorElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_type_attr(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLAnchorElement;
    value: cstring) =
  webkit_dom_html_anchor_element_set_type_attr(cast[ptr DOMHTMLAnchorElement00](self.impl), value)

type
  DOMHTMLOptGroupElement* = ref object of DOMHTMLElement
  DOMHTMLOptGroupElement00* = object of DOMHTMLElement00

proc webkit_dom_html_opt_group_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLOptGroupElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_opt_group_element_get_disabled(self: ptr DOMHTMLOptGroupElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLOptGroupElement): bool =
  toBool(webkit_dom_html_opt_group_element_get_disabled(cast[ptr DOMHTMLOptGroupElement00](self.impl)))

proc disabled*(self: DOMHTMLOptGroupElement): bool =
  toBool(webkit_dom_html_opt_group_element_get_disabled(cast[ptr DOMHTMLOptGroupElement00](self.impl)))

proc webkit_dom_html_opt_group_element_get_label(self: ptr DOMHTMLOptGroupElement00): cstring {.
    importc, libprag.}

proc getLabel*(self: DOMHTMLOptGroupElement): string =
  let resul0 = webkit_dom_html_opt_group_element_get_label(cast[ptr DOMHTMLOptGroupElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc label*(self: DOMHTMLOptGroupElement): string =
  let resul0 = webkit_dom_html_opt_group_element_get_label(cast[ptr DOMHTMLOptGroupElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_opt_group_element_set_disabled(self: ptr DOMHTMLOptGroupElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLOptGroupElement;
    value: bool = true) =
  webkit_dom_html_opt_group_element_set_disabled(cast[ptr DOMHTMLOptGroupElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLOptGroupElement;
    value: bool) =
  webkit_dom_html_opt_group_element_set_disabled(cast[ptr DOMHTMLOptGroupElement00](self.impl), gboolean(value))

proc webkit_dom_html_opt_group_element_set_label(self: ptr DOMHTMLOptGroupElement00;
    value: cstring) {.
    importc, libprag.}

proc setLabel*(self: DOMHTMLOptGroupElement;
    value: cstring) =
  webkit_dom_html_opt_group_element_set_label(cast[ptr DOMHTMLOptGroupElement00](self.impl), value)

proc `label=`*(self: DOMHTMLOptGroupElement;
    value: cstring) =
  webkit_dom_html_opt_group_element_set_label(cast[ptr DOMHTMLOptGroupElement00](self.impl), value)

type
  DOMHTMLBaseElement* = ref object of DOMHTMLElement
  DOMHTMLBaseElement00* = object of DOMHTMLElement00

proc webkit_dom_html_base_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLBaseElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_base_element_get_href(self: ptr DOMHTMLBaseElement00): cstring {.
    importc, libprag.}

proc getHref*(self: DOMHTMLBaseElement): string =
  let resul0 = webkit_dom_html_base_element_get_href(cast[ptr DOMHTMLBaseElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc href*(self: DOMHTMLBaseElement): string =
  let resul0 = webkit_dom_html_base_element_get_href(cast[ptr DOMHTMLBaseElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_base_element_get_target(self: ptr DOMHTMLBaseElement00): cstring {.
    importc, libprag.}

proc getTarget*(self: DOMHTMLBaseElement): string =
  let resul0 = webkit_dom_html_base_element_get_target(cast[ptr DOMHTMLBaseElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc target*(self: DOMHTMLBaseElement): string =
  let resul0 = webkit_dom_html_base_element_get_target(cast[ptr DOMHTMLBaseElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_base_element_set_href(self: ptr DOMHTMLBaseElement00;
    value: cstring) {.
    importc, libprag.}

proc setHref*(self: DOMHTMLBaseElement; value: cstring) =
  webkit_dom_html_base_element_set_href(cast[ptr DOMHTMLBaseElement00](self.impl), value)

proc `href=`*(self: DOMHTMLBaseElement; value: cstring) =
  webkit_dom_html_base_element_set_href(cast[ptr DOMHTMLBaseElement00](self.impl), value)

proc webkit_dom_html_base_element_set_target(self: ptr DOMHTMLBaseElement00;
    value: cstring) {.
    importc, libprag.}

proc setTarget*(self: DOMHTMLBaseElement; value: cstring) =
  webkit_dom_html_base_element_set_target(cast[ptr DOMHTMLBaseElement00](self.impl), value)

proc `target=`*(self: DOMHTMLBaseElement; value: cstring) =
  webkit_dom_html_base_element_set_target(cast[ptr DOMHTMLBaseElement00](self.impl), value)

type
  DOMHTMLLIElement* = ref object of DOMHTMLElement
  DOMHTMLLIElement00* = object of DOMHTMLElement00

proc webkit_dom_html_li_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLLIElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_li_element_get_type_attr(self: ptr DOMHTMLLIElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLLIElement): string =
  let resul0 = webkit_dom_html_li_element_get_type_attr(cast[ptr DOMHTMLLIElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLLIElement): string =
  let resul0 = webkit_dom_html_li_element_get_type_attr(cast[ptr DOMHTMLLIElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_li_element_get_value(self: ptr DOMHTMLLIElement00): int64 {.
    importc, libprag.}

proc getValue*(self: DOMHTMLLIElement): int64 =
  webkit_dom_html_li_element_get_value(cast[ptr DOMHTMLLIElement00](self.impl))

proc value*(self: DOMHTMLLIElement): int64 =
  webkit_dom_html_li_element_get_value(cast[ptr DOMHTMLLIElement00](self.impl))

proc webkit_dom_html_li_element_set_type_attr(self: ptr DOMHTMLLIElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLLIElement; value: cstring) =
  webkit_dom_html_li_element_set_type_attr(cast[ptr DOMHTMLLIElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLLIElement; value: cstring) =
  webkit_dom_html_li_element_set_type_attr(cast[ptr DOMHTMLLIElement00](self.impl), value)

proc webkit_dom_html_li_element_set_value(self: ptr DOMHTMLLIElement00; value: int64) {.
    importc, libprag.}

proc setValue*(self: DOMHTMLLIElement; value: int64) =
  webkit_dom_html_li_element_set_value(cast[ptr DOMHTMLLIElement00](self.impl), value)

proc `value=`*(self: DOMHTMLLIElement; value: int64) =
  webkit_dom_html_li_element_set_value(cast[ptr DOMHTMLLIElement00](self.impl), value)

type
  DOMHTMLStyleElement* = ref object of DOMHTMLElement
  DOMHTMLStyleElement00* = object of DOMHTMLElement00

proc webkit_dom_html_style_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLStyleElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_style_element_get_disabled(self: ptr DOMHTMLStyleElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLStyleElement): bool =
  toBool(webkit_dom_html_style_element_get_disabled(cast[ptr DOMHTMLStyleElement00](self.impl)))

proc disabled*(self: DOMHTMLStyleElement): bool =
  toBool(webkit_dom_html_style_element_get_disabled(cast[ptr DOMHTMLStyleElement00](self.impl)))

proc webkit_dom_html_style_element_get_media(self: ptr DOMHTMLStyleElement00): cstring {.
    importc, libprag.}

proc getMedia*(self: DOMHTMLStyleElement): string =
  let resul0 = webkit_dom_html_style_element_get_media(cast[ptr DOMHTMLStyleElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc media*(self: DOMHTMLStyleElement): string =
  let resul0 = webkit_dom_html_style_element_get_media(cast[ptr DOMHTMLStyleElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_style_element_get_sheet(self: ptr DOMHTMLStyleElement00): ptr DOMStyleSheet00 {.
    importc, libprag.}

proc getSheet*(self: DOMHTMLStyleElement): DOMStyleSheet =
  let gobj = webkit_dom_html_style_element_get_sheet(cast[ptr DOMHTMLStyleElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sheet*(self: DOMHTMLStyleElement): DOMStyleSheet =
  let gobj = webkit_dom_html_style_element_get_sheet(cast[ptr DOMHTMLStyleElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_style_element_get_type_attr(self: ptr DOMHTMLStyleElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLStyleElement): string =
  let resul0 = webkit_dom_html_style_element_get_type_attr(cast[ptr DOMHTMLStyleElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLStyleElement): string =
  let resul0 = webkit_dom_html_style_element_get_type_attr(cast[ptr DOMHTMLStyleElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_style_element_set_disabled(self: ptr DOMHTMLStyleElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLStyleElement;
    value: bool = true) =
  webkit_dom_html_style_element_set_disabled(cast[ptr DOMHTMLStyleElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLStyleElement;
    value: bool) =
  webkit_dom_html_style_element_set_disabled(cast[ptr DOMHTMLStyleElement00](self.impl), gboolean(value))

proc webkit_dom_html_style_element_set_media(self: ptr DOMHTMLStyleElement00;
    value: cstring) {.
    importc, libprag.}

proc setMedia*(self: DOMHTMLStyleElement; value: cstring) =
  webkit_dom_html_style_element_set_media(cast[ptr DOMHTMLStyleElement00](self.impl), value)

proc `media=`*(self: DOMHTMLStyleElement; value: cstring) =
  webkit_dom_html_style_element_set_media(cast[ptr DOMHTMLStyleElement00](self.impl), value)

proc webkit_dom_html_style_element_set_type_attr(self: ptr DOMHTMLStyleElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLStyleElement;
    value: cstring) =
  webkit_dom_html_style_element_set_type_attr(cast[ptr DOMHTMLStyleElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLStyleElement;
    value: cstring) =
  webkit_dom_html_style_element_set_type_attr(cast[ptr DOMHTMLStyleElement00](self.impl), value)

type
  DOMHTMLUListElement* = ref object of DOMHTMLElement
  DOMHTMLUListElement00* = object of DOMHTMLElement00

proc webkit_dom_html_u_list_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLUListElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_u_list_element_get_compact(self: ptr DOMHTMLUListElement00): gboolean {.
    importc, libprag.}

proc getCompact*(self: DOMHTMLUListElement): bool =
  toBool(webkit_dom_html_u_list_element_get_compact(cast[ptr DOMHTMLUListElement00](self.impl)))

proc compact*(self: DOMHTMLUListElement): bool =
  toBool(webkit_dom_html_u_list_element_get_compact(cast[ptr DOMHTMLUListElement00](self.impl)))

proc webkit_dom_html_u_list_element_get_type_attr(self: ptr DOMHTMLUListElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLUListElement): string =
  let resul0 = webkit_dom_html_u_list_element_get_type_attr(cast[ptr DOMHTMLUListElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLUListElement): string =
  let resul0 = webkit_dom_html_u_list_element_get_type_attr(cast[ptr DOMHTMLUListElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_u_list_element_set_compact(self: ptr DOMHTMLUListElement00;
    value: gboolean) {.
    importc, libprag.}

proc setCompact*(self: DOMHTMLUListElement;
    value: bool = true) =
  webkit_dom_html_u_list_element_set_compact(cast[ptr DOMHTMLUListElement00](self.impl), gboolean(value))

proc `compact=`*(self: DOMHTMLUListElement;
    value: bool) =
  webkit_dom_html_u_list_element_set_compact(cast[ptr DOMHTMLUListElement00](self.impl), gboolean(value))

proc webkit_dom_html_u_list_element_set_type_attr(self: ptr DOMHTMLUListElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLUListElement;
    value: cstring) =
  webkit_dom_html_u_list_element_set_type_attr(cast[ptr DOMHTMLUListElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLUListElement;
    value: cstring) =
  webkit_dom_html_u_list_element_set_type_attr(cast[ptr DOMHTMLUListElement00](self.impl), value)

type
  DOMHTMLQuoteElement* = ref object of DOMHTMLElement
  DOMHTMLQuoteElement00* = object of DOMHTMLElement00

proc webkit_dom_html_quote_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLQuoteElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_quote_element_get_cite(self: ptr DOMHTMLQuoteElement00): cstring {.
    importc, libprag.}

proc getCite*(self: DOMHTMLQuoteElement): string =
  let resul0 = webkit_dom_html_quote_element_get_cite(cast[ptr DOMHTMLQuoteElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cite*(self: DOMHTMLQuoteElement): string =
  let resul0 = webkit_dom_html_quote_element_get_cite(cast[ptr DOMHTMLQuoteElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_quote_element_set_cite(self: ptr DOMHTMLQuoteElement00;
    value: cstring) {.
    importc, libprag.}

proc setCite*(self: DOMHTMLQuoteElement; value: cstring) =
  webkit_dom_html_quote_element_set_cite(cast[ptr DOMHTMLQuoteElement00](self.impl), value)

proc `cite=`*(self: DOMHTMLQuoteElement; value: cstring) =
  webkit_dom_html_quote_element_set_cite(cast[ptr DOMHTMLQuoteElement00](self.impl), value)

type
  DOMHTMLLinkElement* = ref object of DOMHTMLElement
  DOMHTMLLinkElement00* = object of DOMHTMLElement00

proc webkit_dom_html_link_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLLinkElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_link_element_get_charset(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getCharset*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_charset(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc charset*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_charset(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_get_disabled(self: ptr DOMHTMLLinkElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLLinkElement): bool =
  toBool(webkit_dom_html_link_element_get_disabled(cast[ptr DOMHTMLLinkElement00](self.impl)))

proc disabled*(self: DOMHTMLLinkElement): bool =
  toBool(webkit_dom_html_link_element_get_disabled(cast[ptr DOMHTMLLinkElement00](self.impl)))

proc webkit_dom_html_link_element_get_href(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getHref*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_href(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc href*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_href(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_get_hreflang(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getHreflang*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_hreflang(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc hreflang*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_hreflang(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_get_media(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getMedia*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_media(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc media*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_media(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_get_rel(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getRel*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_rel(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc rel*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_rel(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_get_rev(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getRev*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_rev(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc rev*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_rev(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_get_sheet(self: ptr DOMHTMLLinkElement00): ptr DOMStyleSheet00 {.
    importc, libprag.}

proc getSheet*(self: DOMHTMLLinkElement): DOMStyleSheet =
  let gobj = webkit_dom_html_link_element_get_sheet(cast[ptr DOMHTMLLinkElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sheet*(self: DOMHTMLLinkElement): DOMStyleSheet =
  let gobj = webkit_dom_html_link_element_get_sheet(cast[ptr DOMHTMLLinkElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_link_element_get_target(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getTarget*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_target(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc target*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_target(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_get_type_attr(self: ptr DOMHTMLLinkElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_type_attr(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLLinkElement): string =
  let resul0 = webkit_dom_html_link_element_get_type_attr(cast[ptr DOMHTMLLinkElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_link_element_set_charset(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setCharset*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_charset(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `charset=`*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_charset(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_disabled(self: ptr DOMHTMLLinkElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLLinkElement;
    value: bool = true) =
  webkit_dom_html_link_element_set_disabled(cast[ptr DOMHTMLLinkElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLLinkElement;
    value: bool) =
  webkit_dom_html_link_element_set_disabled(cast[ptr DOMHTMLLinkElement00](self.impl), gboolean(value))

proc webkit_dom_html_link_element_set_href(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setHref*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_href(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `href=`*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_href(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_hreflang(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setHreflang*(self: DOMHTMLLinkElement;
    value: cstring) =
  webkit_dom_html_link_element_set_hreflang(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `hreflang=`*(self: DOMHTMLLinkElement;
    value: cstring) =
  webkit_dom_html_link_element_set_hreflang(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_media(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setMedia*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_media(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `media=`*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_media(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_rel(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setRel*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_rel(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `rel=`*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_rel(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_rev(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setRev*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_rev(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `rev=`*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_rev(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_sizes(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setSizes*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_sizes(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `sizes=`*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_sizes(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_target(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setTarget*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_target(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `target=`*(self: DOMHTMLLinkElement; value: cstring) =
  webkit_dom_html_link_element_set_target(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc webkit_dom_html_link_element_set_type_attr(self: ptr DOMHTMLLinkElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLLinkElement;
    value: cstring) =
  webkit_dom_html_link_element_set_type_attr(cast[ptr DOMHTMLLinkElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLLinkElement;
    value: cstring) =
  webkit_dom_html_link_element_set_type_attr(cast[ptr DOMHTMLLinkElement00](self.impl), value)

type
  DOMHTMLTableCellElement* = ref object of DOMHTMLElement
  DOMHTMLTableCellElement00* = object of DOMHTMLElement00

proc webkit_dom_html_table_cell_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTableCellElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_table_cell_element_get_abbr(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getAbbr*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_abbr(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc abbr*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_abbr(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_align(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_align(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_align(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_axis(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getAxis*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_axis(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc axis*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_axis(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_bg_color(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getBgColor*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_bg_color(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc bgColor*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_bg_color(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_cell_index(self: ptr DOMHTMLTableCellElement00): int64 {.
    importc, libprag.}

proc getCellIndex*(self: DOMHTMLTableCellElement): int64 =
  webkit_dom_html_table_cell_element_get_cell_index(cast[ptr DOMHTMLTableCellElement00](self.impl))

proc cellIndex*(self: DOMHTMLTableCellElement): int64 =
  webkit_dom_html_table_cell_element_get_cell_index(cast[ptr DOMHTMLTableCellElement00](self.impl))

proc webkit_dom_html_table_cell_element_get_ch(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getCh*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_ch(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc ch*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_ch(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_ch_off(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getChOff*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_ch_off(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc chOff*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_ch_off(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_col_span(self: ptr DOMHTMLTableCellElement00): int64 {.
    importc, libprag.}

proc getColSpan*(self: DOMHTMLTableCellElement): int64 =
  webkit_dom_html_table_cell_element_get_col_span(cast[ptr DOMHTMLTableCellElement00](self.impl))

proc colSpan*(self: DOMHTMLTableCellElement): int64 =
  webkit_dom_html_table_cell_element_get_col_span(cast[ptr DOMHTMLTableCellElement00](self.impl))

proc webkit_dom_html_table_cell_element_get_headers(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getHeaders*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_headers(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc headers*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_headers(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_height(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_height(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc height*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_height(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_no_wrap(self: ptr DOMHTMLTableCellElement00): gboolean {.
    importc, libprag.}

proc getNoWrap*(self: DOMHTMLTableCellElement): bool =
  toBool(webkit_dom_html_table_cell_element_get_no_wrap(cast[ptr DOMHTMLTableCellElement00](self.impl)))

proc noWrap*(self: DOMHTMLTableCellElement): bool =
  toBool(webkit_dom_html_table_cell_element_get_no_wrap(cast[ptr DOMHTMLTableCellElement00](self.impl)))

proc webkit_dom_html_table_cell_element_get_row_span(self: ptr DOMHTMLTableCellElement00): int64 {.
    importc, libprag.}

proc getRowSpan*(self: DOMHTMLTableCellElement): int64 =
  webkit_dom_html_table_cell_element_get_row_span(cast[ptr DOMHTMLTableCellElement00](self.impl))

proc rowSpan*(self: DOMHTMLTableCellElement): int64 =
  webkit_dom_html_table_cell_element_get_row_span(cast[ptr DOMHTMLTableCellElement00](self.impl))

proc webkit_dom_html_table_cell_element_get_scope(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getScope*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_scope(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc scope*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_scope(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_v_align(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getVAlign*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_v_align(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc vAlign*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_v_align(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_get_width(self: ptr DOMHTMLTableCellElement00): cstring {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_width(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc width*(self: DOMHTMLTableCellElement): string =
  let resul0 = webkit_dom_html_table_cell_element_get_width(cast[ptr DOMHTMLTableCellElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_cell_element_set_abbr(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setAbbr*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_abbr(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `abbr=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_abbr(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_align(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_align(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `align=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_align(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_axis(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setAxis*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_axis(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `axis=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_axis(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_bg_color(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setBgColor*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_bg_color(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `bgColor=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_bg_color(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_ch(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setCh*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_ch(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `ch=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_ch(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_ch_off(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setChOff*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_ch_off(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `chOff=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_ch_off(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_col_span(self: ptr DOMHTMLTableCellElement00;
    value: int64) {.
    importc, libprag.}

proc setColSpan*(self: DOMHTMLTableCellElement;
    value: int64) =
  webkit_dom_html_table_cell_element_set_col_span(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `colSpan=`*(self: DOMHTMLTableCellElement;
    value: int64) =
  webkit_dom_html_table_cell_element_set_col_span(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_headers(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setHeaders*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_headers(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `headers=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_headers(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_height(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_height(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `height=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_height(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_no_wrap(self: ptr DOMHTMLTableCellElement00;
    value: gboolean) {.
    importc, libprag.}

proc setNoWrap*(self: DOMHTMLTableCellElement;
    value: bool = true) =
  webkit_dom_html_table_cell_element_set_no_wrap(cast[ptr DOMHTMLTableCellElement00](self.impl), gboolean(value))

proc `noWrap=`*(self: DOMHTMLTableCellElement;
    value: bool) =
  webkit_dom_html_table_cell_element_set_no_wrap(cast[ptr DOMHTMLTableCellElement00](self.impl), gboolean(value))

proc webkit_dom_html_table_cell_element_set_row_span(self: ptr DOMHTMLTableCellElement00;
    value: int64) {.
    importc, libprag.}

proc setRowSpan*(self: DOMHTMLTableCellElement;
    value: int64) =
  webkit_dom_html_table_cell_element_set_row_span(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `rowSpan=`*(self: DOMHTMLTableCellElement;
    value: int64) =
  webkit_dom_html_table_cell_element_set_row_span(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_scope(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setScope*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_scope(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `scope=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_scope(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_v_align(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setVAlign*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_v_align(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `vAlign=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_v_align(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc webkit_dom_html_table_cell_element_set_width(self: ptr DOMHTMLTableCellElement00;
    value: cstring) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_width(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

proc `width=`*(self: DOMHTMLTableCellElement;
    value: cstring) =
  webkit_dom_html_table_cell_element_set_width(cast[ptr DOMHTMLTableCellElement00](self.impl), value)

type
  DOMHTMLOListElement* = ref object of DOMHTMLElement
  DOMHTMLOListElement00* = object of DOMHTMLElement00

proc webkit_dom_html_o_list_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLOListElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_o_list_element_get_compact(self: ptr DOMHTMLOListElement00): gboolean {.
    importc, libprag.}

proc getCompact*(self: DOMHTMLOListElement): bool =
  toBool(webkit_dom_html_o_list_element_get_compact(cast[ptr DOMHTMLOListElement00](self.impl)))

proc compact*(self: DOMHTMLOListElement): bool =
  toBool(webkit_dom_html_o_list_element_get_compact(cast[ptr DOMHTMLOListElement00](self.impl)))

proc webkit_dom_html_o_list_element_get_start(self: ptr DOMHTMLOListElement00): int64 {.
    importc, libprag.}

proc getStart*(self: DOMHTMLOListElement): int64 =
  webkit_dom_html_o_list_element_get_start(cast[ptr DOMHTMLOListElement00](self.impl))

proc start*(self: DOMHTMLOListElement): int64 =
  webkit_dom_html_o_list_element_get_start(cast[ptr DOMHTMLOListElement00](self.impl))

proc webkit_dom_html_o_list_element_get_type_attr(self: ptr DOMHTMLOListElement00): cstring {.
    importc, libprag.}

proc getTypeAttr*(self: DOMHTMLOListElement): string =
  let resul0 = webkit_dom_html_o_list_element_get_type_attr(cast[ptr DOMHTMLOListElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc typeAttr*(self: DOMHTMLOListElement): string =
  let resul0 = webkit_dom_html_o_list_element_get_type_attr(cast[ptr DOMHTMLOListElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_o_list_element_set_compact(self: ptr DOMHTMLOListElement00;
    value: gboolean) {.
    importc, libprag.}

proc setCompact*(self: DOMHTMLOListElement;
    value: bool = true) =
  webkit_dom_html_o_list_element_set_compact(cast[ptr DOMHTMLOListElement00](self.impl), gboolean(value))

proc `compact=`*(self: DOMHTMLOListElement;
    value: bool) =
  webkit_dom_html_o_list_element_set_compact(cast[ptr DOMHTMLOListElement00](self.impl), gboolean(value))

proc webkit_dom_html_o_list_element_set_start(self: ptr DOMHTMLOListElement00;
    value: int64) {.
    importc, libprag.}

proc setStart*(self: DOMHTMLOListElement;
    value: int64) =
  webkit_dom_html_o_list_element_set_start(cast[ptr DOMHTMLOListElement00](self.impl), value)

proc `start=`*(self: DOMHTMLOListElement;
    value: int64) =
  webkit_dom_html_o_list_element_set_start(cast[ptr DOMHTMLOListElement00](self.impl), value)

proc webkit_dom_html_o_list_element_set_type_attr(self: ptr DOMHTMLOListElement00;
    value: cstring) {.
    importc, libprag.}

proc setTypeAttr*(self: DOMHTMLOListElement;
    value: cstring) =
  webkit_dom_html_o_list_element_set_type_attr(cast[ptr DOMHTMLOListElement00](self.impl), value)

proc `typeAttr=`*(self: DOMHTMLOListElement;
    value: cstring) =
  webkit_dom_html_o_list_element_set_type_attr(cast[ptr DOMHTMLOListElement00](self.impl), value)

type
  DOMHTMLAreaElement* = ref object of DOMHTMLElement
  DOMHTMLAreaElement00* = object of DOMHTMLElement00

proc webkit_dom_html_area_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLAreaElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_area_element_get_alt(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getAlt*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_alt(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc alt*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_alt(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_coords(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getCoords*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_coords(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc coords*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_coords(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_hash(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getHash*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_hash(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc hash*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_hash(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_host(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getHost*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_host(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc host*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_host(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_hostname(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getHostname*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_hostname(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc hostname*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_hostname(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_href(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getHref*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_href(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc href*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_href(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_no_href(self: ptr DOMHTMLAreaElement00): gboolean {.
    importc, libprag.}

proc getNoHref*(self: DOMHTMLAreaElement): bool =
  toBool(webkit_dom_html_area_element_get_no_href(cast[ptr DOMHTMLAreaElement00](self.impl)))

proc noHref*(self: DOMHTMLAreaElement): bool =
  toBool(webkit_dom_html_area_element_get_no_href(cast[ptr DOMHTMLAreaElement00](self.impl)))

proc webkit_dom_html_area_element_get_pathname(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getPathname*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_pathname(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pathname*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_pathname(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_port(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getPort*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_port(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc port*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_port(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_protocol(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getProtocol*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_protocol(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc protocol*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_protocol(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_search(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getSearch*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_search(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc search*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_search(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_shape(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getShape*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_shape(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc shape*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_shape(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_get_target(self: ptr DOMHTMLAreaElement00): cstring {.
    importc, libprag.}

proc getTarget*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_target(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc target*(self: DOMHTMLAreaElement): string =
  let resul0 = webkit_dom_html_area_element_get_target(cast[ptr DOMHTMLAreaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_area_element_set_alt(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlt*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_alt(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `alt=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_alt(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_coords(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setCoords*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_coords(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `coords=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_coords(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_hash(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setHash*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_hash(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `hash=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_hash(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_host(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setHost*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_host(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `host=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_host(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_hostname(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setHostname*(self: DOMHTMLAreaElement;
    value: cstring) =
  webkit_dom_html_area_element_set_hostname(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `hostname=`*(self: DOMHTMLAreaElement;
    value: cstring) =
  webkit_dom_html_area_element_set_hostname(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_href(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setHref*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_href(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `href=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_href(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_no_href(self: ptr DOMHTMLAreaElement00;
    value: gboolean) {.
    importc, libprag.}

proc setNoHref*(self: DOMHTMLAreaElement; value: bool = true) =
  webkit_dom_html_area_element_set_no_href(cast[ptr DOMHTMLAreaElement00](self.impl), gboolean(value))

proc `noHref=`*(self: DOMHTMLAreaElement; value: bool) =
  webkit_dom_html_area_element_set_no_href(cast[ptr DOMHTMLAreaElement00](self.impl), gboolean(value))

proc webkit_dom_html_area_element_set_pathname(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setPathname*(self: DOMHTMLAreaElement;
    value: cstring) =
  webkit_dom_html_area_element_set_pathname(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `pathname=`*(self: DOMHTMLAreaElement;
    value: cstring) =
  webkit_dom_html_area_element_set_pathname(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_port(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setPort*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_port(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `port=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_port(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_protocol(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setProtocol*(self: DOMHTMLAreaElement;
    value: cstring) =
  webkit_dom_html_area_element_set_protocol(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `protocol=`*(self: DOMHTMLAreaElement;
    value: cstring) =
  webkit_dom_html_area_element_set_protocol(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_search(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setSearch*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_search(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `search=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_search(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_shape(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setShape*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_shape(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `shape=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_shape(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc webkit_dom_html_area_element_set_target(self: ptr DOMHTMLAreaElement00;
    value: cstring) {.
    importc, libprag.}

proc setTarget*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_target(cast[ptr DOMHTMLAreaElement00](self.impl), value)

proc `target=`*(self: DOMHTMLAreaElement; value: cstring) =
  webkit_dom_html_area_element_set_target(cast[ptr DOMHTMLAreaElement00](self.impl), value)

type
  DOMHTMLMetaElement* = ref object of DOMHTMLElement
  DOMHTMLMetaElement00* = object of DOMHTMLElement00

proc webkit_dom_html_meta_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLMetaElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_meta_element_get_content(self: ptr DOMHTMLMetaElement00): cstring {.
    importc, libprag.}

proc getContent*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_content(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc content*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_content(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_meta_element_get_http_equiv(self: ptr DOMHTMLMetaElement00): cstring {.
    importc, libprag.}

proc getHttpEquiv*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_http_equiv(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc httpEquiv*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_http_equiv(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_meta_element_get_name(self: ptr DOMHTMLMetaElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_name(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_name(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_meta_element_get_scheme(self: ptr DOMHTMLMetaElement00): cstring {.
    importc, libprag.}

proc getScheme*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_scheme(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc scheme*(self: DOMHTMLMetaElement): string =
  let resul0 = webkit_dom_html_meta_element_get_scheme(cast[ptr DOMHTMLMetaElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_meta_element_set_content(self: ptr DOMHTMLMetaElement00;
    value: cstring) {.
    importc, libprag.}

proc setContent*(self: DOMHTMLMetaElement; value: cstring) =
  webkit_dom_html_meta_element_set_content(cast[ptr DOMHTMLMetaElement00](self.impl), value)

proc `content=`*(self: DOMHTMLMetaElement; value: cstring) =
  webkit_dom_html_meta_element_set_content(cast[ptr DOMHTMLMetaElement00](self.impl), value)

proc webkit_dom_html_meta_element_set_http_equiv(self: ptr DOMHTMLMetaElement00;
    value: cstring) {.
    importc, libprag.}

proc setHttpEquiv*(self: DOMHTMLMetaElement;
    value: cstring) =
  webkit_dom_html_meta_element_set_http_equiv(cast[ptr DOMHTMLMetaElement00](self.impl), value)

proc `httpEquiv=`*(self: DOMHTMLMetaElement;
    value: cstring) =
  webkit_dom_html_meta_element_set_http_equiv(cast[ptr DOMHTMLMetaElement00](self.impl), value)

proc webkit_dom_html_meta_element_set_name(self: ptr DOMHTMLMetaElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLMetaElement; value: cstring) =
  webkit_dom_html_meta_element_set_name(cast[ptr DOMHTMLMetaElement00](self.impl), value)

proc `name=`*(self: DOMHTMLMetaElement; value: cstring) =
  webkit_dom_html_meta_element_set_name(cast[ptr DOMHTMLMetaElement00](self.impl), value)

proc webkit_dom_html_meta_element_set_scheme(self: ptr DOMHTMLMetaElement00;
    value: cstring) {.
    importc, libprag.}

proc setScheme*(self: DOMHTMLMetaElement; value: cstring) =
  webkit_dom_html_meta_element_set_scheme(cast[ptr DOMHTMLMetaElement00](self.impl), value)

proc `scheme=`*(self: DOMHTMLMetaElement; value: cstring) =
  webkit_dom_html_meta_element_set_scheme(cast[ptr DOMHTMLMetaElement00](self.impl), value)

type
  DOMHTMLInputElement* = ref object of DOMHTMLElement
  DOMHTMLInputElement00* = object of DOMHTMLElement00

proc webkit_dom_html_input_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLInputElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_input_element_get_accept(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getAccept*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_accept(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc accept*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_accept(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_align(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_align(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_align(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_alt(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getAlt*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_alt(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc alt*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_alt(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_auto_filled(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getAutoFilled*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_auto_filled(cast[ptr DOMHTMLInputElement00](self.impl)))

proc autoFilled*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_auto_filled(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_autofocus(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getAutofocus*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_autofocus(cast[ptr DOMHTMLInputElement00](self.impl)))

proc autofocus*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_autofocus(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_capture(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getCapture*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_capture(cast[ptr DOMHTMLInputElement00](self.impl)))

proc capture*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_capture(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_capture_type(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getCaptureType*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_capture_type(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc captureType*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_capture_type(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_checked(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getChecked*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_checked(cast[ptr DOMHTMLInputElement00](self.impl)))

proc checked*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_checked(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_default_checked(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getDefaultChecked*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_default_checked(cast[ptr DOMHTMLInputElement00](self.impl)))

proc defaultChecked*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_default_checked(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_default_value(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getDefaultValue*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_default_value(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc defaultValue*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_default_value(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_disabled(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_disabled(cast[ptr DOMHTMLInputElement00](self.impl)))

proc disabled*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_disabled(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_form(self: ptr DOMHTMLInputElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLInputElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_input_element_get_form(cast[ptr DOMHTMLInputElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLInputElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_input_element_get_form(cast[ptr DOMHTMLInputElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_input_element_get_height(self: ptr DOMHTMLInputElement00): uint64 {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLInputElement): uint64 =
  webkit_dom_html_input_element_get_height(cast[ptr DOMHTMLInputElement00](self.impl))

proc height*(self: DOMHTMLInputElement): uint64 =
  webkit_dom_html_input_element_get_height(cast[ptr DOMHTMLInputElement00](self.impl))

proc webkit_dom_html_input_element_get_indeterminate(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getIndeterminate*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_indeterminate(cast[ptr DOMHTMLInputElement00](self.impl)))

proc indeterminate*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_indeterminate(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_input_type(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getInputType*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_input_type(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc inputType*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_input_type(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_max_length(self: ptr DOMHTMLInputElement00): int64 {.
    importc, libprag.}

proc getMaxLength*(self: DOMHTMLInputElement): int64 =
  webkit_dom_html_input_element_get_max_length(cast[ptr DOMHTMLInputElement00](self.impl))

proc maxLength*(self: DOMHTMLInputElement): int64 =
  webkit_dom_html_input_element_get_max_length(cast[ptr DOMHTMLInputElement00](self.impl))

proc webkit_dom_html_input_element_get_multiple(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getMultiple*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_multiple(cast[ptr DOMHTMLInputElement00](self.impl)))

proc multiple*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_multiple(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_name(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_name(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_name(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_read_only(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getReadOnly*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_read_only(cast[ptr DOMHTMLInputElement00](self.impl)))

proc readOnly*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_read_only(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_get_size(self: ptr DOMHTMLInputElement00): uint64 {.
    importc, libprag.}

proc getSize*(self: DOMHTMLInputElement): uint64 =
  webkit_dom_html_input_element_get_size(cast[ptr DOMHTMLInputElement00](self.impl))

proc size*(self: DOMHTMLInputElement): uint64 =
  webkit_dom_html_input_element_get_size(cast[ptr DOMHTMLInputElement00](self.impl))

proc webkit_dom_html_input_element_get_src(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getSrc*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_src(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc src*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_src(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_use_map(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getUseMap*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_use_map(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc useMap*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_use_map(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_value(self: ptr DOMHTMLInputElement00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_value(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMHTMLInputElement): string =
  let resul0 = webkit_dom_html_input_element_get_value(cast[ptr DOMHTMLInputElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_input_element_get_width(self: ptr DOMHTMLInputElement00): uint64 {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLInputElement): uint64 =
  webkit_dom_html_input_element_get_width(cast[ptr DOMHTMLInputElement00](self.impl))

proc width*(self: DOMHTMLInputElement): uint64 =
  webkit_dom_html_input_element_get_width(cast[ptr DOMHTMLInputElement00](self.impl))

proc webkit_dom_html_input_element_get_will_validate(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc getWillValidate*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_will_validate(cast[ptr DOMHTMLInputElement00](self.impl)))

proc willValidate*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_get_will_validate(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_is_edited(self: ptr DOMHTMLInputElement00): gboolean {.
    importc, libprag.}

proc isEdited*(self: DOMHTMLInputElement): bool =
  toBool(webkit_dom_html_input_element_is_edited(cast[ptr DOMHTMLInputElement00](self.impl)))

proc webkit_dom_html_input_element_select(self: ptr DOMHTMLInputElement00) {.
    importc, libprag.}

proc select*(self: DOMHTMLInputElement) =
  webkit_dom_html_input_element_select(cast[ptr DOMHTMLInputElement00](self.impl))

proc webkit_dom_html_input_element_set_accept(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setAccept*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_accept(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `accept=`*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_accept(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_align(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_align(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `align=`*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_align(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_alt(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlt*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_alt(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `alt=`*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_alt(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_auto_filled(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setAutoFilled*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_auto_filled(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `autoFilled=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_auto_filled(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_autofocus(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setAutofocus*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_autofocus(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `autofocus=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_autofocus(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_capture_type(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setCaptureType*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_capture_type(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `captureType=`*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_capture_type(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_checked(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setChecked*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_checked(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `checked=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_checked(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_default_checked(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDefaultChecked*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_default_checked(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `defaultChecked=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_default_checked(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_default_value(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setDefaultValue*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_default_value(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `defaultValue=`*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_default_value(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_disabled(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_disabled(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_disabled(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_editing_value(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setEditingValue*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_editing_value(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `editingValue=`*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_editing_value(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_height(self: ptr DOMHTMLInputElement00;
    value: uint64) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLInputElement;
    value: uint64) =
  webkit_dom_html_input_element_set_height(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `height=`*(self: DOMHTMLInputElement;
    value: uint64) =
  webkit_dom_html_input_element_set_height(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_indeterminate(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setIndeterminate*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_indeterminate(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `indeterminate=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_indeterminate(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_input_type(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setInputType*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_input_type(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `inputType=`*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_input_type(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_max_length(self: ptr DOMHTMLInputElement00;
    value: int64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setMaxLength*(self: DOMHTMLInputElement;
    value: int64) =
  var gerror: ptr glib.Error
  webkit_dom_html_input_element_set_max_length(cast[ptr DOMHTMLInputElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `maxLength=`*(self: DOMHTMLInputElement;
    value: int64) =
  var gerror: ptr glib.Error
  webkit_dom_html_input_element_set_max_length(cast[ptr DOMHTMLInputElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_input_element_set_multiple(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setMultiple*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_multiple(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `multiple=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_multiple(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_name(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_name(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `name=`*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_name(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_read_only(self: ptr DOMHTMLInputElement00;
    value: gboolean) {.
    importc, libprag.}

proc setReadOnly*(self: DOMHTMLInputElement;
    value: bool = true) =
  webkit_dom_html_input_element_set_read_only(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc `readOnly=`*(self: DOMHTMLInputElement;
    value: bool) =
  webkit_dom_html_input_element_set_read_only(cast[ptr DOMHTMLInputElement00](self.impl), gboolean(value))

proc webkit_dom_html_input_element_set_size(self: ptr DOMHTMLInputElement00;
    value: uint64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setSize*(self: DOMHTMLInputElement; value: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_html_input_element_set_size(cast[ptr DOMHTMLInputElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `size=`*(self: DOMHTMLInputElement; value: uint64) =
  var gerror: ptr glib.Error
  webkit_dom_html_input_element_set_size(cast[ptr DOMHTMLInputElement00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_input_element_set_src(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setSrc*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_src(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `src=`*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_src(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_use_map(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setUseMap*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_use_map(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `useMap=`*(self: DOMHTMLInputElement;
    value: cstring) =
  webkit_dom_html_input_element_set_use_map(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_value(self: ptr DOMHTMLInputElement00;
    value: cstring) {.
    importc, libprag.}

proc setValue*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_value(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `value=`*(self: DOMHTMLInputElement; value: cstring) =
  webkit_dom_html_input_element_set_value(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc webkit_dom_html_input_element_set_width(self: ptr DOMHTMLInputElement00;
    value: uint64) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLInputElement; value: uint64) =
  webkit_dom_html_input_element_set_width(cast[ptr DOMHTMLInputElement00](self.impl), value)

proc `width=`*(self: DOMHTMLInputElement; value: uint64) =
  webkit_dom_html_input_element_set_width(cast[ptr DOMHTMLInputElement00](self.impl), value)

type
  DOMHTMLFieldSetElement* = ref object of DOMHTMLElement
  DOMHTMLFieldSetElement00* = object of DOMHTMLElement00

proc webkit_dom_html_field_set_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLFieldSetElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_field_set_element_get_form(self: ptr DOMHTMLFieldSetElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLFieldSetElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_field_set_element_get_form(cast[ptr DOMHTMLFieldSetElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLFieldSetElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_field_set_element_get_form(cast[ptr DOMHTMLFieldSetElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMHTMLOptionElement* = ref object of DOMHTMLElement
  DOMHTMLOptionElement00* = object of DOMHTMLElement00

proc webkit_dom_html_option_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLOptionElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_option_element_get_default_selected(self: ptr DOMHTMLOptionElement00): gboolean {.
    importc, libprag.}

proc getDefaultSelected*(self: DOMHTMLOptionElement): bool =
  toBool(webkit_dom_html_option_element_get_default_selected(cast[ptr DOMHTMLOptionElement00](self.impl)))

proc defaultSelected*(self: DOMHTMLOptionElement): bool =
  toBool(webkit_dom_html_option_element_get_default_selected(cast[ptr DOMHTMLOptionElement00](self.impl)))

proc webkit_dom_html_option_element_get_disabled(self: ptr DOMHTMLOptionElement00): gboolean {.
    importc, libprag.}

proc getDisabled*(self: DOMHTMLOptionElement): bool =
  toBool(webkit_dom_html_option_element_get_disabled(cast[ptr DOMHTMLOptionElement00](self.impl)))

proc disabled*(self: DOMHTMLOptionElement): bool =
  toBool(webkit_dom_html_option_element_get_disabled(cast[ptr DOMHTMLOptionElement00](self.impl)))

proc webkit_dom_html_option_element_get_form(self: ptr DOMHTMLOptionElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLOptionElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_option_element_get_form(cast[ptr DOMHTMLOptionElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLOptionElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_option_element_get_form(cast[ptr DOMHTMLOptionElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_option_element_get_index(self: ptr DOMHTMLOptionElement00): int64 {.
    importc, libprag.}

proc getIndex*(self: DOMHTMLOptionElement): int64 =
  webkit_dom_html_option_element_get_index(cast[ptr DOMHTMLOptionElement00](self.impl))

proc index*(self: DOMHTMLOptionElement): int64 =
  webkit_dom_html_option_element_get_index(cast[ptr DOMHTMLOptionElement00](self.impl))

proc webkit_dom_html_option_element_get_label(self: ptr DOMHTMLOptionElement00): cstring {.
    importc, libprag.}

proc getLabel*(self: DOMHTMLOptionElement): string =
  let resul0 = webkit_dom_html_option_element_get_label(cast[ptr DOMHTMLOptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc label*(self: DOMHTMLOptionElement): string =
  let resul0 = webkit_dom_html_option_element_get_label(cast[ptr DOMHTMLOptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_option_element_get_selected(self: ptr DOMHTMLOptionElement00): gboolean {.
    importc, libprag.}

proc getSelected*(self: DOMHTMLOptionElement): bool =
  toBool(webkit_dom_html_option_element_get_selected(cast[ptr DOMHTMLOptionElement00](self.impl)))

proc selected*(self: DOMHTMLOptionElement): bool =
  toBool(webkit_dom_html_option_element_get_selected(cast[ptr DOMHTMLOptionElement00](self.impl)))

proc webkit_dom_html_option_element_get_text(self: ptr DOMHTMLOptionElement00): cstring {.
    importc, libprag.}

proc getText*(self: DOMHTMLOptionElement): string =
  let resul0 = webkit_dom_html_option_element_get_text(cast[ptr DOMHTMLOptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: DOMHTMLOptionElement): string =
  let resul0 = webkit_dom_html_option_element_get_text(cast[ptr DOMHTMLOptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_option_element_get_value(self: ptr DOMHTMLOptionElement00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMHTMLOptionElement): string =
  let resul0 = webkit_dom_html_option_element_get_value(cast[ptr DOMHTMLOptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMHTMLOptionElement): string =
  let resul0 = webkit_dom_html_option_element_get_value(cast[ptr DOMHTMLOptionElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_option_element_set_default_selected(self: ptr DOMHTMLOptionElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDefaultSelected*(self: DOMHTMLOptionElement;
    value: bool = true) =
  webkit_dom_html_option_element_set_default_selected(cast[ptr DOMHTMLOptionElement00](self.impl), gboolean(value))

proc `defaultSelected=`*(self: DOMHTMLOptionElement;
    value: bool) =
  webkit_dom_html_option_element_set_default_selected(cast[ptr DOMHTMLOptionElement00](self.impl), gboolean(value))

proc webkit_dom_html_option_element_set_disabled(self: ptr DOMHTMLOptionElement00;
    value: gboolean) {.
    importc, libprag.}

proc setDisabled*(self: DOMHTMLOptionElement;
    value: bool = true) =
  webkit_dom_html_option_element_set_disabled(cast[ptr DOMHTMLOptionElement00](self.impl), gboolean(value))

proc `disabled=`*(self: DOMHTMLOptionElement;
    value: bool) =
  webkit_dom_html_option_element_set_disabled(cast[ptr DOMHTMLOptionElement00](self.impl), gboolean(value))

proc webkit_dom_html_option_element_set_label(self: ptr DOMHTMLOptionElement00;
    value: cstring) {.
    importc, libprag.}

proc setLabel*(self: DOMHTMLOptionElement;
    value: cstring) =
  webkit_dom_html_option_element_set_label(cast[ptr DOMHTMLOptionElement00](self.impl), value)

proc `label=`*(self: DOMHTMLOptionElement;
    value: cstring) =
  webkit_dom_html_option_element_set_label(cast[ptr DOMHTMLOptionElement00](self.impl), value)

proc webkit_dom_html_option_element_set_selected(self: ptr DOMHTMLOptionElement00;
    value: gboolean) {.
    importc, libprag.}

proc setSelected*(self: DOMHTMLOptionElement;
    value: bool = true) =
  webkit_dom_html_option_element_set_selected(cast[ptr DOMHTMLOptionElement00](self.impl), gboolean(value))

proc `selected=`*(self: DOMHTMLOptionElement;
    value: bool) =
  webkit_dom_html_option_element_set_selected(cast[ptr DOMHTMLOptionElement00](self.impl), gboolean(value))

proc webkit_dom_html_option_element_set_value(self: ptr DOMHTMLOptionElement00;
    value: cstring) {.
    importc, libprag.}

proc setValue*(self: DOMHTMLOptionElement;
    value: cstring) =
  webkit_dom_html_option_element_set_value(cast[ptr DOMHTMLOptionElement00](self.impl), value)

proc `value=`*(self: DOMHTMLOptionElement;
    value: cstring) =
  webkit_dom_html_option_element_set_value(cast[ptr DOMHTMLOptionElement00](self.impl), value)

type
  DOMHTMLTableElement* = ref object of DOMHTMLElement
  DOMHTMLTableElement00* = object of DOMHTMLElement00

proc webkit_dom_html_table_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLTableElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_table_element_create_caption(self: ptr DOMHTMLTableElement00): ptr DOMHTMLElement00 {.
    importc, libprag.}

proc createCaption*(self: DOMHTMLTableElement): DOMHTMLElement =
  let gobj = webkit_dom_html_table_element_create_caption(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_create_t_foot(self: ptr DOMHTMLTableElement00): ptr DOMHTMLElement00 {.
    importc, libprag.}

proc createTFoot*(self: DOMHTMLTableElement): DOMHTMLElement =
  let gobj = webkit_dom_html_table_element_create_t_foot(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_create_t_head(self: ptr DOMHTMLTableElement00): ptr DOMHTMLElement00 {.
    importc, libprag.}

proc createTHead*(self: DOMHTMLTableElement): DOMHTMLElement =
  let gobj = webkit_dom_html_table_element_create_t_head(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_delete_caption(self: ptr DOMHTMLTableElement00) {.
    importc, libprag.}

proc deleteCaption*(self: DOMHTMLTableElement) =
  webkit_dom_html_table_element_delete_caption(cast[ptr DOMHTMLTableElement00](self.impl))

proc webkit_dom_html_table_element_delete_row(self: ptr DOMHTMLTableElement00;
    index: int64; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc deleteRow*(self: DOMHTMLTableElement;
    index: int64) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_element_delete_row(cast[ptr DOMHTMLTableElement00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_table_element_delete_t_foot(self: ptr DOMHTMLTableElement00) {.
    importc, libprag.}

proc deleteTFoot*(self: DOMHTMLTableElement) =
  webkit_dom_html_table_element_delete_t_foot(cast[ptr DOMHTMLTableElement00](self.impl))

proc webkit_dom_html_table_element_delete_t_head(self: ptr DOMHTMLTableElement00) {.
    importc, libprag.}

proc deleteTHead*(self: DOMHTMLTableElement) =
  webkit_dom_html_table_element_delete_t_head(cast[ptr DOMHTMLTableElement00](self.impl))

proc webkit_dom_html_table_element_get_align(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_align(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_align(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_get_bg_color(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getBgColor*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_bg_color(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc bgColor*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_bg_color(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_get_border(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getBorder*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_border(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc border*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_border(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_get_caption(self: ptr DOMHTMLTableElement00): ptr DOMHTMLTableCaptionElement00 {.
    importc, libprag.}

proc getCaption*(self: DOMHTMLTableElement): DOMHTMLTableCaptionElement =
  let gobj = webkit_dom_html_table_element_get_caption(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc caption*(self: DOMHTMLTableElement): DOMHTMLTableCaptionElement =
  let gobj = webkit_dom_html_table_element_get_caption(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_get_cell_padding(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getCellPadding*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_cell_padding(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cellPadding*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_cell_padding(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_get_cell_spacing(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getCellSpacing*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_cell_spacing(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cellSpacing*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_cell_spacing(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_get_rows(self: ptr DOMHTMLTableElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getRows*(self: DOMHTMLTableElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_element_get_rows(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rows*(self: DOMHTMLTableElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_element_get_rows(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_get_rules(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getRules*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_rules(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc rules*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_rules(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_get_summary(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getSummary*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_summary(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc summary*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_summary(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_get_t_bodies(self: ptr DOMHTMLTableElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getTBodies*(self: DOMHTMLTableElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_element_get_t_bodies(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc tBodies*(self: DOMHTMLTableElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_table_element_get_t_bodies(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_get_t_foot(self: ptr DOMHTMLTableElement00): ptr DOMHTMLTableSectionElement00 {.
    importc, libprag.}

proc getTFoot*(self: DOMHTMLTableElement): DOMHTMLTableSectionElement =
  let gobj = webkit_dom_html_table_element_get_t_foot(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc tFoot*(self: DOMHTMLTableElement): DOMHTMLTableSectionElement =
  let gobj = webkit_dom_html_table_element_get_t_foot(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_get_t_head(self: ptr DOMHTMLTableElement00): ptr DOMHTMLTableSectionElement00 {.
    importc, libprag.}

proc getTHead*(self: DOMHTMLTableElement): DOMHTMLTableSectionElement =
  let gobj = webkit_dom_html_table_element_get_t_head(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc tHead*(self: DOMHTMLTableElement): DOMHTMLTableSectionElement =
  let gobj = webkit_dom_html_table_element_get_t_head(cast[ptr DOMHTMLTableElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_get_width(self: ptr DOMHTMLTableElement00): cstring {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_width(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc width*(self: DOMHTMLTableElement): string =
  let resul0 = webkit_dom_html_table_element_get_width(cast[ptr DOMHTMLTableElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_table_element_insert_row(self: ptr DOMHTMLTableElement00;
    index: int64; error: ptr ptr glib.Error = nil): ptr DOMHTMLElement00 {.
    importc, libprag.}

proc insertRow*(self: DOMHTMLTableElement;
    index: int64): DOMHTMLElement =
  var gerror: ptr glib.Error
  let gobj = webkit_dom_html_table_element_insert_row(cast[ptr DOMHTMLTableElement00](self.impl), index, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_table_element_set_align(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLTableElement; value: cstring) =
  webkit_dom_html_table_element_set_align(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `align=`*(self: DOMHTMLTableElement; value: cstring) =
  webkit_dom_html_table_element_set_align(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc webkit_dom_html_table_element_set_bg_color(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setBgColor*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_bg_color(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `bgColor=`*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_bg_color(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc webkit_dom_html_table_element_set_border(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setBorder*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_border(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `border=`*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_border(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc webkit_dom_html_table_element_set_caption(self: ptr DOMHTMLTableElement00;
    value: ptr DOMHTMLTableCaptionElement00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setCaption*(self: DOMHTMLTableElement;
    value: DOMHTMLTableCaptionElement) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_element_set_caption(cast[ptr DOMHTMLTableElement00](self.impl), cast[ptr DOMHTMLTableCaptionElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `caption=`*(self: DOMHTMLTableElement;
    value: DOMHTMLTableCaptionElement) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_element_set_caption(cast[ptr DOMHTMLTableElement00](self.impl), cast[ptr DOMHTMLTableCaptionElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_table_element_set_cell_padding(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setCellPadding*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_cell_padding(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `cellPadding=`*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_cell_padding(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc webkit_dom_html_table_element_set_cell_spacing(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setCellSpacing*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_cell_spacing(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `cellSpacing=`*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_cell_spacing(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc webkit_dom_html_table_element_set_rules(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setRules*(self: DOMHTMLTableElement; value: cstring) =
  webkit_dom_html_table_element_set_rules(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `rules=`*(self: DOMHTMLTableElement; value: cstring) =
  webkit_dom_html_table_element_set_rules(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc webkit_dom_html_table_element_set_summary(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setSummary*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_summary(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `summary=`*(self: DOMHTMLTableElement;
    value: cstring) =
  webkit_dom_html_table_element_set_summary(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc webkit_dom_html_table_element_set_t_foot(self: ptr DOMHTMLTableElement00;
    value: ptr DOMHTMLTableSectionElement00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setTFoot*(self: DOMHTMLTableElement;
    value: DOMHTMLTableSectionElement) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_element_set_t_foot(cast[ptr DOMHTMLTableElement00](self.impl), cast[ptr DOMHTMLTableSectionElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `tFoot=`*(self: DOMHTMLTableElement;
    value: DOMHTMLTableSectionElement) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_element_set_t_foot(cast[ptr DOMHTMLTableElement00](self.impl), cast[ptr DOMHTMLTableSectionElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_table_element_set_t_head(self: ptr DOMHTMLTableElement00;
    value: ptr DOMHTMLTableSectionElement00; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setTHead*(self: DOMHTMLTableElement;
    value: DOMHTMLTableSectionElement) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_element_set_t_head(cast[ptr DOMHTMLTableElement00](self.impl), cast[ptr DOMHTMLTableSectionElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `tHead=`*(self: DOMHTMLTableElement;
    value: DOMHTMLTableSectionElement) =
  var gerror: ptr glib.Error
  webkit_dom_html_table_element_set_t_head(cast[ptr DOMHTMLTableElement00](self.impl), cast[ptr DOMHTMLTableSectionElement00](value.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_html_table_element_set_width(self: ptr DOMHTMLTableElement00;
    value: cstring) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLTableElement; value: cstring) =
  webkit_dom_html_table_element_set_width(cast[ptr DOMHTMLTableElement00](self.impl), value)

proc `width=`*(self: DOMHTMLTableElement; value: cstring) =
  webkit_dom_html_table_element_set_width(cast[ptr DOMHTMLTableElement00](self.impl), value)

type
  DOMHTMLDirectoryElement* = ref object of DOMHTMLElement
  DOMHTMLDirectoryElement00* = object of DOMHTMLElement00

proc webkit_dom_html_directory_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLDirectoryElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_directory_element_get_compact(self: ptr DOMHTMLDirectoryElement00): gboolean {.
    importc, libprag.}

proc getCompact*(self: DOMHTMLDirectoryElement): bool =
  toBool(webkit_dom_html_directory_element_get_compact(cast[ptr DOMHTMLDirectoryElement00](self.impl)))

proc compact*(self: DOMHTMLDirectoryElement): bool =
  toBool(webkit_dom_html_directory_element_get_compact(cast[ptr DOMHTMLDirectoryElement00](self.impl)))

proc webkit_dom_html_directory_element_set_compact(self: ptr DOMHTMLDirectoryElement00;
    value: gboolean) {.
    importc, libprag.}

proc setCompact*(self: DOMHTMLDirectoryElement;
    value: bool = true) =
  webkit_dom_html_directory_element_set_compact(cast[ptr DOMHTMLDirectoryElement00](self.impl), gboolean(value))

proc `compact=`*(self: DOMHTMLDirectoryElement;
    value: bool) =
  webkit_dom_html_directory_element_set_compact(cast[ptr DOMHTMLDirectoryElement00](self.impl), gboolean(value))

type
  DOMHTMLParagraphElement* = ref object of DOMHTMLElement
  DOMHTMLParagraphElement00* = object of DOMHTMLElement00

proc webkit_dom_html_paragraph_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLParagraphElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_paragraph_element_get_align(self: ptr DOMHTMLParagraphElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLParagraphElement): string =
  let resul0 = webkit_dom_html_paragraph_element_get_align(cast[ptr DOMHTMLParagraphElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLParagraphElement): string =
  let resul0 = webkit_dom_html_paragraph_element_get_align(cast[ptr DOMHTMLParagraphElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_paragraph_element_set_align(self: ptr DOMHTMLParagraphElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLParagraphElement;
    value: cstring) =
  webkit_dom_html_paragraph_element_set_align(cast[ptr DOMHTMLParagraphElement00](self.impl), value)

proc `align=`*(self: DOMHTMLParagraphElement;
    value: cstring) =
  webkit_dom_html_paragraph_element_set_align(cast[ptr DOMHTMLParagraphElement00](self.impl), value)

type
  DOMHTMLIFrameElement* = ref object of DOMHTMLElement
  DOMHTMLIFrameElement00* = object of DOMHTMLElement00

proc webkit_dom_html_iframe_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLIFrameElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_iframe_element_get_align(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_align(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_align(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_content_document(self: ptr DOMHTMLIFrameElement00): ptr DOMDocument00 {.
    importc, libprag.}

proc getContentDocument*(self: DOMHTMLIFrameElement): DOMDocument =
  let gobj = webkit_dom_html_iframe_element_get_content_document(cast[ptr DOMHTMLIFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc contentDocument*(self: DOMHTMLIFrameElement): DOMDocument =
  let gobj = webkit_dom_html_iframe_element_get_content_document(cast[ptr DOMHTMLIFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_iframe_element_get_content_window(self: ptr DOMHTMLIFrameElement00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getContentWindow*(self: DOMHTMLIFrameElement): DOMDOMWindow =
  let gobj = webkit_dom_html_iframe_element_get_content_window(cast[ptr DOMHTMLIFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc contentWindow*(self: DOMHTMLIFrameElement): DOMDOMWindow =
  let gobj = webkit_dom_html_iframe_element_get_content_window(cast[ptr DOMHTMLIFrameElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_iframe_element_get_frame_border(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getFrameBorder*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_frame_border(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc frameBorder*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_frame_border(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_height(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_height(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc height*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_height(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_long_desc(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getLongDesc*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_long_desc(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc longDesc*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_long_desc(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_margin_height(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getMarginHeight*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_margin_height(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc marginHeight*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_margin_height(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_margin_width(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getMarginWidth*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_margin_width(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc marginWidth*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_margin_width(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_name(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_name(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_name(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_scrolling(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getScrolling*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_scrolling(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc scrolling*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_scrolling(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_src(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getSrc*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_src(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc src*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_src(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_get_width(self: ptr DOMHTMLIFrameElement00): cstring {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_width(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc width*(self: DOMHTMLIFrameElement): string =
  let resul0 = webkit_dom_html_iframe_element_get_width(cast[ptr DOMHTMLIFrameElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_iframe_element_set_align(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_align(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `align=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_align(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_frame_border(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setFrameBorder*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_frame_border(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `frameBorder=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_frame_border(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_height(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_height(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `height=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_height(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_long_desc(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setLongDesc*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_long_desc(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `longDesc=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_long_desc(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_margin_height(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setMarginHeight*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_margin_height(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `marginHeight=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_margin_height(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_margin_width(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setMarginWidth*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_margin_width(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `marginWidth=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_margin_width(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_name(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_name(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `name=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_name(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_scrolling(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setScrolling*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_scrolling(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `scrolling=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_scrolling(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_src(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setSrc*(self: DOMHTMLIFrameElement; value: cstring) =
  webkit_dom_html_iframe_element_set_src(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `src=`*(self: DOMHTMLIFrameElement; value: cstring) =
  webkit_dom_html_iframe_element_set_src(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc webkit_dom_html_iframe_element_set_width(self: ptr DOMHTMLIFrameElement00;
    value: cstring) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_width(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

proc `width=`*(self: DOMHTMLIFrameElement;
    value: cstring) =
  webkit_dom_html_iframe_element_set_width(cast[ptr DOMHTMLIFrameElement00](self.impl), value)

type
  DOMHTMLHtmlElement* = ref object of DOMHTMLElement
  DOMHTMLHtmlElement00* = object of DOMHTMLElement00

proc webkit_dom_html_html_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLHtmlElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_html_element_get_version(self: ptr DOMHTMLHtmlElement00): cstring {.
    importc, libprag.}

proc getVersion*(self: DOMHTMLHtmlElement): string =
  let resul0 = webkit_dom_html_html_element_get_version(cast[ptr DOMHTMLHtmlElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc version*(self: DOMHTMLHtmlElement): string =
  let resul0 = webkit_dom_html_html_element_get_version(cast[ptr DOMHTMLHtmlElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_html_element_set_version(self: ptr DOMHTMLHtmlElement00;
    value: cstring) {.
    importc, libprag.}

proc setVersion*(self: DOMHTMLHtmlElement; value: cstring) =
  webkit_dom_html_html_element_set_version(cast[ptr DOMHTMLHtmlElement00](self.impl), value)

proc `version=`*(self: DOMHTMLHtmlElement; value: cstring) =
  webkit_dom_html_html_element_set_version(cast[ptr DOMHTMLHtmlElement00](self.impl), value)

type
  DOMHTMLCanvasElement* = ref object of DOMHTMLElement
  DOMHTMLCanvasElement00* = object of DOMHTMLElement00

proc webkit_dom_html_canvas_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLCanvasElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_canvas_element_get_height(self: ptr DOMHTMLCanvasElement00): int64 {.
    importc, libprag.}

proc getHeight*(self: DOMHTMLCanvasElement): int64 =
  webkit_dom_html_canvas_element_get_height(cast[ptr DOMHTMLCanvasElement00](self.impl))

proc height*(self: DOMHTMLCanvasElement): int64 =
  webkit_dom_html_canvas_element_get_height(cast[ptr DOMHTMLCanvasElement00](self.impl))

proc webkit_dom_html_canvas_element_get_width(self: ptr DOMHTMLCanvasElement00): int64 {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLCanvasElement): int64 =
  webkit_dom_html_canvas_element_get_width(cast[ptr DOMHTMLCanvasElement00](self.impl))

proc width*(self: DOMHTMLCanvasElement): int64 =
  webkit_dom_html_canvas_element_get_width(cast[ptr DOMHTMLCanvasElement00](self.impl))

proc webkit_dom_html_canvas_element_set_height(self: ptr DOMHTMLCanvasElement00;
    value: int64) {.
    importc, libprag.}

proc setHeight*(self: DOMHTMLCanvasElement;
    value: int64) =
  webkit_dom_html_canvas_element_set_height(cast[ptr DOMHTMLCanvasElement00](self.impl), value)

proc `height=`*(self: DOMHTMLCanvasElement;
    value: int64) =
  webkit_dom_html_canvas_element_set_height(cast[ptr DOMHTMLCanvasElement00](self.impl), value)

proc webkit_dom_html_canvas_element_set_width(self: ptr DOMHTMLCanvasElement00;
    value: int64) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLCanvasElement;
    value: int64) =
  webkit_dom_html_canvas_element_set_width(cast[ptr DOMHTMLCanvasElement00](self.impl), value)

proc `width=`*(self: DOMHTMLCanvasElement;
    value: int64) =
  webkit_dom_html_canvas_element_set_width(cast[ptr DOMHTMLCanvasElement00](self.impl), value)

type
  DOMHTMLLabelElement* = ref object of DOMHTMLElement
  DOMHTMLLabelElement00* = object of DOMHTMLElement00

proc webkit_dom_html_label_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLLabelElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_label_element_get_form(self: ptr DOMHTMLLabelElement00): ptr DOMHTMLFormElement00 {.
    importc, libprag.}

proc getForm*(self: DOMHTMLLabelElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_label_element_get_form(cast[ptr DOMHTMLLabelElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc form*(self: DOMHTMLLabelElement): DOMHTMLFormElement =
  let gobj = webkit_dom_html_label_element_get_form(cast[ptr DOMHTMLLabelElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_label_element_get_html_for(self: ptr DOMHTMLLabelElement00): cstring {.
    importc, libprag.}

proc getHtmlFor*(self: DOMHTMLLabelElement): string =
  let resul0 = webkit_dom_html_label_element_get_html_for(cast[ptr DOMHTMLLabelElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc htmlFor*(self: DOMHTMLLabelElement): string =
  let resul0 = webkit_dom_html_label_element_get_html_for(cast[ptr DOMHTMLLabelElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_label_element_set_html_for(self: ptr DOMHTMLLabelElement00;
    value: cstring) {.
    importc, libprag.}

proc setHtmlFor*(self: DOMHTMLLabelElement;
    value: cstring) =
  webkit_dom_html_label_element_set_html_for(cast[ptr DOMHTMLLabelElement00](self.impl), value)

proc `htmlFor=`*(self: DOMHTMLLabelElement;
    value: cstring) =
  webkit_dom_html_label_element_set_html_for(cast[ptr DOMHTMLLabelElement00](self.impl), value)

type
  DOMHTMLDListElement* = ref object of DOMHTMLElement
  DOMHTMLDListElement00* = object of DOMHTMLElement00

proc webkit_dom_html_d_list_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLDListElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_d_list_element_get_compact(self: ptr DOMHTMLDListElement00): gboolean {.
    importc, libprag.}

proc getCompact*(self: DOMHTMLDListElement): bool =
  toBool(webkit_dom_html_d_list_element_get_compact(cast[ptr DOMHTMLDListElement00](self.impl)))

proc compact*(self: DOMHTMLDListElement): bool =
  toBool(webkit_dom_html_d_list_element_get_compact(cast[ptr DOMHTMLDListElement00](self.impl)))

proc webkit_dom_html_d_list_element_set_compact(self: ptr DOMHTMLDListElement00;
    value: gboolean) {.
    importc, libprag.}

proc setCompact*(self: DOMHTMLDListElement;
    value: bool = true) =
  webkit_dom_html_d_list_element_set_compact(cast[ptr DOMHTMLDListElement00](self.impl), gboolean(value))

proc `compact=`*(self: DOMHTMLDListElement;
    value: bool) =
  webkit_dom_html_d_list_element_set_compact(cast[ptr DOMHTMLDListElement00](self.impl), gboolean(value))

type
  DOMHTMLPreElement* = ref object of DOMHTMLElement
  DOMHTMLPreElement00* = object of DOMHTMLElement00

proc webkit_dom_html_pre_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLPreElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_pre_element_get_width(self: ptr DOMHTMLPreElement00): int64 {.
    importc, libprag.}

proc getWidth*(self: DOMHTMLPreElement): int64 =
  webkit_dom_html_pre_element_get_width(cast[ptr DOMHTMLPreElement00](self.impl))

proc width*(self: DOMHTMLPreElement): int64 =
  webkit_dom_html_pre_element_get_width(cast[ptr DOMHTMLPreElement00](self.impl))

proc webkit_dom_html_pre_element_get_wrap(self: ptr DOMHTMLPreElement00): gboolean {.
    importc, libprag.}

proc getWrap*(self: DOMHTMLPreElement): bool =
  toBool(webkit_dom_html_pre_element_get_wrap(cast[ptr DOMHTMLPreElement00](self.impl)))

proc wrap*(self: DOMHTMLPreElement): bool =
  toBool(webkit_dom_html_pre_element_get_wrap(cast[ptr DOMHTMLPreElement00](self.impl)))

proc webkit_dom_html_pre_element_set_width(self: ptr DOMHTMLPreElement00;
    value: int64) {.
    importc, libprag.}

proc setWidth*(self: DOMHTMLPreElement; value: int64) =
  webkit_dom_html_pre_element_set_width(cast[ptr DOMHTMLPreElement00](self.impl), value)

proc `width=`*(self: DOMHTMLPreElement; value: int64) =
  webkit_dom_html_pre_element_set_width(cast[ptr DOMHTMLPreElement00](self.impl), value)

proc webkit_dom_html_pre_element_set_wrap(self: ptr DOMHTMLPreElement00;
    value: gboolean) {.
    importc, libprag.}

proc setWrap*(self: DOMHTMLPreElement; value: bool = true) =
  webkit_dom_html_pre_element_set_wrap(cast[ptr DOMHTMLPreElement00](self.impl), gboolean(value))

proc `wrap=`*(self: DOMHTMLPreElement; value: bool) =
  webkit_dom_html_pre_element_set_wrap(cast[ptr DOMHTMLPreElement00](self.impl), gboolean(value))

type
  DOMHTMLDivElement* = ref object of DOMHTMLElement
  DOMHTMLDivElement00* = object of DOMHTMLElement00

proc webkit_dom_html_div_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLDivElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_div_element_get_align(self: ptr DOMHTMLDivElement00): cstring {.
    importc, libprag.}

proc getAlign*(self: DOMHTMLDivElement): string =
  let resul0 = webkit_dom_html_div_element_get_align(cast[ptr DOMHTMLDivElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc align*(self: DOMHTMLDivElement): string =
  let resul0 = webkit_dom_html_div_element_get_align(cast[ptr DOMHTMLDivElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_div_element_set_align(self: ptr DOMHTMLDivElement00;
    value: cstring) {.
    importc, libprag.}

proc setAlign*(self: DOMHTMLDivElement; value: cstring) =
  webkit_dom_html_div_element_set_align(cast[ptr DOMHTMLDivElement00](self.impl), value)

proc `align=`*(self: DOMHTMLDivElement; value: cstring) =
  webkit_dom_html_div_element_set_align(cast[ptr DOMHTMLDivElement00](self.impl), value)

type
  DOMHTMLMapElement* = ref object of DOMHTMLElement
  DOMHTMLMapElement00* = object of DOMHTMLElement00

proc webkit_dom_html_map_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLMapElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_map_element_get_areas(self: ptr DOMHTMLMapElement00): ptr DOMHTMLCollection00 {.
    importc, libprag.}

proc getAreas*(self: DOMHTMLMapElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_map_element_get_areas(cast[ptr DOMHTMLMapElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc areas*(self: DOMHTMLMapElement): DOMHTMLCollection =
  let gobj = webkit_dom_html_map_element_get_areas(cast[ptr DOMHTMLMapElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_map_element_get_name(self: ptr DOMHTMLMapElement00): cstring {.
    importc, libprag.}

proc getName*(self: DOMHTMLMapElement): string =
  let resul0 = webkit_dom_html_map_element_get_name(cast[ptr DOMHTMLMapElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMHTMLMapElement): string =
  let resul0 = webkit_dom_html_map_element_get_name(cast[ptr DOMHTMLMapElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_map_element_set_name(self: ptr DOMHTMLMapElement00;
    value: cstring) {.
    importc, libprag.}

proc setName*(self: DOMHTMLMapElement; value: cstring) =
  webkit_dom_html_map_element_set_name(cast[ptr DOMHTMLMapElement00](self.impl), value)

proc `name=`*(self: DOMHTMLMapElement; value: cstring) =
  webkit_dom_html_map_element_set_name(cast[ptr DOMHTMLMapElement00](self.impl), value)

type
  DOMHTMLMarqueeElement* = ref object of DOMHTMLElement
  DOMHTMLMarqueeElement00* = object of DOMHTMLElement00

proc webkit_dom_html_marquee_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLMarqueeElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_marquee_element_start(self: ptr DOMHTMLMarqueeElement00) {.
    importc, libprag.}

proc start*(self: DOMHTMLMarqueeElement) =
  webkit_dom_html_marquee_element_start(cast[ptr DOMHTMLMarqueeElement00](self.impl))

proc webkit_dom_html_marquee_element_stop(self: ptr DOMHTMLMarqueeElement00) {.
    importc, libprag.}

proc stop*(self: DOMHTMLMarqueeElement) =
  webkit_dom_html_marquee_element_stop(cast[ptr DOMHTMLMarqueeElement00](self.impl))

type
  DOMHTMLBaseFontElement* = ref object of DOMHTMLElement
  DOMHTMLBaseFontElement00* = object of DOMHTMLElement00

proc webkit_dom_html_base_font_element_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMHTMLBaseFontElement()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_html_base_font_element_get_color(self: ptr DOMHTMLBaseFontElement00): cstring {.
    importc, libprag.}

proc getColor*(self: DOMHTMLBaseFontElement): string =
  let resul0 = webkit_dom_html_base_font_element_get_color(cast[ptr DOMHTMLBaseFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc color*(self: DOMHTMLBaseFontElement): string =
  let resul0 = webkit_dom_html_base_font_element_get_color(cast[ptr DOMHTMLBaseFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_base_font_element_get_face(self: ptr DOMHTMLBaseFontElement00): cstring {.
    importc, libprag.}

proc getFace*(self: DOMHTMLBaseFontElement): string =
  let resul0 = webkit_dom_html_base_font_element_get_face(cast[ptr DOMHTMLBaseFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc face*(self: DOMHTMLBaseFontElement): string =
  let resul0 = webkit_dom_html_base_font_element_get_face(cast[ptr DOMHTMLBaseFontElement00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_html_base_font_element_get_size(self: ptr DOMHTMLBaseFontElement00): int64 {.
    importc, libprag.}

proc getSize*(self: DOMHTMLBaseFontElement): int64 =
  webkit_dom_html_base_font_element_get_size(cast[ptr DOMHTMLBaseFontElement00](self.impl))

proc size*(self: DOMHTMLBaseFontElement): int64 =
  webkit_dom_html_base_font_element_get_size(cast[ptr DOMHTMLBaseFontElement00](self.impl))

proc webkit_dom_html_base_font_element_set_color(self: ptr DOMHTMLBaseFontElement00;
    value: cstring) {.
    importc, libprag.}

proc setColor*(self: DOMHTMLBaseFontElement;
    value: cstring) =
  webkit_dom_html_base_font_element_set_color(cast[ptr DOMHTMLBaseFontElement00](self.impl), value)

proc `color=`*(self: DOMHTMLBaseFontElement;
    value: cstring) =
  webkit_dom_html_base_font_element_set_color(cast[ptr DOMHTMLBaseFontElement00](self.impl), value)

proc webkit_dom_html_base_font_element_set_face(self: ptr DOMHTMLBaseFontElement00;
    value: cstring) {.
    importc, libprag.}

proc setFace*(self: DOMHTMLBaseFontElement;
    value: cstring) =
  webkit_dom_html_base_font_element_set_face(cast[ptr DOMHTMLBaseFontElement00](self.impl), value)

proc `face=`*(self: DOMHTMLBaseFontElement;
    value: cstring) =
  webkit_dom_html_base_font_element_set_face(cast[ptr DOMHTMLBaseFontElement00](self.impl), value)

proc webkit_dom_html_base_font_element_set_size(self: ptr DOMHTMLBaseFontElement00;
    value: int64) {.
    importc, libprag.}

proc setSize*(self: DOMHTMLBaseFontElement;
    value: int64) =
  webkit_dom_html_base_font_element_set_size(cast[ptr DOMHTMLBaseFontElement00](self.impl), value)

proc `size=`*(self: DOMHTMLBaseFontElement;
    value: int64) =
  webkit_dom_html_base_font_element_set_size(cast[ptr DOMHTMLBaseFontElement00](self.impl), value)

proc webkit_dom_event_target_add_event_listener_with_closure(self: ptr DOMEventTarget00;
    eventName: cstring; handler: ptr gobject.Closure00; useCapture: gboolean): gboolean {.
    importc, libprag.}

proc addEventListener*(self: DOMEventTarget | DOMHTMLFrameSetElement | DOMHTMLDocument | DOMNode | DOMAttr | DOMHTMLParamElement | DOMHTMLMenuElement | DOMHTMLObjectElement | DOMHTMLTableCaptionElement | DOMHTMLBodyElement | DOMHTMLEmbedElement | DOMHTMLHRElement | DOMHTMLImageElement | DOMHTMLModElement | DOMHTMLLegendElement | DOMHTMLHeadingElement | DOMHTMLTableColElement | DOMElement | DOMHTMLAppletElement | DOMHTMLTitleElement | DOMHTMLScriptElement | DOMHTMLFontElement | DOMHTMLElement | DOMHTMLButtonElement | DOMHTMLFrameElement | DOMHTMLSelectElement | DOMHTMLTableSectionElement | DOMHTMLTableRowElement | DOMHTMLTextAreaElement | DOMHTMLBRElement | DOMHTMLFormElement | DOMHTMLAnchorElement | DOMHTMLOptGroupElement | DOMHTMLBaseElement | DOMHTMLLIElement | DOMHTMLStyleElement | DOMCDATASection | DOMDocumentFragment | DOMCharacterData | DOMHTMLUListElement | DOMHTMLQuoteElement | DOMHTMLHeadElement | DOMHTMLLinkElement | DOMText | DOMHTMLTableCellElement | DOMHTMLOListElement | DOMHTMLAreaElement | DOMDocument | DOMHTMLMetaElement | DOMHTMLInputElement | DOMHTMLFieldSetElement | DOMHTMLOptionElement | DOMComment | DOMHTMLTableElement | DOMHTMLDirectoryElement | DOMHTMLParagraphElement | DOMHTMLIFrameElement | DOMDOMWindow | DOMHTMLHtmlElement | DOMProcessingInstruction | DOMHTMLCanvasElement | DOMDocumentType | DOMHTMLLabelElement | DOMHTMLDListElement | DOMHTMLPreElement | DOMHTMLDivElement | DOMEntityReference | DOMHTMLMapElement | DOMHTMLMarqueeElement | DOMHTMLBaseFontElement;
    eventName: cstring; handler: gobject.Closure; useCapture: bool): bool =
  toBool(webkit_dom_event_target_add_event_listener_with_closure(cast[ptr DOMEventTarget00](self.impl), eventName, cast[ptr gobject.Closure00](handler.impl), gboolean(useCapture)))

proc webkit_dom_event_target_dispatch_event(self: ptr DOMEventTarget00; event: ptr DOMEvent00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc dispatchEvent*(self: DOMEventTarget | DOMHTMLFrameSetElement | DOMHTMLDocument | DOMNode | DOMAttr | DOMHTMLParamElement | DOMHTMLMenuElement | DOMHTMLObjectElement | DOMHTMLTableCaptionElement | DOMHTMLBodyElement | DOMHTMLEmbedElement | DOMHTMLHRElement | DOMHTMLImageElement | DOMHTMLModElement | DOMHTMLLegendElement | DOMHTMLHeadingElement | DOMHTMLTableColElement | DOMElement | DOMHTMLAppletElement | DOMHTMLTitleElement | DOMHTMLScriptElement | DOMHTMLFontElement | DOMHTMLElement | DOMHTMLButtonElement | DOMHTMLFrameElement | DOMHTMLSelectElement | DOMHTMLTableSectionElement | DOMHTMLTableRowElement | DOMHTMLTextAreaElement | DOMHTMLBRElement | DOMHTMLFormElement | DOMHTMLAnchorElement | DOMHTMLOptGroupElement | DOMHTMLBaseElement | DOMHTMLLIElement | DOMHTMLStyleElement | DOMCDATASection | DOMDocumentFragment | DOMCharacterData | DOMHTMLUListElement | DOMHTMLQuoteElement | DOMHTMLHeadElement | DOMHTMLLinkElement | DOMText | DOMHTMLTableCellElement | DOMHTMLOListElement | DOMHTMLAreaElement | DOMDocument | DOMHTMLMetaElement | DOMHTMLInputElement | DOMHTMLFieldSetElement | DOMHTMLOptionElement | DOMComment | DOMHTMLTableElement | DOMHTMLDirectoryElement | DOMHTMLParagraphElement | DOMHTMLIFrameElement | DOMDOMWindow | DOMHTMLHtmlElement | DOMProcessingInstruction | DOMHTMLCanvasElement | DOMDocumentType | DOMHTMLLabelElement | DOMHTMLDListElement | DOMHTMLPreElement | DOMHTMLDivElement | DOMEntityReference | DOMHTMLMapElement | DOMHTMLMarqueeElement | DOMHTMLBaseFontElement;
    event: DOMEvent): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_event_target_dispatch_event(cast[ptr DOMEventTarget00](self.impl), cast[ptr DOMEvent00](event.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_event_target_remove_event_listener_with_closure(self: ptr DOMEventTarget00;
    eventName: cstring; handler: ptr gobject.Closure00; useCapture: gboolean): gboolean {.
    importc, libprag.}

proc removeEventListener*(self: DOMEventTarget | DOMHTMLFrameSetElement | DOMHTMLDocument | DOMNode | DOMAttr | DOMHTMLParamElement | DOMHTMLMenuElement | DOMHTMLObjectElement | DOMHTMLTableCaptionElement | DOMHTMLBodyElement | DOMHTMLEmbedElement | DOMHTMLHRElement | DOMHTMLImageElement | DOMHTMLModElement | DOMHTMLLegendElement | DOMHTMLHeadingElement | DOMHTMLTableColElement | DOMElement | DOMHTMLAppletElement | DOMHTMLTitleElement | DOMHTMLScriptElement | DOMHTMLFontElement | DOMHTMLElement | DOMHTMLButtonElement | DOMHTMLFrameElement | DOMHTMLSelectElement | DOMHTMLTableSectionElement | DOMHTMLTableRowElement | DOMHTMLTextAreaElement | DOMHTMLBRElement | DOMHTMLFormElement | DOMHTMLAnchorElement | DOMHTMLOptGroupElement | DOMHTMLBaseElement | DOMHTMLLIElement | DOMHTMLStyleElement | DOMCDATASection | DOMDocumentFragment | DOMCharacterData | DOMHTMLUListElement | DOMHTMLQuoteElement | DOMHTMLHeadElement | DOMHTMLLinkElement | DOMText | DOMHTMLTableCellElement | DOMHTMLOListElement | DOMHTMLAreaElement | DOMDocument | DOMHTMLMetaElement | DOMHTMLInputElement | DOMHTMLFieldSetElement | DOMHTMLOptionElement | DOMComment | DOMHTMLTableElement | DOMHTMLDirectoryElement | DOMHTMLParagraphElement | DOMHTMLIFrameElement | DOMDOMWindow | DOMHTMLHtmlElement | DOMProcessingInstruction | DOMHTMLCanvasElement | DOMDocumentType | DOMHTMLLabelElement | DOMHTMLDListElement | DOMHTMLPreElement | DOMHTMLDivElement | DOMEntityReference | DOMHTMLMapElement | DOMHTMLMarqueeElement | DOMHTMLBaseFontElement;
    eventName: cstring; handler: gobject.Closure; useCapture: bool): bool =
  toBool(webkit_dom_event_target_remove_event_listener_with_closure(cast[ptr DOMEventTarget00](self.impl), eventName, cast[ptr gobject.Closure00](handler.impl), gboolean(useCapture)))

type
  DOMFileList* = ref object of DOMObject
  DOMFileList00* = object of DOMObject00

proc webkit_dom_file_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMFileList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_file_list_get_length(self: ptr DOMFileList00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMFileList): uint64 =
  webkit_dom_file_list_get_length(cast[ptr DOMFileList00](self.impl))

proc length*(self: DOMFileList): uint64 =
  webkit_dom_file_list_get_length(cast[ptr DOMFileList00](self.impl))

proc webkit_dom_html_input_element_get_files(self: ptr DOMHTMLInputElement00): ptr DOMFileList00 {.
    importc, libprag.}

proc getFiles*(self: DOMHTMLInputElement): DOMFileList =
  let gobj = webkit_dom_html_input_element_get_files(cast[ptr DOMHTMLInputElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc files*(self: DOMHTMLInputElement): DOMFileList =
  let gobj = webkit_dom_html_input_element_get_files(cast[ptr DOMHTMLInputElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_input_element_set_files(self: ptr DOMHTMLInputElement00;
    value: ptr DOMFileList00) {.
    importc, libprag.}

proc setFiles*(self: DOMHTMLInputElement; value: DOMFileList) =
  webkit_dom_html_input_element_set_files(cast[ptr DOMHTMLInputElement00](self.impl), cast[ptr DOMFileList00](value.impl))

proc `files=`*(self: DOMHTMLInputElement; value: DOMFileList) =
  webkit_dom_html_input_element_set_files(cast[ptr DOMHTMLInputElement00](self.impl), cast[ptr DOMFileList00](value.impl))

type
  DOMBlob* = ref object of DOMObject
  DOMBlob00* = object of DOMObject00

proc webkit_dom_blob_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMBlob()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_blob_get_size(self: ptr DOMBlob00): uint64 {.
    importc, libprag.}

proc getSize*(self: DOMBlob): uint64 =
  webkit_dom_blob_get_size(cast[ptr DOMBlob00](self.impl))

proc size*(self: DOMBlob): uint64 =
  webkit_dom_blob_get_size(cast[ptr DOMBlob00](self.impl))

type
  DOMFile* = ref object of DOMBlob
  DOMFile00* = object of DOMBlob00

proc webkit_dom_file_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMFile()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_file_get_name(self: ptr DOMFile00): cstring {.
    importc, libprag.}

proc getName*(self: DOMFile): string =
  let resul0 = webkit_dom_file_get_name(cast[ptr DOMFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: DOMFile): string =
  let resul0 = webkit_dom_file_get_name(cast[ptr DOMFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_file_list_item(self: ptr DOMFileList00; index: uint64): ptr DOMFile00 {.
    importc, libprag.}

proc item*(self: DOMFileList; index: uint64): DOMFile =
  let gobj = webkit_dom_file_list_item(cast[ptr DOMFileList00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMClientRect* = ref object of DOMObject
  DOMClientRect00* = object of DOMObject00

proc webkit_dom_client_rect_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMClientRect()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_client_rect_get_bottom(self: ptr DOMClientRect00): cfloat {.
    importc, libprag.}

proc getBottom*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_bottom(cast[ptr DOMClientRect00](self.impl))

proc bottom*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_bottom(cast[ptr DOMClientRect00](self.impl))

proc webkit_dom_client_rect_get_height(self: ptr DOMClientRect00): cfloat {.
    importc, libprag.}

proc getHeight*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_height(cast[ptr DOMClientRect00](self.impl))

proc height*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_height(cast[ptr DOMClientRect00](self.impl))

proc webkit_dom_client_rect_get_left(self: ptr DOMClientRect00): cfloat {.
    importc, libprag.}

proc getLeft*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_left(cast[ptr DOMClientRect00](self.impl))

proc left*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_left(cast[ptr DOMClientRect00](self.impl))

proc webkit_dom_client_rect_get_right(self: ptr DOMClientRect00): cfloat {.
    importc, libprag.}

proc getRight*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_right(cast[ptr DOMClientRect00](self.impl))

proc right*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_right(cast[ptr DOMClientRect00](self.impl))

proc webkit_dom_client_rect_get_top(self: ptr DOMClientRect00): cfloat {.
    importc, libprag.}

proc getTop*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_top(cast[ptr DOMClientRect00](self.impl))

proc top*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_top(cast[ptr DOMClientRect00](self.impl))

proc webkit_dom_client_rect_get_width(self: ptr DOMClientRect00): cfloat {.
    importc, libprag.}

proc getWidth*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_width(cast[ptr DOMClientRect00](self.impl))

proc width*(self: DOMClientRect): cfloat =
  webkit_dom_client_rect_get_width(cast[ptr DOMClientRect00](self.impl))

proc webkit_dom_element_get_bounding_client_rect(self: ptr DOMElement00): ptr DOMClientRect00 {.
    importc, libprag.}

proc getBoundingClientRect*(self: DOMElement): DOMClientRect =
  let gobj = webkit_dom_element_get_bounding_client_rect(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc boundingClientRect*(self: DOMElement): DOMClientRect =
  let gobj = webkit_dom_element_get_bounding_client_rect(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMDOMTokenList* = ref object of DOMObject
  DOMDOMTokenList00* = object of DOMObject00

proc webkit_dom_dom_token_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMDOMTokenList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_dom_token_list_contains(self: ptr DOMDOMTokenList00; token: cstring): gboolean {.
    importc, libprag.}

proc contains*(self: DOMDOMTokenList; token: cstring): bool =
  toBool(webkit_dom_dom_token_list_contains(cast[ptr DOMDOMTokenList00](self.impl), token))

proc webkit_dom_dom_token_list_get_length(self: ptr DOMDOMTokenList00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMDOMTokenList): uint64 =
  webkit_dom_dom_token_list_get_length(cast[ptr DOMDOMTokenList00](self.impl))

proc length*(self: DOMDOMTokenList): uint64 =
  webkit_dom_dom_token_list_get_length(cast[ptr DOMDOMTokenList00](self.impl))

proc webkit_dom_dom_token_list_get_value(self: ptr DOMDOMTokenList00): cstring {.
    importc, libprag.}

proc getValue*(self: DOMDOMTokenList): string =
  let resul0 = webkit_dom_dom_token_list_get_value(cast[ptr DOMDOMTokenList00](self.impl))
  result = $resul0
  cogfree(resul0)

proc value*(self: DOMDOMTokenList): string =
  let resul0 = webkit_dom_dom_token_list_get_value(cast[ptr DOMDOMTokenList00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_dom_token_list_item(self: ptr DOMDOMTokenList00; index: uint64): cstring {.
    importc, libprag.}

proc item*(self: DOMDOMTokenList; index: uint64): string =
  let resul0 = webkit_dom_dom_token_list_item(cast[ptr DOMDOMTokenList00](self.impl), index)
  result = $resul0
  cogfree(resul0)

proc webkit_dom_dom_token_list_replace(self: ptr DOMDOMTokenList00; token: cstring;
    newToken: cstring; error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc replace*(self: DOMDOMTokenList; token: cstring;
    newToken: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_dom_token_list_replace(cast[ptr DOMDOMTokenList00](self.impl), token, newToken, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc webkit_dom_dom_token_list_set_value(self: ptr DOMDOMTokenList00; value: cstring) {.
    importc, libprag.}

proc setValue*(self: DOMDOMTokenList; value: cstring) =
  webkit_dom_dom_token_list_set_value(cast[ptr DOMDOMTokenList00](self.impl), value)

proc `value=`*(self: DOMDOMTokenList; value: cstring) =
  webkit_dom_dom_token_list_set_value(cast[ptr DOMDOMTokenList00](self.impl), value)

proc webkit_dom_dom_token_list_toggle(self: ptr DOMDOMTokenList00; token: cstring;
    force: gboolean; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc toggle*(self: DOMDOMTokenList; token: cstring;
    force: bool): bool =
  var gerror: ptr glib.Error
  let resul0 = webkit_dom_dom_token_list_toggle(cast[ptr DOMDOMTokenList00](self.impl), token, gboolean(force), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc webkit_dom_element_get_class_list(self: ptr DOMElement00): ptr DOMDOMTokenList00 {.
    importc, libprag.}

proc getClassList*(self: DOMElement): DOMDOMTokenList =
  let gobj = webkit_dom_element_get_class_list(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc classList*(self: DOMElement): DOMDOMTokenList =
  let gobj = webkit_dom_element_get_class_list(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_html_link_element_get_sizes(self: ptr DOMHTMLLinkElement00): ptr DOMDOMTokenList00 {.
    importc, libprag.}

proc getSizes*(self: DOMHTMLLinkElement): DOMDOMTokenList =
  let gobj = webkit_dom_html_link_element_get_sizes(cast[ptr DOMHTMLLinkElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc sizes*(self: DOMHTMLLinkElement): DOMDOMTokenList =
  let gobj = webkit_dom_html_link_element_get_sizes(cast[ptr DOMHTMLLinkElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMClientRectList* = ref object of DOMObject
  DOMClientRectList00* = object of DOMObject00

proc webkit_dom_client_rect_list_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMClientRectList()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_client_rect_list_get_length(self: ptr DOMClientRectList00): uint64 {.
    importc, libprag.}

proc getLength*(self: DOMClientRectList): uint64 =
  webkit_dom_client_rect_list_get_length(cast[ptr DOMClientRectList00](self.impl))

proc length*(self: DOMClientRectList): uint64 =
  webkit_dom_client_rect_list_get_length(cast[ptr DOMClientRectList00](self.impl))

proc webkit_dom_client_rect_list_item(self: ptr DOMClientRectList00; index: uint64): ptr DOMClientRect00 {.
    importc, libprag.}

proc item*(self: DOMClientRectList; index: uint64): DOMClientRect =
  let gobj = webkit_dom_client_rect_list_item(cast[ptr DOMClientRectList00](self.impl), index)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_element_get_client_rects(self: ptr DOMElement00): ptr DOMClientRectList00 {.
    importc, libprag.}

proc getClientRects*(self: DOMElement): DOMClientRectList =
  let gobj = webkit_dom_element_get_client_rects(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc clientRects*(self: DOMElement): DOMClientRectList =
  let gobj = webkit_dom_element_get_client_rects(cast[ptr DOMElement00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  DOMCSSValue* = ref object of DOMObject
  DOMCSSValue00* = object of DOMObject00

proc webkit_dom_css_value_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMCSSValue()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_css_value_get_css_text(self: ptr DOMCSSValue00): cstring {.
    importc, libprag.}

proc getCssText*(self: DOMCSSValue): string =
  let resul0 = webkit_dom_css_value_get_css_text(cast[ptr DOMCSSValue00](self.impl))
  result = $resul0
  cogfree(resul0)

proc cssText*(self: DOMCSSValue): string =
  let resul0 = webkit_dom_css_value_get_css_text(cast[ptr DOMCSSValue00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_css_value_get_css_value_type(self: ptr DOMCSSValue00): uint16 {.
    importc, libprag.}

proc getCssValueType*(self: DOMCSSValue): uint16 =
  webkit_dom_css_value_get_css_value_type(cast[ptr DOMCSSValue00](self.impl))

proc cssValueType*(self: DOMCSSValue): uint16 =
  webkit_dom_css_value_get_css_value_type(cast[ptr DOMCSSValue00](self.impl))

proc webkit_dom_css_value_set_css_text(self: ptr DOMCSSValue00; value: cstring;
    error: ptr ptr glib.Error = nil) {.
    importc, libprag.}

proc setCssText*(self: DOMCSSValue; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_css_value_set_css_text(cast[ptr DOMCSSValue00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

proc `cssText=`*(self: DOMCSSValue; value: cstring) =
  var gerror: ptr glib.Error
  webkit_dom_css_value_set_css_text(cast[ptr DOMCSSValue00](self.impl), value, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)

type
  DOMUIEvent* = ref object of DOMEvent
  DOMUIEvent00* = object of DOMEvent00

proc webkit_dom_ui_event_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMUIEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_ui_event_get_char_code(self: ptr DOMUIEvent00): int64 {.
    importc, libprag.}

proc getCharCode*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_char_code(cast[ptr DOMUIEvent00](self.impl))

proc charCode*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_char_code(cast[ptr DOMUIEvent00](self.impl))

proc webkit_dom_ui_event_get_detail(self: ptr DOMUIEvent00): int64 {.
    importc, libprag.}

proc getDetail*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_detail(cast[ptr DOMUIEvent00](self.impl))

proc detail*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_detail(cast[ptr DOMUIEvent00](self.impl))

proc webkit_dom_ui_event_get_key_code(self: ptr DOMUIEvent00): int64 {.
    importc, libprag.}

proc getKeyCode*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_key_code(cast[ptr DOMUIEvent00](self.impl))

proc keyCode*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_key_code(cast[ptr DOMUIEvent00](self.impl))

proc webkit_dom_ui_event_get_layer_x(self: ptr DOMUIEvent00): int64 {.
    importc, libprag.}

proc getLayerX*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_layer_x(cast[ptr DOMUIEvent00](self.impl))

proc layerX*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_layer_x(cast[ptr DOMUIEvent00](self.impl))

proc webkit_dom_ui_event_get_layer_y(self: ptr DOMUIEvent00): int64 {.
    importc, libprag.}

proc getLayerY*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_layer_y(cast[ptr DOMUIEvent00](self.impl))

proc layerY*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_layer_y(cast[ptr DOMUIEvent00](self.impl))

proc webkit_dom_ui_event_get_page_x(self: ptr DOMUIEvent00): int64 {.
    importc, libprag.}

proc getPageX*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_page_x(cast[ptr DOMUIEvent00](self.impl))

proc pageX*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_page_x(cast[ptr DOMUIEvent00](self.impl))

proc webkit_dom_ui_event_get_page_y(self: ptr DOMUIEvent00): int64 {.
    importc, libprag.}

proc getPageY*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_page_y(cast[ptr DOMUIEvent00](self.impl))

proc pageY*(self: DOMUIEvent): int64 =
  webkit_dom_ui_event_get_page_y(cast[ptr DOMUIEvent00](self.impl))

proc webkit_dom_ui_event_get_view(self: ptr DOMUIEvent00): ptr DOMDOMWindow00 {.
    importc, libprag.}

proc getView*(self: DOMUIEvent): DOMDOMWindow =
  let gobj = webkit_dom_ui_event_get_view(cast[ptr DOMUIEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: DOMUIEvent): DOMDOMWindow =
  let gobj = webkit_dom_ui_event_get_view(cast[ptr DOMUIEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_ui_event_init_ui_event(self: ptr DOMUIEvent00; `type`: cstring;
    canBubble: gboolean; cancelable: gboolean; view: ptr DOMDOMWindow00; detail: int64) {.
    importc, libprag.}

proc initUiEvent*(self: DOMUIEvent; `type`: cstring;
    canBubble: bool; cancelable: bool; view: DOMDOMWindow; detail: int64) =
  webkit_dom_ui_event_init_ui_event(cast[ptr DOMUIEvent00](self.impl), `type`, gboolean(canBubble), gboolean(cancelable), cast[ptr DOMDOMWindow00](view.impl), detail)

type
  DOMKeyboardEvent* = ref object of DOMUIEvent
  DOMKeyboardEvent00* = object of DOMUIEvent00

proc webkit_dom_keyboard_event_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMKeyboardEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_keyboard_event_get_alt_graph_key(self: ptr DOMKeyboardEvent00): gboolean {.
    importc, libprag.}

proc getAltGraphKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_alt_graph_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc altGraphKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_alt_graph_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc webkit_dom_keyboard_event_get_alt_key(self: ptr DOMKeyboardEvent00): gboolean {.
    importc, libprag.}

proc getAltKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_alt_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc altKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_alt_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc webkit_dom_keyboard_event_get_ctrl_key(self: ptr DOMKeyboardEvent00): gboolean {.
    importc, libprag.}

proc getCtrlKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_ctrl_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc ctrlKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_ctrl_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc webkit_dom_keyboard_event_get_key_identifier(self: ptr DOMKeyboardEvent00): cstring {.
    importc, libprag.}

proc getKeyIdentifier*(self: DOMKeyboardEvent): string =
  let resul0 = webkit_dom_keyboard_event_get_key_identifier(cast[ptr DOMKeyboardEvent00](self.impl))
  result = $resul0
  cogfree(resul0)

proc keyIdentifier*(self: DOMKeyboardEvent): string =
  let resul0 = webkit_dom_keyboard_event_get_key_identifier(cast[ptr DOMKeyboardEvent00](self.impl))
  result = $resul0
  cogfree(resul0)

proc webkit_dom_keyboard_event_get_key_location(self: ptr DOMKeyboardEvent00): uint64 {.
    importc, libprag.}

proc getKeyLocation*(self: DOMKeyboardEvent): uint64 =
  webkit_dom_keyboard_event_get_key_location(cast[ptr DOMKeyboardEvent00](self.impl))

proc keyLocation*(self: DOMKeyboardEvent): uint64 =
  webkit_dom_keyboard_event_get_key_location(cast[ptr DOMKeyboardEvent00](self.impl))

proc webkit_dom_keyboard_event_get_meta_key(self: ptr DOMKeyboardEvent00): gboolean {.
    importc, libprag.}

proc getMetaKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_meta_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc metaKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_meta_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc webkit_dom_keyboard_event_get_modifier_state(self: ptr DOMKeyboardEvent00;
    keyIdentifierArg: cstring): gboolean {.
    importc, libprag.}

proc getModifierState*(self: DOMKeyboardEvent;
    keyIdentifierArg: cstring): bool =
  toBool(webkit_dom_keyboard_event_get_modifier_state(cast[ptr DOMKeyboardEvent00](self.impl), keyIdentifierArg))

proc webkit_dom_keyboard_event_get_shift_key(self: ptr DOMKeyboardEvent00): gboolean {.
    importc, libprag.}

proc getShiftKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_shift_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc shiftKey*(self: DOMKeyboardEvent): bool =
  toBool(webkit_dom_keyboard_event_get_shift_key(cast[ptr DOMKeyboardEvent00](self.impl)))

proc webkit_dom_keyboard_event_init_keyboard_event(self: ptr DOMKeyboardEvent00;
    `type`: cstring; canBubble: gboolean; cancelable: gboolean; view: ptr DOMDOMWindow00;
    keyIdentifier: cstring; location: uint64; ctrlKey: gboolean; altKey: gboolean;
    shiftKey: gboolean; metaKey: gboolean; altGraphKey: gboolean) {.
    importc, libprag.}

proc initKeyboardEvent*(self: DOMKeyboardEvent;
    `type`: cstring; canBubble: bool; cancelable: bool; view: DOMDOMWindow;
    keyIdentifier: cstring; location: uint64; ctrlKey: bool; altKey: bool;
    shiftKey: bool; metaKey: bool; altGraphKey: bool) =
  webkit_dom_keyboard_event_init_keyboard_event(cast[ptr DOMKeyboardEvent00](self.impl), `type`, gboolean(canBubble), gboolean(cancelable), cast[ptr DOMDOMWindow00](view.impl), keyIdentifier, location, gboolean(ctrlKey), gboolean(altKey), gboolean(shiftKey), gboolean(metaKey), gboolean(altGraphKey))

type
  DOMMouseEvent* = ref object of DOMUIEvent
  DOMMouseEvent00* = object of DOMUIEvent00

proc webkit_dom_mouse_event_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMMouseEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_mouse_event_get_alt_key(self: ptr DOMMouseEvent00): gboolean {.
    importc, libprag.}

proc getAltKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_alt_key(cast[ptr DOMMouseEvent00](self.impl)))

proc altKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_alt_key(cast[ptr DOMMouseEvent00](self.impl)))

proc webkit_dom_mouse_event_get_button(self: ptr DOMMouseEvent00): uint16 {.
    importc, libprag.}

proc getButton*(self: DOMMouseEvent): uint16 =
  webkit_dom_mouse_event_get_button(cast[ptr DOMMouseEvent00](self.impl))

proc button*(self: DOMMouseEvent): uint16 =
  webkit_dom_mouse_event_get_button(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_client_x(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getClientX*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_client_x(cast[ptr DOMMouseEvent00](self.impl))

proc clientX*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_client_x(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_client_y(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getClientY*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_client_y(cast[ptr DOMMouseEvent00](self.impl))

proc clientY*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_client_y(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_ctrl_key(self: ptr DOMMouseEvent00): gboolean {.
    importc, libprag.}

proc getCtrlKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_ctrl_key(cast[ptr DOMMouseEvent00](self.impl)))

proc ctrlKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_ctrl_key(cast[ptr DOMMouseEvent00](self.impl)))

proc webkit_dom_mouse_event_get_from_element(self: ptr DOMMouseEvent00): ptr DOMNode00 {.
    importc, libprag.}

proc getFromElement*(self: DOMMouseEvent): DOMNode =
  let gobj = webkit_dom_mouse_event_get_from_element(cast[ptr DOMMouseEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc fromElement*(self: DOMMouseEvent): DOMNode =
  let gobj = webkit_dom_mouse_event_get_from_element(cast[ptr DOMMouseEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_mouse_event_get_meta_key(self: ptr DOMMouseEvent00): gboolean {.
    importc, libprag.}

proc getMetaKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_meta_key(cast[ptr DOMMouseEvent00](self.impl)))

proc metaKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_meta_key(cast[ptr DOMMouseEvent00](self.impl)))

proc webkit_dom_mouse_event_get_offset_x(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getOffsetX*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_offset_x(cast[ptr DOMMouseEvent00](self.impl))

proc offsetX*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_offset_x(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_offset_y(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getOffsetY*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_offset_y(cast[ptr DOMMouseEvent00](self.impl))

proc offsetY*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_offset_y(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_related_target(self: ptr DOMMouseEvent00): ptr DOMEventTarget00 {.
    importc, libprag.}

proc getRelatedTarget*(self: DOMMouseEvent): DOMEventTarget =
  let gobj = webkit_dom_mouse_event_get_related_target(cast[ptr DOMMouseEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc relatedTarget*(self: DOMMouseEvent): DOMEventTarget =
  let gobj = webkit_dom_mouse_event_get_related_target(cast[ptr DOMMouseEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_mouse_event_get_screen_x(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getScreenX*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_screen_x(cast[ptr DOMMouseEvent00](self.impl))

proc screenX*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_screen_x(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_screen_y(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getScreenY*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_screen_y(cast[ptr DOMMouseEvent00](self.impl))

proc screenY*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_screen_y(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_shift_key(self: ptr DOMMouseEvent00): gboolean {.
    importc, libprag.}

proc getShiftKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_shift_key(cast[ptr DOMMouseEvent00](self.impl)))

proc shiftKey*(self: DOMMouseEvent): bool =
  toBool(webkit_dom_mouse_event_get_shift_key(cast[ptr DOMMouseEvent00](self.impl)))

proc webkit_dom_mouse_event_get_to_element(self: ptr DOMMouseEvent00): ptr DOMNode00 {.
    importc, libprag.}

proc getToElement*(self: DOMMouseEvent): DOMNode =
  let gobj = webkit_dom_mouse_event_get_to_element(cast[ptr DOMMouseEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc toElement*(self: DOMMouseEvent): DOMNode =
  let gobj = webkit_dom_mouse_event_get_to_element(cast[ptr DOMMouseEvent00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_dom_mouse_event_get_x(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getX*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_x(cast[ptr DOMMouseEvent00](self.impl))

proc x*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_x(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_get_y(self: ptr DOMMouseEvent00): int64 {.
    importc, libprag.}

proc getY*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_y(cast[ptr DOMMouseEvent00](self.impl))

proc y*(self: DOMMouseEvent): int64 =
  webkit_dom_mouse_event_get_y(cast[ptr DOMMouseEvent00](self.impl))

proc webkit_dom_mouse_event_init_mouse_event(self: ptr DOMMouseEvent00; `type`: cstring;
    canBubble: gboolean; cancelable: gboolean; view: ptr DOMDOMWindow00; detail: int64;
    screenX: int64; screenY: int64; clientX: int64; clientY: int64; ctrlKey: gboolean;
    altKey: gboolean; shiftKey: gboolean; metaKey: gboolean; button: uint16;
    relatedTarget: ptr DOMEventTarget00) {.
    importc, libprag.}

proc initMouseEvent*(self: DOMMouseEvent; `type`: cstring;
    canBubble: bool; cancelable: bool; view: DOMDOMWindow; detail: int64; screenX: int64;
    screenY: int64; clientX: int64; clientY: int64; ctrlKey: bool; altKey: bool;
    shiftKey: bool; metaKey: bool; button: uint16; relatedTarget: DOMEventTarget | DOMHTMLFrameSetElement | DOMHTMLDocument | DOMNode | DOMAttr | DOMHTMLParamElement | DOMHTMLMenuElement | DOMHTMLObjectElement | DOMHTMLTableCaptionElement | DOMHTMLBodyElement | DOMHTMLEmbedElement | DOMHTMLHRElement | DOMHTMLImageElement | DOMHTMLModElement | DOMHTMLLegendElement | DOMHTMLHeadingElement | DOMHTMLTableColElement | DOMElement | DOMHTMLAppletElement | DOMHTMLTitleElement | DOMHTMLScriptElement | DOMHTMLFontElement | DOMHTMLElement | DOMHTMLButtonElement | DOMHTMLFrameElement | DOMHTMLSelectElement | DOMHTMLTableSectionElement | DOMHTMLTableRowElement | DOMHTMLTextAreaElement | DOMHTMLBRElement | DOMHTMLFormElement | DOMHTMLAnchorElement | DOMHTMLOptGroupElement | DOMHTMLBaseElement | DOMHTMLLIElement | DOMHTMLStyleElement | DOMCDATASection | DOMDocumentFragment | DOMCharacterData | DOMHTMLUListElement | DOMHTMLQuoteElement | DOMHTMLHeadElement | DOMHTMLLinkElement | DOMText | DOMHTMLTableCellElement | DOMHTMLOListElement | DOMHTMLAreaElement | DOMDocument | DOMHTMLMetaElement | DOMHTMLInputElement | DOMHTMLFieldSetElement | DOMHTMLOptionElement | DOMComment | DOMHTMLTableElement | DOMHTMLDirectoryElement | DOMHTMLParagraphElement | DOMHTMLIFrameElement | DOMDOMWindow | DOMHTMLHtmlElement | DOMProcessingInstruction | DOMHTMLCanvasElement | DOMDocumentType | DOMHTMLLabelElement | DOMHTMLDListElement | DOMHTMLPreElement | DOMHTMLDivElement | DOMEntityReference | DOMHTMLMapElement | DOMHTMLMarqueeElement | DOMHTMLBaseFontElement) =
  webkit_dom_mouse_event_init_mouse_event(cast[ptr DOMMouseEvent00](self.impl), `type`, gboolean(canBubble), gboolean(cancelable), cast[ptr DOMDOMWindow00](view.impl), detail, screenX, screenY, clientX, clientY, gboolean(ctrlKey), gboolean(altKey), gboolean(shiftKey), gboolean(metaKey), button, cast[ptr DOMEventTarget00](relatedTarget.impl))

type
  DOMWheelEvent* = ref object of DOMMouseEvent
  DOMWheelEvent00* = object of DOMMouseEvent00

proc webkit_dom_wheel_event_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(DOMWheelEvent()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_dom_wheel_event_get_wheel_delta(self: ptr DOMWheelEvent00): int64 {.
    importc, libprag.}

proc getWheelDelta*(self: DOMWheelEvent): int64 =
  webkit_dom_wheel_event_get_wheel_delta(cast[ptr DOMWheelEvent00](self.impl))

proc wheelDelta*(self: DOMWheelEvent): int64 =
  webkit_dom_wheel_event_get_wheel_delta(cast[ptr DOMWheelEvent00](self.impl))

proc webkit_dom_wheel_event_get_wheel_delta_x(self: ptr DOMWheelEvent00): int64 {.
    importc, libprag.}

proc getWheelDeltaX*(self: DOMWheelEvent): int64 =
  webkit_dom_wheel_event_get_wheel_delta_x(cast[ptr DOMWheelEvent00](self.impl))

proc wheelDeltaX*(self: DOMWheelEvent): int64 =
  webkit_dom_wheel_event_get_wheel_delta_x(cast[ptr DOMWheelEvent00](self.impl))

proc webkit_dom_wheel_event_get_wheel_delta_y(self: ptr DOMWheelEvent00): int64 {.
    importc, libprag.}

proc getWheelDeltaY*(self: DOMWheelEvent): int64 =
  webkit_dom_wheel_event_get_wheel_delta_y(cast[ptr DOMWheelEvent00](self.impl))

proc wheelDeltaY*(self: DOMWheelEvent): int64 =
  webkit_dom_wheel_event_get_wheel_delta_y(cast[ptr DOMWheelEvent00](self.impl))

proc webkit_dom_wheel_event_init_wheel_event(self: ptr DOMWheelEvent00; wheelDeltaX: int64;
    wheelDeltaY: int64; view: ptr DOMDOMWindow00; screenX: int64; screenY: int64;
    clientX: int64; clientY: int64; ctrlKey: gboolean; altKey: gboolean; shiftKey: gboolean;
    metaKey: gboolean) {.
    importc, libprag.}

proc initWheelEvent*(self: DOMWheelEvent; wheelDeltaX: int64;
    wheelDeltaY: int64; view: DOMDOMWindow; screenX: int64; screenY: int64;
    clientX: int64; clientY: int64; ctrlKey: bool; altKey: bool; shiftKey: bool;
    metaKey: bool) =
  webkit_dom_wheel_event_init_wheel_event(cast[ptr DOMWheelEvent00](self.impl), wheelDeltaX, wheelDeltaY, cast[ptr DOMDOMWindow00](view.impl), screenX, screenY, clientX, clientY, gboolean(ctrlKey), gboolean(altKey), gboolean(shiftKey), gboolean(metaKey))

const DOM_CSS_RULE_CHARSET_RULE* = 2'i32

const DOM_CSS_RULE_FONT_FACE_RULE* = 5'i32

const DOM_CSS_RULE_IMPORT_RULE* = 3'i32

const DOM_CSS_RULE_MEDIA_RULE* = 4'i32

const DOM_CSS_RULE_PAGE_RULE* = 6'i32

const DOM_CSS_RULE_STYLE_RULE* = 1'i32

const DOM_CSS_RULE_UNKNOWN_RULE* = 0'i32

const DOM_CSS_VALUE_CSS_CUSTOM* = 3'i32

const DOM_CSS_VALUE_CSS_INHERIT* = 0'i32

const DOM_CSS_VALUE_CSS_PRIMITIVE_VALUE* = 1'i32

const DOM_CSS_VALUE_CSS_VALUE_LIST* = 2'i32

const DOM_ELEMENT_ALLOW_KEYBOARD_INPUT* = 1'i32

const DOM_EVENT_AT_TARGET* = 2'i32

const DOM_EVENT_BLUR* = 8192'i32

const DOM_EVENT_BUBBLING_PHASE* = 3'i32

const DOM_EVENT_CAPTURING_PHASE* = 1'i32

const DOM_EVENT_CHANGE* = 32768'i32

const DOM_EVENT_CLICK* = 64'i32

const DOM_EVENT_DBLCLICK* = 128'i32

const DOM_EVENT_DRAGDROP* = 2048'i32

const DOM_EVENT_FOCUS* = 4096'i32

const DOM_EVENT_KEYDOWN* = 256'i32

const DOM_EVENT_KEYPRESS* = 1024'i32

const DOM_EVENT_KEYUP* = 512'i32

const DOM_EVENT_MOUSEDOWN* = 1'i32

const DOM_EVENT_MOUSEDRAG* = 32'i32

const DOM_EVENT_MOUSEMOVE* = 16'i32

const DOM_EVENT_MOUSEOUT* = 8'i32

const DOM_EVENT_MOUSEOVER* = 4'i32

const DOM_EVENT_MOUSEUP* = 2'i32

const DOM_EVENT_NONE* = 0'i32

const DOM_EVENT_SELECT* = 16384'i32

const DOM_KEYBOARD_EVENT_KEY_LOCATION_LEFT* = 1'i32

const DOM_KEYBOARD_EVENT_KEY_LOCATION_NUMPAD* = 3'i32

const DOM_KEYBOARD_EVENT_KEY_LOCATION_RIGHT* = 2'i32

const DOM_KEYBOARD_EVENT_KEY_LOCATION_STANDARD* = 0'i32

const DOM_NODE_ATTRIBUTE_NODE* = 2'i32

const DOM_NODE_CDATA_SECTION_NODE* = 4'i32

const DOM_NODE_COMMENT_NODE* = 8'i32

const DOM_NODE_DOCUMENT_FRAGMENT_NODE* = 11'i32

const DOM_NODE_DOCUMENT_NODE* = 9'i32

const DOM_NODE_DOCUMENT_POSITION_CONTAINED_BY* = 16'i32

const DOM_NODE_DOCUMENT_POSITION_CONTAINS* = 8'i32

const DOM_NODE_DOCUMENT_POSITION_DISCONNECTED* = 1'i32

const DOM_NODE_DOCUMENT_POSITION_FOLLOWING* = 4'i32

const DOM_NODE_DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC* = 32'i32

const DOM_NODE_DOCUMENT_POSITION_PRECEDING* = 2'i32

const DOM_NODE_DOCUMENT_TYPE_NODE* = 10'i32

const DOM_NODE_ELEMENT_NODE* = 1'i32

const DOM_NODE_ENTITY_NODE* = 6'i32

const DOM_NODE_ENTITY_REFERENCE_NODE* = 5'i32

const DOM_NODE_FILTER_ACCEPT* = 1'i32

const DOM_NODE_FILTER_REJECT* = 2'i32

const DOM_NODE_FILTER_SHOW_ALL* = -1'i32

const DOM_NODE_FILTER_SHOW_ATTRIBUTE* = 2'i32

const DOM_NODE_FILTER_SHOW_CDATA_SECTION* = 8'i32

const DOM_NODE_FILTER_SHOW_COMMENT* = 128'i32

const DOM_NODE_FILTER_SHOW_DOCUMENT* = 256'i32

const DOM_NODE_FILTER_SHOW_DOCUMENT_FRAGMENT* = 1024'i32

const DOM_NODE_FILTER_SHOW_DOCUMENT_TYPE* = 512'i32

const DOM_NODE_FILTER_SHOW_ELEMENT* = 1'i32

const DOM_NODE_FILTER_SHOW_ENTITY* = 32'i32

const DOM_NODE_FILTER_SHOW_ENTITY_REFERENCE* = 16'i32

const DOM_NODE_FILTER_SHOW_NOTATION* = 2048'i32

const DOM_NODE_FILTER_SHOW_PROCESSING_INSTRUCTION* = 64'i32

const DOM_NODE_FILTER_SHOW_TEXT* = 4'i32

const DOM_NODE_FILTER_SKIP* = 3'i32

const DOM_NODE_PROCESSING_INSTRUCTION_NODE* = 7'i32

const DOM_NODE_TEXT_NODE* = 3'i32

const DOM_RANGE_END_TO_END* = 2'i32

const DOM_RANGE_END_TO_START* = 3'i32

const DOM_RANGE_NODE_AFTER* = 1'i32

const DOM_RANGE_NODE_BEFORE* = 0'i32

const DOM_RANGE_NODE_BEFORE_AND_AFTER* = 2'i32

const DOM_RANGE_NODE_INSIDE* = 3'i32

const DOM_RANGE_START_TO_END* = 1'i32

const DOM_RANGE_START_TO_START* = 0'i32

const DOM_XPATH_RESULT_ANY_TYPE* = 0'i32

const DOM_XPATH_RESULT_ANY_UNORDERED_NODE_TYPE* = 8'i32

const DOM_XPATH_RESULT_BOOLEAN_TYPE* = 3'i32

const DOM_XPATH_RESULT_FIRST_ORDERED_NODE_TYPE* = 9'i32

const DOM_XPATH_RESULT_NUMBER_TYPE* = 1'i32

const DOM_XPATH_RESULT_ORDERED_NODE_ITERATOR_TYPE* = 5'i32

const DOM_XPATH_RESULT_ORDERED_NODE_SNAPSHOT_TYPE* = 7'i32

const DOM_XPATH_RESULT_STRING_TYPE* = 2'i32

const DOM_XPATH_RESULT_UNORDERED_NODE_ITERATOR_TYPE* = 4'i32

const DOM_XPATH_RESULT_UNORDERED_NODE_SNAPSHOT_TYPE* = 6'i32

type
  FormSubmissionStep* {.size: sizeof(cint), pure.} = enum
    sendDomEvent = 0
    complete = 1

type
  Frame* = ref object of gobject.Object
  Frame00* = object of gobject.Object00

proc webkit_frame_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Frame()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_frame_get_id(self: ptr Frame00): uint64 {.
    importc, libprag.}

proc getId*(self: Frame): uint64 =
  webkit_frame_get_id(cast[ptr Frame00](self.impl))

proc id*(self: Frame): uint64 =
  webkit_frame_get_id(cast[ptr Frame00](self.impl))

proc webkit_frame_get_js_context(self: ptr Frame00): ptr javascriptcore.Context00 {.
    importc, libprag.}

proc getJsContext*(self: Frame): javascriptcore.Context =
  let gobj = webkit_frame_get_js_context(cast[ptr Frame00](self.impl))
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

proc jsContext*(self: Frame): javascriptcore.Context =
  let gobj = webkit_frame_get_js_context(cast[ptr Frame00](self.impl))
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

proc webkit_frame_get_js_value_for_dom_object(self: ptr Frame00; domObject: ptr DOMObject00): ptr javascriptcore.Value00 {.
    importc, libprag.}

proc getJsValueForDomObject*(self: Frame; domObject: DOMObject): javascriptcore.Value =
  let gobj = webkit_frame_get_js_value_for_dom_object(cast[ptr Frame00](self.impl), cast[ptr DOMObject00](domObject.impl))
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

proc webkit_frame_get_uri(self: ptr Frame00): cstring {.
    importc, libprag.}

proc getUri*(self: Frame): string =
  result = $webkit_frame_get_uri(cast[ptr Frame00](self.impl))

proc uri*(self: Frame): string =
  result = $webkit_frame_get_uri(cast[ptr Frame00](self.impl))

proc webkit_frame_is_main_frame(self: ptr Frame00): gboolean {.
    importc, libprag.}

proc isMainFrame*(self: Frame): bool =
  toBool(webkit_frame_is_main_frame(cast[ptr Frame00](self.impl)))

type
  HitTestResult* = ref object of gobject.Object
  HitTestResult00* = object of gobject.Object00

proc webkit_hit_test_result_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(HitTestResult()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  WebHitTestResult* = ref object of HitTestResult
  WebHitTestResult00* = object of HitTestResult00

proc webkit_web_hit_test_result_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebHitTestResult()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc webkit_web_hit_test_result_get_node(self: ptr WebHitTestResult00): ptr DOMNode00 {.
    importc, libprag.}

proc getNode*(self: WebHitTestResult): DOMNode =
  let gobj = webkit_web_hit_test_result_get_node(cast[ptr WebHitTestResult00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc node*(self: WebHitTestResult): DOMNode =
  let gobj = webkit_web_hit_test_result_get_node(cast[ptr WebHitTestResult00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  URIRequest* = ref object of gobject.Object
  URIRequest00* = object of gobject.Object00

proc webkit_uri_request_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(URIRequest()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  URIResponse* = ref object of gobject.Object
  URIResponse00* = object of gobject.Object00

proc webkit_uri_response_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(URIResponse()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  UserMessage* = ref object of gobject.InitiallyUnowned
  UserMessage00* = object of gobject.InitiallyUnowned00

proc webkit_user_message_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(UserMessage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  WebPage* = ref object of gobject.Object
  WebPage00* = object of gobject.Object00

proc webkit_web_page_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebPage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scConsoleMessageSent*(self: WebPage;  p: proc (self: ptr WebPage00; consoleMessage: ptr ConsoleMessage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "console-message-sent", cast[GCallback](p), xdata, nil, cf)

proc scContextMenu*(self: WebPage;  p: proc (self: ptr WebPage00; contextMenu: ptr ContextMenu00; hitTestResult: ptr WebHitTestResult00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "context-menu", cast[GCallback](p), xdata, nil, cf)

proc scDocumentLoaded*(self: WebPage;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "document-loaded", cast[GCallback](p), xdata, nil, cf)

proc scFormControlsAssociated*(self: WebPage;  p: proc (self: ptr WebPage00; elements: ptr PtrArray00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "form-controls-associated", cast[GCallback](p), xdata, nil, cf)

proc scFormControlsAssociatedForFrame*(self: WebPage;  p: proc (self: ptr WebPage00; elements: ptr PtrArray00; frame: ptr Frame00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "form-controls-associated-for-frame", cast[GCallback](p), xdata, nil, cf)

proc scSendRequest*(self: WebPage;  p: proc (self: ptr WebPage00; request: ptr URIRequest00; redirectedResponse: ptr URIResponse00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "send-request", cast[GCallback](p), xdata, nil, cf)

proc scUserMessageReceived*(self: WebPage;  p: proc (self: ptr WebPage00; message: ptr UserMessage00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "user-message-received", cast[GCallback](p), xdata, nil, cf)

proc scWillSubmitForm*(self: WebPage;  p: proc (self: ptr WebPage00; form: ptr DOMElement00; step: FormSubmissionStep; sourceFrame: ptr Frame00;
    targetFrame: ptr Frame00; textFieldNames: ptr PtrArray00; textFieldValues: ptr PtrArray00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "will-submit-form", cast[GCallback](p), xdata, nil, cf)

proc webkit_web_page_get_dom_document(self: ptr WebPage00): ptr DOMDocument00 {.
    importc, libprag.}

proc getDomDocument*(self: WebPage): DOMDocument =
  let gobj = webkit_web_page_get_dom_document(cast[ptr WebPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc domDocument*(self: WebPage): DOMDocument =
  let gobj = webkit_web_page_get_dom_document(cast[ptr WebPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_page_get_id(self: ptr WebPage00): uint64 {.
    importc, libprag.}

proc getId*(self: WebPage): uint64 =
  webkit_web_page_get_id(cast[ptr WebPage00](self.impl))

proc id*(self: WebPage): uint64 =
  webkit_web_page_get_id(cast[ptr WebPage00](self.impl))

proc webkit_web_page_get_main_frame(self: ptr WebPage00): ptr Frame00 {.
    importc, libprag.}

proc getMainFrame*(self: WebPage): Frame =
  let gobj = webkit_web_page_get_main_frame(cast[ptr WebPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc mainFrame*(self: WebPage): Frame =
  let gobj = webkit_web_page_get_main_frame(cast[ptr WebPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_page_get_uri(self: ptr WebPage00): cstring {.
    importc, libprag.}

proc getUri*(self: WebPage): string =
  result = $webkit_web_page_get_uri(cast[ptr WebPage00](self.impl))

proc uri*(self: WebPage): string =
  result = $webkit_web_page_get_uri(cast[ptr WebPage00](self.impl))

proc webkit_web_page_send_message_to_view(self: ptr WebPage00; message: ptr UserMessage00;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc sendMessageToView*(self: WebPage; message: UserMessage;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_page_send_message_to_view(cast[ptr WebPage00](self.impl), cast[ptr UserMessage00](message.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_page_send_message_to_view_finish(self: ptr WebPage00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): ptr UserMessage00 {.
    importc, libprag.}

proc sendMessageToViewFinish*(self: WebPage; resu: gio.AsyncResult): UserMessage =
  var gerror: ptr glib.Error
  let gobj = webkit_web_page_send_message_to_view_finish(cast[ptr WebPage00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ScriptWorld* = ref object of gobject.Object
  ScriptWorld00* = object of gobject.Object00

proc webkit_script_world_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(ScriptWorld()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scWindowObjectCleared*(self: ScriptWorld;  p: proc (self: ptr ScriptWorld00; page: ptr WebPage00; frame: ptr Frame00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "window-object-cleared", cast[GCallback](p), xdata, nil, cf)

proc webkit_script_world_new(): ptr ScriptWorld00 {.
    importc, libprag.}

proc newScriptWorld*(): ScriptWorld =
  let gobj = webkit_script_world_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newScriptWorld*(tdesc: typedesc): tdesc =
  assert(result is ScriptWorld)
  let gobj = webkit_script_world_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initScriptWorld*[T](result: var T) {.deprecated.} =
  assert(result is ScriptWorld)
  let gobj = webkit_script_world_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_script_world_new_with_name(name: cstring): ptr ScriptWorld00 {.
    importc, libprag.}

proc newScriptWorldWithName*(name: cstring): ScriptWorld =
  let gobj = webkit_script_world_new_with_name(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newScriptWorldWithName*(tdesc: typedesc; name: cstring): tdesc =
  assert(result is ScriptWorld)
  let gobj = webkit_script_world_new_with_name(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initScriptWorldWithName*[T](result: var T; name: cstring) {.deprecated.} =
  assert(result is ScriptWorld)
  let gobj = webkit_script_world_new_with_name(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_script_world_get_default(): ptr ScriptWorld00 {.
    importc, libprag.}

proc getDefaultScriptWorld*(): ScriptWorld =
  let gobj = webkit_script_world_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_script_world_get_name(self: ptr ScriptWorld00): cstring {.
    importc, libprag.}

proc getName*(self: ScriptWorld): string =
  result = $webkit_script_world_get_name(cast[ptr ScriptWorld00](self.impl))

proc name*(self: ScriptWorld): string =
  result = $webkit_script_world_get_name(cast[ptr ScriptWorld00](self.impl))

proc webkit_frame_get_js_context_for_script_world(self: ptr Frame00; world: ptr ScriptWorld00): ptr javascriptcore.Context00 {.
    importc, libprag.}

proc getJsContextForScriptWorld*(self: Frame; world: ScriptWorld): javascriptcore.Context =
  let gobj = webkit_frame_get_js_context_for_script_world(cast[ptr Frame00](self.impl), cast[ptr ScriptWorld00](world.impl))
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

proc webkit_frame_get_js_value_for_dom_object_in_script_world(self: ptr Frame00;
    domObject: ptr DOMObject00; world: ptr ScriptWorld00): ptr javascriptcore.Value00 {.
    importc, libprag.}

proc getJsValueForDomObjectInScriptWorld*(self: Frame;
    domObject: DOMObject; world: ScriptWorld): javascriptcore.Value =
  let gobj = webkit_frame_get_js_value_for_dom_object_in_script_world(cast[ptr Frame00](self.impl), cast[ptr DOMObject00](domObject.impl), cast[ptr ScriptWorld00](world.impl))
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
  WebEditor* = ref object of gobject.Object
  WebEditor00* = object of gobject.Object00

proc webkit_web_editor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebEditor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scSelectionChanged*(self: WebEditor;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "selection-changed", cast[GCallback](p), xdata, nil, cf)

proc webkit_web_editor_get_page(self: ptr WebEditor00): ptr WebPage00 {.
    importc, libprag.}

proc getPage*(self: WebEditor): WebPage =
  let gobj = webkit_web_editor_get_page(cast[ptr WebEditor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc page*(self: WebEditor): WebPage =
  let gobj = webkit_web_editor_get_page(cast[ptr WebEditor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_page_get_editor(self: ptr WebPage00): ptr WebEditor00 {.
    importc, libprag.}

proc getEditor*(self: WebPage): WebEditor =
  let gobj = webkit_web_page_get_editor(cast[ptr WebPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc editor*(self: WebPage): WebEditor =
  let gobj = webkit_web_page_get_editor(cast[ptr WebPage00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  HitTestResultContext* {.size: sizeof(cint), pure.} = enum
    document = 2
    link = 4
    image = 8
    media = 16
    editable = 32
    scrollbar = 64
    selection = 128

type
  UserMessageError* {.size: sizeof(cint), pure.} = enum
    userMessageUnhandledMessage = 0

type
  WebExtension* = ref object of gobject.Object
  WebExtension00* = object of gobject.Object00

proc webkit_web_extension_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(WebExtension()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scPageCreated*(self: WebExtension;  p: proc (self: ptr WebExtension00; webPage: ptr WebPage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "page-created", cast[GCallback](p), xdata, nil, cf)

proc scUserMessageReceived*(self: WebExtension;  p: proc (self: ptr WebExtension00; message: ptr UserMessage00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "user-message-received", cast[GCallback](p), xdata, nil, cf)

proc webkit_web_extension_get_page(self: ptr WebExtension00; pageId: uint64): ptr WebPage00 {.
    importc, libprag.}

proc getPage*(self: WebExtension; pageId: uint64): WebPage =
  let gobj = webkit_web_extension_get_page(cast[ptr WebExtension00](self.impl), pageId)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc webkit_web_extension_send_message_to_context(self: ptr WebExtension00;
    message: ptr UserMessage00; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc sendMessageToContext*(self: WebExtension; message: UserMessage;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  webkit_web_extension_send_message_to_context(cast[ptr WebExtension00](self.impl), cast[ptr UserMessage00](message.impl), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc webkit_web_extension_send_message_to_context_finish(self: ptr WebExtension00;
    resu: ptr gio.AsyncResult00; error: ptr ptr glib.Error = nil): ptr UserMessage00 {.
    importc, libprag.}

proc sendMessageToContextFinish*(self: WebExtension;
    resu: gio.AsyncResult): UserMessage =
  var gerror: ptr glib.Error
  let gobj = webkit_web_extension_send_message_to_context_finish(cast[ptr WebExtension00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, webkit2webextension.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  WebExtensionInitializeFunction* = proc (extension: ptr WebExtension00) {.cdecl.}

type
  WebExtensionInitializeWithUserDataFunction* = proc (extension: ptr WebExtension00; userData: ptr glib.Variant00) {.cdecl.}
# === remaining symbols:
