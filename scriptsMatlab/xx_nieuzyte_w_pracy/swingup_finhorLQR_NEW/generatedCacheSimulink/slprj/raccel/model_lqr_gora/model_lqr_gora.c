#include "model_lqr_gora.h"
#include "rtwtypes.h"
#include "mwmathutil.h"
#include "model_lqr_gora_private.h"
#include "rt_logging_mmi.h"
#include "model_lqr_gora_capi.h"
#include "model_lqr_gora_dt.h"
extern void * CreateDiagnosticAsVoidPtr_wrapper ( const char * id , int nargs
, ... ) ; RTWExtModeInfo * gblRTWExtModeInfo = NULL ; void
raccelForceExtModeShutdown ( boolean_T extModeStartPktReceived ) { if ( !
extModeStartPktReceived ) { boolean_T stopRequested = false ;
rtExtModeWaitForStartPkt ( gblRTWExtModeInfo , 2 , & stopRequested ) ; }
rtExtModeShutdown ( 2 ) ; }
#include "slsv_diagnostic_codegen_c_api.h"
#include "slsa_sim_engine.h"
const int_T gblNumToFiles = 0 ; const int_T gblNumFrFiles = 0 ; const int_T
gblNumFrWksBlocks = 2 ;
#ifdef RSIM_WITH_SOLVER_MULTITASKING
boolean_T gbl_raccel_isMultitasking = 1 ;
#else
boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
boolean_T gbl_raccel_tid01eq = 1 ; int_T gbl_raccel_NumST = 3 ; const char_T
* gbl_raccel_Version = "9.9 (R2023a) 19-Nov-2022" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#else
UNUSED_PARAMETER ( S ) ;
#endif
} static DataMapInfo rt_dataMapInfo ; DataMapInfo * rt_dataMapInfoPtr = &
rt_dataMapInfo ; rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; const int_T gblNumRootInportBlks = 0 ; const int_T
gblNumModelInputs = 0 ; extern const char * gblInportFileName ; extern
rtInportTUtable * gblInportTUtables ; const int_T gblInportDataTypeIdx [ ] =
{ - 1 } ; const int_T gblInportDims [ ] = { - 1 } ; const int_T
gblInportComplex [ ] = { - 1 } ; const int_T gblInportInterpoFlag [ ] = { - 1
} ; const int_T gblInportContinuous [ ] = { - 1 } ; int_T enableFcnCallFlag [
] = { 1 , 1 , 1 } ; const char * raccelLoadInputsAndAperiodicHitTimes (
SimStruct * S , const char * inportFileName , int * matFileFormat ) { return
rt_RAccelReadInportsMatFile ( S , inportFileName , matFileFormat ) ; }
#include "simstruc.h"
#include "fixedpoint.h"
#include "slsa_sim_engine.h"
#include "simtarget/slSimTgtSLExecSimBridge.h"
#define nypdfceuyx (-1)
B rtB ; X rtX ; DW rtDW ; static SimStruct model_S ; SimStruct * const rtS =
& model_S ; void MdlInitialize ( void ) { boolean_T tmp ; rtDW . bhxcjovhl4 =
1 ; if ( ssIsFirstInitCond ( rtS ) ) { rtX . h0gskvx2t0 [ 0 ] = 0.235 ; rtX .
h0gskvx2t0 [ 1 ] = 0.0 ; rtX . h0gskvx2t0 [ 2 ] = 0.0 ; rtX . h0gskvx2t0 [ 3
] = 0.0 ; tmp = slIsRapidAcceleratorSimulating ( ) ; if ( tmp ) { tmp =
ssGetGlobalInitialStatesAvailable ( rtS ) ; rtDW . bhxcjovhl4 = ! tmp ; }
else { rtDW . bhxcjovhl4 = 1 ; } } rtX . emisowx1s2 = rtP . Integrator_IC ;
rtDW . dbnktdxipl = nypdfceuyx ; rtDW . etzoxq5qdg = 0U ; } void MdlStart (
void ) { { bool externalInputIsInDatasetFormat = false ; void *
pISigstreamManager = rt_GetISigstreamManager ( rtS ) ;
rtwISigstreamManagerGetInputIsInDatasetFormat ( pISigstreamManager , &
externalInputIsInDatasetFormat ) ; if ( externalInputIsInDatasetFormat ) { }
} { { { bool isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU
srcInfo ; sdiLabelU loggedName = sdiGetLabelFromChars ( "radToDeg" ) ;
sdiLabelU origSigName = sdiGetLabelFromChars ( "" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "radToDeg" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "model_lqr_gora/To Workspace" ) ; sdiLabelU blockSID =
sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( "" )
; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars ( "radToDeg" ) ;
sdiAsyncRepoDataTypeHandle hDT = sdiAsyncRepoGetBuiltInDataTypeHandle (
DATA_TYPE_DOUBLE ) ; { sdiComplexity sigComplexity = REAL ;
sdiSampleTimeContinuity stCont = SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray
[ 1 ] = { 4 } ; sigDims . nDims = 1 ; sigDims . dimensions = sigDimsArray ;
srcInfo . numBlockPathElems = 1 ; srcInfo . fullBlockPath = ( sdiFullBlkPathU
) & blockPath ; srcInfo . SID = ( sdiSignalIDU ) & blockSID ; srcInfo .
subPath = subPath ; srcInfo . portIndex = 0 + 1 ; srcInfo . signalName =
sigName ; srcInfo . sigSourceUUID = 0 ; rtDW . bqqou313mg . AQHandles =
sdiStartAsyncioQueueCreation ( hDT , & srcInfo , rt_dataMapInfo . mmi .
InstanceMap . fullPath , "22c1aab0-5e10-4504-bd51-581ced2125f2" ,
sigComplexity , & sigDims , DIMENSIONS_MODE_FIXED , stCont , "" ) ;
sdiCompleteAsyncioQueueCreation ( rtDW . bqqou313mg . AQHandles , hDT , &
srcInfo ) ; if ( rtDW . bqqou313mg . AQHandles ) {
sdiSetSignalSampleTimeString ( rtDW . bqqou313mg . AQHandles , "0.001" ,
0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW . bqqou313mg .
AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . bqqou313mg . AQHandles ,
ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings ( rtDW .
bqqou313mg . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName ( rtDW .
bqqou313mg . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . bqqou313mg . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"state_out" ) ; sdiRegisterWksVariable ( rtDW . bqqou313mg . AQHandles ,
varName , "array" ) ; sdiFreeLabel ( varName ) ; } } } } } { { { bool
isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "control_signal" ) ; sdiLabelU
origSigName = sdiGetLabelFromChars ( "control_signal" ) ; sdiLabelU propName
= sdiGetLabelFromChars ( "control_signal" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "model_lqr_gora/To Workspace1" ) ; sdiLabelU blockSID
= sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( ""
) ; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars (
"control_signal" ) ; sdiAsyncRepoDataTypeHandle hDT =
sdiAsyncRepoGetBuiltInDataTypeHandle ( DATA_TYPE_DOUBLE ) ; { sdiComplexity
sigComplexity = REAL ; sdiSampleTimeContinuity stCont =
SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray [ 1 ] = { 1 } ; sigDims . nDims =
1 ; sigDims . dimensions = sigDimsArray ; srcInfo . numBlockPathElems = 1 ;
srcInfo . fullBlockPath = ( sdiFullBlkPathU ) & blockPath ; srcInfo . SID = (
sdiSignalIDU ) & blockSID ; srcInfo . subPath = subPath ; srcInfo . portIndex
= 0 + 1 ; srcInfo . signalName = sigName ; srcInfo . sigSourceUUID = 0 ; rtDW
. cljbbhe2mi . AQHandles = sdiStartAsyncioQueueCreation ( hDT , & srcInfo ,
rt_dataMapInfo . mmi . InstanceMap . fullPath ,
"98a19275-6832-4a21-95a1-71f0799f5405" , sigComplexity , & sigDims ,
DIMENSIONS_MODE_FIXED , stCont , "" ) ; sdiCompleteAsyncioQueueCreation (
rtDW . cljbbhe2mi . AQHandles , hDT , & srcInfo ) ; if ( rtDW . cljbbhe2mi .
AQHandles ) { sdiSetSignalSampleTimeString ( rtDW . cljbbhe2mi . AQHandles ,
"0.001" , 0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW .
cljbbhe2mi . AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . cljbbhe2mi .
AQHandles , ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings
( rtDW . cljbbhe2mi . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName (
rtDW . cljbbhe2mi . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . cljbbhe2mi . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"u" ) ; sdiRegisterWksVariable ( rtDW . cljbbhe2mi . AQHandles , varName ,
"array" ) ; sdiFreeLabel ( varName ) ; } } } } } { { { bool
isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "  " ) ; sdiLabelU origSigName
= sdiGetLabelFromChars ( "" ) ; sdiLabelU propName = sdiGetLabelFromChars (
"  " ) ; sdiLabelU blockPath = sdiGetLabelFromChars (
"model_lqr_gora/To Workspace2" ) ; sdiLabelU blockSID = sdiGetLabelFromChars
( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( "" ) ; sdiDims sigDims ;
sdiLabelU sigName = sdiGetLabelFromChars ( "  " ) ;
sdiAsyncRepoDataTypeHandle hDT = sdiAsyncRepoGetBuiltInDataTypeHandle (
DATA_TYPE_DOUBLE ) ; { sdiComplexity sigComplexity = REAL ;
sdiSampleTimeContinuity stCont = SAMPLE_TIME_DISCRETE ; int_T sigDimsArray [
1 ] = { 1 } ; sigDims . nDims = 1 ; sigDims . dimensions = sigDimsArray ;
srcInfo . numBlockPathElems = 1 ; srcInfo . fullBlockPath = ( sdiFullBlkPathU
) & blockPath ; srcInfo . SID = ( sdiSignalIDU ) & blockSID ; srcInfo .
subPath = subPath ; srcInfo . portIndex = 0 + 1 ; srcInfo . signalName =
sigName ; srcInfo . sigSourceUUID = 0 ; rtDW . i2oijj1cnb . AQHandles =
sdiStartAsyncioQueueCreation ( hDT , & srcInfo , rt_dataMapInfo . mmi .
InstanceMap . fullPath , "09d5d430-b199-4b72-8282-8ea0362dfb9c" ,
sigComplexity , & sigDims , DIMENSIONS_MODE_FIXED , stCont , "" ) ;
sdiCompleteAsyncioQueueCreation ( rtDW . i2oijj1cnb . AQHandles , hDT , &
srcInfo ) ; if ( rtDW . i2oijj1cnb . AQHandles ) {
sdiSetSignalSampleTimeString ( rtDW . i2oijj1cnb . AQHandles , "0.001" ,
0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW . i2oijj1cnb .
AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . i2oijj1cnb . AQHandles ,
ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings ( rtDW .
i2oijj1cnb . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName ( rtDW .
i2oijj1cnb . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . i2oijj1cnb . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"d" ) ; sdiRegisterWksVariable ( rtDW . i2oijj1cnb . AQHandles , varName ,
"array" ) ; sdiFreeLabel ( varName ) ; } } } } } { { { bool
isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "|x|^2" ) ; sdiLabelU
origSigName = sdiGetLabelFromChars ( "" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "|x|^2" ) ; sdiLabelU blockPath = sdiGetLabelFromChars
(
 "model_lqr_gora/wska&#x17A;nik jako&#x15B;ci sterowania/kwadrat modu&#x142;u wektora stanu"
) ; sdiLabelU blockSID = sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath =
sdiGetLabelFromChars ( "" ) ; sdiDims sigDims ; sdiLabelU sigName =
sdiGetLabelFromChars ( "|x|^2" ) ; sdiAsyncRepoDataTypeHandle hDT =
sdiAsyncRepoGetBuiltInDataTypeHandle ( DATA_TYPE_DOUBLE ) ; { sdiComplexity
sigComplexity = REAL ; sdiSampleTimeContinuity stCont =
SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray [ 1 ] = { 1 } ; sigDims . nDims =
1 ; sigDims . dimensions = sigDimsArray ; srcInfo . numBlockPathElems = 1 ;
srcInfo . fullBlockPath = ( sdiFullBlkPathU ) & blockPath ; srcInfo . SID = (
sdiSignalIDU ) & blockSID ; srcInfo . subPath = subPath ; srcInfo . portIndex
= 0 + 1 ; srcInfo . signalName = sigName ; srcInfo . sigSourceUUID = 0 ; rtDW
. gezyaatx1z . AQHandles = sdiStartAsyncioQueueCreation ( hDT , & srcInfo ,
rt_dataMapInfo . mmi . InstanceMap . fullPath ,
"0642fdc2-73ef-4117-a389-26a68f61d416" , sigComplexity , & sigDims ,
DIMENSIONS_MODE_FIXED , stCont , "" ) ; sdiCompleteAsyncioQueueCreation (
rtDW . gezyaatx1z . AQHandles , hDT , & srcInfo ) ; if ( rtDW . gezyaatx1z .
AQHandles ) { sdiSetSignalSampleTimeString ( rtDW . gezyaatx1z . AQHandles ,
"0.001" , 0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW .
gezyaatx1z . AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . gezyaatx1z .
AQHandles , ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings
( rtDW . gezyaatx1z . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName (
rtDW . gezyaatx1z . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . gezyaatx1z . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"state_norm_squared" ) ; sdiRegisterWksVariable ( rtDW . gezyaatx1z .
AQHandles , varName , "array" ) ; sdiFreeLabel ( varName ) ; } } } } } { { {
bool isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU srcInfo ;
sdiLabelU loggedName = sdiGetLabelFromChars ( "Integrator" ) ; sdiLabelU
origSigName = sdiGetLabelFromChars ( "" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "Integrator" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars (
 "model_lqr_gora/wska&#x17A;nik jako&#x15B;ci sterowania/wska&#x17A;nik IAE z uchybu stanu"
) ; sdiLabelU blockSID = sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath =
sdiGetLabelFromChars ( "" ) ; sdiDims sigDims ; sdiLabelU sigName =
sdiGetLabelFromChars ( "Integrator" ) ; sdiAsyncRepoDataTypeHandle hDT =
sdiAsyncRepoGetBuiltInDataTypeHandle ( DATA_TYPE_DOUBLE ) ; { sdiComplexity
sigComplexity = REAL ; sdiSampleTimeContinuity stCont =
SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray [ 1 ] = { 1 } ; sigDims . nDims =
1 ; sigDims . dimensions = sigDimsArray ; srcInfo . numBlockPathElems = 1 ;
srcInfo . fullBlockPath = ( sdiFullBlkPathU ) & blockPath ; srcInfo . SID = (
sdiSignalIDU ) & blockSID ; srcInfo . subPath = subPath ; srcInfo . portIndex
= 0 + 1 ; srcInfo . signalName = sigName ; srcInfo . sigSourceUUID = 0 ; rtDW
. p3afgontn2 . AQHandles = sdiStartAsyncioQueueCreation ( hDT , & srcInfo ,
rt_dataMapInfo . mmi . InstanceMap . fullPath ,
"64aee81e-60ea-41f5-bbfe-0be7d29b0738" , sigComplexity , & sigDims ,
DIMENSIONS_MODE_FIXED , stCont , "" ) ; sdiCompleteAsyncioQueueCreation (
rtDW . p3afgontn2 . AQHandles , hDT , & srcInfo ) ; if ( rtDW . p3afgontn2 .
AQHandles ) { sdiSetSignalSampleTimeString ( rtDW . p3afgontn2 . AQHandles ,
"0.001" , 0.001 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW .
p3afgontn2 . AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . p3afgontn2 .
AQHandles , ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings
( rtDW . p3afgontn2 . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName (
rtDW . p3afgontn2 . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . p3afgontn2 . AQHandles ) ; }
sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ; sdiFreeLabel (
origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel ( blockPath ) ;
sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if ( !
isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars (
"IAE" ) ; sdiRegisterWksVariable ( rtDW . p3afgontn2 . AQHandles , varName ,
"array" ) ; sdiFreeLabel ( varName ) ; } } } } } rtB . nrgtlprh0m [ 0 ] = rtP
. IC [ 0 ] ; rtB . nrgtlprh0m [ 1 ] = rtP . IC [ 1 ] ; rtB . nrgtlprh0m [ 2 ]
= rtP . IC [ 2 ] ; rtB . nrgtlprh0m [ 3 ] = rtP . IC [ 3 ] ; { FWksInfo *
fromwksInfo ; if ( ( fromwksInfo = ( FWksInfo * ) calloc ( 1 , sizeof (
FWksInfo ) ) ) == ( NULL ) ) { ssSetErrorStatus ( rtS ,
"from workspace STRING(Name) memory allocation error" ) ; } else {
fromwksInfo -> origWorkspaceVarName = "xw_ref_sim" ; fromwksInfo ->
origDataTypeId = 0 ; fromwksInfo -> origIsComplex = 0 ; fromwksInfo ->
origWidth = 1 ; fromwksInfo -> origElSize = sizeof ( real_T ) ; fromwksInfo
-> data = ( void * ) rtP . _Data0 ; fromwksInfo -> nDataPoints = 10001 ;
fromwksInfo -> time = ( double * ) rtP . _Time0 ; rtDW . ngkakcjrzg . TimePtr
= fromwksInfo -> time ; rtDW . ngkakcjrzg . DataPtr = fromwksInfo -> data ;
rtDW . ngkakcjrzg . RSimInfoPtr = fromwksInfo ; } rtDW . iojbqzgrcm .
PrevIndex = 0 ; } { FWksInfo * fromwksInfo ; if ( ( fromwksInfo = ( FWksInfo
* ) calloc ( 1 , sizeof ( FWksInfo ) ) ) == ( NULL ) ) { ssSetErrorStatus (
rtS , "from workspace STRING(Name) memory allocation error" ) ; } else {
fromwksInfo -> origWorkspaceVarName = "d_sim" ; fromwksInfo -> origDataTypeId
= 0 ; fromwksInfo -> origIsComplex = 0 ; fromwksInfo -> origWidth = 1 ;
fromwksInfo -> origElSize = sizeof ( real_T ) ; fromwksInfo -> data = ( void
* ) rtP . _Data0_kzebrya3ks ; fromwksInfo -> nDataPoints = 10001 ;
fromwksInfo -> time = ( double * ) rtP . _Time0_aasimppmux ; rtDW .
akmbeanpsb . TimePtr = fromwksInfo -> time ; rtDW . akmbeanpsb . DataPtr =
fromwksInfo -> data ; rtDW . akmbeanpsb . RSimInfoPtr = fromwksInfo ; } rtDW
. jdfnc1tnv4 . PrevIndex = 0 ; } MdlInitialize ( ) ; } void MdlOutputs (
int_T tid ) { real_T j0n0q3ll5d [ 4 ] ; const real_T * b_params_lepkie ;
real_T B_p ; real_T DEN ; real_T gdtpcmbw0p ; if ( ssIsModeUpdateTimeStep (
rtS ) ) { if ( rtDW . bhxcjovhl4 != 0 ) { rtX . h0gskvx2t0 [ 0 ] = rtB .
nrgtlprh0m [ 0 ] ; rtX . h0gskvx2t0 [ 1 ] = rtB . nrgtlprh0m [ 1 ] ; rtX .
h0gskvx2t0 [ 2 ] = rtB . nrgtlprh0m [ 2 ] ; rtX . h0gskvx2t0 [ 3 ] = rtB .
nrgtlprh0m [ 3 ] ; } rtB . pvpgax4tye [ 0 ] = rtX . h0gskvx2t0 [ 0 ] ; rtB .
pvpgax4tye [ 1 ] = rtX . h0gskvx2t0 [ 1 ] ; rtB . pvpgax4tye [ 2 ] = rtX .
h0gskvx2t0 [ 2 ] ; rtB . pvpgax4tye [ 3 ] = rtX . h0gskvx2t0 [ 3 ] ; } else {
rtB . pvpgax4tye [ 0 ] = rtX . h0gskvx2t0 [ 0 ] ; rtB . pvpgax4tye [ 1 ] =
rtX . h0gskvx2t0 [ 1 ] ; rtB . pvpgax4tye [ 2 ] = rtX . h0gskvx2t0 [ 2 ] ;
rtB . pvpgax4tye [ 3 ] = rtX . h0gskvx2t0 [ 3 ] ; } rtB . pq3sgk21bx = rtP .
Gain1_Gain * rtB . pvpgax4tye [ 1 ] ; rtB . hgaajugsej = rtP . Gain2_Gain *
rtB . pvpgax4tye [ 3 ] ; if ( ssIsSampleHit ( rtS , 1 , 0 ) ) { j0n0q3ll5d [
0 ] = rtB . pvpgax4tye [ 0 ] ; j0n0q3ll5d [ 1 ] = rtB . pq3sgk21bx ;
j0n0q3ll5d [ 2 ] = rtB . pvpgax4tye [ 2 ] ; j0n0q3ll5d [ 3 ] = rtB .
hgaajugsej ; { if ( rtDW . bqqou313mg . AQHandles && ssGetLogOutput ( rtS ) )
{ sdiWriteSignal ( rtDW . bqqou313mg . AQHandles , ssGetTaskTime ( rtS , 1 )
, ( char * ) & j0n0q3ll5d [ 0 ] + 0 ) ; } } { real_T * pDataValues = ( real_T
* ) rtDW . ngkakcjrzg . DataPtr ; real_T * pTimeValues = ( real_T * ) rtDW .
ngkakcjrzg . TimePtr ; int_T currTimeIndex = rtDW . iojbqzgrcm . PrevIndex ;
real_T t = ssGetTaskTime ( rtS , 1 ) ; int numPoints , lastPoint ; FWksInfo *
fromwksInfo = ( FWksInfo * ) rtDW . ngkakcjrzg . RSimInfoPtr ; numPoints =
fromwksInfo -> nDataPoints ; lastPoint = numPoints - 1 ; if ( t <=
pTimeValues [ 0 ] ) { currTimeIndex = 0 ; } else if ( t >= pTimeValues [
lastPoint ] ) { currTimeIndex = lastPoint - 1 ; } else { if ( t < pTimeValues
[ currTimeIndex ] ) { while ( t < pTimeValues [ currTimeIndex ] ) {
currTimeIndex -- ; } } else { while ( t >= pTimeValues [ currTimeIndex + 1 ]
) { currTimeIndex ++ ; } } } rtDW . iojbqzgrcm . PrevIndex = currTimeIndex ;
{ real_T t1 = pTimeValues [ currTimeIndex ] ; real_T t2 = pTimeValues [
currTimeIndex + 1 ] ; if ( t1 == t2 ) { if ( t < t1 ) { rtB . kd0uwmo3pp =
pDataValues [ currTimeIndex ] ; } else { rtB . kd0uwmo3pp = pDataValues [
currTimeIndex + 1 ] ; } } else { real_T f1 = ( t2 - t ) / ( t2 - t1 ) ;
real_T f2 = 1.0 - f1 ; real_T d1 ; real_T d2 ; int_T TimeIndex =
currTimeIndex ; d1 = pDataValues [ TimeIndex ] ; d2 = pDataValues [ TimeIndex
+ 1 ] ; rtB . kd0uwmo3pp = ( real_T ) rtInterpolate ( d1 , d2 , f1 , f2 ) ;
pDataValues += numPoints ; } } } } j0n0q3ll5d [ 0 ] = rtB . pvpgax4tye [ 0 ]
- rtB . kd0uwmo3pp ; j0n0q3ll5d [ 1 ] = rtB . pvpgax4tye [ 1 ] - rtP .
Constant1_Value [ 0 ] ; j0n0q3ll5d [ 2 ] = rtB . pvpgax4tye [ 2 ] - rtP .
Constant1_Value [ 1 ] ; j0n0q3ll5d [ 3 ] = rtB . pvpgax4tye [ 3 ] - rtP .
Constant1_Value [ 2 ] ; gdtpcmbw0p = ( ( rtP . dupa_Gain * j0n0q3ll5d [ 0 ] *
rtP . stateFeedbackGain_Gain [ 0 ] + rtP . dupa_Gain * j0n0q3ll5d [ 1 ] * rtP
. stateFeedbackGain_Gain [ 1 ] ) + rtP . dupa_Gain * j0n0q3ll5d [ 2 ] * rtP .
stateFeedbackGain_Gain [ 2 ] ) + rtP . dupa_Gain * j0n0q3ll5d [ 3 ] * rtP .
stateFeedbackGain_Gain [ 3 ] ; if ( gdtpcmbw0p > rtP . sat [ 0 ] ) { rtB .
k1qu4d4pty = rtP . sat [ 0 ] ; } else if ( gdtpcmbw0p < rtP . sat [ 1 ] ) {
rtB . k1qu4d4pty = rtP . sat [ 1 ] ; } else { rtB . k1qu4d4pty = gdtpcmbw0p ;
} if ( ssIsSampleHit ( rtS , 1 , 0 ) ) { { if ( rtDW . cljbbhe2mi . AQHandles
&& ssGetLogOutput ( rtS ) ) { sdiWriteSignal ( rtDW . cljbbhe2mi . AQHandles
, ssGetTaskTime ( rtS , 1 ) , ( char * ) & rtB . k1qu4d4pty + 0 ) ; } } {
real_T * pDataValues = ( real_T * ) rtDW . akmbeanpsb . DataPtr ; real_T *
pTimeValues = ( real_T * ) rtDW . akmbeanpsb . TimePtr ; int_T currTimeIndex
= rtDW . jdfnc1tnv4 . PrevIndex ; real_T t = ssGetTaskTime ( rtS , 1 ) ; int
numPoints , lastPoint ; FWksInfo * fromwksInfo = ( FWksInfo * ) rtDW .
akmbeanpsb . RSimInfoPtr ; numPoints = fromwksInfo -> nDataPoints ; lastPoint
= numPoints - 1 ; if ( t <= pTimeValues [ 0 ] ) { currTimeIndex = 0 ; } else
if ( t >= pTimeValues [ lastPoint ] ) { currTimeIndex = lastPoint - 1 ; }
else { if ( t < pTimeValues [ currTimeIndex ] ) { while ( t < pTimeValues [
currTimeIndex ] ) { currTimeIndex -- ; } } else { while ( t >= pTimeValues [
currTimeIndex + 1 ] ) { currTimeIndex ++ ; } } } rtDW . jdfnc1tnv4 .
PrevIndex = currTimeIndex ; { real_T t1 = pTimeValues [ currTimeIndex ] ;
real_T t2 = pTimeValues [ currTimeIndex + 1 ] ; if ( t1 == t2 ) { if ( t < t1
) { rtB . h4fgf240rl = pDataValues [ currTimeIndex ] ; } else { rtB .
h4fgf240rl = pDataValues [ currTimeIndex + 1 ] ; } } else { real_T f1 = ( t2
- t ) / ( t2 - t1 ) ; real_T f2 = 1.0 - f1 ; real_T d1 ; real_T d2 ; int_T
TimeIndex = currTimeIndex ; d1 = pDataValues [ TimeIndex ] ; d2 = pDataValues
[ TimeIndex + 1 ] ; rtB . h4fgf240rl = ( real_T ) rtInterpolate ( d1 , d2 ,
f1 , f2 ) ; pDataValues += numPoints ; } } } { if ( rtDW . i2oijj1cnb .
AQHandles && ssGetLogOutput ( rtS ) ) { sdiWriteSignal ( rtDW . i2oijj1cnb .
AQHandles , ssGetTaskTime ( rtS , 1 ) , ( char * ) & rtB . h4fgf240rl + 0 ) ;
} } } rtB . fnd21kysjr = rtX . emisowx1s2 ; if ( ssIsSampleHit ( rtS , 1 , 0
) ) { } gdtpcmbw0p = muDoubleScalarSqrt ( ( ( j0n0q3ll5d [ 0 ] * j0n0q3ll5d [
0 ] + j0n0q3ll5d [ 1 ] * j0n0q3ll5d [ 1 ] ) + j0n0q3ll5d [ 2 ] * j0n0q3ll5d [
2 ] ) + j0n0q3ll5d [ 3 ] * j0n0q3ll5d [ 3 ] ) ; rtB . ixyur2sziu = gdtpcmbw0p
* gdtpcmbw0p ; if ( ssIsSampleHit ( rtS , 1 , 0 ) ) { { if ( rtDW .
gezyaatx1z . AQHandles && ssGetLogOutput ( rtS ) ) { sdiWriteSignal ( rtDW .
gezyaatx1z . AQHandles , ssGetTaskTime ( rtS , 1 ) , ( char * ) & rtB .
ixyur2sziu + 0 ) ; } } { if ( rtDW . p3afgontn2 . AQHandles && ssGetLogOutput
( rtS ) ) { sdiWriteSignal ( rtDW . p3afgontn2 . AQHandles , ssGetTaskTime (
rtS , 1 ) , ( char * ) & rtB . fnd21kysjr + 0 ) ; } } } rtDW . dbnktdxipl =
nypdfceuyx ; b_params_lepkie = & rtP . params_lepkie [ 0 ] ; gdtpcmbw0p = (
b_params_lepkie [ 8 ] * b_params_lepkie [ 10 ] * ( rtB . pvpgax4tye [ 3 ] *
rtB . pvpgax4tye [ 3 ] ) * muDoubleScalarSin ( rtB . pvpgax4tye [ 1 ] ) + (
rtB . h4fgf240rl * muDoubleScalarCos ( rtB . pvpgax4tye [ 1 ] ) - rtB .
pvpgax4tye [ 2 ] * b_params_lepkie [ 6 ] ) ) + ( b_params_lepkie [ 13 ] * rtB
. k1qu4d4pty - rtB . pvpgax4tye [ 2 ] * b_params_lepkie [ 14 ] ) ; B_p = (
b_params_lepkie [ 5 ] * b_params_lepkie [ 10 ] * b_params_lepkie [ 8 ] *
muDoubleScalarSin ( rtB . pvpgax4tye [ 1 ] ) + rtB . h4fgf240rl *
b_params_lepkie [ 4 ] ) - rtB . pvpgax4tye [ 3 ] * b_params_lepkie [ 7 ] ;
DEN = b_params_lepkie [ 8 ] * b_params_lepkie [ 10 ] * muDoubleScalarCos (
rtB . pvpgax4tye [ 1 ] ) ; DEN = b_params_lepkie [ 9 ] * b_params_lepkie [ 12
] - DEN * DEN ; rtB . edl4mvzogx [ 0 ] = rtB . pvpgax4tye [ 2 ] ; rtB .
edl4mvzogx [ 1 ] = rtB . pvpgax4tye [ 3 ] ; rtB . edl4mvzogx [ 2 ] = (
b_params_lepkie [ 12 ] * gdtpcmbw0p - b_params_lepkie [ 8 ] * b_params_lepkie
[ 10 ] * muDoubleScalarCos ( rtB . pvpgax4tye [ 1 ] ) * B_p ) / DEN ; rtB .
edl4mvzogx [ 3 ] = ( b_params_lepkie [ 9 ] * B_p - b_params_lepkie [ 8 ] *
b_params_lepkie [ 10 ] * muDoubleScalarCos ( rtB . pvpgax4tye [ 1 ] ) *
gdtpcmbw0p ) / DEN ; UNUSED_PARAMETER ( tid ) ; } void MdlOutputsTID2 ( int_T
tid ) { rtB . nrgtlprh0m [ 0 ] = rtP . IC [ 0 ] ; rtB . nrgtlprh0m [ 1 ] =
rtP . IC [ 1 ] ; rtB . nrgtlprh0m [ 2 ] = rtP . IC [ 2 ] ; rtB . nrgtlprh0m [
3 ] = rtP . IC [ 3 ] ; UNUSED_PARAMETER ( tid ) ; } void MdlUpdate ( int_T
tid ) { rtDW . bhxcjovhl4 = 0 ; UNUSED_PARAMETER ( tid ) ; } void
MdlUpdateTID2 ( int_T tid ) { UNUSED_PARAMETER ( tid ) ; } void
MdlDerivatives ( void ) { XDot * _rtXdot ; _rtXdot = ( ( XDot * ) ssGetdX (
rtS ) ) ; _rtXdot -> h0gskvx2t0 [ 0 ] = rtB . edl4mvzogx [ 0 ] ; _rtXdot ->
h0gskvx2t0 [ 1 ] = rtB . edl4mvzogx [ 1 ] ; _rtXdot -> h0gskvx2t0 [ 2 ] = rtB
. edl4mvzogx [ 2 ] ; _rtXdot -> h0gskvx2t0 [ 3 ] = rtB . edl4mvzogx [ 3 ] ;
_rtXdot -> emisowx1s2 = rtB . ixyur2sziu ; } void MdlProjection ( void ) { }
void MdlTerminate ( void ) { rt_FREE ( rtDW . ngkakcjrzg . RSimInfoPtr ) ;
rt_FREE ( rtDW . akmbeanpsb . RSimInfoPtr ) ; { if ( rtDW . bqqou313mg .
AQHandles ) { sdiTerminateStreaming ( & rtDW . bqqou313mg . AQHandles ) ; } }
{ if ( rtDW . cljbbhe2mi . AQHandles ) { sdiTerminateStreaming ( & rtDW .
cljbbhe2mi . AQHandles ) ; } } { if ( rtDW . i2oijj1cnb . AQHandles ) {
sdiTerminateStreaming ( & rtDW . i2oijj1cnb . AQHandles ) ; } } { if ( rtDW .
gezyaatx1z . AQHandles ) { sdiTerminateStreaming ( & rtDW . gezyaatx1z .
AQHandles ) ; } } { if ( rtDW . p3afgontn2 . AQHandles ) {
sdiTerminateStreaming ( & rtDW . p3afgontn2 . AQHandles ) ; } } } static void
mr_model_lqr_gora_cacheDataAsMxArray ( mxArray * destArray , mwIndex i , int
j , const void * srcData , size_t numBytes ) ; static void
mr_model_lqr_gora_cacheDataAsMxArray ( mxArray * destArray , mwIndex i , int
j , const void * srcData , size_t numBytes ) { mxArray * newArray =
mxCreateUninitNumericMatrix ( ( size_t ) 1 , numBytes , mxUINT8_CLASS ,
mxREAL ) ; memcpy ( ( uint8_T * ) mxGetData ( newArray ) , ( const uint8_T *
) srcData , numBytes ) ; mxSetFieldByNumber ( destArray , i , j , newArray )
; } static void mr_model_lqr_gora_restoreDataFromMxArray ( void * destData ,
const mxArray * srcArray , mwIndex i , int j , size_t numBytes ) ; static
void mr_model_lqr_gora_restoreDataFromMxArray ( void * destData , const
mxArray * srcArray , mwIndex i , int j , size_t numBytes ) { memcpy ( (
uint8_T * ) destData , ( const uint8_T * ) mxGetData ( mxGetFieldByNumber (
srcArray , i , j ) ) , numBytes ) ; } static void
mr_model_lqr_gora_cacheBitFieldToMxArray ( mxArray * destArray , mwIndex i ,
int j , uint_T bitVal ) ; static void
mr_model_lqr_gora_cacheBitFieldToMxArray ( mxArray * destArray , mwIndex i ,
int j , uint_T bitVal ) { mxSetFieldByNumber ( destArray , i , j ,
mxCreateDoubleScalar ( ( real_T ) bitVal ) ) ; } static uint_T
mr_model_lqr_gora_extractBitFieldFromMxArray ( const mxArray * srcArray ,
mwIndex i , int j , uint_T numBits ) ; static uint_T
mr_model_lqr_gora_extractBitFieldFromMxArray ( const mxArray * srcArray ,
mwIndex i , int j , uint_T numBits ) { const uint_T varVal = ( uint_T )
mxGetScalar ( mxGetFieldByNumber ( srcArray , i , j ) ) ; return varVal & ( (
1u << numBits ) - 1u ) ; } static void
mr_model_lqr_gora_cacheDataToMxArrayWithOffset ( mxArray * destArray ,
mwIndex i , int j , mwIndex offset , const void * srcData , size_t numBytes )
; static void mr_model_lqr_gora_cacheDataToMxArrayWithOffset ( mxArray *
destArray , mwIndex i , int j , mwIndex offset , const void * srcData ,
size_t numBytes ) { uint8_T * varData = ( uint8_T * ) mxGetData (
mxGetFieldByNumber ( destArray , i , j ) ) ; memcpy ( ( uint8_T * ) & varData
[ offset * numBytes ] , ( const uint8_T * ) srcData , numBytes ) ; } static
void mr_model_lqr_gora_restoreDataFromMxArrayWithOffset ( void * destData ,
const mxArray * srcArray , mwIndex i , int j , mwIndex offset , size_t
numBytes ) ; static void mr_model_lqr_gora_restoreDataFromMxArrayWithOffset (
void * destData , const mxArray * srcArray , mwIndex i , int j , mwIndex
offset , size_t numBytes ) { const uint8_T * varData = ( const uint8_T * )
mxGetData ( mxGetFieldByNumber ( srcArray , i , j ) ) ; memcpy ( ( uint8_T *
) destData , ( const uint8_T * ) & varData [ offset * numBytes ] , numBytes )
; } static void mr_model_lqr_gora_cacheBitFieldToCellArrayWithOffset (
mxArray * destArray , mwIndex i , int j , mwIndex offset , uint_T fieldVal )
; static void mr_model_lqr_gora_cacheBitFieldToCellArrayWithOffset ( mxArray
* destArray , mwIndex i , int j , mwIndex offset , uint_T fieldVal ) {
mxSetCell ( mxGetFieldByNumber ( destArray , i , j ) , offset ,
mxCreateDoubleScalar ( ( real_T ) fieldVal ) ) ; } static uint_T
mr_model_lqr_gora_extractBitFieldFromCellArrayWithOffset ( const mxArray *
srcArray , mwIndex i , int j , mwIndex offset , uint_T numBits ) ; static
uint_T mr_model_lqr_gora_extractBitFieldFromCellArrayWithOffset ( const
mxArray * srcArray , mwIndex i , int j , mwIndex offset , uint_T numBits ) {
const uint_T fieldVal = ( uint_T ) mxGetScalar ( mxGetCell (
mxGetFieldByNumber ( srcArray , i , j ) , offset ) ) ; return fieldVal & ( (
1u << numBits ) - 1u ) ; } mxArray * mr_model_lqr_gora_GetDWork ( ) { static
const char_T * ssDWFieldNames [ 3 ] = { "rtB" , "rtDW" , "NULL_PrevZCX" , } ;
mxArray * ssDW = mxCreateStructMatrix ( 1 , 1 , 3 , ssDWFieldNames ) ;
mr_model_lqr_gora_cacheDataAsMxArray ( ssDW , 0 , 0 , ( const void * ) & (
rtB ) , sizeof ( rtB ) ) ; { static const char_T * rtdwDataFieldNames [ 6 ] =
{ "rtDW.dbnktdxipl" , "rtDW.bhxcjovhl4" , "rtDW.iojbqzgrcm" ,
"rtDW.jdfnc1tnv4" , "rtDW.etzoxq5qdg" , "rtDW.oxfaw31eo4" , } ; mxArray *
rtdwData = mxCreateStructMatrix ( 1 , 1 , 6 , rtdwDataFieldNames ) ;
mr_model_lqr_gora_cacheDataAsMxArray ( rtdwData , 0 , 0 , ( const void * ) &
( rtDW . dbnktdxipl ) , sizeof ( rtDW . dbnktdxipl ) ) ;
mr_model_lqr_gora_cacheDataAsMxArray ( rtdwData , 0 , 1 , ( const void * ) &
( rtDW . bhxcjovhl4 ) , sizeof ( rtDW . bhxcjovhl4 ) ) ;
mr_model_lqr_gora_cacheDataAsMxArray ( rtdwData , 0 , 2 , ( const void * ) &
( rtDW . iojbqzgrcm ) , sizeof ( rtDW . iojbqzgrcm ) ) ;
mr_model_lqr_gora_cacheDataAsMxArray ( rtdwData , 0 , 3 , ( const void * ) &
( rtDW . jdfnc1tnv4 ) , sizeof ( rtDW . jdfnc1tnv4 ) ) ;
mr_model_lqr_gora_cacheDataAsMxArray ( rtdwData , 0 , 4 , ( const void * ) &
( rtDW . etzoxq5qdg ) , sizeof ( rtDW . etzoxq5qdg ) ) ;
mr_model_lqr_gora_cacheDataAsMxArray ( rtdwData , 0 , 5 , ( const void * ) &
( rtDW . oxfaw31eo4 ) , sizeof ( rtDW . oxfaw31eo4 ) ) ; mxSetFieldByNumber (
ssDW , 0 , 1 , rtdwData ) ; } return ssDW ; } void mr_model_lqr_gora_SetDWork
( const mxArray * ssDW ) { ( void ) ssDW ;
mr_model_lqr_gora_restoreDataFromMxArray ( ( void * ) & ( rtB ) , ssDW , 0 ,
0 , sizeof ( rtB ) ) ; { const mxArray * rtdwData = mxGetFieldByNumber ( ssDW
, 0 , 1 ) ; mr_model_lqr_gora_restoreDataFromMxArray ( ( void * ) & ( rtDW .
dbnktdxipl ) , rtdwData , 0 , 0 , sizeof ( rtDW . dbnktdxipl ) ) ;
mr_model_lqr_gora_restoreDataFromMxArray ( ( void * ) & ( rtDW . bhxcjovhl4 )
, rtdwData , 0 , 1 , sizeof ( rtDW . bhxcjovhl4 ) ) ;
mr_model_lqr_gora_restoreDataFromMxArray ( ( void * ) & ( rtDW . iojbqzgrcm )
, rtdwData , 0 , 2 , sizeof ( rtDW . iojbqzgrcm ) ) ;
mr_model_lqr_gora_restoreDataFromMxArray ( ( void * ) & ( rtDW . jdfnc1tnv4 )
, rtdwData , 0 , 3 , sizeof ( rtDW . jdfnc1tnv4 ) ) ;
mr_model_lqr_gora_restoreDataFromMxArray ( ( void * ) & ( rtDW . etzoxq5qdg )
, rtdwData , 0 , 4 , sizeof ( rtDW . etzoxq5qdg ) ) ;
mr_model_lqr_gora_restoreDataFromMxArray ( ( void * ) & ( rtDW . oxfaw31eo4 )
, rtdwData , 0 , 5 , sizeof ( rtDW . oxfaw31eo4 ) ) ; } } mxArray *
mr_model_lqr_gora_GetSimStateDisallowedBlocks ( ) { mxArray * data =
mxCreateCellMatrix ( 1 , 3 ) ; mwIndex subs [ 2 ] , offset ; { static const
char_T * blockType [ 1 ] = { "Scope" , } ; static const char_T * blockPath [
1 ] = { "model_lqr_gora/wska&#x17A;nik jako&#x15B;ci sterowania/Scope" , } ;
static const int reason [ 1 ] = { 0 , } ; for ( subs [ 0 ] = 0 ; subs [ 0 ] <
1 ; ++ ( subs [ 0 ] ) ) { subs [ 1 ] = 0 ; offset = mxCalcSingleSubscript (
data , 2 , subs ) ; mxSetCell ( data , offset , mxCreateString ( blockType [
subs [ 0 ] ] ) ) ; subs [ 1 ] = 1 ; offset = mxCalcSingleSubscript ( data , 2
, subs ) ; mxSetCell ( data , offset , mxCreateString ( blockPath [ subs [ 0
] ] ) ) ; subs [ 1 ] = 2 ; offset = mxCalcSingleSubscript ( data , 2 , subs )
; mxSetCell ( data , offset , mxCreateDoubleScalar ( ( real_T ) reason [ subs
[ 0 ] ] ) ) ; } } return data ; } void MdlInitializeSizes ( void ) {
ssSetNumContStates ( rtS , 5 ) ; ssSetNumPeriodicContStates ( rtS , 0 ) ;
ssSetNumY ( rtS , 0 ) ; ssSetNumU ( rtS , 0 ) ; ssSetDirectFeedThrough ( rtS
, 0 ) ; ssSetNumSampleTimes ( rtS , 2 ) ; ssSetNumBlocks ( rtS , 24 ) ;
ssSetNumBlockIO ( rtS , 10 ) ; ssSetNumBlockParams ( rtS , 40036 ) ; } void
MdlInitializeSampleTimes ( void ) { ssSetSampleTime ( rtS , 0 , 0.0 ) ;
ssSetSampleTime ( rtS , 1 , 0.001 ) ; ssSetOffsetTime ( rtS , 0 , 0.0 ) ;
ssSetOffsetTime ( rtS , 1 , 0.0 ) ; } void raccel_set_checksum ( ) {
ssSetChecksumVal ( rtS , 0 , 712436791U ) ; ssSetChecksumVal ( rtS , 1 ,
3733948204U ) ; ssSetChecksumVal ( rtS , 2 , 803129595U ) ; ssSetChecksumVal
( rtS , 3 , 1113528646U ) ; }
#if defined(_MSC_VER)
#pragma optimize( "", off )
#endif
SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) {
static struct _ssMdlInfo mdlInfo ; static struct _ssBlkInfo2 blkInfo2 ;
static struct _ssBlkInfoSLSize blkInfoSLSize ; ( void ) memset ( ( char_T * )
rtS , 0 , sizeof ( SimStruct ) ) ; ( void ) memset ( ( char_T * ) & mdlInfo ,
0 , sizeof ( struct _ssMdlInfo ) ) ; ( void ) memset ( ( char_T * ) &
blkInfo2 , 0 , sizeof ( struct _ssBlkInfo2 ) ) ; ( void ) memset ( ( char_T *
) & blkInfoSLSize , 0 , sizeof ( struct _ssBlkInfoSLSize ) ) ;
ssSetBlkInfo2Ptr ( rtS , & blkInfo2 ) ; ssSetBlkInfoSLSizePtr ( rtS , &
blkInfoSLSize ) ; ssSetMdlInfoPtr ( rtS , & mdlInfo ) ; ssSetExecutionInfo (
rtS , executionInfo ) ; slsaAllocOPModelData ( rtS ) ; { static time_T
mdlPeriod [ NSAMPLE_TIMES ] ; static time_T mdlOffset [ NSAMPLE_TIMES ] ;
static time_T mdlTaskTimes [ NSAMPLE_TIMES ] ; static int_T mdlTsMap [
NSAMPLE_TIMES ] ; static int_T mdlSampleHits [ NSAMPLE_TIMES ] ; static
boolean_T mdlTNextWasAdjustedPtr [ NSAMPLE_TIMES ] ; static int_T
mdlPerTaskSampleHits [ NSAMPLE_TIMES * NSAMPLE_TIMES ] ; static time_T
mdlTimeOfNextSampleHit [ NSAMPLE_TIMES ] ; { int_T i ; for ( i = 0 ; i <
NSAMPLE_TIMES ; i ++ ) { mdlPeriod [ i ] = 0.0 ; mdlOffset [ i ] = 0.0 ;
mdlTaskTimes [ i ] = 0.0 ; mdlTsMap [ i ] = i ; mdlSampleHits [ i ] = 1 ; } }
ssSetSampleTimePtr ( rtS , & mdlPeriod [ 0 ] ) ; ssSetOffsetTimePtr ( rtS , &
mdlOffset [ 0 ] ) ; ssSetSampleTimeTaskIDPtr ( rtS , & mdlTsMap [ 0 ] ) ;
ssSetTPtr ( rtS , & mdlTaskTimes [ 0 ] ) ; ssSetSampleHitPtr ( rtS , &
mdlSampleHits [ 0 ] ) ; ssSetTNextWasAdjustedPtr ( rtS , &
mdlTNextWasAdjustedPtr [ 0 ] ) ; ssSetPerTaskSampleHitsPtr ( rtS , &
mdlPerTaskSampleHits [ 0 ] ) ; ssSetTimeOfNextSampleHitPtr ( rtS , &
mdlTimeOfNextSampleHit [ 0 ] ) ; } ssSetSolverMode ( rtS ,
SOLVER_MODE_SINGLETASKING ) ; { ssSetBlockIO ( rtS , ( ( void * ) & rtB ) ) ;
( void ) memset ( ( ( void * ) & rtB ) , 0 , sizeof ( B ) ) ; } { real_T * x
= ( real_T * ) & rtX ; ssSetContStates ( rtS , x ) ; ( void ) memset ( ( void
* ) x , 0 , sizeof ( X ) ) ; } { void * dwork = ( void * ) & rtDW ;
ssSetRootDWork ( rtS , dwork ) ; ( void ) memset ( dwork , 0 , sizeof ( DW )
) ; } { static DataTypeTransInfo dtInfo ; ( void ) memset ( ( char_T * ) &
dtInfo , 0 , sizeof ( dtInfo ) ) ; ssSetModelMappingInfo ( rtS , & dtInfo ) ;
dtInfo . numDataTypes = 25 ; dtInfo . dataTypeSizes = & rtDataTypeSizes [ 0 ]
; dtInfo . dataTypeNames = & rtDataTypeNames [ 0 ] ; dtInfo . BTransTable = &
rtBTransTable ; dtInfo . PTransTable = & rtPTransTable ; dtInfo .
dataTypeInfoTable = rtDataTypeInfoTable ; }
model_lqr_gora_InitializeDataMapInfo ( ) ; ssSetIsRapidAcceleratorActive (
rtS , true ) ; ssSetRootSS ( rtS , rtS ) ; ssSetVersion ( rtS ,
SIMSTRUCT_VERSION_LEVEL2 ) ; ssSetModelName ( rtS , "model_lqr_gora" ) ;
ssSetPath ( rtS , "model_lqr_gora" ) ; ssSetTStart ( rtS , 0.0 ) ;
ssSetTFinal ( rtS , 10.0 ) ; ssSetStepSize ( rtS , 0.001 ) ;
ssSetFixedStepSize ( rtS , 0.001 ) ; { static RTWLogInfo rt_DataLoggingInfo ;
rt_DataLoggingInfo . loggingInterval = ( NULL ) ; ssSetRTWLogInfo ( rtS , &
rt_DataLoggingInfo ) ; } { { static int_T rt_LoggedStateWidths [ ] = { 4 , 1
} ; static int_T rt_LoggedStateNumDimensions [ ] = { 1 , 1 } ; static int_T
rt_LoggedStateDimensions [ ] = { 4 , 1 } ; static boolean_T
rt_LoggedStateIsVarDims [ ] = { 0 , 0 } ; static BuiltInDTypeId
rt_LoggedStateDataTypeIds [ ] = { SS_DOUBLE , SS_DOUBLE } ; static int_T
rt_LoggedStateComplexSignals [ ] = { 0 , 0 } ; static RTWPreprocessingFcnPtr
rt_LoggingStatePreprocessingFcnPtrs [ ] = { ( NULL ) , ( NULL ) } ; static
const char_T * rt_LoggedStateLabels [ ] = { "CSTATE" , "CSTATE" } ; static
const char_T * rt_LoggedStateBlockNames [ ] = {
"model_lqr_gora/IP/Integrator" ,
"model_lqr_gora/wska&#x17A;nik jako&#x15B;ci sterowania/Integrator" } ;
static const char_T * rt_LoggedStateNames [ ] = { "" , "" } ; static
boolean_T rt_LoggedStateCrossMdlRef [ ] = { 0 , 0 } ; static
RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0
, 0 , 1.0 , 0 , 0.0 } } ; static int_T rt_LoggedStateIdxList [ ] = { 0 , 1 }
; static RTWLogSignalInfo rt_LoggedStateSignalInfo = { 2 ,
rt_LoggedStateWidths , rt_LoggedStateNumDimensions , rt_LoggedStateDimensions
, rt_LoggedStateIsVarDims , ( NULL ) , ( NULL ) , rt_LoggedStateDataTypeIds ,
rt_LoggedStateComplexSignals , ( NULL ) , rt_LoggingStatePreprocessingFcnPtrs
, { rt_LoggedStateLabels } , ( NULL ) , ( NULL ) , ( NULL ) , {
rt_LoggedStateBlockNames } , { rt_LoggedStateNames } ,
rt_LoggedStateCrossMdlRef , rt_RTWLogDataTypeConvert , rt_LoggedStateIdxList
} ; static void * rt_LoggedStateSignalPtrs [ 2 ] ; rtliSetLogXSignalPtrs (
ssGetRTWLogInfo ( rtS ) , ( LogSignalPtrsType ) rt_LoggedStateSignalPtrs ) ;
rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) , & rt_LoggedStateSignalInfo
) ; rt_LoggedStateSignalPtrs [ 0 ] = ( void * ) & rtX . h0gskvx2t0 [ 0 ] ;
rt_LoggedStateSignalPtrs [ 1 ] = ( void * ) & rtX . emisowx1s2 ; }
rtliSetLogT ( ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX (
ssGetRTWLogInfo ( rtS ) , "" ) ; rtliSetLogXFinal ( ssGetRTWLogInfo ( rtS ) ,
"xFinal" ) ; rtliSetLogVarNameModifier ( ssGetRTWLogInfo ( rtS ) , "none" ) ;
rtliSetLogFormat ( ssGetRTWLogInfo ( rtS ) , 4 ) ; rtliSetLogMaxRows (
ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogDecimation ( ssGetRTWLogInfo ( rtS
) , 1 ) ; rtliSetLogY ( ssGetRTWLogInfo ( rtS ) , "" ) ;
rtliSetLogYSignalInfo ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ;
rtliSetLogYSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ; } { static
struct _ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , & statesInfo2 )
; } { static ssPeriodicStatesInfo periodicStatesInfo ;
ssSetPeriodicStatesInfo ( rtS , & periodicStatesInfo ) ; } { static
ssJacobianPerturbationBounds jacobianPerturbationBounds ;
ssSetJacobianPerturbationBounds ( rtS , & jacobianPerturbationBounds ) ; } {
static ssSolverInfo slvrInfo ; static boolean_T contStatesDisabled [ 5 ] ;
static ssNonContDerivSigInfo nonContDerivSigInfo [ 2 ] = { { 1 * sizeof (
real_T ) , ( char * ) ( & rtB . h4fgf240rl ) , ( NULL ) } , { 1 * sizeof (
real_T ) , ( char * ) ( & rtB . kd0uwmo3pp ) , ( NULL ) } } ;
ssSetNumNonContDerivSigInfos ( rtS , 2 ) ; ssSetNonContDerivSigInfos ( rtS ,
nonContDerivSigInfo ) ; ssSetSolverInfo ( rtS , & slvrInfo ) ;
ssSetSolverName ( rtS , "ode4" ) ; ssSetVariableStepSolver ( rtS , 0 ) ;
ssSetSolverConsistencyChecking ( rtS , 0 ) ; ssSetSolverAdaptiveZcDetection (
rtS , 0 ) ; ssSetSolverRobustResetMethod ( rtS , 0 ) ;
ssSetSolverStateProjection ( rtS , 0 ) ; ssSetSolverMassMatrixType ( rtS , (
ssMatrixType ) 0 ) ; ssSetSolverMassMatrixNzMax ( rtS , 0 ) ;
ssSetModelOutputs ( rtS , MdlOutputs ) ; ssSetModelUpdate ( rtS , MdlUpdate )
; ssSetModelDerivatives ( rtS , MdlDerivatives ) ; ssSetTNextTid ( rtS ,
INT_MIN ) ; ssSetTNext ( rtS , rtMinusInf ) ; ssSetSolverNeedsReset ( rtS ) ;
ssSetNumNonsampledZCs ( rtS , 0 ) ; ssSetContStateDisabled ( rtS ,
contStatesDisabled ) ; } ssSetChecksumVal ( rtS , 0 , 712436791U ) ;
ssSetChecksumVal ( rtS , 1 , 3733948204U ) ; ssSetChecksumVal ( rtS , 2 ,
803129595U ) ; ssSetChecksumVal ( rtS , 3 , 1113528646U ) ; { static const
sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo
rt_ExtModeInfo ; static const sysRanDType * systemRan [ 2 ] ;
gblRTWExtModeInfo = & rt_ExtModeInfo ; ssSetRTWExtModeInfo ( rtS , &
rt_ExtModeInfo ) ; rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo ,
systemRan ) ; systemRan [ 0 ] = & rtAlwaysEnabled ; systemRan [ 1 ] = &
rtAlwaysEnabled ; rteiSetModelMappingInfoPtr ( ssGetRTWExtModeInfo ( rtS ) ,
& ssGetModelMappingInfo ( rtS ) ) ; rteiSetChecksumsPtr ( ssGetRTWExtModeInfo
( rtS ) , ssGetChecksums ( rtS ) ) ; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS
) , ssGetTPtr ( rtS ) ) ; } slsaDisallowedBlocksForSimTargetOP ( rtS ,
mr_model_lqr_gora_GetSimStateDisallowedBlocks ) ;
slsaGetWorkFcnForSimTargetOP ( rtS , mr_model_lqr_gora_GetDWork ) ;
slsaSetWorkFcnForSimTargetOP ( rtS , mr_model_lqr_gora_SetDWork ) ;
rt_RapidReadMatFileAndUpdateParams ( rtS ) ; if ( ssGetErrorStatus ( rtS ) )
{ return rtS ; } return rtS ; }
#if defined(_MSC_VER)
#pragma optimize( "", on )
#endif
const int_T gblParameterTuningTid = 2 ; void MdlOutputsParameterSampleTime (
int_T tid ) { MdlOutputsTID2 ( tid ) ; }
