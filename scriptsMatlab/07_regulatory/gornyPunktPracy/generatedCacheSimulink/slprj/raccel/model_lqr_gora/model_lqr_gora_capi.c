#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "model_lqr_gora_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)
#ifndef SS_UINT64
#define SS_UINT64 19
#endif
#ifndef SS_INT64
#define SS_INT64 20
#endif
#else
#include "builtin_typeid_types.h"
#include "model_lqr_gora.h"
#include "model_lqr_gora_capi.h"
#include "model_lqr_gora_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               ((NULL))
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , TARGET_STRING (
"model_lqr_gora/Constant" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , {
1 , 0 , TARGET_STRING ( "model_lqr_gora/  " ) , TARGET_STRING ( "" ) , 0 , 0
, 1 , 0 , 1 } , { 2 , 1 , TARGET_STRING (
"model_lqr_gora/IP/pendulum_dynamics" ) , TARGET_STRING ( "" ) , 0 , 0 , 2 ,
0 , 2 } , { 3 , 0 , TARGET_STRING (
"model_lqr_gora/IP/pendulum_dynamics/is_active_c3_model_lqr_gora" ) ,
TARGET_STRING ( "is_active_c3_model_lqr_gora" ) , 0 , 1 , 1 , 0 , 2 } , { 4 ,
0 , TARGET_STRING ( "model_lqr_gora/IP/Integrator" ) , TARGET_STRING (
"state" ) , 0 , 0 , 0 , 0 , 2 } , { 5 , 0 , TARGET_STRING (
"model_lqr_gora/kontroler/Saturation" ) , TARGET_STRING ( "" ) , 0 , 0 , 1 ,
0 , 2 } , { 6 , 0 , TARGET_STRING ( "model_lqr_gora/radToDeg/Gain1" ) ,
TARGET_STRING ( "x2_theta_deg" ) , 0 , 0 , 1 , 0 , 2 } , { 7 , 0 ,
TARGET_STRING ( "model_lqr_gora/radToDeg/Gain2" ) , TARGET_STRING (
"x4_Dtheta_deg" ) , 0 , 0 , 1 , 0 , 2 } , { 8 , 0 , TARGET_STRING (
"model_lqr_gora/stan_referencyjny/ " ) , TARGET_STRING ( "" ) , 0 , 0 , 1 , 0
, 1 } , { 9 , 0 , TARGET_STRING (
"model_lqr_gora/wskaŸnik jakoœci sterowania/Integrator" ) , TARGET_STRING (
"" ) , 0 , 0 , 1 , 0 , 2 } , { 10 , 0 , TARGET_STRING (
"model_lqr_gora/wskaŸnik jakoœci sterowania/|x|^2/Square" ) , TARGET_STRING (
"" ) , 0 , 0 , 1 , 0 , 2 } , { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 ,
0 } } ; static const rtwCAPI_BlockParameters rtBlockParameters [ ] = { { 11 ,
TARGET_STRING ( "model_lqr_gora/  " ) , TARGET_STRING ( "Time0" ) , 0 , 3 , 0
} , { 12 , TARGET_STRING ( "model_lqr_gora/  " ) , TARGET_STRING ( "Data0" )
, 0 , 3 , 0 } , { 13 , TARGET_STRING ( "model_lqr_gora/dupa" ) ,
TARGET_STRING ( "Gain" ) , 0 , 1 , 0 } , { 14 , TARGET_STRING (
"model_lqr_gora/kontroler/stateFeedbackGain" ) , TARGET_STRING ( "Gain" ) , 0
, 4 , 0 } , { 15 , TARGET_STRING ( "model_lqr_gora/radToDeg/Gain1" ) ,
TARGET_STRING ( "Gain" ) , 0 , 1 , 0 } , { 16 , TARGET_STRING (
"model_lqr_gora/radToDeg/Gain2" ) , TARGET_STRING ( "Gain" ) , 0 , 1 , 0 } ,
{ 17 , TARGET_STRING ( "model_lqr_gora/stan_referencyjny/Constant1" ) ,
TARGET_STRING ( "Value" ) , 0 , 5 , 0 } , { 18 , TARGET_STRING (
"model_lqr_gora/stan_referencyjny/ " ) , TARGET_STRING ( "Time0" ) , 0 , 3 ,
0 } , { 19 , TARGET_STRING ( "model_lqr_gora/stan_referencyjny/ " ) ,
TARGET_STRING ( "Data0" ) , 0 , 3 , 0 } , { 20 , TARGET_STRING (
"model_lqr_gora/wskaŸnik jakoœci sterowania/Integrator" ) , TARGET_STRING (
"InitialCondition" ) , 0 , 1 , 0 } , { 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 }
} ; static int_T rt_LoggedStateIdxList [ ] = { - 1 } ; static const
rtwCAPI_Signals rtRootInputs [ ] = { { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 ,
0 , 0 , 0 } } ; static const rtwCAPI_Signals rtRootOutputs [ ] = { { 0 , 0 ,
( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const
rtwCAPI_ModelParameters rtModelParameters [ ] = { { 21 , TARGET_STRING ( "IC"
) , 0 , 2 , 0 } , { 22 , TARGET_STRING ( "params_lepkie" ) , 0 , 6 , 0 } , {
23 , TARGET_STRING ( "sat" ) , 0 , 7 , 0 } , { 0 , ( NULL ) , 0 , 0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtB . nrgtlprh0m [ 0 ] , & rtB .
h4fgf240rl , & rtB . edl4mvzogx [ 0 ] , & rtDW . etzoxq5qdg , & rtB .
pvpgax4tye [ 0 ] , & rtB . k1qu4d4pty , & rtB . pq3sgk21bx , & rtB .
hgaajugsej , & rtB . kd0uwmo3pp , & rtB . fnd21kysjr , & rtB . ixyur2sziu , &
rtP . _Time0_aasimppmux [ 0 ] , & rtP . _Data0_kzebrya3ks [ 0 ] , & rtP .
dupa_Gain , & rtP . stateFeedbackGain_Gain [ 0 ] , & rtP . Gain1_Gain , & rtP
. Gain2_Gain , & rtP . Constant1_Value [ 0 ] , & rtP . _Time0 [ 0 ] , & rtP .
_Data0 [ 0 ] , & rtP . Integrator_IC , & rtP . IC [ 0 ] , & rtP .
params_lepkie [ 0 ] , & rtP . sat [ 0 ] , } ; static int32_T *
rtVarDimsAddrMap [ ] = { ( NULL ) } ;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , ( uint8_T ) SS_DOUBLE , 0 , 0 , 0 } ,
{ "unsigned char" , "uint8_T" , 0 , 0 , sizeof ( uint8_T ) , ( uint8_T )
SS_UINT8 , 0 , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_MATRIX_COL_MAJOR , 0 , 2 , 0 } , { rtwCAPI_SCALAR , 2 , 2 , 0 } , {
rtwCAPI_VECTOR , 0 , 2 , 0 } , { rtwCAPI_VECTOR , 4 , 2 , 0 } , {
rtwCAPI_VECTOR , 6 , 2 , 0 } , { rtwCAPI_VECTOR , 8 , 2 , 0 } , {
rtwCAPI_VECTOR , 10 , 2 , 0 } , { rtwCAPI_VECTOR , 12 , 2 , 0 } } ; static
const uint_T rtDimensionArray [ ] = { 4 , 1 , 1 , 1 , 10001 , 1 , 1 , 4 , 3 ,
1 , 1 , 15 , 1 , 2 } ; static const real_T rtcapiStoredFloats [ ] = { 0.001 ,
0.0 } ; static const rtwCAPI_FixPtMap rtFixPtMap [ ] = { { ( NULL ) , ( NULL
) , rtwCAPI_FIX_RESERVED , 0 , 0 , ( boolean_T ) 0 } , } ; static const
rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( NULL ) , ( NULL ) , 2 , 0 }
, { ( const void * ) & rtcapiStoredFloats [ 0 ] , ( const void * ) &
rtcapiStoredFloats [ 1 ] , ( int8_T ) 1 , ( uint8_T ) 0 } , { ( const void *
) & rtcapiStoredFloats [ 1 ] , ( const void * ) & rtcapiStoredFloats [ 1 ] ,
( int8_T ) 0 , ( uint8_T ) 0 } } ; static rtwCAPI_ModelMappingStaticInfo
mmiStatic = { { rtBlockSignals , 11 , rtRootInputs , 0 , rtRootOutputs , 0 }
, { rtBlockParameters , 10 , rtModelParameters , 3 } , { ( NULL ) , 0 } , {
rtDataTypeMap , rtDimensionMap , rtFixPtMap , rtElementMap , rtSampleTimeMap
, rtDimensionArray } , "float" , { 712436791U , 3733948204U , 803129595U ,
1113528646U } , ( NULL ) , 0 , ( boolean_T ) 0 , rt_LoggedStateIdxList } ;
const rtwCAPI_ModelMappingStaticInfo * model_lqr_gora_GetCAPIStaticMap ( void
) { return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void model_lqr_gora_InitializeDataMapInfo ( void ) { rtwCAPI_SetVersion ( ( *
rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap (
( * rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void model_lqr_gora_host_InitializeDataMapInfo (
model_lqr_gora_host_DataMapInfo_T * dataMap , const char * path ) {
rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ; rtwCAPI_SetStaticMap ( dataMap ->
mmi , & mmiStatic ) ; rtwCAPI_SetDataAddressMap ( dataMap -> mmi , ( NULL ) )
; rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetPath ( dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap ->
mmi , ( NULL ) ) ; rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
