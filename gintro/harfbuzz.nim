# dependencies:
# GObject-2.0
# GLib-2.0
# immediate dependencies:
# GObject-2.0
# libraries:
# libharfbuzz.so.0,libharfbuzz-gobject.so.0
{.warning[UnusedImport]: off.}
import gobject, glib
const Lib = "libharfbuzz.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}

proc finalizeGObject*[T](o: ref T) =
  if not o.ignoreFinalizer:
    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))

const AAT_LAYOUT_NO_SELECTOR_INDEX* = 65535'i32

const BUFFER_REPLACEMENT_CODEPOINT_DEFAULT* = 65533'i32

const FEATURE_GLOBAL_START* = 0'i32

const LANGUAGE_INVALID* = "INTERFCE (unsuported)"

const MAP_VALUE_INVALID* = 4294967295'u32

const OT_LAYOUT_DEFAULT_LANGUAGE_INDEX* = 65535'i32

const OT_LAYOUT_NO_FEATURE_INDEX* = 65535'i32

const OT_LAYOUT_NO_SCRIPT_INDEX* = 65535'i32

const OT_LAYOUT_NO_VARIATIONS_INDEX* = -1'i32

const OT_MAX_TAGS_PER_LANGUAGE* = 3'i32

const OT_MAX_TAGS_PER_SCRIPT* = 3'i32

const OT_VAR_NO_AXIS_INDEX* = -1'i32

const SET_VALUE_INVALID* = 4294967295'u32

const UNICODE_MAX* = 1114111'i32

const UNICODE_MAX_DECOMPOSITION_LEN* = 19'i32

const VERSION_MAJOR* = 2'i32

const VERSION_MICRO* = 4'i32

const VERSION_MINOR* = 7'i32

const VERSION_STRING* = "2.7.4"

type
  aatLayoutFeatureSelectorT* {.size: sizeof(cint), pure.} = enum
    allTypeFeaturesOn = 0
    allCaps = 1
    allLowerCase = 2
    alternateVertKanaOff = 3
    cjkSymbolAltFour = 4
    altProportionalText = 5
    altHalfWidthText = 6
    formInterrobangOff = 7
    diamondAnnotation = 8
    exponentsOff = 9
    diphthongLigaturesOn = 10
    diphthongLigaturesOff = 11
    hojoCharacters = 12
    nlccharacters = 13
    abbrevSquaredLigaturesOn = 14
    abbrevSquaredLigaturesOff = 15
    stylisticAltEightOn = 16
    stylisticAltEightOff = 17
    contextualLigaturesOn = 18
    contextualLigaturesOff = 19
    historicalLigaturesOn = 20
    historicalLigaturesOff = 21
    stylisticAltElevenOn = 22
    stylisticAltElevenOff = 23
    stylisticAltTwelveOn = 24
    stylisticAltTwelveOff = 25
    stylisticAltThirteenOn = 26
    stylisticAltThirteenOff = 27
    stylisticAltFourteenOn = 28
    stylisticAltFourteenOff = 29
    stylisticAltFifteenOn = 30
    stylisticAltFifteenOff = 31
    stylisticAltSixteenOn = 32
    stylisticAltSixteenOff = 33
    stylisticAltSeventeenOn = 34
    stylisticAltSeventeenOff = 35
    stylisticAltEighteenOn = 36
    stylisticAltEighteenOff = 37
    stylisticAltNineteenOn = 38
    stylisticAltNineteenOff = 39
    stylisticAltTwentyOn = 40
    stylisticAltTwentyOff = 41
    invalid = 65535

const
  aatLayoutFeatureSelectorTHyphenToMinusOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTSmallCaps* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTContextualSwashAlternatesOff* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTPartiallyConnected* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTHiraganaToKatakana* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTTraditionalAltTwo* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTDesignLevel2* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTLineFinalSwashesOn* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTWordFinalSwashesOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTMathematicalGreekOn* = aatLayoutFeatureSelectorT.diphthongLigaturesOn
  aatLayoutFeatureSelectorTAsteriskToMultiplyOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTStylisticAltNineOff* = aatLayoutFeatureSelectorT.contextualLigaturesOff
  aatLayoutFeatureSelectorTAlternateVertKanaOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTDesignLevel4* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTIlluminatedCaps* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTRoundedBoxAnnotation* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTCaseSensitiveSpacingOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTCircleAnnotation* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTFormInterrobangOn* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTStylisticAltThreeOff* = aatLayoutFeatureSelectorT.formInterrobangOff
  aatLayoutFeatureSelectorTStylisticAltOneOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTDesignLevel5* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTKatakanaToHiragana* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTSquaredLigaturesOn* = aatLayoutFeatureSelectorT.hojoCharacters
  aatLayoutFeatureSelectorTDiagonalFractions* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTCjkVerticalRomanHbaseline* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTWordFinalSwashesOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTExpertCharacters* = aatLayoutFeatureSelectorT.diphthongLigaturesOn
  aatLayoutFeatureSelectorTContextualSwashAlternatesOn* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTCjkSymbolAltTwo* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTSymbolLigaturesOff* = aatLayoutFeatureSelectorT.stylisticAltEightOff
  aatLayoutFeatureSelectorTMonospacedNumbers* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTStylisticAltTenOff* = aatLayoutFeatureSelectorT.historicalLigaturesOff
  aatLayoutFeatureSelectorTTraditionalAltFive* = aatLayoutFeatureSelectorT.exponentsOff
  aatLayoutFeatureSelectorTNoCjkSymbolAlternatives* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTContextualAlternatesOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTCjkVerticalRomanCentered* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTTraditionalCharacters* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTJis1990Characters* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTLinguisticRearrangementOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTInitialCapsAndSmallCaps* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTPiCharacters* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTCanonicalCompositionOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTUpperCaseSmallCaps* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTUpperAndLowerCase* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTTraditionalNamesCharacters* = aatLayoutFeatureSelectorT.abbrevSquaredLigaturesOn
  aatLayoutFeatureSelectorTSubstituteVerticalFormsOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTQuarterWidthNumbers* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTUpperCasePetiteCaps* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTBoxAnnotation* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTDefaultLowerCase* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTCaseSensitiveLayoutOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTNoStylisticAlternates* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTKanaToRomanization* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTLineInitialSwashesOn* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTOrdinals* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTCanonicalCompositionOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTCjkItalicRoman* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTCaseSensitiveSpacingOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTVerticalFractions* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTInequalityLigaturesOn* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTAlternateHorizKanaOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTHanjaToHangul* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTHyphensToEmDashOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTJis1983Characters* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTParenthesisAnnotation* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTDesignLevel1* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTStylisticAltFiveOff* = aatLayoutFeatureSelectorT.diphthongLigaturesOff
  aatLayoutFeatureSelectorTPreventOverlapOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTIdeographicAltFour* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTRebusPicturesOff* = aatLayoutFeatureSelectorT.exponentsOff
  aatLayoutFeatureSelectorTStylisticAltSevenOff* = aatLayoutFeatureSelectorT.abbrevSquaredLigaturesOff
  aatLayoutFeatureSelectorTContextualAlternatesOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTCjkItalicRomanOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTMathSymbols* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTInferiors* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTLogosOn* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTLowerCaseNumbers* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTLineFinalSwashesOff* = aatLayoutFeatureSelectorT.formInterrobangOff
  aatLayoutFeatureSelectorTInvertedBoxAnnotation* = aatLayoutFeatureSelectorT.exponentsOff
  aatLayoutFeatureSelectorTNoStyleOptions* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTCaseSensitiveLayoutOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTLowerCaseSmallCaps* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTThirdWidthNumbers* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTCjkSymbolAltFive* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTHyphenToEnDashOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTStylisticAltNineOn* = aatLayoutFeatureSelectorT.contextualLigaturesOn
  aatLayoutFeatureSelectorTSwashAlternatesOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTHanjaToHangulAltTwo* = aatLayoutFeatureSelectorT.diamondAnnotation
  aatLayoutFeatureSelectorTNoOrnaments* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTFullWidthKana* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTStylisticAltSixOn* = aatLayoutFeatureSelectorT.hojoCharacters
  aatLayoutFeatureSelectorTHalfWidthText* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTHanjaToHangulAltThree* = aatLayoutFeatureSelectorT.exponentsOff
  aatLayoutFeatureSelectorTProportionalCjkRoman* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTInvertedCircleAnnotation* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTStylisticAltSixOff* = aatLayoutFeatureSelectorT.nlccharacters
  aatLayoutFeatureSelectorTRomanizationToKatakana* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTJis1978Characters* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTSmartQuotesOn* = aatLayoutFeatureSelectorT.diamondAnnotation
  aatLayoutFeatureSelectorTStylisticAltSevenOn* = aatLayoutFeatureSelectorT.abbrevSquaredLigaturesOn
  aatLayoutFeatureSelectorTTraditionalAltOne* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTEngravedText* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTUpperCaseNumbers* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTStylisticAltTwoOn* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTProportionalText* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTLowerCasePetiteCaps* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTWordInitialSwashesOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTAllTypeFeaturesOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTRareLigaturesOn* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTCompatibilityCompositionOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTDingbats* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTSmartQuotesOff* = aatLayoutFeatureSelectorT.exponentsOff
  aatLayoutFeatureSelectorTRubyKana* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTStylisticAltTenOn* = aatLayoutFeatureSelectorT.historicalLigaturesOn
  aatLayoutFeatureSelectorTSlashedZeroOn* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTRareLigaturesOff* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTAlternateHorizKanaOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTStylisticAltFourOn* = aatLayoutFeatureSelectorT.diamondAnnotation
  aatLayoutFeatureSelectorTIdeographicAltThree* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTDesignLevel3* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTRomanizationToHiragana* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTTallCaps* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTPeriodsToEllipsisOn* = aatLayoutFeatureSelectorT.diphthongLigaturesOn
  aatLayoutFeatureSelectorTCommonLigaturesOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTTraditionalAltFour* = aatLayoutFeatureSelectorT.diamondAnnotation
  aatLayoutFeatureSelectorTSuperiors* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTHalfWidthIdeographs* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTFullWidthCjkRoman* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTNoTransliteration* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTStylisticAltFourOff* = aatLayoutFeatureSelectorT.exponentsOff
  aatLayoutFeatureSelectorTPreventOverlapOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTQuarterWidthText* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTTitlingCaps* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTInternationalSymbols* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTNonFinalSwashesOff* = aatLayoutFeatureSelectorT.exponentsOff
  aatLayoutFeatureSelectorTLineInitialSwashesOff* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTCompatibilityCompositionOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTNoAlternates* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTPeriodAnnotation* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTCjkItalicRomanOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTCjkSymbolAltOne* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTUnconnected* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTHyphenToEnDashOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTAsteriskToMultiplyOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTScientificInferiors* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTRequiredLigaturesOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTDefaultCjkRoman* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTSlashedZeroOff* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTNoRubyKana* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTTranscodingCompositionOff* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTProportionalKana* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTStylisticAltTwoOff* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTIdeographicAltFive* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTNoFractions* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTSubstituteVerticalFormsOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTTranscodingCompositionOn* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTNonFinalSwashesOn* = aatLayoutFeatureSelectorT.diamondAnnotation
  aatLayoutFeatureSelectorTFullWidthIdeographs* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTWordInitialSwashesOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTProportionalIdeographs* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTSlashToDivideOn* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTIdeographicAltOne* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTCommonLigaturesOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTHanjaToHangulAltOne* = aatLayoutFeatureSelectorT.formInterrobangOff
  aatLayoutFeatureSelectorTFleurons* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTRequiredLigaturesOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTHalfWidthCjkRoman* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTProportionalNumbers* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTDecomposeDiacritics* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTLinguisticRearrangementOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTStylisticAltFiveOn* = aatLayoutFeatureSelectorT.diphthongLigaturesOn
  aatLayoutFeatureSelectorTSquaredLigaturesOff* = aatLayoutFeatureSelectorT.nlccharacters
  aatLayoutFeatureSelectorTMathematicalGreekOff* = aatLayoutFeatureSelectorT.diphthongLigaturesOff
  aatLayoutFeatureSelectorTSwashAlternatesOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTNoIdeographicAlternatives* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTPeriodsToEllipsisOff* = aatLayoutFeatureSelectorT.diphthongLigaturesOff
  aatLayoutFeatureSelectorTInitialCaps* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTSimplifiedCharacters* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTJis2004Characters* = aatLayoutFeatureSelectorT.diphthongLigaturesOff
  aatLayoutFeatureSelectorTNoAnnotation* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTCjkSymbolAltThree* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTDecorativeBorders* = aatLayoutFeatureSelectorT.cjkSymbolAltFour
  aatLayoutFeatureSelectorTLogosOff* = aatLayoutFeatureSelectorT.formInterrobangOff
  aatLayoutFeatureSelectorTStylisticAltOneOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTTraditionalAltThree* = aatLayoutFeatureSelectorT.formInterrobangOff
  aatLayoutFeatureSelectorTNoCjkItalicRoman* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTRubyKanaOn* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTMonospacedText* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTHyphenToMinusOff* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTShowDiacritics* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTHideDiacritics* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTSymbolLigaturesOn* = aatLayoutFeatureSelectorT.stylisticAltEightOn
  aatLayoutFeatureSelectorTNormalPosition* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTDisplayText* = aatLayoutFeatureSelectorT.allCaps
  aatLayoutFeatureSelectorTInvertedRoundedBoxAnnotation* = aatLayoutFeatureSelectorT.diphthongLigaturesOn
  aatLayoutFeatureSelectorTHyphensToEmDashOn* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTExponentsOn* = aatLayoutFeatureSelectorT.diamondAnnotation
  aatLayoutFeatureSelectorTThirdWidthText* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTRomanNumeralAnnotation* = aatLayoutFeatureSelectorT.formInterrobangOff
  aatLayoutFeatureSelectorTStylisticAltThreeOn* = aatLayoutFeatureSelectorT.altHalfWidthText
  aatLayoutFeatureSelectorTRebusPicturesOn* = aatLayoutFeatureSelectorT.diamondAnnotation
  aatLayoutFeatureSelectorTRubyKanaOff* = aatLayoutFeatureSelectorT.alternateVertKanaOff
  aatLayoutFeatureSelectorTIdeographicAltTwo* = aatLayoutFeatureSelectorT.allLowerCase
  aatLayoutFeatureSelectorTDefaultUpperCase* = aatLayoutFeatureSelectorT.allTypeFeaturesOn
  aatLayoutFeatureSelectorTSlashToDivideOff* = aatLayoutFeatureSelectorT.altProportionalText
  aatLayoutFeatureSelectorTInequalityLigaturesOff* = aatLayoutFeatureSelectorT.formInterrobangOff
  aatLayoutFeatureSelectorTCursive* = aatLayoutFeatureSelectorT.allLowerCase

type
  aatLayoutFeatureTypeT* {.size: sizeof(cint), pure.} = enum
    allTypographic = 0
    ligatures = 1
    curisveConnection = 2
    letterCase = 3
    verticalSubstitution = 4
    linguisticRearrangement = 5
    numberSpacing = 6
    smartSwashType = 8
    diacriticsType = 9
    verticalPosition = 10
    fractions = 11
    overlappingCharactersType = 13
    typographicExtras = 14
    mathematicalExtras = 15
    ornamentSetsType = 16
    characterAlternatives = 17
    designComplexityType = 18
    styleOptions = 19
    characterShape = 20
    numberCase = 21
    textSpacing = 22
    transliteration = 23
    annotationType = 24
    kanaSpacingType = 25
    ideographicSpacingType = 26
    unicodeDecompositionType = 27
    rubyKana = 28
    cjkSymbolAlternativesType = 29
    ideographicAlternativesType = 30
    cjkVerticalRomanPlacementType = 31
    italicCjkRoman = 32
    caseSensitiveLayout = 33
    alternateKana = 34
    stylisticAlternatives = 35
    contextualAlternatives = 36
    lowerCase = 37
    upperCase = 38
    languageTagType = 39
    cjkRomanSpacingType = 103
    invalid = 65535

type
  blobT00* {.pure.} = object
  blobT* = ref object
    impl*: ptr blobT00
    ignoreFinalizer*: bool

proc hb_gobject_blob_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_blob_t*(self: blobT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_blob_get_type(), cast[ptr blobT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(blobT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_blob_get_type(), cast[ptr blobT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var blobT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_blob_t)

proc hb_blob_copy_writable_or_fail(blob: ptr blobT00): ptr blobT00 {.
    importc, libprag.}

proc blobCopyWritableOrFail*(blob: blobT): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_blob_copy_writable_or_fail(cast[ptr blobT00](blob.impl))

proc hb_blob_create_from_file(fileName: cstring): ptr blobT00 {.
    importc, libprag.}

proc blobCreateFromFile*(fileName: cstring): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_blob_create_from_file(fileName)

proc hb_blob_create_sub_blob(parent: ptr blobT00; offset: uint32; length: uint32): ptr blobT00 {.
    importc, libprag.}

proc blobCreateSubBlob*(parent: blobT; offset: int; length: int): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_blob_create_sub_blob(cast[ptr blobT00](parent.impl), uint32(offset), uint32(length))

proc hb_blob_get_data(blob: ptr blobT00; length: var uint32): ptr cstring {.
    importc, libprag.}

proc blobGetData*(blob: blobT; length: var int): seq[string] =
  var length_00: uint32
  result = cstringArrayToSeq(hb_blob_get_data(cast[ptr blobT00](blob.impl), length_00))
  if length.addr != nil:
    length = int(length_00)

proc hb_blob_get_data_writable(blob: ptr blobT00; length: var uint32): ptr cstring {.
    importc, libprag.}

proc blobGetDataWritable*(blob: blobT; length: var int): seq[string] =
  var length_00: uint32
  result = cstringArrayToSeq(hb_blob_get_data_writable(cast[ptr blobT00](blob.impl), length_00))
  if length.addr != nil:
    length = int(length_00)

proc hb_blob_get_empty(): ptr blobT00 {.
    importc, libprag.}

proc blobGetEmpty*(): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_blob_get_empty()

proc hb_blob_get_length(blob: ptr blobT00): uint32 {.
    importc, libprag.}

proc blobGetLength*(blob: blobT): int =
  int(hb_blob_get_length(cast[ptr blobT00](blob.impl)))

proc hb_blob_is_immutable(blob: ptr blobT00): int32 {.
    importc, libprag.}

proc blobIsImmutable*(blob: blobT): int =
  int(hb_blob_is_immutable(cast[ptr blobT00](blob.impl)))

proc hb_blob_make_immutable(blob: ptr blobT00) {.
    importc, libprag.}

proc blobMakeImmutable*(blob: blobT) =
  hb_blob_make_immutable(cast[ptr blobT00](blob.impl))

type
  bufferClusterLevelT* {.size: sizeof(cint), pure.} = enum
    default = 0
    monotoneCharacters = 1
    characters = 2

const
  bufferClusterLevelTMonotoneGraphemes* = bufferClusterLevelT.default

type
  bufferContentTypeT* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    unicode = 1
    glyphs = 2

type
  bufferDiffFlagsT* {.size: sizeof(cint), pure.} = enum
    equal = 0
    contentTypeMismatch = 1
    lengthMismatch = 2
    notdefPresent = 4
    dottedCirclePresent = 8
    codepointMismatch = 16
    clusterMismatch = 32
    glyphFlagsMismatch = 64
    positionMismatch = 128

type
  bufferFlagsT* {.size: sizeof(cint), pure.} = enum
    default = 0
    bot = 1
    eot = 2
    preserveDefaultIgnorables = 4
    removeDefaultIgnorables = 8
    doNotInsertDottedCircle = 16

type
  bufferSerializeFlagsT* {.size: sizeof(cint), pure.} = enum
    default = 0
    noClusters = 1
    noPositions = 2
    noGlyphNames = 4
    glyphExtents = 8
    glyphFlags = 16
    noAdvances = 32

type
  bufferSerializeFormatT* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    json = 1246973774
    text = 1413830740

proc hb_buffer_serialize_format_from_string(str: ptr uint8; len: int32): bufferSerializeFormatT {.
    importc, libprag.}

proc bufferSerializeFormatFromString*(str: seq[uint8] | string): bufferSerializeFormatT =
  let len = int(str.len)
  hb_buffer_serialize_format_from_string(cast[ptr uint8](unsafeaddr(str[0])), int32(len))

proc hb_buffer_serialize_format_to_string(format: bufferSerializeFormatT): cstring {.
    importc, libprag.}

proc bufferSerializeFormatToString*(format: bufferSerializeFormatT): string =
  result = $hb_buffer_serialize_format_to_string(format)

proc hb_buffer_serialize_list_formats(): ptr cstring {.
    importc, libprag.}

proc bufferSerializeListFormats*(): seq[string] =
  cstringArrayToSeq(hb_buffer_serialize_list_formats())

type
  bufferT00* {.pure.} = object
  bufferT* = ref object
    impl*: ptr bufferT00
    ignoreFinalizer*: bool

proc hb_gobject_buffer_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_buffer_t*(self: bufferT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_buffer_get_type(), cast[ptr bufferT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(bufferT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_buffer_get_type(), cast[ptr bufferT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var bufferT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_buffer_t)

proc hb_buffer_add(buffer: ptr bufferT00; codepoint: uint32; cluster: uint32) {.
    importc, libprag.}

proc bufferAdd*(buffer: bufferT; codepoint: int; cluster: int) =
  hb_buffer_add(cast[ptr bufferT00](buffer.impl), uint32(codepoint), uint32(cluster))

proc hb_buffer_add_codepoints(buffer: ptr bufferT00; text: ptr uint32; textLength: int32;
    itemOffset: uint32; itemLength: int32) {.
    importc, libprag.}

proc bufferAddCodepoints*(buffer: bufferT; text: seq[uint32]; itemOffset: int;
    itemLength: int) =
  let textLength = int(text.len)
  hb_buffer_add_codepoints(cast[ptr bufferT00](buffer.impl), cast[ptr uint32](unsafeaddr(text[0])), int32(textLength), uint32(itemOffset), int32(itemLength))

proc hb_buffer_add_latin1(buffer: ptr bufferT00; text: ptr uint8; textLength: int32;
    itemOffset: uint32; itemLength: int32) {.
    importc, libprag.}

proc bufferAddLatin1*(buffer: bufferT; text: seq[uint8] | string; itemOffset: int;
    itemLength: int) =
  let textLength = int(text.len)
  hb_buffer_add_latin1(cast[ptr bufferT00](buffer.impl), cast[ptr uint8](unsafeaddr(text[0])), int32(textLength), uint32(itemOffset), int32(itemLength))

proc hb_buffer_add_utf16(buffer: ptr bufferT00; text: ptr uint16; textLength: int32;
    itemOffset: uint32; itemLength: int32) {.
    importc, libprag.}

proc bufferAddUtf16*(buffer: bufferT; text: ptr uint16; textLength: int;
    itemOffset: int; itemLength: int) =
  hb_buffer_add_utf16(cast[ptr bufferT00](buffer.impl), text, int32(textLength), uint32(itemOffset), int32(itemLength))

proc hb_buffer_add_utf32(buffer: ptr bufferT00; text: ptr uint32; textLength: int32;
    itemOffset: uint32; itemLength: int32) {.
    importc, libprag.}

proc bufferAddUtf32*(buffer: bufferT; text: seq[uint32]; itemOffset: int;
    itemLength: int) =
  let textLength = int(text.len)
  hb_buffer_add_utf32(cast[ptr bufferT00](buffer.impl), cast[ptr uint32](unsafeaddr(text[0])), int32(textLength), uint32(itemOffset), int32(itemLength))

proc hb_buffer_add_utf8(buffer: ptr bufferT00; text: ptr uint8; textLength: int32;
    itemOffset: uint32; itemLength: int32) {.
    importc, libprag.}

proc bufferAddUtf8*(buffer: bufferT; text: seq[uint8] | string; itemOffset: int;
    itemLength: int) =
  let textLength = int(text.len)
  hb_buffer_add_utf8(cast[ptr bufferT00](buffer.impl), cast[ptr uint8](unsafeaddr(text[0])), int32(textLength), uint32(itemOffset), int32(itemLength))

proc hb_buffer_allocation_successful(buffer: ptr bufferT00): int32 {.
    importc, libprag.}

proc bufferAllocationSuccessful*(buffer: bufferT): int =
  int(hb_buffer_allocation_successful(cast[ptr bufferT00](buffer.impl)))

proc hb_buffer_append(buffer: ptr bufferT00; source: ptr bufferT00; start: uint32;
    `end`: uint32) {.
    importc, libprag.}

proc bufferAppend*(buffer: bufferT; source: bufferT; start: int; `end`: int) =
  hb_buffer_append(cast[ptr bufferT00](buffer.impl), cast[ptr bufferT00](source.impl), uint32(start), uint32(`end`))

proc hb_buffer_clear_contents(buffer: ptr bufferT00) {.
    importc, libprag.}

proc bufferClearContents*(buffer: bufferT) =
  hb_buffer_clear_contents(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_create(): ptr bufferT00 {.
    importc, libprag.}

proc bufferCreate*(): bufferT =
  fnew(result, gBoxedFreehb_buffer_t)
  result.impl = hb_buffer_create()

proc hb_buffer_deserialize_unicode(buffer: ptr bufferT00; buf: ptr cstring;
    bufLen: int32; endPtr: var cstring; format: bufferSerializeFormatT): int32 {.
    importc, libprag.}

proc bufferDeserializeUnicode*(buffer: bufferT; buf: openArray[string];
    bufLen: int; endPtr: var string; format: bufferSerializeFormatT): int =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var endPtr_00: cstring
  result = int(hb_buffer_deserialize_unicode(cast[ptr bufferT00](buffer.impl), seq2CstringArray(buf, fs469n23), int32(bufLen), endPtr_00, format))
  if endPtr.addr != nil:
    endPtr = $(endPtr_00)

proc hb_buffer_diff(buffer: ptr bufferT00; reference: ptr bufferT00; dottedcircleGlyph: uint32;
    positionFuzz: uint32): bufferDiffFlagsT {.
    importc, libprag.}

proc bufferDiff*(buffer: bufferT; reference: bufferT; dottedcircleGlyph: int;
    positionFuzz: int): bufferDiffFlagsT =
  hb_buffer_diff(cast[ptr bufferT00](buffer.impl), cast[ptr bufferT00](reference.impl), uint32(dottedcircleGlyph), uint32(positionFuzz))

proc hb_buffer_get_cluster_level(buffer: ptr bufferT00): bufferClusterLevelT {.
    importc, libprag.}

proc bufferGetClusterLevel*(buffer: bufferT): bufferClusterLevelT =
  hb_buffer_get_cluster_level(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_get_content_type(buffer: ptr bufferT00): bufferContentTypeT {.
    importc, libprag.}

proc bufferGetContentType*(buffer: bufferT): bufferContentTypeT =
  hb_buffer_get_content_type(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_get_empty(): ptr bufferT00 {.
    importc, libprag.}

proc bufferGetEmpty*(): bufferT =
  fnew(result, gBoxedFreehb_buffer_t)
  result.impl = hb_buffer_get_empty()

proc hb_buffer_get_flags(buffer: ptr bufferT00): bufferFlagsT {.
    importc, libprag.}

proc bufferGetFlags*(buffer: bufferT): bufferFlagsT =
  hb_buffer_get_flags(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_get_invisible_glyph(buffer: ptr bufferT00): uint32 {.
    importc, libprag.}

proc bufferGetInvisibleGlyph*(buffer: bufferT): int =
  int(hb_buffer_get_invisible_glyph(cast[ptr bufferT00](buffer.impl)))

proc hb_buffer_get_length(buffer: ptr bufferT00): uint32 {.
    importc, libprag.}

proc bufferGetLength*(buffer: bufferT): int =
  int(hb_buffer_get_length(cast[ptr bufferT00](buffer.impl)))

proc hb_buffer_get_replacement_codepoint(buffer: ptr bufferT00): uint32 {.
    importc, libprag.}

proc bufferGetReplacementCodepoint*(buffer: bufferT): int =
  int(hb_buffer_get_replacement_codepoint(cast[ptr bufferT00](buffer.impl)))

proc hb_buffer_guess_segment_properties(buffer: ptr bufferT00) {.
    importc, libprag.}

proc bufferGuessSegmentProperties*(buffer: bufferT) =
  hb_buffer_guess_segment_properties(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_has_positions(buffer: ptr bufferT00): int32 {.
    importc, libprag.}

proc bufferHasPositions*(buffer: bufferT): int =
  int(hb_buffer_has_positions(cast[ptr bufferT00](buffer.impl)))

proc hb_buffer_normalize_glyphs(buffer: ptr bufferT00) {.
    importc, libprag.}

proc bufferNormalizeGlyphs*(buffer: bufferT) =
  hb_buffer_normalize_glyphs(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_pre_allocate(buffer: ptr bufferT00; size: uint32): int32 {.
    importc, libprag.}

proc bufferPreAllocate*(buffer: bufferT; size: int): int =
  int(hb_buffer_pre_allocate(cast[ptr bufferT00](buffer.impl), uint32(size)))

proc hb_buffer_reset(buffer: ptr bufferT00) {.
    importc, libprag.}

proc bufferReset*(buffer: bufferT) =
  hb_buffer_reset(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_reverse(buffer: ptr bufferT00) {.
    importc, libprag.}

proc bufferReverse*(buffer: bufferT) =
  hb_buffer_reverse(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_reverse_clusters(buffer: ptr bufferT00) {.
    importc, libprag.}

proc bufferReverseClusters*(buffer: bufferT) =
  hb_buffer_reverse_clusters(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_reverse_range(buffer: ptr bufferT00; start: uint32; `end`: uint32) {.
    importc, libprag.}

proc bufferReverseRange*(buffer: bufferT; start: int; `end`: int) =
  hb_buffer_reverse_range(cast[ptr bufferT00](buffer.impl), uint32(start), uint32(`end`))

proc hb_buffer_serialize_unicode(buffer: ptr bufferT00; start: uint32; `end`: uint32;
    buf: var ptr uint8; bufSize: var uint32; bufConsumed: var uint32; format: bufferSerializeFormatT;
    flags: bufferSerializeFlagsT): uint32 {.
    importc, libprag.}

proc bufferSerializeUnicode*(buffer: bufferT; start: int; `end`: int;
    buf: var (seq[uint8] | string); bufSize: var int; bufConsumed: var int = cast[var int](nil);
    format: bufferSerializeFormatT; flags: bufferSerializeFlagsT): int =
  var bufSize_00: uint32
  var bufConsumed_00: uint32
  var buf_00: ptr uint8
  result = int(hb_buffer_serialize_unicode(cast[ptr bufferT00](buffer.impl), uint32(start), uint32(`end`), buf_00, bufSize_00, bufConsumed_00, format, flags))
  if bufSize.addr != nil:
    bufSize = int(bufSize_00)
  if bufConsumed.addr != nil:
    bufConsumed = int(bufConsumed_00)
  buf.setLen(bufSize)
  copyMem(unsafeaddr buf[0], buf_00, bufSize.int * sizeof(buf[0]))
  cogfree(buf_00)

proc hb_buffer_set_cluster_level(buffer: ptr bufferT00; clusterLevel: bufferClusterLevelT) {.
    importc, libprag.}

proc bufferSetClusterLevel*(buffer: bufferT; clusterLevel: bufferClusterLevelT) =
  hb_buffer_set_cluster_level(cast[ptr bufferT00](buffer.impl), clusterLevel)

proc hb_buffer_set_content_type(buffer: ptr bufferT00; contentType: bufferContentTypeT) {.
    importc, libprag.}

proc bufferSetContentType*(buffer: bufferT; contentType: bufferContentTypeT) =
  hb_buffer_set_content_type(cast[ptr bufferT00](buffer.impl), contentType)

proc hb_buffer_set_flags(buffer: ptr bufferT00; flags: bufferFlagsT) {.
    importc, libprag.}

proc bufferSetFlags*(buffer: bufferT; flags: bufferFlagsT) =
  hb_buffer_set_flags(cast[ptr bufferT00](buffer.impl), flags)

proc hb_buffer_set_invisible_glyph(buffer: ptr bufferT00; invisible: uint32) {.
    importc, libprag.}

proc bufferSetInvisibleGlyph*(buffer: bufferT; invisible: int) =
  hb_buffer_set_invisible_glyph(cast[ptr bufferT00](buffer.impl), uint32(invisible))

proc hb_buffer_set_length(buffer: ptr bufferT00; length: uint32): int32 {.
    importc, libprag.}

proc bufferSetLength*(buffer: bufferT; length: int): int =
  int(hb_buffer_set_length(cast[ptr bufferT00](buffer.impl), uint32(length)))

proc hb_buffer_set_replacement_codepoint(buffer: ptr bufferT00; replacement: uint32) {.
    importc, libprag.}

proc bufferSetReplacementCodepoint*(buffer: bufferT; replacement: int) =
  hb_buffer_set_replacement_codepoint(cast[ptr bufferT00](buffer.impl), uint32(replacement))

proc hb_color_get_alpha(color: uint32): uint8 {.
    importc, libprag.}

proc colorGetAlpha*(color: int): uint8 =
  hb_color_get_alpha(uint32(color))

proc hb_color_get_blue(color: uint32): uint8 {.
    importc, libprag.}

proc colorGetBlue*(color: int): uint8 =
  hb_color_get_blue(uint32(color))

proc hb_color_get_green(color: uint32): uint8 {.
    importc, libprag.}

proc colorGetGreen*(color: int): uint8 =
  hb_color_get_green(uint32(color))

proc hb_color_get_red(color: uint32): uint8 {.
    importc, libprag.}

proc colorGetRed*(color: int): uint8 =
  hb_color_get_red(uint32(color))

type
  destroyFuncT* = proc (userData: pointer) {.cdecl.}

type
  directionT* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    ltr = 4
    rtl = 5
    ttb = 6
    btt = 7

proc hb_buffer_get_direction(buffer: ptr bufferT00): directionT {.
    importc, libprag.}

proc bufferGetDirection*(buffer: bufferT): directionT =
  hb_buffer_get_direction(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_set_direction(buffer: ptr bufferT00; direction: directionT) {.
    importc, libprag.}

proc bufferSetDirection*(buffer: bufferT; direction: directionT) =
  hb_buffer_set_direction(cast[ptr bufferT00](buffer.impl), direction)

proc hb_direction_from_string(str: ptr uint8; len: int32): directionT {.
    importc, libprag.}

proc directionFromString*(str: seq[uint8] | string): directionT =
  let len = int(str.len)
  hb_direction_from_string(cast[ptr uint8](unsafeaddr(str[0])), int32(len))

proc hb_direction_to_string(direction: directionT): cstring {.
    importc, libprag.}

proc directionToString*(direction: directionT): string =
  result = $hb_direction_to_string(direction)

proc hb_face_count(blob: ptr blobT00): uint32 {.
    importc, libprag.}

proc faceCount*(blob: blobT): int =
  int(hb_face_count(cast[ptr blobT00](blob.impl)))

type
  faceT00* {.pure.} = object
  faceT* = ref object
    impl*: ptr faceT00
    ignoreFinalizer*: bool

proc hb_gobject_face_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_face_t*(self: faceT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_face_get_type(), cast[ptr faceT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(faceT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_face_get_type(), cast[ptr faceT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var faceT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_face_t)

proc hb_face_builder_add_table(face: ptr faceT00; tag: uint32; blob: ptr blobT00): int32 {.
    importc, libprag.}

proc faceBuilderAddTable*(face: faceT; tag: int; blob: blobT): int =
  int(hb_face_builder_add_table(cast[ptr faceT00](face.impl), uint32(tag), cast[ptr blobT00](blob.impl)))

proc hb_face_builder_create(): ptr faceT00 {.
    importc, libprag.}

proc faceBuilderCreate*(): faceT =
  fnew(result, gBoxedFreehb_face_t)
  result.impl = hb_face_builder_create()

proc hb_face_create(blob: ptr blobT00; index: uint32): ptr faceT00 {.
    importc, libprag.}

proc faceCreate*(blob: blobT; index: int): faceT =
  fnew(result, gBoxedFreehb_face_t)
  result.impl = hb_face_create(cast[ptr blobT00](blob.impl), uint32(index))

proc hb_face_create_for_tables(referenceTableFunc: proc(face: ptr faceT00;
    tag: uint32; userData: pointer): ptr blobT00 {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}): ptr faceT00 {.
    importc, libprag.}

proc faceCreateForTables*(referenceTableFunc: proc(face: ptr faceT00;
    tag: uint32; userData: pointer): ptr blobT00 {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}): faceT =
  fnew(result, gBoxedFreehb_face_t)
  result.impl = hb_face_create_for_tables(referenceTableFunc, userData, destroy)

proc hb_face_get_empty(): ptr faceT00 {.
    importc, libprag.}

proc faceGetEmpty*(): faceT =
  fnew(result, gBoxedFreehb_face_t)
  result.impl = hb_face_get_empty()

proc hb_face_get_glyph_count(face: ptr faceT00): uint32 {.
    importc, libprag.}

proc faceGetGlyphCount*(face: faceT): int =
  int(hb_face_get_glyph_count(cast[ptr faceT00](face.impl)))

proc hb_face_get_index(face: ptr faceT00): uint32 {.
    importc, libprag.}

proc faceGetIndex*(face: faceT): int =
  int(hb_face_get_index(cast[ptr faceT00](face.impl)))

proc hb_face_get_table_tags(face: ptr faceT00; startOffset: uint32; tableCount: var uint32;
    tableTags: var ptr uint32): uint32 {.
    importc, libprag.}

proc faceGetTableTags*(face: faceT; startOffset: int; tableCount: var int;
    tableTags: var seq[uint32]): int =
  var tableTags_00: ptr uint32
  var tableCount_00: uint32
  result = int(hb_face_get_table_tags(cast[ptr faceT00](face.impl), uint32(startOffset), tableCount_00, tableTags_00))
  tableTags.setLen(tableCount)
  copyMem(unsafeaddr tableTags[0], tableTags_00, tableCount.int * sizeof(tableTags[0]))
  cogfree(tableTags_00)
  if tableCount.addr != nil:
    tableCount = int(tableCount_00)

proc hb_face_get_upem(face: ptr faceT00): uint32 {.
    importc, libprag.}

proc faceGetUpem*(face: faceT): int =
  int(hb_face_get_upem(cast[ptr faceT00](face.impl)))

proc hb_face_is_immutable(face: ptr faceT00): int32 {.
    importc, libprag.}

proc faceIsImmutable*(face: faceT): int =
  int(hb_face_is_immutable(cast[ptr faceT00](face.impl)))

proc hb_face_make_immutable(face: ptr faceT00) {.
    importc, libprag.}

proc faceMakeImmutable*(face: faceT) =
  hb_face_make_immutable(cast[ptr faceT00](face.impl))

proc hb_face_reference_blob(face: ptr faceT00): ptr blobT00 {.
    importc, libprag.}

proc faceReferenceBlob*(face: faceT): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_face_reference_blob(cast[ptr faceT00](face.impl))

proc hb_face_reference_table(face: ptr faceT00; tag: uint32): ptr blobT00 {.
    importc, libprag.}

proc faceReferenceTable*(face: faceT; tag: int): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_face_reference_table(cast[ptr faceT00](face.impl), uint32(tag))

proc hb_face_set_glyph_count(face: ptr faceT00; glyphCount: uint32) {.
    importc, libprag.}

proc faceSetGlyphCount*(face: faceT; glyphCount: int) =
  hb_face_set_glyph_count(cast[ptr faceT00](face.impl), uint32(glyphCount))

proc hb_face_set_index(face: ptr faceT00; index: uint32) {.
    importc, libprag.}

proc faceSetIndex*(face: faceT; index: int) =
  hb_face_set_index(cast[ptr faceT00](face.impl), uint32(index))

proc hb_face_set_upem(face: ptr faceT00; upem: uint32) {.
    importc, libprag.}

proc faceSetUpem*(face: faceT; upem: int) =
  hb_face_set_upem(cast[ptr faceT00](face.impl), uint32(upem))

type
  featureT00* {.pure.} = object
  featureT* = ref object
    impl*: ptr featureT00
    ignoreFinalizer*: bool

proc hb_gobject_feature_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_feature_t*(self: featureT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_feature_get_type(), cast[ptr featureT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(featureT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_feature_get_type(), cast[ptr featureT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var featureT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_feature_t)

proc hb_feature_to_string(self: ptr featureT00; buf: var ptr cstring; size: var uint32) {.
    importc, libprag.}

proc stringP*(self: featureT; buf: var seq[string]; size: var int) =
  var size_00: uint32
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var buf_00 = seq2CstringArray(buf, fs469n23)
  hb_feature_to_string(cast[ptr featureT00](self.impl), buf_00, size_00)
  if size.addr != nil:
    size = int(size_00)
  if buf.addr != nil:
    buf = cstringArrayToSeq(buf_00)

proc hb_feature_from_string(str: ptr uint8; len: int32; feature: var featureT00): int32 {.
    importc, libprag.}

proc featureFromString*(str: seq[uint8] | string; feature: var featureT00): int =
  let len = int(str.len)
  int(hb_feature_from_string(cast[ptr uint8](unsafeaddr(str[0])), int32(len), feature))

type
  fontExtentsT00* {.pure.} = object
  fontExtentsT* = ref object
    impl*: ptr fontExtentsT00
    ignoreFinalizer*: bool

type
  fontFuncsT00* {.pure.} = object
  fontFuncsT* = ref object
    impl*: ptr fontFuncsT00
    ignoreFinalizer*: bool

proc hb_gobject_font_funcs_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_font_funcs_t*(self: fontFuncsT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_font_funcs_get_type(), cast[ptr fontFuncsT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(fontFuncsT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_font_funcs_get_type(), cast[ptr fontFuncsT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var fontFuncsT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_font_funcs_t)

proc hb_font_funcs_create(): ptr fontFuncsT00 {.
    importc, libprag.}

proc fontFuncsCreate*(): fontFuncsT =
  fnew(result, gBoxedFreehb_font_funcs_t)
  result.impl = hb_font_funcs_create()

proc hb_font_funcs_get_empty(): ptr fontFuncsT00 {.
    importc, libprag.}

proc fontFuncsGetEmpty*(): fontFuncsT =
  fnew(result, gBoxedFreehb_font_funcs_t)
  result.impl = hb_font_funcs_get_empty()

proc hb_font_funcs_is_immutable(ffuncs: ptr fontFuncsT00): int32 {.
    importc, libprag.}

proc fontFuncsIsImmutable*(ffuncs: fontFuncsT): int =
  int(hb_font_funcs_is_immutable(cast[ptr fontFuncsT00](ffuncs.impl)))

proc hb_font_funcs_make_immutable(ffuncs: ptr fontFuncsT00) {.
    importc, libprag.}

proc fontFuncsMakeImmutable*(ffuncs: fontFuncsT) =
  hb_font_funcs_make_immutable(cast[ptr fontFuncsT00](ffuncs.impl))

type
  fontT00* {.pure.} = object
  fontT* = ref object
    impl*: ptr fontT00
    ignoreFinalizer*: bool

proc hb_gobject_font_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_font_t*(self: fontT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_font_get_type(), cast[ptr fontT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(fontT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_font_get_type(), cast[ptr fontT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var fontT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_font_t)

type
  fontGetVariationGlyphFuncT* = proc (font: ptr fontT00; fontData: pointer; unicode: uint32; variationSelector: uint32;
    glyph: ptr uint32; userData: pointer): int32 {.cdecl.}

type
  fontGetNominalGlyphsFuncT* = proc (font: ptr fontT00; fontData: pointer; count: uint32; firstUnicode: ptr uint32;
    unicodeStride: uint32; firstGlyph: ptr uint32; glyphStride: uint32; userData: pointer): uint32 {.cdecl.}

type
  fontGetNominalGlyphFuncT* = proc (font: ptr fontT00; fontData: pointer; unicode: uint32; glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.}

type
  fontGetGlyphOriginFuncT* = proc (font: ptr fontT00; fontData: pointer; glyph: uint32; x: ptr int32;
    y: ptr int32; userData: pointer): int32 {.cdecl.}

type
  fontGetGlyphNameFuncT* = proc (font: ptr fontT00; fontData: pointer; glyph: uint32; name: cstring;
    size: uint32; userData: pointer): int32 {.cdecl.}

type
  fontGetGlyphKerningFuncT* = proc (font: ptr fontT00; fontData: pointer; firstGlyph: uint32; secondGlyph: uint32;
    userData: pointer): int32 {.cdecl.}

type
  fontGetGlyphFuncT* = proc (font: ptr fontT00; fontData: pointer; unicode: uint32; variationSelector: uint32;
    glyph: ptr uint32; userData: pointer): int32 {.cdecl.}

type
  fontGetGlyphFromNameFuncT* = proc (font: ptr fontT00; fontData: pointer; name: cstring; len: int32; glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.}

type
  fontGetGlyphContourPointFuncT* = proc (font: ptr fontT00; fontData: pointer; glyph: uint32; pointIndex: uint32;
    x: ptr int32; y: ptr int32; userData: pointer): int32 {.cdecl.}

type
  fontGetGlyphAdvancesFuncT* = proc (font: ptr fontT00; fontData: pointer; count: uint32; firstGlyph: ptr uint32;
    glyphStride: uint32; firstAdvance: ptr int32; advanceStride: uint32; userData: pointer) {.cdecl.}

type
  fontGetGlyphAdvanceFuncT* = proc (font: ptr fontT00; fontData: pointer; glyph: uint32; userData: pointer): int32 {.cdecl.}

type
  fontGetFontExtentsFuncT* = proc (font: ptr fontT00; fontData: pointer; extents: ptr fontExtentsT00;
    userData: pointer): int32 {.cdecl.}

type
  bufferMessageFuncT* = proc (buffer: ptr bufferT00; font: ptr fontT00; message: cstring; userData: pointer): int32 {.cdecl.}

proc hb_buffer_deserialize_glyphs(buffer: ptr bufferT00; buf: ptr cstring;
    bufLen: int32; endPtr: var cstring; font: ptr fontT00; format: bufferSerializeFormatT): int32 {.
    importc, libprag.}

proc bufferDeserializeGlyphs*(buffer: bufferT; buf: openArray[string];
    bufLen: int; endPtr: var string; font: fontT; format: bufferSerializeFormatT): int =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var endPtr_00: cstring
  result = int(hb_buffer_deserialize_glyphs(cast[ptr bufferT00](buffer.impl), seq2CstringArray(buf, fs469n23), int32(bufLen), endPtr_00, cast[ptr fontT00](font.impl), format))
  if endPtr.addr != nil:
    endPtr = $(endPtr_00)

proc hb_buffer_serialize(buffer: ptr bufferT00; start: uint32; `end`: uint32;
    buf: var ptr uint8; bufSize: var uint32; bufConsumed: var uint32; font: ptr fontT00;
    format: bufferSerializeFormatT; flags: bufferSerializeFlagsT): uint32 {.
    importc, libprag.}

proc bufferSerialize*(buffer: bufferT; start: int; `end`: int; buf: var (seq[uint8] | string);
    bufSize: var int; bufConsumed: var int = cast[var int](nil); font: fontT = nil;
    format: bufferSerializeFormatT; flags: bufferSerializeFlagsT): int =
  var bufSize_00: uint32
  var bufConsumed_00: uint32
  var buf_00: ptr uint8
  result = int(hb_buffer_serialize(cast[ptr bufferT00](buffer.impl), uint32(start), uint32(`end`), buf_00, bufSize_00, bufConsumed_00, if font.isNil: nil else: cast[ptr fontT00](font.impl), format, flags))
  if bufSize.addr != nil:
    bufSize = int(bufSize_00)
  if bufConsumed.addr != nil:
    bufConsumed = int(bufConsumed_00)
  buf.setLen(bufSize)
  copyMem(unsafeaddr buf[0], buf_00, bufSize.int * sizeof(buf[0]))
  cogfree(buf_00)

proc hb_buffer_serialize_glyphs(buffer: ptr bufferT00; start: uint32; `end`: uint32;
    buf: var ptr uint8; bufSize: var uint32; bufConsumed: var uint32; font: ptr fontT00;
    format: bufferSerializeFormatT; flags: bufferSerializeFlagsT): uint32 {.
    importc, libprag.}

proc bufferSerializeGlyphs*(buffer: bufferT; start: int; `end`: int;
    buf: var (seq[uint8] | string); bufSize: var int; bufConsumed: var int = cast[var int](nil);
    font: fontT = nil; format: bufferSerializeFormatT; flags: bufferSerializeFlagsT): int =
  var bufSize_00: uint32
  var bufConsumed_00: uint32
  var buf_00: ptr uint8
  result = int(hb_buffer_serialize_glyphs(cast[ptr bufferT00](buffer.impl), uint32(start), uint32(`end`), buf_00, bufSize_00, bufConsumed_00, if font.isNil: nil else: cast[ptr fontT00](font.impl), format, flags))
  if bufSize.addr != nil:
    bufSize = int(bufSize_00)
  if bufConsumed.addr != nil:
    bufConsumed = int(bufConsumed_00)
  buf.setLen(bufSize)
  copyMem(unsafeaddr buf[0], buf_00, bufSize.int * sizeof(buf[0]))
  cogfree(buf_00)

proc hb_buffer_set_message_func(buffer: ptr bufferT00; `func`: proc(buffer: ptr bufferT00;
    font: ptr fontT00; message: cstring; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc bufferSetMessageFunc*(buffer: bufferT; `func`: proc(buffer: ptr bufferT00;
    font: ptr fontT00; message: cstring; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_buffer_set_message_func(cast[ptr bufferT00](buffer.impl), `func`, userData, destroy)

proc hb_font_add_glyph_origin_for_direction(font: ptr fontT00; glyph: uint32;
    direction: directionT; x: var int32; y: var int32) {.
    importc, libprag.}

proc fontAddGlyphOriginForDirection*(font: fontT; glyph: int; direction: directionT;
    x: var int; y: var int) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  hb_font_add_glyph_origin_for_direction(cast[ptr fontT00](font.impl), uint32(glyph), direction, x_00, y_00)
  y = int(y_00)
  x = int(x_00)

proc hb_font_create(face: ptr faceT00): ptr fontT00 {.
    importc, libprag.}

proc fontCreate*(face: faceT): fontT =
  fnew(result, gBoxedFreehb_font_t)
  result.impl = hb_font_create(cast[ptr faceT00](face.impl))

proc hb_font_create_sub_font(parent: ptr fontT00): ptr fontT00 {.
    importc, libprag.}

proc fontCreateSubFont*(parent: fontT): fontT =
  fnew(result, gBoxedFreehb_font_t)
  result.impl = hb_font_create_sub_font(cast[ptr fontT00](parent.impl))

proc hb_font_funcs_set_font_h_extents_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; extents: ptr fontExtentsT00;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetFontHExtentsFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; extents: ptr fontExtentsT00;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_font_h_extents_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_font_v_extents_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; extents: ptr fontExtentsT00;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetFontVExtentsFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; extents: ptr fontExtentsT00;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_font_v_extents_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_contour_point_func(ffuncs: ptr fontFuncsT00;
    `func`: proc(font: ptr fontT00; fontData: pointer; glyph: uint32; pointIndex: uint32;
   
    x: ptr int32; y: ptr int32; userData: pointer): int32 {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphContourPointFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; pointIndex: uint32;
    x: ptr int32;
    y: ptr int32; userData: pointer): int32 {.cdecl.}; userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_contour_point_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_from_name_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; name: cstring; len: int32; glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphFromNameFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; name: cstring; len: int32; glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_from_name_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; unicode: uint32; variationSelector: uint32;
    glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.}; userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; unicode: uint32; variationSelector: uint32;
    glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.}; userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_h_advance_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphHAdvanceFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_h_advance_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_h_advances_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; count: uint32; firstGlyph: ptr uint32;
    glyphStride: uint32;
    firstAdvance: ptr int32; advanceStride: uint32; userData: pointer) {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphHAdvancesFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; count: uint32; firstGlyph: ptr uint32;
    glyphStride: uint32;
    firstAdvance: ptr int32; advanceStride: uint32; userData: pointer) {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_h_advances_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_h_kerning_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; firstGlyph: uint32; secondGlyph: uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphHKerningFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; firstGlyph: uint32; secondGlyph: uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_h_kerning_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_h_origin_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; x: ptr int32;
    y: ptr int32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphHOriginFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; x: ptr int32;
    y: ptr int32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_h_origin_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_name_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; name: cstring;
    size: uint32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphNameFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; name: cstring;
    size: uint32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_name_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_v_advance_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphVAdvanceFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_v_advance_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_v_advances_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; count: uint32; firstGlyph: ptr uint32;
    glyphStride: uint32;
    firstAdvance: ptr int32; advanceStride: uint32; userData: pointer) {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphVAdvancesFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; count: uint32; firstGlyph: ptr uint32;
    glyphStride: uint32;
    firstAdvance: ptr int32; advanceStride: uint32; userData: pointer) {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_v_advances_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_v_kerning_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; firstGlyph: uint32; secondGlyph: uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphVKerningFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; firstGlyph: uint32; secondGlyph: uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_v_kerning_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_glyph_v_origin_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; x: ptr int32;
    y: ptr int32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphVOriginFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; x: ptr int32;
    y: ptr int32; userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_v_origin_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_nominal_glyph_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; unicode: uint32; glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetNominalGlyphFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; unicode: uint32; glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_nominal_glyph_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_nominal_glyphs_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; count: uint32; firstUnicode: ptr uint32;
    unicodeStride: uint32;
    firstGlyph: ptr uint32; glyphStride: uint32; userData: pointer): uint32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetNominalGlyphsFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; count: uint32; firstUnicode: ptr uint32;
    unicodeStride: uint32;
    firstGlyph: ptr uint32; glyphStride: uint32; userData: pointer): uint32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_nominal_glyphs_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_funcs_set_variation_glyph_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; unicode: uint32; variationSelector: uint32;
    glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.}; userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetVariationGlyphFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; unicode: uint32; variationSelector: uint32;
    glyph: ptr uint32;
    userData: pointer): int32 {.cdecl.}; userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_variation_glyph_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_get_empty(): ptr fontT00 {.
    importc, libprag.}

proc fontGetEmpty*(): fontT =
  fnew(result, gBoxedFreehb_font_t)
  result.impl = hb_font_get_empty()

proc hb_font_get_extents_for_direction(font: ptr fontT00; direction: directionT;
    extents: var fontExtentsT00) {.
    importc, libprag.}

proc fontGetExtentsForDirection*(font: fontT; direction: directionT;
    extents: var fontExtentsT00) =
  hb_font_get_extents_for_direction(cast[ptr fontT00](font.impl), direction, extents)

proc hb_font_get_face(font: ptr fontT00): ptr faceT00 {.
    importc, libprag.}

proc fontGetFace*(font: fontT): faceT =
  fnew(result, gBoxedFreehb_face_t)
  result.impl = hb_font_get_face(cast[ptr fontT00](font.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(hb_gobject_face_get_type(), result.impl))

proc hb_font_get_glyph(font: ptr fontT00; unicode: uint32; variationSelector: uint32;
    glyph: var uint32): int32 {.
    importc, libprag.}

proc fontGetGlyph*(font: fontT; unicode: int; variationSelector: int;
    glyph: var int): int =
  var glyph_00: uint32
  result = int(hb_font_get_glyph(cast[ptr fontT00](font.impl), uint32(unicode), uint32(variationSelector), glyph_00))
  if glyph.addr != nil:
    glyph = int(glyph_00)

proc hb_font_get_glyph_advance_for_direction(font: ptr fontT00; glyph: uint32;
    direction: directionT; x: var int32; y: var int32) {.
    importc, libprag.}

proc fontGetGlyphAdvanceForDirection*(font: fontT; glyph: int; direction: directionT;
    x: var int; y: var int) =
  var y_00: int32
  var x_00: int32
  hb_font_get_glyph_advance_for_direction(cast[ptr fontT00](font.impl), uint32(glyph), direction, x_00, y_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc hb_font_get_glyph_advances_for_direction(font: ptr fontT00; direction: directionT;
    count: uint32; firstGlyph: ptr uint32; glyphStride: uint32; firstAdvance: var int32;
    advanceStride: var uint32) {.
    importc, libprag.}

proc fontGetGlyphAdvancesForDirection*(font: fontT; direction: directionT;
    count: int; firstGlyph: ptr uint32; glyphStride: int; firstAdvance: var int;
    advanceStride: var int) =
  var firstAdvance_00: int32
  var advanceStride_00: uint32
  hb_font_get_glyph_advances_for_direction(cast[ptr fontT00](font.impl), direction, uint32(count), firstGlyph, uint32(glyphStride), firstAdvance_00, advanceStride_00)
  if firstAdvance.addr != nil:
    firstAdvance = int(firstAdvance_00)
  if advanceStride.addr != nil:
    advanceStride = int(advanceStride_00)

proc hb_font_get_glyph_contour_point(font: ptr fontT00; glyph: uint32; pointIndex: uint32;
    x: var int32; y: var int32): int32 {.
    importc, libprag.}

proc fontGetGlyphContourPoint*(font: fontT; glyph: int; pointIndex: int;
    x: var int; y: var int): int =
  var y_00: int32
  var x_00: int32
  result = int(hb_font_get_glyph_contour_point(cast[ptr fontT00](font.impl), uint32(glyph), uint32(pointIndex), x_00, y_00))
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc hb_font_get_glyph_contour_point_for_origin(font: ptr fontT00; glyph: uint32;
    pointIndex: uint32; direction: directionT; x: var int32; y: var int32): int32 {.
    importc, libprag.}

proc fontGetGlyphContourPointForOrigin*(font: fontT; glyph: int;
    pointIndex: int; direction: directionT; x: var int; y: var int): int =
  var y_00: int32
  var x_00: int32
  result = int(hb_font_get_glyph_contour_point_for_origin(cast[ptr fontT00](font.impl), uint32(glyph), uint32(pointIndex), direction, x_00, y_00))
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc hb_font_get_glyph_from_name(font: ptr fontT00; name: ptr cstring; len: int32;
    glyph: var uint32): int32 {.
    importc, libprag.}

proc fontGetGlyphFromName*(font: fontT; name: openArray[string]; len: int;
    glyph: var int): int =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var glyph_00: uint32
  result = int(hb_font_get_glyph_from_name(cast[ptr fontT00](font.impl), seq2CstringArray(name, fs469n23), int32(len), glyph_00))
  if glyph.addr != nil:
    glyph = int(glyph_00)

proc hb_font_get_glyph_h_advance(font: ptr fontT00; glyph: uint32): int32 {.
    importc, libprag.}

proc fontGetGlyphHAdvance*(font: fontT; glyph: int): int =
  int(hb_font_get_glyph_h_advance(cast[ptr fontT00](font.impl), uint32(glyph)))

proc hb_font_get_glyph_h_advances(font: ptr fontT00; count: uint32; firstGlyph: ptr uint32;
    glyphStride: uint32; firstAdvance: var int32; advanceStride: var uint32) {.
    importc, libprag.}

proc fontGetGlyphHAdvances*(font: fontT; count: int; firstGlyph: ptr uint32;
    glyphStride: int; firstAdvance: var int; advanceStride: var int) =
  var firstAdvance_00: int32
  var advanceStride_00: uint32
  hb_font_get_glyph_h_advances(cast[ptr fontT00](font.impl), uint32(count), firstGlyph, uint32(glyphStride), firstAdvance_00, advanceStride_00)
  if firstAdvance.addr != nil:
    firstAdvance = int(firstAdvance_00)
  if advanceStride.addr != nil:
    advanceStride = int(advanceStride_00)

proc hb_font_get_glyph_h_kerning(font: ptr fontT00; leftGlyph: uint32; rightGlyph: uint32): int32 {.
    importc, libprag.}

proc fontGetGlyphHKerning*(font: fontT; leftGlyph: int; rightGlyph: int): int =
  int(hb_font_get_glyph_h_kerning(cast[ptr fontT00](font.impl), uint32(leftGlyph), uint32(rightGlyph)))

proc hb_font_get_glyph_h_origin(font: ptr fontT00; glyph: uint32; x: var int32;
    y: var int32): int32 {.
    importc, libprag.}

proc fontGetGlyphHOrigin*(font: fontT; glyph: int; x: var int; y: var int): int =
  var y_00: int32
  var x_00: int32
  result = int(hb_font_get_glyph_h_origin(cast[ptr fontT00](font.impl), uint32(glyph), x_00, y_00))
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc hb_font_get_glyph_kerning_for_direction(font: ptr fontT00; firstGlyph: uint32;
    secondGlyph: uint32; direction: directionT; x: var int32; y: var int32) {.
    importc, libprag.}

proc fontGetGlyphKerningForDirection*(font: fontT; firstGlyph: int;
    secondGlyph: int; direction: directionT; x: var int; y: var int) =
  var y_00: int32
  var x_00: int32
  hb_font_get_glyph_kerning_for_direction(cast[ptr fontT00](font.impl), uint32(firstGlyph), uint32(secondGlyph), direction, x_00, y_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc hb_font_get_glyph_name(font: ptr fontT00; glyph: uint32; name: var ptr cstring;
    size: var uint32): int32 {.
    importc, libprag.}

proc fontGetGlyphName*(font: fontT; glyph: int; name: var seq[string];
    size: var int): int =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var name_00 = seq2CstringArray(name, fs469n23)
  var size_00: uint32
  result = int(hb_font_get_glyph_name(cast[ptr fontT00](font.impl), uint32(glyph), name_00, size_00))
  if name.addr != nil:
    name = cstringArrayToSeq(name_00)
  if size.addr != nil:
    size = int(size_00)

proc hb_font_get_glyph_origin_for_direction(font: ptr fontT00; glyph: uint32;
    direction: directionT; x: var int32; y: var int32) {.
    importc, libprag.}

proc fontGetGlyphOriginForDirection*(font: fontT; glyph: int; direction: directionT;
    x: var int; y: var int) =
  var y_00: int32
  var x_00: int32
  hb_font_get_glyph_origin_for_direction(cast[ptr fontT00](font.impl), uint32(glyph), direction, x_00, y_00)
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc hb_font_get_glyph_v_advance(font: ptr fontT00; glyph: uint32): int32 {.
    importc, libprag.}

proc fontGetGlyphVAdvance*(font: fontT; glyph: int): int =
  int(hb_font_get_glyph_v_advance(cast[ptr fontT00](font.impl), uint32(glyph)))

proc hb_font_get_glyph_v_advances(font: ptr fontT00; count: uint32; firstGlyph: ptr uint32;
    glyphStride: uint32; firstAdvance: var int32; advanceStride: var uint32) {.
    importc, libprag.}

proc fontGetGlyphVAdvances*(font: fontT; count: int; firstGlyph: ptr uint32;
    glyphStride: int; firstAdvance: var int; advanceStride: var int) =
  var firstAdvance_00: int32
  var advanceStride_00: uint32
  hb_font_get_glyph_v_advances(cast[ptr fontT00](font.impl), uint32(count), firstGlyph, uint32(glyphStride), firstAdvance_00, advanceStride_00)
  if firstAdvance.addr != nil:
    firstAdvance = int(firstAdvance_00)
  if advanceStride.addr != nil:
    advanceStride = int(advanceStride_00)

proc hb_font_get_glyph_v_kerning(font: ptr fontT00; topGlyph: uint32; bottomGlyph: uint32): int32 {.
    importc, libprag.}

proc fontGetGlyphVKerning*(font: fontT; topGlyph: int; bottomGlyph: int): int =
  int(hb_font_get_glyph_v_kerning(cast[ptr fontT00](font.impl), uint32(topGlyph), uint32(bottomGlyph)))

proc hb_font_get_glyph_v_origin(font: ptr fontT00; glyph: uint32; x: var int32;
    y: var int32): int32 {.
    importc, libprag.}

proc fontGetGlyphVOrigin*(font: fontT; glyph: int; x: var int; y: var int): int =
  var y_00: int32
  var x_00: int32
  result = int(hb_font_get_glyph_v_origin(cast[ptr fontT00](font.impl), uint32(glyph), x_00, y_00))
  if y.addr != nil:
    y = int(y_00)
  if x.addr != nil:
    x = int(x_00)

proc hb_font_get_h_extents(font: ptr fontT00; extents: var fontExtentsT00): int32 {.
    importc, libprag.}

proc fontGetHExtents*(font: fontT; extents: var fontExtentsT00): int =
  int(hb_font_get_h_extents(cast[ptr fontT00](font.impl), extents))

proc hb_font_get_nominal_glyph(font: ptr fontT00; unicode: uint32; glyph: var uint32): int32 {.
    importc, libprag.}

proc fontGetNominalGlyph*(font: fontT; unicode: int; glyph: var int): int =
  var glyph_00: uint32
  result = int(hb_font_get_nominal_glyph(cast[ptr fontT00](font.impl), uint32(unicode), glyph_00))
  if glyph.addr != nil:
    glyph = int(glyph_00)

proc hb_font_get_nominal_glyphs(font: ptr fontT00; count: uint32; firstUnicode: ptr uint32;
    unicodeStride: uint32; firstGlyph: ptr uint32; glyphStride: uint32): uint32 {.
    importc, libprag.}

proc fontGetNominalGlyphs*(font: fontT; count: int; firstUnicode: ptr uint32;
    unicodeStride: int; firstGlyph: ptr uint32; glyphStride: int): int =
  int(hb_font_get_nominal_glyphs(cast[ptr fontT00](font.impl), uint32(count), firstUnicode, uint32(unicodeStride), firstGlyph, uint32(glyphStride)))

proc hb_font_get_parent(font: ptr fontT00): ptr fontT00 {.
    importc, libprag.}

proc fontGetParent*(font: fontT): fontT =
  fnew(result, gBoxedFreehb_font_t)
  result.impl = hb_font_get_parent(cast[ptr fontT00](font.impl))
  result.impl = cast[typeof(result.impl)](g_boxed_copy(hb_gobject_font_get_type(), result.impl))

proc hb_font_get_ppem(font: ptr fontT00; xPpem: var uint32; yPpem: var uint32) {.
    importc, libprag.}

proc fontGetPpem*(font: fontT; xPpem: var int; yPpem: var int) =
  var yPpem_00: uint32
  var xPpem_00: uint32
  hb_font_get_ppem(cast[ptr fontT00](font.impl), xPpem_00, yPpem_00)
  if yPpem.addr != nil:
    yPpem = int(yPpem_00)
  if xPpem.addr != nil:
    xPpem = int(xPpem_00)

proc hb_font_get_ptem(font: ptr fontT00): cfloat {.
    importc, libprag.}

proc fontGetPtem*(font: fontT): cfloat =
  hb_font_get_ptem(cast[ptr fontT00](font.impl))

proc hb_font_get_scale(font: ptr fontT00; xScale: var int32; yScale: var int32) {.
    importc, libprag.}

proc fontGetScale*(font: fontT; xScale: var int; yScale: var int) =
  var yScale_00: int32
  var xScale_00: int32
  hb_font_get_scale(cast[ptr fontT00](font.impl), xScale_00, yScale_00)
  if yScale.addr != nil:
    yScale = int(yScale_00)
  if xScale.addr != nil:
    xScale = int(xScale_00)

proc hb_font_get_v_extents(font: ptr fontT00; extents: var fontExtentsT00): int32 {.
    importc, libprag.}

proc fontGetVExtents*(font: fontT; extents: var fontExtentsT00): int =
  int(hb_font_get_v_extents(cast[ptr fontT00](font.impl), extents))

proc hb_font_get_var_coords_normalized(font: ptr fontT00; length: ptr uint32): ptr int32 {.
    importc, libprag.}

proc fontGetVarCoordsNormalized*(font: fontT; length: ptr uint32): ptr int32 =
  hb_font_get_var_coords_normalized(cast[ptr fontT00](font.impl), length)

proc hb_font_get_variation_glyph(font: ptr fontT00; unicode: uint32; variationSelector: uint32;
    glyph: var uint32): int32 {.
    importc, libprag.}

proc fontGetVariationGlyph*(font: fontT; unicode: int; variationSelector: int;
    glyph: var int): int =
  var glyph_00: uint32
  result = int(hb_font_get_variation_glyph(cast[ptr fontT00](font.impl), uint32(unicode), uint32(variationSelector), glyph_00))
  if glyph.addr != nil:
    glyph = int(glyph_00)

proc hb_font_glyph_from_string(font: ptr fontT00; s: ptr uint8; len: int32;
    glyph: var uint32): int32 {.
    importc, libprag.}

proc fontGlyphFromString*(font: fontT; s: seq[uint8] | string; glyph: var int): int =
  let len = int(s.len)
  var glyph_00: uint32
  result = int(hb_font_glyph_from_string(cast[ptr fontT00](font.impl), cast[ptr uint8](unsafeaddr(s[0])), int32(len), glyph_00))
  if glyph.addr != nil:
    glyph = int(glyph_00)

proc hb_font_glyph_to_string(font: ptr fontT00; glyph: uint32; s: var ptr cstring;
    size: var uint32) {.
    importc, libprag.}

proc fontGlyphToString*(font: fontT; glyph: int; s: var seq[string];
    size: var int) =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var s_00 = seq2CstringArray(s, fs469n23)
  var size_00: uint32
  hb_font_glyph_to_string(cast[ptr fontT00](font.impl), uint32(glyph), s_00, size_00)
  if s.addr != nil:
    s = cstringArrayToSeq(s_00)
  if size.addr != nil:
    size = int(size_00)

proc hb_font_is_immutable(font: ptr fontT00): int32 {.
    importc, libprag.}

proc fontIsImmutable*(font: fontT): int =
  int(hb_font_is_immutable(cast[ptr fontT00](font.impl)))

proc hb_font_make_immutable(font: ptr fontT00) {.
    importc, libprag.}

proc fontMakeImmutable*(font: fontT) =
  hb_font_make_immutable(cast[ptr fontT00](font.impl))

proc hb_font_set_face(font: ptr fontT00; face: ptr faceT00) {.
    importc, libprag.}

proc fontSetFace*(font: fontT; face: faceT) =
  hb_font_set_face(cast[ptr fontT00](font.impl), cast[ptr faceT00](face.impl))

proc hb_font_set_funcs(font: ptr fontT00; klass: ptr fontFuncsT00; fontData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontSetFuncs*(font: fontT; klass: fontFuncsT; fontData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_set_funcs(cast[ptr fontT00](font.impl), cast[ptr fontFuncsT00](klass.impl), fontData, destroy)

proc hb_font_set_funcs_data(font: ptr fontT00; fontData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontSetFuncsData*(font: fontT; fontData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_set_funcs_data(cast[ptr fontT00](font.impl), fontData, destroy)

proc hb_font_set_parent(font: ptr fontT00; parent: ptr fontT00) {.
    importc, libprag.}

proc fontSetParent*(font: fontT; parent: fontT) =
  hb_font_set_parent(cast[ptr fontT00](font.impl), cast[ptr fontT00](parent.impl))

proc hb_font_set_ppem(font: ptr fontT00; xPpem: uint32; yPpem: uint32) {.
    importc, libprag.}

proc fontSetPpem*(font: fontT; xPpem: int; yPpem: int) =
  hb_font_set_ppem(cast[ptr fontT00](font.impl), uint32(xPpem), uint32(yPpem))

proc hb_font_set_ptem(font: ptr fontT00; ptem: cfloat) {.
    importc, libprag.}

proc fontSetPtem*(font: fontT; ptem: cfloat) =
  hb_font_set_ptem(cast[ptr fontT00](font.impl), ptem)

proc hb_font_set_scale(font: ptr fontT00; xScale: int32; yScale: int32) {.
    importc, libprag.}

proc fontSetScale*(font: fontT; xScale: int; yScale: int) =
  hb_font_set_scale(cast[ptr fontT00](font.impl), int32(xScale), int32(yScale))

proc hb_font_set_var_coords_design(font: ptr fontT00; coords: ptr cfloat;
    coordsLength: uint32) {.
    importc, libprag.}

proc fontSetVarCoordsDesign*(font: fontT; coords: ptr cfloat; coordsLength: int) =
  hb_font_set_var_coords_design(cast[ptr fontT00](font.impl), coords, uint32(coordsLength))

proc hb_font_set_var_coords_normalized(font: ptr fontT00; coords: ptr int32;
    coordsLength: uint32) {.
    importc, libprag.}

proc fontSetVarCoordsNormalized*(font: fontT; coords: seq[int32]) =
  let coordsLength = int(coords.len)
  hb_font_set_var_coords_normalized(cast[ptr fontT00](font.impl), cast[ptr int32](unsafeaddr(coords[0])), uint32(coordsLength))

proc hb_font_set_var_named_instance(font: ptr fontT00; instanceIndex: uint32) {.
    importc, libprag.}

proc fontSetVarNamedInstance*(font: fontT; instanceIndex: int) =
  hb_font_set_var_named_instance(cast[ptr fontT00](font.impl), uint32(instanceIndex))

proc hb_font_subtract_glyph_origin_for_direction(font: ptr fontT00; glyph: uint32;
    direction: directionT; x: var int32; y: var int32) {.
    importc, libprag.}

proc fontSubtractGlyphOriginForDirection*(font: fontT; glyph: int;
    direction: directionT; x: var int; y: var int) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  hb_font_subtract_glyph_origin_for_direction(cast[ptr fontT00](font.impl), uint32(glyph), direction, x_00, y_00)
  y = int(y_00)
  x = int(x_00)

proc hb_ft_font_changed(font: ptr fontT00) {.
    importc, libprag.}

proc ftFontChanged*(font: fontT) =
  hb_ft_font_changed(cast[ptr fontT00](font.impl))

proc hb_ft_font_get_load_flags(font: ptr fontT00): int32 {.
    importc, libprag.}

proc ftFontGetLoadFlags*(font: fontT): int =
  int(hb_ft_font_get_load_flags(cast[ptr fontT00](font.impl)))

proc hb_ft_font_set_funcs(font: ptr fontT00) {.
    importc, libprag.}

proc ftFontSetFuncs*(font: fontT) =
  hb_ft_font_set_funcs(cast[ptr fontT00](font.impl))

proc hb_ft_font_set_load_flags(font: ptr fontT00; loadFlags: int32) {.
    importc, libprag.}

proc ftFontSetLoadFlags*(font: fontT; loadFlags: int) =
  hb_ft_font_set_load_flags(cast[ptr fontT00](font.impl), int32(loadFlags))

proc hb_ft_font_unlock_face(font: ptr fontT00) {.
    importc, libprag.}

proc ftFontUnlockFace*(font: fontT) =
  hb_ft_font_unlock_face(cast[ptr fontT00](font.impl))

proc hb_glib_blob_create(gbytes: ptr glib.Bytes00): ptr blobT00 {.
    importc, libprag.}

proc glibBlobCreate*(gbytes: glib.Bytes): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_glib_blob_create(cast[ptr glib.Bytes00](gbytes.impl))

type
  glyphExtentsT00* {.pure.} = object
  glyphExtentsT* = ref object
    impl*: ptr glyphExtentsT00
    ignoreFinalizer*: bool

type
  fontGetGlyphExtentsFuncT* = proc (font: ptr fontT00; fontData: pointer; glyph: uint32; extents: ptr glyphExtentsT00;
    userData: pointer): int32 {.cdecl.}

proc hb_font_funcs_set_glyph_extents_func(ffuncs: ptr fontFuncsT00; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; extents: ptr glyphExtentsT00;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc fontFuncsSetGlyphExtentsFunc*(ffuncs: fontFuncsT; `func`: proc(font: ptr fontT00;
    fontData: pointer; glyph: uint32; extents: ptr glyphExtentsT00;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_font_funcs_set_glyph_extents_func(cast[ptr fontFuncsT00](ffuncs.impl), `func`, userData, destroy)

proc hb_font_get_glyph_extents(font: ptr fontT00; glyph: uint32; extents: var glyphExtentsT00): int32 {.
    importc, libprag.}

proc fontGetGlyphExtents*(font: fontT; glyph: int; extents: var glyphExtentsT00): int =
  int(hb_font_get_glyph_extents(cast[ptr fontT00](font.impl), uint32(glyph), extents))

proc hb_font_get_glyph_extents_for_origin(font: ptr fontT00; glyph: uint32;
    direction: directionT; extents: var glyphExtentsT00): int32 {.
    importc, libprag.}

proc fontGetGlyphExtentsForOrigin*(font: fontT; glyph: int; direction: directionT;
    extents: var glyphExtentsT00): int =
  int(hb_font_get_glyph_extents_for_origin(cast[ptr fontT00](font.impl), uint32(glyph), direction, extents))

type
  glyphFlagsT* {.size: sizeof(cint), pure.} = enum
    defined = 1

const
  glyphFlagsTUnsafeToBreak* = glyphFlagsT.defined

type
  glyphInfoT00* {.pure.} = object
  glyphInfoT* = ref object
    impl*: ptr glyphInfoT00
    ignoreFinalizer*: bool

proc hb_gobject_glyph_info_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_glyph_info_t*(self: glyphInfoT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_glyph_info_get_type(), cast[ptr glyphInfoT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(glyphInfoT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_glyph_info_get_type(), cast[ptr glyphInfoT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var glyphInfoT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_glyph_info_t)

proc hb_buffer_get_glyph_infos(buffer: ptr bufferT00; length: var uint32): ptr glyphInfoT00 {.
    importc, libprag.}

proc bufferGetGlyphInfos*(buffer: bufferT; length: var int): ptr glyphInfoT00 =
  var length_00: uint32
  result = hb_buffer_get_glyph_infos(cast[ptr bufferT00](buffer.impl), length_00)
  if length.addr != nil:
    length = int(length_00)

proc hb_glyph_info_get_glyph_flags(info: ptr glyphInfoT00): glyphFlagsT {.
    importc, libprag.}

proc glyphInfoGetGlyphFlags*(info: glyphInfoT): glyphFlagsT =
  hb_glyph_info_get_glyph_flags(cast[ptr glyphInfoT00](info.impl))

type
  glyphPositionT00* {.pure.} = object
  glyphPositionT* = ref object
    impl*: ptr glyphPositionT00
    ignoreFinalizer*: bool

proc hb_gobject_glyph_position_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_glyph_position_t*(self: glyphPositionT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_glyph_position_get_type(), cast[ptr glyphPositionT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(glyphPositionT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_glyph_position_get_type(), cast[ptr glyphPositionT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var glyphPositionT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_glyph_position_t)

proc hb_buffer_get_glyph_positions(buffer: ptr bufferT00; length: var uint32): ptr glyphPositionT00 {.
    importc, libprag.}

proc bufferGetGlyphPositions*(buffer: bufferT; length: var int): ptr glyphPositionT00 =
  var length_00: uint32
  result = hb_buffer_get_glyph_positions(cast[ptr bufferT00](buffer.impl), length_00)
  if length.addr != nil:
    length = int(length_00)

type
  languageT00* {.pure.} = object
  languageT* = ref object
    impl*: ptr languageT00
    ignoreFinalizer*: bool

proc hb_language_to_string(self: ptr languageT00): cstring {.
    importc, libprag.}

proc stringP*(self: languageT): string =
  result = $hb_language_to_string(cast[ptr languageT00](self.impl))

proc hb_buffer_get_language(buffer: ptr bufferT00): ptr languageT00 {.
    importc, libprag.}

proc bufferGetLanguage*(buffer: bufferT): languageT =
  new(result)
  result.impl = hb_buffer_get_language(cast[ptr bufferT00](buffer.impl))
  result.ignoreFinalizer = true

proc hb_buffer_set_language(buffer: ptr bufferT00; language: ptr languageT00) {.
    importc, libprag.}

proc bufferSetLanguage*(buffer: bufferT; language: languageT) =
  hb_buffer_set_language(cast[ptr bufferT00](buffer.impl), cast[ptr languageT00](language.impl))

proc hb_language_from_string(str: ptr uint8; len: int32): ptr languageT00 {.
    importc, libprag.}

proc languageFromString*(str: seq[uint8] | string): languageT =
  let len = int(str.len)
  new(result)
  result.impl = hb_language_from_string(cast[ptr uint8](unsafeaddr(str[0])), int32(len))
  result.ignoreFinalizer = true

proc hb_language_get_default(): ptr languageT00 {.
    importc, libprag.}

proc languageGetDefault*(): languageT =
  new(result)
  result.impl = hb_language_get_default()
  result.ignoreFinalizer = true

type
  mapT00* {.pure.} = object
  mapT* = ref object
    impl*: ptr mapT00
    ignoreFinalizer*: bool

proc hb_gobject_map_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_map_t*(self: mapT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_map_get_type(), cast[ptr mapT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(mapT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_map_get_type(), cast[ptr mapT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var mapT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_map_t)

proc hb_map_allocation_successful(map: ptr mapT00): int32 {.
    importc, libprag.}

proc mapAllocationSuccessful*(map: mapT): int =
  int(hb_map_allocation_successful(cast[ptr mapT00](map.impl)))

proc hb_map_clear(map: ptr mapT00) {.
    importc, libprag.}

proc mapClear*(map: mapT) =
  hb_map_clear(cast[ptr mapT00](map.impl))

proc hb_map_create(): ptr mapT00 {.
    importc, libprag.}

proc mapCreate*(): mapT =
  fnew(result, gBoxedFreehb_map_t)
  result.impl = hb_map_create()

proc hb_map_del(map: ptr mapT00; key: uint32) {.
    importc, libprag.}

proc mapDel*(map: mapT; key: int) =
  hb_map_del(cast[ptr mapT00](map.impl), uint32(key))

proc hb_map_get(map: ptr mapT00; key: uint32): uint32 {.
    importc, libprag.}

proc mapGet*(map: mapT; key: int): int =
  int(hb_map_get(cast[ptr mapT00](map.impl), uint32(key)))

proc hb_map_get_empty(): ptr mapT00 {.
    importc, libprag.}

proc mapGetEmpty*(): mapT =
  fnew(result, gBoxedFreehb_map_t)
  result.impl = hb_map_get_empty()

proc hb_map_get_population(map: ptr mapT00): uint32 {.
    importc, libprag.}

proc mapGetPopulation*(map: mapT): int =
  int(hb_map_get_population(cast[ptr mapT00](map.impl)))

proc hb_map_has(map: ptr mapT00; key: uint32): int32 {.
    importc, libprag.}

proc mapHas*(map: mapT; key: int): int =
  int(hb_map_has(cast[ptr mapT00](map.impl), uint32(key)))

proc hb_map_is_empty(map: ptr mapT00): int32 {.
    importc, libprag.}

proc mapIsEmpty*(map: mapT): int =
  int(hb_map_is_empty(cast[ptr mapT00](map.impl)))

proc hb_map_set(map: ptr mapT00; key: uint32; value: uint32) {.
    importc, libprag.}

proc mapSet*(map: mapT; key: int; value: int) =
  hb_map_set(cast[ptr mapT00](map.impl), uint32(key), uint32(value))

type
  memoryModeT* {.size: sizeof(cint), pure.} = enum
    duplicate = 0
    readonly = 1
    writable = 2
    readonlyMayMakeWritable = 3

proc hb_ot_color_glyph_reference_png(font: ptr fontT00; glyph: uint32): ptr blobT00 {.
    importc, libprag.}

proc otColorGlyphReferencePng*(font: fontT; glyph: int): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_ot_color_glyph_reference_png(cast[ptr fontT00](font.impl), uint32(glyph))

proc hb_ot_color_glyph_reference_svg(face: ptr faceT00; glyph: uint32): ptr blobT00 {.
    importc, libprag.}

proc otColorGlyphReferenceSvg*(face: faceT; glyph: int): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_ot_color_glyph_reference_svg(cast[ptr faceT00](face.impl), uint32(glyph))

proc hb_ot_color_has_layers(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otColorHasLayers*(face: faceT): int =
  int(hb_ot_color_has_layers(cast[ptr faceT00](face.impl)))

proc hb_ot_color_has_palettes(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otColorHasPalettes*(face: faceT): int =
  int(hb_ot_color_has_palettes(cast[ptr faceT00](face.impl)))

proc hb_ot_color_has_png(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otColorHasPng*(face: faceT): int =
  int(hb_ot_color_has_png(cast[ptr faceT00](face.impl)))

proc hb_ot_color_has_svg(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otColorHasSvg*(face: faceT): int =
  int(hb_ot_color_has_svg(cast[ptr faceT00](face.impl)))

type
  otColorLayerT00* {.pure.} = object
  otColorLayerT* = ref object
    impl*: ptr otColorLayerT00
    ignoreFinalizer*: bool

proc hb_ot_color_glyph_get_layers(face: ptr faceT00; glyph: uint32; startOffset: uint32;
    layerCount: var uint32; layers: var ptr otColorLayerT00): uint32 {.
    importc, libprag.}

proc otColorGlyphGetLayers*(face: faceT; glyph: int; startOffset: int;
    layerCount: var int = cast[var int](nil); layers: var ptr otColorLayerT00): int =
  var layerCount_00: uint32
  result = int(hb_ot_color_glyph_get_layers(cast[ptr faceT00](face.impl), uint32(glyph), uint32(startOffset), layerCount_00, layers))
  if layerCount.addr != nil:
    layerCount = int(layerCount_00)

proc hb_ot_color_palette_color_get_name_id(face: ptr faceT00; colorIndex: uint32): uint32 {.
    importc, libprag.}

proc otColorPaletteColorGetNameId*(face: faceT; colorIndex: int): int =
  int(hb_ot_color_palette_color_get_name_id(cast[ptr faceT00](face.impl), uint32(colorIndex)))

type
  otColorPaletteFlagsT* {.size: sizeof(cint), pure.} = enum
    default = 0
    usableWithLightBackground = 1
    usableWithDarkBackground = 2

proc hb_ot_color_palette_get_colors(face: ptr faceT00; paletteIndex: uint32;
    startOffset: uint32; colorCount: var uint32; colors: var ptr uint32): uint32 {.
    importc, libprag.}

proc otColorPaletteGetColors*(face: faceT; paletteIndex: int; startOffset: int;
    colorCount: var int = cast[var int](nil); colors: var seq[uint32]): int =
  var colorCount_00: uint32
  var colors_00: ptr uint32
  result = int(hb_ot_color_palette_get_colors(cast[ptr faceT00](face.impl), uint32(paletteIndex), uint32(startOffset), colorCount_00, colors_00))
  if colorCount.addr != nil:
    colorCount = int(colorCount_00)
  colors.setLen(colorCount)
  copyMem(unsafeaddr colors[0], colors_00, colorCount.int * sizeof(colors[0]))
  cogfree(colors_00)

proc hb_ot_color_palette_get_count(face: ptr faceT00): uint32 {.
    importc, libprag.}

proc otColorPaletteGetCount*(face: faceT): int =
  int(hb_ot_color_palette_get_count(cast[ptr faceT00](face.impl)))

proc hb_ot_color_palette_get_flags(face: ptr faceT00; paletteIndex: uint32): otColorPaletteFlagsT {.
    importc, libprag.}

proc otColorPaletteGetFlags*(face: faceT; paletteIndex: int): otColorPaletteFlagsT =
  hb_ot_color_palette_get_flags(cast[ptr faceT00](face.impl), uint32(paletteIndex))

proc hb_ot_color_palette_get_name_id(face: ptr faceT00; paletteIndex: uint32): uint32 {.
    importc, libprag.}

proc otColorPaletteGetNameId*(face: faceT; paletteIndex: int): int =
  int(hb_ot_color_palette_get_name_id(cast[ptr faceT00](face.impl), uint32(paletteIndex)))

proc hb_ot_font_set_funcs(font: ptr fontT00) {.
    importc, libprag.}

proc otFontSetFuncs*(font: fontT) =
  hb_ot_font_set_funcs(cast[ptr fontT00](font.impl))

type
  otLayoutBaselineTagT* {.size: sizeof(cint), pure.} = enum
    hanging = 1751215719
    ideoFaceBottomOrLeft = 1768121954
    ideoFaceTopOrRight = 1768121972
    ideoEmboxBottomOrLeft = 1768187247
    ideoEmboxTopOrRight = 1768191088
    math = 1835103336
    roman = 1919905134

proc hb_ot_layout_feature_get_characters(face: ptr faceT00; tableTag: uint32;
    featureIndex: uint32; startOffset: uint32; charCount: var uint32; characters: ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutFeatureGetCharacters*(face: faceT; tableTag: int; featureIndex: int;
    startOffset: int; charCount: var int; characters: var seq[uint32]): int =
  var charCount_00: uint32
  result = int(hb_ot_layout_feature_get_characters(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(featureIndex), uint32(startOffset), charCount_00, cast[ptr uint32](unsafeaddr(characters[0]))))
  if charCount.addr != nil:
    charCount = int(charCount_00)

proc hb_ot_layout_feature_get_lookups(face: ptr faceT00; tableTag: uint32;
    featureIndex: uint32; startOffset: uint32; lookupCount: var uint32; lookupIndexes: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutFeatureGetLookups*(face: faceT; tableTag: int; featureIndex: int;
    startOffset: int; lookupCount: var int; lookupIndexes: var seq[uint32]): int =
  var lookupIndexes_00: ptr uint32
  var lookupCount_00: uint32
  result = int(hb_ot_layout_feature_get_lookups(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(featureIndex), uint32(startOffset), lookupCount_00, lookupIndexes_00))
  lookupIndexes.setLen(lookupCount)
  copyMem(unsafeaddr lookupIndexes[0], lookupIndexes_00, lookupCount.int * sizeof(lookupIndexes[0]))
  cogfree(lookupIndexes_00)
  if lookupCount.addr != nil:
    lookupCount = int(lookupCount_00)

proc hb_ot_layout_feature_get_name_ids(face: ptr faceT00; tableTag: uint32;
    featureIndex: uint32; labelId: var uint32; tooltipId: var uint32; sampleId: var uint32;
    numNamedParameters: var uint32; firstParamId: var uint32): int32 {.
    importc, libprag.}

proc otLayoutFeatureGetNameIds*(face: faceT; tableTag: int; featureIndex: int;
    labelId: var int = cast[var int](nil); tooltipId: var int = cast[var int](nil);
    sampleId: var int = cast[var int](nil); numNamedParameters: var int = cast[var int](nil);
    firstParamId: var int = cast[var int](nil)): int =
  var firstParamId_00: uint32
  var tooltipId_00: uint32
  var labelId_00: uint32
  var numNamedParameters_00: uint32
  var sampleId_00: uint32
  result = int(hb_ot_layout_feature_get_name_ids(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(featureIndex), labelId_00, tooltipId_00, sampleId_00, numNamedParameters_00, firstParamId_00))
  if firstParamId.addr != nil:
    firstParamId = int(firstParamId_00)
  if tooltipId.addr != nil:
    tooltipId = int(tooltipId_00)
  if labelId.addr != nil:
    labelId = int(labelId_00)
  if numNamedParameters.addr != nil:
    numNamedParameters = int(numNamedParameters_00)
  if sampleId.addr != nil:
    sampleId = int(sampleId_00)

proc hb_ot_layout_feature_with_variations_get_lookups(face: ptr faceT00;
    tableTag: uint32; featureIndex: uint32; variationsIndex: uint32; startOffset: uint32;
    lookupCount: var uint32; lookupIndexes: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutFeatureWithVariationsGetLookups*(face: faceT; tableTag: int;
    featureIndex: int; variationsIndex: int; startOffset: int; lookupCount: var int;
    lookupIndexes: var seq[uint32]): int =
  var lookupIndexes_00: ptr uint32
  var lookupCount_00: uint32
  result = int(hb_ot_layout_feature_with_variations_get_lookups(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(featureIndex), uint32(variationsIndex), uint32(startOffset), lookupCount_00, lookupIndexes_00))
  lookupIndexes.setLen(lookupCount)
  copyMem(unsafeaddr lookupIndexes[0], lookupIndexes_00, lookupCount.int * sizeof(lookupIndexes[0]))
  cogfree(lookupIndexes_00)
  if lookupCount.addr != nil:
    lookupCount = int(lookupCount_00)

proc hb_ot_layout_get_attach_points(face: ptr faceT00; glyph: uint32; startOffset: uint32;
    pointCount: var uint32; pointArray: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutGetAttachPoints*(face: faceT; glyph: int; startOffset: int;
    pointCount: var int; pointArray: var seq[uint32]): int =
  var pointCount_00: uint32
  var pointArray_00: ptr uint32
  result = int(hb_ot_layout_get_attach_points(cast[ptr faceT00](face.impl), uint32(glyph), uint32(startOffset), pointCount_00, pointArray_00))
  if pointCount.addr != nil:
    pointCount = int(pointCount_00)
  pointArray.setLen(pointCount)
  copyMem(unsafeaddr pointArray[0], pointArray_00, pointCount.int * sizeof(pointArray[0]))
  cogfree(pointArray_00)

proc hb_ot_layout_get_baseline(font: ptr fontT00; baselineTag: otLayoutBaselineTagT;
    direction: directionT; scriptTag: uint32; languageTag: uint32; coord: var int32): int32 {.
    importc, libprag.}

proc otLayoutGetBaseline*(font: fontT; baselineTag: otLayoutBaselineTagT;
    direction: directionT; scriptTag: int; languageTag: int; coord: var int): int =
  var coord_00: int32
  result = int(hb_ot_layout_get_baseline(cast[ptr fontT00](font.impl), baselineTag, direction, uint32(scriptTag), uint32(languageTag), coord_00))
  if coord.addr != nil:
    coord = int(coord_00)

proc hb_ot_layout_get_ligature_carets(font: ptr fontT00; direction: directionT;
    glyph: uint32; startOffset: uint32; caretCount: var uint32; caretArray: var ptr int32): uint32 {.
    importc, libprag.}

proc otLayoutGetLigatureCarets*(font: fontT; direction: directionT;
    glyph: int; startOffset: int; caretCount: var int; caretArray: var seq[int32]): int =
  var caretArray_00: ptr int32
  var caretCount_00: uint32
  result = int(hb_ot_layout_get_ligature_carets(cast[ptr fontT00](font.impl), direction, uint32(glyph), uint32(startOffset), caretCount_00, caretArray_00))
  caretArray.setLen(caretCount)
  copyMem(unsafeaddr caretArray[0], caretArray_00, caretCount.int * sizeof(caretArray[0]))
  cogfree(caretArray_00)
  if caretCount.addr != nil:
    caretCount = int(caretCount_00)

proc hb_ot_layout_get_size_params(face: ptr faceT00; designSize: var uint32;
    subfamilyId: var uint32; subfamilyNameId: var uint32; rangeStart: var uint32;
    rangeEnd: var uint32): int32 {.
    importc, libprag.}

proc otLayoutGetSizeParams*(face: faceT; designSize: var int; subfamilyId: var int;
    subfamilyNameId: var int; rangeStart: var int; rangeEnd: var int): int =
  var subfamilyId_00: uint32
  var rangeStart_00: uint32
  var rangeEnd_00: uint32
  var subfamilyNameId_00: uint32
  var designSize_00: uint32
  result = int(hb_ot_layout_get_size_params(cast[ptr faceT00](face.impl), designSize_00, subfamilyId_00, subfamilyNameId_00, rangeStart_00, rangeEnd_00))
  if subfamilyId.addr != nil:
    subfamilyId = int(subfamilyId_00)
  if rangeStart.addr != nil:
    rangeStart = int(rangeStart_00)
  if rangeEnd.addr != nil:
    rangeEnd = int(rangeEnd_00)
  if subfamilyNameId.addr != nil:
    subfamilyNameId = int(subfamilyNameId_00)
  if designSize.addr != nil:
    designSize = int(designSize_00)

type
  otLayoutGlyphClassT* {.size: sizeof(cint), pure.} = enum
    unclassified = 0
    baseGlyph = 1
    ligature = 2
    mark = 3
    component = 4

proc hb_ot_layout_get_glyph_class(face: ptr faceT00; glyph: uint32): otLayoutGlyphClassT {.
    importc, libprag.}

proc otLayoutGetGlyphClass*(face: faceT; glyph: int): otLayoutGlyphClassT =
  hb_ot_layout_get_glyph_class(cast[ptr faceT00](face.impl), uint32(glyph))

proc hb_ot_layout_has_glyph_classes(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otLayoutHasGlyphClasses*(face: faceT): int =
  int(hb_ot_layout_has_glyph_classes(cast[ptr faceT00](face.impl)))

proc hb_ot_layout_has_positioning(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otLayoutHasPositioning*(face: faceT): int =
  int(hb_ot_layout_has_positioning(cast[ptr faceT00](face.impl)))

proc hb_ot_layout_has_substitution(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otLayoutHasSubstitution*(face: faceT): int =
  int(hb_ot_layout_has_substitution(cast[ptr faceT00](face.impl)))

proc hb_ot_layout_language_find_feature(face: ptr faceT00; tableTag: uint32;
    scriptIndex: uint32; languageIndex: uint32; featureTag: uint32; featureIndex: var uint32): int32 {.
    importc, libprag.}

proc otLayoutLanguageFindFeature*(face: faceT; tableTag: int; scriptIndex: int;
    languageIndex: int; featureTag: int; featureIndex: var int): int =
  var featureIndex_00: uint32
  result = int(hb_ot_layout_language_find_feature(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(languageIndex), uint32(featureTag), featureIndex_00))
  if featureIndex.addr != nil:
    featureIndex = int(featureIndex_00)

proc hb_ot_layout_language_get_feature_indexes(face: ptr faceT00; tableTag: uint32;
    scriptIndex: uint32; languageIndex: uint32; startOffset: uint32; featureCount: var uint32;
    featureIndexes: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutLanguageGetFeatureIndexes*(face: faceT; tableTag: int;
    scriptIndex: int; languageIndex: int; startOffset: int; featureCount: var int;
    featureIndexes: var seq[uint32]): int =
  var featureCount_00: uint32
  var featureIndexes_00: ptr uint32
  result = int(hb_ot_layout_language_get_feature_indexes(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(languageIndex), uint32(startOffset), featureCount_00, featureIndexes_00))
  if featureCount.addr != nil:
    featureCount = int(featureCount_00)
  featureIndexes.setLen(featureCount)
  copyMem(unsafeaddr featureIndexes[0], featureIndexes_00, featureCount.int * sizeof(featureIndexes[0]))
  cogfree(featureIndexes_00)

proc hb_ot_layout_language_get_feature_tags(face: ptr faceT00; tableTag: uint32;
    scriptIndex: uint32; languageIndex: uint32; startOffset: uint32; featureCount: var uint32;
    featureTags: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutLanguageGetFeatureTags*(face: faceT; tableTag: int; scriptIndex: int;
    languageIndex: int; startOffset: int; featureCount: var int; featureTags: var seq[uint32]): int =
  var featureTags_00: ptr uint32
  var featureCount_00: uint32
  result = int(hb_ot_layout_language_get_feature_tags(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(languageIndex), uint32(startOffset), featureCount_00, featureTags_00))
  featureTags.setLen(featureCount)
  copyMem(unsafeaddr featureTags[0], featureTags_00, featureCount.int * sizeof(featureTags[0]))
  cogfree(featureTags_00)
  if featureCount.addr != nil:
    featureCount = int(featureCount_00)

proc hb_ot_layout_language_get_required_feature(face: ptr faceT00; tableTag: uint32;
    scriptIndex: uint32; languageIndex: uint32; featureIndex: var uint32; featureTag: var uint32): int32 {.
    importc, libprag.}

proc otLayoutLanguageGetRequiredFeature*(face: faceT; tableTag: int;
    scriptIndex: int; languageIndex: int; featureIndex: var int; featureTag: var int): int =
  var featureTag_00: uint32
  var featureIndex_00: uint32
  result = int(hb_ot_layout_language_get_required_feature(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(languageIndex), featureIndex_00, featureTag_00))
  if featureTag.addr != nil:
    featureTag = int(featureTag_00)
  if featureIndex.addr != nil:
    featureIndex = int(featureIndex_00)

proc hb_ot_layout_language_get_required_feature_index(face: ptr faceT00;
    tableTag: uint32; scriptIndex: uint32; languageIndex: uint32; featureIndex: var uint32): int32 {.
    importc, libprag.}

proc otLayoutLanguageGetRequiredFeatureIndex*(face: faceT; tableTag: int;
    scriptIndex: int; languageIndex: int; featureIndex: var int): int =
  var featureIndex_00: uint32
  result = int(hb_ot_layout_language_get_required_feature_index(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(languageIndex), featureIndex_00))
  if featureIndex.addr != nil:
    featureIndex = int(featureIndex_00)

proc hb_ot_layout_lookup_get_glyph_alternates(face: ptr faceT00; lookupIndex: uint32;
    glyph: uint32; startOffset: uint32; alternateCount: var uint32; alternateGlyphs: ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutLookupGetGlyphAlternates*(face: faceT; lookupIndex: int;
    glyph: int; startOffset: int; alternateCount: var int; alternateGlyphs: var seq[uint32]): int =
  var alternateCount_00: uint32
  result = int(hb_ot_layout_lookup_get_glyph_alternates(cast[ptr faceT00](face.impl), uint32(lookupIndex), uint32(glyph), uint32(startOffset), alternateCount_00, cast[ptr uint32](unsafeaddr(alternateGlyphs[0]))))
  if alternateCount.addr != nil:
    alternateCount = int(alternateCount_00)

proc hb_ot_layout_lookup_would_substitute(face: ptr faceT00; lookupIndex: uint32;
    glyphs: ptr uint32; glyphsLength: uint32; zeroContext: int32): int32 {.
    importc, libprag.}

proc otLayoutLookupWouldSubstitute*(face: faceT; lookupIndex: int;
    glyphs: ptr uint32; glyphsLength: int; zeroContext: int): int =
  int(hb_ot_layout_lookup_would_substitute(cast[ptr faceT00](face.impl), uint32(lookupIndex), glyphs, uint32(glyphsLength), int32(zeroContext)))

proc hb_ot_layout_script_find_language(face: ptr faceT00; tableTag: uint32;
    scriptIndex: uint32; languageTag: uint32; languageIndex: ptr uint32): int32 {.
    importc, libprag.}

proc otLayoutScriptFindLanguage*(face: faceT; tableTag: int; scriptIndex: int;
    languageTag: int; languageIndex: ptr uint32): int =
  int(hb_ot_layout_script_find_language(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(languageTag), languageIndex))

proc hb_ot_layout_script_get_language_tags(face: ptr faceT00; tableTag: uint32;
    scriptIndex: uint32; startOffset: uint32; languageCount: var uint32; languageTags: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutScriptGetLanguageTags*(face: faceT; tableTag: int; scriptIndex: int;
    startOffset: int; languageCount: var int; languageTags: var seq[uint32]): int =
  var languageCount_00: uint32
  var languageTags_00: ptr uint32
  result = int(hb_ot_layout_script_get_language_tags(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(startOffset), languageCount_00, languageTags_00))
  if languageCount.addr != nil:
    languageCount = int(languageCount_00)
  languageTags.setLen(languageCount)
  copyMem(unsafeaddr languageTags[0], languageTags_00, languageCount.int * sizeof(languageTags[0]))
  cogfree(languageTags_00)

proc hb_ot_layout_script_select_language(face: ptr faceT00; tableTag: uint32;
    scriptIndex: uint32; languageCount: uint32; languageTags: ptr uint32; languageIndex: var uint32): int32 {.
    importc, libprag.}

proc otLayoutScriptSelectLanguage*(face: faceT; tableTag: int; scriptIndex: int;
    languageCount: int; languageTags: ptr uint32; languageIndex: var int): int =
  var languageIndex_00: uint32
  result = int(hb_ot_layout_script_select_language(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptIndex), uint32(languageCount), languageTags, languageIndex_00))
  if languageIndex.addr != nil:
    languageIndex = int(languageIndex_00)

proc hb_ot_layout_table_choose_script(face: ptr faceT00; tableTag: uint32;
    scriptTags: ptr uint32; scriptIndex: var uint32; chosenScript: var uint32): int32 {.
    importc, libprag.}

proc otLayoutTableChooseScript*(face: faceT; tableTag: int; scriptTags: ptr uint32;
    scriptIndex: var int; chosenScript: var int): int =
  var scriptIndex_00: uint32
  var chosenScript_00: uint32
  result = int(hb_ot_layout_table_choose_script(cast[ptr faceT00](face.impl), uint32(tableTag), scriptTags, scriptIndex_00, chosenScript_00))
  if scriptIndex.addr != nil:
    scriptIndex = int(scriptIndex_00)
  if chosenScript.addr != nil:
    chosenScript = int(chosenScript_00)

proc hb_ot_layout_table_find_feature_variations(face: ptr faceT00; tableTag: uint32;
    coords: ptr int32; numCoords: uint32; variationsIndex: var uint32): int32 {.
    importc, libprag.}

proc otLayoutTableFindFeatureVariations*(face: faceT; tableTag: int;
    coords: ptr int32; numCoords: int; variationsIndex: var int): int =
  var variationsIndex_00: uint32
  result = int(hb_ot_layout_table_find_feature_variations(cast[ptr faceT00](face.impl), uint32(tableTag), coords, uint32(numCoords), variationsIndex_00))
  if variationsIndex.addr != nil:
    variationsIndex = int(variationsIndex_00)

proc hb_ot_layout_table_find_script(face: ptr faceT00; tableTag: uint32;
    scriptTag: uint32; scriptIndex: var uint32): int32 {.
    importc, libprag.}

proc otLayoutTableFindScript*(face: faceT; tableTag: int; scriptTag: int;
    scriptIndex: var int): int =
  var scriptIndex_00: uint32
  result = int(hb_ot_layout_table_find_script(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptTag), scriptIndex_00))
  if scriptIndex.addr != nil:
    scriptIndex = int(scriptIndex_00)

proc hb_ot_layout_table_get_feature_tags(face: ptr faceT00; tableTag: uint32;
    startOffset: uint32; featureCount: var uint32; featureTags: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutTableGetFeatureTags*(face: faceT; tableTag: int; startOffset: int;
    featureCount: var int; featureTags: var seq[uint32]): int =
  var featureTags_00: ptr uint32
  var featureCount_00: uint32
  result = int(hb_ot_layout_table_get_feature_tags(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(startOffset), featureCount_00, featureTags_00))
  featureTags.setLen(featureCount)
  copyMem(unsafeaddr featureTags[0], featureTags_00, featureCount.int * sizeof(featureTags[0]))
  cogfree(featureTags_00)
  if featureCount.addr != nil:
    featureCount = int(featureCount_00)

proc hb_ot_layout_table_get_lookup_count(face: ptr faceT00; tableTag: uint32): uint32 {.
    importc, libprag.}

proc otLayoutTableGetLookupCount*(face: faceT; tableTag: int): int =
  int(hb_ot_layout_table_get_lookup_count(cast[ptr faceT00](face.impl), uint32(tableTag)))

proc hb_ot_layout_table_get_script_tags(face: ptr faceT00; tableTag: uint32;
    startOffset: uint32; scriptCount: var uint32; scriptTags: var ptr uint32): uint32 {.
    importc, libprag.}

proc otLayoutTableGetScriptTags*(face: faceT; tableTag: int; startOffset: int;
    scriptCount: var int; scriptTags: var seq[uint32]): int =
  var scriptTags_00: ptr uint32
  var scriptCount_00: uint32
  result = int(hb_ot_layout_table_get_script_tags(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(startOffset), scriptCount_00, scriptTags_00))
  scriptTags.setLen(scriptCount)
  copyMem(unsafeaddr scriptTags[0], scriptTags_00, scriptCount.int * sizeof(scriptTags[0]))
  cogfree(scriptTags_00)
  if scriptCount.addr != nil:
    scriptCount = int(scriptCount_00)

proc hb_ot_layout_table_select_script(face: ptr faceT00; tableTag: uint32;
    scriptCount: uint32; scriptTags: ptr uint32; scriptIndex: var uint32; chosenScript: var uint32): int32 {.
    importc, libprag.}

proc otLayoutTableSelectScript*(face: faceT; tableTag: int; scriptCount: int;
    scriptTags: ptr uint32; scriptIndex: var int; chosenScript: var int): int =
  var scriptIndex_00: uint32
  var chosenScript_00: uint32
  result = int(hb_ot_layout_table_select_script(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(scriptCount), scriptTags, scriptIndex_00, chosenScript_00))
  if scriptIndex.addr != nil:
    scriptIndex = int(scriptIndex_00)
  if chosenScript.addr != nil:
    chosenScript = int(chosenScript_00)

type
  otMathConstantT* {.size: sizeof(cint), pure.} = enum
    scriptPercentScaleDown = 0
    scriptScriptPercentScaleDown = 1
    delimitedSubFormulaMinHeight = 2
    displayOperatorMinHeight = 3
    mathLeading = 4
    axisHeight = 5
    accentBaseHeight = 6
    flattenedAccentBaseHeight = 7
    subscriptShiftDown = 8
    subscriptTopMax = 9
    subscriptBaselineDropMin = 10
    superscriptShiftUp = 11
    superscriptShiftUpCramped = 12
    superscriptBottomMin = 13
    superscriptBaselineDropMax = 14
    subSuperscriptGapMin = 15
    superscriptBottomMaxWithSubscript = 16
    spaceAfterScript = 17
    upperLimitGapMin = 18
    upperLimitBaselineRiseMin = 19
    lowerLimitGapMin = 20
    lowerLimitBaselineDropMin = 21
    stackTopShiftUp = 22
    stackTopDisplayStyleShiftUp = 23
    stackBottomShiftDown = 24
    stackBottomDisplayStyleShiftDown = 25
    stackGapMin = 26
    stackDisplayStyleGapMin = 27
    stretchStackTopShiftUp = 28
    stretchStackBottomShiftDown = 29
    stretchStackGapAboveMin = 30
    stretchStackGapBelowMin = 31
    fractionNumeratorShiftUp = 32
    fractionNumeratorDisplayStyleShiftUp = 33
    fractionDenominatorShiftDown = 34
    fractionDenominatorDisplayStyleShiftDown = 35
    fractionNumeratorGapMin = 36
    fractionNumDisplayStyleGapMin = 37
    fractionRuleThickness = 38
    fractionDenominatorGapMin = 39
    fractionDenomDisplayStyleGapMin = 40
    skewedFractionHorizontalGap = 41
    skewedFractionVerticalGap = 42
    overbarVerticalGap = 43
    overbarRuleThickness = 44
    overbarExtraAscender = 45
    underbarVerticalGap = 46
    underbarRuleThickness = 47
    underbarExtraDescender = 48
    radicalVerticalGap = 49
    radicalDisplayStyleVerticalGap = 50
    radicalRuleThickness = 51
    radicalExtraAscender = 52
    radicalKernBeforeDegree = 53
    radicalKernAfterDegree = 54
    radicalDegreeBottomRaisePercent = 55

proc hb_ot_math_get_constant(font: ptr fontT00; constant: otMathConstantT): int32 {.
    importc, libprag.}

proc otMathGetConstant*(font: fontT; constant: otMathConstantT): int =
  int(hb_ot_math_get_constant(cast[ptr fontT00](font.impl), constant))

proc hb_ot_math_get_glyph_italics_correction(font: ptr fontT00; glyph: uint32): int32 {.
    importc, libprag.}

proc otMathGetGlyphItalicsCorrection*(font: fontT; glyph: int): int =
  int(hb_ot_math_get_glyph_italics_correction(cast[ptr fontT00](font.impl), uint32(glyph)))

proc hb_ot_math_get_glyph_top_accent_attachment(font: ptr fontT00; glyph: uint32): int32 {.
    importc, libprag.}

proc otMathGetGlyphTopAccentAttachment*(font: fontT; glyph: int): int =
  int(hb_ot_math_get_glyph_top_accent_attachment(cast[ptr fontT00](font.impl), uint32(glyph)))

proc hb_ot_math_get_min_connector_overlap(font: ptr fontT00; direction: directionT): int32 {.
    importc, libprag.}

proc otMathGetMinConnectorOverlap*(font: fontT; direction: directionT): int =
  int(hb_ot_math_get_min_connector_overlap(cast[ptr fontT00](font.impl), direction))

type
  otMathGlyphPartFlagsT* {.size: sizeof(cint), pure.} = enum
    extender = 1

type
  otMathGlyphPartT00* {.pure.} = object
  otMathGlyphPartT* = ref object
    impl*: ptr otMathGlyphPartT00
    ignoreFinalizer*: bool

proc hb_gobject_ot_math_glyph_part_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_ot_math_glyph_part_t*(self: otMathGlyphPartT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_ot_math_glyph_part_get_type(), cast[ptr otMathGlyphPartT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(otMathGlyphPartT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_ot_math_glyph_part_get_type(), cast[ptr otMathGlyphPartT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var otMathGlyphPartT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_ot_math_glyph_part_t)

proc hb_ot_math_get_glyph_assembly(font: ptr fontT00; glyph: uint32; direction: directionT;
    startOffset: uint32; partsCount: var uint32; parts: var ptr otMathGlyphPartT00;
    italicsCorrection: var int32): uint32 {.
    importc, libprag.}

proc otMathGetGlyphAssembly*(font: fontT; glyph: int; direction: directionT;
    startOffset: int; partsCount: var int; parts: var ptr otMathGlyphPartT00;
    italicsCorrection: var int): int =
  var italicsCorrection_00: int32
  var partsCount_00: uint32
  result = int(hb_ot_math_get_glyph_assembly(cast[ptr fontT00](font.impl), uint32(glyph), direction, uint32(startOffset), partsCount_00, parts, italicsCorrection_00))
  if italicsCorrection.addr != nil:
    italicsCorrection = int(italicsCorrection_00)
  if partsCount.addr != nil:
    partsCount = int(partsCount_00)

type
  otMathGlyphVariantT00* {.pure.} = object
  otMathGlyphVariantT* = ref object
    impl*: ptr otMathGlyphVariantT00
    ignoreFinalizer*: bool

proc hb_gobject_ot_math_glyph_variant_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_ot_math_glyph_variant_t*(self: otMathGlyphVariantT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_ot_math_glyph_variant_get_type(), cast[ptr otMathGlyphVariantT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(otMathGlyphVariantT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_ot_math_glyph_variant_get_type(), cast[ptr otMathGlyphVariantT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var otMathGlyphVariantT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_ot_math_glyph_variant_t)

proc hb_ot_math_get_glyph_variants(font: ptr fontT00; glyph: uint32; direction: directionT;
    startOffset: uint32; variantsCount: var uint32; variants: var ptr otMathGlyphVariantT00): uint32 {.
    importc, libprag.}

proc otMathGetGlyphVariants*(font: fontT; glyph: int; direction: directionT;
    startOffset: int; variantsCount: var int; variants: var ptr otMathGlyphVariantT00): int =
  var variantsCount_00: uint32
  result = int(hb_ot_math_get_glyph_variants(cast[ptr fontT00](font.impl), uint32(glyph), direction, uint32(startOffset), variantsCount_00, variants))
  if variantsCount.addr != nil:
    variantsCount = int(variantsCount_00)

proc hb_ot_math_has_data(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otMathHasData*(face: faceT): int =
  int(hb_ot_math_has_data(cast[ptr faceT00](face.impl)))

proc hb_ot_math_is_glyph_extended_shape(face: ptr faceT00; glyph: uint32): int32 {.
    importc, libprag.}

proc otMathIsGlyphExtendedShape*(face: faceT; glyph: int): int =
  int(hb_ot_math_is_glyph_extended_shape(cast[ptr faceT00](face.impl), uint32(glyph)))

type
  otMathKernT* {.size: sizeof(cint), pure.} = enum
    topRight = 0
    topLeft = 1
    bottomRight = 2
    bottomLeft = 3

proc hb_ot_math_get_glyph_kerning(font: ptr fontT00; glyph: uint32; kern: otMathKernT;
    correctionHeight: int32): int32 {.
    importc, libprag.}

proc otMathGetGlyphKerning*(font: fontT; glyph: int; kern: otMathKernT;
    correctionHeight: int): int =
  int(hb_ot_math_get_glyph_kerning(cast[ptr fontT00](font.impl), uint32(glyph), kern, int32(correctionHeight)))

type
  otMetaTagT* {.size: sizeof(cint), pure.} = enum
    designLanguages = 1684827751
    supportedLanguages = 1936485991

proc hb_ot_meta_get_entry_tags(face: ptr faceT00; startOffset: uint32; entriesCount: var uint32;
    entries: var ptr otMetaTagT): uint32 {.
    importc, libprag.}

proc otMetaGetEntryTags*(face: faceT; startOffset: int; entriesCount: var int;
    entries: var ptr otMetaTagT): int =
  var entriesCount_00: uint32
  result = int(hb_ot_meta_get_entry_tags(cast[ptr faceT00](face.impl), uint32(startOffset), entriesCount_00, entries))
  if entriesCount.addr != nil:
    entriesCount = int(entriesCount_00)

proc hb_ot_meta_reference_entry(face: ptr faceT00; metaTag: otMetaTagT): ptr blobT00 {.
    importc, libprag.}

proc otMetaReferenceEntry*(face: faceT; metaTag: otMetaTagT): blobT =
  fnew(result, gBoxedFreehb_blob_t)
  result.impl = hb_ot_meta_reference_entry(cast[ptr faceT00](face.impl), metaTag)

type
  otMetricsTagT* {.size: sizeof(cint), pure.} = enum
    capHeight = 1668311156
    horizontalAscender = 1751216995
    horizontalClippingAscent = 1751346273
    horizontalClippingDescent = 1751346276
    horizontalCaretOffset = 1751347046
    horizontalCaretRun = 1751347822
    horizontalCaretRise = 1751347827
    horizontalDescender = 1751413603
    horizontalLineGap = 1751934832
    subscriptEmXOffset = 1935833199
    subscriptEmXSize = 1935833203
    subscriptEmYOffset = 1935833455
    subscriptEmYSize = 1935833459
    superscriptEmXOffset = 1936750703
    superscriptEmXSize = 1936750707
    superscriptEmYOffset = 1936750959
    superscriptEmYSize = 1936750963
    strikeoutOffset = 1937011311
    strikeoutSize = 1937011315
    underlineOffset = 1970168943
    underlineSize = 1970168947
    verticalAscender = 1986098019
    verticalCaretOffset = 1986228070
    verticalCaretRun = 1986228846
    verticalCaretRise = 1986228851
    verticalDescender = 1986294627
    verticalLineGap = 1986815856
    xHeight = 2020108148

proc hb_ot_metrics_get_position(font: ptr fontT00; metricsTag: otMetricsTagT;
    position: var int32): int32 {.
    importc, libprag.}

proc otMetricsGetPosition*(font: fontT; metricsTag: otMetricsTagT; position: var int = cast[var int](nil)): int =
  var position_00: int32
  result = int(hb_ot_metrics_get_position(cast[ptr fontT00](font.impl), metricsTag, position_00))
  if position.addr != nil:
    position = int(position_00)

proc hb_ot_metrics_get_variation(font: ptr fontT00; metricsTag: otMetricsTagT): cfloat {.
    importc, libprag.}

proc otMetricsGetVariation*(font: fontT; metricsTag: otMetricsTagT): cfloat =
  hb_ot_metrics_get_variation(cast[ptr fontT00](font.impl), metricsTag)

proc hb_ot_metrics_get_x_variation(font: ptr fontT00; metricsTag: otMetricsTagT): int32 {.
    importc, libprag.}

proc otMetricsGetXVariation*(font: fontT; metricsTag: otMetricsTagT): int =
  int(hb_ot_metrics_get_x_variation(cast[ptr fontT00](font.impl), metricsTag))

proc hb_ot_metrics_get_y_variation(font: ptr fontT00; metricsTag: otMetricsTagT): int32 {.
    importc, libprag.}

proc otMetricsGetYVariation*(font: fontT; metricsTag: otMetricsTagT): int =
  int(hb_ot_metrics_get_y_variation(cast[ptr fontT00](font.impl), metricsTag))

type
  otNameEntryT00* {.pure.} = object
  otNameEntryT* = ref object
    impl*: ptr otNameEntryT00
    ignoreFinalizer*: bool

proc hb_ot_name_get_utf16(face: ptr faceT00; nameId: uint32; language: ptr languageT00;
    textSize: var uint32; text: var ptr uint16): uint32 {.
    importc, libprag.}

proc otNameGetUtf16*(face: faceT; nameId: int; language: languageT;
    textSize: var int; text: var ptr uint16): int =
  var textSize_00: uint32
  result = int(hb_ot_name_get_utf16(cast[ptr faceT00](face.impl), uint32(nameId), cast[ptr languageT00](language.impl), textSize_00, text))
  if textSize.addr != nil:
    textSize = int(textSize_00)

proc hb_ot_name_get_utf32(face: ptr faceT00; nameId: uint32; language: ptr languageT00;
    textSize: var uint32; text: ptr uint32): uint32 {.
    importc, libprag.}

proc otNameGetUtf32*(face: faceT; nameId: int; language: languageT;
    textSize: var int; text: var seq[uint32]): int =
  var textSize_00: uint32
  result = int(hb_ot_name_get_utf32(cast[ptr faceT00](face.impl), uint32(nameId), cast[ptr languageT00](language.impl), textSize_00, cast[ptr uint32](unsafeaddr(text[0]))))
  if textSize.addr != nil:
    textSize = int(textSize_00)

proc hb_ot_name_get_utf8(face: ptr faceT00; nameId: uint32; language: ptr languageT00;
    textSize: var uint32; text: var ptr cstring): uint32 {.
    importc, libprag.}

proc otNameGetUtf8*(face: faceT; nameId: int; language: languageT; textSize: var int;
    text: var seq[string]): int =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  var text_00 = seq2CstringArray(text, fs469n23)
  var textSize_00: uint32
  result = int(hb_ot_name_get_utf8(cast[ptr faceT00](face.impl), uint32(nameId), cast[ptr languageT00](language.impl), textSize_00, text_00))
  if text.addr != nil:
    text = cstringArrayToSeq(text_00)
  if textSize.addr != nil:
    textSize = int(textSize_00)

proc hb_ot_name_list_names(face: ptr faceT00; numEntries: var uint32): ptr otNameEntryT00 {.
    importc, libprag.}

proc otNameListNames*(face: faceT; numEntries: var int = cast[var int](nil)): ptr otNameEntryT00 =
  var numEntries_00: uint32
  result = hb_ot_name_list_names(cast[ptr faceT00](face.impl), numEntries_00)
  if numEntries.addr != nil:
    numEntries = int(numEntries_00)

proc hb_ot_tag_from_language(language: ptr languageT00): uint32 {.
    importc, libprag.}

proc otTagFromLanguage*(language: languageT): int =
  int(hb_ot_tag_from_language(cast[ptr languageT00](language.impl)))

proc hb_ot_tag_to_language(tag: uint32): ptr languageT00 {.
    importc, libprag.}

proc otTagToLanguage*(tag: int): languageT =
  new(result)
  result.impl = hb_ot_tag_to_language(uint32(tag))
  result.ignoreFinalizer = true

type
  otVarAxisFlagsT* {.size: sizeof(cint), pure.} = enum
    hidden = 1

type
  otVarAxisInfoT00* {.pure.} = object
  otVarAxisInfoT* = ref object
    impl*: ptr otVarAxisInfoT00
    ignoreFinalizer*: bool

type
  otVarAxisT00* {.pure.} = object
  otVarAxisT* = ref object
    impl*: ptr otVarAxisT00
    ignoreFinalizer*: bool

proc hb_ot_var_find_axis(face: ptr faceT00; axisTag: uint32; axisIndex: ptr uint32;
    axisInfo: var otVarAxisT00): int32 {.
    importc, libprag.}

proc otVarFindAxis*(face: faceT; axisTag: int; axisIndex: ptr uint32;
    axisInfo: var otVarAxisT00): int =
  int(hb_ot_var_find_axis(cast[ptr faceT00](face.impl), uint32(axisTag), axisIndex, axisInfo))

proc hb_ot_var_find_axis_info(face: ptr faceT00; axisTag: uint32; axisInfo: var otVarAxisInfoT00): int32 {.
    importc, libprag.}

proc otVarFindAxisInfo*(face: faceT; axisTag: int; axisInfo: var otVarAxisInfoT00): int =
  int(hb_ot_var_find_axis_info(cast[ptr faceT00](face.impl), uint32(axisTag), axisInfo))

proc hb_ot_var_get_axes(face: ptr faceT00; startOffset: uint32; axesCount: var uint32;
    axesArray: var ptr otVarAxisT00): uint32 {.
    importc, libprag.}

proc otVarGetAxes*(face: faceT; startOffset: int; axesCount: var int;
    axesArray: var ptr otVarAxisT00): int =
  var axesCount_00: uint32
  result = int(hb_ot_var_get_axes(cast[ptr faceT00](face.impl), uint32(startOffset), axesCount_00, axesArray))
  if axesCount.addr != nil:
    axesCount = int(axesCount_00)

proc hb_ot_var_get_axis_count(face: ptr faceT00): uint32 {.
    importc, libprag.}

proc otVarGetAxisCount*(face: faceT): int =
  int(hb_ot_var_get_axis_count(cast[ptr faceT00](face.impl)))

proc hb_ot_var_get_axis_infos(face: ptr faceT00; startOffset: uint32; axesCount: var uint32;
    axesArray: var ptr otVarAxisInfoT00): uint32 {.
    importc, libprag.}

proc otVarGetAxisInfos*(face: faceT; startOffset: int; axesCount: var int;
    axesArray: var ptr otVarAxisInfoT00): int =
  var axesCount_00: uint32
  result = int(hb_ot_var_get_axis_infos(cast[ptr faceT00](face.impl), uint32(startOffset), axesCount_00, axesArray))
  if axesCount.addr != nil:
    axesCount = int(axesCount_00)

proc hb_ot_var_get_named_instance_count(face: ptr faceT00): uint32 {.
    importc, libprag.}

proc otVarGetNamedInstanceCount*(face: faceT): int =
  int(hb_ot_var_get_named_instance_count(cast[ptr faceT00](face.impl)))

proc hb_ot_var_has_data(face: ptr faceT00): int32 {.
    importc, libprag.}

proc otVarHasData*(face: faceT): int =
  int(hb_ot_var_has_data(cast[ptr faceT00](face.impl)))

proc hb_ot_var_named_instance_get_design_coords(face: ptr faceT00; instanceIndex: uint32;
    coordsLength: var uint32; coords: var ptr cfloat): uint32 {.
    importc, libprag.}

proc otVarNamedInstanceGetDesignCoords*(face: faceT; instanceIndex: int;
    coordsLength: var int; coords: var ptr cfloat): int =
  var coordsLength_00: uint32
  result = int(hb_ot_var_named_instance_get_design_coords(cast[ptr faceT00](face.impl), uint32(instanceIndex), coordsLength_00, coords))
  if coordsLength.addr != nil:
    coordsLength = int(coordsLength_00)

proc hb_ot_var_named_instance_get_postscript_name_id(face: ptr faceT00; instanceIndex: uint32): uint32 {.
    importc, libprag.}

proc otVarNamedInstanceGetPostscriptNameId*(face: faceT; instanceIndex: int): int =
  int(hb_ot_var_named_instance_get_postscript_name_id(cast[ptr faceT00](face.impl), uint32(instanceIndex)))

proc hb_ot_var_named_instance_get_subfamily_name_id(face: ptr faceT00; instanceIndex: uint32): uint32 {.
    importc, libprag.}

proc otVarNamedInstanceGetSubfamilyNameId*(face: faceT; instanceIndex: int): int =
  int(hb_ot_var_named_instance_get_subfamily_name_id(cast[ptr faceT00](face.impl), uint32(instanceIndex)))

proc hb_ot_var_normalize_coords(face: ptr faceT00; coordsLength: uint32;
    designCoords: ptr cfloat; normalizedCoords: var int32) {.
    importc, libprag.}

proc otVarNormalizeCoords*(face: faceT; coordsLength: int; designCoords: ptr cfloat;
    normalizedCoords: var int) =
  var normalizedCoords_00: int32
  hb_ot_var_normalize_coords(cast[ptr faceT00](face.impl), uint32(coordsLength), designCoords, normalizedCoords_00)
  if normalizedCoords.addr != nil:
    normalizedCoords = int(normalizedCoords_00)

type
  referenceTableFuncT* = proc (face: ptr faceT00; tag: uint32; userData: pointer): ptr blobT00 {.cdecl.}

type
  scriptT* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    adlam = 1097100397
    caucasianAlbanian = 1097295970
    ahom = 1097363309
    arabic = 1098015074
    imperialAramaic = 1098018153
    armenian = 1098018158
    avestan = 1098281844
    balinese = 1113681001
    bamum = 1113681269
    bassaVah = 1113682803
    batak = 1113683051
    bengali = 1113943655
    bhaiksuki = 1114139507
    bopomofo = 1114599535
    brahmi = 1114792296
    braille = 1114792297
    buginese = 1114990441
    buhid = 1114990692
    chakma = 1130457965
    canadianSyllabics = 1130458739
    carian = 1130459753
    cham = 1130914157
    cherokee = 1130915186
    chorasmian = 1130918515
    coptic = 1131376756
    cypriot = 1131442804
    cyrillic = 1132032620
    devanagari = 1147500129
    divesAkuru = 1147756907
    dogra = 1148151666
    deseret = 1148416628
    duployan = 1148547180
    egyptianHieroglyphs = 1164409200
    elbasan = 1164730977
    elymaic = 1164736877
    ethiopic = 1165256809
    georgian = 1197830002
    glagolitic = 1198285159
    gunjalaGondi = 1198485095
    masaramGondi = 1198485101
    gothic = 1198486632
    grantha = 1198678382
    greek = 1198679403
    gujarati = 1198877298
    gurmukhi = 1198879349
    hangul = 1214344807
    han = 1214344809
    hanunoo = 1214344815
    hatran = 1214346354
    hebrew = 1214603890
    hiragana = 1214870113
    anatolianHieroglyphs = 1215067511
    pahawhHmong = 1215131239
    nyiakengPuachueHmong = 1215131248
    oldHungarian = 1215655527
    oldItalic = 1232363884
    javanese = 1247901281
    kayahLi = 1264675945
    katakana = 1264676449
    kharoshthi = 1265131890
    khmer = 1265134962
    khojki = 1265135466
    khitanSmallScript = 1265202291
    kannada = 1265525857
    kaithi = 1265920105
    taiTham = 1281453665
    lao = 1281453935
    latin = 1281455214
    lepcha = 1281716323
    limbu = 1281977698
    linearA = 1281977953
    linearB = 1281977954
    lisu = 1281979253
    lycian = 1283023721
    lydian = 1283023977
    mahajani = 1298229354
    makasar = 1298230113
    mandaic = 1298230884
    manichaean = 1298230889
    marchen = 1298231907
    medefaidrin = 1298490470
    mendeKikakui = 1298493028
    meroiticCursive = 1298494051
    meroiticHieroglyphs = 1298494063
    malayalam = 1298954605
    modi = 1299145833
    mongolian = 1299148391
    mro = 1299345263
    meeteiMayek = 1299473769
    multani = 1299541108
    myanmar = 1299803506
    nandinagari = 1315008100
    oldNorthArabian = 1315009122
    nabataean = 1315070324
    newa = 1315272545
    nko = 1315663727
    nushu = 1316186229
    ogham = 1332175213
    olChiki = 1332503403
    oldTurkic = 1332898664
    oriya = 1332902241
    osage = 1332963173
    osmanya = 1332964705
    palmyrene = 1348562029
    pauCinHau = 1348564323
    oldPermic = 1348825709
    phagsPa = 1349017959
    inscriptionalPahlavi = 1349020777
    psalterPahlavi = 1349020784
    phoenician = 1349021304
    miao = 1349284452
    inscriptionalParthian = 1349678185
    rejang = 1382706791
    hanifiRohingya = 1383032935
    runic = 1383427698
    samaritan = 1398893938
    oldSouthArabian = 1398895202
    saurashtra = 1398895986
    signwriting = 1399287415
    shavian = 1399349623
    sharada = 1399353956
    siddham = 1399415908
    khudawadi = 1399418468
    sinhala = 1399418472
    sogdian = 1399809892
    oldSogdian = 1399809903
    soraSompeng = 1399812705
    soyombo = 1399814511
    sundanese = 1400204900
    sylotiNagri = 1400466543
    syriac = 1400468067
    tagbanwa = 1415669602
    takri = 1415670642
    taiLe = 1415670885
    newTaiLue = 1415670901
    tamil = 1415671148
    tangut = 1415671399
    taiViet = 1415673460
    telugu = 1415933045
    tifinagh = 1415999079
    tagalog = 1416064103
    thaana = 1416126817
    thai = 1416126825
    tibetan = 1416192628
    tirhuta = 1416196712
    ugaritic = 1432838514
    vai = 1449224553
    warangCiti = 1466004065
    wancho = 1466132591
    oldPersian = 1483761007
    cuneiform = 1483961720
    yezidi = 1499822697
    yi = 1500080489
    zanabazarSquare = 1516334690
    inherited = 1516858984
    common = 1517910393
    unknown = 1517976186

proc hb_buffer_get_script(buffer: ptr bufferT00): scriptT {.
    importc, libprag.}

proc bufferGetScript*(buffer: bufferT): scriptT =
  hb_buffer_get_script(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_set_script(buffer: ptr bufferT00; script: scriptT) {.
    importc, libprag.}

proc bufferSetScript*(buffer: bufferT; script: scriptT) =
  hb_buffer_set_script(cast[ptr bufferT00](buffer.impl), script)

proc glibScriptFromScript*(script: scriptT): glib.UnicodeScript {.
    importc: "hb_glib_script_from_script", libprag.}

proc glibScriptToScript*(script: glib.UnicodeScript): scriptT {.
    importc: "hb_glib_script_to_script", libprag.}

proc hb_ot_tag_to_script(tag: uint32): scriptT {.
    importc, libprag.}

proc otTagToScript*(tag: int): scriptT =
  hb_ot_tag_to_script(uint32(tag))

proc otTagsFromScript*(script: scriptT; scriptTag_1: ptr uint32; scriptTag_2: ptr uint32) {.
    importc: "hb_ot_tags_from_script", libprag.}

proc hb_ot_tags_from_script_and_language(script: scriptT; language: ptr languageT00;
    scriptCount: ptr uint32; scriptTags: var uint32; languageCount: ptr uint32;
    languageTags: var uint32) {.
    importc, libprag.}

proc otTagsFromScriptAndLanguage*(script: scriptT; language: languageT;
    scriptCount: ptr uint32; scriptTags: var int = cast[var int](nil); languageCount: ptr uint32;
    languageTags: var int = cast[var int](nil)) =
  var scriptTags_00: uint32
  var languageTags_00: uint32
  hb_ot_tags_from_script_and_language(script, cast[ptr languageT00](language.impl), scriptCount, scriptTags_00, languageCount, languageTags_00)
  if scriptTags.addr != nil:
    scriptTags = int(scriptTags_00)
  if languageTags.addr != nil:
    languageTags = int(languageTags_00)

proc hb_ot_tags_to_script_and_language(scriptTag: uint32; languageTag: uint32;
    script: ptr scriptT; language: ptr languageT00) {.
    importc, libprag.}

proc otTagsToScriptAndLanguage*(scriptTag: int; languageTag: int;
    script: ptr scriptT; language: languageT = nil) =
  hb_ot_tags_to_script_and_language(uint32(scriptTag), uint32(languageTag), script, if language.isNil: nil else: cast[ptr languageT00](language.impl))

proc hb_script_from_iso15924_tag(tag: uint32): scriptT {.
    importc, libprag.}

proc scriptFromIso15924Tag*(tag: int): scriptT =
  hb_script_from_iso15924_tag(uint32(tag))

proc hb_script_from_string(str: ptr uint8; len: int32): scriptT {.
    importc, libprag.}

proc scriptFromString*(str: seq[uint8] | string): scriptT =
  let len = int(str.len)
  hb_script_from_string(cast[ptr uint8](unsafeaddr(str[0])), int32(len))

proc scriptGetHorizontalDirection*(script: scriptT): directionT {.
    importc: "hb_script_get_horizontal_direction", libprag.}

proc hb_script_to_iso15924_tag(script: scriptT): uint32 {.
    importc, libprag.}

proc scriptToIso15924Tag*(script: scriptT): int =
  int(hb_script_to_iso15924_tag(script))

type
  segmentPropertiesT00* {.pure.} = object
  segmentPropertiesT* = ref object
    impl*: ptr segmentPropertiesT00
    ignoreFinalizer*: bool

proc hb_gobject_segment_properties_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_segment_properties_t*(self: segmentPropertiesT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_segment_properties_get_type(), cast[ptr segmentPropertiesT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(segmentPropertiesT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_segment_properties_get_type(), cast[ptr segmentPropertiesT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var segmentPropertiesT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_segment_properties_t)

proc hb_buffer_get_segment_properties(buffer: ptr bufferT00; props: var segmentPropertiesT00) {.
    importc, libprag.}

proc bufferGetSegmentProperties*(buffer: bufferT; props: var segmentPropertiesT00) =
  hb_buffer_get_segment_properties(cast[ptr bufferT00](buffer.impl), props)

proc bufferGetSegmentProperties*(buffer: bufferT): segmentPropertiesT00 =
  hb_buffer_get_segment_properties(cast[ptr bufferT00](buffer.impl), result)

proc hb_buffer_set_segment_properties(buffer: ptr bufferT00; props: ptr segmentPropertiesT00) {.
    importc, libprag.}

proc bufferSetSegmentProperties*(buffer: bufferT; props: segmentPropertiesT) =
  hb_buffer_set_segment_properties(cast[ptr bufferT00](buffer.impl), cast[ptr segmentPropertiesT00](props.impl))

proc hb_segment_properties_equal(a: ptr segmentPropertiesT00; b: ptr segmentPropertiesT00): int32 {.
    importc, libprag.}

proc segmentPropertiesEqual*(a: segmentPropertiesT; b: segmentPropertiesT): int =
  int(hb_segment_properties_equal(cast[ptr segmentPropertiesT00](a.impl), cast[ptr segmentPropertiesT00](b.impl)))

proc hb_segment_properties_hash(p: ptr segmentPropertiesT00): uint32 {.
    importc, libprag.}

proc segmentPropertiesHash*(p: segmentPropertiesT): int =
  int(hb_segment_properties_hash(cast[ptr segmentPropertiesT00](p.impl)))

type
  setT00* {.pure.} = object
  setT* = ref object
    impl*: ptr setT00
    ignoreFinalizer*: bool

proc hb_gobject_set_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_set_t*(self: setT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_set_get_type(), cast[ptr setT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(setT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_set_get_type(), cast[ptr setT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var setT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_set_t)

proc hb_face_collect_unicodes(face: ptr faceT00; `out`: ptr setT00) {.
    importc, libprag.}

proc faceCollectUnicodes*(face: faceT; `out`: setT) =
  hb_face_collect_unicodes(cast[ptr faceT00](face.impl), cast[ptr setT00](`out`.impl))

proc hb_face_collect_variation_selectors(face: ptr faceT00; `out`: ptr setT00) {.
    importc, libprag.}

proc faceCollectVariationSelectors*(face: faceT; `out`: setT) =
  hb_face_collect_variation_selectors(cast[ptr faceT00](face.impl), cast[ptr setT00](`out`.impl))

proc hb_face_collect_variation_unicodes(face: ptr faceT00; variationSelector: uint32;
    `out`: ptr setT00) {.
    importc, libprag.}

proc faceCollectVariationUnicodes*(face: faceT; variationSelector: int;
    `out`: setT) =
  hb_face_collect_variation_unicodes(cast[ptr faceT00](face.impl), uint32(variationSelector), cast[ptr setT00](`out`.impl))

proc hb_ot_layout_collect_features(face: ptr faceT00; tableTag: uint32; scripts: ptr uint32;
    languages: ptr uint32; features: ptr uint32; featureIndexes: var setT00) {.
    importc, libprag.}

proc otLayoutCollectFeatures*(face: faceT; tableTag: int; scripts: ptr uint32;
    languages: ptr uint32; features: ptr uint32; featureIndexes: var setT00) =
  hb_ot_layout_collect_features(cast[ptr faceT00](face.impl), uint32(tableTag), scripts, languages, features, featureIndexes)

proc hb_ot_layout_collect_lookups(face: ptr faceT00; tableTag: uint32; scripts: ptr uint32;
    languages: ptr uint32; features: ptr uint32; lookupIndexes: var setT00) {.
    importc, libprag.}

proc otLayoutCollectLookups*(face: faceT; tableTag: int; scripts: ptr uint32;
    languages: ptr uint32; features: ptr uint32; lookupIndexes: var setT00) =
  hb_ot_layout_collect_lookups(cast[ptr faceT00](face.impl), uint32(tableTag), scripts, languages, features, lookupIndexes)

proc hb_ot_layout_get_glyphs_in_class(face: ptr faceT00; klass: otLayoutGlyphClassT;
    glyphs: var setT00) {.
    importc, libprag.}

proc otLayoutGetGlyphsInClass*(face: faceT; klass: otLayoutGlyphClassT;
    glyphs: var setT00) =
  hb_ot_layout_get_glyphs_in_class(cast[ptr faceT00](face.impl), klass, glyphs)

proc hb_ot_layout_lookup_collect_glyphs(face: ptr faceT00; tableTag: uint32;
    lookupIndex: uint32; glyphsBefore: var setT00; glyphsInput: var setT00;
    glyphsAfter: var setT00; glyphsOutput: var setT00) {.
    importc, libprag.}

proc otLayoutLookupCollectGlyphs*(face: faceT; tableTag: int; lookupIndex: int;
    glyphsBefore: var setT00; glyphsInput: var setT00; glyphsAfter: var setT00;
    glyphsOutput: var setT00) =
  hb_ot_layout_lookup_collect_glyphs(cast[ptr faceT00](face.impl), uint32(tableTag), uint32(lookupIndex), glyphsBefore, glyphsInput, glyphsAfter, glyphsOutput)

proc hb_ot_layout_lookup_substitute_closure(face: ptr faceT00; lookupIndex: uint32;
    glyphs: var setT00) {.
    importc, libprag.}

proc otLayoutLookupSubstituteClosure*(face: faceT; lookupIndex: int;
    glyphs: var setT00) =
  hb_ot_layout_lookup_substitute_closure(cast[ptr faceT00](face.impl), uint32(lookupIndex), glyphs)

proc hb_ot_layout_lookups_substitute_closure(face: ptr faceT00; lookups: ptr setT00;
    glyphs: var setT00) {.
    importc, libprag.}

proc otLayoutLookupsSubstituteClosure*(face: faceT; lookups: setT;
    glyphs: var setT00) =
  hb_ot_layout_lookups_substitute_closure(cast[ptr faceT00](face.impl), cast[ptr setT00](lookups.impl), glyphs)

proc hb_ot_shape_glyphs_closure(font: ptr fontT00; buffer: ptr bufferT00;
    features: ptr featureT00; numFeatures: uint32; glyphs: var setT00) {.
    importc, libprag.}

proc otShapeGlyphsClosure*(font: fontT; buffer: bufferT; features: ptr featureT00;
    numFeatures: int; glyphs: var setT00) =
  hb_ot_shape_glyphs_closure(cast[ptr fontT00](font.impl), cast[ptr bufferT00](buffer.impl), features, uint32(numFeatures), glyphs)

proc hb_set_add(set: ptr setT00; codepoint: uint32) {.
    importc, libprag.}

proc setAdd*(set: setT; codepoint: int) =
  hb_set_add(cast[ptr setT00](set.impl), uint32(codepoint))

proc `add=`*(set: setT; codepoint: int) =
  hb_set_add(cast[ptr setT00](set.impl), uint32(codepoint))

proc hb_set_add_range(set: ptr setT00; first: uint32; last: uint32) {.
    importc, libprag.}

proc setAddRange*(set: setT; first: int; last: int) =
  hb_set_add_range(cast[ptr setT00](set.impl), uint32(first), uint32(last))

proc hb_set_allocation_successful(set: ptr setT00): int32 {.
    importc, libprag.}

proc setAllocationSuccessful*(set: setT): int =
  int(hb_set_allocation_successful(cast[ptr setT00](set.impl)))

proc hb_set_clear(set: ptr setT00) {.
    importc, libprag.}

proc setClear*(set: setT) =
  hb_set_clear(cast[ptr setT00](set.impl))

proc hb_set_create(): ptr setT00 {.
    importc, libprag.}

proc setCreate*(): setT =
  fnew(result, gBoxedFreehb_set_t)
  result.impl = hb_set_create()

proc hb_set_del(set: ptr setT00; codepoint: uint32) {.
    importc, libprag.}

proc setDel*(set: setT; codepoint: int) =
  hb_set_del(cast[ptr setT00](set.impl), uint32(codepoint))

proc `del=`*(set: setT; codepoint: int) =
  hb_set_del(cast[ptr setT00](set.impl), uint32(codepoint))

proc hb_set_del_range(set: ptr setT00; first: uint32; last: uint32) {.
    importc, libprag.}

proc setDelRange*(set: setT; first: int; last: int) =
  hb_set_del_range(cast[ptr setT00](set.impl), uint32(first), uint32(last))

proc hb_set_get_empty(): ptr setT00 {.
    importc, libprag.}

proc setGetEmpty*(): setT =
  fnew(result, gBoxedFreehb_set_t)
  result.impl = hb_set_get_empty()

proc hb_set_get_max(set: ptr setT00): uint32 {.
    importc, libprag.}

proc setGetMax*(set: setT): int =
  int(hb_set_get_max(cast[ptr setT00](set.impl)))

proc hb_set_get_min(set: ptr setT00): uint32 {.
    importc, libprag.}

proc setGetMin*(set: setT): int =
  int(hb_set_get_min(cast[ptr setT00](set.impl)))

proc hb_set_get_population(set: ptr setT00): uint32 {.
    importc, libprag.}

proc setGetPopulation*(set: setT): int =
  int(hb_set_get_population(cast[ptr setT00](set.impl)))

proc hb_set_has(set: ptr setT00; codepoint: uint32): int32 {.
    importc, libprag.}

proc setHas*(set: setT; codepoint: int): int =
  int(hb_set_has(cast[ptr setT00](set.impl), uint32(codepoint)))

proc hb_set_intersect(set: ptr setT00; other: ptr setT00) {.
    importc, libprag.}

proc setIntersect*(set: setT; other: setT) =
  hb_set_intersect(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc `intersect=`*(set: setT; other: setT) =
  hb_set_intersect(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc hb_set_invert(set: ptr setT00) {.
    importc, libprag.}

proc setInvert*(set: setT) =
  hb_set_invert(cast[ptr setT00](set.impl))

proc hb_set_is_empty(set: ptr setT00): int32 {.
    importc, libprag.}

proc setIsEmpty*(set: setT): int =
  int(hb_set_is_empty(cast[ptr setT00](set.impl)))

proc hb_set_is_equal(set: ptr setT00; other: ptr setT00): int32 {.
    importc, libprag.}

proc setIsEqual*(set: setT; other: setT): int =
  int(hb_set_is_equal(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl)))

proc hb_set_is_subset(set: ptr setT00; largerSet: ptr setT00): int32 {.
    importc, libprag.}

proc setIsSubset*(set: setT; largerSet: setT): int =
  int(hb_set_is_subset(cast[ptr setT00](set.impl), cast[ptr setT00](largerSet.impl)))

proc hb_set_next(set: ptr setT00; codepoint: var uint32): int32 {.
    importc, libprag.}

proc setNext*(set: setT; codepoint: var int): int =
  var codepoint_00 = uint32(codepoint)
  result = int(hb_set_next(cast[ptr setT00](set.impl), codepoint_00))
  codepoint = int(codepoint_00)

proc hb_set_next_range(set: ptr setT00; first: var uint32; last: var uint32): int32 {.
    importc, libprag.}

proc setNextRange*(set: setT; first: var int; last: var int): int =
  var first_00: uint32
  var last_00 = uint32(last)
  result = int(hb_set_next_range(cast[ptr setT00](set.impl), first_00, last_00))
  if first.addr != nil:
    first = int(first_00)
  last = int(last_00)

proc hb_set_previous(set: ptr setT00; codepoint: var uint32): int32 {.
    importc, libprag.}

proc setPrevious*(set: setT; codepoint: var int): int =
  var codepoint_00 = uint32(codepoint)
  result = int(hb_set_previous(cast[ptr setT00](set.impl), codepoint_00))
  codepoint = int(codepoint_00)

proc hb_set_previous_range(set: ptr setT00; first: var uint32; last: var uint32): int32 {.
    importc, libprag.}

proc setPreviousRange*(set: setT; first: var int; last: var int): int =
  var first_00 = uint32(first)
  var last_00: uint32
  result = int(hb_set_previous_range(cast[ptr setT00](set.impl), first_00, last_00))
  first = int(first_00)
  if last.addr != nil:
    last = int(last_00)

proc hb_set_set(set: ptr setT00; other: ptr setT00) {.
    importc, libprag.}

proc setSet*(set: setT; other: setT) =
  hb_set_set(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc `set=`*(set: setT; other: setT) =
  hb_set_set(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc hb_set_subtract(set: ptr setT00; other: ptr setT00) {.
    importc, libprag.}

proc setSubtract*(set: setT; other: setT) =
  hb_set_subtract(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc `subtract=`*(set: setT; other: setT) =
  hb_set_subtract(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc hb_set_symmetric_difference(set: ptr setT00; other: ptr setT00) {.
    importc, libprag.}

proc setSymmetricDifference*(set: setT; other: setT) =
  hb_set_symmetric_difference(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc `symmetricDifference=`*(set: setT; other: setT) =
  hb_set_symmetric_difference(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc hb_set_union(set: ptr setT00; other: ptr setT00) {.
    importc, libprag.}

proc setUnion*(set: setT; other: setT) =
  hb_set_union(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc `union=`*(set: setT; other: setT) =
  hb_set_union(cast[ptr setT00](set.impl), cast[ptr setT00](other.impl))

proc hb_shape(font: ptr fontT00; buffer: ptr bufferT00; features: ptr featureT00;
    numFeatures: uint32) {.
    importc, libprag.}

proc shape*(font: fontT; buffer: bufferT; features: ptr featureT00; numFeatures: int) =
  hb_shape(cast[ptr fontT00](font.impl), cast[ptr bufferT00](buffer.impl), features, uint32(numFeatures))

proc hb_shape_full(font: ptr fontT00; buffer: ptr bufferT00; features: ptr featureT00;
    numFeatures: uint32; shaperList: ptr cstring): int32 {.
    importc, libprag.}

proc shapeFull*(font: fontT; buffer: bufferT; features: ptr featureT00;
    numFeatures: int; shaperList: varargs[string, `$`]): int =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  int(hb_shape_full(cast[ptr fontT00](font.impl), cast[ptr bufferT00](buffer.impl), features, uint32(numFeatures), seq2CstringArray(shaperList, fs469n23)))

proc hb_shape_list_shapers(): ptr cstring {.
    importc, libprag.}

proc shapeListShapers*(): seq[string] =
  cstringArrayToSeq(hb_shape_list_shapers())

type
  shapePlanT00* {.pure.} = object
  shapePlanT* = ref object
    impl*: ptr shapePlanT00
    ignoreFinalizer*: bool

proc hb_gobject_shape_plan_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_shape_plan_t*(self: shapePlanT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_shape_plan_get_type(), cast[ptr shapePlanT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(shapePlanT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_shape_plan_get_type(), cast[ptr shapePlanT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var shapePlanT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_shape_plan_t)

proc hb_shape_plan_create(face: ptr faceT00; props: ptr segmentPropertiesT00;
    userFeatures: ptr featureT00; numUserFeatures: uint32; shaperList: ptr cstring): ptr shapePlanT00 {.
    importc, libprag.}

proc shapePlanCreate*(face: faceT; props: segmentPropertiesT; userFeatures: ptr featureT00;
    numUserFeatures: int; shaperList: varargs[string, `$`]): shapePlanT =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, gBoxedFreehb_shape_plan_t)
  result.impl = hb_shape_plan_create(cast[ptr faceT00](face.impl), cast[ptr segmentPropertiesT00](props.impl), userFeatures, uint32(numUserFeatures), seq2CstringArray(shaperList, fs469n23))

proc hb_shape_plan_create2(face: ptr faceT00; props: ptr segmentPropertiesT00;
    userFeatures: ptr featureT00; numUserFeatures: uint32; coords: ptr int32;
    numCoords: uint32; shaperList: ptr cstring): ptr shapePlanT00 {.
    importc, libprag.}

proc shapePlanCreate2*(face: faceT; props: segmentPropertiesT; userFeatures: ptr featureT00;
    numUserFeatures: int; coords: seq[int32]; shaperList: varargs[string, `$`]): shapePlanT =
  let numCoords = int(coords.len)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, gBoxedFreehb_shape_plan_t)
  result.impl = hb_shape_plan_create2(cast[ptr faceT00](face.impl), cast[ptr segmentPropertiesT00](props.impl), userFeatures, uint32(numUserFeatures), cast[ptr int32](unsafeaddr(coords[0])), uint32(numCoords), seq2CstringArray(shaperList, fs469n23))

proc hb_shape_plan_create_cached(face: ptr faceT00; props: ptr segmentPropertiesT00;
    userFeatures: ptr featureT00; numUserFeatures: uint32; shaperList: ptr cstring): ptr shapePlanT00 {.
    importc, libprag.}

proc shapePlanCreateCached*(face: faceT; props: segmentPropertiesT;
    userFeatures: ptr featureT00; numUserFeatures: int; shaperList: varargs[string, `$`]): shapePlanT =
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, gBoxedFreehb_shape_plan_t)
  result.impl = hb_shape_plan_create_cached(cast[ptr faceT00](face.impl), cast[ptr segmentPropertiesT00](props.impl), userFeatures, uint32(numUserFeatures), seq2CstringArray(shaperList, fs469n23))

proc hb_shape_plan_create_cached2(face: ptr faceT00; props: ptr segmentPropertiesT00;
    userFeatures: ptr featureT00; numUserFeatures: uint32; coords: ptr int32;
    numCoords: uint32; shaperList: ptr cstring): ptr shapePlanT00 {.
    importc, libprag.}

proc shapePlanCreateCached2*(face: faceT; props: segmentPropertiesT;
    userFeatures: ptr featureT00; numUserFeatures: int; coords: seq[int32];
    shaperList: varargs[string, `$`]): shapePlanT =
  let numCoords = int(coords.len)
  var fs469n23x: array[256, pointer]
  var fs469n23: cstringArray = cast[cstringArray](addr fs469n23x)
  fnew(result, gBoxedFreehb_shape_plan_t)
  result.impl = hb_shape_plan_create_cached2(cast[ptr faceT00](face.impl), cast[ptr segmentPropertiesT00](props.impl), userFeatures, uint32(numUserFeatures), cast[ptr int32](unsafeaddr(coords[0])), uint32(numCoords), seq2CstringArray(shaperList, fs469n23))

proc hb_shape_plan_execute(shapePlan: ptr shapePlanT00; font: ptr fontT00;
    buffer: ptr bufferT00; features: ptr featureT00; numFeatures: uint32): int32 {.
    importc, libprag.}

proc shapePlanExecute*(shapePlan: shapePlanT; font: fontT; buffer: bufferT;
    features: ptr featureT00; numFeatures: int): int =
  int(hb_shape_plan_execute(cast[ptr shapePlanT00](shapePlan.impl), cast[ptr fontT00](font.impl), cast[ptr bufferT00](buffer.impl), features, uint32(numFeatures)))

proc hb_shape_plan_get_empty(): ptr shapePlanT00 {.
    importc, libprag.}

proc shapePlanGetEmpty*(): shapePlanT =
  fnew(result, gBoxedFreehb_shape_plan_t)
  result.impl = hb_shape_plan_get_empty()

proc hb_shape_plan_get_shaper(shapePlan: ptr shapePlanT00): cstring {.
    importc, libprag.}

proc shapePlanGetShaper*(shapePlan: shapePlanT): string =
  result = $hb_shape_plan_get_shaper(cast[ptr shapePlanT00](shapePlan.impl))

proc hb_tag_from_string(str: ptr uint8; len: int32): uint32 {.
    importc, libprag.}

proc tagFromString*(str: seq[uint8] | string): int =
  let len = int(str.len)
  int(hb_tag_from_string(cast[ptr uint8](unsafeaddr(str[0])), int32(len)))

proc hb_tag_to_string(tag: uint32; buf: var ptr array[4, uint8]) {.
    importc, libprag.}

proc tagToString*(tag: int; buf: var ptr array[4, uint8]) =
  hb_tag_to_string(uint32(tag), buf)

proc tagToString*(tag: int): ptr array[4, uint8] =
  hb_tag_to_string(uint32(tag), result)

type
  unicodeCombiningClassT* {.size: sizeof(cint), pure.} = enum
    notReordered = 0
    overlay = 1
    nukta = 7
    kanaVoicing = 8
    virama = 9
    ccc10 = 10
    ccc11 = 11
    ccc12 = 12
    ccc13 = 13
    ccc14 = 14
    ccc15 = 15
    ccc16 = 16
    ccc17 = 17
    ccc18 = 18
    ccc19 = 19
    ccc20 = 20
    ccc21 = 21
    ccc22 = 22
    ccc23 = 23
    ccc24 = 24
    ccc25 = 25
    ccc26 = 26
    ccc27 = 27
    ccc28 = 28
    ccc29 = 29
    ccc30 = 30
    ccc31 = 31
    ccc32 = 32
    ccc33 = 33
    ccc34 = 34
    ccc35 = 35
    ccc36 = 36
    ccc84 = 84
    ccc91 = 91
    ccc103 = 103
    ccc107 = 107
    ccc118 = 118
    ccc122 = 122
    ccc129 = 129
    ccc130 = 130
    ccc133 = 132
    attachedBelowLeft = 200
    attachedBelow = 202
    attachedAbove = 214
    attachedAboveRight = 216
    belowLeft = 218
    below = 220
    belowRight = 222
    left = 224
    right = 226
    aboveLeft = 228
    above = 230
    aboveRight = 232
    doubleBelow = 233
    doubleAbove = 234
    iotaSubscript = 240
    invalid = 255

type
  unicodeFuncsT00* {.pure.} = object
  unicodeFuncsT* = ref object
    impl*: ptr unicodeFuncsT00
    ignoreFinalizer*: bool

proc hb_gobject_unicode_funcs_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_unicode_funcs_t*(self: unicodeFuncsT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_unicode_funcs_get_type(), cast[ptr unicodeFuncsT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(unicodeFuncsT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_unicode_funcs_get_type(), cast[ptr unicodeFuncsT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var unicodeFuncsT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_unicode_funcs_t)

type
  unicodeEastasianWidthFuncT* = proc (ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): uint32 {.cdecl.}

type
  unicodeDecomposeFuncT* = proc (ufuncs: ptr unicodeFuncsT00; ab: uint32; a: var uint32; b: var uint32;
    userData: pointer): int32 {.cdecl.}

type
  unicodeDecomposeCompatibilityFuncT* = proc (ufuncs: ptr unicodeFuncsT00; u: uint32; decomposed: ptr uint32; userData: pointer): uint32 {.cdecl.}

type
  unicodeComposeFuncT* = proc (ufuncs: ptr unicodeFuncsT00; a: uint32; b: uint32; ab: var uint32;
    userData: pointer): int32 {.cdecl.}

type
  unicodeCombiningClassFuncT* = proc (ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): unicodeCombiningClassT {.cdecl.}

proc hb_buffer_get_unicode_funcs(buffer: ptr bufferT00): ptr unicodeFuncsT00 {.
    importc, libprag.}

proc bufferGetUnicodeFuncs*(buffer: bufferT): unicodeFuncsT =
  fnew(result, gBoxedFreehb_unicode_funcs_t)
  result.impl = hb_buffer_get_unicode_funcs(cast[ptr bufferT00](buffer.impl))

proc hb_buffer_set_unicode_funcs(buffer: ptr bufferT00; unicodeFuncs: ptr unicodeFuncsT00) {.
    importc, libprag.}

proc bufferSetUnicodeFuncs*(buffer: bufferT; unicodeFuncs: unicodeFuncsT) =
  hb_buffer_set_unicode_funcs(cast[ptr bufferT00](buffer.impl), cast[ptr unicodeFuncsT00](unicodeFuncs.impl))

proc hb_glib_get_unicode_funcs(): ptr unicodeFuncsT00 {.
    importc, libprag.}

proc glibGetUnicodeFuncs*(): unicodeFuncsT =
  fnew(result, gBoxedFreehb_unicode_funcs_t)
  result.impl = hb_glib_get_unicode_funcs()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(hb_gobject_unicode_funcs_get_type(), result.impl))

proc hb_unicode_combining_class(ufuncs: ptr unicodeFuncsT00; unicode: uint32): unicodeCombiningClassT {.
    importc, libprag.}

proc unicodeCombiningClass*(ufuncs: unicodeFuncsT; unicode: int): unicodeCombiningClassT =
  hb_unicode_combining_class(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(unicode))

proc hb_unicode_compose(ufuncs: ptr unicodeFuncsT00; a: uint32; b: uint32;
    ab: var uint32): int32 {.
    importc, libprag.}

proc unicodeCompose*(ufuncs: unicodeFuncsT; a: int; b: int; ab: var int): int =
  var ab_00: uint32
  result = int(hb_unicode_compose(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(a), uint32(b), ab_00))
  if ab.addr != nil:
    ab = int(ab_00)

proc hb_unicode_decompose(ufuncs: ptr unicodeFuncsT00; ab: uint32; a: var uint32;
    b: var uint32): int32 {.
    importc, libprag.}

proc unicodeDecompose*(ufuncs: unicodeFuncsT; ab: int; a: var int; b: var int): int =
  var b_00: uint32
  var a_00: uint32
  result = int(hb_unicode_decompose(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(ab), a_00, b_00))
  if b.addr != nil:
    b = int(b_00)
  if a.addr != nil:
    a = int(a_00)

proc hb_unicode_decompose_compatibility(ufuncs: ptr unicodeFuncsT00; u: uint32;
    decomposed: var uint32): uint32 {.
    importc, libprag.}

proc unicodeDecomposeCompatibility*(ufuncs: unicodeFuncsT; u: int; decomposed: var int): int =
  var decomposed_00: uint32
  result = int(hb_unicode_decompose_compatibility(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(u), decomposed_00))
  if decomposed.addr != nil:
    decomposed = int(decomposed_00)

proc hb_unicode_eastasian_width(ufuncs: ptr unicodeFuncsT00; unicode: uint32): uint32 {.
    importc, libprag.}

proc unicodeEastasianWidth*(ufuncs: unicodeFuncsT; unicode: int): int =
  int(hb_unicode_eastasian_width(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(unicode)))

proc hb_unicode_funcs_create(parent: ptr unicodeFuncsT00): ptr unicodeFuncsT00 {.
    importc, libprag.}

proc unicodeFuncsCreate*(parent: unicodeFuncsT = nil): unicodeFuncsT =
  fnew(result, gBoxedFreehb_unicode_funcs_t)
  result.impl = hb_unicode_funcs_create(if parent.isNil: nil else: cast[ptr unicodeFuncsT00](parent.impl))

proc hb_unicode_funcs_get_default(): ptr unicodeFuncsT00 {.
    importc, libprag.}

proc unicodeFuncsGetDefault*(): unicodeFuncsT =
  fnew(result, gBoxedFreehb_unicode_funcs_t)
  result.impl = hb_unicode_funcs_get_default()
  result.impl = cast[typeof(result.impl)](g_boxed_copy(hb_gobject_unicode_funcs_get_type(), result.impl))

proc hb_unicode_funcs_get_empty(): ptr unicodeFuncsT00 {.
    importc, libprag.}

proc unicodeFuncsGetEmpty*(): unicodeFuncsT =
  fnew(result, gBoxedFreehb_unicode_funcs_t)
  result.impl = hb_unicode_funcs_get_empty()

proc hb_unicode_funcs_get_parent(ufuncs: ptr unicodeFuncsT00): ptr unicodeFuncsT00 {.
    importc, libprag.}

proc unicodeFuncsGetParent*(ufuncs: unicodeFuncsT): unicodeFuncsT =
  fnew(result, gBoxedFreehb_unicode_funcs_t)
  result.impl = hb_unicode_funcs_get_parent(cast[ptr unicodeFuncsT00](ufuncs.impl))

proc hb_unicode_funcs_is_immutable(ufuncs: ptr unicodeFuncsT00): int32 {.
    importc, libprag.}

proc unicodeFuncsIsImmutable*(ufuncs: unicodeFuncsT): int =
  int(hb_unicode_funcs_is_immutable(cast[ptr unicodeFuncsT00](ufuncs.impl)))

proc hb_unicode_funcs_make_immutable(ufuncs: ptr unicodeFuncsT00) {.
    importc, libprag.}

proc unicodeFuncsMakeImmutable*(ufuncs: unicodeFuncsT) =
  hb_unicode_funcs_make_immutable(cast[ptr unicodeFuncsT00](ufuncs.impl))

proc hb_unicode_funcs_set_combining_class_func(ufuncs: ptr unicodeFuncsT00;
    `func`: proc(ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): unicodeCombiningClassT {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetCombiningClassFunc*(ufuncs: unicodeFuncsT; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    unicode: uint32; userData: pointer): unicodeCombiningClassT {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_combining_class_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

proc hb_unicode_funcs_set_compose_func(ufuncs: ptr unicodeFuncsT00; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    a: uint32; b: uint32; ab: var uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetComposeFunc*(ufuncs: unicodeFuncsT; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    a: uint32; b: uint32; ab: var uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_compose_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

proc hb_unicode_funcs_set_decompose_compatibility_func(ufuncs: ptr unicodeFuncsT00;
    `func`: proc(ufuncs: ptr unicodeFuncsT00; u: uint32; decomposed: ptr uint32;
    userData: pointer): uint32 {.cdecl.}; userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetDecomposeCompatibilityFunc*(ufuncs: unicodeFuncsT;
    `func`: proc(ufuncs: ptr unicodeFuncsT00; u: uint32; decomposed: ptr uint32;
    userData: pointer): uint32 {.cdecl.}; userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_decompose_compatibility_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

proc hb_unicode_funcs_set_decompose_func(ufuncs: ptr unicodeFuncsT00; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    ab: uint32; a: var uint32; b: var uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetDecomposeFunc*(ufuncs: unicodeFuncsT; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    ab: uint32; a: var uint32; b: var uint32;
    userData: pointer): int32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_decompose_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

proc hb_unicode_funcs_set_eastasian_width_func(ufuncs: ptr unicodeFuncsT00;
    `func`: proc(ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): uint32 {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetEastasianWidthFunc*(ufuncs: unicodeFuncsT; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    unicode: uint32; userData: pointer): uint32 {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_eastasian_width_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

proc hb_unicode_funcs_set_mirroring_func(ufuncs: ptr unicodeFuncsT00; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    unicode: uint32; userData: pointer): uint32 {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetMirroringFunc*(ufuncs: unicodeFuncsT; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    unicode: uint32; userData: pointer): uint32 {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_mirroring_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

proc hb_unicode_funcs_set_script_func(ufuncs: ptr unicodeFuncsT00; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    unicode: uint32; userData: pointer): scriptT {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetScriptFunc*(ufuncs: unicodeFuncsT; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    unicode: uint32; userData: pointer): scriptT {.cdecl.}; userData: pointer;
    destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_script_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

type
  unicodeGeneralCategoryT* {.size: sizeof(cint), pure.} = enum
    control = 0
    format = 1
    unassigned = 2
    privateUse = 3
    surrogate = 4
    lowercaseLetter = 5
    modifierLetter = 6
    otherLetter = 7
    titlecaseLetter = 8
    uppercaseLetter = 9
    spacingMark = 10
    enclosingMark = 11
    nonSpacingMark = 12
    decimalNumber = 13
    letterNumber = 14
    otherNumber = 15
    connectPunctuation = 16
    dashPunctuation = 17
    closePunctuation = 18
    finalPunctuation = 19
    initialPunctuation = 20
    otherPunctuation = 21
    openPunctuation = 22
    currencySymbol = 23
    modifierSymbol = 24
    mathSymbol = 25
    otherSymbol = 26
    lineSeparator = 27
    paragraphSeparator = 28
    spaceSeparator = 29

type
  unicodeGeneralCategoryFuncT* = proc (ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): unicodeGeneralCategoryT {.cdecl.}

proc hb_unicode_funcs_set_general_category_func(ufuncs: ptr unicodeFuncsT00;
    `func`: proc(ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): unicodeGeneralCategoryT {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) {.
    importc, libprag.}

proc unicodeFuncsSetGeneralCategoryFunc*(ufuncs: unicodeFuncsT; `func`: proc(ufuncs: ptr unicodeFuncsT00;
    unicode: uint32; userData: pointer): unicodeGeneralCategoryT {.cdecl.};
    userData: pointer; destroy: proc(userData: pointer) {.cdecl.}) =
  hb_unicode_funcs_set_general_category_func(cast[ptr unicodeFuncsT00](ufuncs.impl), `func`, userData, destroy)

proc hb_unicode_general_category(ufuncs: ptr unicodeFuncsT00; unicode: uint32): unicodeGeneralCategoryT {.
    importc, libprag.}

proc unicodeGeneralCategory*(ufuncs: unicodeFuncsT; unicode: int): unicodeGeneralCategoryT =
  hb_unicode_general_category(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(unicode))

proc hb_unicode_mirroring(ufuncs: ptr unicodeFuncsT00; unicode: uint32): uint32 {.
    importc, libprag.}

proc unicodeMirroring*(ufuncs: unicodeFuncsT; unicode: int): int =
  int(hb_unicode_mirroring(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(unicode)))

type
  unicodeMirroringFuncT* = proc (ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): uint32 {.cdecl.}

proc hb_unicode_script(ufuncs: ptr unicodeFuncsT00; unicode: uint32): scriptT {.
    importc, libprag.}

proc unicodeScript*(ufuncs: unicodeFuncsT; unicode: int): scriptT =
  hb_unicode_script(cast[ptr unicodeFuncsT00](ufuncs.impl), uint32(unicode))

type
  unicodeScriptFuncT* = proc (ufuncs: ptr unicodeFuncsT00; unicode: uint32; userData: pointer): scriptT {.cdecl.}

type
  userDataKeyT00* {.pure.} = object
  userDataKeyT* = ref object
    impl*: ptr userDataKeyT00
    ignoreFinalizer*: bool

proc hb_gobject_user_data_key_get_type*(): GType {.importc, libprag.}

proc gBoxedFreehb_user_data_key_t*(self: userDataKeyT) =
  if not self.ignoreFinalizer:
    boxedFree(hb_gobject_user_data_key_get_type(), cast[ptr userDataKeyT00](self.impl))

when defined(gcDestructors):
  proc `=destroy`*(self: var typeof(userDataKeyT()[])) =
    when defined(gintroDebug):
      echo "destroy ", $typeof(self), ' ', cast[int](unsafeaddr self)
    if not self.ignoreFinalizer and self.impl != nil:
      boxedFree(hb_gobject_user_data_key_get_type(), cast[ptr userDataKeyT00](self.impl))
      self.impl = nil

proc newWithFinalizer*(x: var userDataKeyT) =
  when defined(gcDestructors):
    new(x)
  else:
    new(x, gBoxedFreehb_user_data_key_t)

type
  varIntT00* {.pure, union.} = object
  varIntT* = ref object
    impl*: ptr varIntT00
    ignoreFinalizer*: bool

type
  variationT00* {.pure.} = object
  variationT* = ref object
    impl*: ptr variationT00
    ignoreFinalizer*: bool

proc hb_variation_to_string(self: ptr variationT00; buf: cstring; size: uint32) {.
    importc, libprag.}

proc stringP*(self: variationT; buf: cstring; size: int) =
  hb_variation_to_string(cast[ptr variationT00](self.impl), buf, uint32(size))

proc hb_font_set_variations(font: ptr fontT00; variations: ptr variationT00;
    variationsLength: uint32) {.
    importc, libprag.}

proc fontSetVariations*(font: fontT; variations: ptr variationT00; variationsLength: int) =
  hb_font_set_variations(cast[ptr fontT00](font.impl), variations, uint32(variationsLength))

proc hb_ot_var_normalize_variations(face: ptr faceT00; variations: ptr variationT00;
    variationsLength: uint32; coords: var ptr int32; coordsLength: var uint32) {.
    importc, libprag.}

proc otVarNormalizeVariations*(face: faceT; variations: variationT;
    variationsLength: int; coords: var seq[int32]; coordsLength: var int) =
  var coordsLength_00: uint32
  var coords_00: ptr int32
  hb_ot_var_normalize_variations(cast[ptr faceT00](face.impl), cast[ptr variationT00](variations.impl), uint32(variationsLength), coords_00, coordsLength_00)
  if coordsLength.addr != nil:
    coordsLength = int(coordsLength_00)
  coords.setLen(coordsLength)
  copyMem(unsafeaddr coords[0], coords_00, coordsLength.int * sizeof(coords[0]))
  cogfree(coords_00)

proc hb_variation_from_string(str: cstring; len: int32; variation: ptr variationT00): int32 {.
    importc, libprag.}

proc variationFromString*(str: cstring; len: int; variation: variationT): int =
  int(hb_variation_from_string(str, int32(len), cast[ptr variationT00](variation.impl)))

proc hb_version(major: var uint32; minor: var uint32; micro: var uint32) {.
    importc, libprag.}

proc version*(major: var int; minor: var int; micro: var int) =
  var major_00: uint32
  var minor_00: uint32
  var micro_00: uint32
  hb_version(major_00, minor_00, micro_00)
  if major.addr != nil:
    major = int(major_00)
  if minor.addr != nil:
    minor = int(minor_00)
  if micro.addr != nil:
    micro = int(micro_00)

proc hb_version_atleast(major: uint32; minor: uint32; micro: uint32): int32 {.
    importc, libprag.}

proc versionAtleast*(major: int; minor: int; micro: int): int =
  int(hb_version_atleast(uint32(major), uint32(minor), uint32(micro)))

proc hb_version_string(): cstring {.
    importc, libprag.}

proc versionString*(): string =
  result = $hb_version_string()
# === remaining symbols:
