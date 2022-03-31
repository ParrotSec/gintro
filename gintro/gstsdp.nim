# dependencies:
# GObject-2.0
# Gst-1.0
# GLib-2.0
# GModule-2.0
# immediate dependencies:
# Gst-1.0
# libraries:
# libgstsdp-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gst, glib, gmodule
const Lib = "libgstsdp-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

type
  MIKEYCacheType* {.size: sizeof(cint), pure.} = enum
    none = 0
    always = 1
    forCsb = 2

type
  MIKEYDecryptInfo00* {.pure.} = object
  MIKEYDecryptInfo* = ref object
    impl*: ptr MIKEYDecryptInfo00
    ignoreFinalizer*: bool

type
  MIKEYEncAlg* {.size: sizeof(cint), pure.} = enum
    null = 0
    aesCm_128 = 1
    aesKw_128 = 2
    aesGcm_128 = 6

type
  MIKEYEncryptInfo* {.pure, byRef.} = object

type
  MIKEYKVType* {.size: sizeof(cint), pure.} = enum
    null = 0
    spi = 1
    interval = 2

type
  MIKEYKeyDataType* {.size: sizeof(cint), pure.} = enum
    tgk = 0
    tek = 2

type
  MIKEYMacAlg* {.size: sizeof(cint), pure.} = enum
    null = 0
    hmacSha_1_160 = 1

type
  MIKEYMapSRTP00* {.pure.} = object
  MIKEYMapSRTP* = ref object
    impl*: ptr MIKEYMapSRTP00
    ignoreFinalizer*: bool

type
  MIKEYMapType* {.size: sizeof(cint), pure.} = enum
    mikeyMapTypeSrtp = 0

type
  MIKEYMessage00* {.pure.} = object
  MIKEYMessage* = ref object
    impl*: ptr MIKEYMessage00
    ignoreFinalizer*: bool

proc gst_mikey_message_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMIKEYMessage*(self: MIKEYMessage) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mikey_message_get_type(), cast[ptr MIKEYMessage00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MIKEYMessage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mikey_message_get_type(), cast[ptr MIKEYMessage00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MIKEYMessage) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMIKEYMessage)

proc gst_mikey_message_new(): ptr MIKEYMessage00 {.
    importc, libprag.}

proc newMIKEYMessage*(): MIKEYMessage =
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = gst_mikey_message_new()

proc newMIKEYMessage*(tdesc: typedesc): tdesc =
  assert(result is MIKEYMessage)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = gst_mikey_message_new()

proc initMIKEYMessage*[T](result: var T) {.deprecated.} =
  assert(result is MIKEYMessage)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = gst_mikey_message_new()

proc gst_mikey_message_new_from_bytes(bytes: ptr glib.Bytes00; info: ptr MIKEYDecryptInfo00;
    error: ptr ptr glib.Error = nil): ptr MIKEYMessage00 {.
    importc, libprag.}

proc newMIKEYMessageFromBytes*(bytes: glib.Bytes; info: MIKEYDecryptInfo): MIKEYMessage =
  var gerror: ptr glib.Error
  let impl0 = gst_mikey_message_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), cast[ptr MIKEYDecryptInfo00](info.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = impl0

proc newMIKEYMessageFromBytes*(tdesc: typedesc; bytes: glib.Bytes; info: MIKEYDecryptInfo): tdesc =
  var gerror: ptr glib.Error
  assert(result is MIKEYMessage)
  let impl0 = gst_mikey_message_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), cast[ptr MIKEYDecryptInfo00](info.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = impl0

proc initMIKEYMessageFromBytes*[T](result: var T; bytes: glib.Bytes; info: MIKEYDecryptInfo) {.deprecated.} =
  var gerror: ptr glib.Error
  assert(result is MIKEYMessage)
  let impl0 = gst_mikey_message_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl), cast[ptr MIKEYDecryptInfo00](info.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = impl0

proc gst_mikey_message_new_from_caps(caps: ptr gst.Caps00): ptr MIKEYMessage00 {.
    importc, libprag.}

proc newMIKEYMessageFromCaps*(caps: gst.Caps): MIKEYMessage =
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = gst_mikey_message_new_from_caps(cast[ptr gst.Caps00](caps.impl))

proc newMIKEYMessageFromCaps*(tdesc: typedesc; caps: gst.Caps): tdesc =
  assert(result is MIKEYMessage)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = gst_mikey_message_new_from_caps(cast[ptr gst.Caps00](caps.impl))

proc initMIKEYMessageFromCaps*[T](result: var T; caps: gst.Caps) {.deprecated.} =
  assert(result is MIKEYMessage)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = gst_mikey_message_new_from_caps(cast[ptr gst.Caps00](caps.impl))

proc gst_mikey_message_new_from_data(data: ptr uint8; size: uint64; info: ptr MIKEYDecryptInfo00;
    error: ptr ptr glib.Error = nil): ptr MIKEYMessage00 {.
    importc, libprag.}

proc newMIKEYMessageFromData*(data: seq[uint8] | string; info: MIKEYDecryptInfo): MIKEYMessage =
  let size = uint64(data.len)
  var gerror: ptr glib.Error
  let impl0 = gst_mikey_message_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), size, cast[ptr MIKEYDecryptInfo00](info.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = impl0

proc newMIKEYMessageFromData*(tdesc: typedesc; data: seq[uint8] | string; info: MIKEYDecryptInfo): tdesc =
  let size = uint64(data.len)
  var gerror: ptr glib.Error
  assert(result is MIKEYMessage)
  let impl0 = gst_mikey_message_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), size, cast[ptr MIKEYDecryptInfo00](info.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = impl0

proc initMIKEYMessageFromData*[T](result: var T; data: seq[uint8] | string; info: MIKEYDecryptInfo) {.deprecated.} =
  let size = uint64(data.len)
  var gerror: ptr glib.Error
  assert(result is MIKEYMessage)
  let impl0 = gst_mikey_message_new_from_data(cast[ptr uint8](unsafeaddr(data[0])), size, cast[ptr MIKEYDecryptInfo00](info.impl), addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGstMIKEYMessage)
  result.impl = impl0

proc gst_mikey_message_add_cs_srtp(self: ptr MIKEYMessage00; policy: uint8;
    ssrc: uint32; roc: uint32): gboolean {.
    importc, libprag.}

proc addCsSrtp*(self: MIKEYMessage; policy: uint8; ssrc: int;
    roc: int): bool =
  toBool(gst_mikey_message_add_cs_srtp(cast[ptr MIKEYMessage00](self.impl), policy, uint32(ssrc), uint32(roc)))

proc gst_mikey_message_add_pke(self: ptr MIKEYMessage00; C: MIKEYCacheType;
    dataLen: uint16; data: ptr uint8): gboolean {.
    importc, libprag.}

proc addPke*(self: MIKEYMessage; C: MIKEYCacheType; data: seq[uint8] | string): bool =
  let dataLen = uint16(data.len)
  toBool(gst_mikey_message_add_pke(cast[ptr MIKEYMessage00](self.impl), C, dataLen, cast[ptr uint8](unsafeaddr(data[0]))))

proc gst_mikey_message_add_rand(self: ptr MIKEYMessage00; len: uint8; rand: ptr uint8): gboolean {.
    importc, libprag.}

proc addRand*(self: MIKEYMessage; rand: seq[uint8] | string): bool =
  let len = uint8(rand.len)
  toBool(gst_mikey_message_add_rand(cast[ptr MIKEYMessage00](self.impl), len, cast[ptr uint8](unsafeaddr(rand[0]))))

proc gst_mikey_message_add_rand_len(self: ptr MIKEYMessage00; len: uint8): gboolean {.
    importc, libprag.}

proc addRandLen*(self: MIKEYMessage; len: uint8): bool =
  toBool(gst_mikey_message_add_rand_len(cast[ptr MIKEYMessage00](self.impl), len))

proc gst_mikey_message_add_t_now_ntp_utc(self: ptr MIKEYMessage00): gboolean {.
    importc, libprag.}

proc addTNowNtpUtc*(self: MIKEYMessage): bool =
  toBool(gst_mikey_message_add_t_now_ntp_utc(cast[ptr MIKEYMessage00](self.impl)))

proc gst_mikey_message_base64_encode(self: ptr MIKEYMessage00): cstring {.
    importc, libprag.}

proc base64Encode*(self: MIKEYMessage): string =
  let resul0 = gst_mikey_message_base64_encode(cast[ptr MIKEYMessage00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_mikey_message_get_cs_srtp(self: ptr MIKEYMessage00; idx: uint32): ptr MIKEYMapSRTP00 {.
    importc, libprag.}

proc getCsSrtp*(self: MIKEYMessage; idx: int): MIKEYMapSRTP =
  new(result)
  result.impl = gst_mikey_message_get_cs_srtp(cast[ptr MIKEYMessage00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_mikey_message_get_n_cs(self: ptr MIKEYMessage00): uint32 {.
    importc, libprag.}

proc getNCs*(self: MIKEYMessage): int =
  int(gst_mikey_message_get_n_cs(cast[ptr MIKEYMessage00](self.impl)))

proc nCs*(self: MIKEYMessage): int =
  int(gst_mikey_message_get_n_cs(cast[ptr MIKEYMessage00](self.impl)))

proc gst_mikey_message_get_n_payloads(self: ptr MIKEYMessage00): uint32 {.
    importc, libprag.}

proc getNPayloads*(self: MIKEYMessage): int =
  int(gst_mikey_message_get_n_payloads(cast[ptr MIKEYMessage00](self.impl)))

proc nPayloads*(self: MIKEYMessage): int =
  int(gst_mikey_message_get_n_payloads(cast[ptr MIKEYMessage00](self.impl)))

proc gst_mikey_message_insert_cs_srtp(self: ptr MIKEYMessage00; idx: int32;
    map: ptr MIKEYMapSRTP00): gboolean {.
    importc, libprag.}

proc insertCsSrtp*(self: MIKEYMessage; idx: int; map: MIKEYMapSRTP): bool =
  toBool(gst_mikey_message_insert_cs_srtp(cast[ptr MIKEYMessage00](self.impl), int32(idx), cast[ptr MIKEYMapSRTP00](map.impl)))

proc gst_mikey_message_remove_cs_srtp(self: ptr MIKEYMessage00; idx: int32): gboolean {.
    importc, libprag.}

proc removeCsSrtp*(self: MIKEYMessage; idx: int): bool =
  toBool(gst_mikey_message_remove_cs_srtp(cast[ptr MIKEYMessage00](self.impl), int32(idx)))

proc gst_mikey_message_remove_payload(self: ptr MIKEYMessage00; idx: uint32): gboolean {.
    importc, libprag.}

proc removePayload*(self: MIKEYMessage; idx: int): bool =
  toBool(gst_mikey_message_remove_payload(cast[ptr MIKEYMessage00](self.impl), uint32(idx)))

proc gst_mikey_message_replace_cs_srtp(self: ptr MIKEYMessage00; idx: int32;
    map: ptr MIKEYMapSRTP00): gboolean {.
    importc, libprag.}

proc replaceCsSrtp*(self: MIKEYMessage; idx: int; map: MIKEYMapSRTP): bool =
  toBool(gst_mikey_message_replace_cs_srtp(cast[ptr MIKEYMessage00](self.impl), int32(idx), cast[ptr MIKEYMapSRTP00](map.impl)))

proc gst_mikey_message_to_bytes(self: ptr MIKEYMessage00; info: MIKEYEncryptInfo;
    error: ptr ptr glib.Error = nil): ptr glib.Bytes00 {.
    importc, libprag.}

proc toBytes*(self: MIKEYMessage; info: MIKEYEncryptInfo): glib.Bytes =
  var gerror: ptr glib.Error
  let impl0 = gst_mikey_message_to_bytes(cast[ptr MIKEYMessage00](self.impl), info, addr gerror)
  if gerror != nil:
    let msg = $gerror.message
    g_error_free(gerror[])
    raise newException(GException, msg)
  fnew(result, gBoxedFreeGBytes)
  result.impl = impl0

proc gst_mikey_message_to_caps(self: ptr MIKEYMessage00; caps: ptr gst.Caps00): gboolean {.
    importc, libprag.}

proc toCaps*(self: MIKEYMessage; caps: gst.Caps): bool =
  toBool(gst_mikey_message_to_caps(cast[ptr MIKEYMessage00](self.impl), cast[ptr gst.Caps00](caps.impl)))

type
  MIKEYTSType* {.size: sizeof(cint), pure.} = enum
    ntpUtc = 0
    ntp = 1
    counter = 2

proc gst_mikey_message_add_t(self: ptr MIKEYMessage00; `type`: MIKEYTSType;
    tsValue: ptr uint8): gboolean {.
    importc, libprag.}

proc addT*(self: MIKEYMessage; `type`: MIKEYTSType; tsValue: seq[uint8] | string): bool =
  toBool(gst_mikey_message_add_t(cast[ptr MIKEYMessage00](self.impl), `type`, cast[ptr uint8](unsafeaddr(tsValue[0]))))

type
  MIKEYPayloadType* {.size: sizeof(cint), pure.} = enum
    last = 0
    kemac = 1
    pke = 2
    dh = 3
    sign = 4
    t = 5
    id = 6
    cert = 7
    chash = 8
    v = 9
    sp = 10
    rand = 11
    err = 12
    keyData = 20
    genExt = 21

type
  MIKEYPayload00* {.pure.} = object
  MIKEYPayload* = ref object
    impl*: ptr MIKEYPayload00
    ignoreFinalizer*: bool

proc gst_mikey_payload_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstMIKEYPayload*(self: MIKEYPayload) =
  if not self.ignoreFinalizer:
    boxedFree(gst_mikey_payload_get_type(), cast[ptr MIKEYPayload00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(MIKEYPayload()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_mikey_payload_get_type(), cast[ptr MIKEYPayload00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var MIKEYPayload) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstMIKEYPayload)

proc gst_mikey_payload_new(`type`: MIKEYPayloadType): ptr MIKEYPayload00 {.
    importc, libprag.}

proc newMIKEYPayload*(`type`: MIKEYPayloadType): MIKEYPayload =
  let impl0 = gst_mikey_payload_new(`type`)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMIKEYPayload)
  result.impl = impl0

proc newMIKEYPayload*(tdesc: typedesc; `type`: MIKEYPayloadType): tdesc =
  assert(result is MIKEYPayload)
  let impl0 = gst_mikey_payload_new(`type`)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMIKEYPayload)
  result.impl = impl0

proc initMIKEYPayload*[T](result: var T; `type`: MIKEYPayloadType) {.deprecated.} =
  assert(result is MIKEYPayload)
  let impl0 = gst_mikey_payload_new(`type`)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstMIKEYPayload)
  result.impl = impl0

proc gst_mikey_payload_kemac_add_sub(self: ptr MIKEYPayload00; newpay: ptr MIKEYPayload00): gboolean {.
    importc, libprag.}

proc kemacAddSub*(self: MIKEYPayload; newpay: MIKEYPayload): bool =
  toBool(gst_mikey_payload_kemac_add_sub(cast[ptr MIKEYPayload00](self.impl), cast[ptr MIKEYPayload00](g_boxed_copy(gst_mikey_payload_get_type(), newpay.impl))))

proc gst_mikey_payload_kemac_get_n_sub(self: ptr MIKEYPayload00): uint32 {.
    importc, libprag.}

proc kemacGetNSub*(self: MIKEYPayload): int =
  int(gst_mikey_payload_kemac_get_n_sub(cast[ptr MIKEYPayload00](self.impl)))

proc gst_mikey_payload_kemac_get_sub(self: ptr MIKEYPayload00; idx: uint32): ptr MIKEYPayload00 {.
    importc, libprag.}

proc kemacGetSub*(self: MIKEYPayload; idx: int): MIKEYPayload =
  fnew(result, gBoxedFreeGstMIKEYPayload)
  result.impl = gst_mikey_payload_kemac_get_sub(cast[ptr MIKEYPayload00](self.impl), uint32(idx))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mikey_payload_get_type(), result.impl))

proc gst_mikey_payload_kemac_remove_sub(self: ptr MIKEYPayload00; idx: uint32): gboolean {.
    importc, libprag.}

proc kemacRemoveSub*(self: MIKEYPayload; idx: int): bool =
  toBool(gst_mikey_payload_kemac_remove_sub(cast[ptr MIKEYPayload00](self.impl), uint32(idx)))

proc gst_mikey_payload_kemac_set(self: ptr MIKEYPayload00; encAlg: MIKEYEncAlg;
    macAlg: MIKEYMacAlg): gboolean {.
    importc, libprag.}

proc kemacSet*(self: MIKEYPayload; encAlg: MIKEYEncAlg;
    macAlg: MIKEYMacAlg): bool =
  toBool(gst_mikey_payload_kemac_set(cast[ptr MIKEYPayload00](self.impl), encAlg, macAlg))

proc gst_mikey_payload_key_data_set_interval(self: ptr MIKEYPayload00; vfLen: uint8;
    vfData: ptr uint8; vtLen: uint8; vtData: ptr uint8): gboolean {.
    importc, libprag.}

proc keyDataSetInterval*(self: MIKEYPayload; vfLen: uint8;
    vfData: seq[uint8] | string; vtData: seq[uint8] | string): bool =
  let vtLen = uint8(vtData.len)
  toBool(gst_mikey_payload_key_data_set_interval(cast[ptr MIKEYPayload00](self.impl), vfLen, cast[ptr uint8](unsafeaddr(vfData[0])), vtLen, cast[ptr uint8](unsafeaddr(vtData[0]))))

proc gst_mikey_payload_key_data_set_key(self: ptr MIKEYPayload00; keyType: MIKEYKeyDataType;
    keyLen: uint16; keyData: ptr uint8): gboolean {.
    importc, libprag.}

proc keyDataSetKey*(self: MIKEYPayload; keyType: MIKEYKeyDataType;
    keyData: seq[uint8] | string): bool =
  let keyLen = uint16(keyData.len)
  toBool(gst_mikey_payload_key_data_set_key(cast[ptr MIKEYPayload00](self.impl), keyType, keyLen, cast[ptr uint8](unsafeaddr(keyData[0]))))

proc gst_mikey_payload_key_data_set_salt(self: ptr MIKEYPayload00; saltLen: uint16;
    saltData: ptr uint8): gboolean {.
    importc, libprag.}

proc keyDataSetSalt*(self: MIKEYPayload; saltData: seq[uint8] | string): bool =
  let saltLen = uint16(saltData.len)
  toBool(gst_mikey_payload_key_data_set_salt(cast[ptr MIKEYPayload00](self.impl), saltLen, cast[ptr uint8](unsafeaddr(saltData[0]))))

proc gst_mikey_payload_key_data_set_spi(self: ptr MIKEYPayload00; spiLen: uint8;
    spiData: ptr uint8): gboolean {.
    importc, libprag.}

proc keyDataSetSpi*(self: MIKEYPayload; spiData: seq[uint8] | string): bool =
  let spiLen = uint8(spiData.len)
  toBool(gst_mikey_payload_key_data_set_spi(cast[ptr MIKEYPayload00](self.impl), spiLen, cast[ptr uint8](unsafeaddr(spiData[0]))))

proc gst_mikey_payload_pke_set(self: ptr MIKEYPayload00; C: MIKEYCacheType;
    dataLen: uint16; data: ptr uint8): gboolean {.
    importc, libprag.}

proc pkeSet*(self: MIKEYPayload; C: MIKEYCacheType; data: seq[uint8] | string): bool =
  let dataLen = uint16(data.len)
  toBool(gst_mikey_payload_pke_set(cast[ptr MIKEYPayload00](self.impl), C, dataLen, cast[ptr uint8](unsafeaddr(data[0]))))

proc gst_mikey_payload_rand_set(self: ptr MIKEYPayload00; len: uint8; rand: ptr uint8): gboolean {.
    importc, libprag.}

proc randSet*(self: MIKEYPayload; rand: seq[uint8] | string): bool =
  let len = uint8(rand.len)
  toBool(gst_mikey_payload_rand_set(cast[ptr MIKEYPayload00](self.impl), len, cast[ptr uint8](unsafeaddr(rand[0]))))

proc gst_mikey_payload_sp_add_param(self: ptr MIKEYPayload00; `type`: uint8;
    len: uint8; val: ptr uint8): gboolean {.
    importc, libprag.}

proc spAddParam*(self: MIKEYPayload; `type`: uint8; val: seq[uint8] | string): bool =
  let len = uint8(val.len)
  toBool(gst_mikey_payload_sp_add_param(cast[ptr MIKEYPayload00](self.impl), `type`, len, cast[ptr uint8](unsafeaddr(val[0]))))

proc gst_mikey_payload_sp_get_n_params(self: ptr MIKEYPayload00): uint32 {.
    importc, libprag.}

proc spGetNParams*(self: MIKEYPayload): int =
  int(gst_mikey_payload_sp_get_n_params(cast[ptr MIKEYPayload00](self.impl)))

proc gst_mikey_payload_sp_remove_param(self: ptr MIKEYPayload00; idx: uint32): gboolean {.
    importc, libprag.}

proc spRemoveParam*(self: MIKEYPayload; idx: int): bool =
  toBool(gst_mikey_payload_sp_remove_param(cast[ptr MIKEYPayload00](self.impl), uint32(idx)))

proc gst_mikey_payload_t_set(self: ptr MIKEYPayload00; `type`: MIKEYTSType;
    tsValue: ptr uint8): gboolean {.
    importc, libprag.}

proc tSet*(self: MIKEYPayload; `type`: MIKEYTSType; tsValue: seq[uint8] | string): bool =
  toBool(gst_mikey_payload_t_set(cast[ptr MIKEYPayload00](self.impl), `type`, cast[ptr uint8](unsafeaddr(tsValue[0]))))

proc gst_mikey_message_add_payload(self: ptr MIKEYMessage00; payload: ptr MIKEYPayload00): gboolean {.
    importc, libprag.}

proc addPayload*(self: MIKEYMessage; payload: MIKEYPayload): bool =
  toBool(gst_mikey_message_add_payload(cast[ptr MIKEYMessage00](self.impl), cast[ptr MIKEYPayload00](g_boxed_copy(gst_mikey_payload_get_type(), payload.impl))))

proc gst_mikey_message_find_payload(self: ptr MIKEYMessage00; `type`: MIKEYPayloadType;
    nth: uint32): ptr MIKEYPayload00 {.
    importc, libprag.}

proc findPayload*(self: MIKEYMessage; `type`: MIKEYPayloadType;
    nth: int): MIKEYPayload =
  fnew(result, gBoxedFreeGstMIKEYPayload)
  result.impl = gst_mikey_message_find_payload(cast[ptr MIKEYMessage00](self.impl), `type`, uint32(nth))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mikey_payload_get_type(), result.impl))

proc gst_mikey_message_get_payload(self: ptr MIKEYMessage00; idx: uint32): ptr MIKEYPayload00 {.
    importc, libprag.}

proc getPayload*(self: MIKEYMessage; idx: int): MIKEYPayload =
  fnew(result, gBoxedFreeGstMIKEYPayload)
  result.impl = gst_mikey_message_get_payload(cast[ptr MIKEYMessage00](self.impl), uint32(idx))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(gst_mikey_payload_get_type(), result.impl))

proc gst_mikey_message_insert_payload(self: ptr MIKEYMessage00; idx: uint32;
    payload: ptr MIKEYPayload00): gboolean {.
    importc, libprag.}

proc insertPayload*(self: MIKEYMessage; idx: int; payload: MIKEYPayload): bool =
  toBool(gst_mikey_message_insert_payload(cast[ptr MIKEYMessage00](self.impl), uint32(idx), cast[ptr MIKEYPayload00](g_boxed_copy(gst_mikey_payload_get_type(), payload.impl))))

proc gst_mikey_message_replace_payload(self: ptr MIKEYMessage00; idx: uint32;
    payload: ptr MIKEYPayload00): gboolean {.
    importc, libprag.}

proc replacePayload*(self: MIKEYMessage; idx: int; payload: MIKEYPayload): bool =
  toBool(gst_mikey_message_replace_payload(cast[ptr MIKEYMessage00](self.impl), uint32(idx), cast[ptr MIKEYPayload00](g_boxed_copy(gst_mikey_payload_get_type(), payload.impl))))

type
  MIKEYPayloadSPParam00* {.pure.} = object
  MIKEYPayloadSPParam* = ref object
    impl*: ptr MIKEYPayloadSPParam00
    ignoreFinalizer*: bool

proc gst_mikey_payload_sp_get_param(self: ptr MIKEYPayload00; idx: uint32): ptr MIKEYPayloadSPParam00 {.
    importc, libprag.}

proc spGetParam*(self: MIKEYPayload; idx: int): MIKEYPayloadSPParam =
  new(result)
  result.impl = gst_mikey_payload_sp_get_param(cast[ptr MIKEYPayload00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

type
  MIKEYSecProto* {.size: sizeof(cint), pure.} = enum
    mikeySecProtoSrtp = 0

proc gst_mikey_payload_sp_set(self: ptr MIKEYPayload00; policy: uint32; proto: MIKEYSecProto): gboolean {.
    importc, libprag.}

proc spSet*(self: MIKEYPayload; policy: int; proto: MIKEYSecProto): bool =
  toBool(gst_mikey_payload_sp_set(cast[ptr MIKEYPayload00](self.impl), uint32(policy), proto))

type
  MIKEYType* {.size: sizeof(cint), pure.} = enum
    invalid = -1
    pskInit = 0
    pskVerify = 1
    pkInit = 2
    pkVerify = 3
    dhInit = 4
    dhResp = 5
    error = 6

type
  MIKEYPRFFunc* {.size: sizeof(cint), pure.} = enum
    mikeyPrfMikey_1 = 0

proc gst_mikey_message_set_info(self: ptr MIKEYMessage00; version: uint8;
    `type`: MIKEYType; V: gboolean; prfFunc: MIKEYPRFFunc; CSB_id: uint32;
    mapType: MIKEYMapType): gboolean {.
    importc, libprag.}

proc setInfo*(self: MIKEYMessage; version: uint8; `type`: MIKEYType;
    V: bool; prfFunc: MIKEYPRFFunc; CSB_id: int; mapType: MIKEYMapType): bool =
  toBool(gst_mikey_message_set_info(cast[ptr MIKEYMessage00](self.impl), version, `type`, gboolean(V), prfFunc, uint32(CSB_id), mapType))

type
  MIKEYPayloadKEMAC* {.pure, byRef.} = object
    pt*: MIKEYPayload00
    encAlg*: MIKEYEncAlg
    macAlg*: MIKEYMacAlg
    subpayloads*: ptr GArray00

type
  MIKEYPayloadKeyData* {.pure, byRef.} = object
    pt*: MIKEYPayload00
    keyType*: MIKEYKeyDataType
    keyLen*: uint16
    keyData*: ptr uint8
    saltLen*: uint16
    saltData*: ptr uint8
    kvType*: MIKEYKVType
    kvLen*: array[2, uint8]
    kvData*: array[2, ptr uint8]

type
  MIKEYPayloadPKE* {.pure, byRef.} = object
    pt*: MIKEYPayload00
    C*: MIKEYCacheType
    dataLen*: uint16
    data*: ptr uint8

type
  MIKEYPayloadRAND* {.pure, byRef.} = object
    pt*: MIKEYPayload00
    len*: uint8
    rand*: ptr uint8

type
  MIKEYPayloadSP* {.pure, byRef.} = object
    pt*: MIKEYPayload00
    policy*: uint32
    proto*: MIKEYSecProto
    params*: ptr GArray00

type
  MIKEYPayloadT00* {.pure.} = object
  MIKEYPayloadT* = ref object
    impl*: ptr MIKEYPayloadT00
    ignoreFinalizer*: bool

type
  MIKEYSecSRTP* {.size: sizeof(cint), pure.} = enum
    encAlg = 0
    encKeyLen = 1
    authAlg = 2
    authKeyLen = 3
    saltKeyLen = 4
    prf = 5
    keyDerivRate = 6
    srtpEnc = 7
    srtcpEnc = 8
    fecOrder = 9
    srtpAuth = 10
    authTagLen = 11
    srtpPrefixLen = 12
    aeadAuthTagLen = 20

const MIKEY_VERSION* = 1'i32

type
  SDPAttribute00* {.pure.} = object
  SDPAttribute* = ref object
    impl*: ptr SDPAttribute00
    ignoreFinalizer*: bool

type
  SDPResult* {.size: sizeof(cint), pure.} = enum
    einval = -1
    ok = 0

proc gst_sdp_attribute_clear(self: ptr SDPAttribute00): SDPResult {.
    importc, libprag.}

proc clear*(self: SDPAttribute): SDPResult =
  gst_sdp_attribute_clear(cast[ptr SDPAttribute00](self.impl))

proc gst_sdp_attribute_set(self: ptr SDPAttribute00; key: cstring; value: cstring): SDPResult {.
    importc, libprag.}

proc set*(self: SDPAttribute; key: cstring; value: cstring = nil): SDPResult =
  gst_sdp_attribute_set(cast[ptr SDPAttribute00](self.impl), key, value)

type
  SDPBandwidth00* {.pure.} = object
  SDPBandwidth* = ref object
    impl*: ptr SDPBandwidth00
    ignoreFinalizer*: bool

proc gst_sdp_bandwidth_clear(self: ptr SDPBandwidth00): SDPResult {.
    importc, libprag.}

proc clear*(self: SDPBandwidth): SDPResult =
  gst_sdp_bandwidth_clear(cast[ptr SDPBandwidth00](self.impl))

proc gst_sdp_bandwidth_set(self: ptr SDPBandwidth00; bwtype: cstring; bandwidth: uint32): SDPResult {.
    importc, libprag.}

proc set*(self: SDPBandwidth; bwtype: cstring; bandwidth: int): SDPResult =
  gst_sdp_bandwidth_set(cast[ptr SDPBandwidth00](self.impl), bwtype, uint32(bandwidth))

type
  SDPConnection00* {.pure.} = object
  SDPConnection* = ref object
    impl*: ptr SDPConnection00
    ignoreFinalizer*: bool

proc gst_sdp_connection_clear(self: ptr SDPConnection00): SDPResult {.
    importc, libprag.}

proc clear*(self: SDPConnection): SDPResult =
  gst_sdp_connection_clear(cast[ptr SDPConnection00](self.impl))

proc gst_sdp_connection_set(self: ptr SDPConnection00; nettype: cstring;
    addrtype: cstring; address: cstring; ttl: uint32; addrNumber: uint32): SDPResult {.
    importc, libprag.}

proc set*(self: SDPConnection; nettype: cstring; addrtype: cstring;
    address: cstring; ttl: int; addrNumber: int): SDPResult =
  gst_sdp_connection_set(cast[ptr SDPConnection00](self.impl), nettype, addrtype, address, uint32(ttl), uint32(addrNumber))

type
  SDPKey00* {.pure.} = object
  SDPKey* = ref object
    impl*: ptr SDPKey00
    ignoreFinalizer*: bool

type
  SDPMedia00* {.pure.} = object
  SDPMedia* = ref object
    impl*: ptr SDPMedia00
    ignoreFinalizer*: bool

proc gst_sdp_media_free(self: ptr SDPMedia00): SDPResult {.
    importc, libprag.}

proc free*(self: SDPMedia): SDPResult =
  gst_sdp_media_free(cast[ptr SDPMedia00](self.impl))

proc finalizerfree*(self: SDPMedia) =
  if not self.ignoreFinalizer:
    discard gst_sdp_media_free(self.impl)

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SDPMedia()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      discard gst_sdp_media_free(self.impl)
      self.impl = nil

proc newWithFinalizer*(x: var SDPMedia) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, finalizerfree)

proc gst_sdp_media_add_bandwidth(self: ptr SDPMedia00; bwtype: cstring; bandwidth: uint32): SDPResult {.
    importc, libprag.}

proc addBandwidth*(self: SDPMedia; bwtype: cstring; bandwidth: int): SDPResult =
  gst_sdp_media_add_bandwidth(cast[ptr SDPMedia00](self.impl), bwtype, uint32(bandwidth))

proc gst_sdp_media_add_connection(self: ptr SDPMedia00; nettype: cstring;
    addrtype: cstring; address: cstring; ttl: uint32; addrNumber: uint32): SDPResult {.
    importc, libprag.}

proc addConnection*(self: SDPMedia; nettype: cstring; addrtype: cstring;
    address: cstring; ttl: int; addrNumber: int): SDPResult =
  gst_sdp_media_add_connection(cast[ptr SDPMedia00](self.impl), nettype, addrtype, address, uint32(ttl), uint32(addrNumber))

proc gst_sdp_media_add_format(self: ptr SDPMedia00; format: cstring): SDPResult {.
    importc, libprag.}

proc addFormat*(self: SDPMedia; format: cstring): SDPResult =
  gst_sdp_media_add_format(cast[ptr SDPMedia00](self.impl), format)

proc gst_sdp_media_as_text(self: ptr SDPMedia00): cstring {.
    importc, libprag.}

proc asText*(self: SDPMedia): string =
  let resul0 = gst_sdp_media_as_text(cast[ptr SDPMedia00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_sdp_media_attributes_len(self: ptr SDPMedia00): uint32 {.
    importc, libprag.}

proc attributesLen*(self: SDPMedia): int =
  int(gst_sdp_media_attributes_len(cast[ptr SDPMedia00](self.impl)))

proc gst_sdp_media_attributes_to_caps(self: ptr SDPMedia00; caps: ptr gst.Caps00): SDPResult {.
    importc, libprag.}

proc attributesToCaps*(self: SDPMedia; caps: gst.Caps): SDPResult =
  gst_sdp_media_attributes_to_caps(cast[ptr SDPMedia00](self.impl), cast[ptr gst.Caps00](caps.impl))

proc gst_sdp_media_bandwidths_len(self: ptr SDPMedia00): uint32 {.
    importc, libprag.}

proc bandwidthsLen*(self: SDPMedia): int =
  int(gst_sdp_media_bandwidths_len(cast[ptr SDPMedia00](self.impl)))

proc gst_sdp_media_connections_len(self: ptr SDPMedia00): uint32 {.
    importc, libprag.}

proc connectionsLen*(self: SDPMedia): int =
  int(gst_sdp_media_connections_len(cast[ptr SDPMedia00](self.impl)))

proc gst_sdp_media_copy(self: ptr SDPMedia00; copy: var ptr SDPMedia00): SDPResult {.
    importc, libprag.}

proc copy*(self: SDPMedia; copy: var SDPMedia): SDPResult =
  fnew(copy, finalizerfree)
  gst_sdp_media_copy(cast[ptr SDPMedia00](self.impl), cast[var ptr SDPMedia00](addr copy.impl))

proc gst_sdp_media_formats_len(self: ptr SDPMedia00): uint32 {.
    importc, libprag.}

proc formatsLen*(self: SDPMedia): int =
  int(gst_sdp_media_formats_len(cast[ptr SDPMedia00](self.impl)))

proc gst_sdp_media_add_attribute(self: ptr SDPMedia00; key: cstring; value: cstring): SDPResult {.
    importc, libprag.}

proc addAttribute*(self: SDPMedia; key: cstring; value: cstring = nil): SDPResult =
  gst_sdp_media_add_attribute(cast[ptr SDPMedia00](self.impl), key, value)

proc gst_sdp_media_get_attribute(self: ptr SDPMedia00; idx: uint32): ptr SDPAttribute00 {.
    importc, libprag.}

proc getAttribute*(self: SDPMedia; idx: int): SDPAttribute =
  new(result)
  result.impl = gst_sdp_media_get_attribute(cast[ptr SDPMedia00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_media_get_attribute_val(self: ptr SDPMedia00; key: cstring): cstring {.
    importc, libprag.}

proc getAttributeVal*(self: SDPMedia; key: cstring): string =
  result = $gst_sdp_media_get_attribute_val(cast[ptr SDPMedia00](self.impl), key)

proc gst_sdp_media_get_attribute_val_n(self: ptr SDPMedia00; key: cstring;
    nth: uint32): cstring {.
    importc, libprag.}

proc getAttributeValN*(self: SDPMedia; key: cstring; nth: int): string =
  result = $gst_sdp_media_get_attribute_val_n(cast[ptr SDPMedia00](self.impl), key, uint32(nth))

proc gst_sdp_media_get_bandwidth(self: ptr SDPMedia00; idx: uint32): ptr SDPBandwidth00 {.
    importc, libprag.}

proc getBandwidth*(self: SDPMedia; idx: int): SDPBandwidth =
  new(result)
  result.impl = gst_sdp_media_get_bandwidth(cast[ptr SDPMedia00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_media_get_caps_from_media(self: ptr SDPMedia00; pt: int32): ptr gst.Caps00 {.
    importc, libprag.}

proc getCapsFromMedia*(self: SDPMedia; pt: int): gst.Caps =
  fnew(result, gBoxedFreeGstCaps)
  result.impl = gst_sdp_media_get_caps_from_media(cast[ptr SDPMedia00](self.impl), int32(pt))

proc gst_sdp_media_get_connection(self: ptr SDPMedia00; idx: uint32): ptr SDPConnection00 {.
    importc, libprag.}

proc getConnection*(self: SDPMedia; idx: int): SDPConnection =
  new(result)
  result.impl = gst_sdp_media_get_connection(cast[ptr SDPMedia00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_media_get_format(self: ptr SDPMedia00; idx: uint32): cstring {.
    importc, libprag.}

proc getFormat*(self: SDPMedia; idx: int): string =
  result = $gst_sdp_media_get_format(cast[ptr SDPMedia00](self.impl), uint32(idx))

proc gst_sdp_media_get_information(self: ptr SDPMedia00): cstring {.
    importc, libprag.}

proc getInformation*(self: SDPMedia): string =
  result = $gst_sdp_media_get_information(cast[ptr SDPMedia00](self.impl))

proc information*(self: SDPMedia): string =
  result = $gst_sdp_media_get_information(cast[ptr SDPMedia00](self.impl))

proc gst_sdp_media_get_key(self: ptr SDPMedia00): ptr SDPKey00 {.
    importc, libprag.}

proc getKey*(self: SDPMedia): SDPKey =
  new(result)
  result.impl = gst_sdp_media_get_key(cast[ptr SDPMedia00](self.impl))
  result.ignoreFinalizer = true

proc key*(self: SDPMedia): SDPKey =
  new(result)
  result.impl = gst_sdp_media_get_key(cast[ptr SDPMedia00](self.impl))
  result.ignoreFinalizer = true

proc gst_sdp_media_get_media(self: ptr SDPMedia00): cstring {.
    importc, libprag.}

proc getMedia*(self: SDPMedia): string =
  result = $gst_sdp_media_get_media(cast[ptr SDPMedia00](self.impl))

proc media*(self: SDPMedia): string =
  result = $gst_sdp_media_get_media(cast[ptr SDPMedia00](self.impl))

proc gst_sdp_media_get_num_ports(self: ptr SDPMedia00): uint32 {.
    importc, libprag.}

proc getNumPorts*(self: SDPMedia): int =
  int(gst_sdp_media_get_num_ports(cast[ptr SDPMedia00](self.impl)))

proc numPorts*(self: SDPMedia): int =
  int(gst_sdp_media_get_num_ports(cast[ptr SDPMedia00](self.impl)))

proc gst_sdp_media_get_port(self: ptr SDPMedia00): uint32 {.
    importc, libprag.}

proc getPort*(self: SDPMedia): int =
  int(gst_sdp_media_get_port(cast[ptr SDPMedia00](self.impl)))

proc port*(self: SDPMedia): int =
  int(gst_sdp_media_get_port(cast[ptr SDPMedia00](self.impl)))

proc gst_sdp_media_get_proto(self: ptr SDPMedia00): cstring {.
    importc, libprag.}

proc getProto*(self: SDPMedia): string =
  result = $gst_sdp_media_get_proto(cast[ptr SDPMedia00](self.impl))

proc proto*(self: SDPMedia): string =
  result = $gst_sdp_media_get_proto(cast[ptr SDPMedia00](self.impl))

proc gst_sdp_media_init(self: ptr SDPMedia00): SDPResult {.
    importc, libprag.}

proc init*(self: SDPMedia): SDPResult =
  gst_sdp_media_init(cast[ptr SDPMedia00](self.impl))

proc gst_sdp_media_insert_attribute(self: ptr SDPMedia00; idx: int32; attr: ptr SDPAttribute00): SDPResult {.
    importc, libprag.}

proc insertAttribute*(self: SDPMedia; idx: int; attr: SDPAttribute): SDPResult =
  gst_sdp_media_insert_attribute(cast[ptr SDPMedia00](self.impl), int32(idx), cast[ptr SDPAttribute00](attr.impl))

proc gst_sdp_media_insert_bandwidth(self: ptr SDPMedia00; idx: int32; bw: ptr SDPBandwidth00): SDPResult {.
    importc, libprag.}

proc insertBandwidth*(self: SDPMedia; idx: int; bw: SDPBandwidth): SDPResult =
  gst_sdp_media_insert_bandwidth(cast[ptr SDPMedia00](self.impl), int32(idx), cast[ptr SDPBandwidth00](bw.impl))

proc gst_sdp_media_insert_connection(self: ptr SDPMedia00; idx: int32; conn: ptr SDPConnection00): SDPResult {.
    importc, libprag.}

proc insertConnection*(self: SDPMedia; idx: int; conn: SDPConnection): SDPResult =
  gst_sdp_media_insert_connection(cast[ptr SDPMedia00](self.impl), int32(idx), cast[ptr SDPConnection00](conn.impl))

proc gst_sdp_media_insert_format(self: ptr SDPMedia00; idx: int32; format: cstring): SDPResult {.
    importc, libprag.}

proc insertFormat*(self: SDPMedia; idx: int; format: cstring): SDPResult =
  gst_sdp_media_insert_format(cast[ptr SDPMedia00](self.impl), int32(idx), format)

proc gst_sdp_media_parse_keymgmt(self: ptr SDPMedia00; mikey: var ptr MIKEYMessage00): SDPResult {.
    importc, libprag.}

proc parseKeymgmt*(self: SDPMedia; mikey: var MIKEYMessage): SDPResult =
  fnew(mikey, gBoxedFreeGstMIKEYMessage)
  gst_sdp_media_parse_keymgmt(cast[ptr SDPMedia00](self.impl), cast[var ptr MIKEYMessage00](addr mikey.impl))

proc gst_sdp_media_remove_attribute(self: ptr SDPMedia00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeAttribute*(self: SDPMedia; idx: int): SDPResult =
  gst_sdp_media_remove_attribute(cast[ptr SDPMedia00](self.impl), uint32(idx))

proc gst_sdp_media_remove_bandwidth(self: ptr SDPMedia00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeBandwidth*(self: SDPMedia; idx: int): SDPResult =
  gst_sdp_media_remove_bandwidth(cast[ptr SDPMedia00](self.impl), uint32(idx))

proc gst_sdp_media_remove_connection(self: ptr SDPMedia00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeConnection*(self: SDPMedia; idx: int): SDPResult =
  gst_sdp_media_remove_connection(cast[ptr SDPMedia00](self.impl), uint32(idx))

proc gst_sdp_media_remove_format(self: ptr SDPMedia00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeFormat*(self: SDPMedia; idx: int): SDPResult =
  gst_sdp_media_remove_format(cast[ptr SDPMedia00](self.impl), uint32(idx))

proc gst_sdp_media_replace_attribute(self: ptr SDPMedia00; idx: uint32; attr: ptr SDPAttribute00): SDPResult {.
    importc, libprag.}

proc replaceAttribute*(self: SDPMedia; idx: int; attr: SDPAttribute): SDPResult =
  gst_sdp_media_replace_attribute(cast[ptr SDPMedia00](self.impl), uint32(idx), cast[ptr SDPAttribute00](attr.impl))

proc gst_sdp_media_replace_bandwidth(self: ptr SDPMedia00; idx: uint32; bw: ptr SDPBandwidth00): SDPResult {.
    importc, libprag.}

proc replaceBandwidth*(self: SDPMedia; idx: int; bw: SDPBandwidth): SDPResult =
  gst_sdp_media_replace_bandwidth(cast[ptr SDPMedia00](self.impl), uint32(idx), cast[ptr SDPBandwidth00](bw.impl))

proc gst_sdp_media_replace_connection(self: ptr SDPMedia00; idx: uint32;
    conn: ptr SDPConnection00): SDPResult {.
    importc, libprag.}

proc replaceConnection*(self: SDPMedia; idx: int; conn: SDPConnection): SDPResult =
  gst_sdp_media_replace_connection(cast[ptr SDPMedia00](self.impl), uint32(idx), cast[ptr SDPConnection00](conn.impl))

proc gst_sdp_media_replace_format(self: ptr SDPMedia00; idx: uint32; format: cstring): SDPResult {.
    importc, libprag.}

proc replaceFormat*(self: SDPMedia; idx: int; format: cstring): SDPResult =
  gst_sdp_media_replace_format(cast[ptr SDPMedia00](self.impl), uint32(idx), format)

proc gst_sdp_media_set_information(self: ptr SDPMedia00; information: cstring): SDPResult {.
    importc, libprag.}

proc setInformation*(self: SDPMedia; information: cstring): SDPResult =
  gst_sdp_media_set_information(cast[ptr SDPMedia00](self.impl), information)

proc gst_sdp_media_set_key(self: ptr SDPMedia00; `type`: cstring; data: cstring): SDPResult {.
    importc, libprag.}

proc setKey*(self: SDPMedia; `type`: cstring; data: cstring): SDPResult =
  gst_sdp_media_set_key(cast[ptr SDPMedia00](self.impl), `type`, data)

proc gst_sdp_media_set_media(self: ptr SDPMedia00; med: cstring): SDPResult {.
    importc, libprag.}

proc setMedia*(self: SDPMedia; med: cstring): SDPResult =
  gst_sdp_media_set_media(cast[ptr SDPMedia00](self.impl), med)

proc gst_sdp_media_set_port_info(self: ptr SDPMedia00; port: uint32; numPorts: uint32): SDPResult {.
    importc, libprag.}

proc setPortInfo*(self: SDPMedia; port: int; numPorts: int): SDPResult =
  gst_sdp_media_set_port_info(cast[ptr SDPMedia00](self.impl), uint32(port), uint32(numPorts))

proc gst_sdp_media_set_proto(self: ptr SDPMedia00; proto: cstring): SDPResult {.
    importc, libprag.}

proc setProto*(self: SDPMedia; proto: cstring): SDPResult =
  gst_sdp_media_set_proto(cast[ptr SDPMedia00](self.impl), proto)

proc gst_sdp_media_uninit(self: ptr SDPMedia00): SDPResult {.
    importc, libprag.}

proc uninit*(self: SDPMedia): SDPResult =
  gst_sdp_media_uninit(cast[ptr SDPMedia00](self.impl))

proc gst_sdp_media_new(media: var ptr SDPMedia00): SDPResult {.
    importc, libprag.}

proc new*(media: var SDPMedia): SDPResult =
  fnew(media, finalizerfree)
  gst_sdp_media_new(cast[var ptr SDPMedia00](addr media.impl))

proc gst_sdp_media_set_media_from_caps(caps: ptr gst.Caps00; media: ptr SDPMedia00): SDPResult {.
    importc, libprag.}

proc setMediaFromCaps*(caps: gst.Caps; media: SDPMedia): SDPResult =
  gst_sdp_media_set_media_from_caps(cast[ptr gst.Caps00](caps.impl), cast[ptr SDPMedia00](media.impl))

type
  SDPMessage00* {.pure.} = object
  SDPMessage* = ref object
    impl*: ptr SDPMessage00
    ignoreFinalizer*: bool

proc gst_sdp_message_get_type*(): GType {.importc, libprag.}

proc gBoxedFreeGstSDPMessage*(self: SDPMessage) =
  if not self.ignoreFinalizer:
    boxedFree(gst_sdp_message_get_type(), cast[ptr SDPMessage00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(SDPMessage()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(gst_sdp_message_get_type(), cast[ptr SDPMessage00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var SDPMessage) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreeGstSDPMessage)

proc gst_sdp_message_free(self: ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc free*(self: SDPMessage): SDPResult =
  gst_sdp_message_free(cast[ptr SDPMessage00](self.impl))

proc finalizerfree*(self: SDPMessage) =
  if not self.ignoreFinalizer:
    discard gst_sdp_message_free(self.impl)

proc gst_sdp_message_add_bandwidth(self: ptr SDPMessage00; bwtype: cstring;
    bandwidth: uint32): SDPResult {.
    importc, libprag.}

proc addBandwidth*(self: SDPMessage; bwtype: cstring; bandwidth: int): SDPResult =
  gst_sdp_message_add_bandwidth(cast[ptr SDPMessage00](self.impl), bwtype, uint32(bandwidth))

proc gst_sdp_message_add_email(self: ptr SDPMessage00; email: cstring): SDPResult {.
    importc, libprag.}

proc addEmail*(self: SDPMessage; email: cstring): SDPResult =
  gst_sdp_message_add_email(cast[ptr SDPMessage00](self.impl), email)

proc gst_sdp_message_add_media(self: ptr SDPMessage00; media: ptr SDPMedia00): SDPResult {.
    importc, libprag.}

proc addMedia*(self: SDPMessage; media: SDPMedia): SDPResult =
  gst_sdp_message_add_media(cast[ptr SDPMessage00](self.impl), cast[ptr SDPMedia00](media.impl))

proc gst_sdp_message_add_phone(self: ptr SDPMessage00; phone: cstring): SDPResult {.
    importc, libprag.}

proc addPhone*(self: SDPMessage; phone: cstring): SDPResult =
  gst_sdp_message_add_phone(cast[ptr SDPMessage00](self.impl), phone)

proc gst_sdp_message_add_time(self: ptr SDPMessage00; start: cstring; stop: cstring;
    repeat: ptr cstring): SDPResult {.
    importc, libprag.}

proc addTime*(self: SDPMessage; start: cstring; stop: cstring;
    repeat: varargs[string, `$`]): SDPResult =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gst_sdp_message_add_time(cast[ptr SDPMessage00](self.impl), start, stop, seq2CstringArray(repeat, fs469n23))

proc gst_sdp_message_add_zone(self: ptr SDPMessage00; adjTime: cstring; typedTime: cstring): SDPResult {.
    importc, libprag.}

proc addZone*(self: SDPMessage; adjTime: cstring; typedTime: cstring): SDPResult =
  gst_sdp_message_add_zone(cast[ptr SDPMessage00](self.impl), adjTime, typedTime)

proc gst_sdp_message_as_text(self: ptr SDPMessage00): cstring {.
    importc, libprag.}

proc asText*(self: SDPMessage): string =
  let resul0 = gst_sdp_message_as_text(cast[ptr SDPMessage00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gst_sdp_message_attributes_len(self: ptr SDPMessage00): uint32 {.
    importc, libprag.}

proc attributesLen*(self: SDPMessage): int =
  int(gst_sdp_message_attributes_len(cast[ptr SDPMessage00](self.impl)))

proc gst_sdp_message_attributes_to_caps(self: ptr SDPMessage00; caps: ptr gst.Caps00): SDPResult {.
    importc, libprag.}

proc attributesToCaps*(self: SDPMessage; caps: gst.Caps): SDPResult =
  gst_sdp_message_attributes_to_caps(cast[ptr SDPMessage00](self.impl), cast[ptr gst.Caps00](caps.impl))

proc gst_sdp_message_bandwidths_len(self: ptr SDPMessage00): uint32 {.
    importc, libprag.}

proc bandwidthsLen*(self: SDPMessage): int =
  int(gst_sdp_message_bandwidths_len(cast[ptr SDPMessage00](self.impl)))

proc gst_sdp_message_copy(self: ptr SDPMessage00; copy: var ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc copy*(self: SDPMessage; copy: var SDPMessage): SDPResult =
  fnew(copy, gBoxedFreeGstSDPMessage)
  gst_sdp_message_copy(cast[ptr SDPMessage00](self.impl), cast[var ptr SDPMessage00](addr copy.impl))

proc gst_sdp_message_dump(self: ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc dump*(self: SDPMessage): SDPResult =
  gst_sdp_message_dump(cast[ptr SDPMessage00](self.impl))

proc gst_sdp_message_emails_len(self: ptr SDPMessage00): uint32 {.
    importc, libprag.}

proc emailsLen*(self: SDPMessage): int =
  int(gst_sdp_message_emails_len(cast[ptr SDPMessage00](self.impl)))

proc gst_sdp_message_add_attribute(self: ptr SDPMessage00; key: cstring;
    value: cstring): SDPResult {.
    importc, libprag.}

proc addAttribute*(self: SDPMessage; key: cstring; value: cstring = nil): SDPResult =
  gst_sdp_message_add_attribute(cast[ptr SDPMessage00](self.impl), key, value)

proc gst_sdp_message_get_attribute(self: ptr SDPMessage00; idx: uint32): ptr SDPAttribute00 {.
    importc, libprag.}

proc getAttribute*(self: SDPMessage; idx: int): SDPAttribute =
  new(result)
  result.impl = gst_sdp_message_get_attribute(cast[ptr SDPMessage00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_message_get_attribute_val(self: ptr SDPMessage00; key: cstring): cstring {.
    importc, libprag.}

proc getAttributeVal*(self: SDPMessage; key: cstring): string =
  result = $gst_sdp_message_get_attribute_val(cast[ptr SDPMessage00](self.impl), key)

proc gst_sdp_message_get_attribute_val_n(self: ptr SDPMessage00; key: cstring;
    nth: uint32): cstring {.
    importc, libprag.}

proc getAttributeValN*(self: SDPMessage; key: cstring;
    nth: int): string =
  result = $gst_sdp_message_get_attribute_val_n(cast[ptr SDPMessage00](self.impl), key, uint32(nth))

proc gst_sdp_message_get_bandwidth(self: ptr SDPMessage00; idx: uint32): ptr SDPBandwidth00 {.
    importc, libprag.}

proc getBandwidth*(self: SDPMessage; idx: int): SDPBandwidth =
  new(result)
  result.impl = gst_sdp_message_get_bandwidth(cast[ptr SDPMessage00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_message_get_connection(self: ptr SDPMessage00): ptr SDPConnection00 {.
    importc, libprag.}

proc getConnection*(self: SDPMessage): SDPConnection =
  new(result)
  result.impl = gst_sdp_message_get_connection(cast[ptr SDPMessage00](self.impl))
  result.ignoreFinalizer = true

proc connection*(self: SDPMessage): SDPConnection =
  new(result)
  result.impl = gst_sdp_message_get_connection(cast[ptr SDPMessage00](self.impl))
  result.ignoreFinalizer = true

proc gst_sdp_message_get_email(self: ptr SDPMessage00; idx: uint32): cstring {.
    importc, libprag.}

proc getEmail*(self: SDPMessage; idx: int): string =
  result = $gst_sdp_message_get_email(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_get_information(self: ptr SDPMessage00): cstring {.
    importc, libprag.}

proc getInformation*(self: SDPMessage): string =
  result = $gst_sdp_message_get_information(cast[ptr SDPMessage00](self.impl))

proc information*(self: SDPMessage): string =
  result = $gst_sdp_message_get_information(cast[ptr SDPMessage00](self.impl))

proc gst_sdp_message_get_key(self: ptr SDPMessage00): ptr SDPKey00 {.
    importc, libprag.}

proc getKey*(self: SDPMessage): SDPKey =
  new(result)
  result.impl = gst_sdp_message_get_key(cast[ptr SDPMessage00](self.impl))
  result.ignoreFinalizer = true

proc key*(self: SDPMessage): SDPKey =
  new(result)
  result.impl = gst_sdp_message_get_key(cast[ptr SDPMessage00](self.impl))
  result.ignoreFinalizer = true

proc gst_sdp_message_get_media(self: ptr SDPMessage00; idx: uint32): ptr SDPMedia00 {.
    importc, libprag.}

proc getMedia*(self: SDPMessage; idx: int): SDPMedia =
  fnew(result, finalizerfree)
  result.impl = gst_sdp_message_get_media(cast[ptr SDPMessage00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_message_get_phone(self: ptr SDPMessage00; idx: uint32): cstring {.
    importc, libprag.}

proc getPhone*(self: SDPMessage; idx: int): string =
  result = $gst_sdp_message_get_phone(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_get_session_name(self: ptr SDPMessage00): cstring {.
    importc, libprag.}

proc getSessionName*(self: SDPMessage): string =
  result = $gst_sdp_message_get_session_name(cast[ptr SDPMessage00](self.impl))

proc sessionName*(self: SDPMessage): string =
  result = $gst_sdp_message_get_session_name(cast[ptr SDPMessage00](self.impl))

proc gst_sdp_message_get_uri(self: ptr SDPMessage00): cstring {.
    importc, libprag.}

proc getUri*(self: SDPMessage): string =
  result = $gst_sdp_message_get_uri(cast[ptr SDPMessage00](self.impl))

proc uri*(self: SDPMessage): string =
  result = $gst_sdp_message_get_uri(cast[ptr SDPMessage00](self.impl))

proc gst_sdp_message_get_version(self: ptr SDPMessage00): cstring {.
    importc, libprag.}

proc getVersion*(self: SDPMessage): string =
  result = $gst_sdp_message_get_version(cast[ptr SDPMessage00](self.impl))

proc version*(self: SDPMessage): string =
  result = $gst_sdp_message_get_version(cast[ptr SDPMessage00](self.impl))

proc gst_sdp_message_init(self: ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc init*(self: SDPMessage): SDPResult =
  gst_sdp_message_init(cast[ptr SDPMessage00](self.impl))

proc gst_sdp_message_insert_attribute(self: ptr SDPMessage00; idx: int32;
    attr: ptr SDPAttribute00): SDPResult {.
    importc, libprag.}

proc insertAttribute*(self: SDPMessage; idx: int; attr: SDPAttribute): SDPResult =
  gst_sdp_message_insert_attribute(cast[ptr SDPMessage00](self.impl), int32(idx), cast[ptr SDPAttribute00](attr.impl))

proc gst_sdp_message_insert_bandwidth(self: ptr SDPMessage00; idx: int32;
    bw: ptr SDPBandwidth00): SDPResult {.
    importc, libprag.}

proc insertBandwidth*(self: SDPMessage; idx: int; bw: SDPBandwidth): SDPResult =
  gst_sdp_message_insert_bandwidth(cast[ptr SDPMessage00](self.impl), int32(idx), cast[ptr SDPBandwidth00](bw.impl))

proc gst_sdp_message_insert_email(self: ptr SDPMessage00; idx: int32; email: cstring): SDPResult {.
    importc, libprag.}

proc insertEmail*(self: SDPMessage; idx: int; email: cstring): SDPResult =
  gst_sdp_message_insert_email(cast[ptr SDPMessage00](self.impl), int32(idx), email)

proc gst_sdp_message_insert_phone(self: ptr SDPMessage00; idx: int32; phone: cstring): SDPResult {.
    importc, libprag.}

proc insertPhone*(self: SDPMessage; idx: int; phone: cstring): SDPResult =
  gst_sdp_message_insert_phone(cast[ptr SDPMessage00](self.impl), int32(idx), phone)

proc gst_sdp_message_medias_len(self: ptr SDPMessage00): uint32 {.
    importc, libprag.}

proc mediasLen*(self: SDPMessage): int =
  int(gst_sdp_message_medias_len(cast[ptr SDPMessage00](self.impl)))

proc gst_sdp_message_parse_keymgmt(self: ptr SDPMessage00; mikey: var ptr MIKEYMessage00): SDPResult {.
    importc, libprag.}

proc parseKeymgmt*(self: SDPMessage; mikey: var MIKEYMessage): SDPResult =
  fnew(mikey, gBoxedFreeGstMIKEYMessage)
  gst_sdp_message_parse_keymgmt(cast[ptr SDPMessage00](self.impl), cast[var ptr MIKEYMessage00](addr mikey.impl))

proc gst_sdp_message_phones_len(self: ptr SDPMessage00): uint32 {.
    importc, libprag.}

proc phonesLen*(self: SDPMessage): int =
  int(gst_sdp_message_phones_len(cast[ptr SDPMessage00](self.impl)))

proc gst_sdp_message_remove_attribute(self: ptr SDPMessage00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeAttribute*(self: SDPMessage; idx: int): SDPResult =
  gst_sdp_message_remove_attribute(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_remove_bandwidth(self: ptr SDPMessage00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeBandwidth*(self: SDPMessage; idx: int): SDPResult =
  gst_sdp_message_remove_bandwidth(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_remove_email(self: ptr SDPMessage00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeEmail*(self: SDPMessage; idx: int): SDPResult =
  gst_sdp_message_remove_email(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_remove_phone(self: ptr SDPMessage00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removePhone*(self: SDPMessage; idx: int): SDPResult =
  gst_sdp_message_remove_phone(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_remove_time(self: ptr SDPMessage00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeTime*(self: SDPMessage; idx: int): SDPResult =
  gst_sdp_message_remove_time(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_remove_zone(self: ptr SDPMessage00; idx: uint32): SDPResult {.
    importc, libprag.}

proc removeZone*(self: SDPMessage; idx: int): SDPResult =
  gst_sdp_message_remove_zone(cast[ptr SDPMessage00](self.impl), uint32(idx))

proc gst_sdp_message_replace_attribute(self: ptr SDPMessage00; idx: uint32;
    attr: ptr SDPAttribute00): SDPResult {.
    importc, libprag.}

proc replaceAttribute*(self: SDPMessage; idx: int; attr: SDPAttribute): SDPResult =
  gst_sdp_message_replace_attribute(cast[ptr SDPMessage00](self.impl), uint32(idx), cast[ptr SDPAttribute00](attr.impl))

proc gst_sdp_message_replace_bandwidth(self: ptr SDPMessage00; idx: uint32;
    bw: ptr SDPBandwidth00): SDPResult {.
    importc, libprag.}

proc replaceBandwidth*(self: SDPMessage; idx: int; bw: SDPBandwidth): SDPResult =
  gst_sdp_message_replace_bandwidth(cast[ptr SDPMessage00](self.impl), uint32(idx), cast[ptr SDPBandwidth00](bw.impl))

proc gst_sdp_message_replace_email(self: ptr SDPMessage00; idx: uint32; email: cstring): SDPResult {.
    importc, libprag.}

proc replaceEmail*(self: SDPMessage; idx: int; email: cstring): SDPResult =
  gst_sdp_message_replace_email(cast[ptr SDPMessage00](self.impl), uint32(idx), email)

proc gst_sdp_message_replace_phone(self: ptr SDPMessage00; idx: uint32; phone: cstring): SDPResult {.
    importc, libprag.}

proc replacePhone*(self: SDPMessage; idx: int; phone: cstring): SDPResult =
  gst_sdp_message_replace_phone(cast[ptr SDPMessage00](self.impl), uint32(idx), phone)

proc gst_sdp_message_set_connection(self: ptr SDPMessage00; nettype: cstring;
    addrtype: cstring; address: cstring; ttl: uint32; addrNumber: uint32): SDPResult {.
    importc, libprag.}

proc setConnection*(self: SDPMessage; nettype: cstring; addrtype: cstring;
    address: cstring; ttl: int; addrNumber: int): SDPResult =
  gst_sdp_message_set_connection(cast[ptr SDPMessage00](self.impl), nettype, addrtype, address, uint32(ttl), uint32(addrNumber))

proc gst_sdp_message_set_information(self: ptr SDPMessage00; information: cstring): SDPResult {.
    importc, libprag.}

proc setInformation*(self: SDPMessage; information: cstring): SDPResult =
  gst_sdp_message_set_information(cast[ptr SDPMessage00](self.impl), information)

proc gst_sdp_message_set_key(self: ptr SDPMessage00; `type`: cstring; data: cstring): SDPResult {.
    importc, libprag.}

proc setKey*(self: SDPMessage; `type`: cstring; data: cstring): SDPResult =
  gst_sdp_message_set_key(cast[ptr SDPMessage00](self.impl), `type`, data)

proc gst_sdp_message_set_origin(self: ptr SDPMessage00; username: cstring;
    sessId: cstring; sessVersion: cstring; nettype: cstring; addrtype: cstring;
    `addr`: cstring): SDPResult {.
    importc, libprag.}

proc setOrigin*(self: SDPMessage; username: cstring; sessId: cstring;
    sessVersion: cstring; nettype: cstring; addrtype: cstring; `addr`: cstring): SDPResult =
  gst_sdp_message_set_origin(cast[ptr SDPMessage00](self.impl), username, sessId, sessVersion, nettype, addrtype, `addr`)

proc gst_sdp_message_set_session_name(self: ptr SDPMessage00; sessionName: cstring): SDPResult {.
    importc, libprag.}

proc setSessionName*(self: SDPMessage; sessionName: cstring): SDPResult =
  gst_sdp_message_set_session_name(cast[ptr SDPMessage00](self.impl), sessionName)

proc gst_sdp_message_set_uri(self: ptr SDPMessage00; uri: cstring): SDPResult {.
    importc, libprag.}

proc setUri*(self: SDPMessage; uri: cstring): SDPResult =
  gst_sdp_message_set_uri(cast[ptr SDPMessage00](self.impl), uri)

proc gst_sdp_message_set_version(self: ptr SDPMessage00; version: cstring): SDPResult {.
    importc, libprag.}

proc setVersion*(self: SDPMessage; version: cstring): SDPResult =
  gst_sdp_message_set_version(cast[ptr SDPMessage00](self.impl), version)

proc gst_sdp_message_times_len(self: ptr SDPMessage00): uint32 {.
    importc, libprag.}

proc timesLen*(self: SDPMessage): int =
  int(gst_sdp_message_times_len(cast[ptr SDPMessage00](self.impl)))

proc gst_sdp_message_uninit(self: ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc uninit*(self: SDPMessage): SDPResult =
  gst_sdp_message_uninit(cast[ptr SDPMessage00](self.impl))

proc gst_sdp_message_zones_len(self: ptr SDPMessage00): uint32 {.
    importc, libprag.}

proc zonesLen*(self: SDPMessage): int =
  int(gst_sdp_message_zones_len(cast[ptr SDPMessage00](self.impl)))

proc gst_sdp_message_as_uri(scheme: cstring; msg: ptr SDPMessage00): cstring {.
    importc, libprag.}

proc asUri*(scheme: cstring; msg: SDPMessage): string =
  let resul0 = gst_sdp_message_as_uri(scheme, cast[ptr SDPMessage00](msg.impl))
  result = $resul0
  cogfree(resul0)

proc gst_sdp_message_new(msg: var ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc new*(msg: var SDPMessage): SDPResult =
  fnew(msg, gBoxedFreeGstSDPMessage)
  gst_sdp_message_new(cast[var ptr SDPMessage00](addr msg.impl))

proc gst_sdp_message_new_from_text(text: cstring; msg: var ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc newFromText*(text: cstring; msg: var SDPMessage): SDPResult =
  fnew(msg, gBoxedFreeGstSDPMessage)
  gst_sdp_message_new_from_text(text, cast[var ptr SDPMessage00](addr msg.impl))

proc gst_sdp_message_parse_buffer(data: ptr uint8; size: uint32; msg: ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc parseBuffer*(data: seq[uint8] | string; msg: SDPMessage): SDPResult =
  let size = int(data.len)
  gst_sdp_message_parse_buffer(cast[ptr uint8](unsafeaddr(data[0])), uint32(size), cast[ptr SDPMessage00](msg.impl))

proc gst_sdp_message_parse_uri(uri: cstring; msg: ptr SDPMessage00): SDPResult {.
    importc, libprag.}

proc parseUri*(uri: cstring; msg: SDPMessage): SDPResult =
  gst_sdp_message_parse_uri(uri, cast[ptr SDPMessage00](msg.impl))

type
  SDPOrigin00* {.pure.} = object
  SDPOrigin* = ref object
    impl*: ptr SDPOrigin00
    ignoreFinalizer*: bool

proc gst_sdp_message_get_origin(self: ptr SDPMessage00): ptr SDPOrigin00 {.
    importc, libprag.}

proc getOrigin*(self: SDPMessage): SDPOrigin =
  new(result)
  result.impl = gst_sdp_message_get_origin(cast[ptr SDPMessage00](self.impl))
  result.ignoreFinalizer = true

proc origin*(self: SDPMessage): SDPOrigin =
  new(result)
  result.impl = gst_sdp_message_get_origin(cast[ptr SDPMessage00](self.impl))
  result.ignoreFinalizer = true

type
  SDPTime00* {.pure.} = object
  SDPTime* = ref object
    impl*: ptr SDPTime00
    ignoreFinalizer*: bool

proc gst_sdp_time_clear(self: ptr SDPTime00): SDPResult {.
    importc, libprag.}

proc clear*(self: SDPTime): SDPResult =
  gst_sdp_time_clear(cast[ptr SDPTime00](self.impl))

proc gst_sdp_time_set(self: ptr SDPTime00; start: cstring; stop: cstring;
    repeat: ptr cstring): SDPResult {.
    importc, libprag.}

proc set*(self: SDPTime; start: cstring; stop: cstring; repeat: varargs[string, `$`]): SDPResult =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  gst_sdp_time_set(cast[ptr SDPTime00](self.impl), start, stop, seq2CstringArray(repeat, fs469n23))

proc gst_sdp_message_get_time(self: ptr SDPMessage00; idx: uint32): ptr SDPTime00 {.
    importc, libprag.}

proc getTime*(self: SDPMessage; idx: int): SDPTime =
  new(result)
  result.impl = gst_sdp_message_get_time(cast[ptr SDPMessage00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_message_insert_time(self: ptr SDPMessage00; idx: int32; t: ptr SDPTime00): SDPResult {.
    importc, libprag.}

proc insertTime*(self: SDPMessage; idx: int; t: SDPTime): SDPResult =
  gst_sdp_message_insert_time(cast[ptr SDPMessage00](self.impl), int32(idx), cast[ptr SDPTime00](t.impl))

proc gst_sdp_message_replace_time(self: ptr SDPMessage00; idx: uint32; t: ptr SDPTime00): SDPResult {.
    importc, libprag.}

proc replaceTime*(self: SDPMessage; idx: int; t: SDPTime): SDPResult =
  gst_sdp_message_replace_time(cast[ptr SDPMessage00](self.impl), uint32(idx), cast[ptr SDPTime00](t.impl))

type
  SDPZone00* {.pure.} = object
  SDPZone* = ref object
    impl*: ptr SDPZone00
    ignoreFinalizer*: bool

proc gst_sdp_zone_clear(self: ptr SDPZone00): SDPResult {.
    importc, libprag.}

proc clear*(self: SDPZone): SDPResult =
  gst_sdp_zone_clear(cast[ptr SDPZone00](self.impl))

proc gst_sdp_zone_set(self: ptr SDPZone00; adjTime: cstring; typedTime: cstring): SDPResult {.
    importc, libprag.}

proc set*(self: SDPZone; adjTime: cstring; typedTime: cstring): SDPResult =
  gst_sdp_zone_set(cast[ptr SDPZone00](self.impl), adjTime, typedTime)

proc gst_sdp_message_get_zone(self: ptr SDPMessage00; idx: uint32): ptr SDPZone00 {.
    importc, libprag.}

proc getZone*(self: SDPMessage; idx: int): SDPZone =
  new(result)
  result.impl = gst_sdp_message_get_zone(cast[ptr SDPMessage00](self.impl), uint32(idx))
  result.ignoreFinalizer = true

proc gst_sdp_message_insert_zone(self: ptr SDPMessage00; idx: int32; zone: ptr SDPZone00): SDPResult {.
    importc, libprag.}

proc insertZone*(self: SDPMessage; idx: int; zone: SDPZone): SDPResult =
  gst_sdp_message_insert_zone(cast[ptr SDPMessage00](self.impl), int32(idx), cast[ptr SDPZone00](zone.impl))

proc gst_sdp_message_replace_zone(self: ptr SDPMessage00; idx: uint32; zone: ptr SDPZone00): SDPResult {.
    importc, libprag.}

proc replaceZone*(self: SDPMessage; idx: int; zone: SDPZone): SDPResult =
  gst_sdp_message_replace_zone(cast[ptr SDPMessage00](self.impl), uint32(idx), cast[ptr SDPZone00](zone.impl))

const SDP_BWTYPE_AS* = "AS"

const SDP_BWTYPE_CT* = "CT"

const SDP_BWTYPE_EXT_PREFIX* = "X-"

const SDP_BWTYPE_RR* = "RR"

const SDP_BWTYPE_RS* = "RS"

const SDP_BWTYPE_TIAS* = "TIAS"

proc gst_sdp_address_is_multicast(nettype: cstring; addrtype: cstring; `addr`: cstring): gboolean {.
    importc, libprag.}

proc sdpAddressIsMulticast*(nettype: cstring; addrtype: cstring; `addr`: cstring): bool =
  toBool(gst_sdp_address_is_multicast(nettype, addrtype, `addr`))

proc gst_sdp_make_keymgmt(uri: cstring; base64: cstring): cstring {.
    importc, libprag.}

proc sdpMakeKeymgmt*(uri: cstring; base64: cstring): string =
  let resul0 = gst_sdp_make_keymgmt(uri, base64)
  result = $resul0
  cogfree(resul0)
# === remaining symbols:
