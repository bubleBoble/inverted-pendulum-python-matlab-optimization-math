; ModuleID = 'test'
source_filename = "test"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @model_lqr_gora_CGInitializeSizes(i8* %S_0) {
model_lqr_gora_CGInitializeSizes_entry:
  %tmp_ = alloca [4 x i32], align 4
  call void @model_lqr_gora_Checksum([4 x i32]* nonnull %tmp_)
  %0 = getelementptr inbounds [4 x i32], [4 x i32]* %tmp_, i64 0, i64 0
  %tmp__el = load i32, i32* %0, align 4
  call void @vm_ssSetChecksumVal(i8* %S_0, i32 0, i32 %tmp__el)
  %1 = getelementptr inbounds [4 x i32], [4 x i32]* %tmp_, i64 0, i64 1
  %tmp__el3 = load i32, i32* %1, align 4
  call void @vm_ssSetChecksumVal(i8* %S_0, i32 1, i32 %tmp__el3)
  %2 = getelementptr inbounds [4 x i32], [4 x i32]* %tmp_, i64 0, i64 2
  %tmp__el5 = load i32, i32* %2, align 4
  call void @vm_ssSetChecksumVal(i8* %S_0, i32 2, i32 %tmp__el5)
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %tmp_, i64 0, i64 3
  %tmp__el7 = load i32, i32* %3, align 4
  call void @vm_ssSetChecksumVal(i8* %S_0, i32 3, i32 %tmp__el7)
  call void @vm_USizeCheck(i8* %S_0, i32 48)
  call void @vm_blockIOSizeCheck(i8* %S_0, i32 232)
  call void @vm_dworkSizeCheck(i8* %S_0, i32 120)
  call void @vm_paramSizeCheck(i8* %S_0, i32 552)
  ret void
}

define void @model_lqr_gora_Checksum([4 x i32]* %y) {
model_lqr_gora_Checksum_entry:
  %0 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 0
  store i32 861494476, i32* %0, align 1
  %1 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 1
  store i32 -1747571314, i32* %1, align 1
  %2 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 2
  store i32 1124225436, i32* %2, align 1
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 3
  store i32 1009198794, i32* %3, align 1
  ret void
}

declare void @vm_ssSetChecksumVal(i8*, i32 zeroext, i32 zeroext)

declare void @vm_USizeCheck(i8*, i32 zeroext)

declare void @vm_blockIOSizeCheck(i8*, i32 zeroext)

declare void @vm_dworkSizeCheck(i8*, i32 zeroext)

declare void @vm_paramSizeCheck(i8*, i32 zeroext)

define void @Enable(i8* %S) {
Enable_entry:
  %0 = call i8* @vm_ssGetModelRtp(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = call i8* @vm_ssGetU(i8* %S)
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 139)
  %3 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare i8* @vm_ssGetModelRtp(i8*)

declare i8* @vm__ssGetModelBlockIO(i8*)

declare i8* @vm_ssGetU(i8*)

declare void @vm_ssCallAccelRunBlock(i8*, i32 signext, i32 signext, i32 signext)

declare zeroext i8 @vm_getHasError(i8*)

define void @ZeroCrossings(i8* %S) {
ZeroCrossings_entry:
  %0 = call i8* @vm_ssGetRootDWork(i8* %S)
  %1 = call i8* @vm_ssGetSolverZcSignalVector(i8* %S)
  %2 = call i8* @vm_ssGetModelRtp(i8* %S)
  %3 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %4 = getelementptr inbounds i8, i8* %3, i64 48
  %5 = bitcast i8* %4 to double*
  %_rtB__DotProduct = load double, double* %5, align 1
  %6 = getelementptr inbounds i8, i8* %2, i64 368
  %7 = bitcast i8* %6 to double*
  %_rtP__Saturation_UpperSat_i = load double, double* %7, align 1
  %tmp0 = fsub double %_rtB__DotProduct, %_rtP__Saturation_UpperSat_i
  %8 = bitcast i8* %1 to double*
  store double %tmp0, double* %8, align 1
  %_rtB__DotProduct9 = load double, double* %5, align 1
  %9 = getelementptr inbounds i8, i8* %2, i64 376
  %10 = bitcast i8* %9 to double*
  %_rtP__Saturation_LowerSat_g = load double, double* %10, align 1
  %tmp1 = fsub double %_rtB__DotProduct9, %_rtP__Saturation_LowerSat_g
  %11 = getelementptr inbounds i8, i8* %1, i64 8
  %12 = bitcast i8* %11 to double*
  store double %tmp1, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %0, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %13, align 1
  %14 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not = icmp eq i8 %14, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %ZeroCrossings_entry
  %15 = getelementptr inbounds i8, i8* %3, i64 160
  %16 = bitcast i8* %15 to double*
  %_rtB__DotProduct_l = load double, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %2, i64 312
  %18 = bitcast i8* %17 to double*
  %_rtP__Saturation_UpperSat = load double, double* %18, align 1
  %tmp2 = fsub double %_rtB__DotProduct_l, %_rtP__Saturation_UpperSat
  %19 = getelementptr inbounds i8, i8* %1, i64 16
  %20 = bitcast i8* %19 to double*
  store double %tmp2, double* %20, align 1
  %_rtB__DotProduct_l19 = load double, double* %16, align 1
  %21 = getelementptr inbounds i8, i8* %2, i64 320
  %22 = bitcast i8* %21 to double*
  %_rtP__Saturation_LowerSat = load double, double* %22, align 1
  %tmp3 = fsub double %_rtB__DotProduct_l19, %_rtP__Saturation_LowerSat
  %23 = getelementptr inbounds i8, i8* %1, i64 24
  %24 = bitcast i8* %23 to double*
  store double %tmp3, double* %24, align 1
  br label %merge

false:                                            ; preds = %ZeroCrossings_entry
  %25 = getelementptr inbounds i8, i8* %1, i64 16
  %26 = bitcast i8* %25 to double*
  store double 0.000000e+00, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %1, i64 24
  %28 = bitcast i8* %27 to double*
  store double 0.000000e+00, double* %28, align 1
  br label %merge

merge:                                            ; preds = %true, %false
  ret void
}

declare i8* @vm_ssGetRootDWork(i8*)

declare i8* @vm_ssGetSolverZcSignalVector(i8*)

define void @ForcingFunction(i8* %S) {
ForcingFunction_entry:
  %0 = call i8* @vm_ssGetRootDWork(i8* %S)
  %1 = call i8* @vm_ssGetdX(i8* %S)
  %2 = call i8* @vm_ssGetX(i8* %S)
  %3 = call i8* @vm_ssGetModelRtp(i8* %S)
  %4 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %5 = getelementptr inbounds i8, i8* %4, i64 200
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = bitcast i8* %1 to double*
  store double %_rtB__Dx_el, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 208
  %9 = bitcast i8* %8 to double*
  %_rtB__Dx_el23 = load double, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %1, i64 8
  %11 = bitcast i8* %10 to double*
  store double %_rtB__Dx_el23, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 216
  %13 = bitcast i8* %12 to double*
  %_rtB__Dx_el26 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %1, i64 16
  %15 = bitcast i8* %14 to double*
  store double %_rtB__Dx_el26, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 224
  %17 = bitcast i8* %16 to double*
  %_rtB__Dx_el29 = load double, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %1, i64 24
  %19 = bitcast i8* %18 to double*
  store double %_rtB__Dx_el29, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %0, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %20, align 1
  %21 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not = icmp eq i8 %21, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %ForcingFunction_entry
  %22 = getelementptr inbounds i8, i8* %1, i64 32
  %23 = bitcast i8* %22 to double*
  store double 0.000000e+00, double* %23, align 1
  %24 = getelementptr inbounds i8, i8* %1, i64 40
  %25 = bitcast i8* %24 to double*
  store double 0.000000e+00, double* %25, align 1
  %26 = getelementptr inbounds i8, i8* %1, i64 48
  %27 = bitcast i8* %26 to double*
  store double 0.000000e+00, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %1, i64 56
  %29 = bitcast i8* %28 to double*
  store double 0.000000e+00, double* %29, align 1
  %30 = getelementptr inbounds i8, i8* %3, i64 480
  %31 = bitcast i8* %30 to i32*
  %_rtP__IPlinearmodel_A_jc_el = load i32, i32* %31, align 1
  br label %merge

false:                                            ; preds = %ForcingFunction_entry
  %32 = getelementptr inbounds i8, i8* %1, i64 32
  %33 = bitcast i8* %32 to double*
  store double 0.000000e+00, double* %33, align 1
  %34 = getelementptr inbounds i8, i8* %1, i64 40
  %35 = bitcast i8* %34 to double*
  store double 0.000000e+00, double* %35, align 1
  %36 = getelementptr inbounds i8, i8* %1, i64 48
  %37 = bitcast i8* %36 to double*
  store double 0.000000e+00, double* %37, align 1
  %38 = getelementptr inbounds i8, i8* %1, i64 56
  %39 = bitcast i8* %38 to double*
  store double 0.000000e+00, double* %39, align 1
  br label %false10

true1:                                            ; preds = %merge
  %40 = getelementptr inbounds i8, i8* %3, i64 160
  %41 = bitcast i8* %40 to [8 x double]*
  %42 = sext i32 %ri_.0 to i64
  %43 = getelementptr inbounds [8 x double], [8 x double]* %41, i64 0, i64 %42
  %_rtP__IPlinearmodel_A_pr_el118 = load double, double* %43, align 1
  %44 = getelementptr inbounds i8, i8* %2, i64 32
  %45 = bitcast i8* %44 to double*
  %_rtX__IPlinearmodel_CSTATE_el120 = load double, double* %45, align 1
  %tmp12 = fmul double %_rtP__IPlinearmodel_A_pr_el118, %_rtX__IPlinearmodel_CSTATE_el120
  %46 = bitcast i8* %22 to [4 x double]*
  %47 = getelementptr inbounds i8, i8* %3, i64 448
  %48 = bitcast i8* %47 to [8 x i32]*
  %49 = getelementptr inbounds [8 x i32], [8 x i32]* %48, i64 0, i64 %42
  %_rtP__IPlinearmodel_A_ir_el124 = load i32, i32* %49, align 1
  %50 = sext i32 %_rtP__IPlinearmodel_A_ir_el124 to i64
  %51 = getelementptr inbounds [4 x double], [4 x double]* %46, i64 0, i64 %50
  %_rtXdot__IPlinearmodel_CSTATE_el125 = load double, double* %51, align 1
  %tmp13 = fadd double %tmp12, %_rtXdot__IPlinearmodel_CSTATE_el125
  store double %tmp13, double* %51, align 1
  %tmp14 = add i32 %ri_.0, 1
  br label %merge

true3:                                            ; preds = %merge11
  %52 = getelementptr inbounds i8, i8* %3, i64 160
  %53 = bitcast i8* %52 to [8 x double]*
  %54 = sext i32 %ri_.1 to i64
  %55 = getelementptr inbounds [8 x double], [8 x double]* %53, i64 0, i64 %54
  %_rtP__IPlinearmodel_A_pr_el103 = load double, double* %55, align 1
  %56 = getelementptr inbounds i8, i8* %2, i64 40
  %57 = bitcast i8* %56 to double*
  %_rtX__IPlinearmodel_CSTATE_el105 = load double, double* %57, align 1
  %tmp9 = fmul double %_rtP__IPlinearmodel_A_pr_el103, %_rtX__IPlinearmodel_CSTATE_el105
  %58 = bitcast i8* %22 to [4 x double]*
  %59 = getelementptr inbounds i8, i8* %3, i64 448
  %60 = bitcast i8* %59 to [8 x i32]*
  %61 = getelementptr inbounds [8 x i32], [8 x i32]* %60, i64 0, i64 %54
  %_rtP__IPlinearmodel_A_ir_el109 = load i32, i32* %61, align 1
  %62 = sext i32 %_rtP__IPlinearmodel_A_ir_el109 to i64
  %63 = getelementptr inbounds [4 x double], [4 x double]* %58, i64 0, i64 %62
  %_rtXdot__IPlinearmodel_CSTATE_el110 = load double, double* %63, align 1
  %tmp10 = fadd double %tmp9, %_rtXdot__IPlinearmodel_CSTATE_el110
  store double %tmp10, double* %63, align 1
  %tmp11 = add i32 %ri_.1, 1
  br label %merge11

true5:                                            ; preds = %merge12
  %64 = getelementptr inbounds i8, i8* %3, i64 160
  %65 = bitcast i8* %64 to [8 x double]*
  %66 = sext i32 %ri_.2 to i64
  %67 = getelementptr inbounds [8 x double], [8 x double]* %65, i64 0, i64 %66
  %_rtP__IPlinearmodel_A_pr_el88 = load double, double* %67, align 1
  %68 = getelementptr inbounds i8, i8* %2, i64 48
  %69 = bitcast i8* %68 to double*
  %_rtX__IPlinearmodel_CSTATE_el90 = load double, double* %69, align 1
  %tmp6 = fmul double %_rtP__IPlinearmodel_A_pr_el88, %_rtX__IPlinearmodel_CSTATE_el90
  %70 = bitcast i8* %22 to [4 x double]*
  %71 = getelementptr inbounds i8, i8* %3, i64 448
  %72 = bitcast i8* %71 to [8 x i32]*
  %73 = getelementptr inbounds [8 x i32], [8 x i32]* %72, i64 0, i64 %66
  %_rtP__IPlinearmodel_A_ir_el94 = load i32, i32* %73, align 1
  %74 = sext i32 %_rtP__IPlinearmodel_A_ir_el94 to i64
  %75 = getelementptr inbounds [4 x double], [4 x double]* %70, i64 0, i64 %74
  %_rtXdot__IPlinearmodel_CSTATE_el95 = load double, double* %75, align 1
  %tmp7 = fadd double %tmp6, %_rtXdot__IPlinearmodel_CSTATE_el95
  store double %tmp7, double* %75, align 1
  %tmp8 = add i32 %ri_.2, 1
  br label %merge12

true7:                                            ; preds = %merge13
  %76 = getelementptr inbounds i8, i8* %3, i64 160
  %77 = bitcast i8* %76 to [8 x double]*
  %78 = sext i32 %ri_.3 to i64
  %79 = getelementptr inbounds [8 x double], [8 x double]* %77, i64 0, i64 %78
  %_rtP__IPlinearmodel_A_pr_el = load double, double* %79, align 1
  %80 = getelementptr inbounds i8, i8* %2, i64 56
  %81 = bitcast i8* %80 to double*
  %_rtX__IPlinearmodel_CSTATE_el = load double, double* %81, align 1
  %tmp3 = fmul double %_rtP__IPlinearmodel_A_pr_el, %_rtX__IPlinearmodel_CSTATE_el
  %82 = bitcast i8* %22 to [4 x double]*
  %83 = getelementptr inbounds i8, i8* %3, i64 448
  %84 = bitcast i8* %83 to [8 x i32]*
  %85 = getelementptr inbounds [8 x i32], [8 x i32]* %84, i64 0, i64 %78
  %_rtP__IPlinearmodel_A_ir_el = load i32, i32* %85, align 1
  %86 = sext i32 %_rtP__IPlinearmodel_A_ir_el to i64
  %87 = getelementptr inbounds [4 x double], [4 x double]* %82, i64 0, i64 %86
  %_rtXdot__IPlinearmodel_CSTATE_el80 = load double, double* %87, align 1
  %tmp4 = fadd double %tmp3, %_rtXdot__IPlinearmodel_CSTATE_el80
  store double %tmp4, double* %87, align 1
  %tmp5 = add i32 %ri_.3, 1
  br label %merge13

false8:                                           ; preds = %merge13
  %88 = getelementptr inbounds i8, i8* %3, i64 508
  %89 = bitcast i8* %88 to i32*
  %_rtP__IPlinearmodel_B_jc_el = load i32, i32* %89, align 1
  br label %merge14

true9:                                            ; preds = %merge14
  %90 = getelementptr inbounds i8, i8* %3, i64 224
  %91 = bitcast i8* %90 to [2 x double]*
  %92 = sext i32 %ri_.4 to i64
  %93 = getelementptr inbounds [2 x double], [2 x double]* %91, i64 0, i64 %92
  %_rtP__IPlinearmodel_B_pr_el = load double, double* %93, align 1
  %94 = getelementptr inbounds i8, i8* %4, i64 176
  %95 = bitcast i8* %94 to double*
  %_rtB__ctrl_sig_lin = load double, double* %95, align 1
  %tmp0 = fmul double %_rtP__IPlinearmodel_B_pr_el, %_rtB__ctrl_sig_lin
  %96 = bitcast i8* %22 to [4 x double]*
  %97 = getelementptr inbounds i8, i8* %3, i64 500
  %98 = bitcast i8* %97 to [2 x i32]*
  %99 = getelementptr inbounds [2 x i32], [2 x i32]* %98, i64 0, i64 %92
  %_rtP__IPlinearmodel_B_ir_el = load i32, i32* %99, align 1
  %100 = sext i32 %_rtP__IPlinearmodel_B_ir_el to i64
  %101 = getelementptr inbounds [4 x double], [4 x double]* %96, i64 0, i64 %100
  %_rtXdot__IPlinearmodel_CSTATE_el = load double, double* %101, align 1
  %tmp1 = fadd double %tmp0, %_rtXdot__IPlinearmodel_CSTATE_el
  store double %tmp1, double* %101, align 1
  %tmp2 = add i32 %ri_.4, 1
  br label %merge14

false10:                                          ; preds = %merge14, %false
  ret void

merge:                                            ; preds = %true1, %true
  %ri_.0 = phi i32 [ %_rtP__IPlinearmodel_A_jc_el, %true ], [ %tmp14, %true1 ]
  %102 = getelementptr inbounds i8, i8* %3, i64 484
  %103 = bitcast i8* %102 to i32*
  %_rtP__IPlinearmodel_A_jc_el43 = load i32, i32* %103, align 1
  %104 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_A_jc_el43
  br i1 %104, label %true1, label %merge11

merge11:                                          ; preds = %merge, %true3
  %ri_.1 = phi i32 [ %tmp11, %true3 ], [ %_rtP__IPlinearmodel_A_jc_el43, %merge ]
  %105 = getelementptr inbounds i8, i8* %3, i64 488
  %106 = bitcast i8* %105 to i32*
  %_rtP__IPlinearmodel_A_jc_el48 = load i32, i32* %106, align 1
  %107 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_A_jc_el48
  br i1 %107, label %true3, label %merge12

merge12:                                          ; preds = %merge11, %true5
  %ri_.2 = phi i32 [ %tmp8, %true5 ], [ %_rtP__IPlinearmodel_A_jc_el48, %merge11 ]
  %108 = getelementptr inbounds i8, i8* %3, i64 492
  %109 = bitcast i8* %108 to i32*
  %_rtP__IPlinearmodel_A_jc_el53 = load i32, i32* %109, align 1
  %110 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_A_jc_el53
  br i1 %110, label %true5, label %merge13

merge13:                                          ; preds = %merge12, %true7
  %ri_.3 = phi i32 [ %tmp5, %true7 ], [ %_rtP__IPlinearmodel_A_jc_el53, %merge12 ]
  %111 = getelementptr inbounds i8, i8* %3, i64 496
  %112 = bitcast i8* %111 to i32*
  %_rtP__IPlinearmodel_A_jc_el58 = load i32, i32* %112, align 1
  %113 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_A_jc_el58
  br i1 %113, label %true7, label %false8

merge14:                                          ; preds = %true9, %false8
  %ri_.4 = phi i32 [ %_rtP__IPlinearmodel_B_jc_el, %false8 ], [ %tmp2, %true9 ]
  %114 = getelementptr inbounds i8, i8* %3, i64 512
  %115 = bitcast i8* %114 to i32*
  %_rtP__IPlinearmodel_B_jc_el62 = load i32, i32* %115, align 1
  %116 = icmp ult i32 %ri_.4, %_rtP__IPlinearmodel_B_jc_el62
  br i1 %116, label %true9, label %false10
}

declare i8* @vm_ssGetdX(i8*)

declare i8* @vm_ssGetX(i8*)

define void @Derivatives(i8* %S) {
Derivatives_entry:
  %0 = call i8* @vm_ssGetRootDWork(i8* %S)
  %1 = call i8* @vm_ssGetdX(i8* %S)
  %2 = call i8* @vm_ssGetX(i8* %S)
  %3 = call i8* @vm_ssGetModelRtp(i8* %S)
  %4 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %5 = getelementptr inbounds i8, i8* %4, i64 200
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = bitcast i8* %1 to double*
  store double %_rtB__Dx_el, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 208
  %9 = bitcast i8* %8 to double*
  %_rtB__Dx_el23 = load double, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %1, i64 8
  %11 = bitcast i8* %10 to double*
  store double %_rtB__Dx_el23, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 216
  %13 = bitcast i8* %12 to double*
  %_rtB__Dx_el26 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %1, i64 16
  %15 = bitcast i8* %14 to double*
  store double %_rtB__Dx_el26, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 224
  %17 = bitcast i8* %16 to double*
  %_rtB__Dx_el29 = load double, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %1, i64 24
  %19 = bitcast i8* %18 to double*
  store double %_rtB__Dx_el29, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %0, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %20, align 1
  %21 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not = icmp eq i8 %21, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %Derivatives_entry
  %22 = getelementptr inbounds i8, i8* %1, i64 32
  %23 = bitcast i8* %22 to double*
  store double 0.000000e+00, double* %23, align 1
  %24 = getelementptr inbounds i8, i8* %1, i64 40
  %25 = bitcast i8* %24 to double*
  store double 0.000000e+00, double* %25, align 1
  %26 = getelementptr inbounds i8, i8* %1, i64 48
  %27 = bitcast i8* %26 to double*
  store double 0.000000e+00, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %1, i64 56
  %29 = bitcast i8* %28 to double*
  store double 0.000000e+00, double* %29, align 1
  %30 = getelementptr inbounds i8, i8* %3, i64 480
  %31 = bitcast i8* %30 to i32*
  %_rtP__IPlinearmodel_A_jc_el = load i32, i32* %31, align 1
  br label %merge

false:                                            ; preds = %Derivatives_entry
  %32 = getelementptr inbounds i8, i8* %1, i64 32
  %33 = bitcast i8* %32 to double*
  store double 0.000000e+00, double* %33, align 1
  %34 = getelementptr inbounds i8, i8* %1, i64 40
  %35 = bitcast i8* %34 to double*
  store double 0.000000e+00, double* %35, align 1
  %36 = getelementptr inbounds i8, i8* %1, i64 48
  %37 = bitcast i8* %36 to double*
  store double 0.000000e+00, double* %37, align 1
  %38 = getelementptr inbounds i8, i8* %1, i64 56
  %39 = bitcast i8* %38 to double*
  store double 0.000000e+00, double* %39, align 1
  br label %false10

true1:                                            ; preds = %merge
  %40 = getelementptr inbounds i8, i8* %3, i64 160
  %41 = bitcast i8* %40 to [8 x double]*
  %42 = sext i32 %ri_.0 to i64
  %43 = getelementptr inbounds [8 x double], [8 x double]* %41, i64 0, i64 %42
  %_rtP__IPlinearmodel_A_pr_el118 = load double, double* %43, align 1
  %44 = getelementptr inbounds i8, i8* %2, i64 32
  %45 = bitcast i8* %44 to double*
  %_rtX__IPlinearmodel_CSTATE_el120 = load double, double* %45, align 1
  %tmp12 = fmul double %_rtP__IPlinearmodel_A_pr_el118, %_rtX__IPlinearmodel_CSTATE_el120
  %46 = bitcast i8* %22 to [4 x double]*
  %47 = getelementptr inbounds i8, i8* %3, i64 448
  %48 = bitcast i8* %47 to [8 x i32]*
  %49 = getelementptr inbounds [8 x i32], [8 x i32]* %48, i64 0, i64 %42
  %_rtP__IPlinearmodel_A_ir_el124 = load i32, i32* %49, align 1
  %50 = sext i32 %_rtP__IPlinearmodel_A_ir_el124 to i64
  %51 = getelementptr inbounds [4 x double], [4 x double]* %46, i64 0, i64 %50
  %_rtXdot__IPlinearmodel_CSTATE_el125 = load double, double* %51, align 1
  %tmp13 = fadd double %tmp12, %_rtXdot__IPlinearmodel_CSTATE_el125
  store double %tmp13, double* %51, align 1
  %tmp14 = add i32 %ri_.0, 1
  br label %merge

true3:                                            ; preds = %merge11
  %52 = getelementptr inbounds i8, i8* %3, i64 160
  %53 = bitcast i8* %52 to [8 x double]*
  %54 = sext i32 %ri_.1 to i64
  %55 = getelementptr inbounds [8 x double], [8 x double]* %53, i64 0, i64 %54
  %_rtP__IPlinearmodel_A_pr_el103 = load double, double* %55, align 1
  %56 = getelementptr inbounds i8, i8* %2, i64 40
  %57 = bitcast i8* %56 to double*
  %_rtX__IPlinearmodel_CSTATE_el105 = load double, double* %57, align 1
  %tmp9 = fmul double %_rtP__IPlinearmodel_A_pr_el103, %_rtX__IPlinearmodel_CSTATE_el105
  %58 = bitcast i8* %22 to [4 x double]*
  %59 = getelementptr inbounds i8, i8* %3, i64 448
  %60 = bitcast i8* %59 to [8 x i32]*
  %61 = getelementptr inbounds [8 x i32], [8 x i32]* %60, i64 0, i64 %54
  %_rtP__IPlinearmodel_A_ir_el109 = load i32, i32* %61, align 1
  %62 = sext i32 %_rtP__IPlinearmodel_A_ir_el109 to i64
  %63 = getelementptr inbounds [4 x double], [4 x double]* %58, i64 0, i64 %62
  %_rtXdot__IPlinearmodel_CSTATE_el110 = load double, double* %63, align 1
  %tmp10 = fadd double %tmp9, %_rtXdot__IPlinearmodel_CSTATE_el110
  store double %tmp10, double* %63, align 1
  %tmp11 = add i32 %ri_.1, 1
  br label %merge11

true5:                                            ; preds = %merge12
  %64 = getelementptr inbounds i8, i8* %3, i64 160
  %65 = bitcast i8* %64 to [8 x double]*
  %66 = sext i32 %ri_.2 to i64
  %67 = getelementptr inbounds [8 x double], [8 x double]* %65, i64 0, i64 %66
  %_rtP__IPlinearmodel_A_pr_el88 = load double, double* %67, align 1
  %68 = getelementptr inbounds i8, i8* %2, i64 48
  %69 = bitcast i8* %68 to double*
  %_rtX__IPlinearmodel_CSTATE_el90 = load double, double* %69, align 1
  %tmp6 = fmul double %_rtP__IPlinearmodel_A_pr_el88, %_rtX__IPlinearmodel_CSTATE_el90
  %70 = bitcast i8* %22 to [4 x double]*
  %71 = getelementptr inbounds i8, i8* %3, i64 448
  %72 = bitcast i8* %71 to [8 x i32]*
  %73 = getelementptr inbounds [8 x i32], [8 x i32]* %72, i64 0, i64 %66
  %_rtP__IPlinearmodel_A_ir_el94 = load i32, i32* %73, align 1
  %74 = sext i32 %_rtP__IPlinearmodel_A_ir_el94 to i64
  %75 = getelementptr inbounds [4 x double], [4 x double]* %70, i64 0, i64 %74
  %_rtXdot__IPlinearmodel_CSTATE_el95 = load double, double* %75, align 1
  %tmp7 = fadd double %tmp6, %_rtXdot__IPlinearmodel_CSTATE_el95
  store double %tmp7, double* %75, align 1
  %tmp8 = add i32 %ri_.2, 1
  br label %merge12

true7:                                            ; preds = %merge13
  %76 = getelementptr inbounds i8, i8* %3, i64 160
  %77 = bitcast i8* %76 to [8 x double]*
  %78 = sext i32 %ri_.3 to i64
  %79 = getelementptr inbounds [8 x double], [8 x double]* %77, i64 0, i64 %78
  %_rtP__IPlinearmodel_A_pr_el = load double, double* %79, align 1
  %80 = getelementptr inbounds i8, i8* %2, i64 56
  %81 = bitcast i8* %80 to double*
  %_rtX__IPlinearmodel_CSTATE_el = load double, double* %81, align 1
  %tmp3 = fmul double %_rtP__IPlinearmodel_A_pr_el, %_rtX__IPlinearmodel_CSTATE_el
  %82 = bitcast i8* %22 to [4 x double]*
  %83 = getelementptr inbounds i8, i8* %3, i64 448
  %84 = bitcast i8* %83 to [8 x i32]*
  %85 = getelementptr inbounds [8 x i32], [8 x i32]* %84, i64 0, i64 %78
  %_rtP__IPlinearmodel_A_ir_el = load i32, i32* %85, align 1
  %86 = sext i32 %_rtP__IPlinearmodel_A_ir_el to i64
  %87 = getelementptr inbounds [4 x double], [4 x double]* %82, i64 0, i64 %86
  %_rtXdot__IPlinearmodel_CSTATE_el80 = load double, double* %87, align 1
  %tmp4 = fadd double %tmp3, %_rtXdot__IPlinearmodel_CSTATE_el80
  store double %tmp4, double* %87, align 1
  %tmp5 = add i32 %ri_.3, 1
  br label %merge13

false8:                                           ; preds = %merge13
  %88 = getelementptr inbounds i8, i8* %3, i64 508
  %89 = bitcast i8* %88 to i32*
  %_rtP__IPlinearmodel_B_jc_el = load i32, i32* %89, align 1
  br label %merge14

true9:                                            ; preds = %merge14
  %90 = getelementptr inbounds i8, i8* %3, i64 224
  %91 = bitcast i8* %90 to [2 x double]*
  %92 = sext i32 %ri_.4 to i64
  %93 = getelementptr inbounds [2 x double], [2 x double]* %91, i64 0, i64 %92
  %_rtP__IPlinearmodel_B_pr_el = load double, double* %93, align 1
  %94 = getelementptr inbounds i8, i8* %4, i64 176
  %95 = bitcast i8* %94 to double*
  %_rtB__ctrl_sig_lin = load double, double* %95, align 1
  %tmp0 = fmul double %_rtP__IPlinearmodel_B_pr_el, %_rtB__ctrl_sig_lin
  %96 = bitcast i8* %22 to [4 x double]*
  %97 = getelementptr inbounds i8, i8* %3, i64 500
  %98 = bitcast i8* %97 to [2 x i32]*
  %99 = getelementptr inbounds [2 x i32], [2 x i32]* %98, i64 0, i64 %92
  %_rtP__IPlinearmodel_B_ir_el = load i32, i32* %99, align 1
  %100 = sext i32 %_rtP__IPlinearmodel_B_ir_el to i64
  %101 = getelementptr inbounds [4 x double], [4 x double]* %96, i64 0, i64 %100
  %_rtXdot__IPlinearmodel_CSTATE_el = load double, double* %101, align 1
  %tmp1 = fadd double %tmp0, %_rtXdot__IPlinearmodel_CSTATE_el
  store double %tmp1, double* %101, align 1
  %tmp2 = add i32 %ri_.4, 1
  br label %merge14

false10:                                          ; preds = %merge14, %false
  ret void

merge:                                            ; preds = %true1, %true
  %ri_.0 = phi i32 [ %_rtP__IPlinearmodel_A_jc_el, %true ], [ %tmp14, %true1 ]
  %102 = getelementptr inbounds i8, i8* %3, i64 484
  %103 = bitcast i8* %102 to i32*
  %_rtP__IPlinearmodel_A_jc_el43 = load i32, i32* %103, align 1
  %104 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_A_jc_el43
  br i1 %104, label %true1, label %merge11

merge11:                                          ; preds = %merge, %true3
  %ri_.1 = phi i32 [ %tmp11, %true3 ], [ %_rtP__IPlinearmodel_A_jc_el43, %merge ]
  %105 = getelementptr inbounds i8, i8* %3, i64 488
  %106 = bitcast i8* %105 to i32*
  %_rtP__IPlinearmodel_A_jc_el48 = load i32, i32* %106, align 1
  %107 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_A_jc_el48
  br i1 %107, label %true3, label %merge12

merge12:                                          ; preds = %merge11, %true5
  %ri_.2 = phi i32 [ %tmp8, %true5 ], [ %_rtP__IPlinearmodel_A_jc_el48, %merge11 ]
  %108 = getelementptr inbounds i8, i8* %3, i64 492
  %109 = bitcast i8* %108 to i32*
  %_rtP__IPlinearmodel_A_jc_el53 = load i32, i32* %109, align 1
  %110 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_A_jc_el53
  br i1 %110, label %true5, label %merge13

merge13:                                          ; preds = %merge12, %true7
  %ri_.3 = phi i32 [ %tmp5, %true7 ], [ %_rtP__IPlinearmodel_A_jc_el53, %merge12 ]
  %111 = getelementptr inbounds i8, i8* %3, i64 496
  %112 = bitcast i8* %111 to i32*
  %_rtP__IPlinearmodel_A_jc_el58 = load i32, i32* %112, align 1
  %113 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_A_jc_el58
  br i1 %113, label %true7, label %false8

merge14:                                          ; preds = %true9, %false8
  %ri_.4 = phi i32 [ %_rtP__IPlinearmodel_B_jc_el, %false8 ], [ %tmp2, %true9 ]
  %114 = getelementptr inbounds i8, i8* %3, i64 512
  %115 = bitcast i8* %114 to i32*
  %_rtP__IPlinearmodel_B_jc_el62 = load i32, i32* %115, align 1
  %116 = icmp ult i32 %ri_.4, %_rtP__IPlinearmodel_B_jc_el62
  br i1 %116, label %true9, label %false10
}

define void @Update0(i8* %S) {
Update0_entry:
  %0 = call i8* @vm_ssGetRootDWork(i8* %S)
  %1 = getelementptr inbounds i8, i8* %0, i64 104
  %2 = bitcast i8* %1 to i32*
  store i32 0, i32* %2, align 1
  ret void
}

define void @Outputs1(i8* %S, i32 signext %controlPortIdx) {
Outputs1_entry:
  %0 = call i8* @vm_ssGetModelRtp(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %0, i64 384
  %3 = bitcast i8* %2 to double*
  %_rtP__Constant_Value_el = load double, double* %3, align 1
  %4 = getelementptr inbounds i8, i8* %1, i64 64
  %5 = bitcast i8* %4 to double*
  store double %_rtP__Constant_Value_el, double* %5, align 1
  %6 = getelementptr inbounds i8, i8* %0, i64 392
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el6 = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %1, i64 72
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el6, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %0, i64 400
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el9 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %1, i64 80
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el9, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %0, i64 408
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el12 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %1, i64 88
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el12, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %0, i64 416
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant1_Value_el = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %1, i64 96
  %21 = bitcast i8* %20 to double*
  store double %_rtP__Constant1_Value_el, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %0, i64 424
  %23 = bitcast i8* %22 to double*
  %_rtP__Constant1_Value_el17 = load double, double* %23, align 1
  %24 = getelementptr inbounds i8, i8* %1, i64 104
  %25 = bitcast i8* %24 to double*
  store double %_rtP__Constant1_Value_el17, double* %25, align 1
  %26 = getelementptr inbounds i8, i8* %0, i64 432
  %27 = bitcast i8* %26 to double*
  %_rtP__Constant1_Value_el20 = load double, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %1, i64 112
  %29 = bitcast i8* %28 to double*
  store double %_rtP__Constant1_Value_el20, double* %29, align 1
  %30 = getelementptr inbounds i8, i8* %0, i64 440
  %31 = bitcast i8* %30 to double*
  %_rtP__Constant2_Value = load double, double* %31, align 1
  %32 = getelementptr inbounds i8, i8* %1, i64 120
  %33 = bitcast i8* %32 to double*
  store double %_rtP__Constant2_Value, double* %33, align 1
  ret void
}

define void @Outputs0(i8* %S) {
Outputs0_entry:
  %0 = call double @vm_ssGetTStart(i8* %S)
  %1 = call double @vm_ssGetTaskTime(i8* %S, i32 1)
  %2 = call i32 @vm_ssIsSampleHit(i8* %S, i32 1, i32 0)
  %3 = call i8* @vm_ssGetRootDWork(i8* %S)
  %4 = call i8* @vm_ssGetContStateDisabled(i8* %S)
  %5 = call i8* @vm_ssGetX(i8* %S)
  %6 = call i8* @vm_ssGetModelRtp(i8* %S)
  %7 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %8 = call i8* @vm_ssGetU(i8* %S)
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 0, i32 104)
  %9 = call i8 @vm_getHasError(i8* %S)
  %10 = and i8 %9, 1
  %.not = icmp eq i8 %10, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %false59, %false70, %false69, %false68, %false67, %false66, %false65, %false64, %false63, %false62, %false61, %false60, %true58, %false56, %false55, %false54, %false53, %false52, %false32, %merge74, %false7, %false6, %false5, %merge, %Outputs0_entry
  ret void

false:                                            ; preds = %Outputs0_entry
  %11 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %12 = and i8 %11, 1
  %.not408 = icmp eq i8 %12, 0
  br i1 %.not408, label %false2, label %true1

true1:                                            ; preds = %false
  %13 = getelementptr inbounds i8, i8* %3, i64 104
  %14 = bitcast i8* %13 to i32*
  %_rtDW__Integrator_IWORK = load i32, i32* %14, align 1
  %.not442 = icmp eq i32 %_rtDW__Integrator_IWORK, 0
  br i1 %.not442, label %true1.false4_crit_edge, label %true3

true1.false4_crit_edge:                           ; preds = %true1
  %.phi.trans.insert = bitcast i8* %5 to double*
  %_rtX__Integrator_CSTATE_el119.pre = load double, double* %.phi.trans.insert, align 1
  br label %false4

false2:                                           ; preds = %false
  %15 = bitcast i8* %5 to double*
  %_rtX__Integrator_CSTATE_el = load double, double* %15, align 1
  %16 = bitcast i8* %7 to double*
  store double %_rtX__Integrator_CSTATE_el, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %5, i64 8
  %18 = bitcast i8* %17 to double*
  %_rtX__Integrator_CSTATE_el98 = load double, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %7, i64 8
  %20 = bitcast i8* %19 to double*
  store double %_rtX__Integrator_CSTATE_el98, double* %20, align 1
  %21 = getelementptr inbounds i8, i8* %5, i64 16
  %22 = bitcast i8* %21 to double*
  %_rtX__Integrator_CSTATE_el101 = load double, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %7, i64 16
  %24 = bitcast i8* %23 to double*
  store double %_rtX__Integrator_CSTATE_el101, double* %24, align 1
  %25 = getelementptr inbounds i8, i8* %5, i64 24
  %26 = bitcast i8* %25 to double*
  %_rtX__Integrator_CSTATE_el104 = load double, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %7, i64 24
  %28 = bitcast i8* %27 to double*
  store double %_rtX__Integrator_CSTATE_el104, double* %28, align 1
  br label %merge

true3:                                            ; preds = %true1
  %29 = getelementptr inbounds i8, i8* %7, i64 64
  %30 = bitcast i8* %29 to double*
  %_rtB__Constant_el = load double, double* %30, align 1
  %31 = bitcast i8* %5 to double*
  store double %_rtB__Constant_el, double* %31, align 1
  %32 = getelementptr inbounds i8, i8* %7, i64 72
  %33 = bitcast i8* %32 to double*
  %_rtB__Constant_el110 = load double, double* %33, align 1
  %34 = getelementptr inbounds i8, i8* %5, i64 8
  %35 = bitcast i8* %34 to double*
  store double %_rtB__Constant_el110, double* %35, align 1
  %36 = getelementptr inbounds i8, i8* %7, i64 80
  %37 = bitcast i8* %36 to double*
  %_rtB__Constant_el113 = load double, double* %37, align 1
  %38 = getelementptr inbounds i8, i8* %5, i64 16
  %39 = bitcast i8* %38 to double*
  store double %_rtB__Constant_el113, double* %39, align 1
  %40 = getelementptr inbounds i8, i8* %7, i64 88
  %41 = bitcast i8* %40 to double*
  %_rtB__Constant_el116 = load double, double* %41, align 1
  %42 = getelementptr inbounds i8, i8* %5, i64 24
  %43 = bitcast i8* %42 to double*
  store double %_rtB__Constant_el116, double* %43, align 1
  br label %false4

false4:                                           ; preds = %true1.false4_crit_edge, %true3
  %.pre-phi = phi double* [ %.phi.trans.insert, %true1.false4_crit_edge ], [ %31, %true3 ]
  %_rtX__Integrator_CSTATE_el119 = phi double [ %_rtX__Integrator_CSTATE_el119.pre, %true1.false4_crit_edge ], [ %_rtB__Constant_el, %true3 ]
  %44 = bitcast i8* %7 to double*
  store double %_rtX__Integrator_CSTATE_el119, double* %44, align 1
  %45 = getelementptr inbounds i8, i8* %5, i64 8
  %46 = bitcast i8* %45 to double*
  %_rtX__Integrator_CSTATE_el122 = load double, double* %46, align 1
  %47 = getelementptr inbounds i8, i8* %7, i64 8
  %48 = bitcast i8* %47 to double*
  store double %_rtX__Integrator_CSTATE_el122, double* %48, align 1
  %49 = getelementptr inbounds i8, i8* %5, i64 16
  %50 = bitcast i8* %49 to double*
  %_rtX__Integrator_CSTATE_el125 = load double, double* %50, align 1
  %51 = getelementptr inbounds i8, i8* %7, i64 16
  %52 = bitcast i8* %51 to double*
  store double %_rtX__Integrator_CSTATE_el125, double* %52, align 1
  %53 = getelementptr inbounds i8, i8* %5, i64 24
  %54 = bitcast i8* %53 to double*
  %_rtX__Integrator_CSTATE_el128 = load double, double* %54, align 1
  %55 = getelementptr inbounds i8, i8* %7, i64 24
  %56 = bitcast i8* %55 to double*
  store double %_rtX__Integrator_CSTATE_el128, double* %56, align 1
  br label %merge

false5:                                           ; preds = %merge
  %57 = getelementptr inbounds i8, i8* %6, i64 344
  %58 = bitcast i8* %57 to double*
  %_rtP__Gain1_Gain_l = load double, double* %58, align 1
  %59 = getelementptr inbounds i8, i8* %7, i64 8
  %60 = bitcast i8* %59 to double*
  %_rtB__state_el = load double, double* %60, align 1
  %tmp0 = fmul double %_rtP__Gain1_Gain_l, %_rtB__state_el
  %61 = getelementptr inbounds i8, i8* %7, i64 32
  %62 = bitcast i8* %61 to double*
  store double %tmp0, double* %62, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 4, i32 104)
  %63 = call i8 @vm_getHasError(i8* %S)
  %64 = and i8 %63, 1
  %.not410 = icmp eq i8 %64, 0
  br i1 %.not410, label %false6, label %true

false6:                                           ; preds = %false5
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 5, i32 104)
  %65 = call i8 @vm_getHasError(i8* %S)
  %66 = and i8 %65, 1
  %.not411 = icmp eq i8 %66, 0
  br i1 %.not411, label %false7, label %true

false7:                                           ; preds = %false6
  %67 = getelementptr inbounds i8, i8* %6, i64 352
  %68 = bitcast i8* %67 to double*
  %_rtP__Gain2_Gain_m = load double, double* %68, align 1
  %69 = getelementptr inbounds i8, i8* %7, i64 24
  %70 = bitcast i8* %69 to double*
  %_rtB__state_el141 = load double, double* %70, align 1
  %tmp1 = fmul double %_rtP__Gain2_Gain_m, %_rtB__state_el141
  %71 = getelementptr inbounds i8, i8* %7, i64 40
  %72 = bitcast i8* %71 to double*
  store double %tmp1, double* %72, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 7, i32 104)
  %73 = call i8 @vm_getHasError(i8* %S)
  %74 = and i8 %73, 1
  %.not412 = icmp eq i8 %74, 0
  br i1 %.not412, label %false8, label %true

false8:                                           ; preds = %false7
  %75 = bitcast i8* %7 to double*
  %_rtB__state_el146 = load double, double* %75, align 1
  %76 = bitcast i8* %8 to double*
  %_rtU__xw_ref = load double, double* %76, align 1
  %tmp2 = fsub double %_rtB__state_el146, %_rtU__xw_ref
  %77 = getelementptr inbounds i8, i8* %6, i64 360
  %78 = bitcast i8* %77 to double*
  %_rtP__Gain_Gain_n = load double, double* %78, align 1
  %79 = getelementptr inbounds i8, i8* %8, i64 16
  %80 = bitcast i8* %79 to double*
  %_rtU__k_xw = load double, double* %80, align 1
  %tmp3 = fmul double %_rtP__Gain_Gain_n, %_rtU__k_xw
  %tmp4 = fmul double %tmp2, %tmp3
  %_rtB__state_el151 = load double, double* %60, align 1
  %81 = getelementptr inbounds i8, i8* %7, i64 96
  %82 = bitcast i8* %81 to double*
  %_rtB__Constant1_el = load double, double* %82, align 1
  %tmp5 = fsub double %_rtB__state_el151, %_rtB__Constant1_el
  %83 = getelementptr inbounds i8, i8* %8, i64 24
  %84 = bitcast i8* %83 to double*
  %_rtU__k_the = load double, double* %84, align 1
  %tmp6 = fmul double %_rtP__Gain_Gain_n, %_rtU__k_the
  %tmp7 = fmul double %tmp5, %tmp6
  %tmp8 = fadd double %tmp4, %tmp7
  %85 = getelementptr inbounds i8, i8* %7, i64 16
  %86 = bitcast i8* %85 to double*
  %_rtB__state_el157 = load double, double* %86, align 1
  %87 = getelementptr inbounds i8, i8* %7, i64 104
  %88 = bitcast i8* %87 to double*
  %_rtB__Constant1_el159 = load double, double* %88, align 1
  %tmp9 = fsub double %_rtB__state_el157, %_rtB__Constant1_el159
  %89 = getelementptr inbounds i8, i8* %8, i64 32
  %90 = bitcast i8* %89 to double*
  %_rtU__k_Dxw = load double, double* %90, align 1
  %tmp10 = fmul double %_rtP__Gain_Gain_n, %_rtU__k_Dxw
  %tmp11 = fmul double %tmp9, %tmp10
  %tmp12 = fadd double %tmp8, %tmp11
  %_rtB__state_el164 = load double, double* %70, align 1
  %91 = getelementptr inbounds i8, i8* %7, i64 112
  %92 = bitcast i8* %91 to double*
  %_rtB__Constant1_el166 = load double, double* %92, align 1
  %tmp13 = fsub double %_rtB__state_el164, %_rtB__Constant1_el166
  %93 = getelementptr inbounds i8, i8* %8, i64 40
  %94 = bitcast i8* %93 to double*
  %_rtU__k_Dthe = load double, double* %94, align 1
  %tmp14 = fmul double %_rtP__Gain_Gain_n, %_rtU__k_Dthe
  %tmp15 = fmul double %tmp13, %tmp14
  %tmp16 = fadd double %tmp12, %tmp15
  %95 = getelementptr inbounds i8, i8* %7, i64 48
  %96 = bitcast i8* %95 to double*
  store double %tmp16, double* %96, align 1
  %97 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %98 = and i8 %97, 1
  %.not413 = icmp eq i8 %98, 0
  br i1 %.not413, label %false8.false10_crit_edge, label %true9

false8.false10_crit_edge:                         ; preds = %false8
  %.phi.trans.insert444 = getelementptr inbounds i8, i8* %3, i64 108
  %.phi.trans.insert445 = bitcast i8* %.phi.trans.insert444 to i32*
  %_rtDW__Saturation_MODE.pre = load i32, i32* %.phi.trans.insert445, align 1
  br label %false10

true9:                                            ; preds = %false8
  %_rtB__DotProduct = load double, double* %96, align 1
  %99 = getelementptr inbounds i8, i8* %6, i64 368
  %100 = bitcast i8* %99 to double*
  %_rtP__Saturation_UpperSat_i = load double, double* %100, align 1
  %101 = fcmp ult double %_rtB__DotProduct, %_rtP__Saturation_UpperSat_i
  br i1 %101, label %false12, label %true11

false10:                                          ; preds = %true11, %true13, %false14, %false8.false10_crit_edge
  %_rtDW__Saturation_MODE182 = phi i32 [ %_rtDW__Saturation_MODE.pre, %false8.false10_crit_edge ], [ 1, %true11 ], [ 0, %true13 ], [ -1, %false14 ]
  %102 = getelementptr inbounds i8, i8* %3, i64 108
  %103 = bitcast i8* %102 to i32*
  switch i32 %_rtDW__Saturation_MODE182, label %false18 [
    i32 1, label %true15
    i32 -1, label %true17
  ]

true11:                                           ; preds = %true9
  %104 = getelementptr inbounds i8, i8* %3, i64 108
  %105 = bitcast i8* %104 to i32*
  store i32 1, i32* %105, align 1
  br label %false10

false12:                                          ; preds = %true9
  %106 = getelementptr inbounds i8, i8* %6, i64 376
  %107 = bitcast i8* %106 to double*
  %_rtP__Saturation_LowerSat_g = load double, double* %107, align 1
  %108 = fcmp ogt double %_rtB__DotProduct, %_rtP__Saturation_LowerSat_g
  br i1 %108, label %true13, label %false14

true13:                                           ; preds = %false12
  %109 = getelementptr inbounds i8, i8* %3, i64 108
  %110 = bitcast i8* %109 to i32*
  store i32 0, i32* %110, align 1
  br label %false10

false14:                                          ; preds = %false12
  %111 = getelementptr inbounds i8, i8* %3, i64 108
  %112 = bitcast i8* %111 to i32*
  store i32 -1, i32* %112, align 1
  br label %false10

true15:                                           ; preds = %false10
  %113 = getelementptr inbounds i8, i8* %6, i64 368
  %114 = bitcast i8* %113 to double*
  %_rtP__Saturation_UpperSat_i190 = load double, double* %114, align 1
  %115 = getelementptr inbounds i8, i8* %7, i64 56
  %116 = bitcast i8* %115 to double*
  store double %_rtP__Saturation_UpperSat_i190, double* %116, align 1
  br label %merge74

true17:                                           ; preds = %false10
  %117 = getelementptr inbounds i8, i8* %6, i64 376
  %118 = bitcast i8* %117 to double*
  %_rtP__Saturation_LowerSat_g187 = load double, double* %118, align 1
  %119 = getelementptr inbounds i8, i8* %7, i64 56
  %120 = bitcast i8* %119 to double*
  store double %_rtP__Saturation_LowerSat_g187, double* %120, align 1
  br label %merge74

false18:                                          ; preds = %false10
  %_rtB__DotProduct184 = load double, double* %96, align 1
  %121 = getelementptr inbounds i8, i8* %7, i64 56
  %122 = bitcast i8* %121 to double*
  store double %_rtB__DotProduct184, double* %122, align 1
  br label %merge74

false19:                                          ; preds = %merge74
  %.not415 = icmp eq i32 %2, 0
  br i1 %.not415, label %false21, label %true20

true20:                                           ; preds = %false19
  %123 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %124 = and i8 %123, 1
  %.not439 = icmp eq i8 %124, 0
  br i1 %.not439, label %false21, label %true22

false21:                                          ; preds = %false30, %true23, %true27, %false26, %true20, %false19
  %125 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE222 = load i8, i8* %125, align 1
  %126 = and i8 %_rtDW__Subsystem_MODE222, 1
  %.not416 = icmp eq i8 %126, 0
  br i1 %.not416, label %false32, label %true31

true22:                                           ; preds = %true20
  %127 = getelementptr inbounds i8, i8* %7, i64 120
  %128 = bitcast i8* %127 to double*
  %_rtB__Constant2 = load double, double* %128, align 1
  %129 = fcmp ogt double %_rtB__Constant2, 0.000000e+00
  br i1 %129, label %true23, label %false24

true23:                                           ; preds = %true22
  %130 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE212 = load i8, i8* %130, align 1
  %131 = and i8 %_rtDW__Subsystem_MODE212, 1
  %.not441 = icmp eq i8 %131, 0
  br i1 %.not441, label %true28, label %false21

false24:                                          ; preds = %true22
  %132 = fcmp oeq double %1, %0
  br i1 %132, label %true25, label %false26

true25:                                           ; preds = %false24
  %133 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 1, i8* %133, align 1
  %134 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 1, i8* %134, align 1
  %135 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 1, i8* %135, align 1
  %136 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 1, i8* %136, align 1
  br label %false26

false26:                                          ; preds = %true25, %false24
  %137 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %137, align 1
  %138 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not440 = icmp eq i8 %138, 0
  br i1 %.not440, label %false21, label %true27

true27:                                           ; preds = %false26
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8* %S)
  %139 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 1, i8* %139, align 1
  %140 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 1, i8* %140, align 1
  %141 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 1, i8* %141, align 1
  %142 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 1, i8* %142, align 1
  store i8 0, i8* %137, align 1
  br label %false21

true28:                                           ; preds = %true23
  %143 = fcmp une double %1, %0
  br i1 %143, label %true29, label %false30

true29:                                           ; preds = %true28
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8* %S)
  br label %false30

false30:                                          ; preds = %true29, %true28
  %144 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 0, i8* %144, align 1
  %145 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 0, i8* %145, align 1
  %146 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 0, i8* %146, align 1
  %147 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 0, i8* %147, align 1
  store i8 1, i8* %130, align 1
  br label %false21

true31:                                           ; preds = %false21
  %148 = getelementptr inbounds i8, i8* %7, i64 128
  %149 = bitcast i8* %148 to double*
  store double 0.000000e+00, double* %149, align 1
  %150 = getelementptr inbounds i8, i8* %7, i64 136
  %151 = bitcast i8* %150 to double*
  store double 0.000000e+00, double* %151, align 1
  %152 = getelementptr inbounds i8, i8* %7, i64 144
  %153 = bitcast i8* %152 to double*
  store double 0.000000e+00, double* %153, align 1
  %154 = getelementptr inbounds i8, i8* %7, i64 152
  %155 = bitcast i8* %154 to double*
  store double 0.000000e+00, double* %155, align 1
  %156 = getelementptr inbounds i8, i8* %6, i64 532
  %157 = bitcast i8* %156 to i32*
  %_rtP__IPlinearmodel_C_jc_el = load i32, i32* %157, align 1
  br label %merge75

false32:                                          ; preds = %true51, %merge82, %false21
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 14, i32 104)
  %158 = call i8 @vm_getHasError(i8* %S)
  %159 = and i8 %158, 1
  %.not417 = icmp eq i8 %159, 0
  br i1 %.not417, label %false52, label %true

true33:                                           ; preds = %merge75
  %160 = getelementptr inbounds i8, i8* %6, i64 240
  %161 = bitcast i8* %160 to [4 x double]*
  %162 = sext i32 %ri_.0 to i64
  %163 = getelementptr inbounds [4 x double], [4 x double]* %161, i64 0, i64 %162
  %_rtP__IPlinearmodel_C_pr_el395 = load double, double* %163, align 1
  %164 = getelementptr inbounds i8, i8* %5, i64 32
  %165 = bitcast i8* %164 to double*
  %_rtX__IPlinearmodel_CSTATE_el397 = load double, double* %165, align 1
  %tmp43 = fmul double %_rtP__IPlinearmodel_C_pr_el395, %_rtX__IPlinearmodel_CSTATE_el397
  %166 = bitcast i8* %148 to [4 x double]*
  %167 = getelementptr inbounds i8, i8* %6, i64 516
  %168 = bitcast i8* %167 to [4 x i32]*
  %169 = getelementptr inbounds [4 x i32], [4 x i32]* %168, i64 0, i64 %162
  %_rtP__IPlinearmodel_C_ir_el401 = load i32, i32* %169, align 1
  %170 = sext i32 %_rtP__IPlinearmodel_C_ir_el401 to i64
  %171 = getelementptr inbounds [4 x double], [4 x double]* %166, i64 0, i64 %170
  %_rtB__IPlinearmodel_el402 = load double, double* %171, align 1
  %tmp44 = fadd double %tmp43, %_rtB__IPlinearmodel_el402
  store double %tmp44, double* %171, align 1
  %tmp45 = add i32 %ri_.0, 1
  br label %merge75

true35:                                           ; preds = %merge76
  %172 = getelementptr inbounds i8, i8* %6, i64 240
  %173 = bitcast i8* %172 to [4 x double]*
  %174 = sext i32 %ri_.1 to i64
  %175 = getelementptr inbounds [4 x double], [4 x double]* %173, i64 0, i64 %174
  %_rtP__IPlinearmodel_C_pr_el380 = load double, double* %175, align 1
  %176 = getelementptr inbounds i8, i8* %5, i64 40
  %177 = bitcast i8* %176 to double*
  %_rtX__IPlinearmodel_CSTATE_el382 = load double, double* %177, align 1
  %tmp40 = fmul double %_rtP__IPlinearmodel_C_pr_el380, %_rtX__IPlinearmodel_CSTATE_el382
  %178 = bitcast i8* %148 to [4 x double]*
  %179 = getelementptr inbounds i8, i8* %6, i64 516
  %180 = bitcast i8* %179 to [4 x i32]*
  %181 = getelementptr inbounds [4 x i32], [4 x i32]* %180, i64 0, i64 %174
  %_rtP__IPlinearmodel_C_ir_el386 = load i32, i32* %181, align 1
  %182 = sext i32 %_rtP__IPlinearmodel_C_ir_el386 to i64
  %183 = getelementptr inbounds [4 x double], [4 x double]* %178, i64 0, i64 %182
  %_rtB__IPlinearmodel_el387 = load double, double* %183, align 1
  %tmp41 = fadd double %tmp40, %_rtB__IPlinearmodel_el387
  store double %tmp41, double* %183, align 1
  %tmp42 = add i32 %ri_.1, 1
  br label %merge76

true37:                                           ; preds = %merge77
  %184 = getelementptr inbounds i8, i8* %6, i64 240
  %185 = bitcast i8* %184 to [4 x double]*
  %186 = sext i32 %ri_.2 to i64
  %187 = getelementptr inbounds [4 x double], [4 x double]* %185, i64 0, i64 %186
  %_rtP__IPlinearmodel_C_pr_el365 = load double, double* %187, align 1
  %188 = getelementptr inbounds i8, i8* %5, i64 48
  %189 = bitcast i8* %188 to double*
  %_rtX__IPlinearmodel_CSTATE_el367 = load double, double* %189, align 1
  %tmp37 = fmul double %_rtP__IPlinearmodel_C_pr_el365, %_rtX__IPlinearmodel_CSTATE_el367
  %190 = bitcast i8* %148 to [4 x double]*
  %191 = getelementptr inbounds i8, i8* %6, i64 516
  %192 = bitcast i8* %191 to [4 x i32]*
  %193 = getelementptr inbounds [4 x i32], [4 x i32]* %192, i64 0, i64 %186
  %_rtP__IPlinearmodel_C_ir_el371 = load i32, i32* %193, align 1
  %194 = sext i32 %_rtP__IPlinearmodel_C_ir_el371 to i64
  %195 = getelementptr inbounds [4 x double], [4 x double]* %190, i64 0, i64 %194
  %_rtB__IPlinearmodel_el372 = load double, double* %195, align 1
  %tmp38 = fadd double %tmp37, %_rtB__IPlinearmodel_el372
  store double %tmp38, double* %195, align 1
  %tmp39 = add i32 %ri_.2, 1
  br label %merge77

true39:                                           ; preds = %merge78
  %196 = getelementptr inbounds i8, i8* %6, i64 240
  %197 = bitcast i8* %196 to [4 x double]*
  %198 = sext i32 %ri_.3 to i64
  %199 = getelementptr inbounds [4 x double], [4 x double]* %197, i64 0, i64 %198
  %_rtP__IPlinearmodel_C_pr_el = load double, double* %199, align 1
  %200 = getelementptr inbounds i8, i8* %5, i64 56
  %201 = bitcast i8* %200 to double*
  %_rtX__IPlinearmodel_CSTATE_el = load double, double* %201, align 1
  %tmp34 = fmul double %_rtP__IPlinearmodel_C_pr_el, %_rtX__IPlinearmodel_CSTATE_el
  %202 = bitcast i8* %148 to [4 x double]*
  %203 = getelementptr inbounds i8, i8* %6, i64 516
  %204 = bitcast i8* %203 to [4 x i32]*
  %205 = getelementptr inbounds [4 x i32], [4 x i32]* %204, i64 0, i64 %198
  %_rtP__IPlinearmodel_C_ir_el = load i32, i32* %205, align 1
  %206 = sext i32 %_rtP__IPlinearmodel_C_ir_el to i64
  %207 = getelementptr inbounds [4 x double], [4 x double]* %202, i64 0, i64 %206
  %_rtB__IPlinearmodel_el357 = load double, double* %207, align 1
  %tmp35 = fadd double %tmp34, %_rtB__IPlinearmodel_el357
  store double %tmp35, double* %207, align 1
  %tmp36 = add i32 %ri_.3, 1
  br label %merge78

false40:                                          ; preds = %merge78
  %_rtB__IPlinearmodel_el = load double, double* %149, align 1
  %_rtU__xw_ref248 = load double, double* %76, align 1
  %tmp17 = fsub double %_rtB__IPlinearmodel_el, %_rtU__xw_ref248
  %208 = getelementptr inbounds i8, i8* %6, i64 304
  %209 = bitcast i8* %208 to double*
  %_rtP__Gain_Gain = load double, double* %209, align 1
  %_rtU__k_xw251 = load double, double* %80, align 1
  %tmp18 = fmul double %_rtP__Gain_Gain, %_rtU__k_xw251
  %tmp19 = fmul double %tmp17, %tmp18
  %_rtB__IPlinearmodel_el253 = load double, double* %151, align 1
  %_rtB__Constant1_el255 = load double, double* %82, align 1
  %tmp20 = fsub double %_rtB__IPlinearmodel_el253, %_rtB__Constant1_el255
  %_rtU__k_the259 = load double, double* %84, align 1
  %tmp21 = fmul double %_rtP__Gain_Gain, %_rtU__k_the259
  %tmp22 = fmul double %tmp20, %tmp21
  %tmp23 = fadd double %tmp19, %tmp22
  %_rtB__IPlinearmodel_el261 = load double, double* %153, align 1
  %_rtB__Constant1_el263 = load double, double* %88, align 1
  %tmp24 = fsub double %_rtB__IPlinearmodel_el261, %_rtB__Constant1_el263
  %_rtU__k_Dxw267 = load double, double* %90, align 1
  %tmp25 = fmul double %_rtP__Gain_Gain, %_rtU__k_Dxw267
  %tmp26 = fmul double %tmp24, %tmp25
  %tmp27 = fadd double %tmp23, %tmp26
  %_rtB__IPlinearmodel_el269 = load double, double* %155, align 1
  %_rtB__Constant1_el271 = load double, double* %92, align 1
  %tmp28 = fsub double %_rtB__IPlinearmodel_el269, %_rtB__Constant1_el271
  %_rtU__k_Dthe275 = load double, double* %94, align 1
  %tmp29 = fmul double %_rtP__Gain_Gain, %_rtU__k_Dthe275
  %tmp30 = fmul double %tmp28, %tmp29
  %tmp31 = fadd double %tmp27, %tmp30
  %210 = getelementptr inbounds i8, i8* %7, i64 160
  %211 = bitcast i8* %210 to double*
  store double %tmp31, double* %211, align 1
  %212 = getelementptr inbounds i8, i8* %7, i64 168
  %213 = bitcast i8* %212 to double*
  store double %_rtB__IPlinearmodel_el261, double* %213, align 1
  %214 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %215 = and i8 %214, 1
  %.not437 = icmp eq i8 %215, 0
  br i1 %.not437, label %false40.false42_crit_edge, label %true41

false40.false42_crit_edge:                        ; preds = %false40
  %.phi.trans.insert449 = getelementptr inbounds i8, i8* %3, i64 112
  %.phi.trans.insert450 = bitcast i8* %.phi.trans.insert449 to i32*
  %_rtDW__Saturation_MODE_d.pre = load i32, i32* %.phi.trans.insert450, align 1
  br label %false42

true41:                                           ; preds = %false40
  %_rtB__DotProduct_l = load double, double* %211, align 1
  %216 = getelementptr inbounds i8, i8* %6, i64 312
  %217 = bitcast i8* %216 to double*
  %_rtP__Saturation_UpperSat = load double, double* %217, align 1
  %218 = fcmp ult double %_rtB__DotProduct_l, %_rtP__Saturation_UpperSat
  br i1 %218, label %false44, label %true43

false42:                                          ; preds = %true43, %true45, %false46, %false40.false42_crit_edge
  %_rtDW__Saturation_MODE_d291 = phi i32 [ %_rtDW__Saturation_MODE_d.pre, %false40.false42_crit_edge ], [ 1, %true43 ], [ 0, %true45 ], [ -1, %false46 ]
  %219 = getelementptr inbounds i8, i8* %3, i64 112
  %220 = bitcast i8* %219 to i32*
  switch i32 %_rtDW__Saturation_MODE_d291, label %false50 [
    i32 1, label %true47
    i32 -1, label %true49
  ]

true43:                                           ; preds = %true41
  %221 = getelementptr inbounds i8, i8* %3, i64 112
  %222 = bitcast i8* %221 to i32*
  store i32 1, i32* %222, align 1
  br label %false42

false44:                                          ; preds = %true41
  %223 = getelementptr inbounds i8, i8* %6, i64 320
  %224 = bitcast i8* %223 to double*
  %_rtP__Saturation_LowerSat = load double, double* %224, align 1
  %225 = fcmp ogt double %_rtB__DotProduct_l, %_rtP__Saturation_LowerSat
  br i1 %225, label %true45, label %false46

true45:                                           ; preds = %false44
  %226 = getelementptr inbounds i8, i8* %3, i64 112
  %227 = bitcast i8* %226 to i32*
  store i32 0, i32* %227, align 1
  br label %false42

false46:                                          ; preds = %false44
  %228 = getelementptr inbounds i8, i8* %3, i64 112
  %229 = bitcast i8* %228 to i32*
  store i32 -1, i32* %229, align 1
  br label %false42

true47:                                           ; preds = %false42
  %230 = getelementptr inbounds i8, i8* %6, i64 312
  %231 = bitcast i8* %230 to double*
  %_rtP__Saturation_UpperSat299 = load double, double* %231, align 1
  %232 = getelementptr inbounds i8, i8* %7, i64 176
  %233 = bitcast i8* %232 to double*
  store double %_rtP__Saturation_UpperSat299, double* %233, align 1
  br label %merge82

true49:                                           ; preds = %false42
  %234 = getelementptr inbounds i8, i8* %6, i64 320
  %235 = bitcast i8* %234 to double*
  %_rtP__Saturation_LowerSat296 = load double, double* %235, align 1
  %236 = getelementptr inbounds i8, i8* %7, i64 176
  %237 = bitcast i8* %236 to double*
  store double %_rtP__Saturation_LowerSat296, double* %237, align 1
  br label %merge82

false50:                                          ; preds = %false42
  %_rtB__DotProduct_l293 = load double, double* %211, align 1
  %238 = getelementptr inbounds i8, i8* %7, i64 176
  %239 = bitcast i8* %238 to double*
  store double %_rtB__DotProduct_l293, double* %239, align 1
  br label %merge82

true51:                                           ; preds = %merge82
  %240 = getelementptr inbounds i8, i8* %3, i64 116
  call void @vm_srUpdateBC(i8* nonnull %240)
  br label %false32

false52:                                          ; preds = %false32
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 15, i32 104)
  %241 = call i8 @vm_getHasError(i8* %S)
  %242 = and i8 %241, 1
  %.not418 = icmp eq i8 %242, 0
  br i1 %.not418, label %false53, label %true

false53:                                          ; preds = %false52
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 16, i32 104)
  %243 = call i8 @vm_getHasError(i8* %S)
  %244 = and i8 %243, 1
  %.not419 = icmp eq i8 %244, 0
  br i1 %.not419, label %false54, label %true

false54:                                          ; preds = %false53
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 17, i32 104)
  %245 = call i8 @vm_getHasError(i8* %S)
  %246 = and i8 %245, 1
  %.not420 = icmp eq i8 %246, 0
  br i1 %.not420, label %false55, label %true

false55:                                          ; preds = %false54
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 18, i32 104)
  %247 = call i8 @vm_getHasError(i8* %S)
  %248 = and i8 %247, 1
  %.not421 = icmp eq i8 %248, 0
  br i1 %.not421, label %false56, label %true

false56:                                          ; preds = %false55
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 19, i32 104)
  %249 = call i8 @vm_getHasError(i8* %S)
  %250 = and i8 %249, 1
  %.not422 = icmp eq i8 %250, 0
  br i1 %.not422, label %false57, label %true

false57:                                          ; preds = %false56
  br i1 %.not415, label %false59, label %true58

true58:                                           ; preds = %false57
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 20, i32 104)
  %251 = call i8 @vm_getHasError(i8* %S)
  %252 = and i8 %251, 1
  %.not425 = icmp eq i8 %252, 0
  br i1 %.not425, label %false60, label %true

false59:                                          ; preds = %false70, %false57
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 104)
  %253 = call i8 @vm_getHasError(i8* %S)
  br label %true

false60:                                          ; preds = %true58
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 21, i32 104)
  %254 = call i8 @vm_getHasError(i8* %S)
  %255 = and i8 %254, 1
  %.not426 = icmp eq i8 %255, 0
  br i1 %.not426, label %false61, label %true

false61:                                          ; preds = %false60
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 22, i32 104)
  %256 = call i8 @vm_getHasError(i8* %S)
  %257 = and i8 %256, 1
  %.not427 = icmp eq i8 %257, 0
  br i1 %.not427, label %false62, label %true

false62:                                          ; preds = %false61
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 23, i32 104)
  %258 = call i8 @vm_getHasError(i8* %S)
  %259 = and i8 %258, 1
  %.not428 = icmp eq i8 %259, 0
  br i1 %.not428, label %false63, label %true

false63:                                          ; preds = %false62
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 24, i32 104)
  %260 = call i8 @vm_getHasError(i8* %S)
  %261 = and i8 %260, 1
  %.not429 = icmp eq i8 %261, 0
  br i1 %.not429, label %false64, label %true

false64:                                          ; preds = %false63
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 25, i32 104)
  %262 = call i8 @vm_getHasError(i8* %S)
  %263 = and i8 %262, 1
  %.not430 = icmp eq i8 %263, 0
  br i1 %.not430, label %false65, label %true

false65:                                          ; preds = %false64
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 26, i32 104)
  %264 = call i8 @vm_getHasError(i8* %S)
  %265 = and i8 %264, 1
  %.not431 = icmp eq i8 %265, 0
  br i1 %.not431, label %false66, label %true

false66:                                          ; preds = %false65
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 27, i32 104)
  %266 = call i8 @vm_getHasError(i8* %S)
  %267 = and i8 %266, 1
  %.not432 = icmp eq i8 %267, 0
  br i1 %.not432, label %false67, label %true

false67:                                          ; preds = %false66
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 28, i32 104)
  %268 = call i8 @vm_getHasError(i8* %S)
  %269 = and i8 %268, 1
  %.not433 = icmp eq i8 %269, 0
  br i1 %.not433, label %false68, label %true

false68:                                          ; preds = %false67
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 29, i32 104)
  %270 = call i8 @vm_getHasError(i8* %S)
  %271 = and i8 %270, 1
  %.not434 = icmp eq i8 %271, 0
  br i1 %.not434, label %false69, label %true

false69:                                          ; preds = %false68
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 30, i32 104)
  %272 = call i8 @vm_getHasError(i8* %S)
  %273 = and i8 %272, 1
  %.not435 = icmp eq i8 %273, 0
  br i1 %.not435, label %false70, label %true

false70:                                          ; preds = %false69
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 31, i32 104)
  %274 = call i8 @vm_getHasError(i8* %S)
  %275 = and i8 %274, 1
  %.not436 = icmp eq i8 %275, 0
  br i1 %.not436, label %false59, label %true

merge:                                            ; preds = %false4, %false2
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 2, i32 104)
  %276 = call i8 @vm_getHasError(i8* %S)
  %277 = and i8 %276, 1
  %.not409 = icmp eq i8 %277, 0
  br i1 %.not409, label %false5, label %true

merge74:                                          ; preds = %false18, %true17, %true15
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 12, i32 104)
  %278 = call i8 @vm_getHasError(i8* %S)
  %279 = and i8 %278, 1
  %.not414 = icmp eq i8 %279, 0
  br i1 %.not414, label %false19, label %true

merge75:                                          ; preds = %true33, %true31
  %ri_.0 = phi i32 [ %_rtP__IPlinearmodel_C_jc_el, %true31 ], [ %tmp45, %true33 ]
  %280 = getelementptr inbounds i8, i8* %6, i64 536
  %281 = bitcast i8* %280 to i32*
  %_rtP__IPlinearmodel_C_jc_el230 = load i32, i32* %281, align 1
  %282 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_C_jc_el230
  br i1 %282, label %true33, label %merge76

merge76:                                          ; preds = %merge75, %true35
  %ri_.1 = phi i32 [ %tmp42, %true35 ], [ %_rtP__IPlinearmodel_C_jc_el230, %merge75 ]
  %283 = getelementptr inbounds i8, i8* %6, i64 540
  %284 = bitcast i8* %283 to i32*
  %_rtP__IPlinearmodel_C_jc_el235 = load i32, i32* %284, align 1
  %285 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_C_jc_el235
  br i1 %285, label %true35, label %merge77

merge77:                                          ; preds = %merge76, %true37
  %ri_.2 = phi i32 [ %tmp39, %true37 ], [ %_rtP__IPlinearmodel_C_jc_el235, %merge76 ]
  %286 = getelementptr inbounds i8, i8* %6, i64 544
  %287 = bitcast i8* %286 to i32*
  %_rtP__IPlinearmodel_C_jc_el240 = load i32, i32* %287, align 1
  %288 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_C_jc_el240
  br i1 %288, label %true37, label %merge78

merge78:                                          ; preds = %merge77, %true39
  %ri_.3 = phi i32 [ %tmp36, %true39 ], [ %_rtP__IPlinearmodel_C_jc_el240, %merge77 ]
  %289 = getelementptr inbounds i8, i8* %6, i64 548
  %290 = bitcast i8* %289 to i32*
  %_rtP__IPlinearmodel_C_jc_el245 = load i32, i32* %290, align 1
  %291 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_C_jc_el245
  br i1 %291, label %true39, label %false40

merge82:                                          ; preds = %false50, %true49, %true47
  %292 = getelementptr inbounds i8, i8* %6, i64 328
  %293 = bitcast i8* %292 to double*
  %_rtP__Gain1_Gain = load double, double* %293, align 1
  %_rtB__IPlinearmodel_el303 = load double, double* %151, align 1
  %tmp32 = fmul double %_rtP__Gain1_Gain, %_rtB__IPlinearmodel_el303
  %294 = getelementptr inbounds i8, i8* %7, i64 184
  %295 = bitcast i8* %294 to double*
  store double %tmp32, double* %295, align 1
  %296 = getelementptr inbounds i8, i8* %6, i64 336
  %297 = bitcast i8* %296 to double*
  %_rtP__Gain2_Gain = load double, double* %297, align 1
  %_rtB__IPlinearmodel_el307 = load double, double* %155, align 1
  %tmp33 = fmul double %_rtP__Gain2_Gain, %_rtB__IPlinearmodel_el307
  %298 = getelementptr inbounds i8, i8* %7, i64 192
  %299 = bitcast i8* %298 to double*
  store double %tmp33, double* %299, align 1
  %300 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %301 = and i8 %300, 1
  %.not438 = icmp eq i8 %301, 0
  br i1 %.not438, label %false32, label %true51
}

declare double @vm_ssGetTStart(i8*)

declare double @vm_ssGetTaskTime(i8*, i32 signext)

declare signext i32 @vm_ssIsSampleHit(i8*, i32 signext, i32 signext)

declare i8* @vm_ssGetContStateDisabled(i8*)

declare zeroext i8 @vm_ssIsModeUpdateTimeStep(i8*)

declare void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8*)

declare void @vm_srUpdateBC(i8*)

define void @SystemInitialize(i8* %S) {
SystemInitialize_entry:
  %0 = call i8 @vm_ssIsFirstInitCond(i8* %S)
  %1 = call i8* @vm_ssGetRootDWork(i8* %S)
  %2 = call i8* @vm_ssGetX(i8* %S)
  %3 = call i8* @vm_ssGetModelRtp(i8* %S)
  %4 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %5 = call i8* @vm_ssGetU(i8* %S)
  %6 = getelementptr inbounds i8, i8* %3, i64 384
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 64
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 392
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el11 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 72
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el11, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 400
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el14 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 80
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el14, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %3, i64 408
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant_Value_el17 = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %4, i64 88
  %21 = bitcast i8* %20 to double*
  store double %_rtP__Constant_Value_el17, double* %21, align 1
  %.not = icmp eq i8 %0, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %SystemInitialize_entry
  %22 = bitcast i8* %2 to double*
  store double 2.350000e-01, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %2, i64 8
  %24 = bitcast i8* %23 to double*
  store double 0.000000e+00, double* %24, align 1
  %25 = getelementptr inbounds i8, i8* %2, i64 16
  %26 = bitcast i8* %25 to double*
  store double 0.000000e+00, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %2, i64 24
  %28 = bitcast i8* %27 to double*
  store double 0.000000e+00, double* %28, align 1
  br label %false

false:                                            ; preds = %true, %SystemInitialize_entry
  %29 = getelementptr inbounds i8, i8* %1, i64 104
  %30 = bitcast i8* %29 to i32*
  store i32 1, i32* %30, align 1
  %31 = getelementptr inbounds i8, i8* %3, i64 272
  %32 = bitcast i8* %31 to double*
  %_rtP__IPlinearmodel_InitialCondition_el = load double, double* %32, align 1
  %33 = getelementptr inbounds i8, i8* %2, i64 32
  %34 = bitcast i8* %33 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el, double* %34, align 1
  %35 = getelementptr inbounds i8, i8* %3, i64 280
  %36 = bitcast i8* %35 to double*
  %_rtP__IPlinearmodel_InitialCondition_el28 = load double, double* %36, align 1
  %37 = getelementptr inbounds i8, i8* %2, i64 40
  %38 = bitcast i8* %37 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el28, double* %38, align 1
  %39 = getelementptr inbounds i8, i8* %3, i64 288
  %40 = bitcast i8* %39 to double*
  %_rtP__IPlinearmodel_InitialCondition_el31 = load double, double* %40, align 1
  %41 = getelementptr inbounds i8, i8* %2, i64 48
  %42 = bitcast i8* %41 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el31, double* %42, align 1
  %43 = getelementptr inbounds i8, i8* %3, i64 296
  %44 = bitcast i8* %43 to double*
  %_rtP__IPlinearmodel_InitialCondition_el34 = load double, double* %44, align 1
  %45 = getelementptr inbounds i8, i8* %2, i64 56
  %46 = bitcast i8* %45 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el34, double* %46, align 1
  %47 = getelementptr inbounds i8, i8* %3, i64 120
  %48 = bitcast i8* %47 to double*
  %_rtP__Output3_Y0 = load double, double* %48, align 1
  %49 = getelementptr inbounds i8, i8* %4, i64 128
  %50 = bitcast i8* %49 to double*
  store double %_rtP__Output3_Y0, double* %50, align 1
  %51 = getelementptr inbounds i8, i8* %3, i64 128
  %52 = bitcast i8* %51 to double*
  %_rtP__Output5_Y0 = load double, double* %52, align 1
  %53 = getelementptr inbounds i8, i8* %4, i64 184
  %54 = bitcast i8* %53 to double*
  store double %_rtP__Output5_Y0, double* %54, align 1
  %55 = getelementptr inbounds i8, i8* %3, i64 136
  %56 = bitcast i8* %55 to double*
  %_rtP__Output8_Y0 = load double, double* %56, align 1
  %57 = getelementptr inbounds i8, i8* %4, i64 168
  %58 = bitcast i8* %57 to double*
  store double %_rtP__Output8_Y0, double* %58, align 1
  %59 = getelementptr inbounds i8, i8* %3, i64 144
  %60 = bitcast i8* %59 to double*
  %_rtP__Output9_Y0 = load double, double* %60, align 1
  %61 = getelementptr inbounds i8, i8* %4, i64 192
  %62 = bitcast i8* %61 to double*
  store double %_rtP__Output9_Y0, double* %62, align 1
  %63 = getelementptr inbounds i8, i8* %3, i64 152
  %64 = bitcast i8* %63 to double*
  %_rtP__Output10_Y0 = load double, double* %64, align 1
  %65 = getelementptr inbounds i8, i8* %4, i64 176
  %66 = bitcast i8* %65 to double*
  store double %_rtP__Output10_Y0, double* %66, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 102)
  %67 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare zeroext i8 @vm_ssIsFirstInitCond(i8*)

