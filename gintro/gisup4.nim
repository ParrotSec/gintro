const
  SCA = [
    "activate!SimpleAction!1!(self: SimpleAction; parameter: glib.Variant = nil)!(self: ptr SimpleAction00; parameter: ptr glib.Variant00)",
    "change_state!SimpleAction!1!(self: SimpleAction; value: glib.Variant = nil)!(self: ptr SimpleAction00; value: ptr glib.Variant00)",
    "command_line!GApplication!1!(self: GApplication; commandLine: ApplicationCommandLine): int!(self: ptr GApplication00; commandLine: ptr ApplicationCommandLine00): int32",
    "handle_local_options!GApplication!1!(self: GApplication; options: glib.VariantDict): int!(self: ptr GApplication00; options: ptr glib.VariantDict00): int32",
    "name_lost!GApplication!0!(self: GApplication): bool!(self: ptr GApplication00): gboolean",
    "open!GApplication!3!(self: GApplication; files: GFile00Array; nFiles: int; hint: cstring)!(self: ptr GApplication00; files: GFile00Array; nFiles: int32; hint: cstring)",
    "action_added!ActionGroup!1!(self: ActionGroup | GApplication | SimpleActionGroup | DBusActionGroup; actionName: cstring)!(self: ptr ActionGroup00; actionName: cstring)",
    "action_enabled_changed!ActionGroup!2!(self: ActionGroup | GApplication | SimpleActionGroup | DBusActionGroup; actionName: cstring; enabled: bool)!(self: ptr ActionGroup00; actionName: cstring; enabled: gboolean)",
    "action_removed!ActionGroup!1!(self: ActionGroup | GApplication | SimpleActionGroup | DBusActionGroup; actionName: cstring)!(self: ptr ActionGroup00; actionName: cstring)",
    "action_state_changed!ActionGroup!2!(self: ActionGroup | GApplication | SimpleActionGroup | DBusActionGroup; actionName: cstring; value: glib.Variant)!(self: ptr ActionGroup00; actionName: cstring; value: ptr glib.Variant00)",
    "ask_password!MountOperation!4!(self: MountOperation; message: cstring; defaultUser: cstring; defaultDomain: cstring; flags: AskPasswordFlags)!(self: ptr MountOperation00; message: cstring; defaultUser: cstring; defaultDomain: cstring; flags: AskPasswordFlags)",
    "ask_question!MountOperation!2!(self: MountOperation; message: cstring; choices: varargs[string, `$`])!(self: ptr MountOperation00; message: cstring; choices: cstringArray)",
    "reply!MountOperation!1!(self: MountOperation; resu: MountOperationResult)!(self: ptr MountOperation00; resu: MountOperationResult)",
    "show_processes!MountOperation!3!(self: MountOperation; message: cstring; processes: GArray00Array; choices: varargs[string, `$`])!(self: ptr MountOperation00; message: cstring; processes: GArray00Array; choices: cstringArray)",
    "show_unmount_progress!MountOperation!3!(self: MountOperation; message: cstring; timeLeft: int64; bytesLeft: int64)!(self: ptr MountOperation00; message: cstring; timeLeft: int64; bytesLeft: int64)",
    "launch_failed!AppLaunchContext!1!(self: AppLaunchContext; startupNotifyId: cstring)!(self: ptr AppLaunchContext00; startupNotifyId: cstring)",
    "launched!AppLaunchContext!2!(self: AppLaunchContext; info: AppInfo | DesktopAppInfo; platformData: glib.Variant)!(self: ptr AppLaunchContext00; info: ptr AppInfo00; platformData: ptr glib.Variant00)",
    "closed!DBusConnection!2!(self: DBusConnection; remotePeerVanished: bool; error: ptr glib.Error)!(self: ptr DBusConnection00; remotePeerVanished: gboolean; error: ptr glib.Error)",
    "items_changed!MenuModel!3!(self: MenuModel; position: int; removed: int; added: int)!(self: ptr MenuModel00; position: int32; removed: int32; added: int32)",
    "allow_mechanism!DBusAuthObserver!1!(self: DBusAuthObserver; mechanism: cstring): bool!(self: ptr DBusAuthObserver00; mechanism: cstring): gboolean",
    "authorize_authenticated_peer!DBusAuthObserver!2!(self: DBusAuthObserver; stream: IOStream; credentials: Credentials = nil): bool!(self: ptr DBusAuthObserver00; stream: ptr IOStream00; credentials: ptr Credentials00): gboolean",
    "changed!FileMonitor!3!(self: FileMonitor; file: GFile; otherFile: GFile = nil; eventType: FileMonitorEvent)!(self: ptr FileMonitor00; file: ptr GFile00; otherFile: ptr GFile00; eventType: FileMonitorEvent)",
    "g_properties_changed!DBusProxy!2!(self: DBusProxy; changedProperties: glib.Variant; invalidatedProperties: varargs[string, `$`])!(self: ptr DBusProxy00; changedProperties: ptr glib.Variant00; invalidatedProperties: cstringArray)",
    "g_signal!DBusProxy!3!(self: DBusProxy; senderName: cstring = nil; signalName: cstring; parameters: glib.Variant)!(self: ptr DBusProxy00; senderName: cstring; signalName: cstring; parameters: ptr glib.Variant00)",
    "interface_proxy_properties_changed!DBusObjectManagerClient!4!(self: DBusObjectManagerClient; objectProxy: DBusObjectProxy; interfaceProxy: DBusProxy; changedProperties: glib.Variant; invalidatedProperties: varargs[string, `$`])!(self: ptr DBusObjectManagerClient00; objectProxy: ptr DBusObjectProxy00; interfaceProxy: ptr DBusProxy00; changedProperties: ptr glib.Variant00; invalidatedProperties: cstringArray)",
    "interface_proxy_signal!DBusObjectManagerClient!5!(self: DBusObjectManagerClient; objectProxy: DBusObjectProxy; interfaceProxy: DBusProxy; senderName: cstring; signalName: cstring; parameters: glib.Variant)!(self: ptr DBusObjectManagerClient00; objectProxy: ptr DBusObjectProxy00; interfaceProxy: ptr DBusProxy00; senderName: cstring; signalName: cstring; parameters: ptr glib.Variant00)",
    "g_authorize_method!DBusInterfaceSkeleton!1!(self: DBusInterfaceSkeleton; invocation: DBusMethodInvocation): bool!(self: ptr DBusInterfaceSkeleton00; invocation: ptr DBusMethodInvocation00): gboolean",
    "authorize_method!DBusObjectSkeleton!2!(self: DBusObjectSkeleton; `interface`: DBusInterfaceSkeleton; invocation: DBusMethodInvocation): bool!(self: ptr DBusObjectSkeleton00; `interface`: ptr DBusInterfaceSkeleton00; invocation: ptr DBusMethodInvocation00): gboolean",
    "interface_added!DBusObject!1!(self: DBusObject | DBusObjectSkeleton | DBusObjectProxy; `interface`: DBusInterface | DBusProxy | DBusInterfaceSkeleton)!(self: ptr DBusObject00; `interface`: ptr DBusInterface00)",
    "interface_removed!DBusObject!1!(self: DBusObject | DBusObjectSkeleton | DBusObjectProxy; `interface`: DBusInterface | DBusProxy | DBusInterfaceSkeleton)!(self: ptr DBusObject00; `interface`: ptr DBusInterface00)",
    "interface_added!DBusObjectManager!2!(self: DBusObjectManager | DBusObjectManagerClient | DBusObjectManagerServer; `object`: DBusObject | DBusObjectSkeleton | DBusObjectProxy; `interface`: DBusInterface | DBusProxy | DBusInterfaceSkeleton)!(self: ptr DBusObjectManager00; `object`: ptr DBusObject00; `interface`: ptr DBusInterface00)",
    "interface_removed!DBusObjectManager!2!(self: DBusObjectManager | DBusObjectManagerClient | DBusObjectManagerServer; `object`: DBusObject | DBusObjectSkeleton | DBusObjectProxy; `interface`: DBusInterface | DBusProxy | DBusInterfaceSkeleton)!(self: ptr DBusObjectManager00; `object`: ptr DBusObject00; `interface`: ptr DBusInterface00)",
    "object_added!DBusObjectManager!1!(self: DBusObjectManager | DBusObjectManagerClient | DBusObjectManagerServer; `object`: DBusObject | DBusObjectSkeleton | DBusObjectProxy)!(self: ptr DBusObjectManager00; `object`: ptr DBusObject00)",
    "object_removed!DBusObjectManager!1!(self: DBusObjectManager | DBusObjectManagerClient | DBusObjectManagerServer; `object`: DBusObject | DBusObjectSkeleton | DBusObjectProxy)!(self: ptr DBusObjectManager00; `object`: ptr DBusObject00)",
    "new_connection!DBusServer!1!(self: DBusServer; connection: DBusConnection): bool!(self: ptr DBusServer00; connection: ptr DBusConnection00): gboolean",
    "accept_certificate!DtlsConnection!2!(self: DtlsConnection; peerCert: TlsCertificate; errors: TlsCertificateFlags): bool!(self: ptr DtlsConnection00; peerCert: ptr TlsCertificate00; errors: TlsCertificateFlags): gboolean",
    "accept_certificate!TlsConnection!2!(self: TlsConnection; peerCert: TlsCertificate; errors: TlsCertificateFlags): bool!(self: ptr TlsConnection00; peerCert: ptr TlsCertificate00; errors: TlsCertificateFlags): gboolean",
    "items_changed!ListModel!3!(self: ListModel | ListStore; position: int; removed: int; added: int)!(self: ptr ListModel00; position: uint32; removed: uint32; added: uint32)",
    "low_memory_warning!MemoryMonitor!1!(self: MemoryMonitor; level: MemoryMonitorWarningLevel)!(self: ptr MemoryMonitor00; level: MemoryMonitorWarningLevel)",
    "drive_changed!VolumeMonitor!1!(self: VolumeMonitor; drive: Drive)!(self: ptr VolumeMonitor00; drive: ptr Drive00)",
    "drive_connected!VolumeMonitor!1!(self: VolumeMonitor; drive: Drive)!(self: ptr VolumeMonitor00; drive: ptr Drive00)",
    "drive_disconnected!VolumeMonitor!1!(self: VolumeMonitor; drive: Drive)!(self: ptr VolumeMonitor00; drive: ptr Drive00)",
    "drive_eject_button!VolumeMonitor!1!(self: VolumeMonitor; drive: Drive)!(self: ptr VolumeMonitor00; drive: ptr Drive00)",
    "drive_stop_button!VolumeMonitor!1!(self: VolumeMonitor; drive: Drive)!(self: ptr VolumeMonitor00; drive: ptr Drive00)",
    "mount_added!VolumeMonitor!1!(self: VolumeMonitor; mount: Mount)!(self: ptr VolumeMonitor00; mount: ptr Mount00)",
    "mount_changed!VolumeMonitor!1!(self: VolumeMonitor; mount: Mount)!(self: ptr VolumeMonitor00; mount: ptr Mount00)",
    "mount_pre_unmount!VolumeMonitor!1!(self: VolumeMonitor; mount: Mount)!(self: ptr VolumeMonitor00; mount: ptr Mount00)",
    "mount_removed!VolumeMonitor!1!(self: VolumeMonitor; mount: Mount)!(self: ptr VolumeMonitor00; mount: ptr Mount00)",
    "volume_added!VolumeMonitor!1!(self: VolumeMonitor; volume: Volume)!(self: ptr VolumeMonitor00; volume: ptr Volume00)",
    "volume_changed!VolumeMonitor!1!(self: VolumeMonitor; volume: Volume)!(self: ptr VolumeMonitor00; volume: ptr Volume00)",
    "volume_removed!VolumeMonitor!1!(self: VolumeMonitor; volume: Volume)!(self: ptr VolumeMonitor00; volume: ptr Volume00)",
    "network_changed!NetworkMonitor!1!(self: NetworkMonitor; networkAvailable: bool)!(self: ptr NetworkMonitor00; networkAvailable: gboolean)",
    "change_event!Settings!2!(self: Settings; keys: seq[uint32]): bool!(self: ptr Settings00; keys: uint32Array; nKeys: int32): gboolean",
    "changed!Settings!1!(self: Settings; key: cstring)!(self: ptr Settings00; key: cstring)",
    "writable_change_event!Settings!1!(self: Settings; key: int): bool!(self: ptr Settings00; key: uint32): gboolean",
    "writable_changed!Settings!1!(self: Settings; key: cstring)!(self: ptr Settings00; key: cstring)",
    "event!SocketClient!3!(self: SocketClient; event: SocketClientEvent; connectable: SocketConnectable | SocketAddress | UnixSocketAddress | NetworkService | NativeSocketAddress | InetSocketAddress | NetworkAddress | ProxyAddress; connection: IOStream = nil)!(self: ptr SocketClient00; event: SocketClientEvent; connectable: ptr SocketConnectable00; connection: ptr IOStream00)",
    "event!SocketListener!2!(self: SocketListener; event: SocketListenerEvent; socket: Socket)!(self: ptr SocketListener00; event: SocketListenerEvent; socket: ptr Socket00)",
    "incoming!SocketService!2!(self: SocketService; connection: SocketConnection; sourceObject: gobject.Object = nil): bool!(self: ptr SocketService00; connection: ptr SocketConnection00; sourceObject: ptr gobject.Object00): gboolean",
    "run!ThreadedSocketService!2!(self: ThreadedSocketService; connection: SocketConnection; sourceObject: gobject.Object = nil): bool!(self: ptr ThreadedSocketService00; connection: ptr SocketConnection00; sourceObject: ptr gobject.Object00): gboolean",
    "area_updated!PixbufLoader!4!(self: PixbufLoader; x: int; y: int; width: int; height: int)!(self: ptr PixbufLoader00; x: int32; y: int32; width: int32; height: int32)",
    "size_prepared!PixbufLoader!2!(self: PixbufLoader; width: int; height: int)!(self: ptr PixbufLoader00; width: int32; height: int32)",
    "bracket_matched!Buffer!2!(self: Buffer; iter: gtk4.TextIter; state: BracketMatchType)!(self: ptr Buffer00; iter: gtk4.TextIter; state: BracketMatchType)",
    "highlight_updated!Buffer!2!(self: Buffer; start: gtk4.TextIter; `end`: gtk4.TextIter)!(self: ptr Buffer00; start: gtk4.TextIter; `end`: gtk4.TextIter)",
    "source_mark_updated!Buffer!1!(self: Buffer; mark: gtk4.TextMark)!(self: ptr Buffer00; mark: ptr gtk4.TextMark00)",
    "move_cursor!Completion!2!(self: Completion; step: gtk4.ScrollStep; num: int)!(self: ptr Completion00; step: gtk4.ScrollStep; num: int32)",
    "move_page!Completion!2!(self: Completion; step: gtk4.ScrollStep; num: int)!(self: ptr Completion00; step: gtk4.ScrollStep; num: int32)",
    "populate_context!Completion!1!(self: Completion; context: CompletionContext)!(self: ptr Completion00; context: ptr CompletionContext00)",
    "change_case!View!1!(self: View; caseType: ChangeCaseType)!(self: ptr View00; caseType: ChangeCaseType)",
    "change_number!View!1!(self: View; count: int)!(self: ptr View00; count: int32)",
    "line_mark_activated!View!2!(self: View; iter: gtk4.TextIter; event: gdk4.Event)!(self: ptr View00; iter: gtk4.TextIter; event: ptr gdk4.Event00)",
    "move_lines!View!1!(self: View; down: bool)!(self: ptr View00; down: gboolean)",
    "move_to_matching_bracket!View!1!(self: View; extendSelection: bool)!(self: ptr View00; extendSelection: gboolean)",
    "move_words!View!1!(self: View; count: int)!(self: ptr View00; count: int32)",
    "smart_home_end!View!2!(self: View; iter: gtk4.TextIter; count: int)!(self: ptr View00; iter: gtk4.TextIter; count: int32)",
    "activate!GutterRenderer!3!(self: GutterRenderer; iter: gtk4.TextIter; area: gdk4.Rectangle; event: gdk4.Event)!(self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; event: ptr gdk4.Event00)",
    "query_activatable!GutterRenderer!3!(self: GutterRenderer; iter: gtk4.TextIter; area: gdk4.Rectangle; event: gdk4.Event): bool!(self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; event: ptr gdk4.Event00): gboolean",
    "query_data!GutterRenderer!3!(self: GutterRenderer; start: gtk4.TextIter; `end`: gtk4.TextIter; state: GutterRendererState)!(self: ptr GutterRenderer00; start: gtk4.TextIter; `end`: gtk4.TextIter; state: GutterRendererState)",
    "query_tooltip!GutterRenderer!5!(self: GutterRenderer; iter: gtk4.TextIter; area: gdk4.Rectangle; x: int; y: int; tooltip: gtk4.Tooltip): bool!(self: ptr GutterRenderer00; iter: gtk4.TextIter; area: gdk4.Rectangle; x: int32; y: int32; tooltip: ptr gtk4.Tooltip00): gboolean",
    "query_tooltip_markup!MarkAttributes!1!(self: MarkAttributes; mark: Mark): string!(self: ptr MarkAttributes00; mark: ptr Mark00): cstring",
    "query_tooltip_text!MarkAttributes!1!(self: MarkAttributes; mark: Mark): string!(self: ptr MarkAttributes00; mark: ptr Mark00): cstring",
    "active_descendant_changed!Object!1!(self: Object; arg1: Object)!(self: ptr Object00; arg1: ptr ptr Object00)",
    "children_changed!Object!2!(self: Object; arg1: int; arg2: Object)!(self: ptr Object00; arg1: uint32; arg2: ptr ptr Object00)",
    "focus_event!Object!1!(self: Object; arg1: bool)!(self: ptr Object00; arg1: gboolean)",
    "property_change!Object!1!(self: Object; arg1: PropertyValues)!(self: ptr Object00; arg1: ptr ptr PropertyValues00)",
    "state_change!Object!2!(self: Object; arg1: cstring; arg2: bool)!(self: ptr Object00; arg1: cstring; arg2: gboolean)",
    "bounds_changed!Component!1!(self: Component | NoOpObject | Plug | Socket; arg1: Rectangle)!(self: ptr Component00; arg1: Rectangle)",
    "page_changed!Document!1!(self: Document | NoOpObject; pageNumber: int)!(self: ptr Document00; pageNumber: int32)",
    "link_selected!Hypertext!1!(self: Hypertext | NoOpObject; arg1: int)!(self: ptr Hypertext00; arg1: int32)",
    "column_deleted!Table!2!(self: Table | NoOpObject; arg1: int; arg2: int)!(self: ptr Table00; arg1: int32; arg2: int32)",
    "column_inserted!Table!2!(self: Table | NoOpObject; arg1: int; arg2: int)!(self: ptr Table00; arg1: int32; arg2: int32)",
    "row_deleted!Table!2!(self: Table | NoOpObject; arg1: int; arg2: int)!(self: ptr Table00; arg1: int32; arg2: int32)",
    "row_inserted!Table!2!(self: Table | NoOpObject; arg1: int; arg2: int)!(self: ptr Table00; arg1: int32; arg2: int32)",
    "text_caret_moved!Text!1!(self: Text | NoOpObject; arg1: int)!(self: ptr Text00; arg1: int32)",
    "text_changed!Text!2!(self: Text | NoOpObject; arg1: int; arg2: int)!(self: ptr Text00; arg1: int32; arg2: int32)",
    "text_insert!Text!3!(self: Text | NoOpObject; arg1: int; arg2: int; arg3: cstring)!(self: ptr Text00; arg1: int32; arg2: int32; arg3: cstring)",
    "text_remove!Text!3!(self: Text | NoOpObject; arg1: int; arg2: int; arg3: cstring)!(self: ptr Text00; arg1: int32; arg2: int32; arg3: cstring)",
    "value_changed!Value!2!(self: Value | NoOpObject; value: cdouble; text: cstring)!(self: ptr Value00; value: cdouble; text: cstring)",
    "deep_notify!Object!2!(self: Object; propObject: Object; prop: gobject.ParamSpec)!(self: ptr Object00; propObject: ptr Object00; prop: ptr gobject.ParamSpec00)",
    "linked!Pad!1!(self: Pad; peer: Pad)!(self: ptr Pad00; peer: ptr Pad00)",
    "unlinked!Pad!1!(self: Pad; peer: Pad)!(self: ptr Pad00; peer: ptr Pad00)",
    "pad_added!Element!1!(self: Element; newPad: Pad)!(self: ptr Element00; newPad: ptr Pad00)",
    "pad_removed!Element!1!(self: Element; oldPad: Pad)!(self: ptr Element00; oldPad: ptr Pad00)",
    "deep_element_added!Bin!2!(self: Bin; subBin: Bin; element: Element)!(self: ptr Bin00; subBin: ptr Bin00; element: ptr Element00)",
    "deep_element_removed!Bin!2!(self: Bin; subBin: Bin; element: Element)!(self: ptr Bin00; subBin: ptr Bin00; element: ptr Element00)",
    "do_latency!Bin!0!(self: Bin): bool!(self: ptr Bin00): gboolean",
    "element_added!Bin!1!(self: Bin; element: Element)!(self: ptr Bin00; element: ptr Element00)",
    "element_removed!Bin!1!(self: Bin; element: Element)!(self: ptr Bin00; element: ptr Element00)",
    "pad_created!PadTemplate!1!(self: PadTemplate; pad: Pad)!(self: ptr PadTemplate00; pad: ptr Pad00)",
    "stream_notify!StreamCollection!2!(self: StreamCollection; `object`: Stream; p0: gobject.ParamSpec)!(self: ptr StreamCollection00; `object`: ptr Stream00; p0: ptr gobject.ParamSpec00)",
    "synced!Clock!1!(self: Clock; synced: bool)!(self: ptr Clock00; synced: gboolean)",
    "child_added!ChildProxy!2!(self: ChildProxy | Pipeline | Bin; `object`: gobject.Object; name: cstring)!(self: ptr ChildProxy00; `object`: ptr gobject.Object00; name: cstring)",
    "child_removed!ChildProxy!2!(self: ChildProxy | Pipeline | Bin; `object`: gobject.Object; name: cstring)!(self: ptr ChildProxy00; `object`: ptr gobject.Object00; name: cstring)",
    "provider_hidden!DeviceProvider!1!(self: DeviceProvider; `object`: cstring)!(self: ptr DeviceProvider00; `object`: cstring)",
    "provider_unhidden!DeviceProvider!1!(self: DeviceProvider; `object`: cstring)!(self: ptr DeviceProvider00; `object`: cstring)",
    "message!Bus!1!(self: Bus; message: Message)!(self: ptr Bus00; message: ptr Message00)",
    "sync_message!Bus!1!(self: Bus; message: Message)!(self: ptr Bus00; message: ptr Message00)",
    "feature_added!Registry!1!(self: Registry; feature: PluginFeature)!(self: ptr Registry00; feature: ptr PluginFeature00)",
    "plugin_added!Registry!1!(self: Registry; plugin: Plugin)!(self: ptr Registry00; plugin: ptr Plugin00)",
    "samples_selected!Aggregator!5!(self: Aggregator; segment: gst.Segment; pts: uint64; dts: uint64; duration: uint64; info: gst.Structure = nil)!(self: ptr Aggregator00; segment: ptr gst.Segment00; pts: uint64; dts: uint64; duration: uint64; info: ptr gst.Structure00)",
    "buffer_consumed!AggregatorPad!1!(self: AggregatorPad; `object`: gst.Buffer)!(self: ptr AggregatorPad00; `object`: ptr gst.Buffer00)",
    "new_preroll!AppSink!0!(self: AppSink): gst.FlowReturn!(self: ptr AppSink00): gst.FlowReturn",
    "new_sample!AppSink!0!(self: AppSink): gst.FlowReturn!(self: ptr AppSink00): gst.FlowReturn",
    "pull_preroll!AppSink!0!(self: AppSink): gst.Sample!(self: ptr AppSink00): gst.Sample00",
    "pull_sample!AppSink!0!(self: AppSink): gst.Sample!(self: ptr AppSink00): gst.Sample00",
    "try_pull_preroll!AppSink!1!(self: AppSink; timeout: uint64): gst.Sample!(self: ptr AppSink00; timeout: uint64): gst.Sample00",
    "try_pull_sample!AppSink!1!(self: AppSink; timeout: uint64): gst.Sample!(self: ptr AppSink00; timeout: uint64): gst.Sample00",
    "end_of_stream!AppSrc!0!(self: AppSrc): gst.FlowReturn!(self: ptr AppSrc00): gst.FlowReturn",
    "need_data!AppSrc!1!(self: AppSrc; length: int)!(self: ptr AppSrc00; length: uint32)",
    "push_buffer!AppSrc!1!(self: AppSrc; buffer: gst.Buffer): gst.FlowReturn!(self: ptr AppSrc00; buffer: ptr gst.Buffer00): gst.FlowReturn",
    "push_buffer_list!AppSrc!1!(self: AppSrc; bufferList: gst.BufferList): gst.FlowReturn!(self: ptr AppSrc00; bufferList: ptr gst.BufferList00): gst.FlowReturn",
    "push_sample!AppSrc!1!(self: AppSrc; sample: gst.Sample): gst.FlowReturn!(self: ptr AppSrc00; sample: ptr gst.Sample00): gst.FlowReturn",
    "seek_data!AppSrc!1!(self: AppSrc; offset: uint64): bool!(self: ptr AppSrc00; offset: uint64): gboolean",
    "value_added!TimedValueControlSource!1!(self: TimedValueControlSource; timedValue: ControlPoint)!(self: ptr TimedValueControlSource00; timedValue: ptr ControlPoint00)",
    "value_changed!TimedValueControlSource!1!(self: TimedValueControlSource; timedValue: ControlPoint)!(self: ptr TimedValueControlSource00; timedValue: ptr ControlPoint00)",
    "value_removed!TimedValueControlSource!1!(self: TimedValueControlSource; timedValue: ControlPoint)!(self: ptr TimedValueControlSource00; timedValue: ptr ControlPoint00)",
    "create_context!GLDisplay!1!(self: GLDisplay; context: GLContext): GLContext!(self: ptr GLDisplay00; context: ptr GLContext00): GLContext00",
    "key_event!GLWindow!2!(self: GLWindow; id: cstring; key: cstring)!(self: ptr GLWindow00; id: cstring; key: cstring)",
    "mouse_event!GLWindow!4!(self: GLWindow; id: cstring; button: int; x: cdouble; y: cdouble)!(self: ptr GLWindow00; id: cstring; button: int32; x: cdouble; y: cdouble)",
    "scroll_event!GLWindow!4!(self: GLWindow; x: cdouble; y: cdouble; deltaX: cdouble; deltaY: cdouble)!(self: ptr GLWindow00; x: cdouble; y: cdouble; deltaX: cdouble; deltaY: cdouble)",
    "send!RTSPExtension!2!(self: RTSPExtension; `object`: pointer; p0: pointer): RTSPResult!(self: ptr RTSPExtension00; `object`: pointer; p0: pointer): RTSPResult",
    "value_changed!ColorBalanceChannel!1!(self: ColorBalanceChannel; value: int)!(self: ptr ColorBalanceChannel00; value: int32)",
    "value_changed!ColorBalance!2!(self: ColorBalance; channel: ColorBalanceChannel; value: int)!(self: ptr ColorBalance00; channel: ptr ColorBalanceChannel00; value: int32)",
    "new_preroll!AppSink!0!(self: AppSink): gst.FlowReturn!(self: ptr AppSink00): gst.FlowReturn",
    "new_sample!AppSink!0!(self: AppSink): gst.FlowReturn!(self: ptr AppSink00): gst.FlowReturn",
    "pull_preroll!AppSink!0!(self: AppSink): gst.Sample!(self: ptr AppSink00): gst.Sample00",
    "pull_sample!AppSink!0!(self: AppSink): gst.Sample!(self: ptr AppSink00): gst.Sample00",
    "try_pull_preroll!AppSink!1!(self: AppSink; timeout: uint64): gst.Sample!(self: ptr AppSink00; timeout: uint64): gst.Sample00",
    "try_pull_sample!AppSink!1!(self: AppSink; timeout: uint64): gst.Sample!(self: ptr AppSink00; timeout: uint64): gst.Sample00",
    "end_of_stream!AppSrc!0!(self: AppSrc): gst.FlowReturn!(self: ptr AppSrc00): gst.FlowReturn",
    "need_data!AppSrc!1!(self: AppSrc; length: int)!(self: ptr AppSrc00; length: uint32)",
    "push_buffer!AppSrc!1!(self: AppSrc; buffer: gst.Buffer): gst.FlowReturn!(self: ptr AppSrc00; buffer: ptr gst.Buffer00): gst.FlowReturn",
    "push_buffer_list!AppSrc!1!(self: AppSrc; bufferList: gst.BufferList): gst.FlowReturn!(self: ptr AppSrc00; bufferList: ptr gst.BufferList00): gst.FlowReturn",
    "push_sample!AppSrc!1!(self: AppSrc; sample: gst.Sample): gst.FlowReturn!(self: ptr AppSrc00; sample: ptr gst.Sample00): gst.FlowReturn",
    "seek_data!AppSrc!1!(self: AppSrc; offset: uint64): bool!(self: ptr AppSrc00; offset: uint64): gboolean",
    "discovered!Discoverer!2!(self: Discoverer; info: DiscovererInfo; error: ptr glib.Error)!(self: ptr Discoverer00; info: ptr DiscovererInfo00; error: ptr glib.Error)",
    "source_setup!Discoverer!1!(self: Discoverer; source: gst.Element)!(self: ptr Discoverer00; source: ptr gst.Element00)",
  ]
