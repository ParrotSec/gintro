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
# libgsttag-1.0.so.0
{.warning[UnusedImport]: off.}
import gobject, gstbase, gst, glib, gmodule
const Lib = "libgsttag-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const TAG_ACOUSTID_FINGERPRINT* = "chromaprint-fingerprint"

const TAG_ACOUSTID_ID* = "acoustid-id"

const TAG_CAPTURING_CONTRAST* = "capturing-contrast"

const TAG_CAPTURING_DIGITAL_ZOOM_RATIO* = "capturing-digital-zoom-ratio"

const TAG_CAPTURING_EXPOSURE_COMPENSATION* = "capturing-exposure-compensation"

const TAG_CAPTURING_EXPOSURE_MODE* = "capturing-exposure-mode"

const TAG_CAPTURING_EXPOSURE_PROGRAM* = "capturing-exposure-program"

const TAG_CAPTURING_FLASH_FIRED* = "capturing-flash-fired"

const TAG_CAPTURING_FLASH_MODE* = "capturing-flash-mode"

const TAG_CAPTURING_FOCAL_LENGTH* = "capturing-focal-length"

const TAG_CAPTURING_FOCAL_LENGTH_35_MM* = "capturing-focal-length-35mm"

const TAG_CAPTURING_FOCAL_RATIO* = "capturing-focal-ratio"

const TAG_CAPTURING_GAIN_ADJUSTMENT* = "capturing-gain-adjustment"

const TAG_CAPTURING_ISO_SPEED* = "capturing-iso-speed"

const TAG_CAPTURING_METERING_MODE* = "capturing-metering-mode"

const TAG_CAPTURING_SATURATION* = "capturing-saturation"

const TAG_CAPTURING_SCENE_CAPTURE_TYPE* = "capturing-scene-capture-type"

const TAG_CAPTURING_SHARPNESS* = "capturing-sharpness"

const TAG_CAPTURING_SHUTTER_SPEED* = "capturing-shutter-speed"

const TAG_CAPTURING_SOURCE* = "capturing-source"

const TAG_CAPTURING_WHITE_BALANCE* = "capturing-white-balance"

const TAG_CDDA_CDDB_DISCID* = "discid"

const TAG_CDDA_CDDB_DISCID_FULL* = "discid-full"

const TAG_CDDA_MUSICBRAINZ_DISCID* = "musicbrainz-discid"

const TAG_CDDA_MUSICBRAINZ_DISCID_FULL* = "musicbrainz-discid-full"

const TAG_CMML_CLIP* = "cmml-clip"

const TAG_CMML_HEAD* = "cmml-head"

const TAG_CMML_STREAM* = "cmml-stream"

const TAG_ID3V2_HEADER_SIZE* = 10'i32

const TAG_IMAGE_HORIZONTAL_PPI* = "image-horizontal-ppi"

const TAG_IMAGE_VERTICAL_PPI* = "image-vertical-ppi"

const TAG_MUSICAL_KEY* = "musical-key"

const TAG_MUSICBRAINZ_ALBUMARTISTID* = "musicbrainz-albumartistid"

const TAG_MUSICBRAINZ_ALBUMID* = "musicbrainz-albumid"

const TAG_MUSICBRAINZ_ARTISTID* = "musicbrainz-artistid"

const TAG_MUSICBRAINZ_RELEASEGROUPID* = "musicbrainz-releasegroupid"

const TAG_MUSICBRAINZ_RELEASETRACKID* = "musicbrainz-releasetrackid"

const TAG_MUSICBRAINZ_TRACKID* = "musicbrainz-trackid"

const TAG_MUSICBRAINZ_TRMID* = "musicbrainz-trmid"

type
  TagDemux* = ref object of gst.Element
  TagDemux00* = object of gst.Element00

proc gst_tag_demux_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TagDemux()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  TagDemuxResult* {.size: sizeof(cint), pure.} = enum
    brokenTag = 0
    again = 1
    ok = 2

type
  TagImageType* {.size: sizeof(cint), pure.} = enum
    none = -1
    undefined = 0
    frontCover = 1
    backCover = 2
    leafletPage = 3
    medium = 4
    leadArtist = 5
    artist = 6
    conductor = 7
    bandOrchestra = 8
    composer = 9
    lyricist = 10
    recordingLocation = 11
    duringRecording = 12
    duringPerformance = 13
    videoCapture = 14
    fish = 15
    illustration = 16
    bandArtistLogo = 17
    publisherStudioLogo = 18

type
  TagLicenseFlag* {.size: sizeof(cint), pure.} = enum
    permitsReproduction = 0
    permitsDistribution = 1
    permitsDerivativeWorks = 2
    permitsSharing = 3
    requiresNotice = 8
    requiresAttribution = 9
    requiresShareAlike = 10
    requiresSourceCode = 11
    requiresCopyleft = 12
    requiresLesserCopyleft = 13
    prohibitsCommercialUse = 16
    prohibitsHighIncomeNationUse = 17
    creativeCommonsLicense = 24
    freeSoftwareFoundationLicense = 25

  TagLicenseFlags* {.size: sizeof(cint).} = set[TagLicenseFlag]

type
  TagMux* = ref object of gst.Element
  TagMux00* = object of gst.Element00

proc gst_tag_mux_get_type*(): GType {.importc, libprag.}

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(TagMux()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    g_object_set_qdata(self.impl, Quark, nil)
    if not self.ignoreFinalizer and self.impl != nil:
      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))
      self.impl = nil

type
  TagXmpWriter00* = object of gobject.Object00
  TagXmpWriter* = ref object of gobject.Object

proc gst_tag_xmp_writer_add_all_schemas(self: ptr TagXmpWriter00) {.
    importc, libprag.}

proc addAllSchemas*(self: TagXmpWriter) =
  gst_tag_xmp_writer_add_all_schemas(cast[ptr TagXmpWriter00](self.impl))

proc gst_tag_xmp_writer_add_schema(self: ptr TagXmpWriter00; schema: cstring) {.
    importc, libprag.}

proc addSchema*(self: TagXmpWriter; schema: cstring) =
  gst_tag_xmp_writer_add_schema(cast[ptr TagXmpWriter00](self.impl), schema)

proc gst_tag_xmp_writer_has_schema(self: ptr TagXmpWriter00; schema: cstring): gboolean {.
    importc, libprag.}

proc hasSchema*(self: TagXmpWriter; schema: cstring): bool =
  toBool(gst_tag_xmp_writer_has_schema(cast[ptr TagXmpWriter00](self.impl), schema))

proc gst_tag_xmp_writer_remove_all_schemas(self: ptr TagXmpWriter00) {.
    importc, libprag.}

proc removeAllSchemas*(self: TagXmpWriter) =
  gst_tag_xmp_writer_remove_all_schemas(cast[ptr TagXmpWriter00](self.impl))

proc gst_tag_xmp_writer_remove_schema(self: ptr TagXmpWriter00; schema: cstring) {.
    importc, libprag.}

proc removeSchema*(self: TagXmpWriter; schema: cstring) =
  gst_tag_xmp_writer_remove_schema(cast[ptr TagXmpWriter00](self.impl), schema)

proc gst_tag_xmp_writer_tag_list_to_xmp_buffer(self: ptr TagXmpWriter00;
    taglist: ptr gst.TagList00; readOnly: gboolean): ptr gst.Buffer00 {.
    importc, libprag.}

proc tagListToXmpBuffer*(self: TagXmpWriter; taglist: gst.TagList;
    readOnly: bool): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_tag_xmp_writer_tag_list_to_xmp_buffer(cast[ptr TagXmpWriter00](self.impl), cast[ptr gst.TagList00](taglist.impl), gboolean(readOnly))

proc gst_tag_check_language_code(langCode: cstring): gboolean {.
    importc, libprag.}

proc tagCheckLanguageCode*(langCode: cstring): bool =
  toBool(gst_tag_check_language_code(langCode))

proc gst_tag_freeform_string_to_utf8(data: ptr int8; size: int32; envVars: ptr cstring): cstring {.
    importc, libprag.}

proc tagFreeformStringToUtf8*(data: ptr int8; size: int; envVars: varargs[string, `$`]): string =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  let resul0 = gst_tag_freeform_string_to_utf8(data, int32(size), seq2CstringArray(envVars, fs469n23))
  result = $resul0
  cogfree(resul0)

proc gst_tag_from_id3_tag(id3Tag: cstring): cstring {.
    importc, libprag.}

proc tagFromId3Tag*(id3Tag: cstring): string =
  result = $gst_tag_from_id3_tag(id3Tag)

proc gst_tag_from_id3_user_tag(`type`: cstring; id3UserTag: cstring): cstring {.
    importc, libprag.}

proc tagFromId3UserTag*(`type`: cstring; id3UserTag: cstring): string =
  result = $gst_tag_from_id3_user_tag(`type`, id3UserTag)

proc gst_tag_from_vorbis_tag(vorbisTag: cstring): cstring {.
    importc, libprag.}

proc tagFromVorbisTag*(vorbisTag: cstring): string =
  result = $gst_tag_from_vorbis_tag(vorbisTag)

proc gst_tag_get_id3v2_tag_size(buffer: ptr gst.Buffer00): uint32 {.
    importc, libprag.}

proc tagGetId3v2TagSize*(buffer: gst.Buffer): int =
  int(gst_tag_get_id3v2_tag_size(cast[ptr gst.Buffer00](buffer.impl)))

proc gst_tag_get_language_code_iso_639_1(langCode: cstring): cstring {.
    importc, libprag.}

proc tagGetLanguageCodeIso_639_1*(langCode: cstring): string =
  result = $gst_tag_get_language_code_iso_639_1(langCode)

proc gst_tag_get_language_code_iso_639_2B(langCode: cstring): cstring {.
    importc, libprag.}

proc tagGetLanguageCodeIso_639_2B*(langCode: cstring): string =
  result = $gst_tag_get_language_code_iso_639_2B(langCode)

proc gst_tag_get_language_code_iso_639_2T(langCode: cstring): cstring {.
    importc, libprag.}

proc tagGetLanguageCodeIso_639_2T*(langCode: cstring): string =
  result = $gst_tag_get_language_code_iso_639_2T(langCode)

proc gst_tag_get_language_codes(): ptr cstring {.
    importc, libprag.}

proc tagGetLanguageCodes*(): seq[string] =
  let resul0 = gst_tag_get_language_codes()
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_tag_get_language_name(languageCode: cstring): cstring {.
    importc, libprag.}

proc tagGetLanguageName*(languageCode: cstring): string =
  result = $gst_tag_get_language_name(languageCode)

proc gst_tag_get_license_description(licenseRef: cstring): cstring {.
    importc, libprag.}

proc tagGetLicenseDescription*(licenseRef: cstring): string =
  result = $gst_tag_get_license_description(licenseRef)

proc tagGetLicenseFlags*(licenseRef: cstring): TagLicenseFlags {.
    importc: "gst_tag_get_license_flags", libprag.}

proc gst_tag_get_license_jurisdiction(licenseRef: cstring): cstring {.
    importc, libprag.}

proc tagGetLicenseJurisdiction*(licenseRef: cstring): string =
  result = $gst_tag_get_license_jurisdiction(licenseRef)

proc gst_tag_get_license_nick(licenseRef: cstring): cstring {.
    importc, libprag.}

proc tagGetLicenseNick*(licenseRef: cstring): string =
  result = $gst_tag_get_license_nick(licenseRef)

proc gst_tag_get_license_title(licenseRef: cstring): cstring {.
    importc, libprag.}

proc tagGetLicenseTitle*(licenseRef: cstring): string =
  result = $gst_tag_get_license_title(licenseRef)

proc gst_tag_get_license_version(licenseRef: cstring): cstring {.
    importc, libprag.}

proc tagGetLicenseVersion*(licenseRef: cstring): string =
  result = $gst_tag_get_license_version(licenseRef)

proc gst_tag_get_licenses(): ptr cstring {.
    importc, libprag.}

proc tagGetLicenses*(): seq[string] =
  let resul0 = gst_tag_get_licenses()
  if resul0.isNil:
    return
  result = cstringArrayToSeq(resul0)
  g_strfreev(resul0)

proc gst_tag_id3_genre_count(): uint32 {.
    importc, libprag.}

proc tagId3GenreCount*(): int =
  int(gst_tag_id3_genre_count())

proc gst_tag_id3_genre_get(id: uint32): cstring {.
    importc, libprag.}

proc tagId3GenreGet*(id: int): string =
  result = $gst_tag_id3_genre_get(uint32(id))

proc gst_tag_image_data_to_image_sample(imageData: ptr uint8; imageDataLen: uint32;
    imageType: TagImageType): ptr gst.Sample00 {.
    importc, libprag.}

proc tagImageDataToImageSample*(imageData: seq[uint8] | string; imageType: TagImageType): gst.Sample =
  let imageDataLen = int(imageData.len)
  fnew(result, gBoxedFreeGstSample)
  result.impl = gst_tag_image_data_to_image_sample(cast[ptr uint8](unsafeaddr(imageData[0])), uint32(imageDataLen), imageType)

proc gst_tag_list_add_id3_image(tagList: ptr gst.TagList00; imageData: ptr uint8;
    imageDataLen: uint32; id3PictureType: uint32): gboolean {.
    importc, libprag.}

proc tagListAddId3Image*(tagList: gst.TagList; imageData: seq[uint8] | string;
    id3PictureType: int): bool =
  let imageDataLen = int(imageData.len)
  toBool(gst_tag_list_add_id3_image(cast[ptr gst.TagList00](tagList.impl), cast[ptr uint8](unsafeaddr(imageData[0])), uint32(imageDataLen), uint32(id3PictureType)))

proc gst_tag_list_from_exif_buffer(buffer: ptr gst.Buffer00; byteOrder: int32;
    baseOffset: uint32): ptr gst.TagList00 {.
    importc, libprag.}

proc tagListFromExifBuffer*(buffer: gst.Buffer; byteOrder: int; baseOffset: int): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_from_exif_buffer(cast[ptr gst.Buffer00](buffer.impl), int32(byteOrder), uint32(baseOffset))

proc gst_tag_list_from_exif_buffer_with_tiff_header(buffer: ptr gst.Buffer00): ptr gst.TagList00 {.
    importc, libprag.}

proc tagListFromExifBufferWithTiffHeader*(buffer: gst.Buffer): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_from_exif_buffer_with_tiff_header(cast[ptr gst.Buffer00](buffer.impl))

proc gst_tag_list_from_id3v2_tag(buffer: ptr gst.Buffer00): ptr gst.TagList00 {.
    importc, libprag.}

proc tagListFromId3v2Tag*(buffer: gst.Buffer): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_from_id3v2_tag(cast[ptr gst.Buffer00](buffer.impl))

proc gst_tag_list_from_vorbiscomment(data: ptr uint8; size: uint64; idData: ptr uint8;
    idDataLength: uint32; vendorString: var cstring): ptr gst.TagList00 {.
    importc, libprag.}

proc tagListFromVorbiscomment*(data: seq[uint8] | string; size: uint64;
    idData: seq[uint8] | string; vendorString: var string = cast[var string](nil)): gst.TagList =
  let idDataLength = int(idData.len)
  var vendorString_00: cstring
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_from_vorbiscomment(cast[ptr uint8](unsafeaddr(data[0])), size, cast[ptr uint8](unsafeaddr(idData[0])), uint32(idDataLength), vendorString_00)
  if vendorString.addr != nil:
    vendorString = $(vendorString_00)

proc gst_tag_list_from_vorbiscomment_buffer(buffer: ptr gst.Buffer00; idData: ptr uint8;
    idDataLength: uint32; vendorString: var cstring): ptr gst.TagList00 {.
    importc, libprag.}

proc tagListFromVorbiscommentBuffer*(buffer: gst.Buffer; idData: seq[uint8] | string;
    vendorString: var string = cast[var string](nil)): gst.TagList =
  let idDataLength = int(idData.len)
  var vendorString_00: cstring
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_from_vorbiscomment_buffer(cast[ptr gst.Buffer00](buffer.impl), cast[ptr uint8](unsafeaddr(idData[0])), uint32(idDataLength), vendorString_00)
  if vendorString.addr != nil:
    vendorString = $(vendorString_00)

proc gst_tag_list_from_xmp_buffer(buffer: ptr gst.Buffer00): ptr gst.TagList00 {.
    importc, libprag.}

proc tagListFromXmpBuffer*(buffer: gst.Buffer): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_from_xmp_buffer(cast[ptr gst.Buffer00](buffer.impl))

proc gst_tag_list_new_from_id3v1(data: ptr array[128, uint8]): ptr gst.TagList00 {.
    importc, libprag.}

proc tagListNewFromId3v1*(data: ptr array[128, uint8]): gst.TagList =
  fnew(result, gBoxedFreeGstTagList)
  result.impl = gst_tag_list_new_from_id3v1(data)

proc gst_tag_list_to_exif_buffer(taglist: ptr gst.TagList00; byteOrder: int32;
    baseOffset: uint32): ptr gst.Buffer00 {.
    importc, libprag.}

proc tagListToExifBuffer*(taglist: gst.TagList; byteOrder: int; baseOffset: int): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_tag_list_to_exif_buffer(cast[ptr gst.TagList00](taglist.impl), int32(byteOrder), uint32(baseOffset))

proc gst_tag_list_to_exif_buffer_with_tiff_header(taglist: ptr gst.TagList00): ptr gst.Buffer00 {.
    importc, libprag.}

proc tagListToExifBufferWithTiffHeader*(taglist: gst.TagList): gst.Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_tag_list_to_exif_buffer_with_tiff_header(cast[ptr gst.TagList00](taglist.impl))

proc gst_tag_list_to_vorbiscomment_buffer(list: ptr gst.TagList00; idData: ptr uint8;
    idDataLength: uint32; vendorString: cstring): ptr gst.Buffer00 {.
    importc, libprag.}

proc tagListToVorbiscommentBuffer*(list: gst.TagList; idData: seq[uint8] | string;
    vendorString: cstring = nil): gst.Buffer =
  let idDataLength = int(idData.len)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_tag_list_to_vorbiscomment_buffer(cast[ptr gst.TagList00](list.impl), cast[ptr uint8](unsafeaddr(idData[0])), uint32(idDataLength), vendorString)

proc gst_tag_list_to_xmp_buffer(list: ptr gst.TagList00; readOnly: gboolean;
    schemas: ptr cstring): ptr gst.Buffer00 {.
    importc, libprag.}

proc tagListToXmpBuffer*(list: gst.TagList; readOnly: bool; schemas: varargs[string, `$`]): gst.Buffer =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_tag_list_to_xmp_buffer(cast[ptr gst.TagList00](list.impl), gboolean(readOnly), seq2CstringArray(schemas, fs469n23))

proc gst_tag_parse_extended_comment(extComment: cstring; key: var cstring;
    lang: var cstring; value: var cstring; failIfNoKey: gboolean): gboolean {.
    importc, libprag.}

proc tagParseExtendedComment*(extComment: cstring; key: var string;
    lang: var string; value: var string; failIfNoKey: bool): bool =
  var key_00: cstring
  var lang_00: cstring
  var value_00: cstring
  result = toBool(gst_tag_parse_extended_comment(extComment, key_00, lang_00, value_00, gboolean(failIfNoKey)))
  if key.addr != nil:
    key = $(key_00)
  if lang.addr != nil:
    lang = $(lang_00)
  if value.addr != nil:
    value = $(value_00)

proc tagRegisterMusicbrainzTags*() {.
    importc: "gst_tag_register_musicbrainz_tags", libprag.}

proc gst_tag_to_id3_tag(gstTag: cstring): cstring {.
    importc, libprag.}

proc tagToId3Tag*(gstTag: cstring): string =
  result = $gst_tag_to_id3_tag(gstTag)

proc gst_tag_to_vorbis_comments(list: ptr gst.TagList00; tag: cstring): ptr glib.List {.
    importc, libprag.}

proc tagToVorbisComments*(list: gst.TagList; tag: cstring): seq[cstring] =
  let resul0 = gst_tag_to_vorbis_comments(cast[ptr gst.TagList00](list.impl), tag)
  g_list_free(resul0)

proc gst_tag_to_vorbis_tag(gstTag: cstring): cstring {.
    importc, libprag.}

proc tagToVorbisTag*(gstTag: cstring): string =
  result = $gst_tag_to_vorbis_tag(gstTag)

proc gst_tag_xmp_list_schemas(): ptr cstring {.
    importc, libprag.}

proc tagXmpListSchemas*(): seq[string] =
  cstringArrayToSeq(gst_tag_xmp_list_schemas())

proc gst_vorbis_tag_add(list: ptr gst.TagList00; tag: cstring; value: cstring) {.
    importc, libprag.}

proc vorbisTagAdd*(list: gst.TagList; tag: cstring; value: cstring) =
  gst_vorbis_tag_add(cast[ptr gst.TagList00](list.impl), tag, value)
# === remaining symbols:

# Extern interfaces: (we don't use converters, but explicit procs for now.)

proc tagSetter*(x: gsttag.TagMux): gst.TagSetter = cast[gst.TagSetter](x)
