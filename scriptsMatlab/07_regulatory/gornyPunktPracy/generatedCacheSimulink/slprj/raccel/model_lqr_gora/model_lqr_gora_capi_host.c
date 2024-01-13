#include "model_lqr_gora_capi_host.h"
static model_lqr_gora_host_DataMapInfo_T root;
static int initialized = 0;
__declspec( dllexport ) rtwCAPI_ModelMappingInfo *getRootMappingInfo()
{
    if (initialized == 0) {
        initialized = 1;
        model_lqr_gora_host_InitializeDataMapInfo(&(root), "model_lqr_gora");
    }
    return &root.mmi;
}

rtwCAPI_ModelMappingInfo *mexFunction(){return(getRootMappingInfo());}
