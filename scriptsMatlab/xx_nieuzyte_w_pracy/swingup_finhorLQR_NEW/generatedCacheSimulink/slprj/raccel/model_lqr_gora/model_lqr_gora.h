#ifndef RTW_HEADER_model_lqr_gora_h_
#define RTW_HEADER_model_lqr_gora_h_
#ifndef model_lqr_gora_COMMON_INCLUDES_
#define model_lqr_gora_COMMON_INCLUDES_
#include <stdlib.h>
#include "sl_AsyncioQueue/AsyncioQueueCAPI.h"
#include "rtwtypes.h"
#include "sigstream_rtw.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging_simtarget.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "model_lqr_gora_types.h"
#include "mwmathutil.h"
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#include "rt_defines.h"
#include <string.h>
#include "rt_nonfinite.h"
#define MODEL_NAME model_lqr_gora
#define NSAMPLE_TIMES (3) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (10) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (5)   
#elif NCSTATES != 5
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T pvpgax4tye [ 4 ] ; real_T pq3sgk21bx ; real_T
hgaajugsej ; real_T kd0uwmo3pp ; real_T k1qu4d4pty ; real_T h4fgf240rl ;
real_T fnd21kysjr ; real_T ixyur2sziu ; real_T nrgtlprh0m [ 4 ] ; real_T
edl4mvzogx [ 4 ] ; } B ; typedef struct { struct { void * AQHandles ; }
bqqou313mg ; struct { void * TimePtr ; void * DataPtr ; void * RSimInfoPtr ;
} ngkakcjrzg ; struct { void * AQHandles ; } cljbbhe2mi ; struct { void *
TimePtr ; void * DataPtr ; void * RSimInfoPtr ; } akmbeanpsb ; struct { void
* AQHandles ; } i2oijj1cnb ; struct { void * LoggedData ; } nnxj51zfla ;
struct { void * AQHandles ; } gezyaatx1z ; struct { void * AQHandles ; }
p3afgontn2 ; int32_T dbnktdxipl ; int_T bhxcjovhl4 ; struct { int_T PrevIndex
; } iojbqzgrcm ; struct { int_T PrevIndex ; } jdfnc1tnv4 ; uint8_T etzoxq5qdg
; boolean_T oxfaw31eo4 ; } DW ; typedef struct { real_T h0gskvx2t0 [ 4 ] ;
real_T emisowx1s2 ; } X ; typedef struct { real_T h0gskvx2t0 [ 4 ] ; real_T
emisowx1s2 ; } XDot ; typedef struct { boolean_T h0gskvx2t0 [ 4 ] ; boolean_T
emisowx1s2 ; } XDis ; typedef struct { rtwCAPI_ModelMappingInfo mmi ; }
DataMapInfo ; struct P_ { real_T IC [ 4 ] ; real_T params_lepkie [ 15 ] ;
real_T sat [ 2 ] ; real_T Gain1_Gain ; real_T Gain2_Gain ; real_T _Time0 [
10001 ] ; real_T _Data0 [ 10001 ] ; real_T dupa_Gain ; real_T
stateFeedbackGain_Gain [ 4 ] ; real_T _Time0_aasimppmux [ 10001 ] ; real_T
_Data0_kzebrya3ks [ 10001 ] ; real_T Integrator_IC ; real_T Constant1_Value [
3 ] ; } ; extern const char_T * RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ;
extern X rtX ; extern DW rtDW ; extern P rtP ; extern mxArray *
mr_model_lqr_gora_GetDWork ( ) ; extern void mr_model_lqr_gora_SetDWork (
const mxArray * ssDW ) ; extern mxArray *
mr_model_lqr_gora_GetSimStateDisallowedBlocks ( ) ; extern const
rtwCAPI_ModelMappingStaticInfo * model_lqr_gora_GetCAPIStaticMap ( void ) ;
extern SimStruct * const rtS ; extern const int_T gblNumToFiles ; extern
const int_T gblNumFrFiles ; extern const int_T gblNumFrWksBlocks ; extern
rtInportTUtable * gblInportTUtables ; extern const char * gblInportFileName ;
extern const int_T gblNumRootInportBlks ; extern const int_T
gblNumModelInputs ; extern const int_T gblInportDataTypeIdx [ ] ; extern
const int_T gblInportDims [ ] ; extern const int_T gblInportComplex [ ] ;
extern const int_T gblInportInterpoFlag [ ] ; extern const int_T
gblInportContinuous [ ] ; extern const int_T gblParameterTuningTid ; extern
DataMapInfo * rt_dataMapInfoPtr ; extern rtwCAPI_ModelMappingInfo *
rt_modelMapInfoPtr ; void MdlOutputs ( int_T tid ) ; void
MdlOutputsParameterSampleTime ( int_T tid ) ; void MdlUpdate ( int_T tid ) ;
void MdlTerminate ( void ) ; void MdlInitializeSizes ( void ) ; void
MdlInitializeSampleTimes ( void ) ; SimStruct * raccel_register_model (
ssExecutionInfo * executionInfo ) ;
#endif
