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
# libgstrtp-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gst, glib, gmodule
const Lib = "libgstrtp-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  RTCPBuffer* {.pure, byRef.} = object
    buffer*: ptr gst.Buffer00
    map*: gst.MapInfo

proc gst_rtcp_buffer_get_packet_count(self: RTCPBuffer): uint32 {.
    importc, libprag.}

proc getPacketCount*(self: RTCPBuffer): int =
  int(gst_rtcp_buffer_get_packet_count(self))

proc packetCount*(self: RTCPBuffer): int =
  int(gst_rtcp_buffer_get_packet_count(self))

proc gst_rtcp_buffer_unmap(self: RTCPBuffer): gboolean {.
    importc, libprag.}

proc unmap*(self: RTCPBuffer): bool =
  toBool(gst_rtcp_buffer_unmap(self))

proc gst_rtcp_buffer_map(buffer: ptr gst.Buffer00; flags: gst.MapFlags; rtcp: RTCPBuffer): gboolean {.
    importc, libprag.}

proc map*(buffer: gst.Buffer; flags: gst.MapFlags; rtcp: RTCPBuffer): bool =
  toBool(gst_rtcp_buffer_map(cast[ptr gst.Buffer00](buffer.impl), flags, rtcp))

proc gst_rtcp_buffer_new(mtu: uint32): ptr gst.Buffer00 {.
    importc, libprag.}

proc newRTCPBuffer*(mtu: int): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtcp_buffer_new(uint32(mtu))

proc gst_rtcp_buffer_new_copy_data(data: ptr uint8; len: uint32): ptr gst.Buffer00 {.
    importc, libprag.}

proc newRTCPBufferCopyData*(data: seq[uint8] | string): gst.Buffer =
  let len = int(data.len)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtcp_buffer_new_copy_data(cast[ptr uint8](unsafeaddr(data[0])), uint32(len))

proc gst_rtcp_buffer_new_take_data(data: ptr uint8; len: uint32): ptr gst.Buffer00 {.
    importc, libprag.}

proc newRTCPBufferTakeData*(data: seq[uint8] | string): gst.Buffer =
  let len = int(data.len)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtcp_buffer_new_take_data(cast[ptr uint8](unsafeaddr(data[0])), uint32(len))

proc gst_rtcp_buffer_validate(buffer: ptr gst.Buffer00): gboolean {.
    importc, libprag.}

proc validate*(buffer: gst.Buffer): bool =
  toBool(gst_rtcp_buffer_validate(cast[ptr gst.Buffer00](buffer.impl)))

proc gst_rtcp_buffer_validate_data(data: ptr uint8; len: uint32): gboolean {.
    importc, libprag.}

proc validateData*(data: seq[uint8] | string): bool =
  let len = int(data.len)
  toBool(gst_rtcp_buffer_validate_data(cast[ptr uint8](unsafeaddr(data[0])), uint32(len)))

proc gst_rtcp_buffer_validate_data_reduced(data: ptr uint8; len: uint32): gboolean {.
    importc, libprag.}

proc validateDataReduced*(data: seq[uint8] | string): bool =
  let len = int(data.len)
  toBool(gst_rtcp_buffer_validate_data_reduced(cast[ptr uint8](unsafeaddr(data[0])), uint32(len)))

proc gst_rtcp_buffer_validate_reduced(buffer: ptr gst.Buffer00): gboolean {.
    importc, libprag.}

proc validateReduced*(buffer: gst.Buffer): bool =
  toBool(gst_rtcp_buffer_validate_reduced(cast[ptr gst.Buffer00](buffer.impl)))

type
  RTCPType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    sr = 200
    rr = 201
    sdes = 202
    bye = 203
    app = 204
    rtpfb = 205
    psfb = 206
    xr = 207

type
  RTCPPacket* {.pure, byRef.} = object
    rtcp*: ptr RTCPBuffer
    offset*: uint32
    padding*: gboolean
    count*: uint8
    `type`*: RTCPType
    length*: uint16
    itemOffset*: uint32
    itemCount*: uint32
    entryOffset*: uint32

proc gst_rtcp_packet_add_profile_specific_ext(self: RTCPPacket; data: ptr uint8;
    len: uint32): gboolean {.
    importc, libprag.}

proc addProfileSpecificExt*(self: RTCPPacket; data: seq[uint8] | string): bool =
  let len = int(data.len)
  toBool(gst_rtcp_packet_add_profile_specific_ext(self, cast[ptr uint8](unsafeaddr(data[0])), uint32(len)))

proc gst_rtcp_packet_add_rb(self: RTCPPacket; ssrc: uint32; fractionlost: uint8;
    packetslost: int32; exthighestseq: uint32; jitter: uint32; lsr: uint32;
    dlsr: uint32): gboolean {.
    importc, libprag.}

proc addRb*(self: RTCPPacket; ssrc: int; fractionlost: uint8;
    packetslost: int; exthighestseq: int; jitter: int; lsr: int; dlsr: int): bool =
  toBool(gst_rtcp_packet_add_rb(self, uint32(ssrc), fractionlost, int32(packetslost), uint32(exthighestseq), uint32(jitter), uint32(lsr), uint32(dlsr)))

proc gst_rtcp_packet_app_get_data(self: RTCPPacket): ptr uint8 {.
    importc, libprag.}

proc appGetData*(self: RTCPPacket): ptr uint8 =
  gst_rtcp_packet_app_get_data(self)

proc gst_rtcp_packet_app_get_data_length(self: RTCPPacket): uint16 {.
    importc, libprag.}

proc appGetDataLength*(self: RTCPPacket): uint16 =
  gst_rtcp_packet_app_get_data_length(self)

proc gst_rtcp_packet_app_get_name(self: RTCPPacket): cstring {.
    importc, libprag.}

proc appGetName*(self: RTCPPacket): string =
  result = $gst_rtcp_packet_app_get_name(self)

proc gst_rtcp_packet_app_get_ssrc(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc appGetSsrc*(self: RTCPPacket): int =
  int(gst_rtcp_packet_app_get_ssrc(self))

proc gst_rtcp_packet_app_get_subtype(self: RTCPPacket): uint8 {.
    importc, libprag.}

proc appGetSubtype*(self: RTCPPacket): uint8 =
  gst_rtcp_packet_app_get_subtype(self)

proc gst_rtcp_packet_app_set_data_length(self: RTCPPacket; wordlen: uint16): gboolean {.
    importc, libprag.}

proc appSetDataLength*(self: RTCPPacket; wordlen: uint16): bool =
  toBool(gst_rtcp_packet_app_set_data_length(self, wordlen))

proc gst_rtcp_packet_app_set_name(self: RTCPPacket; name: cstring) {.
    importc, libprag.}

proc appSetName*(self: RTCPPacket; name: cstring) =
  gst_rtcp_packet_app_set_name(self, name)

proc gst_rtcp_packet_app_set_ssrc(self: RTCPPacket; ssrc: uint32) {.
    importc, libprag.}

proc appSetSsrc*(self: RTCPPacket; ssrc: int) =
  gst_rtcp_packet_app_set_ssrc(self, uint32(ssrc))

proc gst_rtcp_packet_app_set_subtype(self: RTCPPacket; subtype: uint8) {.
    importc, libprag.}

proc appSetSubtype*(self: RTCPPacket; subtype: uint8) =
  gst_rtcp_packet_app_set_subtype(self, subtype)

proc gst_rtcp_packet_bye_add_ssrc(self: RTCPPacket; ssrc: uint32): gboolean {.
    importc, libprag.}

proc byeAddSsrc*(self: RTCPPacket; ssrc: int): bool =
  toBool(gst_rtcp_packet_bye_add_ssrc(self, uint32(ssrc)))

proc gst_rtcp_packet_bye_add_ssrcs(self: RTCPPacket; ssrc: ptr uint32; len: uint32): gboolean {.
    importc, libprag.}

proc byeAddSsrcs*(self: RTCPPacket; ssrc: seq[uint32]): bool =
  let len = int(ssrc.len)
  toBool(gst_rtcp_packet_bye_add_ssrcs(self, cast[ptr uint32](unsafeaddr(ssrc[0])), uint32(len)))

proc gst_rtcp_packet_bye_get_nth_ssrc(self: RTCPPacket; nth: uint32): uint32 {.
    importc, libprag.}

proc byeGetNthSsrc*(self: RTCPPacket; nth: int): int =
  int(gst_rtcp_packet_bye_get_nth_ssrc(self, uint32(nth)))

proc gst_rtcp_packet_bye_get_reason(self: RTCPPacket): cstring {.
    importc, libprag.}

proc byeGetReason*(self: RTCPPacket): string =
  let resul0 = gst_rtcp_packet_bye_get_reason(self)
  result = $resul0
  cogfree(resul0)

proc gst_rtcp_packet_bye_get_reason_len(self: RTCPPacket): uint8 {.
    importc, libprag.}

proc byeGetReasonLen*(self: RTCPPacket): uint8 =
  gst_rtcp_packet_bye_get_reason_len(self)

proc gst_rtcp_packet_bye_get_ssrc_count(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc byeGetSsrcCount*(self: RTCPPacket): int =
  int(gst_rtcp_packet_bye_get_ssrc_count(self))

proc gst_rtcp_packet_bye_set_reason(self: RTCPPacket; reason: cstring): gboolean {.
    importc, libprag.}

proc byeSetReason*(self: RTCPPacket; reason: cstring): bool =
  toBool(gst_rtcp_packet_bye_set_reason(self, reason))

proc gst_rtcp_packet_copy_profile_specific_ext(self: RTCPPacket; data: var ptr uint8;
    len: var uint32): gboolean {.
    importc, libprag.}

proc copyProfileSpecificExt*(self: RTCPPacket; data: var (seq[uint8] | string);
    len: var int): bool =
  var data_00: ptr uint8
  var len_00: uint32
  result = toBool(gst_rtcp_packet_copy_profile_specific_ext(self, data_00, len_00))
  data.setLen(len)
  copyMem(unsafeaddr data[0], data_00, len.int * sizeof(data[0]))
  cogfree(data_00)
  if len.addr != nil:
    len = int(len_00)

proc gst_rtcp_packet_fb_get_fci(self: RTCPPacket): ptr uint8 {.
    importc, libprag.}

proc fbGetFci*(self: RTCPPacket): ptr uint8 =
  gst_rtcp_packet_fb_get_fci(self)

proc gst_rtcp_packet_fb_get_fci_length(self: RTCPPacket): uint16 {.
    importc, libprag.}

proc fbGetFciLength*(self: RTCPPacket): uint16 =
  gst_rtcp_packet_fb_get_fci_length(self)

proc gst_rtcp_packet_fb_get_media_ssrc(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc fbGetMediaSsrc*(self: RTCPPacket): int =
  int(gst_rtcp_packet_fb_get_media_ssrc(self))

proc gst_rtcp_packet_fb_get_sender_ssrc(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc fbGetSenderSsrc*(self: RTCPPacket): int =
  int(gst_rtcp_packet_fb_get_sender_ssrc(self))

proc gst_rtcp_packet_fb_set_fci_length(self: RTCPPacket; wordlen: uint16): gboolean {.
    importc, libprag.}

proc fbSetFciLength*(self: RTCPPacket; wordlen: uint16): bool =
  toBool(gst_rtcp_packet_fb_set_fci_length(self, wordlen))

proc gst_rtcp_packet_fb_set_media_ssrc(self: RTCPPacket; ssrc: uint32) {.
    importc, libprag.}

proc fbSetMediaSsrc*(self: RTCPPacket; ssrc: int) =
  gst_rtcp_packet_fb_set_media_ssrc(self, uint32(ssrc))

proc gst_rtcp_packet_fb_set_sender_ssrc(self: RTCPPacket; ssrc: uint32) {.
    importc, libprag.}

proc fbSetSenderSsrc*(self: RTCPPacket; ssrc: int) =
  gst_rtcp_packet_fb_set_sender_ssrc(self, uint32(ssrc))

proc gst_rtcp_packet_get_count(self: RTCPPacket): uint8 {.
    importc, libprag.}

proc getCount*(self: RTCPPacket): uint8 =
  gst_rtcp_packet_get_count(self)

proc count*(self: RTCPPacket): uint8 =
  gst_rtcp_packet_get_count(self)

proc gst_rtcp_packet_get_length(self: RTCPPacket): uint16 {.
    importc, libprag.}

proc getLength*(self: RTCPPacket): uint16 =
  gst_rtcp_packet_get_length(self)

proc length*(self: RTCPPacket): uint16 =
  gst_rtcp_packet_get_length(self)

proc gst_rtcp_packet_get_padding(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc getPadding*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_get_padding(self))

proc padding*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_get_padding(self))

proc gst_rtcp_packet_get_profile_specific_ext(self: RTCPPacket; data: var ptr uint8;
    len: var uint32): gboolean {.
    importc, libprag.}

proc getProfileSpecificExt*(self: RTCPPacket; data: var (seq[uint8] | string);
    len: var int): bool =
  var data_00: ptr uint8
  var len_00: uint32
  result = toBool(gst_rtcp_packet_get_profile_specific_ext(self, data_00, len_00))
  data.setLen(len)
  copyMem(unsafeaddr data[0], data_00, len.int * sizeof(data[0]))
  cogfree(data_00)
  if len.addr != nil:
    len = int(len_00)

proc gst_rtcp_packet_get_profile_specific_ext_length(self: RTCPPacket): uint16 {.
    importc, libprag.}

proc getProfileSpecificExtLength*(self: RTCPPacket): uint16 =
  gst_rtcp_packet_get_profile_specific_ext_length(self)

proc profileSpecificExtLength*(self: RTCPPacket): uint16 =
  gst_rtcp_packet_get_profile_specific_ext_length(self)

proc gst_rtcp_packet_get_rb(self: RTCPPacket; nth: uint32; ssrc: var uint32;
    fractionlost: var uint8; packetslost: var int32; exthighestseq: var uint32;
    jitter: var uint32; lsr: var uint32; dlsr: var uint32) {.
    importc, libprag.}

proc getRb*(self: RTCPPacket; nth: int; ssrc: var int; fractionlost: var uint8;
    packetslost: var int; exthighestseq: var int; jitter: var int; lsr: var int;
    dlsr: var int) =
  var packetslost_00: int32
  var lsr_00: uint32
  var jitter_00: uint32
  var exthighestseq_00: uint32
  var ssrc_00: uint32
  var dlsr_00: uint32
  gst_rtcp_packet_get_rb(self, uint32(nth), ssrc_00, fractionlost, packetslost_00, exthighestseq_00, jitter_00, lsr_00, dlsr_00)
  if packetslost.addr != nil:
    packetslost = int(packetslost_00)
  if lsr.addr != nil:
    lsr = int(lsr_00)
  if jitter.addr != nil:
    jitter = int(jitter_00)
  if exthighestseq.addr != nil:
    exthighestseq = int(exthighestseq_00)
  if ssrc.addr != nil:
    ssrc = int(ssrc_00)
  if dlsr.addr != nil:
    dlsr = int(dlsr_00)

proc gst_rtcp_packet_get_rb_count(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc getRbCount*(self: RTCPPacket): int =
  int(gst_rtcp_packet_get_rb_count(self))

proc rbCount*(self: RTCPPacket): int =
  int(gst_rtcp_packet_get_rb_count(self))

proc gst_rtcp_packet_get_type(self: RTCPPacket): RTCPType {.
    importc, libprag.}

proc getType*(self: RTCPPacket): RTCPType =
  gst_rtcp_packet_get_type(self)

proc gst_rtcp_packet_move_to_next(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc moveToNext*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_move_to_next(self))

proc gst_rtcp_packet_remove(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc remove*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_remove(self))

proc gst_rtcp_packet_rr_get_ssrc(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc rrGetSsrc*(self: RTCPPacket): int =
  int(gst_rtcp_packet_rr_get_ssrc(self))

proc gst_rtcp_packet_rr_set_ssrc(self: RTCPPacket; ssrc: uint32) {.
    importc, libprag.}

proc rrSetSsrc*(self: RTCPPacket; ssrc: int) =
  gst_rtcp_packet_rr_set_ssrc(self, uint32(ssrc))

proc gst_rtcp_packet_sdes_add_item(self: RTCPPacket; ssrc: uint32): gboolean {.
    importc, libprag.}

proc sdesAddItem*(self: RTCPPacket; ssrc: int): bool =
  toBool(gst_rtcp_packet_sdes_add_item(self, uint32(ssrc)))

proc gst_rtcp_packet_sdes_first_entry(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc sdesFirstEntry*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_sdes_first_entry(self))

proc gst_rtcp_packet_sdes_first_item(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc sdesFirstItem*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_sdes_first_item(self))

proc gst_rtcp_packet_sdes_get_item_count(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc sdesGetItemCount*(self: RTCPPacket): int =
  int(gst_rtcp_packet_sdes_get_item_count(self))

proc gst_rtcp_packet_sdes_get_ssrc(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc sdesGetSsrc*(self: RTCPPacket): int =
  int(gst_rtcp_packet_sdes_get_ssrc(self))

proc gst_rtcp_packet_sdes_next_entry(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc sdesNextEntry*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_sdes_next_entry(self))

proc gst_rtcp_packet_sdes_next_item(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc sdesNextItem*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_sdes_next_item(self))

proc gst_rtcp_packet_set_rb(self: RTCPPacket; nth: uint32; ssrc: uint32;
    fractionlost: uint8; packetslost: int32; exthighestseq: uint32; jitter: uint32;
    lsr: uint32; dlsr: uint32) {.
    importc, libprag.}

proc setRb*(self: RTCPPacket; nth: int; ssrc: int; fractionlost: uint8;
    packetslost: int; exthighestseq: int; jitter: int; lsr: int; dlsr: int) =
  gst_rtcp_packet_set_rb(self, uint32(nth), uint32(ssrc), fractionlost, int32(packetslost), uint32(exthighestseq), uint32(jitter), uint32(lsr), uint32(dlsr))

proc gst_rtcp_packet_sr_get_sender_info(self: RTCPPacket; ssrc: var uint32;
    ntptime: var uint64; rtptime: var uint32; packetCount: var uint32; octetCount: var uint32) {.
    importc, libprag.}

proc srGetSenderInfo*(self: RTCPPacket; ssrc: var int;
    ntptime: var uint64; rtptime: var int; packetCount: var int; octetCount: var int) =
  var packetCount_00: uint32
  var rtptime_00: uint32
  var octetCount_00: uint32
  var ssrc_00: uint32
  gst_rtcp_packet_sr_get_sender_info(self, ssrc_00, ntptime, rtptime_00, packetCount_00, octetCount_00)
  if packetCount.addr != nil:
    packetCount = int(packetCount_00)
  if rtptime.addr != nil:
    rtptime = int(rtptime_00)
  if octetCount.addr != nil:
    octetCount = int(octetCount_00)
  if ssrc.addr != nil:
    ssrc = int(ssrc_00)

proc gst_rtcp_packet_sr_set_sender_info(self: RTCPPacket; ssrc: uint32; ntptime: uint64;
    rtptime: uint32; packetCount: uint32; octetCount: uint32) {.
    importc, libprag.}

proc srSetSenderInfo*(self: RTCPPacket; ssrc: int; ntptime: uint64;
    rtptime: int; packetCount: int; octetCount: int) =
  gst_rtcp_packet_sr_set_sender_info(self, uint32(ssrc), ntptime, uint32(rtptime), uint32(packetCount), uint32(octetCount))

proc gst_rtcp_packet_xr_first_rb(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc xrFirstRb*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_xr_first_rb(self))

proc gst_rtcp_packet_xr_get_block_length(self: RTCPPacket): uint16 {.
    importc, libprag.}

proc xrGetBlockLength*(self: RTCPPacket): uint16 =
  gst_rtcp_packet_xr_get_block_length(self)

proc gst_rtcp_packet_xr_get_dlrr_block(self: RTCPPacket; nth: uint32; ssrc: ptr uint32;
    lastRr: ptr uint32; delay: ptr uint32): gboolean {.
    importc, libprag.}

proc xrGetDlrrBlock*(self: RTCPPacket; nth: int; ssrc: ptr uint32;
    lastRr: ptr uint32; delay: ptr uint32): bool =
  toBool(gst_rtcp_packet_xr_get_dlrr_block(self, uint32(nth), ssrc, lastRr, delay))

proc gst_rtcp_packet_xr_get_prt_by_seq(self: RTCPPacket; seq: uint16; receiptTime: ptr uint32): gboolean {.
    importc, libprag.}

proc xrGetPrtBySeq*(self: RTCPPacket; seq: uint16; receiptTime: ptr uint32): bool =
  toBool(gst_rtcp_packet_xr_get_prt_by_seq(self, seq, receiptTime))

proc gst_rtcp_packet_xr_get_prt_info(self: RTCPPacket; ssrc: ptr uint32;
    thinning: ptr uint8; beginSeq: ptr uint16; endSeq: ptr uint16): gboolean {.
    importc, libprag.}

proc xrGetPrtInfo*(self: RTCPPacket; ssrc: ptr uint32;
    thinning: ptr uint8; beginSeq: ptr uint16; endSeq: ptr uint16): bool =
  toBool(gst_rtcp_packet_xr_get_prt_info(self, ssrc, thinning, beginSeq, endSeq))

proc gst_rtcp_packet_xr_get_rle_info(self: RTCPPacket; ssrc: ptr uint32;
    thinning: ptr uint8; beginSeq: ptr uint16; endSeq: ptr uint16; chunkCount: ptr uint32): gboolean {.
    importc, libprag.}

proc xrGetRleInfo*(self: RTCPPacket; ssrc: ptr uint32;
    thinning: ptr uint8; beginSeq: ptr uint16; endSeq: ptr uint16; chunkCount: ptr uint32): bool =
  toBool(gst_rtcp_packet_xr_get_rle_info(self, ssrc, thinning, beginSeq, endSeq, chunkCount))

proc gst_rtcp_packet_xr_get_rle_nth_chunk(self: RTCPPacket; nth: uint32;
    chunk: ptr uint16): gboolean {.
    importc, libprag.}

proc xrGetRleNthChunk*(self: RTCPPacket; nth: int; chunk: ptr uint16): bool =
  toBool(gst_rtcp_packet_xr_get_rle_nth_chunk(self, uint32(nth), chunk))

proc gst_rtcp_packet_xr_get_rrt(self: RTCPPacket; timestamp: ptr uint64): gboolean {.
    importc, libprag.}

proc xrGetRrt*(self: RTCPPacket; timestamp: ptr uint64): bool =
  toBool(gst_rtcp_packet_xr_get_rrt(self, timestamp))

proc gst_rtcp_packet_xr_get_ssrc(self: RTCPPacket): uint32 {.
    importc, libprag.}

proc xrGetSsrc*(self: RTCPPacket): int =
  int(gst_rtcp_packet_xr_get_ssrc(self))

proc gst_rtcp_packet_xr_get_summary_info(self: RTCPPacket; ssrc: ptr uint32;
    beginSeq: ptr uint16; endSeq: ptr uint16): gboolean {.
    importc, libprag.}

proc xrGetSummaryInfo*(self: RTCPPacket; ssrc: ptr uint32;
    beginSeq: ptr uint16; endSeq: ptr uint16): bool =
  toBool(gst_rtcp_packet_xr_get_summary_info(self, ssrc, beginSeq, endSeq))

proc gst_rtcp_packet_xr_get_summary_jitter(self: RTCPPacket; minJitter: ptr uint32;
    maxJitter: ptr uint32; meanJitter: ptr uint32; devJitter: ptr uint32): gboolean {.
    importc, libprag.}

proc xrGetSummaryJitter*(self: RTCPPacket; minJitter: ptr uint32;
    maxJitter: ptr uint32; meanJitter: ptr uint32; devJitter: ptr uint32): bool =
  toBool(gst_rtcp_packet_xr_get_summary_jitter(self, minJitter, maxJitter, meanJitter, devJitter))

proc gst_rtcp_packet_xr_get_summary_pkt(self: RTCPPacket; lostPackets: ptr uint32;
    dupPackets: ptr uint32): gboolean {.
    importc, libprag.}

proc xrGetSummaryPkt*(self: RTCPPacket; lostPackets: ptr uint32;
    dupPackets: ptr uint32): bool =
  toBool(gst_rtcp_packet_xr_get_summary_pkt(self, lostPackets, dupPackets))

proc gst_rtcp_packet_xr_get_summary_ttl(self: RTCPPacket; isIpv4: ptr gboolean;
    minTtl: ptr uint8; maxTtl: ptr uint8; meanTtl: ptr uint8; devTtl: ptr uint8): gboolean {.
    importc, libprag.}

proc xrGetSummaryTtl*(self: RTCPPacket; isIpv4: ptr gboolean;
    minTtl: ptr uint8; maxTtl: ptr uint8; meanTtl: ptr uint8; devTtl: ptr uint8): bool =
  toBool(gst_rtcp_packet_xr_get_summary_ttl(self, isIpv4, minTtl, maxTtl, meanTtl, devTtl))

proc gst_rtcp_packet_xr_get_voip_burst_metrics(self: RTCPPacket; burstDensity: ptr uint8;
    gapDensity: ptr uint8; burstDuration: ptr uint16; gapDuration: ptr uint16): gboolean {.
    importc, libprag.}

proc xrGetVoipBurstMetrics*(self: RTCPPacket; burstDensity: ptr uint8;
    gapDensity: ptr uint8; burstDuration: ptr uint16; gapDuration: ptr uint16): bool =
  toBool(gst_rtcp_packet_xr_get_voip_burst_metrics(self, burstDensity, gapDensity, burstDuration, gapDuration))

proc gst_rtcp_packet_xr_get_voip_configuration_params(self: RTCPPacket; gmin: ptr uint8;
    rxConfig: ptr uint8): gboolean {.
    importc, libprag.}

proc xrGetVoipConfigurationParams*(self: RTCPPacket; gmin: ptr uint8;
    rxConfig: ptr uint8): bool =
  toBool(gst_rtcp_packet_xr_get_voip_configuration_params(self, gmin, rxConfig))

proc gst_rtcp_packet_xr_get_voip_delay_metrics(self: RTCPPacket; roundtripDelay: ptr uint16;
    endSystemDelay: ptr uint16): gboolean {.
    importc, libprag.}

proc xrGetVoipDelayMetrics*(self: RTCPPacket; roundtripDelay: ptr uint16;
    endSystemDelay: ptr uint16): bool =
  toBool(gst_rtcp_packet_xr_get_voip_delay_metrics(self, roundtripDelay, endSystemDelay))

proc gst_rtcp_packet_xr_get_voip_jitter_buffer_params(self: RTCPPacket; jbNominal: ptr uint16;
    jbMaximum: ptr uint16; jbAbsMax: ptr uint16): gboolean {.
    importc, libprag.}

proc xrGetVoipJitterBufferParams*(self: RTCPPacket; jbNominal: ptr uint16;
    jbMaximum: ptr uint16; jbAbsMax: ptr uint16): bool =
  toBool(gst_rtcp_packet_xr_get_voip_jitter_buffer_params(self, jbNominal, jbMaximum, jbAbsMax))

proc gst_rtcp_packet_xr_get_voip_metrics_ssrc(self: RTCPPacket; ssrc: ptr uint32): gboolean {.
    importc, libprag.}

proc xrGetVoipMetricsSsrc*(self: RTCPPacket; ssrc: ptr uint32): bool =
  toBool(gst_rtcp_packet_xr_get_voip_metrics_ssrc(self, ssrc))

proc gst_rtcp_packet_xr_get_voip_packet_metrics(self: RTCPPacket; lossRate: ptr uint8;
    discardRate: ptr uint8): gboolean {.
    importc, libprag.}

proc xrGetVoipPacketMetrics*(self: RTCPPacket; lossRate: ptr uint8;
    discardRate: ptr uint8): bool =
  toBool(gst_rtcp_packet_xr_get_voip_packet_metrics(self, lossRate, discardRate))

proc gst_rtcp_packet_xr_get_voip_quality_metrics(self: RTCPPacket; rFactor: ptr uint8;
    extRFactor: ptr uint8; mosLq: ptr uint8; mosCq: ptr uint8): gboolean {.
    importc, libprag.}

proc xrGetVoipQualityMetrics*(self: RTCPPacket; rFactor: ptr uint8;
    extRFactor: ptr uint8; mosLq: ptr uint8; mosCq: ptr uint8): bool =
  toBool(gst_rtcp_packet_xr_get_voip_quality_metrics(self, rFactor, extRFactor, mosLq, mosCq))

proc gst_rtcp_packet_xr_get_voip_signal_metrics(self: RTCPPacket; signalLevel: ptr uint8;
    noiseLevel: ptr uint8; rerl: ptr uint8; gmin: ptr uint8): gboolean {.
    importc, libprag.}

proc xrGetVoipSignalMetrics*(self: RTCPPacket; signalLevel: ptr uint8;
    noiseLevel: ptr uint8; rerl: ptr uint8; gmin: ptr uint8): bool =
  toBool(gst_rtcp_packet_xr_get_voip_signal_metrics(self, signalLevel, noiseLevel, rerl, gmin))

proc gst_rtcp_packet_xr_next_rb(self: RTCPPacket): gboolean {.
    importc, libprag.}

proc xrNextRb*(self: RTCPPacket): bool =
  toBool(gst_rtcp_packet_xr_next_rb(self))

proc gst_rtcp_buffer_add_packet(self: RTCPBuffer; `type`: RTCPType; packet: RTCPPacket): gboolean {.
    importc, libprag.}

proc addPacket*(self: RTCPBuffer; `type`: RTCPType; packet: RTCPPacket): bool =
  toBool(gst_rtcp_buffer_add_packet(self, `type`, packet))

proc gst_rtcp_buffer_get_first_packet(self: RTCPBuffer; packet: RTCPPacket): gboolean {.
    importc, libprag.}

proc getFirstPacket*(self: RTCPBuffer; packet: RTCPPacket): bool =
  toBool(gst_rtcp_buffer_get_first_packet(self, packet))

type
  RTCPFBType* {.size: sizeof(cint), pure.} = enum
    fbTypeInvalid = 0
    psfbTypePli = 1
    psfbTypeSli = 2
    psfbTypeRpsi = 3
    psfbTypeFir = 4
    psfbTypeTstr = 5
    psfbTypeTstn = 6
    psfbTypeVbcn = 7
    psfbTypeAfb = 15

const
  RTCPFBTypeRtpfbTypeTwcc* = RTCPFBType.psfbTypeAfb
  RTCPFBTypeRtpfbTypeTmmbr* = RTCPFBType.psfbTypeRpsi
  RTCPFBTypeRtpfbTypeNack* = RTCPFBType.psfbTypePli
  RTCPFBTypeRtpfbTypeTmmbn* = RTCPFBType.psfbTypeFir
  RTCPFBTypeRtpfbTypeRtcpSrReq* = RTCPFBType.psfbTypeTstr

proc gst_rtcp_packet_fb_get_type(self: RTCPPacket): RTCPFBType {.
    importc, libprag.}

proc fbGetType*(self: RTCPPacket): RTCPFBType =
  gst_rtcp_packet_fb_get_type(self)

proc gst_rtcp_packet_fb_set_type(self: RTCPPacket; `type`: RTCPFBType) {.
    importc, libprag.}

proc fbSetType*(self: RTCPPacket; `type`: RTCPFBType) =
  gst_rtcp_packet_fb_set_type(self, `type`)

type
  RTCPSDESType* {.size: sizeof(cint), pure.} = enum
    invalid = -1
    `end` = 0
    cname = 1
    name = 2
    email = 3
    phone = 4
    loc = 5
    tool = 6
    note = 7
    priv = 8

proc gst_rtcp_packet_sdes_add_entry(self: RTCPPacket; `type`: RTCPSDESType;
    len: uint8; data: ptr uint8): gboolean {.
    importc, libprag.}

proc sdesAddEntry*(self: RTCPPacket; `type`: RTCPSDESType;
    data: seq[uint8] | string): bool =
  let len = uint8(data.len)
  toBool(gst_rtcp_packet_sdes_add_entry(self, `type`, len, cast[ptr uint8](unsafeaddr(data[0]))))

proc gst_rtcp_packet_sdes_copy_entry(self: RTCPPacket; `type`: ptr RTCPSDESType;
    len: var uint8; data: var ptr uint8): gboolean {.
    importc, libprag.}

proc sdesCopyEntry*(self: RTCPPacket; `type`: ptr RTCPSDESType;
    len: var uint8; data: var (seq[uint8] | string)): bool =
  var data_00: ptr uint8
  result = toBool(gst_rtcp_packet_sdes_copy_entry(self, `type`, len, data_00))
  data.setLen(len)
  copyMem(unsafeaddr data[0], data_00, len.int * sizeof(data[0]))
  cogfree(data_00)

proc gst_rtcp_packet_sdes_get_entry(self: RTCPPacket; `type`: ptr RTCPSDESType;
    len: var uint8; data: var ptr uint8): gboolean {.
    importc, libprag.}

proc sdesGetEntry*(self: RTCPPacket; `type`: ptr RTCPSDESType;
    len: var uint8; data: var (seq[uint8] | string)): bool =
  var data_00: ptr uint8
  result = toBool(gst_rtcp_packet_sdes_get_entry(self, `type`, len, data_00))
  data.setLen(len)
  copyMem(unsafeaddr data[0], data_00, len.int * sizeof(data[0]))
  cogfree(data_00)

type
  RTCPXRType* {.size: sizeof(cint), pure.} = enum
    invalid = -1
    lrle = 1
    drle = 2
    prt = 3
    rrt = 4
    dlrr = 5
    ssumm = 6
    voipMetrics = 7

proc gst_rtcp_packet_xr_get_block_type(self: RTCPPacket): RTCPXRType {.
    importc, libprag.}

proc xrGetBlockType*(self: RTCPPacket): RTCPXRType =
  gst_rtcp_packet_xr_get_block_type(self)

const RTCP_MAX_BYE_SSRC_COUNT* = 31'i32

const RTCP_MAX_RB_COUNT* = 31'i32

const RTCP_MAX_SDES* = 255'i32

const RTCP_MAX_SDES_ITEM_COUNT* = 31'i32

const RTCP_REDUCED_SIZE_VALID_MASK* = 57592'i32

const RTCP_VALID_MASK* = 57598'i32

const RTCP_VALID_VALUE* = 200'i32

const RTCP_VERSION* = 2'i32

type
  RTPBasePayload* = ref object of gst.Element
  RTPBasePayload00* = object of gst.Element00

proc gst_rtp_base_payload_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTPBasePayload()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_rtp_base_payload_allocate_output_buffer(self: ptr RTPBasePayload00;
    payloadLen: uint32; padLen: uint8; csrcCount: uint8): ptr gst.Buffer00 {.
    importc, libprag.}

proc allocateOutputBuffer*(self: RTPBasePayload; payloadLen: int;
    padLen: uint8; csrcCount: uint8): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_base_payload_allocate_output_buffer(cast[ptr RTPBasePayload00](self.impl), uint32(payloadLen), padLen, csrcCount)

proc gst_rtp_base_payload_get_source_count(self: ptr RTPBasePayload00; buffer: ptr gst.Buffer00): uint32 {.
    importc, libprag.}

proc getSourceCount*(self: RTPBasePayload; buffer: gst.Buffer): int =
  int(gst_rtp_base_payload_get_source_count(cast[ptr RTPBasePayload00](self.impl), cast[ptr gst.Buffer00](buffer.impl)))

proc gst_rtp_base_payload_is_filled(self: ptr RTPBasePayload00; size: uint32;
    duration: uint64): gboolean {.
    importc, libprag.}

proc isFilled*(self: RTPBasePayload; size: int; duration: uint64): bool =
  toBool(gst_rtp_base_payload_is_filled(cast[ptr RTPBasePayload00](self.impl), uint32(size), duration))

proc gst_rtp_base_payload_is_source_info_enabled(self: ptr RTPBasePayload00): gboolean {.
    importc, libprag.}

proc isSourceInfoEnabled*(self: RTPBasePayload): bool =
  toBool(gst_rtp_base_payload_is_source_info_enabled(cast[ptr RTPBasePayload00](self.impl)))

proc gst_rtp_base_payload_push(self: ptr RTPBasePayload00; buffer: ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc push*(self: RTPBasePayload; buffer: gst.Buffer): gst.FlowReturn =
  gst_rtp_base_payload_push(cast[ptr RTPBasePayload00](self.impl), cast[ptr gst.Buffer00](buffer.impl))

proc gst_rtp_base_payload_push_list(self: ptr RTPBasePayload00; list: ptr gst.BufferList00): gst.FlowReturn {.
    importc, libprag.}

proc pushList*(self: RTPBasePayload; list: gst.BufferList): gst.FlowReturn =
  gst_rtp_base_payload_push_list(cast[ptr RTPBasePayload00](self.impl), cast[ptr gst.BufferList00](list.impl))

proc gst_rtp_base_payload_set_options(self: ptr RTPBasePayload00; media: cstring;
    dynamic: gboolean; encodingName: cstring; clockRate: uint32) {.
    importc, libprag.}

proc setOptions*(self: RTPBasePayload; media: cstring;
    dynamic: bool; encodingName: cstring; clockRate: int) =
  gst_rtp_base_payload_set_options(cast[ptr RTPBasePayload00](self.impl), media, gboolean(dynamic), encodingName, uint32(clockRate))

proc gst_rtp_base_payload_set_source_info_enabled(self: ptr RTPBasePayload00;
    enable: gboolean) {.
    importc, libprag.}

proc setSourceInfoEnabled*(self: RTPBasePayload; enable: bool = true) =
  gst_rtp_base_payload_set_source_info_enabled(cast[ptr RTPBasePayload00](self.impl), gboolean(enable))

proc `sourceInfoEnabled=`*(self: RTPBasePayload; enable: bool) =
  gst_rtp_base_payload_set_source_info_enabled(cast[ptr RTPBasePayload00](self.impl), gboolean(enable))

type
  RTPBaseAudioPayload* = ref object of RTPBasePayload
  RTPBaseAudioPayload00* = object of RTPBasePayload00

proc gst_rtp_base_audio_payload_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTPBaseAudioPayload()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_rtp_base_audio_payload_flush(self: ptr RTPBaseAudioPayload00; payloadLen: uint32;
    timestamp: uint64): gst.FlowReturn {.
    importc, libprag.}

proc flush*(self: RTPBaseAudioPayload; payloadLen: int;
    timestamp: uint64): gst.FlowReturn =
  gst_rtp_base_audio_payload_flush(cast[ptr RTPBaseAudioPayload00](self.impl), uint32(payloadLen), timestamp)

proc gst_rtp_base_audio_payload_get_adapter(self: ptr RTPBaseAudioPayload00): ptr gstbase.Adapter00 {.
    importc, libprag.}

proc getAdapter*(self: RTPBaseAudioPayload): gstbase.Adapter =
  let gobj = gst_rtp_base_audio_payload_get_adapter(cast[ptr RTPBaseAudioPayload00](self.impl))
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

proc adapter*(self: RTPBaseAudioPayload): gstbase.Adapter =
  let gobj = gst_rtp_base_audio_payload_get_adapter(cast[ptr RTPBaseAudioPayload00](self.impl))
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

proc gst_rtp_base_audio_payload_push(self: ptr RTPBaseAudioPayload00; data: ptr uint8;
    payloadLen: uint32; timestamp: uint64): gst.FlowReturn {.
    importc, libprag.}

proc push*(self: RTPBaseAudioPayload; data: seq[uint8] | string;
    timestamp: uint64): gst.FlowReturn =
  let payloadLen = int(data.len)
  gst_rtp_base_audio_payload_push(cast[ptr RTPBaseAudioPayload00](self.impl), cast[ptr uint8](unsafeaddr(data[0])), uint32(payloadLen), timestamp)

proc gst_rtp_base_audio_payload_set_frame_based(self: ptr RTPBaseAudioPayload00) {.
    importc, libprag.}

proc setFrameBased*(self: RTPBaseAudioPayload) =
  gst_rtp_base_audio_payload_set_frame_based(cast[ptr RTPBaseAudioPayload00](self.impl))

proc gst_rtp_base_audio_payload_set_frame_options(self: ptr RTPBaseAudioPayload00;
    frameDuration: int32; frameSize: int32) {.
    importc, libprag.}

proc setFrameOptions*(self: RTPBaseAudioPayload;
    frameDuration: int; frameSize: int) =
  gst_rtp_base_audio_payload_set_frame_options(cast[ptr RTPBaseAudioPayload00](self.impl), int32(frameDuration), int32(frameSize))

proc gst_rtp_base_audio_payload_set_sample_based(self: ptr RTPBaseAudioPayload00) {.
    importc, libprag.}

proc setSampleBased*(self: RTPBaseAudioPayload) =
  gst_rtp_base_audio_payload_set_sample_based(cast[ptr RTPBaseAudioPayload00](self.impl))

proc gst_rtp_base_audio_payload_set_sample_options(self: ptr RTPBaseAudioPayload00;
    sampleSize: int32) {.
    importc, libprag.}

proc setSampleOptions*(self: RTPBaseAudioPayload;
    sampleSize: int) =
  gst_rtp_base_audio_payload_set_sample_options(cast[ptr RTPBaseAudioPayload00](self.impl), int32(sampleSize))

proc `sampleOptions=`*(self: RTPBaseAudioPayload;
    sampleSize: int) =
  gst_rtp_base_audio_payload_set_sample_options(cast[ptr RTPBaseAudioPayload00](self.impl), int32(sampleSize))

proc gst_rtp_base_audio_payload_set_samplebits_options(self: ptr RTPBaseAudioPayload00;
    sampleSize: int32) {.
    importc, libprag.}

proc setSamplebitsOptions*(self: RTPBaseAudioPayload;
    sampleSize: int) =
  gst_rtp_base_audio_payload_set_samplebits_options(cast[ptr RTPBaseAudioPayload00](self.impl), int32(sampleSize))

proc `samplebitsOptions=`*(self: RTPBaseAudioPayload;
    sampleSize: int) =
  gst_rtp_base_audio_payload_set_samplebits_options(cast[ptr RTPBaseAudioPayload00](self.impl), int32(sampleSize))

type
  RTPBaseDepayload* = ref object of gst.Element
  RTPBaseDepayload00* = object of gst.Element00

proc gst_rtp_base_depayload_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(RTPBaseDepayload()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

proc gst_rtp_base_depayload_is_source_info_enabled(self: ptr RTPBaseDepayload00): gboolean {.
    importc, libprag.}

proc isSourceInfoEnabled*(self: RTPBaseDepayload): bool =
  toBool(gst_rtp_base_depayload_is_source_info_enabled(cast[ptr RTPBaseDepayload00](self.impl)))

proc gst_rtp_base_depayload_push(self: ptr RTPBaseDepayload00; outBuf: ptr gst.Buffer00): gst.FlowReturn {.
    importc, libprag.}

proc push*(self: RTPBaseDepayload; outBuf: gst.Buffer): gst.FlowReturn =
  gst_rtp_base_depayload_push(cast[ptr RTPBaseDepayload00](self.impl), cast[ptr gst.Buffer00](outBuf.impl))

proc gst_rtp_base_depayload_push_list(self: ptr RTPBaseDepayload00; outList: ptr gst.BufferList00): gst.FlowReturn {.
    importc, libprag.}

proc pushList*(self: RTPBaseDepayload; outList: gst.BufferList): gst.FlowReturn =
  gst_rtp_base_depayload_push_list(cast[ptr RTPBaseDepayload00](self.impl), cast[ptr gst.BufferList00](outList.impl))

proc gst_rtp_base_depayload_set_source_info_enabled(self: ptr RTPBaseDepayload00;
    enable: gboolean) {.
    importc, libprag.}

proc setSourceInfoEnabled*(self: RTPBaseDepayload;
    enable: bool = true) =
  gst_rtp_base_depayload_set_source_info_enabled(cast[ptr RTPBaseDepayload00](self.impl), gboolean(enable))

proc `sourceInfoEnabled=`*(self: RTPBaseDepayload;
    enable: bool) =
  gst_rtp_base_depayload_set_source_info_enabled(cast[ptr RTPBaseDepayload00](self.impl), gboolean(enable))

type
  RTPBuffer* {.pure, byRef.} = object
    buffer*: ptr gst.Buffer00
    state*: uint32
    data*: array[4, pointer]
    size*: array[4, uint64]
    map*: array[4, gst.MapInfo]

proc gst_rtp_buffer_add_extension_onebyte_header(self: RTPBuffer; id: uint8;
    data: ptr uint8; size: uint32): gboolean {.
    importc, libprag.}

proc addExtensionOnebyteHeader*(self: RTPBuffer; id: uint8;
    data: seq[uint8] | string): bool =
  let size = int(data.len)
  toBool(gst_rtp_buffer_add_extension_onebyte_header(self, id, cast[ptr uint8](unsafeaddr(data[0])), uint32(size)))

proc gst_rtp_buffer_add_extension_twobytes_header(self: RTPBuffer; appbits: uint8;
    id: uint8; data: ptr uint8; size: uint32): gboolean {.
    importc, libprag.}

proc addExtensionTwobytesHeader*(self: RTPBuffer; appbits: uint8;
    id: uint8; data: seq[uint8] | string): bool =
  let size = int(data.len)
  toBool(gst_rtp_buffer_add_extension_twobytes_header(self, appbits, id, cast[ptr uint8](unsafeaddr(data[0])), uint32(size)))

proc gst_rtp_buffer_get_csrc(self: RTPBuffer; idx: uint8): uint32 {.
    importc, libprag.}

proc getCsrc*(self: RTPBuffer; idx: uint8): int =
  int(gst_rtp_buffer_get_csrc(self, idx))

proc gst_rtp_buffer_get_csrc_count(self: RTPBuffer): uint8 {.
    importc, libprag.}

proc getCsrcCount*(self: RTPBuffer): uint8 =
  gst_rtp_buffer_get_csrc_count(self)

proc csrcCount*(self: RTPBuffer): uint8 =
  gst_rtp_buffer_get_csrc_count(self)

proc gst_rtp_buffer_get_extension(self: RTPBuffer): gboolean {.
    importc, libprag.}

proc getExtension*(self: RTPBuffer): bool =
  toBool(gst_rtp_buffer_get_extension(self))

proc extension*(self: RTPBuffer): bool =
  toBool(gst_rtp_buffer_get_extension(self))

proc gst_rtp_buffer_get_extension_bytes(self: RTPBuffer; bits: var uint16): ptr glib.Bytes00 {.
    importc, libprag.}

proc getExtensionData*(self: RTPBuffer; bits: var uint16): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gst_rtp_buffer_get_extension_bytes(self, bits)

proc gst_rtp_buffer_get_extension_onebyte_header(self: RTPBuffer; id: uint8;
    nth: uint32; data: var ptr uint8; size: var uint32): gboolean {.
    importc, libprag.}

proc getExtensionOnebyteHeader*(self: RTPBuffer; id: uint8;
    nth: int; data: var (seq[uint8] | string); size: var int): bool =
  var data_00: ptr uint8
  var size_00: uint32
  result = toBool(gst_rtp_buffer_get_extension_onebyte_header(self, id, uint32(nth), data_00, size_00))
  data.setLen(size)
  copyMem(unsafeaddr data[0], data_00, size.int * sizeof(data[0]))
  cogfree(data_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_rtp_buffer_get_extension_twobytes_header(self: RTPBuffer; appbits: var uint8;
    id: uint8; nth: uint32; data: var ptr uint8; size: var uint32): gboolean {.
    importc, libprag.}

proc getExtensionTwobytesHeader*(self: RTPBuffer; appbits: var uint8;
    id: uint8; nth: int; data: var (seq[uint8] | string); size: var int): bool =
  var data_00: ptr uint8
  var size_00: uint32
  result = toBool(gst_rtp_buffer_get_extension_twobytes_header(self, appbits, id, uint32(nth), data_00, size_00))
  data.setLen(size)
  copyMem(unsafeaddr data[0], data_00, size.int * sizeof(data[0]))
  cogfree(data_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_rtp_buffer_get_header_len(self: RTPBuffer): uint32 {.
    importc, libprag.}

proc getHeaderLen*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_header_len(self))

proc headerLen*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_header_len(self))

proc gst_rtp_buffer_get_marker(self: RTPBuffer): gboolean {.
    importc, libprag.}

proc getMarker*(self: RTPBuffer): bool =
  toBool(gst_rtp_buffer_get_marker(self))

proc marker*(self: RTPBuffer): bool =
  toBool(gst_rtp_buffer_get_marker(self))

proc gst_rtp_buffer_get_packet_len(self: RTPBuffer): uint32 {.
    importc, libprag.}

proc getPacketLen*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_packet_len(self))

proc packetLen*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_packet_len(self))

proc gst_rtp_buffer_get_padding(self: RTPBuffer): gboolean {.
    importc, libprag.}

proc getPadding*(self: RTPBuffer): bool =
  toBool(gst_rtp_buffer_get_padding(self))

proc padding*(self: RTPBuffer): bool =
  toBool(gst_rtp_buffer_get_padding(self))

proc gst_rtp_buffer_get_payload_buffer(self: RTPBuffer): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPayloadBuffer*(self: RTPBuffer): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_buffer_get_payload_buffer(self)

proc payloadBuffer*(self: RTPBuffer): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_buffer_get_payload_buffer(self)

proc gst_rtp_buffer_get_payload_bytes(self: RTPBuffer): ptr glib.Bytes00 {.
    importc, libprag.}

proc getPayload*(self: RTPBuffer): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gst_rtp_buffer_get_payload_bytes(self)

proc payload*(self: RTPBuffer): glib.Bytes =
  fnew(result, gBoxedFreeGBytes)
  result.impl = gst_rtp_buffer_get_payload_bytes(self)

proc gst_rtp_buffer_get_payload_len(self: RTPBuffer): uint32 {.
    importc, libprag.}

proc getPayloadLen*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_payload_len(self))

proc payloadLen*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_payload_len(self))

proc gst_rtp_buffer_get_payload_subbuffer(self: RTPBuffer; offset: uint32;
    len: uint32): ptr gst.Buffer00 {.
    importc, libprag.}

proc getPayloadSubbuffer*(self: RTPBuffer; offset: int; len: int): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_buffer_get_payload_subbuffer(self, uint32(offset), uint32(len))

proc gst_rtp_buffer_get_payload_type(self: RTPBuffer): uint8 {.
    importc, libprag.}

proc getPayloadType*(self: RTPBuffer): uint8 =
  gst_rtp_buffer_get_payload_type(self)

proc payloadType*(self: RTPBuffer): uint8 =
  gst_rtp_buffer_get_payload_type(self)

proc gst_rtp_buffer_get_seq(self: RTPBuffer): uint16 {.
    importc, libprag.}

proc getSeq*(self: RTPBuffer): uint16 =
  gst_rtp_buffer_get_seq(self)

proc seq*(self: RTPBuffer): uint16 =
  gst_rtp_buffer_get_seq(self)

proc gst_rtp_buffer_get_ssrc(self: RTPBuffer): uint32 {.
    importc, libprag.}

proc getSsrc*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_ssrc(self))

proc ssrc*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_ssrc(self))

proc gst_rtp_buffer_get_timestamp(self: RTPBuffer): uint32 {.
    importc, libprag.}

proc getTimestamp*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_timestamp(self))

proc timestamp*(self: RTPBuffer): int =
  int(gst_rtp_buffer_get_timestamp(self))

proc gst_rtp_buffer_get_version(self: RTPBuffer): uint8 {.
    importc, libprag.}

proc getVersion*(self: RTPBuffer): uint8 =
  gst_rtp_buffer_get_version(self)

proc version*(self: RTPBuffer): uint8 =
  gst_rtp_buffer_get_version(self)

proc gst_rtp_buffer_pad_to(self: RTPBuffer; len: uint32) {.
    importc, libprag.}

proc padTo*(self: RTPBuffer; len: int) =
  gst_rtp_buffer_pad_to(self, uint32(len))

proc gst_rtp_buffer_set_csrc(self: RTPBuffer; idx: uint8; csrc: uint32) {.
    importc, libprag.}

proc setCsrc*(self: RTPBuffer; idx: uint8; csrc: int) =
  gst_rtp_buffer_set_csrc(self, idx, uint32(csrc))

proc gst_rtp_buffer_set_extension(self: RTPBuffer; extension: gboolean) {.
    importc, libprag.}

proc setExtension*(self: RTPBuffer; extension: bool = true) =
  gst_rtp_buffer_set_extension(self, gboolean(extension))

proc `extension=`*(self: RTPBuffer; extension: bool) =
  gst_rtp_buffer_set_extension(self, gboolean(extension))

proc gst_rtp_buffer_set_extension_data(self: RTPBuffer; bits: uint16; length: uint16): gboolean {.
    importc, libprag.}

proc setExtensionData*(self: RTPBuffer; bits: uint16; length: uint16): bool =
  toBool(gst_rtp_buffer_set_extension_data(self, bits, length))

proc gst_rtp_buffer_set_marker(self: RTPBuffer; marker: gboolean) {.
    importc, libprag.}

proc setMarker*(self: RTPBuffer; marker: bool = true) =
  gst_rtp_buffer_set_marker(self, gboolean(marker))

proc `marker=`*(self: RTPBuffer; marker: bool) =
  gst_rtp_buffer_set_marker(self, gboolean(marker))

proc gst_rtp_buffer_set_packet_len(self: RTPBuffer; len: uint32) {.
    importc, libprag.}

proc setPacketLen*(self: RTPBuffer; len: int) =
  gst_rtp_buffer_set_packet_len(self, uint32(len))

proc `packetLen=`*(self: RTPBuffer; len: int) =
  gst_rtp_buffer_set_packet_len(self, uint32(len))

proc gst_rtp_buffer_set_padding(self: RTPBuffer; padding: gboolean) {.
    importc, libprag.}

proc setPadding*(self: RTPBuffer; padding: bool = true) =
  gst_rtp_buffer_set_padding(self, gboolean(padding))

proc `padding=`*(self: RTPBuffer; padding: bool) =
  gst_rtp_buffer_set_padding(self, gboolean(padding))

proc gst_rtp_buffer_set_payload_type(self: RTPBuffer; payloadType: uint8) {.
    importc, libprag.}

proc setPayloadType*(self: RTPBuffer; payloadType: uint8) =
  gst_rtp_buffer_set_payload_type(self, payloadType)

proc `payloadType=`*(self: RTPBuffer; payloadType: uint8) =
  gst_rtp_buffer_set_payload_type(self, payloadType)

proc gst_rtp_buffer_set_seq(self: RTPBuffer; seq: uint16) {.
    importc, libprag.}

proc setSeq*(self: RTPBuffer; seq: uint16) =
  gst_rtp_buffer_set_seq(self, seq)

proc `seq=`*(self: RTPBuffer; seq: uint16) =
  gst_rtp_buffer_set_seq(self, seq)

proc gst_rtp_buffer_set_ssrc(self: RTPBuffer; ssrc: uint32) {.
    importc, libprag.}

proc setSsrc*(self: RTPBuffer; ssrc: int) =
  gst_rtp_buffer_set_ssrc(self, uint32(ssrc))

proc `ssrc=`*(self: RTPBuffer; ssrc: int) =
  gst_rtp_buffer_set_ssrc(self, uint32(ssrc))

proc gst_rtp_buffer_set_timestamp(self: RTPBuffer; timestamp: uint32) {.
    importc, libprag.}

proc setTimestamp*(self: RTPBuffer; timestamp: int) =
  gst_rtp_buffer_set_timestamp(self, uint32(timestamp))

proc `timestamp=`*(self: RTPBuffer; timestamp: int) =
  gst_rtp_buffer_set_timestamp(self, uint32(timestamp))

proc gst_rtp_buffer_set_version(self: RTPBuffer; version: uint8) {.
    importc, libprag.}

proc setVersion*(self: RTPBuffer; version: uint8) =
  gst_rtp_buffer_set_version(self, version)

proc `version=`*(self: RTPBuffer; version: uint8) =
  gst_rtp_buffer_set_version(self, version)

proc gst_rtp_buffer_unmap(self: RTPBuffer) {.
    importc, libprag.}

proc unmap*(self: RTPBuffer) =
  gst_rtp_buffer_unmap(self)

proc gst_rtp_buffer_allocate_data(buffer: ptr gst.Buffer00; payloadLen: uint32;
    padLen: uint8; csrcCount: uint8) {.
    importc, libprag.}

proc allocateData*(buffer: gst.Buffer; payloadLen: int; padLen: uint8;
    csrcCount: uint8) =
  gst_rtp_buffer_allocate_data(cast[ptr gst.Buffer00](buffer.impl), uint32(payloadLen), padLen, csrcCount)

proc gst_rtp_buffer_calc_header_len(csrcCount: uint8): uint32 {.
    importc, libprag.}

proc calcHeaderLen*(csrcCount: uint8): int =
  int(gst_rtp_buffer_calc_header_len(csrcCount))

proc gst_rtp_buffer_calc_packet_len(payloadLen: uint32; padLen: uint8; csrcCount: uint8): uint32 {.
    importc, libprag.}

proc calcPacketLen*(payloadLen: int; padLen: uint8; csrcCount: uint8): int =
  int(gst_rtp_buffer_calc_packet_len(uint32(payloadLen), padLen, csrcCount))

proc gst_rtp_buffer_calc_payload_len(packetLen: uint32; padLen: uint8; csrcCount: uint8): uint32 {.
    importc, libprag.}

proc calcPayloadLen*(packetLen: int; padLen: uint8; csrcCount: uint8): int =
  int(gst_rtp_buffer_calc_payload_len(uint32(packetLen), padLen, csrcCount))

proc gst_rtp_buffer_compare_seqnum(seqnum1: uint16; seqnum2: uint16): int32 {.
    importc, libprag.}

proc compareSeqnum*(seqnum1: uint16; seqnum2: uint16): int =
  int(gst_rtp_buffer_compare_seqnum(seqnum1, seqnum2))

proc gst_rtp_buffer_default_clock_rate(payloadType: uint8): uint32 {.
    importc, libprag.}

proc defaultClockRate*(payloadType: uint8): int =
  int(gst_rtp_buffer_default_clock_rate(payloadType))

proc gst_rtp_buffer_ext_timestamp(exttimestamp: var uint64; timestamp: uint32): uint64 {.
    importc, libprag.}

proc extTimestamp*(exttimestamp: var uint64; timestamp: int): uint64 =
  gst_rtp_buffer_ext_timestamp(exttimestamp, uint32(timestamp))

proc gst_rtp_buffer_get_extension_onebyte_header_from_bytes(bytes: ptr glib.Bytes00;
    bitPattern: uint16; id: uint8; nth: uint32; data: var ptr uint8; size: var uint32): gboolean {.
    importc, libprag.}

proc getExtensionOnebyteHeaderFromBytes*(bytes: glib.Bytes;
    bitPattern: uint16; id: uint8; nth: int; data: var (seq[uint8] | string);
    size: var int): bool =
  var data_00: ptr uint8
  var size_00: uint32
  result = toBool(gst_rtp_buffer_get_extension_onebyte_header_from_bytes(cast[ptr glib.Bytes00](bytes.impl), bitPattern, id, uint32(nth), data_00, size_00))
  data.setLen(size)
  copyMem(unsafeaddr data[0], data_00, size.int * sizeof(data[0]))
  cogfree(data_00)
  if size.addr != nil:
    size = int(size_00)

proc gst_rtp_buffer_map(buffer: ptr gst.Buffer00; flags: gst.MapFlags; rtp: var RTPBuffer): gboolean {.
    importc, libprag.}

proc map*(buffer: gst.Buffer; flags: gst.MapFlags; rtp: var RTPBuffer): bool =
  toBool(gst_rtp_buffer_map(cast[ptr gst.Buffer00](buffer.impl), flags, rtp))

proc gst_rtp_buffer_new_allocate(payloadLen: uint32; padLen: uint8; csrcCount: uint8): ptr gst.Buffer00 {.
    importc, libprag.}

proc newRTPBufferAllocate*(payloadLen: int; padLen: uint8; csrcCount: uint8): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_buffer_new_allocate(uint32(payloadLen), padLen, csrcCount)

proc gst_rtp_buffer_new_allocate_len(packetLen: uint32; padLen: uint8; csrcCount: uint8): ptr gst.Buffer00 {.
    importc, libprag.}

proc newRTPBufferAllocateLen*(packetLen: int; padLen: uint8; csrcCount: uint8): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_buffer_new_allocate_len(uint32(packetLen), padLen, csrcCount)

proc gst_rtp_buffer_new_copy_data(data: ptr uint8; len: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc newRTPBufferCopyData*(data: seq[uint8] | string): gst.Buffer =
  let len = uint64(data.len)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_buffer_new_copy_data(cast[ptr uint8](unsafeaddr(data[0])), len)

proc gst_rtp_buffer_new_take_data(data: ptr uint8; len: uint64): ptr gst.Buffer00 {.
    importc, libprag.}

proc newRTPBufferTakeData*(data: seq[uint8] | string): gst.Buffer =
  let len = uint64(data.len)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_rtp_buffer_new_take_data(cast[ptr uint8](unsafeaddr(data[0])), len)

type
  RTPBufferFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    retransmission = 20
    redundant = 21
    last = 28

  RTPBufferFlags* {.size: sizeof(cint).} = set[RTPBufferFlag]

type
  RTPBufferMapFlag* {.size: sizeof(cint), pure.} = enum
    ignoreThisDummyValue = 0
    skipPadding = 16
    last = 24

  RTPBufferMapFlags* {.size: sizeof(cint).} = set[RTPBufferMapFlag]

type
  RTPPayload* {.size: sizeof(cint), pure.} = enum
    pcmu = 0
    enum1016 = 1
    g721 = 2
    gsm = 3
    g723 = 4
    dvi4_8000 = 5
    dvi4_16000 = 6
    lpc = 7
    pcma = 8
    g722 = 9
    l16Stereo = 10
    l16Mono = 11
    qcelp = 12
    cn = 13
    mpa = 14
    g728 = 15
    dvi4_11025 = 16
    dvi4_22050 = 17
    g729 = 18
    cellb = 25
    jpeg = 26
    nv = 28
    h261 = 31
    mpv = 32
    mp2t = 33
    h263 = 34

type
  RTPPayloadInfo00* {.pure.} = object
  RTPPayloadInfo* = ref object
    impl*: ptr RTPPayloadInfo00
    ignoreFinalizer*: bool

proc gst_rtp_payload_info_for_name(media: cstring; encodingName: cstring): ptr RTPPayloadInfo00 {.
    importc, libprag.}

proc forName*(media: cstring; encodingName: cstring): RTPPayloadInfo =
  new(result)
  result.impl = gst_rtp_payload_info_for_name(media, encodingName)
  result.ignoreFinalizer = true

proc gst_rtp_payload_info_for_pt(payloadType: uint8): ptr RTPPayloadInfo00 {.
    importc, libprag.}

proc forPt*(payloadType: uint8): RTPPayloadInfo =
  new(result)
  result.impl = gst_rtp_payload_info_for_pt(payloadType)
  result.ignoreFinalizer = true

type
  RTPProfile* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    avp = 1
    savp = 2
    avpf = 3
    savpf = 4

type
  RTPSourceMeta00* {.pure.} = object
  RTPSourceMeta* = ref object
    impl*: ptr RTPSourceMeta00
    ignoreFinalizer*: bool

proc gst_rtp_source_meta_append_csrc(self: ptr RTPSourceMeta00; csrc: ptr uint32;
    csrcCount: uint32): gboolean {.
    importc, libprag.}

proc appendCsrc*(self: RTPSourceMeta; csrc: ptr uint32;
    csrcCount: int): bool =
  toBool(gst_rtp_source_meta_append_csrc(cast[ptr RTPSourceMeta00](self.impl), csrc, uint32(csrcCount)))

proc gst_rtp_source_meta_get_source_count(self: ptr RTPSourceMeta00): uint32 {.
    importc, libprag.}

proc getSourceCount*(self: RTPSourceMeta): int =
  int(gst_rtp_source_meta_get_source_count(cast[ptr RTPSourceMeta00](self.impl)))

proc sourceCount*(self: RTPSourceMeta): int =
  int(gst_rtp_source_meta_get_source_count(cast[ptr RTPSourceMeta00](self.impl)))

proc gst_rtp_source_meta_set_ssrc(self: ptr RTPSourceMeta00; ssrc: ptr uint32): gboolean {.
    importc, libprag.}

proc setSsrc*(self: RTPSourceMeta; ssrc: ptr uint32): bool =
  toBool(gst_rtp_source_meta_set_ssrc(cast[ptr RTPSourceMeta00](self.impl), ssrc))

proc gst_rtp_source_meta_get_info(): ptr gst.MetaInfo00 {.
    importc, libprag.}

proc getInfoRTPSourceMeta*(): gst.MetaInfo =
  new(result)
  result.impl = gst_rtp_source_meta_get_info()
  result.ignoreFinalizer = true

const RTP_HDREXT_BASE* = "urn:ietf:params:rtp-hdrext:"

const RTP_HDREXT_NTP_56* = "ntp-56"

const RTP_HDREXT_NTP_56_SIZE* = 7'i32

const RTP_HDREXT_NTP_64* = "ntp-64"

const RTP_HDREXT_NTP_64_SIZE* = 8'i32

const RTP_PAYLOAD_1016_STRING* = "1"

const RTP_PAYLOAD_CELLB_STRING* = "25"

const RTP_PAYLOAD_CN_STRING* = "13"

const RTP_PAYLOAD_DVI4_11025_STRING* = "16"

const RTP_PAYLOAD_DVI4_16000_STRING* = "6"

const RTP_PAYLOAD_DVI4_22050_STRING* = "17"

const RTP_PAYLOAD_DVI4_8000_STRING* = "5"

const RTP_PAYLOAD_DYNAMIC_STRING* = "[96, 127]"

const RTP_PAYLOAD_G721_STRING* = "2"

const RTP_PAYLOAD_G722_STRING* = "9"

const RTP_PAYLOAD_G723_53* = 17'i32

const RTP_PAYLOAD_G723_53_STRING* = "17"

const RTP_PAYLOAD_G723_63* = 16'i32

const RTP_PAYLOAD_G723_63_STRING* = "16"

const RTP_PAYLOAD_G723_STRING* = "4"

const RTP_PAYLOAD_G728_STRING* = "15"

const RTP_PAYLOAD_G729_STRING* = "18"

const RTP_PAYLOAD_GSM_STRING* = "3"

const RTP_PAYLOAD_H261_STRING* = "31"

const RTP_PAYLOAD_H263_STRING* = "34"

const RTP_PAYLOAD_JPEG_STRING* = "26"

const RTP_PAYLOAD_L16_MONO_STRING* = "11"

const RTP_PAYLOAD_L16_STEREO_STRING* = "10"

const RTP_PAYLOAD_LPC_STRING* = "7"

const RTP_PAYLOAD_MP2T_STRING* = "33"

const RTP_PAYLOAD_MPA_STRING* = "14"

const RTP_PAYLOAD_MPV_STRING* = "32"

const RTP_PAYLOAD_NV_STRING* = "28"

const RTP_PAYLOAD_PCMA_STRING* = "8"

const RTP_PAYLOAD_PCMU_STRING* = "0"

const RTP_PAYLOAD_QCELP_STRING* = "12"

const RTP_PAYLOAD_TS41* = 19'i32

const RTP_PAYLOAD_TS41_STRING* = "19"

const RTP_PAYLOAD_TS48* = 18'i32

const RTP_PAYLOAD_TS48_STRING* = "18"

const RTP_SOURCE_META_MAX_CSRC_COUNT* = 15'i32

const RTP_VERSION* = 2'i32

proc gst_buffer_add_rtp_source_meta(buffer: ptr gst.Buffer00; ssrc: ptr uint32;
    csrc: ptr uint32; csrcCount: uint32): ptr RTPSourceMeta00 {.
    importc, libprag.}

proc bufferAddRtpSourceMeta*(buffer: gst.Buffer; ssrc: ptr uint32;
    csrc: ptr uint32; csrcCount: int): RTPSourceMeta =
  new(result)
  result.impl = gst_buffer_add_rtp_source_meta(cast[ptr gst.Buffer00](buffer.impl), ssrc, csrc, uint32(csrcCount))
  result.ignoreFinalizer = true

proc gst_buffer_get_rtp_source_meta(buffer: ptr gst.Buffer00): ptr RTPSourceMeta00 {.
    importc, libprag.}

proc bufferGetRtpSourceMeta*(buffer: gst.Buffer): RTPSourceMeta =
  new(result)
  result.impl = gst_buffer_get_rtp_source_meta(cast[ptr gst.Buffer00](buffer.impl))
  result.ignoreFinalizer = true

proc rtcpNtpToUnix*(ntptime: uint64): uint64 {.
    importc: "gst_rtcp_ntp_to_unix", libprag.}

proc rtcpSdesNameToType*(name: cstring): RTCPSDESType {.
    importc: "gst_rtcp_sdes_name_to_type", libprag.}

proc gst_rtcp_sdes_type_to_name(`type`: RTCPSDESType): cstring {.
    importc, libprag.}

proc rtcpSdesTypeToName*(`type`: RTCPSDESType): string =
  result = $gst_rtcp_sdes_type_to_name(`type`)

proc rtcpUnixToNtp*(unixtime: uint64): uint64 {.
    importc: "gst_rtcp_unix_to_ntp", libprag.}

proc gst_rtp_hdrext_get_ntp_56(data: ptr uint8; size: uint32; ntptime: var uint64): gboolean {.
    importc, libprag.}

proc rtpHdrextGetNtp_56*(data: seq[uint8] | string; ntptime: var uint64): bool =
  let size = int(data.len)
  toBool(gst_rtp_hdrext_get_ntp_56(cast[ptr uint8](unsafeaddr(data[0])), uint32(size), ntptime))

proc gst_rtp_hdrext_get_ntp_64(data: ptr uint8; size: uint32; ntptime: var uint64): gboolean {.
    importc, libprag.}

proc rtpHdrextGetNtp_64*(data: seq[uint8] | string; ntptime: var uint64): bool =
  let size = int(data.len)
  toBool(gst_rtp_hdrext_get_ntp_64(cast[ptr uint8](unsafeaddr(data[0])), uint32(size), ntptime))

proc gst_rtp_hdrext_set_ntp_56(data: pointer; size: uint32; ntptime: uint64): gboolean {.
    importc, libprag.}

proc rtpHdrextSetNtp_56*(data: pointer; size: int; ntptime: uint64): bool =
  toBool(gst_rtp_hdrext_set_ntp_56(data, uint32(size), ntptime))

proc gst_rtp_hdrext_set_ntp_64(data: pointer; size: uint32; ntptime: uint64): gboolean {.
    importc, libprag.}

proc rtpHdrextSetNtp_64*(data: pointer; size: int; ntptime: uint64): bool =
  toBool(gst_rtp_hdrext_set_ntp_64(data, uint32(size), ntptime))

proc rtpSourceMetaApiGetType*(): GType {.
    importc: "gst_rtp_source_meta_api_get_type", libprag.}
# === remaining symbols:
