; ModuleID = 'test'
source_filename = "test"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @model_lqr_dol_CGInitializeSizes(i8* %S_0) {
model_lqr_dol_CGInitializeSizes_entry:
  %tmp_ = alloca [4 x i32], align 4
  call void @model_lqr_dol_Checksum([4 x i32]* nonnull %tmp_)
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
  call void @vm_USizeCheck(i8* %S_0, i32 16)
  call void @vm_blockIOSizeCheck(i8* %S_0, i32 320)
  call void @vm_dworkSizeCheck(i8* %S_0, i32 120)
  call void @vm_paramSizeCheck(i8* %S_0, i32 656)
  ret void
}

define void @model_lqr_dol_Checksum([4 x i32]* %y) {
model_lqr_dol_Checksum_entry:
  %0 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 0
  store i32 1657155345, i32* %0, align 1
  %1 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 1
  store i32 814698745, i32* %1, align 1
  %2 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 2
  store i32 -671895506, i32* %2, align 1
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 3
  store i32 622610340, i32* %3, align 1
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
  %_rtB__stateFeedbackGain = load double, double* %5, align 1
  %6 = getelementptr inbounds i8, i8* %2, i64 448
  %7 = bitcast i8* %6 to double*
  %_rtP__Saturation_UpperSat_i = load double, double* %7, align 1
  %tmp0 = fsub double %_rtB__stateFeedbackGain, %_rtP__Saturation_UpperSat_i
  %8 = bitcast i8* %1 to double*
  store double %tmp0, double* %8, align 1
  %_rtB__stateFeedbackGain9 = load double, double* %5, align 1
  %9 = getelementptr inbounds i8, i8* %2, i64 456
  %10 = bitcast i8* %9 to double*
  %_rtP__Saturation_LowerSat_g = load double, double* %10, align 1
  %tmp1 = fsub double %_rtB__stateFeedbackGain9, %_rtP__Saturation_LowerSat_g
  %11 = getelementptr inbounds i8, i8* %1, i64 8
  %12 = bitcast i8* %11 to double*
  store double %tmp1, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %0, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %13, align 1
  %14 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not = icmp eq i8 %14, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %ZeroCrossings_entry
  %15 = getelementptr inbounds i8, i8* %3, i64 184
  %16 = bitcast i8* %15 to double*
  %_rtB__Gain = load double, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %2, i64 336
  %18 = bitcast i8* %17 to double*
  %_rtP__Saturation_UpperSat = load double, double* %18, align 1
  %tmp2 = fsub double %_rtB__Gain, %_rtP__Saturation_UpperSat
  %19 = getelementptr inbounds i8, i8* %1, i64 16
  %20 = bitcast i8* %19 to double*
  store double %tmp2, double* %20, align 1
  %_rtB__Gain19 = load double, double* %16, align 1
  %21 = getelementptr inbounds i8, i8* %2, i64 344
  %22 = bitcast i8* %21 to double*
  %_rtP__Saturation_LowerSat = load double, double* %22, align 1
  %tmp3 = fsub double %_rtB__Gain19, %_rtP__Saturation_LowerSat
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
  %5 = getelementptr inbounds i8, i8* %4, i64 288
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = bitcast i8* %1 to double*
  store double %_rtB__Dx_el, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 296
  %9 = bitcast i8* %8 to double*
  %_rtB__Dx_el23 = load double, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %1, i64 8
  %11 = bitcast i8* %10 to double*
  store double %_rtB__Dx_el23, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 304
  %13 = bitcast i8* %12 to double*
  %_rtB__Dx_el26 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %1, i64 16
  %15 = bitcast i8* %14 to double*
  store double %_rtB__Dx_el26, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 312
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
  %30 = getelementptr inbounds i8, i8* %3, i64 584
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
  %47 = getelementptr inbounds i8, i8* %3, i64 552
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
  %59 = getelementptr inbounds i8, i8* %3, i64 552
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
  %71 = getelementptr inbounds i8, i8* %3, i64 552
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
  %83 = getelementptr inbounds i8, i8* %3, i64 552
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
  %88 = getelementptr inbounds i8, i8* %3, i64 612
  %89 = bitcast i8* %88 to i32*
  %_rtP__IPlinearmodel_B_jc_el = load i32, i32* %89, align 1
  br label %merge14

true9:                                            ; preds = %merge14
  %90 = getelementptr inbounds i8, i8* %3, i64 224
  %91 = bitcast i8* %90 to [2 x double]*
  %92 = sext i32 %ri_.4 to i64
  %93 = getelementptr inbounds [2 x double], [2 x double]* %91, i64 0, i64 %92
  %_rtP__IPlinearmodel_B_pr_el = load double, double* %93, align 1
  %94 = getelementptr inbounds i8, i8* %4, i64 232
  %95 = bitcast i8* %94 to double*
  %_rtB__ctrl_sig_lin = load double, double* %95, align 1
  %tmp0 = fmul double %_rtP__IPlinearmodel_B_pr_el, %_rtB__ctrl_sig_lin
  %96 = bitcast i8* %22 to [4 x double]*
  %97 = getelementptr inbounds i8, i8* %3, i64 604
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
  %102 = getelementptr inbounds i8, i8* %3, i64 588
  %103 = bitcast i8* %102 to i32*
  %_rtP__IPlinearmodel_A_jc_el43 = load i32, i32* %103, align 1
  %104 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_A_jc_el43
  br i1 %104, label %true1, label %merge11

merge11:                                          ; preds = %merge, %true3
  %ri_.1 = phi i32 [ %tmp11, %true3 ], [ %_rtP__IPlinearmodel_A_jc_el43, %merge ]
  %105 = getelementptr inbounds i8, i8* %3, i64 592
  %106 = bitcast i8* %105 to i32*
  %_rtP__IPlinearmodel_A_jc_el48 = load i32, i32* %106, align 1
  %107 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_A_jc_el48
  br i1 %107, label %true3, label %merge12

merge12:                                          ; preds = %merge11, %true5
  %ri_.2 = phi i32 [ %tmp8, %true5 ], [ %_rtP__IPlinearmodel_A_jc_el48, %merge11 ]
  %108 = getelementptr inbounds i8, i8* %3, i64 596
  %109 = bitcast i8* %108 to i32*
  %_rtP__IPlinearmodel_A_jc_el53 = load i32, i32* %109, align 1
  %110 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_A_jc_el53
  br i1 %110, label %true5, label %merge13

merge13:                                          ; preds = %merge12, %true7
  %ri_.3 = phi i32 [ %tmp5, %true7 ], [ %_rtP__IPlinearmodel_A_jc_el53, %merge12 ]
  %111 = getelementptr inbounds i8, i8* %3, i64 600
  %112 = bitcast i8* %111 to i32*
  %_rtP__IPlinearmodel_A_jc_el58 = load i32, i32* %112, align 1
  %113 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_A_jc_el58
  br i1 %113, label %true7, label %false8

merge14:                                          ; preds = %true9, %false8
  %ri_.4 = phi i32 [ %_rtP__IPlinearmodel_B_jc_el, %false8 ], [ %tmp2, %true9 ]
  %114 = getelementptr inbounds i8, i8* %3, i64 616
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
  %5 = getelementptr inbounds i8, i8* %4, i64 288
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = bitcast i8* %1 to double*
  store double %_rtB__Dx_el, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 296
  %9 = bitcast i8* %8 to double*
  %_rtB__Dx_el23 = load double, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %1, i64 8
  %11 = bitcast i8* %10 to double*
  store double %_rtB__Dx_el23, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 304
  %13 = bitcast i8* %12 to double*
  %_rtB__Dx_el26 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %1, i64 16
  %15 = bitcast i8* %14 to double*
  store double %_rtB__Dx_el26, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 312
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
  %30 = getelementptr inbounds i8, i8* %3, i64 584
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
  %47 = getelementptr inbounds i8, i8* %3, i64 552
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
  %59 = getelementptr inbounds i8, i8* %3, i64 552
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
  %71 = getelementptr inbounds i8, i8* %3, i64 552
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
  %83 = getelementptr inbounds i8, i8* %3, i64 552
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
  %88 = getelementptr inbounds i8, i8* %3, i64 612
  %89 = bitcast i8* %88 to i32*
  %_rtP__IPlinearmodel_B_jc_el = load i32, i32* %89, align 1
  br label %merge14

true9:                                            ; preds = %merge14
  %90 = getelementptr inbounds i8, i8* %3, i64 224
  %91 = bitcast i8* %90 to [2 x double]*
  %92 = sext i32 %ri_.4 to i64
  %93 = getelementptr inbounds [2 x double], [2 x double]* %91, i64 0, i64 %92
  %_rtP__IPlinearmodel_B_pr_el = load double, double* %93, align 1
  %94 = getelementptr inbounds i8, i8* %4, i64 232
  %95 = bitcast i8* %94 to double*
  %_rtB__ctrl_sig_lin = load double, double* %95, align 1
  %tmp0 = fmul double %_rtP__IPlinearmodel_B_pr_el, %_rtB__ctrl_sig_lin
  %96 = bitcast i8* %22 to [4 x double]*
  %97 = getelementptr inbounds i8, i8* %3, i64 604
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
  %102 = getelementptr inbounds i8, i8* %3, i64 588
  %103 = bitcast i8* %102 to i32*
  %_rtP__IPlinearmodel_A_jc_el43 = load i32, i32* %103, align 1
  %104 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_A_jc_el43
  br i1 %104, label %true1, label %merge11

merge11:                                          ; preds = %merge, %true3
  %ri_.1 = phi i32 [ %tmp11, %true3 ], [ %_rtP__IPlinearmodel_A_jc_el43, %merge ]
  %105 = getelementptr inbounds i8, i8* %3, i64 592
  %106 = bitcast i8* %105 to i32*
  %_rtP__IPlinearmodel_A_jc_el48 = load i32, i32* %106, align 1
  %107 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_A_jc_el48
  br i1 %107, label %true3, label %merge12

merge12:                                          ; preds = %merge11, %true5
  %ri_.2 = phi i32 [ %tmp8, %true5 ], [ %_rtP__IPlinearmodel_A_jc_el48, %merge11 ]
  %108 = getelementptr inbounds i8, i8* %3, i64 596
  %109 = bitcast i8* %108 to i32*
  %_rtP__IPlinearmodel_A_jc_el53 = load i32, i32* %109, align 1
  %110 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_A_jc_el53
  br i1 %110, label %true5, label %merge13

merge13:                                          ; preds = %merge12, %true7
  %ri_.3 = phi i32 [ %tmp5, %true7 ], [ %_rtP__IPlinearmodel_A_jc_el53, %merge12 ]
  %111 = getelementptr inbounds i8, i8* %3, i64 600
  %112 = bitcast i8* %111 to i32*
  %_rtP__IPlinearmodel_A_jc_el58 = load i32, i32* %112, align 1
  %113 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_A_jc_el58
  br i1 %113, label %true7, label %false8

merge14:                                          ; preds = %true9, %false8
  %ri_.4 = phi i32 [ %_rtP__IPlinearmodel_B_jc_el, %false8 ], [ %tmp2, %true9 ]
  %114 = getelementptr inbounds i8, i8* %3, i64 616
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
  %0 = call i8* @vm_ssGetRootDWork(i8* %S)
  %1 = call i8* @vm_ssGetModelRtp(i8* %S)
  %2 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %3 = getelementptr inbounds i8, i8* %1, i64 464
  %4 = bitcast i8* %3 to double*
  %_rtP__Constant_Value_k_el = load double, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %2, i64 64
  %6 = bitcast i8* %5 to double*
  store double %_rtP__Constant_Value_k_el, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %1, i64 472
  %8 = bitcast i8* %7 to double*
  %_rtP__Constant_Value_k_el7 = load double, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %2, i64 72
  %10 = bitcast i8* %9 to double*
  store double %_rtP__Constant_Value_k_el7, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %1, i64 480
  %12 = bitcast i8* %11 to double*
  %_rtP__Constant_Value_k_el10 = load double, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %2, i64 80
  %14 = bitcast i8* %13 to double*
  store double %_rtP__Constant_Value_k_el10, double* %14, align 1
  %15 = getelementptr inbounds i8, i8* %1, i64 488
  %16 = bitcast i8* %15 to double*
  %_rtP__Constant_Value_k_el13 = load double, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %2, i64 88
  %18 = bitcast i8* %17 to double*
  store double %_rtP__Constant_Value_k_el13, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %1, i64 520
  %20 = bitcast i8* %19 to double*
  %_rtP__Constant2_Value = load double, double* %20, align 1
  %21 = getelementptr inbounds i8, i8* %2, i64 120
  %22 = bitcast i8* %21 to double*
  store double %_rtP__Constant2_Value, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %1, i64 496
  %24 = bitcast i8* %23 to double*
  %_rtP__Constant1_Value_el = load double, double* %24, align 1
  %25 = getelementptr inbounds i8, i8* %2, i64 96
  %26 = bitcast i8* %25 to double*
  store double %_rtP__Constant1_Value_el, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %1, i64 528
  %28 = bitcast i8* %27 to double*
  %_rtP__Constant3_Value_el = load double, double* %28, align 1
  %29 = getelementptr inbounds i8, i8* %2, i64 128
  %30 = bitcast i8* %29 to double*
  store double %_rtP__Constant3_Value_el, double* %30, align 1
  %31 = getelementptr inbounds i8, i8* %1, i64 504
  %32 = bitcast i8* %31 to double*
  %_rtP__Constant1_Value_el22 = load double, double* %32, align 1
  %33 = getelementptr inbounds i8, i8* %2, i64 104
  %34 = bitcast i8* %33 to double*
  store double %_rtP__Constant1_Value_el22, double* %34, align 1
  %35 = getelementptr inbounds i8, i8* %1, i64 536
  %36 = bitcast i8* %35 to double*
  %_rtP__Constant3_Value_el25 = load double, double* %36, align 1
  %37 = getelementptr inbounds i8, i8* %2, i64 136
  %38 = bitcast i8* %37 to double*
  store double %_rtP__Constant3_Value_el25, double* %38, align 1
  %39 = getelementptr inbounds i8, i8* %1, i64 512
  %40 = bitcast i8* %39 to double*
  %_rtP__Constant1_Value_el28 = load double, double* %40, align 1
  %41 = getelementptr inbounds i8, i8* %2, i64 112
  %42 = bitcast i8* %41 to double*
  store double %_rtP__Constant1_Value_el28, double* %42, align 1
  %43 = getelementptr inbounds i8, i8* %1, i64 544
  %44 = bitcast i8* %43 to double*
  %_rtP__Constant3_Value_el31 = load double, double* %44, align 1
  %45 = getelementptr inbounds i8, i8* %2, i64 144
  %46 = bitcast i8* %45 to double*
  store double %_rtP__Constant3_Value_el31, double* %46, align 1
  %47 = getelementptr inbounds i8, i8* %1, i64 368
  %48 = bitcast i8* %47 to double*
  %_rtP__Constant_Value_el = load double, double* %48, align 1
  %49 = getelementptr inbounds i8, i8* %2, i64 256
  %50 = bitcast i8* %49 to double*
  store double %_rtP__Constant_Value_el, double* %50, align 1
  %51 = getelementptr inbounds i8, i8* %1, i64 376
  %52 = bitcast i8* %51 to double*
  %_rtP__Constant_Value_el36 = load double, double* %52, align 1
  %53 = getelementptr inbounds i8, i8* %2, i64 264
  %54 = bitcast i8* %53 to double*
  store double %_rtP__Constant_Value_el36, double* %54, align 1
  %55 = getelementptr inbounds i8, i8* %1, i64 384
  %56 = bitcast i8* %55 to double*
  %_rtP__Constant_Value_el39 = load double, double* %56, align 1
  %57 = getelementptr inbounds i8, i8* %2, i64 272
  %58 = bitcast i8* %57 to double*
  store double %_rtP__Constant_Value_el39, double* %58, align 1
  %59 = getelementptr inbounds i8, i8* %1, i64 392
  %60 = bitcast i8* %59 to double*
  %_rtP__Constant_Value_el42 = load double, double* %60, align 1
  %61 = getelementptr inbounds i8, i8* %2, i64 280
  %62 = bitcast i8* %61 to double*
  store double %_rtP__Constant_Value_el42, double* %62, align 1
  %63 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %64 = and i8 %63, 1
  %.not = icmp eq i8 %64, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %Outputs1_entry
  %65 = getelementptr inbounds i8, i8* %0, i64 116
  call void @vm_srUpdateBC(i8* nonnull %65)
  br label %false

false:                                            ; preds = %true, %Outputs1_entry
  ret void
}

declare zeroext i8 @vm_ssIsModeUpdateTimeStep(i8*)

declare void @vm_srUpdateBC(i8*)

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

true:                                             ; preds = %false60, %false71, %false70, %false69, %false68, %false67, %false66, %false65, %false64, %false63, %false62, %false61, %true59, %false57, %false56, %false55, %false54, %false53, %false32, %merge83, %merge75, %false7, %false6, %false5, %merge, %Outputs0_entry
  ret void

false:                                            ; preds = %Outputs0_entry
  %11 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %12 = and i8 %11, 1
  %.not416 = icmp eq i8 %12, 0
  br i1 %.not416, label %false2, label %true1

true1:                                            ; preds = %false
  %13 = getelementptr inbounds i8, i8* %3, i64 104
  %14 = bitcast i8* %13 to i32*
  %_rtDW__Integrator_IWORK = load i32, i32* %14, align 1
  %.not451 = icmp eq i32 %_rtDW__Integrator_IWORK, 0
  br i1 %.not451, label %true1.false4_crit_edge, label %true3

true1.false4_crit_edge:                           ; preds = %true1
  %.phi.trans.insert = bitcast i8* %5 to double*
  %_rtX__Integrator_CSTATE_el120.pre = load double, double* %.phi.trans.insert, align 1
  br label %false4

false2:                                           ; preds = %false
  %15 = bitcast i8* %5 to double*
  %_rtX__Integrator_CSTATE_el = load double, double* %15, align 1
  %16 = bitcast i8* %7 to double*
  store double %_rtX__Integrator_CSTATE_el, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %5, i64 8
  %18 = bitcast i8* %17 to double*
  %_rtX__Integrator_CSTATE_el99 = load double, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %7, i64 8
  %20 = bitcast i8* %19 to double*
  store double %_rtX__Integrator_CSTATE_el99, double* %20, align 1
  %21 = getelementptr inbounds i8, i8* %5, i64 16
  %22 = bitcast i8* %21 to double*
  %_rtX__Integrator_CSTATE_el102 = load double, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %7, i64 16
  %24 = bitcast i8* %23 to double*
  store double %_rtX__Integrator_CSTATE_el102, double* %24, align 1
  %25 = getelementptr inbounds i8, i8* %5, i64 24
  %26 = bitcast i8* %25 to double*
  %_rtX__Integrator_CSTATE_el105 = load double, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %7, i64 24
  %28 = bitcast i8* %27 to double*
  store double %_rtX__Integrator_CSTATE_el105, double* %28, align 1
  br label %merge

true3:                                            ; preds = %true1
  %29 = getelementptr inbounds i8, i8* %7, i64 64
  %30 = bitcast i8* %29 to double*
  %_rtB__Constant_el = load double, double* %30, align 1
  %31 = bitcast i8* %5 to double*
  store double %_rtB__Constant_el, double* %31, align 1
  %32 = getelementptr inbounds i8, i8* %7, i64 72
  %33 = bitcast i8* %32 to double*
  %_rtB__Constant_el111 = load double, double* %33, align 1
  %34 = getelementptr inbounds i8, i8* %5, i64 8
  %35 = bitcast i8* %34 to double*
  store double %_rtB__Constant_el111, double* %35, align 1
  %36 = getelementptr inbounds i8, i8* %7, i64 80
  %37 = bitcast i8* %36 to double*
  %_rtB__Constant_el114 = load double, double* %37, align 1
  %38 = getelementptr inbounds i8, i8* %5, i64 16
  %39 = bitcast i8* %38 to double*
  store double %_rtB__Constant_el114, double* %39, align 1
  %40 = getelementptr inbounds i8, i8* %7, i64 88
  %41 = bitcast i8* %40 to double*
  %_rtB__Constant_el117 = load double, double* %41, align 1
  %42 = getelementptr inbounds i8, i8* %5, i64 24
  %43 = bitcast i8* %42 to double*
  store double %_rtB__Constant_el117, double* %43, align 1
  br label %false4

false4:                                           ; preds = %true1.false4_crit_edge, %true3
  %.pre-phi = phi double* [ %.phi.trans.insert, %true1.false4_crit_edge ], [ %31, %true3 ]
  %_rtX__Integrator_CSTATE_el120 = phi double [ %_rtX__Integrator_CSTATE_el120.pre, %true1.false4_crit_edge ], [ %_rtB__Constant_el, %true3 ]
  %44 = bitcast i8* %7 to double*
  store double %_rtX__Integrator_CSTATE_el120, double* %44, align 1
  %45 = getelementptr inbounds i8, i8* %5, i64 8
  %46 = bitcast i8* %45 to double*
  %_rtX__Integrator_CSTATE_el123 = load double, double* %46, align 1
  %47 = getelementptr inbounds i8, i8* %7, i64 8
  %48 = bitcast i8* %47 to double*
  store double %_rtX__Integrator_CSTATE_el123, double* %48, align 1
  %49 = getelementptr inbounds i8, i8* %5, i64 16
  %50 = bitcast i8* %49 to double*
  %_rtX__Integrator_CSTATE_el126 = load double, double* %50, align 1
  %51 = getelementptr inbounds i8, i8* %7, i64 16
  %52 = bitcast i8* %51 to double*
  store double %_rtX__Integrator_CSTATE_el126, double* %52, align 1
  %53 = getelementptr inbounds i8, i8* %5, i64 24
  %54 = bitcast i8* %53 to double*
  %_rtX__Integrator_CSTATE_el129 = load double, double* %54, align 1
  %55 = getelementptr inbounds i8, i8* %7, i64 24
  %56 = bitcast i8* %55 to double*
  store double %_rtX__Integrator_CSTATE_el129, double* %56, align 1
  br label %merge

false5:                                           ; preds = %merge
  %57 = getelementptr inbounds i8, i8* %6, i64 400
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
  %.not418 = icmp eq i8 %64, 0
  br i1 %.not418, label %false6, label %true

false6:                                           ; preds = %false5
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 5, i32 104)
  %65 = call i8 @vm_getHasError(i8* %S)
  %66 = and i8 %65, 1
  %.not419 = icmp eq i8 %66, 0
  br i1 %.not419, label %false7, label %true

false7:                                           ; preds = %false6
  %67 = getelementptr inbounds i8, i8* %6, i64 408
  %68 = bitcast i8* %67 to double*
  %_rtP__Gain2_Gain_m = load double, double* %68, align 1
  %69 = getelementptr inbounds i8, i8* %7, i64 24
  %70 = bitcast i8* %69 to double*
  %_rtB__state_el142 = load double, double* %70, align 1
  %tmp1 = fmul double %_rtP__Gain2_Gain_m, %_rtB__state_el142
  %71 = getelementptr inbounds i8, i8* %7, i64 40
  %72 = bitcast i8* %71 to double*
  store double %tmp1, double* %72, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 7, i32 104)
  %73 = call i8 @vm_getHasError(i8* %S)
  %74 = and i8 %73, 1
  %.not420 = icmp eq i8 %74, 0
  br i1 %.not420, label %false8, label %true

false8:                                           ; preds = %false7
  %75 = bitcast i8* %7 to double*
  %_rtB__state_el147 = load double, double* %75, align 1
  %76 = bitcast i8* %8 to double*
  %_rtU__xw_ref = load double, double* %76, align 1
  %tmp2 = fsub double %_rtB__state_el147, %_rtU__xw_ref
  %77 = getelementptr inbounds i8, i8* %6, i64 416
  %78 = bitcast i8* %77 to double*
  %_rtP__stateFeedbackGain_Gain_el = load double, double* %78, align 1
  %tmp3 = fmul double %tmp2, %_rtP__stateFeedbackGain_Gain_el
  %_rtB__state_el151 = load double, double* %60, align 1
  %79 = getelementptr inbounds i8, i8* %7, i64 96
  %80 = bitcast i8* %79 to double*
  %_rtB__Constant1_el = load double, double* %80, align 1
  %tmp4 = fsub double %_rtB__state_el151, %_rtB__Constant1_el
  %81 = getelementptr inbounds i8, i8* %6, i64 424
  %82 = bitcast i8* %81 to double*
  %_rtP__stateFeedbackGain_Gain_el154 = load double, double* %82, align 1
  %tmp5 = fmul double %tmp4, %_rtP__stateFeedbackGain_Gain_el154
  %tmp6 = fadd double %tmp3, %tmp5
  %83 = getelementptr inbounds i8, i8* %7, i64 16
  %84 = bitcast i8* %83 to double*
  %_rtB__state_el156 = load double, double* %84, align 1
  %85 = getelementptr inbounds i8, i8* %7, i64 104
  %86 = bitcast i8* %85 to double*
  %_rtB__Constant1_el158 = load double, double* %86, align 1
  %tmp7 = fsub double %_rtB__state_el156, %_rtB__Constant1_el158
  %87 = getelementptr inbounds i8, i8* %6, i64 432
  %88 = bitcast i8* %87 to double*
  %_rtP__stateFeedbackGain_Gain_el160 = load double, double* %88, align 1
  %tmp8 = fmul double %tmp7, %_rtP__stateFeedbackGain_Gain_el160
  %tmp9 = fadd double %tmp6, %tmp8
  %_rtB__state_el162 = load double, double* %70, align 1
  %89 = getelementptr inbounds i8, i8* %7, i64 112
  %90 = bitcast i8* %89 to double*
  %_rtB__Constant1_el164 = load double, double* %90, align 1
  %tmp10 = fsub double %_rtB__state_el162, %_rtB__Constant1_el164
  %91 = getelementptr inbounds i8, i8* %6, i64 440
  %92 = bitcast i8* %91 to double*
  %_rtP__stateFeedbackGain_Gain_el166 = load double, double* %92, align 1
  %tmp11 = fmul double %tmp10, %_rtP__stateFeedbackGain_Gain_el166
  %tmp12 = fadd double %tmp9, %tmp11
  %93 = getelementptr inbounds i8, i8* %7, i64 48
  %94 = bitcast i8* %93 to double*
  store double %tmp12, double* %94, align 1
  %95 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %96 = and i8 %95, 1
  %.not421 = icmp eq i8 %96, 0
  br i1 %.not421, label %false8.false10_crit_edge, label %true9

false8.false10_crit_edge:                         ; preds = %false8
  %.phi.trans.insert453 = getelementptr inbounds i8, i8* %3, i64 108
  %.phi.trans.insert454 = bitcast i8* %.phi.trans.insert453 to i32*
  %_rtDW__Saturation_MODE.pre = load i32, i32* %.phi.trans.insert454, align 1
  br label %false10

true9:                                            ; preds = %false8
  %_rtB__stateFeedbackGain = load double, double* %94, align 1
  %97 = getelementptr inbounds i8, i8* %6, i64 448
  %98 = bitcast i8* %97 to double*
  %_rtP__Saturation_UpperSat_i = load double, double* %98, align 1
  %99 = fcmp ult double %_rtB__stateFeedbackGain, %_rtP__Saturation_UpperSat_i
  br i1 %99, label %false12, label %true11

false10:                                          ; preds = %true11, %true13, %false14, %false8.false10_crit_edge
  %_rtDW__Saturation_MODE179 = phi i32 [ %_rtDW__Saturation_MODE.pre, %false8.false10_crit_edge ], [ 1, %true11 ], [ 0, %true13 ], [ -1, %false14 ]
  %100 = getelementptr inbounds i8, i8* %3, i64 108
  %101 = bitcast i8* %100 to i32*
  switch i32 %_rtDW__Saturation_MODE179, label %false18 [
    i32 1, label %true15
    i32 -1, label %true17
  ]

true11:                                           ; preds = %true9
  %102 = getelementptr inbounds i8, i8* %3, i64 108
  %103 = bitcast i8* %102 to i32*
  store i32 1, i32* %103, align 1
  br label %false10

false12:                                          ; preds = %true9
  %104 = getelementptr inbounds i8, i8* %6, i64 456
  %105 = bitcast i8* %104 to double*
  %_rtP__Saturation_LowerSat_g = load double, double* %105, align 1
  %106 = fcmp ogt double %_rtB__stateFeedbackGain, %_rtP__Saturation_LowerSat_g
  br i1 %106, label %true13, label %false14

true13:                                           ; preds = %false12
  %107 = getelementptr inbounds i8, i8* %3, i64 108
  %108 = bitcast i8* %107 to i32*
  store i32 0, i32* %108, align 1
  br label %false10

false14:                                          ; preds = %false12
  %109 = getelementptr inbounds i8, i8* %3, i64 108
  %110 = bitcast i8* %109 to i32*
  store i32 -1, i32* %110, align 1
  br label %false10

true15:                                           ; preds = %false10
  %111 = getelementptr inbounds i8, i8* %6, i64 448
  %112 = bitcast i8* %111 to double*
  %_rtP__Saturation_UpperSat_i187 = load double, double* %112, align 1
  %113 = getelementptr inbounds i8, i8* %7, i64 56
  %114 = bitcast i8* %113 to double*
  store double %_rtP__Saturation_UpperSat_i187, double* %114, align 1
  br label %merge75

true17:                                           ; preds = %false10
  %115 = getelementptr inbounds i8, i8* %6, i64 456
  %116 = bitcast i8* %115 to double*
  %_rtP__Saturation_LowerSat_g184 = load double, double* %116, align 1
  %117 = getelementptr inbounds i8, i8* %7, i64 56
  %118 = bitcast i8* %117 to double*
  store double %_rtP__Saturation_LowerSat_g184, double* %118, align 1
  br label %merge75

false18:                                          ; preds = %false10
  %_rtB__stateFeedbackGain181 = load double, double* %94, align 1
  %119 = getelementptr inbounds i8, i8* %7, i64 56
  %120 = bitcast i8* %119 to double*
  store double %_rtB__stateFeedbackGain181, double* %120, align 1
  br label %merge75

false19:                                          ; preds = %merge75
  %.not423 = icmp eq i32 %2, 0
  br i1 %.not423, label %false21, label %true20

true20:                                           ; preds = %false19
  %121 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %122 = and i8 %121, 1
  %.not448 = icmp eq i8 %122, 0
  br i1 %.not448, label %false21, label %true22

false21:                                          ; preds = %false30, %true23, %true27, %false26, %true20, %false19
  %123 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE219 = load i8, i8* %123, align 1
  %124 = and i8 %_rtDW__Subsystem_MODE219, 1
  %.not424 = icmp eq i8 %124, 0
  br i1 %.not424, label %false32, label %true31

true22:                                           ; preds = %true20
  %125 = getelementptr inbounds i8, i8* %7, i64 120
  %126 = bitcast i8* %125 to double*
  %_rtB__Constant2 = load double, double* %126, align 1
  %127 = fcmp ogt double %_rtB__Constant2, 0.000000e+00
  br i1 %127, label %true23, label %false24

true23:                                           ; preds = %true22
  %128 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE209 = load i8, i8* %128, align 1
  %129 = and i8 %_rtDW__Subsystem_MODE209, 1
  %.not450 = icmp eq i8 %129, 0
  br i1 %.not450, label %true28, label %false21

false24:                                          ; preds = %true22
  %130 = fcmp oeq double %1, %0
  br i1 %130, label %true25, label %false26

true25:                                           ; preds = %false24
  %131 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 1, i8* %131, align 1
  %132 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 1, i8* %132, align 1
  %133 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 1, i8* %133, align 1
  %134 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 1, i8* %134, align 1
  br label %false26

false26:                                          ; preds = %true25, %false24
  %135 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %135, align 1
  %136 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not449 = icmp eq i8 %136, 0
  br i1 %.not449, label %false21, label %true27

true27:                                           ; preds = %false26
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8* %S)
  %137 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 1, i8* %137, align 1
  %138 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 1, i8* %138, align 1
  %139 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 1, i8* %139, align 1
  %140 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 1, i8* %140, align 1
  store i8 0, i8* %135, align 1
  br label %false21

true28:                                           ; preds = %true23
  %141 = fcmp une double %1, %0
  br i1 %141, label %true29, label %false30

true29:                                           ; preds = %true28
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8* %S)
  br label %false30

false30:                                          ; preds = %true29, %true28
  %142 = getelementptr inbounds i8, i8* %4, i64 4
  store i8 0, i8* %142, align 1
  %143 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 0, i8* %143, align 1
  %144 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 0, i8* %144, align 1
  %145 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 0, i8* %145, align 1
  store i8 1, i8* %128, align 1
  br label %false21

true31:                                           ; preds = %false21
  %146 = getelementptr inbounds i8, i8* %7, i64 152
  %147 = bitcast i8* %146 to double*
  store double 0.000000e+00, double* %147, align 1
  %148 = getelementptr inbounds i8, i8* %7, i64 160
  %149 = bitcast i8* %148 to double*
  store double 0.000000e+00, double* %149, align 1
  %150 = getelementptr inbounds i8, i8* %7, i64 168
  %151 = bitcast i8* %150 to double*
  store double 0.000000e+00, double* %151, align 1
  %152 = getelementptr inbounds i8, i8* %7, i64 176
  %153 = bitcast i8* %152 to double*
  store double 0.000000e+00, double* %153, align 1
  %154 = getelementptr inbounds i8, i8* %6, i64 636
  %155 = bitcast i8* %154 to i32*
  %_rtP__IPlinearmodel_C_jc_el = load i32, i32* %155, align 1
  br label %merge76

false32:                                          ; preds = %true52, %false51, %false21
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 13, i32 104)
  %156 = call i8 @vm_getHasError(i8* %S)
  %157 = and i8 %156, 1
  %.not425 = icmp eq i8 %157, 0
  br i1 %.not425, label %false53, label %true

true33:                                           ; preds = %merge76
  %158 = getelementptr inbounds i8, i8* %6, i64 240
  %159 = bitcast i8* %158 to [4 x double]*
  %160 = sext i32 %ri_.0 to i64
  %161 = getelementptr inbounds [4 x double], [4 x double]* %159, i64 0, i64 %160
  %_rtP__IPlinearmodel_C_pr_el403 = load double, double* %161, align 1
  %162 = getelementptr inbounds i8, i8* %5, i64 32
  %163 = bitcast i8* %162 to double*
  %_rtX__IPlinearmodel_CSTATE_el405 = load double, double* %163, align 1
  %tmp39 = fmul double %_rtP__IPlinearmodel_C_pr_el403, %_rtX__IPlinearmodel_CSTATE_el405
  %164 = bitcast i8* %146 to [4 x double]*
  %165 = getelementptr inbounds i8, i8* %6, i64 620
  %166 = bitcast i8* %165 to [4 x i32]*
  %167 = getelementptr inbounds [4 x i32], [4 x i32]* %166, i64 0, i64 %160
  %_rtP__IPlinearmodel_C_ir_el409 = load i32, i32* %167, align 1
  %168 = sext i32 %_rtP__IPlinearmodel_C_ir_el409 to i64
  %169 = getelementptr inbounds [4 x double], [4 x double]* %164, i64 0, i64 %168
  %_rtB__IPlinearmodel_el410 = load double, double* %169, align 1
  %tmp40 = fadd double %tmp39, %_rtB__IPlinearmodel_el410
  store double %tmp40, double* %169, align 1
  %tmp41 = add i32 %ri_.0, 1
  br label %merge76

true35:                                           ; preds = %merge77
  %170 = getelementptr inbounds i8, i8* %6, i64 240
  %171 = bitcast i8* %170 to [4 x double]*
  %172 = sext i32 %ri_.1 to i64
  %173 = getelementptr inbounds [4 x double], [4 x double]* %171, i64 0, i64 %172
  %_rtP__IPlinearmodel_C_pr_el388 = load double, double* %173, align 1
  %174 = getelementptr inbounds i8, i8* %5, i64 40
  %175 = bitcast i8* %174 to double*
  %_rtX__IPlinearmodel_CSTATE_el390 = load double, double* %175, align 1
  %tmp36 = fmul double %_rtP__IPlinearmodel_C_pr_el388, %_rtX__IPlinearmodel_CSTATE_el390
  %176 = bitcast i8* %146 to [4 x double]*
  %177 = getelementptr inbounds i8, i8* %6, i64 620
  %178 = bitcast i8* %177 to [4 x i32]*
  %179 = getelementptr inbounds [4 x i32], [4 x i32]* %178, i64 0, i64 %172
  %_rtP__IPlinearmodel_C_ir_el394 = load i32, i32* %179, align 1
  %180 = sext i32 %_rtP__IPlinearmodel_C_ir_el394 to i64
  %181 = getelementptr inbounds [4 x double], [4 x double]* %176, i64 0, i64 %180
  %_rtB__IPlinearmodel_el395 = load double, double* %181, align 1
  %tmp37 = fadd double %tmp36, %_rtB__IPlinearmodel_el395
  store double %tmp37, double* %181, align 1
  %tmp38 = add i32 %ri_.1, 1
  br label %merge77

true37:                                           ; preds = %merge78
  %182 = getelementptr inbounds i8, i8* %6, i64 240
  %183 = bitcast i8* %182 to [4 x double]*
  %184 = sext i32 %ri_.2 to i64
  %185 = getelementptr inbounds [4 x double], [4 x double]* %183, i64 0, i64 %184
  %_rtP__IPlinearmodel_C_pr_el373 = load double, double* %185, align 1
  %186 = getelementptr inbounds i8, i8* %5, i64 48
  %187 = bitcast i8* %186 to double*
  %_rtX__IPlinearmodel_CSTATE_el375 = load double, double* %187, align 1
  %tmp33 = fmul double %_rtP__IPlinearmodel_C_pr_el373, %_rtX__IPlinearmodel_CSTATE_el375
  %188 = bitcast i8* %146 to [4 x double]*
  %189 = getelementptr inbounds i8, i8* %6, i64 620
  %190 = bitcast i8* %189 to [4 x i32]*
  %191 = getelementptr inbounds [4 x i32], [4 x i32]* %190, i64 0, i64 %184
  %_rtP__IPlinearmodel_C_ir_el379 = load i32, i32* %191, align 1
  %192 = sext i32 %_rtP__IPlinearmodel_C_ir_el379 to i64
  %193 = getelementptr inbounds [4 x double], [4 x double]* %188, i64 0, i64 %192
  %_rtB__IPlinearmodel_el380 = load double, double* %193, align 1
  %tmp34 = fadd double %tmp33, %_rtB__IPlinearmodel_el380
  store double %tmp34, double* %193, align 1
  %tmp35 = add i32 %ri_.2, 1
  br label %merge78

true39:                                           ; preds = %merge79
  %194 = getelementptr inbounds i8, i8* %6, i64 240
  %195 = bitcast i8* %194 to [4 x double]*
  %196 = sext i32 %ri_.3 to i64
  %197 = getelementptr inbounds [4 x double], [4 x double]* %195, i64 0, i64 %196
  %_rtP__IPlinearmodel_C_pr_el = load double, double* %197, align 1
  %198 = getelementptr inbounds i8, i8* %5, i64 56
  %199 = bitcast i8* %198 to double*
  %_rtX__IPlinearmodel_CSTATE_el = load double, double* %199, align 1
  %tmp30 = fmul double %_rtP__IPlinearmodel_C_pr_el, %_rtX__IPlinearmodel_CSTATE_el
  %200 = bitcast i8* %146 to [4 x double]*
  %201 = getelementptr inbounds i8, i8* %6, i64 620
  %202 = bitcast i8* %201 to [4 x i32]*
  %203 = getelementptr inbounds [4 x i32], [4 x i32]* %202, i64 0, i64 %196
  %_rtP__IPlinearmodel_C_ir_el = load i32, i32* %203, align 1
  %204 = sext i32 %_rtP__IPlinearmodel_C_ir_el to i64
  %205 = getelementptr inbounds [4 x double], [4 x double]* %200, i64 0, i64 %204
  %_rtB__IPlinearmodel_el365 = load double, double* %205, align 1
  %tmp31 = fadd double %tmp30, %_rtB__IPlinearmodel_el365
  store double %tmp31, double* %205, align 1
  %tmp32 = add i32 %ri_.3, 1
  br label %merge79

false40:                                          ; preds = %merge79
  %206 = getelementptr inbounds i8, i8* %7, i64 256
  %207 = bitcast i8* %206 to double*
  %_rtB__Constant_f_el = load double, double* %207, align 1
  %_rtB__IPlinearmodel_el = load double, double* %147, align 1
  %tmp13 = fadd double %_rtB__Constant_f_el, %_rtB__IPlinearmodel_el
  %208 = getelementptr inbounds i8, i8* %7, i64 192
  %209 = bitcast i8* %208 to double*
  store double %tmp13, double* %209, align 1
  %210 = getelementptr inbounds i8, i8* %7, i64 264
  %211 = bitcast i8* %210 to double*
  %_rtB__Constant_f_el247 = load double, double* %211, align 1
  %_rtB__IPlinearmodel_el249 = load double, double* %149, align 1
  %tmp14 = fadd double %_rtB__Constant_f_el247, %_rtB__IPlinearmodel_el249
  %212 = getelementptr inbounds i8, i8* %7, i64 200
  %213 = bitcast i8* %212 to double*
  store double %tmp14, double* %213, align 1
  %214 = getelementptr inbounds i8, i8* %7, i64 272
  %215 = bitcast i8* %214 to double*
  %_rtB__Constant_f_el252 = load double, double* %215, align 1
  %_rtB__IPlinearmodel_el254 = load double, double* %151, align 1
  %tmp15 = fadd double %_rtB__Constant_f_el252, %_rtB__IPlinearmodel_el254
  %216 = getelementptr inbounds i8, i8* %7, i64 208
  %217 = bitcast i8* %216 to double*
  store double %tmp15, double* %217, align 1
  %218 = getelementptr inbounds i8, i8* %7, i64 280
  %219 = bitcast i8* %218 to double*
  %_rtB__Constant_f_el257 = load double, double* %219, align 1
  %_rtB__IPlinearmodel_el259 = load double, double* %153, align 1
  %tmp16 = fadd double %_rtB__Constant_f_el257, %_rtB__IPlinearmodel_el259
  %220 = getelementptr inbounds i8, i8* %7, i64 216
  %221 = bitcast i8* %220 to double*
  store double %tmp16, double* %221, align 1
  %_rtU__xw_ref262 = load double, double* %76, align 1
  %tmp17 = fsub double %_rtU__xw_ref262, %_rtB__IPlinearmodel_el
  %222 = getelementptr inbounds i8, i8* %6, i64 304
  %223 = bitcast i8* %222 to double*
  %_rtP__Gain_Gain_el = load double, double* %223, align 1
  %tmp18 = fmul double %tmp17, %_rtP__Gain_Gain_el
  %224 = getelementptr inbounds i8, i8* %7, i64 128
  %225 = bitcast i8* %224 to double*
  %_rtB__Constant3_el = load double, double* %225, align 1
  %tmp19 = fsub double %_rtB__Constant3_el, %_rtB__IPlinearmodel_el249
  %226 = getelementptr inbounds i8, i8* %6, i64 312
  %227 = bitcast i8* %226 to double*
  %_rtP__Gain_Gain_el270 = load double, double* %227, align 1
  %tmp20 = fmul double %tmp19, %_rtP__Gain_Gain_el270
  %tmp21 = fadd double %tmp18, %tmp20
  %228 = getelementptr inbounds i8, i8* %7, i64 136
  %229 = bitcast i8* %228 to double*
  %_rtB__Constant3_el272 = load double, double* %229, align 1
  %tmp22 = fsub double %_rtB__Constant3_el272, %_rtB__IPlinearmodel_el254
  %230 = getelementptr inbounds i8, i8* %6, i64 320
  %231 = bitcast i8* %230 to double*
  %_rtP__Gain_Gain_el276 = load double, double* %231, align 1
  %tmp23 = fmul double %tmp22, %_rtP__Gain_Gain_el276
  %tmp24 = fadd double %tmp21, %tmp23
  %232 = getelementptr inbounds i8, i8* %7, i64 144
  %233 = bitcast i8* %232 to double*
  %_rtB__Constant3_el278 = load double, double* %233, align 1
  %tmp25 = fsub double %_rtB__Constant3_el278, %_rtB__IPlinearmodel_el259
  %234 = getelementptr inbounds i8, i8* %6, i64 328
  %235 = bitcast i8* %234 to double*
  %_rtP__Gain_Gain_el282 = load double, double* %235, align 1
  %tmp26 = fmul double %tmp25, %_rtP__Gain_Gain_el282
  %tmp27 = fadd double %tmp24, %tmp26
  %236 = getelementptr inbounds i8, i8* %7, i64 184
  %237 = bitcast i8* %236 to double*
  store double %tmp27, double* %237, align 1
  %238 = getelementptr inbounds i8, i8* %7, i64 224
  %239 = bitcast i8* %238 to double*
  store double %tmp15, double* %239, align 1
  %240 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %241 = and i8 %240, 1
  %.not445 = icmp eq i8 %241, 0
  br i1 %.not445, label %false40.false42_crit_edge, label %true41

false40.false42_crit_edge:                        ; preds = %false40
  %.phi.trans.insert458 = getelementptr inbounds i8, i8* %3, i64 112
  %.phi.trans.insert459 = bitcast i8* %.phi.trans.insert458 to i32*
  %_rtDW__Saturation_MODE_d.pre = load i32, i32* %.phi.trans.insert459, align 1
  br label %false42

true41:                                           ; preds = %false40
  %_rtB__Gain = load double, double* %237, align 1
  %242 = getelementptr inbounds i8, i8* %6, i64 336
  %243 = bitcast i8* %242 to double*
  %_rtP__Saturation_UpperSat = load double, double* %243, align 1
  %244 = fcmp ult double %_rtB__Gain, %_rtP__Saturation_UpperSat
  br i1 %244, label %false44, label %true43

false42:                                          ; preds = %true43, %true45, %false46, %false40.false42_crit_edge
  %_rtDW__Saturation_MODE_d297 = phi i32 [ %_rtDW__Saturation_MODE_d.pre, %false40.false42_crit_edge ], [ 1, %true43 ], [ 0, %true45 ], [ -1, %false46 ]
  %245 = getelementptr inbounds i8, i8* %3, i64 112
  %246 = bitcast i8* %245 to i32*
  switch i32 %_rtDW__Saturation_MODE_d297, label %false50 [
    i32 1, label %true47
    i32 -1, label %true49
  ]

true43:                                           ; preds = %true41
  %247 = getelementptr inbounds i8, i8* %3, i64 112
  %248 = bitcast i8* %247 to i32*
  store i32 1, i32* %248, align 1
  br label %false42

false44:                                          ; preds = %true41
  %249 = getelementptr inbounds i8, i8* %6, i64 344
  %250 = bitcast i8* %249 to double*
  %_rtP__Saturation_LowerSat = load double, double* %250, align 1
  %251 = fcmp ogt double %_rtB__Gain, %_rtP__Saturation_LowerSat
  br i1 %251, label %true45, label %false46

true45:                                           ; preds = %false44
  %252 = getelementptr inbounds i8, i8* %3, i64 112
  %253 = bitcast i8* %252 to i32*
  store i32 0, i32* %253, align 1
  br label %false42

false46:                                          ; preds = %false44
  %254 = getelementptr inbounds i8, i8* %3, i64 112
  %255 = bitcast i8* %254 to i32*
  store i32 -1, i32* %255, align 1
  br label %false42

true47:                                           ; preds = %false42
  %256 = getelementptr inbounds i8, i8* %6, i64 336
  %257 = bitcast i8* %256 to double*
  %_rtP__Saturation_UpperSat305 = load double, double* %257, align 1
  %258 = getelementptr inbounds i8, i8* %7, i64 232
  %259 = bitcast i8* %258 to double*
  store double %_rtP__Saturation_UpperSat305, double* %259, align 1
  br label %merge83

true49:                                           ; preds = %false42
  %260 = getelementptr inbounds i8, i8* %6, i64 344
  %261 = bitcast i8* %260 to double*
  %_rtP__Saturation_LowerSat302 = load double, double* %261, align 1
  %262 = getelementptr inbounds i8, i8* %7, i64 232
  %263 = bitcast i8* %262 to double*
  store double %_rtP__Saturation_LowerSat302, double* %263, align 1
  br label %merge83

false50:                                          ; preds = %false42
  %_rtB__Gain299 = load double, double* %237, align 1
  %264 = getelementptr inbounds i8, i8* %7, i64 232
  %265 = bitcast i8* %264 to double*
  store double %_rtB__Gain299, double* %265, align 1
  br label %merge83

false51:                                          ; preds = %merge83
  %266 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %267 = and i8 %266, 1
  %.not447 = icmp eq i8 %267, 0
  br i1 %.not447, label %false32, label %true52

true52:                                           ; preds = %false51
  %268 = getelementptr inbounds i8, i8* %3, i64 116
  call void @vm_srUpdateBC(i8* nonnull %268)
  br label %false32

false53:                                          ; preds = %false32
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 14, i32 104)
  %269 = call i8 @vm_getHasError(i8* %S)
  %270 = and i8 %269, 1
  %.not426 = icmp eq i8 %270, 0
  br i1 %.not426, label %false54, label %true

false54:                                          ; preds = %false53
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 15, i32 104)
  %271 = call i8 @vm_getHasError(i8* %S)
  %272 = and i8 %271, 1
  %.not427 = icmp eq i8 %272, 0
  br i1 %.not427, label %false55, label %true

false55:                                          ; preds = %false54
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 16, i32 104)
  %273 = call i8 @vm_getHasError(i8* %S)
  %274 = and i8 %273, 1
  %.not428 = icmp eq i8 %274, 0
  br i1 %.not428, label %false56, label %true

false56:                                          ; preds = %false55
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 17, i32 104)
  %275 = call i8 @vm_getHasError(i8* %S)
  %276 = and i8 %275, 1
  %.not429 = icmp eq i8 %276, 0
  br i1 %.not429, label %false57, label %true

false57:                                          ; preds = %false56
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 18, i32 104)
  %277 = call i8 @vm_getHasError(i8* %S)
  %278 = and i8 %277, 1
  %.not430 = icmp eq i8 %278, 0
  br i1 %.not430, label %false58, label %true

false58:                                          ; preds = %false57
  br i1 %.not423, label %false60, label %true59

true59:                                           ; preds = %false58
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 19, i32 104)
  %279 = call i8 @vm_getHasError(i8* %S)
  %280 = and i8 %279, 1
  %.not433 = icmp eq i8 %280, 0
  br i1 %.not433, label %false61, label %true

false60:                                          ; preds = %false71, %false58
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 104)
  %281 = call i8 @vm_getHasError(i8* %S)
  br label %true

false61:                                          ; preds = %true59
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 20, i32 104)
  %282 = call i8 @vm_getHasError(i8* %S)
  %283 = and i8 %282, 1
  %.not434 = icmp eq i8 %283, 0
  br i1 %.not434, label %false62, label %true

false62:                                          ; preds = %false61
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 21, i32 104)
  %284 = call i8 @vm_getHasError(i8* %S)
  %285 = and i8 %284, 1
  %.not435 = icmp eq i8 %285, 0
  br i1 %.not435, label %false63, label %true

false63:                                          ; preds = %false62
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 22, i32 104)
  %286 = call i8 @vm_getHasError(i8* %S)
  %287 = and i8 %286, 1
  %.not436 = icmp eq i8 %287, 0
  br i1 %.not436, label %false64, label %true

false64:                                          ; preds = %false63
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 23, i32 104)
  %288 = call i8 @vm_getHasError(i8* %S)
  %289 = and i8 %288, 1
  %.not437 = icmp eq i8 %289, 0
  br i1 %.not437, label %false65, label %true

false65:                                          ; preds = %false64
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 24, i32 104)
  %290 = call i8 @vm_getHasError(i8* %S)
  %291 = and i8 %290, 1
  %.not438 = icmp eq i8 %291, 0
  br i1 %.not438, label %false66, label %true

false66:                                          ; preds = %false65
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 25, i32 104)
  %292 = call i8 @vm_getHasError(i8* %S)
  %293 = and i8 %292, 1
  %.not439 = icmp eq i8 %293, 0
  br i1 %.not439, label %false67, label %true

false67:                                          ; preds = %false66
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 26, i32 104)
  %294 = call i8 @vm_getHasError(i8* %S)
  %295 = and i8 %294, 1
  %.not440 = icmp eq i8 %295, 0
  br i1 %.not440, label %false68, label %true

false68:                                          ; preds = %false67
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 27, i32 104)
  %296 = call i8 @vm_getHasError(i8* %S)
  %297 = and i8 %296, 1
  %.not441 = icmp eq i8 %297, 0
  br i1 %.not441, label %false69, label %true

false69:                                          ; preds = %false68
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 28, i32 104)
  %298 = call i8 @vm_getHasError(i8* %S)
  %299 = and i8 %298, 1
  %.not442 = icmp eq i8 %299, 0
  br i1 %.not442, label %false70, label %true

false70:                                          ; preds = %false69
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 29, i32 104)
  %300 = call i8 @vm_getHasError(i8* %S)
  %301 = and i8 %300, 1
  %.not443 = icmp eq i8 %301, 0
  br i1 %.not443, label %false71, label %true

false71:                                          ; preds = %false70
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 30, i32 104)
  %302 = call i8 @vm_getHasError(i8* %S)
  %303 = and i8 %302, 1
  %.not444 = icmp eq i8 %303, 0
  br i1 %.not444, label %false60, label %true

merge:                                            ; preds = %false4, %false2
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 2, i32 104)
  %304 = call i8 @vm_getHasError(i8* %S)
  %305 = and i8 %304, 1
  %.not417 = icmp eq i8 %305, 0
  br i1 %.not417, label %false5, label %true

merge75:                                          ; preds = %false18, %true17, %true15
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 11, i32 104)
  %306 = call i8 @vm_getHasError(i8* %S)
  %307 = and i8 %306, 1
  %.not422 = icmp eq i8 %307, 0
  br i1 %.not422, label %false19, label %true

merge76:                                          ; preds = %true33, %true31
  %ri_.0 = phi i32 [ %_rtP__IPlinearmodel_C_jc_el, %true31 ], [ %tmp41, %true33 ]
  %308 = getelementptr inbounds i8, i8* %6, i64 640
  %309 = bitcast i8* %308 to i32*
  %_rtP__IPlinearmodel_C_jc_el227 = load i32, i32* %309, align 1
  %310 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_C_jc_el227
  br i1 %310, label %true33, label %merge77

merge77:                                          ; preds = %merge76, %true35
  %ri_.1 = phi i32 [ %tmp38, %true35 ], [ %_rtP__IPlinearmodel_C_jc_el227, %merge76 ]
  %311 = getelementptr inbounds i8, i8* %6, i64 644
  %312 = bitcast i8* %311 to i32*
  %_rtP__IPlinearmodel_C_jc_el232 = load i32, i32* %312, align 1
  %313 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_C_jc_el232
  br i1 %313, label %true35, label %merge78

merge78:                                          ; preds = %merge77, %true37
  %ri_.2 = phi i32 [ %tmp35, %true37 ], [ %_rtP__IPlinearmodel_C_jc_el232, %merge77 ]
  %314 = getelementptr inbounds i8, i8* %6, i64 648
  %315 = bitcast i8* %314 to i32*
  %_rtP__IPlinearmodel_C_jc_el237 = load i32, i32* %315, align 1
  %316 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_C_jc_el237
  br i1 %316, label %true37, label %merge79

merge79:                                          ; preds = %merge78, %true39
  %ri_.3 = phi i32 [ %tmp32, %true39 ], [ %_rtP__IPlinearmodel_C_jc_el237, %merge78 ]
  %317 = getelementptr inbounds i8, i8* %6, i64 652
  %318 = bitcast i8* %317 to i32*
  %_rtP__IPlinearmodel_C_jc_el242 = load i32, i32* %318, align 1
  %319 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_C_jc_el242
  br i1 %319, label %true39, label %false40

merge83:                                          ; preds = %false50, %true49, %true47
  %320 = getelementptr inbounds i8, i8* %6, i64 352
  %321 = bitcast i8* %320 to double*
  %_rtP__Gain1_Gain = load double, double* %321, align 1
  %_rtB__Sum_el309 = load double, double* %213, align 1
  %tmp28 = fmul double %_rtP__Gain1_Gain, %_rtB__Sum_el309
  %322 = getelementptr inbounds i8, i8* %7, i64 240
  %323 = bitcast i8* %322 to double*
  store double %tmp28, double* %323, align 1
  %324 = getelementptr inbounds i8, i8* %6, i64 360
  %325 = bitcast i8* %324 to double*
  %_rtP__Gain2_Gain = load double, double* %325, align 1
  %_rtB__Sum_el313 = load double, double* %221, align 1
  %tmp29 = fmul double %_rtP__Gain2_Gain, %_rtB__Sum_el313
  %326 = getelementptr inbounds i8, i8* %7, i64 248
  %327 = bitcast i8* %326 to double*
  store double %tmp29, double* %327, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 8, i32 104)
  %328 = call i8 @vm_getHasError(i8* %S)
  %329 = and i8 %328, 1
  %.not446 = icmp eq i8 %329, 0
  br i1 %.not446, label %false51, label %true
}

declare double @vm_ssGetTStart(i8*)

declare double @vm_ssGetTaskTime(i8*, i32 signext)

declare signext i32 @vm_ssIsSampleHit(i8*, i32 signext, i32 signext)

declare i8* @vm_ssGetContStateDisabled(i8*)

declare void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8*)

define void @SystemInitialize(i8* %S) {
SystemInitialize_entry:
  %0 = call i8 @vm_ssIsFirstInitCond(i8* %S)
  %1 = call i8* @vm_ssGetRootDWork(i8* %S)
  %2 = call i8* @vm_ssGetX(i8* %S)
  %3 = call i8* @vm_ssGetModelRtp(i8* %S)
  %4 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %5 = call i8* @vm_ssGetU(i8* %S)
  %6 = getelementptr inbounds i8, i8* %3, i64 464
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_k_el = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 64
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_k_el, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 472
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_k_el11 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 72
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_k_el11, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 480
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_k_el14 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 80
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_k_el14, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %3, i64 488
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant_Value_k_el17 = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %4, i64 88
  %21 = bitcast i8* %20 to double*
  store double %_rtP__Constant_Value_k_el17, double* %21, align 1
  %.not = icmp eq i8 %0, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %SystemInitialize_entry
  %22 = bitcast i8* %2 to double*
  store double 2.350000e-01, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %2, i64 8
  %24 = bitcast i8* %23 to double*
  store double 0x400921FB54442D18, double* %24, align 1
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
  %49 = getelementptr inbounds i8, i8* %4, i64 192
  %50 = bitcast i8* %49 to double*
  store double %_rtP__Output3_Y0, double* %50, align 1
  %51 = getelementptr inbounds i8, i8* %3, i64 128
  %52 = bitcast i8* %51 to double*
  %_rtP__Output5_Y0 = load double, double* %52, align 1
  %53 = getelementptr inbounds i8, i8* %4, i64 240
  %54 = bitcast i8* %53 to double*
  store double %_rtP__Output5_Y0, double* %54, align 1
  %55 = getelementptr inbounds i8, i8* %3, i64 136
  %56 = bitcast i8* %55 to double*
  %_rtP__Output8_Y0 = load double, double* %56, align 1
  %57 = getelementptr inbounds i8, i8* %4, i64 224
  %58 = bitcast i8* %57 to double*
  store double %_rtP__Output8_Y0, double* %58, align 1
  %59 = getelementptr inbounds i8, i8* %3, i64 144
  %60 = bitcast i8* %59 to double*
  %_rtP__Output9_Y0 = load double, double* %60, align 1
  %61 = getelementptr inbounds i8, i8* %4, i64 248
  %62 = bitcast i8* %61 to double*
  store double %_rtP__Output9_Y0, double* %62, align 1
  %63 = getelementptr inbounds i8, i8* %3, i64 152
  %64 = bitcast i8* %63 to double*
  %_rtP__Output10_Y0 = load double, double* %64, align 1
  %65 = getelementptr inbounds i8, i8* %4, i64 232
  %66 = bitcast i8* %65 to double*
  store double %_rtP__Output10_Y0, double* %66, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 102)
  %67 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare zeroext i8 @vm_ssIsFirstInitCond(i8*)

