# dependencies:
# xlib-2.0
# GLib-2.0
# Gdk-3.0
# HarfBuzz-0.0
# GdkPixbuf-2.0
# Gtk-3.0
# cairo-1.0
# GObject-2.0
# Pango-1.0
# Gio-2.0
# GModule-2.0
# Atk-1.0
# immediate dependencies:
# Gtk-3.0
# Gdk-3.0
# libraries:
# libgtksourceview-4.so.0
{.warning[UnusedImport]: off.}
import xlib, glib, gdk4, harfbuzz, gdkpixbuf, gtk4, cairo, gobject, pango, gio, gmodule, atk
const Lib = "libgtksourceview-4.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
import glib

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  BackgroundPatternType* {.size: sizeof(cint), pure.} = enum
    none = 0
    grid = 1

type
  BracketMatchType* {.size: sizeof(cint), pure.} = enum
    none = 0
    outOfRange = 1
    notFound = 2
    found = 3

type
  Buffer* = ref object of gtk4.TextBuffer
  Buffer00* = object of gtk4.TextBuffer00

proc gtk_source_buffer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Buffer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scBracketMatched*(self: Buffer;  p: proc (self: ptr Buffer00; iter: gtk4.TextIter; state: BracketMatchType; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "bracket-matched", cast[GCallback](p), xdata, nil, cf)

proc scHighlightUpdated*(self: Buffer;  p: proc (self: ptr Buffer00; start: gtk4.TextIter; `end`: gtk4.TextIter; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "highlight-updated", cast[GCallback](p), xdata, nil, cf)

proc scRedo*(self: Buffer;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "redo", cast[GCallback](p), xdata, nil, cf)

proc scSourceMarkUpdated*(self: Buffer;  p: proc (self: ptr Buffer00; mark: ptr gtk4.TextMark00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "source-mark-updated", cast[GCallback](p), xdata, nil, cf)

proc scUndo*(self: Buffer;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "undo", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_buffer_new(table: ptr gtk4.TextTagTable00): ptr Buffer00 {.
    importc, libprag.}

proc newBuffer*(table: gtk4.TextTagTable = nil): Buffer =
  let gobj = gtk_source_buffer_new(if table.isNil: nil else: cast[ptr gtk4.TextTagTable00](table.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBuffer*(tdesc: typedesc; table: gtk4.TextTagTable = nil): tdesc =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new(if table.isNil: nil else: cast[ptr gtk4.TextTagTable00](table.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBuffer*[T](result: var T; table: gtk4.TextTagTable = nil) {.deprecated.} =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new(if table.isNil: nil else: cast[ptr gtk4.TextTagTable00](table.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_backward_iter_to_source_mark(self: ptr Buffer00; iter: var gtk4.TextIter;
    category: cstring): gboolean {.
    importc, libprag.}

proc backwardIterToSourceMark*(self: Buffer; iter: var gtk4.TextIter;
    category: cstring = nil): bool =
  toBool(gtk_source_buffer_backward_iter_to_source_mark(cast[ptr Buffer00](self.impl), iter, category))

proc gtk_source_buffer_begin_not_undoable_action(self: ptr Buffer00) {.
    importc, libprag.}

proc beginNotUndoableAction*(self: Buffer) =
  gtk_source_buffer_begin_not_undoable_action(cast[ptr Buffer00](self.impl))

proc gtk_source_buffer_can_redo(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc canRedo*(self: Buffer): bool =
  toBool(gtk_source_buffer_can_redo(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_can_undo(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc canUndo*(self: Buffer): bool =
  toBool(gtk_source_buffer_can_undo(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_end_not_undoable_action(self: ptr Buffer00) {.
    importc, libprag.}

proc endNotUndoableAction*(self: Buffer) =
  gtk_source_buffer_end_not_undoable_action(cast[ptr Buffer00](self.impl))

proc gtk_source_buffer_ensure_highlight(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc ensureHighlight*(self: Buffer; start: gtk4.TextIter;
    `end`: gtk4.TextIter) =
  gtk_source_buffer_ensure_highlight(cast[ptr Buffer00](self.impl), start, `end`)

proc gtk_source_buffer_forward_iter_to_source_mark(self: ptr Buffer00; iter: var gtk4.TextIter;
    category: cstring): gboolean {.
    importc, libprag.}

proc forwardIterToSourceMark*(self: Buffer; iter: var gtk4.TextIter;
    category: cstring = nil): bool =
  toBool(gtk_source_buffer_forward_iter_to_source_mark(cast[ptr Buffer00](self.impl), iter, category))

proc gtk_source_buffer_get_context_classes_at_iter(self: ptr Buffer00; iter: gtk4.TextIter): ptr cstring {.
    importc, libprag.}

proc getContextClassesAtIter*(self: Buffer; iter: gtk4.TextIter): seq[string] =
  let resul0 = gtk_source_buffer_get_context_classes_at_iter(cast[ptr Buffer00](self.impl), iter)
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_buffer_get_highlight_matching_brackets(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc getHighlightMatchingBrackets*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_matching_brackets(cast[ptr Buffer00](self.impl)))

proc highlightMatchingBrackets*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_matching_brackets(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_get_highlight_syntax(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc getHighlightSyntax*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_syntax(cast[ptr Buffer00](self.impl)))

proc highlightSyntax*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_highlight_syntax(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_get_implicit_trailing_newline(self: ptr Buffer00): gboolean {.
    importc, libprag.}

proc getImplicitTrailingNewline*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_implicit_trailing_newline(cast[ptr Buffer00](self.impl)))

proc implicitTrailingNewline*(self: Buffer): bool =
  toBool(gtk_source_buffer_get_implicit_trailing_newline(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_get_max_undo_levels(self: ptr Buffer00): int32 {.
    importc, libprag.}

proc getMaxUndoLevels*(self: Buffer): int =
  int(gtk_source_buffer_get_max_undo_levels(cast[ptr Buffer00](self.impl)))

proc maxUndoLevels*(self: Buffer): int =
  int(gtk_source_buffer_get_max_undo_levels(cast[ptr Buffer00](self.impl)))

proc gtk_source_buffer_iter_backward_to_context_class_toggle(self: ptr Buffer00;
    iter: var gtk4.TextIter; contextClass: cstring): gboolean {.
    importc, libprag.}

proc iterBackwardToContextClassToggle*(self: Buffer;
    iter: var gtk4.TextIter; contextClass: cstring): bool =
  toBool(gtk_source_buffer_iter_backward_to_context_class_toggle(cast[ptr Buffer00](self.impl), iter, contextClass))

proc gtk_source_buffer_iter_forward_to_context_class_toggle(self: ptr Buffer00;
    iter: var gtk4.TextIter; contextClass: cstring): gboolean {.
    importc, libprag.}

proc iterForwardToContextClassToggle*(self: Buffer;
    iter: var gtk4.TextIter; contextClass: cstring): bool =
  toBool(gtk_source_buffer_iter_forward_to_context_class_toggle(cast[ptr Buffer00](self.impl), iter, contextClass))

proc gtk_source_buffer_iter_has_context_class(self: ptr Buffer00; iter: gtk4.TextIter;
    contextClass: cstring): gboolean {.
    importc, libprag.}

proc iterHasContextClass*(self: Buffer; iter: gtk4.TextIter;
    contextClass: cstring): bool =
  toBool(gtk_source_buffer_iter_has_context_class(cast[ptr Buffer00](self.impl), iter, contextClass))

proc gtk_source_buffer_join_lines(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc joinLines*(self: Buffer; start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_buffer_join_lines(cast[ptr Buffer00](self.impl), start, `end`)

proc gtk_source_buffer_redo(self: ptr Buffer00) {.
    importc, libprag.}

proc redo*(self: Buffer) =
  gtk_source_buffer_redo(cast[ptr Buffer00](self.impl))

proc gtk_source_buffer_remove_source_marks(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter; category: cstring) {.
    importc, libprag.}

proc removeSourceMarks*(self: Buffer; start: gtk4.TextIter;
    `end`: gtk4.TextIter; category: cstring = nil) =
  gtk_source_buffer_remove_source_marks(cast[ptr Buffer00](self.impl), start, `end`, category)

proc gtk_source_buffer_set_highlight_matching_brackets(self: ptr Buffer00;
    highlight: gboolean) {.
    importc, libprag.}

proc setHighlightMatchingBrackets*(self: Buffer; highlight: bool = true) =
  gtk_source_buffer_set_highlight_matching_brackets(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc `highlightMatchingBrackets=`*(self: Buffer; highlight: bool) =
  gtk_source_buffer_set_highlight_matching_brackets(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc gtk_source_buffer_set_highlight_syntax(self: ptr Buffer00; highlight: gboolean) {.
    importc, libprag.}

proc setHighlightSyntax*(self: Buffer; highlight: bool = true) =
  gtk_source_buffer_set_highlight_syntax(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc `highlightSyntax=`*(self: Buffer; highlight: bool) =
  gtk_source_buffer_set_highlight_syntax(cast[ptr Buffer00](self.impl), gboolean(highlight))

proc gtk_source_buffer_set_implicit_trailing_newline(self: ptr Buffer00;
    implicitTrailingNewline: gboolean) {.
    importc, libprag.}

proc setImplicitTrailingNewline*(self: Buffer; implicitTrailingNewline: bool = true) =
  gtk_source_buffer_set_implicit_trailing_newline(cast[ptr Buffer00](self.impl), gboolean(implicitTrailingNewline))

proc `implicitTrailingNewline=`*(self: Buffer; implicitTrailingNewline: bool) =
  gtk_source_buffer_set_implicit_trailing_newline(cast[ptr Buffer00](self.impl), gboolean(implicitTrailingNewline))

proc gtk_source_buffer_set_max_undo_levels(self: ptr Buffer00; maxUndoLevels: int32) {.
    importc, libprag.}

proc setMaxUndoLevels*(self: Buffer; maxUndoLevels: int) =
  gtk_source_buffer_set_max_undo_levels(cast[ptr Buffer00](self.impl), int32(maxUndoLevels))

proc `maxUndoLevels=`*(self: Buffer; maxUndoLevels: int) =
  gtk_source_buffer_set_max_undo_levels(cast[ptr Buffer00](self.impl), int32(maxUndoLevels))

proc gtk_source_buffer_undo(self: ptr Buffer00) {.
    importc, libprag.}

proc undo*(self: Buffer) =
  gtk_source_buffer_undo(cast[ptr Buffer00](self.impl))

type
  ChangeCaseType* {.size: sizeof(cint), pure.} = enum
    lower = 0
    upper = 1
    toggle = 2
    title = 3

proc gtk_source_buffer_change_case(self: ptr Buffer00; caseType: ChangeCaseType;
    start: gtk4.TextIter; `end`: gtk4.TextIter) {.
    importc, libprag.}

proc changeCase*(self: Buffer; caseType: ChangeCaseType;
    start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_buffer_change_case(cast[ptr Buffer00](self.impl), caseType, start, `end`)

type
  Mark* = ref object of gtk4.TextMark
  Mark00* = object of gtk4.TextMark00

proc gtk_source_mark_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Mark()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_mark_new(name: cstring; category: cstring): ptr Mark00 {.
    importc, libprag.}

proc newMark*(name: cstring; category: cstring): Mark =
  let gobj = gtk_source_mark_new(name, category)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMark*(tdesc: typedesc; name: cstring; category: cstring): tdesc =
  assert(result is Mark)
  let gobj = gtk_source_mark_new(name, category)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMark*[T](result: var T; name: cstring; category: cstring) {.deprecated.} =
  assert(result is Mark)
  let gobj = gtk_source_mark_new(name, category)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_get_category(self: ptr Mark00): cstring {.
    importc, libprag.}

proc getCategory*(self: Mark): string =
  result = $gtk_source_mark_get_category(cast[ptr Mark00](self.impl))

proc category*(self: Mark): string =
  result = $gtk_source_mark_get_category(cast[ptr Mark00](self.impl))

proc gtk_source_mark_next(self: ptr Mark00; category: cstring): ptr Mark00 {.
    importc, libprag.}

proc next*(self: Mark; category: cstring = nil): Mark =
  let gobj = gtk_source_mark_next(cast[ptr Mark00](self.impl), category)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_prev(self: ptr Mark00; category: cstring): ptr Mark00 {.
    importc, libprag.}

proc prev*(self: Mark; category: cstring): Mark =
  let gobj = gtk_source_mark_prev(cast[ptr Mark00](self.impl), category)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_create_source_mark(self: ptr Buffer00; name: cstring;
    category: cstring; where: gtk4.TextIter): ptr Mark00 {.
    importc, libprag.}

proc createSourceMark*(self: Buffer; name: cstring = nil;
    category: cstring; where: gtk4.TextIter): Mark =
  let gobj = gtk_source_buffer_create_source_mark(cast[ptr Buffer00](self.impl), name, category, where)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_get_source_marks_at_iter(self: ptr Buffer00; iter: gtk4.TextIter;
    category: cstring): ptr glib.SList {.
    importc, libprag.}

proc getSourceMarksAtIter*(self: Buffer; iter: gtk4.TextIter;
    category: cstring = nil): seq[Mark] =
  let resul0 = gtk_source_buffer_get_source_marks_at_iter(cast[ptr Buffer00](self.impl), iter, category)
  result = gslistObjects2seq(Mark, resul0, false)
  g_slist_free(resul0)

proc gtk_source_buffer_get_source_marks_at_line(self: ptr Buffer00; line: int32;
    category: cstring): ptr glib.SList {.
    importc, libprag.}

proc getSourceMarksAtLine*(self: Buffer; line: int;
    category: cstring = nil): seq[Mark] =
  let resul0 = gtk_source_buffer_get_source_marks_at_line(cast[ptr Buffer00](self.impl), int32(line), category)
  result = gslistObjects2seq(Mark, resul0, false)
  g_slist_free(resul0)

type
  Language* = ref object of gobject.Object
  Language00* = object of gobject.Object00

proc gtk_source_language_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Language()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_language_get_globs(self: ptr Language00): ptr cstring {.
    importc, libprag.}

proc getGlobs*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_globs(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc globs*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_globs(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_language_get_hidden(self: ptr Language00): gboolean {.
    importc, libprag.}

proc getHidden*(self: Language): bool =
  toBool(gtk_source_language_get_hidden(cast[ptr Language00](self.impl)))

proc hidden*(self: Language): bool =
  toBool(gtk_source_language_get_hidden(cast[ptr Language00](self.impl)))

proc gtk_source_language_get_id(self: ptr Language00): cstring {.
    importc, libprag.}

proc getId*(self: Language): string =
  result = $gtk_source_language_get_id(cast[ptr Language00](self.impl))

proc id*(self: Language): string =
  result = $gtk_source_language_get_id(cast[ptr Language00](self.impl))

proc gtk_source_language_get_metadata(self: ptr Language00; name: cstring): cstring {.
    importc, libprag.}

proc getMetadata*(self: Language; name: cstring): string =
  let resul0 = gtk_source_language_get_metadata(cast[ptr Language00](self.impl), name)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_language_get_mime_types(self: ptr Language00): ptr cstring {.
    importc, libprag.}

proc getMimeTypes*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_mime_types(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc mimeTypes*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_mime_types(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_language_get_name(self: ptr Language00): cstring {.
    importc, libprag.}

proc getName*(self: Language): string =
  result = $gtk_source_language_get_name(cast[ptr Language00](self.impl))

proc name*(self: Language): string =
  result = $gtk_source_language_get_name(cast[ptr Language00](self.impl))

proc gtk_source_language_get_section(self: ptr Language00): cstring {.
    importc, libprag.}

proc getSection*(self: Language): string =
  result = $gtk_source_language_get_section(cast[ptr Language00](self.impl))

proc section*(self: Language): string =
  result = $gtk_source_language_get_section(cast[ptr Language00](self.impl))

proc gtk_source_language_get_style_fallback(self: ptr Language00; styleId: cstring): cstring {.
    importc, libprag.}

proc getStyleFallback*(self: Language; styleId: cstring): string =
  let resul0 = gtk_source_language_get_style_fallback(cast[ptr Language00](self.impl), styleId)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_language_get_style_ids(self: ptr Language00): ptr cstring {.
    importc, libprag.}

proc getStyleIds*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_style_ids(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc styleIds*(self: Language): seq[string] =
  let resul0 = gtk_source_language_get_style_ids(cast[ptr Language00](self.impl))
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gtk_source_language_get_style_name(self: ptr Language00; styleId: cstring): cstring {.
    importc, libprag.}

proc getStyleName*(self: Language; styleId: cstring): string =
  let resul0 = gtk_source_language_get_style_name(cast[ptr Language00](self.impl), styleId)
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_buffer_new_with_language(language: ptr Language00): ptr Buffer00 {.
    importc, libprag.}

proc newBufferWithLanguage*(language: Language): Buffer =
  let gobj = gtk_source_buffer_new_with_language(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newBufferWithLanguage*(tdesc: typedesc; language: Language): tdesc =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new_with_language(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBufferWithLanguage*[T](result: var T; language: Language) {.deprecated.} =
  assert(result is Buffer)
  let gobj = gtk_source_buffer_new_with_language(cast[ptr Language00](language.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_get_language(self: ptr Buffer00): ptr Language00 {.
    importc, libprag.}

proc getLanguage*(self: Buffer): Language =
  let gobj = gtk_source_buffer_get_language(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc language*(self: Buffer): Language =
  let gobj = gtk_source_buffer_get_language(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_set_language(self: ptr Buffer00; language: ptr Language00) {.
    importc, libprag.}

proc setLanguage*(self: Buffer; language: Language = nil) =
  gtk_source_buffer_set_language(cast[ptr Buffer00](self.impl), if language.isNil: nil else: cast[ptr Language00](language.impl))

proc `language=`*(self: Buffer; language: Language = nil) =
  gtk_source_buffer_set_language(cast[ptr Buffer00](self.impl), if language.isNil: nil else: cast[ptr Language00](language.impl))

type
  StyleScheme* = ref object of gobject.Object
  StyleScheme00* = object of gobject.Object00

proc gtk_source_style_scheme_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleScheme()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_get_authors(self: ptr StyleScheme00): ptr cstring {.
    importc, libprag.}

proc getAuthors*(self: StyleScheme): seq[string] =
  let resul0 = gtk_source_style_scheme_get_authors(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc authors*(self: StyleScheme): seq[string] =
  let resul0 = gtk_source_style_scheme_get_authors(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gtk_source_style_scheme_get_description(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getDescription*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_description(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc description*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_description(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_style_scheme_get_filename(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getFilename*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_filename(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc filename*(self: StyleScheme): string =
  let resul0 = gtk_source_style_scheme_get_filename(cast[ptr StyleScheme00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_style_scheme_get_id(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getId*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_id(cast[ptr StyleScheme00](self.impl))

proc id*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_id(cast[ptr StyleScheme00](self.impl))

proc gtk_source_style_scheme_get_name(self: ptr StyleScheme00): cstring {.
    importc, libprag.}

proc getName*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_name(cast[ptr StyleScheme00](self.impl))

proc name*(self: StyleScheme): string =
  result = $gtk_source_style_scheme_get_name(cast[ptr StyleScheme00](self.impl))

proc gtk_source_buffer_get_style_scheme(self: ptr Buffer00): ptr StyleScheme00 {.
    importc, libprag.}

proc getStyleScheme*(self: Buffer): StyleScheme =
  let gobj = gtk_source_buffer_get_style_scheme(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc styleScheme*(self: Buffer): StyleScheme =
  let gobj = gtk_source_buffer_get_style_scheme(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_set_style_scheme(self: ptr Buffer00; scheme: ptr StyleScheme00) {.
    importc, libprag.}

proc setStyleScheme*(self: Buffer; scheme: StyleScheme = nil) =
  gtk_source_buffer_set_style_scheme(cast[ptr Buffer00](self.impl), if scheme.isNil: nil else: cast[ptr StyleScheme00](scheme.impl))

proc `styleScheme=`*(self: Buffer; scheme: StyleScheme = nil) =
  gtk_source_buffer_set_style_scheme(cast[ptr Buffer00](self.impl), if scheme.isNil: nil else: cast[ptr StyleScheme00](scheme.impl))

type
  Style* = ref object of gobject.Object
  Style00* = object of gobject.Object00

proc gtk_source_style_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Style()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_apply(self: ptr Style00; tag: ptr gtk4.TextTag00) {.
    importc, libprag.}

proc apply*(self: Style; tag: gtk4.TextTag) =
  gtk_source_style_apply(cast[ptr Style00](self.impl), cast[ptr gtk4.TextTag00](tag.impl))

proc gtk_source_style_copy(self: ptr Style00): ptr Style00 {.
    importc, libprag.}

proc copy*(self: Style): Style =
  let gobj = gtk_source_style_copy(cast[ptr Style00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_get_style(self: ptr StyleScheme00; styleId: cstring): ptr Style00 {.
    importc, libprag.}

proc getStyle*(self: StyleScheme; styleId: cstring): Style =
  let gobj = gtk_source_style_scheme_get_style(cast[ptr StyleScheme00](self.impl), styleId)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  UndoManager00* = object of gobject.Object00
  UndoManager* = ref object of gobject.Object

proc scCanRedoChanged*(self: UndoManager;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "can-redo-changed", cast[GCallback](p), xdata, nil, cf)

proc scCanUndoChanged*(self: UndoManager;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "can-undo-changed", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_undo_manager_begin_not_undoable_action(self: ptr UndoManager00) {.
    importc, libprag.}

proc beginNotUndoableAction*(self: UndoManager) =
  gtk_source_undo_manager_begin_not_undoable_action(cast[ptr UndoManager00](self.impl))

proc gtk_source_undo_manager_can_redo(self: ptr UndoManager00): gboolean {.
    importc, libprag.}

proc canRedo*(self: UndoManager): bool =
  toBool(gtk_source_undo_manager_can_redo(cast[ptr UndoManager00](self.impl)))

proc gtk_source_undo_manager_can_redo_changed(self: ptr UndoManager00) {.
    importc, libprag.}

proc canRedoChanged*(self: UndoManager) =
  gtk_source_undo_manager_can_redo_changed(cast[ptr UndoManager00](self.impl))

proc gtk_source_undo_manager_can_undo(self: ptr UndoManager00): gboolean {.
    importc, libprag.}

proc canUndo*(self: UndoManager): bool =
  toBool(gtk_source_undo_manager_can_undo(cast[ptr UndoManager00](self.impl)))

proc gtk_source_undo_manager_can_undo_changed(self: ptr UndoManager00) {.
    importc, libprag.}

proc canUndoChanged*(self: UndoManager) =
  gtk_source_undo_manager_can_undo_changed(cast[ptr UndoManager00](self.impl))

proc gtk_source_undo_manager_end_not_undoable_action(self: ptr UndoManager00) {.
    importc, libprag.}

proc endNotUndoableAction*(self: UndoManager) =
  gtk_source_undo_manager_end_not_undoable_action(cast[ptr UndoManager00](self.impl))

proc gtk_source_undo_manager_redo(self: ptr UndoManager00) {.
    importc, libprag.}

proc redo*(self: UndoManager) =
  gtk_source_undo_manager_redo(cast[ptr UndoManager00](self.impl))

proc gtk_source_undo_manager_undo(self: ptr UndoManager00) {.
    importc, libprag.}

proc undo*(self: UndoManager) =
  gtk_source_undo_manager_undo(cast[ptr UndoManager00](self.impl))

proc gtk_source_buffer_get_undo_manager(self: ptr Buffer00): ptr UndoManager00 {.
    importc, libprag.}

proc getUndoManager*(self: Buffer): UndoManager =
  let gobj = gtk_source_buffer_get_undo_manager(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc undoManager*(self: Buffer): UndoManager =
  let gobj = gtk_source_buffer_get_undo_manager(cast[ptr Buffer00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_buffer_set_undo_manager(self: ptr Buffer00; manager: ptr UndoManager00) {.
    importc, libprag.}

proc setUndoManager*(self: Buffer; manager: UndoManager = nil) =
  gtk_source_buffer_set_undo_manager(cast[ptr Buffer00](self.impl), if manager.isNil: nil else: cast[ptr UndoManager00](manager.impl))

proc `undoManager=`*(self: Buffer; manager: UndoManager = nil) =
  gtk_source_buffer_set_undo_manager(cast[ptr Buffer00](self.impl), if manager.isNil: nil else: cast[ptr UndoManager00](manager.impl))

type
  SortFlag* {.size: sizeof(cint), pure.} = enum
    caseSensitive = 0
    reverseOrder = 1
    removeDuplicates = 2

  SortFlags* {.size: sizeof(cint).} = set[SortFlag]

const
  SortFlagsNone* = SortFlags({})
proc none*(t: typedesc[SortFlags]): SortFlags = SortFlags({})

proc gtk_source_buffer_sort_lines(self: ptr Buffer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter; flags: SortFlags; column: int32) {.
    importc, libprag.}

proc sortLines*(self: Buffer; start: gtk4.TextIter; `end`: gtk4.TextIter;
    flags: SortFlags; column: int) =
  gtk_source_buffer_sort_lines(cast[ptr Buffer00](self.impl), start, `end`, flags, int32(column))

type
  CompletionContext* = ref object of gobject.InitiallyUnowned
  CompletionContext00* = object of gobject.InitiallyUnowned00

proc gtk_source_completion_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scCancelled*(self: CompletionContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "cancelled", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_completion_context_get_iter(self: ptr CompletionContext00;
    iter: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getIter*(self: CompletionContext; iter: var gtk4.TextIter): bool =
  toBool(gtk_source_completion_context_get_iter(cast[ptr CompletionContext00](self.impl), iter))

type
  Completion* = ref object of gobject.Object
  Completion00* = object of gobject.Object00

proc gtk_source_completion_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Completion()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivateProposal*(self: Completion;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate-proposal", cast[GCallback](p), xdata, nil, cf)

proc scHide*(self: Completion;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "hide", cast[GCallback](p), xdata, nil, cf)

proc scMoveCursor*(self: Completion;  p: proc (self: ptr Completion00; step: gtk4.ScrollStep; num: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-cursor", cast[GCallback](p), xdata, nil, cf)

proc scMovePage*(self: Completion;  p: proc (self: ptr Completion00; step: gtk4.ScrollStep; num: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-page", cast[GCallback](p), xdata, nil, cf)

proc scPopulateContext*(self: Completion;  p: proc (self: ptr Completion00; context: ptr CompletionContext00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "populate-context", cast[GCallback](p), xdata, nil, cf)

proc scShow*(self: Completion;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "show", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_completion_block_interactive(self: ptr Completion00) {.
    importc, libprag.}

proc blockInteractive*(self: Completion) =
  gtk_source_completion_block_interactive(cast[ptr Completion00](self.impl))

proc gtk_source_completion_create_context(self: ptr Completion00; position: gtk4.TextIter): ptr CompletionContext00 {.
    importc, libprag.}

proc createContext*(self: Completion; position: gtk4.TextIter = cast[var gtk4.TextIter](nil)): CompletionContext =
  let gobj = gtk_source_completion_create_context(cast[ptr Completion00](self.impl), position)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_hide(self: ptr Completion00) {.
    importc, libprag.}

proc hide*(self: Completion) =
  gtk_source_completion_hide(cast[ptr Completion00](self.impl))

proc gtk_source_completion_unblock_interactive(self: ptr Completion00) {.
    importc, libprag.}

proc unblockInteractive*(self: Completion) =
  gtk_source_completion_unblock_interactive(cast[ptr Completion00](self.impl))

type
  CompletionActivation* {.size: sizeof(cint), pure.} = enum
    none = 0
    interactive = 1
    userRequested = 2

proc gtk_source_completion_context_get_activation(self: ptr CompletionContext00): CompletionActivation {.
    importc, libprag.}

proc getActivation*(self: CompletionContext): CompletionActivation =
  gtk_source_completion_context_get_activation(cast[ptr CompletionContext00](self.impl))

proc activation*(self: CompletionContext): CompletionActivation =
  gtk_source_completion_context_get_activation(cast[ptr CompletionContext00](self.impl))

type
  CompletionInfo* = ref object of gtk4.Window
  CompletionInfo00* = object of gtk4.Window00

proc gtk_source_completion_info_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionInfo()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_completion_info_new(): ptr CompletionInfo00 {.
    importc, libprag.}

proc newCompletionInfo*(): CompletionInfo =
  let gobj = gtk_source_completion_info_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCompletionInfo*(tdesc: typedesc): tdesc =
  assert(result is CompletionInfo)
  let gobj = gtk_source_completion_info_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCompletionInfo*[T](result: var T) {.deprecated.} =
  assert(result is CompletionInfo)
  let gobj = gtk_source_completion_info_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_info_move_to_iter(self: ptr CompletionInfo00;
    view: ptr gtk4.TextView00; iter: gtk4.TextIter) {.
    importc, libprag.}

proc moveToIter*(self: CompletionInfo; view: gtk4.TextView;
    iter: gtk4.TextIter = cast[var gtk4.TextIter](nil)) =
  gtk_source_completion_info_move_to_iter(cast[ptr CompletionInfo00](self.impl), cast[ptr gtk4.TextView00](view.impl), iter)

proc gtk_source_completion_get_info_window(self: ptr Completion00): ptr CompletionInfo00 {.
    importc, libprag.}

proc getInfoWindow*(self: Completion): CompletionInfo =
  let gobj = gtk_source_completion_get_info_window(cast[ptr Completion00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc infoWindow*(self: Completion): CompletionInfo =
  let gobj = gtk_source_completion_get_info_window(cast[ptr Completion00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  View* = ref object of gtk4.TextView
  View00* = object of gtk4.TextView00

proc gtk_source_view_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(View()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scChangeCase*(self: View;  p: proc (self: ptr View00; caseType: ChangeCaseType; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "change-case", cast[GCallback](p), xdata, nil, cf)

proc scChangeNumber*(self: View;  p: proc (self: ptr View00; count: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "change-number", cast[GCallback](p), xdata, nil, cf)

proc scJoinLines*(self: View;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "join-lines", cast[GCallback](p), xdata, nil, cf)

proc scLineMarkActivated*(self: View;  p: proc (self: ptr View00; iter: gtk4.TextIter; event: ptr gdk4.Event00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "line-mark-activated", cast[GCallback](p), xdata, nil, cf)

proc scMoveLines*(self: View;  p: proc (self: ptr View00; down: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-lines", cast[GCallback](p), xdata, nil, cf)

proc scMoveToMatchingBracket*(self: View;  p: proc (self: ptr View00; extendSelection: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-to-matching-bracket", cast[GCallback](p), xdata, nil, cf)

proc scMoveWords*(self: View;  p: proc (self: ptr View00; count: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "move-words", cast[GCallback](p), xdata, nil, cf)

proc scRedo*(self: View;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "redo", cast[GCallback](p), xdata, nil, cf)

proc scShowCompletion*(self: View;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "show-completion", cast[GCallback](p), xdata, nil, cf)

proc scSmartHomeEnd*(self: View;  p: proc (self: ptr View00; iter: gtk4.TextIter; count: int32; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "smart-home-end", cast[GCallback](p), xdata, nil, cf)

proc scUndo*(self: View;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "undo", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_view_new(): ptr View00 {.
    importc, libprag.}

proc newView*(): View =
  let gobj = gtk_source_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newView*(tdesc: typedesc): tdesc =
  assert(result is View)
  let gobj = gtk_source_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initView*[T](result: var T) {.deprecated.} =
  assert(result is View)
  let gobj = gtk_source_view_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_new_with_buffer(buffer: ptr Buffer00): ptr View00 {.
    importc, libprag.}

proc newViewWithBuffer*(buffer: Buffer): View =
  let gobj = gtk_source_view_new_with_buffer(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newViewWithBuffer*(tdesc: typedesc; buffer: Buffer): tdesc =
  assert(result is View)
  let gobj = gtk_source_view_new_with_buffer(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initViewWithBuffer*[T](result: var T; buffer: Buffer) {.deprecated.} =
  assert(result is View)
  let gobj = gtk_source_view_new_with_buffer(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_get_auto_indent(self: ptr View00): gboolean {.
    importc, libprag.}

proc getAutoIndent*(self: View): bool =
  toBool(gtk_source_view_get_auto_indent(cast[ptr View00](self.impl)))

proc autoIndent*(self: View): bool =
  toBool(gtk_source_view_get_auto_indent(cast[ptr View00](self.impl)))

proc gtk_source_view_get_background_pattern(self: ptr View00): BackgroundPatternType {.
    importc, libprag.}

proc getBackgroundPattern*(self: View): BackgroundPatternType =
  gtk_source_view_get_background_pattern(cast[ptr View00](self.impl))

proc backgroundPattern*(self: View): BackgroundPatternType =
  gtk_source_view_get_background_pattern(cast[ptr View00](self.impl))

proc gtk_source_view_get_completion(self: ptr View00): ptr Completion00 {.
    importc, libprag.}

proc getCompletion*(self: View): Completion =
  let gobj = gtk_source_view_get_completion(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc completion*(self: View): Completion =
  let gobj = gtk_source_view_get_completion(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_get_highlight_current_line(self: ptr View00): gboolean {.
    importc, libprag.}

proc getHighlightCurrentLine*(self: View): bool =
  toBool(gtk_source_view_get_highlight_current_line(cast[ptr View00](self.impl)))

proc highlightCurrentLine*(self: View): bool =
  toBool(gtk_source_view_get_highlight_current_line(cast[ptr View00](self.impl)))

proc gtk_source_view_get_indent_on_tab(self: ptr View00): gboolean {.
    importc, libprag.}

proc getIndentOnTab*(self: View): bool =
  toBool(gtk_source_view_get_indent_on_tab(cast[ptr View00](self.impl)))

proc indentOnTab*(self: View): bool =
  toBool(gtk_source_view_get_indent_on_tab(cast[ptr View00](self.impl)))

proc gtk_source_view_get_indent_width(self: ptr View00): int32 {.
    importc, libprag.}

proc getIndentWidth*(self: View): int =
  int(gtk_source_view_get_indent_width(cast[ptr View00](self.impl)))

proc indentWidth*(self: View): int =
  int(gtk_source_view_get_indent_width(cast[ptr View00](self.impl)))

proc gtk_source_view_get_insert_spaces_instead_of_tabs(self: ptr View00): gboolean {.
    importc, libprag.}

proc getInsertSpacesInsteadOfTabs*(self: View): bool =
  toBool(gtk_source_view_get_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl)))

proc insertSpacesInsteadOfTabs*(self: View): bool =
  toBool(gtk_source_view_get_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl)))

proc gtk_source_view_get_right_margin_position(self: ptr View00): uint32 {.
    importc, libprag.}

proc getRightMarginPosition*(self: View): int =
  int(gtk_source_view_get_right_margin_position(cast[ptr View00](self.impl)))

proc rightMarginPosition*(self: View): int =
  int(gtk_source_view_get_right_margin_position(cast[ptr View00](self.impl)))

proc gtk_source_view_get_show_line_marks(self: ptr View00): gboolean {.
    importc, libprag.}

proc getShowLineMarks*(self: View): bool =
  toBool(gtk_source_view_get_show_line_marks(cast[ptr View00](self.impl)))

proc showLineMarks*(self: View): bool =
  toBool(gtk_source_view_get_show_line_marks(cast[ptr View00](self.impl)))

proc gtk_source_view_get_show_line_numbers(self: ptr View00): gboolean {.
    importc, libprag.}

proc getShowLineNumbers*(self: View): bool =
  toBool(gtk_source_view_get_show_line_numbers(cast[ptr View00](self.impl)))

proc showLineNumbers*(self: View): bool =
  toBool(gtk_source_view_get_show_line_numbers(cast[ptr View00](self.impl)))

proc gtk_source_view_get_show_right_margin(self: ptr View00): gboolean {.
    importc, libprag.}

proc getShowRightMargin*(self: View): bool =
  toBool(gtk_source_view_get_show_right_margin(cast[ptr View00](self.impl)))

proc showRightMargin*(self: View): bool =
  toBool(gtk_source_view_get_show_right_margin(cast[ptr View00](self.impl)))

proc gtk_source_view_get_smart_backspace(self: ptr View00): gboolean {.
    importc, libprag.}

proc getSmartBackspace*(self: View): bool =
  toBool(gtk_source_view_get_smart_backspace(cast[ptr View00](self.impl)))

proc smartBackspace*(self: View): bool =
  toBool(gtk_source_view_get_smart_backspace(cast[ptr View00](self.impl)))

proc gtk_source_view_get_tab_width(self: ptr View00): uint32 {.
    importc, libprag.}

proc getTabWidth*(self: View): int =
  int(gtk_source_view_get_tab_width(cast[ptr View00](self.impl)))

proc tabWidth*(self: View): int =
  int(gtk_source_view_get_tab_width(cast[ptr View00](self.impl)))

proc gtk_source_view_get_visual_column(self: ptr View00; iter: gtk4.TextIter): uint32 {.
    importc, libprag.}

proc getVisualColumn*(self: View; iter: gtk4.TextIter): int =
  int(gtk_source_view_get_visual_column(cast[ptr View00](self.impl), iter))

proc gtk_source_view_indent_lines(self: ptr View00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc indentLines*(self: View; start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_view_indent_lines(cast[ptr View00](self.impl), start, `end`)

proc gtk_source_view_set_auto_indent(self: ptr View00; enable: gboolean) {.
    importc, libprag.}

proc setAutoIndent*(self: View; enable: bool = true) =
  gtk_source_view_set_auto_indent(cast[ptr View00](self.impl), gboolean(enable))

proc `autoIndent=`*(self: View; enable: bool) =
  gtk_source_view_set_auto_indent(cast[ptr View00](self.impl), gboolean(enable))

proc gtk_source_view_set_background_pattern(self: ptr View00; backgroundPattern: BackgroundPatternType) {.
    importc, libprag.}

proc setBackgroundPattern*(self: View; backgroundPattern: BackgroundPatternType) =
  gtk_source_view_set_background_pattern(cast[ptr View00](self.impl), backgroundPattern)

proc `backgroundPattern=`*(self: View; backgroundPattern: BackgroundPatternType) =
  gtk_source_view_set_background_pattern(cast[ptr View00](self.impl), backgroundPattern)

proc gtk_source_view_set_highlight_current_line(self: ptr View00; highlight: gboolean) {.
    importc, libprag.}

proc setHighlightCurrentLine*(self: View; highlight: bool = true) =
  gtk_source_view_set_highlight_current_line(cast[ptr View00](self.impl), gboolean(highlight))

proc `highlightCurrentLine=`*(self: View; highlight: bool) =
  gtk_source_view_set_highlight_current_line(cast[ptr View00](self.impl), gboolean(highlight))

proc gtk_source_view_set_indent_on_tab(self: ptr View00; enable: gboolean) {.
    importc, libprag.}

proc setIndentOnTab*(self: View; enable: bool = true) =
  gtk_source_view_set_indent_on_tab(cast[ptr View00](self.impl), gboolean(enable))

proc `indentOnTab=`*(self: View; enable: bool) =
  gtk_source_view_set_indent_on_tab(cast[ptr View00](self.impl), gboolean(enable))

proc gtk_source_view_set_indent_width(self: ptr View00; width: int32) {.
    importc, libprag.}

proc setIndentWidth*(self: View; width: int) =
  gtk_source_view_set_indent_width(cast[ptr View00](self.impl), int32(width))

proc `indentWidth=`*(self: View; width: int) =
  gtk_source_view_set_indent_width(cast[ptr View00](self.impl), int32(width))

proc gtk_source_view_set_insert_spaces_instead_of_tabs(self: ptr View00;
    enable: gboolean) {.
    importc, libprag.}

proc setInsertSpacesInsteadOfTabs*(self: View; enable: bool = true) =
  gtk_source_view_set_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl), gboolean(enable))

proc `insertSpacesInsteadOfTabs=`*(self: View; enable: bool) =
  gtk_source_view_set_insert_spaces_instead_of_tabs(cast[ptr View00](self.impl), gboolean(enable))

proc gtk_source_view_set_right_margin_position(self: ptr View00; pos: uint32) {.
    importc, libprag.}

proc setRightMarginPosition*(self: View; pos: int) =
  gtk_source_view_set_right_margin_position(cast[ptr View00](self.impl), uint32(pos))

proc `rightMarginPosition=`*(self: View; pos: int) =
  gtk_source_view_set_right_margin_position(cast[ptr View00](self.impl), uint32(pos))

proc gtk_source_view_set_show_line_marks(self: ptr View00; show: gboolean) {.
    importc, libprag.}

proc setShowLineMarks*(self: View; show: bool = true) =
  gtk_source_view_set_show_line_marks(cast[ptr View00](self.impl), gboolean(show))

proc `showLineMarks=`*(self: View; show: bool) =
  gtk_source_view_set_show_line_marks(cast[ptr View00](self.impl), gboolean(show))

proc gtk_source_view_set_show_line_numbers(self: ptr View00; show: gboolean) {.
    importc, libprag.}

proc setShowLineNumbers*(self: View; show: bool = true) =
  gtk_source_view_set_show_line_numbers(cast[ptr View00](self.impl), gboolean(show))

proc `showLineNumbers=`*(self: View; show: bool) =
  gtk_source_view_set_show_line_numbers(cast[ptr View00](self.impl), gboolean(show))

proc gtk_source_view_set_show_right_margin(self: ptr View00; show: gboolean) {.
    importc, libprag.}

proc setShowRightMargin*(self: View; show: bool = true) =
  gtk_source_view_set_show_right_margin(cast[ptr View00](self.impl), gboolean(show))

proc `showRightMargin=`*(self: View; show: bool) =
  gtk_source_view_set_show_right_margin(cast[ptr View00](self.impl), gboolean(show))

proc gtk_source_view_set_smart_backspace(self: ptr View00; smartBackspace: gboolean) {.
    importc, libprag.}

proc setSmartBackspace*(self: View; smartBackspace: bool = true) =
  gtk_source_view_set_smart_backspace(cast[ptr View00](self.impl), gboolean(smartBackspace))

proc `smartBackspace=`*(self: View; smartBackspace: bool) =
  gtk_source_view_set_smart_backspace(cast[ptr View00](self.impl), gboolean(smartBackspace))

proc gtk_source_view_set_tab_width(self: ptr View00; width: uint32) {.
    importc, libprag.}

proc setTabWidth*(self: View; width: int) =
  gtk_source_view_set_tab_width(cast[ptr View00](self.impl), uint32(width))

proc `tabWidth=`*(self: View; width: int) =
  gtk_source_view_set_tab_width(cast[ptr View00](self.impl), uint32(width))

proc gtk_source_view_unindent_lines(self: ptr View00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc unindentLines*(self: View; start: gtk4.TextIter; `end`: gtk4.TextIter) =
  gtk_source_view_unindent_lines(cast[ptr View00](self.impl), start, `end`)

proc gtk_source_completion_get_view(self: ptr Completion00): ptr View00 {.
    importc, libprag.}

proc getView*(self: Completion): View =
  let gobj = gtk_source_completion_get_view(cast[ptr Completion00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: Completion): View =
  let gobj = gtk_source_completion_get_view(cast[ptr Completion00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Gutter* = ref object of gobject.Object
  Gutter00* = object of gobject.Object00

proc gtk_source_gutter_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Gutter()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_gutter_get_view(self: ptr Gutter00): ptr View00 {.
    importc, libprag.}

proc getView*(self: Gutter): View =
  let gobj = gtk_source_gutter_get_view(cast[ptr Gutter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: Gutter): View =
  let gobj = gtk_source_gutter_get_view(cast[ptr Gutter00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_get_window_type(self: ptr Gutter00): gtk4.TextWindowType {.
    importc, libprag.}

proc getWindowType*(self: Gutter): gtk4.TextWindowType =
  gtk_source_gutter_get_window_type(cast[ptr Gutter00](self.impl))

proc windowType*(self: Gutter): gtk4.TextWindowType =
  gtk_source_gutter_get_window_type(cast[ptr Gutter00](self.impl))

proc gtk_source_gutter_queue_draw(self: ptr Gutter00) {.
    importc, libprag.}

proc queueDraw*(self: Gutter) =
  gtk_source_gutter_queue_draw(cast[ptr Gutter00](self.impl))

proc gtk_source_view_get_gutter(self: ptr View00; windowType: gtk4.TextWindowType): ptr Gutter00 {.
    importc, libprag.}

proc getGutter*(self: View; windowType: gtk4.TextWindowType): Gutter =
  let gobj = gtk_source_view_get_gutter(cast[ptr View00](self.impl), windowType)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  GutterRendererState* {.size: sizeof(cint), pure.} = enum
    normal = 0
    cursor = 1
    prelit = 2
    selected = 4

type
  GutterRenderer* = ref object of gobject.InitiallyUnowned
  GutterRenderer00* = object of gobject.InitiallyUnowned00

proc gtk_source_gutter_renderer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GutterRenderer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scActivate*(self: GutterRenderer;  p: proc (self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; event: ptr gdk4.Event00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cf)

proc scQueryActivatable*(self: GutterRenderer;  p: proc (self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; event: ptr gdk4.Event00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-activatable", cast[GCallback](p), xdata, nil, cf)

proc scQueryData*(self: GutterRenderer;  p: proc (self: ptr GutterRenderer00; start: gtk4.TextIter; `end`: gtk4.TextIter; state: GutterRendererState; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-data", cast[GCallback](p), xdata, nil, cf)

proc scQueryTooltip*(self: GutterRenderer;  p: proc (self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; x: int32; y: int32; tooltip: ptr gtk4.Tooltip00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-tooltip", cast[GCallback](p), xdata, nil, cf)

proc scQueueDraw*(self: GutterRenderer;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "queue-draw", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_gutter_renderer_activate(self: ptr GutterRenderer00; iter: gtk4.TextIter;
    area: gdk4.Rectangle; event: ptr gdk4.Event00) {.
    importc, libprag.}

proc activate*(self: GutterRenderer; iter: gtk4.TextIter;
    area: gdk4.Rectangle; event: gdk4.Event) =
  gtk_source_gutter_renderer_activate(cast[ptr GutterRenderer00](self.impl), iter, area, cast[ptr gdk4.Event00](event.impl))

proc gtk_source_gutter_renderer_begin(self: ptr GutterRenderer00; cr: ptr cairo.Context00;
    backgroundArea: gdk4.Rectangle; cellArea: gdk4.Rectangle; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc begin*(self: GutterRenderer; cr: cairo.Context;
    backgroundArea: gdk4.Rectangle; cellArea: gdk4.Rectangle; start: gtk4.TextIter;
    `end`: gtk4.TextIter) =
  gtk_source_gutter_renderer_begin(cast[ptr GutterRenderer00](self.impl), cast[ptr cairo.Context00](cr.impl), backgroundArea, cellArea, start, `end`)

proc gtk_source_gutter_renderer_draw(self: ptr GutterRenderer00; cr: ptr cairo.Context00;
    backgroundArea: gdk4.Rectangle; cellArea: gdk4.Rectangle; start: gtk4.TextIter;
    `end`: gtk4.TextIter; state: GutterRendererState) {.
    importc, libprag.}

proc draw*(self: GutterRenderer; cr: cairo.Context;
    backgroundArea: gdk4.Rectangle; cellArea: gdk4.Rectangle; start: gtk4.TextIter;
    `end`: gtk4.TextIter; state: GutterRendererState) =
  gtk_source_gutter_renderer_draw(cast[ptr GutterRenderer00](self.impl), cast[ptr cairo.Context00](cr.impl), backgroundArea, cellArea, start, `end`, state)

proc gtk_source_gutter_renderer_end(self: ptr GutterRenderer00) {.
    importc, libprag.}

proc `end`*(self: GutterRenderer) =
  gtk_source_gutter_renderer_end(cast[ptr GutterRenderer00](self.impl))

proc gtk_source_gutter_renderer_get_alignment(self: ptr GutterRenderer00;
    xalign: var cfloat; yalign: var cfloat) {.
    importc, libprag.}

proc getAlignment*(self: GutterRenderer; xalign: var cfloat = cast[var cfloat](nil);
    yalign: var cfloat = cast[var cfloat](nil)) =
  gtk_source_gutter_renderer_get_alignment(cast[ptr GutterRenderer00](self.impl), xalign, yalign)

proc gtk_source_gutter_renderer_get_background(self: ptr GutterRenderer00;
    color: var gdk4.RGBA): gboolean {.
    importc, libprag.}

proc getBackground*(self: GutterRenderer; color: var gdk4.RGBA = cast[var gdk4.RGBA](nil)): bool =
  toBool(gtk_source_gutter_renderer_get_background(cast[ptr GutterRenderer00](self.impl), color))

proc gtk_source_gutter_renderer_get_padding(self: ptr GutterRenderer00; xpad: var int32;
    ypad: var int32) {.
    importc, libprag.}

proc getPadding*(self: GutterRenderer; xpad: var int = cast[var int](nil);
    ypad: var int = cast[var int](nil)) =
  var ypad_00: int32
  var xpad_00: int32
  gtk_source_gutter_renderer_get_padding(cast[ptr GutterRenderer00](self.impl), xpad_00, ypad_00)
  if ypad.addr != nil:
    ypad = int(ypad_00)
  if xpad.addr != nil:
    xpad = int(xpad_00)

proc gtk_source_gutter_renderer_get_size(self: ptr GutterRenderer00): int32 {.
    importc, libprag.}

proc getSize*(self: GutterRenderer): int =
  int(gtk_source_gutter_renderer_get_size(cast[ptr GutterRenderer00](self.impl)))

proc size*(self: GutterRenderer): int =
  int(gtk_source_gutter_renderer_get_size(cast[ptr GutterRenderer00](self.impl)))

proc gtk_source_gutter_renderer_get_view(self: ptr GutterRenderer00): ptr gtk4.TextView00 {.
    importc, libprag.}

proc getView*(self: GutterRenderer): gtk4.TextView =
  let gobj = gtk_source_gutter_renderer_get_view(cast[ptr GutterRenderer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: GutterRenderer): gtk4.TextView =
  let gobj = gtk_source_gutter_renderer_get_view(cast[ptr GutterRenderer00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_get_visible(self: ptr GutterRenderer00): gboolean {.
    importc, libprag.}

proc getVisible*(self: GutterRenderer): bool =
  toBool(gtk_source_gutter_renderer_get_visible(cast[ptr GutterRenderer00](self.impl)))

proc visible*(self: GutterRenderer): bool =
  toBool(gtk_source_gutter_renderer_get_visible(cast[ptr GutterRenderer00](self.impl)))

proc gtk_source_gutter_renderer_get_window_type(self: ptr GutterRenderer00): gtk4.TextWindowType {.
    importc, libprag.}

proc getWindowType*(self: GutterRenderer): gtk4.TextWindowType =
  gtk_source_gutter_renderer_get_window_type(cast[ptr GutterRenderer00](self.impl))

proc windowType*(self: GutterRenderer): gtk4.TextWindowType =
  gtk_source_gutter_renderer_get_window_type(cast[ptr GutterRenderer00](self.impl))

proc gtk_source_gutter_renderer_query_activatable(self: ptr GutterRenderer00;
    iter: gtk4.TextIter; area: gdk4.Rectangle; event: ptr gdk4.Event00): gboolean {.
    importc, libprag.}

proc queryActivatable*(self: GutterRenderer; iter: gtk4.TextIter;
    area: gdk4.Rectangle; event: gdk4.Event): bool =
  toBool(gtk_source_gutter_renderer_query_activatable(cast[ptr GutterRenderer00](self.impl), iter, area, cast[ptr gdk4.Event00](event.impl)))

proc gtk_source_gutter_renderer_query_data(self: ptr GutterRenderer00; start: gtk4.TextIter;
    `end`: gtk4.TextIter; state: GutterRendererState) {.
    importc, libprag.}

proc queryData*(self: GutterRenderer; start: gtk4.TextIter;
    `end`: gtk4.TextIter; state: GutterRendererState) =
  gtk_source_gutter_renderer_query_data(cast[ptr GutterRenderer00](self.impl), start, `end`, state)

proc gtk_source_gutter_renderer_query_tooltip(self: ptr GutterRenderer00;
    iter: gtk4.TextIter; area: gdk4.Rectangle; x: int32; y: int32; tooltip: ptr gtk4.Tooltip00): gboolean {.
    importc, libprag.}

proc queryTooltip*(self: GutterRenderer; iter: gtk4.TextIter;
    area: gdk4.Rectangle; x: int; y: int; tooltip: gtk4.Tooltip): bool =
  toBool(gtk_source_gutter_renderer_query_tooltip(cast[ptr GutterRenderer00](self.impl), iter, area, int32(x), int32(y), cast[ptr gtk4.Tooltip00](tooltip.impl)))

proc gtk_source_gutter_renderer_queue_draw(self: ptr GutterRenderer00) {.
    importc, libprag.}

proc queueDraw*(self: GutterRenderer) =
  gtk_source_gutter_renderer_queue_draw(cast[ptr GutterRenderer00](self.impl))

proc gtk_source_gutter_renderer_set_alignment(self: ptr GutterRenderer00;
    xalign: cfloat; yalign: cfloat) {.
    importc, libprag.}

proc setAlignment*(self: GutterRenderer; xalign: cfloat;
    yalign: cfloat) =
  gtk_source_gutter_renderer_set_alignment(cast[ptr GutterRenderer00](self.impl), xalign, yalign)

proc gtk_source_gutter_renderer_set_background(self: ptr GutterRenderer00;
    color: gdk4.RGBA) {.
    importc, libprag.}

proc setBackground*(self: GutterRenderer; color: gdk4.RGBA = cast[var gdk4.RGBA](nil)) =
  gtk_source_gutter_renderer_set_background(cast[ptr GutterRenderer00](self.impl), color)

proc `background=`*(self: GutterRenderer; color: gdk4.RGBA = cast[var gdk4.RGBA](nil)) =
  gtk_source_gutter_renderer_set_background(cast[ptr GutterRenderer00](self.impl), color)

proc gtk_source_gutter_renderer_set_padding(self: ptr GutterRenderer00; xpad: int32;
    ypad: int32) {.
    importc, libprag.}

proc setPadding*(self: GutterRenderer; xpad: int;
    ypad: int) =
  gtk_source_gutter_renderer_set_padding(cast[ptr GutterRenderer00](self.impl), int32(xpad), int32(ypad))

proc gtk_source_gutter_renderer_set_size(self: ptr GutterRenderer00; size: int32) {.
    importc, libprag.}

proc setSize*(self: GutterRenderer; size: int) =
  gtk_source_gutter_renderer_set_size(cast[ptr GutterRenderer00](self.impl), int32(size))

proc `size=`*(self: GutterRenderer; size: int) =
  gtk_source_gutter_renderer_set_size(cast[ptr GutterRenderer00](self.impl), int32(size))

proc gtk_source_gutter_renderer_set_visible(self: ptr GutterRenderer00; visible: gboolean) {.
    importc, libprag.}

proc setVisible*(self: GutterRenderer; visible: bool = true) =
  gtk_source_gutter_renderer_set_visible(cast[ptr GutterRenderer00](self.impl), gboolean(visible))

proc `visible=`*(self: GutterRenderer; visible: bool) =
  gtk_source_gutter_renderer_set_visible(cast[ptr GutterRenderer00](self.impl), gboolean(visible))

proc gtk_source_gutter_get_renderer_at_pos(self: ptr Gutter00; x: int32;
    y: int32): ptr GutterRenderer00 {.
    importc, libprag.}

proc getRendererAtPos*(self: Gutter; x: int; y: int): GutterRenderer =
  let gobj = gtk_source_gutter_get_renderer_at_pos(cast[ptr Gutter00](self.impl), int32(x), int32(y))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_insert(self: ptr Gutter00; renderer: ptr GutterRenderer00;
    position: int32): gboolean {.
    importc, libprag.}

proc insert*(self: Gutter; renderer: GutterRenderer; position: int): bool =
  toBool(gtk_source_gutter_insert(cast[ptr Gutter00](self.impl), cast[ptr GutterRenderer00](renderer.impl), int32(position)))

proc gtk_source_gutter_remove(self: ptr Gutter00; renderer: ptr GutterRenderer00) {.
    importc, libprag.}

proc remove*(self: Gutter; renderer: GutterRenderer) =
  gtk_source_gutter_remove(cast[ptr Gutter00](self.impl), cast[ptr GutterRenderer00](renderer.impl))

proc gtk_source_gutter_reorder(self: ptr Gutter00; renderer: ptr GutterRenderer00;
    position: int32) {.
    importc, libprag.}

proc reorder*(self: Gutter; renderer: GutterRenderer; position: int) =
  gtk_source_gutter_reorder(cast[ptr Gutter00](self.impl), cast[ptr GutterRenderer00](renderer.impl), int32(position))

type
  GutterRendererAlignmentMode* {.size: sizeof(cint), pure.} = enum
    cell = 0
    first = 1
    last = 2

proc gtk_source_gutter_renderer_get_alignment_mode(self: ptr GutterRenderer00): GutterRendererAlignmentMode {.
    importc, libprag.}

proc getAlignmentMode*(self: GutterRenderer): GutterRendererAlignmentMode =
  gtk_source_gutter_renderer_get_alignment_mode(cast[ptr GutterRenderer00](self.impl))

proc alignmentMode*(self: GutterRenderer): GutterRendererAlignmentMode =
  gtk_source_gutter_renderer_get_alignment_mode(cast[ptr GutterRenderer00](self.impl))

proc gtk_source_gutter_renderer_set_alignment_mode(self: ptr GutterRenderer00;
    mode: GutterRendererAlignmentMode) {.
    importc, libprag.}

proc setAlignmentMode*(self: GutterRenderer;
    mode: GutterRendererAlignmentMode) =
  gtk_source_gutter_renderer_set_alignment_mode(cast[ptr GutterRenderer00](self.impl), mode)

proc `alignmentMode=`*(self: GutterRenderer;
    mode: GutterRendererAlignmentMode) =
  gtk_source_gutter_renderer_set_alignment_mode(cast[ptr GutterRenderer00](self.impl), mode)

type
  SpaceDrawer* = ref object of gobject.Object
  SpaceDrawer00* = object of gobject.Object00

proc gtk_source_space_drawer_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SpaceDrawer()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_space_drawer_new(): ptr SpaceDrawer00 {.
    importc, libprag.}

proc newSpaceDrawer*(): SpaceDrawer =
  let gobj = gtk_source_space_drawer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSpaceDrawer*(tdesc: typedesc): tdesc =
  assert(result is SpaceDrawer)
  let gobj = gtk_source_space_drawer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSpaceDrawer*[T](result: var T) {.deprecated.} =
  assert(result is SpaceDrawer)
  let gobj = gtk_source_space_drawer_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_space_drawer_bind_matrix_setting(self: ptr SpaceDrawer00;
    settings: ptr gio.Settings00; key: cstring; flags: gio.SettingsBindFlags) {.
    importc, libprag.}

proc bindMatrixSetting*(self: SpaceDrawer; settings: gio.Settings;
    key: cstring; flags: gio.SettingsBindFlags) =
  gtk_source_space_drawer_bind_matrix_setting(cast[ptr SpaceDrawer00](self.impl), cast[ptr gio.Settings00](settings.impl), key, flags)

proc gtk_source_space_drawer_get_enable_matrix(self: ptr SpaceDrawer00): gboolean {.
    importc, libprag.}

proc getEnableMatrix*(self: SpaceDrawer): bool =
  toBool(gtk_source_space_drawer_get_enable_matrix(cast[ptr SpaceDrawer00](self.impl)))

proc enableMatrix*(self: SpaceDrawer): bool =
  toBool(gtk_source_space_drawer_get_enable_matrix(cast[ptr SpaceDrawer00](self.impl)))

proc gtk_source_space_drawer_get_matrix(self: ptr SpaceDrawer00): ptr glib.Variant00 {.
    importc, libprag.}

proc getMatrix*(self: SpaceDrawer): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = gtk_source_space_drawer_get_matrix(cast[ptr SpaceDrawer00](self.impl))

proc matrix*(self: SpaceDrawer): glib.Variant =
  fnew(result, finalizerunref)
  result.impl = gtk_source_space_drawer_get_matrix(cast[ptr SpaceDrawer00](self.impl))

proc gtk_source_space_drawer_set_enable_matrix(self: ptr SpaceDrawer00; enableMatrix: gboolean) {.
    importc, libprag.}

proc setEnableMatrix*(self: SpaceDrawer; enableMatrix: bool = true) =
  gtk_source_space_drawer_set_enable_matrix(cast[ptr SpaceDrawer00](self.impl), gboolean(enableMatrix))

proc `enableMatrix=`*(self: SpaceDrawer; enableMatrix: bool) =
  gtk_source_space_drawer_set_enable_matrix(cast[ptr SpaceDrawer00](self.impl), gboolean(enableMatrix))

proc gtk_source_space_drawer_set_matrix(self: ptr SpaceDrawer00; matrix: ptr glib.Variant00) {.
    importc, libprag.}

proc setMatrix*(self: SpaceDrawer; matrix: glib.Variant = nil) =
  gtk_source_space_drawer_set_matrix(cast[ptr SpaceDrawer00](self.impl), if matrix.isNil: nil else: cast[ptr glib.Variant00](matrix.impl))

proc `matrix=`*(self: SpaceDrawer; matrix: glib.Variant = nil) =
  gtk_source_space_drawer_set_matrix(cast[ptr SpaceDrawer00](self.impl), if matrix.isNil: nil else: cast[ptr glib.Variant00](matrix.impl))

proc gtk_source_view_get_space_drawer(self: ptr View00): ptr SpaceDrawer00 {.
    importc, libprag.}

proc getSpaceDrawer*(self: View): SpaceDrawer =
  let gobj = gtk_source_view_get_space_drawer(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc spaceDrawer*(self: View): SpaceDrawer =
  let gobj = gtk_source_view_get_space_drawer(cast[ptr View00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SpaceLocationFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    leading = 1
    insideText = 2
    trailing = 4
    all = 7

type
  SpaceTypeFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    space = 1
    tab = 2
    newline = 4
    nbsp = 8
    all = 15

proc gtk_source_space_drawer_get_types_for_locations(self: ptr SpaceDrawer00;
    locations: SpaceLocationFlags): SpaceTypeFlags {.
    importc, libprag.}

proc getTypesForLocations*(self: SpaceDrawer; locations: SpaceLocationFlags): SpaceTypeFlags =
  gtk_source_space_drawer_get_types_for_locations(cast[ptr SpaceDrawer00](self.impl), locations)

proc gtk_source_space_drawer_set_types_for_locations(self: ptr SpaceDrawer00;
    locations: SpaceLocationFlags; types: SpaceTypeFlags) {.
    importc, libprag.}

proc setTypesForLocations*(self: SpaceDrawer; locations: SpaceLocationFlags;
    types: SpaceTypeFlags) =
  gtk_source_space_drawer_set_types_for_locations(cast[ptr SpaceDrawer00](self.impl), locations, types)

type
  MarkAttributes* = ref object of gobject.Object
  MarkAttributes00* = object of gobject.Object00

proc gtk_source_mark_attributes_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MarkAttributes()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc scQueryTooltipMarkup*(self: MarkAttributes;  p: proc (self: ptr MarkAttributes00; mark: ptr Mark00; xdata: pointer): cstring {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-tooltip-markup", cast[GCallback](p), xdata, nil, cf)

proc scQueryTooltipText*(self: MarkAttributes;  p: proc (self: ptr MarkAttributes00; mark: ptr Mark00; xdata: pointer): cstring {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "query-tooltip-text", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_mark_attributes_new(): ptr MarkAttributes00 {.
    importc, libprag.}

proc newMarkAttributes*(): MarkAttributes =
  let gobj = gtk_source_mark_attributes_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMarkAttributes*(tdesc: typedesc): tdesc =
  assert(result is MarkAttributes)
  let gobj = gtk_source_mark_attributes_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMarkAttributes*[T](result: var T) {.deprecated.} =
  assert(result is MarkAttributes)
  let gobj = gtk_source_mark_attributes_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_attributes_get_background(self: ptr MarkAttributes00;
    background: var gdk4.RGBA): gboolean {.
    importc, libprag.}

proc getBackground*(self: MarkAttributes; background: var gdk4.RGBA): bool =
  toBool(gtk_source_mark_attributes_get_background(cast[ptr MarkAttributes00](self.impl), background))

proc gtk_source_mark_attributes_get_gicon(self: ptr MarkAttributes00): ptr gio.Icon00 {.
    importc, libprag.}

proc getGicon*(self: MarkAttributes): gio.Icon =
  let gobj = gtk_source_mark_attributes_get_gicon(cast[ptr MarkAttributes00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gicon*(self: MarkAttributes): gio.Icon =
  let gobj = gtk_source_mark_attributes_get_gicon(cast[ptr MarkAttributes00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_attributes_get_icon_name(self: ptr MarkAttributes00): cstring {.
    importc, libprag.}

proc getIconName*(self: MarkAttributes): string =
  result = $gtk_source_mark_attributes_get_icon_name(cast[ptr MarkAttributes00](self.impl))

proc iconName*(self: MarkAttributes): string =
  result = $gtk_source_mark_attributes_get_icon_name(cast[ptr MarkAttributes00](self.impl))

proc gtk_source_mark_attributes_get_pixbuf(self: ptr MarkAttributes00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getPixbuf*(self: MarkAttributes): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_mark_attributes_get_pixbuf(cast[ptr MarkAttributes00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: MarkAttributes): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_mark_attributes_get_pixbuf(cast[ptr MarkAttributes00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_attributes_get_tooltip_markup(self: ptr MarkAttributes00;
    mark: ptr Mark00): cstring {.
    importc, libprag.}

proc getTooltipMarkup*(self: MarkAttributes;
    mark: Mark): string =
  let resul0 = gtk_source_mark_attributes_get_tooltip_markup(cast[ptr MarkAttributes00](self.impl), cast[ptr Mark00](mark.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_mark_attributes_get_tooltip_text(self: ptr MarkAttributes00;
    mark: ptr Mark00): cstring {.
    importc, libprag.}

proc getTooltipText*(self: MarkAttributes; mark: Mark): string =
  let resul0 = gtk_source_mark_attributes_get_tooltip_text(cast[ptr MarkAttributes00](self.impl), cast[ptr Mark00](mark.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_mark_attributes_render_icon(self: ptr MarkAttributes00; widget: ptr gtk4.Widget00;
    size: int32): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc renderIcon*(self: MarkAttributes; widget: gtk4.Widget;
    size: int): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_mark_attributes_render_icon(cast[ptr MarkAttributes00](self.impl), cast[ptr gtk4.Widget00](widget.impl), int32(size))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_mark_attributes_set_background(self: ptr MarkAttributes00;
    background: gdk4.RGBA) {.
    importc, libprag.}

proc setBackground*(self: MarkAttributes; background: gdk4.RGBA) =
  gtk_source_mark_attributes_set_background(cast[ptr MarkAttributes00](self.impl), background)

proc `background=`*(self: MarkAttributes; background: gdk4.RGBA) =
  gtk_source_mark_attributes_set_background(cast[ptr MarkAttributes00](self.impl), background)

proc gtk_source_mark_attributes_set_gicon(self: ptr MarkAttributes00; gicon: ptr gio.Icon00) {.
    importc, libprag.}

proc setGicon*(self: MarkAttributes; gicon: gio.Icon) =
  gtk_source_mark_attributes_set_gicon(cast[ptr MarkAttributes00](self.impl), cast[ptr gio.Icon00](gicon.impl))

proc `gicon=`*(self: MarkAttributes; gicon: gio.Icon) =
  gtk_source_mark_attributes_set_gicon(cast[ptr MarkAttributes00](self.impl), cast[ptr gio.Icon00](gicon.impl))

proc gtk_source_mark_attributes_set_icon_name(self: ptr MarkAttributes00;
    iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: MarkAttributes; iconName: cstring) =
  gtk_source_mark_attributes_set_icon_name(cast[ptr MarkAttributes00](self.impl), iconName)

proc `iconName=`*(self: MarkAttributes; iconName: cstring) =
  gtk_source_mark_attributes_set_icon_name(cast[ptr MarkAttributes00](self.impl), iconName)

proc gtk_source_mark_attributes_set_pixbuf(self: ptr MarkAttributes00; pixbuf: ptr gdkpixbuf.Pixbuf00) {.
    importc, libprag.}

proc setPixbuf*(self: MarkAttributes; pixbuf: gdkpixbuf.Pixbuf) =
  gtk_source_mark_attributes_set_pixbuf(cast[ptr MarkAttributes00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc `pixbuf=`*(self: MarkAttributes; pixbuf: gdkpixbuf.Pixbuf) =
  gtk_source_mark_attributes_set_pixbuf(cast[ptr MarkAttributes00](self.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc gtk_source_view_get_mark_attributes(self: ptr View00; category: cstring;
    priority: ptr int32): ptr MarkAttributes00 {.
    importc, libprag.}

proc getMarkAttributes*(self: View; category: cstring; priority: ptr int32): MarkAttributes =
  let gobj = gtk_source_view_get_mark_attributes(cast[ptr View00](self.impl), category, priority)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_view_set_mark_attributes(self: ptr View00; category: cstring;
    attributes: ptr MarkAttributes00; priority: int32) {.
    importc, libprag.}

proc setMarkAttributes*(self: View; category: cstring; attributes: MarkAttributes;
    priority: int) =
  gtk_source_view_set_mark_attributes(cast[ptr View00](self.impl), category, cast[ptr MarkAttributes00](attributes.impl), int32(priority))

type
  SmartHomeEndType* {.size: sizeof(cint), pure.} = enum
    disabled = 0
    before = 1
    after = 2
    always = 3

proc gtk_source_view_get_smart_home_end(self: ptr View00): SmartHomeEndType {.
    importc, libprag.}

proc getSmartHomeEnd*(self: View): SmartHomeEndType =
  gtk_source_view_get_smart_home_end(cast[ptr View00](self.impl))

proc smartHomeEnd*(self: View): SmartHomeEndType =
  gtk_source_view_get_smart_home_end(cast[ptr View00](self.impl))

proc gtk_source_view_set_smart_home_end(self: ptr View00; smartHomeEnd: SmartHomeEndType) {.
    importc, libprag.}

proc setSmartHomeEnd*(self: View; smartHomeEnd: SmartHomeEndType) =
  gtk_source_view_set_smart_home_end(cast[ptr View00](self.impl), smartHomeEnd)

proc `smartHomeEnd=`*(self: View; smartHomeEnd: SmartHomeEndType) =
  gtk_source_view_set_smart_home_end(cast[ptr View00](self.impl), smartHomeEnd)

type
  CompletionProvider00* = object of gobject.Object00
  CompletionProvider* = ref object of gobject.Object

proc gtk_source_completion_get_providers(self: ptr Completion00): ptr glib.List {.
    importc, libprag.}

proc getProviders*(self: Completion): seq[CompletionProvider] =
  result = glistObjects2seq(CompletionProvider, gtk_source_completion_get_providers(cast[ptr Completion00](self.impl)), false)

proc providers*(self: Completion): seq[CompletionProvider] =
  result = glistObjects2seq(CompletionProvider, gtk_source_completion_get_providers(cast[ptr Completion00](self.impl)), false)

proc gtk_source_completion_start(self: ptr Completion00; providers: ptr glib.List;
    context: ptr CompletionContext00): gboolean {.
    importc, libprag.}

proc start*(self: Completion; providers: seq[CompletionProvider];
    context: CompletionContext): bool =
  var tempResGL = seq2GList(providers)
  result = toBool(gtk_source_completion_start(cast[ptr Completion00](self.impl), tempResGL, cast[ptr CompletionContext00](context.impl)))
  g_list_free(tempResGL)

type
  CompletionWords* = ref object of gobject.Object
  CompletionWords00* = object of gobject.Object00

proc gtk_source_completion_words_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionWords()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_completion_words_new(name: cstring; icon: ptr gdkpixbuf.Pixbuf00): ptr CompletionWords00 {.
    importc, libprag.}

proc newCompletionWords*(name: cstring = nil; icon: gdkpixbuf.Pixbuf = nil): CompletionWords =
  let gobj = gtk_source_completion_words_new(name, if icon.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](icon.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCompletionWords*(tdesc: typedesc; name: cstring = nil; icon: gdkpixbuf.Pixbuf = nil): tdesc =
  assert(result is CompletionWords)
  let gobj = gtk_source_completion_words_new(name, if icon.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](icon.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCompletionWords*[T](result: var T; name: cstring = nil; icon: gdkpixbuf.Pixbuf = nil) {.deprecated.} =
  assert(result is CompletionWords)
  let gobj = gtk_source_completion_words_new(name, if icon.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](icon.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_words_register(self: ptr CompletionWords00; buffer: ptr gtk4.TextBuffer00) {.
    importc, libprag.}

proc registerCompletionWords*(self: CompletionWords; buffer: gtk4.TextBuffer) =
  gtk_source_completion_words_register(cast[ptr CompletionWords00](self.impl), cast[ptr gtk4.TextBuffer00](buffer.impl))

proc gtk_source_completion_words_unregister(self: ptr CompletionWords00;
    buffer: ptr gtk4.TextBuffer00) {.
    importc, libprag.}

proc unregister*(self: CompletionWords; buffer: gtk4.TextBuffer) =
  gtk_source_completion_words_unregister(cast[ptr CompletionWords00](self.impl), cast[ptr gtk4.TextBuffer00](buffer.impl))

proc gtk_source_completion_add_provider(self: ptr Completion00; provider: ptr CompletionProvider00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc addProvider*(self: Completion; provider: CompletionProvider | CompletionWords): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_completion_add_provider(cast[ptr Completion00](self.impl), cast[ptr CompletionProvider00](provider.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_completion_remove_provider(self: ptr Completion00; provider: ptr CompletionProvider00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc removeProvider*(self: Completion; provider: CompletionProvider | CompletionWords): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_completion_remove_provider(cast[ptr Completion00](self.impl), cast[ptr CompletionProvider00](provider.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_completion_provider_get_activation(self: ptr CompletionProvider00): CompletionActivation {.
    importc, libprag.}

proc getActivation*(self: CompletionProvider | CompletionWords): CompletionActivation =
  gtk_source_completion_provider_get_activation(cast[ptr CompletionProvider00](self.impl))

proc activation*(self: CompletionProvider | CompletionWords): CompletionActivation =
  gtk_source_completion_provider_get_activation(cast[ptr CompletionProvider00](self.impl))

proc gtk_source_completion_provider_get_gicon(self: ptr CompletionProvider00): ptr gio.Icon00 {.
    importc, libprag.}

proc getGicon*(self: CompletionProvider | CompletionWords): gio.Icon =
  let gobj = gtk_source_completion_provider_get_gicon(cast[ptr CompletionProvider00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gicon*(self: CompletionProvider | CompletionWords): gio.Icon =
  let gobj = gtk_source_completion_provider_get_gicon(cast[ptr CompletionProvider00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_provider_get_icon(self: ptr CompletionProvider00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getIcon*(self: CompletionProvider | CompletionWords): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_completion_provider_get_icon(cast[ptr CompletionProvider00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc icon*(self: CompletionProvider | CompletionWords): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_completion_provider_get_icon(cast[ptr CompletionProvider00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_provider_get_icon_name(self: ptr CompletionProvider00): cstring {.
    importc, libprag.}

proc getIconName*(self: CompletionProvider | CompletionWords): string =
  let resul0 = gtk_source_completion_provider_get_icon_name(cast[ptr CompletionProvider00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: CompletionProvider | CompletionWords): string =
  let resul0 = gtk_source_completion_provider_get_icon_name(cast[ptr CompletionProvider00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_completion_provider_get_interactive_delay(self: ptr CompletionProvider00): int32 {.
    importc, libprag.}

proc getInteractiveDelay*(self: CompletionProvider | CompletionWords): int =
  int(gtk_source_completion_provider_get_interactive_delay(cast[ptr CompletionProvider00](self.impl)))

proc interactiveDelay*(self: CompletionProvider | CompletionWords): int =
  int(gtk_source_completion_provider_get_interactive_delay(cast[ptr CompletionProvider00](self.impl)))

proc gtk_source_completion_provider_get_name(self: ptr CompletionProvider00): cstring {.
    importc, libprag.}

proc getName*(self: CompletionProvider | CompletionWords): string =
  let resul0 = gtk_source_completion_provider_get_name(cast[ptr CompletionProvider00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: CompletionProvider | CompletionWords): string =
  let resul0 = gtk_source_completion_provider_get_name(cast[ptr CompletionProvider00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_completion_provider_get_priority(self: ptr CompletionProvider00): int32 {.
    importc, libprag.}

proc getPriority*(self: CompletionProvider | CompletionWords): int =
  int(gtk_source_completion_provider_get_priority(cast[ptr CompletionProvider00](self.impl)))

proc priority*(self: CompletionProvider | CompletionWords): int =
  int(gtk_source_completion_provider_get_priority(cast[ptr CompletionProvider00](self.impl)))

proc gtk_source_completion_provider_match(self: ptr CompletionProvider00;
    context: ptr CompletionContext00): gboolean {.
    importc, libprag.}

proc match*(self: CompletionProvider | CompletionWords;
    context: CompletionContext): bool =
  toBool(gtk_source_completion_provider_match(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl)))

proc gtk_source_completion_provider_populate(self: ptr CompletionProvider00;
    context: ptr CompletionContext00) {.
    importc, libprag.}

proc populate*(self: CompletionProvider | CompletionWords;
    context: CompletionContext) =
  gtk_source_completion_provider_populate(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl))

type
  CompletionItem* = ref object of gobject.Object
  CompletionItem00* = object of gobject.Object00

proc gtk_source_completion_item_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(CompletionItem()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_completion_item_new(): ptr CompletionItem00 {.
    importc, libprag.}

proc newCompletionItem*(): CompletionItem =
  let gobj = gtk_source_completion_item_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newCompletionItem*(tdesc: typedesc): tdesc =
  assert(result is CompletionItem)
  let gobj = gtk_source_completion_item_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCompletionItem*[T](result: var T) {.deprecated.} =
  assert(result is CompletionItem)
  let gobj = gtk_source_completion_item_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_item_set_gicon(self: ptr CompletionItem00; gicon: ptr gio.Icon00) {.
    importc, libprag.}

proc setGicon*(self: CompletionItem; gicon: gio.Icon = nil) =
  gtk_source_completion_item_set_gicon(cast[ptr CompletionItem00](self.impl), if gicon.isNil: nil else: cast[ptr gio.Icon00](gicon.impl))

proc `gicon=`*(self: CompletionItem; gicon: gio.Icon = nil) =
  gtk_source_completion_item_set_gicon(cast[ptr CompletionItem00](self.impl), if gicon.isNil: nil else: cast[ptr gio.Icon00](gicon.impl))

proc gtk_source_completion_item_set_icon(self: ptr CompletionItem00; icon: ptr gdkpixbuf.Pixbuf00) {.
    importc, libprag.}

proc setIcon*(self: CompletionItem; icon: gdkpixbuf.Pixbuf = nil) =
  gtk_source_completion_item_set_icon(cast[ptr CompletionItem00](self.impl), if icon.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](icon.impl))

proc `icon=`*(self: CompletionItem; icon: gdkpixbuf.Pixbuf = nil) =
  gtk_source_completion_item_set_icon(cast[ptr CompletionItem00](self.impl), if icon.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](icon.impl))

proc gtk_source_completion_item_set_icon_name(self: ptr CompletionItem00;
    iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: CompletionItem; iconName: cstring = nil) =
  gtk_source_completion_item_set_icon_name(cast[ptr CompletionItem00](self.impl), iconName)

proc `iconName=`*(self: CompletionItem; iconName: cstring = nil) =
  gtk_source_completion_item_set_icon_name(cast[ptr CompletionItem00](self.impl), iconName)

proc gtk_source_completion_item_set_info(self: ptr CompletionItem00; info: cstring) {.
    importc, libprag.}

proc setInfo*(self: CompletionItem; info: cstring = nil) =
  gtk_source_completion_item_set_info(cast[ptr CompletionItem00](self.impl), info)

proc `info=`*(self: CompletionItem; info: cstring = nil) =
  gtk_source_completion_item_set_info(cast[ptr CompletionItem00](self.impl), info)

proc gtk_source_completion_item_set_label(self: ptr CompletionItem00; label: cstring) {.
    importc, libprag.}

proc setLabel*(self: CompletionItem; label: cstring = nil) =
  gtk_source_completion_item_set_label(cast[ptr CompletionItem00](self.impl), label)

proc `label=`*(self: CompletionItem; label: cstring = nil) =
  gtk_source_completion_item_set_label(cast[ptr CompletionItem00](self.impl), label)

proc gtk_source_completion_item_set_markup(self: ptr CompletionItem00; markup: cstring) {.
    importc, libprag.}

proc setMarkup*(self: CompletionItem; markup: cstring = nil) =
  gtk_source_completion_item_set_markup(cast[ptr CompletionItem00](self.impl), markup)

proc `markup=`*(self: CompletionItem; markup: cstring = nil) =
  gtk_source_completion_item_set_markup(cast[ptr CompletionItem00](self.impl), markup)

proc gtk_source_completion_item_set_text(self: ptr CompletionItem00; text: cstring) {.
    importc, libprag.}

proc setText*(self: CompletionItem; text: cstring = nil) =
  gtk_source_completion_item_set_text(cast[ptr CompletionItem00](self.impl), text)

proc `text=`*(self: CompletionItem; text: cstring = nil) =
  gtk_source_completion_item_set_text(cast[ptr CompletionItem00](self.impl), text)

type
  CompletionProposal00* = object of gobject.Object00
  CompletionProposal* = ref object of gobject.Object

proc scChanged*(self: CompletionProposal | CompletionItem;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =
  g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cf)

proc gtk_source_completion_proposal_changed(self: ptr CompletionProposal00) {.
    importc, libprag.}

proc changed*(self: CompletionProposal | CompletionItem) =
  gtk_source_completion_proposal_changed(cast[ptr CompletionProposal00](self.impl))

proc gtk_source_completion_proposal_equal(self: ptr CompletionProposal00;
    other: ptr CompletionProposal00): gboolean {.
    importc, libprag.}

proc equal*(self: CompletionProposal | CompletionItem;
    other: CompletionProposal | CompletionItem): bool =
  toBool(gtk_source_completion_proposal_equal(cast[ptr CompletionProposal00](self.impl), cast[ptr CompletionProposal00](other.impl)))

proc gtk_source_completion_proposal_get_gicon(self: ptr CompletionProposal00): ptr gio.Icon00 {.
    importc, libprag.}

proc getGicon*(self: CompletionProposal | CompletionItem): gio.Icon =
  let gobj = gtk_source_completion_proposal_get_gicon(cast[ptr CompletionProposal00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gicon*(self: CompletionProposal | CompletionItem): gio.Icon =
  let gobj = gtk_source_completion_proposal_get_gicon(cast[ptr CompletionProposal00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_proposal_get_icon(self: ptr CompletionProposal00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getIcon*(self: CompletionProposal | CompletionItem): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_completion_proposal_get_icon(cast[ptr CompletionProposal00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc icon*(self: CompletionProposal | CompletionItem): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_completion_proposal_get_icon(cast[ptr CompletionProposal00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_proposal_get_icon_name(self: ptr CompletionProposal00): cstring {.
    importc, libprag.}

proc getIconName*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_icon_name(cast[ptr CompletionProposal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc iconName*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_icon_name(cast[ptr CompletionProposal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_completion_proposal_get_info(self: ptr CompletionProposal00): cstring {.
    importc, libprag.}

proc getInfoCompletionProposal*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_info(cast[ptr CompletionProposal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc infoCompletionProposal*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_info(cast[ptr CompletionProposal00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

proc gtk_source_completion_proposal_get_label(self: ptr CompletionProposal00): cstring {.
    importc, libprag.}

proc getLabel*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_label(cast[ptr CompletionProposal00](self.impl))
  result = $resul0
  cogfree(resul0)

proc label*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_label(cast[ptr CompletionProposal00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_completion_proposal_get_markup(self: ptr CompletionProposal00): cstring {.
    importc, libprag.}

proc getMarkup*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_markup(cast[ptr CompletionProposal00](self.impl))
  result = $resul0
  cogfree(resul0)

proc markup*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_markup(cast[ptr CompletionProposal00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_completion_proposal_get_text(self: ptr CompletionProposal00): cstring {.
    importc, libprag.}

proc getText*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_text(cast[ptr CompletionProposal00](self.impl))
  result = $resul0
  cogfree(resul0)

proc text*(self: CompletionProposal | CompletionItem): string =
  let resul0 = gtk_source_completion_proposal_get_text(cast[ptr CompletionProposal00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_completion_proposal_hash(self: ptr CompletionProposal00): uint32 {.
    importc, libprag.}

proc hash*(self: CompletionProposal | CompletionItem): int =
  int(gtk_source_completion_proposal_hash(cast[ptr CompletionProposal00](self.impl)))

proc gtk_source_completion_context_add_proposals(self: ptr CompletionContext00;
    provider: ptr CompletionProvider00; proposals: ptr glib.List; finished: gboolean) {.
    importc, libprag.}

proc addProposals*(self: CompletionContext;
    provider: CompletionProvider | CompletionWords; proposals: seq[CompletionProposal];
    finished: bool) =
  var tempResGL = seq2GList(proposals)
  gtk_source_completion_context_add_proposals(cast[ptr CompletionContext00](self.impl), cast[ptr CompletionProvider00](provider.impl), tempResGL, gboolean(finished))
  g_list_free(tempResGL)

proc gtk_source_completion_provider_activate_proposal(self: ptr CompletionProvider00;
    proposal: ptr CompletionProposal00; iter: gtk4.TextIter): gboolean {.
    importc, libprag.}

proc activateProposal*(self: CompletionProvider | CompletionWords;
    proposal: CompletionProposal | CompletionItem; iter: gtk4.TextIter): bool =
  toBool(gtk_source_completion_provider_activate_proposal(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionProposal00](proposal.impl), iter))

proc gtk_source_completion_provider_get_info_widget(self: ptr CompletionProvider00;
    proposal: ptr CompletionProposal00): ptr gtk4.Widget00 {.
    importc, libprag.}

proc getInfoWidget*(self: CompletionProvider | CompletionWords;
    proposal: CompletionProposal | CompletionItem): gtk4.Widget =
  let gobj = gtk_source_completion_provider_get_info_widget(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionProposal00](proposal.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_completion_provider_get_start_iter(self: ptr CompletionProvider00;
    context: ptr CompletionContext00; proposal: ptr CompletionProposal00; iter: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getStartIter*(self: CompletionProvider | CompletionWords;
    context: CompletionContext; proposal: CompletionProposal | CompletionItem;
    iter: var gtk4.TextIter): bool =
  toBool(gtk_source_completion_provider_get_start_iter(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionContext00](context.impl), cast[ptr CompletionProposal00](proposal.impl), iter))

proc gtk_source_completion_provider_update_info(self: ptr CompletionProvider00;
    proposal: ptr CompletionProposal00; info: ptr CompletionInfo00) {.
    importc, libprag.}

proc updateInfo*(self: CompletionProvider | CompletionWords;
    proposal: CompletionProposal | CompletionItem; info: CompletionInfo) =
  gtk_source_completion_provider_update_info(cast[ptr CompletionProvider00](self.impl), cast[ptr CompletionProposal00](proposal.impl), cast[ptr CompletionInfo00](info.impl))

type
  CompletionError* {.size: sizeof(cint), pure.} = enum
    alreadyBound = 0
    notBound = 1

type
  CompressionType* {.size: sizeof(cint), pure.} = enum
    none = 0
    gzip = 1

type
  Encoding00* {.pure.} = object
  Encoding* = ref object
    impl*: ptr Encoding00
    ignoreFinalizer*: bool

proc gtk_source_encoding_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGtkSourceEncoding*(self: Encoding) =
  if not self.ignoreFinalizer:
    boxedFree(gtk_source_encoding_get_type(), cast[ptr Encoding00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Encoding()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gtk_source_encoding_get_type(), cast[ptr Encoding00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var Encoding) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGtkSourceEncoding)

proc gtk_source_encoding_free(self: ptr Encoding00) {.
    importc, libprag.}

proc free*(self: Encoding) =
  gtk_source_encoding_free(cast[ptr Encoding00](self.impl))

proc finalizerfree*(self: Encoding) =
  if not self.ignoreFinalizer:
    gtk_source_encoding_free(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_copy(self: ptr Encoding00): ptr Encoding00 {.
    importc, libprag.}

proc copy*(self: Encoding): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_encoding_copy(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_get_charset(self: ptr Encoding00): cstring {.
    importc, libprag.}

proc getCharset*(self: Encoding): string =
  result = $gtk_source_encoding_get_charset(cast[ptr Encoding00](self.impl))

proc charset*(self: Encoding): string =
  result = $gtk_source_encoding_get_charset(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_get_name(self: ptr Encoding00): cstring {.
    importc, libprag.}

proc getName*(self: Encoding): string =
  result = $gtk_source_encoding_get_name(cast[ptr Encoding00](self.impl))

proc name*(self: Encoding): string =
  result = $gtk_source_encoding_get_name(cast[ptr Encoding00](self.impl))

proc gtk_source_encoding_to_string(self: ptr Encoding00): cstring {.
    importc, libprag.}

proc toString*(self: Encoding): string =
  let resul0 = gtk_source_encoding_to_string(cast[ptr Encoding00](self.impl))
  result = $resul0
  cogfree(resul0)

proc getAll*(): ptr glib.SList {.
    importc: "gtk_source_encoding_get_all", libprag.}

proc gtk_source_encoding_get_current(): ptr Encoding00 {.
    importc, libprag.}

proc getCurrent*(): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_encoding_get_current()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc getDefaultCandidates*(): ptr glib.SList {.
    importc: "gtk_source_encoding_get_default_candidates", libprag.}

proc gtk_source_encoding_get_from_charset(charset: cstring): ptr Encoding00 {.
    importc, libprag.}

proc getFromCharset*(charset: cstring): Encoding =
  let impl0 = gtk_source_encoding_get_from_charset(charset)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), impl0))

proc fromCharset*(charset: cstring): Encoding =
  let impl0 = gtk_source_encoding_get_from_charset(charset)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), impl0))

proc gtk_source_encoding_get_utf8(): ptr Encoding00 {.
    importc, libprag.}

proc getUtf8*(): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_encoding_get_utf8()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

type
  File* = ref object of gobject.Object
  File00* = object of gobject.Object00

proc gtk_source_file_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(File()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_file_new(): ptr File00 {.
    importc, libprag.}

proc newFile*(): File =
  let gobj = gtk_source_file_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFile*(tdesc: typedesc): tdesc =
  assert(result is File)
  let gobj = gtk_source_file_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFile*[T](result: var T) {.deprecated.} =
  assert(result is File)
  let gobj = gtk_source_file_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_check_file_on_disk(self: ptr File00) {.
    importc, libprag.}

proc checkFileOnDisk*(self: File) =
  gtk_source_file_check_file_on_disk(cast[ptr File00](self.impl))

proc gtk_source_file_get_compression_type(self: ptr File00): CompressionType {.
    importc, libprag.}

proc getCompressionType*(self: File): CompressionType =
  gtk_source_file_get_compression_type(cast[ptr File00](self.impl))

proc compressionType*(self: File): CompressionType =
  gtk_source_file_get_compression_type(cast[ptr File00](self.impl))

proc gtk_source_file_get_encoding(self: ptr File00): ptr Encoding00 {.
    importc, libprag.}

proc getEncoding*(self: File): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_get_encoding(cast[ptr File00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc encoding*(self: File): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_get_encoding(cast[ptr File00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc gtk_source_file_get_location(self: ptr File00): ptr gio.GFile00 {.
    importc, libprag.}

proc getLocation*(self: File): gio.GFile =
  let gobj = gtk_source_file_get_location(cast[ptr File00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc location*(self: File): gio.GFile =
  let gobj = gtk_source_file_get_location(cast[ptr File00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_is_deleted(self: ptr File00): gboolean {.
    importc, libprag.}

proc isDeleted*(self: File): bool =
  toBool(gtk_source_file_is_deleted(cast[ptr File00](self.impl)))

proc gtk_source_file_is_externally_modified(self: ptr File00): gboolean {.
    importc, libprag.}

proc isExternallyModified*(self: File): bool =
  toBool(gtk_source_file_is_externally_modified(cast[ptr File00](self.impl)))

proc gtk_source_file_is_local(self: ptr File00): gboolean {.
    importc, libprag.}

proc isLocal*(self: File): bool =
  toBool(gtk_source_file_is_local(cast[ptr File00](self.impl)))

proc gtk_source_file_is_readonly(self: ptr File00): gboolean {.
    importc, libprag.}

proc isReadonly*(self: File): bool =
  toBool(gtk_source_file_is_readonly(cast[ptr File00](self.impl)))

proc gtk_source_file_set_location(self: ptr File00; location: ptr gio.GFile00) {.
    importc, libprag.}

proc setLocation*(self: File; location: gio.GFile = nil) =
  gtk_source_file_set_location(cast[ptr File00](self.impl), if location.isNil: nil else: cast[ptr gio.GFile00](location.impl))

proc `location=`*(self: File; location: gio.GFile = nil) =
  gtk_source_file_set_location(cast[ptr File00](self.impl), if location.isNil: nil else: cast[ptr gio.GFile00](location.impl))

type
  NewlineType* {.size: sizeof(cint), pure.} = enum
    lf = 0
    cr = 1
    crLf = 2

proc gtk_source_file_get_newline_type(self: ptr File00): NewlineType {.
    importc, libprag.}

proc getNewlineType*(self: File): NewlineType =
  gtk_source_file_get_newline_type(cast[ptr File00](self.impl))

proc newlineType*(self: File): NewlineType =
  gtk_source_file_get_newline_type(cast[ptr File00](self.impl))

type
  FileLoader* = ref object of gobject.Object
  FileLoader00* = object of gobject.Object00

proc gtk_source_file_loader_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FileLoader()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_file_loader_new(buffer: ptr Buffer00; file: ptr File00): ptr FileLoader00 {.
    importc, libprag.}

proc newFileLoader*(buffer: Buffer; file: File): FileLoader =
  let gobj = gtk_source_file_loader_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileLoader*(tdesc: typedesc; buffer: Buffer; file: File): tdesc =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileLoader*[T](result: var T; buffer: Buffer; file: File) {.deprecated.} =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_new_from_stream(buffer: ptr Buffer00; file: ptr File00;
    stream: ptr gio.InputStream00): ptr FileLoader00 {.
    importc, libprag.}

proc newFileLoaderFromStream*(buffer: Buffer; file: File; stream: gio.InputStream): FileLoader =
  let gobj = gtk_source_file_loader_new_from_stream(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.InputStream00](stream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileLoaderFromStream*(tdesc: typedesc; buffer: Buffer; file: File; stream: gio.InputStream): tdesc =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new_from_stream(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.InputStream00](stream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileLoaderFromStream*[T](result: var T; buffer: Buffer; file: File; stream: gio.InputStream) {.deprecated.} =
  assert(result is FileLoader)
  let gobj = gtk_source_file_loader_new_from_stream(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.InputStream00](stream.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_buffer(self: ptr FileLoader00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: FileLoader): Buffer =
  let gobj = gtk_source_file_loader_get_buffer(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: FileLoader): Buffer =
  let gobj = gtk_source_file_loader_get_buffer(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_compression_type(self: ptr FileLoader00): CompressionType {.
    importc, libprag.}

proc getCompressionType*(self: FileLoader): CompressionType =
  gtk_source_file_loader_get_compression_type(cast[ptr FileLoader00](self.impl))

proc compressionType*(self: FileLoader): CompressionType =
  gtk_source_file_loader_get_compression_type(cast[ptr FileLoader00](self.impl))

proc gtk_source_file_loader_get_encoding(self: ptr FileLoader00): ptr Encoding00 {.
    importc, libprag.}

proc getEncoding*(self: FileLoader): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_loader_get_encoding(cast[ptr FileLoader00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc encoding*(self: FileLoader): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_loader_get_encoding(cast[ptr FileLoader00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc gtk_source_file_loader_get_file(self: ptr FileLoader00): ptr File00 {.
    importc, libprag.}

proc getFile*(self: FileLoader): File =
  let gobj = gtk_source_file_loader_get_file(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc file*(self: FileLoader): File =
  let gobj = gtk_source_file_loader_get_file(cast[ptr FileLoader00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_input_stream(self: ptr FileLoader00): ptr gio.InputStream00 {.
    importc, libprag.}

proc getInputStream*(self: FileLoader): gio.InputStream =
  let gobj = gtk_source_file_loader_get_input_stream(cast[ptr FileLoader00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc inputStream*(self: FileLoader): gio.InputStream =
  let gobj = gtk_source_file_loader_get_input_stream(cast[ptr FileLoader00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_location(self: ptr FileLoader00): ptr gio.GFile00 {.
    importc, libprag.}

proc getLocation*(self: FileLoader): gio.GFile =
  let gobj = gtk_source_file_loader_get_location(cast[ptr FileLoader00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc location*(self: FileLoader): gio.GFile =
  let gobj = gtk_source_file_loader_get_location(cast[ptr FileLoader00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_loader_get_newline_type(self: ptr FileLoader00): NewlineType {.
    importc, libprag.}

proc getNewlineType*(self: FileLoader): NewlineType =
  gtk_source_file_loader_get_newline_type(cast[ptr FileLoader00](self.impl))

proc newlineType*(self: FileLoader): NewlineType =
  gtk_source_file_loader_get_newline_type(cast[ptr FileLoader00](self.impl))

proc gtk_source_file_loader_load_async(self: ptr FileLoader00; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; progressCallback: FileProgressCallback;
    progressCallbackData: pointer; progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc loadAsync*(self: FileLoader; ioPriority: int;
    cancellable: gio.Cancellable = nil; progressCallback: FileProgressCallback;
    progressCallbackData: pointer; progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback;
    userData: pointer) =
  gtk_source_file_loader_load_async(cast[ptr FileLoader00](self.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), progressCallback, progressCallbackData, progressCallbackNotify, callback, userData)

proc gtk_source_file_loader_load_finish(self: ptr FileLoader00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc loadFinish*(self: FileLoader; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_file_loader_load_finish(cast[ptr FileLoader00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_file_loader_set_candidate_encodings(self: ptr FileLoader00;
    candidateEncodings: ptr glib.SList) {.
    importc, libprag.}

proc setCandidateEncodings*(self: FileLoader; candidateEncodings: seq[Encoding]) =
  var tempResGL = seq2GSList(candidateEncodings)
  gtk_source_file_loader_set_candidate_encodings(cast[ptr FileLoader00](self.impl), tempResGL)
  g_slist_free(tempResGL)

proc `candidateEncodings=`*(self: FileLoader; candidateEncodings: seq[Encoding]) =
  var tempResGL = seq2GSList(candidateEncodings)
  gtk_source_file_loader_set_candidate_encodings(cast[ptr FileLoader00](self.impl), tempResGL)
  g_slist_free(tempResGL)

type
  FileLoaderError* {.size: sizeof(cint), pure.} = enum
    tooBig = 0
    encodingAutoDetectionFailed = 1
    conversionFallback = 2

type
  FileSaver* = ref object of gobject.Object
  FileSaver00* = object of gobject.Object00

proc gtk_source_file_saver_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(FileSaver()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_file_saver_new(buffer: ptr Buffer00; file: ptr File00): ptr FileSaver00 {.
    importc, libprag.}

proc newFileSaver*(buffer: Buffer; file: File): FileSaver =
  let gobj = gtk_source_file_saver_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileSaver*(tdesc: typedesc; buffer: Buffer; file: File): tdesc =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileSaver*[T](result: var T; buffer: Buffer; file: File) {.deprecated.} =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_new_with_target(buffer: ptr Buffer00; file: ptr File00;
    targetLocation: ptr gio.GFile00): ptr FileSaver00 {.
    importc, libprag.}

proc newFileSaverWithTarget*(buffer: Buffer; file: File; targetLocation: gio.GFile): FileSaver =
  let gobj = gtk_source_file_saver_new_with_target(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.GFile00](targetLocation.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newFileSaverWithTarget*(tdesc: typedesc; buffer: Buffer; file: File; targetLocation: gio.GFile): tdesc =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new_with_target(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.GFile00](targetLocation.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileSaverWithTarget*[T](result: var T; buffer: Buffer; file: File; targetLocation: gio.GFile) {.deprecated.} =
  assert(result is FileSaver)
  let gobj = gtk_source_file_saver_new_with_target(cast[ptr Buffer00](buffer.impl), cast[ptr File00](file.impl), cast[ptr gio.GFile00](targetLocation.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_get_buffer(self: ptr FileSaver00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: FileSaver): Buffer =
  let gobj = gtk_source_file_saver_get_buffer(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: FileSaver): Buffer =
  let gobj = gtk_source_file_saver_get_buffer(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_get_compression_type(self: ptr FileSaver00): CompressionType {.
    importc, libprag.}

proc getCompressionType*(self: FileSaver): CompressionType =
  gtk_source_file_saver_get_compression_type(cast[ptr FileSaver00](self.impl))

proc compressionType*(self: FileSaver): CompressionType =
  gtk_source_file_saver_get_compression_type(cast[ptr FileSaver00](self.impl))

proc gtk_source_file_saver_get_encoding(self: ptr FileSaver00): ptr Encoding00 {.
    importc, libprag.}

proc getEncoding*(self: FileSaver): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_saver_get_encoding(cast[ptr FileSaver00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc encoding*(self: FileSaver): Encoding =
  fnew(result, gBoxedFreeGtkSourceEncoding)
  result.impl = gtk_source_file_saver_get_encoding(cast[ptr FileSaver00](self.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gtk_source_encoding_get_type(), result.impl))

proc gtk_source_file_saver_get_file(self: ptr FileSaver00): ptr File00 {.
    importc, libprag.}

proc getFile*(self: FileSaver): File =
  let gobj = gtk_source_file_saver_get_file(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc file*(self: FileSaver): File =
  let gobj = gtk_source_file_saver_get_file(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_get_location(self: ptr FileSaver00): ptr gio.GFile00 {.
    importc, libprag.}

proc getLocation*(self: FileSaver): gio.GFile =
  let gobj = gtk_source_file_saver_get_location(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc location*(self: FileSaver): gio.GFile =
  let gobj = gtk_source_file_saver_get_location(cast[ptr FileSaver00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_file_saver_get_newline_type(self: ptr FileSaver00): NewlineType {.
    importc, libprag.}

proc getNewlineType*(self: FileSaver): NewlineType =
  gtk_source_file_saver_get_newline_type(cast[ptr FileSaver00](self.impl))

proc newlineType*(self: FileSaver): NewlineType =
  gtk_source_file_saver_get_newline_type(cast[ptr FileSaver00](self.impl))

proc gtk_source_file_saver_save_async(self: ptr FileSaver00; ioPriority: int32;
    cancellable: ptr gio.Cancellable00; progressCallback: FileProgressCallback;
    progressCallbackData: pointer; progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc saveAsync*(self: FileSaver; ioPriority: int; cancellable: gio.Cancellable = nil;
    progressCallback: FileProgressCallback; progressCallbackData: pointer;
    progressCallbackNotify: DestroyNotify; callback: AsyncReadyCallback; userData: pointer) =
  gtk_source_file_saver_save_async(cast[ptr FileSaver00](self.impl), int32(ioPriority), if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), progressCallback, progressCallbackData, progressCallbackNotify, callback, userData)

proc gtk_source_file_saver_save_finish(self: ptr FileSaver00; resu: ptr gio.AsyncResult00;
    error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc saveFinish*(self: FileSaver; resu: gio.AsyncResult): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_file_saver_save_finish(cast[ptr FileSaver00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_file_saver_set_compression_type(self: ptr FileSaver00; compressionType: CompressionType) {.
    importc, libprag.}

proc setCompressionType*(self: FileSaver; compressionType: CompressionType) =
  gtk_source_file_saver_set_compression_type(cast[ptr FileSaver00](self.impl), compressionType)

proc `compressionType=`*(self: FileSaver; compressionType: CompressionType) =
  gtk_source_file_saver_set_compression_type(cast[ptr FileSaver00](self.impl), compressionType)

proc gtk_source_file_saver_set_encoding(self: ptr FileSaver00; encoding: ptr Encoding00) {.
    importc, libprag.}

proc setEncoding*(self: FileSaver; encoding: Encoding = nil) =
  gtk_source_file_saver_set_encoding(cast[ptr FileSaver00](self.impl), if encoding.isNil: nil else: cast[ptr Encoding00](encoding.impl))

proc `encoding=`*(self: FileSaver; encoding: Encoding = nil) =
  gtk_source_file_saver_set_encoding(cast[ptr FileSaver00](self.impl), if encoding.isNil: nil else: cast[ptr Encoding00](encoding.impl))

proc gtk_source_file_saver_set_newline_type(self: ptr FileSaver00; newlineType: NewlineType) {.
    importc, libprag.}

proc setNewlineType*(self: FileSaver; newlineType: NewlineType) =
  gtk_source_file_saver_set_newline_type(cast[ptr FileSaver00](self.impl), newlineType)

proc `newlineType=`*(self: FileSaver; newlineType: NewlineType) =
  gtk_source_file_saver_set_newline_type(cast[ptr FileSaver00](self.impl), newlineType)

type
  FileSaverFlag* {.size: sizeof(cint), pure.} = enum
    ignoreInvalidChars = 0
    ignoreModificationTime = 1
    createBackup = 2

  FileSaverFlags* {.size: sizeof(cint).} = set[FileSaverFlag]

const
  FileSaverFlagsNone* = FileSaverFlags({})
proc none*(t: typedesc[FileSaverFlags]): FileSaverFlags = FileSaverFlags({})

proc gtk_source_file_saver_get_flags(self: ptr FileSaver00): FileSaverFlags {.
    importc, libprag.}

proc getFlags*(self: FileSaver): FileSaverFlags =
  gtk_source_file_saver_get_flags(cast[ptr FileSaver00](self.impl))

proc flags*(self: FileSaver): FileSaverFlags =
  gtk_source_file_saver_get_flags(cast[ptr FileSaver00](self.impl))

proc gtk_source_file_saver_set_flags(self: ptr FileSaver00; flags: FileSaverFlags) {.
    importc, libprag.}

proc setFlags*(self: FileSaver; flags: FileSaverFlags) =
  gtk_source_file_saver_set_flags(cast[ptr FileSaver00](self.impl), flags)

proc `flags=`*(self: FileSaver; flags: FileSaverFlags) =
  gtk_source_file_saver_set_flags(cast[ptr FileSaver00](self.impl), flags)

type
  FileSaverError* {.size: sizeof(cint), pure.} = enum
    invalidChars = 0
    externallyModified = 1

type
  GutterRendererPixbuf* = ref object of GutterRenderer
  GutterRendererPixbuf00* = object of GutterRenderer00

proc gtk_source_gutter_renderer_pixbuf_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GutterRendererPixbuf()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_gutter_renderer_pixbuf_new(): ptr GutterRendererPixbuf00 {.
    importc, libprag.}

proc newGutterRendererPixbuf*(): GutterRendererPixbuf =
  let gobj = gtk_source_gutter_renderer_pixbuf_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGutterRendererPixbuf*(tdesc: typedesc): tdesc =
  assert(result is GutterRendererPixbuf)
  let gobj = gtk_source_gutter_renderer_pixbuf_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGutterRendererPixbuf*[T](result: var T) {.deprecated.} =
  assert(result is GutterRendererPixbuf)
  let gobj = gtk_source_gutter_renderer_pixbuf_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_pixbuf_get_gicon(self: ptr GutterRendererPixbuf00): ptr gio.Icon00 {.
    importc, libprag.}

proc getGicon*(self: GutterRendererPixbuf): gio.Icon =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_gicon(cast[ptr GutterRendererPixbuf00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gicon*(self: GutterRendererPixbuf): gio.Icon =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_gicon(cast[ptr GutterRendererPixbuf00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gio.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_pixbuf_get_icon_name(self: ptr GutterRendererPixbuf00): cstring {.
    importc, libprag.}

proc getIconName*(self: GutterRendererPixbuf): string =
  result = $gtk_source_gutter_renderer_pixbuf_get_icon_name(cast[ptr GutterRendererPixbuf00](self.impl))

proc iconName*(self: GutterRendererPixbuf): string =
  result = $gtk_source_gutter_renderer_pixbuf_get_icon_name(cast[ptr GutterRendererPixbuf00](self.impl))

proc gtk_source_gutter_renderer_pixbuf_get_pixbuf(self: ptr GutterRendererPixbuf00): ptr gdkpixbuf.Pixbuf00 {.
    importc, libprag.}

proc getPixbuf*(self: GutterRendererPixbuf): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: GutterRendererPixbuf): gdkpixbuf.Pixbuf =
  let gobj = gtk_source_gutter_renderer_pixbuf_get_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gdkpixbuf.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_pixbuf_set_gicon(self: ptr GutterRendererPixbuf00;
    icon: ptr gio.Icon00) {.
    importc, libprag.}

proc setGicon*(self: GutterRendererPixbuf;
    icon: gio.Icon = nil) =
  gtk_source_gutter_renderer_pixbuf_set_gicon(cast[ptr GutterRendererPixbuf00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc `gicon=`*(self: GutterRendererPixbuf;
    icon: gio.Icon = nil) =
  gtk_source_gutter_renderer_pixbuf_set_gicon(cast[ptr GutterRendererPixbuf00](self.impl), if icon.isNil: nil else: cast[ptr gio.Icon00](icon.impl))

proc gtk_source_gutter_renderer_pixbuf_set_icon_name(self: ptr GutterRendererPixbuf00;
    iconName: cstring) {.
    importc, libprag.}

proc setIconName*(self: GutterRendererPixbuf;
    iconName: cstring = nil) =
  gtk_source_gutter_renderer_pixbuf_set_icon_name(cast[ptr GutterRendererPixbuf00](self.impl), iconName)

proc `iconName=`*(self: GutterRendererPixbuf;
    iconName: cstring = nil) =
  gtk_source_gutter_renderer_pixbuf_set_icon_name(cast[ptr GutterRendererPixbuf00](self.impl), iconName)

proc gtk_source_gutter_renderer_pixbuf_set_pixbuf(self: ptr GutterRendererPixbuf00;
    pixbuf: ptr gdkpixbuf.Pixbuf00) {.
    importc, libprag.}

proc setPixbuf*(self: GutterRendererPixbuf;
    pixbuf: gdkpixbuf.Pixbuf = nil) =
  gtk_source_gutter_renderer_pixbuf_set_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl), if pixbuf.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

proc `pixbuf=`*(self: GutterRendererPixbuf;
    pixbuf: gdkpixbuf.Pixbuf = nil) =
  gtk_source_gutter_renderer_pixbuf_set_pixbuf(cast[ptr GutterRendererPixbuf00](self.impl), if pixbuf.isNil: nil else: cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl))

type
  GutterRendererText* = ref object of GutterRenderer
  GutterRendererText00* = object of GutterRenderer00

proc gtk_source_gutter_renderer_text_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(GutterRendererText()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_gutter_renderer_text_new(): ptr GutterRendererText00 {.
    importc, libprag.}

proc newGutterRendererText*(): GutterRendererText =
  let gobj = gtk_source_gutter_renderer_text_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newGutterRendererText*(tdesc: typedesc): tdesc =
  assert(result is GutterRendererText)
  let gobj = gtk_source_gutter_renderer_text_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initGutterRendererText*[T](result: var T) {.deprecated.} =
  assert(result is GutterRendererText)
  let gobj = gtk_source_gutter_renderer_text_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_gutter_renderer_text_measure(self: ptr GutterRendererText00;
    text: cstring; width: var int32; height: var int32) {.
    importc, libprag.}

proc measure*(self: GutterRendererText; text: cstring;
    width: var int = cast[var int](nil); height: var int = cast[var int](nil)) =
  var width_00: int32
  var height_00: int32
  gtk_source_gutter_renderer_text_measure(cast[ptr GutterRendererText00](self.impl), text, width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc gtk_source_gutter_renderer_text_measure_markup(self: ptr GutterRendererText00;
    markup: cstring; width: var int32; height: var int32) {.
    importc, libprag.}

proc measureMarkup*(self: GutterRendererText;
    markup: cstring; width: var int = cast[var int](nil); height: var int = cast[var int](nil)) =
  var width_00: int32
  var height_00: int32
  gtk_source_gutter_renderer_text_measure_markup(cast[ptr GutterRendererText00](self.impl), markup, width_00, height_00)
  if width.addr != nil:
    width = int(width_00)
  if height.addr != nil:
    height = int(height_00)

proc gtk_source_gutter_renderer_text_set_markup(self: ptr GutterRendererText00;
    markup: cstring; length: int32) {.
    importc, libprag.}

proc setMarkup*(self: GutterRendererText;
    markup: cstring; length: int) =
  gtk_source_gutter_renderer_text_set_markup(cast[ptr GutterRendererText00](self.impl), markup, int32(length))

proc gtk_source_gutter_renderer_text_set_text(self: ptr GutterRendererText00;
    text: cstring; length: int32) {.
    importc, libprag.}

proc setText*(self: GutterRendererText; text: cstring;
    length: int) =
  gtk_source_gutter_renderer_text_set_text(cast[ptr GutterRendererText00](self.impl), text, int32(length))

type
  LanguageManager* = ref object of gobject.Object
  LanguageManager00* = object of gobject.Object00

proc gtk_source_language_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(LanguageManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_language_manager_new(): ptr LanguageManager00 {.
    importc, libprag.}

proc newLanguageManager*(): LanguageManager =
  let gobj = gtk_source_language_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newLanguageManager*(tdesc: typedesc): tdesc =
  assert(result is LanguageManager)
  let gobj = gtk_source_language_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initLanguageManager*[T](result: var T) {.deprecated.} =
  assert(result is LanguageManager)
  let gobj = gtk_source_language_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_get_default(): ptr LanguageManager00 {.
    importc, libprag.}

proc getDefaultLanguageManager*(): LanguageManager =
  let gobj = gtk_source_language_manager_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_get_language(self: ptr LanguageManager00;
    id: cstring): ptr Language00 {.
    importc, libprag.}

proc getLanguage*(self: LanguageManager; id: cstring): Language =
  let gobj = gtk_source_language_manager_get_language(cast[ptr LanguageManager00](self.impl), id)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_get_language_ids(self: ptr LanguageManager00): ptr cstring {.
    importc, libprag.}

proc getLanguageIds*(self: LanguageManager): seq[string] =
  let resul0 = gtk_source_language_manager_get_language_ids(cast[ptr LanguageManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc languageIds*(self: LanguageManager): seq[string] =
  let resul0 = gtk_source_language_manager_get_language_ids(cast[ptr LanguageManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gtk_source_language_manager_get_search_path(self: ptr LanguageManager00): ptr cstring {.
    importc, libprag.}

proc getSearchPath*(self: LanguageManager): seq[string] =
  cstringArrayToSeq(gtk_source_language_manager_get_search_path(cast[ptr LanguageManager00](self.impl)))

proc searchPath*(self: LanguageManager): seq[string] =
  cstringArrayToSeq(gtk_source_language_manager_get_search_path(cast[ptr LanguageManager00](self.impl)))

proc gtk_source_language_manager_guess_language(self: ptr LanguageManager00;
    filename: cstring; contentType: cstring): ptr Language00 {.
    importc, libprag.}

proc guessLanguage*(self: LanguageManager; filename: cstring = nil;
    contentType: cstring = nil): Language =
  let gobj = gtk_source_language_manager_guess_language(cast[ptr LanguageManager00](self.impl), filename, contentType)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_language_manager_set_search_path(self: ptr LanguageManager00;
    dirs: ptr cstring) {.
    importc, libprag.}

proc setSearchPath*(self: LanguageManager; dirs: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_language_manager_set_search_path(cast[ptr LanguageManager00](self.impl), seq2CstringArray(dirs, fs469n23))

proc `searchPath=`*(self: LanguageManager; dirs: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_language_manager_set_search_path(cast[ptr LanguageManager00](self.impl), seq2CstringArray(dirs, fs469n23))

type
  Map* = ref object of View
  Map00* = object of View00

proc gtk_source_map_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Map()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_map_new(): ptr Map00 {.
    importc, libprag.}

proc newMap*(): Map =
  let gobj = gtk_source_map_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newMap*(tdesc: typedesc): tdesc =
  assert(result is Map)
  let gobj = gtk_source_map_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMap*[T](result: var T) {.deprecated.} =
  assert(result is Map)
  let gobj = gtk_source_map_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_map_get_view(self: ptr Map00): ptr View00 {.
    importc, libprag.}

proc getView*(self: Map): View =
  let gobj = gtk_source_map_get_view(cast[ptr Map00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc view*(self: Map): View =
  let gobj = gtk_source_map_get_view(cast[ptr Map00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_map_set_view(self: ptr Map00; view: ptr View00) {.
    importc, libprag.}

proc setView*(self: Map; view: View) =
  gtk_source_map_set_view(cast[ptr Map00](self.impl), cast[ptr View00](view.impl))

proc `view=`*(self: Map; view: View) =
  gtk_source_map_set_view(cast[ptr Map00](self.impl), cast[ptr View00](view.impl))

type
  PrintCompositor* = ref object of gobject.Object
  PrintCompositor00* = object of gobject.Object00

proc gtk_source_print_compositor_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(PrintCompositor()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_print_compositor_new(buffer: ptr Buffer00): ptr PrintCompositor00 {.
    importc, libprag.}

proc newPrintCompositor*(buffer: Buffer): PrintCompositor =
  let gobj = gtk_source_print_compositor_new(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPrintCompositor*(tdesc: typedesc; buffer: Buffer): tdesc =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPrintCompositor*[T](result: var T; buffer: Buffer) {.deprecated.} =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new(cast[ptr Buffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_print_compositor_new_from_view(view: ptr View00): ptr PrintCompositor00 {.
    importc, libprag.}

proc newPrintCompositorFromView*(view: View): PrintCompositor =
  let gobj = gtk_source_print_compositor_new_from_view(cast[ptr View00](view.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newPrintCompositorFromView*(tdesc: typedesc; view: View): tdesc =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new_from_view(cast[ptr View00](view.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPrintCompositorFromView*[T](result: var T; view: View) {.deprecated.} =
  assert(result is PrintCompositor)
  let gobj = gtk_source_print_compositor_new_from_view(cast[ptr View00](view.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_print_compositor_draw_page(self: ptr PrintCompositor00; context: ptr gtk4.PrintContext00;
    pageNr: int32) {.
    importc, libprag.}

proc drawPage*(self: PrintCompositor; context: gtk4.PrintContext;
    pageNr: int) =
  gtk_source_print_compositor_draw_page(cast[ptr PrintCompositor00](self.impl), cast[ptr gtk4.PrintContext00](context.impl), int32(pageNr))

proc gtk_source_print_compositor_get_body_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getBodyFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_body_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc bodyFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_body_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_bottom_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getBottomMargin*(self: PrintCompositor;
    unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_bottom_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_buffer(self: ptr PrintCompositor00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: PrintCompositor): Buffer =
  let gobj = gtk_source_print_compositor_get_buffer(cast[ptr PrintCompositor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: PrintCompositor): Buffer =
  let gobj = gtk_source_print_compositor_get_buffer(cast[ptr PrintCompositor00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_print_compositor_get_footer_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getFooterFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_footer_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc footerFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_footer_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_header_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getHeaderFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_header_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc headerFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_header_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_highlight_syntax(self: ptr PrintCompositor00): gboolean {.
    importc, libprag.}

proc getHighlightSyntax*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_highlight_syntax(cast[ptr PrintCompositor00](self.impl)))

proc highlightSyntax*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_highlight_syntax(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_left_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getLeftMargin*(self: PrintCompositor; unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_left_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_line_numbers_font_name(self: ptr PrintCompositor00): cstring {.
    importc, libprag.}

proc getLineNumbersFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc lineNumbersFontName*(self: PrintCompositor): string =
  let resul0 = gtk_source_print_compositor_get_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gtk_source_print_compositor_get_n_pages(self: ptr PrintCompositor00): int32 {.
    importc, libprag.}

proc getNPages*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_n_pages(cast[ptr PrintCompositor00](self.impl)))

proc nPages*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_n_pages(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_pagination_progress(self: ptr PrintCompositor00): cdouble {.
    importc, libprag.}

proc getPaginationProgress*(self: PrintCompositor): cdouble =
  gtk_source_print_compositor_get_pagination_progress(cast[ptr PrintCompositor00](self.impl))

proc paginationProgress*(self: PrintCompositor): cdouble =
  gtk_source_print_compositor_get_pagination_progress(cast[ptr PrintCompositor00](self.impl))

proc gtk_source_print_compositor_get_print_footer(self: ptr PrintCompositor00): gboolean {.
    importc, libprag.}

proc getPrintFooter*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_footer(cast[ptr PrintCompositor00](self.impl)))

proc printFooter*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_footer(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_print_header(self: ptr PrintCompositor00): gboolean {.
    importc, libprag.}

proc getPrintHeader*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_header(cast[ptr PrintCompositor00](self.impl)))

proc printHeader*(self: PrintCompositor): bool =
  toBool(gtk_source_print_compositor_get_print_header(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_print_line_numbers(self: ptr PrintCompositor00): uint32 {.
    importc, libprag.}

proc getPrintLineNumbers*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_print_line_numbers(cast[ptr PrintCompositor00](self.impl)))

proc printLineNumbers*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_print_line_numbers(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_right_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getRightMargin*(self: PrintCompositor;
    unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_right_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_tab_width(self: ptr PrintCompositor00): uint32 {.
    importc, libprag.}

proc getTabWidth*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_tab_width(cast[ptr PrintCompositor00](self.impl)))

proc tabWidth*(self: PrintCompositor): int =
  int(gtk_source_print_compositor_get_tab_width(cast[ptr PrintCompositor00](self.impl)))

proc gtk_source_print_compositor_get_top_margin(self: ptr PrintCompositor00;
    unit: gtk4.Unit): cdouble {.
    importc, libprag.}

proc getTopMargin*(self: PrintCompositor; unit: gtk4.Unit): cdouble =
  gtk_source_print_compositor_get_top_margin(cast[ptr PrintCompositor00](self.impl), unit)

proc gtk_source_print_compositor_get_wrap_mode(self: ptr PrintCompositor00): gtk4.WrapMode {.
    importc, libprag.}

proc getWrapMode*(self: PrintCompositor): gtk4.WrapMode =
  gtk_source_print_compositor_get_wrap_mode(cast[ptr PrintCompositor00](self.impl))

proc wrapMode*(self: PrintCompositor): gtk4.WrapMode =
  gtk_source_print_compositor_get_wrap_mode(cast[ptr PrintCompositor00](self.impl))

proc gtk_source_print_compositor_paginate(self: ptr PrintCompositor00; context: ptr gtk4.PrintContext00): gboolean {.
    importc, libprag.}

proc paginate*(self: PrintCompositor; context: gtk4.PrintContext): bool =
  toBool(gtk_source_print_compositor_paginate(cast[ptr PrintCompositor00](self.impl), cast[ptr gtk4.PrintContext00](context.impl)))

proc gtk_source_print_compositor_set_body_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setBodyFontName*(self: PrintCompositor;
    fontName: cstring) =
  gtk_source_print_compositor_set_body_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `bodyFontName=`*(self: PrintCompositor;
    fontName: cstring) =
  gtk_source_print_compositor_set_body_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_bottom_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setBottomMargin*(self: PrintCompositor;
    margin: cdouble; unit: gtk4.Unit) =
  gtk_source_print_compositor_set_bottom_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_footer_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setFooterFontName*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_footer_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `footerFontName=`*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_footer_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_footer_format(self: ptr PrintCompositor00;
    separator: gboolean; left: cstring; center: cstring; right: cstring) {.
    importc, libprag.}

proc setFooterFormat*(self: PrintCompositor;
    separator: bool; left: cstring = nil; center: cstring = nil; right: cstring = nil) =
  gtk_source_print_compositor_set_footer_format(cast[ptr PrintCompositor00](self.impl), gboolean(separator), left, center, right)

proc gtk_source_print_compositor_set_header_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setHeaderFontName*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_header_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `headerFontName=`*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_header_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_header_format(self: ptr PrintCompositor00;
    separator: gboolean; left: cstring; center: cstring; right: cstring) {.
    importc, libprag.}

proc setHeaderFormat*(self: PrintCompositor;
    separator: bool; left: cstring = nil; center: cstring = nil; right: cstring = nil) =
  gtk_source_print_compositor_set_header_format(cast[ptr PrintCompositor00](self.impl), gboolean(separator), left, center, right)

proc gtk_source_print_compositor_set_highlight_syntax(self: ptr PrintCompositor00;
    highlight: gboolean) {.
    importc, libprag.}

proc setHighlightSyntax*(self: PrintCompositor;
    highlight: bool = true) =
  gtk_source_print_compositor_set_highlight_syntax(cast[ptr PrintCompositor00](self.impl), gboolean(highlight))

proc `highlightSyntax=`*(self: PrintCompositor;
    highlight: bool) =
  gtk_source_print_compositor_set_highlight_syntax(cast[ptr PrintCompositor00](self.impl), gboolean(highlight))

proc gtk_source_print_compositor_set_left_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setLeftMargin*(self: PrintCompositor; margin: cdouble;
    unit: gtk4.Unit) =
  gtk_source_print_compositor_set_left_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_line_numbers_font_name(self: ptr PrintCompositor00;
    fontName: cstring) {.
    importc, libprag.}

proc setLineNumbersFontName*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc `lineNumbersFontName=`*(self: PrintCompositor;
    fontName: cstring = nil) =
  gtk_source_print_compositor_set_line_numbers_font_name(cast[ptr PrintCompositor00](self.impl), fontName)

proc gtk_source_print_compositor_set_print_footer(self: ptr PrintCompositor00;
    print: gboolean) {.
    importc, libprag.}

proc setPrintFooter*(self: PrintCompositor;
    print: bool = true) =
  gtk_source_print_compositor_set_print_footer(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc `printFooter=`*(self: PrintCompositor;
    print: bool) =
  gtk_source_print_compositor_set_print_footer(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc gtk_source_print_compositor_set_print_header(self: ptr PrintCompositor00;
    print: gboolean) {.
    importc, libprag.}

proc setPrintHeader*(self: PrintCompositor;
    print: bool = true) =
  gtk_source_print_compositor_set_print_header(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc `printHeader=`*(self: PrintCompositor;
    print: bool) =
  gtk_source_print_compositor_set_print_header(cast[ptr PrintCompositor00](self.impl), gboolean(print))

proc gtk_source_print_compositor_set_print_line_numbers(self: ptr PrintCompositor00;
    interval: uint32) {.
    importc, libprag.}

proc setPrintLineNumbers*(self: PrintCompositor;
    interval: int) =
  gtk_source_print_compositor_set_print_line_numbers(cast[ptr PrintCompositor00](self.impl), uint32(interval))

proc `printLineNumbers=`*(self: PrintCompositor;
    interval: int) =
  gtk_source_print_compositor_set_print_line_numbers(cast[ptr PrintCompositor00](self.impl), uint32(interval))

proc gtk_source_print_compositor_set_right_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setRightMargin*(self: PrintCompositor;
    margin: cdouble; unit: gtk4.Unit) =
  gtk_source_print_compositor_set_right_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_tab_width(self: ptr PrintCompositor00;
    width: uint32) {.
    importc, libprag.}

proc setTabWidth*(self: PrintCompositor; width: int) =
  gtk_source_print_compositor_set_tab_width(cast[ptr PrintCompositor00](self.impl), uint32(width))

proc `tabWidth=`*(self: PrintCompositor; width: int) =
  gtk_source_print_compositor_set_tab_width(cast[ptr PrintCompositor00](self.impl), uint32(width))

proc gtk_source_print_compositor_set_top_margin(self: ptr PrintCompositor00;
    margin: cdouble; unit: gtk4.Unit) {.
    importc, libprag.}

proc setTopMargin*(self: PrintCompositor; margin: cdouble;
    unit: gtk4.Unit) =
  gtk_source_print_compositor_set_top_margin(cast[ptr PrintCompositor00](self.impl), margin, unit)

proc gtk_source_print_compositor_set_wrap_mode(self: ptr PrintCompositor00;
    wrapMode: gtk4.WrapMode) {.
    importc, libprag.}

proc setWrapMode*(self: PrintCompositor; wrapMode: gtk4.WrapMode) =
  gtk_source_print_compositor_set_wrap_mode(cast[ptr PrintCompositor00](self.impl), wrapMode)

proc `wrapMode=`*(self: PrintCompositor; wrapMode: gtk4.WrapMode) =
  gtk_source_print_compositor_set_wrap_mode(cast[ptr PrintCompositor00](self.impl), wrapMode)

type
  Region* = ref object of gobject.Object
  Region00* = object of gobject.Object00

proc gtk_source_region_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Region()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_region_new(buffer: ptr gtk4.TextBuffer00): ptr Region00 {.
    importc, libprag.}

proc newRegion*(buffer: gtk4.TextBuffer): Region =
  let gobj = gtk_source_region_new(cast[ptr gtk4.TextBuffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newRegion*(tdesc: typedesc; buffer: gtk4.TextBuffer): tdesc =
  assert(result is Region)
  let gobj = gtk_source_region_new(cast[ptr gtk4.TextBuffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRegion*[T](result: var T; buffer: gtk4.TextBuffer) {.deprecated.} =
  assert(result is Region)
  let gobj = gtk_source_region_new(cast[ptr gtk4.TextBuffer00](buffer.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_region_add_region(self: ptr Region00; regionToAdd: ptr Region00) {.
    importc, libprag.}

proc addRegion*(self: Region; regionToAdd: Region = nil) =
  gtk_source_region_add_region(cast[ptr Region00](self.impl), if regionToAdd.isNil: nil else: cast[ptr Region00](regionToAdd.impl))

proc gtk_source_region_add_subregion(self: ptr Region00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc addSubregion*(self: Region; start: gtk4.TextIter;
    `end`: gtk4.TextIter) =
  gtk_source_region_add_subregion(cast[ptr Region00](self.impl), start, `end`)

proc gtk_source_region_get_bounds(self: ptr Region00; start: var gtk4.TextIter;
    `end`: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getBounds*(self: Region; start: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    `end`: var gtk4.TextIter = cast[var gtk4.TextIter](nil)): bool =
  toBool(gtk_source_region_get_bounds(cast[ptr Region00](self.impl), start, `end`))

proc gtk_source_region_get_buffer(self: ptr Region00): ptr gtk4.TextBuffer00 {.
    importc, libprag.}

proc getBuffer*(self: Region): gtk4.TextBuffer =
  let gobj = gtk_source_region_get_buffer(cast[ptr Region00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: Region): gtk4.TextBuffer =
  let gobj = gtk_source_region_get_buffer(cast[ptr Region00](self.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtk4.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_region_intersect_region(self: ptr Region00; region2: ptr Region00): ptr Region00 {.
    importc, libprag.}

proc intersectRegion*(self: Region; region2: Region = nil): Region =
  let gobj = gtk_source_region_intersect_region(cast[ptr Region00](self.impl), if region2.isNil: nil else: cast[ptr Region00](region2.impl))
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_region_intersect_subregion(self: ptr Region00; start: gtk4.TextIter;
    `end`: gtk4.TextIter): ptr Region00 {.
    importc, libprag.}

proc intersectSubregion*(self: Region; start: gtk4.TextIter;
    `end`: gtk4.TextIter): Region =
  let gobj = gtk_source_region_intersect_subregion(cast[ptr Region00](self.impl), start, `end`)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_region_is_empty(self: ptr Region00): gboolean {.
    importc, libprag.}

proc isEmpty*(self: Region): bool =
  toBool(gtk_source_region_is_empty(cast[ptr Region00](self.impl)))

proc gtk_source_region_subtract_region(self: ptr Region00; regionToSubtract: ptr Region00) {.
    importc, libprag.}

proc subtractRegion*(self: Region; regionToSubtract: Region = nil) =
  gtk_source_region_subtract_region(cast[ptr Region00](self.impl), if regionToSubtract.isNil: nil else: cast[ptr Region00](regionToSubtract.impl))

proc gtk_source_region_subtract_subregion(self: ptr Region00; start: gtk4.TextIter;
    `end`: gtk4.TextIter) {.
    importc, libprag.}

proc subtractSubregion*(self: Region; start: gtk4.TextIter;
    `end`: gtk4.TextIter) =
  gtk_source_region_subtract_subregion(cast[ptr Region00](self.impl), start, `end`)

proc gtk_source_region_to_string(self: ptr Region00): cstring {.
    importc, libprag.}

proc toString*(self: Region): string =
  let resul0 = gtk_source_region_to_string(cast[ptr Region00](self.impl))
  if resul0.isNil:
    return
  result = $resul0
  cogfree(resul0)

type
  RegionIter* {.pure, byRef.} = object
    dummy1*: pointer
    dummy2*: uint32
    dummy3*: pointer

proc gtk_source_region_iter_get_subregion(self: RegionIter; start: var gtk4.TextIter;
    `end`: var gtk4.TextIter): gboolean {.
    importc, libprag.}

proc getSubregion*(self: RegionIter; start: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    `end`: var gtk4.TextIter = cast[var gtk4.TextIter](nil)): bool =
  toBool(gtk_source_region_iter_get_subregion(self, start, `end`))

proc gtk_source_region_iter_is_end(self: RegionIter): gboolean {.
    importc, libprag.}

proc isEnd*(self: RegionIter): bool =
  toBool(gtk_source_region_iter_is_end(self))

proc gtk_source_region_iter_next(self: RegionIter): gboolean {.
    importc, libprag.}

proc next*(self: RegionIter): bool =
  toBool(gtk_source_region_iter_next(self))

proc gtk_source_region_get_start_region_iter(self: ptr Region00; iter: var RegionIter) {.
    importc, libprag.}

proc getStartRegionIter*(self: Region; iter: var RegionIter) =
  gtk_source_region_get_start_region_iter(cast[ptr Region00](self.impl), iter)

proc getStartRegionIter*(self: Region): RegionIter =
  gtk_source_region_get_start_region_iter(cast[ptr Region00](self.impl), result)

type
  SearchContext* = ref object of gobject.Object
  SearchContext00* = object of gobject.Object00

proc gtk_source_search_context_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SearchContext()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_search_context_backward(self: ptr SearchContext00; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter; hasWrappedAround: var gboolean): gboolean {.
    importc, libprag.}

proc backward*(self: SearchContext; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var hasWrappedAround_00: gboolean
  result = toBool(gtk_source_search_context_backward(cast[ptr SearchContext00](self.impl), iter, matchStart, matchEnd, hasWrappedAround_00))
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_backward_async(self: ptr SearchContext00;
    iter: gtk4.TextIter; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback;
    userData: pointer) {.
    importc, libprag.}

proc backwardAsync*(self: SearchContext; iter: gtk4.TextIter;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gtk_source_search_context_backward_async(cast[ptr SearchContext00](self.impl), iter, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gtk_source_search_context_backward_finish(self: ptr SearchContext00;
    resu: ptr gio.AsyncResult00; matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter;
    hasWrappedAround: var gboolean; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc backwardFinish*(self: SearchContext; resu: gio.AsyncResult;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var gerror: ptr glib.Error
  var hasWrappedAround_00: gboolean
  let resul0 = gtk_source_search_context_backward_finish(cast[ptr SearchContext00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), matchStart, matchEnd, hasWrappedAround_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_forward(self: ptr SearchContext00; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter; hasWrappedAround: var gboolean): gboolean {.
    importc, libprag.}

proc forward*(self: SearchContext; iter: gtk4.TextIter;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var hasWrappedAround_00: gboolean
  result = toBool(gtk_source_search_context_forward(cast[ptr SearchContext00](self.impl), iter, matchStart, matchEnd, hasWrappedAround_00))
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_forward_async(self: ptr SearchContext00; iter: gtk4.TextIter;
    cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc, libprag.}

proc forwardAsync*(self: SearchContext; iter: gtk4.TextIter;
    cancellable: gio.Cancellable = nil; callback: AsyncReadyCallback; userData: pointer) =
  gtk_source_search_context_forward_async(cast[ptr SearchContext00](self.impl), iter, if cancellable.isNil: nil else: cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gtk_source_search_context_forward_finish(self: ptr SearchContext00;
    resu: ptr gio.AsyncResult00; matchStart: var gtk4.TextIter; matchEnd: var gtk4.TextIter;
    hasWrappedAround: var gboolean; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc forwardFinish*(self: SearchContext; resu: gio.AsyncResult;
    matchStart: var gtk4.TextIter = cast[var gtk4.TextIter](nil); matchEnd: var gtk4.TextIter = cast[var gtk4.TextIter](nil);
    hasWrappedAround: var bool = cast[var bool](nil)): bool =
  var gerror: ptr glib.Error
  var hasWrappedAround_00: gboolean
  let resul0 = gtk_source_search_context_forward_finish(cast[ptr SearchContext00](self.impl), cast[ptr gio.AsyncResult00](resu.impl), matchStart, matchEnd, hasWrappedAround_00, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)
  if hasWrappedAround.addr != nil:
    hasWrappedAround = toBool(hasWrappedAround_00)

proc gtk_source_search_context_get_buffer(self: ptr SearchContext00): ptr Buffer00 {.
    importc, libprag.}

proc getBuffer*(self: SearchContext): Buffer =
  let gobj = gtk_source_search_context_get_buffer(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc buffer*(self: SearchContext): Buffer =
  let gobj = gtk_source_search_context_get_buffer(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_context_get_highlight(self: ptr SearchContext00): gboolean {.
    importc, libprag.}

proc getHighlight*(self: SearchContext): bool =
  toBool(gtk_source_search_context_get_highlight(cast[ptr SearchContext00](self.impl)))

proc highlight*(self: SearchContext): bool =
  toBool(gtk_source_search_context_get_highlight(cast[ptr SearchContext00](self.impl)))

proc gtk_source_search_context_get_match_style(self: ptr SearchContext00): ptr Style00 {.
    importc, libprag.}

proc getMatchStyle*(self: SearchContext): Style =
  let gobj = gtk_source_search_context_get_match_style(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc matchStyle*(self: SearchContext): Style =
  let gobj = gtk_source_search_context_get_match_style(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_context_get_occurrence_position(self: ptr SearchContext00;
    matchStart: gtk4.TextIter; matchEnd: gtk4.TextIter): int32 {.
    importc, libprag.}

proc getOccurrencePosition*(self: SearchContext;
    matchStart: gtk4.TextIter; matchEnd: gtk4.TextIter): int =
  int(gtk_source_search_context_get_occurrence_position(cast[ptr SearchContext00](self.impl), matchStart, matchEnd))

proc gtk_source_search_context_get_occurrences_count(self: ptr SearchContext00): int32 {.
    importc, libprag.}

proc getOccurrencesCount*(self: SearchContext): int =
  int(gtk_source_search_context_get_occurrences_count(cast[ptr SearchContext00](self.impl)))

proc occurrencesCount*(self: SearchContext): int =
  int(gtk_source_search_context_get_occurrences_count(cast[ptr SearchContext00](self.impl)))

proc gtk_source_search_context_get_regex_error(self: ptr SearchContext00): ptr glib.Error {.
    importc, libprag.}

proc getRegexError*(self: SearchContext): ptr glib.Error =
  gtk_source_search_context_get_regex_error(cast[ptr SearchContext00](self.impl))

proc regexError*(self: SearchContext): ptr glib.Error =
  gtk_source_search_context_get_regex_error(cast[ptr SearchContext00](self.impl))

proc gtk_source_search_context_replace(self: ptr SearchContext00; matchStart: gtk4.TextIter;
    matchEnd: gtk4.TextIter; replace: cstring; replaceLength: int32; error: ptr ptr glib.Error = nil): gboolean {.
    importc, libprag.}

proc replace*(self: SearchContext; matchStart: gtk4.TextIter;
    matchEnd: gtk4.TextIter; replace: cstring; replaceLength: int): bool =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_search_context_replace(cast[ptr SearchContext00](self.impl), matchStart, matchEnd, replace, int32(replaceLength), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = toBool(resul0)

proc gtk_source_search_context_replace_all(self: ptr SearchContext00; replace: cstring;
    replaceLength: int32; error: ptr ptr glib.Error = nil): uint32 {.
    importc, libprag.}

proc replaceAll*(self: SearchContext; replace: cstring;
    replaceLength: int): int =
  var gerror: ptr glib.Error
  let resul0 = gtk_source_search_context_replace_all(cast[ptr SearchContext00](self.impl), replace, int32(replaceLength), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  result = int(resul0)

proc gtk_source_search_context_set_highlight(self: ptr SearchContext00; highlight: gboolean) {.
    importc, libprag.}

proc setHighlight*(self: SearchContext; highlight: bool = true) =
  gtk_source_search_context_set_highlight(cast[ptr SearchContext00](self.impl), gboolean(highlight))

proc `highlight=`*(self: SearchContext; highlight: bool) =
  gtk_source_search_context_set_highlight(cast[ptr SearchContext00](self.impl), gboolean(highlight))

proc gtk_source_search_context_set_match_style(self: ptr SearchContext00;
    matchStyle: ptr Style00) {.
    importc, libprag.}

proc setMatchStyle*(self: SearchContext; matchStyle: Style = nil) =
  gtk_source_search_context_set_match_style(cast[ptr SearchContext00](self.impl), if matchStyle.isNil: nil else: cast[ptr Style00](matchStyle.impl))

proc `matchStyle=`*(self: SearchContext; matchStyle: Style = nil) =
  gtk_source_search_context_set_match_style(cast[ptr SearchContext00](self.impl), if matchStyle.isNil: nil else: cast[ptr Style00](matchStyle.impl))

type
  SearchSettings* = ref object of gobject.Object
  SearchSettings00* = object of gobject.Object00

proc gtk_source_search_settings_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SearchSettings()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_search_settings_new(): ptr SearchSettings00 {.
    importc, libprag.}

proc newSearchSettings*(): SearchSettings =
  let gobj = gtk_source_search_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSearchSettings*(tdesc: typedesc): tdesc =
  assert(result is SearchSettings)
  let gobj = gtk_source_search_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSearchSettings*[T](result: var T) {.deprecated.} =
  assert(result is SearchSettings)
  let gobj = gtk_source_search_settings_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_settings_get_at_word_boundaries(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getAtWordBoundaries*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_at_word_boundaries(cast[ptr SearchSettings00](self.impl)))

proc atWordBoundaries*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_at_word_boundaries(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_get_case_sensitive(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getCaseSensitive*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_case_sensitive(cast[ptr SearchSettings00](self.impl)))

proc caseSensitive*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_case_sensitive(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_get_regex_enabled(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getRegexEnabled*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_regex_enabled(cast[ptr SearchSettings00](self.impl)))

proc regexEnabled*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_regex_enabled(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_get_search_text(self: ptr SearchSettings00): cstring {.
    importc, libprag.}

proc getSearchText*(self: SearchSettings): string =
  let resul0 = gtk_source_search_settings_get_search_text(cast[ptr SearchSettings00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc searchText*(self: SearchSettings): string =
  let resul0 = gtk_source_search_settings_get_search_text(cast[ptr SearchSettings00](self.impl))
  if resul0.isNil:
    return
  result = $resul0

proc gtk_source_search_settings_get_wrap_around(self: ptr SearchSettings00): gboolean {.
    importc, libprag.}

proc getWrapAround*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_wrap_around(cast[ptr SearchSettings00](self.impl)))

proc wrapAround*(self: SearchSettings): bool =
  toBool(gtk_source_search_settings_get_wrap_around(cast[ptr SearchSettings00](self.impl)))

proc gtk_source_search_settings_set_at_word_boundaries(self: ptr SearchSettings00;
    atWordBoundaries: gboolean) {.
    importc, libprag.}

proc setAtWordBoundaries*(self: SearchSettings;
    atWordBoundaries: bool = true) =
  gtk_source_search_settings_set_at_word_boundaries(cast[ptr SearchSettings00](self.impl), gboolean(atWordBoundaries))

proc `atWordBoundaries=`*(self: SearchSettings;
    atWordBoundaries: bool) =
  gtk_source_search_settings_set_at_word_boundaries(cast[ptr SearchSettings00](self.impl), gboolean(atWordBoundaries))

proc gtk_source_search_settings_set_case_sensitive(self: ptr SearchSettings00;
    caseSensitive: gboolean) {.
    importc, libprag.}

proc setCaseSensitive*(self: SearchSettings;
    caseSensitive: bool = true) =
  gtk_source_search_settings_set_case_sensitive(cast[ptr SearchSettings00](self.impl), gboolean(caseSensitive))

proc `caseSensitive=`*(self: SearchSettings;
    caseSensitive: bool) =
  gtk_source_search_settings_set_case_sensitive(cast[ptr SearchSettings00](self.impl), gboolean(caseSensitive))

proc gtk_source_search_settings_set_regex_enabled(self: ptr SearchSettings00;
    regexEnabled: gboolean) {.
    importc, libprag.}

proc setRegexEnabled*(self: SearchSettings; regexEnabled: bool = true) =
  gtk_source_search_settings_set_regex_enabled(cast[ptr SearchSettings00](self.impl), gboolean(regexEnabled))

proc `regexEnabled=`*(self: SearchSettings; regexEnabled: bool) =
  gtk_source_search_settings_set_regex_enabled(cast[ptr SearchSettings00](self.impl), gboolean(regexEnabled))

proc gtk_source_search_settings_set_search_text(self: ptr SearchSettings00;
    searchText: cstring) {.
    importc, libprag.}

proc setSearchText*(self: SearchSettings; searchText: cstring = nil) =
  gtk_source_search_settings_set_search_text(cast[ptr SearchSettings00](self.impl), searchText)

proc `searchText=`*(self: SearchSettings; searchText: cstring = nil) =
  gtk_source_search_settings_set_search_text(cast[ptr SearchSettings00](self.impl), searchText)

proc gtk_source_search_settings_set_wrap_around(self: ptr SearchSettings00;
    wrapAround: gboolean) {.
    importc, libprag.}

proc setWrapAround*(self: SearchSettings; wrapAround: bool = true) =
  gtk_source_search_settings_set_wrap_around(cast[ptr SearchSettings00](self.impl), gboolean(wrapAround))

proc `wrapAround=`*(self: SearchSettings; wrapAround: bool) =
  gtk_source_search_settings_set_wrap_around(cast[ptr SearchSettings00](self.impl), gboolean(wrapAround))

proc gtk_source_search_context_new(buffer: ptr Buffer00; settings: ptr SearchSettings00): ptr SearchContext00 {.
    importc, libprag.}

proc newSearchContext*(buffer: Buffer; settings: SearchSettings = nil): SearchContext =
  let gobj = gtk_source_search_context_new(cast[ptr Buffer00](buffer.impl), if settings.isNil: nil else: cast[ptr SearchSettings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newSearchContext*(tdesc: typedesc; buffer: Buffer; settings: SearchSettings = nil): tdesc =
  assert(result is SearchContext)
  let gobj = gtk_source_search_context_new(cast[ptr Buffer00](buffer.impl), if settings.isNil: nil else: cast[ptr SearchSettings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSearchContext*[T](result: var T; buffer: Buffer; settings: SearchSettings = nil) {.deprecated.} =
  assert(result is SearchContext)
  let gobj = gtk_source_search_context_new(cast[ptr Buffer00](buffer.impl), if settings.isNil: nil else: cast[ptr SearchSettings00](settings.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_search_context_get_settings(self: ptr SearchContext00): ptr SearchSettings00 {.
    importc, libprag.}

proc getSettings*(self: SearchContext): SearchSettings =
  let gobj = gtk_source_search_context_get_settings(cast[ptr SearchContext00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  StyleSchemeChooser00* = object of gobject.Object00
  StyleSchemeChooser* = ref object of gobject.Object

type
  StyleSchemeChooserWidget* = ref object of gtk4.Bin
  StyleSchemeChooserWidget00* = object of gtk4.Bin00

proc gtk_source_style_scheme_chooser_widget_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleSchemeChooserWidget()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_chooser_widget_new(): ptr StyleSchemeChooserWidget00 {.
    importc, libprag.}

proc newStyleSchemeChooserWidget*(): StyleSchemeChooserWidget =
  let gobj = gtk_source_style_scheme_chooser_widget_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStyleSchemeChooserWidget*(tdesc: typedesc): tdesc =
  assert(result is StyleSchemeChooserWidget)
  let gobj = gtk_source_style_scheme_chooser_widget_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStyleSchemeChooserWidget*[T](result: var T) {.deprecated.} =
  assert(result is StyleSchemeChooserWidget)
  let gobj = gtk_source_style_scheme_chooser_widget_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  StyleSchemeChooserButton* = ref object of gtk4.Button
  StyleSchemeChooserButton00* = object of gtk4.Button00

proc gtk_source_style_scheme_chooser_button_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleSchemeChooserButton()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_chooser_button_new(): ptr StyleSchemeChooserButton00 {.
    importc, libprag.}

proc newStyleSchemeChooserButton*(): StyleSchemeChooserButton =
  let gobj = gtk_source_style_scheme_chooser_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStyleSchemeChooserButton*(tdesc: typedesc): tdesc =
  assert(result is StyleSchemeChooserButton)
  let gobj = gtk_source_style_scheme_chooser_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStyleSchemeChooserButton*[T](result: var T) {.deprecated.} =
  assert(result is StyleSchemeChooserButton)
  let gobj = gtk_source_style_scheme_chooser_button_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_chooser_get_style_scheme(self: ptr StyleSchemeChooser00): ptr StyleScheme00 {.
    importc, libprag.}

proc getStyleScheme*(self: StyleSchemeChooser | StyleSchemeChooserWidget | StyleSchemeChooserButton): StyleScheme =
  let gobj = gtk_source_style_scheme_chooser_get_style_scheme(cast[ptr StyleSchemeChooser00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc styleScheme*(self: StyleSchemeChooser | StyleSchemeChooserWidget | StyleSchemeChooserButton): StyleScheme =
  let gobj = gtk_source_style_scheme_chooser_get_style_scheme(cast[ptr StyleSchemeChooser00](self.impl))
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_chooser_set_style_scheme(self: ptr StyleSchemeChooser00;
    scheme: ptr StyleScheme00) {.
    importc, libprag.}

proc setStyleScheme*(self: StyleSchemeChooser | StyleSchemeChooserWidget | StyleSchemeChooserButton;
    scheme: StyleScheme) =
  gtk_source_style_scheme_chooser_set_style_scheme(cast[ptr StyleSchemeChooser00](self.impl), cast[ptr StyleScheme00](scheme.impl))

proc `styleScheme=`*(self: StyleSchemeChooser | StyleSchemeChooserWidget | StyleSchemeChooserButton;
    scheme: StyleScheme) =
  gtk_source_style_scheme_chooser_set_style_scheme(cast[ptr StyleSchemeChooser00](self.impl), cast[ptr StyleScheme00](scheme.impl))

type
  StyleSchemeManager* = ref object of gobject.Object
  StyleSchemeManager00* = object of gobject.Object00

proc gtk_source_style_scheme_manager_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(StyleSchemeManager()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_style_scheme_manager_new(): ptr StyleSchemeManager00 {.
    importc, libprag.}

proc newStyleSchemeManager*(): StyleSchemeManager =
  let gobj = gtk_source_style_scheme_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newStyleSchemeManager*(tdesc: typedesc): tdesc =
  assert(result is StyleSchemeManager)
  let gobj = gtk_source_style_scheme_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStyleSchemeManager*[T](result: var T) {.deprecated.} =
  assert(result is StyleSchemeManager)
  let gobj = gtk_source_style_scheme_manager_new()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_manager_get_default(): ptr StyleSchemeManager00 {.
    importc, libprag.}

proc getDefaultStyleSchemeManager*(): StyleSchemeManager =
  let gobj = gtk_source_style_scheme_manager_get_default()
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_manager_append_search_path(self: ptr StyleSchemeManager00;
    path: cstring) {.
    importc, libprag.}

proc appendSearchPath*(self: StyleSchemeManager;
    path: cstring) =
  gtk_source_style_scheme_manager_append_search_path(cast[ptr StyleSchemeManager00](self.impl), path)

proc gtk_source_style_scheme_manager_force_rescan(self: ptr StyleSchemeManager00) {.
    importc, libprag.}

proc forceRescan*(self: StyleSchemeManager) =
  gtk_source_style_scheme_manager_force_rescan(cast[ptr StyleSchemeManager00](self.impl))

proc gtk_source_style_scheme_manager_get_scheme(self: ptr StyleSchemeManager00;
    schemeId: cstring): ptr StyleScheme00 {.
    importc, libprag.}

proc getScheme*(self: StyleSchemeManager;
    schemeId: cstring): StyleScheme =
  let gobj = gtk_source_style_scheme_manager_get_scheme(cast[ptr StyleSchemeManager00](self.impl), schemeId)
  if gobj.isNil:
    return nil
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gtk_source_style_scheme_manager_get_scheme_ids(self: ptr StyleSchemeManager00): ptr cstring {.
    importc, libprag.}

proc getSchemeIds*(self: StyleSchemeManager): seq[string] =
  let resul0 = gtk_source_style_scheme_manager_get_scheme_ids(cast[ptr StyleSchemeManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc schemeIds*(self: StyleSchemeManager): seq[string] =
  let resul0 = gtk_source_style_scheme_manager_get_scheme_ids(cast[ptr StyleSchemeManager00](self.impl))
  if resul0.isNil:
    return
  cstringArrayToSeq(resul0)

proc gtk_source_style_scheme_manager_get_search_path(self: ptr StyleSchemeManager00): ptr cstring {.
    importc, libprag.}

proc getSearchPath*(self: StyleSchemeManager): seq[string] =
  cstringArrayToSeq(gtk_source_style_scheme_manager_get_search_path(cast[ptr StyleSchemeManager00](self.impl)))

proc searchPath*(self: StyleSchemeManager): seq[string] =
  cstringArrayToSeq(gtk_source_style_scheme_manager_get_search_path(cast[ptr StyleSchemeManager00](self.impl)))

proc gtk_source_style_scheme_manager_prepend_search_path(self: ptr StyleSchemeManager00;
    path: cstring) {.
    importc, libprag.}

proc prependSearchPath*(self: StyleSchemeManager;
    path: cstring) =
  gtk_source_style_scheme_manager_prepend_search_path(cast[ptr StyleSchemeManager00](self.impl), path)

proc gtk_source_style_scheme_manager_set_search_path(self: ptr StyleSchemeManager00;
    path: ptr cstring) {.
    importc, libprag.}

proc setSearchPath*(self: StyleSchemeManager;
    path: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_style_scheme_manager_set_search_path(cast[ptr StyleSchemeManager00](self.impl), seq2CstringArray(path, fs469n23))

proc `searchPath=`*(self: StyleSchemeManager;
    path: varargs[string, `$`]) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gtk_source_style_scheme_manager_set_search_path(cast[ptr StyleSchemeManager00](self.impl), seq2CstringArray(path, fs469n23))

type
  Tag* = ref object of gtk4.TextTag
  Tag00* = object of gtk4.TextTag00

proc gtk_source_tag_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(Tag()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gtk_source_tag_new(name: cstring): ptr Tag00 {.
    importc, libprag.}

proc newTag*(name: cstring = nil): Tag =
  let gobj = gtk_source_tag_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc newTag*(tdesc: typedesc; name: cstring = nil): tdesc =
  assert(result is Tag)
  let gobj = gtk_source_tag_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTag*[T](result: var T; name: cstring = nil) {.deprecated.} =
  assert(result is Tag)
  let gobj = gtk_source_tag_new(name)
  let qdata = g_object_get_qdata(gobj, Quark)
  if qdata != nil:
    result = cast[type(result)](qdata)
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    if g_object_is_floating(result.impl).int != 0:
      discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ViewGutterPosition* {.size: sizeof(cint), pure.} = enum
    lines = -30
    marks = -20

proc finalize*() {.
    importc: "gtk_source_finalize", libprag.}

proc init*() {.
    importc: "gtk_source_init", libprag.}

proc gtk_source_utils_escape_search_text(text: cstring): cstring {.
    importc, libprag.}

proc utilsEscapeSearchText*(text: cstring): string =
  let resul0 = gtk_source_utils_escape_search_text(text)
  result = $resul0
  cogfree(resul0)

proc gtk_source_utils_unescape_search_text(text: cstring): cstring {.
    importc, libprag.}

proc utilsUnescapeSearchText*(text: cstring): string =
  let resul0 = gtk_source_utils_unescape_search_text(text)
  result = $resul0
  cogfree(resul0)
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc buildable*(x: gtksource5.Completion): gtk4.Buildable = cast[gtk4.Buildable](x)

proc implementorIface*(x: gtksource5.CompletionInfo): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: gtksource5.CompletionInfo): gtk4.Buildable = cast[gtk4.Buildable](x)

proc implementorIface*(x: gtksource5.Map): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: gtksource5.Map): gtk4.Buildable = cast[gtk4.Buildable](x)

proc scrollable*(x: gtksource5.Map): gtk4.Scrollable = cast[gtk4.Scrollable](x)

proc implementorIface*(x: gtksource5.StyleSchemeChooserButton): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc actionable*(x: gtksource5.StyleSchemeChooserButton): gtk4.Actionable = cast[gtk4.Actionable](x)

proc activatable*(x: gtksource5.StyleSchemeChooserButton): gtk4.Activatable = cast[gtk4.Activatable](x)

proc buildable*(x: gtksource5.StyleSchemeChooserButton): gtk4.Buildable = cast[gtk4.Buildable](x)

proc implementorIface*(x: gtksource5.StyleSchemeChooserWidget): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: gtksource5.StyleSchemeChooserWidget): gtk4.Buildable = cast[gtk4.Buildable](x)

proc implementorIface*(x: gtksource5.View): atk.ImplementorIface = cast[atk.ImplementorIface](x)

proc buildable*(x: gtksource5.View): gtk4.Buildable = cast[gtk4.Buildable](x)

proc scrollable*(x: gtksource5.View): gtk4.Scrollable = cast[gtk4.Scrollable](x)

proc getView*(builder: Builder; name: string): View =
  let gt = g_type_from_name("GSource")
  assert(gt != g_type_invalid_get_type())
  let gobj = gtk_builder_get_object(cast[ptr Builder00](builder.impl), name)
  assert(gobj != nil)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[type(result)](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource5.finalizeGObject)
    result.impl = gobj
    result.ignoreFinalizer = true
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](result.impl), gt)))
